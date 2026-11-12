local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local DoubleDropsActData = class("DoubleDropsActData", ActivityDataBase)
local mapInsType = {
  [GameEnum.instanceType.DailyInstance] = GameEnum.OpenFuncType.DailyInstance,
  [GameEnum.instanceType.RegionBoss] = GameEnum.OpenFuncType.RegionBoss,
  [GameEnum.instanceType.SkillInstance] = GameEnum.OpenFuncType.SkillInstance,
  [GameEnum.instanceType.CharGemInstance] = GameEnum.OpenFuncType.CharGemInstance
}

function DoubleDropsActData:Init()
  self.nDailyUseTimes = 0
  self.nDailyMaxTimes = 0
  self.tbInstanceType = {}
  self.tbOpenFuncType = {}
  self.nRewardType = 0
  self.tbQuests = {}
  self:InitConfig()
end

function DoubleDropsActData:InitConfig()
  if CacheTable.Get("_ActivityDoubleQuest") == nil or next(CacheTable.Get("_ActivityDoubleQuest")) == nil then
    local function funcForeach(mapData)
      CacheTable.InsertData("_ActivityDoubleQuest", mapData.ActivityId, mapData)
    end
    
    ForEachTableLine(ConfigTable.Get("ActivityDoubleQuest"), funcForeach)
  end
  local mapDoubleCfg = ConfigTable.GetData("ActivityDouble", self.nActId)
  if mapDoubleCfg == nil then
    return
  end
  self.nDailyMaxTimes = mapDoubleCfg.DailyTimes
  self.tbInstanceType = mapDoubleCfg.InstanceType
  self.tbOpenFuncType = {}
  for _, v in ipairs(mapDoubleCfg.InstanceType) do
    table.insert(self.tbOpenFuncType, mapInsType[v])
  end
  self.nRewardType = mapDoubleCfg.RewardType
end

function DoubleDropsActData:RefreshDoubleDropsActData(nActId, msgData)
  self.nDailyUseTimes = msgData.DailyUseTimes
  if msgData.Quests == nil or #msgData.Quests == 0 then
    self.tbQuests = {}
    local tbQuest = CacheTable.GetData("_ActivityDoubleQuest", nActId)
    if tbQuest ~= nil then
      for _, v in ipairs(tbQuest) do
        local tbJson = decodeJson(v.QuestParams)
        local questData = {
          nId = v.Id,
          nStatus = AllEnum.ActQuestStatus.UnComplete,
          progress = {
            Cur = 0,
            Max = tbJson[#tbJson]
          }
        }
        table.insert(self.tbQuests, questData)
      end
    end
  else
    self:CacheAllQuestData(msgData.Quests)
  end
end

function DoubleDropsActData:UpdateDoubleCount(nCount)
  self.nDailyUseTimes = nCount
end

function DoubleDropsActData:QuestServer2Client(nStatus)
  if nStatus == 0 then
    return AllEnum.ActQuestStatus.UnComplete
  elseif nStatus == 1 then
    return AllEnum.ActQuestStatus.Complete
  else
    return AllEnum.ActQuestStatus.Received
  end
end

function DoubleDropsActData:CacheAllQuestData(questListData)
  self.tbQuests = {}
  for _, v in pairs(questListData) do
    local questData = {
      nId = v.Id,
      nStatus = self:QuestServer2Client(v.Status),
      progress = v.Progress[1]
    }
    table.insert(self.tbQuests, questData)
  end
  self:RefreshRedDot()
end

function DoubleDropsActData:RefreshQuestData(msgData)
  local questData = {
    nId = msgData.Id,
    nStatus = self:QuestServer2Client(msgData.Status),
    progress = msgData.Progress[1]
  }
  for k, v in ipairs(self.tbQuests) do
    if v.nId == msgData.Id then
      self.tbQuests[k] = questData
      break
    end
  end
  self:RefreshRedDot()
end

function DoubleDropsActData:RefreshRedDot()
  local bRedDot = false
  for _, questData in ipairs(self.tbQuests) do
    bRedDot = bRedDot or questData.nStatus == AllEnum.ActQuestStatus.Complete
    if bRedDot then
      break
    end
  end
  RedDotManager.SetValid(RedDotDefine.Activity_Tab, self.nActId, bRedDot)
  RedDotManager.SetValid(RedDotDefine.Activity_DoubleDrop_Quest, self.nActId, bRedDot)
end

function DoubleDropsActData:GetAllQuests()
  return self.tbQuests
end

function DoubleDropsActData:GetDoubleDropsTimes()
  return self.nDailyUseTimes, self.nDailyMaxTimes
end

function DoubleDropsActData:GetDoubleFuncType()
  return self.tbOpenFuncType
end

function DoubleDropsActData:GetInstanceType()
  return self.tbInstanceType
end

function DoubleDropsActData:CheckInstanceType(nType)
  return table.indexof(self.tbInstanceType, nType) > 0
end

function DoubleDropsActData:GetRewardType()
  return self.nRewardType
end

function DoubleDropsActData:GetDropString()
  local str1, str2 = "", ""
  if self.nRewardType == GameEnum.activityDoubleRewardType.Double then
    str1 = orderedFormat(ConfigTable.GetUIText("Double_Drops_Double_Count_1"), self.nDailyMaxTimes - self.nDailyUseTimes, self.nDailyMaxTimes)
    str2 = ConfigTable.GetUIText("Double_Drops_Double_Count_2")
  elseif self.nRewardType == GameEnum.activityDoubleRewardType.Triple then
    str1 = orderedFormat(ConfigTable.GetUIText("Double_Drops_Triple_Count_1"), self.nDailyMaxTimes - self.nDailyUseTimes, self.nDailyMaxTimes)
    str2 = ConfigTable.GetUIText("Double_Drops_Triple_Count_2")
  end
  return str1, str2
end

function DoubleDropsActData:GetDropActString()
  local str = ""
  if self.nRewardType == GameEnum.activityDoubleRewardType.Double then
    str = orderedFormat(ConfigTable.GetUIText("Double_Drops_Act_Double_Count"), self.nDailyMaxTimes - self.nDailyUseTimes, self.nDailyMaxTimes)
  elseif self.nRewardType == GameEnum.activityDoubleRewardType.Triple then
    str = orderedFormat(ConfigTable.GetUIText("Double_Drops_Triple_Count_1"), self.nDailyMaxTimes - self.nDailyUseTimes, self.nDailyMaxTimes)
  end
  return str
end

function DoubleDropsActData:SendReceiveQuestReward(nQuestId, callback)
  local function netCallback(_, netMsg)
    for k, v in ipairs(self.tbQuests) do
      if v.nStatus == AllEnum.ActQuestStatus.Complete then
        v.nStatus = AllEnum.ActQuestStatus.Received
      end
    end
    self:RefreshRedDot()
    
    local function receiveCallback()
      if type(callback) == "function" then
        callback()
      end
      EventManager.Hit("ReceiveDoubleDropQuest")
    end
    
    UTILS.OpenReceiveByChangeInfo(netMsg, receiveCallback)
  end
  
  local mapSendMsg = {
    ActivityId = self.nActId,
    QuestId = nQuestId or 0
  }
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_double_quest_reward_receive_req, mapSendMsg, nil, netCallback)
end

return DoubleDropsActData
