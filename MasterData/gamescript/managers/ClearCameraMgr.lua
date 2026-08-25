local ClearCameraMgr, Super = System.NewClass("ClearCameraMgr", Manager, IUpdater)
local CSScreen = CS.UnityEngine.Screen

function ClearCameraMgr:ctor()
  Super.ctor(self)
end

function ClearCameraMgr:Awake()
  Super.Awake(self)
  if ApplicationUtils.IsWindowsOrEditor() or AdaptiveManager.Instance:IsLowerTargetRatio() then
    self:TryCreateClearCamera()
  end
end

function ClearCameraMgr:TryCreateClearCamera()
  local camName = "ClearCamera"
  local camGo = CS.UnityEngine.GameObject.Find(camName)
  if camGo then
    return
  end
  camGo = CS.UnityEngine.GameObject("ClearCamera")
  local camera = camGo:AddComponent(typeof(CS.UnityEngine.Camera))
  camera.clearFlags = 2
  camera.backgroundColor = CS.UnityEngine.Color(0, 0, 0, 0)
  local cameraData = camera:GetUniversalAdditionalCameraData()
  cameraData:SetRenderer(2)
  camera.cullingMask = 0
  camera.depth = -99
end

return ClearCameraMgr
