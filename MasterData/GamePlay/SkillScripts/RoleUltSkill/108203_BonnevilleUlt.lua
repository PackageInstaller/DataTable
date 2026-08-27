local bs_108203 = class("bs_108203", LuaSkillBase)
local base = LuaSkillBase
bs_108203.config = {
  actionId = 1005,
  actionIdend = 1006,
  action_speed = 1,
  start_time = 15,
  effect_Dash = 108211,
  effecthit = 108212,
  effecthit2 = 108210,
  effect_buff = 108213,
  buffId_Taunt = 3002,
  buffId_Stun = 106507,
  configId = 51,
  buffId_Back = 106508,
  selectId = 91,
  buffId_defDown = 108206,
  buffId_198 = 198,
  selectId2 = 9,
  buff_105205 = 105205,
  buff_stopMove = 60504,
  audioIdStart = 108208,
  audioIdMovie = 108209,
  audioIdEnd = 108210
}

function bs_108203:ctor()
end

function bs_108203:CheckManualSkillTakeAvailable(role)
  return base.CheckManualSkillTakeAvailable(self, role)
end

function bs_108203:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_108203_01", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_108203_02", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, nil, nil, eBuffFeatureType.Stun)
  self.effect = nil
  self.dashTime = -1
  self.effectBuff = nil
  self.arg = nil
end

function bs_108203:OnAfterBattleStart()
  self.arg = self.caster.recordTable.MaxN2
end

function bs_108203:OnAfterAddBuff(buff, target)
  if self.dashTime ~= -1 then
    self.dashTime = 3
  end
end

function bs_108203:PlaySkill(data, selectTargetCoord, selectRoles, selectRolesType)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.DashPrepare), selectRolesType)
  local N2 = self.caster.recordTable.N2
  N2 = N2 + self.arglist[1]
  if N2 > self.arg then
    N2 = self.arg
  end
  self.caster.recordTable.N2 = N2
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_stopMove, 1, 7, true)
  LuaSkillCtrl:ShowCounting(self.caster, N2, self.arg)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_Dash, self)
  self.effectBuff = LuaSkillCtrl:CallEffect(self.caster, self.config.effect_buff, self)
end

function bs_108203:DashPrepare(selectRole)
  self:CallCasterWait(60)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_105205, 1, 15, true)
  self.caster:LookAtTarget(selectRole)
  self.caster.recordTable.lastAttackRole = selectRole
  local attackTrigger = BindCallback(self, self.Dash, selectRole)
  self.dashTime = 0
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
end

function bs_108203:Dash(target)
  local grid, minDis
  local isCanMove = false
  if not LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.CtrlImmunity) then
    isCanMove = true
    grid = LuaSkillCtrl:GetGridWithRole(target)
    LuaSkillCtrl:PreSetRolePos(grid, self.caster)
    local dis = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, grid.x, grid.y)
    minDis = dis
  else
    local grids = LuaSkillCtrl:FindAllGridsWithinRange(target, 1, false)
    if grids ~= nil then
      for i = 0, grids.Count - 1 do
        local tempGrid = grids[i]
        local isCanGo = false
        local tempRole = tempGrid.role
        if tempRole ~= nil then
          if LuaSkillCtrl:IsFixedObstacle(tempRole) == false and LuaSkillCtrl:IsObstacle(tempRole) == true then
            isCanGo = true
          end
        else
          isCanGo = true
        end
        if isCanGo then
          local dis = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, tempGrid.x, tempGrid.y)
          if minDis == nil or minDis > dis then
            minDis = dis
            grid = tempGrid
          end
        end
      end
    end
  end
  if grid == nil then
    self:EndDash()
  end
  if grid ~= nil then
    local time = minDis * 2
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_105205, 1, time + 15, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, time, true)
    local targetRole = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    self.caster:LookAtTarget(targetRole)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    local collisionArrive = BindCallback(self, self.OnCollisionArrive, target, isCanMove)
    LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, targetRole, 75, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, nil, nil, false, true, collisionArrive, self.caster)
    LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, grid.x, grid.y, time, self.config.buffId_69)
  end
end

function bs_108203:OnCollisionEnter(collider, index, entity)
  if LuaSkillCtrl:IsFixedObstacle(entity) == false and LuaSkillCtrl:IsObstacle(entity) == true then
    LuaSkillCtrl:CallEffect(entity, self.config.effecthit, self)
    LuaSkillCtrl:RemoveLife(entity.hp + 1, self, entity, true, nil, false, true)
  else
    local N2 = self.caster.recordTable.N2
    if N2 ~= 0 then
      LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_defDown, N2, self.arglist[2])
    end
    LuaSkillCtrl:CallEffect(entity, self.config.effecthit, self)
    LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_Stun, 1, 7)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
      self.arglist[3],
      N2 * self.arglist[4]
    })
    skillResult:EndResult()
  end
end

function bs_108203:OnCollisionArrive(target, isCanMove)
  local lastPosX = target.x
  local lastPosY = target.y
  if isCanMove and target ~= nil and target.isDead == false then
    local grid_go = LuaSkillCtrl:CallFindEmptyGridNearest(target)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_fly, 1, 3, true)
    LuaSkillCtrl:CallPhaseMove(self, target, grid_go.x, grid_go.y, 3, self.config.buffId_69, nil, true)
  end
  if target ~= nil and target.isDead == false then
    LuaSkillCtrl:CallEffect(target, self.config.effecthit2, self)
  end
  local N2 = self.caster.recordTable.N2
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionIdend, self.config.action_speed)
  self.dashTime = self.dashTime + 1
  if 3 <= self.dashTime then
    self:EndDash()
  else
    LuaSkillCtrl:StartTimer(nil, 7, function()
      if self.dashTime < 3 then
        local tar = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId, 10)
        if tar ~= nil and tar.Count > 0 then
          local role = tar[0].targetRole
          self:Dash(role)
        end
      else
        self:EndDash()
      end
    end, nil)
  end
end

function bs_108203:EndDash()
  self.dashTime = -1
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.effectBuff ~= nil then
    self.effectBuff:Die()
    self.effectBuff = nil
  end
  self:BreakSkill()
end

function bs_108203:PlayUltEffect(data, selectTargetCoord, selectRoles)
  if selectRoles == nil or selectRoles.Count <= 0 then
    return true
  end
  local role = LuaSkillCtrl:GetRoleWithPos(selectTargetCoord.x, selectTargetCoord.y)
  local space = false
  local grid
  if role ~= nil then
    grid = LuaSkillCtrl:CallFindEmptyGridNearest(role)
  end
  if role ~= nil and 0 < role.hp then
    if LuaSkillCtrl:RoleContainsBuffFeature(role, eBuffFeatureType.CtrlImmunity) == false and grid ~= nil then
      space = true
    else
      local nearGrid = LuaSkillCtrl:FindEmptyGridAroundRole(role)
      if nearGrid ~= nil then
        space = true
      else
        local targetList = LuaSkillCtrl:FindRolesAroundRole(role)
        if targetList.Count > 0 then
          for i = 0, targetList.Count - 1 do
            local role_1 = targetList[i]
            if role_1 == self.caster then
              space = true
              break
            end
            if LuaSkillCtrl:IsFixedObstacle(role_1) == false and LuaSkillCtrl:IsObstacle(role_1) == true then
              space = true
              break
            end
          end
        end
      end
    end
  end
  if space == false then
    return true
  end
  base.PlayUltEffect(self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

function bs_108203:OnUltRoleAction()
  base.OnUltRoleAction(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start)
end

function bs_108203:OnMovieFadeOut()
  base.OnMovieFadeOut(self)
end

function bs_108203:OnSkipUltView()
  base.OnSkipUltView(self)
end

function bs_108203:OnCasterDie()
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.effectBuff ~= nil then
    self.effectBuff:Die()
    self.effectBuff = nil
  end
end

function bs_108203:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
  self.effectBuff = nil
end

return bs_108203
