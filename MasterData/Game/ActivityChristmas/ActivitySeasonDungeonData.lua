local base = require("Game.ActivityFrame.Data.ActCommonRepeatDungeonLevelData")
local ActivitySeasonDungeonData = class("ActivitySeasonDungeonData", base)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function ActivitySeasonDungeonData:ctor(stageId, __seasonDunCfg, seasonId, index)
  self.__seasonId = seasonId
  self.__seasonDunCfg = __seasonDunCfg
  self.__index = index
end

function ActivitySeasonDungeonData:GetDungeonIndex()
  return self.__index
end

function ActivitySeasonDungeonData:GetSeasonId()
  return self.__seasonId
end

function ActivitySeasonDungeonData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.Season
end

function ActivitySeasonDungeonData:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self.__seasonDunCfg.level_des)
end

function ActivitySeasonDungeonData:GetDungeonLevelPic()
  return self.__seasonDunCfg.level_pic
end

function ActivitySeasonDungeonData:GetCouldShowAutoPlay()
  return true
end

function ActivitySeasonDungeonData:GetIsLevelCompleteNoSup()
  local isCompleted = PlayerDataCenter.dungeonComplectedWhithoutSupport[self:GetDungeonLevelStageId()] or false
  return isCompleted
end

function ActivitySeasonDungeonData:GetLevelUnlockConditionCfg()
  return self.__seasonDunCfg.pre1_condition, self.__seasonDunCfg.pre1_para1, self.__seasonDunCfg.pre1_para2, self.__seasonDunCfg.pre2_condition, self.__seasonDunCfg.pre2_para1, self.__seasonDunCfg.pre2_para2, self.__seasonDunCfg.pre3_condition, self.__seasonDunCfg.pre3_para1, self.__seasonDunCfg.pre3_para2
end

function ActivitySeasonDungeonData:GetSpecialUnlockInfo()
  return self.__seasonDunCfg.pre_desc
end

function ActivitySeasonDungeonData:GetIsLevelUnlock()
  local pre1_condition, pre1_para1, pre1_para2, pre2_condition, pre2_para1, pre2_para2, pre3_condition, pre3_para1, pre3_para2 = self:GetLevelUnlockConditionCfg()
  local lock1 = CheckCondition.CheckLua(pre1_condition, pre1_para1, pre1_para2)
  local lock2 = false
  local lock3 = false
  if lock1 then
    return true
  end
  if 0 < #pre2_condition then
    lock2 = CheckCondition.CheckLua(pre2_condition, pre2_para1, pre2_para2)
  end
  if lock2 then
    return true
  end
  if 0 < #pre3_condition then
    lock3 = CheckCondition.CheckLua(pre3_condition, pre3_para1, pre3_para2)
  end
  return lock3
end

function ActivitySeasonDungeonData:GetCommonActDropData()
  return self.__seasonDunCfg.drop_show
end

return ActivitySeasonDungeonData
