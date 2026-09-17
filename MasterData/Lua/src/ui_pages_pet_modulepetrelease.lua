local this = class("modulePetRelease", G_UIModuleBase)

function this.bind()
  return {
    selectedNum = "",
    list_dropdown = {
      moduleName = "modulePages/sortFilter/cellSortFilterDropdown"
    },
    txt_dropDown = "",
    toggleArrow = false,
    dropDownContent = false,
    curBoxIndex = "",
    curBoxName = "",
    module_pageTabSlider = {
      moduleName = "modulePages/modulePageTabSlider"
    },
    active_imgBg = true,
    active_clearBtn = true,
    active_releaseBtn = true,
    active_backRelease = true
  }
end

function this.methods()
  return {
    onClick_filter = function(self)
      L_PetStore:clickBoxFilter()
    end,
    onClick_fastSelect = function(self)
      L_UI:open("pagePetReleaseQuickSelect", {
        currentBox = self.curBox,
        callback = function(pets)
          self:setSelectedPets(pets)
        end
      })
    end,
    onClick_filterClear = function(self)
      L_PetStore:resetSelectGuids()
      self.parent:refreshCurBox()
    end,
    onClick_releaseConfirm = function(self)
      local pets = L_PetStore:getSelectGuids()
      if #pets == 0 then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_pet_empty"))
        return
      end
      local notShowAccess = self:GetSourceLuaPageOptions("failure_jump")
      L_UI:open("pagePetReleaseConfirm", {
        pets = table.clone(pets),
        notShowAccess = notShowAccess
      })
    end,
    onClick_showDropDownContent = function(self)
      self:refreshFilterActive()
      self.bind.dropDownContent = not self.bind.dropDownContent
      self.bind.toggleArrow = not self.bind.toggleArrow
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.img_frame)
    end,
    list_dropdown = {
      onClick_select = function(self, bind)
        self.parent.filter = bind.index
        self.bind.dropDownContent = false
        self.bind.txt_dropDown = L_WordsTpl:getValue(bind.type)
        self.bind.toggleArrow = false
        self.parent:refreshAllBox(self.bind.txt_dropDown)
      end
    },
    dropDownContentBgOnClick = function(self)
      self.bind.dropDownContent = false
      self.bind.toggleArrow = false
    end,
    onClick_closeRelease = function(self)
      L_PetReleaseManager:setIsReleaseMode(false, false, L_PetReleaseManager:getSelectedIdWhenExit(self.curBox))
    end
  }
end

function this:setSelectedPets(pets)
  if pets == 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_quick_empty"))
    return
  end
  local guids = {}
  for _, v in pairs(pets) do
    table.insert(guids, v.guid)
  end
  if L_PetReleaseManager:dealQuickSelect(guids) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_quick_filter"))
  else
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_quick_empty"))
  end
end

function this:open()
  self:initDropDown()
  self:adjustMaskByScreenRatio()
  self:refreshSelectedNum()
  L_PetStore:listenCallFunc(L_PetStore.event.setSelectReleasePet, self.onEvent_setSelectReleasePet, self)
  if self.bindComponents.navMgr then
    self.bindComponents.navMgr.navigationEnabled = false
  end
end

function this:close()
  L_PetStore:unListenCallFunc(L_PetStore.event.setSelectReleasePet, self.onEvent_setSelectReleasePet, self)
end

function this:show()
  self:setOnFilterDisplay()
end

function this:onEvent_setSelectReleasePet()
  self:initDropDown()
  self:refreshSelectedNum()
end

function this:refreshSelectedNum()
  local selectedGuids = L_PetStore:getSelectGuids() or {}
  self.bind.selectedNum = tostring(table.count(selectedGuids))
end

function this:setCurBox(boxId, boxIndexStr, boxName)
  self.curBox = boxId
  self.bind.curBoxIndex = boxIndexStr
  self.bind.curBoxName = boxName
end

function this:setTabSlider(curIndex, loopListLength)
  local modulePageTabSlider = self.modules.module_pageTabSlider
  if modulePageTabSlider then
    modulePageTabSlider:setPageIndex(curIndex, loopListLength)
  end
end

function this:initSortFilterModule()
  self.petSortFilter = L_SortFilterManager:createSortFilter(L_SystemConst.enum.petRelease, function()
  end, function()
    self:dealQuickFilter()
  end)
end

function this:dealQuickFilter()
  self:refreshFilterData()
  if #self._petTotalDataList == 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_quick_empty"))
    return
  end
  local guids = {}
  for _, v in pairs(self._petTotalDataList) do
    table.insert(guids, v.guid)
  end
  if L_PetReleaseManager:dealQuickSelect(guids) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_quick_filter"))
  else
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pet_release_quick_empty"))
  end
end

function this:refreshFilterData()
  self.petSortFilter:bindModule(self.modules.quickSelectFilter)
  self._isPetBoxMode = self.petSortFilter.filterKeyDic[L_SortFilterConst.FilterType.QiBoBoxMode] ~= nil
  local allPet = L_PetStore:getPetList()
  if self._isPetBoxMode then
    allPet = {}
    local boxPets = L_PetStore:getPetBoxList(self.data.curIndex)
    for _, guid in ipairs(boxPets) do
      table.insert(allPet, L_PetStore:getPetItem(guid))
    end
  end
  self._petTotalDataList = {}
  for i, pet in pairs(allPet) do
    table.insert(self._petTotalDataList, {
      itemType = L_Const.resType.pet,
      itemId = pet.id,
      guid = pet.guid
    })
  end
  self.petSortFilter:sortFilterList(self._petTotalDataList)
end

function this:initDropDown()
  local tmp = {}
  local laborType = L_PetConst.filterPetBox.labor
  for index, filterType in ipairs(self.parent.filterTypeOrder) do
    if filterType ~= laborType then
      local typeKey = self.parent.filterType[filterType]
      local isActiveLine = index ~= #self.parent.filterTypeOrder
      table.insert(tmp, {
        index = filterType,
        type = L_WordsTpl:getValue(typeKey),
        txt_name = L_WordsTpl:getValue(typeKey),
        go_icon = false,
        txt_name_h = L_WordsTpl:getValue(typeKey),
        go_line = isActiveLine
      })
    end
  end
  if self.parent.filter == laborType then
    self.parent.filter = L_PetConst.filterPetBox.grade
    self.parent:refreshAllBox(self.bind.txt_dropDown)
  end
  self.bind.txt_dropDown = tmp[self.parent.filter].txt_name
  self.bind.list_dropdown:clear()
  self.bind.list_dropdown:insert_array(tmp)
end

function this:refreshFilterActive()
  for i = 1, #self.bind.list_dropdown do
    local index = self.bind.list_dropdown:getValue(i, "index")
    if index == self.parent.filter then
      self.bind.list_dropdown:getItemCls(i):setActive(true)
    else
      self.bind.list_dropdown:getItemCls(i):setActive(false)
    end
  end
end

function this:getIndexName(index)
  if index < 10 then
    return string.format("0%d", index)
  end
  return tostring(index)
end

function this:adjustMaskByScreenRatio()
  if L_DeviceTpl:getIsMobile() then
    local ratio = C_Screen.width / C_Screen.height
    local t = (ratio - 1.0) / 0.7777799999999999
    local posX = -1574 + t * -134.9000000000001
    local maskRect = self.bindComponents.rect_maskImg
    maskRect.anchoredPosition = C_Vector2(posX, maskRect.anchoredPosition.y)
    self.bind.active_imgBg = false
    self.bind.active_imgBg = true
  end
end

function this:setOnFilterDisplay()
  local isFilterShow = self.parent.bind.offset_boxfilter
  self.bind.active_clearBtn = not isFilterShow
  self.bind.active_releaseBtn = not isFilterShow
  self.bind.active_backRelease = not isFilterShow
  if self.bindComponents then
    self.bindComponents.mask_img.enabled = isFilterShow
    self.bindComponents.animBtnFilter:SetBool("On", isFilterShow)
  end
end

function this:setGamepadFocus(bFocus, newFocusRegion, oldFocusRegion)
  self._gamepadFocus = bFocus
  if bFocus and newFocusRegion == 11 then
    if self.bindComponents.navMgr then
      self.bindComponents.navMgr.navigationEnabled = true
      self.bindComponents.navMgr:DisableAllArea(true)
      self.bindComponents.navMgr:SelectArea("AreaPetReleaseFilterPanel")
    end
  elseif self.bindComponents.navMgr then
    self.bindComponents.navMgr.navigationEnabled = false
  end
end

return this
