require("scope_base")
_class("SkillScopeCalculator_DirectLineBlockedEdgeFree", SkillScopeCalculator_Base)
SkillScopeCalculator_DirectLineBlockedEdgeFree = SkillScopeCalculator_DirectLineBlockedEdgeFree

function SkillScopeCalculator_DirectLineBlockedEdgeFree:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local effectDirType = 1
  local size = scopeParam[1]
  local blockFlag = scopeParam[2] and GetBlockFlagByValue(scopeParam[2]) or BlockFlag.Skill
  local isCenterInRange = scopeParam[3]
  local isBlockSkill = effectDirType == 1
  local boayArea = {}
  for i, p in ipairs(bodyAreaArray) do
    table.insert(boayArea, Vector2(casterPos.x + p.x, casterPos.y + p.y))
  end
  local targetArea = {}
  local wholeArea = {}
  for i, p in ipairs(boayArea) do
    for index = 1, size do
      local directpos = Vector2(p.x + casterDir.x * index, p.y + casterDir.y * index)
      if isBlockSkill and self:IsPosBlock(directpos, blockFlag) then
        break
      end
      self:_InsertTargetGrid(targetArea, directpos, wholeArea)
    end
  end
  if isCenterInRange and not self:IsPosBlock(centerPos, blockFlag) then
    self:_InsertTargetGrid(targetArea, centerPos, wholeArea)
  end
  local result
  if isBlockSkill then
    result = SkillScopeResult:New(SkillScopeType.DirectLineBlockedEdgeFree, casterPos, targetArea, wholeArea)
  else
    result = SkillScopeResult:New(SkillScopeType.DirectLine, casterPos, targetArea, wholeArea)
  end
  return result
end

function SkillScopeCalculator_DirectLineBlockedEdgeFree:IsPosBlock(pos, blockFlag)
  if not pos then
    return false
  end
  if not self._gridFilter._world then
    return false
  end
  local lbsvc = self._gridFilter._world:GetService("BoardLogic")
  if self._gridFilter:IsValidPiecePos(pos) then
    if not blockFlag then
      return false
    end
    local world = self._gridFilter._world
    local utildata = world:GetService("UtilData")
    local pieceBlock = utildata:FindBlockByPos(pos)
    if nil == pieceBlock then
      return true
    end
    return pieceBlock:CheckBlock(blockFlag)
  else
    local boardMaxX = lbsvc:GetCurBoardMaxX()
    local boardMaxY = lbsvc:GetCurBoardMaxY()
    return pos.x < 1 or boardMaxX < pos.x or 1 > pos.y or boardMaxY < pos.y
  end
end
