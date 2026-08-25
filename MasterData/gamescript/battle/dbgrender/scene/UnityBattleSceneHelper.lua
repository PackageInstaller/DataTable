local TimelineAltBindingScheme = CS.Z1Client.TimelineAltBindingScheme
local TypeOfCamera = typeof(CS.UnityEngine.Camera)
local TypeGloab_SceneBlur = typeof(CS.Z1Client.Gloab_SceneBlur)
local TypfOfFollowTargetComp = typeof(CS.AMFollowTarget)
local _GetPos = CS.Framework.TransformUtil.GetPos
local T_Renderer = typeof(CS.UnityEngine.Renderer)
local AMResourcesCache = CS.AMTimeline.AMResourcesCache
local defaultVCamName = "Main"
local T_CinemachineVirtualCamera = CS.Cinemachine and CS.Cinemachine.CinemachineVirtualCamera and typeof(CS.Cinemachine.CinemachineVirtualCamera) or nil
local UnityBattleSceneHelper, Super = System.NewClass("UnityBattleSceneHelper", UnitySceneHelper)

function UnityBattleSceneHelper:ctor(battleScene, assetPath)
  self.battleScene = battleScene
  self.battleId = battleScene.battleId
  self.battleCfg = battleScene.battleCfg
  self.battleSceneCfg = battleScene.battleSceneCfg
  self.mainCamera = CS.UnityEngine.GameObject.Find("Main Camera")
  Super.ctor(self, assetPath)
end

function UnityBattleSceneHelper:BindToBattleScene()
  self:SetupGlobalMaterials()
  self:SetupSpawnPoints()
  self:SetupAttachPoints()
  self:SetupLightNodes()
  self:SetupGlobalBlur()
  self:SetupVirtualCamerasConfig()
  self:SyncToBattleScene()
  self:CalCameraDistForFog()
end

function UnityBattleSceneHelper:ShowScene(showed)
  local isHided = self.curBattleSceneStatus and self.curBattleSceneStatus.isHided or false
  showed = showed and not isHided
  if not IsNil(self.sceneRootNode) then
    self.sceneRootNode:SetActive(showed)
  end
  if not IsNil(self.sceneEffectsNode) then
    self.sceneEffectsNode:SetActive(showed)
  end
end

function UnityBattleSceneHelper:HideSceneEffects()
  if not IsNil(self.sceneEffectsNode) then
    self.sceneEffectsNode:SetActive(false)
  end
end

function UnityBattleSceneHelper:SetupRootGameObjects()
  Super.SetupRootGameObjects(self)
  self.sceneRootNode = self:Find("Scenes")
  self.virtualCameraRoot = self:Find("CM")
  self.cameraNode = self:Find("Camera")
  self.sceneEffectsNode = self:Find("SceneEffects")
  if self.cameraNode then
    self.sceneCamera = self.cameraNode:GetComponent(TypeOfCamera)
  end
  self._sceneRenderers = self.sceneRootNode.gameObject:GetComponentsInChildren(T_Renderer)
  if self.sceneEffectsNode then
    local followTargetComp = self.sceneEffectsNode:GetComponent(TypfOfFollowTargetComp)
    followTargetComp = followTargetComp or self.sceneEffectsNode:AddComponent(TypfOfFollowTargetComp)
    followTargetComp:Begin(self.sceneRootNode.gameObject, CS.UnityEngine.Vector3.zero, true, true, false, false)
    followTargetComp:AttachGameObjectToTarget()
    if self.battleSceneCfg.BattleSceneSfx then
      for _, fxName in ipairs(self.battleSceneCfg.BattleSceneSfx) do
        local fxNode = self.sceneEffectsNode.transform:Find(fxName)
        if fxNode then
          fxNode.gameObject:SetActive(true)
        end
      end
    end
  end
end

function UnityBattleSceneHelper:SetupGlobalMaterials()
  self.initAmbientColor = CS.UnityEngine.RenderSettings.ambientLight
  self.initFogColor = CS.UnityEngine.RenderSettings.fogColor
  self.isLightOn = true
  CS.UnityEngine.Shader.SetGlobalFloat("Power", 0)
  CS.UnityEngine.Shader.SetGlobalFloat("AllAlpha", 0.6)
  CS.UnityEngine.Shader.SetGlobalFloat("UltiSceneProgress", 0)
  CS.UnityEngine.Shader.SetGlobalFloat("UltiCharacterProgress", 0)
end

function UnityBattleSceneHelper:SetupSpawnPoints()
  self.spawnPointRootNode = self:Find("SpawnPoints")
  self.playerSpawnPoints = self.spawnPointRootNode.transform:Find("Player")
  self.monsterSpawnPoints = self.spawnPointRootNode.transform:Find("Monster")
  self.tentacleSpawnPoints = self.spawnPointRootNode.transform:Find("tancle")
  self.needReflect = self:Find("NeedReflect")
  self.spawnPointMap = {}
  self.spawnPointMap[bc.BattleCamp.Camp1] = self:SearchSpawnPoints(self.playerSpawnPoints)
  self.spawnPointMap[bc.BattleCamp.Camp2] = self:SearchSpawnPoints(self.monsterSpawnPoints)
  self.tentaclePoints = self:SearchSpawnPoints(self.tentacleSpawnPoints)
  self:SortSpawnPoints()
end

function UnityBattleSceneHelper:SearchSpawnPoints(root)
  local holder = {}
  local pointCount = root.childCount
  local isOld = false
  local playerSpawnPoints = self.playerSpawnPoints
  local firstPlayerPoint = playerSpawnPoints:GetChild(0)
  if firstPlayerPoint.name == "Point" then
    isOld = true
  end
  for i = 0, pointCount - 1 do
    local transform = root:GetChild(i)
    if isOld then
      holder[i + 1] = transform
    else
      local name = transform.name
      local id = string.match(name, "-?%d+")
      id = tonumber(id)
      if id then
        holder[id] = root:GetChild(i)
      end
    end
  end
  return holder
end

function UnityBattleSceneHelper:SortSpawnPoints()
  local spawnPoints = {
    [bc.BattleCamp.Camp1] = {},
    [bc.BattleCamp.Camp2] = {}
  }
  for camp, campPoinMap in pairs(self.spawnPointMap) do
    for _, point in pairs(campPoinMap or {}) do
      table.insert(spawnPoints[camp], {
        point = point,
        z = point.position.z
      })
    end
  end
  self.spawnPointToOrder = {
    [bc.BattleCamp.Camp1] = {},
    [bc.BattleCamp.Camp2] = {}
  }
  for _, camp in ipairs({
    bc.BattleCamp.Camp1,
    bc.BattleCamp.Camp2
  }) do
    table.sort(spawnPoints[camp], function(a, b)
      return a.z > b.z
    end)
    for index, info in ipairs(spawnPoints[camp]) do
      self.spawnPointToOrder[camp][info.point] = math.abs(index) * 100
    end
  end
end

function UnityBattleSceneHelper:SetupAttachPoints()
  self.camp1SfxPoint = self.spawnPointRootNode.transform:Find("Sfx1")
  self.camp2SfxPoint = self.spawnPointRootNode.transform:Find("Sfx2")
  local centerPoint = self.spawnPointRootNode.transform:Find("Center")
  local monsterCenter = self.spawnPointRootNode.transform:Find("MonsterCenter")
  if centerPoint then
    self.centerPosition = centerPoint.position
  end
  if monsterCenter then
    self.monsterCenterPosition = monsterCenter.position
  end
  AMResourcesCache.RemoveGameObject("SpawnPoints")
  AMResourcesCache.AddGameObject("SpawnPoints", self.spawnPointRootNode.gameObject)
  if self.camp1SfxPoint then
    AMResourcesCache.RemoveGameObject("SpawnPoints/Sfx1")
    AMResourcesCache.AddGameObject("SpawnPoints/Sfx1", self.camp1SfxPoint.gameObject)
  end
  if self.camp2SfxPoint then
    AMResourcesCache.RemoveGameObject("SpawnPoints/Sfx2")
    AMResourcesCache.AddGameObject("SpawnPoints/Sfx2", self.camp2SfxPoint.gameObject)
  end
end

function UnityBattleSceneHelper:SetupLightNodes()
  self.lightRootNode = self:Find("Light")
  if self.lightRootNode then
    local dirLightNode = self.lightRootNode.transform:Find("Directional Light")
    if dirLightNode then
      self.dirLight = dirLightNode:GetComponent(typeof(CS.UnityEngine.Light))
    end
  end
end

function UnityBattleSceneHelper:SetupGlobalBlur()
  AMResourcesCache.RemoveGameObject("Gloab_SceneBlur")
  self.globalBlur = self:Find("Gloab_SceneBlur")
  AMResourcesCache.AddGameObject("Gloab_SceneBlur", self.globalBlur)
  if self.globalBlur then
    local globalBlurComp = self.globalBlur:GetComponent(TypeGloab_SceneBlur)
    if globalBlurComp then
      globalBlurComp.Blur = 0
    end
  end
end

function UnityBattleSceneHelper:GetMainVirtalCamera()
  local vCam = self.virtualCameraRoot.transform:Find(self.currBattleVCamName)
  if vCam then
    return vCam.gameObject
  end
end

function UnityBattleSceneHelper:SetupVirtualCamerasConfig()
  self.currBattleVCamName = self:GetVCamName(self.battleScene, self.battleCfg)
  self.vCamDict = {}
  local mainVM = self:GetMainVirtalCamera()
  local excludeSet = {Timeline = true}
  if T_CinemachineVirtualCamera and self.virtualCameraRoot then
    local rootGo = self.virtualCameraRoot.gameObject
    local vCamComps = rootGo:GetComponentsInChildren(T_CinemachineVirtualCamera, true)
    for i = 0, vCamComps.Length - 1 do
      local comp = vCamComps[i]
      local go = comp.gameObject
      local name = go.name
      if not excludeSet[name] then
        AMResourcesCache.RemoveGameObject("CM/" .. name)
        AMResourcesCache.AddGameObject("CM/" .. name, go)
        self.vCamDict[name] = go
        go:SetActive(name == self.currBattleVCamName)
      end
    end
  else
    local rootTrans = self.virtualCameraRoot.transform
    for i = 0, rootTrans.childCount - 1 do
      local vCam = rootTrans:GetChild(i)
      local go = vCam.gameObject
      local name = go.name
      if not excludeSet[name] then
        AMResourcesCache.RemoveGameObject("CM/" .. name)
        AMResourcesCache.AddGameObject("CM/" .. name, go)
        self.vCamDict[name] = go
        go:SetActive(name == self.currBattleVCamName)
      end
    end
  end
  for name1, vCam1 in pairs(self.vCamDict) do
    TimelineAltBindingScheme.Unregister(vCam1)
    for name2, vCam2 in pairs(self.vCamDict) do
      if name2 ~= name1 then
        TimelineAltBindingScheme.Register(vCam1, name2, vCam2)
      end
    end
  end
  AMResourcesCache.RemoveGameObject("CM")
  AMResourcesCache.AddGameObject("CM", self.virtualCameraRoot.gameObject)
  AMResourcesCache.RemoveGameObject("Main Camera")
  AMResourcesCache.AddGameObject("Main Camera", self.mainCamera)
  self:SwitchMainVirtualCamera(mainVM)
end

function UnityBattleSceneHelper:SwitchMainVirtualCamera(mainVM)
  if self.mainVM then
    self.mainVM.gameObject:SetActive(false)
  end
  self.mainVM = mainVM
  if self.mainVM then
    self.mainVM.gameObject:SetActive(true)
  end
  self:SetupCameraInitPose(mainVM)
  AMResourcesCache.RemoveGameObject("CameraInitPose")
  AMResourcesCache.RemoveGameObject("CameraOriginPose")
  AMResourcesCache.RemoveGameObject("CameraOriginPosAndRot")
  AMResourcesCache.AddGameObject("CameraInitPose", self.cameraInitPoseNode.gameObject)
  AMResourcesCache.AddGameObject("CameraOriginPose", self.cameraOriginPose.gameObject)
  AMResourcesCache.AddGameObject("CameraOriginPosAndRot", self.cameraOriginPosAndRot.gameObject)
  if self.cameraComp then
    self.cameraComp:Dispose()
    self.cameraComp = nil
  end
  self.cameraComp = BattleCameraComponent(bg.mainCamera, mainVM)
  self.cameraComp:InitCamera(self.sceneCamera.transform, self.virtualCameraRoot.transform)
  EventMgr.Instance.BattleCameraChange:Dispatch()
end

function UnityBattleSceneHelper:IsCameraValid(cameraName)
  if not self.virtualCameraRoot or IsNil(self.virtualCameraRoot) then
    return
  end
  if self.vCamDict and self.vCamDict[cameraName] or self.virtualCameraRoot.transform:Find(cameraName) then
    return true
  end
end

function UnityBattleSceneHelper:ChangeDefaultCamera()
  local cur = self.currBattleVCamName
  local newCamName = self:GetVCamName(self.battleScene, self.battleCfg)
  if cur == newCamName then
    return
  end
  local vCam = self.virtualCameraRoot.transform:Find(newCamName)
  if not vCam then
    return
  end
  self.currBattleVCamName = newCamName
  self:SwitchMainVirtualCamera(vCam.gameObject)
  self:SyncToBattleScene()
end

function UnityBattleSceneHelper:GetVCamName(battleScene, battleConfig)
  if battleScene.battleCameraScheme and self:IsCameraValid(battleScene.battleCameraScheme) then
    return battleScene.battleCameraScheme
  end
  local savedCam = BattleCameraDataUtils.GetSavedCameraName(self)
  if savedCam and self:IsCameraValid(savedCam) then
    return savedCam
  end
  local vCamName = battleConfig.VirtualCamera
  if not vCamName or "" == vCamName or not self:IsCameraValid(vCamName) then
    vCamName = defaultVCamName
  end
  return vCamName
end

function UnityBattleSceneHelper:SyncToBattleScene()
  self.battleScene.camp1SfxPoint = self.camp1SfxPoint
  self.battleScene.camp2SfxPoint = self.camp2SfxPoint
  self.battleScene.spawnPointMap = self.spawnPointMap
  self.battleScene.tentaclePoints = self.tentaclePoints
  self.battleScene.sceneCamera = self.sceneCamera
  self.battleScene.virtualCameraRoot = self.virtualCameraRoot
  self.battleScene.lightRootNode = self.lightRootNode
  self.battleScene.dirLight = self.dirLight
  self.battleScene.sceneRootNode = self.sceneRootNode
  self.battleScene.centerPosition = self.centerPosition
  self.battleScene.monsterCenterPosition = self.monsterCenterPosition
  self.battleScene.spawnPointToOrder = self.spawnPointToOrder
  self.battleScene.cameraComp = self.cameraComp
  self.battleScene.mainVM = self.mainVM
  self.battleScene.cameraInitPoseNode = self.cameraInitPoseNode
  self.battleScene.cameraOriginPose = self.cameraOriginPose
  self.battleScene.cameraOriginPosAndRot = self.cameraOriginPosAndRot
  self.battleScene.needReflect = self.needReflect
end

function UnityBattleSceneHelper:ApplyMianCameraToCMVMainPose(mainCamera)
  if self.mainVM then
    self.mainVM.transform.position = mainCamera.transform.position
    self.mainVM.transform.eulerAngles = mainCamera.transform.eulerAngles
    self.mainVM.transform.localScale = mainCamera.transform.lossyScale
  end
end

function UnityBattleSceneHelper:SetupCameraInitPose(mainVM)
  if mainVM then
    AMResourcesCache.RemoveGameObject("CM/Main")
    AMResourcesCache.RemoveGameObject("CM/PVPMain")
    AMResourcesCache.AddGameObject("CM/Main", mainVM)
    AMResourcesCache.AddGameObject("CM/PVPMain", mainVM)
  end
  if not self.cameraInitPoseNode then
    self.cameraInitPoseNode = CS.UnityEngine.GameObject("CameraInitPose")
    CS.AMTimeline.AMDontDestroyOnLoad.Get(self.cameraInitPoseNode)
  end
  self.cameraInitPoseNode.transform.position = mainVM.transform.position
  self.cameraInitPoseNode.transform.eulerAngles = mainVM.transform.eulerAngles
  self.cameraInitPoseNode.transform.localScale = mainVM.transform.lossyScale
  if not self.cameraOriginPose then
    self.cameraOriginPose = CS.UnityEngine.GameObject("CameraOriginPose")
    CS.AMTimeline.AMDontDestroyOnLoad.Get(self.cameraOriginPose)
  end
  self.cameraOriginPose.transform.position = mainVM.transform.position
  self.cameraOriginPose.transform.eulerAngles = CS.UnityEngine.Vector3.zero
  self.cameraOriginPose.transform.localScale = mainVM.transform.lossyScale
  if not self.cameraOriginPosAndRot then
    self.cameraOriginPosAndRot = CS.UnityEngine.GameObject("CameraOriginPosAndRot")
    CS.AMTimeline.AMDontDestroyOnLoad.Get(self.cameraOriginPosAndRot)
  end
  self.cameraOriginPosAndRot.transform.position = mainVM.transform.position
  self.cameraOriginPosAndRot.transform.eulerAngles = mainVM.transform.eulerAngles
  self.cameraOriginPosAndRot.transform.localScale = mainVM.transform.lossyScale
end

function UnityBattleSceneHelper:EnableApplyDepthFog(enbale)
  if self._isApplyDepthFogEnable == enbale then
    return
  end
  self._isApplyDepthFogEnable = enbale
  local sceneRenderers = self._sceneRenderers
  for i = 0, sceneRenderers.Length - 1 do
    local materials = sceneRenderers[i].materials
    if materials then
      for j = 0, materials.Length - 1 do
        if enbale then
          materials[j]:EnableKeyword("_ENABLEULTISKILLSHADOW_ON")
        else
          materials[j]:DisableKeyword("_ENABLEULTISKILLSHADOW_ON")
        end
      end
    end
  end
end

function UnityBattleSceneHelper:CalCameraDistForFog()
  local sceneRenderers = self._sceneRenderers
  local fastestDist = 0
  for i = 0, sceneRenderers.Length - 1 do
    local _, _, z = _GetPos(sceneRenderers[i].transform, nil, nil, nil)
    if fastestDist < z then
      fastestDist = z
    end
  end
  local _, _, camPosZ = _GetPos(self.mainCamera.transform, nil, nil, nil)
  local sceneZLength = math.max(math.abs(camPosZ * 2), math.abs(fastestDist - camPosZ))
  CS.UnityEngine.Shader.SetGlobalFloat("ZDistance", sceneZLength)
end

function UnityBattleSceneHelper:UnloadScene()
  if not IsNil(self.virtualCameraRoot) then
    self.virtualCameraRoot:SetActive(false)
  end
  if self.vCamDict then
    for _, vCam in pairs(self.vCamDict) do
      TimelineAltBindingScheme.Unregister(vCam)
    end
  end
  if self.cameraInitPoseNode then
    CS.UnityEngine.GameObject.Destroy(self.cameraInitPoseNode)
    self.cameraInitPoseNode = nil
  end
  if self.cameraOriginPosAndRot then
    CS.UnityEngine.GameObject.Destroy(self.cameraOriginPosAndRot)
    self.cameraOriginPosAndRot = nil
  end
  if self.cameraOriginPose then
    CS.UnityEngine.GameObject.Destroy(self.cameraOriginPose)
    self.cameraOriginPose = nil
  end
  if self.cameraComp then
    self.cameraComp:Dispose()
    self.cameraComp = nil
  end
  Super.UnloadScene(self)
  self.mainCamera = nil
  self.sceneRootNode = nil
  self.virtualCameraRoot = nil
  self.cameraNode = nil
  self.sceneEffectsNode = nil
  self.sceneCamera = nil
  self._sceneRenderers = nil
  self.spawnPointRootNode = nil
  self.playerSpawnPoints = nil
  self.monsterSpawnPoints = nil
  self.tentacleSpawnPoints = nil
  self.camp1SfxPoint = nil
  self.camp2SfxPoint = nil
  self.lightRootNode = nil
  self.dirLight = nil
  self.globalBlur = nil
  self.needReflect = nil
  self.mainVM = nil
  self.vCamDict = nil
  self.initAmbientColor = nil
  self.initFogColor = nil
  self.battleScene = nil
end

return UnityBattleSceneHelper
