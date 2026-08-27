local bs_102103 = class("bs_102103", LuaSkillBase)
local base = LuaSkillBase
bs_102103.config = {
  effectId_start = 1021031,
  effectId_hit = 1021032,
  effectId_startmove = 1021033,
  startmove_time = 5,
  effectId_endmove = 1021034,
  effectId_target = 1021035,
  effectId_speed = 1,
  actionId_start = 1005,
  movieEndRoleAction = 1006,
  actionId_shoot1 = 1008,
  actionId_shoot2 = 1001,
  actionId_shoot3 = 1004,
  audioIdStart = 102101,
  audioIdMovie = 102102,
  audioIdWave = 102103,
  audioIdHit = 102104,
  audioIdTrans = 102105,
  buffId_GrooveUlt = 1021031,
  skilltime = 30,
  action_time = 8,
  move_wait = 30,
  move_times = 3,
  collider_go = 0,
  select_id = 9,
  select_range = 20,
  buffignoretype = 15,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  }
}

function bs_102103:ctor()
end

function bs_102103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.ultmode = 0
end

function bs_102103:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster, true)
  self:CallCasterWait(105)
  self.ultmode = 1
  if selectTargetCoord ~= nil then
    local inputdirection = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputdirection)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_GrooveUlt, 1, 105, true)
    LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, self.CallSkillExecute, inputdirection))
  end
end

function bs_102103:CallSkillExecute(direction)
  self.times = self.config.move_times
  local duration = self.config.move_wait
  local ShootWaveAction = BindCallback(self, self.ShootWaveAction, direction)
  local skillTime = (self.config.move_times - 1) * self.config.move_wait
  LuaSkillCtrl:StartTimer(self, duration, ShootWaveAction, nil, self.config.move_times - 1, duration)
end

function bs_102103:ShootWaveAction(grid)
  if self.caster.hp <= 0 or self.ultmode == 0 then
    return
  end
  local roll = LuaSkillCtrl:CallRange(1, 3)
  local action = self.config["actionId_shoot" .. tostring(roll)]
  LuaSkillCtrl:CallRoleAction(self.caster, action, 1)
  local ShootWave = BindCallback(self, self.ShootWave, grid)
  local shoottime = self.config.action_time
  if self.times == self.config.move_times then
    ShootWave()
    return
  end
  LuaSkillCtrl:StartTimer(nil, shoottime, ShootWave, nil)
end

function bs_102103:ShootWave(grid)
  self.times = self.times - 1
  if grid == nil then
    return
  end
  LuaSkillCtrl:CallEffect(grid, self.config.effectId_start, self)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioIdWave)
  local gridPos = grid:GetLogicPos()
  local shootDir = CS.TrueSync.TSVector3.Subtract(gridPos, self.caster.lsObject.localPosition).normalized
  local shootDir2D = CS.TrueSync.TSVector2(shootDir.x, shootDir.z)
  local OnCollition = BindCallback(self, self.OnCollision, shootDir2D)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, grid, 100, 7, eColliderInfluenceType.Enemy, OnCollition, nil, nil, nil, true, true)
end

function bs_102103:OnCollision(shootDir2d, collider, index, entity)
  if self.caster == nil or self.caster.hp <= 0 or entity == nil or entity.hp <= 0 or entity.camp == self.caster.camp then
    return
  end
  local bornPos = self.caster.lsObject.localPosition
  if not entity.lsObject.localPosition:Equals(bornPos) then
    local tsVec2 = CS.TrueSync.TSVector2
    local curDir = CS.TrueSync.TSVector3.Subtract(entity.lsObject.localPosition, bornPos)
    local curDir2d = tsVec2(curDir.x, curDir.z).normalized
    local angle = LuaSkillCtrl:CallTSVec2Angle(curDir2d, shootDir2d)
    if 100 < angle or angle < -100 then
      return
    end
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  local hurtRatio = self.arglist[1]
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {hurtRatio}, false)
  skillResult:EndResult()
  self:MoveTargetStart(entity)
end

function bs_102103:MoveTargetStart(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_startmove, self)
  LuaSkillCtrl:PlayAuSource(target, self.config.audioIdHit)
  local MoveTargetEnd = BindCallback(self, self.MoveTargetEnd, target)
  LuaSkillCtrl:StartTimer(self, self.config.startmove_time, MoveTargetEnd, nil)
end

function bs_102103:MoveTargetEnd(target)
  local grid = LuaSkillCtrl:FindEmptyGrid(function(x, y)
    return 0 <= x
  end)
  if grid == nil then
    return
  end
  if target == nil or target.hp <= 0 then
    return
  end
  local cantChoose = LuaSkillCtrl:RoleContainsBuffFeature(target, self.config.buffignoretype)
  if cantChoose then
    return
  end
  LuaSkillCtrl:CallBreakAllSkill(target)
  self:TryResetMoveState(target)
  LuaSkillCtrl:SetRolePos(grid, target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_endmove, self)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioIdTrans)
  LuaSkillCtrl:DispelBuff(target, self.config.buffId_move, 1, true)
end

function bs_102103:OnBreakSkill(role)
  if role == self.caster then
    self:CancleCasterWait()
    self.ultmode = 0
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_GrooveUlt, 1, true, true)
  end
  base.OnBreakSkill(self, role)
end

function bs_102103:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_102103:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 105, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_102103:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_102103:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_102103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102103
