local bs_1001022 = class("bs_1001022", LuaSkillBase)
local base = LuaSkillBase
bs_1001022.config = {
  heal_config = {baseheal_formula = 100101},
  effectId_line = 100105,
  effectId_trail = 100106,
  effectId_hit = 100107,
  selectId = 24,
  selectRange = 10,
  skill_time = 12,
  start_time = 6,
  actionId = 1002,
  act_speed = 1,
  time_heal = 3
}

function bs_1001022:ctor()
end

function bs_1001022:InitSkill(isMidwaySkill)
end

function bs_1001022:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectRange)
  if targetList.Count == 0 then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self.caster:LookAtTarget(targetList[0].targetRole)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList[0].targetRole, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.act_speed, self.config.start_time, attackTrigger)
end

function bs_1001022:OnAttackTrigger(target, data)
  self:RealPlaySkill(nil, target, 1)
end

function bs_1001022:RealPlaySkill(sender, target, healId)
  if sender == nil then
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_trail, self, false, false, self.SkillEventFunc, healId)
    if target ~= self.caster then
      LuaSkillCtrl:CallEffect(target, self.config.effectId_line, self, nil, sender)
    end
  else
    LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, sender, false, false, self.SkillEventFunc, healId)
  end
  if sender == nil and target == self.caster then
    return
  end
end

function bs_1001022:SkillEventFunc(healId, effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(nil, self.config.time_heal, BindCallback(self, self.CallBack, target.targetRole, healId))
    if healId <= self.arglist[2] then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, self.config.selectRange)
      if targetList.Count == 0 then
        return
      end
      for i = 0, targetList.Count - 1 do
        if targetList[i].targetRole ~= nil and targetList[i].targetRole ~= target.targetRole then
          self:RealPlaySkill(target.targetRole, targetList[i].targetRole, healId + 1)
          LuaSkillCtrl:CallEffect(targetList[i].targetRole, self.config.effectId_line, self, nil, target.targetRole)
        end
      end
    end
  end
end

function bs_1001022:CallBack(targetRole, healId)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {healId}, false, false)
  skillResult:EndResult()
end

function bs_1001022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1001022
