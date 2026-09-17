local cls = class("pageTipBubble", G_UIPageBase)
local defaultSizeDelta = C_Vector2(40, 40)
local verticalSize = C_Vector2(30, 18)
local horizontalSize = C_Vector2(18, 30)
local deltaDistance = 64
local bangSize = 0

function cls.bind()
  return {
    go_arrow = true,
    color_bg = C_Color(1, 1, 1, 1),
    color_bgBorder = C_Color(1, 1, 1, 1)
  }
end

function cls.methods()
  return {
    onClick_btnClose = function(self)
      self:HideSelfOnClick()
    end
  }
end

function cls:playToggleAnimation()
  self.bindComponents.toggleAnimation:PlayMapChangeAnimation()
end

function cls:show(options)
  cls.super.show(self, options)
  self:refreshDatas(options)
end

function cls:refreshPageView(options)
  cls.super.refreshPageView(self, options)
  self:refreshDatas(options)
end

function cls:refreshDatas(options)
  self.data = options.data
  self.startPointIndex = 0
  self.bInited = false
  self.bCanTouch = true
  bangSize = 0
  self:SetScale(C_Vector3.zero)
  self:Init()
  if not self.data[11] then
    self.bind.go_arrow = true
  else
    self.bind.go_arrow = false
  end
  self.bind.color_bg = C_Color(1, 1, 1, self.data[7] or 1)
  self.bind.color_bgBorder = C_Color(1, 1, 1, self.data[7] or 1)
  self.delayHideSelfFrameNum = nil
end

function cls:SetScale(scale)
  if not L_CommonUtil.isValid(self.gameObject) then
    return
  end
  self.gameObject.transform.localScale = scale
end

function cls:Init()
  local function cbk(childObj)
    if self.data[2] and self.data[2] ~= "" then
      if self.curScript then
        self.curScript:Init(self.data[3])
      else
        self.curScript = require(self.data[2]).new(G_UIModuleBase.ModuleType.Static)
        self.curScript:created(nil, nil, self)
        self.curScript:toBind(self.pfObj:GetComponent(typeof(C_UIBinding)))
        self.curScript:Init(self.data[3])
        self.curScript.parentScript = self
      end
      if self.data[16] and self.curScript.tipRefreshBgFun == nil then
        function self.curScript.tipRefreshBgFun()
          self:RefreshImgContentSize()
        end
      end
    end
    if not L_CommonUtil.isValid(self.data[4]) then
      self:HideSelf()
      return
    end
    self:SetScale(C_Vector3.one)
    local pos = self.data[4].position
    local posNew = L_UI:getRoot():InverseTransformPoint(pos)
    local offset = self.data[10]
    if offset then
      posNew = posNew + offset
    end
    self.gameObject.transform.anchoredPosition3D = C_Vector3(posNew.x, posNew.y, 0)
    self.gameObject.transform.localScale = C_Vector3.one
    self.deltaSize = self.data[9]
    self.deltaSize = self.deltaSize or defaultSizeDelta
    self.borderDistance = self.data[8]
    self:InitUIBubbleBase(self.data[5], self.data[6])
  end
  
  if self.bLoadPrefabPath and self.bLoadPrefabPath == self.data[1] then
    if not L_CommonUtil.isValid(self.pfObj) then
      return
    end
    cbk()
    return
  end
  self:LoadChildPrefabAsyn(self.data[1], cbk)
end

function cls:callCallback(...)
  if self.callback and type(self.callback) == "function" then
    self.callback(...)
  end
end

function cls:LoadChildPrefabAsyn(pfPath, cbk)
  self.bLoadPrefabPath = pfPath
  local handler
  handler = C_LuaUtility.InstantiateAsync(pfPath, function(go)
    if not L_CommonUtil.isValid(go) then
      errorf("cant load asset from " .. pfPath)
      return
    end
    if not self.bLoadPrefabPath or self.bLoadPrefabPath ~= pfPath then
      C_LuaUtility.DestroyObject(handler)
      return
    end
    self:ReleaseChildPrefab()
    self.loadChildPrefabHandler = handler
    self.pfObj = go
    self.pfObj.transform.anchorMin = C_Vector2(0.5, 0.5)
    self.pfObj.transform.anchorMax = C_Vector2(0.5, 0.5)
    self.pfObj.transform.pivot = C_Vector2(0.5, 0.5)
    self.pfObj.transform.anchoredPosition3D = C_Vector3.zero
    self.pfObj.transform.localScale = C_Vector3.one
    if cbk then
      cbk(self.pfObj)
    end
  end, self.bindComponents.contentRoot.transform)
end

function cls:ReleaseChildPrefab()
  if L_CommonUtil.isValid(self.pfObj) then
    C_BoundGameObject.Destroy(self.pfObj)
  end
  self.pfObj = nil
  self.curScript = nil
  if self.loadChildPrefabHandler then
    C_LuaUtility.DestroyObject(self.loadChildPrefabHandler)
    self.loadChildPrefabHandler = nil
  end
end

function cls:InitUIBubbleBase(pointTo, bCanTouch)
  self.bCanTouch = bCanTouch
  self.startPointIndex = pointTo
  self:SetImgContentSize(self.pfObj.transform)
  self.bInited = true
end

function cls:SetImgContentSize(childTrans)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(childTrans:GetComponent("RectTransform"))
  local sizeDelta = childTrans:GetComponent("RectTransform").sizeDelta
  childTrans:SetSizeWithCurrentAnchors(1, sizeDelta.y)
  childTrans:SetSizeWithCurrentAnchors(0, sizeDelta.x)
  self:UpdateContainerSize(sizeDelta)
end

function cls:SetImageContentSizeAndPivot(childTrans, pivot)
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(childTrans:GetComponent("RectTransform"))
  local sizeDelta = childTrans:GetComponent("RectTransform").sizeDelta
  childTrans:SetSizeWithCurrentAnchors(1, sizeDelta.y)
  childTrans:SetSizeWithCurrentAnchors(0, sizeDelta.x)
  local oldPivot = self.bindComponents.bubbleRect.pivot
  cls:SetImageAnchored(self.bindComponents.bubbleRect, pivot)
  local newPivot = self.bindComponents.bubbleRect.pivot
  local pivotOffset = newPivot * self.bindComponents.bubbleRect.rect.size - oldPivot * self.bindComponents.bubbleRect.rect.size
  local originalPos = self.bindComponents.bubbleRect.anchoredPosition
  if self.borderDistance == nil then
    self.bindComponents.bubbleRect:SetSizeWithCurrentAnchors(0, sizeDelta.x)
    self.bindComponents.bubbleRect:SetSizeWithCurrentAnchors(1, sizeDelta.y)
  else
    self.bindComponents.bubbleRect:SetSizeWithCurrentAnchors(0, sizeDelta.x + self.borderDistance.x * 2)
    self.bindComponents.bubbleRect:SetSizeWithCurrentAnchors(1, sizeDelta.y + self.borderDistance.y * 2)
  end
  self.bindComponents.bubbleRect.anchoredPosition = originalPos + pivotOffset
end

function cls:UpdateContainerSize(childSizeDelta)
  if self.borderDistance == nil then
    self.bindComponents.bubbleRect:SetSizeWithCurrentAnchors(0, childSizeDelta.x)
    self.bindComponents.bubbleRect:SetSizeWithCurrentAnchors(1, childSizeDelta.y)
  else
    self.bindComponents.bubbleRect:SetSizeWithCurrentAnchors(0, childSizeDelta.x + self.borderDistance.x * 2)
    self.bindComponents.bubbleRect:SetSizeWithCurrentAnchors(1, childSizeDelta.y + self.borderDistance.y * 2)
  end
  self:SetPosition()
end

function cls:SetImageAnchored(obj, Pos)
  obj:GetComponent("RectTransform").pivot = {
    x = Pos.x,
    y = Pos.y
  }
end

local SetPosFunc = {
  [0] = function(initPos, rectW, rectH, screenW, screenH, arrowRootRect, arrowRect, bubbleRect, transSize)
    local arrowSize = horizontalSize
    if initPos.x - (arrowSize.x + transSize.x) - rectW >= -(screenW - deltaDistance) / 2 then
      cls:SetImageAnchored(arrowRootRect, C_Vector2(1, 0.5))
      arrowRect.localEulerAngles = C_Vector3(0, 0, 0)
      arrowRect.anchoredPosition3D = C_Vector3(0, 0, 0)
      arrowRootRect.anchoredPosition3D = C_Vector3(-transSize.x, 0, 0)
      cls:SetImageAnchored(bubbleRect, C_Vector2(1, 0.5))
      rectH = rectH + deltaDistance
      if initPos.y + rectH / 2 > screenH / 2 then
        bubbleRect.anchoredPosition3D = C_Vector3(-(arrowSize.x + transSize.x), screenH / 2 - (initPos.y + rectH / 2), 0)
      elseif initPos.y - rectH / 2 < -screenH / 2 then
        bubbleRect.anchoredPosition3D = C_Vector3(-(arrowSize.x + transSize.x), -screenH / 2 + rectH / 2 - initPos.y, 0)
      else
        bubbleRect.anchoredPosition3D = C_Vector3(-(arrowSize.x + transSize.x), 0, 0)
      end
      return true
    end
    return false
  end,
  [1] = function(initPos, rectW, rectH, screenW, screenH, arrowRootRect, arrowRect, bubbleRect, transSize)
    local arrowSize = verticalSize
    if initPos.y + arrowSize.y + rectH <= (screenH - deltaDistance) / 2 then
      cls:SetImageAnchored(arrowRootRect, C_Vector2(0.5, 0))
      arrowRect.localEulerAngles = C_Vector3(0, 0, -90)
      arrowRect.anchoredPosition3D = C_Vector3(0, 0, 0)
      arrowRootRect.anchoredPosition3D = C_Vector3(0, transSize.y, 0)
      cls:SetImageAnchored(bubbleRect, C_Vector2(0.5, 0))
      rectW = rectW + deltaDistance
      if initPos.x + rectW / 2 > screenW / 2 then
        bubbleRect.anchoredPosition3D = C_Vector3(screenW / 2 - (initPos.x + rectW / 2), arrowSize.y + transSize.y, 0)
      elseif initPos.x - rectW / 2 < -screenW / 2 then
        bubbleRect.anchoredPosition3D = C_Vector3(-screenW / 2 + rectW / 2 - initPos.x, arrowSize.y + transSize.y, 0)
      else
        bubbleRect.anchoredPosition3D = C_Vector3(0, arrowSize.y + transSize.y, 0)
      end
      return true
    end
    return false
  end,
  [2] = function(initPos, rectW, rectH, screenW, screenH, arrowRootRect, arrowRect, bubbleRect, transSize)
    local arrowSize = horizontalSize
    if initPos.x + arrowSize.x + rectW <= (screenW - deltaDistance) / 2 then
      cls:SetImageAnchored(arrowRootRect, C_Vector2(0, 0.5))
      arrowRect.localEulerAngles = C_Vector3(0, 0, 180)
      arrowRect.anchoredPosition3D = C_Vector3(0, 0, 0)
      arrowRootRect.anchoredPosition3D = C_Vector3(transSize.x, 0, 0)
      cls:SetImageAnchored(bubbleRect, C_Vector2(0, 0.5))
      rectH = rectH + deltaDistance
      if initPos.y + rectH / 2 > screenH / 2 then
        bubbleRect.anchoredPosition3D = C_Vector3(arrowSize.x + transSize.x, screenH / 2 - (initPos.y + rectH / 2), 0)
      elseif initPos.y - rectH / 2 < -screenH / 2 then
        bubbleRect.anchoredPosition3D = C_Vector3(arrowSize.x + transSize.x, -screenH / 2 + rectH / 2 - initPos.y, 0)
      else
        bubbleRect.anchoredPosition3D = C_Vector3(arrowSize.x + transSize.x, 0, 0)
      end
      return true
    end
    return false
  end,
  [3] = function(initPos, rectW, rectH, screenW, screenH, arrowRootRect, arrowRect, bubbleRect, transSize)
    local arrowSize = verticalSize
    if initPos.y - arrowSize.y - rectH >= -(screenH - deltaDistance) / 2 then
      cls:SetImageAnchored(arrowRootRect, C_Vector2(0.5, 1))
      arrowRect.localEulerAngles = C_Vector3(0, 0, 90)
      arrowRect.anchoredPosition3D = C_Vector3(0, 0, 0)
      arrowRootRect.anchoredPosition3D = C_Vector3(0, -transSize.y, 0)
      cls:SetImageAnchored(bubbleRect, C_Vector2(0.5, 1))
      rectW = rectW + deltaDistance
      if initPos.x + rectW / 2 > screenW / 2 then
        bubbleRect.anchoredPosition3D = C_Vector3(screenW / 2 - (initPos.x + rectW / 2), -(arrowSize.y + transSize.y), 0)
      elseif initPos.x - rectW / 2 < -screenW / 2 then
        bubbleRect.anchoredPosition3D = C_Vector3(-screenW / 2 + rectW / 2 - initPos.x, -(arrowSize.y + transSize.y), 0)
      else
        bubbleRect.anchoredPosition3D = C_Vector3(0, -(arrowSize.y + transSize.y), 0)
      end
      return true
    end
    return false
  end
}

function cls:GetLayerScale()
  local m_matchWidthOrHeight = 1.0
  if Unity.Screen.width / Unity.Screen.height < 2 then
    m_matchWidthOrHeight = 0.78
  end
  local kLogBase = 2.0
  local logWidth = Mathf.Log(Unity.Screen.width / 1920, kLogBase)
  local logHeight = Mathf.Log(Unity.Screen.height / 1080, kLogBase)
  local logWeightedAverage = Mathf.Lerp(logWidth, logHeight, m_matchWidthOrHeight)
  local scaleFactor = Mathf.Pow(kLogBase, logWeightedAverage)
  return scaleFactor
end

function cls:SetPosition()
  self.rect = self.gameObject:GetComponent(typeof(Unity.RectTransform))
  local initPos = self.rect.anchoredPosition
  local layerScale = self:GetLayerScale()
  self.rectW = self.bindComponents.bubbleRect.rect.width
  self.rectH = self.bindComponents.bubbleRect.rect.height
  self.screenH = Unity.Screen.height / layerScale
  self.screenW = Unity.Screen.width / layerScale - bangSize * 2
  if self.data[13] then
    for _, v in ipairs(self.data[13]) do
      if SetPosFunc[v] and SetPosFunc[v](initPos, self.rectW, self.rectH, self.screenW, self.screenH, self.bindComponents.arrowRootRect, self.bindComponents.arrowRect, self.bindComponents.bubbleRect, self.deltaSize) then
        return
      end
    end
  else
    for i = 1, 4 do
      if SetPosFunc[self.startPointIndex] and SetPosFunc[self.startPointIndex](initPos, self.rectW, self.rectH, self.screenW, self.screenH, self.bindComponents.arrowRootRect, self.bindComponents.arrowRect, self.bindComponents.bubbleRect, self.deltaSize) then
        return
      else
        self.startPointIndex = self.startPointIndex + 1
        self.startPointIndex = self.startPointIndex % 4
      end
    end
  end
end

function cls:RefreshPosition()
  local pos = self.data[4].position
  local posNew = L_UI:getRoot():InverseTransformPoint(pos)
  local offset = self.data[10]
  if offset then
    posNew = posNew + offset
  end
  self.gameObject.transform.anchoredPosition3D = C_Vector3(posNew.x, posNew.y, 0)
  self.gameObject.transform.localScale = C_Vector3.one
  if self.data[13] then
    for _, v in ipairs(self.data[13]) do
      if SetPosFunc[v] and SetPosFunc[v](initPos, self.rectW, self.rectH, self.screenW, self.screenH, self.bindComponents.arrowRootRect, self.bindComponents.arrowRect, self.bindComponents.bubbleRect, self.deltaSize) then
        return
      end
    end
  else
    for i = 1, 4 do
      if SetPosFunc[self.startPointIndex] and SetPosFunc[self.startPointIndex](self.rect.anchoredPosition, self.rectW, self.rectH, self.screenW, self.screenH, self.bindComponents.arrowRootRect, self.bindComponents.arrowRect, self.bindComponents.bubbleRect, self.deltaSize) then
        return
      else
        self.startPointIndex = self.startPointIndex + 1
        self.startPointIndex = self.startPointIndex % 4
      end
    end
  end
end

function cls:RefreshImgContentSize()
  if self.pfObj ~= nil then
    self:SetImgContentSize(self.pfObj.transform)
  end
end

function cls:GetParentCanvasLayer(child)
  if not L_CommonUtil.isValid(child) then
    return nil
  end
  if not self.curChildInstanceId or self.curChildInstanceId ~= child:GetInstanceID() then
    self.curChildInstanceId = child:GetInstanceID()
  else
    return self.parentGo
  end
  local parent
  while true do
    if child.transform.parent == nil then
      return nil
    end
    parent = child.transform.parent
    if L_CommonUtil.isValid(parent.gameObject:GetComponent(typeof(C_Canvas))) then
      break
    end
    child = child.transform.parent
  end
  self.parentGo = parent.gameObject
  return self.parentGo
end

function cls:update()
  if self.bInited == false then
    return
  end
  if self.delayHideSelfFrameNum ~= nil and self.delayHideSelfFrameNum > 0 then
    self.delayHideSelfFrameNum = self.delayHideSelfFrameNum - 1
    if self.delayHideSelfFrameNum == 0 then
      self:HideSelf()
    end
  end
  if L_CommonUtil.isValid(self.data[4]) then
    if L_CommonUtil.isValid(self.data[4].gameObject) and not self.data[4].gameObject.activeInHierarchy then
      self:HideSelf()
      return
    else
      local parentGo = self:GetParentCanvasLayer(self.data[4])
      if parentGo and L_CommonUtil.isValid(self.gameObject) and self.gameObject.layer ~= parentGo.layer then
        self.gameObject.layer = parentGo.layer
      end
    end
  else
    self:HideSelf()
    return
  end
  if Unity.Input.GetAxis("Mouse ScrollWheel") ~= 0 then
    self:HideSelf()
    return
  end
  if self.data[12] then
    self:RefreshPosition()
  end
end

function cls:HideSelfOnClick()
  if self.data and self.data[14] then
    if self.delayHideSelfFrameNum ~= nil and self.delayHideSelfFrameNum > 0 then
      return
    end
    self.delayHideSelfFrameNum = self.data[15] or 1
    return
  else
    self:HideSelf()
  end
end

function cls:HideSelf()
  L_UI:close(self.pageName)
  self.bInited = false
end

function cls:close(options)
  cls.super.close(self, options)
  if self.curScript then
    self.curScript:_dispose()
    self.curScript = nil
  end
  self.bInited = false
  self.bCanTouch = true
end

function cls:destroy(options)
  cls.super.destroy(self, options)
  self:ReleaseChildPrefab()
end

return cls
