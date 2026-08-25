local T_CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local FeatureUnlockView, Super = NewClass("FeatureUnlockView", BaseView)
FeatureUnlockView.uiResCls = UI_Other_Popup_OpensystemResource

function FeatureUnlockView:ctor(panelData, closeCb)
  Super.ctor(self)
  self._data = panelData
  self._closeCb = closeCb
  self._banClick = true
  self._timer = nil
end

function FeatureUnlockView:OnBuildView()
  Super.OnBuildView(self)
  self.closeWithoutAnim = true
  self._canvasGroup = self.ui.uiNode:GetComponent(T_CanvasGroup)
end

function FeatureUnlockView:RegisterNotifications()
end

function FeatureUnlockView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClickClose))
  self:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self._OnCSEvent))
end

function FeatureUnlockView:OnEnterView()
  Super.OnEnterView(self)
  if self._canvasGroup then
    self._canvasGroup.alpha = 0
  end
  self:_Refresh()
  self._timer = self:BindTimer(0.05, 0, nil, function()
    self._timer = nil
    if IsNil(self._canvasGroup) then
      return
    end
    self._canvasGroup.alpha = 1
  end)
end

function FeatureUnlockView:OnExitView()
  Super.OnExitView(self)
end

function FeatureUnlockView:OnUIOpenAnimFinish()
  self._banClick = false
end

function FeatureUnlockView:_Refresh()
  self:SetText(self.ui.Text_Title, self._data.title)
  self:SetText(self.ui.Text_Desc, self._data.desc)
end

function FeatureUnlockView:_OnClickClose()
  if self._banClick then
    return
  end
  local showData = PlayerDataUtils.PopFeatureUnlockShowQueue()
  if showData then
    self._data = showData
    self:_Refresh()
    self._banClick = true
    self:PlayUIAnim(System.fn(self, self.OnUIOpenAnimFinish), true)
    self.ui.Group_Top:SetActive(false)
    self.ui.Group_Top:SetActive(true)
  else
    PlayerDataUtils.SetEnabledShow(true)
    local closeCb = self._closeCb
    self._closeCb = nil
    self:Close()
    if closeCb then
      closeCb()
    end
  end
end

function FeatureUnlockView:_OnCSEvent(eventName, eventValue)
  if "OnStartGrabScreen" ~= eventName then
    return
  end
  if IsNil(self._canvasGroup) then
    return
  end
  if 0 == tonumber(eventValue) then
    if self._timer then
      self:StopTimer(self._timer)
      self._timer = nil
    end
    self.ui.Group_Top:SetActive(false)
    self.ui.Group_Top:SetActive(true)
    self._canvasGroup.alpha = 1
  end
end

return FeatureUnlockView
