require("scope_base")
_class("SkillScopeCalculator_RandomGridsAndTypeSize", SkillScopeCalculator_Base)
SkillScopeCalculator_RandomGridsAndTypeSize = SkillScopeCalculator_RandomGridsAndTypeSize

function SkillScopeCalculator_RandomGridsAndTypeSize:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local size = scopeParam.size
  
  local function GetRandomPoints(rdmPoints)
    if not rdmPoints then
      return
    end
    local filtered = {}
    local blockGrids = self._gridFilter:GetBlockGridTrapPosList()
    for i, v in ipairs(rdmPoints) do
      local tbl = {}
      for j, vj in ipairs(v) do
        if not table.icontains(blockGrids, vj) then
          table.insert(tbl, vj)
        end
      end
      table.insert(filtered, tbl)
    end
    local randomPeices = {}
    for i, v in ipairs(filtered) do
      local len = table.count(v)
      local idx = 1
      if 0 < len then
        idx = self._gridFilter:_GetRandomNumber(1, len)
      end
      local posList = {}
      if scopeParam.type == 1 then
        posList = self:CalSquare(size, v[idx])
      elseif scopeParam.type == 2 then
        posList = self:CalCross(size, v[idx])
      end
      table.appendArray(randomPeices, posList)
    end
    return randomPeices
  end
  
  local grids = GetRandomPoints(scopeParam.posList)
  local result = SkillScopeResult:New(SkillScopeType.RandomGridsAndTypeSize, centerPos, grids, grids)
  return result
end

function SkillScopeCalculator_RandomGridsAndTypeSize:CalSquare(size, pos)
  local arr = {}
  local tmpSize = size - 1
  for j = 0, tmpSize do
    for k = 0, tmpSize do
      if pos then
        table.insert(arr, pos + Vector2(j, k))
      end
    end
  end
  return arr
end

function SkillScopeCalculator_RandomGridsAndTypeSize:CalCross(size, pos)
  local arr = {}
  table.insert(arr, pos)
  for i = 1, size do
    table.insert(arr, pos + Vector2.up * i)
    table.insert(arr, pos + Vector2.right * i)
    table.insert(arr, pos + Vector2.down * i)
    table.insert(arr, pos + Vector2.left * i)
  end
  return arr
end
