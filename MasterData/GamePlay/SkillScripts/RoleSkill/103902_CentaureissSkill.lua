local bs_103902 = class("bs_103902", LuaSkillBase)
local base = LuaSkillBase
bs_103902.config = {
  buffId_196 = 196,
  buffId_170 = 170,
  buffId_66 = 66,
  buffId_151 = 151,
  buffId_259 = 259,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    returndamage_formula = 0
  },
  aoe = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  beatBackBuff = 151,
  stunBuff = 66,
  effectIdStart = 10465,
  effectIdEnd = 10468,
  effectIdAttack = 10467,
  effectIdAttackSj = 10516,
  effectIdSj = 10469,
  effectIdEnd2 = 10535,
  effectIdAttack2 = 10534,
  actionIdStart1 = 1008,
  actionIdLoop1 = 1007,
  actionIdEnd1 = 1009,
  actionIdStart2 = 1022,
  actionIdLoop2 = 1023,
  actionIdEnd2 = 1024,
  effectId_high = 103904,
  skill_time = 65,
  start_time = 17,
  action_speed = 1,
  audioId1 = 298,
  audioId2 = 299
}

function bs_103902:ctor()
end

function bs_103902:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_103902:PlaySkill(data)
  self.effectEnd = self.config.effectIdEnd
  if LuaSkillCtrl:CallRange(1, 1000) <= 500 then
    self.actionStart = self.config.actionIdStart1
    self.actionLoop = self.config.actionIdLoop1
    self.actionEnd = self.config.actionIdEnd1
    self.effectAttack = self.config.effectIdAttack
  else
    self.actionStart = self.config.actionIdStart2
    self.actionLoop = self.config.actionIdLoop2
    self.actionEnd = self.config.actionIdEnd2
    self.effectAttack = self.config.effectIdAttack2
  end
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
  if target ~= nil then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, self.arglist[1], true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[1], true)
    self:CallCasterWait(self.config.skill_time)
    self.caster:LookAtTarget(target)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.actionStart, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_66, 1, self.arglist[1])
  end
end

function bs_103902:OnAttackTrigger(target)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, 1) then
    LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1] - self.config.start_time)
    self.caster:LookAtTarget(target)
    self.effectIdAttack = LuaSkillCtrl:CallEffect(target, self.effectAttack, self, nil, nil, 1, true)
    self.effectIdAttackSj = LuaSkillCtrl:CallEffect(target, self.config.effectIdAttackSj, self, nil, nil, 1, true)
    self.effectIdStart = LuaSkillCtrl:CallEffect(target, self.config.effectIdStart, self, nil, nil, 1, true)
    self.num = self.arglist[2]
    local time = self.num
    for i = 1, time do
      LuaSkillCtrl:StartTimer(self, self.num * 3, function()
        self:hurtUnit(target)
      end, self, 0, 2)
      self.num = self.num - 1
    end
    LuaSkillCtrl:StartTimer(self, time * 3, function()
      self:finalAttack(target)
    end)
  else
    self:finalAttack(target)
  end
end

function bs_103902:hurtUnit(target)
  if target == nil or target.hp <= 0 then
    self:finalAttack(target)
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
    self.arglist[3]
  })
  skillResult:EndResult()
end

function bs_103902:finalAttack(target)
  if self.effectIdAttack ~= nil then
    self.effectIdAttack:Die()
    self.effectIdAttack = nil
  end
  if self.effectIdAttackSj ~= nil then
    self.effectIdAttackSj:Die()
    self.effectIdAttackSj = nil
  end
  if self.effectIdStart ~= nil then
    self.effectIdStart:Die()
    self.effectIdStart = nil
  end
  if target ~= nil and target.hp > 0 and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, 1) then
    LuaSkillCtrl:CallRoleAction(self.caster, self.actionEnd, 1)
    LuaSkillCtrl:StartTimer(self, 8, function()
      self.effectIdEnd = LuaSkillCtrl:CallEffect(target, self.effectEnd, self, nil, nil, 1, true)
      self.effectIdSj = LuaSkillCtrl:CallEffect(target, self.config.effectIdSj, self, nil, nil, 1, true)
      LuaSkillCtrl:PlayAuSource(target, self.config.audioId2)
      LuaSkillCtrl:CallBuffLifeEvent(self, target, self.config.buffId_259, 1, 5, BindCallback(self, self.OnBuffLifeEvent, target))
      LuaSkillCtrl:StartTimer(nil, 5, function()
        LuaSkillCtrl:CallEffect(target, self.config.effectId_high, self)
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe)
        for i = 0, skillResult.roleList.Count - 1 do
          LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_66, 1, self.arglist[5])
        end
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
          self.arglist[3]
        })
        skillResult:EndResult()
      end)
      self:OnSkillDamageEnd()
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 1, true)
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
    end)
  else
    LuaSkillCtrl:CallRoleAction(self.caster, self.actionEnd, 1)
    self:CancleCasterWait()
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 1, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 0, true)
    self:OnSkillDamageEnd()
  end
end

function bs_103902:OnBuffLifeEvent(role, lifeType, arg)
  if lifeType == eBuffLifeEvent.NewAdd then
    LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(1.4, 1.4, 0.6), 0.2)
    LuaSkillCtrl:StartTimer(self, 3, function()
      LuaSkillCtrl:CallStartLocalScale(role, Vector3.New(1, 1, 1), 0.2)
    end)
  end
end

function bs_103902:OnBreakSkill(role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 1, true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_170, 1, true)
    if self.effectIdAttack ~= nil then
      self.effectIdAttack:Die()
      self.effectIdAttack = nil
    end
    if self.effectIdAttackSj ~= nil then
      self.effectIdAttackSj:Die()
      self.effectIdAttackSj = nil
    end
    if self.effectIdStart ~= nil then
      self.effectIdStart:Die()
      self.effectIdStart = nil
    end
    self:CancleCasterWait()
  end
  base.OnBreakSkill(self, role)
end

function bs_103902:OnCasterDie()
  if not LuaSkillCtrl.IsInVerify and LuaSkillCtrl.IsInTDBattle then
    LuaSkillCtrl:BreakCurrentAction(self.caster)
  end
  base.OnCasterDie(self)
  if self.effectIdStart ~= nil then
    self.effectIdStart:Die()
    self.effectIdStart = nil
  end
  if self.effectIdAttack ~= nil then
    self.effectIdAttack:Die()
    self.effectIdAttack = nil
  end
  if self.effectIdAttackSj ~= nil then
    self.effectIdAttackSj:Die()
    self.effectIdAttackSj = nil
  end
end

function bs_103902:LuaDispose()
  base.LuaDispose(self)
  self.effectIdAttackSj = nil
  self.effectIdAttack = nil
  self.effectIdStart = nil
  self.effectIdEnd = nil
  self.effectIdSj = nil
end

return bs_103902
