_class("GridBeginDragSystem_Render", UniqueReactiveSystem)
GridBeginDragSystem_Render = GridBeginDragSystem_Render

function GridBeginDragSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not GridTouchComponent:IsInstanceOfType(component) then
    return false
  end
  if component:GetGridTouchStateID() ~= GridTouchStateID.BeginDrag then
    return false
  end
  return true
end

function GridBeginDragSystem_Render:ExecuteWorld(world)
  self.world = world
  local playerGridLocation = world:Player():GetLocalTeamEntity():GridLocation()
  local gridTouchComponent = world:GridTouch()
  local touchPosition = gridTouchComponent:GetGridTouchBeginPosition()
  local offset = gridTouchComponent:GetGridTouchOffset()
  local linkLineService = self.world:GetService("LinkLine")
  local touchPlayer = linkLineService:IsTouchInPlayerTouchArea(touchPosition, offset)
  gridTouchComponent:SetTouchPlayer(touchPlayer)
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  previewChainPathCmpt:ClearPreviewChainPath()
  Log.debug("[touch] GridBeginDragSystem_Render player position:", playerGridLocation.Position.x, " ", playerGridLocation.Position.y, " ", playerGridLocation.Position.z)
  Log.debug("[touch] GridBeginDragSystem_Render touchPosition:", touchPosition.x, " ", touchPosition.y, " ", touchPosition.z, " Time:", UnityEngine.Time.frameCount)
  Log.debug("[touch] GridBeginDragSystem_Render offset:", offset.x, " ", offset.y, " ", offset.z)
  if touchPlayer then
    previewChainPathCmpt:SetLinkLineState(true)
    linkLineService:StartLinkLine(touchPosition, offset)
    local prvwSvc = self._world:GetService("PreviewMonsterTrap")
    prvwSvc:ClearMonsterTrapPreview()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MatchLineDragStart)
  else
    Log.notice("[touch] GridBeginDragSystem_Render no touch player ")
    local guideService = self.world:GetService("Guide")
    if not guideService:IsGuidePathInvokeType() then
      local prvwSvc = self._world:GetService("PreviewMonsterTrap")
      prvwSvc:CheckPreviewMonsterAction(touchPosition, offset)
      local previewActiveSkillSvc = world:GetService("PreviewActiveSkill")
      world:GetService("MonsterShowRender"):MonsterGridAnimDown()
    end
  end
end

function GridBeginDragSystem_Render:Filter(world)
  return true
end

function GridBeginDragSystem_Render:NearCenter(centerPos, checkPos, offset)
  local diff = checkPos - centerPos
  if math.abs(diff.x) >= 1 or 1 <= math.abs(diff.y) then
    return false
  end
  return math.abs(offset.x) < 1 and 1 > math.abs(offset.y)
end
