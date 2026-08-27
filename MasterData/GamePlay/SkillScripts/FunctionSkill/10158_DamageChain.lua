local bs_10158 = class("bs_10158", LuaSkillBase)
local base = LuaSkillBase
bs_10158.config = {effectId = 10258, effectDamageId = 10259}

function bs_10158:ctor()
end

function bs_10158:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10158_3", 1, self.OnAfterHurt, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10158_11", 1, self.OnBeforePlaySkill)
  self.caster.recordTable["10158_AfterSkillCast"] = false
end

function bs_10158:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and not skill.isCommonAttack and self.caster.recordTable["10158_AfterSkillCast"] and not isTriggerSet and self.effect == nil then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 20, 10, target)
    if targetlist.Count > 0 then
      self.effect = LuaSkillCtrl:CallEffect(targetlist[0].targetRole, self.config.effectId, self, nil, target)
      self.caster.recordTable["10158_target1"] = target
      self.caster.recordTable["10158_target2"] = targetlist[0].targetRole
    end
    if self.damTimer == nil and self.arglist[1] ~= nil then
      self.damTimer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], self.CallBack, self, 1)
    end
    self.caster.recordTable["10158_AfterSkillCast"] = false
  end
  if self.effect ~= nil and sender == self.caster and target == self.caster.recordTable["10158_target1"] and self.caster.recordTable["10158_target2"] ~= nil then
    local damage = math.max(1, hurt * self.arglist[2] // 1000)
    LuaSkillCtrl:RemoveLife(damage, self, self.caster.recordTable["10158_target2"], true, nil, true, false, eHurtType.RealDmg)
    LuaSkillCtrl:CallEffect(self.caster.recordTable["10158_target2"], self.config.effectDamageId, self)
    LuaSkillCtrl:CallEffect(target, self.config.effectDamageId, self)
  end
  if hurt >= target.hp and self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_10158:OnBeforePlaySkill(role, context)
  if self.caster.recordTable["104502_active"] == false then
    return
  end
  if context.skill.maker == self.caster and not context.skill.isCommonAttack then
    self.caster.recordTable["10158_AfterSkillCast"] = true
  end
end

function bs_10158:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  self.caster.recordTable["10158_target1"] = nil
  self.caster.recordTable["10158_target2"] = nil
end

function bs_10158:OnCasterDie()
  base.OnCasterDie(self)
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
end

function bs_10158:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_10158
