Scope_FullscreenExceptSafeZone_SafeAreaMode = {TrapCenter = 1}
_enum("Scope_FullscreenExceptSafeZone_SafeAreaMode", Scope_FullscreenExceptSafeZone_SafeAreaMode)
require("scope_base")
_class("SkillScopeCalculator_FullscreenExceptSafeZone", SkillScopeCalculator_Base)
SkillScopeCalculator_FullscreenExceptSafeZone = SkillScopeCalculator_FullscreenExceptSafeZone

function SkillScopeCalculator_FullscreenExceptSafeZone:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  if not self._gridFilter._world then
    return SkillScopeResult:New(SkillScopeType.FullscreenExceptSafeZone, Vector2.zero, {}, {})
  end
  local safeAreaMode = scopeParam.safeAreaMode
  local safeAreaParam = scopeParam.safeAreaParam
  local tv2SafeAreaCenter, safeAreaBodyArea = self:_GetSafeAreaCenter(safeAreaMode, safeAreaParam)
  local safeAreaScopeType = scopeParam.safeAreaScopeType
  local safeAreaScopeParam = scopeParam.safeAreaScopeParam
  local calculator = SkillScopeCalculator:New(self._gridFilter)
  local tv2SafeArea = {}
  for _, v2Center in ipairs(tv2SafeAreaCenter) do
    local scopeResult = calculator:ComputeScopeRange(safeAreaScopeType, safeAreaScopeParam, v2Center, safeAreaBodyArea, casterDir, nTargetType, casterPos, casterEntity)
    if scopeResult:GetAttackRange() then
      table.appendArray(tv2SafeArea, scopeResult:GetAttackRange())
    end
  end
  local safeAreaIndexBoolDic = {}
  for _, v2 in ipairs(tv2SafeArea) do
    local index = Vector2.Pos2Index(v2)
    safeAreaIndexBoolDic[index] = true
  end
  local attackRange = {}
  local wholeRange = {}
  local lsvcBoard = self._gridFilter._world:GetService("BoardLogic")
  local board = self._gridFilter._world:GetBoardEntity():Board()
  local arr = board:GetBlockFlagArray()
  for x, col in pairs(arr) do
    for y, block in pairs(col) do
      local grid = Vector2(x, y)
      local gridPosIndex = Vector2.Pos2Index(grid)
      if not safeAreaIndexBoolDic[gridPosIndex] then
        table.insert(wholeRange, grid)
        if not lsvcBoard:IsPosBlock(grid, BlockFlag.SkillSkip) then
          table.insert(attackRange, grid)
        end
      end
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.FullscreenExceptSafeZone, centerPos, attackRange, wholeRange)
  return result
end

function SkillScopeCalculator_FullscreenExceptSafeZone:_GetSafeAreaCenter(safeAreaMode, safeAreaParam)
  local world = self._gridFilter._world
  local tv2CenterPos = {}
  local tv2BodyArea = {}
  if safeAreaMode == Scope_FullscreenExceptSafeZone_SafeAreaMode.TrapCenter then
    local globalTrapGroup = world:GetGroupEntities(world.BW_WEMatchers.Trap)
    for _, eTrap in ipairs(globalTrapGroup) do
      if table.icontains(safeAreaParam, eTrap:Trap():GetTrapID()) then
        local bodyArea = eTrap:BodyArea():GetArea()
        if #bodyArea > #tv2BodyArea then
          tv2BodyArea = bodyArea
        end
        table.insert(tv2CenterPos, eTrap:GetGridPosition())
      end
    end
  end
  return tv2CenterPos, tv2BodyArea
end
