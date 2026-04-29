_class("UICN20N49AlchemyShopLevelUPComplete", UIController)
UICN20N49AlchemyShopLevelUPComplete = UICN20N49AlchemyShopLevelUPComplete

function UICN20N49AlchemyShopLevelUPComplete:OnShow(uiParams)
  self._cfg = uiParams[1]
  self:InitWidgets()
  self:RefreshUI()
end

function UICN20N49AlchemyShopLevelUPComplete:InitWidgets()
  self._itemText = self:GetUIComponent("UILocalizationText", "itemText")
end

function UICN20N49AlchemyShopLevelUPComplete:RefreshUI()
  self._itemText:SetText(StringTable.Get(self._cfg.Desc))
end

function UICN20N49AlchemyShopLevelUPComplete:BgOnClick(go)
  self:CloseDialog()
  if self._callback then
    self._callback()
  end
end
