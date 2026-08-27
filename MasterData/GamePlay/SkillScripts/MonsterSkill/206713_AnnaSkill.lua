local bs_206713 = class("bs_206713", LuaSkillBase)
local base = LuaSkillBase
bs_206713.config = {
  effectId_line = 100207,
  effectId_trail = 100208,
  effect_buff = 100206,
  selectId_skill = 15,
  select_range = 10,
  buffId_cockhourse = 3010,
  tier_skill = 1,
  time = nil,
  tier = 1,
  skill_speed = 1,
  actionId = 1002,
  skill_time = 15,
  start_time = 9,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  }
}

function bs_206713:ctor()
end

function bs_206713:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_206713:PlaySkill(data)
  local target = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, self.config.select_range)
  if target == nil then
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target[0].targetRole)
    self.caster:LookAtTarget(target[0].targetRole)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.skill_speed, self.config.start_time, attackTrigger)
  end
end

function bs_206713:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_line, self)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self, self.SkillEventFunc)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:PlayAuHit(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
    self.arglist[1]
  }, false, false)
  LuaSkillCtrl:CallBuff(self, target, self.config.buffId_cockhourse, self.config.tier_skill, self.config.time)
  skillResult:EndResult()
  local transferList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if transferList ~= nil and transferList.Count > 0 then
    for i = 0, transferList.Count - 1 do
      local OtherTarget = transferList[i].targetRole
      if OtherTarget ~= target and OtherTarget.belongNum ~= eBattleRoleBelong.neutral then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
          self.arglist[2]
        }, false, false)
        LuaSkillCtrl:CallEffect(OtherTarget, self.config.effectId_line, self, nil, target)
        LuaSkillCtrl:CallEffect(OtherTarget, self.config.effectId_trail, self, self.SkillEventFunc_extra, target)
        LuaSkillCtrl:CallBuff(self, OtherTarget, self.config.buffId_cockhourse, self.config.tier_skill, self.config.time)
        skillResult:EndResult()
      end
    end
  end
end

function bs_206713:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_206713
