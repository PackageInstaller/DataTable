local bs_105502 = class("bs_105502", LuaSkillBase)
local base = LuaSkillBase
bs_105502.config = {
  actionId_start_time = 17,
  actionId_end_time = 34,
  actionId_start = 1008,
  actionId_loop = 1007,
  actionId_end = 1009,
  action_speed = 1,
  buffId_crit1 = 105503,
  buffId_crit2 = 105504,
  effectId = 105506,
  effectId_end = 105516,
  weaponLv = 0
}

function bs_105502:ctor()
end

function bs_105502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105502:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.arglist[1]
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
  end, nil)
  self.OverTime = LuaSkillCtrl:StartTimer(self, self.config.actionId_start_time + self.arglist[1], function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    if self.loop ~= nil then
      self.loop:Die()
      self.loop = nil
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_end, self, nil, nil, nil, true)
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, time, true)
end

function bs_105502:OnAttackTrigger(data)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  self:RemoveSkillTrigger(eSkillTriggerType.RoleDie)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_105502", 10, self.OnRoleDie)
  self.loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil, nil, nil, true)
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      local role = targetList[i]
      if role ~= nil and 0 < role.hp and role.roleType == eBattleRoleType.character then
        LuaSkillCtrl:CallBuff(self, targetList[i], self.config.buffId_crit1, 1, self.arglist[1])
      end
    end
  end
end

function bs_105502:OnRoleDie(killer, role)
  if role.belongNum ~= self.caster.belongNum and (killer.belongNum == self.caster.belongNum or LuaSkillCtrl:GetRoleAllBuffsByFeature(killer, 4)) then
    self:RemoveSkillTrigger(eSkillTriggerType.RoleDie)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
    self:AddCasterWait(self.config.actionId_end_time)
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        local role = targetList[i]
        if role ~= nil and 0 < role.hp and role.roleType == eBattleRoleType.character and 0 < role:GetBuffTier(self.config.buffId_crit1) then
          LuaSkillCtrl:DispelBuff(role, self.config.buffId_crit1, 1)
          LuaSkillCtrl:CallBuff(self, role, self.config.buffId_crit2, 1, self.arglist[3])
        end
      end
    end
    if self.OverTime ~= nil then
      self.OverTime:Stop()
      self.OverTime = nil
    end
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    if self.loop ~= nil then
      self.loop:Die()
      self.loop = nil
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_end, self, nil, nil, nil, true)
  end
end

function bs_105502:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    self:RemoveSkillTrigger(eSkillTriggerType.RoleDie)
    self:CancleCasterWait()
    if self.loop ~= nil then
      self.loop:Die()
      self.loop = nil
      LuaSkillCtrl:DispelBuff(role, 170, 1)
    end
    if self.OverTime ~= nil then
      self.OverTime:Stop()
      self.OverTime = nil
    end
  end
end

function bs_105502:OnCasterDie()
  base.OnCasterDie(self)
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
end

function bs_105502:LuaDispose()
  base.LuaDispose(self)
  self.loop = nil
end

return bs_105502
