_class("SkillScopeParamParser", Object)
SkillScopeParamParser = SkillScopeParamParser

function SkillScopeParamParser:Constructor()
  self._scopeParamFuncDic = {}
  self._scopeParamFuncDic[SkillScopeType.NRowsMColumns] = self._ParseNRowsMColumnsParam
  self._scopeParamFuncDic[SkillScopeType.DoubleCross] = self._ParseDoubleCrossParam
  self._scopeParamFuncDic[SkillScopeType.FullScreen] = self._ParseParam_FullScreen
  self._scopeParamFuncDic[SkillScopeType.Rhombus] = self._ParseRhombusParam
  self._scopeParamFuncDic[SkillScopeType.Square] = self._ParseSquare
  self._scopeParamFuncDic[SkillScopeType.Nearest] = self._ParseNearestParam
  self._scopeParamFuncDic[SkillScopeType.SuperCross] = self._ParseSuperCrossParam
  self._scopeParamFuncDic[SkillScopeType.NRowsMColumnsSpreadAlongRow] = self._ParseNRowsMColumnsSpreadAlongRowParam
  self._scopeParamFuncDic[SkillScopeType.EmptyRandGrid] = self._ParseEmptyRandGridParam
  self._scopeParamFuncDic[SkillScopeType.WidthCrossWithPickUp] = self._ParseWidthCrossWithPickUpParam
  self._scopeParamFuncDic[SkillScopeType.DoubleCrossBeBlocked] = self._ParseDoubleCrossParam
  self._scopeParamFuncDic[SkillScopeType.FixedArea] = self._ParseFixedAreaParam
  self._scopeParamFuncDic[SkillScopeType.MultiCenterSquare] = self._ParseMultiCenterSquare
  self._scopeParamFuncDic[SkillScopeType.RandomGrids] = self._ParseRandomGrids
  self._scopeParamFuncDic[SkillScopeType.MonsterWithBuffType] = self._ParserMonsterWithBuffType
  self._scopeParamFuncDic[SkillScopeType.WalkableGridOnEdge] = self._ParserWalkableGridOnEdgeParam
  self._scopeParamFuncDic[SkillScopeType.RandomGridsAndTypeSize] = self._ParserRandomGridsAndTypeSizeParam
end

function SkillScopeParamParser:ParseScopeParam(scopeType, scopeParamArray)
  if self._scopeParamFuncDic[scopeType] then
    return self._scopeParamFuncDic[scopeType](self, scopeParamArray)
  else
    return scopeParamArray
  end
end

function SkillScopeParamParser:_ParserMonsterWithBuffType(scopeParamArray)
  if type(scopeParamArray) == "table" then
    local paramNum = #scopeParamArray
    if 0 < paramNum then
      return scopeParamArray[1]
    end
  end
  return scopeParamArray
end

function SkillScopeParamParser:_ParseSuperCrossParam(scopeParamArray)
  if type(scopeParamArray) == "table" then
    local paramNum = #scopeParamArray
    if 0 < paramNum then
      return scopeParamArray[1]
    end
  end
  return scopeParamArray
end

function SkillScopeParamParser:_ParseNRowsMColumnsParam(scopeParamArray)
  return SkillNRowsMColumnsScopeParam:New(scopeParamArray[1], scopeParamArray[2], scopeParamArray.ScopeCenterParam)
end

function SkillScopeParamParser:_ParseNRowsMColumnsSpreadAlongRowParam(scopeParamArray)
  return SkillNRowsMColumnsScopeParam:New(scopeParamArray[1], scopeParamArray[2])
end

function SkillScopeParamParser:_ParseCrossExceptBlockParam(scopeParamArray)
  if type(scopeParamArray) == "table" then
    local paramNum = #scopeParamArray
    if 0 < paramNum then
      return scopeParamArray[1]
    end
  end
  return scopeParamArray
end

function SkillScopeParamParser:_ParseDoubleCrossParam(scopeParamArray)
  if type(scopeParamArray) == "table" then
    local paramNum = #scopeParamArray
    if paramNum == 1 then
      return scopeParamArray[1]
    end
  end
  return scopeParamArray
end

function SkillScopeParamParser:_ParseParam_FullScreen(scopeParamArray)
  if type(scopeParamArray) == "table" then
    local paramNum = #scopeParamArray
    if 0 < paramNum then
      return scopeParamArray[1]
    end
  end
  return scopeParamArray
end

function SkillScopeParamParser:_ParseRhombusParam(scopeParamArray)
  local size = scopeParamArray[1]
  local isCenterIncluded = scopeParamArray[2] ~= 0
  local canMove = scopeParamArray[3] or false
  return {
    size,
    isCenterIncluded,
    canMove
  }
end

function SkillScopeParamParser:_ParseSquare(scopeParamArray)
  if type(scopeParamArray) == "table" then
    local paramNum = #scopeParamArray
    if 0 < paramNum then
      return scopeParamArray[1]
    end
  end
  return scopeParamArray
end

function SkillScopeParamParser:_ParseNearestParam(scopeParamArray)
  if type(scopeParamArray) == "table" then
    local paramNum = #scopeParamArray
    if 0 < paramNum then
      return scopeParamArray[1]
    end
  end
  return scopeParamArray
end

function SkillScopeParamParser:_ParseEmptyRandGridParam(scopeParamArray)
  if type(scopeParamArray) == "table" then
    local paramNum = #scopeParamArray
    if 0 < paramNum then
      return scopeParamArray[1]
    end
  end
  return scopeParamArray
end

function SkillScopeParamParser:_ParseWidthCrossWithPickUpParam(scopeParamArray)
  local length = scopeParamArray[1]
  local width = scopeParamArray[2]
  return {length, width}
end

function SkillScopeParamParser:_ParseFixedAreaParam(scopeParamArray)
  if type(scopeParamArray) == "table" then
    local paramNum = #scopeParamArray
    if 0 < paramNum then
      return scopeParamArray[1]
    end
  end
  return scopeParamArray
end

function SkillScopeParamParser:_ParseMultiCenterSquare(scopeParamArray)
  if type(scopeParamArray) == "table" then
    local paramNum = #scopeParamArray
    if 0 < paramNum then
      return scopeParamArray[1]
    end
  end
  return scopeParamArray
end

function SkillScopeParamParser:_ParseRandomGrids(scopeParamArray)
  local i = 1
  local retIdx = 1
  local ret = {}
  for _, num in ipairs(scopeParamArray) do
    if num == 0 then
      retIdx = retIdx + 1
    else
      if not ret[retIdx] then
        ret[retIdx] = {}
      end
      if i % 2 == 0 then
        local t = ret[retIdx]
        t[#t].y = num
      else
        local vec = Vector2.zero
        vec.x = num
        table.insert(ret[retIdx], vec)
      end
      i = i + 1
    end
  end
  return ret
end

function SkillScopeParamParser:_ParserWalkableGridOnEdgeParam(...)
  return ...
end

function SkillScopeParamParser:_ParserRandomGridsAndTypeSizeParam(scopeParamArray)
  local i = 1
  local retIdx = 1
  local ret = {}
  for _, num in ipairs(scopeParamArray.pos) do
    if num == 0 then
      retIdx = retIdx + 1
    else
      if not ret[retIdx] then
        ret[retIdx] = {}
      end
      if i % 2 == 0 then
        local t = ret[retIdx]
        t[#t].y = num
      else
        local vec = Vector2.zero
        vec.x = num
        table.insert(ret[retIdx], vec)
      end
      i = i + 1
    end
  end
  scopeParamArray.posList = ret
  return scopeParamArray
end
