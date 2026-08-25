local CompCommonillustrateCreationItem, Super = NewViewComponent("CompCommonillustrateCreationItem")

function CompCommonillustrateCreationItem:ctor(uiNode, view, creationTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Rule_Creation_ItemResource(uiNode)
  self._creationTid = creationTid
end

function CompCommonillustrateCreationItem:OnEnterComponent()
  local relicCfg = RelicCfgUtils.GetCfg(self._creationTid)
  self:SetText(self.ui.Text_Item_Name, LT.Text(relicCfg.Name))
  self:SetText(self.ui.Text_Item_Desc, RelicDataUtils.GetRelicDesc(relicCfg.ID))
  self:SetImage(self.ui.Icon_Article, relicCfg.Icon)
end

return CompCommonillustrateCreationItem
