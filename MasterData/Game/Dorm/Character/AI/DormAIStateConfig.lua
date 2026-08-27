local DormAIStateConfig = {}
local eDormActionType = {
  Stand = 0,
  Fnt = 1,
  Idle = 2,
  Visit = 3,
  UnbindExit = 4
}
local states = {
  [eDormActionType.Stand] = require("Game.Dorm.Character.AI.DormAIStandState"),
  [eDormActionType.Fnt] = require("Game.Dorm.Character.AI.DormAIFntState"),
  [eDormActionType.Idle] = require("Game.Dorm.Character.AI.DormAIIdleState"),
  [eDormActionType.Visit] = require("Game.Dorm.Character.AI.DormAIVisitState"),
  [eDormActionType.UnbindExit] = require("Game.Dorm.Character.AI.DormAIUnbindExit")
}
DormAIStateConfig.eDormActionType = eDormActionType

function DormAIStateConfig.GetState(typeId)
  local stateClass = states[typeId]
  if stateClass == nil then
    error("dorm action type not define,type:" .. tostring(typeId))
  end
  return stateClass
end

function DormAIStateConfig.GetDormFntState()
  return states[eDormActionType.Fnt]
end

function DormAIStateConfig.GetDormVisitState()
  return states[eDormActionType.Visit]
end

function DormAIStateConfig.GetDormUnbindExitState()
  return states[eDormActionType.UnbindExit]
end

function DormAIStateConfig.GetDormIdleState()
  return states[eDormActionType.Idle]
end

return DormAIStateConfig
