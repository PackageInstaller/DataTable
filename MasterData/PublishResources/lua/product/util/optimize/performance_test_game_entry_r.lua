_class("PerformanceTestGameEntry", Object)
PerformanceTestGameEntry = PerformanceTestGameEntry

function PerformanceTestGameEntry:Constructor(levelID, sceneGO)
  self._levelID = levelID
  self._sceneGO = sceneGO
end

function PerformanceTestGameEntry:InitalizeCoreGame()
  local worldInfo = CutsceneWorldCreationContext:New()
  worldInfo.level_id = self._levelID
  worldInfo.matchType = MatchType.MT_Mission
  self._world = PerformanceWorld:New(worldInfo)
  self._world:EnterWorld()
  self._world:SetSceneGO(self._sceneGO)
  local configService = self._world:GetService("Config")
  configService:InitConfig()
  self:_CacheAssetFile()
  local entityService = self._world:GetService("LogicEntity")
  entityService:CreateBoardEntity()
  self:_DoRenderBoard()
  self:SetUpCutsceneCamera()
  local goEffRuchangActorpoint = UnityEngine.GameObject.Find(GameResourceConst.EffRuchangActorpoint)
  if goEffRuchangActorpoint then
    goEffRuchangActorpoint:SetActive(false)
  end
  self._timeService = self._world:GetService("Time")
  self._running = true
end

function PerformanceTestGameEntry:_CacheAssetFile()
  local entityService = self._world:GetService("RenderEntity")
  entityService:CreateRenderBoardEntity()
  self:_CacheGlobalAssetFile()
end

function PerformanceTestGameEntry:_CacheGlobalAssetFile()
  local file_name = "globalShaderEffects.asset"
  local respool = self._world:GetService("ResourcesPool")
  respool:CacheAsset(file_name, 1)
end

function PerformanceTestGameEntry:_CacheCutsceneGridMaterial()
  local loadingSvc = self._world:GetService("Loading")
  loadingSvc:_CacheGridMaterial()
  local respool = self._world:GetService("ResourcesPool")
  local cachetable = {}
  loadingSvc:_CacheCurrentGrid(cachetable)
  for k, v in pairs(cachetable) do
    local resname = v[1]
    local count = v[2]
    if string.endwith(resname, ".mat") then
      respool:CacheMaterial(resname, count)
    else
      respool:Cache(resname, count)
    end
  end
  loadingSvc:_ReplaceCachedGridMaterial()
end

function PerformanceTestGameEntry:CreateCutscenePlayer()
  local entityConstId = EntityConfigIDRender.CutscenePlayer
  local ctx = EntityCreationContext:New()
  ctx.entity_config_id = entityConstId
  ctx.bShow = true
  local entity = self._world:CreateEntity()
  self._world:SetEntityIdByEntityConfigId(entity, entityConstId)
  EntityAssembler.AssembleEntityComponents(entity, ctx)
  local prefabPath = "1500331.prefab"
  entity:ReplaceAsset(NativeUnityPrefabAsset:New(prefabPath))
  local pos = Vector3(0, 0, 0)
  entity:SetLocation(pos)
  return entity
end

function PerformanceTestGameEntry:SetUpCutsceneCamera()
  self._world:MainCamera():Camera()
  local listenerSvc = self._world:GetService("PerformanceListener")
  local levelRawData = Cfg.cfg_level[self._levelID]
  listenerSvc:SetCamera(levelRawData.Theme)
end

function PerformanceTestGameEntry:CalcCutsceneFov(fov)
  local newFov = fov
  local defaultAspect = BattleConst.CameraDefaultAspect
  local aspect = UnityEngine.Screen.width / UnityEngine.Screen.height
  if defaultAspect > aspect then
    newFov = fov + (defaultAspect - aspect) * 6
  end
  return newFov
end

function PerformanceTestGameEntry:Stop()
  self._running = false
end

function PerformanceTestGameEntry:Running()
  return self._running
end

function PerformanceTestGameEntry:Dispose()
  self._matchEnterData = nil
  self._enterPreferenceData = nil
  self._request = nil
  self._world:ExitWorld()
  self._world:Dispose()
  InnerGameHelperRender:GetInstance():Dispose()
end

function PerformanceTestGameEntry:Update(curTimeMS, deltaTimeMS)
  self._timeService:SetCurrentTime(curTimeMS)
  self._timeService:SetDeltaTime(deltaTimeMS)
  self._world:UpdateWorld(deltaTimeMS)
end

function PerformanceTestGameEntry:ReplayCutscene(TT)
  local cutsceneSvc = self._world:GetService("Cutscene")
  cutsceneSvc:ReviewCutscene(TT, self._levelID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CutsceneFinish)
end

function PerformanceTestGameEntry:_DoRenderBoard()
  local boardServiceRender = self._world:GetService("BoardRender")
  local gapTiles = BattleConst.GapTiles
  local gapTilesPosList = {}
  for i, p in ipairs(gapTiles) do
    local gridPos = Vector2(p[1], p[2])
    table.insert(gapTilesPosList, gridPos)
  end
  local piecePosList = {}
  for x = 1, BattleConst.DefaultMaxX do
    for y = 1, BattleConst.DefaultMaxY do
      local gridPos = Vector2(x, y)
      if not table.icontains(gapTilesPosList, gridPos) then
        local pieceType = math.random(1, 4)
        local gridEntity = boardServiceRender:CreateGridEntity(pieceType, gridPos, true)
        gridEntity:SetViewVisible(false)
        local renderPos = boardServiceRender:GridPos2RenderPos(gridPos)
        table.insert(piecePosList, renderPos)
      end
    end
  end
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = renderBoardEntity:RenderBoard()
  local brillantLineObj = renderBoardCmpt:GetBrillantGridObj()
  if brillantLineObj then
    brillantLineObj:SetActive(true)
    local curPieceTable = renderBoardCmpt._gridEntityTable
    CellRenderManager.DrawRangeImmediate(piecePosList)
  end
end
