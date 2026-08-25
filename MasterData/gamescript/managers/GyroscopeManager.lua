local CsTexture2D = typeof(CS.UnityEngine.Texture2D)
local Vector3_One = CS.UnityEngine.Vector3.one
local Vector3_NewBG = CS.UnityEngine.Vector3(0.89, 0.89, 1)
local GyroscopeManager, Super = System.NewClass("GyroscopeManager", Manager)

function GyroscopeManager:ctor()
  Super.ctor(self)
end

function GyroscopeManager:Awake(binder)
  Super.Awake(self)
  self.cameraComp = nil
  self.gyroscope = nil
  self.bgComp = nil
  self.topUrl = nil
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.InsertFullScreenPanel, System.fn(self, self.FullScreenChangeFunc))
  binder:BindEvent(EventMgr.Instance.RemoveFullScreenPanel, System.fn(self, self.FullScreenChangeFunc))
  binder:BindEvent(EventMgr.Instance.OnExitScene, function()
    self.topUrl = nil
  end)
  binder:BindEvent(EventMgr.Instance.ChangeScene, function(sceneType)
    if sceneType ~= CommonDefine.SceneType.Town then
      self:DisableGyroscope()
    end
  end)
end

function GyroscopeManager:FullScreenChangeFunc()
  local topUrl = UIManager.Instance:GetTopFullScreenPanel()
  if not self.topUrl or self.topUrl ~= topUrl then
    self.topUrl = topUrl
    local sceneType = SceneMgr.Instance:GetSceneType()
    if sceneType ~= cd.SceneType.Town and sceneType ~= cd.SceneType.Null then
      self:DisableGyroscope()
      return
    end
    if not self:GetGyroscopeSettingByUrl(topUrl) then
      return
    end
    self:EnableGyroscope(topUrl)
  end
end

function GyroscopeManager:EnableGyroscope(url)
  self:DisableGyroscope()
  self:InitCamera()
  self:InitGyroscope(url)
  self:InitBg(url)
  local panel = UIManager.Instance:GetWindow(url)
  if panel and panel.RefreshGyroscopeBg then
    panel:RefreshGyroscopeBg()
  end
end

function GyroscopeManager:InitCamera()
  self.cameraComp = CS.UnityEngine.GameObject.Find("Main Camera")
  if not self.cameraComp then
    return
  end
end

function GyroscopeManager:InitCameraPos()
  if not self.cameraComp then
    return
  end
  CS.Framework.TransformUtil.SetPos(self.cameraComp.transform, 0, 0, 0)
  CS.Framework.TransformUtil.SetLocalEulerAngles(self.cameraComp.transform, 0, 0, 0)
end

function GyroscopeManager:InitGyroscope(url)
  self.gyroscope = self.cameraComp:GetComponent(typeof(CS.Z1Client.Gyroscope))
  if not self.gyroscope then
    return
  end
  self:SwitchGyroscope(true)
  self:SetGyroscopeByUrl(url)
end

function GyroscopeManager:SwitchGyroscope(boolVal, needResetCamera)
  if self.gyroscope then
    if true == boolVal then
      boolVal = SettingManager:GetBoolSettingData(CommonDefine.SettingUniqueName.GyroscopeSwitch)
    elseif needResetCamera then
      self:InitCameraPos()
    end
    self.gyroscope.enabled = boolVal
  end
end

function GyroscopeManager:InitBg(url)
  local prefabPath = self:GetGyroscopeBgByUrl(url)
  if url == Urls.MainPanel and ArtCollectionModel.Instance:GetBgActivityDefine() then
    return
  end
  self:ChangeBg(prefabPath)
end

function GyroscopeManager:ChangeBg(prefabPath, isUseTween)
  local preBgComp = self.bgComp
  if not isUseTween then
    self:DestroyBg()
  end
  if prefabPath then
    local prefab = ResLoadMgr.LoadAsset(prefabPath, self)
    self.bgComp = CS.UnityEngine.GameObject.Instantiate(prefab)
    self:ShowBg()
    if isUseTween then
      self:TweenShowBg(self.bgComp, preBgComp)
    end
  end
end

function GyroscopeManager:ShowBg(isUseTween)
  if self.bgComp then
    self.bgComp:SetActive(true)
    self:StopMeshTween()
    if isUseTween then
    end
  end
end

function GyroscopeManager:TweenShowBg(newBgComp, preBgComp)
  if not newBgComp or not preBgComp then
    return
  end
  self:StopMeshTween()
  local meshRenderer = newBgComp:GetComponentInChildren(typeof(CS.UnityEngine.MeshRenderer))
  local curTime, duration = TimerManager.totalTime, 0.2
  newBgComp.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1.01)
  meshRenderer.material.color = CS.UnityEngine.Color(1, 1, 1, 0)
  self._meshTween = meshRenderer.material:DOFade(1, duration):OnUpdate(function()
    local deltaTime = TimerManager.totalTime - curTime
    if meshRenderer and not IsNil(meshRenderer) then
      meshRenderer.material.color = CS.UnityEngine.Color(1, 1, 1, deltaTime / duration)
    end
  end):OnComplete(function()
    if meshRenderer and not IsNil(meshRenderer) then
      meshRenderer.material.color = CS.UnityEngine.Color(1, 1, 1, 1)
    end
    if preBgComp and not IsNil(preBgComp) then
      CS.UnityEngine.GameObject.Destroy(preBgComp)
    end
    if newBgComp and not IsNil(newBgComp) then
      newBgComp.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
    end
  end)
end

function GyroscopeManager:StopMeshTween()
  if self._meshTween then
    self._meshTween:Kill(true)
    self._meshTween = nil
  end
end

function GyroscopeManager:HideBg()
  if self.bgComp then
    self.bgComp:SetActive(false)
  end
end

function GyroscopeManager:ChangeDormitoryTex(isDefault)
  if not self.bgComp then
    return
  end
  local Picture = ArtCollectionModel.Instance:GetDomitoryBg()
  if Picture then
    local material = self.bgComp:GetComponentInChildren(typeof(CS.UnityEngine.MeshRenderer)).material
    local sprite = ResLoadMgr.LoadAsset(Picture, self)
    if sprite then
      material:SetTexture("_MainTex", sprite.texture)
    end
  end
  self.bgComp.transform.localScale = isDefault and Vector3_One or Vector3_NewBG
end

function GyroscopeManager:DisableGyroscope()
  if self.cameraComp then
    self.cameraComp = nil
  end
  if self.gyroscope then
    self:SwitchGyroscope(false)
    self.gyroscope = nil
  end
  self:DestroyBg()
end

function GyroscopeManager:SetGyroscopeByUrl(url)
  if self.gyroscope then
    local xUpper, xLower, xRotateRateScale, yUpper, yLower, yRotateRateScale = self:GetGyroscopeSettingByUrl(url)
    self.gyroscope.xAxisUpperLimit = xUpper
    self.gyroscope.xAxisLowerLimit = xLower
    self.gyroscope.horiRotateRateScale = xRotateRateScale
    self.gyroscope.yAxisUpperLimit = yUpper
    self.gyroscope.yAxisLowerLimit = yLower
    self.gyroscope.vertRotateRateScale = yRotateRateScale
  end
end

function GyroscopeManager:DestroyBg()
  self:StopMeshTween()
  if self.bgComp then
    CS.UnityEngine.GameObject.Destroy(self.bgComp)
    ResLoadMgr.UnloadAssetByTarget(self)
    self.bgComp = nil
  end
end

local url2GyroscopeSettingMap = {
  [Urls.MainPanel] = {
    3,
    357,
    0.118,
    3,
    357,
    0.171
  },
  [Urls.MainPanelPVP] = {
    6,
    354,
    0.1,
    6,
    354,
    0.1
  },
  [Urls.MainCopyChapterPanel] = {
    3,
    357,
    0.118,
    3,
    357,
    0.171
  }
}

function GyroscopeManager:GetGyroscopeSettingByUrl(url)
  if url2GyroscopeSettingMap[url] then
    do return table.unpack end
    return table.unpack, url2GyroscopeSettingMap[url]
  end
  return nil
end

local url2BgPrefabMap = {
  [Urls.MainPanel] = "MainUIScene/Scene_MainInterface/Prefab/Scene_MainInterface.prefab",
  [Urls.MainPanelPVP] = "MainUIScene/Scene_MainInterface/Prefab/UI_Large_Pvp_Bg_01.prefab"
}

function GyroscopeManager:GetGyroscopeBgByUrl(url)
  return url2BgPrefabMap[url]
end

function GyroscopeManager:OnDestroy()
  Super.OnDestroy(self)
end

return GyroscopeManager
