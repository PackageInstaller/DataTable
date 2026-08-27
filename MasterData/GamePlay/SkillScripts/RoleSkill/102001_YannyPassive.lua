local bs_102001 = class("bs_102001", LuaSkillBase)
local base = LuaSkillBase
bs_102001.config = {buffId = 102001, healBuffId = 102002}

function bs_102001:ctor()
end

function bs_102001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102001_1", 1, self.OnAfterBattleStart)
  self:AddSetHealTrigger("bs_102001_2", 99, self.OnSetHeal, nil, self.caster)
end

function bs_102001:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
end

function bs_102001:OnSetHeal(context)
  if context.target == self.caster and context.isTriggerSet ~= true then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.healBuffId, 1, self.arglist[3])
  end
end

function bs_102001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102001
