local bs_106502 = class("bs_106502", LuaSkillBase)
local base = LuaSkillBase
bs_106502.config = {
  start_time = 15,
  start_time2 = 4,
  start_time3 = 5,
  start_time4 = 6,
  skill_time = 58,
  actionId = 1105,
  action_speed = 1,
  effectId_1 = 106503,
  effectId_2 = 106504,
  effectId_3 = 106505,
  effectId_4 = 106506,
  effectId_5 = 106508,
  effectId_6 = 106509,
  effectId_self_1 = 106508,
  effectId_self_2 = 106509,
  HurtConfigId = 2,
  buffId_stun = 106507,
  buffId_196 = 196,
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  weaponLv = 0
}

function bs_106502:ctor()
end

function bs_106502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106502:PlaySkill(data)
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
    local effectTarget = LuaSkillCtrl:GetTargetWithGrid(target.x, target.y)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, effectTarget, self.caster.x, self.caster.y)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, self.config.skill_time)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_5, self)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_6, self)
  end
end

function bs_106502:OnAttackTrigger(target, x, y)
  local skillEnd = self:OnMoveEs(x, y)
  if skillEnd == false then
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_1, self)
  self:OnHurt(target, 1)
  LuaSkillCtrl:StartTimer(self, self.config.start_time2, function()
    local skillEnd = self:OnMoveEs(x, y)
    if skillEnd == false then
      return
    end
    LuaSkillCtrl:CallEffect(target, self.config.effectId_2, self)
    self:OnHurt(target, 2)
    LuaSkillCtrl:StartTimer(self, self.config.start_time3, function()
      local skillEnd = self:OnMoveEs(x, y)
      if skillEnd == false then
        return
      end
      LuaSkillCtrl:CallEffect(target, self.config.effectId_3, self)
      self:OnHurt(target, 3)
      LuaSkillCtrl:StartTimer(self, self.config.start_time4, function()
        local skillEnd = self:OnMoveEs(x, y)
        if skillEnd == false then
          return
        end
        LuaSkillCtrl:CallEffect(target, self.config.effectId_4, self)
        self:OnHurt(target, 4)
      end)
    end)
  end)
end

function bs_106502:OnMoveEs(x, y)
  if self.caster.x ~= x or self.caster.y ~= y then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    return false
  else
    return true
  end
end

function bs_106502:OnHurt(target, time)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe)
  local num = skillResult.roleList.Count
  for i = 0, skillResult.roleList.Count - 1 do
    local role = skillResult.roleList[i]
    if LuaSkillCtrl:IsFixedObstacle(role) then
      num = num - 1
    end
  end
  for i = 0, skillResult.roleList.Count - 1 do
    local role = skillResult.roleList[i]
    if LuaSkillCtrl:IsFixedObstacle(role) ~= true then
      if time ~= 4 and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_stun, 1, self.arglist[3])
      end
      if time == 4 then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_stun, 1, self.arglist[4])
        if 2 <= self.config.weaponLv then
          role:TryCallBreakNumChange(-self.arglist[7])
        end
      end
      local hurt = self.arglist[1] // num
      if 2 <= self.config.weaponLv then
        hurt = hurt + self.arglist[6]
      end
      local onCtrl = LuaSkillCtrl:RoleContainsCtrlBuff(role)
      if onCtrl == true then
        hurt = hurt * (1000 + self.arglist[5]) // 1000
        LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.OnLindHurt, 2, role)
      end
      local skillResult2 = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult2, self.config.HurtConfigId, {hurt})
      skillResult2:EndResult()
    end
  end
  skillResult:EndResult()
  if time == 4 then
    self:OnSkillDamageEnd()
  end
end

function bs_106502:OnBreakSkill(role)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 0)
  self:CancleCasterWait()
  base.OnBreakSkill(self, role)
end

function bs_106502:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106502
