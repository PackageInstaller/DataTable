local TrinketEquipViewType = CommonDefine.TrinketEquipViewType
local CompTrinketEquipSuitSelect, Super = NewViewComponent("CompTrinketEquipSuitSelect")

function CompTrinketEquipSuitSelect:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Panel_Trinket_EquipResource(uiNode)
end

function CompTrinketEquipSuitSelect:OnEnterComponent()
  self:_InitTrinketList()
end

function CompTrinketEquipSuitSelect:_InitTrinketList()
  local compTrinketEquipListData = {
    page = TrinketEquipViewType.SuitSelect
  }
  self:AddViewComponentOnce(self.ui.UI_Team_Item_Suit_Bookmark, CompTrinketEquipList, compTrinketEquipListData)
end

function CompTrinketEquipSuitSelect:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompTrinketEquipSuitSelect
