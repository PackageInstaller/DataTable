local DOTween = CS.DG.Tweening.DOTween
local TypeTimelineController = typeof(CS.Z1Client.TimelineController)
local TypeVolume = typeof(CS.UnityEngine.Rendering.Volume)
local TypeUniversalAdditionalCameraData = typeof(CS.UnityEngine.Rendering.Universal.UniversalAdditionalCameraData)
local MapArtEffectManager, Super = System.NewClass("MapArtEffectManager", Manager)

function MapArtEffectManager:ctor()
  Super.ctor(self)
end

function MapArtEffectManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
  self.rtCamera = CS.UnityEngine.GameObject.Find("RTCamera")
  self.artMask = self.parent.rootNode.transform:Find("fogMask/Ground/Ground_Fog"):GetComponent(typeof(CS.UnityEngine.MeshRenderer))
  self.artMat = self.artMask.material
  self.artTextureB = self.artMat:GetTexture("_MainMapB")
  local bgNode = self.parent.bgNode.transform
  self.volume = bgNode:Find("Volume"):GetComponent(TypeVolume)
  self.enterTimeline = bgNode:Find("EnterTimeline").gameObject
  self.triggerTimeline = bgNode:Find("TriggerTimeline").gameObject
  self.cinemachine = bgNode:Find("CinimationB").gameObject
  self.openingMistItems = {}
  if self.rtCamera then
    local cameraData = self.rtCamera:GetComponent(TypeUniversalAdditionalCameraData)
    if cameraData then
      cameraData.requiresDepthTexture = false
      cameraData.requiresColorOption = 0
    end
  end
end

function MapArtEffectManager:OnDestroy()
  Super.OnDestroy(self)
  self.rtCamera = nil
  DOTweenUtils.KillAllTweensByTarget(self)
  self.openingTexture = nil
  ResLoadMgr.UnloadAssetByTarget(self)
end

function MapArtEffectManager:ResetAtmosphere()
  local lerpValue = 0
  if self.parent.owner:HasShadowEffect() then
    lerpValue = 1
  end
  self.artMat:SetFloat("_Lerp", lerpValue)
end

function MapArtEffectManager:ChangeAtmosphere(changeTime, callback)
  AvgStoryManager.Instance:WaitStoryFinish(nil, function()
    self:_ChangeAtmosphere(changeTime, callback)
  end)
end

function MapArtEffectManager:_ChangeAtmosphere(changeTime, callback)
  if self.parent.owner then
    self.parent.owner:SetShadowEffect()
  end
  local lerpValue = self.artMat:GetFloat("_Lerp")
  if lerpValue > 0.9 then
    if callback then
      callback()
    end
    return
  end
  changeTime = tonumber(changeTime) or 4
  local role = self:GetComponent(MapRoleManager):GetRole()
  if role then
    local light = role:GetLight()
    local color = ColorUtils.ParseHtmlStringToUnityColor("#CBE3FFFF")
    light:DOColor(color, changeTime)
  end
  if self.triggerTimeline then
    local mainCamera = UIRootMgr.GetMainCamera()
    local brain = mainCamera:GetComponent(typeof(CS.Cinemachine.CinemachineBrain))
    brain:ManualUpdate()
    self.cinemachine.transform.position = mainCamera.gameObject.transform.position
    self.triggerTimeline:SetActive(true)
    local component = self.triggerTimeline:GetComponent(TypeTimelineController)
    component:Play(function()
      self.cinemachine:SetActive(false)
      self.triggerTimeline:SetActive(false)
      if callback then
        callback()
      end
    end)
    local eventName = string.format("LIGHTEFFECT_%s", PathStrUtils.GetBaseName(self.parent.scenePath))
    eventName = string.upper(eventName)
    if not AudioManager.Instance:HasSoundEvent(eventName) then
      eventName = "LIGHTEFFECT_DEFAULT"
    end
    AudioManager.Instance:PostSoundEvent(eventName)
  end
end

function MapArtEffectManager:SetDepthOfFieldState(state)
  local effect = self:GetVolumeEffect("DepthOfField")
  if effect then
    effect.active = state
  else
    Logger.Warn("Effects is error")
  end
end

function MapArtEffectManager:GetVolumeEffect(effectName)
  local volume = self.volume
  local profile = volume.profile
  local effect
  if "Bloom" == effectName then
    effect = CS.Framework.UIUtilTool.GetBloom(profile)
  elseif "Vignette" == effectName then
    effect = CS.Framework.UIUtilTool.GetVignette(profile)
  elseif "DepthOfField" == effectName then
    effect = CS.Framework.UIUtilTool.GetDepthOfField(profile)
  end
  return effect
end

function MapArtEffectManager:PlayStageEnterAnim(callBack)
  self.cinemachine:SetActive(true)
  self.enterTimeline:SetActive(true)
  local component = self.enterTimeline:GetComponent(TypeTimelineController)
  component:Play(function()
    self.cinemachine:SetActive(false)
    self.enterTimeline:SetActive(false)
    if self:IsOneLineMap() then
      self.cinemachine:SetActive(true)
    end
    self.artMat:SetTexture("_MainMapB", self.artTextureB)
    if callBack then
      callBack()
    end
  end)
  if not self.openingTexture then
    local texturePath = self.parent:GetSceneOpeningTexturePath()
    self.openingTexture = ResLoadMgr.LoadAsset(texturePath, self, typeof(CS.UnityEngine.Texture))
    print("openingTexturePath:", texturePath)
    if not self.openingTexture then
      Logger.Error("找不到Opening贴图 " .. texturePath)
      texturePath = "Scenebg/MSceneBg/MScene_002_GroundIn"
      self.openingTexture = ResLoadMgr.LoadAsset(texturePath, self, typeof(CS.UnityEngine.Texture))
    end
  end
  self.artMat:SetTexture("_MainMapB", self.openingTexture)
end

function MapArtEffectManager:PlayOnEnter(posX, posY, lv, role, startTime, interTime, callBack)
  self.binder:BindTimer(startTime, 0, nil, function()
    if not WorldRecoveryManager.Instance:IsRecovery() then
      role.go:SetActive(true)
      role:PlayAnim("Base.OpenShow")
    end
    self:PlayOpenMist(posX, posY, lv)
    self:PlayGridAnimAfterMove(posX, posY, posX, posY, lv, 0, 0, interTime, callBack)
  end)
end

function MapArtEffectManager:IsOneLineMap()
  do return self.parent.IsOneLineMap end
  return self.parent.IsOneLineMap, self.parent
end

function MapArtEffectManager:PlayOpenMistAndGridAnim(oldPosX, oldPosY, newPosX, newPosY, callBack, lv, mistTime, sinkTime, upTime, interTime)
  local mapEntity = self.parent
  if not mapEntity.isShow then
    mapEntity:SetRefreshMistAfterShowMap(true)
    return
  end
  lv = lv or mapEntity.roleFOV
  mistTime = mistTime or mapEntity:GetMistOpenTime()
  upTime = upTime or mapEntity:GetGridUpTime()
  interTime = interTime or mapEntity:GetGapTime()
  sinkTime = sinkTime or mapEntity:GetSinkTime()
  self.binder:BindTimer(mistTime, 1, function()
    self:PlayOpenMist(newPosX, newPosY, lv)
  end)
  self:PlayGridAnimAfterMove(oldPosX, oldPosY, newPosX, newPosY, lv, sinkTime, upTime, interTime, function()
    if callBack then
      callBack()
    end
  end)
end

function MapArtEffectManager:PlayGridAnimAfterMove(oldPosX, oldPosY, newPosX, newPosY, lv, sinkTime, upTime, interTime, callBack)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  local gearMgr = self:GetComponent(MapGearManager)
  local roleMgr = self:GetComponent(MapRoleManager)
  local upAndSinkGrids = terrainMgr:GetUpAndSinkGrid(oldPosX, oldPosY, newPosX, newPosY)
  local sequence = DOTween.Sequence(self)
  local sink = upAndSinkGrids.sink or {}
  local up = upAndSinkGrids.up or {}
  local newGrid = gearMgr:GetGearByPos(newPosX, newPosY)
  if newGrid and newGrid:GetType() == CommonDefine.GearItemType.DropTerrain then
    AudioManager.Instance:PostSoundEvent("SFX_EXP_BLOCK_CRACK_ENTER")
    local oldx, oldy = roleMgr:GetRole():GetPrevPos()
    local oldIdx = self.parent:GetIdxByPos(oldx, oldy)
    for i, terrainIdx in ipairs(up or {}) do
      if terrainIdx == oldIdx then
        table.remove(up, i)
        table.insert(sink, terrainIdx)
        break
      end
    end
  end
  if #sink > 0 then
    sequence:InsertCallback(sinkTime, function()
      self:PlayGridSink(terrainMgr, sink)
      self:PlayGearDown(sink)
    end)
  end
  sequence:InsertCallback(upTime, function()
    self:PlayGridUp(terrainMgr, up, upAndSinkGrids.curIdx)
    self:PlayGearUp(up)
  end)
  upTime = upTime + interTime
  sequence:InsertCallback(upTime, function()
    self:PlayGridHalfUp(newPosX, newPosY, lv)
  end)
  if callBack then
    sequence:OnComplete(callBack)
  end
end

function MapArtEffectManager:PlayBattleNearDown(oldPosX, oldPosY, newPosX, newPosY)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  local upAndSinkGrids = terrainMgr:GetUpAndSinkGrid(oldPosX, oldPosY, newPosX, newPosY)
  local sequence = DOTween.Sequence(self)
  local sink = upAndSinkGrids.sink
  local sinkTime = self.parent:GetSinkTime()
  if upAndSinkGrids.sink then
    sequence:InsertCallback(sinkTime, function()
      self:PlayGridSink(terrainMgr, sink)
      self:PlayGearDown(sink)
    end)
  end
end

function MapArtEffectManager:PlayOpenMist(posX, posY, lv)
  local mistComp = self:GetComponent(MapMistManager)
  self:EnableCamera(true)
  mistComp:OpenMist(posX, posY, lv, false)
end

function MapArtEffectManager:PlayGridUp(terrainMgr, grids, curIdx)
  if nil == grids then
    return
  end
  terrainMgr:PlayGridUp(grids)
  terrainMgr:PlayGridUpNoOutline(curIdx)
end

function MapArtEffectManager:PlayGridSink(terrainMgr, grids)
  if nil == grids then
    return
  end
  terrainMgr:PlayGridSink(grids)
end

function MapArtEffectManager:PlayGridHalfUp(posX, posY, lv)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  local grids = terrainMgr:GetUpHalfGrid(posX, posY, lv)
  for k, v in pairs(grids) do
    for _, idx in pairs(v) do
      local grid = terrainMgr:GetTerrainByIdx(idx)
      grid:PlayAnim("Up-Y-A", false)
    end
  end
end

function MapArtEffectManager:PlayGearUp(grids)
  local gearMgr = self:GetComponent(MapGearManager)
  for _, v in pairs(grids) do
    local gear = gearMgr:GetGearByIdx(v)
    if gear then
      gear:PlayUp()
    end
  end
end

function MapArtEffectManager:SetOpeningMistItem(mapItem, isOpening)
  self.openingMistItems[mapItem] = isOpening or nil
  local hasOpeningItem = table.next(self.openingMistItems) ~= nil
  self:EnableCamera(hasOpeningItem)
end

function MapArtEffectManager:EnableCamera(enable)
  if self.rtCamera then
    self.rtCamera:SetActive(enable)
  end
end

function MapArtEffectManager:PlayGearDown(grids)
  local gearMgr = self:GetComponent(MapGearManager)
  for _, v in pairs(grids) do
    local gear = gearMgr:GetGearByIdx(v)
    if gear then
      gear:PlayDown()
    end
  end
end

return MapArtEffectManager
