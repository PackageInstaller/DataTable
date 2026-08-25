local SummonIntroInventoryPage, Super = System.NewComponent("SummonIntroInventoryPage")

function SummonIntroInventoryPage:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Summon_Popup_Detail_TipResource(uiNode)
  self.model = model
end

function SummonIntroInventoryPage:OnBind(binder)
  binder:SetText(self.ui.Text_Inventory_Title, LT.Text("Summon_RateList_Text1"))
  local inventoryDict = self.model:GetInventoryDict()
  self:_TryCreateInventory(binder, inventoryDict.SSR, self.ui.UI_Summon_Item_Inventory_SSR)
  self:_TryCreateInventory(binder, inventoryDict.SR, self.ui.UI_Summon_Item_Inventory_SR)
  self:_TryCreateInventory(binder, inventoryDict.R, self.ui.UI_Summon_Item_Inventory_R)
end

function SummonIntroInventoryPage:_TryCreateInventory(binder, inventoryData, uiNode)
  if inventoryData then
    uiNode:SetActive(true)
    binder:BindComponent(SummonIntroInventoryPageItem(uiNode, inventoryData))
  else
    uiNode:SetActive(false)
  end
end

return SummonIntroInventoryPage
