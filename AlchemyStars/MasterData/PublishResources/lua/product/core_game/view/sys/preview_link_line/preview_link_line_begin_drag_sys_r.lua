_class("PreviewLinkLineBeginDragSystem_Render", UniqueReactiveSystem)
PreviewLinkLineBeginDragSystem_Render = PreviewLinkLineBeginDragSystem_Render

function PreviewLinkLineBeginDragSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not GridTouchComponent:IsInstanceOfType(component) then
    return false
  end
  if component:GetGridTouchStateID() ~= GridTouchStateID.PLLBeginDrag then
    return false
  end
  return true
end

function PreviewLinkLineBeginDragSystem_Render:ExecuteWorld(world)
  local playerGridLocation = world:Player():GetLocalTeamEntity():GridLocation()
  local gridTouchComponent = world:GridTouch()
  local touchPosition = gridTouchComponent:GetGridTouchBeginPosition()
  local offset = gridTouchComponent:GetGridTouchOffset()
  local linkLineService = world:GetService("PreviewLinkLine")
  local touchPlayer = linkLineService:IsTouchInPlayerTouchArea(touchPosition, offset)
  gridTouchComponent:SetTouchPlayer(touchPlayer)
  if not touchPlayer then
    return
  end
  local previewEntity = world:GetPreviewEntity()
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  linkLineService:CancelAllLinkPosPieceType(chainPath)
  previewLinkLineCmpt:ClearPreviewChainPath()
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
    local previewEntity = self._world:GetPreviewEntity()
    local previewChainPathCmpt = previewEntity:PreviewChainPath()
    previewChainPathCmpt:ClearPreviewChainPath()
  end
  Log.debug("[touch] PreviewLinkLineBeginDragSystem_Render player position:", playerGridLocation.Position.x, " ", playerGridLocation.Position.y, " ", playerGridLocation.Position.z)
  Log.debug("[touch] PreviewLinkLineBeginDragSystem_Render touchPosition:", touchPosition.x, " ", touchPosition.y, " ", touchPosition.z, " Time:", UnityEngine.Time.frameCount)
  Log.debug("[touch] PreviewLinkLineBeginDragSystem_Render offset:", offset.x, " ", offset.y, " ", offset.z)
  if touchPlayer then
    linkLineService:StartLinkLine(touchPosition, offset)
    local prvwSvc = world:GetService("PreviewMonsterTrap")
    prvwSvc:ClearMonsterTrapPreview()
  end
end

function PreviewLinkLineBeginDragSystem_Render:Filter(world)
  return true
end
