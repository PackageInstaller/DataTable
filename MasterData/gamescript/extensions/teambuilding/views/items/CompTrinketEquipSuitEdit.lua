local CompTrinketEquipSuitEdit, Super = NewViewComponent("CompTrinketEquipSuitEdit")

function CompTrinketEquipSuitEdit:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Panel_Trinket_EquipResource(uiNode)
end

function CompTrinketEquipSuitEdit:OnEnterComponent()
  self:_InitTrinketList()
end

function CompTrinketEquipSuitEdit:_InitTrinketList()
  local compTrinketEquipListData = {
    page = CommonDefine.TrinketEquipViewType.SuitEdit
  }
  self:AddViewComponentOnce(self.ui.UI_Team_Item_Suit_Bookmark, CompTrinketEquipList, compTrinketEquipListData)
end

function CompTrinketEquipSuitEdit:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompTrinketEquipSuitEdit
