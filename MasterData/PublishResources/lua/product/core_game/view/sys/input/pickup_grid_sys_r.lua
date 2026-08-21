_class("PickUpGridSystem_Render", UniqueReactiveSystem)
PickUpGridSystem_Render = PickUpGridSystem_Render

function PickUpGridSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not PickUpComponent:IsInstanceOfType(component) then
    return false
  end
  return true
end

function PickUpGridSystem_Render:Filter(world)
  return true
end

function PickUpGridSystem_Render:ExecuteWorld(world)
  self._world = world
  local cPickUp = world:PickUp()
  local clickRenderPos = cPickUp:GetClickPos()
  local boardServiceRender = world:GetService("BoardRender")
  local gridPos = boardServiceRender:BoardRenderPos2GridPos(clickRenderPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local stateId = utilDataSvc:GetCurMainStateID()
  if stateId == GameStateID.PickUpActiveSkillTarget or stateId == GameStateID.PreviewActiveSkill then
    local curSkillID = cPickUp:GetCurActiveSkillID()
    if not curSkillID then
      Log.debug("Handle pick up activeSkillID is nil")
      return
    end
    if curSkillID < 0 then
      Log.debug("Handle pick up activeSkillID is invalid ", curSkillID)
      return
    end
    self:SetPickUpGrid(cPickUp, gridPos)
  elseif stateId == GameStateID.PickUpChainSkillTarget then
    self:SetChainSkillPickUpGrid(cPickUp, gridPos)
  else
    Log.fatal("### invalid state. stateId=", stateId)
  end
end

function PickUpGridSystem_Render:SetPickUpGrid(cPickUp, gridPos)
  local activeSkillID = cPickUp:GetCurActiveSkillID()
  local casterPetPstID = cPickUp:GetCurActiveSkillPetPstID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local activeSkillPickUpType = skillConfigData:GetSkillPickType()
  local utilData = self._world:GetService("UtilData")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  pickUpTargetCmpt:SetPickUpTargetType(activeSkillPickUpType)
  pickUpTargetCmpt:SetPickUpGridPos(gridPos)
  if utilData:IsValidPiecePos(gridPos) and not utilData:IsPosBlock(gridPos, BlockFlag.LinkLine) then
    pickUpTargetCmpt:SetPickUpGridSafePos(gridPos)
  end
  pickUpTargetCmpt:SetCurActiveSkillInfo(activeSkillID, casterPetPstID)
  renderBoardEntity:ReplacePickUpTarget()
end

function PickUpGridSystem_Render:SetChainSkillPickUpGrid(cPickUp, gridPos)
  local utilData = self._world:GetService("UtilData")
  if utilData:GetBoardIsPosNil(gridPos) then
    return
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  pickUpTargetCmpt:SetPickUpTargetType(SkillPickUpType.ChainInstruction)
  pickUpTargetCmpt:SetPickUpGridPos(gridPos)
  if utilData:IsValidPiecePos(gridPos) and not utilData:IsPosBlock(gridPos, BlockFlag.LinkLine) and not utilData:IsPosDimensionDoor(gridPos) then
    pickUpTargetCmpt:SetPickUpGridSafePos(gridPos)
  else
    Log.fatal("GridPos:", tostring(gridPos), " Is Invalid ")
  end
  renderBoardEntity:ReplacePickUpTarget()
end
