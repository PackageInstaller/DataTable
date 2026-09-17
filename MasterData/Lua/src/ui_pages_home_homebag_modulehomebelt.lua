local module = class("moduleHomeBelt", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()

function module.bind()
  return {
    list_belt = {
      moduleName = "pages/home/homeBag/cellIconHomeBelt"
    },
    list_pageNum = {
      moduleName = "pages/home/homeBag/cellHomeBeltNum"
    },
    select_tab = -1,
    enabled_scroll = true,
    img_drag = ""
  }
end

function module.methods()
  return {
    onClickNextTab = function(self)
      self:changeNextPage()
    end
  }
end

function module:open()
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
  L_ShortCutManager:addShortKeyFlag(self, "~", L_Const.AnchorType.Middle, self.bindComponents.Tip)
  self:endDrag()
  self.onUITouchHandle = self.onUITouchHandle or L_CommonUtil.handle(self.onUITouch, self)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUIDragStart, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUIDrag, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUIDragEnd, self)
  C_ScreenTouch.OnUI_Touch("+", self.onUITouchHandle)
  C_ScreenTouch.OnUI_DragStart("+", self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag("+", self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd("+", self.onUIDragEndHandle)
end

function module:close()
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self._refreshViewHandle)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshBelt, self._refreshView)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshBuildingBag, self._refreshView)
  L_ShortCutManager:clearShortKeyFlag(self)
  C_ScreenTouch.OnUI_Touch("-", self.onUITouchHandle)
  C_ScreenTouch.OnUI_DragStart("-", self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag("-", self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd("-", self.onUIDragEndHandle)
end

function module:registerShortCut(pageName)
  local lineGridNum = L_HomeStore:getLineGridNum()
  for i = 1, lineGridNum do
    L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType["EMainNumber" .. i], function()
      self:onBeltClick(i)
    end)
  end
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EMainTilde, function()
    self:changeNextPage()
  end)
end

function module:changeNextPage()
  self:onBeltClick(0)
  if self._onChangeEmplty then
    self._onChangeEmplty()
  end
  L_HomeStore:setBeltPage(self._beltType, L_HomeStore:getBeltPage(self._beltType) + 1)
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
end

function module:getBeltPage()
  return L_HomeStore:getBeltPage(self._beltType)
end

function module:refreshView(checkContentAni)
  if not self._beltType then
    return
  end
  self.bind.select_tab = self:getBeltPage(self._beltType)
  L_GameUtil.forceRebuildLayout(self.bindComponents.tab_list)
  self._beltIds = table.clone(L_HomeStore:getBeltItems(self._beltType))
  local lineGridNum = L_HomeStore:getLineGridNum()
  local datas = {}
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
end

function module:onUITouch(gesture)
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
  local touchLocPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  if not self.isBind then
    return
  end
  if self._beltType == L_Const.HomeShortcutBarType.HSBT_BUILD then
    local tpl = _homeBuildingTpl:getTplById(beltId)
    self.bind.img_drag = _homeBuildingTpl:getBuildIcon(tpl)
  elseif self._beltType == L_Const.HomeShortcutBarType.HSBT_CROP then
    self.bind.img_drag = L_ItemTplManager:getCommonItem(beltId).icon
  end
  self.bind.enabled_scroll = false
  L_Vector3.setAnchored(self.bindComponents.rect_drag, touchLocPos)
  self:invokeDragAni(self.holdItemViewIndex)
end

function module:onUIDrag(gesture)
  if self.holdItemViewIndex == nil then
    return
  end
  if not self.bindComponents.rect_drag.gameObject.activeSelf then
    self.bindComponents.rect_drag.gameObject:ActiveTrans(true)
  end
  local touchLocPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_Vector3.setAnchored(self.bindComponents.rect_drag, touchLocPos)
end

function module:onUIDragEnd(gesture)
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

function module:getHoldInfo(go)
  for viewIndex, module in ipairs(self.modules.list_belt) do
    if module:getRaycastGo() == go then
      return viewIndex
    end
  end
  return nil
end

function module:handleDragEffect(holdItemViewRealDataId, endItemViewRealDataId)
  local beltIds = table.clone(L_HomeStore:getBeltItems(self._beltType))
  if endItemViewRealDataId ~= nil then
    beltIds[holdItemViewRealDataId], beltIds[endItemViewRealDataId] = beltIds[endItemViewRealDataId], beltIds[holdItemViewRealDataId]
  else
    beltIds[holdItemViewRealDataId] = 0
  end
  L_HomeStore:req_changeBelt(self._beltType, beltIds)
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
  self.bind.enabled_scroll = true
end

return module
