local bs_15090 = class("bs_15090", LuaSkillBase)
local base = LuaSkillBase
bs_15090.config = {buffId = 110085}

function bs_15090:ctor()
end

function bs_15090:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_15090_3", 1, self.OnHurtResultStart)
  self:AddSetHurtTrigger("bs_15090_2", 1, self.OnSetHurt, self.caster)
end

function bs_15090:OnHurtResultStart(skill, context)
  if context.sender == self.caster and LuaSkillCtrl:RoleContainsBuffFeature(context.target, eBuffFeatureType.Stun) then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_15090:OnSetHurt(context)
  if context.sender == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_15090:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15090
