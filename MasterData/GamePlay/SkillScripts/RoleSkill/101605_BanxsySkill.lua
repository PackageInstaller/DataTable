local bs_101605 = class("bs_101605", LuaSkillBase)
local base = LuaSkillBase
bs_101605.config = {
  buffId_Paint = 101601,
  buffId_170 = 170,
  superBuffId = 271,
  effectId = 101604,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0
  },
  HurtConfig1 = 2,
  audioId1 = 107,
  audioId2 = 108,
  audioId3 = 109,
  selectCode = 57
}

function bs_101605:ctor()
end

function bs_101605:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.arg2 = self.arglist[2]
end

function bs_101605:PlaySkill(data)
  local realTargetRole = self:CheckAndGetTargetRole()
  if realTargetRole == nil then
    return
  end
  self:PhaseMove(realTargetRole)
end

function bs_101605:realRlaySkill(realTargetRole)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, realTargetRole)
  self.caster:LookAtTarget(realTargetRole)
  self:CallCasterWait(15)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1020, 1.5, 7, attackTrigger)
  LuaSkillCtrl:StartTimer(self, 10, function()
    local TargetRole = self:CheckAndGetTargetRole()
    if TargetRole == nil then
      return
    end
    self.caster:LookAtTarget(TargetRole)
    LuaSkillCtrl:CallEffect(TargetRole, self.config.effectId, self, self.SkillEventFunc1)
  end, nil)
end

function bs_101605:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
end

function bs_101605:CheckAndGetTargetRole()
  local lastAtkRole = self.caster.recordTable.lastAttackRole
  if lastAtkRole ~= nil and LuaSkillCtrl:IsAbleAttackTarget(self.caster, lastAtkRole, self.cskill.SkillRange) and lastAtkRole:GetBuffTier(self.config.buffId_Paint) <= 0 and lastAtkRole.belongNum ~= eBattleRoleBelong.neutral then
    return lastAtkRole
  end
  local realTargetRole
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget ~= nil then
    realTargetRole = moveTarget.targetRole
  end
  if realTargetRole == nil or realTargetRole:GetBuffTier(self.config.buffId_Paint) > 0 or realTargetRole:ContainFeature(eBuffFeatureType.AbadonDebuff) then
    local roles = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectCode, self.cskill.SkillRange)
    if (roles == nil or 0 >= roles.Count) and realTargetRole == nil then
      self.cskill:ResetCDTimeRatio(ConfigData.game_config.skillBreakCd)
      return
    end
    realTargetRole = self:AnalysisSelectRoles(realTargetRole, roles)
  end
  return realTargetRole
end

function bs_101605:AnalysisSelectRoles(realTargetRole, roles)
  local result = realTargetRole
  if roles == nil or roles.Count <= 0 then
    return result
  end
  for i = 0, roles.Count - 1 do
    local targetRole = roles[i].targetRole
    if targetRole.belongNum ~= eBattleRoleBelong.neutral and 0 >= targetRole:GetBuffTier(self.config.buffId_Paint) and not targetRole:ContainFeature(eBuffFeatureType.AbadonDebuff) then
      result = targetRole
      break
    end
  end
  return result
end

function bs_101605:PhaseMove(realTargetRole)
  LuaSkillCtrl:CallRoleAction(self.caster, 1007)
  local grid
  local grids = LuaSkillCtrl:FindEmptyGridsWithinRange(realTargetRole.x, realTargetRole.y, self.caster.attackRange, true)
  if grids ~= nil and grids.Count > 0 then
    grid = grids[0]
    self.caster.recordTable.lastAttackRole = realTargetRole
  end
  if grid == nil then
    grid = LuaSkillCtrl:FindEmptyGridWithinRange(self.caster, 2)
  end
  if grid ~= nil then
    LuaSkillCtrl:CallPhaseMove(self, self.caster, grid.x, grid.y, 6, 69)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId3)
  end
  LuaSkillCtrl:StartTimer(nil, 6, function()
    LuaSkillCtrl:CallRoleAction(self.caster, 1009)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.superBuffId, 1, self.arglist[3])
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.arglist[3], true)
    LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[3])
    self:realRlaySkill(realTargetRole)
  end)
end

function bs_101605:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target.targetRole, 10) then
    self.caster.recordTable.skill_target = target.targetRole
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
end

function bs_101605:SkillEventFunc1(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target.targetRole, 10) then
    self.caster.recordTable.skill_target = target.targetRole
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
    local targetNum = 0
    local targetList = LuaSkillCtrl:FindAllRolesWithinRange(target, 1, true)
    if 0 < targetList.Count then
      for i = 0, targetList.Count - 1 do
        if targetList[i].belongNum == 2 then
          targetNum = targetNum + 1
        end
      end
    end
    if targetNum == 1 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig1, {
        self.arglist[1] * self.arglist[5] // 1000
      })
      skillResult:EndResult()
    else
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
        self.arglist[1] * self.arglist[4] // 1000
      })
      skillResult:EndResult()
    end
    self:OnSkillDamageEnd()
  end
end

function bs_101605:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101605
