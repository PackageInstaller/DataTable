_class("UIHauteCoutureDrawGetItemCellDetailBLH", UICustomWidget)
UIHauteCoutureDrawGetItemCellDetailBLH = UIHauteCoutureDrawGetItemCellDetailBLH

function UIHauteCoutureDrawGetItemCellDetailBLH:OnShow(uiParams)
  self:InitWidget()
end

function UIHauteCoutureDrawGetItemCellDetailBLH:InitWidget()
  local item = self:GetUIComponent("UISelectObjectPath", "item")
  self.item = item:SpawnObject("UIHauteCoutureDrawGetItemCellBLH")
  self.txt_name = self:GetUIComponent("UILocalizationText", "txt_name")
  self.txt_have = self:GetUIComponent("UILocalizationText", "txt_have")
  self.txt_desc = self:GetUIComponent("UILocalizationText", "txt_desc")
end

function UIHauteCoutureDrawGetItemCellDetailBLH:SetData(itemInfo)
  self.item:SetData(itemInfo, false, nil)
  self.item:EnableInteract(false)
  self.txt_name:SetText(StringTable.Get(itemInfo.item_name))
  self.txt_desc:SetText(StringTable.Get(itemInfo.simple_desc))
  local roleModule = GameGlobal.GetModule(RoleModule)
  local c = roleModule:GetAssetCount(itemInfo.item_id) or 0
  self.txt_have:SetText(c)
end
