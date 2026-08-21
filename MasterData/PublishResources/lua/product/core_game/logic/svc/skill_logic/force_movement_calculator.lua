_class("ForceMovementCalculator", Object)
ForceMovementCalculator = ForceMovementCalculator

function ForceMovementCalculator:Constructor(world)
  self._world = world
end

function ForceMovementCalculator.GetEntitySortFunctionByDir(dir)
  if dir.x < 0 and 0 < dir.y then
    return ForceMovementCalculator.SortEntityByDir_LT
  elseif dir.x == 0 and 0 < dir.y then
    return ForceMovementCalculator.SortEntityByDir_Top
  elseif dir.x > 0 and 0 < dir.y then
    return ForceMovementCalculator.SortEntityByDir_RT
  elseif dir.x < 0 and dir.y == 0 then
    return ForceMovementCalculator.SortEntityByDir_Left
  elseif dir.x > 0 and dir.y == 0 then
    return ForceMovementCalculator.SortEntityByDir_Right
  elseif dir.x < 0 and 0 > dir.y then
    return ForceMovementCalculator.SortEntityByDir_LB
  elseif dir.x == 0 and 0 > dir.y then
    return ForceMovementCalculator.SortEntityByDir_Bottom
  elseif dir.x > 0 and 0 > dir.y then
    return ForceMovementCalculator.SortEntityByDir_RB
  end
end

function ForceMovementCalculator.SortEntityByDir_LT(left, right)
  local v2LeftPos = left:GetGridPosition()
  local v2RightPos = right:GetGridPosition()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  local v2SortPov = Vector2.New(1, boardMaxY)
  return Vector2.Distance(v2LeftPos, v2SortPov) > Vector2.Distance(v2RightPos, v2SortPov)
end

function ForceMovementCalculator.SortEntityByDir_RT(left, right)
  local v2LeftPos = left:GetGridPosition()
  local v2RightPos = right:GetGridPosition()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  local v2SortPov = Vector2.New(boardMaxX, boardMaxY)
  return Vector2.Distance(v2LeftPos, v2SortPov) > Vector2.Distance(v2RightPos, v2SortPov)
end

function ForceMovementCalculator.SortEntityByDir_LB(left, right)
  local v2LeftPos = left:GetGridPosition()
  local v2RightPos = right:GetGridPosition()
  local v2SortPov = Vector2.New(1, 1)
  return Vector2.Distance(v2LeftPos, v2SortPov) > Vector2.Distance(v2RightPos, v2SortPov)
end

function ForceMovementCalculator.SortEntityByDir_RB(left, right)
  local v2LeftPos = left:GetGridPosition()
  local v2RightPos = right:GetGridPosition()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local v2SortPov = Vector2.New(boardMaxX, 1)
  return Vector2.Distance(v2LeftPos, v2SortPov) > Vector2.Distance(v2RightPos, v2SortPov)
end

function ForceMovementCalculator.SortEntityByDir_Left(left, right)
  local v2LeftPos = left:GetGridPosition()
  local v2RightPos = right:GetGridPosition()
  if v2LeftPos.x ~= v2RightPos.x then
    return v2LeftPos.x > v2RightPos.x
  else
    return v2LeftPos.y > v2RightPos.y
  end
end

function ForceMovementCalculator.SortEntityByDir_Right(left, right)
  local v2LeftPos = left:GetGridPosition()
  local v2RightPos = right:GetGridPosition()
  if v2LeftPos.x ~= v2RightPos.x then
    return v2LeftPos.x < v2RightPos.x
  else
    return v2LeftPos.y > v2RightPos.y
  end
end

function ForceMovementCalculator.SortEntityByDir_Top(left, right)
  local v2LeftPos = left:GetGridPosition()
  local v2RightPos = right:GetGridPosition()
  if v2LeftPos.y ~= v2RightPos.y then
    return v2LeftPos.y < v2RightPos.y
  else
    return v2LeftPos.x > v2RightPos.x
  end
end

function ForceMovementCalculator.SortEntityByDir_Bottom(left, right)
  local v2LeftPos = left:GetGridPosition()
  local v2RightPos = right:GetGridPosition()
  if v2LeftPos.y ~= v2RightPos.y then
    return v2LeftPos.y > v2RightPos.y
  else
    return v2LeftPos.x > v2RightPos.x
  end
end

function ForceMovementCalculator:Calculate(casterEntity, skillEffectParam)
  local pickupComponent = casterEntity:ActiveSkillPickUpComponent()
  if not pickupComponent then
    Log.error(self._className, "施法者没有ActiveSkillPickupComponent")
    return
  end
  local pickupPosArray = pickupComponent:GetAllValidPickUpGridPos()
  if #pickupPosArray == 0 then
    Log.error(self._className, "没有点选位置记录")
    return
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
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local targetIDs = scopeResult:GetTargetIDs()
  local includeMultiSize = skillEffectParam:IsIncludeMultiSize()
  local includeTrap = skillEffectParam:IsIncludeTrap()
  local tSelectedTarget = {}
  for _, targetID in ipairs(targetIDs) do
    local e = self._world:GetEntityByID(targetID)
    if self:IsEntityTarget(e, includeMultiSize, includeTrap) then
      table.insert(tSelectedTarget, e)
    end
  end
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
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local skillEffectCalcSvc = self._world:GetService("SkillEffectCalc")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local triggerSvc = self._world:GetService("Trigger")
  local boardEntity = self._world:GetBoardEntity()
  local isCalcStepByPick = skillEffectParam:IsCalcStepByPick()
  local isRecordCurRoundForceMoveStep = skillEffectParam:IsRecordCurRoundForceMoveStep()
  local result = SkillEffectResult_ForceMovement:New()
  for _, e in ipairs(tSelectedTarget) do
    local maxStep = skillEffectParam:GetStep()
    if isPickTargetMove then
      v2Dir, maxStep = self:_ReCalcMoveDirByTargetAndPick(e, moveCenterPos, pickupDirPos, maxStep, isCalcStepByPick)
    end
    local v2Begin = e:GetGridPosition()
    local bodyArea = e:BodyArea():GetArea()
    local final
    for i = 1, maxStep do
      local v2 = v2Begin - v2Dir * i
      local posLast = v2Begin - v2Dir * (i - 1)
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
        if utilData:IsValidPiecePos(v2) and pieceBlock and not boardServiceLogic:IsPosBlock(v2, blockFlag) then
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
        if isRecordCurRoundForceMoveStep then
          local recordBuffCmpt = casterEntity:BuffComponent()
          local buffValueKey = "CurRoundForceMoveStep"
          local curRoundForceMoveStep = recordBuffCmpt:GetBuffValue(buffValueKey) or 0
          curRoundForceMoveStep = curRoundForceMoveStep + i
          recordBuffCmpt:SetBuffValue(buffValueKey, curRoundForceMoveStep)
        end
      else
        break
      end
    end
    local trapIds = {}
    if final then
      local defender = e
      local defenderPos = v2Begin
      local targetPos = final
      local bodyArea, blockFlag = boardServiceLogic:RemoveEntityBlockFlag(defender, defenderPos)
      local tConvertInfo = {}
      local pieceChangeTable = skillEffectCalcSvc:_CalcHitbackPieceChangeTable(defenderPos, targetPos, defender)
      if pieceChangeTable ~= nil then
        for pos, pieceType in pairs(pieceChangeTable) do
          boardServiceLogic:SetPieceTypeLogic(pieceType, pos)
          local convertInfo = NTGridConvert_ConvertInfo:New(pos, PieceType.None, pieceType)
          table.insert(tConvertInfo, convertInfo)
        end
      end
      local ntGridConvert = NTGridConvert:New(boardEntity, tConvertInfo)
      ntGridConvert:SetConvertEffectType(SkillEffectType.ForceMovement)
      ntGridConvert:SetSkillType(skillEffectParam:GetSkillType())
      triggerSvc:Notify(ntGridConvert)
      defender:SetGridPosition(targetPos)
      triggerSvc:Notify(NTForceMovement:New(defender, defenderPos, targetPos))
      if defender:HasTeam() then
        local pets = defender:Team():GetTeamPetEntities()
        for i, petEntity in ipairs(pets) do
          petEntity:SetGridPosition(targetPos)
          petEntity:GridLocation():SetMoveLastPosition(targetPos)
        end
      end
      if targetPos ~= defenderPos then
        local triggerTraps = trapServiceLogic:TriggerTrapByEntity(defender, TrapTriggerOrigin.Hitback)
        for i, e in ipairs(triggerTraps) do
          trapIds[#trapIds + 1] = e:GetID()
        end
      end
      local colorNew = utilData:FindPieceElement(targetPos)
      if defender:HasTeam() and boardServiceLogic:GetCanConvertGridElement(targetPos) then
        colorNew = PieceType.None
      end
      boardServiceLogic:SetPieceTypeLogic(colorNew, defender:GetGridPosition())
      boardServiceLogic:SetEntityBlockFlag(defender, targetPos, blockFlag)
    end
    result:AppendMoveResult(e:GetID(), v2Begin, final or v2Begin, trapIds)
  end
  casterEntity:SkillContext():GetResultContainer():AddEffectResult(result)
end

function ForceMovementCalculator:IsEntityTarget(e, includeMultiSize, includeTrap)
  local utilData = self._world:GetService("UtilData")
  return utilData:IsEntityForceMovementTarget(e, includeMultiSize, includeTrap)
end

function ForceMovementCalculator:_NewPieceBlockBlackboard(centerPos, targetIDs)
  local utilData = self._world:GetService("UtilData")
  local blackboard = utilData:CreatePieceBlockBlackboard(targetIDs)
  return blackboard
end

function ForceMovementCalculator:IsPosFitFullBodyArea(gridPos, entity, testBlockVal, bodyAreaByOff)
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

function ForceMovementCalculator:_ReCalcMoveDirByTargetAndPick(targetEntity, pickPos, dirPos, defaultStep, isCalcStepByPick)
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
  dir = dir * -1
  return dir, step
end

function ForceMovementCalculator:CalcTargetForceMovementStep(targetEntity, dir, maxStep)
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
    local v2 = e:GetGridPosition() + v2Dir * i
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
