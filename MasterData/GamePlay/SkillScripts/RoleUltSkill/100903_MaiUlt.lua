local bs_100903 = class("bs_100903", LuaSkillBase)
local base = LuaSkillBase
bs_100903.config = {
  effectId_storm = 1009031,
  effectId_hit = 1009032,
  actionId_start = 1005,
  skilltime = 15,
  movieEndRoleAction = 1006,
  actionId_loop = 1010,
  actionId_end = 1006,
  end_time = 10,
  act_speed = 1,
  audioIdStart = 100906,
  audioIdMovie = 100907,
  audioIdLoop = 100909,
  stormRate = 6,
  buffId_skillmode = 1009031,
  buffId_blind = 3012,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  }
}

function bs_100903:ctor()
end

function bs_100903:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.time = 1
end

function bs_100903:PlaySkill(data, selectTargetCoord, selectRoles)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(999)
  if selectTargetCoord ~= nil then
    local inputCoord = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    self.caster:LookAtTarget(inputCoord)
    self:CallSkillExecute(inputCoord)
  end
end

function bs_100903:CallSkillExecute(inputCoord)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skillmode, 1, self.arglist[1], true)
  local stormData = {
    roleMarks = {},
    arrivedRoles = {}
  }
  if inputCoord ~= nil then
    local targetGrid = LuaSkillCtrl:GetTargetWithGrid(inputCoord.x, inputCoord.y)
    self.stormEffect = LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_storm, self, nil, nil, nil, false)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter, stormData)
    local collisionExit = BindCallback(self, self.OnCollisionExit, stormData)
    local stormCollider = LuaSkillCtrl:CallAddCircleColliderForEffect(self.stormEffect, 100, eColliderInfluenceType.Enemy, nil, collisionEnter, collisionExit)
    local times = self.arglist[1] // self.config.stormRate
    local duration = self.config.stormRate
    local stormshock = BindCallback(self, self.StormShock, stormData, targetGrid)
    LuaSkillCtrl:StartTimer(self, duration, stormshock, nil, times - 1, duration)
    local stormEndAction = BindCallback(self, self.StormEndAction, stormCollider)
    LuaSkillCtrl:StartTimer(self, self.arglist[1], stormEndAction)
  end
end

function bs_100903:OnCollisionEnter(stormData, collider, index, entity)
  if stormData.roleMarks[entity] == nil then
    table.insert(stormData.arrivedRoles, entity)
    stormData.roleMarks[entity] = true
  end
end

function bs_100903:OnCollisionExit(stormData, collider, entity)
  if stormData.roleMarks[entity] then
    stormData.roleMarks[entity] = nil
    table.removebyvalue(stormData.arrivedRoles, entity)
  end
end

function bs_100903:StormShock(stormData, targetGrid)
  LuaSkillCtrl:CallEffect(targetGrid, self.config.effectId_storm, self, nil, nil, nil, false)
  for i = 1, #stormData.arrivedRoles do
    local target = stormData.arrivedRoles[i]
    if target ~= nil and not (target.hp <= 0) then
      if target.intensity ~= 0 then
        LuaSkillCtrl:CallBuff(self, target, self.config.buffId_blind, 1, self.config.stormRate)
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
        self.arglist[2]
      })
      skillResult:EndResult()
      local down = -self.arglist[3]
      LuaSkillCtrl:CallResetCDNumForRole(target, down)
    end
  end
end

function bs_100903:StormEndAction()
  self:SkillEnd()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
  self.isStormEnd = true
  self.endActionTimmer = LuaSkillCtrl:StartTimer(nil, self.config.end_time, function()
    self:CancleCasterWait()
    self.isStormEnd = nil
  end)
end

function bs_100903:SkillEnd()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_skillmode, 1, true)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buff_lockcd, 0, true)
  if self.stormEffect ~= nil then
    self.stormEffect:Die()
    self.stormEffect = nil
  end
end

function bs_100903:OnBreakSkill(role)
  if role == self.caster then
    self:SkillEnd()
    if not self.isStormEnd then
      self:CancleCasterWait()
      self.isStormEnd = nil
    end
  end
  base.OnBreakSkill(self, role)
end

function bs_100903:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

function bs_100903:PlayUltEffect()
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_100903:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_100903:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_100903:OnCasterDie()
  self:SkillEnd()
  if self.endActionTimmer ~= nil then
    self.endActionTimmer:Stop()
    self.endActionTimmer = nil
  end
  self:CancleCasterWait()
  base.OnCasterDie(self)
end

function bs_100903:LuaDispose()
  self.time = nil
  self.stormEffect = nil
  self.isStormEnd = nil
  base.LuaDispose(self)
end

return bs_100903
