local bs_212202 = class("bs_212202", LuaSkillBase)
local base = LuaSkillBase
bs_212202.config = {
  start_time = 8,
  end_time = 35,
  buffId_170 = 170,
  actionId = 1008,
  actionId_end = 1009,
  actionId_speed = 1,
  effectId_dg = 212204,
  effectId_loop = 212206,
  effectId_loopdg = 212205,
  configId_trail = 2,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  }
}

function bs_212202:ctor()
end

function bs_212202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_212202_1", 10, self.OnRoleDie)
end

function bs_212202:OnRoleDie(killer, role)
  if role.hp == 0 and role ~= nil then
    self:endAttack()
  end
end

function bs_212202:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, self.cskill.SkillRange) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target == nil then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  self.caster:LookAtTarget(target)
  local time = self.config.start_time + self.arglist[1] + self.config.end_time
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, time, true)
  local grid = LuaSkillCtrl:GetGridWithRole(target)
  local targetGrid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_dg, self)
end

function bs_212202:OnAttackTrigger(target)
  if target ~= nil and target.hp > 0 then
    LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
    self.skillLoop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self, nil, nil, nil, true)
    local grid = LuaSkillCtrl:GetGridWithRole(target)
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    self.skillLoop2 = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_loopdg, self, nil, nil, nil, true)
    local beginTimer = LuaSkillCtrl:StartTimer(self, 15, function()
      self:beginAttack(target)
    end, self, self.arglist[1] // 15 - 1, 14)
    LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
      if beginTimer ~= nil then
        beginTimer:Stop()
        beginTimer = nil
      end
      self:endAttack()
    end)
  else
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
  end
end

function bs_212202:beginAttack(target)
  if target ~= nil and target.hp > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe)
    local num = skillResult.roleList.Count
    for i = 0, skillResult.roleList.Count - 1 do
      local role = skillResult.roleList[i]
      if LuaSkillCtrl:IsFixedObstacle(role) or role.belongNum == self.caster.belongNum then
        num = num - 1
      end
    end
    if 2 <= num then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        if LuaSkillCtrl:IsFixedObstacle(role) ~= true then
          local hurt = self.arglist[2] // num
          local skillResult2 = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult2, self.config.configId_trail, {hurt})
          skillResult2:EndResult()
        end
      end
    else
      local skillResult3 = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      local hurt2 = self.arglist[2] * (1000 + self.arglist[3]) // 1000
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult3, self.config.configId_trail, {hurt2})
      skillResult3:EndResult()
    end
  else
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
  end
end

function bs_212202:endAttack()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
  if self.skillLoop2 ~= nil then
    self.skillLoop2:Die()
    self.skillLoop2 = nil
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
  LuaSkillCtrl:StartTimer(nil, self.config.end_time, function()
    self:CancleCasterWait()
  end)
end

function bs_212202:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    if self.skillLoop ~= nil then
      self.skillLoop:Die()
      self.skillLoop = nil
    end
    if self.skillLoop2 ~= nil then
      self.skillLoop2:Die()
      self.skillLoop2 = nil
    end
  end
end

function bs_212202:OnCasterDie()
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
  if self.skillLoop2 ~= nil then
    self.skillLoop2:Die()
    self.skillLoop2 = nil
  end
  base.OnCasterDie(self)
end

return bs_212202
