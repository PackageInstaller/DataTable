_class("SkillEffectCalc_AddGridEffect", Object)
SkillEffectCalc_AddGridEffect = SkillEffectCalc_AddGridEffect

function SkillEffectCalc_AddGridEffect:Constructor(world)
  self._world = world
end

function SkillEffectCalc_AddGridEffect:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillGridEffectParam = skillEffectCalcParam.skillEffectParam
  local gridEffectType = skillGridEffectParam:GetTargetGridEffectType()
  local gridConvertType = skillGridEffectParam:GetGridConvertType()
  local summonTrap = skillGridEffectParam:GetSummonTrap()
  local ignoreConvertForAny = skillGridEffectParam:GetIgnoreConvertForAny()
  local ignoreConvertForBlock = skillGridEffectParam:GetIgnoreConvertForBlock()
  local count = skillGridEffectParam:GetCount()
  local gridList = skillEffectCalcParam.skillRange
  local casterEntityID = skillEffectCalcParam.casterEntityID
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local boardServiceL = self._world:GetService("BoardLogic")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local board = self._world:GetBoardEntity():Board()
  local tConvertInfo = {}
  local posList = table.cloneconf(gridList)
  local utilData = self._world:GetService("UtilData")
  for _, pos in ipairs(posList) do
    local samePosTraps = utilData:GetTrapsAtPos(pos)
    if 0 < #samePosTraps then
      for _, e in ipairs(samePosTraps) do
        local trapCmpt = e:Trap()
        if trapCmpt:GetTrapType() == TrapType.GapTileTrap then
          table.removev(gridList, pos)
        end
      end
    end
  end
  if #gridList == 0 then
    return
  end
  if count and count < #gridList then
    local newPosList = {}
    for i = 1, count do
      table.insert(newPosList, gridList[i])
    end
    gridList = newPosList
  end
  if gridConvertType then
    for _, pos in ipairs(gridList) do
      local nOldColor = utilData:FindPieceElement(pos)
      if ignoreConvertForAny and self:IsForbidConvertAndTypeAny(pos) then
      elseif ignoreConvertForBlock and self:IsForbidConvertByBlock(pos) then
      else
        local convertInfo = NTGridConvert_ConvertInfo:New(pos, nOldColor, gridConvertType)
        table.insert(tConvertInfo, convertInfo)
      end
    end
  end
  local traps = {}
  local gridConvertTypes = {}
  for i = 1, #gridList do
    local gridPos = gridList[i]
    local pt = board:GetPieceType(gridPos)
    if not gridConvertType or gridConvertType == pt or ignoreConvertForAny and self:IsForbidConvertAndTypeAny(gridPos) then
    elseif ignoreConvertForBlock and self:IsForbidConvertByBlock(gridPos) then
    else
      boardServiceL:SetPieceTypeLogic(gridConvertType, gridPos)
      gridConvertTypes[Vector2.Pos2Index(gridPos)] = gridConvertType
    end
    if summonTrap and summonTrap ~= 0 then
      local eTrap = trapServiceLogic:CreateTrap(summonTrap, gridPos, Vector2(0, 1), false, nil, casterEntity)
      if eTrap then
        traps[Vector2.Pos2Index(gridPos)] = eTrap:GetID()
      end
    end
  end
  local nt = NTGridConvert:New(casterEntity, tConvertInfo)
  nt:SetConvertEffectType(SkillEffectType.AddGridEffect)
  nt:SetSkillType(skillGridEffectParam:GetSkillType())
  local triggerService = self._world:GetService("Trigger")
  triggerService:Notify(nt)
  local skillConvertEffectResult = SkillAddGridEffectResult:New(gridList, gridConvertTypes, traps)
  return skillConvertEffectResult
end

function SkillEffectCalc_AddGridEffect:IsForbidConvertAndTypeAny(gridPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local isAnyPiece = utilDataSvc:GetPieceType(gridPos) == PieceType.Any
  local isBlock = utilDataSvc:IsPosBlock(gridPos, BlockFlag.ChangeElement)
  return isAnyPiece and isBlock
end

function SkillEffectCalc_AddGridEffect:IsForbidConvertByBlock(gridPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local isBlock = utilDataSvc:IsPosBlock(gridPos, BlockFlag.ChangeElement)
  return isBlock
end
