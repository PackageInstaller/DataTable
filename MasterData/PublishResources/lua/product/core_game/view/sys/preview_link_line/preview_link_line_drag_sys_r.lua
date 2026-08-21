_class("PreviewLinkLineDragSystem_Render", UniqueReactiveSystem)
PreviewLinkLineDragSystem_Render = PreviewLinkLineDragSystem_Render

function PreviewLinkLineDragSystem_Render:Constructor(world)
  self._world = world
  self._CancelChainPathCallBack = GameHelper:GetInstance():CreateCallback(self.CancelChainPath, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.CancelChainPath, self._CancelChainPathCallBack)
end

function PreviewLinkLineDragSystem_Render:TearDown()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.CancelChainPath, self._CancelChainPathCallBack)
end

function PreviewLinkLineDragSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not GridTouchComponent:IsInstanceOfType(component) then
    return false
  end
  if component:GetGridTouchStateID() ~= GridTouchStateID.PLLDrag then
    return false
  end
  return true
end

function PreviewLinkLineDragSystem_Render:ExecuteWorld(world)
  local gridTouchComponent = world:GridTouch()
  local touchPlayer = gridTouchComponent:IsTouchPlayer()
  if not touchPlayer then
    return
  end
  local previewEntity = world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  if chainPath == nil then
    return
  end
  local gridTouchComponent = world:GridTouch()
  local posArray = gridTouchComponent:GetGridMovePositionArray()
  local offsetArray = gridTouchComponent:GetGridMoveOffsetArray()
  local linkLineService = world:GetService("PreviewLinkLine")
  if #chainPath == 0 then
    local beginIndex = 0
    for touchIndex = 1, #posArray do
      local touchPosition = posArray[touchIndex]
      local touchOffset = offsetArray[touchIndex]
      if beginIndex == 0 then
        local touchPlayer = linkLineService:IsTouchInPlayerTouchArea(touchPosition, touchOffset)
        if not touchPlayer then
          goto lbl_75
        end
        local prvwSvc = world:GetService("PreviewMonsterTrap")
        prvwSvc:ClearMonsterTrapPreview()
        gridTouchComponent:SetTouchPlayer(touchPlayer)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
        local ret = linkLineService:StartLinkLine(touchPosition, touchOffset)
        beginIndex = touchIndex
        if ret ~= nil and ret == false then
          break
        end
      elseif touchIndex > beginIndex then
        linkLineService:CalcPathPoint(touchPosition, touchOffset)
      end
      ::lbl_75::
    end
  else
    for touchIndex = 1, #posArray do
      local touchPosition = posArray[touchIndex]
      local touchOffset = offsetArray[touchIndex]
      linkLineService:CalcPathPoint(touchPosition, touchOffset)
    end
  end
end

function PreviewLinkLineDragSystem_Render:Filter(world)
  return true
end

function PreviewLinkLineDragSystem_Render:CancelChainPath()
  local inputCmpt = self._world:Input()
  if not inputCmpt:IsPreviewActiveSkill() then
    return
  end
  if inputCmpt:IsPreviewActiveSkillPlaying() then
    return
  end
  local linkLineService = self._world:GetService("PreviewLinkLine")
  linkLineService:CancelChainPath()
  local previewEntity = self._world:GetPreviewEntity()
  linkLineService:NotifyPickUpTargetChange()
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
    previewEntity:ReplacePreviewChainPath({}, PieceType.None, PieceType.None)
    local linkageRenderService = self.world:GetService("LinkageRender")
    linkageRenderService:ShowLinkageInfo({})
    linkageRenderService:HideBenumbTips()
    linkageRenderService:HideTrapWallBlock()
    self:_DisablePreviewChainSkillRange()
    self:_ClearFlashTarget()
  end
  previewEntity:ReplacePreviewLinkLine({}, PieceType.None, PieceType.None)
  linkLineService:NotifyPickUpTargetChange()
end

function PreviewLinkLineDragSystem_Render:_ClearFlashTarget()
  local flashEnemyEntities = self.world:GetGroup(self.world.BW_WEMatchers.MaterialAnimation):GetEntities()
  for _, v in ipairs(flashEnemyEntities) do
    v:StopAnimFlashAlpha()
  end
end

function PreviewLinkLineDragSystem_Render:_DisablePreviewChainSkillRange()
  local reBoard = self._world:GetRenderBoardEntity()
  local previewChainSkillRangeCmpt = reBoard:PreviewChainSkillRange()
  previewChainSkillRangeCmpt:EnablePreviewChainSkillRange(false)
end
