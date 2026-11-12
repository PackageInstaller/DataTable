local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local JointDrillActData = class("JointDrillActData", ActivityDataBase)
local ClientManager = CS.ClientManager.Instance
local TimerManager = require("GameCore.Timer.TimerManager")
local LocalData = require("GameCore.Data.LocalData")
local sJointDrillDailyEnterKeyPrefix = "JointDrillDailyEnter_"

local function GetDailyEnterLocalKey(nActId)
  return sJointDrillDailyEnterKeyPrefix .. tostring(nActId)
end

function JointDrillActData:Init()
  self.jointDrillActCfg = nil
  self.nJointDrillType = 0
  self.nActStatus = 0
  self.actTimer = nil
  self.bDailyEnterLoaded = false
  self.nDailyEnterNextRefreshTime = nil
  self.bDailyEnterRedDotValid = false
  self.tbPassedLevels = {}
  self.tbQuests = {}
  self.nTotalScore = 0
  self.nLastRefreshRankTime = 0
  self.nRankingRefreshTime = 600
  self.mapSelfRankData = nil
  self.mapRankList = nil
  self.nTotalRank = 0
  self:InitConfig()
end

function JointDrillActData:InitConfig()
  local mapActCfg = ConfigTable.GetData("JointDrillControl", self.nActId)
  if nil == mapActCfg then
    return
  end
  self.jointDrillActCfg = mapActCfg
  self.nJointDrillType = mapActCfg.Type
  if CacheTable.Get("_JointDrillQuest") == nil or next(CacheTable.Get("_JointDrillQuest")) == nil then
    local function funcForeachJointDrillQuest(line)
      if nil == CacheTable.GetData("_JointDrillQuest", line.GroupId) then
        CacheTable.SetData("_JointDrillQuest", line.GroupId, {})
      end
      CacheTable.InsertData("_JointDrillQuest", line.GroupId, line)
    end
    
    ForEachTableLine(ConfigTable.Get("JointDrillQuest"), funcForeachJointDrillQuest)
  end
end

function JointDrillActData:GetJointDrillActCfg()
  return self.jointDrillActCfg
end

function JointDrillActData:RefreshJointDrillActData(msgData)
  if self.nJointDrillType == GameEnum.JointDrillMode.JointDrill_Mode_1 then
    PlayerData.JointDrill_1:InitData()
    if msgData.Mode1 ~= nil then
      PlayerData.JointDrill_1:CacheJointDrillData(self.nActId, msgData.Meta, msgData.Mode1)
    end
  elseif self.nJointDrillType == GameEnum.JointDrillMode.JointDrill_Mode_2 then
    PlayerData.JointDrill_2:InitData()
    if msgData.Mode2 ~= nil then
      PlayerData.JointDrill_2:CacheJointDrillData(self.nActId, msgData.Meta, msgData.Mode2)
    end
  end
  self.tbPassedLevels = msgData.PassedLevels
  if msgData.Quests ~= nil then
    self.tbQuests = msgData.Quests
  end
  self:RefreshJointDrillQuestRedDot()
  self:RefreshDailyEnterRedDot()
  self:StartActTimer()
end

function JointDrillActData:GetChallengeStartTime()
  if self.jointDrillActCfg ~= nil then
    return self.nOpenTime + self.jointDrillActCfg.DrillStartTime
  end
end

function JointDrillActData:GetChallengeEndTime()
  if self.jointDrillActCfg ~= nil then
    return self.nOpenTime + self.jointDrillActCfg.DrillStartTime + self.jointDrillActCfg.DrillDurationTime
  end
end

function JointDrillActData:RefreshJointDrillQuestRedDot()
  local bHasReward = false
  for _, v in ipairs(self.tbQuests) do
    if v.Status == 1 then
      bHasReward = true
      break
    end
  end
  RedDotManager.SetValid(RedDotDefine.JointDrillQuest, nil, bHasReward)
end

function JointDrillActData:CheckInChallengeTime()
  local nChallengeStartTime = self:GetChallengeStartTime()
  local nChallengeEndTime = self:GetChallengeEndTime()
  if nChallengeStartTime == nil or nChallengeEndTime == nil then
    return false
  end
  local nCurTime = ClientManager.serverTimeStamp
  return nChallengeStartTime <= nCurTime and nChallengeEndTime > nCurTime
end

function JointDrillActData:CheckEnteredToday()
  if not self.bDailyEnterLoaded then
    local sData = LocalData.GetPlayerLocalData(GetDailyEnterLocalKey(self.nActId))
    self.nDailyEnterNextRefreshTime = tonumber(sData)
    self.bDailyEnterLoaded = true
  end
  local nCurTime = ClientManager.serverTimeStamp
  return self.nDailyEnterNextRefreshTime ~= nil and nCurTime < self.nDailyEnterNextRefreshTime
end

function JointDrillActData:RefreshDailyEnterRedDot()
  local bShowRedDot = self:CheckInChallengeTime() and not self:CheckEnteredToday()
  if self.bDailyEnterRedDotValid == bShowRedDot then
    return
  end
  self.bDailyEnterRedDotValid = bShowRedDot
  RedDotManager.SetValid(RedDotDefine.JointDrillDailyEnter, self.nActId, bShowRedDot)
end

function JointDrillActData:MarkEnteredToday()
  if not self:CheckInChallengeTime() then
    self:RefreshDailyEnterRedDot()
    return
  end
  local nNowTime = ClientManager.serverTimeStamp
  local nNextRefreshTime = ClientManager:GetNextRefreshTime(nNowTime)
  self.nDailyEnterNextRefreshTime = nNextRefreshTime
  self.bDailyEnterLoaded = true
  LocalData.SetPlayerLocalData(GetDailyEnterLocalKey(self.nActId), tostring(nNextRefreshTime))
  self:RefreshDailyEnterRedDot()
end

function JointDrillActData:RefreshQuestData(questData)
  local bHasData = false
  for k, v in ipairs(self.tbQuests) do
    if v.Id == questData.Id then
      self.tbQuests[k] = questData
      bHasData = true
      break
    end
  end
  if not bHasData then
    table.insert(self.tbQuests, questData)
  end
  self:RefreshJointDrillQuestRedDot()
end

function JointDrillActData:GetRewardQuestList()
  local tbQuests = {}
  for _, v in ipairs(self.tbQuests) do
    local nSortStatus = 0
    if v.Status == 0 then
      nSortStatus = 1
    elseif v.Status == 1 then
      nSortStatus = 0
    elseif v.Status == 2 then
      nSortStatus = 2
    end
    v.SortStatus = nSortStatus
    table.insert(tbQuests, v)
  end
  return tbQuests
end

function JointDrillActData:SendReceiveQuestReward(callback)
  local function NetCallback(_, netMsg)
    UTILS.OpenReceiveByChangeInfo(netMsg, function()
      if callback ~= nil then
        callback()
      end
    end)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.joint_drill_quest_reward_receive_req, {}, nil, NetCallback)
end

function JointDrillActData:StartActTimer()
  if self.actTimer ~= nil then
    self.actTimer:Cancel()
    self.actTimer = nil
  end
  local nChallengeStartTime = self:GetChallengeStartTime()
  local nChallengeEndTime = self:GetChallengeEndTime()
  local nActEndTime = self:GetActEndTime()
  self.nActStatus = 0
  
  local function refreshTime()
    local nRemainTime = 0
    local nCurTime = ClientManager.serverTimeStamp
    if nCurTime < nChallengeStartTime then
      self.nActStatus = AllEnum.JointDrillActStatus.WaitStart
      nRemainTime = nChallengeStartTime - nCurTime
    elseif nCurTime <= nChallengeEndTime then
      self.nActStatus = AllEnum.JointDrillActStatus.Start
      nRemainTime = nChallengeEndTime - nCurTime
    elseif nCurTime > nChallengeEndTime and nCurTime < nActEndTime then
      self.nActStatus = AllEnum.JointDrillActStatus.WaitClose
      nRemainTime = nActEndTime - nCurTime
    elseif nCurTime >= nActEndTime then
      self.nActStatus = AllEnum.JointDrillActStatus.Closed
      nRemainTime = 0
    end
    self:RefreshDailyEnterRedDot()
    EventManager.Hit("RefreshJointDrillActTime", self.nActStatus, nRemainTime)
    if nRemainTime <= 0 and self.actTimer ~= nil and self.nActStatus == AllEnum.JointDrillActStatus.Closed then
      self.actTimer:Cancel()
      self.actTimer = nil
      return
    end
  end
  
  refreshTime()
  if self.actTimer == nil then
    self.actTimer = TimerManager.Add(0, 1, nil, refreshTime, true, true, true)
  end
end

function JointDrillActData:GetActStatus()
  return self.nActStatus
end

function JointDrillActData:CheckPassedId(nLevelId)
  if self.tbPassedLevels ~= nil then
    for _, v in ipairs(self.tbPassedLevels) do
      if v.LevelId == nLevelId then
        return true
      end
    end
  end
  return false
end

function JointDrillActData:PassedLevel(nLevelId, nScore)
  table.insert(self.tbPassedLevels, {LevelId = nLevelId, Score = nScore})
end

function JointDrillActData:GetJointDrillType()
  return self.nJointDrillType
end

return JointDrillActData
