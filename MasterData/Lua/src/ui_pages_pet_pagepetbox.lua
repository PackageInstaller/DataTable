local this = class("pagePetBox", G_UIPageBase)
local _petTpl = L_GameTpl:getPetTpl()
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _systemFilterTpl = L_GameTpl:getSystemFilterTpl()
local _systemFiltertypeTpl = L_GameTpl:getSystemFiltertypeTpl()
local PetBoxScrollSpeed = 3000
local PetBoxScrollUnlockDelay = 1.1
local FilterScope = {CurrentBox = 1, AllBox = 2}
local GamepadFocusRegions = {
  PetList = 0,
  PetInfo = 1,
  FilterPanel = 2,
  PetListReleaseMode = 10,
  PetReleaseFilterPanel = 11
}
local GamepadNavigationAreas = {
  PetList = "AreaPetList",
  FilterPanel = "AreaFilterPanel",
  PetReleaseFilterPanel = "AreaPetReleaseFilterPanel"
}

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {curIndex = 1}
  self.filterType = {
    [L_PetConst.filterPetBox.level] = "ui_pageHomeCenterPetStationedManage_01",
    [L_PetConst.filterPetBox.grade] = "ui_pageHomeCenterPetStationedManage_02",
    [L_PetConst.filterPetBox.labor] = "ui_pageHomeCenterPetStationedManage_04"
  }
  self.filterTypeOrder = {
    L_PetConst.filterPetBox.grade,
    L_PetConst.filterPetBox.level,
    L_PetConst.filterPetBox.labor
  }
  self._filterKeyDic = nil
  self._filteredPetList = {}
  self._filteredPetMap = {}
  self._filterPrevBoxIndex = nil
  self._filterResultLocked = false
end

function this.bind()
  return {
    loopListBox = {
      moduleName = "pages/pet/cellPetBox"
    },
    modulePetBoxProperty = {
      moduleName = "pages/pet/new/modulePetBoxInfo"
    },
    show_petBoxProperty = false,
    list_dropdown = {
      moduleName = "modulePages/sortFilter/cellSortFilterDropdown"
    },
    txt_dropDown = "",
    toggleArrow = false,
    dropDownContent = false,
    go_curBoxIndex = true,
    curBoxIndex = "",
    curBoxName = "",
    go_changeBoxName = true,
    img_drag = "",
    edgeLeft_enable = false,
    edgeRight_enable = false,
    modulesPetRelease = {
      type = "toggleModule",
      isAsync = true,
      modulePetRelease = {
        assetName = "UI/Pages/Pet/modulePetRelease",
        moduleName = "pages/pet/modulePetRelease"
      }
    },
    togglePetRelease = "",
    modulePetReleaseActive = false,
    btnPetFreeActive = true,
    module_pageTabSlider = {
      moduleName = "modulePages/modulePageTabSlider"
    },
    downBgActive = true,
    boxInfoActive = true,
    activeUnlockState = false,
    activelockState = false,
    show_filter_icon_on = true,
    modulesPetBoxEntrance = {
      type = "toggleModule",
      isAsync = true,
      modulePetBoxEntrance = {
        assetName = "UI/Pages/Pet/modulePetBoxQuick",
        moduleName = "pages/pet/moduleQuickPetBox"
      }
    },
    togglePetBoxEntrance = "",
    go_listPetBoxEntrance = false,
    activeNextHitArea = true,
    activelastHitArea = true,
    img_Enable = false,
    offset_boxfilter = false,
    module_pet = true,
    module_pageFilter = {
      moduleName = "pages/pet/new/modulePetFilter"
    },
    show_filterTitle = false,
    txt_filterTitle = "",
    go_commonPetList = true,
    go_filterPetList = false,
    petbox_Filter = {
      moduleName = "pages/pet/cellPetBox",
      pageType = L_PetConst.PageType.House
    },
    go_commonBoxInfo = true
  }
end

function this.methods()
  return {
    onSnapFinished = function(self, index)
      self.realIndex = index
      self.bindComponents.list_petBox:ScrollToCell(index, 3000, nil, function(idx)
        self:onPetBoxListScrollToIndex(idx)
      end)
      local snapIndex = index + 1
      local realBoxIndex = self:realSnapToItemIndex(snapIndex)
      self:setPointListActive(realBoxIndex)
      self:refreshCurBox()
    end,
    loopListBox = {
      onClick_Choose = function(self, id)
      end
    },
    onClick_orderPetBoxInfo = function(self)
      if self.isInFilter then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_petdna_type_isfilter"))
        return
      end
      L_UI:open("pagePetSortFilter", {
        boxIndex = self.data.curIndex,
        callback = function()
          self:refreshCurBox(true)
        end
      })
    end,
    onClick_changePetBoxName = function(self)
      if not self.isTop then
        return
      end
      if self.isInFilter then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_petdna_type_isfilter"))
        return
      end
      local unlock = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.renameKiboBox)
      if not unlock then
        return
      end
      local boxIndex = self.data.curIndex
      self._isRenamingPetBox = true
      local data = {
        txtTitle = L_WordsTpl:getValue("ui_kibo_box_change_name_text1"),
        placeHolder = L_WordsTpl:getValue("ui_modulePetBoxName_03"),
        limit = 7,
        keepPageOpen = true,
        notNewLine = true,
        textBoxType = L_Const.CommonTextBoxType.Rename,
        pageClosedCallback = function()
          self._isRenamingPetBox = false
        end,
        confirmCallback = function(txt)
          if string.isEmpty(string.trim(txt)) then
            L_FlyMsgManager:showNormalMsgByKey("notice_pageFormationMain_03")
            return
          end
          if string.gsub(txt, " ", "") ~= txt then
            L_FlyMsgManager:showNormalMsgByKey("notice_pageFormationMain_02")
            return
          end
          L_PetStore:req_changePetBoxName(txt, boxIndex, function(name)
            if name == nil then
              L_UI:close("pageCommonTextBox")
              L_FlyMsgManager:showNormalMsgByKey("notice_kibo_box_name_change_success")
            end
          end)
        end
      }
      L_GameUtil.showNormalTextBox(data)
    end,
    onClick_showDropDownContent = function(self)
      self:refreshFilterActive()
      self.bind.dropDownContent = not self.bind.dropDownContent
      self.bind.toggleArrow = not self.bind.toggleArrow
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.img_frame)
    end,
    onClick_nextBox = function(self)
      if self.isInFilter then
        return
      end
      self:scrollPetBoxToIndex(self.realIndex + 1, true, true, function(index)
        self:onPetBoxListScrollToIndex(index)
      end)
    end,
    onClick_lastBox = function(self)
      if self.isInFilter then
        return
      end
      self:scrollPetBoxToIndex(self.realIndex - 1, true, true, function(index)
        self:onPetBoxListScrollToIndex(index)
      end)
    end,
    onClick_PetFree = function(self)
      if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petRelease) then
        return
      end
      L_PetStore:resetSelectGuids()
      L_PetReleaseManager:setIsReleaseMode(true, true)
      self:setReleaseMode()
      if #L_PetStore:getSelectGuids() == 0 then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_pet_empty"))
      end
    end,
    onClick_Filter = function(self)
      if self.bind.offset_boxfilter then
        self:onCloseFilter()
        return
      end
      self:_onClickFilter()
    end,
    list_dropdown = {
      onClick_select = function(self, bind)
        self.filter = bind.index
        self.bind.dropDownContent = false
        self.bind.txt_dropDown = bind.type
        self.bind.toggleArrow = false
        self:refreshFilterActive()
        if self.isInFilter then
          local module = self.modules.petbox_Filter
          if module and module.modules and module.modules.list_pet then
            for _, petCell in pairs(module.modules.list_pet) do
              if petCell and petCell.refreshFilterType and petCell.bind and (not math.isEmpty(petCell.bind.guid) or petCell.bind.filterEmpty) then
                petCell:refreshFilterType(self.filter)
              end
            end
          end
          local scrollView = module and module.bindComponents and module.bindComponents.scrollView
          if scrollView then
            scrollView.verticalNormalizedPosition = 1
          end
        else
          for i = 1, #self.bind.loopListBox do
            local boxModule = self.bind.loopListBox:getItemCls(i)
            if boxModule and boxModule.modules and boxModule.modules.list_pet then
              for j = 1, #boxModule.modules.list_pet do
                local petCell = boxModule.modules.list_pet[j]
                if petCell and petCell.refreshFilterType then
                  petCell:refreshFilterType(self.filter)
                end
              end
            end
          end
        end
      end
    },
    onPointEnter_right = function(self)
      if self.bindComponents.rect_drag.gameObject.activeSelf == true then
        self:createAutoDragTimer(1)
      end
    end,
    onPointExit_right = function(self)
      if self.bindComponents.rect_drag.gameObject.activeSelf == true then
        self:killAutoDragTimer()
      end
    end,
    onPointEnter_left = function(self)
      if self.bindComponents.rect_drag.gameObject.activeSelf == true then
        self:createAutoDragTimer(0)
      end
    end,
    onPointExit_left = function(self)
      if self.bindComponents.rect_drag.gameObject.activeSelf == true then
        self:killAutoDragTimer()
      end
    end,
    dropDownContentBgOnClick = function(self)
      self.bind.dropDownContent = false
      self.bind.toggleArrow = false
    end,
    onClick_lock = function(self)
      local nowTime = L_TimeUtil:getServerTime()
      if self.lockCDTime and nowTime <= self.lockCDTime then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageMultiDungeonMatching_13"))
        return
      end
      self:switchLockPetBox(not self.islockPetBox)
    end,
    onClick_closeFilter = function(self)
      self:onCloseFilter()
      self:clearFilter()
    end,
    onClick_exitPetFilter = function(self)
      self:onCloseFilter()
      self:clearFilter()
    end
  }
end

function this:checkCanlockBox(echo)
  local lockBoxIds = L_PetStore:getLockBoxIds()
  local boxNum = L_PetStore:getPetBoxNum()
  if #lockBoxIds >= math.max(0, boxNum - 1) then
    if echo then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_can_not_lock_all_kibo_box"))
    end
    return false
  end
  return true
end

function this:switchLockPetBox(isLock)
  if isLock then
    if not self:checkCanlockBox(true) then
      return
    end
    L_GameUtil.showCommonTip({
      txtTitle = L_WordsTpl:getValue("notice_kibo_box_lock_confirm_title"),
      txtContent = L_WordsTpl:getValue("notice_kibo_box_lock_confirm"),
      confirmCallback = function()
        self:setPetBoxLockState(true)
      end
    })
    return
  end
  self.lockCDTime = L_TimeUtil:getServerTime() + 2
  self:setPetBoxLockState(isLock)
end

function this:setPetBoxLockState(isLock)
  local operation = isLock and 1 or 0
  L_PetStore:req_lockPetBox(self.data.curIndex, operation, function()
    self:refreshBoxLockState(self.data.curIndex)
    self:playPetBoxLockAudio(isLock)
  end)
end

function this:playPetBoxLockAudio(isLock)
  local audioEvent = isLock and "Play_SFX_System_UI_QiboHouse_Lock" or "Play_SFX_System_UI_QiboHouse_Unlock"
  L_AudioUtil.playSound(audioEvent)
end

function this:refreshLockPetBoxState()
  self.bind.activelockState = not self.islockPetBox
  self.bind.activeUnlockState = self.islockPetBox
end

function this:onEvent_refreshBoxLock()
  self:refreshBoxLockState(self.data.curIndex)
end

function this:onTopBarRefresh()
  C_IntegrateMgr.TopBarModule:SetTopBarCloseFunc(function()
    L_UI:close(self.pageName)
  end)
end

function this:preOpen(options)
  options = options or {}
  self.islockPetBox = false
  self.filter = L_PetConst.filterPetBox.grade
  self.realIndex = 0
  self.fingerId = nil
  self.bindComponents.scroll_box.enabled = true
  self.bindComponents.list_petBox.scrollSensitivity = 0
  self.bindComponents.rect_drag.gameObject:ActiveTrans(false)
  self.itemIsFirstTimeToHoverBox = true
  self.isInputKeyChangeBox = false
  self.isMousePressed = false
  self._isDragOverReleaseArea = false
  self._mutationBoxReddotMap = nil
  self._petBoxScrollTargetIndex = nil
  if not L_DeviceTpl:getIsPc() then
    self.bind.img_Enable = true
    self.bindComponents.viewportMask.padding = C_Vector4(-20, 0, 20, 0)
  end
  self:initSystem()
  self:setReleaseMode()
  self._filterKeyDic = nil
  self._filterResultLocked = false
  self.isInFilter = false
  self.isManualSwitch = false
  self.canReInitModule = false
  self._visitedMutationBoxes = self:_loadVisitedMutationBoxes()
  local petGuid = 0
  if not math.isEmpty(options.defaultPetGuid) then
    local petItem = L_PetStore:getPetItem(options.defaultPetGuid)
    if petItem then
      self._defaultBoxIndex = petItem.box_id // 100
      petGuid = options.defaultPetGuid
    end
  else
    self._defaultBoxIndex = options.defaultBoxIndex
    if self._defaultBoxIndex then
      petGuid = L_PetStore:getPetBoxFirstPet(self._defaultBoxIndex)
    else
      petGuid = L_PetStore:getPetBoxFirstPet(1)
    end
  end
  self._initJumpBoxIndex = self._defaultBoxIndex
  L_PetStore:setCurSelectPetId(petGuid)
  self:initModule()
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(true)
    self:bindPCKey()
    self:registerShortCut()
  end
  local defaultIndex = self._defaultBoxIndex or 1
  self:refreshBoxLockState(defaultIndex)
  L_PetStore:clearFlyMsg()
end

function this:open(options)
  this.super.open(self, options)
  self.isOpen = true
  self.isTop = true
  C_AudioManager.Play("Play_SFX_System_UI_QiboHouse_Interface_Open")
end

function this:show(options)
  self.bindComponents.list_petBox.gameObject:ActiveTrans(true)
  L_PetStore:listenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId, self)
  L_PetStore:listenCallFunc(L_PetStore.event.removePet, self.onEvent_removePet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setSelectReleasePet, self.onEvent_setSelectReleasePet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshBoxLock, self.onEvent_refreshBoxLock, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetBox, self.onEvent_refreshPetBox, self)
  L_PetStore:listenCallFunc(L_PetStore.event.clickBoxFilter, self.onEvent_clickBoxFilter, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setPetReleaseMode, self.onEvent_setPetReleaseMode, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetGeneMutation, self.onEvent_refreshPetGeneMutationForPage, self)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ENextBox, function()
    if self._isRenamingPetBox or self.isInFilter then
      return
    end
    if self:scrollPetBoxToIndex(self.realIndex + 1, true, true, function(index)
      self:onPetBoxListScrollToIndex(index)
    end) then
      self.isInputKeyChangeBox = true
    end
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ELastBox, function()
    if self._isRenamingPetBox or self.isInFilter then
      return
    end
    if self:scrollPetBoxToIndex(self.realIndex - 1, true, true, function(index)
      self:onPetBoxListScrollToIndex(index)
    end) then
      self.isInputKeyChangeBox = true
    end
  end)
  if self:CanRefresh() and self.canReInitModule then
    self:initModule()
  end
  self.bindComponents.list_petBox.gameObject:ActiveTrans(true)
  self:rebuildMutationBoxReddotMap()
  self.updateTimer = Timer.repeated(0.33, self.onScrollBox, self)
  self.canReInitModule = true
  self:configTouch("+")
  local jumpBoxIndex = self._initJumpBoxIndex or self._defaultBoxIndex
  if not math.isEmpty(jumpBoxIndex) then
    self.isManualSwitch = true
    self:setPointListActive(jumpBoxIndex)
    self.bindComponents.list_petBox:FocusItemIndex(jumpBoxIndex - 1)
    self.bindComponents.list_petBox:ScrollToCellImmediate(jumpBoxIndex - 1)
    self:onPetBoxListScrollToIndex(jumpBoxIndex - 1)
  else
    self.bindComponents.list_petBox:ScrollToCellImmediate(0)
    self:onPetBoxListScrollToIndex(0)
  end
  self._initJumpBoxIndex = nil
  L_PetManager:checkPetBoxCanMutationGuide()
  if self.isInFilter and self:CanRefresh() then
    self:refreshFilterPetCells()
  end
  if self.modules.modulePetBoxProperty then
    self.modules.modulePetBoxProperty:playPetCardShowAnim()
  end
end

function this:CanRefresh()
  if L_PetReleaseManager:getIsReleaseMode() then
    return false
  end
  local status = L_UI:getPageStatus("pagePetReleaseConfirm")
  if status and status ~= "closed" then
    return false
  end
  return true
end

function this:hide()
  self:endDrag()
  self.bind.go_listPetBoxEntrance = false
  self.bind.togglePetBoxEntrance = ""
  self:configTouch("-")
  if self.updateTimer then
    Timer.remove(self.updateTimer)
    self.updateTimer = nil
  end
  self:clearPetBoxScrollLock()
  self:killFilterJumpTimer()
  L_PetStore:unListenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId)
  L_PetStore:unListenCallFunc(L_PetStore.event.removePet, self.onEvent_removePet)
  L_PetStore:unListenCallFunc(L_PetStore.event.setSelectReleasePet, self.onEvent_setSelectReleasePet)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshBoxLock, self.onEvent_refreshBoxLock, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetBox, self.onEvent_refreshPetBox, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.clickBoxFilter, self.onEvent_clickBoxFilter, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.setPetReleaseMode, self.onEvent_setPetReleaseMode, self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetGeneMutation, self.onEvent_refreshPetGeneMutationForPage, self)
  L_ShortCutManager:removeShortCut(self.pageName)
end

function this:close(options)
  self:clearLastReddot()
  self:clearPetBoxScrollLock()
  self:killAutoDragTimer()
  self:killBoxHoverTimer()
  self:killInitBoxListTimer()
  self:killFilterJumpTimer()
  L_ShortCutManager:removeShortCut(self.pageName)
  L_PetReleaseManager:setIsReleaseMode(false)
  this.super.close(self, options)
  if L_DeviceTpl:getIsPc() then
    self:setShortcutGuidePCActive(false)
    self:unregisterShortCut()
    L_ShortCutManager:clearShortKeyFlag(self)
  end
  L_PetStore:call(L_PetStore.event.closePetBox)
  L_PetStore:setCurSelectPetId(0)
  self:releaseSystem()
  self._filterKeyDic = nil
  self._filterResultLocked = false
  self.isInFilter = false
  self._isRenamingPetBox = false
  if self.frameSchedulerId then
    FrameScheduler.remove(self.frameSchedulerId)
  end
  self.frameSchedulerId = nil
  self.isOpen = false
  self.isTop = false
end

function this:initModule()
  self:initDropDown()
  self:initBoxList()
  self:initPointList()
  self.petGuid = L_PetStore:getCurSelectPetId()
  self:refreshPetProperty(self.petGuid, true)
  if self.modules.modulePetBoxProperty then
    self.modules.modulePetBoxProperty:resetBoxInfo()
  end
  self:onCloseFilter()
  self:refreshFilterTitle()
end

function this:initDropDown()
  local tmp = {}
  for index, filterType in ipairs(self.filterTypeOrder) do
    local typeKey = self.filterType[filterType]
    local isActiveLine = index ~= #self.filterTypeOrder
    table.insert(tmp, {
      index = filterType,
      type = L_WordsTpl:getValue(typeKey),
      txt_name = L_WordsTpl:getValue(typeKey),
      go_icon = false,
      txt_name_h = L_WordsTpl:getValue(typeKey),
      go_line = isActiveLine
    })
  end
  local curTypeKey = self.filterType[self.filter]
  self.bind.txt_dropDown = curTypeKey and L_WordsTpl:getValue(curTypeKey) or ""
  self.bind.list_dropdown:clear()
  self.bind.list_dropdown:insert_array(tmp)
end

function this:getPagePetBoxDisplayName(index)
  if L_PetStore:hasPetBoxCustomName(index) then
    return L_PetStore:getPetBoxName(index)
  end
  return L_WordsTpl:getValue("notice_pagePetBox_07")
end

function this:initBoxList()
  local tmp = {}
  local petBoxList = L_PetStore:getPetBoxList()
  for i, v in ipairs(petBoxList) do
    table.insert(tmp, {
      index = i,
      petList = v,
      boxIndex = i,
      boxName = self:getPagePetBoxDisplayName(i),
      pageType = L_PetConst.PageType.House
    })
  end
  self.bind.loopListBox:clear()
  self.bind.loopListBox:insert_array(tmp)
end

function this:onScrollBox()
  if not self.isBind then
    return
  end
  local loopListViewRoot = self.bindComponents.list_petBox
  if loopListViewRoot == nil then
    return
  end
  local index = loopListViewRoot:GetSnapIndex()
  if index == nil then
    return
  end
  self.realIndex = index
  if self._petBoxScrollTargetIndex == index then
    self:clearPetBoxScrollLock()
  end
  local snapIndex = index + 1
  self._defaultBoxIndex = snapIndex
  local realBoxIndex = self:realSnapToItemIndex(snapIndex)
  self:setPointListActive(realBoxIndex)
end

function this:scrollPetBoxToIndex(targetIndex, playSound, manualSwitch, callback)
  local listPetBox = self.bindComponents and self.bindComponents.list_petBox
  if listPetBox == nil then
    return false
  end
  local currentIndex = listPetBox:GetSnapIndex() or self.realIndex or 0
  if targetIndex == currentIndex then
    return false
  end
  self._petBoxScrollTargetIndex = targetIndex
  if manualSwitch then
    self.isManualSwitch = true
  end
  listPetBox:ScrollToCell(targetIndex, PetBoxScrollSpeed, nil, callback)
  if playSound then
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Switch")
  end
  self:restartPetBoxScrollUnlockTimer()
  return true
end

function this:restartPetBoxScrollUnlockTimer()
  if self.petBoxScrollUnlockTimer then
    Timer.remove(self.petBoxScrollUnlockTimer)
  end
  self.petBoxScrollUnlockTimer = Timer.once(PetBoxScrollUnlockDelay, self.onPetBoxScrollUnlockTimer, self)
end

function this:onPetBoxScrollUnlockTimer()
  self.petBoxScrollUnlockTimer = nil
  self._petBoxScrollTargetIndex = nil
end

function this:clearPetBoxScrollLock()
  if self.petBoxScrollUnlockTimer then
    Timer.remove(self.petBoxScrollUnlockTimer)
    self.petBoxScrollUnlockTimer = nil
  end
  self._petBoxScrollTargetIndex = nil
end

function this:realSnapToItemIndex(snapIndex)
  local count = #self.bind.loopListBox
  if count <= 0 then
    return 1
  end
  local index = snapIndex
  if index == 0 then
    index = count
  else
    index = index % count
    index = index == 0 and count or index
  end
  return index
end

function this:onEvent_setCurPetId(guid)
  self.petGuid = guid
  self:refreshPetProperty(guid)
end

function this:onEvent_setSelectReleasePet(guid)
  if guid ~= nil then
    self.petGuid = guid
    self:refreshPetProperty(guid, nil, true)
  end
end

function this:refreshPetProperty(guid, noAnim, skipShowBtnRoot)
  if math.isEmpty(guid) then
    self.bind.show_petBoxProperty = false
    self:setBoxDetailBtnActive(false)
  else
    self.bind.show_petBoxProperty = true
    if not skipShowBtnRoot then
      self:setBoxDetailBtnActive(true)
    end
  end
  local modulePetBoxProperty = self.modules.modulePetBoxProperty
  if modulePetBoxProperty then
    modulePetBoxProperty:refreshPetProperty(guid, noAnim ~= true)
  end
end

function this:onEvent_removePet(guids)
  L_PetReleaseManager:setIsReleaseMode(false)
  if math.isEmpty(self.petGuid) then
    self:refreshPetProperty(self.petGuid)
  else
    for _, v in ipairs(guids) do
      if v == self.petGuid then
        self.petGuid = nil
        local countList = L_PetStore:getPetBoxList(self.data.curIndex)
        for _, id in pairs(countList) do
          if not math.isEmpty(id) then
            self.petGuid = L_PetStore:getPetBoxFirstPet(self.data.curIndex)
            break
          end
        end
        if math.isEmpty(self.petGuid) then
          self:refreshPetProperty(self.petGuid)
        else
          L_PetStore:setCurSelectPetId(self.petGuid)
        end
      end
    end
  end
  self:refreshCurBox()
  self:setReleaseMode()
  self:rebuildMutationBoxReddotMap()
  self:refreshGenePageReddot()
end

function this:onEvent_refreshPetBox(boxMap)
  if not self.isBind or table.isEmpty(boxMap) then
    return
  end
  for boxIndex, _ in pairs(boxMap) do
    if 0 < boxIndex and self.bind.loopListBox[boxIndex] then
      local boxName = self:getPagePetBoxDisplayName(boxIndex)
      self.bind.loopListBox:change(boxIndex, {boxName = boxName})
      if boxIndex == self.data.curIndex and not self.isInFilter then
        self.bind.curBoxName = boxName
        self:refreshBoxModule(boxIndex)
      end
    end
  end
  self:rebuildMutationBoxReddotMap()
  self:refreshGenePageReddot()
  if self.isInFilter then
    self:refreshFilter()
  end
end

function this:onEvent_clickBoxFilter()
  if self.bind.offset_boxfilter then
    self:onCloseFilter()
  else
    self:_onClickFilter()
  end
end

function this:onEvent_closeBoxFilter()
  self:onCloseFilter()
end

function this:onEvent_changePetBox(box)
  self:scrollPetBoxToIndex(box - 1, false, false, function(index)
    self:onPetBoxListScrollToIndex(index)
  end)
end

function this:onEvent_setPetReleaseMode()
  self:setReleaseMode()
end

function this:getVisibleBoxModule(boxIndex)
  boxIndex = boxIndex or self.data.curIndex
  for _, module in ipairs(self.modules.loopListBox or {}) do
    if module.bind and module.bind.boxIndex == boxIndex and module.isBind then
      return module
    end
  end
  return self.bind.loopListBox:getItemCls(boxIndex)
end

function this:refreshBoxModule(boxIndex, selectGuid)
  boxIndex = boxIndex or self.data.curIndex
  local boxModule = self:getVisibleBoxModule(boxIndex)
  if not boxModule or not boxModule.isBind then
    return
  end
  if not boxModule._isFilterListMode then
    boxModule.bind.petList = L_PetStore:getPetBoxList(boxIndex) or {}
  end
  if boxModule.refreshInfo then
    boxModule:refreshInfo()
  end
  if boxModule.refreshBoxList then
    boxModule:refreshBoxList(selectGuid or L_PetStore:getCurSelectPetId())
  end
end

function this:refreshCurBox(isPlaySortAudio)
  local boxModule = self:getVisibleBoxModule(self.data.curIndex)
  if boxModule and boxModule.refresh then
    boxModule:refresh()
  end
  if isPlaySortAudio then
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Sort")
  end
  if self.isInFilter then
    self:refreshFilterListView()
  end
end

function this:refreshAllBox(typeName)
  for i = 1, #self.bind.loopListBox do
    local boxModule = self.bind.loopListBox:getItemCls(i)
    if boxModule and boxModule.modules and boxModule.modules.list_pet then
      for j = 1, #boxModule.modules.list_pet do
        local petCell = boxModule.modules.list_pet[j]
        if petCell and petCell.refreshFilterType then
          petCell:refreshFilterType(self.filter)
        end
      end
    end
  end
  self.bind.txt_dropDown = typeName
end

function this:getFilterType()
  if math.isEmpty(self.filter) then
    self.filter = 1
  end
  return self.filter
end

function this:refreshFilterActive()
  for i = 1, #self.bind.list_dropdown do
    local index = self.bind.list_dropdown:getValue(i, "index")
    local itemCls = self.bind.list_dropdown:getItemCls(i)
    if itemCls and itemCls.setActive then
      itemCls:setActive(index == self.filter)
    end
  end
end

function this:initPointList()
  if self._defaultBoxIndex then
    self.isManualSwitch = true
    self:setPointListActive(self._defaultBoxIndex)
    self.bindComponents.list_petBox:FocusItemIndex(self._defaultBoxIndex - 1)
    self.bindComponents.list_petBox:ScrollToCellImmediate(self._defaultBoxIndex - 1)
    self:onPetBoxListScrollToIndex(self._defaultBoxIndex - 1)
  else
    self.bindComponents.list_petBox.gameObject:ActiveTrans(false)
  end
end

function this:setPointListActive(itemIndex, forceRefresh)
  itemIndex = itemIndex or 1
  if self.data.curIndex ~= itemIndex then
    if self.isManualSwitch then
      self.isManualSwitch = false
    else
      L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Switch")
    end
    if not self.isInFilter then
      self:clearFilter()
    end
    self:refreshBoxLockState(itemIndex)
  end
  self.data.curIndex = itemIndex
  if not self._visitedMutationBoxes[itemIndex] then
    self._visitedMutationBoxes[itemIndex] = true
    self:_saveVisitedMutationBox(itemIndex)
  end
  local modulePageTabSlider = self.modules.module_pageTabSlider
  if modulePageTabSlider then
    modulePageTabSlider:setPageIndex(self.data.curIndex, #self.bind.loopListBox)
  end
  local boxData = self.bind.loopListBox[self.data.curIndex]
  if not boxData then
    return
  end
  local boxIndexStr = self:indexChange(boxData.boxIndex)
  local boxName = boxData.boxName
  local modulePetRelease = self.modules.modulesPetRelease[self.bind.togglePetRelease]
  if modulePetRelease then
    modulePetRelease:setCurBox(self.data.curIndex, boxIndexStr, boxName)
    modulePetRelease:setTabSlider(self.data.curIndex, #self.bind.loopListBox)
  end
  self.bind.curBoxIndex = boxIndexStr
  if not self.isInFilter then
    self.bind.curBoxName = boxName
  end
  self:refreshFilterTitle()
  self:refreshGenePageReddot()
end

function this:refreshGenePageReddot()
  local reddotGeneNext = self.bindComponents.reddotGeneNext
  local reddotGeneLast = self.bindComponents.reddotGeneLast
  if not L_CommonUtil.isValid(reddotGeneNext) or not L_CommonUtil.isValid(reddotGeneLast) then
    return
  end
  reddotGeneNext.gameObject:SetActive(false)
  reddotGeneLast.gameObject:SetActive(false)
  local curIndex = self.data.curIndex
  local totalBox = #self.bind.loopListBox
  if totalBox <= 1 then
    return
  end
  local mutationBoxReddotMap = self._mutationBoxReddotMap or self:rebuildMutationBoxReddotMap()
  local halfTotal = math.ceil(totalBox / 2)
  local showNext = false
  local showLast = false
  for boxIndex = 1, totalBox do
    if boxIndex ~= curIndex and not self._visitedMutationBoxes[boxIndex] and mutationBoxReddotMap[boxIndex] then
      local rightDist = (boxIndex - curIndex + totalBox) % totalBox
      if halfTotal >= rightDist then
        showNext = true
      else
        showLast = true
      end
      if showNext and showLast then
        break
      end
    end
  end
  reddotGeneNext.gameObject:SetActive(showNext)
  reddotGeneLast.gameObject:SetActive(showLast)
end

function this:rebuildMutationBoxReddotMap()
  local mutationBoxReddotMap = self._mutationBoxReddotMap or {}
  for boxIndex in pairs(mutationBoxReddotMap) do
    mutationBoxReddotMap[boxIndex] = nil
  end
  local totalBox = L_PetStore:getPetBoxNum() or #self.bind.loopListBox
  local reddotManager = L_ReddotManager
  local petStore = L_PetStore
  local formationType = L_FormationManager:getCurFormationType()
  for boxIndex = 1, totalBox do
    local boxPetList = petStore:getPetBoxList(boxIndex)
    if boxPetList then
      for _, guid in ipairs(boxPetList) do
        local isInFormation = not math.isEmpty(guid) and L_FormationStore:getPetPlaceInTeam(formationType, nil, guid) > 0
        if isInFormation and reddotManager:haveNew(reddotManager.DotDef.PetGeneMutation, guid) then
          mutationBoxReddotMap[boxIndex] = true
          break
        end
      end
    end
  end
  self._mutationBoxReddotMap = mutationBoxReddotMap
  return mutationBoxReddotMap
end

function this:onEvent_refreshPetGeneMutationForPage()
  self:rebuildMutationBoxReddotMap()
  self:refreshGenePageReddot()
end

function this:_getVisitedMutationBoxKey(boxIndex)
  return string.format("%s_petGeneBoxVisited_%s", L_PlayerStore:getPlayerId(), boxIndex)
end

function this:_loadVisitedMutationBoxes()
  local visited = {}
  local totalBox = L_PetStore:getPetBoxNum() or 0
  for i = 1, totalBox do
    local key = self:_getVisitedMutationBoxKey(i)
    if C_PlayerPrefsUtility.GetInt(key, 0) == 1 then
      visited[i] = true
    end
  end
  return visited
end

function this:_saveVisitedMutationBox(boxIndex)
  local key = self:_getVisitedMutationBoxKey(boxIndex)
  C_PlayerPrefsUtility.SetInt(key, 1)
end

function this:refreshBoxLockState(boxId)
  self.islockPetBox = L_PetStore:getBoxIsLock(boxId)
  self:refreshLockPetBoxState()
end

function this:indexChange(index)
  if index < 10 then
    return string.format("0%d", index)
  end
  return tostring(index)
end

function this:check(options, callback)
  if (not options or not options.ignoreProxyType) and AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.pet)
  if not result then
    callback(false)
    return
  end
  local isInFirstTask = true
  local unlockMoreCondition = L_GameConstTpl:getValue("CONDITION_FIRST_TASKID", true)
  if unlockMoreCondition and type(unlockMoreCondition) == "table" then
    isInFirstTask = L_ConditionManager:isComplete(unlockMoreCondition)
  end
  if not isInFirstTask and L_FormationStore:getIsTrailFormation(L_FormationManager:getCurFormationType()) then
    L_FlyMsgManager:showNormalMsgByKey("notice_pagePetBox_06")
    callback(false)
    return
  end
  callback(true)
end

function this:configTouch(operator)
  self.onUITouchHandle = self.onUITouchHandle or L_CommonUtil.handle(self.onUI_touchHandle, self)
  self.onUIDragHandle = self.onUIDragHandle or L_CommonUtil.handle(self.onUI_dragHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_dragEndHandle, self)
  self.onUIClickHandle = self.onUIClickHandle or L_CommonUtil.handle(self.onUI_clickHandle, self)
  C_ScreenTouch.OnUI_LongTapStart(operator, self.onUITouchHandle)
  C_ScreenTouch.OnUI_LongTapEnd(operator, self.onUIClickHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onUIDragHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
end

function this:getHoldInfo(go)
  if go == nil then
    return nil, nil
  end
  if self.isInFilter then
    local module = self.modules.petbox_Filter
    if module and module.modules and module.modules.list_pet then
      for n, item in ipairs(module.modules.list_pet) do
        if item and item.getRaycastGo and item:checkRaycastEqualsGo(go) then
          local filteredPet = self._filteredPetList[n]
          if filteredPet then
            return item.bind.guid, filteredPet.boxIndex * 100 + filteredPet.slot
          end
        end
      end
    end
    for _, moduleBox in ipairs(self.modules.loopListBox) do
      if moduleBox.bind.boxIndex == self.data.curIndex and moduleBox.modules and moduleBox.modules.list_pet then
        for n, item in ipairs(moduleBox.modules.list_pet) do
          if item and item.getRaycastGo and item:checkRaycastEqualsGo(go) then
            local filteredPet = self._filteredPetList[n]
            if filteredPet then
              return item.bind.guid, filteredPet.boxIndex * 100 + filteredPet.slot
            end
          end
        end
      end
    end
    return nil, nil
  end
  for _, module in ipairs(self.modules.loopListBox) do
    if module.bind.boxIndex == self.data.curIndex and module.modules and module.modules.list_pet then
      for n, item in ipairs(module.modules.list_pet) do
        if item and item.getRaycastGo and item:checkRaycastEqualsGo(go) then
          return item.bind.guid, self.data.curIndex * 100 + n
        end
      end
    end
  end
  return nil, nil
end

function this:setSelectAlpha(boxId, alpha)
  if math.isEmpty(boxId) then
    return
  end
  local index = boxId // 100
  local slot = boxId % 100
  for _, module in ipairs(self.modules.loopListBox) do
    if module.bind.boxIndex == index then
      local listPet = module.bind.list_pet
      if listPet then
        local itemCls = listPet.getItemCls and listPet:getItemCls(slot) or nil
        if itemCls and itemCls.isBind then
          itemCls:setIconAlpha(alpha)
          listPet:change(slot, {
            isLongTap = alpha < 1 and true or false
          })
        end
      end
      break
    end
  end
end

function this:onUI_clickHandle(gesture)
  self.isMousePressed = false
  self:inputKeyChangeBox(gesture)
  self:endDrag()
end

function this:onUI_touchHandle(gesture)
  if self.bindComponents.rect_drag.gameObject.activeSelf == true then
    return
  end
  if L_PetReleaseManager:getIsReleaseMode() or L_UI:checkPageOpen("pagePetReleaseConfirm") then
    return
  end
  local go = gesture.go
  self.fingerId = gesture.fingerId
  local holdGuid, holdBoxId = self:getHoldInfo(go)
  if math.isEmpty(holdGuid) then
    return
  end
  if not self.isBind then
    return
  end
  local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_AudioUtil.playSound("Play_SFX_System_UI_General_Click_Hold")
  L_FlyMsgManager:startLongPress(gesture, 0.5, function()
    if not self.isMousePressed then
      return
    end
    self._holdGuid, self._holdBoxId = holdGuid, holdBoxId
    L_Vector3.setAnchored(self.bindComponents.rect_drag, touchPos)
    self:showDragImg(true, holdGuid, holdBoxId)
    self:showQuickPetBox(true)
    self.bind.go_listPetBoxEntrance = true
    self.bind.togglePetBoxEntrance = "modulePetBoxEntrance"
    local quickBox = self.modules.modulesPetBoxEntrance.modulePetBoxEntrance
    if quickBox and quickBox.fadeIn then
      quickBox:fadeIn()
    end
  end)
  self.isMousePressed = true
end

function this:onUI_dragHandle(gesture)
  if L_PetReleaseManager:getIsReleaseMode() or L_UI:checkPageOpen("pagePetReleaseConfirm") then
    return
  end
  if self.bindComponents.rect_drag.gameObject.activeSelf == true then
  end
  if gesture.fingerId ~= self.fingerId then
    self.bindComponents.scroll_box.enabled = true
    return
  end
  local touchPos = L_Vector3.screenToLocalInRectangle(self.bindComponents.rect_content, gesture.position)
  L_Vector3.setAnchored(self.bindComponents.rect_drag, touchPos)
  if self.bind.go_listPetBoxEntrance then
    self:checkDragOverBox(gesture)
  end
  self:checkDragOverReleaseArea(gesture)
end

function this:onUi_dragEnd(gesture)
  self.itemIsFirstTimeToHoverBox = true
  if L_UI:checkPageOpen("pagePetReleaseConfirm") then
    return
  end
  if gesture.fingerId ~= self.fingerId then
    return
  end
  if self._isDragOverReleaseArea or self:isGestureOverReleaseArea(gesture) then
    self:handleDragToRelease(self._holdGuid)
    return
  end
  if self._selectedBoxIndex then
    self:handleDragToBox(self._holdGuid, self._selectedBoxIndex)
    return
  end
  local go = gesture:GetCurrentFirstPickedUIElement()
  if not math.isEmpty(self._holdGuid) then
    local holdGuid, holdBoxId = self:getHoldInfo(go)
    if holdGuid == self._holdGuid or holdBoxId == self._holdBoxId then
      self:endDrag()
      return
    end
    if math.isEmpty(holdBoxId) then
      self:endDrag()
      return
    end
    self:handleDragEffect(self._holdGuid, self._holdBoxId, holdGuid, holdBoxId)
  else
    self:endDrag()
  end
  self.isInputKeyChangeBox = false
end

function this:onUI_dragEndHandle(gesture)
  self:onUi_dragEnd(gesture)
  self.isMousePressed = false
end

function this:inputKeyChangeBox(gesture)
  if self.isInputKeyChangeBox and not self.isMousePressed then
    self:onUi_dragEnd(gesture)
    self.isInputKeyChangeBox = false
  end
end

function this:showDragImg(isShow, holdGuid, holdBoxId)
  if L_PetReleaseManager:getIsReleaseMode() then
    return
  end
  if isShow then
    self:setSelectAlpha(holdBoxId, 0.5)
    local pet = L_PetStore:getPetItem(holdGuid)
    if not pet then
      return
    end
    local tpl = _petTpl:getTplById(pet.id)
    self.bind.img_drag = _petTpl:getPetPixelIcon(tpl, pet:isSpecialPet())
    self.bindComponents.scroll_box.enabled = false
    self:setFilterListScrollEnabled(false)
    self.bindComponents.rect_drag.gameObject:ActiveTrans(true)
    self.bind.activeNextHitArea = false
    self.bind.activelastHitArea = false
    self.bind.edgeLeft_enable = true
    self.bind.edgeRight_enable = true
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_PickUp")
    for _, module in ipairs(self.modules.loopListBox) do
      if module.setIsDragging then
        module:setIsDragging(true)
      end
    end
  else
    self:endDrag()
  end
end

function this:onDragExchangeComplete(fromGuid)
  self:endDrag()
  L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Drop")
  local fromPet = L_PetStore:getPetItem(fromGuid)
  local boxIndex = self.data.curIndex
  if fromPet and not math.isEmpty(fromPet.box_id) then
    boxIndex = fromPet.box_id // 100
  end
  if self.isInFilter then
    self:refreshFilter()
  end
  L_PetStore:setCurSelectPetId(fromGuid)
  self:refreshBoxModule(boxIndex, fromGuid)
end

function this:handleDragEffect(fromGuid, fromBoxId, toGuid, toBoxId)
  if math.isEmpty(toBoxId) then
    self:endDrag()
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Drop")
    return
  end
  if self.isInFilter then
    self:handleFilterListSwap(fromGuid, toGuid, toBoxId)
    return
  end
  if math.isEmpty(toGuid) then
    L_PetStore:req_CSSetPetBox(fromGuid, toBoxId, function()
      self:onDragExchangeComplete(fromGuid)
    end)
  else
    L_PetStore:req_CSExchangePetBoxId(fromGuid, toGuid, function()
      self:onDragExchangeComplete(fromGuid)
    end)
  end
end

function this:handleFilterListSwap(fromGuid, toGuid, toBoxId)
  if not self._filteredPetList then
    self:endDrag()
    return
  end
  local fromIndex, toIndex
  for i, petData in ipairs(self._filteredPetList) do
    if petData.guid == fromGuid then
      fromIndex = i
    end
    if petData.guid == toGuid then
      toIndex = i
    end
  end
  if fromIndex and toIndex then
    self._filteredPetList[fromIndex], self._filteredPetList[toIndex] = self._filteredPetList[toIndex], self._filteredPetList[fromIndex]
    self:refreshFilterListView()
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Drop")
  end
  self:endDrag()
end

function this:isDraggingPet()
  if not math.isEmpty(self._holdGuid) then
    return true
  end
  local rectDrag = self.bindComponents and self.bindComponents.rect_drag
  if rectDrag and L_CommonUtil.isValid(rectDrag) and rectDrag.gameObject.activeSelf then
    return true
  end
  return false
end

function this:endDrag()
  self:setFilterListScrollEnabled(true)
  if L_PetReleaseManager:getIsReleaseMode() or L_UI:checkPageOpen("pagePetReleaseConfirm") then
    return
  end
  if not math.isEmpty(self._holdBoxId) then
    self:setSelectAlpha(self._holdBoxId, 1)
  end
  if not math.isEmpty(self._holdGuid) then
    local modulePetBoxEntrance = self.modules.modulesPetBoxEntrance.modulePetBoxEntrance
    if modulePetBoxEntrance then
      if modulePetBoxEntrance.clearSelection then
        modulePetBoxEntrance:clearSelection()
      end
      if modulePetBoxEntrance.fadeOut then
        modulePetBoxEntrance:fadeOut()
      end
    end
  end
  self._holdGuid, self._holdBoxId, self.fingerId = nil, nil, nil
  self.bindComponents.rect_drag.gameObject:ActiveTrans(false)
  self.bindComponents.scroll_box.enabled = true
  self.bind.activeNextHitArea = true
  self.bind.activelastHitArea = true
  self.bind.edgeLeft_enable = false
  self.bind.edgeRight_enable = false
  self.isInputKeyChangeBox = false
  self.isMousePressed = false
  for _, module in ipairs(self.modules.loopListBox) do
    if module.setIsDragging then
      module:setIsDragging(false)
    end
  end
  self:killAutoDragTimer()
  self:showQuickPetBox(false)
  self._selectedBoxIndex = nil
  self:killBoxHoverTimer()
  self:newOrResetTimer("playModulePetBoxQuick_out", function()
    if self._holdGuid == nil then
      self.bind.go_listPetBoxEntrance = false
      self.bind.togglePetBoxEntrance = ""
    end
    self.itemIsFirstTimeToHoverBox = true
  end)
  self._isDragOverReleaseArea = false
  if self.isInFilter then
    self:refreshFilterListView()
  end
end

function this:setFilterListScrollEnabled(isEnabled)
  if not self.isInFilter then
    return
  end
  local module = self.modules and self.modules.petbox_Filter
  if not (module and module.isBind and module.bindComponents) or not module.bindComponents.scrollView then
    return
  end
  module.bindComponents.scrollView.enabled = isEnabled == true
end

function this:showQuickPetBox(isShow)
  self.bind.boxInfoActive = not isShow
  self.bind.downBgActive = not isShow
  self:setBoxDetailBtnActive(not isShow)
  local modulePetBoxEntrance = self.modules.modulesPetBoxEntrance.modulePetBoxEntrance
  if modulePetBoxEntrance and modulePetBoxEntrance.setFilterMode then
    modulePetBoxEntrance:setFilterMode(self.isInFilter)
  end
  self:setLockStateAnim(not isShow)
end

function this:createAutoDragTimer(index)
  self:killAutoDragTimer()
  local value = index == 1 and 1 or -1
  self.autoDragTimer = Timer.repeated(1.1, function()
    if not self.isInFilter then
      self:clearFilter()
    end
    self:scrollPetBoxToIndex(self.realIndex + value, true, true, function(idx)
      self:onPetBoxListScrollToIndex(idx)
    end)
  end, self)
end

function this:killAutoDragTimer()
  if self.autoDragTimer then
    Timer.remove(self.autoDragTimer)
    self.autoDragTimer = nil
  end
end

function this:checkDragOverBox(gesture)
  local go = gesture:GetCurrentFirstPickedUIElement()
  if not go then
    self:clearBoxSelection()
    return
  end
  local holdGuid, holdBoxId = self:getHoldInfo(go)
  if not math.isEmpty(holdBoxId) then
    self:clearBoxSelection()
    return
  end
  local modulePetBoxEntrance = self.modules.modulesPetBoxEntrance.modulePetBoxEntrance
  if modulePetBoxEntrance and modulePetBoxEntrance.getHover then
    local i = modulePetBoxEntrance:getHover(go)
    if i then
      if self._selectedBoxIndex ~= i then
        self:clearBoxSelection()
        self._selectedBoxIndex = i
        self:createBoxHoverTimer(i)
      end
    else
      self:clearBoxSelection()
    end
  end
end

function this:clearBoxSelection()
  if self._selectedBoxIndex then
    local modulePetBoxEntrance = self.modules.modulesPetBoxEntrance.modulePetBoxEntrance
    if modulePetBoxEntrance and modulePetBoxEntrance.clearSelection then
      modulePetBoxEntrance:clearSelection()
    end
    self._selectedBoxIndex = nil
    self:killBoxHoverTimer()
  end
end

function this:setDragOverReleaseArea(isOver)
  self._isDragOverReleaseArea = isOver == true
  if self._isDragOverReleaseArea then
    self:clearBoxSelection()
  end
end

function this:checkDragOverReleaseArea(gesture)
  if self:isGestureOverReleaseArea(gesture) then
    self:setDragOverReleaseArea(true)
  end
end

function this:isGestureOverReleaseArea(gesture)
  if not gesture then
    return false
  end
  local go = gesture:GetCurrentFirstPickedUIElement()
  if not go then
    return false
  end
  local currentGo = go
  while currentGo do
    if currentGo.name == "filterReleaseArea" or currentGo.name == "releaseArea" then
      return true
    end
    currentGo = currentGo.transform.parent and currentGo.transform.parent.gameObject or nil
  end
  return false
end

function this:handleDragToRelease(petGuid)
  if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petRelease) then
    self:endDrag()
    return
  end
  if math.isEmpty(petGuid) then
    self:endDrag()
    return
  end
  local pet = L_PetStore:getPetItem(petGuid)
  if not pet then
    self:endDrag()
    return
  end
  L_PetReleaseManager:dealSelectPet(petGuid)
  L_UI:open("pagePetReleaseConfirm", {
    pets = {petGuid},
    quickRelease = true
  })
  self:endDrag()
  self._isDragOverReleaseArea = false
end

function this:createBoxHoverTimer(boxIndex)
  self:killBoxHoverTimer()
  self.boxHoverTimer = Timer.once(2, function()
    if boxIndex == nil then
      return
    end
    local targetBoxIndex = boxIndex - 1
    if boxIndex == self.data.curIndex then
      return
    end
    self.itemIsFirstTimeToHoverBox = false
    self.isManualSwitch = true
    self:setPointListActive(boxIndex)
    self.realIndex = targetBoxIndex
    self._defaultBoxIndex = boxIndex
    local listPetBox = self.bindComponents and self.bindComponents.list_petBox
    if listPetBox then
      listPetBox:FocusItemIndex(targetBoxIndex)
      listPetBox:ScrollToCellImmediate(targetBoxIndex)
    end
    self.bindComponents.list_petBox:ScrollToCell(targetBoxIndex, 3000, nil, function(index)
      self:onPetBoxListScrollToIndex(index)
    end)
    if not self.isInFilter then
      self:clearFilter()
    end
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Switch")
    self:clearBoxSelection()
  end, self)
end

function this:killBoxHoverTimer()
  if self.boxHoverTimer then
    Timer.remove(self.boxHoverTimer)
    self.boxHoverTimer = nil
  end
end

function this:killInitBoxListTimer()
  if self.initBoxListTimer then
    Timer.remove(self.initBoxListTimer)
    self.initBoxListTimer = nil
  end
end

function this:killFilterJumpTimer()
  if self.filterJumpTimer then
    Timer.remove(self.filterJumpTimer)
    self.filterJumpTimer = nil
  end
end

function this:getFilterSelectedPetBoxIndex()
  local curPetGuid = L_PetStore:getCurSelectPetId()
  if math.isEmpty(curPetGuid) then
    return
  end
  for _, petData in ipairs(self._filteredPetList or {}) do
    if petData.guid == curPetGuid then
      return petData.boxIndex
    end
  end
  local petItem = L_PetStore:getPetItem(curPetGuid)
  if petItem then
    return petItem.box_id // 100
  end
end

function this:jumpToPetBoxIndex(boxIndex, needDelay)
  if math.isEmpty(boxIndex) or boxIndex <= 0 then
    return
  end
  
  local function scrollToTarget()
    if not (self.isBind and self.bindComponents) or not self.bindComponents.list_petBox then
      return
    end
    self.bindComponents.list_petBox:ScrollToCellImmediate(boxIndex - 1)
    self:onPetBoxListScrollToIndex(boxIndex - 1)
  end
  
  scrollToTarget()
  if needDelay then
    self:killFilterJumpTimer()
    self.filterJumpTimer = Timer.once(0.05, function()
      self.filterJumpTimer = nil
      scrollToTarget()
    end, self)
  end
end

function this:handleDragToBox(petGuid, boxIndex)
  if math.isEmpty(petGuid) or math.isEmpty(boxIndex) then
    self:endDrag()
    return
  end
  local isFull, emptySlot = L_PetStore:getPetBoxIsFull(boxIndex)
  if isFull then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("kibo_box_already_full"))
    self:endDrag()
    return
  end
  local newBoxId = boxIndex * 100 + emptySlot
  L_PetStore:req_CSSetPetBox(petGuid, newBoxId, function()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("kibo_box_move_success"))
    self:endDrag()
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Drop")
    if self.isInFilter then
      self:refreshFilter()
    else
      self:refreshCurBox()
    end
  end)
end

function this:showBoxExchangeDialog(petGuid, targetBoxIndex)
  local dragPet = L_PetStore:getPetItem(petGuid)
  if not dragPet then
    return
  end
  local targetBoxName = self:getPagePetBoxDisplayName(targetBoxIndex)
  local targetBoxPets = L_PetStore:getPetBoxList(targetBoxIndex)
  local exchangeList = {}
  for slot, guid in ipairs(targetBoxPets) do
    if not math.isEmpty(guid) then
      local pet = L_PetStore:getPetItem(guid)
      if pet then
        table.insert(exchangeList, {
          guid = guid,
          name = pet.getPetName and pet:getPetName() or pet.pet_name or pet.name or "",
          slot = slot,
          boxIndex = targetBoxIndex,
          configId = pet.id,
          isSelected = #exchangeList == 0
        })
      end
    end
  end
  if #exchangeList == 0 then
    self:endDrag()
    return
  end
  self._exchangeTargetGuid = exchangeList[1].guid
  L_UI:open("pagePetChangeBoxTip", {
    dragPetGuid = petGuid,
    targetBoxIndex = targetBoxIndex,
    targetBoxName = targetBoxName,
    exchangeList = exchangeList,
    defaultSelectGuid = self._exchangeTargetGuid,
    confirmCallback = function(targetGuid)
      if not math.isEmpty(targetGuid) then
        L_PetStore:req_CSExchangePetBoxId(petGuid, targetGuid, function()
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("kibo_box_move_success"))
          L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Drop")
          self:refreshCurBox()
          if self.isInFilter then
            self:refreshFilter()
          end
        end)
      end
      self._exchangeTargetGuid = nil
    end,
    cancelCallback = function()
      self._exchangeTargetGuid = nil
    end
  })
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.petRelease] = {
      self.bindComponents.btnPetFreeTrans
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
      v.locker:setCallback(self.refreshSystem, self, self.gameObject)
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
  for _, v in ipairs(node) do
    locker:tryShowOrHide(v, isUnlock)
  end
end

function this:releaseSystem()
  for _, v in pairs(self.systemToTrans) do
    if v.locker then
      C_IntegrateMgr.SystemUnlockModule:RemoveLocker(v.locker)
    end
    v.locker = nil
  end
  self.systemToTrans = nil
end

function this:setReleaseMode()
  local isFreeMode = L_PetReleaseManager:getIsReleaseMode()
  self.bind.btnPetFreeActive = not isFreeMode
  self.bind.boxInfoActive = not isFreeMode
  self.bind.downBgActive = not isFreeMode
  self.bind.modulePetReleaseActive = isFreeMode
  self:setBoxDetailBtnActive(true)
  local modulePetRelease = self.modules.modulesPetRelease[self.bind.togglePetRelease]
  if isFreeMode then
    self.bind.togglePetRelease = "modulePetRelease"
    if modulePetRelease then
      modulePetRelease:SetActive(true)
      modulePetRelease:setOnFilterDisplay()
    end
  elseif self.bind.togglePetRelease == "modulePetRelease" and modulePetRelease then
    modulePetRelease:SetActive(false)
  end
  self:setLockStateAnim(not isFreeMode)
  if self.bindComponents.activeCellShortcutGuideD then
    local resGuideActive = not isFreeMode and L_DeviceTpl:getIsPc()
    self.bindComponents.activeCellShortcutGuideD.gameObject:SetActive(resGuideActive)
  end
  if self.isInFilter then
    self:refreshFilterSelectedPet(true)
  end
  if isFreeMode then
    self:setGamepadFocusRegion(GamepadFocusRegions.PetListReleaseMode)
  else
    self:setGamepadFocusRegion(GamepadFocusRegions.PetList)
  end
end

function this:setBoxDetailBtnActive(active)
  if self.modules.modulePetBoxProperty then
    self.modules.modulePetBoxProperty:setDetailBtnActive(active)
  end
end

function this:escHandle()
  if self._isRenamingPetBox then
    return
  end
  if self:isDraggingPet() then
    self:endDrag()
    return
  end
  if self.isInFilter then
    self:clearFilter()
    return
  end
  self:closePageFunc()
end

function this:closePageFunc()
  if L_PetReleaseManager:getIsReleaseMode() then
    if self:getGamepadFocusRegion() == GamepadFocusRegions.PetReleaseFilterPanel then
      self:onGamepadFocusRegionBack()
      return
    end
    L_PetReleaseManager:setIsReleaseMode(false, false, L_PetReleaseManager:getSelectedIdWhenExit(self.data.curIndex))
    self:setGamepadFocusRegion(GamepadFocusRegions.PetList)
  else
    if C_InputManager.IsEnableGamePad and self:onGamepadFocusRegionBack() then
      return
    end
    L_UI:close(self.pageName)
  end
end

function this:getPetBoxFilterGroups()
  local tplSys = _systemUnlockTpl:getTplById(L_SystemConst.enum.pet)
  local sortFilterId = _systemUnlockTpl:getFilterConfig(tplSys)
  local tplSortFilter = _systemFilterTpl:getTplById(sortFilterId)
  local filterConfig = _systemFilterTpl:getFilterConfig(tplSortFilter)
  local groups = {}
  local scopeFilterType
  for _, typeAndLimit in ipairs(filterConfig or {}) do
    local typeId, limit = table.unpack(typeAndLimit)
    if typeId == L_SortFilterConst.FilterType.QiBoBoxMode then
      scopeFilterType = typeId
      break
    elseif typeId == L_SortFilterConst.FilterType.Gene and not scopeFilterType then
      scopeFilterType = typeId
    end
  end
  for _, typeAndLimit in ipairs(filterConfig or {}) do
    local typeId, limit = table.unpack(typeAndLimit)
    local group = {type = typeId, selectLimit = limit}
    if typeId == scopeFilterType then
      local defaultScopeValue = self:getPetBoxCurrentScopeDefaultValue(typeId)
      group.selectLimit = 1
      group.keepOneSelected = true
      group.defaultList = defaultScopeValue and {defaultScopeValue} or nil
    end
    table.insert(groups, group)
  end
  return groups
end

function this:isPetBoxScopeFilterType(typeId)
  return typeId == L_SortFilterConst.FilterType.QiBoBoxMode or typeId == L_SortFilterConst.FilterType.Gene
end

function this:getPetBoxScopeFilterType()
  local fallbackType
  for _, group in ipairs(self:getPetBoxFilterGroups()) do
    if group.type == L_SortFilterConst.FilterType.QiBoBoxMode then
      return group.type
    elseif group.type == L_SortFilterConst.FilterType.Gene then
      fallbackType = group.type
    end
  end
  return fallbackType
end

function this:getPetBoxFilterTypeByTable(filterTable)
  for _, group in ipairs(self:getPetBoxFilterGroups()) do
    local tplFilterType = _systemFiltertypeTpl:getTplById(group.type)
    if tplFilterType and _systemFiltertypeTpl:getFilterTable(tplFilterType) == filterTable then
      return group.type
    end
  end
end

function this:hasPetBoxFilterSelected(filterKeyDic)
  if table.isEmpty(filterKeyDic) then
    return false
  end
  for _, idList in pairs(filterKeyDic) do
    if not table.isEmpty(idList) then
      return true
    end
  end
  return false
end

function this:checkPetBoxFilterConfirm(filterKeyDic)
  if not self:hasPetBoxFilterSelected(filterKeyDic) then
    return true
  end
  local scopeFilterType = self:getPetBoxScopeFilterType()
  if not scopeFilterType then
    return false
  end
  local scopeList = filterKeyDic and filterKeyDic[scopeFilterType]
  if table.isEmpty(scopeList) then
    return false
  end
  return true
end

function this:onCloseFilter()
  self.bind.offset_boxfilter = false
  self.bind.module_pet = true
  if self.bindComponents and self.bindComponents.anim then
    self.bindComponents.anim:Stop()
    self.bindComponents.anim:Play("anim_petbox_switch_Fast")
  end
  self.bindComponents.ani_btn_filter:SetBool("On", false)
  local modulePetRelease = self.modules.modulesPetRelease[self.bind.togglePetRelease]
  if modulePetRelease then
    modulePetRelease:setOnFilterDisplay()
  end
end

function this:_onClickFilter()
  self.bind.module_pet = false
  self.bind.offset_boxfilter = true
  self.bindComponents.ani_btn_filter:SetBool("On", true)
  
  local function callback(filterKeyDic)
    if not self:hasRealFilterCondition(filterKeyDic) then
      self:onCloseFilter()
      self._filterKeyDic = nil
      self._filterResultLocked = false
      self:clearFilter()
      return
    end
    self._filterKeyDic = filterKeyDic
    self._filterResultLocked = false
    self:_filterCallback()
  end
  
  local function onCancel()
    self:onCloseFilter()
    self:clearFilter()
  end
  
  local function onClose()
    self:onCloseFilter()
    self:clearFilter()
  end
  
  local function onConfirmClose()
    self:onCloseFilter()
  end
  
  self.modules.module_pageFilter:initFilterModule({
    systemId = L_SystemConst.enum.pet,
    selectValue = self._filterKeyDic,
    customFilterGroups = self:getPetBoxFilterGroups(),
    confirmCheck = function(filterKeyDic)
      return self:checkPetBoxFilterConfirm(filterKeyDic)
    end,
    callback = callback,
    onCancel = onCancel,
    onClose = onClose,
    onConfirmClose = onConfirmClose
  })
  local modulePetRelease = self.modules.modulesPetRelease[self.bind.togglePetRelease]
  if modulePetRelease then
    modulePetRelease:setOnFilterDisplay()
  end
end

function this:_filterCallback()
  self.isInFilter = true
  self:refreshFilterTitle()
  self:refreshFilter(true)
end

function this:clearFilter()
  if not self.isInFilter then
    return
  end
  local targetBoxIndex = self:getFilterSelectedPetBoxIndex()
  self._filterKeyDic = nil
  self._filterResultLocked = false
  self.isInFilter = false
  self._filteredPetList = {}
  self._filteredPetMap = {}
  local needJump = targetBoxIndex and 0 < targetBoxIndex and targetBoxIndex ~= self.data.curIndex
  if needJump then
    self:setPointListActive(targetBoxIndex)
  end
  self:refreshCurBox()
  self:refreshFilterTitle()
  if needJump then
    self:jumpToPetBoxIndex(targetBoxIndex, true)
  end
end

function this:getFilterScope(filterKeyDic)
  local scopeFilterType = self:getPetBoxScopeFilterType()
  local scopeList = scopeFilterType and filterKeyDic and filterKeyDic[scopeFilterType]
  local scopeValue = scopeList and scopeList[1]
  if scopeValue == nil then
    return
  end
  local scopeIndex = self:getFilterOptionIndexByValue(scopeFilterType, scopeValue)
  local scopeEnum = self:getFilterOptionEnumByValue(scopeFilterType, scopeValue) or scopeValue
  if scopeEnum == FilterScope.AllBox or math.isEmpty(scopeEnum) and scopeIndex == FilterScope.AllBox then
    return FilterScope.AllBox
  end
  return FilterScope.CurrentBox
end

function this:getFilterOptionList(typeId)
  local tplFilterType = _systemFiltertypeTpl:getTplById(typeId)
  if not tplFilterType then
    return {}
  end
  local filterContent = _systemFiltertypeTpl:getFilterContent(tplFilterType)
  local filterTable = _systemFiltertypeTpl:getFilterTable(tplFilterType)
  local filterKey = _systemFiltertypeTpl:getFilterKey(tplFilterType)
  local optionList = {}
  if not table.isEmpty(filterContent) then
    for _, contentId in ipairs(filterContent) do
      table.insert(optionList, L_Config:getConfigDirectly(filterTable, contentId))
    end
  else
    optionList = L_Config:getConfigDirectly(filterTable) or {}
  end
  return optionList, filterKey
end

function this:getFilterOptionIndexByValue(typeId, value)
  local optionList, filterKey = self:getFilterOptionList(typeId)
  for index, config in ipairs(optionList) do
    if config and config[filterKey] == value then
      return index
    end
  end
end

function this:getFilterOptionEnumByValue(typeId, value)
  local optionList, filterKey = self:getFilterOptionList(typeId)
  for _, config in ipairs(optionList) do
    if config and config[filterKey] == value then
      return config.EnumId
    end
  end
end

function this:getPetBoxCurrentScopeDefaultValue(typeId)
  local optionList, filterKey = self:getFilterOptionList(typeId)
  if table.isEmpty(optionList) or string.isEmpty(filterKey) then
    return
  end
  for _, config in ipairs(optionList) do
    if config and config.EnumId == FilterScope.CurrentBox then
      return config[filterKey]
    end
  end
  local config = optionList[FilterScope.CurrentBox]
  return config and config[filterKey]
end

function this:collectPetListByFilterScope(scope)
  local petList = {}
  local petBoxList = L_PetStore:getPetBoxList() or {}
  
  local function collectBox(boxIndex, boxPets)
    if not boxPets then
      return
    end
    for slot, petGuid in ipairs(boxPets) do
      if not math.isEmpty(petGuid) then
        local pet = L_PetStore:getPetItem(petGuid)
        if pet then
          local petName = pet.getPetName and pet:getPetName() or pet.pet_name or ""
          table.insert(petList, {
            itemType = L_Const.resType.pet,
            itemId = pet.id,
            guid = petGuid,
            _boxIndex = boxIndex,
            _slot = slot,
            _petName = petName
          })
        end
      end
    end
  end
  
  if scope == FilterScope.CurrentBox then
    collectBox(self.data.curIndex, petBoxList[self.data.curIndex])
  else
    for boxIndex, boxPets in ipairs(petBoxList) do
      collectBox(boxIndex, boxPets)
    end
  end
  return petList
end

function this:filterPetListByMainElement(petList, elementIdList)
  if table.isEmpty(elementIdList) then
    return
  end
  for i = #petList, 1, -1 do
    local item = petList[i]
    local tpl = _petTpl:getTplById(item.itemId)
    local firstElement = tpl and _petTpl:getFirstElement(tpl)
    local _, index = table.ipairsFind(elementIdList, function(value)
      return value == firstElement
    end)
    if index == nil then
      table.remove(petList, i)
    end
  end
end

function this:getFilterPetPositionMap()
  local posMap = {}
  local petBoxList = L_PetStore:getPetBoxList() or {}
  for boxIndex, boxPets in ipairs(petBoxList) do
    if boxPets then
      for slot, petGuid in ipairs(boxPets) do
        if not math.isEmpty(petGuid) then
          posMap[petGuid] = {boxIndex = boxIndex, slot = slot}
        end
      end
    end
  end
  return posMap
end

function this:updateLockedFilterResult()
  local posMap = self:getFilterPetPositionMap()
  self._filteredPetMap = {}
  for i = #self._filteredPetList, 1, -1 do
    local petData = self._filteredPetList[i]
    local guid = petData and petData.guid
    local pet = guid and L_PetStore:getPetItem(guid)
    local posData = guid and posMap[guid]
    if pet and posData then
      petData.boxIndex = posData.boxIndex
      petData.slot = posData.slot
      petData.petName = pet.getPetName and pet:getPetName() or pet.pet_name or ""
      self._filteredPetMap[guid] = true
    else
      table.remove(self._filteredPetList, i)
    end
  end
end

function this:refreshFilterSelectedPet(forceFirst)
  if #self._filteredPetList <= 0 then
    L_PetStore:setCurSelectPetId(0)
    return
  end
  local curGuid = L_PetStore:getCurSelectPetId()
  if not forceFirst and not math.isEmpty(curGuid) then
    for _, petData in ipairs(self._filteredPetList) do
      if petData.guid == curGuid then
        return
      end
    end
  end
  local firstPet = self._filteredPetList[1]
  if firstPet and curGuid ~= firstPet.guid then
    L_PetStore:setCurSelectPetId(firstPet.guid)
  end
end

function this:refreshFilter(rebuildResult)
  if not self._filterKeyDic then
    self.isInFilter = false
    self._filteredPetList = {}
    self._filteredPetMap = {}
    self._filterResultLocked = false
    self:refreshCurBox()
    return
  end
  local hasFilter = false
  for key, value in pairs(self._filterKeyDic) do
    if key ~= L_SortFilterConst.FilterType.All and not table.isEmpty(value) then
      hasFilter = true
      break
    end
  end
  if not hasFilter then
    self.isInFilter = false
    self._filteredPetList = {}
    self._filteredPetMap = {}
    self._filterResultLocked = false
    self:refreshCurBox()
    return
  end
  self.isInFilter = true
  if self._filterResultLocked and not rebuildResult then
    self:updateLockedFilterResult()
    self:refreshFilterSelectedPet(false)
    self:refreshFilterListView()
    return
  end
  local filterScope = self:getFilterScope(self._filterKeyDic)
  local scopeFilterType = self:getPetBoxScopeFilterType()
  local mainElementFilterType = self:getPetBoxFilterTypeByTable("element_type") or L_SortFilterConst.FilterType.Element
  local geneFilterIdList = scopeFilterType ~= L_SortFilterConst.FilterType.Gene and self._filterKeyDic[L_SortFilterConst.FilterType.Gene] or nil
  local hasGeneFilter = geneFilterIdList and not table.isEmpty(geneFilterIdList)
  local mainElementIdList = self._filterKeyDic[mainElementFilterType]
  local actualDnaTypes = {}
  if hasGeneFilter then
    local _systemFiltercontentTpl = L_GameTpl:getSystemFiltercontentTpl()
    local _systemFiltertypeTpl = L_GameTpl:getSystemFiltertypeTpl()
    local tpl_filterType = _systemFiltertypeTpl:getTplById(L_SortFilterConst.FilterType.Gene)
    local filterKey = tpl_filterType and _systemFiltertypeTpl:getFilterKey(tpl_filterType) or nil
    local needConvert = filterKey == "id"
    for _, contentId in ipairs(geneFilterIdList or {}) do
      if needConvert then
        local tpl = _systemFiltercontentTpl:getTplById(contentId)
        if tpl then
          local enumId = _systemFiltercontentTpl:getEnumId(tpl)
          if enumId and 0 < enumId then
            table.insert(actualDnaTypes, enumId)
          end
        end
      else
        table.insert(actualDnaTypes, contentId)
      end
    end
  end
  local nonGeneFilterKeyDic = {}
  for typeId, idList in pairs(self._filterKeyDic) do
    if typeId ~= L_SortFilterConst.FilterType.Gene and typeId ~= L_SortFilterConst.FilterType.All and typeId ~= L_SortFilterConst.FilterType.QiBoBoxMode and typeId ~= scopeFilterType and typeId ~= L_SortFilterConst.FilterType.Element and typeId ~= mainElementFilterType and not table.isEmpty(idList) then
      nonGeneFilterKeyDic[typeId] = idList
    end
  end
  local hasNonGeneFilter = not table.isEmpty(nonGeneFilterKeyDic)
  local petList = self:collectPetListByFilterScope(filterScope)
  if hasNonGeneFilter then
    local tempSortFilter = L_SortFilterManager:createSortFilter(L_SystemConst.enum.pet, function()
    end, function()
    end)
    tempSortFilter.filterKeyDic = nonGeneFilterKeyDic
    tempSortFilter:filterList(petList)
  end
  self:filterPetListByMainElement(petList, mainElementIdList)
  if hasGeneFilter then
    local i = #petList
    while 1 <= i do
      local item = petList[i]
      local pet = L_PetStore:getPetItem(item.guid)
      local passGeneFilter = false
      local petGenes = L_PetStore:getPetSkills(pet, true, true, false)
      for _, dna in pairs(petGenes) do
        for _, dnaType in ipairs(actualDnaTypes) do
          if dna.dnaType == dnaType then
            passGeneFilter = true
            break
          end
        end
        if passGeneFilter then
          break
        end
      end
      if not passGeneFilter then
        table.remove(petList, i)
      end
      i = i - 1
    end
  end
  local allPets = {}
  for _, item in ipairs(petList) do
    local rarities = {}
    if hasGeneFilter then
      local pet = L_PetStore:getPetItem(item.guid)
      local petGenes = L_PetStore:getPetSkills(pet, true, true, false)
      for _, dna in pairs(petGenes) do
        for _, dnaType in ipairs(actualDnaTypes) do
          if dna.dnaType == dnaType then
            table.insert(rarities, dna.rarity)
            break
          end
        end
      end
      table.sort(rarities, function(a, b)
        return b < a
      end)
    else
      local _, gradeRank = L_PetStore:getPetGradeNew(item.guid)
      rarities = {
        gradeRank or 0
      }
    end
    table.insert(allPets, {
      guid = item.guid,
      boxIndex = item._boxIndex,
      slot = item._slot,
      rarities = rarities,
      petName = item._petName
    })
  end
  table.sort(allPets, function(a, b)
    if a.boxIndex ~= b.boxIndex then
      return a.boxIndex < b.boxIndex
    end
    if a.slot ~= b.slot then
      return a.slot < b.slot
    end
    for i = 1, math.max(#a.rarities, #b.rarities) do
      local aRarity = a.rarities[i] or 0
      local bRarity = b.rarities[i] or 0
      if aRarity ~= bRarity then
        return aRarity > bRarity
      end
    end
    return false
  end)
  self._filteredPetList = allPets
  self._filteredPetMap = {}
  for _, petData in ipairs(self._filteredPetList) do
    self._filteredPetMap[petData.guid] = true
  end
  self._filterResultLocked = true
  self:refreshFilterSelectedPet(true)
  self:refreshFilterListView(true)
end

function this:clearLastReddot()
  if not math.isEmpty(L_PetStore:getCurSelectPetId()) then
    local petItem = L_PetStore:getPetItem(L_PetStore:getCurSelectPetId())
    if petItem and petItem.gene_infos and #petItem.gene_infos > 0 then
      for _, v in ipairs(petItem.gene_infos) do
        local keyString = L_PetStore:getPetGeneMutationNewSaveKeyByPos(L_PetStore:getCurSelectPetId(), v.pos)
        C_PlayerPrefsUtility.SetInt(keyString, 0)
      end
    end
  end
end

function this:setShortcutGuidePCActive(isShow)
  local args = CS.Lens.Gameplay.UI.ModuleShortcutGuidePcUiPanelEventArgs()
  args.isLuaEvent = true
  args.luaTable = {shortcutGuidePcUiPanel = 32}
  if isShow then
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcShowUiPanel, args)
  else
    C_ExternalManager.DispatchEvent(C_EExternalEventType.ShortcutGuidePcHideUiPanel, args)
  end
end

function this:bindPCKey()
  L_ShortCutManager:addShortKeyFlag(self, "D", L_Const.AnchorType.Bottom, self.bindComponents.transformNext, L_Vector3.new(0.28, -5.31, 0), 0.68)
  L_ShortCutManager:addShortKeyFlag(self, "A", L_Const.AnchorType.Bottom, self.bindComponents.transformLast, L_Vector3.new(0.28, -5.31, 0), 0.68)
end

function this:setLockStateAnim(isShow)
  if isShow then
    if self.bindComponents.animUnlockState then
      self:stopAnimToLastFrame(self.bindComponents.animUnlockState, "anim_commonbtn_unlock_press")
    end
    if self.bindComponents.animLockState then
      self:stopAnimToLastFrame(self.bindComponents.animLockState, "anim_commonbtn_lock_press")
    end
  end
end

function this:stopAnimToLastFrame(anim, clipName)
  if anim.isPlaying then
    local aniState
    for _, state in pairs(anim) do
      if state and state.name == clipName then
        aniState = state
        break
      end
    end
    if aniState then
      aniState.normalizedTime = 1
      anim:Sample()
    end
  end
  anim:Stop()
end

function this:refreshFilterTitle()
  if self.isInFilter then
    self.bind.show_filterTitle = true
    self.bind.txt_filterTitle = L_WordsTpl:getValue("ui_kibo_box_filter_status")
    self.bind.curBoxName = L_WordsTpl:getValue("ui_kibo_box_filter_status")
    self.bind.go_curBoxIndex = false
    self.bind.go_changeBoxName = false
    self.bind.go_commonPetList = false
    self.bind.go_filterPetList = true
    self.bind.go_commonBoxInfo = false
  else
    self.bind.show_filterTitle = false
    self.bind.txt_filterTitle = ""
    local boxData = self.bind.loopListBox[self.data.curIndex]
    self.bind.go_curBoxIndex = true
    if boxData then
      self.bind.curBoxName = boxData.boxName
    end
    self.bind.go_changeBoxName = true
    self.bind.activeNextHitArea = true
    self.bind.activelastHitArea = true
    self.bind.go_commonPetList = true
    self.bind.go_filterPetList = false
    self.bind.go_commonBoxInfo = true
  end
end

function this:refreshFilterPetCells()
  local module = self.modules.petbox_Filter
  if not (module and module.modules) or not module.modules.list_pet then
    return
  end
  for _, cell in pairs(module.modules.list_pet) do
    if cell and cell.refreshView then
      cell:refreshView()
    end
  end
end

function this:refreshFilterListView(resetScroll)
  local petList = {}
  for i, petData in ipairs(self._filteredPetList) do
    petList[i] = {
      guid = petData.guid,
      originBoxIndex = petData.boxIndex,
      originSlot = petData.slot,
      petName = petData.petName,
      rarities = petData.rarities
    }
  end
  local module = self.modules.petbox_Filter
  if module then
    module.bind.boxIndex = self.data.curIndex
    module.bind.petList = petList
    if module.refreshFilterList then
      module:refreshFilterList(petList, self.filter, resetScroll)
    end
    if self.isInFilter and self.bind.go_filterPetList then
      self:refreshFilterPetCells()
    end
    return
  end
  if #self.bind.loopListBox <= 0 then
    return
  end
  local boxModule = self.bind.loopListBox:getItemCls(self.data.curIndex)
  if boxModule and boxModule.refreshFilterList then
    boxModule:refreshFilterList(petList, self.filter, resetScroll)
  end
  if self.isInFilter and self.bind.go_filterPetList then
    self:refreshFilterPetCells()
  end
end

function this:hasRealFilterCondition(filterKeyDic)
  filterKeyDic = filterKeyDic or self._filterKeyDic
  if table.isEmpty(filterKeyDic) then
    return false
  end
  local scopeFilterType = self:getPetBoxScopeFilterType()
  for key, value in pairs(filterKeyDic) do
    if key == scopeFilterType then
      if self:getFilterScope(filterKeyDic) == FilterScope.AllBox then
        return true
      end
    elseif key ~= L_SortFilterConst.FilterType.All and not table.isEmpty(value) then
      return true
    end
  end
  return false
end

function this:findCanMutationPetInBox(boxIndex)
  return L_PetManager:getCanMutationPetInBox(boxIndex)
end

function this:findNearestCanMutationPet()
  local petBoxList = L_PetStore:getPetBoxList() or {}
  local totalBox = #petBoxList
  if totalBox <= 0 then
    return nil, nil, nil
  end
  local curIndex = self.data.curIndex or 1
  local guid, slot = self:findCanMutationPetInBox(curIndex)
  if guid then
    return curIndex, slot, guid
  end
  for offset = 1, totalBox - 1 do
    local nextBoxIndex = (curIndex + offset - 1) % totalBox + 1
    guid, slot = self:findCanMutationPetInBox(nextBoxIndex)
    if guid then
      return nextBoxIndex, slot, guid
    end
    local lastBoxIndex = (curIndex - offset - 1) % totalBox + 1
    if lastBoxIndex ~= nextBoxIndex then
      guid, slot = self:findCanMutationPetInBox(lastBoxIndex)
      if guid then
        return lastBoxIndex, slot, guid
      end
    end
  end
  return nil, nil, nil
end

function this:getPetCellGameObject(boxIndex, slot, guid)
  if math.isEmpty(boxIndex) or math.isEmpty(slot) then
    return nil
  end
  local boxModule = self.bind.loopListBox:getItemCls(boxIndex)
  if boxModule and boxModule.refresh then
    boxModule:refresh()
  end
  local petCell
  if boxModule and boxModule.modules and boxModule.modules.list_pet then
    petCell = boxModule.modules.list_pet[slot]
  end
  if not petCell and boxModule and boxModule.bind and boxModule.bind.list_pet and boxModule.bind.list_pet.getItemCls then
    petCell = boxModule.bind.list_pet:getItemCls(slot)
  end
  if petCell and petCell.bind and petCell.bind.guid == guid then
    return petCell.gameObject
  end
  return nil
end

function this:jumpToGuidePetBox(boxIndex)
  if math.isEmpty(boxIndex) then
    return
  end
  self.isManualSwitch = true
  self:setPointListActive(boxIndex)
  local listPetBox = self.bindComponents and self.bindComponents.list_petBox
  if listPetBox then
    listPetBox:FocusItemIndex(boxIndex - 1)
    listPetBox:ScrollToCellImmediate(boxIndex - 1)
  end
end

function this:CheckCanFindTargetCellItem(guideSerializeId, guideParam)
  return true
end

function this:FindTargetCellItem(guideSerializeId, guideParam)
  if guideSerializeId == L_Const.GuideSerializeId.PetBoxFindCanMutationPet then
    local boxIndex, slot, guid = self:findNearestCanMutationPet()
    if not boxIndex then
      return nil
    end
    if boxIndex ~= self.data.curIndex then
      self:jumpToGuidePetBox(boxIndex)
    end
    local go = self:getPetCellGameObject(boxIndex, slot, guid)
    return go
  end
  return nil
end

function this:getPetBoxByIndex(index)
  local totalCount = #self.bind.loopListBox
  if 0 < totalCount then
    local idx = (index + totalCount) % totalCount
    local box = self.bind.loopListBox:getItemCls(idx + 1)
    return box
  end
  return nil
end

function this:getCurrentPetBox()
  local idx = self.realIndex or 0
  return self:getPetBoxByIndex(idx)
end

function this:setPetBoxNavigationEnable(box, bEnable, bReset)
  if box and box.bindComponents.navMgr then
    if bEnable then
      box.bindComponents.navMgr.navigationEnabled = true
      if bReset then
        box.bindComponents.navMgr:DisableAllArea(true)
        box.bindComponents.navMgr:SelectArea(GamepadNavigationAreas.PetList)
      end
    else
      box.bindComponents.navMgr:DisableAllArea()
      box.bindComponents.navMgr.navigationEnabled = false
    end
  end
end

function this:setCurrentPetBoxNavigationEnable(bEnable, bReset)
  local box = self:getCurrentPetBox()
  self:setPetBoxNavigationEnable(box, bEnable, bReset)
end

function this:onPetBoxListScrollToIndex(newIndex)
  local box = self.bind.loopListBox:getItemCls(newIndex + 1)
  if box and box.bindComponents.navMgr then
    local focusRegion = self:getGamepadFocusRegion()
    local navEnable = self.isTop and (focusRegion == GamepadFocusRegions.PetList or focusRegion == GamepadFocusRegions.PetListReleaseMode)
    self:setPetBoxNavigationEnable(box, navEnable, true)
  end
end

function this:onTopChange(options)
  if not self.isOpen then
    return
  end
  local preIsTop = self.isTop
  local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  self.isTop = self.pageName == curPageName
end

function this:gamepadFocusRegionInfo()
  return {
    [GamepadFocusRegions.PetList] = {
      onEnter = function(self, info)
        if self.realIndex then
          self:onPetBoxListScrollToIndex(self.realIndex)
        end
      end,
      onExit = function(self, info)
        self:setCurrentPetBoxNavigationEnable(false)
      end,
      modules = nil,
      navigationArea = "",
      backRegion = nil
    },
    [GamepadFocusRegions.PetInfo] = {
      onEnter = function(self, info)
      end,
      onExit = function(self, info)
      end,
      modules = {
        self.modules.modulePetBoxProperty
      },
      navigationArea = nil,
      backRegion = GamepadFocusRegions.PetList
    },
    [GamepadFocusRegions.FilterPanel] = {
      onEnter = function(self, info)
      end,
      onExit = function(self, info)
      end,
      modules = nil,
      navigationArea = GamepadNavigationAreas.FilterPanel,
      backRegion = GamepadFocusRegions.PetList
    },
    [GamepadFocusRegions.PetListReleaseMode] = {
      onEnter = function(self, info)
        if self.realIndex then
          self:onPetBoxListScrollToIndex(self.realIndex)
        end
      end,
      onExit = function(self, info)
        self:setCurrentPetBoxNavigationEnable(false)
      end,
      modules = {
        self.modules.modulesPetRelease.modulePetRelease
      },
      navigationArea = nil,
      backRegion = GamepadFocusRegions.PetList
    },
    [GamepadFocusRegions.PetReleaseFilterPanel] = {
      onEnter = function(self, info)
      end,
      onExit = function(self, info)
      end,
      modules = {
        self.modules.modulesPetRelease.modulePetRelease
      },
      navigationArea = nil,
      backRegion = GamepadFocusRegions.PetListReleaseMode
    }
  }
end

function this:setGamepadFocusRegion(regionId)
  self._gamepadFocusRegionInfo = self._gamepadFocusRegionInfo or self:gamepadFocusRegionInfo()
  local oldRegion = self._gamepadFocusRegion
  if self._gamepadFocusRegion then
    local info = self._gamepadFocusRegionInfo[self._gamepadFocusRegion]
    if self.bindComponents.navMgr and info.navigationArea then
      self.bindComponents.navMgr:DisableAllArea()
      self.bindComponents.navMgr.navigationEnabled = false
    end
    if info.onExit then
      info.onExit(self, info)
    end
    if info.modules then
      for _, module in ipairs(info.modules) do
        if module and module.gameObject and module.setGamepadFocus then
          module:setGamepadFocus(false, regionId, oldRegion)
        end
      end
    end
  end
  self._gamepadFocusRegion = regionId
  local infoNew = self._gamepadFocusRegionInfo[self._gamepadFocusRegion]
  if self.bindComponents.navMgr and infoNew.navigationArea then
    self.bindComponents.navMgr:DisableAllArea()
    self.bindComponents.navMgr.navigationEnabled = infoNew.navigationArea ~= ""
    if infoNew.navigationArea ~= "" then
      self.bindComponents.navMgr:SelectArea(infoNew.navigationArea)
    end
  end
  if infoNew.onEnter then
    infoNew.onEnter(self, infoNew)
  end
  if infoNew.modules then
    for _, module in ipairs(infoNew.modules) do
      if module and module.gameObject and module.setGamepadFocus then
        module:setGamepadFocus(true, regionId, oldRegion)
      end
    end
  end
end

function this:getGamepadFocusRegion()
  self._gamepadFocusRegion = self._gamepadFocusRegion or GamepadFocusRegions.PetList
  return self._gamepadFocusRegion
end

function this:onGamepadFocusRegionBack()
  if not self.isTop then
    return true
  end
  self._gamepadFocusRegionInfo = self._gamepadFocusRegionInfo or self:gamepadFocusRegionInfo()
  self._gamepadFocusRegion = self._gamepadFocusRegion or GamepadFocusRegions.PetList
  local info = self._gamepadFocusRegionInfo[self._gamepadFocusRegion]
  if info.backRegion then
    self:setGamepadFocusRegion(info.backRegion)
    return true
  end
  return false
end

function this:registerShortCut()
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.EPagePetBoxFocusOnFilters, function()
    if not self.isTop then
      return
    end
    if self.bind.modulePetReleaseActive then
      self:setGamepadFocusRegion(GamepadFocusRegions.PetReleaseFilterPanel)
    else
      self:setGamepadFocusRegion(GamepadFocusRegions.FilterPanel)
    end
  end)
end

function this:unregisterShortCut()
  L_ShortCutManager:unregisterShortCut(self.pageName, C_InputManager_KeyType.EPagePetBoxFocusOnFilters)
end

return this
