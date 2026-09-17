local this = class("modulePhotoTextHandle", G_UIModuleBase)
local _dir = {
  rb = 1,
  rt = 2,
  lb = 3,
  lt = 4
}

function this.bind()
  return {activeAlineH = nil, activeAlineV = nil}
end

function this.methods()
  return {
    onDrag = function(self, screenPos)
      self:onDrag(screenPos)
    end,
    onBeginDrag = function(self, screenPos)
      self.lastScreenPos = screenPos
    end,
    onDragHandle = function(self, screenPos)
      self:onDragHandle(screenPos, _dir.lb)
    end,
    onBeginDragHandle = function(self, screenPos)
      self.lastScreenPos = screenPos
    end,
    onDragHandleLT = function(self, screenPos)
      self:onDragHandle(screenPos, _dir.lt)
    end,
    onBeginDragHandleLT = function(self, screenPos)
      self.lastScreenPos = screenPos
    end,
    onDragHandleRT = function(self, screenPos)
      self:onDragHandle(screenPos, _dir.rt)
    end,
    onBeginDragHandleRT = function(self, screenPos)
      self.lastScreenPos = screenPos
    end,
    onDragHandleRB = function(self, screenPos)
      self:onDragHandle(screenPos, _dir.rb)
    end,
    onBeginDragHandleRB = function(self, screenPos)
      self.lastScreenPos = screenPos
    end,
    onClickDel = function(self)
      self:emit("onClickDel", self.bindRect)
    end,
    onClickAlign = function(self)
      self:switchAlign()
    end,
    onClickEdit = function(self)
      self:editText()
    end
  }
end

function this:open()
  self.rectTransform = self.gameObject:GetComponent(typeof(C_RectTransform))
  self.bindComponents.btnDrag.DragObjParent = self.rectTransform.parent
end

function this:bindTextRect(uiRect, textComponent, bgRect)
  self.bindRect = uiRect
  self.textComponent = textComponent
  self.text = textComponent.text
  self.textRect = textComponent.gameObject:GetComponent(typeof(C_RectTransform))
  self.bgRect = bgRect
  self.isHorizontal = true
  self.bind.activeAlineH = not self.isHorizontal
  self.bind.activeAlineV = self.isHorizontal
  self:reSizeByText()
  self:syncSize()
  self.rectTransform:SetAsLastSibling()
end

function this:setActive(b)
  self.gameObject:SetActive(b)
end

function this:onDrag(screenPos, dir)
  if self.lastScreenPos == nil then
    self.lastScreenPos = screenPos
    return
  end
  local prePos = L_GameUtil.spToLpInRectangle(self.rectTransform.parent, self.lastScreenPos)
  local curPos = L_GameUtil.spToLpInRectangle(self.rectTransform.parent, screenPos)
  local offset = curPos - prePos
  local targetPos = self.rectTransform.localPosition + offset
  local sizeLimit = self.rectTransform.parent.rect.size
  targetPos.x = math.clamp(targetPos.x, -sizeLimit.x / 2, sizeLimit.x / 2)
  targetPos.y = math.clamp(targetPos.y, -sizeLimit.y / 2, sizeLimit.y / 2)
  self.rectTransform.localPosition = targetPos
  self.bindRect.localPosition = targetPos
  self.lastScreenPos = screenPos
end

function this:onDragHandle(screenPos, dir)
  if self.lastScreenPos == nil then
    self.lastScreenPos = screenPos
    return
  end
  local prePos = L_GameUtil.spToLpInRectangle(self.rectTransform.parent, self.lastScreenPos)
  local curPos = L_GameUtil.spToLpInRectangle(self.rectTransform.parent, screenPos)
  local offset
  if dir == _dir.lb or dir == nil then
    offset = curPos - prePos
  elseif dir == _dir.lt then
    offset = C_Vector2(curPos.x - prePos.x, prePos.y - curPos.y)
  elseif dir == _dir.rt then
    offset = C_Vector2(prePos.x - curPos.x, prePos.y - curPos.y)
  elseif dir == _dir.rb then
    offset = C_Vector2(prePos.x - curPos.x, curPos.y - prePos.y)
  end
  offset.x = -offset.x * 2
  offset.y = -offset.y * 2
  local curSize = self.rectTransform.sizeDelta
  if not self.isHorizontal then
  end
  local ratio = curSize.x / curSize.y
  local targetSize = curSize + offset
  if math.abs(offset.x) > math.abs(offset.y) then
    targetSize.y = targetSize.x / ratio
  else
    targetSize.x = targetSize.y * ratio
  end
  local maxSize = C_Vector2(self.oriX, self.oriY) * 2.5
  local minSize = C_Vector2(self.oriX, self.oriY)
  if not self.isHorizontal then
    local x, y = minSize.x, minSize.y
    x, y = y, x
    minSize.x = x
    minSize.y = y
    x, y = maxSize.x, maxSize.y
    x, y = y, x
    maxSize.x = x
    maxSize.y = y
  end
  targetSize.x = math.clamp(targetSize.x, minSize.x, maxSize.x)
  targetSize.y = math.clamp(targetSize.y, minSize.y, maxSize.y)
  self.rectTransform.sizeDelta = targetSize
  local targetScale
  if self.isHorizontal then
    targetScale = C_Vector3(targetSize.x / self.oriX, targetSize.y / self.oriY, 1)
  else
    targetScale = C_Vector3(targetSize.y / self.oriX, targetSize.x / self.oriY, 1)
  end
  self.bindRect.localScale = targetScale
  self.lastScreenPos = screenPos
end

function this:editText()
  local data = {
    txtTitle = L_WordsTpl:getValue("residual_code_modulephototexthandle_01"),
    placeHolder = L_WordsTpl:getValue("residual_code_modulephototexthandle_01"),
    txtContent = self.text,
    limit = 7,
    tip = L_WordsTpl:getValue("residual_code_modulephototexthandle_01"),
    keepPageOpen = true,
    textBoxType = L_Const.CommonTextBoxType.Rename,
    unicodeWhiteLevel = 0,
    confirmCallback = function(txt)
      local isCn = string.match(txt, "^[€-ÿ]*$")
      if not isCn then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_modulephototexthandle_04"))
        return
      end
      if self.lastCheckText and self.lastCheckText ~= "" and txt == self.lastCheckText then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_photo_illegal_message"))
        return
      end
      L_Net:sendMessage(MsgGenCode.CSProtoGeneralDirtyCheck, {data_info = txt}, function(rsp_data, errorCode)
        if errorCode ~= 0 then
          self.lastCheckText = txt
          return
        end
        self.lastCheckText = nil
        self.text = txt
        if not self.isHorizontal then
          txt = string.format("<rotate=90>%s", txt)
        end
        self.textComponent.text = txt
        self:reSizeByText()
        self:syncSize()
        L_UI:close("pageCommonTextBox")
      end)
    end
  }
  L_GameUtil.showNormalTextBox(data)
end

function this:switchAlign()
  self.isHorizontal = not self.isHorizontal
  local text = self.text
  if not self.isHorizontal then
    text = string.format("<rotate=90>%s", text)
    self.bindRect.localRotation = C_Quaternion.Euler(0, 0, -90)
  else
    self.bindRect.localRotation = C_Quaternion.identity
  end
  self.textComponent.text = text
  self:reSizeByText()
  self:syncSize()
  self.bind.activeAlineH = not self.isHorizontal
  self.bind.activeAlineV = self.isHorizontal
end

function this:reSizeByText()
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.textRect)
  local textSize = self.textRect.sizeDelta
  if textSize == C_Vector2.zero then
    textSize = C_Vector2(50, 50)
  end
  self.bgRect.sizeDelta = textSize * 1.1
  self.bindRect.sizeDelta = textSize * 1.1
end

function this:syncSize()
  self.rectTransform.localPosition = self.bindRect.localPosition
  self.oriRectSize = C_Vector2(self.bindRect.rect.size.x, self.bindRect.rect.size.y)
  self.oriX = self.bindRect.rect.size.x
  self.oriY = self.bindRect.rect.size.y
  if self.isHorizontal then
    self.rectTransform.sizeDelta = self.oriRectSize * self.bindRect.localScale.x
  else
    self.rectTransform.sizeDelta = C_Vector2(self.oriRectSize.y, self.oriRectSize.x) * self.bindRect.localScale.x
  end
end

function this:close()
end

return this
