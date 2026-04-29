require("scope_base")
_class("SkillScopeCalculator_AngleFreeLineWithWidthGrow", SkillScopeCalculator_Base)
SkillScopeCalculator_AngleFreeLineWithWidthGrow = SkillScopeCalculator_AngleFreeLineWithWidthGrow

function SkillScopeCalculator_AngleFreeLineWithWidthGrow:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  self._world = self._hub._gridFilter._world
  if not self._world then
    Log.exception(self._className, "AngleFreeLineWithWidthGrow无法用于没有world的环境下")
    return SkillScopeResult:New(SkillScopeType.AngleFreeLineWithWidthGrow, casterPos, {}, {})
  end
  local centerPosArray = centerPos
  if centerPos._className then
    centerPosArray = {centerPos}
  end
  local bNoExtend = scopeParam.noExtend == 1
  local widthThreshold = BattleConst.ScopeAngleFreeLineThreshold
  if scopeParam.widthThreshold then
    widthThreshold = scopeParam.widthThreshold * 0.8
  end
  local stepRate = scopeParam.stepRate
  local oriPos = casterPos
  local desPos = centerPosArray[1]
  if oriPos == desPos then
    return SkillScopeResult:New(SkillScopeType.AngleFreeLineWithWidthGrow, casterPos, {casterPos}, {})
  end
  local attackRange = self:_GetAttackRange(oriPos, desPos, bNoExtend, widthThreshold, stepRate)
  local result = SkillScopeResult:New(SkillScopeType.AngleFreeLineWithWidthGrow, centerPos, attackRange, attackRange)
  return result
end

function SkillScopeCalculator_AngleFreeLineWithWidthGrow:_GetAttackRange(oriPos, desPos, noExtend, width, stepRate)
  local attackRange = {}
  local dir = desPos - oriPos
  local pDirUp = Vector2(-dir.y, dir.x)
  local pDirDown = Vector2(dir.y, -dir.x)
  dir = Vector2.Normalize(dir)
  pDirUp = Vector2.Normalize(pDirUp)
  pDirDown = Vector2.Normalize(pDirDown)
  if not noExtend then
    desPos = oriPos + dir * math.sqrt(2 * BattleConst.BoardMaxLen * BattleConst.BoardMaxLen)
  end
  local dis = Vector2.Distance(desPos, oriPos)
  local oriUp = oriPos + pDirUp * width
  local oriDown = oriPos + pDirDown * width
  local desDown = desPos + pDirDown * (width + dis * stepRate)
  local desUp = desPos + pDirUp * (width + dis * stepRate)
  local boardSvc = self._world:GetService("BoardLogic")
  local pieceXYMap = boardSvc:GetGridTiles()
  for x, tableY in pairs(pieceXYMap) do
    for y, _ in pairs(tableY) do
      local curPos = Vector2(x, y)
      if self:IsPointInTrapezoid(curPos, oriUp, oriDown, desDown, desUp) then
        table.insert(attackRange, curPos)
      end
    end
  end
  return attackRange
end

function SkillScopeCalculator_AngleFreeLineWithWidthGrow:IsPointInTrapezoid(P, A, B, C, D)
  local function funRightOfOn(P, A, B)
    return (B.x - A.x) * (P.y - A.y) - (B.y - A.y) * (P.x - A.x) >= 0
  end
  
  return funRightOfOn(P, A, B) and funRightOfOn(P, B, C) and funRightOfOn(P, C, D) and funRightOfOn(P, D, A)
end
