require("calc_base")
_class("SkillEffectCalc_IsolateConvert", SkillEffectCalc_Base)
SkillEffectCalc_IsolateConvert = SkillEffectCalc_IsolateConvert

function SkillEffectCalc_IsolateConvert:DoSkillEffectCalculator(calcParam)
  local teidTarget = calcParam:GetTargetEntityIDs()
  local tResult = {}
  for _, eid in ipairs(teidTarget) do
    local result = self:DoSingleTargetProcess(calcParam, eid)
    if result then
      table.insert(tResult, result)
    end
  end
  return tResult
end

function SkillEffectCalc_IsolateConvert:_CalcIsolateMatrix(v2TargetPos)
  local v2TargetX = v2TargetPos.x
  local v2TargetY = v2TargetPos.y
  local v2TargetXLeft = v2TargetX - 1
  local v2TargetXRight = v2TargetX + 1
  local v2TargetYUp = v2TargetY + 1
  local v2TargetYDown = v2TargetY - 1
  local tv2Ring = {
    Vector2.New(v2TargetX, v2TargetYUp),
    Vector2.New(v2TargetXRight, v2TargetYUp),
    Vector2.New(v2TargetXRight, v2TargetY),
    Vector2.New(v2TargetXRight, v2TargetYDown),
    Vector2.New(v2TargetX, v2TargetYDown),
    Vector2.New(v2TargetXLeft, v2TargetYDown),
    Vector2.New(v2TargetXLeft, v2TargetY),
    Vector2.New(v2TargetXLeft, v2TargetYUp)
  }
  return tv2Ring
end

function SkillEffectCalc_IsolateConvert:DoSingleTargetProcess(calcParam, eid)
  local eTarget = self._world:GetEntityByID(eid)
  if not eTarget then
    return
  end
  local effectParam = calcParam:GetSkillEffectParam()
  local pattern = effectParam:GetPattern()
  local v2TargetPos = eTarget:GetGridPosition()
  local tv2BodyArea = eTarget:BodyArea():GetArea()
  local tv2SortedRing = self:_CalcIsolateMatrix(v2TargetPos)
  local svcTrap = self._world:GetService("TrapLogic")
  local teTraps = self._world:GetGroup(self._world.BW_WEMatchers.Trap):GetEntities()
  local flushableTrapDic = {}
  for _, eTrap in ipairs(teTraps) do
    if not eTrap:HasDeadMark() then
      local level = eTrap:Trap():GetTrapLevel()
      local pos = eTrap:GetGridPosition()
      if svcTrap:IsTrapFlushable(level) then
        local integerPos = Vector2.New(pos.x, pos.y)
        local posIndex = integerPos:PosIndex()
        if not flushableTrapDic[posIndex] then
          flushableTrapDic[posIndex] = {}
        end
        table.insert(flushableTrapDic[posIndex], eTrap:GetID())
      end
    end
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local tAtomData = {}
  local i = 0
  for index, v2 in ipairs(tv2SortedRing) do
    i = i + 1
    if not boardServiceLogic:IsPosBlock(v2, BlockFlag.Skill | BlockFlag.SkillSkip | BlockFlag.ChangeElement) then
      local integerPos = Vector2.New(v2.x, v2.y)
      local tFlushTrap = flushableTrapDic[integerPos:PosIndex()] or {}
      local oldPieceType = boardServiceLogic:GetPieceType(integerPos)
      local atom = SkillEffectResult_IsolateConvert_AtomicData:New(v2, oldPieceType, pattern[i], tFlushTrap)
      table.insert(tAtomData, atom)
    end
  end
  local result = SkillEffectResult_IsolateConvert:New(tAtomData)
  return result
end
