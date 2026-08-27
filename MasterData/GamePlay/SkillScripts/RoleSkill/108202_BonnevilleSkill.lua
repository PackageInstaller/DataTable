local bs_108202 = class("bs_108202", LuaSkillBase)
local base = LuaSkillBase
bs_108202.config = {
  selectId = 92,
  selectId2 = 10002,
  configId = 51,
  buffId_fly = 5002101,
  buffId_Stun = 101,
  buffId_defDown = 108205,
  buffId_69 = 69,
  buffId_198 = 198,
  skill_time = 25,
  actionId = 1008,
  actionIdend = 1009,
  action_speed = 1,
  start_time = 15,
  buffId_focusOnFiring = 107907,
  effectProtect = 108205,
  effectstart = 108207,
  effecthit = 108209,
  effecthit2 = 108210
}

function bs_108202:ctor()
end

function bs_108202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effect = nil
  self.effectTar = nil
  self.mark = 0
end

function bs_108202:PlaySkill(data)
  self:CallCasterWait(30)
  local target
  local tar = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId2, 10)
  if tar ~= nil and tar.Count > 0 then
    for i = 0, tar.Count - 1 do
      target = tar[i].targetRole
      if LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.NotBeSelected) then
        target = nil
      else
        break
      end
    end
  end
  if target ~= nil then
    local isCanGo = false
    local isCanMove = false
    if not LuaSkillCtrl:RoleContainsBuffFeature(target, eBuffFeatureType.CtrlImmunity) then
      local gridList = LuaSkillCtrl:FindEmptyGridsWithinRange(target.x, target.y, 5)
      if gridList ~= nil then
        local grid_go = LuaSkillCtrl:GetGridWithRole(target)
        LuaSkillCtrl:PreSetRolePos(grid_go, self.caster)
        isCanGo = true
        isCanMove = true
      elseif gridList == nil then
        local grids = LuaSkillCtrl:FindAllGridsWithinRange(target, 1, false)
        if grids ~= nil then
          for i = 0, grids.Count - 1 do
            local tempGrid = grids[i]
            local tempRole = tempGrid.role
            if tempRole ~= nil and LuaSkillCtrl:IsFixedObstacle(tempRole) == false and LuaSkillCtrl:IsObstacle(tempRole) == true then
              isCanGo = true
            end
          end
        end
      end
    else
      local grids = LuaSkillCtrl:FindAllGridsWithinRange(target, 1, false)
      if grids ~= nil then
        for i = 0, grids.Count - 1 do
          local tempGrid = grids[i]
          local tempRole = tempGrid.role
          if tempRole ~= nil then
            if LuaSkillCtrl:IsFixedObstacle(tempRole) == false and LuaSkillCtrl:IsObstacle(tempRole) == true then
              isCanGo = true
            end
          else
            isCanGo = true
          end
        end
      end
    end
    if isCanGo then
      self.caster:LookAtTarget(target)
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, isCanMove)
      self.caster.recordTable.lastAttackRole = target
      self.effectTar = LuaSkillCtrl:CallEffect(target, self.config.effectProtect, self)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    else
      LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
      return
    end
  else
    LuaSkillCtrl:SetResetCdByReturnConfigOnce(self)
    return
  end
end

function bs_108202:OnAttackTrigger(target, isCanMove, data)
  local grid, minDis
  if isCanMove then
    grid = LuaSkillCtrl:GetGridWithRole(target)
    local dis = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, grid.x, grid.y)
    minDis = dis
  else
    local grids = LuaSkillCtrl:FindAllGridsWithinRange(target, 1, false)
    if grids ~= nil then
      for i = 0, grids.Count - 1 do
        local isObstacle = false
        if grids[i].role ~= nil and LuaSkillCtrl:IsFixedObstacle(grids[i].role) == false and LuaSkillCtrl:IsObstacle(grids[i].role) == true then
          isObstacle = true
        end
        if grids[i].role == nil or isObstacle then
          local tempGrid = grids[i]
          local tempRole = tempGrid.role
          local gridNow = LuaSkillCtrl:GetGridWithRole(self.caster)
          local dis = LuaSkillCtrl:GetGridsDistance(self.caster.x, self.caster.y, tempGrid.x, tempGrid.y)
          if (minDis == nil or minDis > dis) and tempGrid ~= gridNow then
            minDis = dis
            grid = tempGrid
          end
        end
      end
    end
  end
  if grid ~= nil then
    local time = minDis * 2
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_198, 1, time, true)
    local targetRole = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
    self.caster:LookAtTarget(targetRole)
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectstart, self)
    local collisionEnter = BindCallback(self, self.OnCollisionEnter, target)
    local collisionArrive = BindCallback(self, self.OnCollisionArrive, target, isCanMove)
    LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, targetRole, 75, 0, eColliderInfluenceType.Enemy, collisionEnter, nil, nil, nil, false, true, collisionArrive, self.caster)
    LuaSkillCtrl:CallPhaseMoveWithoutTurnAndAllowCcd(self, self.caster, grid.x, grid.y, time, self.config.buffId_69)
  end
end

function bs_108202:OnCollisionEnter(target, collider, index, entity)
  if LuaSkillCtrl:IsFixedObstacle(entity) == false and LuaSkillCtrl:IsObstacle(entity) == true then
    LuaSkillCtrl:CallEffect(entity, self.config.effecthit, self)
    LuaSkillCtrl:RemoveLife(entity.hp + 1, self, entity, true, nil, false, true)
  else
    local N2 = self.caster.recordTable.N2
    if N2 ~= 0 then
      LuaSkillCtrl:CallBuff(self, entity, self.config.buffId_defDown, N2, self.arglist[4])
    end
    LuaSkillCtrl:CallEffect(entity, self.config.effecthit, self)
    if entity == target and target.isDead == false then
      self.mark = 1
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
      self.arglist[1],
      N2 * self.arglist[2]
    })
    skillResult:EndResult()
  end
end

function bs_108202:OnCollisionArrive(target, isCanMove)
  if self.mark == 0 and target.isDead == true then
    LuaSkillCtrl:CallResetCDNumForRole(self.caster, self.arglist[8])
  end
  self:OnSkillDamageEnd()
  local lastPosX = target.x
  local lastPosY = target.y
  if isCanMove and target ~= nil and target.isDead == false then
    local grid_go = LuaSkillCtrl:CallFindEmptyGridNearest(target)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_fly, 1, 3, true)
    LuaSkillCtrl:CallPhaseMove(self, target, grid_go.x, grid_go.y, 3, self.config.buffId_69, nil, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_focusOnFiring, 1, 30)
  elseif target ~= nil and target.isDead == false and lastPosX == target.x and lastPosY == target.y then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_Stun, 1, self.arglist[3])
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_focusOnFiring, 1, self.arglist[3] + 30)
  end
  if target ~= nil and target.isDead == false then
    LuaSkillCtrl:CallEffect(target, self.config.effecthit2, self)
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionIdend, self.config.action_speed)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.effectTar ~= nil then
    self.effectTar:Die()
    self.effectTar = nil
  end
  self.mark = 0
  self.caster.recordTable.N2 = 0
  LuaSkillCtrl:HideCounting(self.caster)
end

function bs_108202:OnBreakSkill(role)
  self.mark = 0
  base.OnBreakSkill(self, role)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.effectTar ~= nil then
    self.effectTar:Die()
    self.effectTar = nil
  end
end

function bs_108202:OnCasterDie()
  self.mark = 0
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.effectTar ~= nil then
    self.effectTar:Die()
    self.effectTar = nil
  end
end

function bs_108202:LuaDispose()
  base.LuaDispose(self)
  self.effectTar = nil
  self.effect = nil
end

return bs_108202
