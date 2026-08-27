local bs_215004 = class("bs_215004", LuaSkillBase)
local base = LuaSkillBase
bs_215004.config = {
  actionId_start = 1022,
  actionId_loop = 1023,
  actionId_end = 1024,
  actionId_end_time = 18,
  actionId_start_time = 20,
  action_speed = 1,
  buffId_gravity = 215003,
  effectId_cast_p1 = 215010,
  effectId_cast_p2 = 215013,
  effectId_aim_p1 = 215022,
  effectId_aim_p2 = 215023,
  effectId_shoot_p1 = 215011,
  effectId_shoot_p2 = 215014,
  effectId_hit_p1 = 215012,
  effectId_hit_p2 = 215015,
  configId = 3
}

function bs_215004:ctor()
end

function bs_215004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.loopTime = self.arglist[1]
end

function bs_215004:PlaySkill(data)
  if self.caster.recordTable.P2 == true then
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i].targetRole
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_gravity, 1, self.arglist[3], true)
      end
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast_p2, self)
  else
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast_p1, self)
  end
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
  end, nil)
  self.finishAttack = LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time + self.loopTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, time, true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(nil, time, callnextskill)
end

function bs_215004:OnAttackTrigger(target, data)
  if self.caster.recordTable.P2 == true then
    self.aim = LuaSkillCtrl:CallEffect(target, self.config.effectId_aim_p2, self)
  else
    self.aim = LuaSkillCtrl:CallEffect(target, self.config.effectId_aim_p1, self)
  end
  local shoot = BindCallback(self, self.ShootWave, target)
  LuaSkillCtrl:StartTimer(self, self.loopTime + 3, shoot, self, 0)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
end

function bs_215004:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if self.aim ~= nil then
    self.aim:Die()
    self.aim = nil
  end
end

function bs_215004:ShootWave(target)
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
  if self.aim ~= nil then
    self.aim:Die()
    self.aim = nil
  end
  if self.caster.recordTable.P2 == true then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_shoot_p2, self)
  else
    LuaSkillCtrl:CallEffect(target, self.config.effectId_shoot_p1, self)
  end
  LuaSkillCtrl:StartTimer(nil, 8, function()
    if self.caster.recordTable.P2 == true then
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hit_p2, self)
    else
      LuaSkillCtrl:CallEffect(target, self.config.effectId_hit_p1, self)
    end
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target, 1, true)
    if targetList.Count > 0 then
      for i = targetList.Count - 1, 0, -1 do
        if targetList[i].belongNum ~= target.belongNum then
          targetList:RemoveAt(i)
        end
      end
    end
    local targetList2 = LuaSkillCtrl:FindAllRolesWithinRange(target, 1, true)
    if targetList2.Count > 0 then
      for i = 0, targetList2.Count - 1 do
        if targetList2[i].belongNum ~= self.caster.belongNum then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList2[i])
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
            self.arglist[2] // targetList.Count
          })
          skillResult:EndResult()
        end
      end
    end
  end, nil)
end

function bs_215004:EndSkillAndCallNext()
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

function bs_215004:OnCasterDie()
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

return bs_215004
