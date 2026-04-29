require("scope_base")
_class("SkillScopeCalculator_CrossABackBNearCaster", SkillScopeCalculator_Base)
SkillScopeCalculator_CrossABackBNearCaster = SkillScopeCalculator_CrossABackBNearCaster

function SkillScopeCalculator_CrossABackBNearCaster:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local backOffset = scopeParam[1]
  local trapID = scopeParam[2]
  local areaPosList = {}
  for i, p in ipairs(bodyArea) do
    local curPos = centerPos + p
    table.insert(areaPosList, curPos)
  end
  local startIdx = 1
  local backIdx = startIdx + backOffset
  local attackRange = {}
  local validCorssAPosList = {}
  local validBackBPosList = {}
  local sortPosList = {}
  local preDashDir = {
    Vector2.up,
    Vector2.down,
    Vector2.left,
    Vector2.right
  }
  for i, p in ipairs(areaPosList) do
    for _, dir in ipairs(preDashDir) do
      local prePos = p + dir
      local backOffsetPos = p + dir:Mul(backIdx)
      if self:CheckPosValid(prePos, trapID) and self:CheckPosValid(backOffsetPos, trapID) and not table.icontains(validCorssAPosList, prePos) and not table.icontains(validBackBPosList, backOffsetPos) then
        validCorssAPosList[#validCorssAPosList + 1] = prePos
        sortPosList[#sortPosList + 1] = prePos
        validBackBPosList[#validBackBPosList + 1] = backOffsetPos
      end
    end
  end
  if 0 < #sortPosList then
    HelperProxy:SortPosByCenterPosDistance(casterPos, sortPosList)
    local neareastPos = sortPosList[1]
    for i, pos in ipairs(validCorssAPosList) do
      if pos == neareastPos then
        attackRange[#attackRange + 1] = pos
        attackRange[#attackRange + 1] = validBackBPosList[i]
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.CrossABackBNearCaster, casterPos, attackRange, attackRange)
  return result
end

function SkillScopeCalculator_CrossABackBNearCaster:CheckPosValid(pos, trapID)
  local isValid = self._gridFilter:IsValidPiecePos(pos)
  if not isValid then
    return false
  end
  local isBlocked = self._gridFilter:IsPosBlock(pos, BlockFlag.MonsterLand | BlockFlag.MonsterFly)
  if isBlocked then
    return self._gridFilter:IsPosHasTrapByTrapID(pos, trapID)
  end
  return true
end
