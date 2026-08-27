local base = require("Game.DungeonCenter.Data.DungeonLevelBase")
local ActHardLevelData = class("ActHardLevelData", base)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local PeridicFmtBuffSelectData = require("Game.PeriodicChallenge.PeridicFmtBuffSelectData")

function ActHardLevelData:ctor(dunStageId, activityBase, ActHardLevelPlayData)
  self.__hardDunCfg = ConfigData.activity_hard_dungeon_stage[dunStageId]
  self.__activityBase = activityBase
  self.__actHardLevelPlayData = ActHardLevelPlayData
  self._fmtSelectDic = {}
end

function ActHardLevelData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.CommonHard
end

function ActHardLevelData:GetBelongActData()
  return self.__activityBase
end

function ActHardLevelData:GetDungeonLevelPic()
  return self.__hardDunCfg.level_pic
end

function ActHardLevelData:HasRecommendFormation()
  return self.__hardDunCfg.team_record
end

function ActHardLevelData:GetAssistanceId()
  return self.__hardDunCfg.assistance_id
end

function ActHardLevelData:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self.__hardDunCfg.dungeon_desc)
end

function ActHardLevelData:GetScoreRateReduceNum()
  return self.__hardDunCfg.assistanc_reduce or 0
end

function ActHardLevelData:GetIsShowDamageNum()
  return true
end

function ActHardLevelData:GetCommonHardLevelBuffSelectData(dungeonId)
  if self._fmtSelectDic[dungeonId] ~= nil then
    return self._fmtSelectDic[dungeonId]
  end
  local fmtBuffSelectData = PeridicFmtBuffSelectData.CreateFmtBuffByCommonHardLevel(dungeonId)
  fmtBuffSelectData:SetDefaultSelect(table.emptytable)
  self._fmtSelectDic[dungeonId] = fmtBuffSelectData
  return fmtBuffSelectData
end

function ActHardLevelData:ACHLD_SetRankInfo(msg_HardDungeonData)
  self.highScore = msg_HardDungeonData.highScore
  self.maxDamage = msg_HardDungeonData.maxDamage
  self.isVerifying = msg_HardDungeonData.isVerifying
end

function ActHardLevelData:ACHLD_GetHightScore()
  return self.highScore or 0
end

function ActHardLevelData:ACHLD_GetIsVerifying()
  return self.isVerifying
end

function ActHardLevelData:ACHLD_GetIsSeen()
  local actFrameId = self.__actHardLevelPlayData:AHLPD_GetActFreameId()
  local dunStageId = self:GetDungeonLevelStageId()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isSeen = userDataCache:GetCommonHardDunLevelIsSeen(actFrameId, dunStageId)
  return isSeen
end

return ActHardLevelData
