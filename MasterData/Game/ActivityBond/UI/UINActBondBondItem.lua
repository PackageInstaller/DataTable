local base = UIBaseNode
local UINActBondBondItem = class("UINActBondBondItem", base)

function UINActBondBondItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActBondBondItem:InitBondActBondItem(bondCfg, resloader)
  self.bondCfg = bondCfg
  local iconName = self.bondCfg.bond_icon
  self.ui.img_Pic.sprite = AtlasUtil.GetSpriteFromAtlas("BondIcon", iconName, resloader)
end

function UINActBondBondItem:OnDelete()
  base.OnDelete(self)
end

return UINActBondBondItem
