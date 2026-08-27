local bs_93024 = class("bs_93024", LuaSkillBase)
local base = LuaSkillBase
bs_93024.config = {
  Delay = 150,
  buffIdUp = 2064,
  buffIdDown = 2063
}

function bs_93024:ctor()
end

function bs_93024:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_93024_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.HurtResultEnd, "bs_93024_3", 3, self.OnHurtResultEnd)
end

function bs_93024:OnAfterBattleStart()
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdUp, self.arglist[1], nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdDown, self.arglist[2], nil, true)
end

function bs_93024:OnHurtResultEnd(skill, targetRole, hurtValue)
  local buffTier = targetRole:GetBuffTier(self.config.buffIdUp)
  local buffTier1 = targetRole:GetBuffTier(self.config.buffIdDown)
  if 0 < hurtValue and targetRole == self.caster and 0 < buffTier and 0 < buffTier1 then
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffIdUp, 0, true)
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffIdDown, 0, true)
    local callBack = BindCallback(self, self.CallBack)
    self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[3], callBack, self, 0)
  end
end

function bs_93024:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdUp, self.arglist[1], nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffIdDown, self.arglist[2], nil, true)
end

function bs_93024:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

return bs_93024
