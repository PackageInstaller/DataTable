_class("UIS4TradeCrewManager", UICustomWidget)
UIS4TradeCrewManager = UIS4TradeCrewManager

function UIS4TradeCrewManager:OnShow(uiParams)
  self:InitWidget()
end

function UIS4TradeCrewManager:InitWidget()
  self._headList = self:GetUIComponent("UISelectObjectPath", "headList")
end

function UIS4TradeCrewManager:SetData(tradeData, selectID)
  self._tradeData = tradeData
  self._selectID = selectID
  self:Refresh()
end

function UIS4TradeCrewManager:Refresh()
  self._crews = self._tradeData:GetCrewsByHarbourID(self._selectID)
  self._crewItemTb = self._headList:SpawnObjects("UIS4TradeCrewManagerItem", 3)
  for i, item in pairs(self._crewItemTb) do
    local crew
    if i <= table.count(self._crews) then
      crew = self._crews[i]
    end
    item:SetData(crew)
  end
end

function UIS4TradeCrewManager:BgOnClick()
  self:ShowDialog("UIS4TradeCrewController", self._tradeData, self._selectID)
end
