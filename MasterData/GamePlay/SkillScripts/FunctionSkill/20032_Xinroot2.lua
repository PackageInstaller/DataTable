local bs_20032 = class("bs_20032", LuaSkillBase)
local base = LuaSkillBase
bs_20032.config = {
  buffId = 1039,
  buffTier = 1,
  damageBuffId = 1075,
  effectId1 = 91,
  effectId2 = 10339,
  effectId3 = 10340,
  healFormula = 10098,
  healEffectId = 10286
}

function bs_20032:ctor()
end

function bs_20032:InitSkill(isMidwaySkill)
  self.caster.recordTable["20032_effectFlag"] = true
  self.time = 0
  base.InitSkill(self, isMidwaySkill)
  if self.caster.roleDataId ~= 30000 then
    return
  end
  self:AddAfterHurtTrigger("bs_20032_1", 1, self.OnAfterHurt, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_20032_2", 1, self.OnAfterBattleStart)
end

function bs_20032:OnAfterBattleStart()
  if self.caster.hp * 1000 // self.caster.maxHp <= self.arglist[1] and self:IsReadyToTake() and self.time == 0 then
    if self.caster.recordTable["20032_effectFlag"] then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.healEffectId, self)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.damageBuffId, self.config.buffTier)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier)
    local healNum = math.max(LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.healFormula, self.caster, self.caster, self), 1)
    LuaSkillCtrl:CallHeal(healNum, self, self.caster)
    self.caster.recordTable["20032_effectFlag"] = false
    self.time = 1
    self:OnSkillTake()
  end
end

function bs_20032:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and self.caster.hp * 1000 // self.caster.maxHp <= self.arglist[1] and self:IsReadyToTake() and self.time == 0 then
    if self.caster.recordTable["20032_effectFlag"] then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId3, self)
      LuaSkillCtrl:CallEffect(self.caster, self.config.healEffectId, self)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.damageBuffId, self.config.buffTier, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
    local healNum = math.max(LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.healFormula, self.caster, self.caster, self), 1)
    LuaSkillCtrl:CallHeal(healNum, self, self.caster, true)
    self.caster.recordTable["20032_effectFlag"] = false
    self.time = 1
    self:OnSkillTake()
  end
end

function bs_20032:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20032
