require("piece_refresh_state_system")
_class("ClientPieceRefreshSystem_Render", PieceRefreshSystem)
ClientPieceRefreshSystem_Render = ClientPieceRefreshSystem_Render

function ClientPieceRefreshSystem_Render:_DoRenderFillPiece(TT, result)
  if not result then
    return
  end
  local boardRenderSvc = self._world:GetService("BoardRender")
  if result.pieceRefreshType == PieceRefreshType.Inplace then
    boardRenderSvc:FillChainPathPieces(result.inplaceResult)
  elseif result.pieceRefreshType == PieceRefreshType.FallingDown then
    self:FallingDownPieces(TT, result)
  elseif result.pieceRefreshType == PieceRefreshType.Destroy then
    self:RefreshPieceByDestroy(TT, result)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  if result.ntRefreshGridOnPetMoveDone then
    playBuffSvc:PlayBuffView(TT, result.ntRefreshGridOnPetMoveDone)
  end
  if result.ntGridConvert then
    playBuffSvc:PlayBuffView(TT, result.ntGridConvert)
  end
  if result.ntAfterPieceRefreshBeginChainSkill then
    playBuffSvc:PlayBuffView(TT, result.ntAfterPieceRefreshBeginChainSkill)
  end
end

function ClientPieceRefreshSystem_Render:FallingDownPieces(TT, result)
  local pieceService = self._world:GetService("Piece")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local boardServiceR = self._world:GetService("BoardRender")
  local trapSvc = self._world:GetService("TrapRender")
  local pool = {}
  for i, v in ipairs(result.delset) do
    local pieceEntity = renderBoardCmpt:GetGridRenderEntity(v.pos)
    pieceEntity:SetViewVisible(false)
    renderBoardCmpt:RemoveGridRenderEntityData(v.pos)
    pool[i] = pieceEntity
  end
  local moveEntities = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local movePieces = {}
  for i, v in ipairs(result.movset) do
    local gridEntity = renderBoardCmpt:GetGridRenderEntity(v.from)
    local is_blocked = utilDataSvc:IsPosListHaveMonster({
      v.to
    })
    if not is_blocked then
      local animName = pieceService:GetPieceAnimation(v.from)
      if animName ~= "Normal" then
        pieceService:SetPieceEntityAnimNormal(gridEntity)
      end
    end
    local distance = math.abs(v.to.x - v.from.x) + math.abs(v.to.y - v.from.y)
    local speed = distance / BattleConst.FallGridTime
    gridEntity:AddGridMove(speed, v.to, v.from)
    moveEntities[#moveEntities + 1] = gridEntity
    movePieces[i] = {
      gridEntity,
      v.to
    }
  end
  for i, v in ipairs(movePieces) do
    local gridEntity = v[1]
    local pos = v[2]
    gridEntity:SetGridPosition(pos)
    renderBoardCmpt:SetGridRenderEntityData(pos, gridEntity)
  end
  local newsetCount = #result.newset
  local hPerGrid = 0.01
  local totalHeight = hPerGrid * newsetCount
  local waitRestHeightGrids = {}
  for i, v in ipairs(result.newset) do
    local gridEntity = pool[i]
    pieceService:SetPieceEntityPieceType(gridEntity, v.color)
    gridEntity:SetGridPosition(v.pos)
    gridEntity:SetPosition(v.from)
    gridEntity:SetViewVisible(true)
    if v.pos ~= v.from then
      local distance = math.abs(v.pos.x - v.from.x) + math.abs(v.pos.y - v.from.y)
      local speed = distance / BattleConst.FallGridTime
      local gridMoveCmpt = gridEntity:AddGridMove(speed, v.pos, v.from)
      if gridMoveCmpt then
        local movHeight = hPerGrid * (newsetCount - i + 1)
        gridMoveCmpt:SetMovingHeight(movHeight)
      end
      moveEntities[#moveEntities + 1] = gridEntity
    else
      local tmpHeight = hPerGrid * (newsetCount - i + 1)
      local localPosition = boardServiceR:GridPos2RenderPos(v.pos)
      local tmpPos
      if tmpHeight then
        tmpPos = Vector3(localPosition.x, tmpHeight, localPosition.z)
      end
      gridEntity:SetPosition(tmpPos)
      table.insert(waitRestHeightGrids, gridEntity)
    end
    renderBoardCmpt:SetGridRenderEntityData(v.pos, gridEntity)
    Log.debug("_ReplaceGridRes gridPos=", Vector2.Pos2Index(v.pos), " pieceType=", v.color)
  end
  for i, v in ipairs(result.moveTraps) do
    local trapEntity = v.entity
    local distance = math.abs(v.to.x - v.from.x) + math.abs(v.to.y - v.from.y)
    local speed = distance / BattleConst.FallGridTime
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
  while self:IsMoving(moveEntities) do
    YIELD(TT)
  end
  for index, gridEntity in ipairs(waitRestHeightGrids) do
    local gridPostion = gridEntity:GetGridPosition()
    gridEntity:SetPosition(gridPostion)
  end
  local trapSvc = self._world:GetService("TrapRender")
  for i, v in ipairs(result.moveTraps) do
    local trapEntity = v.entity
    local posTarget = v.to
    trapSvc:OnCheckTrapViewSetPieceExtraLayer(trapEntity, posTarget)
  end
  for _, v in ipairs(result.triggerTraps) do
    local e = v[1]
    local skillEffectResultContainer = v[2]
    local triggerEntity = v[3]
    e:SkillRoutine():SetResultContainer(skillEffectResultContainer)
    trapSvc:PlayTrapTriggerSkill(TT, e, false, triggerEntity)
  end
  for _, v in pairs(result.movePrisms) do
    local oldPos = v.from
    pieceService:SetPieceRenderEffect(oldPos, PieceEffectType.Normal)
  end
  for _, v in pairs(result.movePrisms) do
    local newPos = v.to
    local pieceEffectType = v.pieceEffectType
    if newPos then
      pieceService:SetPieceRenderEffect(newPos, pieceEffectType)
    end
  end
  pieceService:RefreshPieceAnim()
end

function ClientPieceRefreshSystem_Render:IsMoving(es)
  for _, e in ipairs(es) do
    if e:HasGridMove() then
      return true
    end
  end
end

function ClientPieceRefreshSystem_Render:_DoRenderShowStoryTips(TT)
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:ShowLinkageInfo({})
  GameGlobal.TaskManager():CoreGameStartTask(self.ShowStoryTips, self)
end

function ClientPieceRefreshSystem_Render:ShowStoryTips(TT)
  YIELD(TT, BattleConst.RefreshPieceTick)
  local innerStoryService = self._world:GetService("InnerStory")
  if innerStoryService:CheckStoryBanner(StoryShowType.WaveAndRoundAfterPlayerRound) then
    InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
  end
  innerStoryService:CheckStoryTips(StoryShowType.WaveAndRoundAfterPlayerRound)
end

function ClientPieceRefreshSystem_Render:RefreshPieceByDestroy(TT, result)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local boardRenderSvc = self._world:GetService("BoardRender")
  local trapSvc = self._world:GetService("TrapRender")
  local effectSvc = self._world:GetService("Effect")
  local fillPieceTable = result.inplaceResult
  if fillPieceTable and 0 < #fillPieceTable then
    boardRenderSvc:FillChainPathPieces(fillPieceTable)
  end
  if result.destroyTrapIDList then
    local destroyTrapList = {}
    for _, entityID in ipairs(result.destroyTrapIDList) do
      local entity = self._world:GetEntityByID(entityID)
      if entity then
        destroyTrapList[#destroyTrapList + 1] = entity
      end
    end
    local donotPlayDie = true
    trapSvc:PlayTrapDieSkill(TT, destroyTrapList, donotPlayDie)
  end
  if result.newTrapIDList then
    local trapList = {}
    local posList = {}
    for _, entityID in ipairs(result.newTrapIDList) do
      local entity = self._world:GetEntityByID(entityID)
      if entity then
        trapList[#trapList + 1] = entity
        posList[#posList + 1] = entity:GetGridPosition()
      end
    end
    trapSvc:ShowTraps(TT, trapList, true)
    for _, pos in ipairs(posList) do
      local pieceEntity = renderBoardCmpt:GetGridRenderEntity(pos)
      pieceEntity:SetViewVisible(false)
    end
    for index, pos in ipairs(posList) do
      if index ~= 1 then
        YIELD(TT, BattleConst.DestroyPieceEffectPlayInterval)
      end
      local effEntityID = renderBoardCmpt:GetGridEffectEntityID(pos)
      local effectEntity = self._world:GetEntityByID(effEntityID)
      if effectEntity then
        self._world:DestroyEntity(effectEntity)
        renderBoardCmpt:RemoveGridEffectEntityID(pos)
      end
      effectSvc:CreateWorldPositionEffect(BattleConst.DestroyPieceEffectID, pos)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIUpdateBossCastSkillTipInfo, #trapList)
  end
end
