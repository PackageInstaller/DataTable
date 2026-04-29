require("base_ins_r")
_class("PlayRefreshRoundCountInstruction", BaseInstruction)
PlayRefreshRoundCountInstruction = PlayRefreshRoundCountInstruction

function PlayRefreshRoundCountInstruction:Constructor(paramList)
end

function PlayRefreshRoundCountInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local utilDataSvc = world:GetService("UtilData")
  local roundCount = utilDataSvc:GetLightCount()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateRoundCount, roundCount)
end
