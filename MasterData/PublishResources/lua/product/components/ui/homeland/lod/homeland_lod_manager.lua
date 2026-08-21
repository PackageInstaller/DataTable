_class("HomelandLODManager", Object)
HomelandLODManager = HomelandLODManager
local LODLevel = {
  HIGH = 0,
  MID = 1,
  LOW = 2
}

function HomelandLODManager:Constructor()
  self._lodlevel = LODManager.Instance:GetLODLevel()
end

function HomelandLODManager:Init(homelandClient)
  self._medalWallCamera = homelandClient:CameraManager():MedalWallCameraController():CameraCmp()
  self._followCamera = homelandClient:CameraManager():FollowCameraController():CameraCmp()
  self._globalCamera = homelandClient:CameraManager():GlobalCameraController():CameraCmp()
  if self._lodlevel == LODLevel.LOW then
    self:OnLowLevel()
  elseif self._lodlevel == LODLevel.MID then
    self:OnMidLevel()
  elseif self._lodlevel == LODLevel.HIGH then
    self:OnHighLevel()
  else
    Log.error("###[HomelandLODManager] No LOD level found :", self._lodlevel)
  end
end

function HomelandLODManager:OnLowLevel()
  self._resRequest = ResourceManager:GetInstance():SyncLoadAsset("Homeland_Low_Post.asset", LoadType.Asset)
  if self._resRequest ~= nil and self._resRequest.Obj then
    if self._followCamera then
      self._followCamera:GetComponent(typeof(UnityEngine.H3DPostProcessing.PostProcessing)).profile = self._resRequest.Obj
    end
    if self._globalCamera then
      self._globalCamera:GetComponent(typeof(UnityEngine.H3DPostProcessing.PostProcessing)).profile = self._resRequest.Obj
    end
    if self._medalWallCamera then
      self._medalWallCamera:GetComponent(typeof(UnityEngine.H3DPostProcessing.PostProcessing)).profile = self._resRequest.Obj
    end
  end
end

function HomelandLODManager:OnMidLevel()
  if self._followCamera then
    self._followCamera:GetComponent(typeof(UnityEngine.H3DPostProcessing.PostProcessing)).enabled = true
  end
  if self._globalCamera then
    self._globalCamera:GetComponent(typeof(UnityEngine.H3DPostProcessing.PostProcessing)).enabled = false
  end
  if self._medalWallCamera then
    self._medalWallCamera:GetComponent(typeof(UnityEngine.H3DPostProcessing.PostProcessing)).enabled = true
  end
end

function HomelandLODManager:OnHighLevel()
  if self._followCamera then
    self._followCamera:GetComponent(typeof(UnityEngine.H3DPostProcessing.PostProcessing)).enabled = true
  end
  if self._globalCamera then
    self._globalCamera:GetComponent(typeof(UnityEngine.H3DPostProcessing.PostProcessing)).enabled = true
  end
  if self._medalWallCamera then
    self._medalWallCamera:GetComponent(typeof(UnityEngine.H3DPostProcessing.PostProcessing)).enabled = true
  end
end

function HomelandLODManager:Dispose()
end
