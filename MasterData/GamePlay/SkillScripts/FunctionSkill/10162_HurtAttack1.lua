local bs_10162 = class("bs_10162", LuaSkillBase)
local base = LuaSkillBase
bs_10162.config = {
  buffId = 1121,
  buffTier = 1,
  effectId = 10250
}

function bs_10162:ctor()
end

function bs_10162:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10162_3", 2, self.OnAfterHurt)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10162_1", 1, self.OnBeforePlaySkill)
  self.caster.recordTable["10162_atkNum"] = 0
  self.caster.recordTable["10162_atkFlag"] = false
  self.caster.recordTable["10162_DamageNum"] = 0
end

function bs_10162:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] * 2 + self.caster.recordTable["10162_DamageNum"] and self:IsReadyToTake() then
    self:PlayChipEffect()
    self.caster.recordTable["10162_atkFlag"] = true
    self.caster.recordTable["10162_DamageNum"] = 0
    self:OnSkillTake()
  else
    self.caster.recordTable["10162_DamageNum"] = self.caster.recordTable["10162_DamageNum"] + 50
  end
  if target ~= self.caster and target.belongNum == self.caster.belongNum and not isMiss and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] + self.caster.recordTable["10162_DamageNum"] and self:IsReadyToTake() then
    self:PlayChipEffect()
    self.caster.recordTable["10162_atkFlag"] = true
    self.caster.recordTable["10162_DamageNum"] = 0
    self:OnSkillTake()
  else
    self.caster.recordTable["10162_DamageNum"] = self.caster.recordTable["10162_DamageNum"] + 50
  end
  if sender == self.caster and skill.isCommonAttack then
    self.caster.recordTable["10162_atkNum"] = 0
    if 0 >= self.caster.recordTable["10162_atkNum"] then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
      if self.effect ~= nil then
        self.effect:Die()
        self.effect = nil
      end
    end
    if hurt >= target.hp and self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
  end
end

function bs_10162:OnBeforePlaySkill(role, context)
  if context.skill.maker == self.caster and context.skill.isCommonAttack and self.caster.recordTable["10162_atkFlag"] then
    self.caster.recordTable["10162_atkFlag"] = false
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    self.effect = LuaSkillCtrl:CallEffect(context.skill.maker, self.config.effectId, self)
    self.caster.recordTable["10162_atkNum"] = 2
  end
end

function bs_10162:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_10162:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_10162
