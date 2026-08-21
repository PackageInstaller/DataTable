_class("PlayShowCasterOnPickPosWithOffInstruction", BaseInstruction)
PlayShowCasterOnPickPosWithOffInstruction = PlayShowCasterOnPickPosWithOffInstruction

function PlayShowCasterOnPickPosWithOffInstruction:Constructor(paramList)
  self._reset = tonumber(paramList.reset)
  self._disToPickPos = tonumber(paramList.disToPickPos)
end

function PlayShowCasterOnPickPosWithOffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local utilDataSvc = world:GetService("UtilData")
  local boardServiceRender = world:GetService("BoardRender")
  if self._reset and self._reset == 1 then
    local targetGridPos = casterEntity:GetGridPosition()
    casterEntity:SetPosition(targetGridPos)
  else
    local entitySvc = world:GetService("RenderEntity")
    local renderPickUpComponent = casterEntity:RenderPickUpComponent()
    if not renderPickUpComponent then
      return
    end
    local pickUpPos = renderPickUpComponent:GetLastPickUpGridPos()
    if self._disToPickPos and self._disToPickPos ~= 0 then
      local startGridPos = casterEntity:GetGridPosition()
      local dir = pickUpPos - startGridPos
      local v3Dir = boardServiceRender:GridDir2LocationDir(dir)
      v3Dir = Vector3.Normalize(v3Dir)
      local pickUpRenderPos = boardServiceRender:GridPos2RenderPos(pickUpPos)
      local targetPos = pickUpRenderPos + v3Dir * self._disToPickPos
      casterEntity:SetLocation(targetPos, v3Dir)
    else
      casterEntity:SetPosition(pickUpPos)
    end
  end
  YIELD(TT)
end
