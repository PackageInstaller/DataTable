require("scope_base")
_class("SkillScopeCalculator_BoardSelectEdgeRandomAndExtend", SkillScopeCalculator_Base)
SkillScopeCalculator_BoardSelectEdgeRandomAndExtend = SkillScopeCalculator_BoardSelectEdgeRandomAndExtend
local BoardSelectEdgeRandomAndExtendType = {
  None = 0,
  NoBlock = 1,
  CheckMonsterCountAndSummon = 2,
  ControlMonsterMoveWasOnEdge = 2
}
_enum("BoardSelectEdgeRandomAndExtendType", BoardSelectEdgeRandomAndExtendType)

function SkillScopeCalculator_BoardSelectEdgeRandomAndExtend:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity)
  local world = self._hub._gridFilter._world
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local utilData = world:GetService("UtilData")
  local randomSvc = world:GetService("RandomLogic")
  local selectX = scopeParam.x or 0
  local selectY = scopeParam.y or 0
  local extendType = scopeParam.type or 1
  local extendParam = scopeParam.param or {}
  local selectXPosList = {}
  local selectYPosList = {}
  local selectXPosListNotBlock = {}
  local selectYPosListNotBlock = {}
  if 0 < selectX and 0 < selectY then
    local casterBodyPosList = {}
    for _, area in ipairs(bodyArea) do
      local workPos = area + centerPos
      table.insert(casterBodyPosList, workPos)
    end
    local board = world:GetBoardEntity():Board()
    local arr = board:GetBlockFlagArray()
    for x, col in pairs(arr) do
      for y, block in pairs(col) do
        local grid = Vector2(x, y)
        local isBlock = utilData:IsPosBlock(grid, BlockFlag.MonsterLand)
        local isCasterBodyPos = table.intable(casterBodyPosList, grid)
        if x == selectX then
          table.insert(selectXPosList, grid)
          if isCasterBodyPos or not isBlock then
            table.insert(selectXPosListNotBlock, grid)
          end
        end
        if y == selectY and not table.intable(selectXPosList, grid) then
          table.insert(selectYPosList, grid)
          if isCasterBodyPos or not isBlock then
            table.insert(selectYPosListNotBlock, grid)
          end
        end
      end
    end
  end
  local monsterEntityList = world:GetGroupEntities(world.BW_WEMatchers.MonsterID)
  local resultPosList = {}
  if extendType == BoardSelectEdgeRandomAndExtendType.None then
    table.appendArray(resultPosList, selectXPosList)
    table.appendArray(resultPosList, selectYPosList)
  elseif extendType == BoardSelectEdgeRandomAndExtendType.NoBlock then
    table.appendArray(resultPosList, selectXPosListNotBlock)
    table.appendArray(resultPosList, selectYPosListNotBlock)
  elseif extendType == BoardSelectEdgeRandomAndExtendType.CheckMonsterCountAndSummon then
    local trapID = extendParam.trapID
    local limitCount = extendParam.count
    local monsterClassID = extendParam.monsterClassID
    local aliveCount = 0
    for i, entity in ipairs(monsterEntityList) do
      local curMonsterClassID = entity:MonsterID():GetMonsterClassID()
      if not entity:HasDeadMark() and curMonsterClassID == monsterClassID then
        aliveCount = aliveCount + 1
      end
    end
    local trapEntityList = world:GetGroupEntities(world.BW_WEMatchers.Trap)
    for i, entity in ipairs(trapEntityList) do
      local trapCmpt = entity:Trap()
      if not entity:HasDeadMark() and trapCmpt:GetTrapID() == trapID then
        aliveCount = aliveCount + 1
      end
    end
    local needSummonCount = limitCount - aliveCount
    if 0 < needSummonCount then
      for i = 1, needSummonCount do
        local randomXorY = randomSvc:LogicRand(1, 2)
        if randomXorY == 1 then
          local randomIndex = randomSvc:LogicRand(1, #selectXPosListNotBlock)
          local posWork = selectXPosListNotBlock[randomIndex]
          table.insert(resultPosList, posWork)
        elseif randomXorY == 2 then
          local randomIndex = randomSvc:LogicRand(1, #selectYPosListNotBlock)
          local posWork = selectYPosListNotBlock[randomIndex]
          table.insert(resultPosList, posWork)
        end
      end
    end
  elseif extendType == BoardSelectEdgeRandomAndExtendType.ControlMonsterMoveWasOnEdge then
    local selectXPosList = {}
    local selectYPosList = {}
  end
  local result = SkillScopeResult:New(SkillScopeType.BoardSelectEdgeRandomAndExtend, centerPos, resultPosList, resultPosList)
  return result
end
