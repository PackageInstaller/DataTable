local bs_10015 = class("bs_10015", LuaSkillBase)
local base = LuaSkillBase
bs_10015.config = {
  buffId = 68,
  buffId1 = 1064,
  effectId1 = 10166,
  effectId2 = 10167,
  effectId3 = 10168,
  buffTierFormula = 10036
}

function bs_10015:ctor()
end

function bs_10015:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10015_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_10015_3", 1, self.OnAfterHurt, nil, self.caster)
  self:AddAfterHealTrigger("bs_10015_5", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_10015:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil, true)
    end
    if buffTier > self.arglist[1] // 2 then
      LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.2, 1.2, 1.2), 0.2)
      if self.effect == nil then
        self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self, self.SkillEventFunc)
      end
      if self.effect1 ~= nil then
        self.effect1:Die()
        self.effect1 = nil
      end
      if self.effect2 ~= nil then
        self.effect2:Die()
        self.effect2 = nil
      end
    elseif buffTier > self.arglist[1] // 4 then
      LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.1, 1.1, 1.1), 0.2)
      if self.effect1 == nil then
        self.effect1 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self, self.SkillEventFunc)
      end
      if self.effect ~= nil then
        self.effect:Die()
        self.effect = nil
      end
      if self.effect2 ~= nil then
        self.effect2:Die()
        self.effect2 = nil
      end
    else
      LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1, 1, 1), 0.2)
      if self.effect2 == nil then
        self.effect2 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, self.SkillEventFunc)
      end
      if self.effect ~= nil then
        self.effect:Die()
        self.effect = nil
      end
      if self.effect1 ~= nil then
        self.effect1:Die()
        self.effect1 = nil
      end
    end
  end
end

function bs_10015:OnAfterBattleStart()
  local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier)
  if buffTier > self.arglist[1] // 2 then
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.2, 1.2, 1.2), 0.2)
    if self.effect == nil then
      self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self, self.SkillEventFunc)
    end
    if self.effect1 ~= nil then
      self.effect1:Die()
      self.effect1 = nil
    end
    if self.effect2 ~= nil then
      self.effect2:Die()
      self.effect2 = nil
    end
  elseif buffTier > self.arglist[1] // 4 then
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.1, 1.1, 1.1), 0.2)
    if self.effect1 == nil then
      self.effect1 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self, self.SkillEventFunc)
    end
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    if self.effect2 ~= nil then
      self.effect2:Die()
      self.effect2 = nil
    end
  else
    LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1, 1, 1), 0.2)
    if self.effect2 == nil then
      self.effect2 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, self.SkillEventFunc)
    end
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    if self.effect1 ~= nil then
      self.effect1:Die()
      self.effect1 = nil
    end
  end
end

function bs_10015:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.buffTierFormula, self.caster, self.caster, self)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier)
    end
    if buffTier < self.arglist[1] // 4 then
      LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1, 1, 1), 0.2)
      if self.effect2 == nil then
        self.effect2 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, self.SkillEventFunc)
      end
      if self.effect ~= nil then
        self.effect:Die()
        self.effect = nil
      end
      if self.effect1 ~= nil then
        self.effect1:Die()
        self.effect1 = nil
      end
    elseif buffTier < self.arglist[1] // 2 then
      LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.1, 1.1, 1.1), 0.2)
      if self.effect1 == nil then
        self.effect1 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self, self.SkillEventFunc)
      end
      if self.effect ~= nil then
        self.effect:Die()
        self.effect = nil
      end
      if self.effect2 ~= nil then
        self.effect2:Die()
        self.effect2 = nil
      end
    else
      LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.2, 1.2, 1.2), 0.2)
      if self.effect == nil then
        self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self, self.SkillEventFunc)
      end
      if self.effect1 ~= nil then
        self.effect1:Die()
        self.effect1 = nil
      end
      if self.effect2 ~= nil then
        self.effect2:Die()
        self.effect2 = nil
      end
    end
  end
end

function bs_10015:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_10015:LuaDispose()
  self.effect = nil
  self.effect1 = nil
  self.effect2 = nil
  base.LuaDispose(self)
end

return bs_10015
