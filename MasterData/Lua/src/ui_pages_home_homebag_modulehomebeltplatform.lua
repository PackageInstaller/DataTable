local module = class("moduleHomeBeltPlatform", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local DisplayState = {
  INIT = 0,
  SHOWING = 1,
  HIDING = 2
}

function module.bind()
  return {
    active_pc = false,
    list_belt_pc = {
      moduleName = "pages/home/homeBag/cellIconHomeBelt"
    },
    list_pageNum_pc = {
      moduleName = "pages/home/homeBag/cellHomeBeltNum"
    },
    select_tab_pc = -1,
    enabled_scroll_pc = true,
    img_drag_pc = "",
    active_cropBag_pc = false,
    active_buildBag_pc = false,
    active_gamepadTips_pc = false,
    txt_gamepadTipsReturn_pc = "",
    active_mobile = false,
    list_belt_mobile = {
      moduleName = "pages/home/homeBag/cellIconHomeBelt"
    },
    list_pageNum_mobile = {
      moduleName = "pages/home/homeBag/cellHomeBeltNum"
    },
    select_tab_mobile = -1,
    enabled_scroll_mobile = true,
    img_drag_mobile = "",
    active_cropBag_mobile = false,
    active_buildBag_mobile = false,
    active_bagKeyNode = false
  }
end

function module.methods()
  return {
    onClickNextTab = function(self)
      self:changeNextPage()
    end,
    onClick_page_last = function(self)
      self:changeLastPage()
    end,
    onClick_page_next = function(self)
      self:changeNextPage()
    end,
    onClick_bag_crop_pc = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.homeBag)
    end,
    onClick_bag_build_pc = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.homeBag)
    end,
    onClick_bag_crop_mobile = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.homeBag)
    end,
    onClick_bag_build_mobile = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.homeBag)
    end
  }
end

function module:initPlatformBind()
  if self._initPlatform then
    return
  end
  self._initPlatform = true
  local isPc = L_DeviceTpl:getIsPc()
  self.bind.active_pc = isPc
  self.bind.active_mobile = not isPc
  if isPc then
    self.bind.list_belt = self.bind.list_belt_pc
    self.modules.list_belt = self.modules.list_belt_pc
    self.bind.list_pageNum = self.bind.list_pageNum_pc
    self.bindComponents.rect_drag = self.bindComponents.rect_drag_pc
    self.bindComponents.tab_list = self.bindComponents.tab_list_pc
  else
    self.bind.active = self.bind.active_mobile
    self.modules.list_belt = self.modules.list_belt_mobile
    self.bind.list_belt = self.bind.list_belt_mobile
    self.bind.list_pageNum = self.bind.list_pageNum_mobile
    self.bindComponents.rect_drag = self.bindComponents.rect_drag_mobile
    self.bindComponents.tab_list = self.bindComponents.tab_list_mobile
  end
  self.bind.tab_list_pc = false
  self.bind.active_cropBag_pc = false
  self.bind.active_buildBag_pc = false
  self.bind.active_cropBag_mobile = false
  self.bind.active_buildBag_mobile = false
  self.bind.active_bagKeyNode = false
end

function module:open()
  self:initAnimationData()
  self:initPlatformBind()
  self.bind.list_belt:clear()
  local lineGridNum = L_HomeStore:getLineGridNum()
  local datas = {}
  for i = 1, lineGridNum do
    table.insert(datas, {
      index = i,
      onClickCell = function()
        self:onBeltClick(i)
      end,
      onEnterCell = function()
        if self._onEnterCell then
          self._onEnterCell(self:getDataId(i), i)
        end
      end,
      onExitCell = function()
        if self._onExitCell then
          self._onExitCell(self:getDataId(i), i)
        end
      end,
      onPressCell = function()
        if self._onPressCell then
          self._onPressCell(self:getDataId(i), i)
        end
      end
    })
  end
  self.bind.list_belt:clear()
  self.bind.list_belt:insert_array(datas)
  local pageNum = L_HomeStore:getBeltMaxPage()
  local beltDatas = {}
  for i = 1, pageNum do
    beltDatas[i] = {
      text = tostring(i),
      tabId = i
    }
  end
  self.bind.list_pageNum:clear()
  self.bind.list_pageNum:insert_array(beltDatas)
  
  function self._refreshView()
    self:refreshView(true)
    if self._selectedIndex then
      self:onBeltClick(self._selectedIndex)
    end
  end
  
  self._refreshViewHandle = handler(self, self._refreshView)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self._refreshViewHandle)
  L_HomeStore:listenCallFunc(L_HomeStore.event.refreshBelt, self._refreshView)
  L_HomeStore:listenCallFunc(L_HomeStore.event.refreshBuildingBag, self._refreshView)
  self._isLongDrag = false
  self._isDragging = false
  self:endDrag()
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUIDragStart, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUIDrag, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUIDragEnd, self)
  C_ScreenTouch.OnUI_DragStart("+", self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag("+", self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd("+", self.onUIDragEndHandle)
  self.onUILongTapStartHandle = self.onUILongTapStartHandle or L_CommonUtil.handle(self.onUILongTapStart, self)
  self.onUILongTapEndHandle = self.onUILongTapEndHandle or L_CommonUtil.handle(self.onUILongTapEnd, self)
  C_ScreenTouch.OnUI_LongTapStart("+", self.onUILongTapStartHandle)
  C_ScreenTouch.OnUI_LongTapEnd("+", self.onUILongTapEndHandle)
end

function module:close()
  self._initPlatform = nil
  self._isLongDrag = false
  self._isDragging = false
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self._refreshViewHandle)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshBelt, self._refreshView)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshBuildingBag, self._refreshView)
  self._addBagShortCut = nil
  if L_DeviceTpl:getIsPc() then
    L_ShortCutManager:clearShortKeyFlag(self)
  end
  C_ScreenTouch.OnUI_DragStart("-", self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag("-", self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd("-", self.onUIDragEndHandle)
  C_ScreenTouch.OnUI_LongTapStart("-", self.onUILongTapStartHandle)
  C_ScreenTouch.OnUI_LongTapEnd("-", self.onUILongTapEndHandle)
end

function module:initAnimationData()
  self.animation = self.animation or self.gameObject:GetComponent(typeof(C_Animation))
  self.displayState = DisplayState.INIT
end

function module:refreshBagShow(beltType)
  self:initPlatformBind()
  if beltType == nil then
    beltType = self._beltType
  end
  local isCanShow = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.homeBag)
  local isBuild = beltType == L_Const.HomeShortcutBarType.HSBT_BUILD
  if L_DeviceTpl:getIsPc() then
    self.bind.active_cropBag_pc = isCanShow and not isBuild
    self.bind.active_buildBag_pc = isCanShow and isBuild
    if isCanShow and not self._addBagShortCut then
      self._addBagShortCut = true
      L_ShortCutManager:addShortKeyFlag(self, tostring(9), L_Const.AnchorType.Middle, self.bindComponents.bagKeyNode)
    end
    self.bind.active_bagKeyNode = self.bind.active_cropBag_pc or self.bind.active_buildBag_pc
  else
    self.bind.active_cropBag_mobile = isCanShow and not isBuild
    self.bind.active_buildBag_mobile = isCanShow and isBuild
  end
end

function module:activeBelt()
  if self.displayState == DisplayState.SHOWING then
    return
  end
  L_TimerManager:stopTimer(self, "hideBelt")
  self.gameObject:SetActive(true)
  self.animation:Play("anim_home_maincity_belt_in")
  self.displayState = DisplayState.SHOWING
end

function module:hideBelt()
  if self.displayState == DisplayState.HIDING then
    return
  end
  self.animation:Play("anim_home_maincity_belt_out")
  self.displayState = DisplayState.HIDING
  local delayTimeBetweenOutAnimationAndHide = 0.2
  L_TimerManager:newOrResetTimer(self, "hideBelt", function()
    if L_CommonUtil.isValid(self.gameObject) then
      self.gameObject:SetActive(false)
    end
  end, delayTimeBetweenOutAnimationAndHide)
end

function module:registerShortCut(pageName)
  if not L_DeviceTpl:getIsPc() then
    return
  end
  local lineGridNum = L_HomeStore:getLineGridNum()
  for i = 1, lineGridNum do
    L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType["EMainNumber" .. i], function()
      self:onBeltClick(i)
      self._curIndex = i
    end)
  end
  L_ShortCutManager:addShortKeyFlag(self, "~", L_Const.AnchorType.Middle, self.bindComponents.tip_pc)
  L_ShortCutManager:addShortKeyFlag(self, "D-Pad", L_Const.AnchorType.Middle, self.bindComponents.tip_pc)
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EMainTilde, function()
    self:changeNextPage()
  end)
  if pageName ~= "pageHomeBag" then
    L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EItemBarPrevPage, function()
      self:changeLastPage()
    end)
    L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EItemBarNextPage, function()
      self:changeNextPage()
    end)
    L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EItemBarPrevItem, function()
      self:changePrevItem()
    end)
    L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EItemBarNextItem, function()
      self:changeNextItem()
    end)
  end
  self.bind.active_gamepadTips_pc = C_InputManager.IsEnableGamePad
  L_ShortCutManager:addShortKeyFlag(self, "Cancel", L_Const.AnchorType.Middle, self.bindComponents.rect_gamepadTipsReturn, L_Vector3.new(-75, 0, 0))
  self.bind.txt_gamepadTipsReturn_pc = L_WordsTpl:getValue("ui_shortcut_text_back")
end

function module:changeNextPage()
  self:onBeltClick(0)
  if self._onChangeEmplty then
    self._onChangeEmplty()
  end
  L_HomeStore:setBeltPage(self._beltType, L_HomeStore:getBeltPage(self._beltType) + 1)
  self._curIndex = self:computeCurIndex()
  if self._curIndex then
    self:refreshSelectGamepad()
  end
end

function module:changeLastPage()
  self:onBeltClick(0)
  if self._onChangeEmplty then
    self._onChangeEmplty()
  end
  local pageIndex = L_HomeStore:getBeltPage(self._beltType)
  pageIndex = 1 < pageIndex and pageIndex - 1 or L_HomeStore:getBeltMaxPage()
  L_HomeStore:setBeltPage(self._beltType, pageIndex)
  self._curIndex = self:computeCurIndex()
  if self._curIndex then
    self:refreshSelectGamepad()
  end
end

function module:computeCurIndex(item_id)
  local itemId = 0
  if item_id then
    itemId = item_id
  elseif self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD then
    itemId = AzurWorld.HomeMgr.BlockModule.DefaultEditBuild.buildId
  elseif self._beltType == L_Const.HomeShortcutBarType.HSBT_CROP then
  end
  for i, beltItem in ipairs(self.modules.list_belt) do
    if beltItem._item and beltItem._id == itemId then
      return beltItem.bind.index
    end
  end
  return nil
end

function module:changePrevItem()
  if not self._curIndex then
    self._curIndex = self:computeCurIndex() or 1
  end
  local oldIndex = self._curIndex
  repeat
    self._curIndex = self._curIndex - 1
    if self._curIndex <= 0 then
      self._curIndex = #self.modules.list_belt
    end
  until not math.isEmpty(self:getDataId(self._curIndex)) or self._curIndex == oldIndex
  if oldIndex ~= self._curIndex then
    self:onBeltClick(self._curIndex)
    self:refreshSelectGamepad()
  end
end

function module:changeNextItem()
  if not self._curIndex then
    self._curIndex = self:computeCurIndex() or #self.modules.list_belt
  end
  local oldIndex = self._curIndex
  repeat
    self._curIndex = self._curIndex + 1
    if self._curIndex > #self.modules.list_belt then
      self._curIndex = 1
    end
  until not math.isEmpty(self:getDataId(self._curIndex)) or self._curIndex == oldIndex
  if oldIndex ~= self._curIndex then
    self:onBeltClick(self._curIndex)
    self:refreshSelectGamepad()
  end
end

function module:setBelt(beltType, canSelect, params)
  self._beltType = beltType
  self._canSelect = canSelect
  params = params or {}
  self._selectedIndex = params.selectedIndex
  self._onClickCell = params.onClickCell
  self._onEnterCell = params.onEnterCell
  self._onExitCell = params.onExitCell
  self._onPressCell = params.onPressCell
  self._onChangeEmplty = params.onChangeEmplty
  self._onTouchCell = params.onTouchCell
  self._onDragCell = params.onDragCell
  self._onDragEndCell = params.onDragEndCell
  self:refreshView()
  if params.buildingId then
    self._curIndex = self:computeCurIndex(params.buildingId)
    if self._curIndex then
      self:refreshSelectGamepad()
    end
  end
end

function module:getBeltPage()
  return L_HomeStore:getBeltPage(self._beltType)
end

function module:refreshView(checkContentAni)
  if not self._beltType then
    return
  end
  if L_DeviceTpl:getIsPc() then
    self.bind.select_tab_pc = self:getBeltPage(self._beltType)
  else
    self.bind.select_tab_mobile = self:getBeltPage(self._beltType)
  end
  L_GameUtil.forceRebuildLayout(self.bindComponents.tab_list)
  self._beltIds = table.clone(L_HomeStore:getBeltItems(self._beltType))
  local datas = {}
  local lineGridNum = L_HomeStore:getLineGridNum()
  for i = 1, lineGridNum do
    local index = self:getRealDataId(i)
    self._beltIds[index] = self._beltIds[index] or 0
    local id = self._beltIds[index]
    if math.isEmpty(id) then
      table.insert(datas, {})
    elseif self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD then
      local build = L_HomeStore:getBuildingInBag(id)
      local num = build.total_num - build.used_num
      table.insert(datas, {build_id = id, num = num})
    elseif self._beltType == L_Const.HomeShortcutBarType.HSBT_CROP then
      table.insert(datas, {
        item_id = id,
        num = C_BagMgr:getItemNumByItemId(id)
      })
    end
  end
  for i, module in ipairs(self.modules.list_belt) do
    if checkContentAni and table.isEmpty(module._item) and not table.isEmpty(datas[i]) then
      self:invokeContentAni(i)
    end
    module:refreshByItem(datas[i])
  end
  if self._currPage ~= self:getBeltPage() then
    self._currPage = self:getBeltPage()
    if table.isEmpty(datas[self._selectedIndex]) then
      self._selectedIndex = nil
    end
  end
  if self._canSelect and (not (not math.isEmpty(self._selectedIndex) and self.modules.list_belt[self._selectedIndex]) or not self.modules.list_belt[self._selectedIndex].bind.active_select) then
    for i, module in ipairs(self.modules.list_belt) do
      if module._item then
        self:onBeltClick(i)
        return
      end
    end
    self:onBeltClick(0)
    if self._onChangeEmplty then
      self._onChangeEmplty()
    end
  elseif not self._canSelect then
    self._selectedIndex = nil
    for i, module in ipairs(self.modules.list_belt) do
      module:setSelect(false)
    end
  end
  if self._canSelect then
    self:refreshSelect()
  else
    self:refreshSelectGamepad()
  end
end

function module:onBeltClick(index)
  self:invokeResetAni(index)
  self:endDrag()
  if index > #self.modules.list_belt or index <= 0 then
    return
  end
  if self._onClickCell then
    self._onClickCell(self:getDataId(index), index)
  end
  if self._canSelect and not math.isEmpty(self:getDataId(index)) then
    self._selectedIndex = index
    self:refreshSelect()
  end
end

function module:refreshSelect()
  printf("刷新选中", self._selectedIndex)
  for i, module in ipairs(self.modules.list_belt) do
    module:setSelect(self._selectedIndex == module.bind.index)
  end
end

function module:getRealDataId(viewId)
  if viewId == nil then
    return nil
  end
  local lineGridNum = L_HomeStore:getLineGridNum()
  local realId = self:getBeltPage() * lineGridNum - lineGridNum + viewId
  return realId
end

function module:getViewId(realId)
  local lineGridNum = L_HomeStore:getLineGridNum()
  return (realId - 1) % lineGridNum + 1
end

function module:getDataId(viewId)
  local data = L_HomeStore:getBeltItems(self._beltType)
  return data[self:getRealDataId(viewId)]
end

function module:checkRaycastGo(go)
  for i, module in ipairs(self.modules.list_belt) do
    if module:getRaycastGo() == go then
      return self:getRealDataId(i)
    end
  end
end

function module:getRaycastGo(viewId)
  return self.modules.list_belt[viewId]:getRaycastGo()
end

function module:invokeDragAni(realId)
  local trueId = self:getViewId(realId)
  self.modules.list_belt[trueId]:invokeDragAni()
end

function module:invokeContentAni(realId)
  local trueId = self:getViewId(realId)
  self.modules.list_belt[trueId]:invokeContentAni()
end

function module:invokeResetAni(realId)
  local trueId = self:getViewId(realId)
  self.modules.list_belt[trueId]:invokeResetAni()
end

function module:onUIDragStart(gesture)
  self._isDragging = true
  self._dragStartPos = nil
  local go = gesture:GetCurrentFirstPickedUIElement()
  local holdItemViewIndex = self:getHoldInfo(go)
  if holdItemViewIndex == nil then
    return
  end
  self._dragStartPos = gesture.position
end

function module:onUIDrag(gesture)
  if not self._isLongDrag or self.holdItemViewIndex == nil then
    return
  end
  if not self.bindComponents.rect_drag.gameObject.activeSelf then
    self.bindComponents.rect_drag.gameObject:ActiveTrans(true)
  end
  local touchLocPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_Vector3.setAnchored(self.bindComponents.rect_drag, touchLocPos)
end

function module:onUIDragEnd(gesture)
  self._isDragging = false
  if not self._isLongDrag then
    if self._dragStartPos ~= nil then
      local dragEndPos = gesture.position
      local spacePos = dragEndPos.x - self._dragStartPos.x
      if 150 < spacePos then
        self:changeLastPage()
      elseif spacePos < -150 then
        self:changeNextPage()
      end
    end
    self._dragStartPos = nil
    return
  end
  self._dragStartPos = nil
  self._isLongDrag = false
  if self.holdItemViewIndex == nil then
    return
  end
  local go = gesture:GetCurrentFirstPickedUIElement()
  self.endItemViewIndex = self:getHoldInfo(go)
  local holdItemViewRealDataId = self:getRealDataId(self.holdItemViewIndex)
  local endItemViewRealDataId = self:getRealDataId(self.endItemViewIndex)
  self:handleDragEffect(holdItemViewRealDataId, endItemViewRealDataId)
  self:handleDragAnim()
  self:endDrag()
end

function module:onUILongTapStart(gesture)
  if self._isLongDrag then
    return
  end
  local go = gesture:GetCurrentFirstPickedUIElement()
  local holdItemViewIndex = self:getHoldInfo(go)
  self.holdItemViewIndex = holdItemViewIndex
  if self.holdItemViewIndex == nil then
    return
  end
  local beltIds = table.clone(L_HomeStore:getBeltItems(self._beltType))
  local beltId = beltIds[self:getRealDataId(self.holdItemViewIndex)]
  if beltId == 0 then
    self:endDrag()
    return
  end
  self._isLongDrag = true
  local touchLocPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  if not self.isBind then
    return
  end
  if self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD then
    local tpl = _homeBuildingTpl:getTplById(beltId)
    if L_DeviceTpl:getIsPc() then
      self.bind.img_drag_pc = _homeBuildingTpl:getBuildIcon(tpl)
    else
      self.bind.img_drag_mobile = _homeBuildingTpl:getBuildIcon(tpl)
    end
  elseif self._beltType == L_Const.HomeShortcutBarType.HSBT_CROP then
    if L_DeviceTpl:getIsPc() then
      self.bind.img_drag_pc = L_ItemTplManager:getCommonItem(beltId).icon
    else
      self.bind.img_drag_mobile = L_ItemTplManager:getCommonItem(beltId).icon
    end
  end
  if L_DeviceTpl:getIsPc() then
    self.bind.enabled_scroll_pc = false
  else
    self.bind.enabled_scroll_mobile = false
  end
  L_Vector3.setAnchored(self.bindComponents.rect_drag, touchLocPos)
  self:invokeDragAni(self.holdItemViewIndex)
  C_AudioManager.Play("Play_SFX_System_UI_QiboHouse_PickUp")
end

function module:onUILongTapEnd(gesture)
  self._isLongDrag = false
end

function module:getHoldInfo(go)
  for viewIndex, module in ipairs(self.modules.list_belt) do
    if module:getRaycastGo() == go then
      return viewIndex
    end
  end
  return nil
end

function module:handleDragEffect(holdItemViewRealDataId, endItemViewRealDataId, callback)
  local beltIds = table.clone(L_HomeStore:getBeltItems(self._beltType))
  if endItemViewRealDataId ~= nil then
    beltIds[holdItemViewRealDataId], beltIds[endItemViewRealDataId] = beltIds[endItemViewRealDataId], beltIds[holdItemViewRealDataId]
  else
    beltIds[holdItemViewRealDataId] = 0
  end
  L_HomeStore:req_changeBelt(self._beltType, beltIds, callback)
end

function module:handleDragAnim()
  if self.holdItemViewIndex then
    self:invokeContentAni(self.holdItemViewIndex)
  end
  if self.endItemViewIndex then
    self:invokeContentAni(self.endItemViewIndex)
  end
end

function module:endDrag()
  self.holdItemViewIndex = nil
  self.endItemViewIndex = nil
  self.bindComponents.rect_drag.gameObject:ActiveTrans(false)
  if L_DeviceTpl:getIsPc() then
    self.bind.enabled_scroll_pc = true
  else
    self.bind.enabled_scroll_mobile = true
  end
end

function module:getEmptySlotIndex()
  for i, cell in ipairs(self.modules.list_belt) do
    if cell:isEmpty() then
      local index = (self:getBeltPage() - 1) * L_HomeStore:getLineGridNum() + i
      return index, cell
    end
  end
  return nil
end

function module:getSelectedSlotIndex()
  local selGo = C_GamepadUtility.GetCurrentSelectedGameObject()
  for i, cell in ipairs(self.modules.list_belt) do
    if cell:getRaycastGo() == selGo then
      local index = (self:getBeltPage() - 1) * L_HomeStore:getLineGridNum() + i
      return index, cell
    end
  end
  return nil
end

function module:checkAlreadyInBelt(id)
  for i, cell in ipairs(self.modules.list_belt) do
    if not cell:isEmpty() and cell:getId() == id then
      local index = (self:getBeltPage() - 1) * L_HomeStore:getLineGridNum() + i
      return true, index
    end
  end
  return false
end

function module:refreshSelectGamepad()
  if self._canSelect then
    return
  end
  for i, module in ipairs(self.modules.list_belt) do
    module:setSelect(C_InputManager.IsEnableGamePad and self._curIndex == module.bind.index)
  end
end

function module:onControlSchemeChange()
  self:refreshSelectGamepad()
  if L_DeviceTpl:getIsPc() then
    self.bind.active_gamepadTips_pc = C_InputManager.IsEnableGamePad
  end
end

function module:setGamepadTipsActive(active)
  self.bind.active_gamepadTips_pc = active and C_InputManager.IsEnableGamePad
end

return module
