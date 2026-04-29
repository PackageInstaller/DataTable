_class("CutsceneGameEntry", Object)
CutsceneGameEntry = CutsceneGameEntry

function CutsceneGameEntry:Constructor(levelID)
  self._levelID = levelID
end

function CutsceneGameEntry:InitalizeCoreGame()
  local worldInfo = CutsceneWorldCreationContext:New()
  worldInfo.level_id = self._levelID
  self._world = CutsceneWorld:New(worldInfo)
  self._world:EnterWorld()
  local configService = self._world:GetService("Config")
  configService:InitConfig()
  self:_CacheAssetFile()
  self:_DoRenderBoard()
  local playerEntity = self:CreateCutscenePlayer()
  self._world:Player():SetLocalTeamEntity(playerEntity)
  self:SetUpCutsceneCamera()
  local goEffRuchangActorpoint = UnityEngine.GameObject.Find(GameResourceConst.EffRuchangActorpoint)
  if goEffRuchangActorpoint then
    goEffRuchangActorpoint:SetActive(false)
  end
  self._timeService = self._world:GetService("Time")
  self._running = true
  self._replayTaskID = GameGlobal.TaskManager():CoreGameStartTask(self.ReplayCutscene, self)
end

function CutsceneGameEntry:_CacheAssetFile()
  local entityService = self._world:GetService("RenderEntity")
  entityService:CreateRenderBoardEntity()
  self:_CacheGlobalAssetFile()
  self:_CacheCutsceneGridMaterial()
end

function CutsceneGameEntry:_CacheGlobalAssetFile()
  local file_name = "globalShaderEffects.asset"
  local respool = self._world:GetService("ResourcesPool")
  respool:CacheAsset(file_name, 1)
end

function CutsceneGameEntry:_CacheCutsceneGridMaterial()
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
end

function CutsceneGameEntry:CreateCutscenePlayer()
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

function CutsceneGameEntry:SetUpCutsceneCamera()
  local cameraName = "MainCamera"
  self._request = UnityResourceService:GetInstance():LoadGameObject(cameraName .. ".prefab")
  local go = self._request.Obj
  local levelRawData = Cfg.cfg_level[self._levelID]
  local themeRawData = Cfg.cfg_theme[levelRawData.Theme]
  local cameraCmpt = go:GetComponent("Camera")
  cameraCmpt.fieldOfView = self:CalcCutsceneFov(themeRawData.Fov)
  cameraCmpt.nearClipPlane = themeRawData.NearClipDistance
  cameraCmpt.farClipPlane = themeRawData.FarClipDistance
  local numberArray = string.split(themeRawData.CameraPosition, ",")
  local positionX = tonumber(numberArray[1])
  local positionY = tonumber(numberArray[2])
  local positionZ = tonumber(numberArray[3])
  local cameraPos = Vector3(positionX, positionY, positionZ)
  cameraCmpt.transform.position = cameraPos
  local rotationNumberArray = string.split(themeRawData.CameraRotation, ",")
  local rotationX = tonumber(rotationNumberArray[1])
  local rotationY = tonumber(rotationNumberArray[2])
  local rotationZ = tonumber(rotationNumberArray[3])
  cameraCmpt.transform.rotation = Quaternion.Euler(rotationX, rotationY, rotationZ)
end

function CutsceneGameEntry:CalcCutsceneFov(fov)
  local newFov = fov
  local defaultAspect = BattleConst.CameraDefaultAspect
  local aspect = UnityEngine.Screen.width / UnityEngine.Screen.height
  if defaultAspect > aspect then
    newFov = fov + (defaultAspect - aspect) * 6
  end
  return newFov
end

function CutsceneGameEntry:Stop()
  self._running = false
end

function CutsceneGameEntry:Running()
  return self._running
end

function CutsceneGameEntry:Dispose()
  local cutsceneSvc = self._world:GetService("Cutscene")
  cutsceneSvc:ResetSkyBoxColor()
  self._matchEnterData = nil
  self._enterPreferenceData = nil
  UnityEngine.GameObject.Destroy(self._request.Obj)
  self._request = nil
  self._world:ExitWorld()
  self._world:Dispose()
  InnerGameHelperRender:GetInstance():Dispose()
end

function CutsceneGameEntry:Update(curTimeMS, deltaTimeMS)
  self._timeService:SetCurrentTime(curTimeMS)
  self._timeService:SetDeltaTime(deltaTimeMS)
  self._world:UpdateWorld(deltaTimeMS)
end

function CutsceneGameEntry:ReplayCutscene(TT)
  local cutsceneSvc = self._world:GetService("Cutscene")
  cutsceneSvc:ReviewCutscene(TT, self._levelID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CutsceneFinish)
end

function CutsceneGameEntry:_DoRenderBoard()
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
        gridEntity:SetViewVisible(true)
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
