local bs_40020 = class("bs_40020", LuaSkillBase)
local base = LuaSkillBase
bs_40020.config = {
  buffId_1012 = 1211,
  attackdelay = 15,
  effectId = 10608
}

function bs_40020:ctor()
end

function bs_40020:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40020_1", 1, self.OnAfterBattleStart)
end

function bs_40020:OnAfterBattleStart()
  self.damTimer = LuaSkillCtrl:StartTimer(self, self.config.attackdelay, self.CallBack, self, -1)
end

function bs_40020:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  if self.caster.hp < self.caster.maxHp * self.arglist[1] // 1000 and self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1012, 1, nil, true)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
end

function bs_40020:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_40020
