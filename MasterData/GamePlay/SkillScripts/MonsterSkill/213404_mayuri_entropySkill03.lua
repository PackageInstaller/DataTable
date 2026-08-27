local bs_213404 = class("bs_213404", LuaSkillBase)
local base = LuaSkillBase
bs_213404.config = {
  actionId = 1105,
  action_speed = 1,
  skillTime = 83,
  effectId_skill = 213409,
  effectId_aim = 213411,
  HurtConfigID = 3,
  buffId_lockCd = 170
}

function bs_213404:ctor()
end

function bs_213404:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_213404:PlaySkill(data)
  local target
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 87, 10)
  if targetList.Count <= 0 then
    return
  end
  target = targetList[0].targetRole
  self.caster:LookAtTarget(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_aim, self, nil)
  LuaSkillCtrl:StartShowSkillDurationTime(self, 35)
  self:OnSkillTake()
  local time = self.config.skillTime
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId, self.config.action_speed)
  self.Attack_01 = LuaSkillCtrl:StartTimer(self, 36, function()
    self:Attack()
  end, nil)
  self.Attack_02 = LuaSkillCtrl:StartTimer(self, 41, function()
    self:Attack()
  end, nil)
  self.Attack_03 = LuaSkillCtrl:StartTimer(self, 44, function()
    self:Attack()
  end, nil)
  self.Attack_03 = LuaSkillCtrl:StartTimer(self, 47, function()
    self:Attack()
  end, nil)
  self.Attack_03 = LuaSkillCtrl:StartTimer(self, 54, function()
    self:Attack()
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, time, true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  self.callnext = LuaSkillCtrl:StartTimer(self, time, callnextskill)
end

function bs_213404:Attack()
  local target
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 87, 10)
  if targetList.Count <= 0 then
    return
  end
  target = targetList[0].targetRole
  self.caster:LookAtTarget(target)
  local target_grid = LuaSkillCtrl:GetGridWithRole(target)
  LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_skill, self, false, false, self.OnEffectTrigger, target_grid)
end

function bs_213404:OnEffectTrigger(realgrid, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local roles = LuaSkillCtrl:FindRolesAroundGrid(realgrid, 1)
    if roles ~= nil and roles.Count > 0 then
      local num = roles.Count
      for i = 0, roles.Count - 1 do
        if roles[i] ~= nil and 0 < roles[i].hp then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles[i])
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
            self.arglist[1] // num
          })
          skillResult:EndResult()
        end
      end
    end
    local roles_net = LuaSkillCtrl:FindRolesAroundGrid(realgrid, 0)
    if roles_net ~= nil and roles_net.Count > 0 then
      for i = 0, roles_net.Count - 1 do
        if roles_net[i] ~= nil and 0 < roles_net[i].hp then
          local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, roles_net[i])
          LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
            self.arglist[1]
          })
          skillResult:EndResult()
        end
      end
    end
  end
end

function bs_213404:EndSkillAndCallNext()
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

function bs_213404:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_213404
