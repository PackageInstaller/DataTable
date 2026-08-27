local BaseAIStateConfig = require("Game.Dorm.Character.AI.Base.BaseAIStateConfig")
local LittleManAIStateConfig = class("LittleManAIStateConfig", BaseAIStateConfig)
local eLittleManActionType = {Stand = 0, Move = 2}
local states = {
  [eLittleManActionType.Stand] = require("Game.LittleMan.AI.LittleManAIStandState"),
  [eLittleManActionType.Move] = require("Game.LittleMan.AI.LittleManAIMoveState")
}
LittleManAIStateConfig.eLittleManActionType = eLittleManActionType

function LittleManAIStateConfig.GetState(typeId)
  local stateClass = states[typeId]
  if stateClass == nil then
    error("LittleMan action type not define,type:" .. tostring(typeId))
  end
  return stateClass
end

function LittleManAIStateConfig.GetLittleManMoveState()
  return states[eLittleManActionType.Move]
end

return LittleManAIStateConfig
