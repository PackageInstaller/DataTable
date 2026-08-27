local base = require("Game.Dungeon.Dync.DungeonDyncElemHGV3")
local DungeonDyncElemHGV3Free = class("DungeonDyncElemHGV3Free", base)
local DungeonDyncEnum = require("Game.Dungeon.Dync.DungeonDyncEnum")
local HeroGrowV3Enum = require("Game.ActivityHeroGrowV3.Data.HeroGrowV3Enum")

function DungeonDyncElemHGV3Free:ctor()
  self._dyncType = DungeonDyncEnum.DgDyncType.HeroLiteFree
  self.__hgv3SubType = HeroGrowV3Enum.HGV3NormalQuestType.freeTeam
end

return DungeonDyncElemHGV3Free
