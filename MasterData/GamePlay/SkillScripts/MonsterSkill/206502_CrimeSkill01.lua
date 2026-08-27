local bs_206502 = class("bs_206502", LuaSkillBase)
local base = LuaSkillBase
bs_206502.config = {
  buffId_judge = 206801,
  buffId_fly = 502101,
  effectId_start = 2065012,
  effectId_hit = 2065011,
  HurtConfig = {
    hit_formula = 10201,
    basehurt_formula = 3000,
    crit_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  }
}

function bs_206502:ctor()
end

function bs_206502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_206502:PlaySkill(data)
  self.isInSkill = true
  local SkillDuration = 37
  local SkillStart = 8
  self:CallCasterWait(SkillDuration)
  LuaSkillCtrl:StartShowSkillDurationTime(self, SkillDuration)
  self:AbandonSkillCdAutoReset(true)
  LuaSkillCtrl:StartTimer(self, SkillDuration, function()
    self.isInSkill = false
    self:CancleCasterWait()
    self:CallNextBossSkill()
  end)
  local last_target = self.caster.recordTable.lastAttackRole
  local targetRole
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    targetRole = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    targetRole = tempTarget.targetRole
  end
  if targetRole ~= nil then
    self.caster:LookAtTarget(targetRole)
    LuaSkillCtrl:StartTimer(self, SkillStart, function()
      self:OnAttackTrigger()
    end)
    LuaSkillCtrl:CallRoleAction(self.caster, 1002, 1)
    LuaSkillCtrl:PlayAuSource(self.caster, 442)
  end
end

function bs_206502:OnAttackTrigger()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.aoe_config)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
    self.arglist[1]
  })
  for i = 0, skillResult.roleList.Count - 1 do
    if LuaSkillCtrl:IsObstacle(skillResult.roleList[i]) then
      return
    end
    if not LuaSkillCtrl:GetRoleBuffById(skillResult.roleList[i], self.config.buffId_fly) then
      LuaSkillCtrl:CallEffect(skillResult.roleList[i], self.config.effectId_hit, self)
      LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId_judge, 1, self.arglist[2])
    end
  end
  skillResult:EndResult()
end

function bs_206502:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster and self.isInSkill then
    self.isInSkill = false
    self:CancleCasterWait()
    self:CallNextBossSkill()
  end
end

return bs_206502
