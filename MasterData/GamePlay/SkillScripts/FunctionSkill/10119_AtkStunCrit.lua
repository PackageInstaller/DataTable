local bs_10119 = class("bs_10119", LuaSkillBase)
local base = LuaSkillBase
bs_10119.config = {
  featureType = eBuffFeatureType.Stun
}

function bs_10119:ctor()
end

function bs_10119:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10119_2", 1, self.OnSetHurt, self.caster)
end

function bs_10119:OnSetHurt(context)
  if context.sender == self.caster and not context.isMiss and LuaSkillCtrl:RoleContainsCtrlBuff(context.target) then
    self:PlayChipEffect()
    if context.isCrit then
      context.hurt = (1000 + self.caster.critDamage + self.arglist[1]) * context.hurt // (1000 + self.caster.critDamage)
    else
      context.isCrit = true
      context.hurt = (1000 + self.caster.critDamage + self.arglist[1]) * context.hurt // 1000
    end
  end
end

function bs_10119:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10119
