local bs_1043022 = class("bs_1043022", LuaSkillBase)
local base = LuaSkillBase
bs_1043022.config = {
  buff_RangeDown = 10430501,
  start_time = 15,
  actionId = 1002,
  action_speed = 1,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  },
  heal_config = {baseheal_formula = 501},
  effectId_SkillStart = 104311,
  effectId_SkillHit = 104309,
  effectId_Heal = 104308,
  audioIdStart = 104307,
  radius = 300,
  arcAngleRange = 60
}

function bs_1043022:ctor()
end

function bs_1043022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.TargetCount = 0
end

function bs_1043022:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local targetRole
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    targetRole = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    targetRole = tempTarget.targetRole
  end
  if targetRole ~= nil then
    local selectTarget = LuaSkillCtrl:GetTargetWithGrid(targetRole.x, targetRole.y)
    local targetPos = targetRole.lsObject.localPosition
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, selectTarget, targetPos)
    self.caster:LookAtTarget(targetRole)
    self:CallCasterWait(self.config.start_time + 15)
    LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, self.config.start_time + 15, true)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioIdStart)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  end
end

function bs_1043022:OnAttackTrigger(selectTarget, selectTargetPos)
  local forwardDir = CS.TrueSync.TSVector3.Subtract(selectTargetPos, self.caster.lsObject.localPosition)
  local ColliderEnter = BindCallback(self, self.OnColliderEnter, forwardDir, selectTargetPos)
  LuaSkillCtrl:CallEffect(selectTarget, self.config.effectId_SkillStart, self)
  LuaSkillCtrl:CallEffect(selectTarget, self.config.effectId_SkillHit, self)
  local fireCollider = LuaSkillCtrl:CallGetCircleSkillCollider(self, self.config.radius, eColliderInfluenceType.Enemy, ColliderEnter)
  fireCollider.lsObject = CS.LSUnityObject()
  fireCollider:SetColiderObjPosForce(selectTargetPos)
  LuaSkillCtrl:StartTimer(nil, 1, function()
    LuaSkillCtrl:ClearColliderOrEmission(fireCollider)
    self.TargetCount = math.min(self.TargetCount * self.arglist[2], self.arglist[5])
    local HealNum = self.TargetCount * self.caster.maxHp // 1000
    if 0 < HealNum then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_Heal, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {HealNum})
      skillResult:EndResult()
      self.TargetCount = 0
    end
  end)
end

function bs_1043022:OnColliderEnter(forwardDir, selectTargetPos, collider, index, entity)
  local angle = 0
  if not entity.lsObject.localPosition:Equals(selectTargetPos) then
    local tsVec2 = CS.TrueSync.TSVector2
    local curDir = CS.TrueSync.TSVector3.Subtract(entity.lsObject.localPosition, selectTargetPos)
    local curDir2d = tsVec2(curDir.x, curDir.z).normalized
    local forwardDir2D = tsVec2(forwardDir.x, forwardDir.z)
    angle = LuaSkillCtrl:CallTSVec2Angle(curDir2d, forwardDir2D)
  end
  if 180 < angle then
    angle = 360 - angle
  end
  if angle > self.config.arcAngleRange then
    return
  end
  if self.caster == nil or 0 >= self.caster.hp then
    return
  end
  if 0 < entity.intensity and entity.attackRange > self.arglist[3] and LuaSkillCtrl:CheckReletionWithRoleBelong(entity, self.caster, eBelongReletionType.Enemy) and entity.recordTable.Demiurge ~= true then
    local rangeDownNum = entity.attackRange - self.arglist[3]
    LuaSkillCtrl:CallBuff(self, entity, self.config.buff_RangeDown, rangeDownNum, self.arglist[1])
  end
  local rangeDownNum = entity:GetBuffTier(self.config.buff_RangeDown)
  if 0 < rangeDownNum then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buff_RangeDown, rangeDownNum, self.arglist[1])
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
    self.arglist[4]
  })
  skillResult:EndResult()
  if 0 < entity.intensity and entity.belongNum == eBattleRoleBelong.enemy then
    self.TargetCount = self.TargetCount + 1
  end
end

function bs_1043022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1043022
