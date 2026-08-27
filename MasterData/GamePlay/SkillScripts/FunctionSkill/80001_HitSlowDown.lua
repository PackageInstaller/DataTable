local bs_80001 = class("bs_80001", LuaSkillBase)
local base = LuaSkillBase
bs_80001.config = {buffId = 1236}

function bs_80001:ctor()
end

function bs_80001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_80001_3", 1, self.OnAfterHurt, self.caster)
end

function bs_80001:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isTriggerSet and target.hp >= 0 and not isMiss then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.arglist[2], true)
  end
end

function bs_80001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_80001
