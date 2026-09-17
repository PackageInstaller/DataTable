local this = class("pagePhotoEdit", G_UIPageBase)
local _tabInfo = {
  {
    tabId = 2,
    txt_name = L_WordsTpl:getValue("residual_code_pagephotoedit_01"),
    groupName = "resize",
    icon = "UI/Atlas/PhotoEdit/tex_photo_icon_02.png"
  },
  {
    tabId = 3,
    txt_name = L_WordsTpl:getValue("residual_code_pagephotoedit_02"),
    groupName = "stamp",
    icon = "UI/Atlas/PhotoEdit/tex_photo_icon_03.png"
  },
  {
    tabId = 4,
    txt_name = L_WordsTpl:getValue("residual_code_pagephotoedit_03"),
    groupName = "text",
    icon = "UI/Atlas/PhotoEdit/tex_photo_icon_04.png"
  }
}

function this:created(...)
  this.super.created(self, ...)
end

function this.bind()
  return {
    active_closeBtn_circle = true,
    active_closeBtn_black = false,
    tabList = {
      moduleName = "pages/photoEdit/cellPhotoEditTab"
    },
    curTabID = 0,
    group = this.registBindGroup(),
    groupName = "",
    pos_finishBtn = L_DeviceTpl:getIsPc() and C_Vector2(-269, -67) or C_Vector2(-291, -74)
  }
end

function this.methods()
  return {
    onClick_save = function(self)
      self:save()
    end,
    onTabSelect = function(self, tabId)
      self.bind.curTabID = tabId
      self.bind.groupName = tostring(tabId)
      self:refreshSubModule(tabId)
    end,
    onDragImage = function(self, screenPos)
      if self.bind.curTabID == 2 then
        local subModule = self.modules.group["2"]
        subModule:onDragImage(screenPos, self.bindComponents.img_photoRect)
      end
    end,
    onDragImageBegin = function(self, screenPos)
      if self.bind.curTabID == 2 then
        local subModule = self.modules.group["2"]
        subModule:onDragImageBegin(screenPos)
      end
    end,
    onDragImageEnd = function(self, screenPos)
      if self.bind.curTabID == 2 then
        local subModule = self.modules.group["2"]
        subModule:onDragImageEnd()
      end
    end,
    group = {
      onClick_confirm = function(self)
        self.bind.curTabID = 3
      end
    },
    onClickClose = function(self)
      L_UI:close(self.pageName)
    end,
    onClickClose_black = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.rt = options.rt
  self:setImg()
  self:autoFit()
  self:initTab()
  self.onEditComplete = options.onEditComplete
  local curRatio = C_Screen.width / C_Screen.height
  local limitRatio = 1.7777777777777777
  if L_DeviceTpl:getIsPc() then
    self.bind.active_closeBtn_circle = true
    self.bind.active_closeBtn_black = false
    if curRatio > limitRatio then
      self.bind.pos_finishBtn = C_Vector2(-172, -67)
    end
  else
    self.bind.active_closeBtn_circle = false
    self.bind.active_closeBtn_black = true
    if curRatio > limitRatio then
      self.bind.pos_finishBtn = C_Vector2(-172, -74)
    end
  end
end

function this:initTab()
  local list = {}
  for i, v in pairs(_tabInfo) do
    local temp = {
      txt_name = v.txt_name,
      txt_nameOff = v.txt_name,
      txt_nameEn = string.upper(v.groupName),
      txt_nameEnOff = string.upper(v.groupName),
      tabId = v.tabId,
      icon_On = v.icon,
      icon_Off = v.icon,
      activeLine = v.tabId ~= 4,
      tabGroup = self.bindComponents.tabGroup
    }
    table.insert(list, temp)
  end
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(list)
  self.bind.curTabID = 2
end

function this.registBindGroup()
  local tab = {
    type = "toggleModule"
  }
  for key, value in pairs(_tabInfo) do
    local groupId = value.tabId
    local cell = {
      assetName = "UI/Pages/PhotoEdit/Group/modulePhotoEdit_" .. value.groupName,
      moduleName = "pages/photoEdit/group/modulePhotoEdit_" .. value.groupName
    }
    tab[tostring(groupId)] = cell
  end
  return tab
end

function this:refreshSubModule(id)
  local subModule = self.modules.group[tostring(id)]
  if not subModule.isInit then
    subModule:initParam({
      rt = self.rt,
      maskRect = self.bindComponents.maskRect,
      imgRoot = self.bindComponents.imgRoot,
      bgFrame = self.bindComponents.bgframe,
      photoRect = self.bindComponents.img_photoRect,
      photoMask = self.bindComponents.photoMask
    })
    if id == 2 then
      function subModule.onClick_confirmCallBack()
        self.bind.curTabID = 3
      end
    end
    if id == 4 then
      function subModule.onClick_deleteCallBack()
        self.bind.curTabID = 3
      end
    end
  end
end

function this:setImg()
  self.mat = C_UnityObject.Instantiate(self.bindComponents.imgPreview.material)
  self.mat:EnableKeyword("FIX_TO_GAMMA")
  self.bindComponents.img_photo.material = self.mat
  self.bindComponents.img_photo.texture = self.rt
end

function this:autoFit()
  local parentRect = self.bindComponents.imgContainer
  local parentWidth = parentRect.rect.size.x
  local parentHeight = parentRect.rect.size.y
  local imgWidth = self.rt.width
  local imgHeight = self.rt.height
  local ratio = imgWidth / imgHeight
  local targetWidth, targetHeight
  if ratio < parentWidth / parentHeight then
    targetHeight = parentHeight
    targetWidth = targetHeight * ratio
  else
    targetWidth = parentWidth
    targetHeight = targetWidth / ratio
  end
  local size = C_Vector2(targetWidth, targetHeight)
  self.bindComponents.imgRoot.sizeDelta = size
  self.bindComponents.photoMask.gameObject:GetComponent(typeof(C_RectTransform)).sizeDelta = size
  self.bindComponents.img_photo.gameObject:GetComponent(typeof(C_RectTransform)).sizeDelta = size
  self:syncBgFrameFull()
end

function this:syncBgFrameFull()
  local rect = self.bindComponents.bgframe
  self.initBgframePos = self.initBgframePos or rect.anchoredPosition
  rect.anchoredPosition = self.initBgframePos
  rect.sizeDelta = self.bindComponents.imgRoot.sizeDelta + C_Vector2(36, 36)
end

function this:show(options)
end

function this:hide()
end

function this:close(options)
  if self.captureCanvas then
    C_BoundGameObject.Destroy(self.captureCanvas)
    self.captureCanvas = nil
  end
  if self.mat then
    C_UnityObject.Destroy(self.mat)
    self.mat = nil
  end
end

function this:destroy(options)
end

function this:test()
  self.photoTex = options.tex
  self.bindComponents.imgPreview.texture = self.photoTex
  local mat = C_UnityObject.Instantiate(self.bindComponents.imgPreview.material)
  mat:EnableKeyword("FIX_TO_GAMMA")
  self.bindComponents.imgPreview.material = mat
  self:initCaptureCanvas()
end

function this:initCaptureCanvas()
  local canvas = L_ResPool:syncGameObject("Program/UIScene/pre_UICaptureCanvas.prefab", C_LuaUtility.GetRootNode())
  self.captureCanvas = canvas
  local cam = canvas.transform:Find("UICaptureCamera"):GetComponent(typeof(CS.UnityEngine.Camera))
  self.cam = cam
end

function this:copyRoot()
  local targetSize = C_Vector2(self.rt.width, self.rt.height)
  local curSize = self.bindComponents.imgRoot.sizeDelta
  local scale = C_Vector3(targetSize.x / curSize.x, targetSize.y / curSize.y, 1)
  local rectMask = self.bindComponents.photoMask
  local padding = rectMask.padding
  if scale.x < 1 or scale.y < 1 then
    rectMask.padding = C_Vector4(rectMask.padding.x * scale.x, rectMask.padding.y * scale.y, rectMask.padding.z * scale.x, rectMask.padding.w * scale.y)
  end
  local newRoot = C_UnityObject.Instantiate(self.bindComponents.imgRoot, self.captureCanvas.transform)
  rectMask.padding = padding
  newRoot.transform.localPosition = C_Vector3.zero
  newRoot.transform.localScale = scale
  return scale
end

function this:save()
  L_PhotoManager:sendEvent(L_PhotoManager.event.photoEditSave)
  self:initCaptureCanvas()
  Unity.Rendering.Azur._2D.Utilities.ScreenCaptureHelper.RegistCaptureCamera(self.cam)
  local newScale = self:copyRoot()
  local camRt = L_PhotoManager:newCaptureRT(self.rt.width, self.rt.height)
  self.cam.targetTexture = camRt
  self.cam:Render()
  Unity.Rendering.Azur._2D.Utilities.ScreenCaptureHelper.UnregistCaptureCamera(self.cam)
  local rectMask = self.bindComponents.photoMask
  local maskRectTransform = rectMask.gameObject:GetComponent(typeof(C_RectTransform))
  local size = maskRectTransform.rect.size
  local targetSize = C_Vector2(self.rt.width, self.rt.height)
  local leftBottom = C_Vector2(rectMask.padding.x, rectMask.padding.y)
  local maskSize = C_Vector2(size.x - rectMask.padding.x - rectMask.padding.z, size.y - rectMask.padding.y - rectMask.padding.w)
  leftBottom = C_Vector2(leftBottom.x * newScale.x, leftBottom.y * newScale.y)
  maskSize = C_Vector2(maskSize.x * newScale.x, maskSize.y * newScale.y)
  local cutRect = C_Rect(leftBottom, maskSize)
  local texture = C_CameraCaptureUtil.GetTextureFromRT(camRt, cutRect)
  C_CameraCaptureUtil.SetAlphaOne(texture)
  if self.captureCanvas then
    C_BoundGameObject.Destroy(self.captureCanvas)
    self.captureCanvas = nil
  end
  self.cam.targetTexture = nil
  L_PhotoManager:releaseCaptureRT(camRt)
  L_UI:close(self.pageName)
  if self.onEditComplete then
    self.onEditComplete(texture)
  end
end

return this
