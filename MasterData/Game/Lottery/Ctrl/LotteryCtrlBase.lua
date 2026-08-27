local LotteryCtrlBase = class("LotteryCtrlBase")

function LotteryCtrlBase:ctor(ltrCtrl)
  self.ltrCtrl = ltrCtrl
  table.insert(self.ltrCtrl.ctrls, self)
end

function LotteryCtrlBase:OnDelete()
end

return LotteryCtrlBase
