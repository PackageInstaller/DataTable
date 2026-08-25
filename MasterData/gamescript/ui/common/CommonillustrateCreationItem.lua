local CommonillustrateCreationItem, Super = System.NewComponent("CommonillustrateCreationItem")

function CommonillustrateCreationItem:ctor(uiNode, creationTid)
  Super.ctor(self)
  self.ui = UI_Pvp_Rule_Creation_ItemResource(uiNode)
  self._creationTid = creationTid
end

function CommonillustrateCreationItem:OnBind(binder)
  self.binder = binder
  local relicCfg = RelicCfgUtils.GetCfg(self._creationTid)
  self.binder:SetText(self.ui.Text_Item_Name, LT.Text(relicCfg.Name))
  self.binder:SetText(self.ui.Text_Item_Desc, RelicDataUtils.GetRelicDesc(relicCfg.ID))
  self.binder:SetImage(self.ui.Icon_Article, relicCfg.Icon)
end

return CommonillustrateCreationItem
