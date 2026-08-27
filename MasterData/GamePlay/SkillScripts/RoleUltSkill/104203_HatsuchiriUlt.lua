local bs_104203 = class("bs_104203", LuaSkillBase)
local base = LuaSkillBase
bs_104203.config = {
  effect_in = 104211,
  effect_out = 104212,
  effect_trail = 104213,
  effect_hit = 104217,
  actionId_speed = 1,
  actionId = 1008,
  actionId_end = 1009,
  start_time = 15,
  end_time = 9,
  buffId_god = 3009,
  buffId_yinshen = 3016,
  buff_move = 104202,
  buff_chanrao = 104203,
  buffId_skillCD = 170,
  buffId_attackCD = 104205,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0
  },
  audioIdStart = 104209,
  audioIdMovie = 104210,
  audioId_up = 104211,
  buff_CD2 = 104207
}

function bs_104203:ctor()
end

function bs_104203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_104203:PlaySkill(data, selectTargetCoord, selectRoles, SelectRolesType)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.SneakPrepare), SelectRolesType)
end

function bs_104203:SneakPrepare(selectRole)
  self.caster:LookAtTarget(selectRole)
  self:CallCasterWait(self.config.start_time)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skillCD, 1, self.config.start_time + 3, true)
  local attackTrigger = BindCallback(self, self.Sneak, selectRole)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect_in, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_yinshen, 1, 15)
  LuaSkillCtrl:CallBuff(self, selectRole, self.config.buff_chanrao, 1, self.arglist[1], false)
end

function bs_104203:Sneak(selectRole)
  local arg = self.caster.recordTable.arg1
  if LuaSkillCtrl:IsRoleAdjacent(self.caster, selectRole) == true then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skillCD, 1, self.config.end_time, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.end_time, true)
    self:CallCasterWait(self.config.end_time)
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
    LuaSkillCtrl:CallEffect(selectRole, self.config.effect_out, self)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_up)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, selectRole)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[2]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_CD2, 1, arg, true)
    LuaSkillCtrl:StartTimer(self, 3, function()
      LuaSkillCtrl:CallEffect(selectRole, self.config.effect_hit, self)
    end)
    LuaSkillCtrl:CallReFillMainSkillCdForRole(self.caster)
    self.caster:LookAtTarget(selectRole)
    self.caster.recordTable.lastAttackRole = selectRole
    return
  end
  local grid = LuaSkillCtrl:FindEmptyGridsWithinRange(selectRole.x, selectRole.y, 10, false)
  if grid == nil then
    return
  end
  local targetGrid = LuaSkillCtrl:GetGridWithPos(grid[0].x, grid[0].y)
  local MoveTime = LuaSkillCtrl:GetGridsDistance(targetGrid.x, targetGrid.y, self.caster.x, self.caster.y)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skillCD, 1, self.config.end_time + MoveTime, true)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_attackCD, 1, self.config.end_time + MoveTime, true)
  local effectGrid = LuaSkillCtrl:GetTargetWithGrid(targetGrid.x, targetGrid.y)
  LuaSkillCtrl:CallEffect(effectGrid, self.config.effect_trail, self)
  LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, targetGrid.x, targetGrid.y, MoveTime, self.config.buff_move)
  self:CallCasterWait(self.config.end_time + MoveTime)
  LuaSkillCtrl:StartTimer(self, MoveTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1)
    LuaSkillCtrl:CallEffect(selectRole, self.config.effect_out, self)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_up)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, selectRole)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[2]
    })
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_CD2, 1, arg, true)
    LuaSkillCtrl:StartTimer(self, 3, function()
      LuaSkillCtrl:CallEffect(selectRole, self.config.effect_hit, self)
    end)
    self.caster.recordTable.case = 1
    LuaSkillCtrl:CallReFillMainSkillCdForRole(self.caster)
    self.caster:LookAtTarget(selectRole)
    self.caster.recordTable.lastAttackRole = selectRole
  end)
end

function bs_104203:PlayUltEffect(data, selectTargetCoord, selectRoles)
  if selectRoles == nil or selectRoles.Count <= 0 then
    return true
  end
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_104203:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 2)
end

function bs_104203:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_104203:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_104203:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_104203:LuaDispose()
  base.LuaDispose(self)
end

return bs_104203
