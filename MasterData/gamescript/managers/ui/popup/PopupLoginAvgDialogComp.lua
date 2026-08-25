local PopupLoginAvgDialogComp = System.NewClass("PopupLoginAvgDialogComp", PopupBaseComp)

function PopupLoginAvgDialogComp:ctor()
end

function PopupLoginAvgDialogComp:OnBind(binder)
  self.binder = binder
end

function PopupLoginAvgDialogComp:Clear()
end

function PopupLoginAvgDialogComp:_GetTimeRange()
  local range = DT.GetOriginalConstant("LoginAvgDialogTimeRange")
  if type(range) ~= "table" or #range < 2 then
    return
  end
  local startTs = tonumber(range[1])
  local endTs = tonumber(range[2])
  if not startTs or not endTs then
    return
  end
  return startTs, endTs
end

function PopupLoginAvgDialogComp:_GetStoryId()
  local avgStoryTid = DT.GetOriginalConstant("LoginAvgDialogId")
  if type(avgStoryTid) == "table" then
    avgStoryTid = avgStoryTid[1]
  end
  avgStoryTid = tonumber(avgStoryTid)
  if not avgStoryTid or not DT.AvgDialog[avgStoryTid] then
    return
  end
  return avgStoryTid
end

function PopupLoginAvgDialogComp:CheckPopup()
  if not GuidePanelUtils.IsViewAtTop(Urls.MainPanel) then
    return
  end
  local startTs, endTs = self:_GetTimeRange()
  if not startTs or not endTs then
    return
  end
  local now = TimeUtils.GetServerTime()
  if startTs > now or endTs < now then
    return
  end
  local popupStamp = ClientDataUtils.GetClientSubData(cd.ClientSubKey.LoginAvgDialogPopupStamp)
  if popupStamp == endTs then
    return
  end
  local avgStoryTid = self:_GetStoryId()
  if not avgStoryTid then
    return
  end
  ClientDataUtils.SetClientSubData(cd.ClientSubKey.LoginAvgDialogPopupStamp, endTs, true)
  AvgStoryManager.Instance:StartStoryById(avgStoryTid, nil, function()
    self:SetBusy(false)
  end)
  self:SetBusy(true)
end

function PopupLoginAvgDialogComp:_OnBusySafetyCheck()
  do return AvgStoryManager.Instance.IsPlaying end
  return AvgStoryManager.Instance.IsPlaying, AvgStoryManager.Instance
end

return PopupLoginAvgDialogComp
