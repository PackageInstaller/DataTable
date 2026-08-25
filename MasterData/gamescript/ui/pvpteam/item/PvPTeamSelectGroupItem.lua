local PvPTeamSelectGroupItem, Super = System.NewComponent("PvPTeamSelectGroupItem")

function PvPTeamSelectGroupItem:ctor(uiNode, itemDataGroup)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_EnchantmentResource(uiNode)
  self.itemDataGroup = itemDataGroup
end

function PvPTeamSelectGroupItem:OnBind(binder)
  self.binder = binder
  for _, itemData in ipairs(self.itemDataGroup) do
    binder:BindNewComponent(self.ui.Content, PvPTeamSelectItem, UI_Pvp_Item_FormationResource, itemData)
  end
end

return PvPTeamSelectGroupItem
