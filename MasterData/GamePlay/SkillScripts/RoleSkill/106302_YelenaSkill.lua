local bs_106302 = class("bs_106302", LuaSkillBase)
local base = LuaSkillBase
bs_106302.config = {
  actionId_1 = 1008,
  start_time_1 = 12,
  end_time_1 = 12,
  actionId_loop = 1007,
  actionId_end = 1009,
  skill_time_2 = 30,
  actionId_2 = 1105,
  action_speed = 1,
  start_time_2 = 7,
  skill_time_3 = 23,
  actionId_3 = 1020,
  action_speed = 1,
  start_time_3 = 5,
  effect_trail_1 = 106310,
  effectId_cast_1 = 106312,
  effect_trail_2 = 106313,
  effectId_cast_2 = 106315,
  effect_trail_3 = 106316,
  effectId_cast_3 = 106318,
  buff_atkSpeed = 106306,
  buff_def = 106307,
  HurtConfigID = 25,
  HurtConfigID_1 = 17,
  buffId_red = 106301,
  buffId_blue = 106302,
  buffId_yellow = 106303,
  effectId_get_1 = 106307,
  effectId_get_2 = 106308,
  effectId_get_3 = 106309,
  effectId_hit_3 = 106317
}

function bs_106302:ctor()
end

function bs_106302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106302:PlaySkill(data)
  local colorTable = self.caster.recordTable.colorTable
  if colorTable == nil then
    return
  end
  local colorId = 1
  local colorNume = 0
  if colorTable[1].num > colorTable[2].num then
    colorId = colorTable[1].colorId
    colorNume = colorTable[1].num
  elseif colorTable[2].num > colorTable[3].num then
    if LuaSkillCtrl:CallRange(1, 100) < 50 then
      colorId = colorTable[1].colorId
      colorNume = colorTable[1].num
    else
      colorId = colorTable[2].colorId
      colorNume = colorTable[2].num
    end
  else
    local randNum = LuaSkillCtrl:CallRange(1, 100)
    if randNum < 34 then
      colorId = colorTable[1].colorId
      colorNume = colorTable[1].num
    elseif randNum < 67 then
      colorId = colorTable[2].colorId
      colorNume = colorTable[2].num
    else
      colorId = colorTable[3].colorId
      colorNume = colorTable[3].num
    end
  end
  self.colorNum = colorNume
  if colorId == 1 then
    self:RealPlaySkill_red()
  elseif colorId == 2 then
    self:RealPlaySkill_blue()
  else
    self:RealPlaySkill_yellow()
  end
end

function bs_106302:RealPlaySkill_red()
  if self.colorNum > 20 then
    self.colorNum = 20
  end
  self.loopTime = (self.arglist[1] + self.colorNum) * 5 + 1
  local target
  local targets = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
  for i = targets.Count - 1, 0, -1 do
    local role = targets[i].targetRole
    if LuaSkillCtrl:IsObstacle(role) then
      targets:RemoveAt(i)
    end
  end
  if targets.Count > 0 then
    target = targets[0].targetRole
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger1)
    self.caster:LookAtTarget(target)
    local skilltime = self.config.start_time_1 + self.config.end_time_1 + self.loopTime
    self:CallCasterWait(skilltime)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_1, self.config.action_speed, self.config.start_time_1, attackTrigger)
  end
  self.loopAttack = LuaSkillCtrl:StartTimer(self, self.config.start_time_1, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
  end, nil)
  self.finishAttack = LuaSkillCtrl:StartTimer(self, self.config.start_time_1 + self.loopTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    if self.atk ~= nil then
      self.atk:Stop()
      self.atk = nil
    end
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role ~= nil and 0 < role.hp then
          LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buff_atkSpeed, 1, self.arglist[4])
        end
      end
    end
    self:OnSkillDamageEnd()
  end, nil)
end

function bs_106302:OnAttackTrigger1()
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnPlayYelenaSkill, self.caster, 1)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.loopTime)
  self.atk = LuaSkillCtrl:StartTimer(self, 5, function()
    local tar
    local targets = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
    for i = 0, targets.Count - 1 do
      local role = targets[i].targetRole
      if not LuaSkillCtrl:IsObstacle(role) then
        tar = role
        break
      end
    end
    if tar == nil then
      LuaSkillCtrl:CallBreakAllSkill(self.caster)
    end
    LuaSkillCtrl:CallEffectWithArgOverride(tar, self.config.effect_trail_1, self, self.caster, nil, nil, self.SkillEventFunc_1)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast_1, self)
  end, nil, -1, 5)
end

function bs_106302:SkillEventFunc_1(effect, eventId, target)
  if effect.dataId == self.config.effect_trail_1 and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[2]
    })
    skillResult:EndResult()
  end
end

function bs_106302:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
  end
end

function bs_106302:RealPlaySkill_blue()
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
    return
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger2, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time_2)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_2, self.config.action_speed, self.config.start_time_2, attackTrigger)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast_2, self)
  end
end

function bs_106302:OnAttackTrigger2(target)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnPlayYelenaSkill, self.caster, 2)
  self:RealPlaySkill_2(nil, target, 1)
end

function bs_106302:RealPlaySkill_2(sender, target, times)
  if sender == nil then
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail_2, self, self.caster, false, false, self.SkillEventFunc_2, times)
  else
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail_2, self, sender, false, false, self.SkillEventFunc_2, times)
  end
end

function bs_106302:SkillEventFunc_2(times, effect, eventId, target)
  if effect.dataId == self.config.effect_trail_2 and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID_1, {
      self.arglist[5]
    })
    skillResult:EndResult()
    if times <= self.arglist[6] + self.colorNum then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 42, 10)
      if targetList.Count == 0 then
        self:OnSkillDamageEnd()
        return
      end
      if targetList.Count >= 2 then
        for i = 0, targetList.Count - 1 do
          if targetList[i].targetRole ~= nil and targetList[i].targetRole ~= target.targetRole then
            self:RealPlaySkill_2(target.targetRole, targetList[i].targetRole, times + 1)
            break
          end
        end
      end
    else
      self:OnSkillDamageEnd()
    end
  end
end

function bs_106302:RealPlaySkill_yellow()
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
    return
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger3, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time_3)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_3, self.config.action_speed_3, self.config.start_time_3, attackTrigger)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast_3, self)
  end
end

function bs_106302:OnAttackTrigger3(target)
  LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnPlayYelenaSkill, self.caster, 3)
  LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail_3, self, self.caster, nil, nil, self.SkillEventFunc_3)
end

function bs_106302:SkillEventFunc_3(effect, eventId, target)
  if effect.dataId == self.config.effect_trail_3 and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_hit_3, self)
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target, 1, true)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        if targetList[i].belongNum ~= self.caster.belongNum then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
            self.arglist[7]
          })
          skillResult:EndResult()
          LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buff_def, 1, self.arglist[9] + 15 * self.colorNum)
        end
      end
      self:OnSkillDamageEnd()
    end
  end
end

function bs_106302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106302
