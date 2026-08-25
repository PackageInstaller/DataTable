local RectTransform = CS.UnityEngine.RectTransform
local typeof = _ENV.typeof
local CanvasGroup = CS.UnityEngine.CanvasGroup
local AlertToolTipsPanel, Super = System.NewClass("AlertToolTipsPanel", UIBasePanel)
AlertToolTipsPanel.uiResCls = UI_Common_Popup_Tips_5Resource

function AlertToolTipsPanel:ctor(data, rootGameObject)
  Super.ctor(self)
  self.data = data
  self.rootGameObject = rootGameObject
end

function AlertToolTipsPanel:OnBind(binder)
  self.binder = binder
  self.canvasGroup = self.ui.Image_Bg:GetComponent(typeof(CanvasGroup))
  self.canvasGroup.alpha = 0
  binder:SetActive(self.ui.uiNode, false)
  self:BindOutSideClick()
  local model = binder:createModel(AlertModel, self.data)
  binder:BindToText(self.ui.Text_Title, function()
    do return model.GetTitle end
    return model.GetTitle, model
  end)
  binder:BindToVisible(self.ui.Text_Title, function()
    return not string.isempty(model:GetTitle())
  end)
  binder:BindToText(self.ui.Text_Copywriting, function()
    do return model.GetDesc end
    return model.GetDesc, model
  end)
  self.transform = self.ui.ScrollView.transform
  binder:SetActive(self.ui.uiNode, true)
  binder:BindTimer(0.01, 0, nil, function()
    self.canvasGroup.alpha = 1
    StrUtils.SetPreferredHeight(self.ui.Text_Copywriting)
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(self.ui.Image_Bg)
    if self.data.worldPos then
      self:_AdjustByWorldPosition()
    else
      self:AdjustPosition()
    end
  end)
end

function AlertToolTipsPanel:BindOutSideClick()
  self.binder:BindUICustomInput(self.ui.Image_Bg, function(hover)
    if not hover then
      self:Close()
    end
  end)
end

function AlertToolTipsPanel:AdjustPosition()
  if not self.rootGameObject then
    return
  end
  local rootPosition = self:GetRootPosition()
  local margin = 10
  local rootSizeDelta = self.rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local rootHeight = rootSizeDelta.y
  local rootWidth = rootSizeDelta.x
  local sizeDelta = self.ui.Image_Bg:GetComponent(typeof(RectTransform)).sizeDelta
  self.width = sizeDelta.x
  self.height = sizeDelta.y
  local bgWidth = UIRootMgr.GetBGImageWidth()
  local bgHeight = UIRootMgr.GetBGImageHeight()
  local UISize = CS.UnityEngine.GameObject.Find("SafeArea"):GetComponent(typeof(RectTransform)).rect
  local UIwidth = bgWidth < UISize.width and bgWidth or UISize.width
  local UIheight = bgHeight < UISize.height and bgHeight or UISize.height
  local overUpper = rootPosition.y + self.height + margin > UIheight / 2
  local overLower = rootPosition.y - rootHeight - margin - self.height < -UIheight / 2
  if overUpper and overLower then
    rootPosition.y = UIheight / 2 - margin
  elseif overUpper then
    rootPosition.y = rootPosition.y - rootHeight - margin
  else
    rootPosition.y = rootPosition.y + self.height + margin
  end
  local x = rootPosition.x + rootWidth / 2
  if x + self.width / 2 > UIwidth / 2 then
    x = x - (self.width / 2 + x + margin - UIwidth / 2)
  elseif x - self.width / 2 < -UIwidth / 2 then
    x = x + margin + (self.width / 2 - x - UIwidth / 2)
  end
  rootPosition.x = x
  self.transform.anchoredPosition = rootPosition
  local BgSizeDelta = self.ui.Image_Bg.gameObject.transform.sizeDelta
  self.ui.Content.transform.sizeDelta = CS.UnityEngine.Vector2(BgSizeDelta.x, BgSizeDelta.y)
  self.ui.ScrollView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect)).enabled = bgHeight < BgSizeDelta.y
end

function AlertToolTipsPanel:GetRootPosition()
  if not self.rootGameObject then
    return
  end
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(self.rootGameObject.transform.position, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  local rootSize = self.rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local Pivot = self.rootGameObject.transform.pivot
  do return CS.UnityEngine.Vector2, localPos.x - Pivot.x * rootSize.x end
  return CS.UnityEngine.Vector2, localPos.x - Pivot.x * rootSize.x, localPos.y + (1 - Pivot.y) * rootSize.y, (1 - Pivot.y) * rootSize.y, rootSize.y
end

function AlertToolTipsPanel:_AdjustByWorldPosition()
  if not self.data or not self.data.worldPos then
    return
  end
  local posX = self.data.worldPos.x
  local posY = self.data.worldPos.y
  local posZ = self.data.worldPos.z
  if nil == posZ then
    local newPosition = CS.UnityEngine.Vector2(-770 + posX * 130, -310 + posY * 130)
    self.transform.anchoredPosition = newPosition
  else
    local worldPos = CS.UnityEngine.Vector3(posX, posY, posZ)
    local uiRect = self.transform.rect
    local uiWidth = uiRect.width
    local uiHeight = uiRect.height
    local screenWidth = UIRootMgr.GetUIRootWidth()
    local screenHeight = UIRootMgr.GetUIRootHeight()
    local bgWidth = UIRootMgr.GetBGImageWidth()
    local bgHeight = UIRootMgr.GetBGImageHeight()
    screenWidth = screenWidth > bgWidth and bgWidth or screenWidth
    screenHeight = screenHeight > bgHeight and bgHeight or screenHeight
    local xMin, xMax = -screenWidth / 2 + uiWidth / 2, screenWidth / 2 - uiWidth / 2
    local yMin, yMax = -screenHeight / 2 + uiHeight / 2, screenHeight / 2 - uiHeight / 2
    local anchoredPos = CS.Framework.UIUtilTool.ConvertSceneToUIWorldPos(worldPos, self.transform.parent, UIRootMgr.GetMainCamera(), UIRootMgr.GetUICamera())
    anchoredPos.y = anchoredPos.y + 180
    if xMin > anchoredPos.x then
      anchoredPos.x = xMin
    elseif xMax < anchoredPos.x then
      anchoredPos.x = xMax
    end
    if yMin > anchoredPos.y then
      anchoredPos.y = yMin
    elseif yMax < anchoredPos.y then
      anchoredPos.y = yMax
    end
    self.transform.anchoredPosition = anchoredPos
  end
end

function AlertToolTipsPanel:Close()
  Super.Close(self)
end

return AlertToolTipsPanel
