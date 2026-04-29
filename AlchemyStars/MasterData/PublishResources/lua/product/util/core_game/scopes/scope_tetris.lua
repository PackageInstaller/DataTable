require("scope_base")
_class("SkillScopeCalculator_Tetris", SkillScopeCalculator_Base)
SkillScopeCalculator_Tetris = SkillScopeCalculator_Tetris

function SkillScopeCalculator_Tetris:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  if not centerPos then
    return SkillScopeResult:New(SkillScopeType.Tetris, casterPos, {}, {})
  end
  local scopeList = self:ParseScopeParam(scopeParam)
  local cross_area = {}
  local wholeArea = {}
  local featureSvc = self._gridFilter._world:GetService("FeatureLogic")
  local tetrisDirIndex = featureSvc:GetTetrisDirIndex()
  local tetrisType = featureSvc:GetTetrisType()
  local tmpOffSetList = scopeList[tetrisType][tetrisDirIndex]
  for i, offsetPos in ipairs(tmpOffSetList) do
    self:_InsertTargetGrid(cross_area, offsetPos + centerPos)
  end
  local result = SkillScopeResult:New(SkillScopeType.Tetris, casterPos, cross_area, cross_area)
  return result
end

function SkillScopeCalculator_Tetris:ParseScopeParam(scopeParam)
  local scopeList = {}
  for _, tetrisList in ipairs(scopeParam) do
    local tmpTetrisList = {}
    for _, tetrisDirList in ipairs(tetrisList) do
      local tmpTetrisDirList = {}
      for _, tetrisOffSet in ipairs(tetrisDirList) do
        local offSet = Vector2(tetrisOffSet[1], tetrisOffSet[2])
        table.insert(tmpTetrisDirList, offSet)
      end
      table.insert(tmpTetrisList, tmpTetrisDirList)
    end
    table.insert(scopeList, tmpTetrisList)
  end
  return scopeList
end
