local bs_15223 = class("bs_15223", LuaSkillBase)
local base = LuaSkillBase
bs_15223.config = {heal_resultId = 4}

function bs_15223:ctor()
end

function bs_15223:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_15223_3", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum)
end

function bs_15223:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == self.caster.belongNum and isMiss then
    self:PlayChipEffect()
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_resultId, {
      self.arglist[1]
    }, true)
    skillResult:EndResult()
  end
end

function bs_15223:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15223
