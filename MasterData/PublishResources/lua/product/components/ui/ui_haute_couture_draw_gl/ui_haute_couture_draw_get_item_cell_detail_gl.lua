_class("UIHauteCoutureDrawGetItemCellDetailGL", UICustomWidget)
UIHauteCoutureDrawGetItemCellDetailGL = UIHauteCoutureDrawGetItemCellDetailGL

function UIHauteCoutureDrawGetItemCellDetailGL:OnShow(uiParams)
  self:InitWidget()
end

function UIHauteCoutureDrawGetItemCellDetailGL:InitWidget()
  local item = self:GetUIComponent("UISelectObjectPath", "item")
  self.item = item:SpawnObject("UIHauteCoutureDrawGetItemCellGL")
  self.txt_name = self:GetUIComponent("UILocalizationText", "txt_name")
  self.txt_have = self:GetUIComponent("UILocalizationText", "txt_have")
  self.txt_desc = self:GetUIComponent("UILocalizationText", "txt_desc")
end

function UIHauteCoutureDrawGetItemCellDetailGL:SetData(itemInfo)
  self.item:SetData(itemInfo, false, nil)
  self.item:EnableInteract(false)
  self.txt_name:SetText(StringTable.Get(itemInfo.item_name))
  self.txt_desc:SetText(StringTable.Get(itemInfo.simple_desc))
  local roleModule = GameGlobal.GetModule(RoleModule)
  local c = roleModule:GetAssetCount(itemInfo.item_id) or 0
  self.txt_have:SetText(StringTable.Get("str_item_public_owned") .. c)
end
