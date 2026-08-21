_class("GridDoubleClickSystem_Render", UniqueReactiveSystem)
GridDoubleClickSystem_Render = GridDoubleClickSystem_Render

function GridDoubleClickSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not GridTouchComponent:IsInstanceOfType(component) then
    return false
  end
  if component:GetGridTouchStateID() ~= GridTouchStateID.DoubleClick then
    return false
  end
  return true
end

function GridDoubleClickSystem_Render:Constructor(world)
  self._timeService = world:GetService("Time")
  self._lastClickTime = 0
end

function GridDoubleClickSystem_Render:ExecuteWorld(world)
  local inputCmpt = self._world:Input()
  if inputCmpt:IsPreviewActiveSkill() or inputCmpt:IsPreviewActiveSkillPlaying() then
    return
  end
  local currentTimeMS = self._timeService:GetCurrentTimeMs()
  if currentTimeMS - self._lastClickTime < BattleConst.DoubleClickIntervalTime then
    return
  end
  self._lastClickTime = currentTimeMS
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, true)
  self._configService = world:GetService("Config")
  local guideService = world:GetService("Guide")
  local isGuide = guideService:HandleDoubleClickTrigger()
  if isGuide == true then
    return
  end
  self.world = world
  local teamEntity = world:Player():GetLocalTeamEntity()
  local playerPos = teamEntity:GetGridPosition()
  local gridTouchComponent = world:GridTouch()
  local touchPosition = gridTouchComponent:GetDoubleClickPos()
  if touchPosition ~= playerPos then
    Log.fatal("touchPosition ~= playerpos>>>>>>>")
    return
  end
  local previewEntity = world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  previewChainPathCmpt:ClearPreviewChainPath()
  local syncMoveServiceRender = self._world:GetService("SyncMoveRender")
  if syncMoveServiceRender then
    syncMoveServiceRender:ClearPreview()
  end
  local linkLineSvc = self._world:GetService("LinkLine")
  linkLineSvc:FinishBulletTime()
  local prvwSvc = self._world:GetService("PreviewMonsterTrap")
  prvwSvc:ClearMonsterTrapPreview()
  local cameraCmpt = self.world:MainCamera()
  cameraCmpt:DoMoveCamera(false)
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  if #chainPath ~= 0 then
    table.clear(chainPath)
  end
  table.insert(chainPath, touchPosition)
  local elementType = PieceType.None
  self:SendMovePathDoneCommand(chainPath, elementType)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
  self.world:EventDispatcher():Dispatch(GameEventType.FinishGuideWeakLine, {
    [1] = elementType,
    [2] = 1
  })
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.IdleEnd, 1, teamLeaderEntity:GetID())
end

function GridDoubleClickSystem_Render:Filter(world)
  return true
end

function GridDoubleClickSystem_Render:SendMovePathDoneCommand(chainPath, elementType)
  local cmd = MovePathDoneCommand:New()
  cmd:SetChainPath(chainPath)
  cmd:SetElementType(elementType)
  self.world:Player():SendCommand(cmd)
end
