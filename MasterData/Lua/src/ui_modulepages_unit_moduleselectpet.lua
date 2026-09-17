local this = class("moduleSelectPet", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local PageCount = 30
local shrinkInterval = 140

function this.bind()
  return {
    go_shrink = false,
    go_switchCam = false,
    list_pet_snap_start_index = 0,
    list_pet_snap_end_index = 0,
    isOn_listEmpty_shrink = false,
    list_pet_shrink = {
      moduleName = "pages/formation/formationModule/cellPixelPetFormation"
    },
    list_pet_shrinkPre = {
      moduleName = "pages/formation/formationModule/cellPixelPetFormation"
    },
    list_pet_shrinkNext = {
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
    module_formationPetPropertyName = "",
    module_extend = {
      type = "toggleModule",
      moduleExtend = {
        assetName = "UI/CommonModules/Unit/moduleCommonBottomSelectExpand",
        moduleName = "modulePages/unit/moduleCommonBottomSelectExpand"
      }
    },
    module_extendName = "",
    go_btnRecommend = false,
    go_btnUnrecommend = false,
    module_recommendName = "",
    module_recommend = {
      type = "toggleModule",
      moduleRecommend = {
        assetName = "UI/CommonModules/Unit/modulePetRecommend",
        moduleName = "modulePages/unit/modulePetRecommend"
      }
    }
  }
end

function this.methods()
  return {
    onClick_expand = function(self)
      if self._isPlayingVFX then
        return
      end
      C_AudioManager.Play("Play_SFX_System_UI_General_Halfscreen_Open")
      self:playExpandVFX()
    end,
    onClick_cameraSwitch = function(self)
      self:petCameraSwitch()
    end,
    onClick_petRecommend = function(self)
      self:petRecommend()
    end,
    onClick_petUnrecommend = function(self)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_recommend_pet_lock"))
    end
  }
end

function this:open()
  self._selectPetHandler = handler(self, self.selectPet)
  self._onPointEnterPetCellHandler = handler(self, self.onPointEnterPetCell)
  self._onPointExitPetCellHandler = handler(self, self.onPointExitPetCell)
  self._afterLateUpdateHandle = handler(self, self.onLateUpdate)
  C_UpdateSource.AddAfterLateUpdateEventHandler(self._afterLateUpdateHandle, "FormationMain_moduleSelectPet.afterLateUpdateHandle")
  self.rectShrinkListPre = self.bindComponents.rect_pet_shrinkPre
  self.rectShrinkListMid = self.bindComponents.rect_pet_shrinkMid
  self.rectShrinkListNext = self.bindComponents.rect_pet_shrinkNext
  self.rectShrinkContentPre = self.bindComponents.content_pet_shrinkPre
  self.rectShrinkContentMid = self.bindComponents.content_pet_shrinkMid
  self.rectShrinkContentNext = self.bindComponents.content_pet_shrinkNext
  self.bindShrinkListPre = self.bind.list_pet_shrinkPre
  self.bindShrinkListMid = self.bind.list_pet_shrink
  self.bindShrinkListNext = self.bind.list_pet_shrinkNext
  self.scrollPre = self.bindComponents.scrollRectPre_shrink
  self.scrollMid = self.bindComponents.scrollRect_shrink
  self.scrollNext = self.bindComponents.scrollRectNext_shrink
  self.line1 = self.bindComponents.line1
  self.line2 = self.bindComponents.line2
  
  function self.scrollMid.rectOnEndDrag()
    self:onShrinkScrollEnd(self.bindComponents.scrollRect_shrink)
  end
  
  function self.scrollPre.rectOnEndDrag()
    self:onShrinkScrollEnd(self.bindComponents.scrollRectPre_shrink)
  end
  
  function self.scrollNext.rectOnEndDrag()
    self:onShrinkScrollEnd(self.bindComponents.scrollRectNext_shrink)
  end
  
  self.prePosX = self.rectShrinkListPre.localPosition.x - shrinkInterval
  self.midPosX = self.rectShrinkListMid.localPosition.x
  self.nextPosX = self.rectShrinkListNext.localPosition.x + shrinkInterval
  L_HomeStore:listenCallFunc(L_HomeStore.event.refreshHomePetInfo, self.refreshPetStatus, self)
  local startSnapIndex = 1
  local endSnapIndex = startSnapIndex + PageCount - 1
  self.bind.list_pet_snap_start_index = startSnapIndex
  self.bind.list_pet_snap_end_index = endSnapIndex
  C_InputManager.SetGamepadUIInputMap("moduleSelectPet", true)
  L_ShortCutManager:registerShortCut("moduleSelectPet", C_InputManager_KeyType.EModuleSelectPetShowProperty, function()
    self:onGamepadShowProperty()
  end)
  L_ShortCutManager:registerShortCut("moduleSelectPet", C_InputManager_KeyType.EModuleSelectPetFocusProperty, function()
    self:onGamepadFocusProperty()
  end)
  L_ShortCutManager:registerShortCut("moduleSelectPet", C_InputManager_KeyType.EGamepadUI_R3, function()
    self:onGamepadOpenPagePet()
  end)
end

function this:close(options)
  self:configTouch("-")
  L_TimerManager:clearTimer(self)
  if self._afterLateUpdateHandle then
    C_UpdateSource.RemoveAfterLateUpdateEventHandler(self._afterLateUpdateHandle)
  end
  self._afterLateUpdateHandle = nil
  self.scrollMid.rectOnEndDrag = nil
  self.scrollPre.rectOnEndDrag = nil
  self.scrollNext.rectOnEndDrag = nil
  if self.scrollTween1 then
    self.scrollTween1:Kill()
    self.scrollTween1 = nil
  end
  if self.scrollTween2 then
    self.scrollTween2:Kill()
    self.scrollTween2 = nil
  end
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshHomePetInfo, self.refreshPetStatus, self)
  C_InputManager.SetGamepadUIInputMap("moduleSelectPet", false)
  L_ShortCutManager:unregisterShortCut("moduleSelectPet", C_InputManager_KeyType.EModuleSelectPetShowProperty)
  L_ShortCutManager:unregisterShortCut("moduleSelectPet", C_InputManager_KeyType.EModuleSelectPetFocusProperty)
  L_ShortCutManager:unregisterShortCut("moduleSelectPet", C_InputManager_KeyType.EGamepadUI_R3)
end

function this:initModule(param)
  self._param = param or {}
  self._petBoxIndex = param.defaultSelectBoxIndex
  self.cellType = param.cellType
  self.editMode = param.editMode or false
  self.heroConfigId = self._param.heroConfigId
  self.bind.pageType = param.pageType
  self:initSortFilterModule()
  self.bind.go_shrink = false
  self:playShrinkVFX()
  self:initPetList()
  self:refreshContent()
  self:refreshPetRecommend()
  CS.Lens.Gameplay.UI.UIPageAreaStateMachine.instance:PushArea("pageFormationMain", "AreaSelectPet")
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

function this:getExpandModule()
  if not self._expandModule then
    self.bind.module_extendName = "moduleExtend"
    self._expandModule = self.modules.module_extend.moduleExtend
    if self._expandModule then
      self._expandModule:initModule({
        systemId = self._param.systemId,
        defaultSelectBoxIndex = self._petBoxIndex,
        cellType = self.cellType,
        editMode = self.editMode,
        petSortFilter = self._petSortFilter,
        onSelectPetCallback = handler(self, self.onExpandSelectPetCallback),
        onShrinkCallback = handler(self, self.onExpandShrinkCallback),
        pageType = self.bind.pageType
      })
      self._expandModule:setOnBoxIndexChangeCallback(handler(self, self.onExpandBoxIndexChange))
    end
  end
  return self._expandModule
end

function this:onExpandSelectPetCallback(guid)
  self:emit("onClick_selectPet", guid)
  if self.bind.onClickSelectPet then
    self.bind:onClickSelectPet(guid)
  end
  self.selPetID = guid
end

function this:onExpandShrinkCallback()
  self._isExpand = false
  self.bind.go_shrink = true
  if self.bindComponents.ani_moduleSelectPet then
    self.bindComponents.ani_moduleSelectPet:SetBool("Expand", false)
  end
  self:refreshContent()
end

function this:onExpandBoxIndexChange(newBoxIndex)
  self._petBoxIndex = newBoxIndex
end

function this:refreshContent()
  if self._isExpand then
    local expandModule = self:getExpandModule()
    if expandModule then
      expandModule:setPetSortFilter(self._petSortFilter)
      expandModule:setPetBoxMode(self._isPetBoxMode)
      expandModule:setPetTotalDataList(self._petTotalDataList)
      expandModule:setPetBoxIndex(self._petBoxIndex)
      expandModule:refreshContent()
    end
  else
    self._petSortFilter:bindModule(self.modules.module_sortFilter_shrink)
    self:refreshThreePagePet_shrink()
    self.bind.go_boxInfo_shrink = self._isPetBoxMode
    if self._isPetBoxMode then
      self:initPetBoxFilterModule()
    else
      self.scrollMid:FocusItemIndex(0)
    end
  end
  self:configTouch(self._isExpand and "-" or "+")
  self:refreshBottomGamepadCuts()
end

function this:initPetList()
  self._isPetBoxMode = self._petSortFilter.filterKeyDic[L_SortFilterConst.FilterType.QiBoBoxMode] == nil
  if not self._isPetBoxMode then
    local allPet = L_PetStore:getPetList()
    self._petTotalDataList = {}
    for i, pet in pairs(allPet) do
      table.insert(self._petTotalDataList, {
        itemType = L_Const.resType.pet,
        itemId = pet.id,
        guid = pet.guid,
        groupId = 0
      })
    end
    self._petSortFilter:sortFilterList(self._petTotalDataList)
  end
end

function this:refreshThreePagePet_shrink(mark)
  if self.editMode then
    self:checkHasPet()
  end
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
      callback = nil,
      groupId = 0
    }
  end
  
  local function buildGroupHeadPaddingCell(groupId)
    return {
      itemType = 0,
      itemId = 0,
      guid = 0,
      callback = nil,
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
        groupId = 0,
        pageType = self.bind.pageType,
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
    self.rectShrinkListMid.gameObject:SetActive(true)
    self.rectShrinkListNext.gameObject:SetActive(false)
    self.rectShrinkListPre.gameObject:SetActive(false)
    self.line1.gameObject:SetActive(false)
    self.line2.gameObject:SetActive(false)
    self.bindShrinkListPre:clear()
    self.bindShrinkListNext:clear()
    if #self.bindShrinkListMid == #curPageData then
      for i, v in pairs(curPageData) do
        self.bindShrinkListMid:change(i, v)
      end
    else
      self.bindShrinkListMid:clear()
      self.bindShrinkListMid:insert_array(curPageData)
    end
    self.bind.isOn_listEmpty_shrink = table.isEmpty(curPageData)
  else
    local curPageData = {}
    for _, v in ipairs(self._petTotalDataList or {}) do
      table.insert(curPageData, {
        guid = v.guid,
        callback = self._selectPetHandler,
        pointEnterCallback = self._onPointEnterPetCellHandler,
        pointExitCallback = self._onPointExitPetCellHandler,
        pageType = self.bind.pageType
      })
    end
    self.bind.isOn_listEmpty_shrink = table.isEmpty(curPageData)
    if #self.bindShrinkListMid == #curPageData then
      for i, v in pairs(curPageData) do
        self.bindShrinkListMid:change(i, v)
      end
    else
      self.bindShrinkListMid:clear()
      self.bindShrinkListMid:insert_array(curPageData)
    end
    self.rectShrinkListNext.gameObject:SetActive(false)
    self.rectShrinkListPre.gameObject:SetActive(false)
    self.line1.gameObject:SetActive(false)
    self.line2.gameObject:SetActive(false)
  end
  if self.selectDic ~= nil then
    self:setListSelect(self.selectDic)
  end
end

function this:initPetBoxFilterModule()
  local module_petBoxSortFilter = self.modules.module_petBoxSortFilter
  module_petBoxSortFilter:initModuleByDefaultIndex(self._petBoxIndex, function(selectIndex)
    self._petBoxIndex = selectIndex
    local realCount = PageCount + 1
    local startIndex = (self._petBoxIndex - 1) * realCount + 1
    self.bind.list_pet_snap_start_index = startIndex
    self.bind.list_pet_snap_end_index = startIndex + PageCount - 1
    self.scrollMid:FocusItemIndex(startIndex, true)
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
  local petPosIdx = L_FormationStore:getPetPlaceInTeam(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), cell.bind.guid)
  if petPosIdx == L_FormationManager:getFocusIndex() then
    self.bind.go_switchCam = false
    if self.parent and self.parent.resetPetCamera then
      self.parent:resetPetCamera()
    end
  else
    self.bind.go_switchCam = false
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
  if self._isExpand then
    local expandModule = self:getExpandModule()
    if expandModule then
      expandModule:playShrinkVFX()
    end
    return true
  end
end

function this:setListSelect(selectDic)
  self.selectDic = selectDic or {}
  for i, v in pairs(self.modules.list_pet_shrink) do
    local cell = v
    local petParams = self.selectDic[cell.bind.guid]
    cell:setSelect((petParams and petParams.isSelect) == true)
    cell:setPosIndex(petParams and petParams.index)
  end
  for i, v in pairs(self.modules.list_pet_shrinkPre) do
    local cell = v
    local petParams = self.selectDic[cell.bind.guid]
    cell:setSelect((petParams and petParams.isSelect) == true)
    cell:setPosIndex(petParams and petParams.index)
  end
  for i, v in pairs(self.modules.list_pet_shrinkNext) do
    local cell = v
    local petParams = self.selectDic[cell.bind.guid]
    cell:setSelect((petParams and petParams.isSelect) == true)
    cell:setPosIndex(petParams and petParams.index)
  end
end

function this:petCameraSwitch()
  if self.parent and self.parent.switchPetCamera then
    self.parent:switchPetCamera()
  end
end

function this:checkHasPet()
  local guid = L_FormationStore:getFormationPosPetGuid(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), L_FormationManager:getFocusIndex())
  if guid and 0 < guid then
    self.bind.go_switchCam = false
  else
    self.bind.go_switchCam = false
  end
end

function this:onPointEnterPetCell(cell)
  if not L_DeviceTpl:getIsPc() then
    return
  end
  if C_InputManager.IsEnableGamePad then
    local isPreShowModuleInfo = false
    if self._petPropertyModule then
      isPreShowModuleInfo = self._petPropertyModule:isShowModuleInfo()
    end
    self:showPetProperty(cell:getRaycastGo(), cell.bind.guid)
    if not isPreShowModuleInfo then
      self._petPropertyModule:showModuleInfoDirect(false)
    end
    self:refreshBottomGamepadCuts()
  else
    self:showPetProperty(cell:getRaycastGo(), cell.bind.guid)
  end
end

function this:onPointExitPetCell(cell)
  if not L_DeviceTpl:getIsPc() then
    return
  end
  self:hidePetProperty()
end

function this:configTouch(operator)
  if not L_DeviceTpl:getIsMobile() then
    return
  end
  self.onUITouchHandle = self.onUITouchHandle or L_CommonUtil.handle(self.onUI_touchHandle, self)
  self.onUIClickHandle = self.onUIClickHandle or L_CommonUtil.handle(self.onUI_clickHandle, self)
  self.onUIDragEndHandle = self.onUIDragEndHandle or L_CommonUtil.handle(self.onUI_clickHandle, self)
  C_ScreenTouch.OnUI_LongTapEnd(operator, self.onUIClickHandle)
  C_ScreenTouch.OnUI_Click(operator, self.onUIClickHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onUIDragEndHandle)
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

function this:onUI_clickHandle(gesture)
  if not self.isBind then
    return
  end
  if self._petPropertyModule then
    self._petPropertyModule:showModuleInfo(false, nil, false, gesture)
  end
end

function this:getHoldInfo(go)
  for i, v in ipairs(self.modules.list_pet_shrink) do
    local module = v
    if module:getRaycastGo() == go then
      return module.bind.guid
    end
  end
end

function this:isShowPetProperty()
  if not self._petPropertyModule then
    return false
  end
  return self._petPropertyModule:isShowModuleInfo()
end

function this:isShowPetPropertyDetail()
  if not self._petPropertyModule then
    return false
  end
  return self._petPropertyModule:isShowModuleInfoDetail()
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

function this:hidePetProperty()
  if not self:isShowPetProperty() then
    return
  end
  CS.Lens.Gameplay.UI.UIPageAreaStateMachine.instance:ReplaceArea("pageFormationMain", "AreaSelectPet")
  self._petPropertyModule:showModuleInfo(false)
end

function this:hidePetPropertyDetail()
  if not self:isShowPetPropertyDetail() then
    return
  end
  self._petPropertyModule:HideBattleSkillDetail()
  self._petPropertyModule:HideGeneSkillDetail()
end

function this:onGamepadShowProperty()
  if self:isShowPetProperty() then
    return
  end
  self._petPropertyModule:showModuleInfoDirect(true)
  self:refreshBottomGamepadCuts()
end

function this:onGamepadFocusProperty()
  if not self:isShowPetProperty() then
    return
  end
  CS.Lens.Gameplay.UI.UIPageAreaStateMachine.instance:ReplaceArea("pageFormationMain", "AreaSelectPetDetail")
  self:refreshBottomGamepadCuts()
end

function this:onGamepadOpenPagePet()
  if self:isShowPetProperty() then
    return
  end
  local petGuid = L_FormationStore:getFormationPosPetGuid(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), L_FormationManager:getFocusIndex())
  if math.isEmpty(petGuid) then
    return
  end
  local serverData = L_PetStore:getPetItem(petGuid)
  if serverData and not serverData:getPetAbilityLimited() then
    L_UI:open("pagePet", {petId = petGuid})
  end
end

function this:refreshBottomGamepadCuts()
  if self:isShowPetPropertyDetail() then
    local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {
      moduleOrPageName = "moduleSelectPet",
      changeGroupName = "selectpet_property_detail"
    }
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
    return
  end
  local petNavMng = self.gameObject:GetComponent(typeof(C_UINavigationBinding))
  local propNavMng = self._petPropertyModule and self._petPropertyModule.gameObject:GetComponent(typeof(C_UINavigationBinding)) or nil
  if propNavMng and propNavMng.navigationEnabled then
    local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {
      moduleOrPageName = "moduleSelectPet",
      changeGroupName = "selectpet_property_detail"
    }
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
    return
  end
  if petNavMng and petNavMng.navigationEnabled and self:isShowPetProperty() then
    if self:isSelectedPetInTeam() then
      local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
      args.isLuaEvent = true
      args.luaTable = {
        moduleOrPageName = "moduleSelectPet",
        changeGroupName = "selectpet_property_selectpet"
      }
      C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
      return
    else
      local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
      args.isLuaEvent = true
      args.luaTable = {
        moduleOrPageName = "moduleSelectPet",
        changeGroupName = "selectpet_property_unselectpet"
      }
      C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
      return
    end
  end
  if self:isSelectedPetInTeam() then
    local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {
      moduleOrPageName = "moduleSelectPet",
      changeGroupName = "selectpet_noproperty_selectpet"
    }
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
    return
  else
    local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
    args.isLuaEvent = true
    args.luaTable = {
      moduleOrPageName = "moduleSelectPet",
      changeGroupName = "selectpet_noproperty_unselectpet"
    }
    C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
    return
  end
end

function this:isSelectedPetInTeam()
  local selGo = C_GamepadUtility.GetCurrentSelectedGameObject()
  if not selGo or selGo:IsNull() then
    return false
  end
  for i, cell in ipairs(self.modules.list_pet_shrink) do
    if cell and cell._cellPixelPet and selGo.transform.parent.gameObject == cell._cellPixelPet.gameObject then
      return cell._cellPixelPet.bind.selected
    end
  end
  return false
end

function this:playExpandVFX()
  if not self.isBind then
    return
  end
  if self._isPlayingVFX then
    return
  end
  if self.bindComponents.ani_moduleSelectPet then
    self.bindComponents.ani_moduleSelectPet:SetBool("Expand", true)
  end
  self._isExpand = true
  self._isPlayingVFX = true
  L_TimerManager:newOrResetTimer(self, "playExpandVFX", function()
    self._isPlayingVFX = false
    self.bind.go_shrink = false
    self.bind.list_pet_shrink:clear()
    local expandModule = self:getExpandModule()
    if expandModule then
      expandModule:setPetSortFilter(self._petSortFilter)
      expandModule:setPetBoxMode(self._isPetBoxMode)
      expandModule:setPetTotalDataList(self._petTotalDataList)
      expandModule:setPetBoxIndex(self._petBoxIndex)
      expandModule:playExpandVFX()
    end
  end, 0.17)
end

function this:playShrinkVFX()
  if not self.isBind then
    return
  end
  if self._isPlayingVFX then
    return
  end
  self.bind.go_shrink = true
  self._isExpand = false
  self._isPlayingVFX = true
  if self.bindComponents.ani_moduleSelectPet then
    self.bindComponents.ani_moduleSelectPet:SetBool("Expand", false)
  end
  L_TimerManager:newOrResetTimer(self, "playShrinkVFX", function()
    self._isPlayingVFX = false
  end, 0.17)
end

function this:playHideVFX()
  self._isPlayingVFX = true
  if self.bindComponents.ani_moduleSelectPet then
    self.bindComponents.ani_moduleSelectPet:Play("Hide")
  end
  L_TimerManager:newOrResetTimer(self, "playHideVFX", function()
    self:emit("onVFXPlay_hide")
    if self.bind.onVFXPlayHideCb then
      self.bind:onVFXPlayHideCb()
    end
    self._isPlayingVFX = false
  end, 0.17)
end

function this:enableDetailBtn()
  self.enableDetailBtnFlag = true
end

function this:onLateUpdate()
end

function this:onShrinkScrollEnd(scroll)
  if scroll == self.scrollMid then
    local pos = self.scrollMid.horizontalNormalizedPosition
    local boxNum = L_PetStore:getPetBoxNum()
    local realCount = PageCount + 1
    local offset = 1.0 / boxNum * (3.0 / realCount)
    local startSnapIndex = math.floor(boxNum * (pos + offset)) * realCount + 1
    local endSnapIndex = startSnapIndex + PageCount - 1
    self.bind.list_pet_snap_start_index = startSnapIndex
    self.bind.list_pet_snap_end_index = endSnapIndex
    local newIndex = math.floor(startSnapIndex / realCount) + 1
    if newIndex < 1 then
      newIndex = 1
    end
    if boxNum < newIndex then
      newIndex = boxNum
    end
    if newIndex ~= self._petBoxIndex then
      self._petBoxIndex = newIndex
      self.modules.module_petBoxSortFilter:refreshInfoWithoutCallback(self._petBoxIndex)
      L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Button_Slide")
    end
  end
end

function this:refreshPetStatus()
  for i, v in ipairs(self.modules.list_pet_shrink) do
    v:refreshView()
  end
  self:refreshBottomGamepadCuts()
end

function this:refreshAllSelect()
  if not self.isBind then
    return
  end
  if self._isExpand then
    self._expandModule:refreshAllSelect()
  else
    for i, v in ipairs(self.modules.list_pet_shrink) do
      local cell = v
      cell:refreshSelect()
    end
  end
  self:refreshBottomGamepadCuts()
end

function this:petRecommend()
  if not self.heroConfigId then
    return
  end
  self.bind.go_btnRecommend = false
  self.bind.module_recommendName = "moduleRecommend"
  if self.modules.module_recommend.moduleRecommend then
    self.modules.module_recommend.moduleRecommend:initModule({
      configId = self.heroConfigId,
      SetBtnRecommendVisible = function(module, visible)
        self:SetBtnRecommendVisible(visible)
      end
    })
    
    function self.modules.module_recommend.moduleRecommend.bind.onClickSelectPet(cell, petGuid)
      self:emit("onClick_selectPet", petGuid)
      if self.bind.onClickSelectPet then
        self.bind:onClickSelectPet(petGuid)
      end
    end
  end
end

function this:SetBtnRecommendVisible(visible)
  self.bind.go_btnRecommend = visible
end

function this:refreshPetRecommend()
  self.bind.go_btnRecommend = false
  self.bind.go_btnUnrecommend = false
  self.bind.module_recommendName = ""
  local tpl = _heroTpl:getTplById(self.heroConfigId)
  local petTable = _heroTpl:getHeroRecommendPet(tpl)
  if not (tpl and petTable) or table.isEmpty(petTable) then
    self.bind.go_btnRecommend = false
    self.bind.go_btnUnrecommend = self._param.showRecommend
  else
    self.bind.go_btnRecommend = self._param.showRecommend
    self.bind.go_btnUnrecommend = false
  end
end

return this
