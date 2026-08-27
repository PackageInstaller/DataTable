local UINHeroAttrItem = class("UINHeroAttrItem", UIBaseNode)

function UINHeroAttrItem:OnInit()
  self.ui.tex_attrValue = self:FindComponent("Tex_AttriCount", eUnityComponentID.ExText)
  self.ui.texItem_attr = self:FindComponent("Tex_AttriName", eUnityComponentID.ExText)
  self.ui.imgItem_attr = self:FindComponent("Img_Icon", eUnityComponentID.Image)
  self.color_ori = self.ui.tex_attrValue.color
end

function UINHeroAttrItem:InitAttr(attrId, value, overriodColor)
  local attrCfg = ConfigData.attribute[attrId]
  if self.ui.imgItem_attr ~= nil and not IsNull(attrCfg.icon) then
    self.ui.imgItem_attr.sprite = CRH:GetSprite(attrCfg.icon)
  end
  self.ui.texItem_attr.text = LanguageUtil.GetLocaleText(attrCfg.name)
  self.ui.tex_attrValue.text = tostring(value)
  self.ui.tex_attrValue.color = overriodColor or self.color_ori
end

return UINHeroAttrItem
