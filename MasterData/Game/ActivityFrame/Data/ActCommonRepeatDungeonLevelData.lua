local base = require("Game.DungeonCenter.Data.DungeonLevelBase")
local ActCommonRepeatDungeonLevelData = class("ActCommonRepeatDungeonLevelData", base)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function ActCommonRepeatDungeonLevelData:InitActCmRepeatDungeonLvData(actGnrRepeatDgCfg, index, actData)
  self.__actGnrRepeatDgCfg = actGnrRepeatDgCfg
  self.__index = index
  self.__actData = actData
end

function ActCommonRepeatDungeonLevelData:GetDungeonIndex()
  return self.__index
end

function ActCommonRepeatDungeonLevelData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.Repeat
end

function ActCommonRepeatDungeonLevelData:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self.__actGnrRepeatDgCfg.level_des)
end

function ActCommonRepeatDungeonLevelData:GetDungeonLevelPic()
  return self.__actGnrRepeatDgCfg.level_pic
end

function ActCommonRepeatDungeonLevelData:GetCouldShowAutoPlay()
  return false
end

function ActCommonRepeatDungeonLevelData:GetIsLevelCompleteNoSup()
  local isCompleted = PlayerDataCenter.dungeonComplectedWhithoutSupport[self:GetDungeonLevelStageId()] or false
  return isCompleted
end

function ActCommonRepeatDungeonLevelData:GetLevelUnlockConditionCfg()
  local dungeonCfg = ConfigData.battle_dungeon[self.__actGnrRepeatDgCfg.dungeon_id]
  if dungeonCfg == nil then
    error("Cant get dungeonCfg, id = " .. tostring(self.__actGnrRepeatDgCfg.dungeon_id))
    return
  end
  return dungeonCfg.pre_condition, dungeonCfg.pre_para1, dungeonCfg.pre_para2
end

function ActCommonRepeatDungeonLevelData:GetSpecialUnlockInfo()
  return self.__actGnrRepeatDgCfg.pre_desc
end

function ActCommonRepeatDungeonLevelData:GetCommonActDropData()
  return self.__actGnrRepeatDgCfg.drop_show
end

function ActCommonRepeatDungeonLevelData:GetDungeonNameEn()
  return LanguageUtil.GetLocaleText(self.__actGnrRepeatDgCfg.level_name_en)
end

function ActCommonRepeatDungeonLevelData:GetDungeonIcon()
  return self.__actGnrRepeatDgCfg.level_icon
end

function ActCommonRepeatDungeonLevelData:GetRepeatDgLvActData()
  return self.__actData
end

function ActCommonRepeatDungeonLevelData:SetRepeatDgLvReturnFunc(returnFunc)
  self._returnFunc = returnFunc
end

function ActCommonRepeatDungeonLevelData:GetRepeatDgLvReturnFunc()
  return self._returnFunc
end

function ActCommonRepeatDungeonLevelData:IsDgQuickBattleUnlock()
  local completeChallenge = PlayerDataCenter.dungeonCenterData:IsDgChallengeTaskCompleteAll(self.__stageId)
  return completeChallenge
end

return ActCommonRepeatDungeonLevelData
