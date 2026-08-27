local bs_40031 = class("bs_40031", LuaSkillBase)
local base = LuaSkillBase
bs_40031.config = {
  buffId_63 = 63,
  buffId_69 = 69,
  buffId_50 = 50,
  PhaseMoveDuration = 8,
  PhaseMoveDuration2 = 16,
  buffId_124 = 278,
  duration_124 = 999,
  buffId_165 = 165,
  duration_165 = 13,
  buffId_196 = 196,
  duration_196 = 90,
  buffID_1158 = 1158,
  antion1 = 1008,
  antion2 = 1007,
  antion3 = 1009,
  findGridRange = 3,
  effectId1 = 10237,
  effectId2 = 10238,
  effectId3 = 10861,
  effectId4 = 10867,
  audioId1 = 84,
  audioId2 = 85,
  audioId3 = 86,
  audioId4 = 330,
  HurtConfig = {
    hit_formula = 0,
    def_formula = 9996,
    basehurt_formula = 10031,
    minhurt_formula = 9994,
    crit_formula = 0,
    crithur_ratio = 9995,
    correct_formula = 9989,
    lifesteal_formula = 1001,
    spell_lifesteal_formula = 1002,
    returndamage_formula = 1000
  },
  select_id = 40,
  select_id2 = 19,
  select_range = 10,
  skill_time = 999
}

function bs_40031:ctor()
end

function bs_40031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.skill_open = false
end

function bs_40031:PlaySkill(data)
  self.skill_open = true
  local targetlast = self.caster.recordTable.lastAttackRole
  if self.caster.recordTable["20036_root2arg"] then
    local temTarget = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id2, self.config.select_range)
    targetlast = temTarget[0].targetRole
  end
  if targetlast == nil or 0 >= targetlast.hp or targetlast.recordTable.isPhaseSelect or targetlast.intensity == 0 then
    targetlast = nil
    local selectTargets = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
    local targetCount = selectTargets.Count
    if 0 < targetCount then
      for i = 0, targetCount - 1 do
        if selectTargets[i].targetRole ~= nil and not selectTargets[i].targetRole.recordTable.isPhaseSelect then
          targetlast = selectTargets[i].targetRole
          break
        end
      end
    end
  end
  if targetlast == nil then
    return
  else
    targetlast.recordTable.isPhaseSelect = true
  end
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  self:CallCasterWait(self.config.skill_time, true)
  self:AbandonSkillCdAutoReset(true)
  local buffAction = BindCallback(self, self.OnActionTrigger1, targetlast)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.antion1, 1, 30, buffAction)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_196, 1, self.config.duration_196)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_50, 1, self.config.duration_196)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_1158, 1)
  LuaSkillCtrl:StartTimer(nil, 6, function()
    LuaSkillCtrl:CallEffect(targetlast, self.config.effectId3, self)
    LuaSkillCtrl:CallBuff(self, targetlast, self.config.buffId_124, 1, self.config.duration_124)
  end)
end

function bs_40031:OnActionTrigger1(targetlast)
  self:Onboolen(targetlast)
  if self.skill_open == false then
    return
  end
  local grid = LuaSkillCtrl:FindEmptyGridWithinRange(targetlast, self.config.findGridRange)
  if IsNull(grid) then
    self:CallNextSkill(targetlast)
    return
  end
  self.caster:LookAtTargetDir(LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y), targetlast)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, self.caster, grid.x, grid.y, self.config.PhaseMoveDuration2, self.config.buffId_69)
  LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, function(table, grid)
    self:Onboolen(targetlast)
    if self.skill_open == false then
      return
    end
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.antion2)
  end, grid))
  local arriveCallBack = BindCallback(self, self.OnArriveAction, targetlast)
  local phaseMove = BindCallback(self, function(table, targetlast)
    self:Onboolen(targetlast)
    self.caster:LookAtTarget(targetlast)
    local afterRotation = BindCallback(self, function(table, grid)
      self:Onboolen(targetlast)
      if self.skill_open == false then
        return
      end
      LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, targetlast.x, targetlast.y, 3, 69)
      LuaSkillCtrl:StartTimer(self, 3, arriveCallBack)
    end, grid)
    self:Onboolen(targetlast)
    if self.skill_open == false then
      return
    end
    self.loopEfc = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, nil, true)
    LuaSkillCtrl:StartTimer(self, 26, afterRotation)
  end, targetlast)
  LuaSkillCtrl:StartTimer(self, self.config.PhaseMoveDuration, phaseMove)
end

function bs_40031:Onboolen(targetRole)
  if targetRole:IsUnSelect(self.caster) and self.skill_open == true then
    LuaSkillCtrl:DispelBuff(targetRole, self.config.buffId_124, 0)
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    if self.loopEfc ~= nil then
      self.loopEfc:Die()
      self.loopEfc = nil
    end
    self:CallNextSkill(targetRole)
  end
end

function bs_40031:OnArriveAction(targetRole)
  if self.skill_open == false then
    local grid = LuaSkillCtrl:FindEmptyGrid(nil)
    if grid == nil then
      return
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_up, self)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_down, self)
    return
  end
  LuaSkillCtrl:ForceDispelBuff(targetRole, self.config.buffId_124, 0, true)
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  if self.loopEfc ~= nil then
    self.loopEfc:Die()
    self.loopEfc = nil
  end
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId3)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId2, self)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.antion3)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:PlayAuHit(self, targetRole)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
  skillResult:EndResult()
  if 0 < targetRole.hp then
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_165, 1, self.config.duration_165)
    local maxRange = self.config.findGridRange
    local grid
    for tempRange = 1, maxRange do
      grid = LuaSkillCtrl:FindEmptyGridWithinRange(targetRole, tempRange)
      if grid ~= nil then
        LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId4)
        LuaSkillCtrl:CallPhaseMove(self, targetRole, grid.x, grid.y, 5, self.config.buffId_63)
        break
      end
    end
    if grid == nil then
      grid = LuaSkillCtrl:FindEmptyGrid()
      if grid == nil then
        error("cant find empty grid")
        self:CallNextSkill(targetRole)
        return
      end
      LuaSkillCtrl:CallPhaseMove(self, targetRole, grid.x, grid.y, 5, self.config.buffId_63)
    end
  end
  if self.callNextTimer ~= nil then
    self.callNextTimer:Stop()
    self.callNextTimer = nil
  end
  self.callNextTimer = LuaSkillCtrl:StartTimer(nil, 46, function()
    self:CallNextSkill(targetRole)
  end)
  targetRole.recordTable.isPhaseSelect = nil
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1158, 0)
  self.skill_open = false
end

function bs_40031:CallNextSkill(targetRole)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1158, 0)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_196, 0)
  LuaSkillCtrl:CallRoleAction(self.caster, 100)
  self.skill_open = false
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CancleCasterWait()
  self:CallNextBossSkill()
  if targetRole.isDead then
    return
  end
  LuaSkillCtrl:ForceDispelBuff(targetRole, self.config.buffId_124, 0)
  targetRole.recordTable.isPhaseSelect = nil
end

function bs_40031:OnCasterDie()
  base.OnCasterDie(self)
  if self.callNextTimer ~= nil then
    self.callNextTimer:Stop()
    self.callNextTimer = nil
  end
end

function bs_40031:LuaDispose()
  base.LuaDispose(self)
  self.loopEfc = nil
  self.loopaudio = nil
end

return bs_40031
