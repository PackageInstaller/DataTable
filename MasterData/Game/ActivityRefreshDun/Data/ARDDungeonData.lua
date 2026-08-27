local DungeonLevelBase = require("Game.DungeonCenter.Data.DungeonLevelBase")
local ARDDungeonData = class("ARDDungeonData", DungeonLevelBase)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function ARDDungeonData:ctor(dungeonStageId, isComplete, ARDData)
  self.__dungeonId = dungeonStageId
  self.__IsCompleted = isComplete
  self.ARDData = ARDData
  self.__dungeonCfg = ConfigData.activity_refresh_dungeon_dun[dungeonStageId]
  assert(self.__dungeonCfg ~= nil, "dungeonCfg is nil,dungeonId:" .. tostring(dungeonStageId))
  self.__heroCfg = ConfigData.activity_refresh_dungeon_hero[self.__dungeonCfg.hero_id]
  assert(self.__heroCfg ~= nil, "heroCfg is nil,hero_id:" .. tostring(self.__dungeonCfg.hero_id))
end

function ARDDungeonData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.AprilFool
end

function ARDDungeonData:GetARDDunId()
  return self.__dungeonId
end

function ARDDungeonData:GetARDDunIsCompleted()
  return self.__IsCompleted
end

function ARDDungeonData:GetARDDunCfg()
  return self.__dungeonCfg
end

function ARDDungeonData:GetARDDLevelPicName()
  return self.__heroCfg.pic
end

function ARDDungeonData:GetARDDLevelTag()
  return self.__dungeonCfg.difficulty
end

function ARDDungeonData:GetCouldExchange()
  if self:GetARDDunIsCompleted() then
    return false
  end
  return true
end

function ARDDungeonData:GetARDDAvgId()
  return self.__heroCfg.avg_id
end

return ARDDungeonData
