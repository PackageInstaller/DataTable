local RectTransform = CS.UnityEngine.RectTransform
local typeof = _ENV.typeof
local CanvasGroup = CS.UnityEngine.CanvasGroup
local AlertIconToolBattleTipsPanel, Super = System.NewClass("AlertIconToolBattleTipsPanel", UIBasePanel)
AlertIconToolBattleTipsPanel.uiResCls = UI_Common_Popup_Tips_6Resource
local MAXHEIGHT = 720
local MINHEIGHT = 90

function AlertIconToolBattleTipsPanel:ctor(data, rootGameObject, isSchoolEffectTip)
  Super.ctor(self)
  self.data = data
  self.rootGameObject = rootGameObject
  self.isSchoolEffectTip = isSchoolEffectTip
end

function AlertIconToolBattleTipsPanel:OnBind(binder)
  self.binder = binder
  self.canvasGroup = self.ui.uiNode:GetComponent(typeof(CanvasGroup))
  self.canvasGroup.alpha = 0
  binder:SetActive(self.ui.uiNode, false)
  local model = binder:createModel(AlertModel, self.data)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:SetActive(self.ui.Text_Desc_2, false)
  binder:SetActive(self.ui.Text_Level, false)
  binder:BindToText(self.ui.Text_Count, function()
    do return model.GetOwnText end
    return model.GetOwnText, model
  end)
  binder:BindToText(self.ui.Text_Title, function()
    do return model.GetTitle end
    return model.GetTitle, model
  end)
  binder:BindToText(self.ui.Text_Desc_1, function()
    do return model.GetDesc end
    return model.GetDesc, model
  end)
  binder:BindToText(self.ui.Text_Desc, function()
    do return model.GetDesc end
    return model.GetDesc, model
  end)
  binder:BindToImage(self.ui.Icon_Article, function()
    do return model.GetIcon end
    return model.GetIcon, model
  end)
  binder:BindToImage(self.ui.Icon_Article_2, function()
    do return model.GetIcon end
    return model.GetIcon, model
  end)
  binder:BindToVisible(self.ui.Group_Article, function()
    return not self.isSchoolEffectTip
  end)
  binder:BindToVisible(self.ui.Group_Article2, function()
    return self.isSchoolEffectTip
  end)
  self.transform = self.ui.uiNode.transform
  binder:SetActive(self.ui.uiNode, true)
  binder:BindToRaw(function()
    binder:BindTimer(0.02, 0, nil, function()
      local height = StrUtils.SetPreferredHeight(self.ui.Text_Desc_1, 30)
      StrUtils.SetPreferredHeight(self.ui.Text_Desc, 30)
      local overflow = height > MAXHEIGHT
      local contentHeight = overflow and MAXHEIGHT + MINHEIGHT or height + MINHEIGHT
      local descviewHeight = overflow and MAXHEIGHT or height
      local scrollRect = self.ui.DescView.gameObject:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
      scrollRect.enabled = overflow
      local descSizeDelta = self.ui.DescView.transform.sizeDelta
      local contentSizeDelta = self.ui.Group_Tip.transform.sizeDelta
      local descviewV2 = CS.UnityEngine.Vector2(0, 0)
      local contentV2 = CS.UnityEngine.Vector2(0, 0)
      descviewV2.x, contentV2.x = descSizeDelta.x, contentSizeDelta.x
      descviewV2.y, contentV2.y = descviewHeight, contentHeight
      self.ui.Group_Tip.transform.sizeDelta = contentV2
      self.ui.DescView.transform.sizeDelta = descviewV2
    end)
  end, function()
    do return model.GetDesc end
    return model.GetDesc, model
  end)
  self:ResetPos()
  binder:BindTimer(0.02, 0, nil, function()
    self.canvasGroup.alpha = 1
  end)
end

function AlertIconToolBattleTipsPanel:ResetPos()
  if not self.isSchoolEffectTip then
    if self.data.worldPos then
      self:_AdjustByWorldPosition()
    else
      self:AdjustPosition()
    end
  else
    self.ui.uiNode.transform.anchoredPosition = self:GetRootPosition()
  end
end

function AlertIconToolBattleTipsPanel:SetRendered(isRendered)
  Super.SetRendered(self, isRendered)
  if self.transform and isRendered then
    self:ResetPos()
  end
end

function AlertIconToolBattleTipsPanel:AdjustPosition()
  if not self.rootGameObject or not self.transform then
    return
  end
  local rootPosition = self:GetRootPosition()
  local margin = 10
  local rootSizeDelta = self.rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local rootWidth = rootSizeDelta.x
  local rootHeight = rootSizeDelta.y
  local sizeDelta = self.ui.uiNode:GetComponent(typeof(RectTransform)).sizeDelta
  self.width = sizeDelta.x
  self.height = sizeDelta.y
  local UISize = CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)).sizeDelta
  local UIwidth = UISize.x
  local UIheight = UISize.y
  if rootPosition.y + self.height + margin > UIheight / 2 then
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
end

function AlertIconToolBattleTipsPanel:GetRootPosition()
  if not self.rootGameObject then
    return
  end
  local localPos = CS.Framework.UIUtilTool.ConvertUIWorldPosToLocalPos(self.rootGameObject.transform.position, CS.UnityEngine.GameObject.Find("UIRoot"):GetComponent(typeof(RectTransform)), CameraManager:GetUICamera())
  local rootSize = self.rootGameObject:GetComponent(typeof(RectTransform)).sizeDelta
  local Pivot = self.rootGameObject.transform.pivot
  do return CS.UnityEngine.Vector2, localPos.x - Pivot.x * rootSize.x end
  return CS.UnityEngine.Vector2, localPos.x - Pivot.x * rootSize.x, localPos.y + (1 - Pivot.y) * rootSize.y, (1 - Pivot.y) * rootSize.y, rootSize.y
end

function AlertIconToolBattleTipsPanel:_AdjustByWorldPosition()
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

function AlertIconToolBattleTipsPanel:Close()
  Super.Close(self)
end

return AlertIconToolBattleTipsPanel
