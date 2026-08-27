local bs_21023 = class("bs_21023", LuaSkillBase)
local base = LuaSkillBase
bs_21023.config = {
  buffId = 110018,
  effectId1 = 10947,
  effectId2 = 10948
}

function bs_21023:ctor()
end

function bs_21023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_21023_2", 1, self.OnBeforePlaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_21023_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_21023_3", 1, self.OnAfterHurt, self.caster)
  self:AddAfterHealTrigger("bs_21023_4", 1, self.OnAfterHeal, self.caster)
  self.Num = 0
  self.effectNum = 0
end

function bs_21023:OnAfterBattleStart()
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
end

function bs_21023:OnBeforePlaySkill(role, context)
  if role == self.caster and self.Num == 0 and context.skill.skillTag == eSkillTag.normalSkill then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil)
    self.Num = 1
  elseif self.Num == 1 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    self.effectNum = 1
  end
end

function bs_21023:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isNormalSkill and self.effectNum == 0 and self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_21023:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if sender == self.caster and skill.isNormalSkill and self.effectNum == 0 and self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_21023:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_21023:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_21023
