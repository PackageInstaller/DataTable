local bs_10144 = class("bs_10144", LuaSkillBase)
local base = LuaSkillBase
bs_10144.config = {
  buffId = 1121,
  buffTier = 1,
  effectId = 10250,
  buffId2 = 1120
}

function bs_10144:ctor()
end

function bs_10144:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10144_3", 2, self.OnAfterHurt)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10144_1", 1, self.OnBeforePlaySkill)
  self.caster.recordTable["10144_atkNum"] = 0
  self.caster.recordTable["10144_atkFlag"] = false
end

function bs_10144:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] and self:IsReadyToTake() then
    self:PlayChipEffect()
    self.caster.recordTable["10144_atkFlag"] = true
    self:OnSkillTake()
  end
  if sender == self.caster and skill.isCommonAttack then
    self.caster.recordTable["10144_atkNum"] = self.caster.recordTable["10144_atkNum"] - 1
    if self.caster.recordTable["10144_atkNum"] <= 0 then
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

function bs_10144:OnBeforePlaySkill(role, context)
  if context.skill.maker == self.caster and context.skill.isCommonAttack and self.caster.recordTable["10144_atkFlag"] then
    self.caster.recordTable["10144_atkFlag"] = false
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    self.effect = LuaSkillCtrl:CallEffect(context.skill.maker, self.config.effectId, self)
    self.caster.recordTable["10144_atkNum"] = 2
  end
end

function bs_10144:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_10144:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_10144
