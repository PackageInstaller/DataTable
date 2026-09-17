local module = class("cellSkillLevelItem", G_UIModuleBase)
local skillTpl = L_GameTpl:getSkillTpl()

function module.bind()
  return {
    skillIcon = "",
    desc = "",
    beforeLevel = "",
    curLevel = ""
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
  local tpl = skillTpl:getTplById(self.bind.skillId)
  self.bind.skillIcon = skillTpl:getIcon(tpl)
  self.bind.desc = L_WordsTpl:getValue("ui_hero_rune_skill_up")
end

return module
