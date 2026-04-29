require("base_ins_r")
_class("DataTakeSceneScreenshotInstruction", BaseInstruction)
DataTakeSceneScreenshotInstruction = DataTakeSceneScreenshotInstruction

function DataTakeSceneScreenshotInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local cMainCamera = world:MainCamera()
  local csCamera = cMainCamera:Camera()
  local csRT = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  csCamera.targetTexture = csRT
  csCamera:Render()
  UnityEngine.RenderTexture.active = csRT
  local csTex2d = UnityEngine.Texture2D:New(UnityEngine.Screen.width, UnityEngine.Screen.height)
  csTex2d:ReadPixels(UnityEngine.Rect:New(0, 0, UnityEngine.Screen.width, UnityEngine.Screen.height), 0, 0, false)
  csTex2d:Apply()
  csCamera.targetTexture = nil
  UnityEngine.RenderTexture.active = nil
  csRT:Destroy()
  cMainCamera:SetScreenCameraScreenshot(csTex2d)
end
