local bs_215102 = class("bs_215102", LuaSkillBase)
local base = LuaSkillBase
bs_215102.config = {
  actionId_start = 1022,
  actionId_loop = 1023,
  actionId_end = 1024,
  actionId_end_time = 18,
  actionId_start_time = 20,
  action_speed = 1,
  effectId_cast = 215105,
  effectId_aim = 215106,
  effectId_hit = 215107,
  configId = 3
}

function bs_215102:ctor()
end

function bs_215102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.loopTime = self.arglist[1]
end

function bs_215102:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 104801, 10)
  for i = targetList.Count - 1, 0, -1 do
    local role = targetList[i].targetRole
    if LuaSkillCtrl:IsObstacle(role) then
      targetList:RemoveAt(i)
    end
  end
  local targetListCount = targetList.Count
  if targetListCount == 0 then
    return
  end
  local index = LuaSkillCtrl:CallRange(0, targetListCount - 1)
  local target = targetList[index].targetRole
  self.caster:LookAtTarget(target)
  if target == nil or 0 >= target.hp then
    return
  end
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.loopTime
  self:CallCasterWait(time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  self.loopAttack = LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
    self.loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
  end, nil)
  self.finishAttack = LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time + self.loopTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, time, true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(nil, time, callnextskill)
end

function bs_215102:OnAttackTrigger(target, data)
  local grid = LuaSkillCtrl:GetGridWithRole(target)
  local target_grid = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  self.aim = LuaSkillCtrl:CallEffect(target_grid, self.config.effectId_aim, self)
  local shoot = BindCallback(self, self.ShootWave, target_grid)
  LuaSkillCtrl:StartTimer(self, self.loopTime + 3, shoot, self, 0)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
end

function bs_215102:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if self.aim ~= nil then
    self.aim:Die()
    self.aim = nil
  end
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
end

function bs_215102:ShootWave(target_grid)
  if self.aim ~= nil then
    self.aim:Die()
    self.aim = nil
  end
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
  LuaSkillCtrl:CallEffect(target_grid, self.config.effectId_hit, self)
  local target = LuaSkillCtrl:GetRoleWithPos(target_grid.x, target_grid.y)
  if target ~= nil then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
      self.arglist[2]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target, 66, 1, self.arglist[3])
  end
end

function bs_215102:EndSkillAndCallNext()
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

function bs_215102:OnCasterDie()
  base.OnCasterDie(self)
  if self.loopAttack ~= nil then
    self.loopAttack:Stop()
    self.loopAttack = nil
  end
  if self.finishAttack ~= nil then
    self.finishAttack:Stop()
    self.finishAttack = nil
  end
  if self.onLoopAttack ~= nil then
    self.onLoopAttack:Stop()
    self.onLoopAttack = nil
  end
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
  if self.aim ~= nil then
    self.aim:Die()
    self.aim = nil
  end
end

return bs_215102
