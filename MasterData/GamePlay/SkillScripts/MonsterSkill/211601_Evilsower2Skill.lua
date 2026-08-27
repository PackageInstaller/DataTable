local bs_211601 = class("bs_211601", LuaSkillBase)
local base = LuaSkillBase
bs_211601.config = {
  skill_time = 25,
  start_time = 8,
  start_time2 = 4,
  dd_time = 3,
  hdRate = 30,
  actionId_start = 1022,
  actionId_loop = 1023,
  actionId_end = 1024,
  buffId_170 = 170,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0
  },
  time_loop = 7,
  effectId_loop = 211601,
  effectId_hit = 211602,
  effectId_loop2 = 211603,
  effectId_hit2 = 211604,
  buffIdcx = 211601,
  buffId_lockCd = 3008,
  configId = 3
}

function bs_211601:ctor()
end

function bs_211601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_211601:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target ~= nil then
    local noAttack_time = 8
    self:CallCasterWait(noAttack_time)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.start_time, attackTrigger)
    self.caster:LookAtTarget(target)
    LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, 8, true)
  end
end

function bs_211601:OnAttackTrigger(target)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, 1.5)
  local time = self.arglist[6] // self.arglist[1]
  self.beginTimer = LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    if LuaSkillCtrl:GetRoleEfcGrid(self.caster) ~= 0 then
      local effectBall2 = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop2, self)
      local collisionTrigger2 = BindCallback(self, self.OnCollision2, target)
      LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 1, eColliderInfluenceType.Enemy, collisionTrigger2, nil, nil, effectBall2, true, true, BindCallback(self, self.OnArive, effectBall2))
    else
      LuaSkillCtrl:RemoveLife(self.caster.hp * self.arglist[2] // 1000, self, self.caster, false, nil, true, true, 1, true)
      local effectBall = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
      local collisionTrigger = BindCallback(self, self.OnCollision, target)
      LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 15, 1, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, effectBall, true, true, BindCallback(self, self.OnArive, effectBall))
    end
  end, nil, time, 7)
  local time1 = self.arglist[6] + 7
  LuaSkillCtrl:StartShowSkillDurationTime(self, time1)
  self:AddCasterWait(time1 + 2)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, time1, true)
  LuaSkillCtrl:StartTimer(nil, self.arglist[6], function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    if self.beginTimer ~= nil then
      self.beginTimer:Stop()
      self.beginTimer = nil
    end
  end)
end

function bs_211601:OnArive(cusEffect)
  if cusEffect ~= nil and not cusEffect:IsDie() then
    cusEffect:Die()
  end
end

function bs_211601:OnCollision(inputTarget, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 or entity.belongNum == self.caster.belongNum then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arglist[3]
  }, false)
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_hit, self)
  skillResult:EndResult()
end

function bs_211601:OnCollision2(inputTarget, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 or entity.belongNum == self.caster.belongNum then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arglist[3]
  }, false)
  LuaSkillCtrl:CallBuffRepeated(self, entity, self.config.buffIdcx, 1, self.arglist[5] + 1, false, false, self.OnBuffExecute)
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_hit2, self)
  skillResult:EndResult()
end

function bs_211601:OnBuffExecute(buff, targetRole)
  local num = targetRole:GetBuffTier(self.config.buffIdcx)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  local hurtnum = self.arglist[4] * num
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {hurtnum}, true)
  skillResult:EndResult()
end

function bs_211601:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    if self.beginTimer ~= nil then
      self.beginTimer:Stop()
      self.beginTimer = nil
    end
  end
end

function bs_211601:OnCasterDie()
  base.OnCasterDie(self)
  if self.beginTimer ~= nil then
    self.beginTimer:Stop()
    self.beginTimer = nil
  end
end

return bs_211601
