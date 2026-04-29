_class("SkillPreviewEffectCalcService", Object)
SkillPreviewEffectCalcService = SkillPreviewEffectCalcService

function SkillPreviewEffectCalcService:Constructor(world)
  self._world = world
  self._skillEffectParamParser = SkillEffectParamParser:New()
end

function SkillPreviewEffectCalcService:Initialize()
  self._configService = self._world:GetService("Config")
  self._utilDataService = self._world:GetService("UtilData")
end

function SkillPreviewEffectCalcService:_CreateSkillEffectCalcParam(casterID, targetIDArray, effectParam, range)
  local calcParam = SkillEffectCalcParam:New(casterID, targetIDArray, effectParam, 0, range)
  return calcParam
end

function SkillPreviewEffectCalcService:CreateSkillEffectParam(effectType, effectParam)
  local param = self._skillEffectParamParser:ParseSkillEffectParam(effectType, effectParam)
  return param
end

function SkillPreviewEffectCalcService:CalcConvertGridElement(casterEntity, scopeGridList, param)
  local skillConvertEffectParam = param
  local sourceArray = skillConvertEffectParam:GetSourceGridElement()
  local targetElementType = skillConvertEffectParam:GetTargetGridElement()
  local useEntityElement = false
  local elementEntity
  if skillConvertEffectParam:IsConvertToCasterElement() then
    useEntityElement = true
    elementEntity = casterEntity
  elseif skillConvertEffectParam:IsConvertToTeamLeaderElement() then
    useEntityElement = true
    local teamEntity
    if casterEntity:HasPet() then
      teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    elseif casterEntity:HasTeam() then
      teamEntity = casterEntity
    end
    elementEntity = teamEntity:GetTeamLeaderPetEntity()
  end
  if useEntityElement and elementEntity and elementEntity:Element() ~= nil and elementEntity:Element():GetPrimaryType() ~= nil then
    local tarElement = elementEntity:Element():GetPrimaryType()
    targetElementType = tarElement
    local newSource = {}
    for _, elementType in ipairs(sourceArray) do
      if targetElementType ~= elementType then
        table.insert(newSource, elementType)
      end
    end
    sourceArray = newSource
  end
  local targetMaxCount = skillConvertEffectParam:GetTargetGridElementCount()
  local ignoreBlock = skillConvertEffectParam:IsIgnoreBlock()
  local targetGridDic = {}
  local hasEnoughTarget = false
  local currentTargetCount = 0
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local skillRangePosList = {}
  local blockedPieces = {}
  for k, v in pairs(scopeGridList) do
    local cantConverPos = env:IsPosBlock(v, BlockFlag.ChangeElement)
    if ignoreBlock then
      cantConverPos = false
    end
    if cantConverPos then
      table.insert(blockedPieces, v)
    else
      table.insert(skillRangePosList, v)
    end
  end
  for _, gridPos in ipairs(skillRangePosList) do
    local isMatch = self:IsPreviewGridElementMatch(gridPos, sourceArray)
    if isMatch then
      targetGridDic[#targetGridDic + 1] = Vector2(gridPos.x, gridPos.y)
      currentTargetCount = currentTargetCount + 1
      if targetMaxCount <= currentTargetCount then
        hasEnoughTarget = true
        break
      end
    end
  end
  local skillConvertEffectResult = SkillConvertGridElementEffectResult:New(targetGridDic, targetElementType, blockedPieces)
  return skillConvertEffectResult
end

function SkillPreviewEffectCalcService:CalcHitBack(casterEntity, scopeGridList, targetID, skillPreviewContext, param)
  local attackerPos = skillPreviewContext:GetCasterPos()
  local attackerDir = skillPreviewContext:GetCasterDir()
  local attackerBodyArea = skillPreviewContext:GetCasterBodyArea()
  local hitBackDirType = skillPreviewContext:GetHitBackDirType()
  local ignorePlayerBlock = param:GetIgnorePlayerBlock()
  hitBackDirType = hitBackDirType or param:GetDirType()
  local type = param:GetType()
  local hitBackDistance = param:GetDistance()
  local calcType = param:GetCalcType()
  local excludeCasterPos = param:ExcludeCasterPos()
  local backupDirectionPlan = param:GetBackupDirectionPlan()
  local enableByPickNum = param:GetEnableByPickNum()
  if enableByPickNum then
    local checkNum = tonumber(enableByPickNum)
    local attacker = casterEntity
    local component = attacker:PreviewPickUpComponent()
    if component then
      local curPickNum = component:GetAllValidPickUpGridPosCount()
      if curPickNum ~= checkNum then
        return
      end
    end
  end
  local defender = self._world:GetEntityByID(targetID)
  if not defender then
    return nil
  end
  if defender:HasTrapID() then
    local trapRenderCmpt = defender:TrapRender()
    if TrapType.BombByHitBack ~= trapRenderCmpt:GetTrapType() then
      return
    end
  end
  local defenderPos = defender:GetGridPosition()
  local defenderBodyArea = defender:BodyArea()
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if env:IsImmuneHitback(defender) then
    return SkillHitBackEffectResult:New(targetID, defenderPos, defenderPos)
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local dir
  if hitBackDirType == HitBackDirectionType.Cross then
    dir = GameHelper.ComputeLogicDir(attackerDir)
  elseif hitBackDirType == HitBackDirectionType.SelectCanUseDir then
    dir, hitBackDistance = utilCalcSvc:_CalCanUseHitBackDir(defender, hitBackDistance)
  else
    dir = utilCalcSvc:_CalcHitBackDir(hitBackDirType, attackerPos, defenderPos, attackerBodyArea, defenderBodyArea)
  end
  if dir == nil or dir == Vector2.zero then
    if backupDirectionPlan then
      if backupDirectionPlan == HitBackDirectionBackupPlan.AlwaysUp then
        dir = Vector2.up
      end
    else
      Log.fatal("击退方向计算结果错误！")
      return SkillHitBackEffectResult:New(targetID, defenderPos, defenderPos)
    end
  end
  if type == HitBackType.PullBack then
    dir = -dir
  end
  local excludePosList = {}
  if excludeCasterPos then
    local casterBodyArea = attackerBodyArea:GetArea()
    if casterBodyArea and attackerPos then
      for i = 1, #casterBodyArea do
        excludePosList[#excludePosList + 1] = casterBodyArea[i] + attackerPos
      end
    end
  end
  local targetPos = defenderPos:Clone()
  local bodyArea = defenderBodyArea:GetArea()
  for i = 1, #bodyArea do
    excludePosList[#excludePosList + 1] = defenderPos + bodyArea[i]
  end
  local useCheckBlockFlag = BlockFlag.HitBack
  if defender:HasMonsterID() then
    local raceType = defender:MonsterID():GetMonsterRaceType()
    if MonsterRaceType.Fly == raceType then
      useCheckBlockFlag = BlockFlag.HitBackFly
    end
  end
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local utilData = self._world:GetService("UtilData")
  for i = 1, hitBackDistance do
    local tempPos = targetPos + dir
    local needBreak = false
    for i = 1, #bodyArea do
      local tempBodyPos = tempPos + bodyArea[i]
      if not table.icontains(excludePosList, tempBodyPos) then
        if not utilData:IsValidPiecePos(tempBodyPos) then
          needBreak = true
          break
        end
        if env:IsPosBlock(tempBodyPos, useCheckBlockFlag) or utilData:IsPosBlockWithEntityRace(tempBodyPos, useCheckBlockFlag, defender) then
          needBreak = true
          break
        end
        local checkTrapWallPosStart = tempBodyPos - dir
        local trapWallBlock = utilData:CalcHitbackForTrapWallBlock(checkTrapWallPosStart, tempBodyPos, useCheckBlockFlag)
        if trapWallBlock then
          needBreak = true
          break
        end
      end
    end
    local trapWallBlock = utilData:CalcHitbackForTrapWallBlockMultiBodyArea(tempPos, bodyArea)
    if trapWallBlock then
      needBreak = true
      break
    end
    if needBreak then
      break
    end
    targetPos = tempPos
  end
  local trapRenderCmpt = defender:TrapRender()
  if trapRenderCmpt and TrapType.BombByHitBack == trapRenderCmpt:GetTrapType() then
    local posNext = targetPos + dir
    if utilData:IsHaveEntity(posNext, EnumTargetEntity.Pet | EnumTargetEntity.Monster) then
      targetPos = posNext
    end
  end
  if targetPos ~= defenderPos then
    env:DelEntityBlockFlag(defender, defender:GridLocation():GetGridPos())
    env:AddEntityBlockFlag(defender, targetPos)
  end
  local hitbackResult = SkillHitBackEffectResult:New(targetID, defenderPos, targetPos, nil, calcType, dir)
  return hitbackResult
end

function SkillPreviewEffectCalcService:CalcMultiTraction(casterEntity, skillPreviewContext, param, transContextCenter)
  local centerPos = skillPreviewContext:GetCasterPos()
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  if previewPickUpComponent then
    local pickUpGridArray = previewPickUpComponent:GetAllValidPickUpGridPos()
    centerPos = pickUpGridArray[1]
  end
  if transContextCenter then
    centerPos = skillPreviewContext:GetScopeCenterPosList()
  end
  local scopeResult = skillPreviewContext:GetScopeResult(SkillEffectType.MultiTraction)
  local calcParam = self:_CreateSkillEffectCalcParam(casterEntity:GetID(), {}, param, scopeResult)
  calcParam:SetGridPos(centerPos)
  param._finalDamageIncreateRate = nil
  local skillEffectCalc = SkillEffectCalc_MultiTraction:New(self._world)
  local result = skillEffectCalc:DoSkillEffectCalculator(calcParam)
  return result
end

function SkillPreviewEffectCalcService:CalcSerialKiller(casterEntityID, nearestEntityIDs, skillEffectParam, skillID)
  local attacker = self._world:GetEntityByID(casterEntityID)
  local serialScopeType = skillEffectParam:GetSerialScopeType()
  local radius = skillEffectParam:GetRadius()
  local pieceType = skillEffectParam:GetPieceType()
  local posCaster = attacker:GetGridPosition()
  local casterBodyArea = attacker:BodyArea():GetArea()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(serialScopeType, {
    [1] = radius,
    [2] = 0
  }, posCaster, casterBodyArea)
  local addPiecePosList = {}
  local env = self._world:GetPreviewEntity():PreviewEnv()
  if scopeResult then
    local array = scopeResult:GetAttackRange()
    for _, v in pairs(array) do
      local pt = env:GetPieceType(v)
      if pt == pieceType then
        table.insert(addPiecePosList, v)
      end
    end
  end
  local res = SkillSerialKillerResult:New()
  res:SetAddPiecePosList(addPiecePosList)
  return res
end

function SkillPreviewEffectCalcService:CalcForceMovement(casterEntity, skillPreviewContext, skillEffectParam)
  local skillEffectCalc = PreviewSkillEffectCalc_ForceMovement:New(self._world)
  local result = skillEffectCalc:Calculate(casterEntity, skillPreviewContext, skillEffectParam)
  return result
end

function SkillPreviewEffectCalcService:CalcTargetFourDirForceMovementStep(targetEntity, maxStep)
  local skillEffectCalc = PreviewSkillEffectCalc_ForceMovement:New(self._world)
  local result = skillEffectCalc:CalcTargetFourDirForceMovementStep(targetEntity, skillPreviewContext, skillEffectParam)
  return result
end

function SkillPreviewEffectCalcService:CalcTargetForceMovementStep(casterEntity, v2Dir, maxStep)
  local skillEffectCalc = PreviewSkillEffectCalc_ForceMovement:New(self._world)
  local result = skillEffectCalc:CalcTargetForceMovementStep(casterEntity, v2Dir, maxStep)
  return result
end

function SkillPreviewEffectCalcService:CalcTransportByRange(casterEntity, skillPreviewContext, effectParam, pickUpList)
  local targetIDs = skillPreviewContext:GetTargetEntityIDList(SkillEffectType.TransportByRange)
  local isPickUp = effectParam:IsPickUp()
  local isTransportTarget = effectParam:IsTransportTarget()
  local result = SkillEffectResultTransportByRange:New()
  local range, dirType
  if isPickUp then
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    range, dirType = utilScopeSvc:CalcRangeByPickUpPosList(pickUpList)
    local utilDataSvc = self._world:GetService("UtilData")
    for i, v in ipairs(range) do
      local nextPos = self:GridGetNextPos(v, dirType)
      local pieceType = utilDataSvc:GetPieceType(v)
      local pieceData = TransportByRangePieceData:New(v, pieceType, nextPos)
      result:AddPieceData(pieceData)
    end
  end
  if isTransportTarget then
    local targetID = targetIDs[1]
    local targetEntity = self._world:GetEntityByID(targetID)
    local utilDatSvc = self._world:GetService("UtilData")
    if targetEntity and not utilDatSvc:CheckForceMoveImmunity(targetEntity) then
      local pos = targetEntity:GetGridPosition()
      local bodyAreaCount = targetEntity:BodyArea():GetAreaCount()
      if bodyAreaCount == 1 then
        local nextPos = self:GetNextPos(pos, dirType)
        local utilDataSvc = self._world:GetService("UtilData")
        if utilDataSvc:IsMonsterCanTel2TargetPos(targetEntity, nextPos) then
          result:AddTargetData(targetID, pos, nextPos)
        end
      end
    end
  end
  return result
end

function SkillPreviewEffectCalcService:_GetNextPos(i, pos, dirType)
  local nextPos
  if dirType == DirectionType.Up then
    nextPos = Vector2(pos.x, pos.y + i)
  elseif dirType == DirectionType.Down then
    nextPos = Vector2(pos.x, pos.y - i)
  elseif dirType == DirectionType.Left then
    nextPos = Vector2(pos.x - i, pos.y)
  elseif dirType == DirectionType.Right then
    nextPos = Vector2(pos.x + i, pos.y)
  end
  return nextPos
end

function SkillPreviewEffectCalcService:GetNextPos(pos, dirType)
  local max
  local utilScopeCalcSvc = self._world:GetService("UtilScopeCalc")
  local nextPos
  if dirType == DirectionType.Up or dirType == DirectionType.Down then
    max = utilScopeCalcSvc:GetCurBoardMaxY()
  elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
    max = utilScopeCalcSvc:GetCurBoardMaxX()
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  for i = 1, max do
    local tmpPos = self:_GetNextPos(i, pos, dirType)
    local pieceType = utilDataSvc:GetPieceType(tmpPos)
    if not utilScopeSvc:IsValidPiecePos(tmpPos) then
      return tmpPos
    end
    if pieceType and pieceType ~= PieceType.None then
      return tmpPos
    end
  end
  return nextPos
end

function SkillPreviewEffectCalcService:GridGetNextPos(pos, dirType)
  local max
  local utilScopeCalcSvc = self._world:GetService("UtilScopeCalc")
  local nextPos
  if dirType == DirectionType.Up or dirType == DirectionType.Down then
    max = utilScopeCalcSvc:GetCurBoardMaxY()
  elseif dirType == DirectionType.Left or dirType == DirectionType.Right then
    max = utilScopeCalcSvc:GetCurBoardMaxX()
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  for i = 1, max do
    local tmpPos = self:_GetNextPos(i, pos, dirType)
    local pieceType = utilDataSvc:GetPieceType(tmpPos)
    if not utilScopeSvc:IsValidPiecePos(tmpPos) then
      return tmpPos
    end
    if pieceType and pieceType ~= PieceType.None and utilDataSvc:IsPosCanConvertGridElement(tmpPos) then
      return tmpPos
    end
  end
  return nextPos
end

function SkillPreviewEffectCalcService:CalcPickUpGridTogether(casterEntity, skillPreviewContext, effectParam, pickUpList)
  local skillRange = skillPreviewContext:GetScopeResult()
  local rangeCount = #skillRange
  local pickupPos = pickUpList[1]
  local pickupIndex = self:FindPickIndex(skillRange, pickupPos)
  local pieceType = effectParam:GetGridType()
  local gridDataList = self:BuildData(skillRange)
  local replaceIndex = pickupIndex
  for i = pickupIndex, rangeCount do
    local gridData = gridDataList[i]
    if pieceType == gridData:GetGridType() and gridData:IsCanConvert() and i ~= replaceIndex then
      local tmpData = gridData
      Log.info("ReplaceIndex:", replaceIndex, "Type:", gridData:GetGridType(), " GridPos:", gridData:GetGridPos())
      local j = replaceIndex
      while i >= j do
        local tmpR = self:FindCanTogetherGrid(gridDataList, j, i, 1)
        if tmpR then
          Log.info("DownToUp Index:", tmpR, "Pos:", skillRange[tmpR], " NewType:", tmpData:GetGridType())
          local tempGridData = gridDataList[tmpR]
          gridDataList[tmpR] = tmpData
          tmpData = tempGridData
          j = tmpR
        end
        j = j + 1
      end
      replaceIndex = replaceIndex + 1
    end
  end
  replaceIndex = pickupIndex
  for i = pickupIndex, 1, -1 do
    local gridData = gridDataList[i]
    if pieceType == gridData:GetGridType() and gridData:IsCanConvert() and i ~= replaceIndex then
      Log.info("ReplaceIndex:", replaceIndex, "GridPos:", gridData:GetGridPos())
      local tmpData = gridData
      local j = replaceIndex
      while i <= j do
        local tmpR = self:FindCanTogetherGrid(gridDataList, j, i, -1)
        if tmpR then
          Log.info("UpToDown Index:", tmpR, "Pos:", skillRange[tmpR], " NewType:", tmpData:GetGridType())
          local tempGridData = gridDataList[tmpR]
          gridDataList[tmpR] = tmpData
          tmpData = tempGridData
          j = tmpR
        end
        j = j - 1
      end
      replaceIndex = replaceIndex - 1
    end
  end
  for i, pos in ipairs(skillRange) do
    gridDataList[i]:SetGridPos(pos)
  end
  local results = SkillEffectResult_PickUpGridTogether:New(gridDataList)
  return results
end

function SkillPreviewEffectCalcService:FindCanTogetherGrid(gridDataList, beginIndex, endIndex, step)
  for i = beginIndex, endIndex, step do
    local gridData = gridDataList[i]
    if gridData:IsCanConvert() then
      return i
    end
  end
end

function SkillPreviewEffectCalcService:FindPickIndex(range, pickPos)
  for i, v in ipairs(range) do
    if v.x == pickPos.x and v.y == pickPos.y then
      return i
    end
  end
end

function SkillPreviewEffectCalcService:BuildData(skillRange)
  local ret = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  for i, pos in ipairs(skillRange) do
    local gridEntity = renderBoardCmpt:GetGridRenderEntity(pos)
    local pieceType = gridEntity:Piece():GetPieceType()
    local canConvert = utilDataSvc:IsPosCanConvertGridElement(pos)
    if pieceType == PieceType.None then
      canConvert = false
    end
    local data = PickUpGridTogetherData:New(pieceType, pos, canConvert)
    table.insert(ret, data)
  end
  return ret
end

function SkillPreviewEffectCalcService:IsPreviewGridElementMatch(checkPos, convertGridTypeArray)
  local checkPosType = self:GetPreviewGridType(checkPos)
  for k, v in ipairs(convertGridTypeArray) do
    local curGridType = tonumber(v)
    if curGridType == checkPosType then
      return true
    end
  end
  return false
end

function SkillPreviewEffectCalcService:GetPreviewGridType(pos)
  local env = self._world:GetPreviewEntity():PreviewEnv()
  return env:GetPieceType(pos)
end
