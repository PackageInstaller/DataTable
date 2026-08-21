require("scope_base")
_class("SkillScopeCalculator_FaceFrontLineBlocked", SkillScopeCalculator_Base)
SkillScopeCalculator_FaceFrontLineBlocked = SkillScopeCalculator_FaceFrontLineBlocked

function SkillScopeCalculator_FaceFrontLineBlocked:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local effectDirType = 1
  local size = scopeParam[1]
  local usePreviewFourDir = scopeParam[2] or 0
  local gridPos = centerPos
  if casterEntity then
    gridPos = casterEntity:GridLocation():GetGridPos()
  end
  local casterDirList = {casterDir}
  if usePreviewFourDir == 1 then
    casterDirList = {
      Vector2(-1, 0),
      Vector2(1, 0),
      Vector2(0, -1),
      Vector2(0, 1)
    }
  end
  local boayArea = {}
  for i, p in ipairs(bodyAreaArray) do
    table.insert(boayArea, Vector2(casterPos.x + p.x, casterPos.y + p.y))
  end
  local targetArea = {}
  local wholeArea = {}
  for _, dir in ipairs(casterDirList) do
    for i, p in ipairs(boayArea) do
      for index = 1, size do
        local directpos = Vector2(p.x + dir.x * index, p.y + dir.y * index)
        self:_InsertTargetGrid(targetArea, directpos, wholeArea)
        if not self._gridFilter:IsPosBlock(directpos, BlockFlag.MonsterLand) or casterPos ~= gridPos and directpos == gridPos then
        else
          break
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.FaceFrontLineBlocked, casterPos, targetArea, wholeArea)
  return result
end
