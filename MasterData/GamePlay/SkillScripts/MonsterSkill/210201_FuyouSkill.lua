local bs_210201 = class("bs_210201", LuaSkillBase)
local base = LuaSkillBase
bs_210201.config = {
  skill_time = 25,
  start_time = 6,
  start_time2 = 4,
  dd_time = 3,
  hdRate = 30,
  actionId_attack3 = 1025,
  actionId_start = 1008,
  actionId_loop = 1007,
  actionId_end = 1009,
  action_speed = 1,
  buffIdHD = 207802,
  effectId_skill = 10779,
  effectId_bnfffire = 100307,
  effectId_trail2 = 210202,
  effectId_qk = 210205,
  effectId_bd = 207805,
  buffId_170 = 3008,
  audioId = 207803,
  hurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0
  },
  buffId_js = 210201,
  time_loop = 7
}

function bs_210201:ctor()
end

function bs_210201:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_210201:PlaySkill(data)
  local noAttack_time = 17
  self:CallCasterWait(noAttack_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 35, true)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, 35, true)
end

function bs_210201:OnAttackTrigger()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop)
  self.skillLoop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_qk, self, nil, nil, nil, true)
  local num_now = self.arglist[1]
  local num = 0
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  ::lbl_25::
  if targetList ~= nil and 0 < num_now and 0 < targetList.Count then
    if num_now > targetList.Count then
      for i = 0, targetList.Count - 1 do
        self:AttackEnemy(targetList[i], num)
      end
      num_now = num_now - targetList.Count
      num = num + 1
      goto lbl_25
    else
      for i = 0, num_now - 1 do
        self:AttackEnemy(targetList[i], num)
      end
    end
    LuaSkillCtrl:StartTimer(self, num * self.config.time_loop + self.config.time_loop - 2, function()
      LuaSkillCtrl:BreakCurrentAction(self.caster)
      if self.skillLoop ~= nil then
        self.skillLoop:Die()
        self.skillLoop = nil
      end
      LuaSkillCtrl:StartTimer(self, 1, function()
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
        LuaSkillCtrl:DispelBuff(self.caster, 196, 0)
        self:CancleCasterWait()
      end)
    end)
  end
  local time1 = num * self.config.time_loop + self.config.time_loop
  LuaSkillCtrl:StartShowSkillDurationTime(self, time1)
  self:AddCasterWait(time1 + 2)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, time1, true)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, time1, true)
end

function bs_210201:AttackEnemy(target, num)
  local Time = num * self.config.time_loop
  LuaSkillCtrl:StartTimer(self, Time, function()
    LuaSkillCtrl:CallEffect(target, self.config.effectId_trail2, self, self.OnEffectTrigger)
  end)
end

function bs_210201:OnEffectTrigger(effect, eventId, target)
  if effect.dataId == self.config.effectId_trail2 and eventId == eBattleEffectEvent.Trigger and target ~= nil and target.targetRole.hp > 0 then
    local num = target.targetRole:GetBuffTier(self.config.buffId_js)
    if num <= 4 then
      local hurt = self.arglist[2] + self.arglist[3] * num
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {hurt})
      skillResult:EndResult()
    else
      local hurt2 = self.arglist[2] + self.arglist[3] * 4 + self.arglist[5]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {hurt2})
      skillResult:EndResult()
      LuaSkillCtrl:DispelBuff(target.targetRole, self.config.buffId_js, 0)
    end
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_js, 1, self.arglist[4])
  end
end

function bs_210201:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0)
    LuaSkillCtrl:DispelBuff(self.caster, 196, 0)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
    if self.skillLoop ~= nil then
      self.skillLoop:Die()
      self.skillLoop = nil
    end
  end
end

function bs_210201:OnCasterDie()
  base.OnCasterDie(self)
  if self.skillLoop ~= nil then
    self.skillLoop:Die()
    self.skillLoop = nil
  end
end

return bs_210201
