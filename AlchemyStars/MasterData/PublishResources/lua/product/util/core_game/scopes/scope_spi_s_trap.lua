require("scope_base")
_class("SkillScopeCalculator_SPIstavanSummonTrap", SkillScopeCalculator_Base)
SkillScopeCalculator_SPIstavanSummonTrap = SkillScopeCalculator_SPIstavanSummonTrap

function SkillScopeCalculator_SPIstavanSummonTrap:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local blockFlag
  if scopeParam.BlockFlag then
    blockFlag = GetBlockFlagByValue(scopeParam.BlockFlag)
  else
    blockFlag = BlockFlag.LinkLine
  end
  local arr = self:CalFixedPos(scopeParam.pos)
  local ret = {}
  local bFind = false
  for i, pos in ipairs(arr) do
    local isBlockGrid = self._gridFilter:IsPosBlock(pos + casterPos, blockFlag)
    if not isBlockGrid then
      table.insert(ret, pos + casterPos)
      bFind = true
      break
    end
  end
  if not bFind then
    local ringMaxCount = math.max(self._gridFilter:GetBoardMaxX(), self._gridFilter:GetBoardMaxY())
    for ring = 3, ringMaxCount do
      local listTotalData = ComputeScopeRange.ComputeRange_SquareRing(casterPos, 1, ring)
      for key, value in ipairs(listTotalData) do
        local isBlockGrid = self._gridFilter:IsPosBlock(value, blockFlag)
        if not isBlockGrid then
          table.insert(ret, value)
          bFind = true
          break
        end
      end
      if bFind then
        break
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.SPIstavanSummonTrap, centerPos, ret, ret)
  return result
end

function SkillScopeCalculator_SPIstavanSummonTrap:CalFixedPos(posList)
  local arr = {}
  for _, v in ipairs(posList) do
    table.insert(arr, Vector2(v[1], v[2]))
  end
  return arr
end
