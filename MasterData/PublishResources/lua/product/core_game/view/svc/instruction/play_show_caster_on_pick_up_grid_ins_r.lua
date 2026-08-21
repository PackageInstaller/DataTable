_class("PlayShowCasterOnPickUpGridInstruction", BaseInstruction)
PlayShowCasterOnPickUpGridInstruction = PlayShowCasterOnPickUpGridInstruction

function PlayShowCasterOnPickUpGridInstruction:Constructor(paramList)
  self._pickUpIndex = tonumber(paramList.pickUpIndex) or 1
  self._reset = paramList.reset ~= nil
end

function PlayShowCasterOnPickUpGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local oriEntity = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    oriEntity = cSuperEntity:GetSuperEntity()
  end
  local renderPickUpComponent = oriEntity:RenderPickUpComponent()
  if not renderPickUpComponent then
    return
  end
  local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
  local pickUpPos = pickUpGridArray[self._pickUpIndex]
  local targetGridPos = self._reset and oriEntity:GetGridPosition() or pickUpPos
  oriEntity:SetPosition(targetGridPos)
  YIELD(TT)
end
