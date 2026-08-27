local bs_203207 = class("bs_203207", LuaSkillBase)
local base = LuaSkillBase
bs_203207.config = {
  buffId_196 = 196,
  buffId_170 = 170,
  buffId_66 = 66,
  buffId_151 = 151,
  buffId_259 = 259,
  effectIdline = 10920,
  effectIdmiao = 10448,
  effectId = 10449,
  effectIdtrail = 10450,
  antion1 = 1008,
  antion2 = 1007,
  antion3 = 1009,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10032,
    crit_formula = 0
  },
  start_time = 15,
  end_time = 18,
  audioId1 = 318,
  buffID_1158 = 1158,
  buffId_yun = 66
}

function bs_203207:ctor()
end

function bs_203207:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_203207:PlaySkill(data)
  local target
  local lastAttackRole = self.caster.recordTable.lastAttackRole
  if lastAttackRole ~= nil and lastAttackRole.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, lastAttackRole, 1) then
    target = lastAttackRole
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget ~= nil then
      target = tempTarget.targetRole
    end
  end
  self.role = target
  if self.role ~= nil then
    self:CallCasterWait(self.config.start_time + self.arglist[1] + self.config.end_time)
    self:AbandonSkillCdAutoReset(true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_1158, 1, self.config.start_time + self.arglist[1] + self.config.end_time, true)
    self.caster:LookAtTarget(self.role)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.role)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.antion1, 1, self.config.start_time, attackTrigger)
    local time_196 = self.arglist[1] + self.config.start_time - 1
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, time_196)
    self.loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil, nil, nil, true)
  end
end

function bs_203207:OnAttackTrigger(role)
  self.loopline = LuaSkillCtrl:CallEffect(role, self.config.effectIdline, self, nil, nil, nil, true)
  self.loopMZ = LuaSkillCtrl:CallEffect(role, self.config.effectIdmiao, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.antion2)
  local boom = BindCallback(self, self.Onboom, role)
  LuaSkillCtrl:StartTimer(self, self.arglist[1], boom, self)
end

function bs_203207:Onboom(role)
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
  self:CallNextBossSkill()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1158, 0)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.role = nil
end

function bs_203207:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if target ~= nil and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target.targetRole, 10) then
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_259, 1, 6)
      LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_yun, 1, self.arglist[3])
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 1, true)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
      skillResult:EndResult()
    else
      self:CancleCasterWait()
      self:CallNextBossSkill()
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1158, 0)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 1, true)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
    end
  end
end

function bs_203207:OnBreakSkill(role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 1, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 1, true)
    self:CancleCasterWait()
    self:CallNextBossSkill()
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1158, 0)
  end
  base.OnBreakSkill(self, role)
end

function bs_203207:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_203207:LuaDispose()
  base.LuaDispose(self)
  self.role = nil
  if self.loop ~= nil then
    self.loop:Die()
    self.loop = nil
  end
  if self.loopline ~= nil then
    self.loopline:Die()
    self.loopline = nil
  end
  if self.loopMZ ~= nil then
    self.loopMZ:Die()
    self.loopMZ = nil
  end
end

return bs_203207
