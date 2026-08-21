require("scope_base")
_class("SkillScopeCalculator_CrossEdgesByCenterPos", SkillScopeCalculator_Base)
SkillScopeCalculator_CrossEdgesByCenterPos = SkillScopeCalculator_CrossEdgesByCenterPos

function SkillScopeCalculator_CrossEdgesByCenterPos:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local world = self._gridFilter._world
  local boardSvc = world:GetService("BoardLogic")
  local x = centerPos.x
  local y = centerPos.y
  local up = boardSvc:GetMinYOfColX(x)
  local down = boardSvc:GetMaxYOfColX(x)
  local left = boardSvc:GetMinXOfRowY(y)
  local right = boardSvc:GetMaxXOfRowY(y)
  local wholeRange = {}
  table.insert(wholeRange, Vector2(x, up))
  table.insert(wholeRange, Vector2(x, down))
  table.insert(wholeRange, Vector2(left, y))
  table.insert(wholeRange, Vector2(right, y))
  local attackRange = table.unique(wholeRange)
  local result = SkillScopeResult:New(SkillScopeType.CrossEdgesByCenterPos, centerPos, attackRange, wholeRange)
  return result
end
