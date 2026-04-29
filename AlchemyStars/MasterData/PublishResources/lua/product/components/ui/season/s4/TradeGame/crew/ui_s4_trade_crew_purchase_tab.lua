_class("UIS4TradeCrewPurchaseTab", UICustomWidget)
UIS4TradeCrewPurchaseTab = UIS4TradeCrewPurchaseTab

function UIS4TradeCrewPurchaseTab:Constructor()
  self._isInit = false
end

function UIS4TradeCrewPurchaseTab:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnS4TradeCrewChange, self.OnS4TradeCrewChange)
  self:_GetComponents()
end

function UIS4TradeCrewPurchaseTab:_GetComponents()
  self._purchaseBlock = self:GetUIComponent("UISelectObjectPath", "purchaseBlock")
end

function UIS4TradeCrewPurchaseTab:SetData(tradeData, selectID)
  self._tradeData = tradeData
  self._selectID = selectID
  self:_InitComponents()
end

function UIS4TradeCrewPurchaseTab:OnS4TradeCrewChange()
  self:_InitComponents()
  self:PlayInAnim()
end

function UIS4TradeCrewPurchaseTab:_InitComponents()
  local noBuyCrews = self._tradeData:GetAllNoBuyCrews()
  self._purchaseCrews = self._purchaseBlock:SpawnObjects("UIS4TradeCrewItem", table.count(noBuyCrews))
  for i, crew in pairs(self._purchaseCrews) do
    crew:SetData(self._tradeData, noBuyCrews[i], self._selectID, true, function()
      self:_InitComponents()
    end)
  end
end

function UIS4TradeCrewPurchaseTab:SetInit()
  self._isInit = true
end

function UIS4TradeCrewPurchaseTab:PlayInAnim()
  if not self._isInit then
    return
  end
  for i, crew in pairs(self._purchaseCrews) do
    crew:PlayInAnim(i)
  end
end
