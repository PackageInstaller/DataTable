local bs_300003 = class("bs_300003", LuaSkillBase)
local base = LuaSkillBase
bs_300003.config = {
  aoe_config = {
    effect_shape = 1,
    aoe_select_code = 4,
    aoe_range = 10
  },
  effectCFId = 123,
  startEffectId = 10105,
  endEffectId = 10106,
  buffId_67 = 67,
  buffId_1002 = 1002,
  buffID_1158 = 1158,
  maxHPId = 1003,
  buffTier = 1,
  startAnimId = 1002,
  loopAnimId = 1007,
  endAnimId = 1009,
  audioId1 = 48,
  audioId_end = 388,
  buffId_196 = 196,
  HealConfig = {baseheal_formula = 501},
  skill_time = 33,
  skill_speed = 1,
  start_time = 14
}

function bs_300003:ctor()
end

function bs_300003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_300003_1", 100, self.OnSetHurt, nil, self.caster)
end

function bs_300003:PlaySkill(data)
  self:AbandonSkillCdAutoReset(true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, self.arglist[1] + self.config.skill_time)
  local actionTotalTime = self.config.skill_time + self.arglist[1]
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.caster, data)
  self:CallCasterWait(actionTotalTime)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.startEffectId, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, self.config.skill_speed, self.config.start_time, attackTrigger)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_1158, 1)
end

function bs_300003:OnSetHurt(context)
  if context.target ~= self.caster then
    return
  end
  if self.caster:GetBuffTier(self.config.buffId_1002) > 0 and context.isTriggerSet ~= true and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.hurt_type ~= 2 then
    local damageNum = context.hurt
    context.hurt = 0
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.HealConfig, {damageNum})
    skillResult:EndResult()
  end
end

function bs_300003:OnAttackTrigger(target, data)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectCFId, self, nil, nil, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1002, 1, self.arglist[1])
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
  skillResult:BuffResult(self.config.buffId_67, self.config.buffTier, self.arglist[1])
  skillResult:EndResult()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.loopAnimId, 1)
  LuaSkillCtrl:StartTimer(self, self.arglist[1], self.CallBack, self, 0, 0)
end

function bs_300003:CallBack()
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  end
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_end)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.endAnimId, 1)
  LuaSkillCtrl:CallEffect(self.caster, self.config.endEffectId, self)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1158, 0)
  self:CancleCasterWait()
  self:CallNextBossSkill()
end

function bs_300003:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_300003:LuaDispose()
  base.LuaDispose(self)
  self.loopaudio = nil
  self.effect = nil
end

return bs_300003
