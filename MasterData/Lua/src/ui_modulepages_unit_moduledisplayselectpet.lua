local this = class("moduleDisplaySelectPet", G_UIModuleBase)
local PageCount = 30
local shrinkInterval = 140

function this.bind()
  return {
    go_shrink = false,
    list_pet_snap_start_index = 0,
    list_pet_snap_end_index = 0,
    isOn_listEmpty_shrink = false,
    list_pet_shrink = {
      moduleName = "pages/formation/formationModule/cellPixelPetFormation"
    },
    list_pet_buffer = {
      moduleName = "pages/formation/formationModule/cellPixelPetFormation"
    },
    txt_lineA = "",
    txt_lineB = "",
    module_sortFilter_shrink = L_Const.ModuleInfo.SortFilterModule,
    go_boxInfo_shrink = false,
    module_petBoxSortFilter = {
      moduleName = "modulePages/unit/modulePetBoxDropdown"
    },
    module_formationPetProperty = {
      type = "toggleModule",
      moduleFormationPetProperty = {
        assetName = "UI/pages/Formation/moduleFormationPetProperty",
        moduleName = "pages/formation/formationModule/moduleFormationPetProperty"
      }
    },
    module_formationPetPropertyName = ""
  }
end

function this:open()
  self._selectPetHandler = handler(self, self.selectPet)
  self._onPointEnterPetCellHandler = handler(self, self.onPointEnterPetCell)
  self._onPointExitPetCellHandler = handler(self, self.onPointExitPetCell)
  self._afterLateUpdateHandle = handler(self, self.onLateUpdate)
  C_UpdateSource.AddAfterLateUpdateEventHandler(self._afterLateUpdateHandle, "FormationMain_moduleSelectPet.afterLateUpdateHandle")
  self.rectListMain = self.bindComponents.rect_pet_shrinkMid
  self.rectListBuffer = self.bindComponents.rect_pet_shrinkNext
  self.rectContentMain = self.bindComponents.content_pet_shrinkMid
  self.rectContentBuffer = self.bindComponents.content_pet_shrinkNext
  self.bindListMain = self.bind.list_pet_shrink
  self.bindListBuffer = self.bind.list_pet_buffer
  self.scrollMain = self.bindComponents.scrollRect_shrink
  self.scrollBuffer = self.bindComponents.scrollRectNext_shrink
  self.line1 = self.bindComponents.line1
  self.line2 = self.bindComponents.line2
  
  function self.scrollMain.rectOnEndDrag()
    self:onShrinkScrollEnd(self.scrollMain)
    if not L_DeviceTpl:getIsPc() then
      return
    end
    if self._petPropertyModule then
      self._petPropertyModule:showModuleInfo(false)
    end
  end
  
  function self.scrollBuffer.rectOnEndDrag()
    self:onShrinkScrollEnd(self.scrollBuffer)
  end
  
  self.enableDetailBtnFlag = true
  self.mainPosX = self.rectListMain.localPosition.x
  self.prePosX = self.mainPosX - self.rectListMain.rect.width - shrinkInterval
  self.nextPosX = self.mainPosX + self.rectListMain.rect.width + shrinkInterval
  self.scrollDirection = 0
  self._bufferDirection = 1
  self._isInitialLoading = false
end

function this:close(options)
  self:configTouch("-")
  L_TimerManager:clearTimer(self)
  if self._afterLateUpdateHandle then
    C_UpdateSource.RemoveAfterLateUpdateEventHandler(self._afterLateUpdateHandle)
  end
  self._afterLateUpdateHandle = nil
  if self.scrollMain then
    self.scrollMain.rectOnEndDrag = nil
    self.scrollMain.refreshCellsFinish = nil
  end
  if self.scrollBuffer then
    self.scrollBuffer.rectOnEndDrag = nil
  end
  if self.scrollTween1 then
    self.scrollTween1:Kill()
    self.scrollTween1 = nil
  end
  if self.scrollTween2 then
    self.scrollTween2:Kill()
    self.scrollTween2 = nil
  end
  self._onMainListLoadFinished = nil
  self._isInitialLoading = false
end

function this:initModule(param)
  self._param = param or {}
  self._petBoxIndex = param.defaultSelectBoxIndex
  self.cellType = param.cellType
  self.editMode = param.editMode or false
  self:initSortFilterModule()
  self.bind.go_shrink = false
  self:playShrinkVFX()
  self:initPetList()
  self:refreshContent()
end

function this:initSortFilterModule()
  if L_FormationManager:getRuntimeFormationIndex() ~= nil and self._lastEditFormationIndex == L_FormationManager:getRuntimeFormationIndex() then
    return
  end
  self._lastEditFormationIndex = L_FormationManager:getRuntimeFormationIndex()
  self._petSortFilter = L_SortFilterManager:createSortFilter(self._param.systemId, function()
    self._petPageIndex = 1
    self:initPetList()
    self:refreshContent()
  end, function()
    self._petPageIndex = 1
    self:initPetList()
    self:refreshContent()
  end)
end

function this:refreshContent()
  self._petSortFilter:bindModule(self.modules.module_sortFilter_shrink)
  self:refreshThreePagePet_shrink()
  self.bind.go_boxInfo_shrink = self._isPetBoxMode
  if self._isPetBoxMode or self._param.systemId == L_SystemConst.enum.petDisplay then
    self:initPetBoxFilterModule()
  end
  self:configTouch("+")
end

function this:initPetList()
  self._isPetBoxMode = self._petSortFilter.filterKeyDic[L_SortFilterConst.FilterType.QiBoBoxMode] == nil
  self._petTotalDataList = {}
  if not self._isPetBoxMode then
    local allPet = L_PetStore:getPetList()
    for i, pet in pairs(allPet) do
      table.insert(self._petTotalDataList, {
        itemType = L_Const.resType.pet,
        itemId = pet.id,
        guid = pet.guid
      })
    end
    self._petSortFilter:sortFilterList(self._petTotalDataList)
  end
end

function this:refreshTwoPagePet_shrink(direction)
  if self._isPetBoxMode then
    self:moveToPage()
  end
  local PAGE_COUNT = 30
  local GROUP_HEAD_PADDING = 1
  local GROUP_TOTAL_COUNT = PAGE_COUNT + GROUP_HEAD_PADDING
  
  local function buildEmptyCell()
    return {
      itemType = 0,
      itemId = 0,
      guid = 0,
      callback = false,
      pointEnterCallback = false,
      pointExitCallback = false
    }
  end
  
  local function buildGroupHeadPaddingCell(groupId)
    return {
      itemType = 0,
      itemId = 0,
      guid = 0,
      callback = false,
      pointEnterCallback = false,
      pointExitCallback = false,
      groupId = groupId
    }
  end
  
  local function buildAllPetDataWithSlot()
    local groupMap = {}
    local guidMap = {}
    local petList = {}
    
    local function addPetByGuid(guid)
      if not guid or math.isEmpty(guid) or guidMap[guid] then
        return
      end
      guidMap[guid] = true
      local petData = L_PetStore:getPetItem(guid)
      if not petData or not petData.box_id then
        return
      end
      local boxId = petData.box_id
      local groupId = math.floor(boxId / 100)
      local posId = boxId % 100
      if groupId <= 0 then
        return
      end
      if posId < 1 or posId > PAGE_COUNT then
        return
      end
      local cell = {
        itemType = L_Const.resType.pet,
        itemId = petData.id,
        type = self.cellType or L_Const.cellIconUnitType.selectPet,
        guid = guid,
        callback = self._selectPetHandler,
        pointEnterCallback = self._onPointEnterPetCellHandler,
        pointExitCallback = self._onPointExitPetCellHandler,
        boxId = boxId
      }
      table.insert(petList, cell)
    end
    
    local totalGroupNum = L_PetStore:getPetBoxNum() or 0
    for boxIndex = 1, totalGroupNum do
      local boxData = L_PetStore:getPetBoxList(boxIndex) or {}
      for _, guid in pairs(boxData) do
        addPetByGuid(guid)
      end
    end
    self._petSortFilter:filterList(petList)
    for _, cell in ipairs(petList) do
      local boxId = cell.boxId
      local groupId = math.floor(boxId / 100)
      local posId = boxId % 100
      cell.boxId = nil
      groupMap[groupId] = groupMap[groupId] or {}
      groupMap[groupId][posId] = cell
    end
    local curPageData = {}
    for groupId = 1, totalGroupNum do
      local groupData = groupMap[groupId] or {}
      for pos = 1, GROUP_TOTAL_COUNT do
        if pos == 1 then
          table.insert(curPageData, buildGroupHeadPaddingCell(groupId))
        else
          local realPos = pos - GROUP_HEAD_PADDING
          if groupData[realPos] then
            table.insert(curPageData, groupData[realPos])
          else
            table.insert(curPageData, buildEmptyCell())
          end
        end
      end
    end
    return curPageData
  end
  
  if self._isPetBoxMode then
    local curPageData = buildAllPetDataWithSlot()
    self.rectListMain.gameObject:SetActive(true)
    self.rectListBuffer.gameObject:SetActive(false)
    self.line1.gameObject:SetActive(false)
    self.line2.gameObject:SetActive(false)
    if #self.bindListMain == #curPageData then
      for i, v in pairs(curPageData) do
        self.bindListMain:change(i, v)
      end
    else
      self.bindListMain:clear()
      self.bindListMain:insert_array(curPageData)
    end
    self.bind.isOn_listEmpty_shrink = table.isEmpty(curPageData)
    self.scrollMain:StopMovement()
    self.scrollMain:FocusItemIndex(1)
    self._bufferDirection = nil
    self._isInitialLoading = nil
    if self.scrollMain then
      self.scrollMain.refreshCellsFinish = nil
    end
    self:refreshShrinkInteractive()
  else
    local curPageData = {}
    for _, v in ipairs(self._petTotalDataList or {}) do
      table.insert(curPageData, {
        guid = v.guid,
        callback = self._selectPetHandler,
        pointEnterCallback = self._onPointEnterPetCellHandler,
        pointExitCallback = self._onPointExitPetCellHandler
      })
    end
    self.bind.isOn_listEmpty_shrink = table.isEmpty(curPageData)
    if #self.bindListMain == #curPageData then
      for i, v in pairs(curPageData) do
        self.bindListMain:change(i, v)
      end
    else
      self.bindListMain:clear()
      self.bindListMain:insert_array(curPageData)
    end
    self.rectListMain.gameObject:SetActive(true)
    self.rectListBuffer.gameObject:SetActive(false)
    self.line1.gameObject:SetActive(false)
    self.line2.gameObject:SetActive(false)
    self.bind.list_pet_snap_start_index = 0
    self.bind.list_pet_snap_end_index = 0
    self.scrollMain:StopMovement()
    self.scrollMain:FocusItemIndex(0)
  end
  self:setListSelect(self.selectDic)
end

function this:refreshTwoPagePet_shrinkOld(direction)
  if self._isPetBoxMode then
    self:moveToPage()
  end
  if self._isPetBoxMode then
    self.rectListMain.gameObject:SetActive(true)
    self.line1.gameObject:SetActive(true)
    self.line2.gameObject:SetActive(true)
    self._petBoxIndex = self._petBoxIndex or 1
    local listsToRefresh = {}
    if direction == nil then
      listsToRefresh = {
        {
          offset = 0,
          bindList = self.bindListMain
        },
        {
          offset = 1,
          bindList = self.bindListBuffer
        }
      }
      self._bufferDirection = 1
      self._isInitialLoading = true
    elseif direction == 1 then
      self.rectListBuffer.gameObject:SetActive(true)
      listsToRefresh = {
        {
          offset = 1,
          bindList = self.bindListBuffer
        }
      }
      self._bufferDirection = 1
    elseif direction == -1 then
      self.rectListBuffer.gameObject:SetActive(true)
      listsToRefresh = {
        {
          offset = -1,
          bindList = self.bindListBuffer
        }
      }
      self._bufferDirection = -1
    end
    for _, listInfo in ipairs(listsToRefresh) do
      local curPageData = {}
      local boxIndex = self._petBoxIndex + listInfo.offset
      boxIndex = (boxIndex - 1 + L_PetStore:getPetBoxNum()) % L_PetStore:getPetBoxNum() + 1
      local bindList = listInfo.bindList
      local boxData = L_PetStore:getPetBoxList(boxIndex)
      local temp = {}
      for _, guid in pairs(boxData) do
        if not math.isEmpty(guid) then
          local petData = L_PetStore:getPetItem(guid)
          table.insert(temp, {
            itemType = L_Const.resType.pet,
            itemId = petData.id,
            type = self.cellType or L_Const.cellIconUnitType.selectPet,
            guid = guid,
            callback = self._selectPetHandler,
            pointEnterCallback = self._onPointEnterPetCellHandler,
            pointExitCallback = self._onPointExitPetCellHandler
          })
        end
      end
      self._petSortFilter:sortFilterList(temp)
      for _ = 1, PageCount do
        table.insert(curPageData, {
          itemType = 0,
          itemId = 0,
          guid = 0,
          callback = nil
        })
      end
      for _, cell in pairs(temp) do
        local pet = L_PetStore:getPetItem(cell.guid)
        curPageData[pet.box_id % 100] = cell
      end
      if #bindList == #curPageData then
        for i, v in pairs(curPageData) do
          bindList:change(i, v)
        end
      else
        bindList:clear()
        bindList:insert_array(curPageData)
      end
    end
    self.scrollMain:StopMovement()
    if direction == nil then
      self.scrollMain.horizontalNormalizedPosition = 0
      self.rectListBuffer.gameObject:SetActive(false)
      if self._onMainListLoadFinished == nil then
        function self._onMainListLoadFinished()
          self:onMainListLoadFinished()
        end
      end
      self.scrollMain.refreshCellsFinish = self._onMainListLoadFinished
    else
      self:updateBufferPosition()
    end
    self.scrollBuffer:StopMovement()
    if self._bufferDirection == 1 then
      self.scrollBuffer:FocusItemIndex(0)
      self.scrollBuffer.horizontalNormalizedPosition = 0
      self.scrollBuffer:StopMovement()
    elseif self._bufferDirection == -1 then
      self.scrollBuffer:FocusItemIndex(#self.bindListBuffer - 1)
      self.scrollBuffer.horizontalNormalizedPosition = 1
      self.scrollBuffer:StopMovement()
    end
    self:refreshLineText()
    self:refreshShrinkInteractive()
  else
    local curPageData = {}
    for _, v in ipairs(self._petTotalDataList) do
      table.insert(curPageData, {
        guid = v.guid,
        callback = self._selectPetHandler,
        pointEnterCallback = self._onPointEnterPetCellHandler,
        pointExitCallback = self._onPointExitPetCellHandler
      })
    end
    self.bind.isOn_listEmpty_shrink = table.isEmpty(curPageData)
    if #self.bindListMain == #curPageData then
      for i, v in pairs(curPageData) do
        self.bindListMain:change(i, v)
      end
    else
      self.bindListMain:clear()
      self.bindListMain:insert_array(curPageData)
    end
    self.rectListBuffer.gameObject:SetActive(false)
    self.line1.gameObject:SetActive(false)
    self.line2.gameObject:SetActive(false)
    self.scrollMain:StopMovement()
    self.scrollMain:FocusItemIndex(0)
  end
  self:setListSelect(self.selectDic)
end

function this:refreshThreePagePet_shrink(mark)
  self:refreshTwoPagePet_shrink(mark)
end

function this:initPetBoxFilterModule()
  local module_petBoxSortFilter = self.modules.module_petBoxSortFilter
  module_petBoxSortFilter:initModuleByDefaultIndex(self._petBoxIndex, function(selectIndex)
    if not self._isPetBoxMode then
      return
    end
    self._petBoxIndex = selectIndex
    local realCount = PageCount + 1
    local startIndex = (self._petBoxIndex - 1) * realCount + 1
    self.bind.list_pet_snap_start_index = startIndex
    self.bind.list_pet_snap_end_index = startIndex + PageCount - 1
    self.scrollMain:FocusItemIndex(startIndex)
  end)
end

function this:selectPet(cell)
  self:emit("onClick_selectPet", cell.bind.guid)
  if self.bind.onClickSelectPet then
    self.bind:onClickSelectPet(cell.bind.guid)
  end
  self.selPetID = cell.bind.guid
  if not self.editMode then
    return
  end
  if L_DeviceTpl:getIsPc() then
    return
  end
  self:showPetProperty(cell:getRaycastGo(), cell.bind.guid)
end

function this:moveToPage()
  if math.isEmpty(self._moveToId) then
    return
  end
  if self._isPetBoxMode then
    self._petBoxIndex = math.floor(L_PetStore:getPetItem(self._moveToId).box_id / 100)
  else
    for i, v in ipairs(self._petTotalDataList) do
      if v.guid == self._moveToId then
        self._petPageIndex = math.ceil(i / PageCount)
        break
      end
    end
  end
  self._moveToId = nil
end

function this:escHandle()
  if self._isPlayingVFX then
    return true
  end
end

function this:setListSelect(selectDic)
  self.selectDic = selectDic or {}
  for _, v in pairs(self.modules.list_pet_shrink) do
    local cell = v
    local petParams = self.selectDic[cell.bind.guid]
    cell:setSelect((petParams and petParams.isSelect) == true)
    cell:setPosIndex(petParams and petParams.index)
  end
  for _, v in pairs(self.modules.list_pet_buffer) do
    local cell = v
    local petParams = self.selectDic[cell.bind.guid]
    cell:setSelect((petParams and petParams.isSelect) == true)
    cell:setPosIndex(petParams and petParams.index)
  end
end

function this:onPointEnterPetCell(cell)
  if not L_DeviceTpl:getIsPc() then
    return
  end
  self:showPetProperty(cell:getRaycastGo(), cell.bind.guid)
end

function this:onPointExitPetCell(cell)
  if not L_DeviceTpl:getIsPc() then
    return
  end
  if self._petPropertyModule then
    self._petPropertyModule:showModuleInfo(false)
  end
end

function this:configTouch(operator)
  if not L_DeviceTpl:getIsMobile() then
    return
  end
  self.onUIClickHandle = self.onUIClickHandle or L_CommonUtil.handle(self.onUI_clickHandle, self)
  C_ScreenTouch.OnUI_Click(operator, self.onUIClickHandle)
end

function this:onUI_touchHandle(gesture)
  if not self.isBind then
    return
  end
  local go = gesture.go
  local holdId = self:getHoldInfo(go)
  if math.isEmpty(holdId) then
    return
  end
  L_FlyMsgManager:startLongPress(gesture, 0.5, function()
    self:showPetProperty(go, holdId)
  end)
end

function this:onUI_clickHandle()
  if not self.isBind then
    return
  end
  if self._petPropertyModule then
    self._petPropertyModule:showModuleInfo(false)
  end
end

function this:getHoldInfo(go)
  for _, v in ipairs(self.modules.list_pet_shrink) do
    local module = v
    if module:getRaycastGo() == go then
      return module.bind.guid
    end
  end
  for _, v in ipairs(self.modules.list_pet_buffer) do
    local module = v
    if module:getRaycastGo() == go then
      return module.bind.guid
    end
  end
end

function this:showPetProperty(go, guid)
  if not self._petPropertyModule then
    self.bind.module_formationPetPropertyName = "moduleFormationPetProperty"
    self._petPropertyModule = self.modules.module_formationPetProperty.moduleFormationPetProperty
    if self.enableDetailBtnFlag then
      self._petPropertyModule:openDetailBtn()
    end
  end
  local targetPosX = self.bindComponents.rect_moduleSelectPet.transform:InverseTransformPoint(go.transform.position).x
  local halfScreenWidth = self.bindComponents.rect_moduleSelectPet.transform.rect.width / 2
  self._petPropertyModule:showModuleInfo(true, guid)
  self._petPropertyModule:setLocalPosAndArrow(targetPosX, halfScreenWidth, go)
end

function this:playShrinkVFX()
  if not self.isBind then
    return
  end
  if self._isPlayingVFX then
    return
  end
  self.bind.go_shrink = true
  self._isPlayingVFX = true
  if self.bindComponents.ani_moduleSelectPet then
    self.bindComponents.ani_moduleSelectPet:SetBool("Expand", false)
  end
  L_TimerManager:newOrResetTimer(self, "playShrinkVFX", function()
    self._isPlayingVFX = false
  end, 0.17)
end

function this:updateBufferPosition()
end

function this:onMainListLoadFinished()
  if not self.isBind then
    return
  end
  if self._isInitialLoading then
    self._isInitialLoading = false
    self.rectListBuffer.gameObject:SetActive(true)
    self:updateBufferPosition()
    self.scrollMain.refreshCellsFinish = nil
  end
end

function this:onLateUpdate()
end

function this:onShrinkScrollEnd(scroll)
  if scroll == self.scrollMain then
    if not self._isPetBoxMode then
      self.bind.list_pet_snap_start_index = 0
      self.bind.list_pet_snap_end_index = 0
      return
    end
    local p = self.scrollMain.horizontalNormalizedPosition
    local boxNum = L_PetStore:getPetBoxNum()
    local realCount = PageCount + 1
    local offset = 1.0 / boxNum * (3.0 / realCount)
    local newIndex = math.clamp(math.floor(boxNum * (p + offset)) + 1, 1, boxNum)
    local startSnapIndex = (newIndex - 1) * realCount + 1
    local endSnapIndex = startSnapIndex + PageCount - 1
    self.bind.list_pet_snap_start_index = startSnapIndex
    self.bind.list_pet_snap_end_index = endSnapIndex
    if newIndex ~= self._petBoxIndex then
      self._petBoxIndex = newIndex
      self.modules.module_petBoxSortFilter:refreshInfoWithoutCallback(self._petBoxIndex)
    end
  end
end

function this:scrollToNext()
  if self.scrollTween1 then
    self.scrollTween1:Kill()
  end
  if self.scrollTween2 then
    self.scrollTween2:Kill()
  end
  self.scrollTween1 = self.rectListMain:DOLocalMoveX(self.prePosX, 0.4):SetEase(Tweening.Ease.OutCirc)
  self.scrollTween2 = self.rectListBuffer:DOLocalMoveX(self.mainPosX, 0.4):SetEase(Tweening.Ease.OutCirc):OnComplete(function()
    self:tweenScrollEnd(1)
  end)
end

function this:scrollToPre()
  if self.scrollTween1 then
    self.scrollTween1:Kill()
  end
  if self.scrollTween2 then
    self.scrollTween2:Kill()
  end
  self.scrollTween1 = self.rectListMain:DOLocalMoveX(self.nextPosX, 0.4):SetEase(Tweening.Ease.OutCirc)
  self.scrollTween2 = self.rectListBuffer:DOLocalMoveX(self.mainPosX, 0.4):SetEase(Tweening.Ease.OutCirc):OnComplete(function()
    self:tweenScrollEnd(-1)
  end)
end

function this:tweenScrollEnd(direction)
  if not self.isBind then
    return
  end
  self.tweenScrolling = false
  self.scrollDirection = 0
  local tempRect = self.rectListMain
  local tempScroll = self.scrollMain
  local tempBind = self.bindListMain
  local tempContent = self.rectContentMain
  self.rectListMain = self.rectListBuffer
  self.scrollMain = self.scrollBuffer
  self.bindListMain = self.bindListBuffer
  self.rectContentMain = self.rectContentBuffer
  self.rectListBuffer = tempRect
  self.scrollBuffer = tempScroll
  self.bindListBuffer = tempBind
  self.rectContentBuffer = tempContent
  
  function self.scrollMain.rectOnEndDrag()
    self:onShrinkScrollEnd(self.scrollMain)
  end
  
  function self.scrollBuffer.rectOnEndDrag()
    self:onShrinkScrollEnd(self.scrollBuffer)
  end
  
  local boxIndex = self._petBoxIndex + direction
  boxIndex = (boxIndex - 1 + L_PetStore:getPetBoxNum()) % L_PetStore:getPetBoxNum() + 1
  self._petBoxIndex = boxIndex
  if self._isPetBoxMode then
    self.modules.module_petBoxSortFilter:refreshInfoWithoutCallback(self._petBoxIndex)
    self:refreshTwoPagePet_shrink(1)
    self:refreshShrinkInteractive()
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Button_Slide")
  end
end

function this:refreshLineText()
  local boxIndex = self._petBoxIndex - 1
  boxIndex = (boxIndex - 1 + L_PetStore:getPetBoxNum()) % L_PetStore:getPetBoxNum() + 1
  local pre = string.format("%02d", boxIndex)
  local boxIndex = self._petBoxIndex + 1
  boxIndex = (boxIndex - 1 + L_PetStore:getPetBoxNum()) % L_PetStore:getPetBoxNum() + 1
  local next = string.format("%02d", boxIndex)
  self.bind.txt_lineA = pre
  self.bind.txt_lineB = next
end

function this:refreshShrinkInteractive()
  local canvasGroupMain = self.rectListMain:GetComponent(typeof(C_CanvasGroup))
  local canvasGroupBuffer = self.rectListBuffer:GetComponent(typeof(C_CanvasGroup))
  canvasGroupMain.blocksRaycasts = true
  canvasGroupBuffer.blocksRaycasts = false
end

return this
