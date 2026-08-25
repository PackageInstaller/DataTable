local RectTransform = CS.UnityEngine.RectTransform
local typeof = _ENV.typeof
local TipsGenerateUtils = {}

function TipsGenerateUtils.AdjustPosition(rootGameObj, tipGameObj)
  local rootPosition = TipsGenerateUtils.GetLocalPosition(rootGameObj)
  local rootSizeDelta = rootGameObj:GetComponent(typeof(RectTransform)).sizeDelta
  local rootHeight = rootSizeDelta.y
  local sizeDelta = tipGameObj:GetComponent(typeof(RectTransform)).sizeDelta
  local tipWidth = sizeDelta.x
  local tipHeight = sizeDelta.y
  local UISize = CS.UnityEngine.GameObject.Find("SafeArea"):GetComponent(typeof(RectTransform)).rect
  local bgWidth = UIRootMgr.GetBGImageWidth()
  local UIwidth = bgWidth < UISize.width and bgWidth or UISize.width
  if rootPosition.y > 0 then
    rootPosition.y = rootPosition.y - tipHeight / 2 - rootHeight / 2
  else
    rootPosition.y = rootPosition.y + tipHeight / 2 + rootHeight / 2
  end
  if rootPosition.x + tipWidth / 2 > UIwidth / 2 then
    rootPosition.x = rootPosition.x - (tipWidth / 2 + rootPosition.x - UIwidth / 2)
  elseif rootPosition.x - tipWidth / 2 < -UIwidth / 2 then
    rootPosition.x = rootPosition.x + (tipWidth / 2 - rootPosition.x - UIwidth / 2)
  end
  tipGameObj.transform.anchoredPosition = rootPosition
end

function TipsGenerateUtils.GetLocalPosition(gameObj)
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(gameObj.transform.position, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  do return CS.UnityEngine.Vector2, localPos.x end
  return CS.UnityEngine.Vector2, localPos.x, localPos.y, CameraManager:GetUICamera()
end

return TipsGenerateUtils
