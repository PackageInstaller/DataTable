_class("PerformanceListenerServiceRender", BaseService)
PerformanceListenerServiceRender = PerformanceListenerServiceRender

function PerformanceListenerServiceRender:Constructor(world)
  self._world = world
  self._autoBinder = AutoEventBinder:New(self._world:EventDispatcher())
  Log.notice("PerformanceListenerServiceRender start")
  self._autoBinder:BindEvent(GameEventType.BeginTestScence, self, self.OnBeginTestScene)
  self._autoBinder:BindEvent(GameEventType.StopTestScence, self, self.OnStopTestScene)
  self._autoBinder:BindEvent(GameEventType.UpdateTestScenceFPS, self, self.AddLog)
  self._autoBinder:BindEvent(GameEventType.SwitchScene, self, self.UISwitchScene)
  self._autoBinder:BindEvent(GameEventType.PerfMonsterStat, self, self.UIPerfMonsterStat)
  self._autoBinder:BindEvent(GameEventType.SwitchMonster, self, self.UISwitchMonster)
  self._fightResultEventListener = FightResultEventListenerRender:New(self._world, self._autoBinder)
  self._cameraSvc = self._world:GetService("Camera")
end

function PerformanceListenerServiceRender:Dispose()
  self._autoBinder:UnBindAllEvents()
end

function PerformanceListenerServiceRender:SetCamera(themeID)
  local levelConfigData = self._configService:GetLevelConfigData()
  levelConfigData:ParseCameraParam(themeID)
  self._cameraSvc:_InitSceneCamera()
end

local ScenePerfTestType = {
  OnlySceneTheme = 1,
  SceneAndMonster = 2,
  SceneAndTexture = 3,
  SceneAndStatsData = 4
}
_enum("ScenePerfTestType", ScenePerfTestType)

function PerformanceListenerServiceRender:OnBeginTestScene(testType)
  self._stopFlag = false
  GameGlobal.TaskManager():CoreGameStartTask(self._TestScene, self, testType)
end

function PerformanceListenerServiceRender:OnStopTestScene()
  self._stopFlag = true
end

function PerformanceListenerServiceRender:AddLog(sceneName, themeID, fpsNumber)
  local levelCommits
  if not self._logs then
    self._logs = {
      "Scene,ThemeID,FPS,LevelCommits,LevelID"
    }
  end
  local levelID
  for k, v in pairs(Cfg.cfg_level()) do
    if v.Theme == themeID and v.comment then
      levelCommits = v.comment
      levelID = tostring(v.ID)
      break
    end
    if v.Theme == themeID and not v.comment then
      levelID = tostring(v.ID)
    end
  end
  local s
  if levelCommits then
    s = sceneName .. "," .. tostring(themeID) .. "," .. tostring(fpsNumber) .. "," .. levelCommits .. "  ," .. levelID
  elseif levelID then
    s = sceneName .. "," .. tostring(themeID) .. "," .. tostring(fpsNumber) .. ", , " .. levelID
  else
    s = sceneName .. "," .. tostring(themeID) .. "," .. tostring(fpsNumber) .. ", , "
  end
  table.insert(self._logs, s)
  if EDITOR then
    self:AddStatsDataLog(sceneName, themeID)
  end
end

function PerformanceListenerServiceRender:AddStatsDataLog(sceneName, themeID)
  local levelCommits
  if not self._statsDataLogs then
    self._statsDataLogs = {
      "Scene,ThemeID,LevelID,DrawCalls,Batches,SetPassCalls,Triangles,Vertices"
    }
  end
  local levelID
  for k, v in pairs(Cfg.cfg_level()) do
    if v.Theme == themeID and v.comment then
      levelCommits = v.comment
      levelID = tostring(v.ID)
      break
    end
    if v.Theme == themeID and not v.comment then
      levelID = tostring(v.ID)
    end
  end
  local s
  if levelCommits then
    s = sceneName .. "," .. tostring(themeID) .. "," .. levelID .. "," .. UnityEditor.UnityStats.drawCalls .. "," .. UnityEditor.UnityStats.batches .. "," .. UnityEditor.UnityStats.setPassCalls .. "," .. UnityEditor.UnityStats.triangles .. "," .. UnityEditor.UnityStats.vertices
  elseif levelID then
    s = sceneName .. "," .. tostring(themeID) .. "," .. levelID .. "," .. UnityEditor.UnityStats.drawCalls .. "," .. UnityEditor.UnityStats.batches .. "," .. UnityEditor.UnityStats.setPassCalls .. "," .. UnityEditor.UnityStats.triangles .. "," .. UnityEditor.UnityStats.vertices
  else
    s = sceneName .. "," .. tostring(themeID) .. ", , " .. UnityEditor.UnityStats.drawCalls .. "," .. UnityEditor.UnityStats.batches .. "," .. UnityEditor.UnityStats.setPassCalls .. "," .. UnityEditor.UnityStats.triangles .. "," .. UnityEditor.UnityStats.vertices
  end
  table.insert(self._statsDataLogs, s)
end

function PerformanceListenerServiceRender:WriteLog()
  local dir = EngineGameHelper.StoragePath .. "PerformanceLog/"
  App.MakeDir(dir)
  local filePath = dir .. "CoreGameScenePerformanceLog" .. os.date("%y%m%d%H%M%S") .. ".csv"
  local file = io.open(filePath, "w")
  for i, log in ipairs(self._logs) do
    file:write(log)
    file:write("\n")
  end
  io.close(file)
end

function PerformanceListenerServiceRender:WriteStatsDataLog()
  local dir = EngineGameHelper.StoragePath .. "PerformanceLog/"
  App.MakeDir(dir)
  local filePath = dir .. "CoreGameSceneStatsDataLog" .. os.date("%y%m%d%H%M%S") .. ".csv"
  local file = io.open(filePath, "w")
  for i, log in ipairs(self._statsDataLogs) do
    file:write(log)
    file:write("\n")
  end
  io.close(file)
end

function PerformanceListenerServiceRender:_OnlyScene(TT)
  for k, v in pairs(Cfg.cfg_theme()) do
    if self._stopFlag then
      break
    end
    local themeID = v.ID
    if self:SwitchScene(TT, v.SceneResPath, themeID) then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateTestScenceInfo, v.SceneResPath, themeID)
      YIELD(TT, 6000)
    else
      Log.fatal("")
    end
  end
  self:WriteLog()
end

function PerformanceListenerServiceRender:AddTextureLog(scene, log)
  if self._textureLogs == nil then
    self._textureLogs = {}
  end
  if self._textureLogs[scene] == nil then
    self._textureLogs[scene] = {
      "图片纹理,使用占比,图片尺寸,材质,使用该图占比最大的物体"
    }
  end
  table.appendArray(self._textureLogs[scene], log)
end

function PerformanceListenerServiceRender:WriteTextureLog()
  local dir = EngineGameHelper.StoragePath .. "PerformanceLog/"
  App.MakeDir(dir)
  for sceneName, v in pairs(self._textureLogs) do
    local filePath = dir .. "SceneTextureLog_" .. sceneName .. "_" .. os.date("%y%m%d%H%M%S") .. ".csv"
    local file = io.open(filePath, "w")
    for i, log in ipairs(v) do
      file:write(log)
      file:write("\n")
    end
    io.close(file)
  end
end

function PerformanceListenerServiceRender:TexturePixelPercentageData(TT, scene)
  local sceneStats = SceneStats:New()
  local goScene = GameObjectHelper.Find("SceneRoot")
  if not goScene then
    YIELD(TT, 1000)
    goScene = GameObjectHelper.Find("SceneRoot")
  end
  if goScene then
    local meshRenderers = goScene:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
    if meshRenderers.Length > 0 then
      local log = sceneStats:OnGetTexturePixelPercentageDataCoroutine(TT, meshRenderers, true)
      self:AddTextureLog(scene, log)
    end
  end
end

function PerformanceListenerServiceRender:_SceneAndMonster(TT)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local resourceSvc = self._world:GetService("Resource")
  local entitySvc = self._world:GetService("LogicEntity")
  for k, v in pairs(Cfg.cfg_theme()) do
    if self._stopFlag then
      break
    end
    local themeID = v.ID
    local res = {}
    local resQ = {}
    for _, levelCfg in pairs(Cfg.cfg_level()) do
      if levelCfg.Theme == themeID then
        local bNext = false
        GameGlobal:GetInstance().gameLogic:LoadScene(TT, v.SceneResPath)
        local levelConfigData = self._configService:GetLevelConfigData()
        levelConfigData:ParseLevelConfig(levelCfg.ID)
        entitySvc:GenerateBoardData()
        local teamPos = levelConfigData:GetPlayerBornPos()
        local teamRotation = levelConfigData:GetPlayerBornRotation()
        local monsterRefreshParam = levelConfigData:GetLevelWaveBeginRefreshMonsterParam(1, teamPos)
        local createMonsterPosService = self._world:GetService("CreateMonsterPos")
        local monsterRefreshPosType = monsterRefreshParam:GetMonsterRefreshPosType()
        local monsterArray = createMonsterPosService:GetMonsterRefreshPos(monsterRefreshPosType, monsterRefreshParam)
        for _, monster in ipairs(monsterArray) do
          local monsterID = monster:GetMonsterID()
          local monsterPosition = monster:GetPosition()
          local dir = monster:GetForward()
          local resPath = monsterConfigData:GetMonsterResPath(monsterID)
          local request = resourceSvc:LoadGameObject(resPath)
          if request then
            local xOffset = monsterPosition.x - 1
            local zOffset = monsterPosition.y - 1
            local realPos = Vector3(-4, 0, -3) + Vector3(xOffset, 0, zOffset)
            local transform = request.Obj.transform
            table.insert(res, request.Obj)
            table.insert(resQ, request)
            local tf = transform
            tf.forward = Vector3(dir.x, 0, dir.y)
            tf.position = realPos
            tf.localScale = Vector3(1, 1, 1)
          else
            res = {}
            for _, req in pairs(resQ) do
              req:Dispose()
            end
            resQ = {}
            bNext = true
          end
        end
        if not bNext then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateTestScenceInfo, v.SceneResPath, themeID)
          local goEffRuchangActorpoint = UnityEngine.GameObject.Find(GameResourceConst.EffRuchangActorpoint)
          if goEffRuchangActorpoint then
            goEffRuchangActorpoint:SetActive(false)
          end
          self:SetCamera(themeID)
          YIELD(TT, 5000)
          res = {}
          for _, req in pairs(resQ) do
            req:Dispose()
          end
          break
        end
      end
    end
  end
  self:WriteLog()
end

function PerformanceListenerServiceRender:_TestScene(TT, testType)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TestSceneCloseButton, true)
  if testType == ScenePerfTestType.OnlySceneTheme then
    self:_OnlyScene(TT)
  end
  if testType == ScenePerfTestType.SceneAndMonster then
    self:_SceneAndMonster(TT)
  end
  if testType == ScenePerfTestType.SceneAndTexture then
    self:_SceneAndTexture(TT)
  end
  if testType == ScenePerfTestType.SceneAndStatsData then
    self:_SceneAndStatsData(TT)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TestSceneCloseButton, false)
end

function PerformanceListenerServiceRender:_SceneAndTexture(TT)
  if not EDITOR then
    Log.exception("只能在编辑器下使用")
    return
  end
  local count = 0
  for k, v in pairs(Cfg.cfg_theme()) do
    if self._stopFlag or 1 < count then
      break
    end
    local themeID = v.ID
    if self:SwitchScene(TT, v.SceneResPath, themeID) then
      if EDITOR then
        YIELD(TT, 1000)
        self:TexturePixelPercentageData(TT, v.SceneResPath)
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateTestScenceInfo, v.SceneResPath, themeID)
      YIELD(TT, 5000)
      Log.fatal("场景结束 ：", v.SceneResPath)
    else
      Log.fatal("场景加载失败 ：", v.SceneResPath)
    end
  end
  self:WriteLog()
  self:WriteTextureLog()
end

function PerformanceListenerServiceRender:_SceneAndStatsData(TT)
  for k, v in pairs(Cfg.cfg_theme()) do
    if self._stopFlag then
      break
    end
    local themeID = v.ID
    if self:SwitchScene(TT, v.SceneResPath, themeID) then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateTestScenceInfo, v.SceneResPath, themeID)
      YIELD(TT, 5000)
    end
  end
  self:WriteStatsDataLog()
end

function PerformanceListenerServiceRender:SwitchScene(TT, sceneName, themeID)
  local newScene = GameGlobal:GetInstance().gameLogic:LoadScene(TT, sceneName)
  if newScene then
    self._world:SetSceneGO(newScene)
    YIELD(TT, 100)
    local camera_cmpt = self._world:MainCamera()
    Log.fatal("LoadScene:", sceneName)
    local tt = UnityEngine.GameObject.FindGameObjectsWithTag("MainCamera")
    if tt.Length ~= 1 then
      camera_cmpt.camera = nil
      camera_cmpt._request = nil
      collectgarbage("collect")
      App.ClearMemory()
      collectgarbage("collect")
      App.ClearMemory()
      collectgarbage("collect")
      App.ClearMemory()
      YIELD(TT, 100)
    end
    local main_camera = camera_cmpt:Camera()
    YIELD(TT, 100)
    local goEffRuchangActorpoint = UnityEngine.GameObject.Find(GameResourceConst.EffRuchangActorpoint)
    if goEffRuchangActorpoint then
      goEffRuchangActorpoint:SetActive(false)
    end
    self:SetCamera(themeID)
    return true
  end
  Log.fatal("场景加载失败 :", sceneName)
  return false
end

function PerformanceListenerServiceRender:UISwitchScene(sceneName, themeID)
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    local bFind = false
    for k, v in pairs(Cfg.cfg_theme()) do
      if v.SceneResPath == sceneName then
        local cfgThemeID = v.ID
        self:SwitchScene(TT, sceneName, cfgThemeID)
        bFind = true
        break
      end
    end
    if not bFind then
      self:SwitchScene(TT, sceneName, themeID)
    end
  end)
end

function PerformanceListenerServiceRender:WriteMonsterStatData()
  local dir = EngineGameHelper.StoragePath .. "PerformanceLog/"
  App.MakeDir(dir)
  local filePath = dir .. "CoreGameMonsterStatsDataLog" .. os.date("%y%m%d%H%M%S") .. ".csv"
  local file = io.open(filePath, "w")
  for i, log in ipairs(self._monsterStatLog) do
    file:write(log)
    file:write("\n")
  end
  io.close(file)
  filePath = dir .. "CoreGameMonsterBonesLog" .. os.date("%y%m%d%H%M%S") .. ".csv"
  file = io.open(filePath, "w")
  for i, log in ipairs(self._monsterBonesLog) do
    file:write(log)
    file:write("\n")
  end
  io.close(file)
end

function PerformanceListenerServiceRender:UIPerfMonsterStat()
  self._monsterStatLog = {
    "PrefabName,MonsterID,DrawCalls,Batches,SetPassCalls,Triangles,Vertices,BonesCount"
  }
  self._monsterBonesLog = {
    "PrefabName,MonsterID,SkinName,BonesCount"
  }
  local eulerAnglesList = {
    Vector3(0, 0, 0),
    Vector3(0, 45, 0),
    Vector3(0, 90, 0),
    Vector3(0, 135, 0),
    Vector3(0, 180, 0),
    Vector3(0, 225, 0),
    Vector3(0, 270, 0),
    Vector3(0, 315, 0)
  }
  local prefabNameDic = {}
  local count = 1
  local mainCameraCmpt = self._world:MainCamera()
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    local sourceSkyBox = UnityEngine.RenderSettings.skybox
    UnityEngine.RenderSettings.skybox = nil
    local sceneRoot = UnityEngine.GameObject.Find("SceneRoot")
    local effectList = {}
    local effect = UnityEngine.GameObject.Find("Effect")
    while effect do
      effect:SetActive(false)
      table.insert(effectList, effect)
      effect = UnityEngine.GameObject.Find("Effect")
    end
    mainCameraCmpt._postProcessingCmpt.enabled = false
    sceneRoot:SetActive(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TestSceneCloseButton, true, true)
    YIELD(TT, 600)
    local sourceDrawCalls = UnityEditor.UnityStats.drawCalls
    local sourceBatches = UnityEditor.UnityStats.batches
    local sourceSetPassCall = UnityEditor.UnityStats.setPassCalls
    local sourceTriangles = UnityEditor.UnityStats.triangles
    local sourceVertices = UnityEditor.UnityStats.vertices
    Log.fatal("SourceDrawCalls：", sourceDrawCalls, "SourceBatches：", sourceBatches, "SourceSetPassCall：", sourceSetPassCall, "SourceTriangles：", sourceTriangles, "SourceVertices：", sourceVertices)
    for k, v in pairs(Cfg.cfg_monster_class()) do
      if self._stopFlag then
        break
      end
      local resName = v.ResPath
      local prefabName = string.sub(tostring(resName), 1, -8)
      local classID = v.ID
      if "empty.prefab" ~= resName then
        local request = UnityResourceService:GetInstance():LoadGameObject(resName)
        if request then
          local go = request.Obj
          if not prefabNameDic[prefabName] then
            local skinnedMeshRenderArray = go.transform:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
            local meshRenderers = skinnedMeshRenderArray:ToTable()
            local BonesCount = 0
            for i, meshRender in ipairs(meshRenderers) do
              local bonesArray = meshRender.bones
              local bones = bonesArray:ToTable()
              if 0 < #bones then
                if not meshRender.name then
                  Log.exception("meshRender.sharedMesh is nil ", v.ResPath)
                end
                local bonesLog = prefabName .. "," .. tostring(classID) .. "," .. meshRender.name .. "," .. tostring(#bones)
                table.insert(self._monsterBonesLog, bonesLog)
                BonesCount = BonesCount + #bones
              end
            end
            prefabNameDic[prefabName] = {}
            local curPrefabNameDic = prefabNameDic[prefabName]
            table.insert(curPrefabNameDic, v.ID)
            go.name = prefabName
            go.transform.position = Vector3(0, 0, -1)
            go.transform.localEulerAngles = Vector3(0, 135, 0)
            YIELD(TT)
            local dc = -1
            local log
            for _, eulerAngles in pairs(eulerAnglesList) do
              go.transform.localEulerAngles = eulerAngles
              YIELD(TT)
              if dc < UnityEditor.UnityStats.drawCalls then
                dc = UnityEditor.UnityStats.drawCalls
                local curDC = UnityEditor.UnityStats.drawCalls - sourceDrawCalls
                local curBT = UnityEditor.UnityStats.batches - sourceBatches
                local curSetPassCalls = UnityEditor.UnityStats.setPassCalls - sourceSetPassCall
                local curTri = UnityEditor.UnityStats.triangles - sourceTriangles
                local curVer = UnityEditor.UnityStats.vertices - sourceVertices
                if curDC < 0 or curBT < 0 or curSetPassCalls < 0 or curTri < 0 or curVer < 0 then
                  Log.fatal("")
                end
                log = prefabName .. "," .. tostring(classID) .. "," .. curDC .. "," .. curBT .. "," .. curSetPassCalls .. "," .. curTri .. "," .. curVer .. "," .. BonesCount
              end
            end
            table.insert(self._monsterStatLog, log)
          end
          YIELD(TT)
          collectgarbage("collect")
          App.ClearMemory()
          UnityEngine.Object.Destroy(go)
          YIELD(TT, 100)
        end
      end
    end
    mainCameraCmpt._postProcessingCmpt.enabled = true
    self:WriteMonsterStatData()
    sceneRoot:SetActive(true)
    for i, effect in ipairs(effectList) do
      effect:SetActive(true)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TestSceneCloseButton, false, false)
    if effect then
      effect:SetActive(true)
    end
    UnityEngine.RenderSettings.skybox = sourceSkyBox
  end)
end
