local DungeonLevelBase = require("Game.DungeonCenter.Data.DungeonLevelBase")
local DungeonLevelBlackHole = class("DungeonLevelBlackHole", DungeonLevelBase)
local PeridicFmtBuffSelectData = require("Game.PeriodicChallenge.PeridicFmtBuffSelectData")
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")
local DynFairyData = require("Game.Exploration.Data.DynFairyData")

function DungeonLevelBlackHole:ctor(stageId, msgLevel, floorData)
  self.__blackHoleCfg = ConfigData.activity_blackhole_dungeon[stageId]
  self.__stageId = stageId
  if self.__blackHoleCfg == nil then
    error("blackHole cfg is null:id:" .. tostring(stageId))
  end
  self._fmtSelectDic = {}
  self.msgLevel = msgLevel or table.emptytable
  self.floorData = floorData
  self:GenFairyFakeData()
end

function DungeonLevelBlackHole:UpdateMsgLevel(msgLevel)
  self.msgLevel = msgLevel or table.emptytable
  self:GenFairyFakeData()
end

function DungeonLevelBlackHole:GenFairyFakeData()
  if self.msgLevel.fairy then
    self.dynFairyData = DynFairyData.GenDynFairyData(self.msgLevel.fairy)
  else
    self.dynFairyData = nil
  end
end

function DungeonLevelBlackHole:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.ActBlackHole
end

function DungeonLevelBlackHole:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self.__blackHoleCfg.level_des)
end

function DungeonLevelBlackHole:GetDungeonLevelPic()
  return self.__blackHoleCfg.level_pic
end

function DungeonLevelBlackHole:HasRecommendFormation()
  return self.__blackHoleCfg.team_record
end

function DungeonLevelBlackHole:GetAssistanceId()
  return self.__blackHoleCfg.assistance_id
end

function DungeonLevelBlackHole:GetScoreRateReduceNum()
  return self.__blackHoleCfg.assistanc_reduce or 0
end

function DungeonLevelBlackHole:GetBlackHoleBuffSelectData(dungeonId)
  if self._fmtSelectDic[dungeonId] ~= nil then
    return self._fmtSelectDic[dungeonId]
  end
  local dungeonCfg = self.__blackHoleCfg
  if dungeonCfg == nil then
    error("id id nil " .. tostring(dungeonId))
    return nil
  end
  if not dungeonCfg.is_buff then
    return nil
  end
  local fmtBuffSelectData = PeridicFmtBuffSelectData.CreateFmtBuffByBlackHole(dungeonId, self)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  fmtBuffSelectData:SetDefaultSelect(table.emptytable)
  fmtBuffSelectData:SetSelectCallback(function(buffDic)
  end)
  self._fmtSelectDic[dungeonId] = fmtBuffSelectData
  return fmtBuffSelectData
end

function DungeonLevelBlackHole:GetBlackHoleFloorData()
  return self.floorData
end

function DungeonLevelBlackHole:GetBuffSelectIntroId()
  local actData = self.floorData:GetActData()
  return actData:GetBlackHoleMainCfg().buffrule_des
end

function DungeonLevelBlackHole:GetBlackHolePassTeam()
  return self.msgLevel.heroIds, self.dynFairyData
end

function DungeonLevelBlackHole:GetBlackHoleScoreNum()
  return self.msgLevel.levelScore or 0
end

function DungeonLevelBlackHole:GetBlackHoleTimeNum()
  return self.msgLevel.overTime or 0
end

function DungeonLevelBlackHole:IsBlackHoleVerifying()
  return self.msgLevel.isVerifying
end

return DungeonLevelBlackHole
