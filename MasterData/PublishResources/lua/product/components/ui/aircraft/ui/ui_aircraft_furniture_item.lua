_class("UIAircraftFurnitureItem", UICustomWidget)
UIAircraftFurnitureItem = UIAircraftFurnitureItem

function UIAircraftFurnitureItem:OnShow(uiParams)
  self._aircraftModule = GameGlobal.GameLogic():GetModule(AircraftModule)
  self:_GetComponents()
end

function UIAircraftFurnitureItem:SetData(furnitureInfo)
  local item_cfg = Cfg.cfg_item({})
  local furnitureNameID = item_cfg[furnitureInfo.nAssetId].Name
  local furnitureName = StringTable.Get(furnitureNameID)
  self._name:SetText(furnitureName)
  self._num:SetText("x" .. furnitureInfo.count)
  self._addNum:SetText(furnitureInfo.baseAmbient)
end

function UIAircraftFurnitureItem:_GetComponents()
  self._name = self:GetUIComponent("Text", "Name")
  self._num = self:GetUIComponent("Text", "Num")
  self._addNum = self:GetUIComponent("Text", "AddNum")
  self._extaAdd = self:GetUIComponent("Text", "ExtaAdd")
end

function UIAircraftFurnitureItem:_OnRefresh()
end
