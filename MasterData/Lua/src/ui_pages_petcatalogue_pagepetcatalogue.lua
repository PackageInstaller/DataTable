local page = class("pagePetCatalogue", G_UIPageBase)
local petTpl = L_GameTpl:getPetTpl()
local wordsTpl = L_GameTpl:getWordsTpl()
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _systemFilterTpl = L_GameTpl:getSystemFilterTpl()

function page:ctor(...)
  page.super.ctor(self, ...)
  self.data = {
    curPageIdx = 0,
    totalPage = 0,
    maxPerPage = 21,
    listCatalogIdx = {},
    filterDirty = false,
    isAttrView = false
  }
  self.init = false
end

function page:created(obj, pageConfig)
  page.super.created(self, obj, pageConfig)
end

function page.bind()
  return {
    listCatalogBox = {
      moduleName = "pages/petCatalogue/cellPetCatalogBox"
    },
    listDotLine = {
      moduleName = "pages/Main/cellActivityPoint"
    },
    btnPreviewActive = false,
    btnNextActive = false,
    color_selectName = C_Color(1, 1, 1, 1),
    addSelectActive = false,
    noSelectActive = true,
    catalogMainActive = true,
    catalogAddActive = false,
    moduleAttrView = {
      moduleName = "pages/petCatalogue/moduleAttrView"
    },
    cellsize = C_Vector2(2080, 1028),
    activeBtnTaskReward = false
  }
end

function page.methods()
  return {
    onclickPrev = function(self)
      self.bindComponents.listCatalogBoxScroll:ScrollToCell(self.realIndex - 1, 3000)
      self.isManualSwitch = true
    end,
    onclickNext = function(self)
      self.bindComponents.listCatalogBoxScroll:ScrollToCell(self.realIndex + 1, 3000)
      self.isManualSwitch = true
    end,
    onSnapFinished = function(self, index)
      self.realIndex = index
      self.bindComponents.listCatalogBoxScroll:ScrollToCell(index, 3000)
      local tempIndex = self:_realSnapToItemIndex(index + 1)
      self:setPointListActive(tempIndex)
      self.data.curPageIdx = tempIndex
      self.bind.btnPreviewActive = self.data.curPageIdx ~= 1
      self.bind.btnNextActive = self.data.curPageIdx ~= self.data.totalPage
    end,
    onclickFilter = function(self)
      self:_onClickFilter()
    end,
    onclickBuffView = function(self)
      if self.data.isAttrView then
        self.data.isAttrView = false
      else
        self.data.isAttrView = true
      end
      self.bind.addSelectActive = self.data.isAttrView
      self.bind.noSelectActive = not self.data.isAttrView
      self.bind.color_selectName = self.data.isAttrView and C_Color(0.9058824, 0.9215686, 0.6666667, 1) or C_Color(1, 1, 1, 1)
      self:setAttrView(self.data.isAttrView)
      self.bindComponents.anim:Play("Anim_PetCatalogue_Click")
    end,
    onSwitchView = function(self)
      self:onClickSwitchView(not self.showMainView)
    end,
    onClickTaskReward = function(self)
      L_CatalogStore:tryGetReward()
    end
  }
end

function page:preOpen(options)
  self.showMainView = true
  self.bind.txtAllBuff = L_WordsTpl:getValue("notice_pagePetCatalogue_01")
  self.realIndex = 0
  self._filterKeyDic = nil
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ENextBox, function()
    self.bindComponents.listCatalogBoxScroll:ScrollToCell(self.realIndex + 1, 3000)
    self.isManualSwitch = true
  end)
  L_ShortCutManager:registerShortCut(self.pageName, C_InputManager_KeyType.ELastBox, function()
    self.bindComponents.listCatalogBoxScroll:ScrollToCell(self.realIndex - 1, 3000)
    self.isManualSwitch = true
  end)
  self.objPerRow = 7
  if C_ResolutionUtility.CheckSuperWidthScreen() then
    self.data.maxPerPage = 27
    self.objPerRow = 9
    self.bind.cellsize = C_Vector2(2740, 1028)
  else
    self.bind.cellsize = C_Vector2(2080, 1028)
  end
  if not L_DeviceTpl:getIsPc() then
    self.data.maxPerPage = 12
    self.objPerRow = 6
    self.bind.cellsize = C_Vector2(1850, 1028)
  end
  self.bindComponents.listCatalogBoxScroll:ScrollToCell(0, 3000)
end

function page:open()
end

function page:show()
  if not self.updateTimer then
    self.updateTimer = Timer.repeated(0.33, function()
      self:onScrollBox()
    end, self)
  end
  if not self.init then
    self:initCatalog()
    self.init = true
  else
    for i = 1, #self.bind.listCatalogBox do
      local box = self.bind.listCatalogBox:getItemCls(i)
      if box then
        box:refreshRedDot()
      end
    end
  end
  self:refreshRewardBtnActive()
  L_CatalogStore:listenCallFunc(L_CatalogStore.event.getCatalogReward, self.onEvent_getCatalogReward, self)
end

function page:hide()
  if self.updateTimer then
    Timer.remove(self.updateTimer)
    self.updateTimer = nil
  end
  L_CatalogStore:unListenCallFunc(L_CatalogStore.event.getCatalogReward, self.onEvent_getCatalogReward, self)
end

function page:close()
  self.init = false
  self._filterKeyDic = nil
  if self.updateTimer then
    Timer.remove(self.updateTimer)
    self.updateTimer = nil
  end
end

function page:update()
  if self.bind.catalogAddActive then
    self.modules.moduleAttrView:update()
  end
end

function page:initCatalog()
  table.clear(self.data.listCatalogIdx)
  for pid, tpl in pairs(petTpl.data) do
    if tpl.iconographyshow and tpl.iconographyshow == 1 then
      local tpl_sys = _systemUnlockTpl:getTplById(L_SystemConst.enum.petCatalog)
      local filterID = _systemUnlockTpl:getFilterConfig(tpl_sys)
      local tpl_sortFilter = _systemFilterTpl:getTplById(filterID)
      local filterConfig = _systemFilterTpl:getFilterConfig(tpl_sortFilter)
      local fId = filterConfig[1][1]
      if self._filterKeyDic and self._filterKeyDic[fId] then
        local elementType = self._filterKeyDic[fId][1] or 0
        local petType = petTpl:getFirstElement(tpl)
        if petType == elementType then
          table.insert(self.data.listCatalogIdx, pid)
        end
      else
        table.insert(self.data.listCatalogIdx, pid)
      end
    end
  end
  table.sort(self.data.listCatalogIdx, function(a, b)
    local aTpl = petTpl:getTplById(a)
    local bTpl = petTpl:getTplById(b)
    if aTpl.iconographyNum == bTpl.iconographyNum then
      return a < b
    end
    return aTpl.iconographyNum < bTpl.iconographyNum
  end)
  self.data.totalPage = math.ceil(#self.data.listCatalogIdx / self.data.maxPerPage)
  local temp = {}
  local tempBox = {}
  for i = 1, self.data.totalPage do
    table.insert(temp, {
      normal = i ~= 1,
      active = i == 1
    })
    table.insert(tempBox, {
      petList = self:_getPetByPage(i),
      onClickCb = function(cell)
        self:_onClickCatalog(cell)
      end,
      pageIdxBase = (i - 1) * self.data.maxPerPage,
      objPerRow = self.objPerRow
    })
  end
  self.bind.listDotLine:clear()
  self.bind.listDotLine:insert_array(temp)
  self.bind.listCatalogBox:clear()
  self.bind.listCatalogBox:insert_array(tempBox)
end

function page:setPointListActive(index)
  local temp = {}
  for i = 1, self.data.totalPage do
    table.insert(temp, {
      normal = i ~= index,
      active = i == index
    })
  end
  self.bind.listDotLine:freshAll(temp)
end

function page:setAttrView(isAttr)
  for i = 1, #self.bind.listCatalogBox do
    local box = self.bind.listCatalogBox:getItemCls(i)
    if box then
      box:setAttrView(isAttr)
    end
  end
end

function page:getIsAttrView()
  return self.data.isAttrView
end

function page:_onClickCatalog(cell)
  if cell.bind.petId then
    L_UI:open("pagePetCatalogDetail", {
      filter = self._filterKeyDic,
      petId = cell.bind.petId,
      catalogId = cell.bind.catalogId
    })
  end
end

function page:_realSnapToItemIndex(snapIndex)
  local index = snapIndex
  if index == 0 then
    index = self.data.totalPage
  else
    index = math.max(1, math.min(snapIndex, self.data.totalPage))
  end
  return index
end

function page:onScrollBox()
  if not self.isBind then
    return
  end
  local loopListViewRoot = self.bindComponents.listCatalogBoxScroll
  if loopListViewRoot == nil then
    return
  end
  local index = loopListViewRoot:GetSnapIndex()
  if index == nil then
    return
  end
  self.realIndex = index
  local snapIndex = index + 1
  local realBoxIndex = self:_realSnapToItemIndex(snapIndex)
  self:setPointListActive(realBoxIndex)
  self.data.curPageIdx = realBoxIndex
  self.bind.btnPreviewActive = self.data.curPageIdx ~= 1
  self.bind.btnNextActive = self.data.curPageIdx ~= self.data.totalPage
end

function page:_getPetByPage(i)
  local result = {}
  for j = 1, self.data.maxPerPage do
    if not self.data.listCatalogIdx[j + (i - 1) * self.data.maxPerPage] then
      break
    end
    table.insert(result, {
      petId = self.data.listCatalogIdx[j + (i - 1) * self.data.maxPerPage]
    })
  end
  return result
end

function page:_onClickFilter()
  local function callback(filterKeyDic)
    self._filterKeyDic = filterKeyDic
    
    self:_filterCallback(filterKeyDic)
    self.bindComponents.ani_btn_filter:SetBool("On", not table.isEmpty(self._filterKeyDic))
  end
  
  local param = {
    type = L_SortFilterConst.SortOrFilter.Filter,
    systemId = L_SystemConst.enum.petCatalog,
    callback = callback,
    selectValue = self._filterKeyDic
  }
  L_UI:open("pageMultiplySortFilter", param)
end

function page:_filterCallback(filterKeyDic)
  self:initCatalog()
  self.bind.moveToItemIndex = 0
end

function page:onClickSwitchView(isShowMainView)
  self.showMainView = isShowMainView
  self.bind.catalogMainActive = self.showMainView
  self.bind.catalogAddActive = not self.showMainView
  if not self.showMainView then
    self.bindComponents.switchBtnAnim:Play("Anim_PetCatalogue_change")
    self.modules.moduleAttrView:showView()
  else
    self.bindComponents.switchBtnAnim:Play("Anim_PetCatalogue_change_2")
    self.bindComponents.anim:Play("Anim_PetCatalogue_Click")
  end
end

function page:CheckCanFindTargetCellItem(guideSerializeId, guideParam)
  return true
end

function page:FindTargetCellItem(guideSerializeId, guideParam)
  if guideSerializeId == L_Const.GuideSerializeId.PetCatalogGuide then
    local snapIdex, itemIndex = self:findPetSnapIndex(guideParam)
    if snapIdex < 0 then
      return nil
    end
    local box = self.bind.listCatalogBox:getItemCls(snapIdex + 1)
    if box then
      return box:getItemByIndex(itemIndex)
    end
  elseif guideSerializeId == L_Const.GuideSerializeId.PetCatalogGuideChangePage then
    local snapIdex, itemIndex = self:findPetSnapIndex(guideParam)
    if snapIdex < 0 then
      return nil
    end
    self.bind.snapToItemIndex = snapIdex
  end
  return nil
end

function page:findPetSnapIndex(petTplId)
  for i = 1, self.data.totalPage do
    for j = 1, self.data.maxPerPage do
      local petId = self.data.listCatalogIdx[j + (i - 1) * self.data.maxPerPage]
      if not petId then
        break
      end
      if petId == petTplId then
        return i - 1, j - 1
      end
    end
  end
  return -1, 0
end

function page:refreshRewardBtnActive()
  self.bind.activeBtnTaskReward = L_CatalogStore:checkCanGetReward()
end

function page:onEvent_getCatalogReward()
  self:refreshRewardBtnActive()
end

return page
