local bs_202603 = class("bs_202603", LuaSkillBase)
local base = LuaSkillBase
bs_202603.config = {
  effectIdline = 10447,
  effectIdmiao = 10448,
  effectId = 10449,
  effectIdtrail = 10450,
  antion1 = 1008,
  antion2 = 1007,
  antion3 = 1009,
  buffId_196 = 196,
  HurtConfig = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 10055,
    crit_formula = 0
  },
  start_time = 15,
  end_time = 18,
  audioId1 = 318
}

function bs_202603:ctor()
end

function bs_202603:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_202603_10", 1, self.OnRoleDie)
end

function bs_202603:PlaySkill(data)
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
  self.role = target
  if self.role ~= nil then
    self:CallCasterWait(self.config.start_time + self.arglist[1] + self.config.end_time)
    self.caster:LookAtTarget(self.role)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.role)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.antion1, 1, self.config.start_time, attackTrigger)
    local time_196 = self.arglist[1] + self.config.start_time - 1
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, time_196)
    self.loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil, nil, nil, true)
  end
end

function bs_202603:OnAttackTrigger(role)
  self.loopline = LuaSkillCtrl:CallEffect(role, self.config.effectIdline, self, nil, nil, nil, true)
  self.loopMZ = LuaSkillCtrl:CallEffect(role, self.config.effectIdmiao, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.antion2)
  local boom = BindCallback(self, self.Onboom, role)
  LuaSkillCtrl:StartTimer(self, self.arglist[1], boom, self)
end

function bs_202603:OnRoleDie(killer, role)
  if role == self.role then
    self:Onboom(self.role)
  end
end

function bs_202603:Onboom(role)
  if role.hp > 0 and role:IsUnSelect(self.caster) ~= true then
    LuaSkillCtrl:CallEffect(role, self.config.effectIdtrail, self, self.SkillEventFunc)
  end
  if self.loopMZ ~= nil then
    self.loopMZ:Die()
    self.loopMZ = nil
  end
  if self.loopline ~= nil then
    self.loopline:Die()
    self.loopline = nil
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.antion3)
  LuaSkillCtrl:StartTimer(self, self.config.end_time, function()
    if self.loop ~= nil then
      self.loop:Die()
      self.loop = nil
    end
  end)
  self:CancleCasterWait()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.role = nil
end

function bs_202603:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local arg = self.arglist[2]
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {arg}, true)
    skillResult:EndResult()
  end
end

function bs_202603:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_202603:LuaDispose()
  base.LuaDispose(self)
  self.role = nil
  self.loop = nil
  self.loopline = nil
  self.loopMZ = nil
end

return bs_202603
