local module = class("cellBreakSkill", G_UIModuleBase)

function module.bind()
  return {
    bgActive = true,
    skillName = "",
    skillGetText = ""
  }
end

function module.methods()
  return {}
end

function module:refresh()
  local skillTpl = L_GameTpl:getSkillTpl()
  local tpl = skillTpl:getTplById(self.bind.skillId)
  self.bind.skillName = skillTpl:getName(tpl)
  self.bind.skillGetText = L_WordsTpl:getTplById("ui_heroRank_skill")
end

return module
