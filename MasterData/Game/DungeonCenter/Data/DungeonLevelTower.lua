local DungeonLevelBase = require("Game.DungeonCenter.Data.DungeonLevelBase")
local DungeonLevelTower = class("DungeonLevelTower", DungeonLevelBase)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function DungeonLevelTower:ctor(stageId, isHeax)
  if isHeax then
    self.__isHeax = isHeax
    self.__dungeonTowerCfg = ConfigData.env_dungeon_tower_dungeon_detail[stageId]
  else
    self.__dungeonTowerCfg = ConfigData.dungeon_tower[stageId]
  end
  if self.__dungeonTowerCfg == nil then
    error("dungeon tower cfg is null:id:" .. tostring(stageId))
  end
end

function DungeonLevelTower:BindLevelTowerTypeData(towerTypeData)
  self.__towerTypeData = towerTypeData
end

function DungeonLevelTower:GetLevelTowerTypeData()
  return self.__towerTypeData
end

function DungeonLevelTower:IsTwinTowerLevel()
  return self.__towerTypeData:IsTypeTwinTower()
end

function DungeonLevelTower:GetDungeonLevelType()
  if self.__isHeax then
    return DungeonLevelEnum.DunLevelType.SixHeroTower
  end
  return DungeonLevelEnum.DunLevelType.Tower
end

function DungeonLevelTower:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self.__dungeonTowerCfg.level_des)
end

function DungeonLevelTower:GetDungeonLevelPic()
  return self.__dungeonTowerCfg.level_pic
end

function DungeonLevelTower:GetDunTowerLevelNum()
  if self.__isHeax then
    return self.__dungeonTowerCfg.floor_id
  end
  return self.__dungeonTowerCfg.level_num
end

function DungeonLevelTower:IsTowerFlagLevel()
  return self.__dungeonTowerCfg.flag_level
end

function DungeonLevelTower:GetDungeonTowerType()
  if self.__isHeax then
    return self.__dungeonTowerCfg.tower_id
  end
  return self.__dungeonTowerCfg.tower_type
end

function DungeonLevelTower:HasRecommendFormation()
  return self.__dungeonTowerCfg.team_record
end

function DungeonLevelTower:GetTowerTypeTotalLevel()
  return self.__towerTypeData:GetTowerTotalLevel()
end

function DungeonLevelTower:HasNextTowerLevel()
  return self:GetDunTowerLevelNum() < self.__towerTypeData:GetTowerTotalLevel()
end

function DungeonLevelTower:GetNextTowerLevelData()
  local nextLevelData = self.__towerTypeData:GetTowerLevelByNum(self:GetDunTowerLevelNum() + 1)
  return nextLevelData
end

function DungeonLevelTower:GetTowerLevelNounId()
  if self.__isHeax then
    return 0
  end
  return self.__dungeonTowerCfg.tower_noun
end

function DungeonLevelTower:GetTowerChipSelectMax()
  return self.__dungeonTowerCfg.chip_select_max or 0
end

function DungeonLevelTower:GetTowerChipQuality()
  return self.__dungeonTowerCfg.chip_quality or 0
end

function DungeonLevelTower:GetTowerChipSuitPool()
  return self.__dungeonTowerCfg.chip_pool or {}
end

function DungeonLevelTower:GetTowerTypeName()
  return self.__towerTypeData:GetDungeonTowerName()
end

function DungeonLevelTower:GetTowerLvName()
  return self.__towerTypeData:GetDungeonTowerLvName()
end

function DungeonLevelTower:GetDunServerRacingFrame()
  return PlayerDataCenter.dungeonTowerSData:GetTowerLevelRacingFrame(self:GetDungeonTowerType(), self:GetDunTowerLevelNum())
end

function DungeonLevelTower:GetIsHaveRacing()
  if self:IsTwinTowerLevel() then
    return true
  end
  if self.__isHeax then
    local towerId = self:GetDungeonTowerType()
    local isHaveRacing = ConfigData.env_dungeon_tower_speed_reward[towerId] ~= nil
    return isHaveRacing
  end
end

function DungeonLevelTower:GetIsHideRacingTimeShow()
  if self.__isHeax then
    return true
  end
  return false
end

return DungeonLevelTower
