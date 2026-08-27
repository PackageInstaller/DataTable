local base = UIBaseNode
local UINBondDetailsItem = class("UINBondDetailsItem", base)

function UINBondDetailsItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBondDetailsItem:InitBondDetailItem(bondCfg, resloader)
  self.__bondCfg = bondCfg
  self.ui.Tex_Name.text = LanguageUtil.GetLocaleText(self.__bondCfg.bond_name)
  self.ui.Tex_Des.text = LanguageUtil.GetLocaleText(self.__bondCfg.bond_des)
  local iconName = self.__bondCfg.bond_icon
  self.ui.Img_IconPic.sprite = AtlasUtil.GetSpriteFromAtlas("BondIcon", iconName, resloader)
end

function UINBondDetailsItem:OnDelete()
  base.OnDelete(self)
end

return UINBondDetailsItem
