local bs_1037022 = class("bs_1037022", LuaSkillBase)
local base = LuaSkillBase
bs_1037022.config = {
  effectId_start = 10329,
  effectId_skill = 10330,
  effectId_ex_skill = 10801,
  selectId_1 = 15,
  selectRange_1 = 20,
  selectId_2 = 19,
  selectRange_2 = 20,
  HurtConfig1 = {
    hit_formula = 0,
    basehurt_formula = 10076,
    crit_formula = 0,
    crithur_ratio = 0
  },
  HurtConfig_aoe = {
    basehurt_formula = 502,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  Aoe = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 2
  },
  skill_ex_time = 10,
  audioId1 = 287,
  audioId2 = 288,
  audioId3 = 289
}

function bs_1037022:ctor()
end

function bs_1037022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1037022_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, 1037022)
  self.mainTarget = nil
end

function bs_1037022:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and target == self.mainTarget and not isMiss and isTriggerSet ~= true and target.belongNum ~= self.caster.belongNum and 0 < hurt then
    local realHurt = hurt * self.arglist[2] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.Aoe)
    for i = 0, skillResult.roleList.Count - 1 do
      local role = skillResult.roleList[i]
      LuaSkillCtrl:CallRealDamage(self, role, nil, self.config.HurtConfig_aoe, {realHurt}, true)
    end
    skillResult:EndResult()
    self.mainTarget = nil
  end
end

function bs_1037022:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_1, self.config.selectRange_1)
  if targetList.Count <= 0 then
    return
  end
  self:CallCasterWait(15)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList[0].targetRole)
  self.caster:LookAtTarget(targetList[0].targetRole)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 2, 7, attackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
end

function bs_1037022:OnAttackTrigger(target)
  self.mainTarget = target
  LuaSkillCtrl:PlayAuSource(target, self.config.audioId2)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self, self.SkillEventFunc)
end

function bs_1037022:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(nil, 11, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig1)
      skillResult:EndResult()
    end, nil)
  end
end

function bs_1037022:LuaDispose()
  base.LuaDispose(self)
  self.mainTarget = nil
end

function bs_1037022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1037022
