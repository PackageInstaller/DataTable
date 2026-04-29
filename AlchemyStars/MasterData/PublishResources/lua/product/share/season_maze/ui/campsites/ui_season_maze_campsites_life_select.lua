_class("UISeasonMaze_Campsites_Life_Select", UIController)
UISeasonMaze_Campsites_Life_Select = UISeasonMaze_Campsites_Life_Select

function UISeasonMaze_Campsites_Life_Select:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
  self._module = self:GetModule(MissionModule)
  self._ctx = self._module:TeamCtx()
  self._teams = self._ctx:Teams()
end

function UISeasonMaze_Campsites_Life_Select:OnShow(uiParams)
  self._cost = uiParams[1]
  self._selectCb = uiParams[2]
  self._cfg = Cfg.cfg_item({})
  if self._cfg == nil then
    Log.fatal("[error] maze --> _cfg == nil !")
  end
  
  function self.petCondition(pet)
    if pet.cur_blood_prcent <= 0 then
      return true
    end
  end
  
  self.seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self.uiSeasonMazeModule = self.seasonMazeModule:UIModule()
  self.mazePets = self.uiSeasonMazeModule:GetSeasonMazePets(self.petCondition)
  self._itemCountPerRow = 5
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
  self._pets = self.uiSeasonMazeModule:GetSeasonMazeTablePets(self.petCondition)
  self._petCount = table.count(self._pets)
  self._listShowItemCount = math.ceil(self._petCount / self._itemCountPerRow)
  self._backClose = false
  self:InitWidget()
  self:InitUI()
end

function UISeasonMaze_Campsites_Life_Select:InitWidget()
  self.petScrollView = self:GetUIComponent("UIDynamicScrollView", "PetScrollView")
  self._emptyDataTip = self:GetGameObject("EmptyTip")
  local pool = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self.backBtns = pool:SpawnObject("UINewCommonTopButton")
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
  self._filterRedSp1 = self._uiHeartAtlas:GetSprite("spirit_jiantou_b_4_frame")
  self._filterRedSp2 = self._uiHeartAtlas:GetSprite("spirit_jiantou_b_3_frame")
end

function UISeasonMaze_Campsites_Life_Select:InitUI()
  self.whiteTextColor = Color.New(1, 1, 1)
  self.yellowTextColor = Color.New(0.8352941, 0.7215686, 0.4705882)
  self:_InitBackBtn()
  self:RefreshPetView()
end

function UISeasonMaze_Campsites_Life_Select:_InitBackBtn()
  self.backBtns:SetData(function()
    self._backClose = true
    for i = 1, #self._TaskList do
      local taskId = self._TaskList[i]
      if taskId ~= nil then
        GameGlobal.TaskManager():KillTask(taskId)
      end
    end
    self:CloseDialog()
  end, nil, nil, true, nil, false, nil)
end

function UISeasonMaze_Campsites_Life_Select:RefreshPetView()
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

function UISeasonMaze_Campsites_Life_Select:InitSpritListInfo(scrollView, index)
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
          if itemIndex % 2 == 0 then
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
        heartItem:SetInVisible()
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

function UISeasonMaze_Campsites_Life_Select:GetHasItemAsyncLoading()
  for _, v in pairs(self._AsyncLoadFlagMap) do
    if v == 1 then
      return true
    end
  end
  return false
end

function UISeasonMaze_Campsites_Life_Select:ShowHeartItem(TT, heartItem, index)
  if heartItem == nil or heartItem.view == nil or heartItem:GetGameObject() == nil then
    return
  end
  local config = self._pets[index]
  if config ~= nil then
    heartItem:SetData(config, function(id)
      local desc = StringTable.Get("str_season_maze_camp_life_heal_cost_desc", self._cost)
      UISeasonMazeModule.PopMsgBox(StringTable.Get("str_season_maze_camp_tips"), desc, SeasonMazeMsgBoxType.OkCancel, function()
        if self._selectCb then
          self:CloseDialog()
          self._selectCb(id)
        end
      end)
    end, true, self._firstIn, TeamOpenerType.SeasonMaze, PetSkinEffectPath.CARD_PET_LIST, index)
  end
end

function UISeasonMaze_Campsites_Life_Select:GetScrollViewParam()
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 333
  return param
end

function UISeasonMaze_Campsites_Life_Select:OnSortFilterChanged(sortType, sortOrder, filterParams)
  self._sortType = sortType
  self._sortOrder = sortOrder
  self._filterParams = filterParams
  self:FlushTopBtnState()
  self:RefrenshPetList()
end

function UISeasonMaze_Campsites_Life_Select:FlushTopBtnState()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:Flush(self._sortType, self._sortOrder, self._petModule.PetSortElementIndex)
  end
end

function UISeasonMaze_Campsites_Life_Select:ChangeSortParams(idx)
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
  self:RefrenshPetList()
end

function UISeasonMaze_Campsites_Life_Select:RefrenshPetList(pstid, stay)
  self._items = {}
  local sortParams
  if self._sortType == PetSortType.Element then
    self._currentElementSortTypeOrder = self._petModule.PetSortElementIndex
    sortParams = PetDefaulSort[self._elementSortTypeOrder[self._currentElementSortTypeOrder]][PetSortOrder.Descending]
  else
    sortParams = PetDefaulSort[self._sortType][self._sortOrder]
  end
  self._pets = self._petModule:_SortPets(self.uiSeasonMazeModule:GetSeasonMazeTablePets(self.petCondition), self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  self._petModule:SavePetSortInfo(self._filterParams, self._sortOrder, self._sortType)
  self:CalcPetScrollViewCount()
  self.petScrollView:SetListItemCount(self._listShowItemCount)
  if not stay then
    self.petScrollView:MovePanelToItemIndex(0, 0)
  else
    self.petScrollView:RefreshAllShownItem()
  end
  self._filterRedIGo:SetActive(false)
end

function UISeasonMaze_Campsites_Life_Select:CalcPetScrollViewCount()
  self._petCount = table.count(self._pets)
  self._listShowItemCount = math.ceil(self._petCount / self._itemCountPerRow)
  self._emptyDataTip:SetActive(false)
end

function UISeasonMaze_Campsites_Life_Select:CloseFiterCallBack()
  self._sortFilterActiveStatus = false
  self:SetClearBtnStatus()
end

function UISeasonMaze_Campsites_Life_Select:SetClearBtnStatus()
  if not self._petModule:CheckHasCachePetSortInfo() then
    self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("spirit_jiantou_b_1_frame")
    self._clearFilterBtn:SetActive(false)
  else
    self._curSortStateIcon.sprite = self._uiHeartAtlas:GetSprite("spirit_jiantou_b_2_frame")
    self._clearFilterBtn:SetActive(true)
  end
end

function UISeasonMaze_Campsites_Life_Select:SetFilterImgActive()
  local sp
  if self._isFilterRedPoint then
    sp = self._filterRedSp1
  else
    sp = self._filterRedSp2
  end
  self._filterRedImg.sprite = sp
end

function UISeasonMaze_Campsites_Life_Select:BtnFiltrateOnClick(go)
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

function UISeasonMaze_Campsites_Life_Select:ClearFilterBtnOnClick(go)
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

function UISeasonMaze_Campsites_Life_Select:FilterRedBtnOnClick(go)
end
