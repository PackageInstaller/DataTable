local BaseAIStateConfig = require("Game.Dorm.Character.AI.Base.BaseAIStateConfig")
local HallFairyAIStateConfig = class("HallFairyAIStateConfig", BaseAIStateConfig)
local eLittleManActionType = {
  Stand = 0,
  Move = 1,
  Dialogue = 2,
  Think = 3,
  BeGreetting = 4
}
local states = {
  [eLittleManActionType.Stand] = require("Game.Fairy.AI.HallFairyAIStandState"),
  [eLittleManActionType.Move] = require("Game.Fairy.AI.HallFairyAIMoveState"),
  [eLittleManActionType.Dialogue] = require("Game.Fairy.AI.HallFairyAIDialogueState"),
  [eLittleManActionType.Think] = require("Game.Fairy.AI.HallFairyAIThinkState"),
  [eLittleManActionType.BeGreetting] = require("Game.Fairy.AI.HallFairyAIBeGreettingState")
}
HallFairyAIStateConfig.eLittleManActionType = eLittleManActionType

function HallFairyAIStateConfig.GetState(typeId)
  local stateClass = states[typeId]
  if stateClass == nil then
    error("HallFairy action type not define,type:" .. tostring(typeId))
  end
  return stateClass
end

return HallFairyAIStateConfig
