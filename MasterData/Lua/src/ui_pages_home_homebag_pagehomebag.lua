local this = class("pageHomeBag", G_UIPageBase)
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _BlockTpl = L_GameTpl:getHomeBlockTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local DragAreaType = {BELT = 1, BAG = 2}
local GamepadOprationType = {
  NORMAL = 0,
  BAG_REPLACE = 1,
  BELT_CHOOSE = 2,
  BELT_REPLACE = 3
}

function this.bind()
  return {
    txt_title = "",
    grid_bag = L_Const.ModuleInfo.CellIconBag,
    enabled_scrollBag = true,
    verticalNormalizedPosition = 0,
    active_empty = false,
    txt_empty = "",
    active_buildInfo = false,
    active_seedInfo = false,
    module_buildInfo = {
      moduleName = "pages/home/homeBag/moduleHomeBagBuildInfo"
    },
    module_cropInfo = {
      moduleName = "pages/home/homeBag/moduleHomeBagCropInfo"
    },
    module_belt = {
      moduleName = "pages/home/homeBag/moduleHomeBeltPlatform"
    },
    img_drag = ""
  }
end

function this.methods()
  return {
    onClick_close = function()
      L_UI:close("pageHomeBag")
    end
  }
end

local TagId2ShortBar = {
  [L_Const.commonTag.HOME_BUILDING] = L_Const.HomeShortcutBarType.HSBT_BUILD,
  [L_Const.commonTag.HOME_SEED] = L_Const.HomeShortcutBarType.HSBT_CROP
}
local BuildingTag = L_Const.commonTag.HOME_BUILDING
local SeedTag = L_Const.commonTag.HOME_SEED

function this:preOpen()
  self:endDrag()
  self._bagItems = {}
  self:configTouch("+")
  self.refresViewHandle = handler(self, self.refresView)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.refresViewHandle)
  L_HomeStore:listenCallFunc(L_HomeStore.event.refreshBuildingBag, self.refresView, self)
  self.moduleTag = BuildingTag
  local buildGuid = L_HomeManager:getCurrInteractId()
  local buildingEntity = AzurWorld.HomeMgr and AzurWorld.HomeMgr:GetHomeBuild(buildGuid)
  if buildingEntity and (buildingEntity:GetStoreData():GetGroupConfig().type == 15 or buildingEntity:GetStoreData():GetGroupConfig().type == 19) then
    self.moduleTag = SeedTag
  else
    self.moduleTag = BuildingTag
  end
  self.firstInit = true
  self.onNavigateHandle = self.onNavigateHandle or L_CommonUtil.handle(self.onNavigate, self)
  C_InputManager.AddAxisListener(L_Const.axisType.eNavigate, self.onNavigateHandle)
  self.controlSchemeChangeHandle = self.controlSchemeChangeHandle or handler(self, self.onControlSchemeChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.ControlSchemeChange, self.controlSchemeChangeHandle)
end

function this:show()
  self._isLongDrag = false
  self._isDragging = false
  self.modules.module_belt:registerShortCut(self.pageName)
  self:registerShortcuts()
  self:onSelectTabId(self.moduleTag)
  self:resetGamepadParams()
end

function this:onSelectTabId(tabId)
  self._beltType = TagId2ShortBar[tabId]
  self._selectIndex = 0
  self:refresView()
  self.bind.verticalNormalizedPosition = 1
end

function this:close()
  self:configTouch("-")
  self._isLongDrag = nil
  self._isDragging = nil
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.refresViewHandle)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshBuildingBag, self.refresView, self)
  L_TimerManager:clearTimer(self)
  C_InputManager.RemoveAxisListener(L_Const.axisType.eNavigate, self.onNavigateHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.ControlSchemeChange, self.controlSchemeChangeHandle)
end

function this:escHandle()
  if C_InputManager.IsEnableGamePad and (self._gamepadOperationType ~= GamepadOprationType.NORMAL or self._isFocusBelt) then
    self:handleGamepadEsc()
    return
  end
  L_UI:close(self.pageName)
end

function this:refresView()
  self.bind.txt_title = self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD and L_WordsTpl:getValue("notice_homeProduction_14") or L_WordsTpl:getValue("notice_homeProduction_15")
  self._bagItems = {}
  if self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD then
    local bagHomeItems = L_HomeStore:getAllBagBuilding()
    for _, v in pairs(bagHomeItems) do
      local num = v.total_num - v.used_num
      if 0 < num then
        local tpl = _homeBuildingTpl:getTplById(v.build_id)
        local stackNum = _homeBuildingTpl:getStackNum(tpl)
        if 0 < stackNum then
          while 0 < num do
            table.insert(self._bagItems, {
              build_id = v.build_id,
              num = math.min(stackNum, num)
            })
            num = num - stackNum
          end
        else
          table.insert(self._bagItems, {
            build_id = v.build_id,
            num = num
          })
        end
      end
    end
  elseif self._beltType == L_Const.HomeShortcutBarType.HSBT_CROP then
    local allItems = C_BagMgr:getAllItem()
    for id, v in pairs(allItems) do
      if _homeSeedTpl:getIsSeed(id) then
        local batches = C_BagMgr:GetStackCommonItemData(id)
        for i = 0, batches.Count - 1 do
          local num = batches[i]
          if 0 < num then
            table.insert(self._bagItems, {item_id = id, num = num})
          end
        end
      end
    end
  end
  local colNum = L_DeviceTpl:getIsPc() and 9 or 8
  local bagBoxNum = math.max(math.ceil(#self._bagItems / colNum) * colNum, colNum * 6)
  if #self.modules.grid_bag ~= bagBoxNum then
    self.bind.grid_bag:clear()
    self.bind.grid_bag:insert_array(L_DataUtil.getEmptyModuleDatas(bagBoxNum))
  end
  for i, module in ipairs(self.modules.grid_bag) do
    if self._bagItems[i] then
      local img = ""
      local conf, itemid, itemType
      if self._bagItems[i].item_id then
        itemid = self._bagItems[i].item_id
        itemType = L_Const.resType.commonItem
        conf = L_ItemTplManager:getCommonItem(self._bagItems[i].item_id)
        img = conf.icon
      elseif self._bagItems[i].build_id then
        itemid = self._bagItems[i].build_id
        itemType = L_Const.resType.warehouse
        conf = L_ItemTplManager:getBuildingItem(self._bagItems[i].build_id)
        img = conf.icon
      end
      module:setDataContent(itemType, nil, itemid, {
        itemNum = self._bagItems[i].num,
        icon = img,
        callback = function()
          self:onSelectItem(i)
        end,
        noTip = true
      })
    else
      module:setGeneralContent(L_Const.resType.warehouse, nil, nil)
    end
    module:setQualityLineActive(self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD)
  end
  self.modules.module_belt:setBelt(self._beltType, false, {
    onClickCell = function(index)
      self:onBeltClick(index)
    end
  })
  self:refreshSelect()
  if self.firstInit == true then
    self.firstInit = false
    FrameScheduler.add(function()
      self:refresView()
    end, 1)
  end
end

function this:onBeltClick(index)
  self:endDrag()
end

function this:onSelectItem(index)
  local targetItem = self._bagItems[index]
  if not targetItem then
    return
  end
  if self._selectIndex ~= index then
    self._selectIndex = index
    self:refreshSelect(true)
  end
end

function this:refreshSelect(forceAni)
  if math.isEmpty(self._selectIndex) and #self._bagItems > 0 then
    self._selectIndex = 1
  end
  self.bind.active_empty = math.isEmpty(self._selectIndex)
  for i, module in ipairs(self.modules.grid_bag) do
    module:setSel(self._bagItems[self._selectIndex] and self._selectIndex == i or false)
  end
  local targetItem = self._bagItems[self._selectIndex]
  self.bind.txt_empty = self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD and L_WordsTpl:getValue("notice_homeProduction_16") or L_WordsTpl:getValue("notice_homeProduction_17")
  self.bind.active_buildInfo = targetItem ~= nil and self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD
  self.bind.active_seedInfo = targetItem ~= nil and self._beltType == L_Const.HomeShortcutBarType.HSBT_CROP
  if targetItem then
    if self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD then
      self.modules.module_buildInfo:setBuildId(targetItem.build_id, self._lastTarget == nil, forceAni)
    elseif self._beltType == L_Const.HomeShortcutBarType.HSBT_CROP then
      self.modules.module_cropInfo:setSeedId(targetItem.item_id, self._lastTarget == nil, forceAni)
    end
  end
  self._lastTarget = targetItem
end

function this:endDrag()
  if C_InputManager.IsEnableGamePad then
    return
  end
  self._holdType, self._holdId = nil, nil
  self.bindComponents.rect_drag.gameObject:ActiveTrans(false)
  self.bind.enabled_scrollBag = true
end

function this:getHoldInfo(go, beltTarget)
  if beltTarget then
    local res = self.modules.module_belt:checkRaycastGo(go)
    if res then
      return DragAreaType.BELT, res
    end
  else
    for i, module in ipairs(self.modules.grid_bag) do
      if module:getRaycastGo() == go then
        return DragAreaType.BAG, i
      end
    end
  end
end

function this:configTouch(operator)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  self.onUIClickHandle = self.onUIClickHandle or L_CommonUtil.handle(self.onUI_clickHandle, self)
  C_ScreenTouch.OnUI_Click(operator, self.onUIClickHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
  self.onUILongTapStartHandle = self.onUILongTapStartHandle or L_CommonUtil.handle(self.onUILongTapStart, self)
  self.onUILongTapEndHandle = self.onUILongTapEndHandle or L_CommonUtil.handle(self.onUILongTapEnd, self)
  C_ScreenTouch.OnUI_LongTapStart(operator, self.onUILongTapStartHandle)
  C_ScreenTouch.OnUI_LongTapEnd(operator, self.onUILongTapEndHandle)
end

function this:onUILongTapStart(gesture)
  if self._isLongDrag then
    return
  end
  local go = gesture.go
  local holdType, holdId = self:getHoldInfo(go, false)
  if not holdType then
    return
  end
  if holdType == DragAreaType.BAG and not self._bagItems[holdId] then
    return
  end
  local beltIds = table.clone(L_HomeStore:getBeltItems(self._beltType))
  if holdType == DragAreaType.BELT and math.isEmpty(beltIds[holdId]) then
    return
  end
  local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  if not self.isBind then
    return
  end
  self._holdType, self._holdId = holdType, holdId
  if holdType == DragAreaType.BAG then
    self:onSelectItem(holdId)
    local itemData = self._bagItems[holdId]
    if self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD then
      local tpl = _homeBuildingTpl:getTplById(itemData.build_id)
      self.bind.img_drag = _homeBuildingTpl:getBuildIcon(tpl)
    elseif self._beltType == L_Const.HomeShortcutBarType.HSBT_CROP then
      self.bind.img_drag = L_ItemTplManager:getCommonItem(itemData.item_id).icon
    end
    self.bindComponents.rect_drag.gameObject:ActiveTrans(true)
    L_Vector3.setAnchored(self.bindComponents.rect_drag, touchPos)
  elseif holdType == DragAreaType.BELT then
  end
  self.bind.enabled_scrollBag = false
  self._isLongDrag = true
end

function this:onUILongTapEnd(gesture)
  self:onUI_dragEndHandle(gesture)
end

function this:onUI_clickHandle(gesture)
  self:endDrag()
end

function this:onUI_dragHandle(gesture)
  if not self._isLongDrag then
    return
  end
  local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_Vector3.setAnchored(self.bindComponents.rect_drag, touchPos)
end

function this:onUI_dragEndHandle(gesture)
  if not self._isLongDrag then
    return
  end
  self._isLongDrag = false
  local go = gesture:GetCurrentFirstPickedUIElement()
  if self._holdId then
    local holdType, holdId = self:getHoldInfo(go, true)
    self:handleDragEffect(self._holdType, self._holdId, holdType, holdId)
  end
  self:endDrag()
end

function this:handleDragEffect(fromType, fromId, toType, toId, callback)
  local beltIds = table.clone(L_HomeStore:getBeltItems(self._beltType))
  if fromType == DragAreaType.BELT then
    if toType == DragAreaType.BELT then
      beltIds[fromId], beltIds[toId] = beltIds[toId], beltIds[fromId]
    else
      beltIds[fromId] = 0
    end
  elseif fromType == DragAreaType.BAG and toType == DragAreaType.BELT then
    local itemData = self._bagItems[fromId]
    local tarId = 0
    if itemData then
      if self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD then
        tarId = itemData.build_id
      elseif self._beltType == L_Const.HomeShortcutBarType.HSBT_CROP then
        tarId = itemData.item_id
      end
    end
    for i, id in ipairs(beltIds) do
      if id == tarId then
        beltIds[i] = 0
      end
    end
    beltIds[toId] = tarId
  end
  L_HomeStore:req_changeBelt(self._beltType, beltIds, callback)
end

function this:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.homeBag)
  local currBlockId, currGridId = AzurWorld.HomeMgr:GetInteractBlockIdAndGridIdWithPlayerByOffset()
  local blockTpl = _BlockTpl:getTplById(currBlockId)
  if blockTpl and _BlockTpl:getBlockType(blockTpl) == L_HomeConst.blockType.BUILD then
    callback(C_HomeUtil.GetIsBlockUnlock(currBlockId) and result)
    return
  end
  callback(false)
end

function this:registerShortcuts()
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EItemBarPrevPage, function()
    if not self:CanBeltInput() then
      return
    end
    self.modules.module_belt:changeLastPage()
    self:refreshBottomInfo()
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EItemBarNextPage, function()
    if not self:CanBeltInput() then
      return
    end
    self.modules.module_belt:changeNextPage()
    self:refreshBottomInfo()
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EItemBarPrevItem, function()
    if not self:CanBeltInput() then
      return
    end
    self:syncFloatIconPos()
    self:refreshBottomInfo()
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EItemBarNextItem, function()
    if not self:CanBeltInput() then
      return
    end
    self:syncFloatIconPos()
    self:refreshBottomInfo()
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageHomeBagSwitchArea, function()
    if not self:checkIsGamepad() or self._gamepadOperationType ~= GamepadOprationType.NORMAL then
      return
    end
    self._isFocusBelt = not self._isFocusBelt
    self.modules.module_belt:setGamepadTipsActive(self._isFocusBelt)
    if self._isFocusBelt then
      self.bindComponents.nav_binding:SelectArea("AreaBelt")
      self.bindComponents.input_binding.inputEnabled = false
    else
      self.bindComponents.nav_binding:SelectArea("AreaBag")
      self.bindComponents.input_binding.inputEnabled = true
    end
    self:refreshBottomInfo()
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageHomeBagPlace, function()
    if not self:checkIsGamepad() or not self._isFocusBelt then
      return
    end
    if self._gamepadOperationType == GamepadOprationType.NORMAL or self._gamepadOperationType == GamepadOprationType.BELT_REPLACE then
      if self._gamepadOperationType == GamepadOprationType.BELT_REPLACE then
        self:clearOperationStatus()
      else
        self._gamepadOperationType = GamepadOprationType.BELT_REPLACE
        local beltSelectedIdx, beltCell = self:getBletSelectedSlotIndex()
        if beltSelectedIdx ~= nil and beltCell ~= nil then
          local icon = beltCell.bind.img_icon
          self._beltSelectedIdx = beltSelectedIdx
          self._beltCell = beltCell
          self._beltCell:setAlpha(0.5)
          self:SetFloatIconEnabled(true, icon)
          self:syncFloatIconPos(beltCell:getRaycastGo())
        end
      end
      self:refreshBottomInfo()
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ESubmit, function()
    if not self:checkIsGamepad() then
      return
    end
    if self._gamepadOperationType == GamepadOprationType.BAG_REPLACE then
      local beltSelectedIdx = self:getBletSelectedSlotIndex()
      if beltSelectedIdx ~= nil and self._bagSelectedIdx ~= nil then
        if self._bagCell ~= nil then
          self._bagCell:setAlpha(1)
        end
        self:handleDragEffect(DragAreaType.BAG, self._bagSelectedIdx, DragAreaType.BELT, beltSelectedIdx, self:handleDragCallback())
      end
      self:clearOperationStatus()
    elseif self._gamepadOperationType == GamepadOprationType.BELT_CHOOSE then
      if self._bagSelectedIdx ~= nil and self._beltSelectedIdx ~= nil then
        if self._beltCell ~= nil then
          self._beltCell:setAlpha(1)
        end
        self:handleDragEffect(DragAreaType.BAG, self._bagSelectedIdx, DragAreaType.BELT, self._beltSelectedIdx, self:handleDragCallback())
      end
      self:clearOperationStatus()
    elseif self._gamepadOperationType == GamepadOprationType.BELT_REPLACE then
      local beltSelectedIdx = self:getBletSelectedSlotIndex()
      if beltSelectedIdx ~= nil and self._beltSelectedIdx ~= nil and beltSelectedIdx ~= self._beltSelectedIdx then
        if self._beltCell ~= nil then
          self._beltCell:setAlpha(1)
        end
        self.modules.module_belt:handleDragEffect(self._beltSelectedIdx, beltSelectedIdx, self:handleDragCallback())
      end
      self:clearOperationStatus()
    elseif self._gamepadOperationType == GamepadOprationType.NORMAL then
      if self._isFocusBelt then
        local beltSelectedIdx, beltCell = self:getBletSelectedSlotIndex()
        if beltSelectedIdx ~= nil and beltCell ~= nil then
          self._beltSelectedIdx = beltSelectedIdx
          self._beltCell = beltCell
          if beltCell:isEmpty() then
            self._gamepadOperationType = GamepadOprationType.BELT_CHOOSE
            self._beltCell:setAlpha(0.5)
            self.bindComponents.nav_binding:SelectArea("AreaBag")
            local bagSelectedIdx, bagCell = self:getBagSelectedIndex()
            if bagSelectedIdx ~= nil and bagCell ~= nil then
              local icon = bagCell.bind.img_icon
              self._bagSelectedIdx = bagSelectedIdx
              self:SetFloatIconEnabled(true, icon)
              self:syncFloatIconPos(beltCell:getRaycastGo())
            end
          else
            self:handleDragEffect(DragAreaType.BELT, beltSelectedIdx, DragAreaType.BAG, 0, self:handleDragCallback())
          end
        end
      else
        local bagSelectedIdx, bagCell = self:getBagSelectedIndex()
        if bagSelectedIdx ~= nil and bagCell ~= nil then
          local isAlreadyInBlet, slotIdx = self:checkAlreadyInBelt(bagCell:getId())
          if not isAlreadyInBlet then
            local emptySlotIdx = self:getBletEmptySlotIndex()
            if emptySlotIdx ~= nil then
              self:handleDragEffect(DragAreaType.BAG, bagSelectedIdx, DragAreaType.BELT, emptySlotIdx, self:handleDragCallback())
            else
              self._gamepadOperationType = GamepadOprationType.BAG_REPLACE
              self._bagCell = bagCell
              self._bagCell:setAlpha(0.5)
              local icon = bagCell.bind.img_icon
              self._bagSelectedIdx = bagSelectedIdx
              self.bindComponents.nav_binding:SelectArea("AreaBelt")
              self:SetFloatIconEnabled(true, icon)
              self:syncFloatIconPos()
            end
          else
            self:handleDragEffect(DragAreaType.BELT, slotIdx, DragAreaType.BAG, 0, self:handleDragCallback())
          end
        end
      end
    end
  end)
end

function this:handleGamepadEsc()
  if self._gamepadOperationType ~= GamepadOprationType.NORMAL then
    self:clearOperationStatus()
  elseif self._isFocusBelt then
    self._isFocusBelt = false
    self.modules.module_belt:setGamepadTipsActive(self._isFocusBelt)
    self.bindComponents.nav_binding:SelectArea("AreaBag")
    self.bindComponents.input_binding.inputEnabled = true
  end
  self:refreshBottomInfo()
end

function this:clearOperationStatus()
  self._gamepadOperationType = GamepadOprationType.NORMAL
  if self._isFocusBelt then
    self.bindComponents.nav_binding:SelectArea("AreaBelt")
  else
    self.bindComponents.nav_binding:SelectArea("AreaBag")
  end
  self:SetFloatIconEnabled(false)
  if self._bagCell ~= nil then
    self._bagCell:setAlpha(1)
  end
  if self._beltCell ~= nil then
    self._beltCell:setAlpha(1)
  end
end

function this:checkIsGamepad()
  if not C_InputManager.IsEnableGamePad then
    self:resetGamepadParams()
  end
  return C_InputManager.IsEnableGamePad
end

function this:resetGamepadParams()
  self._isFocusBelt = false
  self.modules.module_belt:setGamepadTipsActive(self._isFocusBelt)
  self._gamepadOperationType = GamepadOprationType.NORMAL
end

function this:getBletEmptySlotIndex()
  return self.modules.module_belt:getEmptySlotIndex()
end

function this:getBletSelectedSlotIndex()
  return self.modules.module_belt:getSelectedSlotIndex()
end

function this:getBagSelectedIndex()
  for i, cell in ipairs(self.modules.grid_bag) do
    if cell:checkIsSelected() then
      return i, cell
    end
  end
  return nil
end

function this:checkAlreadyInBelt(id)
  return self.modules.module_belt:checkAlreadyInBelt(id)
end

function this:SetFloatIconEnabled(enabled, icon)
  if icon ~= nil then
    self.bind.img_drag = icon
  end
  self.bindComponents.rect_drag.gameObject:ActiveTrans(enabled)
end

function this:syncFloatIconPos(go)
  local selGo = go
  if selGo == nil then
    selGo = C_GamepadUtility.GetCurrentSelectedGameObject()
  end
  local scrPos = L_Vector3.toScreenPosition(selGo.transform.position)
  local selPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, scrPos)
  selPos = selPos + L_Vector3.new(0, 80, 0)
  L_Vector3.setAnchored(self.bindComponents.rect_drag, selPos)
end

function this:CanBeltInput()
  return self:checkIsGamepad() and self._gamepadOperationType ~= GamepadOprationType.BELT_CHOOSE and (self._isFocusBelt or self._gamepadOperationType == GamepadOprationType.BAG_REPLACE or self._gamepadOperationType == GamepadOprationType.BELT_REPLACE)
end

function this:onNavigate(v2)
  if self._gamepadOperationType == GamepadOprationType.BELT_CHOOSE then
    local bagSelectedIdx, bagCell = self:getBagSelectedIndex()
    if bagSelectedIdx ~= nil and bagCell ~= nil and self._bagSelectedIdx ~= bagSelectedIdx then
      local icon = bagCell.bind.img_icon
      self.bind.img_drag = icon
      self:refreshBottomInfo()
      self._bagSelectedIdx = bagSelectedIdx
    end
  elseif self._gamepadOperationType == GamepadOprationType.BELT_REPLACE then
    local beltSelectedIdx, beltCell = self:getBletSelectedSlotIndex()
    if beltSelectedIdx ~= nil and beltCell ~= nil and self._tmpIdx ~= beltSelectedIdx then
      self:refreshBottomInfo()
      self._tmpIdx = beltSelectedIdx
    end
  elseif self._gamepadOperationType == GamepadOprationType.BAG_REPLACE then
    local beltSelectedIdx, beltCell = self:getBletSelectedSlotIndex()
    if beltSelectedIdx ~= nil and beltCell ~= nil and self._tmpIdx ~= beltSelectedIdx then
      self:refreshBottomInfo()
      self._tmpIdx = beltSelectedIdx
    end
  elseif self._gamepadOperationType == GamepadOprationType.NORMAL then
    if self._isFocusBelt then
      local beltSelectedIdx, beltCell = self:getBletSelectedSlotIndex()
      if beltSelectedIdx ~= nil and beltCell ~= nil and self._tmpIdx ~= beltSelectedIdx then
        self:refreshBottomInfo()
        self._tmpIdx = beltSelectedIdx
      end
    else
      local bagSelectedIdx, bagCell = self:getBagSelectedIndex()
      if bagSelectedIdx ~= nil and bagCell ~= nil and self._tmpIdx ~= bagSelectedIdx then
        self:refreshBottomInfo()
        self._tmpIdx = bagSelectedIdx
      end
    end
  end
end

function this:refreshBottomInfo()
  local grpName
  if self._isFocusBelt then
    if self._gamepadOperationType == GamepadOprationType.BELT_CHOOSE then
      grpName = "GroupBeltEmptyExecute"
    elseif self._gamepadOperationType == GamepadOprationType.BELT_REPLACE then
      grpName = "GroupSwapBelt"
    elseif self._gamepadOperationType == GamepadOprationType.NORMAL then
      local beltSelectedIdx, beltCell = self:getBletSelectedSlotIndex()
      if beltSelectedIdx ~= nil and beltCell ~= nil then
        if beltCell:isEmpty() then
          grpName = "GroupBeltEmpty"
        else
          grpName = "GroupBeltExist"
        end
      end
    end
  elseif self._gamepadOperationType == GamepadOprationType.BAG_REPLACE then
    grpName = "GroupBagFullBeltExecute"
  elseif self._gamepadOperationType == GamepadOprationType.NORMAL then
    local bagSelectedIdx, bagCell = self:getBagSelectedIndex()
    if bagSelectedIdx ~= nil and bagCell ~= nil then
      local isAlreadyInBlet, slotIdx = self:checkAlreadyInBelt(bagCell:getId())
      if isAlreadyInBlet then
        grpName = "GroupBagInBelt"
      else
        local emptySlotIdx = self:getBletEmptySlotIndex()
        if emptySlotIdx ~= nil then
          grpName = "GroupBagNotInBelt"
        else
          grpName = "GroupBagFullBelt"
        end
      end
    end
  end
  if grpName ~= nil and grpName ~= self._grpName then
    self._grpName = grpName
    local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {
      moduleOrPageName = self.pageName,
      changeGroupName = grpName
    }
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
  end
end

function this:handleDragCallback()
  Timer.once(0.1, function()
    self:refreshBottomInfo()
  end, self)
end

function this:onControlSchemeChange()
  self.modules.module_belt:setGamepadTipsActive(self._isFocusBelt)
end

return this
