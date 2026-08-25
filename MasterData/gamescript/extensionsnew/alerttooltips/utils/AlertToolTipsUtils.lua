local RectTransform = CS.UnityEngine.RectTransform
local typeof = _ENV.typeof
local AlertToolTipsUtils = {}

function AlertToolTipsUtils.GetTitle(tipsData)
  if not tipsData then
    return ""
  end
  if tipsData.title then
    return tipsData.title
  end
  local config = DT.TipsType[tipsData.tipTid]
  return config and LT.Text(config.Title) or ""
end

function AlertToolTipsUtils.GetDesc(tipsData)
  if not tipsData then
    return ""
  end
  if tipsData.desc then
    return tipsData.desc
  end
  local config = DT.TipsType[tipsData.tipTid]
  return config and LT.Text(config.Desc) or ""
end

function AlertToolTipsUtils.GetIcon(tipsData)
  if not tipsData then
    return nil
  end
  if tipsData.iconPath then
    return tipsData.iconPath
  end
  local config = DT.TipsType[tipsData.tipTid]
  return config and config.Icon or ""
end

function AlertToolTipsUtils.GetOwnText(tipsData)
  if not tipsData then
    return ""
  end
  return tipsData.ownText or ""
end

function AlertToolTipsUtils.GetRootPosition(rootGameObject)
  if not rootGameObject then
    return nil
  end
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(rootGameObject.transform.position, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  local rootSize = rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local pivot = rootGameObject.transform.pivot
  do return CS.UnityEngine.Vector2, localPos.x - pivot.x * rootSize.x end
  return CS.UnityEngine.Vector2, localPos.x - pivot.x * rootSize.x, localPos.y + (1 - pivot.y) * rootSize.y, (1 - pivot.y) * rootSize.y, rootSize.y
end

local function _GetSafeAreaSize()
  local bgWidth = UIRootMgr.GetBGImageWidth()
  local bgHeight = UIRootMgr.GetBGImageHeight()
  local safeAreaRect = CS.UnityEngine.GameObject.Find("SafeArea"):GetComponent(typeof(RectTransform)).rect
  local uiWidth = bgWidth < safeAreaRect.width and bgWidth or safeAreaRect.width
  local uiHeight = bgHeight < safeAreaRect.height and bgHeight or safeAreaRect.height
  return uiWidth, uiHeight
end

local function _GetUIRootSize()
  local uiSize = CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)).sizeDelta
  return uiSize.x, uiSize.y
end

local function _AdjustVertical(pos, tipHeight, rootHeight, uiHeight, margin)
  local overUpper = pos.y + tipHeight + margin > uiHeight / 2
  local overLower = pos.y - rootHeight - margin - tipHeight < -uiHeight / 2
  if overUpper and overLower then
    pos.y = uiHeight / 2 - margin
  elseif overUpper then
    pos.y = pos.y - rootHeight - margin
  else
    pos.y = pos.y + tipHeight + margin
  end
end

local function _AdjustHorizontal(pos, tipWidth, rootWidth, uiWidth, margin)
  local x = pos.x + rootWidth / 2
  if x + tipWidth / 2 > uiWidth / 2 then
    x = x - (tipWidth / 2 + x + margin - uiWidth / 2)
  elseif x - tipWidth / 2 < -uiWidth / 2 then
    x = x + margin + (tipWidth / 2 - x - uiWidth / 2)
  end
  pos.x = x
end

function AlertToolTipsUtils.AdjustPosition(transform, rootGameObject, bgTransform, scrollView, contentTransform)
  if not rootGameObject then
    return
  end
  local pos = AlertToolTipsUtils.GetRootPosition(rootGameObject)
  if not pos then
    return
  end
  local margin = 10
  local rootSize = rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local tipSize = bgTransform.sizeDelta
  local uiWidth, uiHeight = _GetSafeAreaSize()
  _AdjustVertical(pos, tipSize.y, rootSize.y, uiHeight, margin)
  _AdjustHorizontal(pos, tipSize.x, rootSize.x, uiWidth, margin)
  transform.anchoredPosition = pos
  if contentTransform then
    contentTransform.sizeDelta = CS.UnityEngine.Vector2(tipSize.x, tipSize.y)
  end
  if scrollView then
    local scrollRect = scrollView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
    scrollRect.enabled = tipSize.y > UIRootMgr.GetBGImageHeight()
  end
end

function AlertToolTipsUtils.AdjustIconPosition(transform, rootGameObject, nodeTransform)
  if not rootGameObject or not transform then
    return
  end
  local pos = AlertToolTipsUtils.GetRootPosition(rootGameObject)
  if not pos then
    return
  end
  local margin = 10
  local rootSize = rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local tipSize = nodeTransform.sizeDelta
  local uiWidth, uiHeight = _GetUIRootSize()
  _AdjustVertical(pos, tipSize.y, rootSize.y, uiHeight, margin)
  _AdjustHorizontal(pos, tipSize.x, rootSize.x, uiWidth, margin)
  transform.anchoredPosition = pos
end

function AlertToolTipsUtils.AdjustByWorldPosition(transform, worldPosData, offsetY)
  if not worldPosData then
    return
  end
  offsetY = offsetY or 180
  if worldPosData.z == nil then
    transform.anchoredPosition = CS.UnityEngine.Vector2(-770 + worldPosData.x * 130, -310 + worldPosData.y * 130)
    return
  end
  local worldPos = CS.UnityEngine.Vector3(worldPosData.x, worldPosData.y, worldPosData.z)
  local uiRect = transform.rect
  local screenWidth = math.min(UIRootMgr.GetUIRootWidth(), UIRootMgr.GetBGImageWidth())
  local screenHeight = math.min(UIRootMgr.GetUIRootHeight(), UIRootMgr.GetBGImageHeight())
  local xMin = -screenWidth / 2 + uiRect.width / 2
  local xMax = screenWidth / 2 - uiRect.width / 2
  local yMin = -screenHeight / 2 + uiRect.height / 2
  local yMax = screenHeight / 2 - uiRect.height / 2
  local anchoredPos = CS.Framework.UIUtilTool.ConvertSceneToUIWorldPos(worldPos, transform.parent, UIRootMgr.GetMainCamera(), UIRootMgr.GetUICamera())
  anchoredPos.y = anchoredPos.y + offsetY
  anchoredPos.x = MathUtils.Clamp(anchoredPos.x, xMin, xMax)
  anchoredPos.y = MathUtils.Clamp(anchoredPos.y, yMin, yMax)
  transform.anchoredPosition = anchoredPos
end

function AlertToolTipsUtils.AdjustDescLayout(textDesc1, textDesc, descView, groupTipTransform, maxHeight, minHeight)
  maxHeight = maxHeight or 720
  minHeight = minHeight or 90
  local height = StrUtils.SetPreferredHeight(textDesc1, 30)
  StrUtils.SetPreferredHeight(textDesc, 30)
  local overflow = maxHeight < height
  local contentHeight = overflow and maxHeight + minHeight or height + minHeight
  local descViewHeight = overflow and maxHeight or height
  local scrollRect = descView.gameObject:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  scrollRect.enabled = overflow
  local descSizeDelta = descView.transform.sizeDelta
  local contentSizeDelta = groupTipTransform.sizeDelta
  groupTipTransform.sizeDelta = CS.UnityEngine.Vector2(contentSizeDelta.x, contentHeight)
  descView.transform.sizeDelta = CS.UnityEngine.Vector2(descSizeDelta.x, descViewHeight)
end

return AlertToolTipsUtils
