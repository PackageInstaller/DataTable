local bs_204401 = class("bs_204401", LuaSkillBase)
local base = LuaSkillBase
bs_204401.config = {
  hurt_config = {
    hit_formula = 10201,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0,
    returndamage_formula = 0
  },
  actionId = 1002,
  action_speed = 1,
  skill_time = 40,
  start_time = 23,
  pause_time = 4,
  effectid_Hurt = 204403,
  effectid_Sj = 204401,
  effectid_start = 204404,
  effectid_quan = 204405,
  effectid_direction = 204406,
  effectid_target = 204407,
  effect_speed = 10,
  effect_radius = 50,
  selectId = 10002,
  selectrange = 20
}

function bs_204401:ctor()
end

function bs_204401:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_204401:PlaySkill(data)
  local targets = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectrange)
  if targets == nil or targets.Count <= 0 then
    return
  end
  local target2 = targets[0].targetRole
  self.caster:LookAtTarget(target2)
  self:CallCasterWait(self.config.skill_time)
  if self.lineStart ~= nil then
    self.lineStart:Die()
    self.lineStart = nil
  end
  if self.targetEffect ~= nil then
    self.targetEffect:Die()
    self.targetEffect = nil
  end
  self.lineStart = LuaSkillCtrl:CallEffect(target2, self.config.effectid_direction, self)
  self.targetEffect = LuaSkillCtrl:CallEffect(target2, self.config.effectid_target, self)
  LuaSkillCtrl:StartTimer(self, 10, function()
    LuaSkillCtrl:CallEffect(target2, self.config.effectid_quan, self)
  end)
  local attackTrigger = BindCallback(self, self.beginsplash, target2, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.acton_speed, self.config.start_time, attackTrigger)
end

function bs_204401:beginsplash(target, data)
  local totalEmitTime = self.arglist[2] - 1
  if target == nil or target.hp <= 0 or target:IsTowerLoadOff() then
    return
  end
  LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, self.CallEffectAndEmissions, target), nil, totalEmitTime - 1, self.config.start_time)
  LuaSkillCtrl:StartTimer(self, 6, BindCallback(self, self.CallEffectAndEmissions, target), nil, 0, self.config.config_time)
  if self.lineStart ~= nil then
    self.lineStart:Die()
    self.lineStart = nil
  end
  if self.targetEffect ~= nil then
    self.targetEffect:Die()
    self.targetEffect = nil
  end
end

function bs_204401:CallEffectAndEmissions(target)
  if target == nil or target.hp <= 0 or target:IsTowerLoadOff() then
    return
  end
  local cusEffect = LuaSkillCtrl:CallEffect(target, self.config.effectid_Hurt, self)
  local collisionTrigger = BindCallback(self, self.OnCollision, cusEffect)
  self.emission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 30, 7, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, nil, true, true, BindCallback(self, self.OnArive, cusEffect))
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectid_start, self)
end

function bs_204401:OnArive(cusEffect)
  self.emission = nil
  if cusEffect ~= nil and not cusEffect:IsDie() then
    cusEffect:Die()
  end
end

function bs_204401:OnCollision(cusEffect, collider, index, entity)
  if LuaSkillCtrl:IsFixedObstacle(entity) then
    return
  end
  if cusEffect ~= nil and not cusEffect:IsDie() then
    cusEffect:Die()
  end
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 then
    return
  end
  if entity.roleType == eBattleRoleType.DungeonRole and entity.belongNum == eBattleRoleBelong.player and LuaSkillCtrl.IsInTDBattle then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
    self.arglist[1]
  }, false)
  LuaSkillCtrl:CallEffect(entity, self.config.effectid_Sj, self)
  skillResult:EndResult()
  collider.isActive = false
end

function bs_204401:OnCasterDie()
  base.OnCasterDie(self)
  if self.lineStart ~= nil then
    self.lineStart:Die()
    self.lineStart = nil
  end
  if self.targetEffect ~= nil then
    self.targetEffect:Die()
    self.targetEffect = nil
  end
end

function bs_204401:LuaDispose()
  base.LuaDispose(self)
  if self.emission ~= nil and self.emission.collider ~= nil then
    self.emission:EndAndDisposeEmission()
    self.emission = nil
  end
  if self.lineStart ~= nil then
    self.lineStart:Die()
    self.lineStart = nil
  end
  if self.targetEffect ~= nil then
    self.targetEffect:Die()
    self.targetEffect = nil
  end
end

return bs_204401
