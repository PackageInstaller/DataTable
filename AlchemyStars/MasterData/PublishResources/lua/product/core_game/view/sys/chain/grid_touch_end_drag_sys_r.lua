_class("GridEndDragSystem_Render", UniqueReactiveSystem)
GridEndDragSystem_Render = GridEndDragSystem_Render

function GridEndDragSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not GridTouchComponent:IsInstanceOfType(component) then
    return false
  end
  if component:GetGridTouchStateID() ~= GridTouchStateID.EndDrag then
    return false
  end
  return true
end

function GridEndDragSystem_Render:ExecuteWorld(world)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeBossHPBuffButtonRayCast, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MatchLineDragEnd)
  local gridTouchCmpt = world:GridTouch()
  local isTouchPlayer = gridTouchCmpt:IsTouchPlayer()
  local cameraCmpt = self.world:MainCamera()
  if isTouchPlayer == true then
    cameraCmpt:DoMoveCamera(false)
  end
  local syncMoveServiceRender = self._world:GetService("SyncMoveRender")
  if syncMoveServiceRender then
    syncMoveServiceRender:ClearPreview()
  end
  local boardServiceR = world:GetService("BoardRender")
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  if chainPath == nil then
    Log.fatal("chain path is nil")
    return
  end
  previewChainPathCmpt:SetLinkLineState(false)
  local pieceType = previewChainPathCmpt:GetPreviewPieceType()
  local utilDataSvc = self._world:GetService("UtilData")
  if isTouchPlayer then
    local piece_service = world:GetService("Piece")
    piece_service:RefreshPieceAnim()
  end
  local linkLineService = world:GetService("LinkLine")
  linkLineService:FinishBulletTime()
  if isTouchPlayer == true then
    local guideService = world:GetService("Guide")
    if #chainPath <= 1 then
      guideService:ShowGuideWeakLine()
    end
    local guideFinishType = guideService:HandleEndDragTrigger()
    if guideFinishType == false then
      self:_ClearLinkIn()
      self.world:GetService("LinkageRender"):ClearLinkRender()
      self:_ClearFlashTarget()
      linkLineService:AllMonsterAndTrapTrans(false)
      self:_DestroyLinkLine()
      self:_ClearLinkageNum()
      local chainPath = previewChainPathCmpt:GetPreviewChainPath()
      if chainPath then
        local sBoardRender = self._world:GetService("BoardRender")
        local cPreviewEnv = previewEntity:PreviewEnv()
        for i, pos in ipairs(chainPath) do
          if cPreviewEnv and cPreviewEnv:IsPrismPiece(pos) then
            sBoardRender:UnapplyPrism(pos)
          end
        end
      end
      linkLineService:CancelBoardPieceMap(chainPath)
      previewChainPathCmpt:ClearPreviewChainPath()
      linkLineService:ShowChainPathCancelArea(false)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushPetChainSkillItem, true, 0, nil)
      gridTouchCmpt:SetTouchPlayer(false)
      return
    end
  else
    previewChainPathCmpt:ClearPreviewChainPath()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushPetChainSkillItem, true, 0, nil)
    return
  end
  gridTouchCmpt:SetTouchPlayer(false)
  if chainPath == nil then
    self.world:GetService("LinkageRender"):ClearLinkRender()
    return
  end
  local reBoard = self._world:GetRenderBoardEntity()
  if reBoard then
    local previewChainSkillRangeCmpt = reBoard:PreviewChainSkillRange()
    previewChainSkillRangeCmpt:EnablePreviewChainSkillRange(false)
  end
  self:_ClearFlashTarget()
  linkLineService:AllMonsterAndTrapTrans(false)
  if 1 < #chainPath then
    local lastchainPathPos = chainPath[#chainPath]
    local isBlock = utilDataSvc:IsPosBlockLinkLineForChainChainEnd(lastchainPathPos)
    if isBlock then
      for i = table.count(chainPath), 2, -1 do
        local chainPos = chainPath[i]
        linkLineService:_OnPieceRemoveFromChain(chainPos)
      end
      chainPath = {
        chainPath[1]
      }
    end
  end
  linkLineService:CancelBoardPieceMap(chainPath)
  if 1 < #chainPath then
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      local guideService = world:GetService("Guide")
      local guideTaskId = guideService:Trigger(GameEventType.GuidePlayerHandleFinish, GuidePlayerHandle.LinkEnd)
      while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
        YIELD(TT)
      end
      previewChainPathCmpt:SetPreviewChainPath(chainPath, pieceType)
      self:SendMovePathDoneCommand(chainPath, pieceType)
      self:_LinkDone(chainPath)
      self.world:GetService("LinkageRender"):ClearLinkRender()
      linkLineService:ShowChainPathCancelArea(false)
    end, self)
  else
    local arrowService = self.world:GetService("CanMoveArrow")
    arrowService:ShowCanMoveArrow(true)
    if #chainPath == 1 then
      local pieceSvc = self._world:GetService("Piece")
      local pieceEntity = pieceSvc:FindPieceEntity(chainPath[#chainPath])
      if not pieceEntity then
        Log.fatal("连线坐标：" .. tostring(chainPath[#chainPath]) .. " 位置的格子无法获取到！")
      else
        pieceSvc:SetPieceAnimLinkOut(chainPath[#chainPath])
      end
      local previewEntity = self._world:GetPreviewEntity()
      previewEntity:ReplacePreviewChainPath({}, PieceType.None, PieceType.None)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.FlushPetChainSkillItem, true, 0, nil)
      local linkageRenderService = self.world:GetService("LinkageRender")
      linkageRenderService:ShowLinkageInfo({})
      linkageRenderService:ClearLinkRender()
      linkageRenderService:HideBenumbTips()
      linkageRenderService:HideTrapWallBlock()
      linkLineService:SetMonsterShadowPosListDown(true)
    end
    linkLineService:ShowChainPathCancelArea(false)
  end
end

function GridEndDragSystem_Render:Filter(world)
  return true
end

function GridEndDragSystem_Render:SendMovePathDoneCommand(chainPath, elementType)
  local cmd = MovePathDoneCommand:New()
  cmd:SetChainPath(chainPath)
  cmd:SetElementType(elementType)
  self.world:Player():SendCommand(cmd)
  local utilDataSvc = self._world:GetService("UtilData")
  local curstateid = utilDataSvc:GetCurMainStateID()
  Log.debug("GridEndDragSystem_Render:SendMovePathDoneCommand gamefsm state ", curstateid)
end

function GridEndDragSystem_Render:_ClearLinkageNum()
  local entityPoolService = self.world:GetService("EntityPool")
  local reBoard = self.world:GetRenderBoardEntity()
  local linkRendererDataCmpt = reBoard:LinkRendererData()
  local allEntities = linkRendererDataCmpt:GetLinkageNumEntityList()
  local linkageRenderService = self.world:GetService("LinkageRender")
  local remove_list = {}
  for _, linkageNumEntity in ipairs(allEntities) do
    table.insert(remove_list, linkageNumEntity)
  end
  for _, e in ipairs(remove_list) do
    linkageRenderService:DestroyLinkNum(e)
  end
end

function GridEndDragSystem_Render:_DestroyLinkLine()
  local entityPoolService = self.world:GetService("EntityPool")
  local linkageRenderService = self.world:GetService("LinkageRender")
  local reBoard = self.world:GetRenderBoardEntity()
  local linkRendererDataCmpt = reBoard:LinkRendererData()
  local allEntities = linkRendererDataCmpt:GetLinkLineEntityList()
  for _, linkLineEntity in ipairs(allEntities) do
    linkageRenderService:DestroyLinkLine(linkLineEntity)
  end
end

function GridEndDragSystem_Render:_ClearFlashTarget()
  local flashEnemyEntities = self.world:GetGroup(self.world.BW_WEMatchers.MaterialAnimation):GetEntities()
  for _, v in ipairs(flashEnemyEntities) do
    v:StopAnimFlashAlpha()
  end
end

function GridEndDragSystem_Render:_ClearLinkIn()
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  for _, pos in ipairs(chainPath) do
    self.world:GetService("Piece"):SetPieceAnimLinkOut(pos)
  end
end

function GridEndDragSystem_Render:_LinkDone(chainPath)
  local pieceService = self.world:GetService("Piece")
  for i = 1, #chainPath do
    pieceService:SetPieceAnimLinkDone(chainPath[i])
  end
end
