local module = class("cellTalentSkillLevel", G_UIModuleBase)
local skillTpl = L_GameTpl:getSkillTpl()

function module.bind()
  return {
    skillIcon = "",
    skillNameText = "",
    slotName = "",
    beforeLevel = "",
    afterLevel = ""
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
  self.bind.beforeLevel = tostring(1)
  self.bind.afterLevel = tostring(self.bind.addLevel + 1)
  local tpl = skillTpl:getTplById(self.bind.skillId)
  self.bind.skillNameText = skillTpl:getName(tpl)
  self.bind.slotName = L_WordsTpl:getValue("talent_page_skill_type_" .. self.bind.index)
  self.bind.skillIcon = skillTpl:getIcon(tpl)
end

return module
