local module = class("cellBreakSuccessSkill", G_UIModuleBase)

function module.bind()
  return {skillName = ""}
end

function module.methods()
  return {
    onclick_openSkillInfo = function(self)
      local hero = L_HeroStore:getHero(self.bind.heroId)
      L_UI:open("pageSkillInfo", {
        hero = hero,
        skillId = self.bind.skillId
      })
    end
  }
end

function module:refresh()
  local skillTpl = L_GameTpl:getSkillTpl()
  local tpl = skillTpl:getTplById(self.bind.skillId)
  self.bind.skillName = skillTpl:getName(tpl)
end

return module
