local ActCommonRepeatDungeonLevelData = require("Game.ActivityFrame.Data.ActCommonRepeatDungeonLevelData")
local DungeonLevelActHGV3Repeat = class("DungeonLevelActHGV3Repeat", ActCommonRepeatDungeonLevelData)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function DungeonLevelActHGV3Repeat:ctor(stageId, actData)
  self.actData = actData
  self.__repeatCfg = actData:GetHGV3ReBrushCfg()
end

function DungeonLevelActHGV3Repeat:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.HeroGrowV3Repeat
end

function DungeonLevelActHGV3Repeat:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self.__repeatCfg.dungeon_des)
end

function DungeonLevelActHGV3Repeat:GetDungeonLevelPic()
  return self.__repeatCfg.dungeon_pic
end

function DungeonLevelActHGV3Repeat:GetCouldShowAutoPlay()
  return true
end

function DungeonLevelActHGV3Repeat:GetLevelUnlockConditionCfg()
  local dungeonCfg = ConfigData.battle_dungeon[self.__repeatCfg.dungeon_id]
  if dungeonCfg == nil then
    error("Cant get dungeonCfg, id = " .. tostring(self.__repeatCfg.dungeon_id))
    return
  end
  return dungeonCfg.pre_condition, dungeonCfg.pre_para1, dungeonCfg.pre_para2
end

function DungeonLevelActHGV3Repeat:GetIsLevelCompleteNoSup()
  local isCompleted = PlayerDataCenter.dungeonComplectedWhithoutSupport[self:GetDungeonLevelStageId()] or false
  return isCompleted
end

function DungeonLevelActHGV3Repeat:GetCantAutoBattleTip()
  return 7924
end

function DungeonLevelActHGV3Repeat:GetSpecialUnlockInfo()
  return nil
end

function DungeonLevelActHGV3Repeat:GetCommonActDropData()
  return self.__repeatCfg.drop_show
end

function DungeonLevelActHGV3Repeat:GetDungeonNameEn()
  return nil
end

function DungeonLevelActHGV3Repeat:GetRepeatDgLvActData()
  return self.actData
end

function DungeonLevelActHGV3Repeat:GetAssistanceId()
  return self.__repeatCfg.assistance_id
end

function DungeonLevelActHGV3Repeat:GetEnterLevelCost()
  return self.actData:GetHGV3RepeatTicketId()
end

function DungeonLevelActHGV3Repeat:GetDungeonActName()
  return self.actData:GetActivityName()
end

function DungeonLevelActHGV3Repeat:IsDgQuickBattleUnlock()
  local completeChallenge = PlayerDataCenter.dungeonCenterData:IsDgChallengeTaskCompleteAll(self.__repeatCfg.dungeon_id)
  return completeChallenge
end

return DungeonLevelActHGV3Repeat
