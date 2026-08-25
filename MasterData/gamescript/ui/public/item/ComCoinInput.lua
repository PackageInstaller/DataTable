local ComCoinInput, Super = System.NewComponent("ComCoinInput")

function ComCoinInput:ctor(res, plusCb, minusCb, maxCb, minCb)
  Super.ctor(self)
  self.ui = Com_Coin_InputResource(res)
  self.currrentNum = 1
  self.plusCb = plusCb
  self.minusCb = minusCb
  self.maxCb = maxCb
  self.minCb = minCb
end

function ComCoinInput:OnBind(binder)
  self.binder = binder
  self.binder:BindButtonClick(self.ui.Btn_Add, System.fn(self, self.OnClickPlus))
  self.binder:BindButtonClick(self.ui.Btn_Minus, System.fn(self, self.OnClickMinus))
  self.binder:BindButtonClick(self.ui.Btn_Max, System.fn(self, self.OnClickMax))
  self.binder:BindButtonClick(self.ui.Btn_Min, System.fn(self, self.OnClickMin))
end

function ComCoinInput:OnClickPlus()
  if self.plusCb then
    self.plusCb()
  end
end

function ComCoinInput:OnClickMinus()
  if self.minusCb then
    self.minusCb()
  end
end

function ComCoinInput:OnClickMax()
  if self.maxCb then
    self.maxCb()
  end
end

function ComCoinInput:OnClickMin()
  if self.minCb then
    self.minCb()
  end
end

function ComCoinInput:UpdateCurrentNum(currentNum)
  if currentNum then
    self.binder:SetText(self.ui.Text_Current_Num, currentNum)
  end
end

function ComCoinInput:UpdateTotalNum(totalNum)
  if totalNum then
    self.binder:SetText(self.ui.Text_Total_Num, totalNum)
  end
end

return ComCoinInput
