local bs_212105 = class("bs_212105", LuaSkillBase)
local base = LuaSkillBase
bs_212105.config = {
  buffId_lockCd = 170,
  actionId_start = 1022,
  actionId_loop = 1023,
  actionId_end = 1024,
  action_speed = 1,
  actionId_start_time = 17,
  actionId_end_time = 12,
  HurtConfigID = 3,
  heal_resultId = 6,
  effectId = 212103,
  effectId_heal = 212105,
  buff_grid = 1275
}

function bs_212105:ctor()
end

function bs_212105:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddHurtResultEndTrigger("bs_212105", 30, self.OnHurtResultEnd, self.caster, nil, nil)
  self.loopTime = self.arglist[2]
  self.skillTarget = nil
  self.onCastSkill = false
end

function bs_212105:PlaySkill(data)
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
    self.caster:LookAtTarget(target)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.onCastSkill = true
    local time = self.config.actionId_start_time + self.config.actionId_end_time + self.loopTime
    self:CallCasterWait(time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
    self.loopAttack = LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time, function()
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
    end, nil)
    self.finishAttack = LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time + self.loopTime, function()
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
      if self.onLoopAttack ~= nil then
        self.onLoopAttack:Stop()
        self.onLoopAttack = nil
      end
      if self.effect_loop ~= nil then
        self.effect_loop:Die()
        self.effect_loop = nil
      end
      if self.effectId_heal ~= nil then
        self.effectId_heal:Die()
        self.effectId_heal = nil
      end
      if self.skillTarget ~= nil and self.skillTarget:GetBuffTier(66) > 0 then
        LuaSkillCtrl:DispelBuff(self.skillTarget, 66, 0)
      end
    end, nil)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, time, true)
    local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
    LuaSkillCtrl:StartTimer(self, time, callnextskill)
  end
end

function bs_212105:OnAttackTrigger(target)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.config.actionId_end_time + self.loopTime)
  self.skillTarget = target
  LuaSkillCtrl:CallBuff(self, target, 66, 1, 999, true)
  self.onLoopAttack = LuaSkillCtrl:StartTimer(self, 15, function()
    if target.hp > 0 and target:GetBuffTier(self.config.buff_grid) == 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
        self.arglist[1]
      })
      skillResult:EndResult()
      self.effect_loop = LuaSkillCtrl:CallEffect(target, self.config.effectId, self)
      self.effectId_heal = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_heal, self)
    else
      LuaSkillCtrl:CallBreakAllSkill(self.caster)
    end
  end, self, -1, 15)
end

function bs_212105:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker == self.caster and skill.dataId == 212105 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResultWithConfig(self, skillResult, self.config.heal_resultId, {hurtValue})
    skillResult:EndResult()
  end
end

function bs_212105:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if self.skillTarget ~= nil and self.skillTarget:GetBuffTier(66) > 0 then
    LuaSkillCtrl:DispelBuff(self.skillTarget, 66, 0)
  end
  if self.effect_loop ~= nil then
    self.effect_loop:Die()
    self.effect_loop = nil
  end
  if self.effectId_heal ~= nil then
    self.effectId_heal:Die()
    self.effectId_heal = nil
  end
  if self.onCastSkill == true then
    self:EndSkillAndCallNext()
  end
end

function bs_212105:EndSkillAndCallNext()
  self.onCastSkill = false
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

function bs_212105:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect_loop ~= nil then
    self.effect_loop:Die()
    self.effect_loop = nil
  end
  if self.effectId_heal ~= nil then
    self.effectId_heal:Die()
    self.effectId_heal = nil
  end
end

return bs_212105
