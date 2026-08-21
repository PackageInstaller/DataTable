_class("UIS4TradeCrewControlTab", UICustomWidget)
UIS4TradeCrewControlTab = UIS4TradeCrewControlTab

function UIS4TradeCrewControlTab:OnShow(uiParams)
  self:_GetComponents()
  self:AttachEvent(GameEventType.OnS4TradeCrewBuy, self._InitComponents)
  self:AttachEvent(GameEventType.OnS4TradeCrewChange, self.OnS4TradeCrewChange)
end

function UIS4TradeCrewControlTab:_GetComponents()
  self._occupyBlock = self:GetUIComponent("UISelectObjectPath", "occupyBlock")
  self._crewBlock = self:GetUIComponent("UISelectObjectPath", "crewBlock")
end

function UIS4TradeCrewControlTab:SetData(tradeData, selectID)
  self._tradeData = tradeData
  self._selectID = selectID
  self:_InitComponents()
end

function UIS4TradeCrewControlTab:OnS4TradeCrewChange()
  self:_InitComponents()
  self:PlayInAnim()
end

function UIS4TradeCrewControlTab:_InitComponents()
  local occupyCrews = self._tradeData:GetCrewsByHarbourID(self._selectID)
  local showCrews = self._tradeData:GetAllBuyCrewsExceptID(self._selectID)
  self._occupyCrews = self._occupyBlock:SpawnObjects("UIS4TradeCrewItem", table.count(occupyCrews))
  self._normalCrews = self._crewBlock:SpawnObjects("UIS4TradeCrewItem", table.count(showCrews))
  local index = 1
  for _, id in pairs(occupyCrews) do
    local crew = self._occupyCrews[index]
    crew:SetData(self._tradeData, id, self._selectID)
    index = index + 1
  end
  index = 1
  for _, id in pairs(showCrews) do
    local crew = self._normalCrews[index]
    crew:SetData(self._tradeData, id, self._selectID)
    index = index + 1
  end
end

function UIS4TradeCrewControlTab:PlayInAnim()
  for index, crew in pairs(self._occupyCrews) do
    crew:PlayInAnim(index)
  end
  for index, crew in pairs(self._normalCrews) do
    crew:PlayInAnim(index)
  end
end
