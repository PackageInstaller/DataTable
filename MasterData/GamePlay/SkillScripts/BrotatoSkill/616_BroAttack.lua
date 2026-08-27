local bs_616 = class("bs_616", LuaSkillBase)
local base = LuaSkillBase
bs_616.config = {
  hurt_config = {
    basehurt_formula = 10076,
    hit_formula = 0,
    crit_formula = 0,
    correct_formula = 9989,
    spell_lifesteal_formula = 10102
  },
  buffId_1017 = 1017,
  buffTier = 1,
  startAnimID = 1002,
  effectId = 61601,
  effectPick = 61603,
  effectLine = 61604,
  hurtEffectId = 61602,
  audioId1 = 49,
  audioId2 = 50,
  passive_select_id = 9,
  passive_select_range = 0,
  skill_time = 28,
  skill_speed = 1,
  start_time = 16,
  emissionRadius = 10,
  emissionSpeed = 4,
  Time = 75
}

function bs_616:ctor()
end

function bs_616:InitSkill(isMidwaySkill)
end

function bs_616:PlaySkill(data)
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget ~= nil then
    local curAtkRole = moveTarget.targetRole
    if curAtkRole ~= nil then
      if self.lastAttackRole ~= curAtkRole then
        self.displaySelectEfc = true
      end
      self.lastAttackRole = curAtkRole
    end
  end
  if self.caster.recordTable.life_num ~= nil then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.passive_select_id, self.config.passive_select_range)
    if targetlist.Count > 0 then
      self.life_num = self.caster.recordTable.life_num * targetlist.Count
    end
  else
    self.life_num = 0
  end
  if moveTarget ~= nil then
    self:CallCasterWait(self.config.skill_time)
    local role = moveTarget.targetRole
    self.caster:LookAtTarget(role)
    local Targetgrid = LuaSkillCtrl:GetTargetWithGrid(role.x, role.y)
    self:DamageAnimation(Targetgrid)
    LuaSkillCtrl:CallEffect(Targetgrid, self.config.effectPick, self)
    LuaSkillCtrl:CallEffect(Targetgrid, self.config.effectLine, self)
  end
end

function bs_616:DamageAnimation(target)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, target)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, self.config.skill_speed, self.config.start_time, moveAttackTrigger)
end

function bs_616:OnMoveAttackTrigger(target)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  local cusEffect = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, self.config.emissionRadius, self.config.emissionSpeed, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, false, true)
end

function bs_616:OnCollision(collider, index, entity)
  if entity ~= self.caster then
    LuaSkillCtrl:CallEffect(entity, self.config.hurtEffectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:PlayAuHit(self, entity)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.life_num
    })
    skillResult:EndResult()
  end
end

function bs_616:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_616
