local base = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINAttrOutLineRowItem = class("UINAttrOutLineRowItem", base)

function UINAttrOutLineRowItem:OnInit()
  base.OnInit(self)
end

function UINAttrOutLineRowItem:InitAttrOutLineRowItem(nameStr, iconSprite, attr, attrExtra, isRecommend)
  self.ui.attrIcon.sprite = iconSprite
  self.ui.tex_Name.text = nameStr
  self.ui.tex_Attri.text = attr
  if string.IsNullOrEmpty(attrExtra) then
    self.ui.tex_AttriExtra.text.text = ""
  else
    self.ui.tex_AttriExtra:SetIndex(0, attrExtra)
  end
  self.ui.obj_Recommend:SetActive(isRecommend)
end

function UINAttrOutLineRowItem:OnDelete()
  base.OnDelete(self)
end

return UINAttrOutLineRowItem
