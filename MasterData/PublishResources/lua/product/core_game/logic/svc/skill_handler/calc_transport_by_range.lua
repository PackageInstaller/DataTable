_class("SkillEffectCalc_TransportByRange", Object)
SkillEffectCalc_TransportByRange = SkillEffectCalc_TransportByRange

function SkillEffectCalc_TransportByRange:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_TransportByRange:DoSkillEffectCalculator(skillEffectCalcParam)
  local paramSkillEffect = skillEffectCalcParam.skillEffectParam
  local targetIDs = skillEffectCalcParam.targetEntityIDs
  local range = skillEffectCalcParam:GetCenterPos()
  local result = self:_CalcTransportEnvListByRange(paramSkillEffect, range, targetIDs)
  return {result}
end

function SkillEffectCalc_TransportByRange:_GetNextPos(i, pos, dirType)
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

function SkillEffectCalc_TransportByRange:GridGetNextPos(pos, dirType)
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

function SkillEffectCalc_TransportByRange:GetNextPos(pos, dirType)
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

function SkillEffectCalc_TransportByRange:_CalcTransportEnvListByRange(effectParam, pickUpList, targetIDs)
  local isPickUp = effectParam:IsPickUp()
  local isTransportTarget = effectParam:IsTransportTarget()
  local result = SkillEffectResultTransportByRange:New()
  local range, dirType, edgeBegin, edgeEnd, invalidPos, totalRange
  local boardServiceLogic = self._world:GetService("BoardLogic")
  if isPickUp then
    edgeEnd = {}
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    range, dirType, edgeBegin, invalidPos, totalRange = utilScopeSvc:CalcRangeByPickUpPosList(pickUpList)
    local utilDataSvc = self._world:GetService("UtilData")
    for i, v in ipairs(range) do
      local nextPos = self:GridGetNextPos(v, dirType)
      local pieceType = utilDataSvc:GetPieceType(v)
      if not boardServiceLogic:IsValidPiecePos(nextPos) then
        table.insert(edgeEnd, v)
      end
      local pieceData = TransportByRangePieceData:New(v, pieceType, nextPos)
      result:AddPieceData(pieceData)
    end
    result:SetTransportDir(dirType)
    result:SetEdge(edgeBegin, edgeEnd)
    result:SetResetGridPosList(invalidPos)
    result:SetOutlineRange(totalRange)
  end
  local targetData = {}
  if isTransportTarget then
    local targetID = targetIDs[1]
    local targetEntity = self._world:GetEntityByID(targetID)
    local buffLogicSvc = self._world:GetService("BuffLogic")
    if targetEntity and not buffLogicSvc:CheckForceMoveImmunity(targetEntity) then
      local pos = targetEntity:GetGridPosition()
      local bodyAreaCount = targetEntity:BodyArea():GetAreaCount()
      if bodyAreaCount == 1 then
        local nextPos = self:GetNextPos(pos, dirType)
        local utilDataSvc = self._world:GetService("UtilData")
        if utilDataSvc:IsMonsterCanTel2TargetPos(targetEntity, nextPos) and utilDataSvc:IsBlockMoveWithTrapWall(pos, nextPos, targetEntity) == false then
          result:AddTargetData(targetID, pos, nextPos)
          local triggerSvc = self._world:GetService("Trigger")
          triggerSvc:Notify(NTTransportEachMoveEnd:New(targetEntity, pos, nextPos))
        end
      end
    end
  end
  return result
end

function SkillEffectCalc_TransportByRange:_TriggerTraps(result, traps, triggerEntity)
  if triggerEntity:HasTrapID() then
    return
  end
  local trapSvc = self._world:GetService("TrapLogic")
  for _, e in ipairs(traps) do
    if e:HasTrapID() then
      local triggerTraps, triggerResults = trapSvc:CalcTrapTriggerSkill(e, triggerEntity)
      if triggerTraps then
        for i, trap in ipairs(triggerTraps) do
          local skillResult = triggerResults[i]
          result:AddTrapSkillResult(trap:GetID(), skillResult, triggerEntity:GetID())
        end
      end
    end
  end
end
