local UILotteryShow = class("UILotteryShow", UIBaseWindow)
local base = UIBaseWindow

function UILotteryShow:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.SkipLotteryShow)
end

function UILotteryShow:InitLotteryShow(showCtrl)
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIManager:HideWindow(UIWindowTypeID.TopStatus)
  self.__showCtrl = showCtrl
end

function UILotteryShow:BackAction()
  if self.__showCtrl ~= nil then
    self.__showCtrl:SkipShow()
  end
end

function UILotteryShow:SkipLotteryShow()
  UIUtil.OnClickBackByUiTab(self)
end

return UILotteryShow
