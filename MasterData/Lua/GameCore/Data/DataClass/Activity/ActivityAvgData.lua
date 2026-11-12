local ActivityStoryDataBase = require("GameCore.Data.DataClass.Activity.ActivityStoryDataBase")
local ActivityAvgData = class("ActivityAvgData", ActivityStoryDataBase)
local LocalData = require("GameCore.Data.LocalData")

function ActivityAvgData:Init()
  self.tbActivityAvgList = {}
  self.tbCachedReadedActAvg = {}
  self.tbActAvgList = {}
  ActivityStoryDataBase.Init(self)
  EventManager.Add(EventId.UpdateWorldClass, self, self.OnEvent_UpdateWorldClass)
end

function ActivityAvgData:UnInit()
  EventManager.Remove(EventId.UpdateWorldClass, self, self.OnEvent_UpdateWorldClass)
end

function ActivityAvgData:CacheActivityAvgData(msgData)
  if self.tbActAvgList[msgData.Id] == nil then
    self.tbActAvgList[msgData.Id] = {}
  end
  self.tbActAvgList[msgData.Id].nOpenTime = msgData.StartTime
  self.tbActAvgList[msgData.Id].nEndTime = msgData.EndTime
end

function ActivityAvgData:RefreshActivityAvgData(nActId, msgData)
  self.tbCachedReadedActAvg[nActId] = {}
  for _, avgId in ipairs(msgData.RewardIds) do
    table.insert(self.tbCachedReadedActAvg[nActId], avgId)
  end
  self:RefreshAvgRedDot()
end

function ActivityAvgData:IsActivityAvgReaded(activityId, storyId)
  if self.tbCachedReadedActAvg[activityId] == nil then
    return false
  end
  for _, avgId in ipairs(self.tbCachedReadedActAvg[activityId]) do
    if avgId == storyId then
      return true
    end
  end
  return false
end

function ActivityAvgData:HasActivityData(activityId)
  return self.tbActAvgList[activityId] ~= nil
end

function ActivityAvgData:IsActivityAvgUnlock(activityId, storyId)
  if self.tbActAvgList[activityId] == nil then
    return false
  end
  local cfg = ConfigTable.GetData("ActivityAvgLevel", storyId)
  local isPreReaded = self:IsActivityAvgReaded(activityId, cfg.PreLevelId) or cfg.PreLevelId == 0
  local nOpenTime = self.tbActAvgList[activityId].nOpenTime
  nOpenTime = CS.ClientManager.Instance:GetNextRefreshTime(nOpenTime) - 86400
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local days = math.floor((curTime - nOpenTime) / 86400)
  return days >= cfg.DayOpen, isPreReaded, nOpenTime
end

function ActivityAvgData:GetActivityOpenTime(activityId)
  if self.tbActAvgList[activityId] == nil then
    return 0
  end
  return self.tbActAvgList[activityId].nOpenTime, self.tbActAvgList[activityId].nEndTime
end

function ActivityAvgData:IsNew(activityId, storyId)
  local isTimeUnlock, isPreReaded, _ = self:IsActivityAvgUnlock(activityId, storyId)
  if not isTimeUnlock or not isPreReaded then
    return false
  end
  if self:IsActivityAvgReaded(activityId, storyId) then
    return false
  end
  return true
end

function ActivityAvgData:GetRecentAcvitityIndex(activityId)
  local list = self:GetStoryIdListByActivityId(activityId)
  if list == nil then
    return 0
  end
  for i = 1, #list do
    if not self:IsActivityAvgReaded(activityId, list[i]) then
      return i
    end
  end
  return 1
end

function ActivityAvgData:GetActivityIdsByChapterId(chapterId)
  local tbActivityIds = {}
  
  local function forEachLine_StoryChapter(chapterConfig)
    if chapterConfig.ChapterId == chapterId and self:HasActivityData(chapterConfig.Id) then
      table.insert(tbActivityIds, chapterConfig.Id)
    end
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityStoryChapter"), forEachLine_StoryChapter)
  return tbActivityIds
end

function ActivityAvgData:OnEvent_UpdateWorldClass()
  self:RefreshAvgRedDot()
end

function ActivityAvgData:IsOpen(sAvgId, nActivityId)
  local cfg = self:GetStoryCfgData(sAvgId)
  local nOpenTime = 0
  if self.tbActAvgList[nActivityId] ~= nil then
    nOpenTime = self.tbActAvgList[nActivityId].nOpenTime
  end
  nOpenTime = CS.ClientManager.Instance:GetNextRefreshTime(nOpenTime) - 86400
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local days = math.floor((curTime - nOpenTime) / 86400)
  return days >= cfg.DayOpen, nOpenTime
end

function ActivityAvgData:_GetApplyMsgId(nActivityId)
  local actConfig = ConfigTable.GetData("Activity", nActivityId)
  if actConfig ~= nil and actConfig.ActivityType == GameEnum.activityType.HistoryStory then
    return NetMsgId.Id.activity_history_story_apply_req
  end
  return NetMsgId.Id.activity_story_apply_req
end

function ActivityAvgData:_GetSettleMsgId(nActivityId)
  local actConfig = ConfigTable.GetData("Activity", nActivityId)
  if actConfig ~= nil and actConfig.ActivityType == GameEnum.activityType.HistoryStory then
    return NetMsgId.Id.activity_history_story_settle_req
  end
  return NetMsgId.Id.activity_story_settle_req, false
end

function ActivityAvgData:RefreshAvgRedDot()
  local tbActGroupRedDot = {}
  for k, v in pairs(self.CFG_ChapterStoryNumIds) do
    local actIds = self:GetActivityIdsByChapterId(k)
    for _, actId in pairs(actIds) do
      for _, storyId in pairs(v) do
        local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(actId)
        if bInActGroup then
          if tbActGroupRedDot[nActGroupId] == nil then
            tbActGroupRedDot[nActGroupId] = false
          end
          local cfg = ConfigTable.GetData("ActivityStory", storyId)
          local isUnlock = self:IsUnlock(cfg.ConditionId)
          local isClicked = LocalData.GetPlayerLocalData(self:_GetLocalReadKey(actId, storyId)) == true
          local isNew = self:IsStoryReaded(storyId) == false
          local _ActAvg = self.tbActAvgList[actId]
          local isOpen = false
          if _ActAvg ~= nil then
            isOpen = self:IsOpen(cfg.StoryId, actId)
          end
          local actGroupData = PlayerData.Activity:GetActivityGroupDataById(nActGroupId)
          local bActGroupUnlock = actGroupData:IsUnlock()
          local bActGroupOpen = actGroupData:CheckActivityGroupOpen()
          local bNew = isUnlock and isNew and not isClicked and isOpen and bActGroupUnlock and bActGroupOpen
          if bNew == true then
            tbActGroupRedDot[nActGroupId] = true
          end
          RedDotManager.SetValid(RedDotDefine.Activity_GroupNew_Avg_Group, {
            nActGroupId,
            actId,
            storyId
          }, bNew)
        end
      end
    end
  end
  EventManager.Hit("RefreshActivityGroupRedDot")
end

return ActivityAvgData
