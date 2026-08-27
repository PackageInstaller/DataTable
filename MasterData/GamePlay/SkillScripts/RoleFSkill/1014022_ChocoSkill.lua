local bs_1014022 = class("bs_1014022", LuaSkillBase)
local base = LuaSkillBase
bs_1014022.config = {
  effectId_skill = 101405,
  effectId_trail = 101407,
  skill_time = 35,
  start_time = 17,
  actionId = 1002,
  action_speed = 1,
  audioId1 = 191,
  select_id = 14,
  select_range = 10,
  buffId_cookie = 101401,
  heal_config = {baseheal_formula = 3021}
}

function bs_1014022:ctor()
end

function bs_1014022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1014022:PlaySkill(data)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetList.Count == 0 then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  if targetList[0].targetRole ~= nil then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_skill, self, nil, nil, nil, true)
    self.caster:LookAtTarget(targetList[0].targetRole)
    self:CallCasterWait(self.config.skill_time)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, targetList[0].targetRole, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  end
end

function bs_1014022:OnAttackTrigger(target, data)
  if target == nil or target.hp <= 0 then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self, self.SkillEventFunc)
end

function bs_1014022:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, self.config.buffId_cookie, 1, self.arglist[1], nil, false, self.OnBuffExecute)
  end
end

function bs_1014022:OnBuffExecute(buff, targetRole)
  if targetRole:GetBuffTier(self.config.buffId_cookie) > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {
      self.arglist[4]
    })
    skillResult:EndResult()
  end
end

function bs_1014022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1014022
