local bs_1041022 = class("bs_1041022", LuaSkillBase)
local base = LuaSkillBase
bs_1041022.config = {
  start_time = 22,
  end_time = 20,
  actionId = 1008,
  actionId_end = 1009,
  action_speed = 1,
  radius = 50,
  speed = 5,
  buffId_196 = 19601,
  buffId_170 = 170,
  effectId_line = 104108,
  effectId_trail = 104110,
  effectId_hit = 104109,
  effectId_skill1 = 104114,
  effectId_skill2 = 104115,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  }
}

function bs_1041022:ctor()
end

function bs_1041022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_1041022_11", 1, self.OnRoleDie)
  self.caster.recordTable["skill_arglist[1]"] = 0
  self.open = false
end

function bs_1041022:PlaySkill(data)
  local target = self.caster.recordTable.pass_target
  if target ~= nil and LuaSkillCtrl.IsInTDBattle and target.x == ConfigData.buildinConfig.BenchX then
    return
  end
  if target ~= nil and target.hp > 0 then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.start_time + self.arglist[4])
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.config.start_time + self.arglist[4], true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, self.config.start_time + self.arglist[4], true)
  end
end

function bs_1041022:OnAttackTrigger(target)
  if target ~= nil and target.hp > 0 then
    self.open = true
    LuaSkillCtrl:CallRoleAction(self.caster, 1007)
    LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[4])
    self.caster.recordTable["skill_arglist[1]"] = self.arglist[1]
    local num = self.arglist[4] // self.arglist[2] - 1
    local skill_hurt = BindCallback(self, self.onSkillHurt, target)
    local onOver = BindCallback(self, self.OnOver)
    self.loopLine = LuaSkillCtrl:CallEffect(target, self.config.effectId_line, self, nil, nil, nil, true)
    self.loop_skill1 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skill1, self, nil, nil, nil, true)
    self.loop_skill2 = LuaSkillCtrl:CallEffect(target, self.config.effectId_skill2, self, nil, nil, nil, true)
    self.hurt_timer = LuaSkillCtrl:StartTimer(self, self.arglist[2], skill_hurt, self, num, self.arglist[2] - 1)
    LuaSkillCtrl:StartTimer(self, self.arglist[4], onOver, self)
  end
end

function bs_1041022:onSkillHurt(target)
  if target ~= nil and LuaSkillCtrl.IsInTDBattle and target.x == ConfigData.buildinConfig.BenchX then
    self:OnOver()
    return
  end
  if target ~= nil and target.hp > 0 then
    local cusEffect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_trail, self)
    cusEffect.lsObject.localPosition = self.caster.lsObject.localPosition
    local collisionTrigger = BindCallback(self, self.OnCollision)
    LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, self.config.radius, self.config.speed, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, false, true, nil)
  end
end

function bs_1041022:OnCollision(collider, index, entity)
  if LuaSkillCtrl:IsFixedObstacle(entity) then
    return
  end
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_hit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
    self.arglist[3]
  })
  skillResult:EndResult()
end

function bs_1041022:OnOver()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 0, true)
  if self.open == false then
    return
  end
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  self.caster.recordTable["skill_arglist[1]"] = 0
  self:CancleCasterWait()
  self:CallCasterWait(self.config.end_time)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
  if self.loopLine ~= nil then
    self.loopLine:Die()
    self.loopLine = nil
  end
  if self.loop_skill1 ~= nil then
    self.loop_skill1:Die()
    self.loop_skill1 = nil
  end
  if self.loop_skill2 ~= nil then
    self.loop_skill2:Die()
    self.loop_skill2 = nil
  end
  if self.hurt_timer ~= nil then
    self.hurt_timer:Stop()
    self.hurt_timer = nil
  end
  self.open = false
end

function bs_1041022:OnBreakSkill(role)
  if role == self.caster then
    self:OnOver()
  end
  base.OnBreakSkill(self, role)
end

function bs_1041022:OnRoleDie(killer, role, killSkill)
  if role == self.caster.recordTable.pass_target then
    self:OnOver()
  end
end

function bs_1041022:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_1041022:LuaDispose()
  base.LuaDispose(self)
  if self.loopLine ~= nil then
    self.loopLine:Die()
    self.loopLine = nil
  end
  if self.loop_skill1 ~= nil then
    self.loop_skill1:Die()
    self.loop_skill1 = nil
  end
  if self.loop_skill2 ~= nil then
    self.loop_skill2:Die()
    self.loop_skill2 = nil
  end
  if self.hurt_timer ~= nil then
    self.hurt_timer:Stop()
    self.hurt_timer = nil
  end
end

return bs_1041022
