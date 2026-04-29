_class("UISeasonMazeTeamChangeController", UIController)
UISeasonMazeTeamChangeController = UISeasonMazeTeamChangeController

function UISeasonMazeTeamChangeController:Constructor()
  self._itemCountPerRow = 6
  self._listShowItemCount = 0
  self._firstIn = true
  self._btnCount = 3
  self.items = {}
  self._dicItems = {}
  self._atlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self._elementSortTypeOrder = {
    [1] = PetSortType.WaterFirst,
    [2] = PetSortType.FireFirst,
    [3] = PetSortType.SenFirst,
    [4] = PetSortType.ElectricityFirst,
    [5] = PetSortType.NoneElementFirst
  }
  self._sortFilterActiveStatus = false
  self._currentElementSortTypeOrder = 0
end

function UISeasonMazeTeamChangeController:GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseUITeamsMemberSelect()
  end, nil)
  self._sortBtns = self:GetUIComponent("UISelectObjectPath", "sortBtns")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._curSortStateIcon = self:GetUIComponent("Image", "btnFiltrate")
  self._emptyDataTip = self:GetGameObject("EmptyTip")
  self._seasonTipsText = self:GetUIComponent("UILocalizationText", "SeasonTipsText")
  self._seasonGo = self:GetGameObject("Season")
  self._root = self:GetGameObject("root")
  self._emptyDataTip:SetActive(false)
  self._sortFilterLoader = self:GetUIComponent("UISelectObjectPath", "sortFilter")
  self._clearFilterBtn = self:GetGameObject("clearFilterBtn")
  self._clearFilterBtn:SetActive(false)
  self._clearFilterBtnTrans = self:GetUIComponent("RectTransform", "clearFilterBtn")
  self._topRightTrans = self:GetUIComponent("RectTransform", "TopRightAnchor")
  self._rtFastTeam = self:GetUIComponent("RectTransform", "FastTeam")
  self._cancelBtn = self:GetGameObject("CancelBtn")
  self._cancelBtnIcon = self:GetUIComponent("Image", "CancelBtn")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelBtn), UIEvent.Press, function()
    self._cancelBtnIcon.color = Color(1.0, 1.0, 1.0, 0.5)
    self:CancelBtnOnPress()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelBtn), UIEvent.Release, function()
    self._cancelBtnIcon.color = Color(1.0, 1.0, 1.0, 1)
    self:CancelBtnOnRelease()
  end)
end

function UISeasonMazeTeamChangeController:OnValue()
  self:SetClearBtnStatus()
  self:InitTopBtns()
  self:CalcPetScrollViewCount()
  self:_InitSrollView()
  self._firstIn = false
  self:FastTeamLayout()
end

function UISeasonMazeTeamChangeController:FastTeamLayout()
  self._rtFastTeam.gameObject:SetActive(self.ctx:IsFastSelect())
  if self.ctx:IsFastSelect() then
    local transform = self._scrollRect.transform
    local offsetMin = transform.offsetMin
    local offsetMax = transform.offsetMax
    local anchoredPosition = transform.anchoredPosition
    offsetMin.y = offsetMin.y + 100
    anchoredPosition.y = anchoredPosition.y + 50
    transform.anchoredPosition = anchoredPosition
    transform.offsetMin = offsetMin
    transform.offsetMax = offsetMax
    local transform = self._scrollRect.verticalScrollbar.transform
    local offsetMin = transform.offsetMin
    local offsetMax = transform.offsetMax
    local anchoredPosition = transform.anchoredPosition
    offsetMin.y = offsetMin.y + 100
    anchoredPosition.y = anchoredPosition.y + 50
    transform.anchoredPosition = anchoredPosition
    transform.offsetMin = offsetMin
    transform.offsetMax = offsetMax
  end
end

function UISeasonMazeTeamChangeController:NormalBranch()
  self._sortType = PetSortType.Level
  self._sortOrder = PetSortOrder.Descending
  self._slot = self.ctx.curSlot
  self._add = false
  local teams = self.ctx:Teams()
  local team = teams.list[self.ctx:GetCurrTeamId()]
  self._team = team:Clone()
  if self._openList then
    self._add = true
    if self._openPet then
      self._add = false
    end
  elseif self.ctx:IsFastSelect() then
    self._add = true
  elseif self._team.pets[self._slot] == 0 then
    self._add = true
  end
  local sortFilterCfg = UISortFilterCfg.SeasonMazeTeam
  self._filterParams = {}
  local sortCfg = {}
  for idx, value in ipairs(sortFilterCfg.Sort) do
    sortCfg[idx] = Cfg.cfg_client_pet_sort[value]
  end
  local filterCfg = {}
  for tag, filters in pairs(sortFilterCfg.Filter) do
    local cfgs = {}
    for idx, value in ipairs(filters) do
      cfgs[idx] = Cfg.cfg_client_pet_filter[value]
    end
    filterCfg[tag] = cfgs
  end
  self._sortCfg = sortCfg
  self._filterCfg = filterCfg
  local sortParams = PetDefaulSort[self._sortType][self._sortOrder]
  if self.ctx.teamOpenerType == TeamOpenerType.SeasonMaze then
    sortParams = {}
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    local curRoomType = SMazeAdaptor.GetCurRoomType()
    local isMining = curRoomType == SeasonMazeRoomType.SMRT_Ore
    if isMining then
      table.insert(sortParams, 1, PetSortParam:New(PetSortType.SMazeInTeam, PetSortOrder.Ascending, self._team.pets))
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.SMazeDispatch, PetSortOrder.Descending))
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.SMazeDie, PetSortOrder.Descending))
  end
  self:SetElementSortDefaultParam()
  if self._petModule._sortParam ~= nil then
    sortParams = self._petModule._sortParam
  end
  local savedMemID = self._pstidTab
  local savedSortParams = sortParams
  if self.ctx:IsFastSelect() then
    sortParams = {}
    table.insert(sortParams, PetSortParam:New(PetSortType.FastTeam, PetSortOrder.Descending))
    for i = 1, #savedSortParams do
      table.insert(sortParams, savedSortParams[i])
    end
    local teamLookup = self:FastSelectMemID(savedMemID)
    sortParams[1]:SetParams(teamLookup)
  end
  self._pets = self._petModule:_SortPets(self._allPets, self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  self._pstidTab = {}
  if not self._add then
    local tabItem = {}
    if self._openPet then
      tabItem.pstid = self._openPet:GetPstID()
    else
      tabItem.pstid = self._team.pets[self._slot]
    end
    tabItem.del = true
    table.insert(self._pstidTab, tabItem)
  end
  local teamLookup = {}
  if self._openList then
    teamLookup = {}
    if self._openPet then
      teamLookup[self._openPet:GetPstID()] = self._openPet:GetPstID()
    end
  else
    for i = 1, #self._team.pets do
      local pstid = self._team.pets[i]
      teamLookup[pstid] = pstid
    end
  end
  if self.ctx:IsFastSelect() then
    teamLookup = {}
  end
  for i = 1, #self._pets do
    local pet = self._pets[i]
    local pstid = pet:GetPstID()
    if teamLookup[pstid] == nil then
      local tabItem = {}
      tabItem.pstid = pstid
      tabItem.del = false
      table.insert(self._pstidTab, tabItem)
    end
  end
  if self.ctx:IsFastSelect() then
    self:FastSelectMemID(savedMemID)
  end
end

function UISeasonMazeTeamChangeController:OnShow(uiParams)
  self._petModule = self:GetModule(PetModule)
  self._uiSeasonMazeModule = self:GetUIModule(SeasonMazeModule)
  self._missionModule = self:GetModule(MissionModule)
  self.ctx = self._missionModule:TeamCtx()
  self._openList = uiParams[1]
  if self._openList then
    self._allPets = self._openList
  else
    self._allPets = self._uiSeasonMazeModule:GetSeasonMazePets()
  end
  self._clickCb = uiParams[2]
  self._openPet = uiParams[3]
  self:GetComponents()
  self:NormalBranch()
  self:OnValue()
  self:AttacEvents()
end

function UISeasonMazeTeamChangeController:AttacEvents()
  self:AttachEvent(GameEventType.PetUpLevelEvent, self.RefrenshPetList)
  self:AttachEvent(GameEventType.PetUpGradeEvent, self.RefrenshPetList)
end

function UISeasonMazeTeamChangeController:InitTopBtns()
  self:SetClearBtnStatus()
  self._currSortIndex = 0
  if self._petModule.PetSortElementIndex ~= 0 then
    self._currentElementSortTypeOrder = self._petModule.PetSortElementIndex
  end
  self._sortBtns:SpawnObjects("UITopSortBtnItem", self._btnCount)
  self._sortBtnsPool = self._sortBtns:GetAllSpawnList()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:SetData(i, self._sortCfg[i], self._sortType, self._sortOrder, function(idx)
      self:ChangeSortParams(idx)
    end, self._currentElementSortTypeOrder)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._topRightTrans)
  local topBtnsWidth = self._topRightTrans.rect.width
  local targetPos = Vector2(-topBtnsWidth - 100, self._clearFilterBtn.transform.localPosition.y)
  self._clearFilterBtn.transform.localPosition = targetPos
end

function UISeasonMazeTeamChangeController:ChangeSortParams(idx)
  local tp = self._sortCfg[idx].Type
  if self._sortType == tp then
    if self._sortOrder == PetSortOrder.Ascending then
      self._sortOrder = PetSortOrder.Descending
    elseif self._sortOrder == PetSortOrder.Descending then
      self._sortOrder = PetSortOrder.Ascending
    end
  else
    self._sortType = tp
    self._sortOrder = PetSortOrder.Descending
  end
  self:FlushTopBtnState()
  self:RefrenshPetList()
end

function UISeasonMazeTeamChangeController:FlushTopBtnState()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:Flush(self._sortType, self._sortOrder, self._petModule.PetSortElementIndex)
  end
end

function UISeasonMazeTeamChangeController:_InitSrollView()
  self._scrollView:InitListView(self._listShowItemCount, function(scrollView, index)
    return self:InitSpritListInfo(scrollView, index)
  end, self:GetScrollViewParam())
end

function UISeasonMazeTeamChangeController:GetScrollViewParam()
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 333
  return param
end

function UISeasonMazeTeamChangeController:InitSpritListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISeasonMazeTeamChangeItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._petCount then
      heartItem:GetGameObject():SetActive(false)
    else
      self:ShowHeartItem(heartItem, itemIndex)
    end
  end
  return item
end

function UISeasonMazeTeamChangeController:NormalShowHeartClick(pstid, del)
  self._isBinderData = nil
  local pets = {}
  for i = 1, #self._team.pets do
    table.insert(pets, self._team.pets[i])
  end
  if del then
    if pets[self._slot] ~= 0 then
      pets[self._slot] = 0
    else
      self:CloseUITeamsMemberSelect()
      return
    end
  else
    pets = self:SetTeamData(pets, pstid)
  end
  local pet = self:GetPetByPstID(pstid)
  local petresid = 0
  if pet then
    petresid = pet:GetTemplateID()
  end
  self:Lock("UISeasonMazeTeamChangeController")
  self:StartTask(self._OnChangeTeam, self, petresid, del, pets)
end

function UISeasonMazeTeamChangeController:SetTeamData(pets, pstid)
  for i = 1, #pets do
    if pets[i] == pstid then
      pets[i] = 0
    elseif pets[i] == 0 then
    else
      local isBinderPet, petaName, petbName = self:IsBinderPet(pets[i], pstid)
      if isBinderPet then
        pets[i] = 0
        self._isBinderData = {}
        self._isBinderData.peta = petaName
        self._isBinderData.petb = petbName
      end
    end
  end
  pets[self._slot] = pstid
  return pets
end

function UISeasonMazeTeamChangeController:IsBinderPet(pstid_old, pstid_new)
  if pstid_old and pstid_new then
    local pet_old = self:GetPetByPstID(pstid_old)
    local pet_new = self:GetPetByPstID(pstid_new)
    local tid_old = pet_old:GetTemplateID()
    local tid_new = pet_new:GetTemplateID()
    return self:CheckBinderID(tid_old, tid_new), pet_old:GetPetName(), pet_new:GetPetName()
  end
end

function UISeasonMazeTeamChangeController:CheckAvailablePetCount()
  local count = 0
  for petId, v in pairs(self._allPets) do
    local isWorking = self._uiSeasonMazeModule:GetPetState(petId, ESeasonMazePetStateType.ESeasonMazePetStateType_Dispatch)
    local isDie = self._uiSeasonMazeModule:GetPetState(petId, ESeasonMazePetStateType.ESeasonMazePetStateType_Dead)
    if not isWorking and not isDie then
      count = count + 1
    end
  end
  return count
end

function UISeasonMazeTeamChangeController:CheckBinderID(tida, tidb)
  if tida == tidb then
    return true
  end
  local cfg = Cfg.cfg_pet({})
  if cfg then
    local cfga = cfg[tida]
    local cfgb = cfg[tidb]
    if not cfga then
      Log.error("###[UISeasonMazeTeamChangeController] cfga is nil ! id --> ", tida)
      return
    end
    if not cfgb then
      Log.error("###[UISeasonMazeTeamChangeController] cfgb is nil ! id --> ", tidb)
      return
    end
    if cfga.BinderPetID and cfgb.BinderPetID and cfga.BinderPetID == cfgb.BinderPetID then
      return true
    end
  end
end

function UISeasonMazeTeamChangeController:NormalShowHeartLongPress(pstid, btnListener)
  local pet = self:GetPetByPstID(pstid)
  if pet then
    local petModule = self:GetModule(PetModule)
    petModule.uiModule:SetTeamCustomPets({pet})
    local petid = pet:GetTemplateID()
    self:ShowDialog("UISpiritDetailGroupController", petid, false, nil, nil, true)
    return true
  end
  return false
end

function UISeasonMazeTeamChangeController:OnRootActiveChange(flag)
  if flag then
    for k, v in pairs(self._dicItems) do
      if v:GetGameObject().activeSelf then
        v:RevertButton()
      end
    end
  end
end

function UISeasonMazeTeamChangeController:ShowHeartItem(heartItem, index)
  local tabItem = self._pstidTab[index]
  heartItem:GetGameObject():SetActive(true)
  table.insert(self.items, heartItem)
  self._dicItems[heartItem:GetGameObject():GetInstanceID()] = heartItem
  local teamType = self.ctx.teamOpenerType
  local fastClickItem = heartItem
  heartItem:SetData(tabItem, function(pstid, del, helppetstate, slot)
    if self.ctx:IsFastSelect() then
      self:FastSelectHeartClick(fastClickItem, pstid, del, helppetstate, slot)
    elseif self._clickCb then
      self._clickCb(pstid, del)
      self:CloseDialog()
    else
      self:NormalShowHeartClick(pstid, del)
    end
  end, function(pstid, btnListener)
    return self:NormalShowHeartLongPress(pstid, btnListener)
  end, self._scrollRect, self._firstIn, teamType, self._slot, function(pstid)
    return self:GetPetByPstID(pstid)
  end, self)
end

function UISeasonMazeTeamChangeController:GetPetByPstID(pstid)
  return self._allPets[pstid]
end

function UISeasonMazeTeamChangeController:_OnChangeTeam(TT, petResId, del, pets)
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  local res = seasonMazeModule:ReqSeasonMazeChangeFormationInfo(TT, self._team.id, self._team.name, pets)
  self:UnLock("UISeasonMazeTeamChangeController")
  if res:GetSucc() then
    self._team.pets = pets
    local teams = self.ctx:Teams()
    teams:UpdateTeam(self._team)
    self:CloseUITeamsMemberSelect()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
  end
  if not del then
    GameGlobal.GetModule(PetAudioModule):PlayPetAudio("Formation", petResId)
  end
end

function UISeasonMazeTeamChangeController:CloseUITeamsMemberSelect()
  self:CloseDialog()
  if self._isBinderData then
    local namea = StringTable.Get(self._isBinderData.peta)
    local nameb = StringTable.Get(self._isBinderData.petb)
    local tips = StringTable.Get("str_team_change_binder_toast_tips", nameb, namea)
    ToastManager.ShowToast(tips)
  end
end

function UISeasonMazeTeamChangeController:CalcPetScrollViewCount()
  self._petCount = table.count(self._pstidTab)
  self._listShowItemCount = math.ceil(self._petCount / self._itemCountPerRow)
  self:CheckEmptyTip()
end

function UISeasonMazeTeamChangeController:CheckEmptyTip()
  if self._petCount <= 0 then
    self._emptyDataTip:SetActive(true)
  else
    self._emptyDataTip:SetActive(false)
  end
end

function UISeasonMazeTeamChangeController:RefrenshPetList_NormalBranch()
  local sortParams = {}
  local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
  if self.ctx.teamOpenerType == TeamOpenerType.SeasonMaze then
    sortParams = {}
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    local curRoomType = SMazeAdaptor.GetCurRoomType()
    local isMining = curRoomType == SeasonMazeRoomType.SMRT_Ore
    if isMining then
      table.insert(sortParams, 1, PetSortParam:New(PetSortType.SMazeInTeam, PetSortOrder.Ascending, self._team.pets))
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.SMazeDispatch, PetSortOrder.Descending))
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.SMazeDie, PetSortOrder.Descending))
  else
    sortParams = tempParams
  end
  if self._sortType == PetSortType.Element then
    if not (self._currentElementSortTypeOrder and self._elementSortTypeOrder[self._currentElementSortTypeOrder] and PetDefaulSort[self._elementSortTypeOrder[self._currentElementSortTypeOrder]]) or not PetDefaulSort[self._elementSortTypeOrder[self._currentElementSortTypeOrder]][PetSortOrder.Descending] then
      Log.error("卡牌列表刷新失败:", self._currentElementSortTypeOrder)
    end
    local tempParams = PetDefaulSort[self._elementSortTypeOrder[self._currentElementSortTypeOrder]][PetSortOrder.Descending]
    sortParams = {}
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    local curRoomType = SMazeAdaptor.GetCurRoomType()
    local isMining = curRoomType == SeasonMazeRoomType.SMRT_Ore
    if isMining then
      table.insert(sortParams, 1, PetSortParam:New(PetSortType.SMazeInTeam, PetSortOrder.Ascending, self._team.pets))
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.SMazeDispatch, PetSortOrder.Descending))
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.SMazeDie, PetSortOrder.Descending))
  end
  local savedMemID = self._pstidTab
  local savedSortParams = sortParams
  if self.ctx:IsFastSelect() then
    sortParams = {}
    table.insert(sortParams, PetSortParam:New(PetSortType.FastTeam, PetSortOrder.Descending))
    for i = 1, #savedSortParams do
      table.insert(sortParams, savedSortParams[i])
    end
    local teamLookup = self:FastSelectMemID(savedMemID)
    sortParams[1]:SetParams(teamLookup)
  end
  self._pets = self._petModule:_SortPets(self._allPets, self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  self._petModule:SavePetSortInfo(self._filterParams, self._sortOrder, self._sortType, savedSortParams)
  self._pstidTab = {}
  if not self._add then
    local tabItem = {}
    tabItem.pstid = self._team.pets[self._slot]
    tabItem.del = true
    table.insert(self._pstidTab, tabItem)
  end
  local teamLookup = {}
  if self._openList then
    teamLookup = {}
    if self._openPet then
      teamLookup[self._openPet:GetPstID()] = self._openPet:GetPstID()
    end
  else
    for i = 1, #self._team.pets do
      local pstid = self._team.pets[i]
      teamLookup[pstid] = pstid
    end
  end
  if self.ctx:IsFastSelect() then
    teamLookup = {}
  end
  for i = 1, #self._pets do
    local pet = self._pets[i]
    local pstid = pet:GetPstID()
    if teamLookup[pstid] == nil then
      local tabItem = {}
      tabItem.pstid = pstid
      tabItem.del = false
      table.insert(self._pstidTab, tabItem)
    end
  end
  if self.ctx:IsFastSelect() then
    self:FastSelectMemID(savedMemID)
  end
end

function UISeasonMazeTeamChangeController:RefrenshPetList()
  self._currentElementSortTypeOrder = self._petModule.PetSortElementIndex
  self:RefrenshPetList_NormalBranch()
  self:CalcPetScrollViewCount()
  self.items = {}
  self._scrollView:SetListItemCount(self._listShowItemCount)
  self._scrollView:MovePanelToItemIndex(0, 0)
end

function UISeasonMazeTeamChangeController:BtnFiltrateOnClick(go)
  self._curSortStateIcon.sprite = self._atlas:GetSprite("spirit_jiantou_b_2_frame")
  self._sortFilterActiveStatus = true
  if self._sortFilter == nil then
    self._sortFilter = self._sortFilterLoader:SpawnObject("UISortFilterItem")
  end
  self._sortFilter:SetData(self._sortType, self._sortOrder, self._filterParams, self._sortCfg, self._filterCfg, function(sortType, sortOrder, filterParams)
    self:OnSortFilterChanged(sortType, sortOrder, filterParams)
  end, function()
    self:CloseFiterCallBack()
  end)
  self._clearFilterBtn:SetActive(true)
  self._sortFilter:GetGameObject():SetActive(true)
end

function UISeasonMazeTeamChangeController:OnSortFilterChanged(sortType, sortOrder, filterParams)
  self._sortType = sortType
  self._sortOrder = sortOrder
  self._filterParams = filterParams
  self:FlushTopBtnState()
  self:RefrenshPetList()
end

function UISeasonMazeTeamChangeController:CloseFiterCallBack()
  self._sortFilterActiveStatus = false
  self:SetClearBtnStatus()
end

function UISeasonMazeTeamChangeController:GetPetItem(petTempId)
  for index, value in ipairs(self.items) do
    if value.pet:GetTemplateID() == petTempId then
      return value:GetGameObject("btn")
    end
  end
  return nil
end

function UISeasonMazeTeamChangeController:GetPetItemHP(_index)
  for index, value in ipairs(self.items) do
    if index == _index then
      return value.heartItem:GetGameObject("hpbg")
    end
  end
  return nil
end

function UISeasonMazeTeamChangeController:GetScroll()
  return self._scrollRect
end

function UISeasonMazeTeamChangeController:GetHelpPetItem()
  for _, value in ipairs(self.items) do
    if value:GetHelpPetState() then
      return value:GetGameObject("btn")
    end
  end
  return nil
end

function UISeasonMazeTeamChangeController:SelectTeamItem(nIndex)
  local uiTeamItem = self.items[nIndex]
  if nil == uiTeamItem then
    return
  end
  uiTeamItem:bgOnClick()
end

function UISeasonMazeTeamChangeController:ClearFilterBtnOnClick()
  if self._sortFilterActiveStatus == false then
    self._clearFilterBtn:SetActive(false)
    self._curSortStateIcon.sprite = self._atlas:GetSprite("spirit_jiantou_b_1_frame")
  end
  self._petModule:ClearPetSortFilterInfo()
  self:NormalBranch()
  self:FlushTopBtnState()
  self:RefrenshPetList()
  if self._sortFilter then
    self._sortFilter:ClearFilters()
  end
end

function UISeasonMazeTeamChangeController:OnHide()
  if self._petModule then
    self._petModule:ClearAllPetSortInfo()
  end
end

function UISeasonMazeTeamChangeController:SetClearBtnStatus()
  if not self._petModule:CheckHasCachePetSortInfo(false) then
    self._curSortStateIcon.sprite = self._atlas:GetSprite("spirit_jiantou_b_1_frame")
    self._clearFilterBtn:SetActive(false)
  else
    self._curSortStateIcon.sprite = self._atlas:GetSprite("spirit_jiantou_b_2_frame")
    self._clearFilterBtn:SetActive(true)
  end
end

function UISeasonMazeTeamChangeController:SetElementSortDefaultParam()
  if self._petModule.PetSortType ~= nil then
    self._sortType = self._petModule.PetSortType
  end
  if self._petModule.PetSortOrder ~= nil then
    self._sortOrder = self._petModule.PetSortOrder
  end
  if self._petModule.PetSortFilter ~= nil then
    self._filterParams = self._petModule.PetSortFilter
  end
end

function UISeasonMazeTeamChangeController:GetTeamOrPrimaryPets()
  return self._team.pets
end

function UISeasonMazeTeamChangeController:GetPstidTab()
  if self._pstidTab == nil then
    self._pstidTab = {}
  end
  return self._pstidTab
end

function UISeasonMazeTeamChangeController:FastSelectMemID(savedMemID)
  if self._pstidTab == nil then
    self._pstidTab = {}
  end
  local teamLookup = {}
  local outotFilter = {}
  if savedMemID == nil then
    for i = 1, #self._team.pets do
      local pstid = self._team.pets[i]
      teamLookup[pstid] = i
      if pstid ~= 0 then
        local tabItem = {
          pstid = pstid,
          del = false,
          memId = i
        }
        table.insert(outotFilter, tabItem)
      end
    end
  else
    for k, v in pairs(savedMemID) do
      teamLookup[v.pstid] = v.memId
      if v.memId ~= nil then
        table.insert(outotFilter, v)
      end
    end
  end
  for k, v in pairs(self._allPets) do
    local pstid = v:GetPstID()
    local memId = teamLookup[pstid]
    v:SetFastTeamMemID(memId)
  end
  local filterLookup = {}
  for k, v in pairs(self._pstidTab) do
    v.memId = teamLookup[v.pstid]
    filterLookup[v.pstid] = v.pstid
  end
  local insertID = 1
  for k, v in pairs(outotFilter) do
    if filterLookup[v.pstid] == nil then
      table.insert(self._pstidTab, insertID, v)
      insertID = insertID + 1
    end
  end
  return teamLookup
end

function UISeasonMazeTeamChangeController:FastSelectHeartClick(fastClickItem, pstid, del, helppetstate, slot)
  local tabItem = fastClickItem:GetTabItem()
  local savedmemId = tabItem.memId
  if fastClickItem:IsBinderPet() then
    tabItem.memId = tabItem.memId
  elseif fastClickItem:IsRepeatHelpPet() then
    tabItem.memId = tabItem.memId
  elseif tabItem.memId ~= nil then
    tabItem.memId = nil
  else
    local teamLookup = {}
    for k, v in pairs(self._pstidTab) do
      if v.memId ~= nil then
        teamLookup[v.memId] = v.memId
      end
    end
    local memId
    for i = 1, #self._team.pets do
      if teamLookup[i] == nil then
        memId = i
        break
      end
    end
    tabItem.memId = memId
  end
  if savedmemId ~= tabItem.memId then
    for k, v in pairs(self._dicItems) do
      if v:GetGameObject().activeSelf then
        v:FastTeamChanged()
      end
    end
    local playVoice = false
    if tabItem.memId ~= nil and playVoice then
      local pet = self:GetPetByPstID(pstid)
      local petResId = 0
      if pet then
        petResId = pet:GetTemplateID()
      end
      GameGlobal.GetModule(PetAudioModule):PlayPetAudio("Formation", petResId)
    end
  end
end

function UISeasonMazeTeamChangeController:BtnFastConfirmOnClick(go)
  local petresid = 0
  local del = true
  local pets = {}
  local petCount = #self._team.pets
  for i = 1, petCount do
    pets[i] = 0
  end
  for k, v in pairs(self._pstidTab) do
    if v.memId ~= nil then
      pets[v.memId] = v.pstid
    end
  end
  self:Lock("UISeasonMazeTeamChangeController")
  self:StartTask(self._OnChangeTeam, self, petresid, del, pets)
end

function UISeasonMazeTeamChangeController:CancelBtnOnclick()
  return
end

function UISeasonMazeTeamChangeController:CancelBtnOnPress(go)
  for k, v in pairs(self._pstidTab) do
    if v.memId ~= nil then
      v.memId = nil
    end
  end
  for k, v in pairs(self._dicItems) do
    if v:GetGameObject().activeSelf then
      v:FastTeamChanged()
    end
  end
  self:Lock("UISeasonMazeTeamChangeController")
end

function UISeasonMazeTeamChangeController:CancelBtnOnRelease(go)
  self:UnLock("UISeasonMazeTeamChangeController")
end

function UISeasonMazeTeamChangeController:_CheckSeasonTips()
  local active = false
  local text
  if self.ctx.teamOpenerType == TeamOpenerType.Season then
    self.ctx:GetCurrTeamId()
    local ctxParam = self.ctx.param
    if ctxParam then
      local missionId = ctxParam[1]
      if missionId then
        local missionCfg = Cfg.cfg_season_mission[missionId]
        if missionCfg and missionCfg.Type ~= SeasonEventPointType.DailyLevel then
          active = true
          text = StringTable.Get("str_season_pet_enhance_title", missionCfg.PetGrade, missionCfg.PetLv, missionCfg.PetAwakening, missionCfg.PetEquip)
        end
      end
    end
  end
  if self._seasonGo then
    self._seasonGo:SetActive(active)
    if active and self._seasonTipsText then
      self._seasonTipsText:SetText(text)
    end
  end
end
