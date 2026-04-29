_class("UIWidgetCancelArea", UICustomWidget)
UIWidgetCancelArea = UIWidgetCancelArea

function UIWidgetCancelArea:OnShow()
  self._cancelArea = self:GetGameObject("CancelArea")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelArea), UIEvent.Hovered, function(go)
    self:OnEnterCancelArea(go)
  end)
  self:AttachEvent(GameEventType.ApplicationFocus, self.OnApplicationFocus)
  self:AttachEvent(GameEventType.ShowChainPathCancelArea, self.OnShowChainPathCancelArea)
  self:AttachEvent(GameEventType.HideChainPathCancelArea, self.OnHideChainPathCancelArea)
end

function UIWidgetCancelArea:OnHide()
  Log.notice("cancel hide")
end

function UIWidgetCancelArea:OnEnterCancelArea()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattle",
    input = "OnEnterCancelArea",
    args = {}
  })
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CancelChainPath)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
  self:OnHideChainPathCancelArea()
end

function UIWidgetCancelArea:OnShowChainPathCancelArea()
  if BattleStatHelper.GetAutoFightStat() then
    return
  end
  self._cancelArea:SetActive(true)
end

function UIWidgetCancelArea:OnHideChainPathCancelArea()
  self._cancelArea:SetActive(false)
end

function UIWidgetCancelArea:OnApplicationFocus(isFocus)
  if not GameGlobal:GetInstance():IsCoreGameRunning() then
    return
  end
  if isFocus then
  elseif GameGlobal:GetInstance():IsLinkLineState() then
    self:OnEnterCancelArea()
  end
end
