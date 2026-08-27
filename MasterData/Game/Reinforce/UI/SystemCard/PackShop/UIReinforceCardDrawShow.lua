local UIReinforceCardDrawShow = class("UIReinforceCardDrawShow", UIBaseWindow)
local base = UIBaseWindow

function UIReinforceCardDrawShow:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_mask, self, self.SkipLotteryShow)
  self.duration = 1.4
end

function UIReinforceCardDrawShow:InitLotteryShow(texture, callback)
  self.callback = callback
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
  self.ui.core.texture = texture
  self.ui.effectMask.texture = texture
  self.ui.effectMask.gameObject:SetActive(true)
  self.showAnimTImer = TimerManager:StartTimer(self.duration, function()
    if self.callback ~= nil then
      self.callback()
    end
    self.callback = nil
    self.showAnimTImer = nil
  end, self, true)
end

function UIReinforceCardDrawShow:BackAction()
  self:Delete()
end

function UIReinforceCardDrawShow:SkipLotteryShow()
  if self.showAnimTImer ~= nil then
    TimerManager:StopTimer(self.showAnimTImer)
    self.showAnimTImer = nil
  end
  if self.callback ~= nil then
    self.callback()
    self.callback = nil
  end
  UIUtil.OnClickBackByUiTab(self)
end

return UIReinforceCardDrawShow
