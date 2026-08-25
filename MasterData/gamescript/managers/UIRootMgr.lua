local typeof = _ENV.typeof
local Screen = CS.UnityEngine.Screen
local ScreenOrientation = CS.UnityEngine.ScreenOrientation
local UIRootMgr = System.NewClass("UIRootMgr", Component)
local width = 1920
local height = 1080
local uiCamera, mainCamera, sceneRoot, uiRoot, uiRT, topAreaGO, leftAreaGO, bottomAreaGo, rightAreaGo, topAreaRT, leftAreaRT, bottomAreaRT, rightAreaRT, safeAreaRT

function UIRootMgr.Init()
  mainCamera = CS.UnityEngine.Camera.main
  width = CS.UnityEngine.Screen.width
  height = CS.UnityEngine.Screen.height
  uiCamera = CS.UnityEngine.GameObject.Find("UICamera"):GetComponent(typeof(CS.UnityEngine.Camera))
  sceneRoot = CS.UnityEngine.GameObject.Find("SceneRoot")
  uiRoot = CS.UnityEngine.GameObject.Find("UIRoot")
  topAreaGO = CS.UnityEngine.GameObject.Find("TopArea")
  leftAreaGO = CS.UnityEngine.GameObject.Find("LeftArea")
  bottomAreaGo = CS.UnityEngine.GameObject.Find("BottomArea")
  rightAreaGo = CS.UnityEngine.GameObject.Find("RightArea")
  topAreaRT = topAreaGO:GetComponent(typeof(CS.UnityEngine.RectTransform))
  leftAreaRT = leftAreaGO:GetComponent(typeof(CS.UnityEngine.RectTransform))
  bottomAreaRT = bottomAreaGo:GetComponent(typeof(CS.UnityEngine.RectTransform))
  rightAreaRT = rightAreaGo:GetComponent(typeof(CS.UnityEngine.RectTransform))
  uiRT = uiRoot:GetComponent(typeof(CS.UnityEngine.RectTransform))
  safeAreaRT = CS.UnityEngine.GameObject.Find("SafeArea"):GetComponent(typeof(CS.UnityEngine.RectTransform))
  UIRootMgr.InitScreenAutoRotation()
  UIRootMgr.BlackAreaAddGraphicRaycaster()
end

function UIRootMgr.GetAllAreaRT()
  return safeAreaRT, topAreaRT, bottomAreaRT, leftAreaRT, rightAreaRT
end

function UIRootMgr.BlackAreaAddGraphicRaycaster()
  local areaGoGroup = {
    topAreaGO,
    leftAreaGO,
    bottomAreaGo,
    rightAreaGo
  }
  for _, go in pairs(areaGoGroup) do
    if go then
      local image = go:GetComponent(typeof(CS.UnityEngine.UI.Image))
      if image then
        image.raycastTarget = true
      end
      go:AddComponent(typeof(CS.UnityEngine.UI.GraphicRaycaster))
    end
  end
end

function UIRootMgr.GetUIRoot()
  return uiRoot or CS.UnityEngine.GameObject.Find("UIRoot")
end

function UIRootMgr.GetUIRootRectTransform()
  return uiRT or UIRootMgr.GetUIRoot():GetComponent(typeof(CS.UnityEngine.RectTransform))
end

function UIRootMgr.GetBlackBorderOffset()
  local transform = UIRootMgr.GetUIRootRectTransform()
  local ScreenXSmall = transform.sizeDelta.x / transform.sizeDelta.y * CS.UnityEngine.Screen.height
  return (UIRootMgr.GetScreenWidth() - ScreenXSmall) / 2
end

function UIRootMgr.GetUIXRadio()
  return UIRootMgr.GetScreenWidth() / UIRootMgr.GetUIRootWidth()
end

function UIRootMgr.GetUIYRadio()
  return UIRootMgr.GetScreenHeight() / UIRootMgr.GetUIRootHeight()
end

function UIRootMgr.GetSceneRoot()
  return sceneRoot or CS.UnityEngine.GameObject.Find("SceneRoot")
end

function UIRootMgr.Find(name)
  do return CS.UnityEngine.GameObject.Find end
  return CS.UnityEngine.GameObject.Find, name
end

function UIRootMgr.GetScreenWidth()
  return width or CS.UnityEngine.Screen.width
end

function UIRootMgr.GetScreenHeight()
  return height or CS.UnityEngine.Screen.height
end

function UIRootMgr.GetUIRootWidth()
  local transform = UIRootMgr.GetUIRootRectTransform()
  return transform.sizeDelta.x
end

function UIRootMgr.GetUIRootHeight()
  local transform = UIRootMgr.GetUIRootRectTransform()
  return transform.sizeDelta.y
end

function UIRootMgr.IsInScreen(x, y)
  local halfw = UIRootMgr.GetUIRootWidth() * 0.5
  local halfh = UIRootMgr.GetUIRootHeight() * 0.5
  if x >= -halfw and x < halfw and y >= -halfh and y < halfh then
    return true
  end
end

function UIRootMgr.GetUICamera()
  return uiCamera or CS.UnityEngine.GameObject.Find("UICamera"):GetComponent(typeof(CS.UnityEngine.Camera))
end

function UIRootMgr.GetMainCamera()
  return mainCamera or CS.UnityEngine.Camera.main
end

function UIRootMgr.GetBGImageWidth()
  return 2340
end

function UIRootMgr.GetBGImageHeight()
  return 1080
end

function UIRootMgr.GetTopBottomBarHeight()
  return topAreaRT.rect.height
end

function UIRootMgr.GetLeftRightBarWidth()
  return leftAreaRT.rect.width
end

function UIRootMgr.SetSiblingIndex(obj, index)
  CS.Framework.GameObjectUtil.SetSiblingIndex(obj, index)
end

function UIRootMgr.DestroyGameObject(obj)
  CS.Framework.GameObjectUtil.Destroy(obj)
end

function UIRootMgr.ClearAllChildren(obj)
  CS.Framework.GameObjectUtil.ClearChildren(obj)
end

function UIRootMgr.DestroyChildIndex(obj, index)
  Logger.Debug("DestroyChild")
  CS.Framework.GameObjectUtil.DestroyChild(obj, index)
end

function UIRootMgr.SetLayerRecursively(obj, layerName)
  CS.Framework.GameObjectUtil.SetLayerRecursively(obj, layerName)
end

function UIRootMgr.Clone(obj)
  local go = CS.Framework.GameObjectUtil.Clone(obj)
  return go
end

function UIRootMgr.FindChild(transform, name)
  local obj = CS.Framework.GameObjectUtil.DeepFindChild(transform, name)
  return obj and obj.gameObject or nil
end

function UIRootMgr.InitScreenAutoRotation()
  Screen.orientation = ScreenOrientation.AutoRotation
  Screen.autorotateToLandscapeLeft = true
  Screen.autorotateToLandscapeRight = true
  Screen.autorotateToPortrait = false
  Screen.autorotateToPortraitUpsideDown = false
end

return UIRootMgr
