local this = class("moduleCommonBottomSelectExpand", G_UIModuleBase)
local PageCount = 30

function this.bind()
  return {
    go_expand = false,
    list_pet_expand = {
      moduleName = "pages/formation/formationModule/cellPixelPetFormation"
    },
    txt_boxName_expand = nil,
    txt_boxIndex_expand = nil,
    go_changePageTab = false,
    go_lastBtn = false,
    go_nextBtn = false,
    module_pageTabSlider = {
      moduleName = "modulePages/modulePageTabSlider"
    },
    module_sortFilter_expand = L_Const.ModuleInfo.SortFilterModule
  }
end

function this.methods()
  return {
    onClick_lastPage = function(self)
      self:changePageIndex(-1)
    end,
    onClick_nextPage = function(self)
      self:changePageIndex(1)
    end,
    onClick_shrink = function(self)
      if self._isPlayingVFX then
        return
      end
      C_AudioManager.Play("Play_SFX_System_UI_General_Halfscreen_Close")
      self:playShrinkVFX()
    end,
    onClick_closeExpand = function(self)
      if self._isPlayingVFX then
        return
      end
      self:playShrinkVFX()
    end,
    onClick_btnBg = function(self)
      self:escHandle()
    end,
    onClick_detail = function(self)
      local curPosPet = L_FormationStore:getFormationPosPetGuid(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), L_FormationManager:getFocusIndex())
      if math.isEmpty(curPosPet) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("residual_code_moduleselectpet_01"))
        return
      end
      if self:GetSourceLuaPageOptions("failure_jump") then
        L_FlyMsgManager:showNormalMsgByKey("common_jump_ban_tips")
        return
      end
      L_UI:open("pagePet", {
        petId = curPosPet,
        callBack = function()
          Timer.once(0.2, function()
            self:playExpandVFX()
            self:refreshContent()
          end)
        end
      })
    end
  }
end

function this:open()
  self._selectPetHandler = handler(self, self.selectPet)
  L_HomeStore:listenCallFunc(L_HomeStore.event.refreshHomePetInfo, self.refreshPetStatus, self)
end

function this:close()
  L_TimerManager:clearTimer(self)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshHomePetInfo, self.refreshPetStatus, self)
end

function this:initModule(param)
  self._param = param or {}
  self._petBoxIndex = param.defaultSelectBoxIndex or 1
  self.cellType = param.cellType
  self.editMode = param.editMode or false
  self._petSortFilter = param.petSortFilter
  self.pageType = param.pageType
  self._onSelectPetCallback = param.onSelectPetCallback
  self._onShrinkCallback = param.onShrinkCallback
  self._isExpand = false
  self._isPlayingVFX = false
  self.selPetID = nil
  self.selectDic = {}
end

function this:setPetSortFilter(petSortFilter)
  self._petSortFilter = petSortFilter
end

function this:setPetBoxMode(isPetBoxMode)
  self._isPetBoxMode = isPetBoxMode
end

function this:setPetTotalDataList(petTotalDataList)
  self._petTotalDataList = petTotalDataList
end

function this:setPetBoxIndex(petBoxIndex)
  self._petBoxIndex = petBoxIndex
end

function this:setMoveToId(moveToId)
  self._moveToId = moveToId
end

function this:refreshContent()
  if not self._isExpand then
    return
  end
  if self._petSortFilter and self.modules.module_sortFilter_expand then
    self._petSortFilter:bindModule(self.modules.module_sortFilter_expand)
  end
  self:refreshCurPagePet_expand()
  self:refreshPageTabInfo(true)
end

function this:changePageIndex(delta)
  if self._isPetBoxMode then
    self._petBoxIndex = math.clamp(self._petBoxIndex + delta, 1, L_PetStore:getPetBoxNum())
  else
    self._petPageIndex = math.clamp(self._petPageIndex + delta, 1, self._petTotalPageNum)
  end
  self:refreshCurPagePet_expand()
  self:refreshPageTabInfo()
  if self._isPetBoxMode and self._onBoxIndexChangeCallback then
    self._onBoxIndexChangeCallback(self._petBoxIndex)
  end
end

function this:refreshCurPagePet_expand()
  self:moveToPage()
  local curPageData = {}
  if self._isPetBoxMode then
    self._petBoxIndex = self._petBoxIndex or 1
    local boxData = L_PetStore:getPetBoxList(self._petBoxIndex)
    local temp = {}
    for i, guid in pairs(boxData) do
      if not math.isEmpty(guid) then
        local petData = L_PetStore:getPetItem(guid)
        table.insert(temp, {
          itemType = L_Const.resType.pet,
          itemId = petData.id,
          guid = guid,
          type = self.cellType or L_Const.cellIconUnitType.selectPet,
          pageType = self.pageType,
          callback = self._selectPetHandler
        })
      end
    end
    if self._petSortFilter then
      self._petSortFilter:filterList(temp)
    end
    for i = 1, PageCount do
      table.insert(curPageData, {
        itemType = 0,
        itemId = 0,
        guid = 0,
        pageType = self.pageType,
        callback = nil
      })
    end
    for i, cell in pairs(temp) do
      local pet = L_PetStore:getPetItem(cell.guid)
      curPageData[pet.box_id % 100] = cell
    end
  else
    self._petPageIndex = self._petPageIndex or 1
    if self._petTotalDataList then
      for i = (self._petPageIndex - 1) * PageCount + 1, self._petPageIndex * PageCount do
        if not self._petTotalDataList[i] then
          break
        end
        table.insert(curPageData, {
          guid = self._petTotalDataList[i].guid,
          pageType = self.pageType,
          callback = self._selectPetHandler
        })
      end
    end
  end
  self:initBoxInfo_expand()
  self.bind.list_pet_expand:clear()
  self.bind.list_pet_expand:insert_array(curPageData)
  self:setListSelect(self.selectDic)
end

function this:initBoxInfo_expand()
  self.bind.txt_boxName_expand = self._isPetBoxMode and L_PetStore:getPetBoxName(self._petBoxIndex) or L_WordsTpl:getValue("ui_moduleSelectPet")
  self.bind.txt_boxIndex_expand = self._isPetBoxMode and string.format("%02d", self._petBoxIndex) or ""
end

function this:refreshPageTabInfo(isInit)
  local totalPage, curPage
  if self._isPetBoxMode then
    totalPage = L_PetStore:getPetBoxNum()
    curPage = self._petBoxIndex
  else
    totalPage = self._petTotalDataList and math.ceil(#self._petTotalDataList / PageCount) or 1
    curPage = self._petPageIndex or 1
  end
  self._petTotalPageNum = totalPage
  local needShowTab = 1 < totalPage
  self.bind.go_changePageTab = needShowTab
  if needShowTab then
    self.bind.go_lastBtn = 1 < curPage
    self.bind.go_nextBtn = totalPage > curPage
    local modulePageTabSlider = self.modules.module_pageTabSlider
    if modulePageTabSlider then
      modulePageTabSlider:setPageIndex(curPage, totalPage)
    end
  end
end

function this:selectPet(cell)
  self:emit("onClick_selectPet", cell.bind.guid)
  if self._onSelectPetCallback then
    self._onSelectPetCallback(cell.bind.guid)
  end
  self.selPetID = cell.bind.guid
end

function this:moveToPage()
  if math.isEmpty(self._moveToId) then
    return
  end
  if self._isPetBoxMode then
    local petItem = L_PetStore:getPetItem(self._moveToId)
    if petItem then
      self._petBoxIndex = math.floor(petItem.box_id / 100)
    end
  elseif self._petTotalDataList then
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
    self:playShrinkVFX()
    return true
  end
end

function this:setListSelect(selectDic)
  self.selectDic = selectDic or {}
  for i, v in pairs(self.modules.list_pet_expand) do
    local cell = v
    local petParams = self.selectDic[cell.bind.guid]
    cell:setSelect((petParams and petParams.isSelect) == true)
    cell:setPosIndex(petParams and petParams.index)
  end
end

function this:playExpandVFX()
  if not self.isBind then
    return
  end
  if self._isPlayingVFX then
    return
  end
  self.bind.go_expand = true
  self._isExpand = true
  self._isPlayingVFX = true
  L_TimerManager:newOrResetTimer(self, "playExpandVFX", function()
    self._isPlayingVFX = false
    self:refreshContent()
    self:refreshAllSelect()
  end, 0.17)
end

function this:playShrinkVFX()
  if not self.isBind then
    return
  end
  if self._isPlayingVFX then
    return
  end
  self._isExpand = false
  self._isPlayingVFX = true
  L_TimerManager:newOrResetTimer(self, "playShrinkVFX", function()
    self._isPlayingVFX = false
    self.bind.go_expand = false
    self.bind.list_pet_expand:clear()
    if self._onShrinkCallback then
      self._onShrinkCallback()
    end
    self:emit("onShrinkComplete")
  end, 0.17)
end

function this:isExpand()
  return self._isExpand
end

function this:isPlayingVFX()
  return self._isPlayingVFX
end

function this:getPetBoxIndex()
  return self._petBoxIndex
end

function this:setOnBoxIndexChangeCallback(callback)
  self._onBoxIndexChangeCallback = callback
end

function this:refreshPetStatus()
  for i, v in ipairs(self.modules.list_pet_expand) do
    v:refreshView()
  end
end

function this:refreshAllSelect()
  for i, v in ipairs(self.modules.list_pet_expand) do
    local cell = v
    cell:refreshSelect()
  end
end

return this
