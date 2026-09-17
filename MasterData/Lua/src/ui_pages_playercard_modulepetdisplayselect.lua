local this = class("modulePetDisplaySelect", G_UIModuleBase)
local PageCount = 30

function this.bind()
  return {
    txt_boxNum = "1",
    txt_boxName = "",
    list_pets = {
      moduleName = "pages/playerCard/cellPlayerCardPetPixelDisplay"
    },
    go_changePageTab = false,
    go_lastBtn = false,
    go_nextBtn = false,
    module_pageTabSlider = {
      moduleName = "modulePages/modulePageTabSlider"
    },
    module_sortFilter = L_Const.ModuleInfo.SortFilterModule
  }
end

function this.methods()
  return {
    onClick_filter = function(self)
    end,
    onClick_lastPage = function(self)
      self:changePageIndex(-1)
    end,
    onClick_nextPage = function(self)
      self:changePageIndex(1)
    end,
    list_pets = {
      onClick_selectCell = function(self, bind)
        self:emit("onClick_select", bind)
      end
    }
  }
end

function this:open()
  self:initSortFilterModule()
  self._petSortFilter:bindModule(self.modules.module_sortFilter)
  self:initPetList()
  self:refreshCurPageData()
  self:refreshPageTabInfo()
end

function this:initSortFilterModule()
  self._petSortFilter = L_SortFilterManager:createSortFilter(L_SystemConst.enum.petDisplay, function()
    self._petPageIndex = 1
    self:initPetList()
    self:refreshCurPageData()
  end, function()
    self._petPageIndex = 1
    self:initPetList()
    self:refreshCurPageData()
  end)
end

function this:initPetSlot()
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
        guid = pet.guid
      })
    end
    self._petSortFilter:sortFilterList(self._petTotalDataList)
  end
end

function this:changePageIndex(delta)
  if self._isPetBoxMode then
    self._petBoxIndex = math.clamp(self._petBoxIndex + delta, 1, L_PetStore:getPetBoxNum())
  else
    self._petPageIndex = math.clamp(self._petPageIndex + delta, 1, self._petTotalPageNum)
  end
  self:refreshCurPageData()
  self:refreshPageTabInfo()
end

function this:refreshCurPageData()
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
          callback = self._selectPetHandler,
          isActive_panelSel = true,
          isActive_panelNone = false
        })
      end
    end
    self._petSortFilter:filterList(temp)
    for i = 1, PageCount do
      table.insert(curPageData, {
        itemType = 0,
        itemId = 0,
        guid = 0,
        callback = nil,
        isActive_panelSel = true
      })
    end
    for i, cell in pairs(temp) do
      local pet = L_PetStore:getPetItem(cell.guid)
      curPageData[pet.box_id % 100] = cell
    end
  else
    self._petPageIndex = self._petPageIndex or 1
    for i = (self._petPageIndex - 1) * PageCount + 1, self._petPageIndex * PageCount do
      if not self._petTotalDataList[i] then
        break
      end
      table.insert(curPageData, {
        guid = self._petTotalDataList[i].guid,
        callback = self._selectPetHandler,
        isActive_panelSel = true,
        isActive_panelNone = false
      })
    end
  end
  self:refreshBoxInfo()
  if #self.bind.list_pets == #curPageData then
    for i, v in pairs(curPageData) do
      self.bind.list_pets:change(i, v)
    end
  else
    self.bind.list_pets:clear()
    self.bind.list_pets:insert_array(curPageData)
  end
  self:refreshSelectState(self.selectList)
end

function this:refreshBoxInfo()
  self.bind.txt_boxName = self._isPetBoxMode and L_PetStore:getPetBoxName(self._petBoxIndex) or L_WordsTpl:getValue("ui_moduleSelectPet")
  self.bind.txt_boxNum = self._isPetBoxMode and string.format("%02d", self._petBoxIndex) or ""
end

function this:refreshPageTabInfo()
  local totalPage, curPage
  if self._isPetBoxMode then
    totalPage = L_PetStore:getPetBoxNum()
    curPage = self._petBoxIndex
  else
    totalPage = math.ceil(#self._petTotalDataList / PageCount)
    curPage = self._petPageIndex
  end
  local needShowTab = 1 < totalPage
  self.bind.go_changePageTab = needShowTab
  if needShowTab then
    self.bind.go_lastBtn = 1 < curPage
    self.bind.go_nextBtn = totalPage > curPage
    local modulePageTabSlider = self.modules.module_pageTabSlider
    modulePageTabSlider:setPageIndex(curPage, totalPage)
  end
end

function this:refreshSelectState(guidList)
  if guidList == nil then
    guidList = {}
  end
  self.selectList = guidList
  if self.bind.guid == -1 then
    return
  end
  for _, v in pairs(self.modules.list_pets) do
    local index = table.indexOf(guidList, v.bind.guid)
    if index ~= false then
      v:setSelect(true, index)
    else
      v:setSelect(false)
    end
  end
end

return this
