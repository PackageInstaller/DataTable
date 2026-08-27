local bs_104702 = class("bs_104702", LuaSkillBase)
local base = LuaSkillBase
bs_104702.config = {
  effectId = 104703,
  effectId2 = 104709,
  effectId3 = 104715,
  buffId_Da = 104701,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0
  },
  speed = 1,
  action_speed = 1,
  skill_time = 25,
  actionId = 1002,
  selectId = 65,
  selectRange = 10,
  audioId_hit = 104706,
  start_time = 22
}

function bs_104702:ctor()
end

function bs_104702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("104702_14", 90, self.OnSetHurt)
end

function bs_104702:PlaySkill(data)
  local target = self.caster
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectRange)
  if target == self.caster or target.roleType ~= eBattleRoleType.character then
    for i = 0, targetList.Count - 1 do
      if targetList[i].targetRole.roleType == eBattleRoleType.character then
        target = targetList[i].targetRole
        break
      end
    end
  end
  if target ~= nil and target.roleType == eBattleRoleType.character then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time + 2)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  else
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
  end
end

function bs_104702:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
  if target.hp > 0 then
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
  end
  if target.hp <= 0 then
    local target_new = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 0)
    if 0 < target_new.Count then
      LuaSkillCtrl:CallEffect(target_new[0].targetRole, self.config.effectId, self, self.SkillEventFunc)
    end
  end
end

function bs_104702:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and effect.dataId == self.config.effectId then
    LuaSkillCtrl:PlayAuSource(target, self.config.audioId_hit)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectRange)
    LuaSkillCtrl:CallEffect(target, self.config.effectId3, self)
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_Da, 1, self.arglist[2])
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Da, 1, self.arglist[2])
    LuaSkillCtrl:StartTimer(nil, self.arglist[2], function()
      self:OnSkillDamageEnd()
    end)
  end
end

function bs_104702:OnSetHurt(context)
  if context.sender:GetBuffTier(self.config.buffId_Da) > 0 and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.skill.isCommonAttack then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    local prob = self.arglist[1]
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {prob})
    skillResult:EndResult()
  end
end

function bs_104702:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_104702
