local bs_213901 = class("bs_213901", LuaSkillBase)
local base = LuaSkillBase
bs_213901.config = {
  time_ready = 7,
  time_end = 23,
  time_freq = 15,
  actionId_1 = 1002,
  action_speed = 1,
  effect_trail_1 = 213903,
  effect_fog = 213904,
  effect_hit = 213902,
  HurtConfigID = 3,
  buff_poison = 213901
}

function bs_213901:ctor()
end

function bs_213901:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.time_fog = self.arglist[2] + 1
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
end

function bs_213901:PlaySkill(data)
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
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  self.caster:LookAtTarget(target)
  local skilltime = self.config.time_ready + self.config.time_end
  self:CallCasterWait(skilltime)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_1, self.config.action_speed, self.config.time_ready, attackTrigger)
end

function bs_213901:OnAttackTrigger(target)
  if target == nil then
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
  LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effect_trail_1, self, self.caster, nil, nil, self.SkillEventFunc_1)
end

function bs_213901:SkillEventFunc_1(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[1]
    })
    skillResult:EndResult()
    self.grid_trigger = LuaSkillCtrl:GetGridWithRole(target.targetRole)
    LuaSkillCtrl:StartTimer(nil, 3, function(csGrid)
      if self.grid_trigger == nil then
        return
      else
        self:fog(csGrid, target.targetRole)
      end
    end, self.grid_trigger)
  end
end

function bs_213901:fog(grid, target)
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
  self.effect_loop = LuaSkillCtrl:CallEffect(gridTarget, self.config.effect_fog, self)
  local trigger_times = self.time_fog // self.config.time_freq
  local times_fog = 0
  local target_trigger = LuaSkillCtrl:GetRoleWithPos(grid.x, grid.y)
  if target_trigger ~= nil and self.effect_loop ~= nil and 0 < target_trigger:GetBuffTier(self.config.buff_poison) then
    LuaSkillCtrl:DispelBuff(target_trigger, self.config.buff_poison, 0)
  end
  self.fogtimer = LuaSkillCtrl:StartTimer(nil, self.config.time_freq, function()
    local target_trigger = LuaSkillCtrl:GetRoleWithPos(grid.x, grid.y)
    if target_trigger ~= nil and self.effect_loop ~= nil then
      local buffTier = target_trigger:GetBuffTier(self.config.buff_poison)
      local hurt = target_trigger.maxHp * (self.arglist[3] + buffTier * self.arglist[5]) // 1000
      LuaSkillCtrl:RemoveLife(hurt, self, target_trigger, true, nil, true, true, eHurtType.RealDmg)
      LuaSkillCtrl:CallEffect(target_trigger, self.config.effect_hit, self)
      LuaSkillCtrl:CallBuff(self, target_trigger, self.config.buff_poison, 1, self.time_fog)
    end
  end, self, trigger_times)
  LuaSkillCtrl:StartTimer(nil, self.time_fog, function()
    if self.fogtimer ~= nil then
      self.fogtimer:Stop()
      self.fogtimer = nil
    end
    self:__killEffectAndAudio(self.effect_loop, nil)
  end)
end

function bs_213901:__killEffectAndAudio(effect, loopAudio)
  if effect ~= nil then
    effect:Die()
    effect = nil
  end
  if loopAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(loopAudio)
  end
end

function bs_213901:OnRoleSplash(role, grid, X, Y)
  if role.belongNum ~= self.caster.belongNum and self.effect_loop ~= nil and X == self.grid_trigger.x and Y == self.grid_trigger.y then
    if self.fogtimer ~= nil then
      self.fogtimer:Stop()
      self.fogtimer = nil
    end
    self:__killEffectAndAudio(self.effect_loop, nil)
  end
end

function bs_213901:OnRolePhaseMoveStart(role, luaskill, X, Y)
  if role.belongNum ~= self.caster.belongNum and self.effect_loop ~= nil and X == self.grid_trigger.x and Y == self.grid_trigger.y then
    if self.fogtimer ~= nil then
      self.fogtimer:Stop()
      self.fogtimer = nil
    end
    self:__killEffectAndAudio(self.effect_loop, nil)
  end
end

function bs_213901:OnCasterDie()
  if self.effect_loop ~= nil then
    self.effect_loop:Die()
    self.effect_loop = nil
  end
  if self.fogtimer ~= nil then
    self.fogtimer:Stop()
    self.fogtimer = nil
  end
  base.OnCasterDie(self)
end

function bs_213901:LuaDispose()
  if self.effect_loop ~= nil then
    self.effect_loop:Die()
    self.effect_loop = nil
  end
  if self.fogtimer ~= nil then
    self.fogtimer:Stop()
    self.fogtimer = nil
  end
  self.grid_trigger = nil
  base.LuaDispose(self)
end

return bs_213901
