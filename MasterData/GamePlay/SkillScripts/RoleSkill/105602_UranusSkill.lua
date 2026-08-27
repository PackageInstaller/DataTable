local bs_105602 = class("bs_105602", LuaSkillBase)
local base = LuaSkillBase
bs_105602.config = {
  effectId_skill = 105601,
  actionId = 1002,
  audioId1 = 101003,
  skill_time = 32,
  start_time = 9,
  selectRange = 10,
  selectId2 = 34,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    crithur_ratio = 0
  }
}

function bs_105602:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105602:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, self.cskill.SkillRange) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  if target == nil or target.hp <= 0 then
    return
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
  self.caster:LookAtTarget(target)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, 1, self.config.start_time, attackTrigger)
end

function bs_105602:OnAttackTrigger(target, date)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self, self.OnEffectTrigger)
end

function bs_105602:OnEffectTrigger(effect, eventId, target)
  if effect.dataId == self.config.effectId_skill and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:StartTimer(self, 3, function()
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 34, 10, target.targetRole)
      local skill_end = true
      if targetList.Count >= 1 then
        for i = 0, targetList.Count - 1 do
          if targetList[i].targetRole ~= nil and targetList[i].targetRole ~= target.targetRole then
            skill_end = false
            LuaSkillCtrl:CallEffectWithArgOverride(targetList[i].targetRole, self.config.effectId_skill, self, target.targetRole, false, false, self.OnEffectTrigger2)
            break
          end
        end
      end
      if skill_end == true then
        self:OnSkillDamageEnd()
      end
    end)
  end
end

function bs_105602:OnEffectTrigger2(effect, eventId, target)
  if effect.dataId == self.config.effectId_skill and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[2]
    })
    skillResult:EndResult()
    self:OnSkillDamageEnd()
  end
end

function bs_105602:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105602
