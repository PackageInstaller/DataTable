_class("PopStarProServiceRender", BaseService)
PopStarProServiceRender = PopStarProServiceRender

function PopStarProServiceRender:IsPosBlockPopStar(pos)
  local utilDataSvc = self._world:GetService("UtilData")
  if utilDataSvc:IsHaveEntity(pos, EnumTargetEntity.Pet) then
    return false
  end
  if utilDataSvc:IsPosBlock(pos, BlockFlag.LinkLine) then
    return true
  end
  local listTrap = utilDataSvc:GetTrapsAtPos(pos)
  for _, trapEntity in ipairs(listTrap) do
    local trapRCmp = trapEntity:TrapRender()
    if #trapRCmp:GetActiveSkillID() > 0 then
      return true
    end
  end
  return false
end

function PopStarProServiceRender:CalculatePopStarConnectPieces(gridPos)
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local pieceType = env:GetPieceType(gridPos)
  local pieces = env:GetAllPieceType()
  local connMap = {}
  for x, _ in pairs(pieces) do
    connMap[x] = {}
  end
  local connectPieces = {}
  table.insert(connectPieces, gridPos)
  connMap[gridPos.x][gridPos.y] = true
  local utilDataSvc = self._world:GetService("UtilData")
  
  local function searchConnectPiece(center, next)
    for _, offset in ipairs(Offset8) do
      local pos = Vector2(center.x + offset[1], center.y + offset[2])
      if utilDataSvc:IsValidPiecePos(pos) then
        local connectPieceType = env:GetPieceType(pos)
        local pieceMatch = PopStarCanMatchPieceType(pieceType, connectPieceType)
        if not connMap[pos.x][pos.y] and pieceMatch then
          table.insert(connectPieces, pos)
          connMap[pos.x][pos.y] = true
          next(pos, next)
        end
      end
    end
  end
  
  searchConnectPiece(gridPos, searchConnectPiece)
  return connectPieces
end

function PopStarProServiceRender:PreviewPopInfo(gridPos, connectPieces)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc:IsHaveEntity(gridPos, EnumTargetEntity.Pet) then
    local entityRSvc = self._world:GetService("RenderEntity")
    entityRSvc:CreateGhost(gridPos, teamEntity)
  end
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local pieceType = env:GetPieceType(gridPos)
  local chainPath = connectPieces
  table.insert(chainPath, 1, gridPos)
  if utilDataSvc:CanCastChainSkill(teamEntity, gridPos, connectPieces) then
    local previewEntity = self._world:GetPreviewEntity()
    previewEntity:ReplacePreviewChainPath(chainPath, pieceType)
  end
  local linkageRSvc = self._world:GetService("LinkageRender")
  linkageRSvc:ShowLinkageInfoForPopStarPro(chainPath)
  self:PreviewPopArea(connectPieces)
end

function PopStarProServiceRender:PreviewPopArea(connectPieces)
  local pieceService = self._world:GetService("Piece")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, pieceEntity in ipairs(pieceGroup:GetEntities()) do
    local gridLocationCmpt = pieceEntity:GridLocation()
    local gridPos = gridLocationCmpt.Position
    if not table.icontains(connectPieces, gridPos) then
      pieceService:SetPieceAnimDark(gridPos)
    else
      pieceService:SetPieceAnimNormal(gridPos)
    end
  end
end

function PopStarProServiceRender:PetHeadInQueue()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  for _, pet in ipairs(teamEntity:Team():GetTeamPetEntities()) do
    self._world:EventDispatcher():Dispatch(GameEventType.InOutQueue, pet:PetPstID():GetPstID(), false)
  end
end

function PopStarProServiceRender:ClearPreviewPop(connectPieces)
  local previewEntity = self._world:GetPreviewEntity()
  previewEntity:ReplacePreviewChainPath({})
  local linkageRSvc = self._world:GetService("LinkageRender")
  linkageRSvc:ShowLinkageInfoForPopStarPro({})
  self:_ClearFlashAndTransTarget()
  local mainCameraCmpt = self._world:MainCamera()
  mainCameraCmpt:EnableDarkCamera(false)
  local pieceService = self._world:GetService("Piece")
  local pieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, pieceEntity in ipairs(pieceGroup:GetEntities()) do
    local gridLocationCmpt = pieceEntity:GridLocation()
    local gridPos = gridLocationCmpt.Position
    if not table.icontains(connectPieces, gridPos) then
      pieceService:SetPieceAnimNormal(gridPos)
    end
  end
  self:ClearPreviewTrap()
end

function PopStarProServiceRender:_ClearFlashAndTransTarget()
  local flashGroup = self._world:GetGroup(self._world.BW_WEMatchers.MaterialAnimation)
  local flashEnemyEntities = flashGroup:GetEntities()
  for _, v in ipairs(flashEnemyEntities) do
    v:StopAnimFlashAlpha()
  end
  for _, v in pairs(flashEnemyEntities) do
    if (v:HasMonsterID() or v:HasTrapID()) and (not v:BuffView() or not v:BuffView():HasBuffEffect(BuffEffectType.NotPlayMaterialAnimation)) then
      v:StopGhostAnim()
    end
  end
end

function PopStarProServiceRender:ClearPreviewTrap()
  local previewSvc = self._world:GetService("PreviewMonsterTrap")
  previewSvc:ClearPreviewTrap()
end

function PopStarProServiceRender:PopConnectPieces(TT, connectPieces, score, trapResList)
  local pieceSvc = self._world:GetService("Piece")
  local index = 0
  if score < PopStarConst.PopStarPopCountList[1] then
    index = 1
  elseif score < PopStarConst.PopStarPopCountList[2] then
    index = 2
  elseif score < PopStarConst.PopStarPopCountList[3] then
    index = 3
  elseif score >= PopStarConst.PopStarPopCountList[3] then
    index = 4
  end
  if 0 < index then
    AudioHelperController.PlayInnerGameSfx(PopStarConst.PopStarPopAudioIDList[index])
  end
  self:_PlayTriggerTraps(TT, trapResList)
  local posList = {}
  local effectSvc = self._world:GetService("Effect")
  for _, gridPos in ipairs(connectPieces) do
    effectSvc:CreateWorldPositionEffect(PopStarConst.PopStarPopEffID, gridPos)
    local pieceEntity = pieceSvc:FindPieceEntity(gridPos)
    local worldPos = pieceEntity:View():GetGameObject().transform.position
    local uiWorldPos = self:CalcUIWorldPos(worldPos + Vector3(0, 0.5, 0))
    posList[#posList + 1] = uiWorldPos
  end
  if 0 < PopStarConst.PopStarPlayRankEffDelayTime then
    YIELD(TT, PopStarConst.PopStarPlayRankEffDelayTime)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarPlayRankUIEff, score)
  if 0 < PopStarConst.PopStarPopEffInterval then
    YIELD(TT, PopStarConst.PopStarPopEffInterval)
  end
  local pieceService = self._world:GetService("Piece")
  for _, gridPos in ipairs(connectPieces) do
    pieceService:SetPieceAnimMoveDone(gridPos)
  end
  if 0 < PopStarConst.PopStarGridDownInterval then
    YIELD(TT, PopStarConst.PopStarGridDownInterval)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarPlayPopUIEff, posList)
  if 0 < PopStarConst.PopStarFlyInterval then
    YIELD(TT, PopStarConst.PopStarFlyInterval)
  end
end

function PopStarProServiceRender:PlayPopStarResult(TT, result)
  if not result then
    return
  end
  local trapSvc = self._world:GetService("TrapRender")
  trapSvc:PlayTrapDieSkill(TT, result:GetDelTrapList())
  local score = result:GetPopNum()
  self:PopConnectPieces(TT, result:GetPopConnectPieces(), score, result:GetTrapSkillResults())
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTPopStarProAddFeatureEnergy:New())
  playBuffSvc:PlayBuffView(TT, NTPopStarScoreChange:New())
  self._world:EventDispatcher():Dispatch(GameEventType.PopStarProScoreChange, result:GetTotalPopNum())
  YIELD(TT, PopStarConst.PopStarPopWaitTime)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local pool = {}
  for i, v in ipairs(result:GetDelSet()) do
    local pieceEntity = renderBoardCmpt:GetGridRenderEntity(v.pos)
    pieceEntity:SetViewVisible(false)
    renderBoardCmpt:RemoveGridRenderEntityData(v.pos)
    pool[i] = pieceEntity
  end
  local moveGridDic, effGridList = self:_SortAllMoveGrid(result:GetMoveSet(), result:GetNewSet())
  local effectSvc = self._world:GetService("Effect")
  for _, gridPos in ipairs(effGridList) do
    effectSvc:CreateWorldPositionEffect(PopStarConst.PopStarGridFallEffID, gridPos)
  end
  YIELD(TT, PopStarConst.PopStarFallStartDelayTime)
  local moveEntities = {}
  local poolIndex = 1
  for _, posList in ipairs(moveGridDic) do
    for _, data in ipairs(posList) do
      poolIndex = self:PlayGridFall(TT, data.to, result, poolIndex, pool, moveEntities)
    end
    YIELD(TT, PopStarConst.PopStarMoveInterval)
  end
  while self:IsMoving(moveEntities) do
    YIELD(TT)
  end
  local piece_service = self._world:GetService("Piece")
  if piece_service then
    piece_service:RefreshPieceAnim()
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTPopStarEnd:New(result:GetPopNum()))
end

function PopStarProServiceRender:_PlayTriggerTraps(TT, trapResList)
  for _, v in ipairs(trapResList) do
    local trapEntity = self._world:GetEntityByID(v[1])
    local trapSkillRes = v[2]
    local skillEffectResultContainer = trapSkillRes:GetResultContainer()
    trapEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
    local triggerEntity = self._world:GetEntityByID(v[3])
    local trapSvc = self._world:GetService("TrapRender")
    trapSvc:PlayTrapTriggerSkill(TT, trapEntity, false, triggerEntity)
  end
end

function PopStarProServiceRender:IsMoving(es)
  for _, e in ipairs(es) do
    if e:HasGridMove() then
      return true
    end
  end
end

function PopStarProServiceRender:_GetMoveDataByTargetPos(pos, result)
  for _, v in ipairs(result:GetMoveSet()) do
    if v.to == pos then
      return v
    end
  end
end

function PopStarProServiceRender:_GetNewDataByTargetPos(pos, result)
  for _, v in ipairs(result:GetNewSet()) do
    if v.pos == pos then
      return v
    end
  end
end

function PopStarProServiceRender:_GetMoveTrapDataByTargetPos(pos, result)
  local trapDatas = {}
  for i, v in ipairs(result:GetMoveTrapList()) do
    if v.to == pos then
      trapDatas[#trapDatas + 1] = v
    end
  end
  return trapDatas
end

function PopStarProServiceRender:StopPreviewPopStar()
  local entityRSvc = self._world:GetService("RenderEntity")
  entityRSvc:DestroyGhost()
  self:PetHeadInQueue()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpResCmpt = renderBoardEntity:PopStarPickUpResult()
  if not pickUpResCmpt then
    return
  end
  local connectPieces = pickUpResCmpt:GetPopStarConnectPieces()
  self:ClearPreviewPop(connectPieces)
  pickUpResCmpt:ResetPopStarPickUp()
end

function PopStarProServiceRender:CalcUIWorldPos(worldPos)
  local camera = self._world:MainCamera():Camera()
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local uiCam = GameGlobal.UIStateManager():GetControllerCamera("UIBattle")
  local uiWorldPos = uiCam:ScreenToWorldPoint(screenPos)
  return Vector2(uiWorldPos.x, uiWorldPos.y)
end

function PopStarProServiceRender:_SortAllMoveGrid(moveSet, newSet)
  local posDic = {}
  for _, v in ipairs(moveSet) do
    local columnIndex = v.to.x
    if not posDic[columnIndex] then
      posDic[columnIndex] = {}
    end
    table.insert(posDic[columnIndex], v)
  end
  for _, v in ipairs(newSet) do
    local columnIndex = v.pos.x
    if not posDic[columnIndex] then
      posDic[columnIndex] = {}
    end
    local vMove = {
      from = v.from,
      to = v.pos,
      color = v.color
    }
    table.insert(posDic[columnIndex], vMove)
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local effPosList = {}
  local maxCount = 0
  for k, list in pairs(posDic) do
    table.sort(list, function(dataA, dataB)
      return dataA.to.y < dataB.to.y
    end)
    effPosList[#effPosList + 1] = Vector2(k, utilDataSvc:GetMaxYOfColX(k))
    maxCount = math.max(maxCount, table.count(list))
  end
  local movePosDic = {}
  for i = 1, maxCount do
    movePosDic[i] = {}
    for _, list in pairs(posDic) do
      if list[i] then
        table.insert(movePosDic[i], list[i])
      end
    end
  end
  return movePosDic, effPosList
end

function PopStarProServiceRender:PlayGridFall(TT, gridTargetPos, result, poolIndex, pool, moveEntities)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local boardServiceR = self._world:GetService("BoardRender")
  local speed = 1 / (PopStarConst.PopStarMoveOneGridTime / 1000)
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceService = self._world:GetService("Piece")
  local moveData = self:_GetMoveDataByTargetPos(gridTargetPos, result)
  if moveData then
    local gridEntity = renderBoardCmpt:GetGridRenderEntity(moveData.from)
    local is_blocked = utilDataSvc:IsPosListHaveMonster({
      moveData.to
    })
    if not is_blocked then
      local animName = pieceService:GetPieceAnimation(moveData.from)
      if animName ~= "Normal" then
        pieceService:SetPieceEntityAnimNormal(gridEntity)
      end
    end
    gridEntity:AddGridMove(speed, moveData.to, moveData.from)
    moveEntities[#moveEntities + 1] = gridEntity
    gridEntity:SetGridPosition(moveData.to)
    renderBoardCmpt:SetGridRenderEntityData(moveData.to, gridEntity)
  end
  local newData = self:_GetNewDataByTargetPos(gridTargetPos, result)
  if newData then
    local gridEntity = pool[poolIndex]
    poolIndex = poolIndex + 1
    pieceService:SetPieceEntityPieceType(gridEntity, newData.color)
    gridEntity:SetGridPosition(newData.pos)
    gridEntity:SetPosition(newData.from)
    gridEntity:SetViewVisible(true)
    if newData.pos ~= newData.from then
      gridEntity:AddGridMove(speed, newData.pos, newData.from)
      moveEntities[#moveEntities + 1] = gridEntity
    end
    renderBoardCmpt:SetGridRenderEntityData(newData.pos, gridEntity)
  end
  for _, v in ipairs(self:_GetMoveTrapDataByTargetPos(gridTargetPos, result)) do
    local trapEntity = v.entity
    local trapSvc = self._world:GetService("TrapRender")
    local isPieceExtraLayerTrap = trapSvc:IsPieceExtraLayerTrap(trapEntity)
    if isPieceExtraLayerTrap == false then
      trapEntity:AddGridMove(speed, v.to, v.from)
      moveEntities[#moveEntities + 1] = trapEntity
    end
    if trapEntity:HasTrapRoundInfoRender() then
      local eid = trapEntity:TrapRoundInfoRender():GetRoundInfoEntityID()
      if eid then
        local eff = self._world:GetEntityByID(eid)
        eff:AddGridMove(speed, v.to, v.from)
      end
    end
    local cEffectHolder = trapEntity:EffectHolder()
    if cEffectHolder then
      local effectList = cEffectHolder:GetIdleEffect()
      if table.count(effectList) > 0 then
        for i, eff in ipairs(effectList) do
          local effectEntity = self._world:GetEntityByID(eff)
          if effectEntity and effectEntity:HasView() then
            local curGridPos = boardServiceR:GetRealEntityGridPos(effectEntity)
            local newGridPos = curGridPos + Vector2(v.to.x - v.from.x, v.to.y - v.from.y)
            effectEntity:AddGridMove(speed, newGridPos, curGridPos)
          end
        end
      end
    end
  end
  return poolIndex
end
