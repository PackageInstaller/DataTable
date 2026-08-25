local T_CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local FeatureUnlockPanel, Super = System.NewClass("FeatureUnlockPanel", UIBasePanel)
FeatureUnlockPanel.uiResCls = UI_Other_Popup_OpensystemResource

function FeatureUnlockPanel:ctor(panelData, closeCb)
  Super.ctor(self)
  self.data = panelData
  self.closeCb = closeCb
  self.banClick = true
  self:SetOpenEndCallback(System.fn(self, self.OpenAnimCb))
end

function FeatureUnlockPanel:OnBind(binder)
  self.binder = binder
  self.closeWithoutAnim = true
  self.canvasGroup = self.ui.uiNode:GetComponent(T_CanvasGroup)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnClickClose))
  binder:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self.OnCSEvent))
  self.timer = binder:BindTimer(0.05, 0, nil, function()
    self.timer = nil
    if IsNil(self.canvasGroup) then
      return
    end
    self.canvasGroup.alpha = 1
  end)
  self:_Refresh()
end

function FeatureUnlockPanel:_Refresh()
  self.binder:SetText(self.ui.Text_Title, self.data.title)
  self.binder:SetText(self.ui.Text_Desc, self.data.desc)
end

function FeatureUnlockPanel:OnEnterUI()
  Super.OnEnterUI(self)
  if self.canvasGroup then
    self.canvasGroup.alpha = 0
  end
end

function FeatureUnlockPanel:OpenAnimCb()
  self.banClick = false
end

function FeatureUnlockPanel:OnClickClose()
  local showData = PlayerDataUtils.PopFeatureUnlockShowQueue()
  if showData then
    self.data = showData
    self:_Refresh()
    self.banClick = true
    self:PlayUIAnim(System.fn(self, self.OpenAnimCb), true)
    self.ui.Group_Top:SetActive(false)
    self.ui.Group_Top:SetActive(true)
  else
    PlayerDataUtils.SetEnabledShow(true)
    Super.Close(self)
    if self.closeCb then
      self.closeCb()
    end
  end
end

function FeatureUnlockPanel:OnCSEvent(eventName, eventValue)
  if "OnStartGrabScreen" ~= eventName then
    return
  end
  if IsNil(self.canvasGroup) then
    return
  end
  if 0 == tonumber(eventValue) then
    if self.timer then
      self.binder:StopTimer(self.timer)
      self.timer = nil
    end
    self.ui.Group_Top:SetActive(false)
    self.ui.Group_Top:SetActive(true)
    self.canvasGroup.alpha = 1
  end
end

return FeatureUnlockPanel
