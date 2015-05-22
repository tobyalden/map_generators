require('rspec')
require('floor')

describe(Floor) do

  describe('#initialize') do
    it("Creates an empty floor.") do
      test_floor = Floor.new({:width => 10, :height => 10})
      expect(test_floor.map[4][4]).to(eq(false))
    end
  end

  describe('#cellular_automata') do
    it("Generates a series of caverns using cellular automata.") do
      test_floor = Floor.new({:width => 80, :height => 40})
      test_floor.cellular_automata(3, 10)
      print("\n\nCellular Automata:\n\n")
      test_floor.print_map()
      print("\n")
    end
  end

  describe('#fill_map') do
    it("Fills the whole map as either solid or empty space.") do
      test_floor = Floor.new({:width => 10, :height => 10})
      test_floor.fill_map(true)
      expect(test_floor.map[4][4]).to(eq(true))
      test_floor.fill_map(false)
      expect(test_floor.map[4][4]).to(eq(false))
    end
  end

  describe('#rogue_style') do
    it("Generates a map in the style of the original Rogue.") do
      print("\n\nRogue-style Map:\n\n")
      test_floor = Floor.new({:width => 80, :height => 40})
      test_floor.rogue_style(30, 10, 20, 5, 10)
      test_floor.print_map()
      print("\n")
    end
  end

  # room_width = rand((@width/20).floor()..(@width/5).floor())
  # room_height = rand((@height/20).floor()..(@height/5).floor())
  # def rogue_style(num_rooms, min_room_width, min_room_height, max_room_width, max_room_height)

  describe('#create_boundaries') do
    it("Creates walls around the edges of the map.") do
      test_floor = Floor.new({:width => 10, :height => 10})
      test_floor.create_boundaries()
      expect(test_floor.map[0][0]).to(eq(true))
      expect(test_floor.map[0][9]).to(eq(true))
      expect(test_floor.map[9][0]).to(eq(true))
      expect(test_floor.map[9][9]).to(eq(true))
      expect(test_floor.map[4][4]).to(eq(false))
    end
  end

  describe('#drunk_walk') do
    it("Performs the drunkard's walk generation algorithim, clearing or filling for a given number of steps.") do
      test_floor = Floor.new({:width => 80, :height => 20})
      test_floor.fill_map(true)
      steps = 1000
      test_floor.drunk_walk(steps, false)
      test_floor.create_boundaries()
      # if(PRINT_MAPS)
      #   print("\n\nDrunkard's Walk [#{steps} steps]:\n\n")
      #   test_floor.print_map()
      #   print("\n")
      # end
    end
  end

  describe('#randomize_map') do
    it("Randomizes each cell with an equal probablity of being empty or solid.") do
      test_floor = Floor.new({:width => 80, :height => 20})
      test_floor.randomize_map()
      # if(PRINT_MAPS)
      #   print("\n\nRandom Map:\n\n")
      #   test_floor.print_map()
      #   print("\n")
      # end
    end
  end

  describe('#empty_neighbors') do
    it("Returns the number of empty cells surrounding a given cell within a given radius (including the given cell).") do
      test_floor = Floor.new({:width => 10, :height => 10})
      expect(test_floor.empty_neighbors(4, 4, 1)).to(eq(9))
      test_floor.fill_map(true)
      expect(test_floor.empty_neighbors(4, 4, 3)).to(eq(0))
    end
  end

  describe('#random_step') do
    it("Takes a coordinate as a pair of numbers and returns a random adjacent coordinate as a hash.") do
      test_floor = Floor.new({:width => 10, :height => 10})
      x = 8
      y = 3
      coords = test_floor.random_step(x, y)
      expect(x != coords[:x] || x != coords[:y]).to(eq(true))
    end
  end

  describe('#is_within_map?') do
    it("Returns true if the specified coordinates are within the map's boundaries.") do
      test_floor = Floor.new({:width => 10, :height => 10})
      expect(test_floor.is_within_map?(0, 0)).to(eq(true))
      expect(test_floor.is_within_map?(9, 9)).to(eq(true))
      expect(test_floor.is_within_map?(-1, -1)).to(eq(false))
      expect(test_floor.is_within_map?(10, 10)).to(eq(false))
    end
  end

  describe('#is_solid?') do
    it("Returns true if the map is solid (i.e., contains a wall) at the specified coordinates.") do
      test_floor = Floor.new({:width => 10, :height => 10})
      test_floor.create_boundaries()
      expect(test_floor.is_solid?(0, 0)).to(eq(true))
      expect(test_floor.is_solid?(4, 4)).to(eq(false))
    end
  end

  describe('#set_is_solid') do
    it("Sets the map to be solid or empty at the specified coordinates.") do
      test_floor = Floor.new({:width => 10, :height => 10})
      test_floor.set_is_solid(4, 4, true)
      expect(test_floor.is_solid?(4, 4)).to(eq(true))
      test_floor.set_is_solid(4, 4, false)
      expect(test_floor.is_solid?(4, 4)).to(eq(false))
    end
  end

end
