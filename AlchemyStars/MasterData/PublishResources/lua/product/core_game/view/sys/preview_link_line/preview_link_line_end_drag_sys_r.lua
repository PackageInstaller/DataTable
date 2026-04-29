_class("PreviewLinkLineEndDragSystem_Render", UniqueReactiveSystem)
PreviewLinkLineEndDragSystem_Render = PreviewLinkLineEndDragSystem_Render

function PreviewLinkLineEndDragSystem_Render:IsInterested(index, previousComponent, component)
  if component == nil then
    return false
  end
  if not GridTouchComponent:IsInstanceOfType(component) then
    return false
  end
  if component:GetGridTouchStateID() ~= GridTouchStateID.PLLEndDrag then
    return false
  end
  return true
end

function PreviewLinkLineEndDragSystem_Render:ExecuteWorld(world)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleTimeSpeed, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeBossHPBuffButtonRayCast, true)
  local gridTouchCmpt = world:GridTouch()
  local isTouchPlayer = gridTouchCmpt:IsTouchPlayer()
  if isTouchPlayer == true then
    local cameraCmpt = world:MainCamera()
    cameraCmpt:DoMoveCamera(false)
  else
    return
  end
  local syncMoveServiceRender = world:GetService("SyncMoveRender")
  if syncMoveServiceRender then
    syncMoveServiceRender:ClearPreview()
  end
  local linkageSvc = world:GetService("LinkageRender")
  local previewEntity = world:GetPreviewEntity()
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  if chainPath == nil then
    linkageSvc:DestroyTouchPosEffect()
    return
  end
  if isTouchPlayer then
    local piece_service = world:GetService("Piece")
    piece_service:RefreshPieceAnim()
  end
  local linkLineService = world:GetService("PreviewLinkLine")
  linkLineService:FinishBulletTime()
  if isTouchPlayer == true then
    local guideService = world:GetService("Guide")
    if #chainPath <= 1 then
      guideService:ShowGuideWeakLine()
    end
    local guideFinishType = guideService:HandlePLLEndDragTrigger()
    if guideFinishType == false then
      self:_ClearLinkIn()
      linkageSvc:DestroyTouchPosEffect()
      self:_ClearFlashTarget()
      self:_DestroyLinkLine()
      self:_ClearLinkageNum()
      linkLineService:CancelAllLinkPosPieceType(chainPath)
      previewLinkLineCmpt:ClearPreviewChainPath()
      linkLineService:AllMonsterAndTrapTrans(false)
      linkLineService:ShowChainPathCancelArea(false)
      gridTouchCmpt:SetTouchPlayer(false)
      return
    end
  else
  end
  gridTouchCmpt:SetTouchPlayer(false)
  linkLineService:AllMonsterAndTrapTrans(false)
  if 1 < #chainPath then
    local pieceType = previewLinkLineCmpt:GetPreviewPieceType()
    previewLinkLineCmpt:SetPreviewChainPath(chainPath, pieceType)
    self:_LinkDone(chainPath)
    linkageSvc:DestroyTouchPosEffect()
    local utilDataSvc = self._world:GetService("UtilData")
    if utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
      do
        local linkageRenderService = self.world:GetService("LinkageRender")
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          self:SendMovePathDoneCommand(chainPath, pieceType)
          self:_LinkDone(chainPath)
          self.world:GetService("LinkageRender"):ClearLinkRender()
          linkLineService:ShowChainPathCancelArea(false)
        end, self)
      end
    end
  elseif #chainPath == 1 then
    local pieceSvc = world:GetService("Piece")
    local pieceEntity = pieceSvc:FindPieceEntity(chainPath[#chainPath])
    if not pieceEntity then
      Log.fatal("连线坐标：" .. tostring(chainPath[#chainPath]) .. " 位置的格子无法获取到！")
    else
      pieceSvc:SetPieceAnimLinkOut(chainPath[#chainPath])
    end
    local previewEntity = world:GetPreviewEntity()
    previewEntity:ReplacePreviewLinkLine({}, PieceType.None, PieceType.None)
    linkLineService:NotifyPickUpTargetChange()
    linkageSvc:DestroyTouchPosEffect()
    linkLineService:SetMonsterShadowPosListDown(true)
  end
  linkLineService:ShowChainPathCancelArea(false)
end

function PreviewLinkLineEndDragSystem_Render:Filter(world)
  return true
end

function PreviewLinkLineEndDragSystem_Render:_DestroyLinkLine()
  local linkageRenderService = self._world:GetService("LinkageRender")
  local reBoard = self._world:GetRenderBoardEntity()
  local linkRendererDataCmpt = reBoard:LinkRendererData()
  local allEntities = linkRendererDataCmpt:GetLinkLineEntityList()
  for _, linkLineEntity in ipairs(allEntities) do
    linkageRenderService:DestroyLinkLine(linkLineEntity)
  end
end

function PreviewLinkLineEndDragSystem_Render:_ClearLinkageNum()
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

function PreviewLinkLineEndDragSystem_Render:_ClearLinkIn()
  local previewEntity = self._world:GetPreviewEntity()
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  for _, pos in ipairs(chainPath) do
    self._world:GetService("Piece"):SetPieceAnimLinkOut(pos)
  end
end

function PreviewLinkLineEndDragSystem_Render:_LinkDone(chainPath)
  local pieceService = self._world:GetService("Piece")
  for i = 1, #chainPath do
    pieceService:SetPieceAnimLinkDone(chainPath[i])
  end
end

function PreviewLinkLineEndDragSystem_Render:SendMovePathDoneCommand(chainPath, elementType)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local svc = self._world:GetService("RenderEntity")
  svc:DestroyGhost()
  previewActiveSkillService:_DestroyPickUpArrow()
  previewActiveSkillService:_RevertBright()
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID):GetEntities()
  for _, v in ipairs(flashEnemyEntities) do
    local comp = v:MaterialAnimationComponent()
    if comp then
      comp:StopLayer(MaterialAnimLayer.SkillPreview)
    end
  end
  previewActiveSkillService:ResetPreview()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UICancelActiveSkillCast)
  previewActiveSkillService:_ClearPreviewActiveSkill(false, true)
  local cmd = MovePathDoneCommand:New()
  cmd:SetChainPath(chainPath)
  cmd:SetElementType(elementType)
  cmd:SetActiveSkillID(activeSkillID)
  cmd:SetCasterPstID(petPstID)
  self.world:Player():SendCommand(cmd)
  local utilDataSvc = self._world:GetService("UtilData")
  local curstateid = utilDataSvc:GetCurMainStateID()
  Log.debug("PreviewLinkLineEndDragSystem_Render:SendMovePathDoneCommand gamefsm state ", curstateid)
end

function PreviewLinkLineEndDragSystem_Render:_ClearFlashTarget()
  local flashEnemyEntities = self.world:GetGroup(self.world.BW_WEMatchers.MaterialAnimation):GetEntities()
  for _, v in ipairs(flashEnemyEntities) do
    v:StopAnimFlashAlpha()
  end
end
