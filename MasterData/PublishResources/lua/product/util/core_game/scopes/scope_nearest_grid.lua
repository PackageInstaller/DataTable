require("scope_base")
_class("SkillScopeCalculator_NearestGrid", SkillScopeCalculator_Base)
SkillScopeCalculator_NearestGrid = SkillScopeCalculator_NearestGrid

function SkillScopeCalculator_NearestGrid:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos)
  local casterPos = centerPos
  local bodyAreaArray = bodyArea
  local param = scopeParam
  local gridCount = param.gridCount or 0
  local girdTypeList = param.elementType or {}
  local excludeTrap = param.excludeTrap or {}
  local canPlayerMove = param.canPlayerMove or 0
  local canPlayerMoveFlag = canPlayerMove == 1
  local excludePosList = {}
  local excludeChainPath = param.excludeChainPath or 0
  if excludeChainPath == 1 then
    local teamEntity = self._gridFilter._world:Player():GetCurrentTeamEntity()
    local logicChainPathCmpt = teamEntity:LogicChainPath()
    local chainPath = logicChainPathCmpt:GetLogicChainPath()
    table.appendArray(excludePosList, chainPath)
  end
  local useCenterPosPieceType = param.useCenterPosPieceType or 0
  if useCenterPosPieceType == 1 then
    local world = self._gridFilter._world
    local boardServiceLogic = world:GetService("BoardLogic")
    local pieceType = boardServiceLogic:GetPieceType(casterPos)
    if pieceType ~= PieceType.None then
      girdTypeList = {}
      table.insert(girdTypeList, pieceType)
    end
  end
  local excludeCenterPos = param.excludeCenterPos or 0
  if excludeCenterPos == 1 then
    table.insert(excludePosList, casterPos)
  end
  local pieceList = self._gridFilter:FindPieceElementByTypeCountAndCenter(casterPos, girdTypeList, gridCount, excludeTrap, excludePosList, canPlayerMoveFlag)
  local result = SkillScopeResult:New(SkillScopeType.NearestGrid, casterPos, pieceList, pieceList)
  return result
end
