local PETSCENEPATH = "Program/UIScene/petCatalogScene.prefab"
local page = class("pagePetCatalogDetail", G_UIPageBase)
local PageCount = 30
local isPc = L_DeviceTpl:getIsPc()
local isMobile = L_DeviceTpl:getIsMobile()
local petTpl = L_GameTpl:getPetTpl()

function page:ctor(...)
  page.super.ctor(self, ...)
  self.data = {
    listCatalog = {},
    curListIdx = nil
  }
end

function page:created(obj, pageConfig)
  page.super.created(self, obj, pageConfig)
end

function page.bind()
  return {
    toggleSwitch = true,
    tempListBox = {
      moduleName = "pages/petCatalogue/cellCatalogPet"
    },
    pos_tempListBox = C_Vector2.zero,
    catalogInfoActive = true,
    moduleCatalogInfo = {
      moduleName = "pages/petCatalogue/modulePetCatalogDetail"
    },
    mapInfoActive = false,
    moduleMapInfo = {
      moduleName = "pages/petCatalogue/modulePetCatalogMap"
    },
    list_pet_expand = {
      moduleName = "pages/petCatalogue/cellPetCatalogDetailBox"
    },
    bottomActive = true,
    obj_Expend = false,
    obj_tempListBox = true,
    obj_expentBtn = true,
    obj_btn_shrink = false,
    go_changePageTab = false,
    go_lastBtn = false,
    go_nextBtn = false,
    listDotLine = {
      moduleName = "pages/Main/cellActivityPoint"
    },
    activeBtnTaskReward = false
  }
end

function page.methods()
  return {
    onClick_information = function(self)
      if not self.isMap then
        return
      end
      self.bind.toggleSwitch = false
      self:refreshCatalogInfoActive(true)
      self.bind.mapInfoActive = false
      self.bind.obj_Expend = false
      self.isMap = false
      self:ShowPetById()
    end,
    onClick_map = function(self)
      if not self:getUnlockHabitat(self.currShowPetId) then
        return
      end
      if self.isMap then
        return
      end
      self:refreshCatalogInfoActive(false)
      self.bind.mapInfoActive = true
      self.bind.obj_Expend = false
      self.isMap = true
      self.modules.moduleMapInfo:isJumpAction()
      self:ShowPetById()
      self.modules.moduleCatalogInfo:CloseFlash(false)
    end,
    onClickFilter = function(self)
      self:_onClickFilter()
    end,
    onClickExpand = function(self)
      self:refreshCatalogInfoActive(false)
      self.isExpend = true
      self.bind.obj_Expend = true
      self.bind.obj_btn_shrink = true
      self.bind.obj_tempListBox = false
      self.bind.obj_expentBtn = false
      self:initCatalogBox()
      self:refreshPageTabInfo()
    end,
    onCloseExpand = function(self)
      self:onCloseExpand()
    end,
    onClick_lastPage = function(self)
      self:changePageIndex(-1)
    end,
    onClick_nextPage = function(self)
      self:changePageIndex(1)
    end,
    onCloseExpand_Bg = function(self)
      self:onCloseExpand()
    end,
    onClickTaskReward = function(self)
      L_CatalogStore:tryGetReward()
    end
  }
end

function page:onCloseExpand()
  self.isExpend = false
  self:refreshCatalogInfoActive(true)
  self.bind.obj_Expend = false
  self.bind.obj_btn_shrink = false
  self.bind.obj_tempListBox = true
  self.bind.obj_expentBtn = true
  self:initCatalog(false)
  self:setSelect(self.data.curListIdx, true)
  self:_stopExpandScrollPoll()
end

function page:setExpendPetIdWhitPage()
  local _index
  local flag = false
  local curPetId = self.currShowPetId
  for i = 1, #self.petDatas do
    for j = 1, #self.petDatas[i] do
      if self.petDatas[i][j].petId == curPetId then
        _index = i
        flag = true
        break
      end
    end
    if flag then
      break
    end
  end
  self._petBoxIndex = _index
end

function page:refreshCurPagePet_expand()
  self._petBoxIndex = self._petBoxIndex or 1
  if self.petDatas[self._petBoxIndex] == nil then
    self._petBoxIndex = 1
  end
  local temp = {}
  for i = 1, #self.petDatas do
    table.insert(temp, {
      normal = i ~= self._petBoxIndex,
      active = i == self._petBoxIndex
    })
  end
  self.bind.listDotLine:freshAll(temp)
end

function page:initCatalogBox()
  local curPetId = self.currShowPetId
  local tempBox = {}
  local foundPageIndex
  for i = 1, #self.petDatas do
    local hasCurPet = false
    for j = 1, #self.petDatas[i] do
      if self.petDatas[i][j].petId == curPetId then
        hasCurPet = true
        break
      end
    end
    if hasCurPet then
      foundPageIndex = i
    end
    table.insert(tempBox, {
      petList = self.petDatas[i],
      onClickCb = function(cell)
        self:_onClickCatalog(cell)
      end,
      curPetId = curPetId
    })
  end
  self._petBoxIndex = foundPageIndex or 1
  self.bind.list_pet_expand:clear()
  self.bind.list_pet_expand:insert_array(tempBox)
  self:refreshCurPagePet_expand()
  local scroll = self.bindComponents.listCatalogBoxScroll
  if scroll then
    scroll:FocusItemIndex(self._petBoxIndex - 1, true)
  end
  self:_startExpandScrollPoll()
  self:changePetExpandSelect()
end

function page:_startExpandScrollPoll()
  if self._expandScrollTimer then
    return
  end
  self._expandScrollTimer = Timer.repeated(0.33, function()
    if not self.isBind or not self.isExpend then
      return
    end
    local scroll = self.bindComponents.listCatalogBoxScroll
    if not scroll then
      return
    end
    local index = scroll:GetSnapIndex()
    if index and 0 <= index then
      local newPageIndex = index + 1
      if newPageIndex ~= self._petBoxIndex then
        self._petBoxIndex = newPageIndex
        self:refreshCurPagePet_expand()
        self:refreshPageTabInfo()
      end
    end
  end, self)
end

function page:_stopExpandScrollPoll()
  if self._expandScrollTimer then
    Timer.remove(self._expandScrollTimer)
    self._expandScrollTimer = nil
  end
end

function page:changePageIndex(delta)
  self._petBoxIndex = math.clamp(self._petBoxIndex + delta, 1, #self.petDatas)
  self:refreshPageTabInfo()
  self.bindComponents.listCatalogBoxScroll:ScrollToCell(self._petBoxIndex - 1, 3000)
end

function page:changePetExpandSelect()
  if self.isExpend then
    for i = 1, #self.bind.list_pet_expand do
      local box = self.bind.list_pet_expand:getItemCls(i)
      if box then
        box:refreshSelection(self.currShowPetId)
      end
    end
  end
end

function page:refreshPageTabInfo(isInit)
  local totalPage, curPage
  totalPage = #self.petDatas
  curPage = self._petBoxIndex
  local needShowTab = 1 < totalPage
  self.bind.go_changePageTab = needShowTab
  if needShowTab then
    self.bind.go_lastBtn = 1 < curPage
    self.bind.go_nextBtn = totalPage > curPage
  end
end

function page:preOpen(options)
  self.originTime = C_RealWeather.GetTimeOfDay()
  self.originTimeTick = C_RealWeather.GetTimeTick()
  self._filterKeyDic = options.filter
  self._cacheOption = options
  C_CameraManager.SetBrainBlendStyle(L_Const.blendStyle.cut)
  local brain = C_CameraManager.GetMainCameraBrain()
  brain.m_CustomBlends = nil
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PetCatalogDetail)
end

function page:initPage()
  self.pageInited = true
  local options = self._cacheOption
  self:initCatalog()
  self.currShowPetId = options.petId
  L_GameUtil.forceRebuildLayout(self.bindComponents.ContentTrans)
  L_GameUtil.forceRebuildLayout(self.bindComponents.scrollRectTrans)
  self:SetCatalogContentTrans(options.catalogId)
  self:setSelect(options.catalogId, nil, true)
  self:refreshCatalogInfoActive(true)
  self.bind.mapInfoActive = false
  self.bind.obj_Expend = false
  C_RealWeather.SetTime(1650)
  C_RealWeather.SetTimeTick(0)
end

function page:onPetLoaded()
  self.bindComponents.blackMask.gameObject:ActiveTrans(false)
  if not self.animInitialed then
    self.bindComponents.anim:Stop()
    self.bindComponents.anim:Play("Anim_PetCatalogDetail_In")
    self.animInitialed = true
  end
end

function page:closeFrameTimer()
  if self.frameTimerId then
    FrameScheduler.remove(self.frameTimerId)
  end
end

function page:SetCatalogContentTrans(catalogId)
  self:closeFrameTimer()
  self.frameTimerId = FrameScheduler.add(function()
    local maxJumpIndex = #self.data.listCatalog - self:getMaxShowCount()
    self.bindComponents.scrollRectPetCatalog.velocity = C_Vector2.zero
    if maxJumpIndex < catalogId then
      self.bindComponents.scrollRect.horizontalNormalizedPosition = 1
    else
      self.bindComponents.scrollRect:FocusItemIndex(catalogId - 1)
    end
  end)
end

function page:getMaxShowCount()
  local viewPortWidth = self.bindComponents.viewportTsf.rect.width
  return math.floor(viewPortWidth / 207)
end

function page:open()
  self.animInitialed = nil
  if self.sceneGo == nil and self.sceneLoadHandle == nil then
    self.sceneLoadHandle = L_ResPool:asyncGameObject(PETSCENEPATH, function(id, go)
      self.sceneGo = go
      self.sceneGo.transform:SetParent(C_LuaUtility.GetRootNode())
      L_Vector3.setPos(self.sceneGo.transform, C_UIMgr.SceneLoadDefaultPosition)
      self.modules.moduleCatalogInfo:setSceneGo(go)
      self:initPage()
    end)
  end
end

function page:show()
  if self.pageInited ~= nil and self.currShowPetId and self.scenego ~= nil then
    self:ShowPetById()
  end
  C_UISceneManager.SetSceneVisible()
  C_UISceneManager.SetUISceneEntryType(C_EUISceneType.PetCatalogDetail)
  if L_CommonUtil.isValid(self.sceneGo) then
    self.sceneGo:SetActive(true)
  end
  self:refreshRewardBtnActive()
  L_CatalogStore:listenCallFunc(L_CatalogStore.event.getCatalogReward, self.onEvent_getCatalogReward, self)
end

function page:hide()
  if L_CommonUtil.isValid(self.sceneGo) then
    self.sceneGo:SetActive(false)
  end
  L_CatalogStore:unListenCallFunc(L_CatalogStore.event.getCatalogReward, self.onEvent_getCatalogReward, self)
end

function page:close()
  if self.sceneLoadHandle then
    L_ResPool:destroyGo(self.sceneLoadHandle)
    self.sceneLoadHandle = nil
  end
  self.modules.moduleCatalogInfo:removePet()
  if self.openTimer then
    Timer.remove(self.openTimer)
    self.openTimer = nil
  end
  if self.frameTaskId then
    FrameScheduler.remove(self.frameTaskId)
    self.frameTaskId = nil
  end
  self._filterKeyDic = nil
  if L_CommonUtil.isValid(self.sceneGo) then
    C_GameObject.Destroy(self.sceneGo)
  end
  C_UISceneManager.SetSceneVisible()
  C_RealWeather.SetTime(self.originTime)
  C_RealWeather.SetTimeTick(self.originTimeTick)
  self:closeFrameTimer()
  self:_stopExpandScrollPoll()
end

function page:onTopChange(options)
  if C_DeviceGradeHelper.IsLowMemoryDevice() or not C_AppConfigManager.IsPcPlatformForUI then
    if options.topLv == 0 and 0 < options.lastTopLv and self.topStateDirty then
      self.sceneLoadHandle = L_ResPool:asyncGameObject(PETSCENEPATH, function(id, go)
        self.sceneGo = go
        self.sceneGo.transform:SetParent(C_LuaUtility.GetRootNode())
        L_Vector3.setPos(self.sceneGo.transform, C_UIMgr.SceneLoadDefaultPosition)
        C_UIMgr.CloseCutin()
        self.modules.moduleCatalogInfo:setSceneGo(go)
        if self.pageInited ~= nil and self.currShowPetId then
          self:ShowPetById(true)
        end
        self.modules.moduleCatalogInfo:setSceneBind()
      end)
      self.topStateDirty = false
    elseif options.topLv == 1 and options.lastTopLv < 1 then
      if self.sceneLoadHandle then
        L_ResPool:destroyGo(self.sceneLoadHandle)
        self.sceneLoadHandle = nil
      end
      if L_CommonUtil.isValid(self.sceneGo) then
        C_GameObject.Destroy(self.sceneGo)
        self.sceneGo = nil
      end
      if self.csharpPage then
        self.csharpPage.needCutback = true
      end
      self.modules.moduleCatalogInfo:removePet()
      self.modules.moduleCatalogInfo:setSceneGo(nil)
      self.topStateDirty = true
    end
  end
end

function page:initCatalog(resetList)
  table.clear(self.data.listCatalog)
  for pid, pConfig in pairs(petTpl.data) do
    if pConfig.iconographyshow and pConfig.iconographyshow == 1 then
      if self._filterKeyDic and self._filterKeyDic[18] then
        local elementType = self._filterKeyDic[18][1] or 0
        local petType = petTpl:getFirstElement(pConfig)
        if petType == elementType then
          table.insert(self.data.listCatalog, {
            petId = pid,
            onClickCb = function(cell)
              self:_onClickCatalog(cell)
            end
          })
        end
      else
        table.insert(self.data.listCatalog, {
          petId = pid,
          onClickCb = function(cell)
            self:_onClickCatalog(cell)
          end
        })
      end
    end
  end
  table.sort(self.data.listCatalog, function(a, b)
    local aTpl = petTpl:getTplById(a.petId)
    local bTpl = petTpl:getTplById(b.petId)
    if aTpl.iconographyNum == bTpl.iconographyNum then
      return a.petId < b.petId
    end
    return aTpl.iconographyNum < bTpl.iconographyNum
  end)
  for i = 1, #self.data.listCatalog do
    self.data.listCatalog[i].idx = i
  end
  self:OnPetDataTabelSet()
  self:refreshCurPagePet_expand()
  self:refreshPageTabInfo()
  if resetList == nil then
    resetList = true
  end
  if resetList then
    self.bind.tempListBox:clear()
    self.bind.tempListBox:insert_array(self.data.listCatalog)
    self.bind.pos_tempListBox = C_Vector2.zero
  end
end

function page:OnPetDataTabelSet()
  self.petDatas = {}
  local index = 0
  local arrIndex = 1
  self.petDatas[arrIndex] = {}
  for k, v in pairs(self.data.listCatalog) do
    index = index + 1
    table.insert(self.petDatas[arrIndex], v)
    if index == 24 then
      index = 0
      arrIndex = arrIndex + 1
      self.petDatas[arrIndex] = {}
    end
  end
end

function page:refreshTaskRedDot()
  local cell = self.bind.tempListBox:getItemCls(self.data.curListIdx)
  if cell then
    cell:refreshRedDot()
  end
end

function page:_onClickCatalog(cell)
  if cell and cell.bind.idx then
    self:setSelect(cell.bind.idx)
    self:setExpendPetIdWhitPage()
    if self.isExpend then
      self:SetCatalogContentTrans(cell.bind.idx)
      self:onCloseExpand()
    end
  end
end

function page:setSelect(idx, force, noVX)
  if not idx then
    error("PetCatalog: select index is nil")
    return
  end
  if self.data.curListIdx and self.data.curListIdx == idx and not force then
    return
  end
  if self.data.curListIdx and self.data.curListIdx > 0 then
    local oldSelectCell = self.bind.tempListBox:getItemCls(self.data.curListIdx)
    if oldSelectCell then
      oldSelectCell:setSelect(false)
    else
      self.bindComponents.ContentTrans.localPosition = L_Vector3.new(0, self.bindComponents.ContentTrans.localPosition.y, 0)
    end
  end
  local newSelectCell = self.bind.tempListBox:getItemCls(idx)
  if newSelectCell then
    newSelectCell:setSelect(true)
  end
  self.data.curListIdx = idx
  self.currShowPetId = newSelectCell.bind.petId
  self:ShowPetById(noVX)
end

function page:ShowPetById(noVX)
  if self.isMap and self:getUnlockHabitat(self.currShowPetId) then
    self:showMap(noVX)
    self.bind.toggleSwitch = false
  else
    self.modules.moduleMapInfo:hideMapChangeVx()
    self:showInfo()
    self:setBlur(false)
    self.bind.toggleSwitch = true
    self.bindComponents.anim:Stop()
    self.bindComponents.anim:Play("Anim_PetCatalogDetail_switch")
  end
end

function page:getUnlockHabitat(petId, blockNotice)
  local petCatalogData = L_CatalogStore:getPetCatalogByPetId(petId) or {}
  local taskLevel = petCatalogData.lv or 1
  if taskLevel < L_GameTpl:getGameConstTpl():getData("ICONOGRAPHYLEVEL_UNLOCK_HABITAT", L_Const.GameTplType.int) and not blockNotice then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_habitat_01"))
  end
  return taskLevel >= L_GameTpl:getGameConstTpl():getData("ICONOGRAPHYLEVEL_UNLOCK_HABITAT", L_Const.GameTplType.int)
end

function page:getScreenOffsetMinY()
  local rectTransform = self.bindComponents.screenOffsetMinY
  local position = rectTransform.position
  local sizeDelta = rectTransform.sizeDelta
  local screenPosition = C_CameraManager.uiCamera:WorldToScreenPoint(L_Vector3.new(position.x, position.y, position.z))
  local minY = screenPosition.y + sizeDelta.y / 2
  return minY
end

function page:showMap(noVX)
  self:refreshCatalogInfoActive(false)
  self.bind.mapInfoActive = true
  self.isMap = true
  self.modules.moduleMapInfo:initMap()
  local areaId = AzurWorld.areaManager:GetMapAreaId()
  self.modules.moduleMapInfo:setArea(areaId, noVX)
  self.modules.moduleMapInfo:showPet(self.currShowPetId)
  self.modules.moduleMapInfo.modules.moduleMap:setScreenOffsetMinY(self:getScreenOffsetMinY())
end

function page:showInfo()
  if not self.isExpend then
    self:refreshCatalogInfoActive(true)
    self.bind.mapInfoActive = false
  end
  self.isMap = false
  self.modules.moduleCatalogInfo:showPet(self.currShowPetId, true)
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
  self:setSelect(1, true)
  if self.isExpend then
    self:initCatalogBox()
  end
end

function page:setBlur(isBlur)
  if self._blurTimer then
    Timer.remove(self._blurTimer)
    self._blurTimer = nil
  end
  if isBlur then
    C_LBlurStack.ClearRenderTexturByInstanceId(self.gameObject:GetInstanceID())
    self._blurTimer = Timer.once(0.15, function()
      if self.bind.mapInfoActive then
        self._blurTimer = nil
        self.bindComponents.blur.enabled = true
      end
    end)
  else
    self.bindComponents.blur.enabled = false
  end
end

function page:refreshCatalogInfoActive(active)
  self.bind.catalogInfoActive = active
  self:refreshRewardBtnActive()
end

function page:refreshRewardBtnActive()
  self.bind.activeBtnTaskReward = self.bind.catalogInfoActive and L_CatalogStore:checkCanGetReward()
end

function page:onEvent_getCatalogReward()
  self:refreshRewardBtnActive()
end

return page
