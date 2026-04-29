require("scope_base")
_class("SkillScopeCalculator_TargetUnderFootColorGrid", SkillScopeCalculator_Base)
SkillScopeCalculator_TargetUnderFootColorGrid = SkillScopeCalculator_TargetUnderFootColorGrid

function SkillScopeCalculator_TargetUnderFootColorGrid:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local bodyAreaArray = bodyArea
  local param = scopeParam
  local world = self._gridFilter._world
  local bodyAreaPosList = {}
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local isHasMonster, monsterID = utilScopeSvc:IsPosHasMonster(centerPos)
  if isHasMonster then
    local monsterEntity = world:GetEntityByID(monsterID)
    local bodyAreaList = monsterEntity:BodyArea():GetArea()
    local gridPos = monsterEntity:GridLocation():GetGridPos()
    for _, bodyArea in ipairs(bodyAreaList) do
      local workPos = gridPos + bodyArea
      table.insert(bodyAreaPosList, workPos)
    end
  end
  local gridCount = param.gridCount or 0
  local girdTypeList = param.elementType or {}
  local excludeTrap = param.excludeTrap or {}
  local validPieceList = self._gridFilter:FindPieceElementByTypeAndArea(bodyAreaPosList, girdTypeList, excludeTrap)
  HelperProxy:SortPosByCenterPosDistance(casterPos, validPieceList)
  local pieceList = {}
  local findGridCount = 0
  for _, grid in ipairs(validPieceList) do
    if gridCount > findGridCount then
      findGridCount = findGridCount + 1
      table.insert(pieceList, grid)
    else
      break
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.TargetUnderFootColorGrid, centerPos, pieceList, pieceList)
  return result
end
