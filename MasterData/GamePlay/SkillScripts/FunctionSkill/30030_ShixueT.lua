local bs_30030 = class("bs_30030", LuaSkillBase)
local base = LuaSkillBase
bs_30030.config = {buffId_shixue = 257, buffTier = 1}

function bs_30030:ctor()
end

function bs_30030:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30030_1", 1, self.OnAfterBattleStart)
end

function bs_30030:OnAfterBattleStart()
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.Callback, self, -1)
end

function bs_30030:Callback()
  self:PlayChipEffect()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_shixue, self.config.buffTier)
end

function bs_30030:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_30030
