local bs_107202 = class("bs_107202", LuaSkillBase)
local base = LuaSkillBase
bs_107202.config = {
  actionId_1 = 1002,
  time_1 = 25,
  start_time_1 = 9,
  actionId_2 = 1008,
  start_time_2 = 19,
  end_time_2 = 12,
  actionId_loop_bot = 1007,
  actionId_end_bot = 1009,
  action_speed = 1,
  effect_trail_1 = 107205,
  effect_trail_2 = 107207,
  effect_ready = 107214,
  buff_show = 107204,
  HurtConfigID = 39,
  audio_skill1 = 107204,
  weaponLv = 0
}

function bs_107202:ctor()
end

function bs_107202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107202:PlaySkill(data)
  self.lock = false
  if self.caster.recordTable.changebody == false then
    self:RealPlaySkill()
  else
    self:RealPlaySkill_changebody()
  end
end

function bs_107202:RealPlaySkill()
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
  else
    local ex_damage = math.min(self.caster.recordTable.energy_num, self.arglist[7])
    self.caster.recordTable.energy_num = self.caster.recordTable.energy_num - ex_damage
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_show, ex_damage)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger1, target, ex_damage)
    self.caster:LookAtTarget(target)
    local skilltime = self.config.time_1
    LuaSkillCtrl:StartTimer(nil, self.config.start_time_1 // 2, function()
      if 0 < ex_damage then
        LuaSkillCtrl:CallEffect(self.caster, self.config.effect_ready, self)
      end
    end)
    if self.config.weaponLv >= 1 then
      self:CallCasterWait(skilltime * 1000 // (self.arglist[9] + 1000))
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_1, self.config.action_speed * (self.arglist[9] + 1000) // 1000, self.config.start_time_1 * 1000 // (self.arglist[9] + 1000), attackTrigger)
    else
      self:CallCasterWait(skilltime)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_1, self.config.action_speed, self.config.start_time_1, attackTrigger)
    end
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audio_skill1)
    self.atk1 = LuaSkillCtrl:StartTimer(self, 13, attackTrigger, nil, 0, 0)
    self.atk2 = LuaSkillCtrl:StartTimer(self, 17, attackTrigger, nil, 0, 0)
  end
end

function bs_107202:OnAttackTrigger1(target, ex_damage)
  if target == nil or target.hp <= 0 then
    if self.config.weaponLv >= 1 then
      self:ReturnSkillCost()
    end
    local targets = LuaSkillCtrl:CallTargetSelect(self, 1, 3)
    for i = 0, targets.Count - 1 do
      local role = targets[i].targetRole
      if not LuaSkillCtrl:IsObstacle(role) then
        target = role
        break
      end
    end
    if target == nil then
      LuaSkillCtrl:CallBreakAllSkill(self.caster)
    end
  end
  LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail_1, self, self.caster, nil, nil, self.SkillEventFunc_1, ex_damage)
end

function bs_107202:SkillEventFunc_1(ex_damage, effect, eventId, target)
  if effect.dataId == self.config.effect_trail_1 and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[2] + ex_damage * self.arglist[3]
    })
    skillResult:EndResult()
  end
end

function bs_107202:RealPlaySkill_changebody()
  local num = self.arglist[4]
  self.loopTime2 = num * 3
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
  local ex_damage = math.min(self.caster.recordTable.energy_num, self.arglist[8])
  if target == nil then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  else
    self.caster.recordTable.energy_num = self.caster.recordTable.energy_num - ex_damage
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_show, ex_damage)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger2, target, ex_damage)
    self.caster:LookAtTarget(target)
    local skilltime = self.config.start_time_2 + self.loopTime2
    if self.config.weaponLv >= 1 then
      self:CallCasterWait(skilltime * 1000 // (self.arglist[9] + 1000))
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_2, self.config.action_speed * (self.arglist[9] + 1000) // 1000, self.config.start_time_2 * 1000 // (self.arglist[9] + 1000), attackTrigger)
      self.loopAttack = LuaSkillCtrl:StartTimer(self, self.config.start_time_2 * 1000 // (self.arglist[9] + 1000), function()
        LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop_bot, self.config.action_speed * (self.arglist[9] + 1000) // 1000)
      end, nil)
      self.finishAttack = LuaSkillCtrl:StartTimer(self, (self.config.start_time_2 + self.loopTime2) * 1000 // (self.arglist[9] + 1000), function()
        LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end_bot, self.config.action_speed * (self.arglist[9] + 1000) // 1000)
        if self.atk ~= nil then
          self.atk:Stop()
          self.atk = nil
        end
        self:OnSkillDamageEnd()
      end, nil)
    else
      self:CallCasterWait(skilltime)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_2, self.config.action_speed, self.config.start_time_2, attackTrigger)
      self.loopAttack = LuaSkillCtrl:StartTimer(self, self.config.start_time_2, function()
        LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop_bot, self.config.action_speed)
      end, nil)
      self.finishAttack = LuaSkillCtrl:StartTimer(self, self.config.start_time_2 + self.loopTime2, function()
        LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end_bot, self.config.action_speed)
        if self.atk ~= nil then
          self.atk:Stop()
          self.atk = nil
        end
        self:OnSkillDamageEnd()
      end, nil)
    end
  end
end

function bs_107202:OnAttackTrigger2(target, ex_damage)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.loopTime2)
  self.atk = LuaSkillCtrl:StartTimer(self, 1, function()
    if target == nil or target.hp <= 0 then
      local targets = LuaSkillCtrl:CallTargetSelect(self, 1, 3)
      for i = 0, targets.Count - 1 do
        local role = targets[i].targetRole
        if not LuaSkillCtrl:IsObstacle(role) then
          target = role
          break
        end
      end
      if target == nil then
        LuaSkillCtrl:CallBreakAllSkill(self.caster)
      end
    end
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail_2, self, self.caster, nil, nil, self.SkillEventFunc_2, ex_damage)
  end, nil, self.arglist[4] - 1, 1)
end

function bs_107202:SkillEventFunc_2(ex_damage, effect, eventId, target)
  if effect.dataId == self.config.effect_trail_2 and eventId == eBattleEffectEvent.Trigger then
    if (target == nil or target.targetRole.hp <= 0) and self.config.weaponLv >= 1 then
      self:ReturnSkillCost()
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[5] + ex_damage * self.arglist[6]
    })
    skillResult:EndResult()
  end
end

function bs_107202:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
  end
end

function bs_107202:ReturnSkillCost()
  if not self.lock then
    local buff_num = self.caster.recordTable.energy_num
    self.caster.recordTable.energy_num = math.min(buff_num + self.arglist[10], self.caster.recordTable.energy_num_max)
    local buff_add = self.caster.recordTable.energy_num - buff_num
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_show, buff_add, 9999)
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnXinghuanAddZhuRan, buff_add)
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[11] * 180 // 1000)
    self.lock = true
  end
end

function bs_107202:OnCasterDie()
  base.OnCasterDie(self)
  self.lock = true
end

return bs_107202
