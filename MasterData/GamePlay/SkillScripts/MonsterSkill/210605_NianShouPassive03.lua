local bs_210605 = class("bs_210605", LuaSkillBase)
local base = LuaSkillBase
bs_210605.config = {
  buffId_Boss = 3017,
  buffId_critcore = 210602,
  buffId_nocritcore = 210603,
  effectId_critcore_1 = 210609,
  effectId_critcore_2 = 210610,
  effectId_critcore_3 = 210611
}

function bs_210605:ctor()
end

function bs_210605:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_210605_2", 1, self.OnAfterHurt, nil, self.caster)
  self.crit_times = 0
  self.effect = nil
  self:AddAfterAddBuffTrigger("bs_210605_3", 1, self.OnAfterAddBuff, self.caster, self.caster, nil, nil, self.config.buffId_critcore)
  self:AddBeforeBuffDispelTrigger("bs_210605_4", 1, self.OnBeforBuffDispel, self.caster, nil, self.config.buffId_critcore)
  self:AddBeforeAddBuffTrigger("bs_210605_5", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, self.config.buffId_critcore)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_210605_7", 1, self.BeforeEndBattle)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_critcore, 1, nil)
  self.Addcrit_times = LuaSkillCtrl:StartTimer(nil, self.arglist[2], BindCallback(self, self.Addcrit_times), nil, -1, 0)
end

function bs_210605:Addcrit_times()
  if self.crit_times > 0 then
    self.crit_times = self.crit_times - 1
    self:ShowAttackCounting(self.crit_times)
  end
end

function bs_210605:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and 0 < hurt and isCrit and 0 < self.caster:GetBuffTier(self.config.buffId_critcore) then
    self.crit_times = self.crit_times + 1
    if self.crit_times == 10 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_critcore, 1)
      self.crit_times = 0
    end
    self:ShowAttackCounting(self.crit_times)
  end
end

function bs_210605:OnAfterAddBuff(buff, target)
  if target:GetBuffTier(self.config.buffId_nocritcore) > 0 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_nocritcore, 1)
  end
  local buffnum = target:GetBuffTier(self.config.buffId_critcore)
  if buffnum == 1 then
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_critcore_1, self)
  elseif buffnum == 2 then
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_critcore_2, self)
  elseif buffnum == 3 then
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_critcore_3, self)
  end
end

function bs_210605:OnBeforBuffDispel(target, context)
  local buffnum = target:GetBuffTier(self.config.buffId_critcore)
  if buffnum == 3 then
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_critcore_2, self)
  elseif buffnum == 2 then
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_critcore_1, self)
  elseif buffnum == 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_nocritcore, 1, nil)
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    self.crit_times = 0
    self:ShowAttackCounting(self.crit_times)
  end
end

function bs_210605:OnBeforeAddBuff(target, context)
  local buffnum = target:GetBuffTier(self.config.buffId_critcore)
  if 2 <= buffnum then
    self.crit_times = 0
    self:ShowAttackCounting(self.crit_times)
  end
end

function bs_210605:ShowAttackCounting(Count)
  if LuaSkillCtrl.IsInVerify then
    return
  end
  if Count == 0 then
    LuaSkillCtrl:HideCounting(self.caster)
    return
  end
  LuaSkillCtrl:ShowCounting(self.caster, Count, 10)
end

function bs_210605:BeforeEndBattle()
  self:ShowAttackCounting(0)
  LuaSkillCtrl:HideCounting(self.caster)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.Addcrit_times ~= nil then
    self.Addcrit_times:Stop()
    self.Addcrit_times = nil
  end
end

function bs_210605:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:HideCounting(self.caster)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.Addcrit_times ~= nil then
    self.Addcrit_times:Stop()
    self.Addcrit_times = nil
  end
end

function bs_210605:LuaDispose()
  base.LuaDispose(self)
end

return bs_210605
