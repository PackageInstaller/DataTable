local Vector2 = CS.UnityEngine.Vector2
local ActivityBasePanel, Super = System.NewClass("ActivityBasePanel", UIBasePanel)

function ActivityBasePanel:OnBind(binder)
  self.binder = binder
end

function ActivityBasePanel:_SetActivityPlot(textGameObj)
  local desc = ""
  if self.activityConfig and self.activityConfig.ActivityPlot then
    desc = LT.Text(self.activityConfig.ActivityPlot)
  end
  textGameObj = textGameObj or self.ui.Text_Desc
  if textGameObj then
    self.binder:SetText(textGameObj, desc)
  end
end

function ActivityBasePanel:_BindActivityTimer()
  if not (self.activityData and self.binder and self.ui) or not self.ui.Text_Time then
    Logger.Warn("_BindActivityTimer wrong activityData:%s binder:%s Text_Time:%s", self.activityData, self.binder, self.ui and self.ui.Text_Time)
    return
  end
  local timeType = ActivityDataUtils.GetTimeType(self.activityData.activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
    return
  end
  local leftTime = ActivityDataUtils.GetLeftTime(self.activityData) or 0
  if leftTime <= 0 then
    if self.activityData.endTime > 0 and self.activityData.endTime < TimeUtils.GetServerTime() then
      self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimeExpired"))
    end
    return
  end
  self.binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  if self._activityTimer then
    self.binder:StopTimer(self._activityTimer)
  end
  self._activityTimer = self.binder:BindTimer(1, -1, function()
    leftTime = leftTime - 1
    if leftTime <= 0 then
      self:_ClearTimer()
      return
    end
    self.binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  end, function()
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimeExpired"))
    self:_ClearTimer()
  end)
end

function ActivityBasePanel:_ClearTimer()
  if self._activityTimer then
    TimerManager.Instance:StopTimer(self._activityTimer)
    self._activityTimer = nil
  end
end

function ActivityBasePanel:_BindPortraitComp()
  if not (self.activityTid and self.binder and self.ui) or not self.ui.Image_Awaker then
    return
  end
  local config = ActivityDataUtils.GetConfig(self.activityTid)
  if not config or not config.ShowAwaker then
    return
  end
  local awakerTid = config.ShowAwaker
  if not self.awakerPortraitComp then
    local portraitAlign = CommonDefine.PortraitAlign.Center
    self.awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Image_Awaker, awakerTid, nil, nil, portraitAlign))
  else
    self.awakerPortraitComp:ChangeAwakerTid(awakerTid)
  end
end

function ActivityBasePanel:Show()
  if self.ui and self.ui.uiNode then
    self.ui.uiNode.transform.anchoredPosition = Vector2.zero
  end
  if self.ui.Text_Title then
    StrUtils.SetPreferedWidthFontSize(self.ui.Text_Title, nil, 800)
  end
  if self.ui.Text_Diary then
    StrUtils.SetPreferedWidthFontSize(self.ui.Text_Diary, nil, 800)
  end
end

function ActivityBasePanel:Hide()
  if self.ui and self.ui.uiNode then
    self.ui.uiNode.transform.anchoredPosition = Vector2(9999, 9999)
  end
end

function ActivityBasePanel:OnOpenAnim(callback)
  self:Show()
  if callback then
    callback()
  end
end

function ActivityBasePanel:OnCloseAnim(callback)
  self:Hide()
  if callback then
    callback()
  end
end

return ActivityBasePanel
