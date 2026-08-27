local bs_102206 = class("bs_102206", LuaSkillBase)
local base = LuaSkillBase
bs_102206.config = {
  effectId_skill = 102215,
  effectId_hit = 102214,
  hurt_config = {hit_formula = 0, basehurt_formula = 3000},
  end_time = 10,
  start_time = 11,
  loop_time = 12,
  skill_time = 36,
  actionId = 1002,
  actionId_start = 1022,
  actionId_end = 1024,
  action_speed = 1,
  action_speed1 = 2.5,
  skill_selectId = 1001,
  audioId1 = 234,
  audioId2 = 235,
  buff_wudi = 102203
}

function bs_102206:ctor()
end

function bs_102206:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102206:PlaySkill(data)
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
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_wudi, 1, self.config.skill_time, true)
  end
end

function bs_102206:OnAttackTrigger(Target)
  LuaSkillCtrl:CallEffect(Target, self.config.effectId_hit, self)
  local arg = 0
  self.num = 0
  for i = 1, self.arglist[1] do
    LuaSkillCtrl:StartTimer(nil, (self.arglist[1] - i) * 2, function()
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, Target)
      LuaSkillCtrl:PlayAuSource(Target, self.config.audioId2)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
        self.arglist[2] + self.arglist[7]
      })
      skillResult:EndResult()
      self.num = self.num + 1
      if self.num == self.arglist[2] then
        self:OnSkillDamageEnd()
      end
    end)
  end
end

function bs_102206:OnBreakSkill(role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_wudi, 0, true)
  end
  base.OnBreakSkill(self, role)
end

function bs_102206:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102206
