local SAFE_TIME = 10
local KeyMaskView, Super = NewClass("KeyMaskView", BaseView)
KeyMaskView.uiResCls = UILoadingBlockMaskResource

function KeyMaskView:ctor(showStr, showDuration, closeCallback)
  Super.ctor(self)
  self._showStr = showStr
  self._showDuration = showDuration or SAFE_TIME
  self._closeCallback = closeCallback
end

function KeyMaskView:RegisterNotifications()
end

function KeyMaskView:RegisterEvents()
end

function KeyMaskView:OnEnterView()
  Super.OnEnterView(self)
  local rect = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  if rect then
    rect.anchorMin = CS.UnityEngine.Vector2(0, 0)
    rect.anchorMax = CS.UnityEngine.Vector2(1, 1)
    rect.offsetMin = CS.UnityEngine.Vector2(0, 0)
    rect.offsetMax = CS.UnityEngine.Vector2(0, 0)
  end
  self:SetText(self.ui.Text_Desc, self._showStr)
  self:BindTimer(1, self._showDuration, nil, function()
    if self._closeCallback then
      self._closeCallback()
      self._closeCallback = nil
    end
    self:Close()
  end)
end

function KeyMaskView:OnExitView()
  Super.OnExitView(self)
end

return KeyMaskView
