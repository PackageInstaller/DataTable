_class("GuideServiceRender", BaseService)
GuideServiceRender = GuideServiceRender

function GuideServiceRender:Constructor(world)
  self._world = world
  self._eventListener = GuideServiceListenerRender:New(self)
end

function GuideServiceRender:Initialize()
  self._eventListener:RegEvents()
end

function GuideServiceRender:Dispose()
  self._eventListener:UnregEvents()
  self:FinishGuideShadowEntity(true)
end

function GuideServiceRender:SetNeedYield(need)
  if NOGUIDE then
    self.needYield = false
  else
    self.needYield = need
  end
end

function GuideServiceRender:Trigger(gameEventType, ...)
  local param = {
    ...
  }
  self.taskId = TaskManager:GetInstance():CoreGameStartTask(function(TT)
    if gameEventType == GameEventType.GuideBattleStart then
      local levelId = self:_GetLevelID()
      self._eventDispatcher:Dispatch(gameEventType, levelId, function(needYield)
        self:SetNeedYield(needYield)
      end)
    elseif gameEventType == GameEventType.GuideBattleFinish then
      local levelId = self:_GetLevelID()
      self._eventDispatcher:Dispatch(gameEventType, levelId, function(needYield)
        self:SetNeedYield(needYield)
      end)
    elseif gameEventType == GameEventType.GuideRound then
      local curLevelID, curWaveIndex, curRoundIndex = self:GetCurLevelState()
      local mOrEAction = param[1]
      self._eventDispatcher:Dispatch(gameEventType, curLevelID, curWaveIndex, curRoundIndex, mOrEAction, function(needYield)
        self:SetNeedYield(needYield)
      end)
    elseif gameEventType == GameEventType.GuidePlayerHandleFinish then
      local curLevelID, curWaveIndex, curRoundIndex = self:GetCurLevelState()
      local playerHandleType = param[1]
      local petTempId = self:GetPetTempIdByEntry(param[2])
      if playerHandleType == GuidePlayerHandle.MainSkillFinish then
        self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Button)
      end
      self._eventDispatcher:Dispatch(gameEventType, curLevelID, curWaveIndex, curRoundIndex, playerHandleType, petTempId, function(needYield)
        self:SetNeedYield(needYield)
      end)
    elseif gameEventType == GameEventType.GuidePlayerSkillFinish then
      local curLevelID, curWaveIndex, curRoundIndex = self:GetCurLevelState()
      local levelId = self:_GetLevelID()
      local PlaySkillFinishType = param[1]
      local petTempId = self:GetPetTempIdByEntry(param[2])
      self._eventDispatcher:Dispatch(gameEventType, curLevelID, curWaveIndex, curRoundIndex, PlaySkillFinishType, petTempId, function(needYield)
        self:SetNeedYield(needYield)
      end)
    elseif gameEventType == GameEventType.GuidePlayerSkillRealFinish then
      local curLevelID, curWaveIndex, curRoundIndex = self:GetCurLevelState()
      local levelId = self:_GetLevelID()
      local PlaySkillFinishType = param[1]
      local petTempId = self:GetPetTempIdByEntry(param[2])
      self._eventDispatcher:Dispatch(gameEventType, curLevelID, curWaveIndex, curRoundIndex, PlaySkillFinishType, petTempId, function(needYield)
        self:SetNeedYield(needYield)
      end)
    elseif gameEventType == GameEventType.ShowGuideCancelArea then
      local curLevelID, curWaveIndex, curRoundIndex = self:GetCurLevelState()
      self._eventDispatcher:Dispatch(gameEventType, curLevelID, curWaveIndex, function(needYield)
        self:SetNeedYield(needYield)
      end)
    elseif gameEventType == GameEventType.ShowGuidePowerReady then
      local curLevelID, curWaveIndex, curRoundIndex = self:GetCurLevelState()
      local petTempId = self:GetPetTempIdByEntry(param[1])
      self._eventDispatcher:Dispatch(gameEventType, curLevelID, curWaveIndex, function(needYield)
        self:SetNeedYield(needYield)
      end)
    end
    if NOGUIDE then
      return
    end
    while self.needYield do
      YIELD(TT)
    end
  end)
  return self.taskId
end

function GuideServiceRender:GetCurLevelState()
  local utilStatSvc = self._world:GetService("UtilData")
  local curLevelID = self:_GetLevelID()
  local curWaveIndex = utilStatSvc:GetStatCurWaveIndex()
  local curRoundIndex = utilStatSvc:GetStatCurWaveRoundNum()
  return curLevelID, curWaveIndex, curRoundIndex
end

function GuideServiceRender:_GetLevelID()
  local _configService = self._world:GetService("Config")
  local levelData = _configService:GetLevelConfigData()
  local levelID = levelData:GetLevelID()
  return levelID
end

function GuideServiceRender:GetPetTempIdByEntry(entry)
  if not entry then
    return 0
  end
  local petPstIDCmpt = entry:PetPstID()
  if petPstIDCmpt then
    local petTempId = petPstIDCmpt:GetTemplateID()
    return petTempId
  end
  return 0
end

function GuideServiceRender:IsGuidePathInvokeType()
  return self:GetInvokeType() == GuideInvokeType.GuidePath
end

function GuideServiceRender:GetInvokeType()
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePathCmpt = reBoard:GuidePath()
  return guidePathCmpt and guidePathCmpt:GetInvokeType() or GuideInvokeType.None
end

function GuideServiceRender:ShowGuideLine(guideParam)
  self:_ShowGuideLine(GuideRefreshType.StartGuidePath, guideParam)
end

function GuideServiceRender:_ShowGuideLine(guideRefreshType, guideParam)
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePathCmpt = reBoard:GuidePath()
  local curGuideRefreshType = guidePathCmpt:GetGuideRefreshType()
  if curGuideRefreshType ~= GuideRefreshType.StartGuidePath then
    if guideParam then
      local path = guideParam.LogicParams
      guidePathCmpt:SetGuidePath(path)
      guidePathCmpt:SetInvokeType(guideParam.InvokeType)
    end
    guidePathCmpt:SetGuideRefreshType(guideRefreshType)
    reBoard:ReplaceGuidePath()
    self._eventDispatcher:Dispatch(GameEventType.ShowGuideMask, true)
  end
end

function GuideServiceRender:HandleCameraMoveToNormalTrigger()
  local invokeType = self:GetInvokeType()
  if invokeType ~= GuideInvokeType.GuidePath then
    return false
  end
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  local finishGuide = self:CheckGuidePathFinish(chainPath)
  if finishGuide == false then
    local previewEntity = self._world:GetPreviewEntity()
    previewEntity:ReplacePreviewChainPath({}, PieceType.None, PieceType.None)
    self._eventDispatcher:Dispatch(GameEventType.FlushPetChainSkillItem, true, 0, nil)
    self:_ReShowGuideLine()
    return true
  end
  return false
end

function GuideServiceRender:CheckGuidePathFinish(chainPath)
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePathCmpt = reBoard:GuidePath()
  local guidePath = guidePathCmpt:GetGuidePath()
  if chainPath == nil or guidePath == nil then
    return true
  end
  if #chainPath ~= #guidePath then
    return false
  end
  for index, pathPoint in ipairs(chainPath) do
    local curGuidePoint = guidePath[index]
    if curGuidePoint ~= pathPoint then
      return false
    end
  end
  return true
end

function GuideServiceRender:_ReShowGuideLine()
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePathCmpt = reBoard:GuidePath()
  local curGuideRefreshType = guidePathCmpt:GetGuideRefreshType()
  guidePathCmpt:SetGuideRefreshType(GuideRefreshType.RestartGuidePath)
  reBoard:ReplaceGuidePath()
end

function GuideServiceRender:HandleCameraMoveToFocusTrigger()
  local invokeType = self:GetInvokeType()
  if invokeType ~= GuideInvokeType.GuidePath then
    return
  end
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePathCmpt = reBoard:GuidePath()
  local curGuideRefreshType = guidePathCmpt:GetGuideRefreshType()
  if curGuideRefreshType ~= GuideRefreshType.ShowGuideLine then
    guidePathCmpt:SetGuideRefreshType(GuideRefreshType.ShowGuideLine)
    reBoard:ReplaceGuidePath()
  end
end

function GuideServiceRender:HandleWaitInputTrigger()
  local invokeType = self:GetInvokeType()
  if invokeType == GuideInvokeType.GuidePath then
    local gridTouchCmpt = self._world:GridTouch()
    local isTouchPlayer = gridTouchCmpt:IsTouchPlayer()
    if isTouchPlayer ~= true then
      self:_ShowGuideLine(GuideRefreshType.RestartGuidePath)
    end
  end
end

function GuideServiceRender:HandleBeginDragTrigger(newGridPos)
  self:PauseGuideWeakLine()
  local invokeType = self:GetInvokeType()
  if invokeType == GuideInvokeType.GuidePath then
    local reBoard = self._world:GetRenderBoardEntity()
    local guidePathCmpt = reBoard:GuidePath()
    guidePathCmpt:SetGuideRefreshType(GuideRefreshType.ShowGuideLine)
    reBoard:ReplaceGuidePath()
    return self:_CheckGuidePathHasPos(newGridPos)
  end
  return true
end

function GuideServiceRender:_CheckGuidePathHasPos(gridPos)
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePathCmpt = reBoard:GuidePath()
  local guidePath = guidePathCmpt:GetGuidePath()
  if guidePath == nil then
    return false
  end
  for _, v in ipairs(guidePath) do
    if v == gridPos then
      return true
    end
  end
  return false
end

function GuideServiceRender:HandleEndDragTrigger()
  local invokeType = self:GetInvokeType()
  if invokeType == GuideInvokeType.GuidePath then
    local previewEntity = self._world:GetPreviewEntity()
    local previewChainPathCmpt = previewEntity:PreviewChainPath()
    local chainPath = previewChainPathCmpt:GetPreviewChainPath()
    local reBoard = self._world:GetRenderBoardEntity()
    local guidePathCmpt = reBoard:GuidePath()
    local finishGuide = self:CheckGuidePathFinish(chainPath)
    if finishGuide == true then
      guidePathCmpt:SetInvokeType(GuideInvokeType.None)
      guidePathCmpt:SetGuideRefreshType(GuideRefreshType.StopGuidePath)
      guidePathCmpt:SetGuidePath({})
      reBoard:ReplaceGuidePath()
      self._eventDispatcher:Dispatch(GameEventType.ShowGuideMask, false)
      self._eventDispatcher:Dispatch(GameEventType.FinishGuideStep, GuideType.Line)
    else
      ToastManager.ShowToast(StringTable.Get("str_guide_link_warn"))
      local match = GameGlobal.GetModule(MatchModule)
      local enterData = match:GetMatchEnterData()
      if enterData._match_type == MatchType.MT_Mission then
        local missionID = enterData:GetMissionCreateInfo().mission_id
        GameGlobal.UAReportForceGuideEvent("FightChainDone", {
          missionID,
          previewChainPathCmpt:GetPreviewPieceType(),
          chainPath and #chainPath or 0,
          "",
          0
        })
      end
      return false
    end
  end
  return true
end

function GuideServiceRender:HandleDragTrigger(newGridPos)
  local invokeType = self:GetInvokeType()
  if invokeType ~= GuideInvokeType.GuidePath then
    return true
  end
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  local newPosIndex = #chainPath + 1
  return self:_CheckChainPosMatchGuidPath(newPosIndex, newGridPos)
end

function GuideServiceRender:_CheckChainPosMatchGuidPath(index, gridPos)
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePathCmpt = reBoard:GuidePath()
  local guidePath = guidePathCmpt:GetGuidePath()
  if guidePath == nil then
    return false
  end
  if index > #guidePath then
    return false
  end
  local guidePoint = guidePath[index]
  if guidePoint ~= gridPos then
    return false
  end
  return true
end

function GuideServiceRender:HandleDoubleClickTrigger()
  local invokeType = self:GetInvokeType()
  if invokeType ~= GuideInvokeType.None then
    return true
  end
  return false
end

function GuideServiceRender:CanShowGuideWeakLine()
  local invokeType = self:GetInvokeType()
  return invokeType ~= GuideInvokeType.GuidePath
end

function GuideServiceRender:CheckGuideWeakLine()
  if not self:CanShowGuideWeakLine() then
    return false
  end
  local curLevelID, curWaveIndex, curRoundIndex = self:GetCurLevelState()
  local levelConfigData = ConfigServiceHelper.GetLevelConfigData()
  local data = levelConfigData:GetLevelWeakLineData()
  if not data then
    return false
  end
  if data.dontShowRounds then
    for _, value in ipairs(data.dontShowRounds) do
      if value.wave == curWaveIndex and value.round == curRoundIndex then
        return false
      end
    end
  end
  return true
end

function GuideServiceRender:ShowGuideWeakLine(TT)
  if not self:CheckGuideWeakLine() then
    return
  end
  local reBoard = self._world:GetRenderBoardEntity()
  local autoFightService = self._world:GetService("AutoFight")
  local guidePathCmpt = reBoard:GuideWeakPath()
  local curGuideRefreshType = guidePathCmpt:GetGuideRefreshType()
  if curGuideRefreshType == GuideRefreshType.PauseGuidePath then
    local path = guidePathCmpt:GetGuidePath()
    guidePathCmpt:SetGuideRefreshType(GuideRefreshType.RestartGuidePath)
    guidePathCmpt:SetGuidePath(path)
    reBoard:ReplaceGuideWeakPath()
  else
    if GameGlobal.GetModule(SkillPerfModule):IsPerfCoreGame() then
      return
    end
    local teamEntity = self._world:Player():GetLocalTeamEntity()
    local path = autoFightService:GetAutoChainPath(TT, teamEntity)
    guidePathCmpt:SetGuideRefreshType(GuideRefreshType.StartGuidePath)
    guidePathCmpt:SetGuidePath(path)
    reBoard:ReplaceGuideWeakPath()
  end
end

function GuideServiceRender:PauseGuideWeakLine()
  local reBoard = self._world:GetRenderBoardEntity()
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chainPath = previewChainPathCmpt:GetPreviewChainPath()
  local guidePathCmpt = reBoard:GuideWeakPath()
  guidePathCmpt:SetGuideRefreshType(GuideRefreshType.PauseGuidePath)
  reBoard:ReplaceGuideWeakPath()
end

function GuideServiceRender:FinishGuideWeakLine()
  local reBoard = self._world:GetRenderBoardEntity()
  local guidePathCmpt = reBoard:GuideWeakPath()
  guidePathCmpt:SetGuideRefreshType(GuideRefreshType.StopGuidePath)
  guidePathCmpt:SetGuidePath({})
  reBoard:ReplaceGuideWeakPath()
end

function GuideServiceRender:HandleActiveSkillTrigger()
  return true
end

function GuideServiceRender:ShowGuidePiece(guideParam)
  local invokeType = guideParam and guideParam.InvokeType
  if invokeType == GuideInvokeType.GuidePiece or invokeType == GuideInvokeType.GuidePieceInfinity or GuideInvokeType.GuidePieceInfinityDontYield then
    local posList = guideParam.LogicParams
    local grids = {}
    for _, value in ipairs(posList) do
      table.insert(grids, Vector2(value[1], value[2]))
    end
    TaskManager:GetInstance():CoreGameStartTask(self.CreateGuidePieceEntity, self, grids, invokeType)
    if invokeType == GuideInvokeType.GuidePiece then
      self:ChangeGridColor(grids)
      GameGlobal.Timer():AddEvent(3000, function()
        self:ResetNormal()
        self:DestroyGuidePieceEntity()
        self._eventDispatcher:Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
      end)
    end
  end
end

function GuideServiceRender:DestroyGuidePieceEntity()
  local guidePieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.GuidePiece)
  local remove_list = {}
  for _, entity in ipairs(guidePieceGroup:GetEntities()) do
    table.insert(remove_list, entity)
  end
  for _, e in ipairs(remove_list) do
    self._world:DestroyEntity(e)
  end
  self._eventDispatcher:Dispatch(GameEventType.ShowGuideMask, false)
end

function GuideServiceRender:ChangeGridColor(grids)
  local pieceService = self._world:GetService("Piece")
  local utilDataSvc = self._world:GetService("UtilData")
  local connect_piece_grid_list = grids
  local count = #connect_piece_grid_list
  if 0 < count then
    local piece_group = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
    for _, piece_entity in ipairs(piece_group:GetEntities()) do
      local grid_location_cmpt = piece_entity:GridLocation()
      local is_blocked = utilDataSvc:IsPosBlockLinkLineForChain(grid_location_cmpt.Position)
      if not is_blocked then
        pieceService:SetPieceAnimDark(grid_location_cmpt.Position)
      end
    end
    for k, pos in pairs(connect_piece_grid_list) do
      local is_blocked = utilDataSvc:IsPosBlockLinkLineForChain(pos)
      if not is_blocked then
        pieceService:SetPieceAnimNormal(pos)
      end
    end
  end
end

function GuideServiceRender:CreateGuidePieceEntity(TT, grids, invokeType)
  GuideHelper.GuideLoadLock(false, "Piece")
  local boardServiceRender = self._world:GetService("BoardRender")
  local activeSkill = invokeType ~= GuideInvokeType.GuidePiece
  local guidePieceEntity = self:_CreateGuidePieceEntity(activeSkill)
  local guidePieceCmp = guidePieceEntity:GuidePiece()
  guidePieceCmp:SetValidGrids(grids)
  guidePieceCmp:SetUnValidGrids(boardServiceRender:GetExceptGrids(grids))
  guidePieceEntity:ReplaceGuidePiece()
  if guidePieceEntity and guidePieceEntity:View() then
    local go = guidePieceEntity:View():GetGameObject()
    if go then
      local lineRender = go.transform:GetComponent("LineRenderer")
      local renderEntityService = self._world:GetService("RenderEntity")
      local packageGrids = renderEntityService:GetGridPackagePosList(grids)
      local count = #packageGrids
      lineRender.positionCount = count
      for index = 1, count do
        local realPos = boardServiceRender:GridPos2RenderPos(packageGrids[index])
        lineRender:SetPosition(index - 1, realPos)
      end
      if activeSkill and 0 < #grids then
        go.transform.position = boardServiceRender:GridPos2RenderPos(grids[1])
      end
      self._eventDispatcher:Dispatch(GameEventType.ShowGuideMask, true)
    end
  end
end

function GuideServiceRender:_CreateGuidePieceEntity(activeSkill)
  local sEntity = self._world:GetService("RenderEntity")
  local dotEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.GuidePiece)
  if activeSkill then
    dotEntity:ReplaceAsset(NativeUnityPrefabAsset:New("Eff_Ingame_jnyd_kuang.prefab", true))
  end
  return dotEntity
end

function GuideServiceRender:ResetNormal()
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceService = self._world:GetService("Piece")
  local piece_group = self._world:GetGroup(self._world.BW_WEMatchers.Piece)
  for _, piece_entity in ipairs(piece_group:GetEntities()) do
    local grid_location_cmpt = piece_entity:GridLocation()
    local is_blocked = utilDataSvc:IsPosBlockLinkLineForChain(grid_location_cmpt.Position)
    if not is_blocked then
      pieceService:SetPieceAnimNormal(grid_location_cmpt.Position)
    end
  end
end

function GuideServiceRender:IsValidGuidePiecePos(x, y)
  local guidePieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.GuidePiece)
  local isGuide = false
  local es = guidePieceGroup:GetEntities()
  if guidePieceGroup and table.count(es) <= 0 then
    return true, isGuide
  end
  for _, e in ipairs(es) do
    local guidePieceCmp = e:GuidePiece()
    for _, gridPos in ipairs(guidePieceCmp:GetValidGrids()) do
      if x == gridPos.x and y == gridPos.y then
        isGuide = true
        return true, isGuide
      end
    end
    return false, isGuide
  end
  return false, isGuide
end

function GuideServiceRender:IsGuideAndPieceValid(x, y)
  local guidePieceGroup = self._world:GetGroup(self._world.BW_WEMatchers.GuidePiece)
  local es = guidePieceGroup:GetEntities()
  if guidePieceGroup and table.count(es) <= 0 then
    return false, false
  end
  for _, e in ipairs(es) do
    local guidePieceCmp = e:GuidePiece()
    for _, gridPos in ipairs(guidePieceCmp:GetValidGrids()) do
      if x == gridPos.x and y == gridPos.y then
        return true, true
      end
    end
  end
  return true, false
end

function GuideServiceRender:ShowBuff(buffId)
end

function GuideServiceRender:ShowEntity(guideParam)
  local target, entity, entityType = self:_ShowEntity(guideParam, true)
  if not entity then
    return
  end
  local UI = GameGlobal.UIStateManager()
  UI:ShowDialog("UIGuideModelController", target, entity:GetID(), entityType, function()
    self:ResetShowEntity("UIGuideModelController")
  end)
end

function GuideServiceRender:ResetShowEntity(controllerName)
  self._world:MainCamera():EnableEffectCamera(true)
  local effCamera = self._world:MainCamera():EffectCamera()
  if effCamera then
    local UI = GameGlobal.UIStateManager()
    local camera = UI:GetControllerCamera(controllerName)
    local targetDepth = camera.depth - 1
    self.effDepth = effCamera.depth
    effCamera.depth = targetDepth
  end
end

function GuideServiceRender:_ShowEntity(guideParam, createShadow)
  local entityType = guideParam[1]
  local cfgId = guideParam[2]
  local entity
  if entityType == GuideModelType.Monster or entityType == GuideModelType.ChessMonster then
    local _group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, e in ipairs(_group:GetEntities()) do
      local monsterId = e:MonsterID():GetMonsterID()
      if monsterId == cfgId then
        entity = e
        break
      end
    end
  elseif entityType == GuideModelType.Trap then
    local _group = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
    for _, e in ipairs(_group:GetEntities()) do
      local monsterId = e:TrapRender():GetTrapID()
      if monsterId == cfgId then
        entity = e
        break
      end
    end
  elseif entityType == GuideModelType.ChessPet then
    local _group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
    for _, e in ipairs(_group:GetEntities()) do
      local chessPetCmpt = e:ChessPet()
      local chessPetID = chessPetCmpt:GetChessPetID()
      if chessPetID == cfgId then
        entity = e
        break
      end
    end
  end
  if not entity then
    return nil, nil, nil
  end
  if createShadow then
    self.shadowEntity = self:CreateGuideGhostEntity(entityType, entity)
  end
  local target = entity:View():GetGameObject().transform
  return target, entity, entityType
end

function GuideServiceRender:CreateGuideGhostEntity(entityType, entity)
  if not entity then
    return
  end
  local sEntity = self._world:GetService("RenderEntity")
  local ghostEntity = sEntity:CreateRenderEntity(EntityConfigIDRender.GuideGhost)
  local enemyPos = entity:GridLocation().Position
  local enemyDir = entity:GridLocation().Direction
  local enemyOffset = entity:GridLocation().Offset
  local ghostPos = Vector2(enemyPos.x, enemyPos.y)
  local ghostDir = Vector2(enemyDir.x, enemyDir.y)
  local ghostOffset = Vector2(enemyOffset.x, enemyOffset.y)
  local prefabPath
  if entityType == GuideModelType.Monster or entityType == GuideModelType.ChessMonster then
    if entity:HasMonsterID() then
      local cfg_monster = Cfg.cfg_monster[entity:MonsterID():GetMonsterID()]
      local cfg_monster_class = Cfg.cfg_monster_class[cfg_monster.ClassID]
      prefabPath = cfg_monster_class.ResPath
    end
  elseif entityType == GuideModelType.Trap then
    if entity:TrapRender() then
      prefabPath = entity:Asset():GetResPath()
    end
  elseif entityType == GuideModelType.ChessPet and entity:ChessPet() then
    local cfg_chesspet = Cfg.cfg_chesspet[entity:ChessPet():GetChessPetID()]
    local cfg_chesspet_class = Cfg.cfg_chesspet_class[cfg_chesspet.ClassID]
    prefabPath = cfg_chesspet_class.ResPath
  end
  if prefabPath then
    ghostEntity:ReplaceAsset(NativeUnityPrefabAsset:New(prefabPath, false))
    ghostEntity:ReplaceBodyArea(entity:BodyArea():GetArea())
  end
  ghostEntity:ReplaceGuideGhost(entity:GetID())
  ghostEntity:SetGridLocationAndOffset(ghostPos, ghostDir, ghostOffset)
  ghostEntity:SetLocation(ghostPos + ghostOffset, ghostDir)
  ghostEntity:SetViewVisible(true)
  TaskManager:GetInstance():CoreGameStartTask(function(TT)
    while not ghostEntity:HasView() do
      YIELD(TT)
    end
    GameObjectHelper.SetGameObjectLayer(ghostEntity:View().ViewWrapper.GameObject, GuideConst.EffectLayer)
  end)
  return ghostEntity
end

function GuideServiceRender:ChangeGuideGhostLayer()
  if self.shadowEntity and self.shadowEntity:View() and self.shadowEntity:View().ViewWrapper then
    GameObjectHelper.SetGameObjectLayer(self.shadowEntity:View().ViewWrapper.GameObject, 0)
    self._world:DestroyEntity(self.shadowEntity)
  end
  self.shadowEntity = nil
end

function GuideServiceRender:FinishGuideShadowEntity(dispose)
  if not dispose and self.effDepth and self._world and self._world:MainCamera() then
    self._world:MainCamera():EnableEffectCamera(false)
    local effCamera = self._world:MainCamera():EffectCamera()
    if effCamera then
      effCamera.depth = self.effDepth
    end
  end
end

function GuideServiceRender:ShowCircle(cfg)
  if not cfg then
    return
  end
  local circleType = cfg.type
  local gridPos = Vector2.zero
  if circleType == GuideCircleType.Grid then
    gridPos.x = cfg.param[1]
    gridPos.y = cfg.param[2]
    GameGlobal.UIStateManager():ShowDialog("UIGuideCircleController", cfg, gridPos)
  elseif circleType == GuideCircleType.ClickGrid then
    self:_ShowClickGrid(cfg)
  else
    local targetId
    if circleType == GuideCircleType.Monster then
      local _group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
      for _, e in ipairs(_group:GetEntities()) do
        local monsterId = e:MonsterID():GetMonsterID()
        targetId = monsterId
        if monsterId == cfg.param[1] then
          self:FindCircleCenter(gridPos, e)
          break
        end
      end
    elseif circleType == GuideCircleType.Trap then
      local _group = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
      for _, e in ipairs(_group:GetEntities()) do
        local trapId = e:TrapRender():GetTrapID()
        targetId = trapId
        if trapId == cfg.param[1] then
          self:FindCircleCenter(gridPos, e)
          break
        end
      end
    end
    local entityType = GuideCircleType.Monstercfgsa
    if circleType == GuideCircleType.Monster then
      entityType = GuideModelType.Monster
    elseif circleType == GuideCircleType.Trap then
      entityType = GuideModelType.Trap
    end
    local guideParam = {}
    guideParam[1] = entityType
    guideParam[2] = targetId
    local target, entity, entityType = self:_ShowEntity(guideParam)
    GameGlobal.UIStateManager():ShowDialog("UIGuideCircleModelController", cfg, target)
  end
end

function GuideServiceRender:FindCircleCenter(gridPos, e)
  gridPos = e:GridLocation():GetGridPos()
  local bodyArea = e:BodyArea()
  if bodyArea and bodyArea:GetAreaCount() > 1 then
    local area = bodyArea:GetArea()
    local xTbl = {}
    local yTbl = {}
    for index, vec2 in ipairs(area) do
      local x = gridPos.x + vec2.x
      local y = gridPos.y + vec2.y
      table.insert(xTbl, x)
      table.insert(yTbl, y)
    end
    local minX = table.min(xTbl)
    local minY = table.min(yTbl)
    local maxX = table.max(xTbl)
    local maxY = table.max(yTbl)
    gridPos = Vector2((minX + maxX) / 2, (minY + maxY) / 2)
  end
end

function GuideServiceRender:YieldComplete(TT)
  while self.needYield do
    YIELD(TT)
    if not GameGlobal:GetInstance():IsCoreGameRunning() then
      return
    end
  end
end

function GuideServiceRender:_ShowClickGrid(cfg)
  if not cfg then
    return
  end
  local gridPos = Vector2.zero
  gridPos.x = cfg.param[1]
  gridPos.y = cfg.param[2]
  GameGlobal.UIStateManager():ShowDialog("UIGuideGridController", cfg, gridPos, function(gridPos, offset)
    self:_PreViewMonsterAction(gridPos, offset)
  end)
end

function GuideServiceRender:_PreViewMonsterAction(touchPosition, offset)
  local boardSvcR = self._world:GetService("BoardRender")
  local inputCmpt = self._world:Input()
  local v3Pos = boardSvcR:GridPos2RenderPos(touchPosition)
  inputCmpt:SetTouchBeginPosition(v3Pos)
  local prvwSvc = self._world:GetService("PreviewMonsterTrap")
  prvwSvc:CheckPreviewMonsterAction(touchPosition, offset)
end
