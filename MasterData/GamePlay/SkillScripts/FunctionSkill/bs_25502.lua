local bs_25502 = class("bs_25502", LuaSkillBase)
local base = LuaSkillBase
bs_25502.config = {buffId = 110163}

function bs_25502:ctor()
end

function bs_25502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_25502_1", 1, self.OnAfterBattleStart)
  self:AddAfterHealTrigger("bs_25502_2", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_25502:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[2], nil, true)
  end, nil, -1)
end

function bs_25502:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if self.caster:GetBuffTier(self.config.buffId) ~= nil then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, self.arglist[4], true)
  end
end

function bs_25502:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_25502
