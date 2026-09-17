local module = class("cellPetCatalogElementAttrItem", G_UIModuleBase)

function module.bind()
  return {
    toggleIsOn = false,
    imgColor = C_Color(1, 1, 1, 0.5),
    imgAttrIcon = "",
    txtAttrName = "",
    txtAttrValue = "",
    colorTxtName = C_Color(0.3098039, 0.3215686, 0.3647059, 1),
    colorTxtValue = C_Color(0.3098039, 0.3215686, 0.3647059, 1)
  }
end

function module:refresh()
  local tpl = L_GameTpl:getBattleInfoTpl():getTplById(self.bind.attrId)
  self.bind.toggleIsOn = self.bind.index % 2 == 1
  self.bind.txtAttrValue = tostring(self.bind.attrVal)
  self.bind.imgAttrIcon = L_GameTpl:getBattleInfoTpl():getIcon(tpl)
  local _, color = C_ColorUtility.TryParseHtmlString(self.bind.color_attrBg)
  self.bind.imgColor = color
  self.bind.txtAttrName = L_GameTpl:getBattleInfoTpl():getName(tpl)
end

return module
