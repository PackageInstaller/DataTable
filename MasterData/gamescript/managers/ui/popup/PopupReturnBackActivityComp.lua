local PopupReturnBackActivityComp = System.NewClass("PopupReturnBackActivityComp", PopupBaseComp)

function PopupReturnBackActivityComp:ctor()
  self._returnBackActivityTid = nil
end

function PopupReturnBackActivityComp:OnBind(binder)
  self.binder = binder
end

function PopupReturnBackActivityComp:Clear()
  self._returnBackActivityTid = nil
end

function PopupReturnBackActivityComp:OnActivityChange()
  local displayActivityTidMap = ActivityManager.Instance.model:GetDisplayActivityTidMap()
  for activityTid, activityData in pairs(displayActivityTidMap) do
    local activityCfg = ActivityDataUtils.GetConfig(activityTid)
    if activityCfg.ActivitySystemType ~= ActivityDefine.ActivitySystemType.ReturnEvent or activityData.startTime > TimeUtils.GetServerTime() then
    else
      self._returnBackActivityTid = activityTid
    end
  end
end

function PopupReturnBackActivityComp:CheckPopup()
  if not self._returnBackActivityTid then
    return
  end
  local _, isUnlockActivity = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Activity, 0)
  if not isUnlockActivity then
    return
  end
  if not ActivityDataUtils.IsActivityOpen(self._returnBackActivityTid) then
    return
  end
  local activityData = ActivityDataUtils.GetActivityData(self._returnBackActivityTid)
  if not activityData then
    return
  end
  local activityEndTime = activityData.base.endTime
  local cacheData = ClientDataUtils.GetClientSubData(cd.ClientSubKey.Played2YearReturnAvg)
  local lastEndTime = cacheData and tonumber(cacheData)
  if lastEndTime and activityEndTime <= lastEndTime then
    return
  end
  local stageFinalId = DT.GetConstant("StageFinalId")
  local isPassFirstStChapter = CopyDataUtils.IsFirstRewardDraw(stageFinalId)
  local avgStoryTidList = DT.GetOriginalConstant("ReturnPopupAvg")
  local avgStoryTid = not isPassFirstStChapter and avgStoryTidList[1] or avgStoryTidList[2]
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.Played2YearReturnAvg, activityEndTime, true)
  AvgStoryManager.Instance:StartStoryById(avgStoryTid, nil, function()
    local jumpToActivityTid = DT.GetOriginalConstant("ReturnPopupAvgJumpto")
    if not ActivityDataUtils.IsActivityOpen(jumpToActivityTid) then
      jumpToActivityTid = self._returnBackActivityTid
    end
    ActivityDataUtils.OpenActivityMainPanel(jumpToActivityTid)
    self:SetBusy(false)
  end)
  self:SetBusy(true)
end

function PopupReturnBackActivityComp:_OnBusySafetyCheck()
  do return AvgStoryManager.Instance.IsPlaying end
  return AvgStoryManager.Instance.IsPlaying, AvgStoryManager.Instance
end

return PopupReturnBackActivityComp
