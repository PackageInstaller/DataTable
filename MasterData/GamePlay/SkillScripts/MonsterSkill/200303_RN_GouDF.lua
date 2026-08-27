local bs_200303 = class("bs_200303", LuaSkillBase)
local base = LuaSkillBase
bs_200303.config = {
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
  effectId = 10095,
  effectPick = 2001301,
  effectLine = 2001302,
  hurtEffectId = 10096,
  audioId1 = 49,
  audioId2 = 50,
  passive_select_id = 9,
  passive_select_range = 0,
  skill_time = 28,
  skill_speed = 1,
  start_time = 16,
  emissionRadius = 40,
  emissionSpeed = 4
}

function bs_200303:ctor()
end

function bs_200303:InitSkill(isMidwaySkill)
end

function bs_200303:PlaySkill(data)
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
    self:DamageAnimation(role)
    self.effectPick = LuaSkillCtrl:CallEffect(role, self.config.effectPick, self)
    LuaSkillCtrl:CallEffect(role, self.config.effectLine, self)
  end
end

function bs_200303:DamageAnimation(target)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  local moveAttackTrigger = BindCallback(self, self.OnMoveAttackTrigger, target)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimID, self.config.skill_speed, self.config.start_time, moveAttackTrigger)
end

function bs_200303:OnMoveAttackTrigger(target)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  local cusEffect = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
  local collisionTrigger = BindCallback(self, self.OnCollision)
  local collisionArrive = BindCallback(self, self.OnArrive, cusEffect)
  local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, self.config.emissionRadius, self.config.emissionSpeed, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, false, true, collisionArrive)
end

function bs_200303:OnCollision(collider, index, entity)
  if entity ~= self.caster then
    LuaSkillCtrl:CallEffect(entity, self.config.hurtEffectId, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:PlayAuHit(self, entity)
    skillResult:BuffResult(self.config.buffId_1017, self.config.buffTier, self.arglist[2])
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.life_num
    })
    skillResult:EndResult()
  end
end

function bs_200303:OnArrive(cueEffect)
  if self.effectPick ~= nil then
    self.effectPick:Die()
    self.effectPick = nil
  end
end

function bs_200303:LuaDispose()
  base.LuaDispose(self)
  if self.effectPick ~= nil then
    self.effectPick:Die()
    self.effectPick = nil
  end
end

function bs_200303:OnCasterDie()
  base.OnCasterDie(self)
  if self.effectPick ~= nil then
    self.effectPick:Die()
    self.effectPick = nil
  end
end

return bs_200303
