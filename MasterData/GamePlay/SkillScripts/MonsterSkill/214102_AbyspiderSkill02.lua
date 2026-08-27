local bs_214102 = class("bs_214102", LuaSkillBase)
local base = LuaSkillBase
bs_214102.config = {
  HurtConfigID = 2,
  HurtConfigID2 = 3,
  actionId1 = 1002,
  actionId2 = 1105,
  action_speed = 1,
  actionId_start_time = 7,
  skilltime = 22,
  buffId_lockCd = 170,
  buff_id_jiejian = 214102,
  buff_id_poison = 214103,
  effect_cast = 214105,
  effect_hit = 214106,
  effect_cast2 = 214107,
  effect_hit2 = 214108,
  effect_posion_hit = 214109
}

function bs_214102:ctor()
end

function bs_214102:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.onCastSkill = false
end

function bs_214102:PlaySkill(data)
  local target
  if self.caster.recordTable.lastAttackRole ~= nil then
    target = self.caster.recordTable.lastAttackRole
  else
    local targets = LuaSkillCtrl:CallTargetSelect(self, 33, 1)
    for i = 0, targets.Count - 1 do
      local role = targets[i].targetRole
      if not LuaSkillCtrl:IsObstacle(role) then
        target = role
      end
    end
  end
  if target ~= nil then
    self.caster:LookAtTarget(target)
    self.onCastSkill = true
    local time = self.config.skilltime
    if target:GetBuffTier(self.config.buff_id_jiejian) == 0 then
      LuaSkillCtrl:CallEffect(self.caster, self.config.effect_cast, self, nil)
      local attackTrigger = BindCallback(self, self.OnAttackTrigger1, target)
      self:CallCasterWait(time)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId1, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
    else
      LuaSkillCtrl:CallEffect(self.caster, self.config.effect_cast2, self, nil)
      local attackTrigger = BindCallback(self, self.OnAttackTrigger2, target)
      self:CallCasterWait(time)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId2, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, time, true)
    local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
    LuaSkillCtrl:StartTimer(self, time, callnextskill)
  end
end

function bs_214102:OnAttackTrigger1(target)
  if target == nil or target.hp <= 0 then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
    self.arglist[1]
  })
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(target, self.config.effect_hit, self, nil)
end

function bs_214102:OnAttackTrigger2(target)
  if target == nil or target.hp <= 0 then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    return
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
    self.arglist[2]
  })
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(target, self.config.effect_hit2, self, nil)
  LuaSkillCtrl:CallBuffRepeated(self, target, self.config.buff_id_poison, 1, self.arglist[3], false, false, self.OnBuffExecute)
end

function bs_214102:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  local hurtnum = self.arglist[4]
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID2, {hurtnum}, true)
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(targetRole, self.config.effect_posion_hit, self, nil)
end

function bs_214102:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if self.onCastSkill == true then
    self:EndSkillAndCallNext()
  end
end

function bs_214102:EndSkillAndCallNext()
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

function bs_214102:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_214102:LuaDispose()
  base.LuaDispose(self)
end

return bs_214102
