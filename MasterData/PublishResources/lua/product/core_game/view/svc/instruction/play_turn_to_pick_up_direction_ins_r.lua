require("base_ins_r")
_class("PlayTurnToPickUpDirectionInstruction", BaseInstruction)
PlayTurnToPickUpDirectionInstruction = PlayTurnToPickUpDirectionInstruction

function PlayTurnToPickUpDirectionInstruction:Constructor(paramList)
end

function PlayTurnToPickUpDirectionInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local lastPickUpGridPos
  local selectComponent = casterEntity:RenderPickUpComponent()
  if selectComponent ~= nil then
    lastPickUpGridPos = selectComponent:GetLastPickUpGridPos()
  end
  if lastPickUpGridPos == nil then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local boardServiceRender = world:GetService("BoardRender")
  local casterPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  local dir = lastPickUpGridPos - casterPos
  casterEntity:SetDirection(dir)
end
