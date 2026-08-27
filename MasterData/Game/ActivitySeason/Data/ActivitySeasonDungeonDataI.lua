local base = require("Game.ActivityChristmas.ActivitySeasonDungeonData")
local ActivitySeasonDungeonDataI = class("ActivitySeasonDungeonDataI", base)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function ActivitySeasonDungeonDataI:GetDungeonNameEn()
  return self.__seasonDunCfg.level_name_en
end

function ActivitySeasonDungeonDataI:GetDungeonIcon()
  return self.__seasonDunCfg.level_icon
end

function ActivitySeasonDungeonDataI:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.SeasonI
end

return ActivitySeasonDungeonDataI
