_class("OptimizeHelper", Object)
OptimizeHelper = OptimizeHelper
local texture2D, renderTexture

function OptimizeHelper.GetOptimizeRenderTexture(gameObject)
  if renderTexture == nil then
    renderTexture = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  end
  OptimizeHelper.OnRenderTextureRender(gameObject)
  return renderTexture
end

function OptimizeHelper.OnRenderTextureRender(gameObject, rednerTexture2D, mainCamera)
  if renderTexture then
    renderTexture:Release()
  end
  local mainCamera = OptimizeHelper.GetMainCamera()
  local oldObjLayer = gameObject.layer
  GameObjectHelper.SetGameObjectLayer(gameObject, 21)
  local oldMask = mainCamera.cullingMask
  mainCamera.cullingMask = 2097152
  local oldClearFlags = mainCamera.clearFlags
  mainCamera.clearFlags = UnityEngine.CameraClearFlags.Depth
  mainCamera.targetTexture = renderTexture
  mainCamera:Render()
  UnityEngine.RenderTexture.active = renderTexture
  if rednerTexture2D then
    texture2D:ReadPixels(UnityEngine.Rect:New(0, 0, UnityEngine.Screen.width, UnityEngine.Screen.height), 0, 0, false)
    texture2D:Apply()
  end
  GameObjectHelper.SetGameObjectLayer(gameObject, oldObjLayer)
  mainCamera.clearFlags = oldClearFlags
  mainCamera.cullingMask = oldMask
end

function OptimizeHelper.OnRenderTextureClear()
  if renderTexture then
    renderTexture:Release()
  end
  local mainCamera = OptimizeHelper.GetMainCamera()
  mainCamera.targetTexture = nil
  UnityEngine.RenderTexture.active = nil
end

function OptimizeHelper.GetOptimizeTexture2D(gameObject, mainCamera)
  if renderTexture == nil then
    renderTexture = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  end
  if texture2D == nil then
    texture2D = UnityEngine.Texture2D:New(UnityEngine.Screen.width, UnityEngine.Screen.height)
  end
  OptimizeHelper.OnRenderTextureRender(gameObject, true, mainCamera)
  return texture2D
end

function OptimizeHelper.GetMainCamera()
  local world = GameGlobal:GetInstance():GetMainWorld()
  local mainCameraComponent = world:MainCamera()
  local mainCamera = mainCameraComponent:Camera()
  return mainCamera
end
