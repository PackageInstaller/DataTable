_class("PlayShowCasterOnCenterInstruction", BaseInstruction)
PlayShowCasterOnCenterInstruction = PlayShowCasterOnCenterInstruction

function PlayShowCasterOnCenterInstruction:Constructor(paramList)
  self._reset = paramList.reset ~= nil
end

function PlayShowCasterOnCenterInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local utilDataSvc = world:GetService("UtilData")
  local baseCenterPos = utilDataSvc:GetCurBoardCenterPos()
  local targetGridPos = self._reset and casterEntity:GetGridPosition() or baseCenterPos
  casterEntity:SetPosition(targetGridPos)
  YIELD(TT)
end
