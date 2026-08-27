local bs_210601 = class("bs_210601", LuaSkillBase)
local base = LuaSkillBase
bs_210601.config = {
  buffId_critcore = 210602,
  buffId_lockCd = 170,
  buffId_debuff = 210601,
  effect_hit = 210603,
  effect_atk = 210604,
  actionId_start = 1008,
  actionId_loop = 1007,
  actionId_end = 1009,
  action_speed = 1,
  actionId_start_time = 15,
  actionId_end_time = 40,
  configId = 3
}

function bs_210601:ctor()
end

function bs_210601:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.loopTime = self.arglist[1]
end

function bs_210601:PlaySkill(data)
  self:OnSkillTake()
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.loopTime
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  self.loopAttack = LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
  end, nil)
  self.finishAttack = LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time + self.loopTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    if self.effect_atk ~= nil then
      self.effect_atk:Die()
      self.effect_atk = nil
    end
    if self.atk ~= nil then
      self.atk:Stop()
      self.atk = nil
    end
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, time, true)
  self:AbandonSkillCdAutoReset(true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  self.callnext = LuaSkillCtrl:StartTimer(self, time, callnextskill)
end

function bs_210601:OnAttackTrigger(data)
  if self.caster:GetBuffTier(self.config.buffId_critcore) > 0 then
    LuaSkillCtrl:StartShowSkillDurationTime(self, self.loopTime + 2)
    self.effect_atk = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_atk, self)
    LuaSkillCtrl:CallBattleCamShakeByParam(0, 1, 0.5, 50)
    self.atk = LuaSkillCtrl:StartTimer(nil, 15, function()
      LuaSkillCtrl:CallBattleCamShakeByParam(0, 2, 0.5, 50)
      if LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.Exiled) then
        if self.effect_atk ~= nil then
          self.effect_atk:Die()
          self.effect_atk = nil
        end
        if self.atk ~= nil then
          self.atk:Stop()
          self.atk = nil
        end
        if self.callnext ~= nil then
          self.callnext:Stop()
          self.callnext = nil
        end
        LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
        local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
        LuaSkillCtrl:StartTimer(self, self.config.actionId_end_time, callnextskill)
      end
      if self.caster:GetBuffTier(self.config.buffId_critcore) == 0 then
        if self.effect_atk ~= nil then
          self.effect_atk:Die()
          self.effect_atk = nil
        end
        if self.atk ~= nil then
          self.atk:Stop()
          self.atk = nil
        end
        if self.callnext ~= nil then
          self.callnext:Stop()
          self.callnext = nil
        end
        LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
        local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
        LuaSkillCtrl:StartTimer(self, self.config.actionId_end_time, callnextskill)
      end
      local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
      if 0 < targetList.Count then
        for i = targetList.Count - 1, 0, -1 do
          local role = targetList[i]
          if role ~= nil and 0 < role.hp then
            LuaSkillCtrl:CallBuff(self, role, self.config.buffId_debuff, 1, self.arglist[4])
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
            LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
              self.arglist[2]
            })
            skillResult:EndResult()
            LuaSkillCtrl:CallEffect(role, self.config.effect_hit, self)
          end
        end
      end
    end, nil, -1, 10)
  elseif self.caster:GetBuffTier(self.config.buffId_critcore) == 0 then
    if self.callnext ~= nil then
      self.callnext:Stop()
      self.callnext = nil
    end
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
    LuaSkillCtrl:StartTimer(self, self.config.actionId_end_time, callnextskill)
  end
end

function bs_210601:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if self.effect_atk ~= nil then
    self.effect_atk:Die()
    self.effect_atk = nil
  end
  if self.atk ~= nil then
    self.atk:Stop()
    self.atk = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
end

function bs_210601:EndSkillAndCallNext()
  if self.effect_atk ~= nil then
    self.effect_atk:Die()
    self.effect_atk = nil
  end
  if self.atk ~= nil then
    self.atk:Stop()
    self.atk = nil
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_critcore, 1, nil)
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

function bs_210601:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect_atk ~= nil then
    self.effect_atk:Die()
    self.effect_atk = nil
  end
  if self.atk ~= nil then
    self.atk:Stop()
    self.atk = nil
  end
end

function bs_210601:LuaDispose()
  base.LuaDispose(self)
  self.effect_atk = nil
  self.atk = nil
  self.callnext = nil
end

return bs_210601
