local bs_10161 = class("bs_10161", LuaSkillBase)
local base = LuaSkillBase
bs_10161.config = {buffId = 1043}

function bs_10161:ctor()
end

function bs_10161:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_10161_5", 1, self.OnAfterHeal, self.caster)
end

function bs_10161:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if sender == self.caster and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[3] then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], self.arglist[2], true)
  end
end

function bs_10161:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10161
