require("wait_input_system")
_class("ClientWaitInputSystem_Render", WaitInputSystem)
ClientWaitInputSystem_Render = ClientWaitInputSystem_Render

function ClientWaitInputSystem_Render:_DoRenderStopPortalPreview(TT)
  local utilDataSvc = self._world:GetService("UtilData")
  local hasDoor = utilDataSvc:HasDimensionDoor()
  if not hasDoor then
    return
  end
  local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
  sPreviewSkill:StopPreviewChainSkill(TT)
  local pieceService = self._world:GetService("Piece")
  pieceService:RefreshPieceAnim()
end

function ClientWaitInputSystem_Render:_DoRenderPieceAnimation(TT)
  local piece_service = self._world:GetService("Piece")
  if piece_service then
    piece_service:RefreshPieceAnim()
    piece_service:RefreshMonsterAreaOutLine(TT)
  end
end

function ClientWaitInputSystem_Render:_DoRenderGuidePlayer(TT)
  local guideService = self._world:GetService("Guide")
  local utilStatSvc = self._world:GetService("UtilData")
  local guideTaskId
  if utilStatSvc:GetStatIsRoundAuroraTime() then
    guideTaskId = guideService:Trigger(GameEventType.GuideRound, GuideRoundTurn.AuroraTime)
  end
  while not TaskHelper:GetInstance():IsTaskFinished(guideTaskId, true) do
    YIELD(TT)
  end
end

function ClientWaitInputSystem_Render:_DoRenderWaitStun(TT)
  YIELD(TT, BattleConst.StunWaitTime)
end

function ClientWaitInputSystem_Render:_DoRenderCameraFollowHero()
end

function ClientWaitInputSystem_Render:_DoRenderShowPlayerTurnInfo(TT, teamEntity)
  if teamEntity == nil then
    return
  end
  if self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
    self:_DoRenderShowLocalPlayerTurnUI(TT, teamEntity)
  else
    self:_DoRenderShowRemotePlayerTurnUI(TT, teamEntity)
  end
end

function ClientWaitInputSystem_Render:_DoRenderShowLocalPlayerTurnUI(TT, teamEntity)
  local innerStoryService = self._world:GetService("InnerStory")
  if innerStoryService:CheckStoryBanner(StoryShowType.WaveAndRoundBeginPlayerRound) then
    InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
  end
  innerStoryService:CheckStoryTips(StoryShowType.WaveAndRoundBeginPlayerRound)
  local showArrow = self:_IsShowArrow()
  if showArrow == true then
    local arrowService = self._world:GetService("CanMoveArrow")
    arrowService:ShowCanMoveArrow(true)
  end
  local guideService = self._world:GetService("Guide")
  guideService:HandleWaitInputTrigger()
  guideService:ShowGuideWeakLine(TT)
  self:_DoRenderShowHideBesiegedTips(TT, teamEntity)
  local petEntities = self._world:GetGroup(self._world.BW_WEMatchers.PetPstID):GetEntities()
  for _, e in ipairs(petEntities) do
    local pstIDCmpt = e:PetPstID()
    local pstID = pstIDCmpt:GetPstID()
    self._world:EventDispatcher():Dispatch(GameEventType.InOutQueue, pstID, false)
  end
end

function ClientWaitInputSystem_Render:_DoRenderShowRemotePlayerTurnUI(TT)
end

function ClientWaitInputSystem_Render:_DoRenderShowPetHeadUI(TT)
  if self._world:GetGameTurn() == GameTurnType.LocalPlayerTurn then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowPetInfo, 1)
  else
  end
end

function ClientWaitInputSystem_Render:_IsShowArrow()
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    return false
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local curMainStateID = utilDataSvc:GetCurMainStateID()
  if curMainStateID ~= GameStateID.WaitInput then
    Log.notice("has exit wait input state,should not show arrow")
    return false
  end
  local gridTouchComponent = self._world:GridTouch()
  local touchState = gridTouchComponent:GetGridTouchStateID()
  if touchState == GridTouchStateID.BeginDrag or touchState == GridTouchStateID.Drag then
    Log.notice("drag,should not show arrow")
    return false
  end
  return true
end

function ClientWaitInputSystem_Render:_DoRenderShowAuroraTime(TT)
  local battleRenderCmpt = self._world:BattleRenderConfig()
  local utilStatSvc = self._world:GetService("UtilData")
  if not utilStatSvc:GetStatIsRoundAuroraTime() then
    return
  end
  local isReEnter = utilStatSvc:GetStatIsReEnterAuroraTime()
  if not isReEnter then
    if battleRenderCmpt:IsWaitInputAuroraTime() then
      return
    end
  elseif battleRenderCmpt:IsReEnterAuroraTimePlayed() then
    return
  end
  self:_DoRenderGuidePlayer(TT)
  battleRenderCmpt:SetWaitInputAuroraTime(true)
  if isReEnter then
    self:_DoRenderCloseAuroraTime(TT)
  end
  local playbuffsvc = self._world:GetService("PlayBuff")
  playbuffsvc:PlayBuffView(TT, NTEnterAuroraTime:New())
  local renderEntitySvc = self._world:GetService("RenderEntity")
  renderEntitySvc:ShowUITurnTips(true, true)
  self._world:MainCamera():SetAuroaTimeObjActive(true)
  self._world:MainCamera():ToggleAuroraTime(true)
  self._world:EventDispatcher():Dispatch(GameEventType.ShowHideAuroraTime, true)
  if isReEnter then
    battleRenderCmpt:SetReEnterAuroraTimePlayed(true)
  end
  YIELD(TT, BattleConst.RefreshPetInfoTick)
end

function ClientWaitInputSystem_Render:_DoRenderShowHideBesiegedTips(TT, teamEntity)
  if self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro then
    return
  end
  local playerPos = teamEntity:GetGridPosition()
  local utilDataSvc = self._world:GetService("UtilData")
  local listTotalData = ComputeScopeRange.ComputeRange_SquareRing(playerPos, 1, 1)
  local listAttackData = {}
  for key, value in pairs(listTotalData) do
    local isValidGrid = not utilDataSvc:IsPosBlockLinkLineForChain(value)
    if isValidGrid == true then
      listAttackData[#listAttackData + 1] = value
    end
  end
  if #listAttackData == 0 then
    self._world:EventDispatcher():Dispatch(GameEventType.ShowHideBesiegedTips, true)
  else
    self._world:EventDispatcher():Dispatch(GameEventType.ShowHideBesiegedTips, false)
  end
end

function ClientWaitInputSystem_Render:_DoRenderCompareHPLog(TT)
  local openException = false
  self:_CompareLogicRenderHP(openException)
end

function ClientWaitInputSystem_Render:_DoRenderPlayWaitInputBuff(TT)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTWaitInput:New())
end

function ClientWaitInputSystem_Render:_DoRenderComparePieceType(TT)
  if not EDITOR then
    return
  end
  local cPreviewEnv = self._world:GetPreviewEntity():PreviewEnv()
  local cPreviewPieceTypeIndexMap = cPreviewEnv._pieceTypes
  local cPreviewAllPiece = cPreviewEnv:GetAllPieceType()
  local previewPieceDiff = {}
  for posIndex, pieceType in pairs(cPreviewPieceTypeIndexMap) do
    local x = posIndex // 100
    local y = posIndex - x * 100
    if not cPreviewAllPiece[x] then
      table.insert(previewPieceDiff, {
        posIndex = posIndex,
        err = "not found in all piece table"
      })
    elseif cPreviewAllPiece[x][y] ~= pieceType then
      table.insert(previewPieceDiff, {
        posIndex = posIndex,
        err = string.format("different color: _pieceType->%s, _allPieceTable->%s", tostring(pieceType), tostring(cPreviewAllPiece[x][y]))
      })
    end
  end
  local piecePosList = {}
  local tePiece = self._world:GetGroupEntities(self._world.BW_WEMatchers.Piece)
  for _, ePiece in ipairs(tePiece) do
    if not ePiece:HasOutsideRegion() then
      local cPiece = ePiece:Piece()
      local pos = ePiece:GetGridPosition()
      local pieceType = cPiece:GetPieceType()
      local previewEnvType = cPreviewEnv:GetPieceType(pos)
      if pieceType ~= previewEnvType then
        if pieceType == 0 and previewEnvType == 5 then
          Log.fatal("player at any piece pos")
        else
          table.insert(previewPieceDiff, {
            posIndex = pos:Pos2Index(),
            err = string.format("different piece color: piece->%s, previewEnv->%s", pieceType, previewEnvType)
          })
        end
      end
      if not table.icontains(piecePosList, pos) then
        table.insert(piecePosList, pos)
      else
        table.insert(previewPieceDiff, {
          posIndex = pos:Pos2Index(),
          err = "piece entity pos repeat"
        })
      end
    end
  end
  if #previewPieceDiff ~= 0 then
    for _, exception in ipairs(previewPieceDiff) do
      Log.error("[PieceTypeDiff] err: posIndex=", tostring(exception.posIndex), " desc: ", tostring(exception.err))
    end
    Log.exception("[PieceTypeDiff] PieceType conflict. Check log for more information. ")
  end
end

function ClientWaitInputSystem_Render:ClearPreviewChainPathData()
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  previewChainPathCmpt:ClearPreviewChainPath()
end

function ClientWaitInputSystem_Render:_DoRenderAutoFight(TT, teamEntity)
  local svcTest = self._world:GetService("AutoTest")
  if svcTest and svcTest:IsRunning() then
    return
  end
  local svc = self._world:GetService("AutoFight")
  GameGlobal.TaskManager():CoreGameStartTask(svc.AutoFight, svc, teamEntity)
end

function ClientWaitInputSystem_Render:_DoRenderSetPreviewTeam(teamEntity)
  self._world:Player():SetPreviewTeamEntity(teamEntity)
end

function ClientWaitInputSystem_Render:_DoRenderPlayerBuffDelayed(TT, teamEntity)
  YIELD(TT, BattleConst.PlayerStunRenderYieldTimeMS)
  local playBuffService = self._world:GetService("PlayBuff")
  playBuffService:PlayPlayerTurnStartBuff(TT, teamEntity, nil, true)
end
