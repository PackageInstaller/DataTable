local bs_215005 = class("bs_215005", LuaSkillBase)
local base = LuaSkillBase
bs_215005.config = {
  actionId = 1105,
  actionId_time = 20,
  action_speed = 1,
  start_time = 10,
  effectId_cast_p1 = 215016,
  effectId_cast_p2 = 215019,
  effect_trail_p1 = 215017,
  effect_trail_p2 = 215020,
  effectId_hit_p1 = 215018,
  effectId_hit_p2 = 215021,
  buffId_hurt = 215002,
  configId = 3
}

function bs_215005:ctor()
end

function bs_215005:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_215005:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 10) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.actionId_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  end
  if self.caster.recordTable.P2 == true then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast_p2, self)
  else
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast_p1, self)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, self.config.actionId_time, true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(nil, self.config.actionId_time, callnextskill)
end

function bs_215005:OnAttackTrigger(target, data)
  self.caster:LookAtTarget(target)
  if self.caster.recordTable.P2 == true then
    local effect_zd = LuaSkillCtrl:CallEffect(target, self.config.effect_trail_p2, self)
    local OnCollition = BindCallback(self, self.OnCollision)
    local onArrive = BindCallback(self, self.onArrive)
    local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 30, 7, 2, OnCollition, nil, nil, effect_zd, true, true, onArrive)
    local shoot = BindCallback(self, self.ShootWave)
    LuaSkillCtrl:StartTimer(self, 3, shoot, self, 1, 3)
  else
    local effect_zd = LuaSkillCtrl:CallEffect(target, self.config.effect_trail_p1, self)
    local OnCollition = BindCallback(self, self.OnCollision)
    local onArrive = BindCallback(self, self.onArrive)
    local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 30, 7, 2, OnCollition, nil, nil, effect_zd, true, true, onArrive)
  end
end

function bs_215005:ShootWave()
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
  for i = 0, targets.Count - 1 do
    local role = targets[i].targetRole
    if not LuaSkillCtrl:IsObstacle(role) then
      target = role
      break
    end
  end
  if target == nil or 0 >= target.hp then
    return
  end
  local effect_zd = LuaSkillCtrl:CallEffect(target, self.config.effect_trail_p2, self)
  local OnCollition = BindCallback(self, self.OnCollision)
  local onArrive = BindCallback(self, self.onArrive)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 30, 7, 2, OnCollition, nil, nil, effect_zd, true, true, onArrive)
end

function bs_215005:onArrive()
  self:OnSkillDamageEnd()
end

function bs_215005:OnCollision(collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 then
    return
  end
  if entity.belongNum == self.caster.belongNum or LuaSkillCtrl:IsFixedObstacle(entity) then
    return
  end
  self:HurtEnermy(entity)
end

function bs_215005:HurtEnermy(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arglist[1]
  })
  skillResult:EndResult()
  if self.caster.recordTable.P2 == true then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit_p2, self)
  else
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit_p1, self)
  end
end

function bs_215005:EndSkillAndCallNext()
  LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self.caster:CallUnFreezeNextSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_215005:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_215005
