local this = class("pageHomeCropBox", G_UIPageBase)
local _homeSeedTpl = L_GameTpl:getHomeSeedsTpl()
local _homeDropTpl = L_GameTpl:getHomeDropTpl()
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local DragAreaType = {
  BOX = 1,
  BAG = 2,
  BAGTOBOX = 3,
  BOXTOBAG = 4
}
local QuickSelect = {
  STARTSELECT = 1,
  STOPSELECT = 2,
  GIVEHALF = 3
}
local GamepadOprationType = {NORMAL = 0, BOXSWAP = 1}
local GRP_BAG = "GroupBag"
local GRP_NUM_TIP = "GroupNumTip"
local GRP_BOX = "GroupBox"
local GRP_BOX_SWAP = "GroupBoxSwap"

function this.bind()
  return {
    grid_bag = {
      moduleName = "pages/home/homeBag/cellIconHomeBag"
    },
    grid_box = {
      moduleName = "pages/home/homeBag/cellIconHomeBox"
    },
    enabled_scrollBag = true,
    enabled_scrollBox = true,
    img_drag = "",
    active_tip = false,
    offset_tip = C_Vector3.one,
    txt_time = "",
    txt_reward = "",
    txt_water = "",
    txt_rewardHave = "",
    txt_rewardName = "",
    module_num = {
      moduleName = "modulePages/moduleSelectNum"
    },
    txt_btn = L_WordsTpl:getValue("notice_homeProduction_27"),
    txt_name = L_WordsTpl:getValue("notice_homeProduction_25"),
    go_imgDrag = false,
    txt_dragNum = nil,
    pos_drag = nil,
    go_dragTxt = false,
    go_pcTip = false
  }
end

function this.methods()
  return {
    onClick_close = function()
      L_UI:close("pageHomeCropBox")
    end,
    onClick_bg = function()
    end,
    onClick_confirm = function()
    end,
    onClick_set = function(self)
      if not self._selectedType then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_homeProduction_25"))
        return
      end
      local selectNum = self.modules.module_num:getNum()
      local targetItems = self._selectedType == DragAreaType.BAG and self._bagItems or self._boxItems
      local targetItem = targetItems[self._selectIndex]
      local currNum = targetItem.num
      
      local function cb()
        if currNum <= selectNum then
          self._selectedType = nil
          self._selectIndex = nil
        end
        self:refreshSelect()
        self._curSelectNum = 0
        if self.bind.active_tip then
          self.bind.active_tip = false
          self:onTipCloseGamepad()
        end
      end
      
      if self._selectedType == DragAreaType.BOX then
        self._autoData:Req_OperateSeed(L_Const.HomeOperateAutoWorkType.HOAWT_DEL, targetItem.item_id, selectNum, targetItem.guid, cb)
      else
        local guid = 0
        for i, item in ipairs(self._boxItems) do
          if item.item_id == targetItem.item_id then
            guid = item.guid
          end
        end
        self._autoData:Req_OperateSeed(L_Const.HomeOperateAutoWorkType.HOAWT_ADD, targetItem.item_id, selectNum, guid, cb)
      end
      self._selectedType = nil
      self._selectIndex = nil
      self.bind.active_tip = false
      self._curSelectNum = 0
      self:onTipCloseGamepad(true)
    end,
    onClick_auto = function(self)
      local subList = self:getAllSubmitList()
      self._autoData:Req_AutoSelectSeed(subList)
      self._selectedType = nil
    end,
    onClick_nodeMask = function(self)
      if self.bind.active_tip then
        self.bind.active_tip = false
        self._curSelectNum = 0
        self:onTipCloseGamepad()
        for _, module in ipairs(self.modules.grid_box) do
          module:setSelect(false)
        end
        for _, module in ipairs(self.modules.grid_bag) do
          module:setSelect(false)
        end
        self._selectedType, self._selectIndex = nil, nil
        self:refreshSelect()
      end
    end
  }
end

function this:toBind(uiBinding)
  self.super.toBind(self, uiBinding)
  local addModuleGeneric = xlua.get_generic_method(self.csharpPage:GetType(), "AddModule", 1)
  local addModule = addModuleGeneric(CS.Lens.Gameplay.UI.HomeCrop.CropSeedPriorityChooseModule, CS.UnityEngine.GameObject)
  self.cropSeedPriorityChooseModule = addModule(self.csharpPage, self.csharpPage, self.bindComponents.cropSeedPriorityChooseModule.gameObject)
end

function this:preOpen(params)
  self._curSelectNum = 0
  self._isShiftImgHold = false
  self._buildingGuid = params.buildingGuid
  self._buildingData = C_HomeUtil.GetBuildData(self._buildingGuid)
  self._autoData = self._buildingData.auto
  self._selectHoldingType = QuickSelect.STOPSELECT
  self._bagItems = {}
  self._boxItems = {}
  self:endDrag()
  self:refreshBoxes()
  self:configTouch("+")
  self.refreshBoxesHandle = handler(self, self.refreshBoxes)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.refreshBoxesHandle)
  
  function self._refreshFunc()
    self:refreshBoxes()
  end
  
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildSync, self._refreshFunc)
  self:showPcTip()
  self.onNavigateHandle = self.onNavigateHandle or L_CommonUtil.handle(self.onNavigate, self)
  C_InputManager.AddAxisListener(L_Const.axisType.eNavigate, self.onNavigateHandle)
  self.onControlSchemeChangeHandle = self.onControlSchemeChangeHandle or handler(self, self.onControlSchemeChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.ControlSchemeChange, self.onControlSchemeChangeHandle)
  C_AudioManager.Play("Play_SFX_System_UI_General_Parchment_Open_L2")
end

function this:show()
  self:registerShortCut(true)
  self:resetGamepadParams()
  C_InputManager.Instance.VirtualMouseInput.leftButtonAction.action:Disable()
end

function this:hide()
  C_AudioManager.Play("Play_SFX_System_UI_General_Parchment_Close_L2")
  C_InputManager.Instance.VirtualMouseInput.leftButtonAction.action:Enable()
end

function this:close()
  self:configTouch("-")
  self:registerShortCut(false)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.refreshBoxesHandle)
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildSync, self._refreshFunc)
  L_TimerManager:clearTimer(self)
  C_InputManager.RemoveAxisListener(L_Const.axisType.eNavigate, self.onNavigateHandle)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.ControlSchemeChange, self.onControlSchemeChangeHandle)
end

function this:escHandle()
  if C_InputManager.IsEnableGamePad and (self._gamepadOperationType ~= GamepadOprationType.NORMAL or self.bind.active_tip) then
    self:handleGamepadEsc()
    return
  end
  L_UI:close(self.pageName)
end

function this:isSeedSizeSatisfied(itemId)
  local seedTpl = _homeSeedTpl:getTplBySeedItemId(itemId)
  if not seedTpl then
    return false
  end
  local itemSize = _homeSeedTpl:getHomeItemSize(seedTpl)
  return itemSize and #itemSize == 2 and 2 >= itemSize[1] and itemSize[2] <= 2
end

function this:refreshBoxes()
  local allItems = C_BagMgr:getAllItem()
  self._bagItems = {}
  for id, v in pairs(allItems) do
    if _homeSeedTpl:getIsSeed(id) and self:isSeedSizeSatisfied(v.itemId) then
      local batches = C_BagMgr:GetStackCommonItemData(id)
      for i = 0, batches.Count - 1 do
        local num = batches[i]
        if 0 < num then
          table.insert(self._bagItems, {
            item_id = id,
            num = num,
            itemType = v.itemType
          })
        end
      end
    end
  end
  local bagBoxNum = math.max(math.ceil(#self._bagItems / 4) * 4, 16)
  if bagBoxNum > #self.modules.grid_bag then
    self.bind.grid_bag:clear()
    self.bind.grid_bag:insert_array(L_DataUtil.getEmptyModuleDatas(bagBoxNum))
  end
  for i, module in ipairs(self.modules.grid_bag) do
    module:refreshByItem(self._bagItems[i], function()
      if self._isShiftImgHold or self._isShiftDown then
        return
      end
      self:onSelectItem(DragAreaType.BAG, i)
    end)
  end
  self._boxItems = {}
  for i = 0, self._autoData.seeds.Count - 1 do
    local seedItem = self._autoData.seeds[i]
    table.insert(self._boxItems, {
      item_id = seedItem.itemId,
      guid = seedItem.guid,
      num = seedItem.itemNum,
      itemType = seedItem.itemType
    })
  end
  self.bindComponents.grid_boxContent.disableScroll = 0 >= self._autoData.seeds.Count
  local boxNum = 12
  if #self.modules.grid_box ~= boxNum then
    self.bind.grid_box:clear()
    self.bind.grid_box:insert_array(L_DataUtil.getEmptyModuleDatas(boxNum))
  end
  for i, module in ipairs(self.modules.grid_box) do
    local index = i
    module:refreshByItem(index, self._boxItems[i], function()
      if self._isShiftImgHold or self._isShiftDown then
        return
      end
      self:onSelectItem(DragAreaType.BOX, i)
    end, function(guid)
      if self._isShiftImgHold then
        return
      end
      if self._holdType == DragAreaType.BOX and self._holdId and self._holdId > 0 then
        if i == self._holdId then
          self:endDrag()
        end
        return
      end
      local targetItems = self._boxItems
      local targetItem
      for i, item in ipairs(targetItems) do
        if item.guid == guid then
          targetItem = item
          break
        end
      end
      if targetItem then
        local currNum = targetItem.num
        
        local function cb()
          self._selectedType = nil
          self._selectIndex = nil
          self:refreshSelect()
        end
        
        self._autoData:Req_OperateSeed(L_Const.HomeOperateAutoWorkType.HOAWT_DEL, targetItem.item_id, currNum, targetItem.guid, cb)
      end
    end, function()
      return not math.isEmpty(self._holdId)
    end)
  end
  self:refreshSelect()
end

function this:onSelectItem(type, index)
  local targetItems = type == DragAreaType.BAG and self._bagItems or self._boxItems
  local targetItem = targetItems[index]
  if not targetItem then
    return
  end
  if self._selectedType ~= type or self._selectIndex ~= index then
    self._selectedType, self._selectIndex = type, index
    self._curSelectNum = 0
  else
    self._selectedType, self._selectIndex = nil, nil
  end
  self:refreshSelect()
  self:endDrag()
end

function this:getTipLimitPosition(targetPos)
  local width = self.bindComponents.offset.sizeDelta.x / 2
  local halfScreenWidth = self.bindComponents.nodeNumberTip.transform.rect.width / 2
  if halfScreenWidth < targetPos.x + width then
    targetPos.x = halfScreenWidth - width
  elseif halfScreenWidth < width - targetPos.x then
    targetPos.x = width - halfScreenWidth
  end
  targetPos.y = targetPos.y - 10
  return targetPos
end

function this:refreshSelect()
  for i, module in ipairs(self.modules.grid_bag) do
    module.bind.active_select = self._selectedType == DragAreaType.BAG and self._bagItems[i] and self._selectIndex == i or false
    module.bind.img_sel = module.bind.active_select
    if module.bind.active_select and module:getTipPosition() ~= nil then
      local tip_localPos = self.bindComponents.nodeNumberTip.transform:InverseTransformPoint(module:getTipPosition())
      tip_localPos = self:getTipLimitPosition(tip_localPos)
      self.bindComponents.offset.localPosition = tip_localPos
    end
  end
  for i, module in ipairs(self.modules.grid_box) do
    module.bind.active_select = self._selectedType == DragAreaType.BOX and self._boxItems[i] and self._selectIndex == i or false
    module.bind.img_sel = module.bind.active_select
    if module.bind.active_select and module:getTipPosition() ~= nil then
      local tip_localPos = self.bindComponents.nodeNumberTip.transform:InverseTransformPoint(module:getTipPosition())
      tip_localPos = self:getTipLimitPosition(tip_localPos)
      self.bindComponents.offset.localPosition = tip_localPos
    end
  end
  if not self._selectedType then
    if self.bind.active_tip then
      self.bind.active_tip = false
      self._curSelectNum = 0
      self:onTipCloseGamepad()
    end
  else
    if not self.bind.active_tip then
      self.bind.active_tip = true
      self:onTipOpenGamepad()
    end
    self.bind.txt_btn = self._selectedType == DragAreaType.BOX and L_WordsTpl:getValue("notice_homeProduction_26") or L_WordsTpl:getValue("notice_homeProduction_27")
    local targetItems = self._selectedType == DragAreaType.BAG and self._bagItems or self._boxItems
    local targetItem = targetItems[self._selectIndex]
    if targetItem then
      local seedTpl = _homeSeedTpl:getTplBySeedItemId(targetItem.item_id)
      if not seedTpl then
        return
      end
      self.bind.txt_name = L_ItemTplManager:getCommonItem(targetItem.item_id).name
      local buffCondition = L_HomeBuffManager:getCropCondition(_homeSeedTpl:getId(seedTpl))
      local growTime, preHarTime = L_HomeBuffManager:getCropGrowParam(_homeSeedTpl:getId(seedTpl), buffCondition)
      local totalTime = growTime + preHarTime
      self.bind.txt_time = L_TimeUtil.secondToString(totalTime, L_TimeUtil.secondToStringShowType.TWO_UNIT)
      self.bind.txt_reward = _homeSeedTpl:getNumShow(seedTpl)
      self.bind.txt_water = tostring(_homeSeedTpl:getNeedWater(seedTpl))
      local dropId = _homeSeedTpl:getHomeDropId(seedTpl)
      local dropTpl = _homeDropTpl:getTplById(dropId[1])
      local rewardItemId = _homeDropTpl:getItemId(dropTpl)
      local rewardItemType = _homeDropTpl:getItemType(dropTpl)
      local rewardItemConf = L_ItemTplManager:getItemConfig(rewardItemType, rewardItemId[1])
      self.bind.txt_rewardName = rewardItemConf.name
      self.bind.txt_rewardHave = tostring(C_BagMgr:getItemNumByItemId(rewardItemId[1]))
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.timeRect)
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rewardTagRect)
    end
    
    local function numChangefunc(num)
      self._curSelectNum = num
    end
    
    local _selectNum = self._curSelectNum
    if _selectNum <= 0 then
      _selectNum = targetItem and targetItem.num or 1
    end
    self.modules.module_num:initModule(numChangefunc, _selectNum, 1, _selectNum)
  end
end

function this:getHoldInfo(go)
  for i, module in ipairs(self.modules.grid_bag) do
    if module:getRaycastGo() == go then
      return DragAreaType.BAG, i
    end
  end
  for i, module in ipairs(self.modules.grid_box) do
    if module:getRaycastGo() == go then
      return DragAreaType.BOX, i
    end
  end
end

function this:configTouch(operator)
  self.onUITouchHandle = self.onUITouchHandle or L_CommonUtil.handle(self.onUI_touchHandle, self)
  self.onUIDragStartHandle = self.onUIDragStartHandle or L_CommonUtil.handle(self.onUI_dragStartHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  self.onUIClickHandle = self.onUIClickHandle or L_CommonUtil.handle(self.onUI_clickHandle, self)
  C_ScreenTouch.OnUI_Touch(operator, self.onUITouchHandle)
  C_ScreenTouch.OnUI_DragStart(operator, self.onUIDragStartHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
  C_ScreenTouch.OnUI_Click(operator, self.onUIClickHandle)
end

function this:onUI_touchHandle(gesture)
  local go = gesture.go
  local holdType, holdId = self:getHoldInfo(go)
  local targetItems = holdType == DragAreaType.BAG and self._bagItems or self._boxItems
  if not holdId or not targetItems[holdId] then
    return
  end
  local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_Vector3.setAnchored(self.bindComponents.rect_drag, touchPos)
  L_FlyMsgManager:startLongPress(gesture, 0.5, function()
    if not self.isBind then
      return
    end
    self:onSelectItem(nil)
    printf("开始拖拽")
    self._holdType, self._holdId = holdType, holdId
    local targetItems = self._holdType == DragAreaType.BAG and self._bagItems or self._boxItems
    self.bind.img_drag = L_ItemTplManager:getCommonItem(targetItems[self._holdId].item_id).icon
    self.bindComponents.rect_drag.gameObject:ActiveTrans(true)
    self.bind.go_dragTxt = false
    self.bind.enabled_scrollBag = false
    self.bind.enabled_scrollBox = false
    if self._holdType == DragAreaType.BAG then
      self:playBagCellItemDragAnim(self._holdId)
    end
  end)
end

function this:onUI_dragStartHandle(gesture)
  if not self._holdId then
    printf("拖拽中断")
    L_TimerManager:stopTimer(self, "pressing")
  end
end

function this:onUI_dragHandle(gesture)
  local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_Vector3.setAnchored(self.bindComponents.rect_drag, touchPos)
end

function this:onUI_dragEndHandle(gesture)
  printf("拖拽结束")
  local go = gesture:GetCurrentFirstPickedUIElement()
  if self._holdId then
    local holdType, holdId = self:getHoldInfo(go)
    if holdId then
      self:handleDragEffect(self._holdType, self._holdId, holdType, holdId)
    end
  end
  self:endDrag()
end

function this:onUI_clickHandle(gesture)
  local uiElement = gesture:GetCurrentFirstPickedUIElement()
  local gestureGo = gesture.go
  L_TimerManager:newOrResetTimer(self, "onUI_clickHandle_timer", function()
    self:onTimerUIClickHandle(uiElement, gestureGo)
  end, 0.1)
end

function this:onTimerUIClickHandle(uiElement, gestureGo)
  if self._holdId and self._holdId ~= 0 then
    local holdType, holdId = self:getHoldInfo(uiElement)
    if holdId or holdId ~= self._holdId then
      local res = self:handleDragEffect(self._holdType, self._holdId, holdType, holdId, self._holdNum)
      if res then
        self:playBagCellItemEndDragAnim(self._holdId)
        self._holdType = 0
        self._holdId = 0
        self.bindComponents.rect_drag.gameObject:ActiveTrans(false)
        self.bind.go_dragTxt = false
        self._isShiftImgHold = false
        self._selectHoldingType = QuickSelect.STOPSELECT
        self.bind.enabled_scrollBag = true
        self.bind.enabled_scrollBox = true
      end
      return
    end
  end
  local holdType, holdId = self:getHoldInfo(gestureGo)
  if holdType == nil then
    holdType = 0
  end
  if holdId == nil then
    holdId = 0
  end
  if holdType ~= DragAreaType.BAG then
    return
  end
  if self._isShiftDown and (self._holdId == nil or self._holdId == 0) and not math.isEmpty(holdId) and self._holdId ~= holdId then
    self._selectHoldingType = QuickSelect.STARTSELECT
  elseif self._isShiftDown and not math.isEmpty(self._holdId) and math.isEmpty(holdId) then
    self._selectHoldingType = QuickSelect.STOPSELECT
  elseif self._isShiftDown and not math.isEmpty(self._holdId) and holdId ~= self._holdId then
    self._selectHoldingType = QuickSelect.STOPSELECT
  elseif self._isShiftDown and not math.isEmpty(self._holdId) and self._holdId == holdId then
    self._selectHoldingType = QuickSelect.GIVEHALF
  end
  if self._selectHoldingType == QuickSelect.STARTSELECT then
    self._holdId = holdId
    self._holdType = holdType
    local targetItems = self._holdType == DragAreaType.BAG and self._bagItems or self._boxItems
    self._holdNum = math.ceil(targetItems[self._holdId].num / 2)
    self._isShiftImgHold = true
  elseif self._selectHoldingType == QuickSelect.STOPSELECT then
    self._holdId = 0
    self._holdNum = 0
    self._isShiftImgHold = false
  elseif self._selectHoldingType == QuickSelect.GIVEHALF then
    self._holdNum = math.ceil(self._holdNum / 2)
  end
  if self._isShiftImgHold then
    self.bindComponents.rect_drag.gameObject:ActiveTrans(true)
    local targetItems = self._holdType == DragAreaType.BAG and self._bagItems or self._boxItems
    self.bind.img_drag = L_ItemTplManager:getCommonItem(targetItems[self._holdId].item_id).icon
    self.bind.txt_dragNum = tostring(self._holdNum)
    self.bind.go_dragTxt = true
  else
    self.bindComponents.rect_drag.gameObject:ActiveTrans(false)
    self.bind.go_dragTxt = false
  end
end

function this:endDrag()
  if self._holdType and self._holdType == DragAreaType.BAG and self._holdId then
    self:playBagCellItemEndDragAnim(self._holdId)
  end
  L_TimerManager:stopTimer(self, "pressing")
  if self._isShiftImgHold == false or self._isShiftImgHold == nil then
    self._holdType, self._holdId = nil, nil
  end
  self.bindComponents.rect_drag.gameObject:ActiveTrans(false)
  self.bind.enabled_scrollBag = true
  self.bind.enabled_scrollBox = true
end

function this:handleDragEffect(fromType, fromId, toType, toId, num)
  printf("拖转", fromType, fromId, toType, toId)
  if fromType == DragAreaType.BAG then
    if toType == DragAreaType.BOX then
      local item = self._bagItems[fromId]
      local guid = 0
      for i, v in ipairs(self._boxItems) do
        if v.item_id == item.item_id then
          guid = v.guid
        end
      end
      local tpl = _homeSeedTpl:getSeedTplByItem(item.item_id)
      local condition = _homeSeedTpl:getCondition(tpl)
      if not L_ConditionManager:isComplete(condition) then
        L_FlyMsgManager:showNormalMsg(L_ConditionManager:getTipDesc(condition))
        return false
      end
      local res_num = 0
      if item ~= nil then
        res_num = item.num
      end
      if math.isEmpty(num) == false then
        res_num = num
      end
      if item then
        self._autoData:Req_OperateSeed(L_Const.HomeOperateAutoWorkType.HOAWT_ADD, item.item_id, res_num, guid)
      end
    end
  elseif toType == DragAreaType.BAG then
    local item = self._boxItems[fromId]
    local res_num = 0
    if item ~= nil then
      res_num = item.num
    end
    if math.isEmpty(num) == false then
      res_num = num
    end
    if item then
      self._autoData:Req_OperateSeed(L_Const.HomeOperateAutoWorkType.HOAWT_DEL, item.item_id, res_num, item.guid)
    end
  else
    local item1 = self._boxItems[fromId]
    local item2 = self._boxItems[toId]
    if item2 and item1 then
      self._autoData:Req_ExchangeSeed(item1.guid, item2.guid)
    end
  end
  return true
end

function this:showPcTip()
  self.bind.go_pcTip = L_DeviceTpl:getIsPc()
end

function this:registerShortCut(show)
  if not L_DeviceTpl:getIsPc() then
    return
  end
  if show then
    L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EHomeCropShift, function(value)
      self._isShiftDown = value
    end, true)
  else
    L_ShortCutManager:removeShortCut(self.pageName)
  end
  self:registerGamepadShotcut(show)
end

function this:update()
  if self._isShiftImgHold then
    local mousePosition = CS.UnityEngine.Input.mousePosition
    local _, uiPos = _screenPosToUI(self.bindComponents.rect_content, C_Vector2(mousePosition.x, mousePosition.y), C_CameraManager.uiCamera)
    if self._holdId ~= nil and self._holdId ~= 0 then
      self.bind.pos_drag = uiPos
    end
  end
end

function this:getAllSubmitList()
  local list = {}
  local max_count = 12
  for k, v in pairs(self._boxItems) do
    for index, item in pairs(self._bagItems) do
      if item.item_id == v.item_id then
        local isFirstHave = true
        for i, data in pairs(list) do
          if data.itemId == item.item_id then
            data.itemNum = data.itemNum + item.num
            isFirstHave = false
          end
        end
        if isFirstHave and max_count > #list then
          table.insert(list, {
            itemId = item.item_id,
            itemNum = item.num,
            itemType = item.itemType,
            guid = v.guid
          })
        end
      end
    end
  end
  for k, v in pairs(self._bagItems) do
    local tmp_data = table.find(self._boxItems, function(value)
      return value.item_id == v.item_id
    end)
    if not tmp_data then
      local data = table.find(list, function(value)
        return value.itemId == v.item_id
      end)
      if data then
        data.itemNum = data.itemNum + v.num
      elseif max_count > #list then
        table.insert(list, {
          itemId = v.item_id,
          itemNum = v.num,
          itemType = v.itemType,
          guid = 0
        })
      end
    end
  end
  return list
end

function this:playBagCellItemDragAnim(index)
  if not index or not self.modules.grid_bag then
    return
  end
  local cell = self.modules.grid_bag[index]
  if cell then
    cell:playDragAnim()
  end
  self._dragCell = cell
end

function this:playBagCellItemEndDragAnim(index)
  if self._dragCell then
    self._dragCell:playEndDragAnim()
  end
  self._dragCell = nil
end

function this:registerGamepadShotcut(show)
  if not show then
    return
  end
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageHomeCropBoxSwitchArea, function()
    if not self:checkIsGamepad() or self._gamepadOperationType ~= GamepadOprationType.NORMAL or self.bind.active_tip then
      return
    end
    self._isFocusBag = not self._isFocusBag
    if self._isFocusBag then
      C_InputManager.GetAction("UI/Submit"):Enable()
      self.bindComponents.nav_binding:SelectArea("AreaBag")
      self._selectedType = DragAreaType.BAG
    else
      C_InputManager.GetAction("UI/Submit"):Disable()
      self.bindComponents.nav_binding:SelectArea("AreaStorage")
      self._selectedType = nil
    end
    self:refreshBottomTips()
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageHomeCropBoxExecute, function()
    if not self:checkIsGamepad() or self._gamepadOperationType ~= GamepadOprationType.NORMAL or self._isFocusBag then
      return
    end
    local boxIdx, boxCell = self:getBoxSelected()
    if boxIdx ~= nil and boxCell ~= nil then
      local item = self._boxItems[boxIdx]
      self._autoData:Req_OperateSeed(L_Const.HomeOperateAutoWorkType.HOAWT_DEL, item.item_id, item.num, item.guid)
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageHomeCropBoxAddAll, function()
    if not self:checkIsGamepad() or self._gamepadOperationType ~= GamepadOprationType.NORMAL or self.bind.active_tip then
      return
    end
    self.methods.onClick_auto(self)
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageHomeCropBoxQuickSave, function()
    if not (self:checkIsGamepad() and self._gamepadOperationType == GamepadOprationType.NORMAL and self._isFocusBag) or self.bind.active_tip then
      return
    end
    local bagIdx, bagCell = self:getBagSelected()
    if bagIdx ~= nil and bagCell ~= nil then
      if self._isHoldHalf then
        local halfNum = math.ceil(self._bagItems[bagIdx].num / 2)
        self:handleDragEffect(DragAreaType.BAG, bagIdx, DragAreaType.BOX, 1, halfNum)
        self._selectedType = nil
      else
        self:handleDragEffect(DragAreaType.BAG, bagIdx, DragAreaType.BOX, 1)
      end
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPageHomeCropBoxQuickSaveHalf, function(value)
    self._isHoldHalf = value
  end, true)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ECommonConfirm, function()
    if not self:checkIsGamepad() then
      return
    end
    if not self._isFocusBag then
      if self._gamepadOperationType == GamepadOprationType.BOXSWAP then
        if self._boxCell ~= nil and self._boxIdx ~= nil then
          local boxIdx, boxCell = self:getBoxSelected()
          if boxIdx ~= nil and boxCell ~= nil then
            if self._boxIdx ~= boxIdx then
              self:handleDragEffect(DragAreaType.BOX, self._boxIdx, DragAreaType.BOX, boxIdx)
            end
            self:clearOperationStatus()
          end
        end
      else
        local boxIdx, boxCell = self:getBoxSelected()
        if boxIdx ~= nil and boxCell ~= nil then
          self._gamepadOperationType = GamepadOprationType.BOXSWAP
          self._boxCell = boxCell
          self._boxIdx = boxIdx
          self._boxCell:setAlpha(0.5)
          local item = self._boxItems[boxIdx]
          local icon = L_ItemTplManager:getCommonItem(item.item_id).icon
          self._holdNum = item.num
          self:syncFloatIconPos()
          self:SetFloatIconEnabled(true, icon)
        end
      end
    end
    self:refreshBottomTips()
  end)
end

function this:resetGamepadParams()
  self._isFocusBag = true
  self._isNumTipShown = false
  self._gamepadOperationType = GamepadOprationType.NORMAL
end

function this:checkIsGamepad()
  if not C_InputManager.IsEnableGamePad then
    self:resetGamepadParams()
  end
  return C_InputManager.IsEnableGamePad
end

function this:handleGamepadEsc()
  if self.bind.active_tip then
    self.bind.active_tip = false
    self._curSelectNum = 0
    self:onTipCloseGamepad()
  end
  if self._gamepadOperationType ~= GamepadOprationType.NORMAL then
    self:clearOperationStatus()
    self:refreshBottomTips()
  end
end

function this:clearOperationStatus()
  self._gamepadOperationType = GamepadOprationType.NORMAL
  if self._isFocusBag then
    self.bindComponents.nav_binding:SelectArea("AreaBag")
    self._selectedType = DragAreaType.BAG
  else
    self.bindComponents.nav_binding:SelectArea("AreaStorage")
    self._selectedType = nil
  end
  self:SetFloatIconEnabled(false)
  if self._boxCell ~= nil then
    self._boxCell:setAlpha(1)
  end
  if self._bagCell ~= nil then
    self._bagCell:setAlpha(1)
  end
end

function this:onTipOpenGamepad()
  C_InputManager.GetAction("UI/Submit"):Disable()
  self.bindComponents.nav_binding.navigationEnabled = false
  self._isNumTipShown = true
  self:refreshBottomTips()
end

function this:onTipCloseGamepad(ignoreSelectedType)
  C_InputManager.GetAction("UI/Submit"):Enable()
  self.bindComponents.nav_binding.navigationEnabled = true
  self.bindComponents.nav_binding:SelectArea("AreaBag")
  if not ignoreSelectedType then
    self._selectedType = DragAreaType.BAG
  end
  self._isNumTipShown = false
  self:refreshBottomTips()
end

function this:getBagSelected()
  local selGo = C_GamepadUtility.GetCurrentSelectedGameObject()
  for i, cell in ipairs(self.modules.grid_bag) do
    if cell:getRaycastGo() == selGo then
      return i, cell
    end
  end
end

function this:getBoxSelected()
  local selGo = C_GamepadUtility.GetCurrentSelectedGameObject()
  for i, cell in ipairs(self.modules.grid_box) do
    if cell:getRaycastGo() == selGo then
      return i, cell
    end
  end
end

function this:getBoxEmptySlot()
  for i, cell in ipairs(self.modules.grid_box) do
    if cell:isEmpty() then
      return i, cell
    end
  end
end

function this:SetFloatIconEnabled(enabled, icon)
  if icon ~= nil then
    self.bind.img_drag = icon
  end
  self.bind.txt_dragNum = tostring(self._holdNum)
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
  C_MJLog.LogInfo("[VTS] 同步icon位置:" .. tostring(selPos))
  L_Vector3.setAnchored(self.bindComponents.rect_drag, selPos)
end

function this:onNavigate(v2)
  if not self:checkIsGamepad() then
    return
  end
  if self._gamepadOperationType == GamepadOprationType.BOXSWAP then
    self:syncFloatIconPos()
  end
end

function this:onControlSchemeChange()
  if C_InputManager.IsEnableGamePad then
    if L_DeviceTpl:getIsPc() then
      self.bind.go_pcTip = false
    end
    self:clearOperationStatus()
    if not self._isFocusBag or self.bind.active_tip then
      C_InputManager.GetAction("UI/Submit"):Disable()
    end
    self:refreshBottomTips()
  else
    if L_DeviceTpl:getIsPc() then
      self.bind.go_pcTip = true
    end
    self:clearOperationStatus()
    C_InputManager.GetAction("UI/Submit"):Enable()
  end
end

function this:refreshBottomTips()
  local grpName
  if self._gamepadOperationType == GamepadOprationType.NORMAL then
    if self._isNumTipShown then
      grpName = GRP_NUM_TIP
    elseif self._isFocusBag then
      grpName = GRP_BAG
    else
      grpName = GRP_BOX
    end
  elseif self._gamepadOperationType == GamepadOprationType.BOXSWAP then
    grpName = GRP_BOX_SWAP
  end
  if grpName ~= nil then
    local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {
      moduleOrPageName = "pageHomeCropBox",
      changeGroupName = grpName
    }
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
  end
end

return this
