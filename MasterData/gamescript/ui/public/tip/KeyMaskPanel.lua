local SAFE_TIME = 10
local KeyMaskPanel, Super = System.NewClass("KeyMaskPanel", UIBasePanel)
KeyMaskPanel.uiResCls = UILoadingBlockMaskResource

function KeyMaskPanel:ctor(showStr, showDuration, closeCallback)
  Super.ctor(self)
  self.showStr = showStr
  self.showDuration = showDuration or SAFE_TIME
  self.closeCallback = closeCallback
end

function KeyMaskPanel:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Desc, self.showStr)
  binder:BindTimer(1, self.showDuration, nil, System.fn(self, self.Close))
end

function KeyMaskPanel:Close()
  Super.Close(self)
  if self.closeCallback then
    self.closeCallback()
  end
end

return KeyMaskPanel
