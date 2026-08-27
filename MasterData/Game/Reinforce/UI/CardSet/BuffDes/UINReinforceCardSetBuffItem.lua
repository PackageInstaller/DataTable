local base = UIBaseNode
local UINReinforceCardSetBuffItem = class("UINReinforceCardSetBuffItem", base)

function UINReinforceCardSetBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINReinforceCardSetBuffItem:InitReinforceCSDNBuffItem(dynBuffData)
  self.ui.Tex_TitleName.text = dynBuffData:GetEpBuffName()
  self.ui.Tex_Des.text = dynBuffData:GetEpBuffDescribe()
  self.ui.Img_ProtocolPic.sprite = dynBuffData:GetEpBuffIcon()
end

function UINReinforceCardSetBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINReinforceCardSetBuffItem
