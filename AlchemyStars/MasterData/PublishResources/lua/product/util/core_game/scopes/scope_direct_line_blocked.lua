require("scope_base")
_class("SkillScopeCalculator_DirectLineBlocked", SkillScopeCalculator_Base)
SkillScopeCalculator_DirectLineBlocked = SkillScopeCalculator_DirectLineBlocked

function SkillScopeCalculator_DirectLineBlocked:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local effectDirType = 1
  local size = scopeParam[1]
  local blockFlag = scopeParam[2] and GetBlockFlagByValue(scopeParam[2]) or BlockFlag.Skill
  local isCenterInRange = scopeParam[3]
  local isBackward = scopeParam[4]
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
      if isBlockSkill and self._gridFilter:IsPosBlock(directpos, blockFlag) then
        break
      end
      self:_InsertTargetGrid(targetArea, directpos, wholeArea)
    end
  end
  if isCenterInRange and not self._gridFilter:IsPosBlock(centerPos, blockFlag) then
    self:_InsertTargetGrid(targetArea, centerPos, wholeArea)
  end
  if isBackward then
    for i, p in ipairs(boayArea) do
      for index = 1, size do
        local backwardPos = Vector2(p.x - casterDir.x * index, p.y - casterDir.y * index)
        if isBlockSkill and self._gridFilter:IsPosBlock(backwardPos, blockFlag) then
          break
        end
        self:_InsertTargetGrid(targetArea, backwardPos, wholeArea)
      end
    end
  end
  local result
  if isBlockSkill then
    result = SkillScopeResult:New(SkillScopeType.DirectLineBlocked, casterPos, targetArea, wholeArea)
  else
    result = SkillScopeResult:New(SkillScopeType.DirectLine, casterPos, targetArea, wholeArea)
  end
  return result
end
