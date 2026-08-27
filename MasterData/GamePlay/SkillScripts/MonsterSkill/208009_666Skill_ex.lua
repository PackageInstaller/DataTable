local bs_208009 = class("bs_208009", LuaSkillBase)
local base = LuaSkillBase
bs_208009.config = {buffId_passive = 208001}

function bs_208009:ctor()
end

function bs_208009:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_208009_1", 1, self.OnAfterHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.OnAfterShieldHurt, "bs_208009_13", 1, self.OnAfterShieldHurt)
end

function bs_208009:OnAfterShieldHurt(context)
  if context.target ~= nil and context.target.hp > 0 and context.target == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_passive, 1)
  end
end

function bs_208009:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target ~= nil and target.hp > 0 and target == self.caster and 0 < hurt then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_passive, 1)
  end
end

function bs_208009:PlaySkill(data)
end

function bs_208009:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_208009
