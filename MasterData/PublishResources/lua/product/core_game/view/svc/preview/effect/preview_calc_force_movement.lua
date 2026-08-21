_class("PreviewSkillEffectCalc_ForceMovement", Object)
PreviewSkillEffectCalc_ForceMovement = PreviewSkillEffectCalc_ForceMovement

function PreviewSkillEffectCalc_ForceMovement:Constructor(world)
  self._world = world
end

function PreviewSkillEffectCalc_ForceMovement:Calculate(casterEntity, skillPreviewContext, skillEffectParam)
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  if not previewPickUpComponent then
    Log.error(self._className, "施法者没有ActiveSkillPickupComponent")
    return
  end
  local pickupPosArray = previewPickUpComponent:GetAllValidPickUpGridPos()
  if #pickupPosArray == 0 then
    Log.error(self._className, "没有点选位置记录")
    return
  end
  local targetIDs = skillPreviewContext:GetTargetEntityIDList(SkillEffectType.ForceMovement)
  local includeMultiSize = skillEffectParam:IsIncludeMultiSize()
  local includeTrap = skillEffectParam:IsIncludeTrap()
  local tSelectedTarget = {}
  for _, targetID in ipairs(targetIDs) do
    local e = self._world:GetEntityByID(targetID)
    if self:IsEntityTarget(e, includeMultiSize, includeTrap) then
      table.insert(tSelectedTarget, e)
    end
  end
  local moveCenterPos = casterEntity:GetGridPosition()
  local pickupDirPos = pickupPosArray[1]
  local isPickTargetMove = false
  if 1 < #pickupPosArray then
    moveCenterPos = pickupPosArray[1]
    pickupDirPos = pickupPosArray[2]
    isPickTargetMove = true
  end
  local v2Dir = moveCenterPos - pickupDirPos
  if 0 < v2Dir.x then
    v2Dir.x = 1
  elseif 0 > v2Dir.x then
    v2Dir.x = -1
  end
  if 0 < v2Dir.y then
    v2Dir.y = 1
  elseif 0 > v2Dir.y then
    v2Dir.y = -1
  end
  local sortFunction = ForceMovementCalculator.GetEntitySortFunctionByDir(v2Dir)
  table.sort(tSelectedTarget, sortFunction)
  local utilData = self._world:GetService("UtilData")
  local lbsvc = self._world:GetService("BoardLogic")
  local isCalcStepByPick = skillEffectParam:IsCalcStepByPick()
  local result = SkillEffectResult_ForceMovement:New()
  for _, e in ipairs(tSelectedTarget) do
    local maxStep = skillEffectParam:GetStep()
    if isPickTargetMove then
      v2Dir, maxStep = self:_ReCalcMoveDirByTargetAndPick(e, moveCenterPos, pickupDirPos, maxStep, isCalcStepByPick)
    end
    local bodyArea = e:BodyArea():GetArea()
    local final
    for i = 1, maxStep do
      local v2 = e:GetGridPosition() - v2Dir * i
      local posLast = e:GetGridPosition() - v2Dir * (i - 1)
      local blockFlag = BlockFlag.MonsterLand
      if e:HasMonsterID() then
        local monsterClassID = e:MonsterID():GetMonsterClassID()
        local cfgMonsterClass = Cfg.cfg_monster_class({ID = monsterClassID})[1]
        if cfgMonsterClass.RaceType == MonsterRaceType.Fly then
          blockFlag = BlockFlag.MonsterFly
        end
      end
      local canMove = true
      if bodyArea and 1 < #bodyArea then
        local blockExceptTarget = {
          e:GetID()
        }
        self._pieceBlockBlackboard = self:_NewPieceBlockBlackboard(nil, blockExceptTarget)
        local boardsvc = self._world:GetService("BoardLogic")
        local blockVal = boardsvc:GetEntityMoveBlockFlag(e)
        local fitFullBodyArea = self:IsPosFitFullBodyArea(v2, e, blockVal, nil)
        if not fitFullBodyArea then
          canMove = false
          break
        end
      else
        local pieceBlock = utilData:FindBlockByPos(v2)
        if utilData:IsValidPiecePos(v2) and pieceBlock and not lbsvc:IsPosBlock(v2, blockFlag) then
        else
          canMove = false
          break
        end
      end
      local isBlockMoveWithTrapWall = utilData:IsBlockMoveWithTrapWall(posLast, v2, e)
      if isBlockMoveWithTrapWall then
        canMove = false
        break
      end
      if canMove then
        final = v2
      else
        break
      end
    end
    result:AppendMoveResult(e:GetID(), e:GetGridPosition(), final or e:GetGridPosition(), {})
  end
  return result
end

function PreviewSkillEffectCalc_ForceMovement:IsEntityTarget(e, includeMultiSize, includeTrap)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    if includeTrap and e:HasTrapID() then
      return true
    end
    return e:HasTeam() or e:HasPet()
  end
  local isTrap = false
  if not e:HasMonsterID() then
    if includeTrap and e:HasTrapID() then
      isTrap = true
    else
      return false
    end
  end
  if e:HasGhost() then
    return false
  end
  if not isTrap then
    local cfgsvc = self._world:GetService("Config")
    local monsterConfigData = cfgsvc:GetMonsterConfigData()
    local monsterID = e:MonsterID():GetMonsterID()
    if monsterConfigData:IsBoss(monsterID) then
      return false
    end
  end
  if not includeMultiSize and e:BodyArea():GetAreaCount() ~= 1 then
    return false
  end
  local bufflsvc = self._world:GetService("BuffLogic")
  if bufflsvc:CheckForceMoveImmunity(e) then
    return false
  end
  return true
end

function PreviewSkillEffectCalc_ForceMovement:_NewPieceBlockBlackboard(centerPos, targetIDs)
  local utilData = self._world:GetService("UtilData")
  local blackboard = utilData:CreatePieceBlockBlackboard(targetIDs)
  return blackboard
end

function PreviewSkillEffectCalc_ForceMovement:IsPosFitFullBodyArea(gridPos, entity, testBlockVal, bodyAreaByOff)
  local checkPos = gridPos
  local areaArray = entity:BodyArea():GetArea()
  if bodyAreaByOff then
    areaArray = bodyAreaByOff
  end
  for _, v2RelativeBody in ipairs(areaArray) do
    local v2 = checkPos + v2RelativeBody
    if not self._pieceBlockBlackboard[v2.x] or not self._pieceBlockBlackboard[v2.x][v2.y] then
      return false
    end
    if self._pieceBlockBlackboard[v2.x][v2.y]:GetBlock() & testBlockVal ~= 0 then
      return false
    end
    local utilData = entity:GetOwnerWorld():GetService("UtilData")
    if utilData:IsPosBlockWithEntityRace(v2, testBlockVal, entity) then
      return false
    end
  end
  return true
end

function PreviewSkillEffectCalc_ForceMovement:CalcTargetForceMovementStep(targetEntity, dir, maxStep)
  if not targetEntity then
    return
  end
  local moveStep = 0
  local utilData = self._world:GetService("UtilData")
  local lbsvc = self._world:GetService("BoardLogic")
  local e = targetEntity
  local v2Dir = dir
  local bodyArea = e:BodyArea():GetArea()
  local final
  for i = 1, maxStep do
    local v2 = e:GetGridPosition() - v2Dir * i
    local blockFlag = BlockFlag.MonsterLand
    if e:HasMonsterID() then
      local monsterClassID = e:MonsterID():GetMonsterClassID()
      local cfgMonsterClass = Cfg.cfg_monster_class({ID = monsterClassID})[1]
      if cfgMonsterClass.RaceType == MonsterRaceType.Fly then
        blockFlag = BlockFlag.MonsterFly
      end
    end
    local canMove = true
    if bodyArea and 1 < #bodyArea then
      local blockExceptTarget = {
        e:GetID()
      }
      self._pieceBlockBlackboard = self:_NewPieceBlockBlackboard(nil, blockExceptTarget)
      local boardsvc = self._world:GetService("BoardLogic")
      local blockVal = boardsvc:GetEntityMoveBlockFlag(e)
      local fitFullBodyArea = self:IsPosFitFullBodyArea(v2, e, blockVal, nil)
      if not fitFullBodyArea then
        canMove = false
        break
      end
    else
      local pieceBlock = utilData:FindBlockByPos(v2)
      if utilData:IsValidPiecePos(v2) and pieceBlock and not lbsvc:IsPosBlock(v2, blockFlag) then
      else
        canMove = false
        break
      end
    end
    if canMove then
      final = v2
      moveStep = i
    else
      break
    end
  end
  return moveStep
end

function PreviewSkillEffectCalc_ForceMovement:_ReCalcMoveDirByTargetAndPick(targetEntity, pickPos, dirPos, defaultStep, isCalcStepByPick)
  local dir
  local step = defaultStep
  local targetPos = targetEntity:GetGridPosition()
  local bodyArea = targetEntity:BodyArea():GetArea()
  if bodyArea then
    if #bodyArea == 1 then
      dir = dirPos - pickPos
      step = math.abs(dir.x) + math.abs(dir.y)
      if dir.x > 0 then
        dir.x = 1
      elseif dir.x < 0 then
        dir.x = -1
      end
      if dir.y > 0 then
        dir.y = 1
      elseif dir.y < 0 then
        dir.y = -1
      end
    else
      local upMaxY, downMinY, rightMaxX, leftMinX
      for index, off in ipairs(bodyArea) do
        local bodyPos = targetPos + off
        if not upMaxY then
          upMaxY = bodyPos.y
        elseif upMaxY < bodyPos.y then
          upMaxY = bodyPos.y
        end
        if not downMinY then
          downMinY = bodyPos.y
        elseif downMinY > bodyPos.y then
          downMinY = bodyPos.y
        end
        if not rightMaxX then
          rightMaxX = bodyPos.x
        elseif rightMaxX < bodyPos.x then
          rightMaxX = bodyPos.x
        end
        if not leftMinX then
          leftMinX = bodyPos.x
        elseif leftMinX > bodyPos.x then
          leftMinX = bodyPos.x
        end
      end
      if upMaxY < dirPos.y then
        dir = Vector2.up
        if isCalcStepByPick then
          step = dirPos.y - upMaxY
        end
      elseif downMinY > dirPos.y then
        dir = Vector2.down
        if isCalcStepByPick then
          step = downMinY - dirPos.y
        end
      elseif rightMaxX < dirPos.x then
        dir = Vector2.right
        if isCalcStepByPick then
          step = dirPos.x - rightMaxX
        end
      elseif leftMinX > dirPos.x then
        dir = Vector2.left
        if isCalcStepByPick then
          step = leftMinX - dirPos.x
        end
      end
    end
  end
  dir = dir * -1
  return dir, step
end
