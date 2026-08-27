local bs_108602 = class("bs_108602", LuaSkillBase)
local base = LuaSkillBase
bs_108602.config = {
  skill_time = 30,
  start_time = 15,
  actionId = 1002,
  action_speed = 1,
  radius = 230,
  arcAngleRange = 60,
  buffId = 108604,
  HurtConfigID = 3,
  buffId_crazy = 108607,
  effectId_shan = 108606,
  effectId_hit = 108607
}

function bs_108602:ctor()
end

function bs_108602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_108602:PlaySkill(data)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  local num = 0
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      if targetList[i] ~= nil then
        num = num + 1
      end
    end
  end
  if 10 < num then
    num = 10
  end
  local shieldValue = self.caster.skill_intensity * self.arglist[1] // 1000 * num
  if 0 < shieldValue then
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
  end
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and 0 < last_target.hp and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  end
end

function bs_108602:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_shan, self)
  local shieldNum = LuaSkillCtrl:GetRoleAllShield(self.caster)
  local value = 0
  if shieldNum ~= 0 then
    value = shieldNum / self.caster.maxHp * 1000
  end
  if value > self.arglist[5] * 1000 then
    value = self.arglist[5] * 1000
  end
  local curGrid = LuaSkillCtrl:GetGridWithRole(self.caster)
  local ColliderEnter = BindCallback(self, self.OnColliderEnter, value)
  local endTarget = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
  local fireCollider = LuaSkillCtrl:CallGetSectorSkillCollider(self, curGrid, self.config.radius, self.config.arcAngleRange, endTarget, eColliderInfluenceType.Enemy, false, ColliderEnter)
  fireCollider.bindRole = self.caster
  LuaSkillCtrl:StartTimer(nil, 1, function()
    LuaSkillCtrl:ClearColliderOrEmission(fireCollider)
    self:OnSkillDamageEnd()
  end)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if 0 < targetList.Count then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp and role.roleType == eBattleRoleType.realSummoner then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_crazy, 1, self.arglist[7], true)
      end
    end
  end
end

function bs_108602:OnColliderEnter(value, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
    self.arglist[2] + self.arglist[2] * value // 1000
  })
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, entity, self.config.buffId, 1, self.arglist[4])
  LuaSkillCtrl:CallEffect(entity, self.config.effectId_hit, self)
end

function bs_108602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_108602
