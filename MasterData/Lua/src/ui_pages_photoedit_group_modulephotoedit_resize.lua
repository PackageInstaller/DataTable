local this = class("modulePhotoEdit_resize", require("ui.pages.photoEdit.group.modulePhotoEdit_base"))

function this.bind()
  return {
    sizeList = {
      moduleName = "pages/photoEdit/cellPhotoEditSize"
    },
    curId = 0,
    modulePhotoSizeHandle = {
      moduleName = "pages/photoEdit/modulePhotoSizeHandle"
    }
  }
end

function this.methods()
  return {
    onSelect = function(self, id)
      local info = self.sizeInfo[id]
      if info == nil then
        return
      end
      info.onClick(self)
      if id == 1 then
        return
      end
      self.curTabId = id
      self:changeDir(info)
      self:applyRatio(info)
      self.modules.modulePhotoSizeHandle:initInfo(info)
    end,
    onClick_confirm = function(self)
      self.onClick_confirmCallBack()
    end,
    modulePhotoSizeHandle = {
      onHandleSizeChange = function(self)
        self:onHandleSizeChange()
      end
    },
    onClickAlign = function(self)
      self.isHorizontal = not self.isHorizontal
      local info = self.sizeInfo[self.curTabId]
      if info and info.ratio then
        self:changeDir(info)
        self:applyRatio(info)
      end
    end
  }
end

function this:open()
  return
end

function this:initParam(params)
  this.super.initParam(self, params)
  self.modulePhotoSizeHandle = self.modules.modulePhotoSizeHandle
  self.handleRect = self.modulePhotoSizeHandle.gameObject:GetComponent(typeof(C_RectTransform))
  self:initInfo()
  self:initList()
  self.modulePhotoSizeHandle.gameObject.transform:SetParent(self.imgRoot)
  self.modulePhotoSizeHandle:initRef({
    imgRoot = self.imgRoot,
    photoRect = self.photoRect
  })
  self.bind.curId = 2
  self.modulePhotoSizeHandle:syncRectMask()
  self.photoMask.enabled = false
  if self.maskRect ~= nil then
    self.maskRect.gameObject:SetActive(true)
  end
  self.isHorizontal = true
end

function this:show()
  self.modules.modulePhotoSizeHandle.gameObject:SetActive(true)
  if self.isInit then
    self.bind.curId = 2
  end
  if self.photoMask then
    self.photoMask.enabled = false
  end
  if self.maskRect ~= nil then
    self.maskRect.gameObject:SetActive(true)
  end
  self.parent:syncBgFrameFull()
end

function this:hide()
  self.modules.modulePhotoSizeHandle.gameObject:SetActive(false)
  self.bind.curId = 0
end

function this:initList()
  local list = {}
  for i, v in pairs(self.sizeInfo) do
    local temp = {
      txt_name = v.name,
      txt_nameOn = v.name,
      tabId = v.id,
      tabGroup = self.bindComponents.tabGroup,
      img = v.icon
    }
    table.insert(list, temp)
  end
  self.bind.sizeList:clear()
  self.bind.sizeList:insert_array(list)
end

function this:initInfo()
  self.sizeInfo = {
    [1] = {
      id = 1,
      name = L_WordsTpl:getValue("residual_code_modulephotoedit_resize_01"),
      onClick = function(self)
        self:resetSize()
        self.bind.curId = 2
      end,
      icon = "UI/Atlas/PhotoEdit/tex_photo_icon_06.png"
    },
    [2] = {
      id = 2,
      name = L_WordsTpl:getValue("residual_code_modulephotoedit_resize_02"),
      onClick = function(self)
      end,
      isFree = true,
      icon = "UI/Atlas/PhotoEdit/tex_photo_icon_07.png"
    },
    [3] = {
      id = 3,
      name = "1:1",
      onClick = function(self)
      end,
      ratio = {x = 1, y = 1},
      icon = "UI/Atlas/PhotoEdit/tex_photo_frame_03_34_34.png"
    },
    [4] = {
      id = 4,
      name = "3:2",
      onClick = function(self)
      end,
      ratio = {x = 3, y = 2},
      icon = "UI/Atlas/PhotoEdit/tex_photo_frame_06_44_32.png"
    },
    [5] = {
      id = 5,
      name = "4:3",
      onClick = function(self)
      end,
      ratio = {x = 4, y = 3},
      icon = "UI/Atlas/PhotoEdit/tex_photo_frame_08_44_34.png"
    },
    [6] = {
      id = 6,
      name = "16:9",
      onClick = function(self)
      end,
      ratio = {x = 16, y = 9},
      icon = "UI/Atlas/PhotoEdit/tex_photo_frame_07_58_34.png"
    }
  }
end

function this:onHandleSizeChange()
  local rect = self.handleRect
  local pivot = rect.pivot
  local offset = (pivot - C_Vector2(0.5, 0.5)) * rect.sizeDelta
  self.maskRect.localPosition = rect.localPosition - C_Vector3(offset.x, offset.y, 0)
  self.maskRect.sizeDelta = rect.sizeDelta
end

function this:onDragImageBegin(screenPos)
  do return end
  if not self.isShow then
    self.isDraggingImg = false
    return
  end
  local uiCamera = C_CameraManager.uiCamera
  local isIn = C_RectTransformUtility.RectangleContainsScreenPoint(self.modulePhotoSizeHandle.rectTransform, screenPos, uiCamera)
  self.isDraggingImg = not isIn
  self.lastScreenPos = screenPos
end

function this:onDragImage(screenPos, imgRect)
  do return end
  if not self.isDraggingImg then
    return
  end
  local prePos = L_GameUtil.spToLpInRectangle(imgRect.parent, self.lastScreenPos)
  local curPos = L_GameUtil.spToLpInRectangle(imgRect.parent, screenPos)
  self.lastScreenPos = screenPos
  local offset = curPos - prePos
  local finalPos = imgRect.localPosition + offset
  local handleRect = self.modulePhotoSizeHandle.rectTransform
  local handleTopLeft = handleRect.anchoredPosition + C_Vector2(-handleRect.rect.width / 2, handleRect.rect.height / 2)
  local limitTopLeft = handleTopLeft + C_Vector2(imgRect.rect.width / 2, -imgRect.rect.height / 2)
  local handleBottomRight = handleRect.anchoredPosition + C_Vector2(handleRect.rect.width / 2, -handleRect.rect.height / 2)
  local limitBottomRight = handleBottomRight + C_Vector2(-imgRect.rect.width / 2, imgRect.rect.height / 2)
  local maxX = limitTopLeft.x
  local minX = limitBottomRight.x
  local maxY = limitBottomRight.y
  local minY = limitTopLeft.y
  finalPos.x = math.clamp(finalPos.x, minX, maxX)
  finalPos.y = math.clamp(finalPos.y, minY, maxY)
  imgRect.localPosition = finalPos
end

function this:onDragImageEnd()
  do return end
  self.isDraggingImg = false
end

function this:applyRatio(info)
  local ratio = info.ratio
  if ratio ~= nil then
    self.modulePhotoSizeHandle:applyRatio(ratio)
  end
end

function this:changeDir(info)
  if info.ratio then
    if self.isHorizontal then
      if info.ratio.x < info.ratio.y then
        info.ratio.x, info.ratio.y = info.ratio.y, info.ratio.x
      end
    elseif info.ratio.x > info.ratio.y then
      info.ratio.x, info.ratio.y = info.ratio.y, info.ratio.x
    end
  end
end

function this:resetSize()
  self.photoRect.anchoredPosition = C_Vector2.zero
  self.modulePhotoSizeHandle:syncRectMask()
end

function this:onSave()
  self:syncPhotoMask()
  self.modulePhotoSizeHandle.gameObject:SetActive(false)
end

function this:onDragHandle()
end

function this:refresh()
end

function this:close()
  self.super.close(self)
end

return this
