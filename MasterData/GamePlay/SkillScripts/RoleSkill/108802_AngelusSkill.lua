local bs_108802 = class("bs_108802", LuaSkillBase)
local base = LuaSkillBase
bs_108802.config = {
  skill_time = 30,
  actionId = 1008,
  action_speed = 1,
  start_time = 18,
  effectId_cast = 108809,
  effect_trail = 108810,
  configId_1 = 57,
  configId = 17
}

function bs_108802:ctor()
end

function bs_108802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108802:PlaySkill(data)
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
    self:windTest()
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  end
end

function bs_108802:windTest()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
  self.atk = LuaSkillCtrl:StartTimer(self, 2, function()
    local damage = self.caster._curHp * self.arglist[2] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId_1, {damage})
    skillResult:EndResult()
  end, nil, self.arglist[1] - 1, 2)
end

function bs_108802:OnAttackTrigger(target, data)
  self.caster:LookAtTarget(target)
  local effect_zd = LuaSkillCtrl:CallEffect(target, self.config.effect_trail, self)
  local OnCollition = BindCallback(self, self.OnCollision)
  local onArrive = BindCallback(self, self.onArrive)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 30, 7, 2, OnCollition, nil, nil, effect_zd, true, true, onArrive)
end

function bs_108802:onArrive()
  self:OnSkillDamageEnd()
end

function bs_108802:OnCollision(collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 then
    return
  end
  if entity.belongNum == self.caster.belongNum or LuaSkillCtrl:IsFixedObstacle(entity) then
    return
  end
  self:HurtEnermy(entity)
end

function bs_108802:HurtEnermy(target)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
    self.arglist[3]
  })
  skillResult:EndResult()
end

function bs_108802:LuaDispose()
  base.LuaDispose(self)
end

function bs_108802:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108802
