local bs_1022022 = class("bs_1022022", LuaSkillBase)
local base = LuaSkillBase
bs_1022022.config = {
  effectId_skill = 102210,
  effectId_hit = 102211,
  hurt_config = {hit_formula = 0, basehurt_formula = 3000},
  skill_time = 36,
  start_time = 11,
  actionId = 1002,
  action_speed = 1,
  skill_selectId = 1001,
  audioId1 = 234,
  audioId2 = 235
}

function bs_1022022:ctor()
end

function bs_1022022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1022022:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local moveTarget = self:GetMoveSelectTarget()
    if moveTarget ~= nil then
      target = moveTarget.targetRole
    end
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self, nil, nil, nil, true)
  end
end

function bs_1022022:OnAttackTrigger(Target)
  LuaSkillCtrl:CallEffect(Target, self.config.effectId_hit, self)
  local arg = 0
  for i = 1, self.arglist[1] do
    LuaSkillCtrl:StartTimer(nil, (self.arglist[1] - i) * 2, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, Target)
      LuaSkillCtrl:PlayAuSource(Target, self.config.audioId2)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.arglist[2]
      })
      skillResult:EndResult()
    end)
  end
end

function bs_1022022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1022022
