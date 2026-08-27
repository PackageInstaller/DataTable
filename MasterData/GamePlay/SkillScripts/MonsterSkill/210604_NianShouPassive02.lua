local bs_210604 = class("bs_210604", LuaSkillBase)
local base = LuaSkillBase
bs_210604.config = {
  buffId_Boss = 3017,
  buffId_critcore = 210602,
  buffId_nocritcore = 210603,
  effectId_critcore_1 = 210609,
  effectId_critcore_2 = 210610,
  effectId_critcore_3 = 210611,
  buffId_xxx = 210605
}

function bs_210604:ctor()
end

function bs_210604:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_210604_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_210604_2", 1, self.OnAfterHurt, nil, self.caster)
  self.crit_times = 0
  self.effect = nil
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_210604_6", 1, self.BeforeEndBattle)
  self:AddAfterAddBuffTrigger("bs_210604_3", 1, self.OnAfterAddBuff, self.caster, self.caster, nil, nil, self.config.buffId_critcore)
  self:AddBeforeBuffDispelTrigger("bs_210604_4", 1, self.OnBeforBuffDispel, self.caster, nil, self.config.buffId_critcore)
  self:AddBeforeAddBuffTrigger("bs_210604_5", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, self.config.buffId_critcore)
end

function bs_210604:OnAfterBattleStart()
  local breakComponent = self.caster:GetBreakComponent()
  if breakComponent == nil then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Boss, 1, nil, true)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_critcore, 3, nil)
  self.Addcrit_timer = LuaSkillCtrl:StartTimer(nil, self.arglist[2], BindCallback(self, self.Addcrit_times), nil, -1, 0)
end

function bs_210604:Addcrit_times()
  if self.crit_times > 0 then
    self.crit_times = self.crit_times - 1
    self:ShowAttackCounting(self.crit_times)
  end
end

function bs_210604:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and 0 < hurt and isCrit and 0 < self.caster:GetBuffTier(self.config.buffId_critcore) then
    self.crit_times = self.crit_times + 1
    if self.crit_times == 10 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_critcore, 1)
      self.crit_times = 0
    end
    self:ShowAttackCounting(self.crit_times)
  end
end

function bs_210604:OnAfterAddBuff(buff, target)
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

function bs_210604:OnBeforBuffDispel(target, context)
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

function bs_210604:OnBeforeAddBuff(target, context)
  local buffnum = target:GetBuffTier(self.config.buffId_critcore)
  if 3 <= buffnum then
    self.crit_times = 0
    self:ShowAttackCounting(self.crit_times)
  end
end

function bs_210604:ShowAttackCounting(Count)
  if LuaSkillCtrl.IsInVerify then
    return
  end
  if Count == 0 then
    LuaSkillCtrl:HideCounting(self.caster)
    return
  end
  LuaSkillCtrl:ShowCounting(self.caster, Count, 10)
end

function bs_210604:BeforeEndBattle()
  self:ShowAttackCounting(0)
end

function bs_210604:OnCasterDie()
  base.OnCasterDie(self)
  self:ShowAttackCounting(0)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.Addcrit_timer ~= nil then
    self.Addcrit_timer:Stop()
    self.Addcrit_timer = nil
  end
end

function bs_210604:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_210604
