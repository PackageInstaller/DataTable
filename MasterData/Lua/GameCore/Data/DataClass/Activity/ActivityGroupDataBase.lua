local LocalData = require("GameCore.Data.LocalData")
local ActivityGroupDataBase = class("ActivityGroupDataBase")

function ActivityGroupDataBase:ctor(mapActGroupData)
  self.nActGroupId = mapActGroupData.Id
  self.actGroupCfg = mapActGroupData
  self.bRedDot = false
  self.bBanner = false
  self.tbActivityEntranceState = {}
  self.nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.actGroupCfg.StartTime)
  self.nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.actGroupCfg.EndTime)
  self.nEndEnterTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.actGroupCfg.EnterEndTime)
  self:Init()
end

function ActivityGroupDataBase:Init()
end

function ActivityGroupDataBase:UpdateActivityGroupState(mapState)
  self.bRedDot = mapState.RedDot
  self.bBanner = mapState.Banner
end

function ActivityGroupDataBase:RefreshActivityData(mapActGroupData)
  self.actGroupCfg = mapActGroupData
  self.nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.actGroupCfg.StartTime)
  self.nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.actGroupCfg.EndTime)
  self.nEndEnterTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.actGroupCfg.EnterEndTime)
end

function ActivityGroupDataBase:GetActGroupId()
  return self.nActGroupId
end

function ActivityGroupDataBase:GetActGroupCfgData()
  return self.actGroupCfg
end

function ActivityGroupDataBase:IsUnlock()
  if self.actGroupCfg.StartCondType == GameEnum.questAcceptCond.WorldClassSpecific then
    local nWorldCalss = PlayerData.Base:GetWorldClass()
    if nWorldCalss < self.actGroupCfg.StartCondParams[1] then
      local txtLock = orderedFormat(ConfigTable.GetUIText("Activity_Cond_WorldClass"), self.actGroupCfg.StartCondParams[1])
      return false, txtLock
    end
  end
  return true
end

function ActivityGroupDataBase:IsUnlockShow()
  if self.actGroupCfg.PreLimit == GameEnum.activityPreLimit.WorldClass then
    local nWorldCalss = PlayerData.Base:GetWorldClass()
    if nWorldCalss < tonumber(self.actGroupCfg.LimitParam) then
      return false
    end
  elseif self.actGroupCfg.PreLimit == GameEnum.activityPreLimit.questLimit then
    return PlayerData.Avg:IsStoryReaded(self.actGroupCfg.LimitParam)
  end
  return true
end

function ActivityGroupDataBase:CheckActivityGroupOpen()
  if not self:IsUnlockShow() then
    return false
  end
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  return curTime < self.nEndTime and self.nOpenTime > 0
end

function ActivityGroupDataBase:CheckActGroupShow()
  if not self:IsUnlockShow() then
    return false
  end
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  return curTime < self.nEndEnterTime
end

function ActivityGroupDataBase:CheckActGroupPopUpShow()
  if not self:IsUnlock() then
    return false
  end
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  return curTime < self.nEndTime
end

function ActivityGroupDataBase:GetActGroupEndTime()
  return self.nEndTime
end

function ActivityGroupDataBase:GetActGroupEnterEndTime()
  return self.nEndEnterTime
end

function ActivityGroupDataBase:GetActGroupRemainTime()
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  return self.nEndTime - curTime
end

function ActivityGroupDataBase:GetActGroupDate()
  local nOpenYear = tonumber(os.date("%Y", self.nOpenTime))
  local nOpenMonth = tonumber(os.date("%m", self.nOpenTime))
  local nOpenDay = tonumber(os.date("%d", self.nOpenTime))
  local nEndYear = tonumber(os.date("%Y", self.nEndTime))
  local nEndMonth = tonumber(os.date("%m", self.nEndTime))
  local nEndDay = tonumber(os.date("%d", self.nEndTime))
  return nOpenMonth, nOpenDay, nEndMonth, nEndDay, nOpenYear, nEndYear
end

function ActivityGroupDataBase:CheckPopUp()
  local localData = LocalData.GetPlayerLocalData("Act_PopUp_DontShow" .. self.actGroupCfg.Id)
  if localData then
    return false
  end
  return PlayerData.PopUp:IsNeedActPopUp(self.nActGroupId)
end

function ActivityGroupDataBase:CheckShowBanner()
  return self:CheckActGroupShow() and self.actCfg.BannerRes ~= "" and self.bBanner == false
end

function ActivityGroupDataBase:GetBannerPng()
end

function ActivityGroupDataBase:RefreshRedDot()
end

function ActivityGroupDataBase:RefreshStateData(bRedDot, bBanner)
  self.bRedDot = bRedDot
  self.bBanner = bBanner
end

function ActivityGroupDataBase:IsActivityInActivityGroup(nActivityId)
  return false
end

local ActivityState = {
  NotOpen = 1,
  Open = 2,
  Closed = 3
}

function ActivityGroupDataBase:GetActivityDataByActivityId(nActivityId)
  if self.tbAllActivity == nil then
    return nil
  end
  for _, activity in pairs(self.tbAllActivity) do
    if activity.ActivityId == nActivityId then
      return activity
    end
  end
end

function ActivityGroupDataBase:GetActivityEntranceState(nActivityId)
  local activityData = ConfigTable.GetData("Activity", nActivityId)
  local state = ActivityState.NotOpen
  if activityData ~= nil then
    local curTime = CS.ClientManager.Instance.serverTimeStamp
    if activityData.StartTime ~= "" and activityData.EndTime ~= "" then
      local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
      local endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
      if (activityData.ActivityType == GameEnum.activityType.Story or activityData.ActivityType == GameEnum.activityType.HistoryStory) and activityData.MidGroupId ~= nil and activityData.MidGroupId > 0 then
        local activityGroupData = ConfigTable.GetData("ActivityGroup", activityData.MidGroupId)
        if activityGroupData ~= nil and activityGroupData.StoryShowTime ~= nil and activityGroupData.StoryShowTime ~= "" then
          endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityGroupData.StoryShowTime)
        end
      end
      if curTime < openTime then
        state = ActivityState.NotOpen
      elseif curTime >= openTime and curTime < endTime then
        state = ActivityState.Open
      else
        state = ActivityState.Closed
      end
    elseif activityData.EndType == GameEnum.activityEndType.NoLimit then
      state = ActivityState.Open
      if activityData.StartTime ~= "" then
        local openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
        if curTime < openTime then
          state = ActivityState.NotOpen
        end
      end
    end
  end
  self.tbActivityEntranceState[nActivityId] = state
  return state
end

function ActivityGroupDataBase:GetActivityEntranceTimerData(nActivityId)
  local activityData = ConfigTable.GetData("Activity", nActivityId)
  local state = self:GetActivityEntranceState(nActivityId)
  local bShowCountDown = false
  local openTime, endTime
  if activityData ~= nil and activityData.StartTime ~= "" and activityData.EndTime ~= "" then
    openTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.StartTime)
    endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityData.EndTime)
    if (activityData.ActivityType == GameEnum.activityType.Story or activityData.ActivityType == GameEnum.activityType.HistoryStory) and activityData.MidGroupId ~= nil and activityData.MidGroupId > 0 then
      local activityGroupData = ConfigTable.GetData("ActivityGroup", activityData.MidGroupId)
      if activityGroupData ~= nil and activityGroupData.StoryShowTime ~= nil and activityGroupData.StoryShowTime ~= "" then
        endTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(activityGroupData.StoryShowTime)
      end
    end
    if state == ActivityState.Open then
      local curTime = CS.ClientManager.Instance.serverTimeStamp
      if endTime > self:GetActGroupEndTime() then
        bShowCountDown = true
      elseif endTime < self:GetActGroupEndTime() then
        bShowCountDown = endTime - curTime <= 259200
      end
    end
  end
  return state, bShowCountDown, openTime, endTime
end

function ActivityGroupDataBase:GetActivityEntranceStateTip(state)
  if state == ActivityState.Closed then
    return ConfigTable.GetUIText("Activity_End_Notice")
  elseif state == ActivityState.NotOpen then
    return ConfigTable.GetUIText("Activity_Not_Open")
  end
  return ""
end

function ActivityGroupDataBase:CheckActivityEntranceOpen(nActivityId, nPanelId, bShowTips, bRequiredActData)
  local actData = self:GetActivityDataByActivityId(nActivityId)
  if actData == nil or nPanelId ~= nil and actData.PanelId ~= nil and actData.PanelId ~= nPanelId then
    local sTips = ConfigTable.GetUIText("Activity_Not_Open")
    if bShowTips then
      EventManager.Hit(EventId.OpenMessageBox, sTips)
    end
    return false, ActivityState.NotOpen, sTips, false
  end
  local bUnlock, sUnlockTip = self:IsUnlock()
  if not bUnlock then
    if bShowTips then
      EventManager.Hit(EventId.OpenMessageBox, sUnlockTip or "")
    end
    return false, ActivityState.NotOpen, sUnlockTip or "", false
  end
  if not self:CheckActGroupShow() then
    local sTips = ConfigTable.GetUIText("Activity_End_Notice")
    if bShowTips then
      EventManager.Hit(EventId.OpenMessageBox, sTips)
    end
    return false, ActivityState.Closed, sTips, false
  end
  local state = self:GetActivityEntranceState(nActivityId)
  if state ~= ActivityState.Open then
    local sTips = self:GetActivityEntranceStateTip(state)
    if bShowTips then
      EventManager.Hit(EventId.OpenMessageBox, sTips)
    end
    return false, state, sTips, false
  end
  local activityData = PlayerData.Activity:GetActivityDataById(nActivityId)
  if activityData == nil then
    local bHint = true
    if actData.Index == AllEnum.ActivityThemeFuncIndex.Story then
      bHint = not PlayerData.ActivityAvg:HasActivityData(nActivityId)
    end
    if bHint then
      local sTips = ConfigTable.GetUIText(bRequiredActData and "Activity_Data_Refreshing" or "Activity_Not_Open")
      if bShowTips then
        EventManager.Hit(EventId.OpenMessageBox, sTips)
      end
      return false, state, sTips, not bRequiredActData
    end
  elseif type(activityData.CheckActJumpCond) == "function" then
    local bCanJump, sTips = activityData:CheckActJumpCond(bShowTips)
    if not bCanJump then
      return false, state, sTips, false
    end
  end
  return true, state, "", false
end

function ActivityGroupDataBase:OnOpenMiniGameEntrance(actData)
end

function ActivityGroupDataBase:OpenActivityEntrance(nActivityId, nPanelId, nMiniGameTransitionId)
  local actData = self:GetActivityDataByActivityId(nActivityId)
  if actData == nil then
    return
  end
  nPanelId = nPanelId or actData.PanelId
  if nPanelId == nil then
    return
  end
  if actData.Index == AllEnum.ActivityThemeFuncIndex.MiniGame then
    self:OnOpenMiniGameEntrance(actData)
    if nMiniGameTransitionId ~= nil and 0 < nMiniGameTransitionId then
      EventManager.Hit(EventId.SetTransition, nMiniGameTransitionId, function()
        EventManager.Hit(EventId.OpenPanel, nPanelId, nActivityId, self.nActGroupId)
      end)
    else
      EventManager.Hit(EventId.OpenPanel, nPanelId, nActivityId, self.nActGroupId)
    end
    return
  end
  if self.actGroupCfg.TransitionId ~= nil and 0 < self.actGroupCfg.TransitionId then
    EventManager.Hit(EventId.SetTransition, self.actGroupCfg.TransitionId, function()
      EventManager.Hit(EventId.OpenPanel, nPanelId, nActivityId)
    end)
  else
    EventManager.Hit(EventId.OpenPanel, nPanelId, nActivityId)
  end
end

return ActivityGroupDataBase
