local WarChessConditionCheck = {}
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
WarChessConditionCheck.checkFunc = {
  [eWarChessEnum.eConditionCat.checkUnitValue] = function(wcCtrl, unit, args)
    if #args < 3 then
      error("checkUnitValue arg length not legal")
    end
    local opNum = args[1]
    local pms = unit.pms
    local value = pms[args[2] + 1]
    local targetValue = args[3]
    if opNum == 1 then
      return value >= targetValue
    elseif opNum == 2 then
      return value < targetValue
    elseif opNum == 3 then
      return value == targetValue
    else
      error("not support operate num")
    end
    return false
  end,
  [eWarChessEnum.eConditionCat.checkTurnNum] = function(wcCtrl, unit, args)
    if #args < 2 then
      error("checkUnitValue arg length not legal")
    end
    local opNum = args[1]
    local turnNum = wcCtrl.turnCtrl:GetWCTurnNum()
    local targetTurnNum = args[2]
    if opNum == 1 then
      return turnNum >= targetTurnNum
    elseif opNum == 2 then
      return turnNum < targetTurnNum
    elseif opNum == 3 then
      return turnNum == targetTurnNum
    else
      error("not support operate num")
    end
    return false
  end,
  [eWarChessEnum.eConditionCat.checkPressLevel] = function(wcCtrl, unit, args)
    if #args < 2 then
      error("checkUnitValue arg length not legal")
    end
    local opNum = args[1]
    local pressLevel = wcCtrl.turnCtrl:GetWCStressLevelAndPoint()
    local targetTurnNum = args[2]
    if opNum == 1 then
      return pressLevel >= targetTurnNum
    elseif opNum == 2 then
      return pressLevel < targetTurnNum
    elseif opNum == 3 then
      return pressLevel == targetTurnNum
    else
      error("not support operate num")
    end
    return false
  end,
  [eWarChessEnum.eConditionCat.checkItemNumAbove] = function(wcCtrl, unit, args)
    if #args < 2 then
      error("checkUnitValue arg length not legal")
    end
    local itemId = args[1]
    local itemNum = wcCtrl.backPackCtrl:GetWCItemNum(itemId)
    local targetItemNum = args[2]
    return itemNum >= targetItemNum
  end,
  [eWarChessEnum.eConditionCat.checkIsNotHaveEntityOnGrid] = function(wcCtrl, unit, args)
    return not WarChessConditionCheck.checkFunc[eWarChessEnum.eConditionCat.checkIsHaveEntityOnGrid](wcCtrl, unit, args)
  end,
  [eWarChessEnum.eConditionCat.checkIsHaveEntityOnGrid] = function(wcCtrl, unit, args)
    local x, y = WarChessHelper.Coordination2Pos(unit.pos)
    local gridData = wcCtrl.mapCtrl:GetGridDataByLogicXY(nil, x, y)
    if gridData == nil then
      error("want to check some thing which not on grid is on grid unit:" .. tostring(unit))
      return false
    end
    local entityData = wcCtrl.mapCtrl:GetEntityDataByLogicPosXY(nil, x, y)
    if entityData ~= nil then
      return false
    end
    local teamData = wcCtrl.teamCtrl:GetTeamDataByLogicPos(Vector2.Temp(x, y))
    if teamData ~= nil then
      return false
    end
    return true
  end
}

function WarChessConditionCheck.CheckWCCondition(wcCtrl, unit, conditionId, args)
  local checkFuck = WarChessConditionCheck.checkFunc[conditionId]
  if checkFuck ~= nil then
    return checkFuck(wcCtrl, unit, args)
  else
    warn("warchess condition check not exist id:" .. tostring(conditionId) .. [[

default return true]])
    return true
  end
end

function WarChessConditionCheck.CheckGridConditionTree(unit, interactCfg)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local rootNode = interactCfg.cond
  local check
  
  function check(node)
    if node.e ~= nil then
      local data = node.e
      return WarChessConditionCheck.CheckWCCondition(wcCtrl, unit, data.cat, data.pms)
    elseif node.o ~= nil then
      for _, subNode in ipairs(node.o.data) do
        if check(subNode) then
          return true
        end
      end
      return false
    elseif node.a ~= nil then
      for _, subNode in ipairs(node.a.data) do
        if not check(subNode) then
          return false
        end
      end
      return true
    else
      return true
    end
  end
  
  if rootNode == nil then
    return true
  end
  return check(rootNode)
end

return WarChessConditionCheck
