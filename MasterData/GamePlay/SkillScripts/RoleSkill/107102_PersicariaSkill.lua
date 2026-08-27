local bs_107102 = class("bs_107102", LuaSkillBase)
local base = LuaSkillBase
bs_107102.config = {
  actionId_1 = 1008,
  start_time_1 = 15,
  end_time_1 = 15,
  actionId_loop = 1007,
  actionId_end = 1009,
  buffId = 107101,
  effectId_loopcast = 107108,
  effectId_cast = 107107,
  effect_trail_1 = 107109,
  HurtConfigID = 17,
  weaponLv = 0
}

function bs_107102:ctor()
end

function bs_107102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_107102:PlaySkill(data)
  local num = self.arglist[1]
  if 1 < self.config.weaponLv then
    num = num + self.arglist[4]
  end
  self.loopTime = num * 5
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
    self:OnSkillDamageEnd()
  end, nil)
end

function bs_107102:OnAttackTrigger1()
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
      LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
      LuaSkillCtrl:CallBreakAllSkill(self.caster)
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_cast, self)
    LuaSkillCtrl:StartTimer(nil, 3, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, tar)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
        self.arglist[2]
      })
      skillResult:EndResult()
      if LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[3] then
        LuaSkillCtrl:CallBuff(self, tar, self.config.buffId, 1, 120)
      end
      LuaSkillCtrl:CallEffect(tar, self.config.effect_trail_1, self)
    end, nil, 0, 0)
  end, nil, -1, 5)
end

function bs_107102:SkillEventFunc_1(effect, eventId, target)
  if effect.dataId == self.config.effect_trail_1 and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[2]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId, 1, 120)
    LuaSkillCtrl:CallEffect(target.targetRole, self.config.effect_trail_1, self)
  end
end

function bs_107102:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    self:CancleCasterWait()
  end
end

function bs_107102:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107102
