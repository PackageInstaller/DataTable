local bs_15077 = class("bs_15077", LuaSkillBase)
local base = LuaSkillBase
bs_15077.config = {
  featureType = eBuffFeatureType.Stun
}

function bs_15077:ctor()
end

function bs_15077:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_15077_2", 1, self.OnSetHurt, self.caster)
end

function bs_15077:OnSetHurt(context)
  if context.sender == self.caster and not context.isMiss and LuaSkillCtrl:RoleContainsCtrlBuff(context.target) and context.skill.isCommonAttack then
    self:PlayChipEffect()
    if context.isCrit then
      context.hurt = (1000 + self.caster.critDamage + self.arglist[1]) * context.hurt // (1000 + self.caster.critDamage)
    else
      context.isCrit = true
      context.hurt = (1000 + self.caster.critDamage + self.arglist[1]) * context.hurt // 1000
    end
  end
end

function bs_15077:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15077
