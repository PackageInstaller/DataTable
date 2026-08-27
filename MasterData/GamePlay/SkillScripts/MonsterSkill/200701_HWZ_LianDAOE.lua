local bs_40012 = class("bs_40012", LuaSkillBase)
local base = LuaSkillBase
bs_40012.config = {
  hurt_config = {
    basehurt_formula = 10007,
    hit_formula = 10201,
    crit_formula = 0,
    correct_formula = 9989,
    spell_lifesteal_formula = 10102
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  startAnimId = 1002,
  effectId = 10117,
  effectId1 = 10118,
  audioId1 = 55,
  select_id = 1001,
  select_range = 0,
  passive_select_id = 9,
  passive_select_range = 0,
  skill_time = 23,
  start_time = 11
}

function bs_40012:ctor()
end

function bs_40012:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_40012:PlaySkill(data)
  if self.config.audioId1 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
  local lastAtkRole = self.caster.recordTable.lastAttackRole
  if lastAtkRole ~= nil then
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, lastAtkRole, 1) then
      self:CallCasterWait(self.config.skill_time)
      self.caster:LookAtTarget(lastAtkRole)
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.startAnimId, 1)
      LuaSkillCtrl:CallEffect(lastAtkRole, self.config.effectId, self, self.SkillEventFunc, nil, 1)
    else
      self:BreakSkill()
    end
  else
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
    if targetlist.Count > 0 then
      if LuaSkillCtrl:IsAbleAttackTarget(self.caster, targetlist[0].targetRole, 1) then
        self:CallCasterWait(self.config.skill_time)
        self.caster:LookAtTarget(targetlist[0])
        LuaSkillCtrl:CallRoleAction(self.caster, self.config.startAnimId, 1)
        LuaSkillCtrl:CallEffect(targetlist[0], self.config.effectId, self, self.SkillEventFunc, nil, 1)
      else
        self:BreakSkill()
      end
    end
  end
end

function bs_40012:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if self.caster.recordTable.life_num ~= nil then
      local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.passive_select_id, self.config.passive_select_range)
      if targetlist.Count > 0 then
        self.life_num = self.caster.recordTable.life_num * targetlist.Count
      end
    else
      self.life_num = 0
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    if skillResult.roleList.Count ~= 0 then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        if LuaSkillCtrl:IsRoleAdjacent(role, self.caster) then
          LuaSkillCtrl:StartTimer(nil, self.config.start_time, function()
            LuaSkillCtrl:CallEffect(role, self.config.effectId1, self, self.HurtFunc, nil, 1, false)
            LuaSkillCtrl:PlayAuHit(self, target)
          end, nil, 0)
        end
      end
    end
    skillResult:EndResult()
  end
end

function bs_40012:HurtFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.life_num
    })
    skillResult:EndResult()
  end
end

function bs_40012:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_40012
