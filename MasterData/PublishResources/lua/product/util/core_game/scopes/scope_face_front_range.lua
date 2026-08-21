require("scope_base")
_class("SkillScopeCalculator_FaceFrontRange", SkillScopeCalculator_Base)
SkillScopeCalculator_FaceFrontRange = SkillScopeCalculator_FaceFrontRange

function SkillScopeCalculator_FaceFrontRange:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local usecasterDir = scopeParam[3] or 0
  local listPosAttack = {}
  local listPosWhole = {}
  local casterDirList = {
    Vector2(0, 1),
    Vector2(0, -1),
    Vector2(1, 0),
    Vector2(-1, 0)
  }
  if usecasterDir == 1 then
    casterDirList = {casterDir}
  end
  for k, dir in pairs(casterDirList) do
    local curListPosAttack, curListPosWhole = self:_OnCalcFrontRange(scopeParam, bodyArea, casterPos, dir)
    table.appendArray(listPosAttack, curListPosAttack)
    table.appendArray(listPosWhole, curListPosWhole)
  end
  local result = SkillScopeResult:New(SkillScopeType.FaceFrontRange, casterPos, listPosAttack, listPosWhole, nil)
  return result
end

function SkillScopeCalculator_FaceFrontRange:_OnCalcFrontRange(scopeParam, bodyArea, casterPos, dirVector2)
  local nCountRow = scopeParam[1]
  local nCountCol = scopeParam[2]
  local fDirStand45 = math.sqrt(2) / 2
  local nBodyCount = table.count(bodyArea)
  local nBodyBig = 1
  if nBodyCount == 4 then
    nBodyBig = 2
  elseif nBodyCount == 9 then
    nBodyBig = 3
  end
  local dirWork = dirVector2.normalized
  local nLoopRowStart = 0
  local nLoopColStart = 0
  local nLoopRowEnd = 0
  local nLoopColEnd = 0
  if 0 < dirWork.y and dirWork.x >= -fDirStand45 and fDirStand45 >= dirWork.x then
    nLoopRowStart = self:_ComputeHalfStartPos(nCountRow)
    nLoopColStart = nBodyBig
    nLoopRowEnd = nLoopRowStart + nCountRow
    nLoopColEnd = nLoopColStart + nCountCol
  elseif 0 < dirWork.x and dirWork.y >= -fDirStand45 and fDirStand45 >= dirWork.y then
    nLoopRowStart = nBodyBig
    nLoopColStart = self:_ComputeHalfStartPos(nCountRow)
    nLoopRowEnd = nLoopRowStart + nCountCol
    nLoopColEnd = nLoopColStart + nCountRow
  elseif 0 > dirWork.y and dirWork.x >= -fDirStand45 and fDirStand45 >= dirWork.x then
    nLoopRowStart = self:_ComputeHalfStartPos(nCountRow)
    nLoopColStart = -nCountCol
    nLoopRowEnd = nLoopRowStart + nCountRow
    nLoopColEnd = nLoopColStart + nCountCol
  elseif 0 > dirWork.x and dirWork.y >= -fDirStand45 and fDirStand45 >= dirWork.y then
    nLoopRowStart = -nCountCol
    nLoopColStart = self:_ComputeHalfStartPos(nCountRow)
    nLoopRowEnd = nLoopRowStart + nCountCol
    nLoopColEnd = nLoopColStart + nCountRow
  end
  local listPosWhole = {}
  local listPosAttack = {}
  for i = nLoopRowStart, nLoopRowEnd - 1 do
    for j = nLoopColStart, nLoopColEnd - 1 do
      local posWork = casterPos + Vector2.New(i, j)
      if self._gridFilter:IsValidPiecePos(posWork) then
        table.insert(listPosAttack, posWork)
      end
      table.insert(listPosWhole, posWork)
    end
  end
  return listPosAttack, listPosWhole
end
