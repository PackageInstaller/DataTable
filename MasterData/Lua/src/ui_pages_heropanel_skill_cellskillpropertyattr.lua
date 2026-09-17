local module = class("cellSkillPropertyAttr", G_UIModuleBase)

function module.bind()
  return {
    isShowSelf = false,
    propertyNameTxt = "",
    attrList = {
      moduleName = "pages/HeroPanel/skill/cellSkillAttr"
    }
  }
end

function module:initModule(tplSkill)
  if tplSkill == nil then
    return
  end
  local skillTpl = L_GameTpl:getSkillTpl()
  local elementTypeTpl = L_GameTpl:getElementTypeTpl()
  local elementList = skillTpl:getSkillElement(tplSkill)
  self.bind.propertyNameTxt = L_WordsTpl:getValue("notice_hero_skillAttrList"), self.bind.attrList:clear()
  local showSelf = false
  for _, v in ipairs(elementList) do
    if v ~= L_Const.skillElementType.none then
      local tpl = elementTypeTpl:getTplById(v)
      self.bind.attrList:insert({
        attrIcon = elementTypeTpl:getSkillElem(tpl)
      })
      showSelf = showSelf or true
    end
  end
  self.bind.isShowSelf = showSelf
end

return module
