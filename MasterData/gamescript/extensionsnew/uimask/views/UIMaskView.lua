local UIMaskView, Super = NewClass("UIMaskView", BaseView)
UIMaskView.uiResCls = UI_Common_Mask_PanelResource

function UIMaskView:ctor(delay)
  Super.ctor(self)
  self._delay = delay
end

function UIMaskView:RegisterNotifications()
end

function UIMaskView:RegisterEvents()
end

function UIMaskView:OnEnterView()
  Super.OnEnterView(self)
  self:BindTimer(self._delay or 2, 0, nil, function()
    self:Close()
  end)
end

function UIMaskView:OnExitView()
  Super.OnExitView(self)
end

return UIMaskView
