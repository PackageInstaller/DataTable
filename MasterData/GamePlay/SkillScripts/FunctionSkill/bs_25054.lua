local bs_25054 = class("bs_25054", LuaSkillBase)
local base = LuaSkillBase
bs_25054.config = {heal_resultId = 4}

function bs_25054:ctor()
end

function bs_25054:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_25054_3", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum)
end

function bs_25054:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == self.caster.belongNum and isMiss then
    self:PlayChipEffect()
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_resultId, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
end

function bs_25054:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25054
