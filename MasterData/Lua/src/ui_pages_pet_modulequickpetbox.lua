local module = class("moduleQuickPetBox", G_UIModuleBase)
local NEXT_BOX_HOVER_INTERVAL = 0.5
local QUICK_BOX_SCROLL_DURATION = 0.5

function module:ctor(...)
  module.super.ctor(self, ...)
  self.isInFilter = false
end

function module.bind()
  return {
    listBox = {
      moduleName = "pages/pet/cellQuickBoxItem"
    }
  }
end

function module.methods()
  return {
    onPointEnter_hitArea = function(self)
      self:setReleaseAreaHover(true)
    end,
    onPointExit_hitArea = function(self)
      self:setReleaseAreaHover(false)
    end,
    onClick = function(self)
    end,
    onPointEnter_next = function(self)
      self:createNextBoxHoverTimer()
    end,
    onPointExit_next = function(self)
      self:killNextBoxHoverTimer()
    end
  }
end

function module:getPagePetBox()
  local parent = self.parent
  while parent do
    if parent.setDragOverReleaseArea or parent.handleDragToRelease then
      return parent
    end
    parent = parent.parent
  end
end

function module:setReleaseAreaHover(isHover)
  local pagePetBox = self:getPagePetBox()
  if not pagePetBox then
    return
  end
  if pagePetBox.setDragOverReleaseArea then
    pagePetBox:setDragOverReleaseArea(isHover)
  else
    pagePetBox._isDragOverReleaseArea = isHover
  end
  if isHover and pagePetBox.clearBoxSelection then
    pagePetBox:clearBoxSelection()
  end
end

function module:canHoverTurnNextBox(pagePetBox)
  if not pagePetBox or not pagePetBox.isDraggingPet then
    return false
  end
  return pagePetBox:isDraggingPet()
end

function module:createNextBoxHoverTimer()
  self:killNextBoxHoverTimer()
  local pagePetBox = self:getPagePetBox()
  local canHover = self:canHoverTurnNextBox(pagePetBox)
  if not canHover then
    return
  end
  self.nextBoxHoverTimer = Timer.once(NEXT_BOX_HOVER_INTERVAL, function()
    local curPagePetBox = self:getPagePetBox()
    local canHoverNow = self:canHoverTurnNextBox(curPagePetBox)
    if not canHoverNow then
      self:killNextBoxHoverTimer()
      return
    end
    self:scrollQuickBoxListToEnd()
    self.nextBoxHoverTimer = nil
  end, self)
end

function module:killNextBoxHoverTimer()
  if self.nextBoxHoverTimer then
    Timer.remove(self.nextBoxHoverTimer)
    self.nextBoxHoverTimer = nil
  end
end

function module:getQuickBoxListTransform()
  if L_CommonUtil.isValid(self._quickBoxListTransform) then
    return self._quickBoxListTransform
  end
  if self.gameObject then
    self._quickBoxListTransform = self.gameObject.transform:Find("bottom/listBox")
  end
  return self._quickBoxListTransform
end

function module:getQuickBoxListLayout()
  if self._quickBoxListLayout then
    return self._quickBoxListLayout
  end
  local listTrans = self:getQuickBoxListTransform()
  if listTrans then
    self._quickBoxListLayout = listTrans.gameObject:GetComponent("HorizontalLayoutGroup")
  end
  return self._quickBoxListLayout
end

function module:getQuickBoxCellWidth()
  if self.modules and self.modules.listBox then
    for _, cellModule in ipairs(self.modules.listBox) do
      if cellModule and cellModule.gameObject then
        return cellModule.gameObject.transform.rect.width
      end
    end
  end
  return 100
end

function module:calcQuickBoxScrollEndPaddingLeft()
  local listTrans = self:getQuickBoxListTransform()
  local layout = self:getQuickBoxListLayout()
  local boxCount = self.bind.listBox and #self.bind.listBox or 0
  if not (listTrans and layout) or boxCount <= 0 then
    return nil
  end
  local spacing = layout.spacing
  local childWidth = self:getQuickBoxCellWidth()
  local contentWidth = layout.padding.right + boxCount * childWidth + math.max(0, boxCount - 1) * spacing
  local viewportWidth = listTrans.rect.width
  local maxScroll = math.max(0, contentWidth - viewportWidth)
  return -maxScroll, contentWidth, viewportWidth, maxScroll
end

function module:killQuickBoxScrollTween()
  if self._quickBoxScrollTween then
    self._quickBoxScrollTween:Kill()
    self._quickBoxScrollTween = nil
  end
end

function module:setQuickBoxListPaddingLeft(value)
  local layout = self:getQuickBoxListLayout()
  local listTrans = self:getQuickBoxListTransform()
  if not layout or not listTrans then
    return nil
  end
  local padding = layout.padding
  padding.left = math.floor(value + 0.5)
  layout.padding = padding
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(listTrans)
  return layout.padding.left
end

function module:resetQuickBoxListScroll()
  self:killQuickBoxScrollTween()
  self:setQuickBoxListPaddingLeft(0)
end

function module:scrollQuickBoxListToEnd()
  local layout = self:getQuickBoxListLayout()
  local listTrans = self:getQuickBoxListTransform()
  local targetPaddingLeft, _, _, maxScroll = self:calcQuickBoxScrollEndPaddingLeft()
  if not (layout and listTrans) or targetPaddingLeft == nil then
    return
  end
  if maxScroll <= 0 then
    return
  end
  local pagePetBox = self:getPagePetBox()
  if pagePetBox and pagePetBox.clearBoxSelection then
    pagePetBox:clearBoxSelection()
  end
  self:killQuickBoxScrollTween()
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(listTrans)
  
  local function getter()
    return layout.padding.left
  end
  
  local function setter(value)
    self:setQuickBoxListPaddingLeft(value)
  end
  
  self._quickBoxScrollTween = DOTween.To(getter, setter, targetPaddingLeft, QUICK_BOX_SCROLL_DURATION)
end

function module:open()
  self:resetQuickBoxListScroll()
  self:initBoxList()
end

function module:getBoxCountAndTotal(boxIndex)
  local boxPets = L_PetStore:getPetBoxList(boxIndex) or {}
  local petCount = 0
  for _, guid in ipairs(boxPets) do
    if not math.isEmpty(guid) then
      petCount = petCount + 1
    end
  end
  return petCount, #boxPets
end

function module:initBoxList()
  local tmp = {}
  local petBoxNum = L_PetStore:getPetBoxNum()
  for i = 1, petBoxNum do
    local isFull = L_PetStore:getPetBoxIsFull(i)
    local petCount, totalSlots = self:getBoxCountAndTotal(i)
    table.insert(tmp, {
      boxIndex = i,
      isFull = isFull,
      petCount = petCount,
      totalSlots = totalSlots,
      isInFilter = self.isInFilter
    })
  end
  self.bind.listBox:clear()
  self.bind.listBox:insert_array(tmp)
end

function module:setFilterMode(isInFilter)
  self.isInFilter = isInFilter
  if self.modules and self.modules.listBox then
    for i, cellModule in ipairs(self.modules.listBox) do
      if cellModule and cellModule.setFilterMode then
        cellModule:setFilterMode(isInFilter)
      end
    end
  end
end

function module:clearSelection()
  if not self.modules or not self.modules.listBox then
    return
  end
  for i, module in ipairs(self.modules.listBox) do
    if module.setSelected then
      module:setSelected(false)
    end
  end
end

function module:getHover(go)
  if not self.modules or not self.modules.listBox then
    return
  end
  for i, module in ipairs(self.modules.listBox) do
    if module.bindComponents and module.bindComponents.hitArea and go == module.bindComponents.hitArea.gameObject then
      return i
    end
  end
  return nil
end

function module:fadeIn()
  if not self.isBind then
    return
  end
  self:killNextBoxHoverTimer()
  self:resetQuickBoxListScroll()
  self.bindComponents.anim:Play("anim_modulePetBoxQuick_in")
end

function module:fadeOut()
  self:killNextBoxHoverTimer()
  self:killQuickBoxScrollTween()
  if self.isBind then
    self.bindComponents.anim:Play("anim_modulePetBoxQuick_out")
  end
end

function module:close()
  self:killNextBoxHoverTimer()
  self:killQuickBoxScrollTween()
end

function module:show()
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetBox, self.onEvent_refreshPetBox, self)
end

function module:hide()
  self:killNextBoxHoverTimer()
  self:killQuickBoxScrollTween()
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetBox, self.onEvent_refreshPetBox, self)
end

function module:onEvent_refreshPetBox()
  if not self.isBind then
    return
  end
  for i, module in ipairs(self.modules.listBox) do
    if module then
      local petCount, totalSlots = self:getBoxCountAndTotal(i)
      module:refresh({
        isFull = L_PetStore:getPetBoxIsFull(i),
        petCount = petCount,
        totalSlots = totalSlots,
        isInFilter = self.isInFilter
      })
    end
  end
end

return module
