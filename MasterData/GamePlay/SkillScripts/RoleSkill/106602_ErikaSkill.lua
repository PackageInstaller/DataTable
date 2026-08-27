local bs_106602 = class("bs_106602", LuaSkillBase)
local base = LuaSkillBase
bs_106602.config = {
  HurtConfigId = 2,
  HurtConfigId2 = 2,
  buffId_Back = 3007,
  buffId_1 = 106601,
  buffId_ding = 106603,
  effectId_boom = 106608,
  effectId_shan = 106611,
  effectId_skill = 106616,
  skill_time = 41,
  start_time = 7,
  actionId = 1002,
  action_speed = 1,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  radius = 300,
  arcAngleRange = 30
}

function bs_106602:ctor()
end

function bs_106602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnCallBuff, self.OnCallBuff, self)
end

bs_106602.blackBuffIdDic = {
  [2065] = true,
  [2066] = true,
  [5002001] = true,
  [151] = true,
  [259] = true,
  [3007] = true,
  [300701] = true,
  [15101] = true,
  [25901] = true,
  [106508] = true,
  [106602] = true
}

function bs_106602:PlaySkill(data)
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
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  end
end

function bs_106602:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_boom, self)
  LuaSkillCtrl:StartTimer(nil, 5, function()
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe)
    local num = skillResult.roleList.Count
    for i = skillResult.roleList.Count - 1, 0, -1 do
      local role = skillResult.roleList[i]
      if LuaSkillCtrl:IsFixedObstacle(role) ~= true then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_1, 1, self.arglist[2])
        local skillResult2 = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult2, self.config.HurtConfigId, {
          self.arglist[1]
        })
        skillResult2:EndResult()
      end
    end
    skillResult:EndResult()
  end)
  LuaSkillCtrl:StartTimer(self, 6, function()
    local curGrid = LuaSkillCtrl:GetGridWithRole(self.caster)
    local ColliderEnter = BindCallback(self, self.OnColliderEnter)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_shan, self)
    local endTarget = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
    local fireCollider = LuaSkillCtrl:CallGetSectorSkillCollider(self, curGrid, self.config.radius, self.config.arcAngleRange, endTarget, eColliderInfluenceType.Enemy, false, ColliderEnter)
    fireCollider.bindRole = self.caster
    LuaSkillCtrl:StartTimer(nil, 1, function()
      LuaSkillCtrl:ClearColliderOrEmission(fireCollider)
      self:OnSkillDamageEnd()
    end)
  end)
end

function bs_106602:OnColliderEnter(collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 then
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId2, {
    self.arglist[3]
  })
  skillResult:EndResult()
  if 0 < entity.intensity and entity.belongNum == eBattleRoleBelong.enemy then
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_Back, 1, 3)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_ding, 1, 20)
  end
end

function bs_106602:OnCallBuff(sender, target, buffId, bResult)
  if bs_106602.blackBuffIdDic[buffId] == true and target.belongNum ~= self.caster.belongNum and target:GetBuffTier(self.config.buffId_1) > 0 then
    local x = target.x
    local y = target.y
    LuaSkillCtrl:StartTimer(nil, 1, function()
      if self.caster == nil or self.caster.hp <= 0 then
        return
      end
      if target.x == x and target.y == y then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
          self.arglist[4]
        })
        skillResult:EndResult()
        LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self)
      end
    end)
  end
end

function bs_106602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106602
