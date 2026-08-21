_class("UISeasonMazeBackPackController", UIController)
UISeasonMazeBackPackController = UISeasonMazeBackPackController

function UISeasonMazeBackPackController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
  self._module = self:GetModule(MissionModule)
  self._ctx = self._module:TeamCtx()
  self._teams = self._ctx:GetSeasonMazeTeam()
end

function UISeasonMazeBackPackController:OnShow(uiParams)
  self._cfg = Cfg.cfg_item({})
  if self._cfg == nil then
    Log.fatal("[error] maze --> _cfg == nil !")
  end
  self.openTag = 1
  if uiParams[1] then
    self.openTag = uiParams[1]
  end
  if uiParams[2] then
    self._innerGame = true
  end
  self.seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self.uiSeasonMazeModule = self.seasonMazeModule:UIModule()
  self.seasonMazeObj = self.seasonMazeModule:CurSeasonObj()
  self.cmptInfo = self.seasonMazeObj:GetComponentInfo(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._ctx:InitSeasonMazeTeam(self.cmptInfo.m_formation_list)
  self.refreshPetOver = false
  self.refreshRelicOver = false
  self.refreshActionCardOver = false
  self.mazePets = self.uiSeasonMazeModule:GetSeasonMazePets()
  self.mazeRelics = self.uiSeasonMazeModule:GetSeasonMazeRelics()
  self.mazeActionCards = self.uiSeasonMazeModule:GetSeasonMazeActionCards()
  self._itemCountPerRow = 5
  self._relic_itemCountPerRow = 4
  self._actionCard_itemCountPerRow = 4
  self._listShowItemCount = 0
  self._TaskList = {}
  self._AsyncLoadFlagMap = {}
  self._btnCount = 3
  self._firstIn = true
  self._uiHeartAtlas = self:GetAsset("UIHeartItem.spriteatlas", LoadType.SpriteAtlas)
  self._items = {}
  self._elementSortTypeOrder = {
    [1] = PetSortType.WaterFirst,
    [2] = PetSortType.FireFirst,
    [3] = PetSortType.SenFirst,
    [4] = PetSortType.ElectricityFirst
  }
  self._currentElementSortTypeOrder = 0
  self._sortFilterActiveStatus = false
  self._petHeartItemList = {}
  self._isFilterRedPoint = false
  self._petModule = GameGlobal.GetModule(PetModule)
  self._petModule:ClearAllPetSortInfo()
  local sortFilterCfg = UISortFilterCfg.SeasonMazeTeam
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
  if self._petModule.PetSortType ~= nil then
    self._sortType = self._petModule.PetSortType
  else
    self._sortType = PetSortType.Level
  end
  if self._petModule.PetSortOrder ~= nil then
    self._sortOrder = self._petModule.PetSortOrder
  else
    self._sortOrder = PetSortOrder.Descending
  end
  if self._petModule.PetSortFilter ~= nil then
    self._filterParams = self._petModule.PetSortFilter
  else
    self._filterParams = {}
  end
  local sortParams = PetDefaulSort[self._sortType][self._sortOrder]
  self._pets = self._petModule:_SortPets(self.uiSeasonMazeModule:GetSeasonMazeTablePets(), self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  self._pets = self:SortByDeath(self._pets)
  self._petCount = table.count(self._pets)
  self._listShowItemCount = math.ceil(self._petCount / self._itemCountPerRow)
  self._backClose = false
  if self._innerGame then
    local matchModule = GameGlobal.GetModule(MatchModule)
    local enterData = matchModule:GetMatchEnterData()
    if enterData:GetMatchType() == MatchType.MT_SeasonMaze then
      self._isFromSeasonMaze = true
      self._relicList = {}
      local createInfo = enterData:GetSeasonMazeMissionInfo()
      self.mazeRelics = createInfo.relic_list
    end
    self.petBtn = self:GetGameObject("PetBtn")
    self.petBtn:SetActive(false)
    self.sacredBtn = self:GetGameObject("SacredBtn")
    self.sacredBtn.transform.position = Vector3(self.sacredBtn.transform.position.x, self.petBtn.transform.position.y, self.sacredBtn.transform.position.z)
    self.activeCardBtn = self:GetGameObject("ActiveCardBtn")
    self.activeCardBtn:SetActive(false)
  end
  self:InitWidget()
  self:InitUI()
  self:Lock("UISeasonMazeBackPackController:Enter")
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:UnLock("UISeasonMazeBackPackController:Enter")
  end)
end

function UISeasonMazeBackPackController:SortByDeath(pets)
  local savePets = {}
  local deathPets = {}
  local dispatchPets = {}
  local inTeamPets = {}
  for i = 1, #pets do
    local pstd = pets[i]:GetPstID()
    local curHp, maxHp = self.uiSeasonMazeModule:GetPetHP(pstd, nil)
    if 0 < curHp then
      local module = GameGlobal.GetModule(SeasonMazeModule)
      local dispatch = module:GetPetDispatchData(pets[i]:GetTemplateID())
      if dispatch then
        dispatchPets[#dispatchPets + 1] = pets[i]
      elseif 0 < #self._teams.list then
        local tmpTeam = self._teams.list[1]:Clone()
        local teampets = tmpTeam:GetPets()
        local inTeam = false
        for jk = 1, #teampets do
          local pet = teampets[jk]
          if pet == pets[i]:GetPstID() then
            inTeamPets[#inTeamPets + 1] = pets[i]
            inTeam = true
          end
        end
        if not inTeam then
          savePets[#savePets + 1] = pets[i]
        end
      else
        savePets[#savePets + 1] = pets[i]
      end
    else
      deathPets[#deathPets + 1] = pets[i]
    end
  end
  if 0 < #inTeamPets then
    for i = 1, #savePets do
      inTeamPets[#inTeamPets + 1] = savePets[i]
    end
    savePets = inTeamPets
  end
  if 0 < #dispatchPets then
    for i = 1, #dispatchPets do
      savePets[#savePets + 1] = dispatchPets[i]
    end
  end
  if 0 < #deathPets then
    for i = 1, #deathPets do
      savePets[#savePets + 1] = deathPets[i]
    end
  end
  return savePets
end

function UISeasonMazeBackPackController:InitWidget()
  self.petScrollView = self:GetUIComponent("UIDynamicScrollView", "PetScrollView")
  self._emptyDataTip = self:GetGameObject("EmptyTip")
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  self._sortBtns = self:GetUIComponent("UISelectObjectPath", "sortBtns")
  self._curSortStateIcon = self:GetUIComponent("Image", "btnFiltrate")
  self._sortFilterLoader = self:GetUIComponent("UISelectObjectPath", "sortFilter")
  self._clearFilterBtn = self:GetGameObject("clearFilterBtn")
  self._clearFilterBtn:SetActive(false)
  self.topRightAnchor = self:GetGameObject("TopRightAnchor")
  self._filterRedImg = self:GetUIComponent("Image", "FilterRedBtn")
  self._filterRedIGo = self:GetGameObject("FilterRedBtn")
  self._filterRedIGo:SetActive(false)
  self.petView = self:GetGameObject("PetView")
  self.sacredView = self:GetGameObject("SacredView")
  self.activeCardView = self:GetGameObject("ActiveCardView")
  self.sacredScrollView = self:GetUIComponent("UIDynamicScrollView", "SacredScrollView")
  self.activeCardScrollView = self:GetUIComponent("UIDynamicScrollView", "ActiveCardScrollView")
  self.petName = self:GetUIComponent("UILocalizationText", "petName")
  self.sacredName = self:GetUIComponent("UILocalizationText", "sacredName")
  self.activeCardName = self:GetUIComponent("UILocalizationText", "activeCardName")
  self._filterRedSp1 = self._uiHeartAtlas:GetSprite("spirit_jiantou_b_4_frame")
  self._filterRedSp2 = self._uiHeartAtlas:GetSprite("spirit_jiantou_b_3_frame")
end

function UISeasonMazeBackPackController:InitUI()
  self.whiteTextColor = Color.New(1, 1, 1)
  self.yellowTextColor = Color.New(0.8352941, 0.7215686, 0.4705882)
  self.petBtn = self:GetUIComponent("Toggle", "PetBtn")
  
  function self.petBtnValueChanged(isOn)
    if isOn then
      self:ActiveTagView(1)
    else
    end
  end
  
  self.petBtn.onValueChanged:AddListener(self.petBtnValueChanged)
  self.sacredBtn = self:GetUIComponent("Toggle", "SacredBtn")
  
  function self.sacredBtnValueChanged(isOn)
    if isOn then
      self:ActiveTagView(2)
    else
    end
  end
  
  self.sacredBtn.onValueChanged:AddListener(self.sacredBtnValueChanged)
  self.activeCardBtn = self:GetUIComponent("Toggle", "ActiveCardBtn")
  
  function self.activeCardBtnValueChanged(isOn)
    if isOn then
      self:ActiveTagView(3)
    else
    end
  end
  
  self.activeCardBtn.onValueChanged:AddListener(self.activeCardBtnValueChanged)
  self:_InitBackBtn()
  if self.openTag == 1 then
    self:ActiveTagView(1)
    self.activeCardBtn.isOn = false
    self.sacredBtn.isOn = false
    self.petBtn.isOn = true
  elseif self.openTag == 2 then
    self:ActiveTagView(2)
    self.activeCardBtn.isOn = false
    self.sacredBtn.isOn = true
    self.petBtn.isOn = false
  elseif self.openTag == 3 then
    self:ActiveTagView(3)
    self.activeCardBtn.isOn = true
    self.sacredBtn.isOn = false
    self.petBtn.isOn = false
  end
end

function UISeasonMazeBackPackController:_InitBackBtn()
  local hideHomeBtn = false
  if self._innerGame then
    hideHomeBtn = true
  end
  self.backBtns:SetData(function()
    self._backClose = true
    for i = 1, #self._TaskList do
      local taskId = self._TaskList[i]
      if taskId ~= nil then
        GameGlobal.TaskManager():KillTask(taskId)
      end
    end
    self:CloseDialog()
  end, function()
    local pageIdx = 1
    if self._TmpTag == 1 then
      pageIdx = 1
    elseif self._TmpTag == 2 then
      pageIdx = 2
    elseif self._TmpTag == 3 then
      pageIdx = 3
    end
    UISeasonMazeModule.OpenHelpUI(UISeasonMazeHelperTabIndex.Temp6, pageIdx)
  end, nil, hideHomeBtn, nil, false, nil)
end

function UISeasonMazeBackPackController:ActiveTagView(tag)
  self.petView:SetActive(false)
  self.sacredView:SetActive(false)
  self.activeCardView:SetActive(false)
  if tag == 1 then
    self.petView:SetActive(true)
    self:RefreshPetBackPack()
  elseif tag == 2 then
    self.sacredView:SetActive(true)
    self:RefreshRelicBackPack()
  elseif tag == 3 then
    self.activeCardView:SetActive(true)
    self:RefreshActionCardBackPack()
  end
  self._TmpTag = tag
end

function UISeasonMazeBackPackController:RefreshPetBackPack()
  if self.refreshPetOver then
    self.petScrollView:MovePanelToItemIndex(0, 0)
    return
  end
  self.refreshPetOver = true
  self._module = self:GetModule(MissionModule)
  self.petScrollView:InitListView(self._listShowItemCount, function(scrollView, index)
    return self:InitSpritListInfo(scrollView, index)
  end, self:GetScrollViewParam())
  self._sortBtns:SpawnObjects("UITopSortBtnItem", self._btnCount)
  self._sortBtnsPool = self._sortBtns:GetAllSpawnList()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:SetData(i, self._sortCfg[i], self._sortType, self._sortOrder, function(idx)
      self:ChangeSortParams(idx)
    end, self._currentElementSortTypeOrder)
  end
end

function UISeasonMazeBackPackController:InitSpritListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    if self._TaskList[item] then
      return item
    end
    self._TaskList[item] = self:StartTask(function(TT)
      if 0 < index then
        while self:GetHasItemAsyncLoading() do
          YIELD(TT)
        end
      end
      if self._backClose then
        return
      end
      self._AsyncLoadFlagMap[item] = 1
      rowPool:AsyncSpawnObjects(TT, "UISeasonMazeBagPetStateItem", self._itemCountPerRow)
      local rowList = rowPool:GetAllSpawnList()
      self._petHeartItemList = rowList
      for i = 1, self._itemCountPerRow do
        local heartItem = rowList[i]
        heartItem:GetGameObject():SetActive(false)
      end
      for i = 1, self._itemCountPerRow do
        local heartItem = rowList[i]
        local itemIndex = index * self._itemCountPerRow + i
        if itemIndex > self._petCount then
          heartItem:GetGameObject():SetActive(false)
        else
          self:ShowHeartItem(TT, heartItem, itemIndex)
          heartItem:PlayFadeInAnim()
          self._items[itemIndex] = heartItem
          if itemIndex % 5 == 0 then
          end
        end
      end
      self._AsyncLoadFlagMap[item] = 2
      item.IsInitHandlerCalled = true
      self._TaskList[item] = nil
    end)
  else
    local rowList = rowPool:GetAllSpawnList()
    self._petHeartItemList = rowList
    for i = 1, self._itemCountPerRow do
      local heartItem = rowList[i]
      heartItem:GetGameObject():SetActive(false)
    end
    for i = 1, self._itemCountPerRow do
      local heartItem = rowList[i]
      local itemIndex = index * self._itemCountPerRow + i
      if itemIndex > self._petCount then
        heartItem:GetGameObject():SetActive(false)
      else
        self:ShowHeartItem(TT, heartItem, itemIndex)
        heartItem:ResetInAnim()
        self._items[itemIndex] = heartItem
      end
    end
  end
  return item
end

function UISeasonMazeBackPackController:GetHasItemAsyncLoading()
  for _, v in pairs(self._AsyncLoadFlagMap) do
    if v == 1 then
      return true
    end
  end
  return false
end

function UISeasonMazeBackPackController:ShowHeartItem(TT, heartItem, index)
  if heartItem == nil or heartItem.view == nil or heartItem:GetGameObject() == nil then
    return
  end
  local config = self._pets[index]
  if config ~= nil then
    heartItem:SetData(config, function(id)
      local pstids = {}
      for i = 1, #self._pets do
        table.insert(pstids, self._pets[i]:GetPstID())
      end
      local petModule = self:GetModule(PetModule)
      petModule.uiModule:SetTeamCustomPets(self._pets)
      local petid = self.mazePets[id]:GetTemplateID()
      self:ShowDialog("UISpiritDetailGroupController", petid, false, nil, nil, true)
    end, true, self._firstIn, TeamOpenerType.SeasonMaze, PetSkinEffectPath.CARD_PET_LIST, index)
    self:_SetRedPoint(config, heartItem)
  end
end

function UISeasonMazeBackPackController:_SetRedPoint(config, heartItem)
end

function UISeasonMazeBackPackController:GetScrollViewParam()
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 333
  return param
end

function UISeasonMazeBackPackController:OnSortFilterChanged(sortType, sortOrder, filterParams)
  self._sortType = sortType
  self._sortOrder = sortOrder
  self._filterParams = filterParams
  self:FlushTopBtnState()
  self:RefrenshPetList()
end

function UISeasonMazeBackPackController:FlushTopBtnState()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:Flush(self._sortType, self._sortOrder, self._petModule.PetSortElementIndex)
  end
end

function UISeasonMazeBackPackController:ChangeSortParams(idx)
  local tp = self._sortCfg[idx].Type
  if self._sortType == tp then
    if self._sortOrder == PetSortOrder.Ascending then
      self._sortOrder = PetSortOrder.Descending
    elseif self._sortOrder == PetSortOrder.Descending then
      self._sortOrder = PetSortOrder.Ascending
    end
  else
    self._sortType = tp
  end
  self:FlushTopBtnState()
  self:RefrenshPetList(1, true)
end

function UISeasonMazeBackPackController:RefrenshPetList(pstid, stay)
  self._items = {}
  local sortParams
  if self._sortType == PetSortType.Element then
    self._currentElementSortTypeOrder = self._petModule.PetSortElementIndex
    sortParams = PetDefaulSort[self._elementSortTypeOrder[self._currentElementSortTypeOrder]][PetSortOrder.Descending]
  else
    sortParams = PetDefaulSort[self._sortType][self._sortOrder]
  end
  self._pets = self._petModule:_SortPets(self.uiSeasonMazeModule:GetSeasonMazeTablePets(), self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  self._pets = self:SortByDeath(self._pets)
  self._petModule:SavePetSortInfo(self._filterParams, self._sortOrder, self._sortType)
  local preListShowItemCount = self._listShowItemCount
  self:CalcPetScrollViewCount()
  self.petScrollView:SetListItemCount(self._listShowItemCount)
  if preListShowItemCount == self._listShowItemCount then
    self.petScrollView:MovePanelToItemIndex(0, 0)
  else
  end
  self._filterRedIGo:SetActive(false)
end

function UISeasonMazeBackPackController:CalcPetScrollViewCount()
  self._petCount = table.count(self._pets)
  self._listShowItemCount = math.ceil(self._petCount / self._itemCountPerRow)
  if self._petCount > 0 then
    self._emptyDataTip:SetActive(false)
  else
    self._emptyDataTip:SetActive(true)
  end
end

function UISeasonMazeBackPackController:CloseFiterCallBack()
  self._sortFilterActiveStatus = false
  self:SetClearBtnStatus()
end

function UISeasonMazeBackPackController:SetClearBtnStatus()
  if not self._petModule:CheckHasCachePetSortInfo() then
    self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("spirit_jiantou_b_1_frame")
    self._clearFilterBtn:SetActive(false)
  else
    self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("spirit_jiantou_b_2_frame")
    self._clearFilterBtn:SetActive(true)
  end
end

function UISeasonMazeBackPackController:SetFilterImgActive()
  local sp
  if self._isFilterRedPoint then
    sp = self._filterRedSp1
  else
    sp = self._filterRedSp2
  end
  self._filterRedImg.sprite = sp
end

function UISeasonMazeBackPackController:RefreshRelicBackPack()
  if self.refreshRelicOver then
    if table.count(self.mazeRelics) ~= 0 then
      self.sacredScrollView:MovePanelToItemIndex(0, 0)
    end
    return
  end
  self.refreshRelicOver = true
  self.mazeRelics = self.uiSeasonMazeModule:GetSeasonMazeRelics()
  local relics = {}
  if table.count(self.mazeRelics) == 0 then
    return
  end
  for key, value in pairs(self.mazeRelics) do
    relics[#relics + 1] = key
  end
  self._itemInfo = self:Relic_SortItems(relics)
  self._relic_listShowRowmItemCount = table.count(self._itemInfo)
  self:_Relic_InitSrollView()
end

function UISeasonMazeBackPackController:Relic_SortItems(items)
  table.sort(items, function(a, b)
    local ta = self._cfg[a]
    local tb = self._cfg[b]
    local taUse = self.uiSeasonMazeModule:GetSeasonMazeRelicCanUseCount(ta.ID)
    local tbUse = self.uiSeasonMazeModule:GetSeasonMazeRelicCanUseCount(tb.ID)
    if taUse == 0 and tbUse ~= 0 then
      return false
    end
    if tbUse == 0 and taUse ~= 0 then
      return true
    end
    return ta.ID < tb.ID
  end)
  return items
end

function UISeasonMazeBackPackController:_Relic_InitSrollView()
  self.sacredScrollView:InitListView(self:Relic_GetRowCount(), function(scrollView, index)
    return self:Relic_InitSpritListInfo(scrollView, index)
  end)
end

function UISeasonMazeBackPackController:Relic_GetRowCount()
  local row = math.ceil(self._relic_listShowRowmItemCount / self._relic_itemCountPerRow)
  return row
end

function UISeasonMazeBackPackController:Relic_InitSpritListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISeasonMazeRelicItem", self._relic_itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._relic_itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._relic_itemCountPerRow + i
    if itemIndex > self._relic_listShowRowmItemCount then
      heartItem:GetGameObject():SetActive(false)
    else
      self:Relic_ShowHeartItem(heartItem, itemIndex)
    end
  end
  return item
end

function UISeasonMazeBackPackController:Relic_ShowHeartItem(item, index)
  local cfg = self._itemInfo[index]
  item:GetGameObject():SetActive(false)
  if cfg ~= nil then
    item:SetData(index, cfg, function(tIndex)
      self:ShowDialog("UISeasonMazeRelicInfoController", self._itemInfo[index], self._itemInfo)
    end, false, true, false)
  end
end

function UISeasonMazeBackPackController:RefreshActionCardBackPack()
  if self.refreshActionCardOver then
    self.activeCardScrollView:MovePanelToItemIndex(0, 0)
    return
  end
  self.refreshActionCardOver = true
  self.infos = self:Sort_ActionCard(self.mazeActionCards)
  local unReActionCard = {}
  for i = 1, #self.infos do
    local target = self.infos[i]
    if #unReActionCard == 0 then
      unReActionCard[#unReActionCard + 1] = target
    else
      local re = false
      for j = 1, #unReActionCard do
        local beyondCom = unReActionCard[j]
        if beyondCom == target then
          re = true
        end
      end
      if not re then
        unReActionCard[#unReActionCard + 1] = target
      end
    end
  end
  self.infos = unReActionCard
  self._actionCard_listShowRowmItemCount = table.count(self.infos)
  self:_ActionCard_InitSrollView()
end

function UISeasonMazeBackPackController:Sort_ActionCard(infos)
  table.sort(infos, function(a, b)
    local ta = Cfg.cfg_component_season_maze_hand[a]
    local tb = Cfg.cfg_component_season_maze_hand[b]
    if ta.Quality == tb.Quality then
      return ta.ID < tb.ID
    end
    return ta.Quality > tb.Quality
  end)
  return infos
end

function UISeasonMazeBackPackController:_ActionCard_InitSrollView()
  self.activeCardScrollView:InitListView(self:ActionCard_GetRowCount(), function(scrollView, index)
    return self:ActionCard_InitSpritListInfo(scrollView, index)
  end)
end

function UISeasonMazeBackPackController:ActionCard_GetRowCount()
  local row = math.ceil(self._actionCard_listShowRowmItemCount / self._actionCard_itemCountPerRow)
  return row
end

function UISeasonMazeBackPackController:ActionCard_InitSpritListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISeasonMazeCardItem", self._actionCard_itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._actionCard_itemCountPerRow do
    local heartItem = rowList[i]
    local itemIndex = index * self._actionCard_itemCountPerRow + i
    if itemIndex > self._actionCard_listShowRowmItemCount then
      heartItem:GetGameObject():SetActive(false)
    else
      self:ActionCard_ShowHeartItem(heartItem, itemIndex)
    end
  end
  return item
end

function UISeasonMazeBackPackController:ActionCard_ShowHeartItem(item, index)
  local cfg = self.infos[index]
  item:GetGameObject():SetActive(false)
  if cfg ~= nil then
    item:SetData(index, cfg, function(index)
      local indexCfg = self.infos[index]
      self:ShowDialog("UISeasonMazeActionCardInfoController", indexCfg)
    end, function()
    end)
    item:PlayDelaBagAnim(index)
  end
end

function UISeasonMazeBackPackController:BtnFiltrateOnClick(go)
  self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("spirit_jiantou_b_2_frame")
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

function UISeasonMazeBackPackController:ClearFilterBtnOnClick(go)
  if self._sortFilterActiveStatus == false then
    self._clearFilterBtn:SetActive(false)
    self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("spirit_jiantou_b_1_frame")
  end
  self._petModule:ClearPetSortFilterInfo()
  self._filterParams = {}
  self._isFilterRedPoint = false
  self:SetFilterImgActive()
  self:FlushTopBtnState()
  self:RefrenshPetList()
  if self._sortFilter then
    self._sortFilter:ClearFilters()
  end
end

function UISeasonMazeBackPackController:FilterRedBtnOnClick(go)
end

function UISeasonMazeBackPackController:PetBtnOnClick(go)
end

function UISeasonMazeBackPackController:SacredBtnOnClick(go)
end

function UISeasonMazeBackPackController:ActiveCardBtnOnClick(go)
end
