require("scope_base")
_class("SkillScopeCalculator_AngleFreeLinePlus", SkillScopeCalculator_Base)
SkillScopeCalculator_AngleFreeLinePlus = SkillScopeCalculator_AngleFreeLinePlus

function SkillScopeCalculator_AngleFreeLinePlus:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local world = self._hub._gridFilter._world
  if not world then
    Log.exception(self._className, "AngleFreeLine无法用于没有world的环境下")
    return SkillScopeResult:New(SkillScopeType.AngleFreeLinePlus, casterPos, {}, {})
  end
  local centerPosArray = centerPos
  if centerPos._className then
    centerPosArray = {centerPos}
  end
  local bNoExtend = scopeParam.noExtend == 1
  local bNoAniExtend = scopeParam.noAniExtend == 1
  local widthThreshold = BattleConst.ScopeAngleFreeLineThreshold
  if scopeParam.widthThreshold then
    widthThreshold = scopeParam.widthThreshold * 0.8
  end
  local isDirectionReverse = scopeParam.directionReverse == 1
  if scopeParam.useTrapAsBegin then
    local trapID = scopeParam.trapID
    local trapServerLogic = world:GetService("TrapLogic")
    local trapList = {}
    if type(trapID) == "number" then
      trapList[#trapList + 1] = trapID
    elseif type(trapID) == "table" then
      trapList = trapID
    end
    local bFind = false
    for _, vTrapID in ipairs(trapList) do
      local trapCenterPosList = trapServerLogic:FindTrapPosByTrapID(vTrapID)
      if table.count(trapCenterPosList) == 0 then
      else
        casterPos = trapCenterPosList[1]
        bFind = true
        break
      end
    end
    if not bFind then
      return SkillScopeResult:New(SkillScopeType.AngleFreeLinePlus, casterPos, {}, {})
    end
  end
  local useBodyArea = scopeParam.useBodyArea
  local oriPos = casterPos
  local desPos = centerPosArray[1]
  if isDirectionReverse then
    oriPos = centerPosArray[1]
    desPos = casterPos
  end
  if oriPos == desPos then
    return SkillScopeResult:New(SkillScopeType.AngleFreeLinePlus, casterPos, {casterPos}, {})
  end
  local attackRange = {}
  local wholeRange = {}
  local utilScope = world:GetService("UtilScopeCalc")
  utilScope:P2PAngleFreeLineRange(oriPos, desPos, attackRange, wholeRange, bNoExtend, widthThreshold)
  if not bNoAniExtend then
    local aniAttackRange = {}
    local aniWholeRange = {}
    utilScope:P2PAngleFreeLineRange(desPos, oriPos, aniAttackRange, aniWholeRange, bNoAniExtend, widthThreshold)
    table.Vector2Append(attackRange, aniAttackRange)
    table.Vector2Append(wholeRange, aniWholeRange)
    attackRange = table.unique(attackRange)
    wholeRange = table.unique(wholeRange)
  end
  local extendAList = {}
  local extendWList = {}
  if useBodyArea then
    for _, body in ipairs(bodyArea) do
      for _, v in ipairs(attackRange) do
        local newPos = v + body
        if not table.Vector2Include(attackRange, newPos) then
          table.insert(extendAList, newPos)
        end
      end
      for _, v in ipairs(wholeRange) do
        local newPos = v + body
        if not table.Vector2Include(wholeRange, newPos) then
          table.insert(extendWList, newPos)
        end
      end
    end
  end
  if 0 < #extendAList then
    table.Vector2Append(attackRange, extendAList)
  end
  if 0 < #extendWList then
    table.Vector2Append(wholeRange, extendWList)
  end
  local bSortFromBack = scopeParam.bSortFromBack == 1
  if bSortFromBack then
    local backDir = oriPos - desPos
    backDir = backDir.normalized
    local fakeAnchorPos = oriPos + backDir * 100
    fakeAnchorPos = Vector2(math.floor(fakeAnchorPos.x), math.floor(fakeAnchorPos.y))
    
    local function sortF(a, b)
      local da = Vector2.Distance(a, fakeAnchorPos)
      local db = Vector2.Distance(b, fakeAnchorPos)
      return da < db
    end
    
    table.sort(attackRange, sortF)
    table.sort(wholeRange, sortF)
  end
  local result = SkillScopeResult:New(SkillScopeType.AngleFreeLinePlus, centerPos, attackRange, wholeRange)
  return result
end
