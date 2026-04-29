_class("UITeamChangeController", UIController)
UITeamChangeController = UITeamChangeController

function UITeamChangeController:Constructor()
  self._itemCountPerRow = 6
  self._slotHelpPet = 5
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
  self._disableHelpPetSlot = false
end

function UITeamChangeController:GetComponents()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self.helpPetBranch then
      self:CloseDialog()
    else
      self:CloseUITeamsMemberSelect()
    end
  end, nil)
  self._sortBtns = self:GetUIComponent("UISelectObjectPath", "sortBtns")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._scrollRect = self:GetUIComponent("ScrollRect", "ScrollView")
  self._curSortStateIcon = self:GetUIComponent("Image", "btnFiltrate")
  self._emptyDataTip = self:GetGameObject("EmptyTip")
  self._towerTip = self:GetUIComponent("UILocalizationText", "TowerTip")
  self._towerGo = self:GetGameObject("Tower")
  self._eightFightTipsGo = self:GetGameObject("eightFightTips")
  self._eightPetConditionTxt = self:GetUIComponent("RollingText", "eightPetConditionTxt")
  self._seasonTipsText = self:GetUIComponent("UILocalizationText", "SeasonTipsText")
  self._seasonGo = self:GetGameObject("Season")
  if self._seasonGo then
    self._seasonGo:SetActive(false)
  end
  self._campaignTips = self:GetGameObject("Campaign")
  self._campaignTipsText = self:GetUIComponent("UILocalizationText", "CampaignTipsText")
  if self._campaignTips then
    self._campaignTips:SetActive(false)
  end
  self._emptyDataTip:SetActive(false)
  self._sortFilterLoader = self:GetUIComponent("UISelectObjectPath", "sortFilter")
  self._airGo = self:GetGameObject("Air")
  self._clearFilterBtn = self:GetGameObject("clearFilterBtn")
  self._clearFilterBtn:SetActive(false)
  self._clearFilterBtnTrans = self:GetUIComponent("RectTransform", "clearFilterBtn")
  self._topRightTrans = self:GetUIComponent("RectTransform", "TopRightAnchor")
  self._refineTip = self:GetGameObject("RefineTip")
  self._refineTip:SetActive(false)
  self._redPoint = self:GetGameObject("RedPoint")
  self._topRight = self:GetGameObject("TopRight")
  self._topRightRect = self:GetUIComponent("RectTransform", "TopRight")
  self._rtFastTeam = self:GetUIComponent("RectTransform", "FastTeam")
  self._filterFavImg = self:GetUIComponent("Image", "FilterFavBtn")
  self._cancelBtn = self:GetGameObject("CancelBtn")
  self._cancelBtnIcon = self:GetUIComponent("Image", "CancelBtn")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelBtn), UIEvent.Press, function()
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
    self._cancelBtnIcon.color = Color(1.0, 1.0, 1.0, 0.5)
    self:CancelBtnOnPress()
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelBtn), UIEvent.Release, function()
    self._cancelBtnIcon.color = Color(1.0, 1.0, 1.0, 1)
    self:CancelBtnOnRelease()
  end)
end

function UITeamChangeController:SetFilterFavImgActive()
  if self._isFilterFavPet then
    self._filterFavImg.sprite = self._atlas:GetSprite("tjxa_icon4")
  else
    self._filterFavImg.sprite = self._atlas:GetSprite("tjxa_icon3")
  end
end

function UITeamChangeController:OnValue()
  if self.ctx:CheckTeamOpenerType(TeamOpenerType.EightPets) then
    local txt = self:GetTeamConcition()
    if txt then
      self._eightFightTipsGo:SetActive(true)
      self._eightPetConditionTxt:RefreshText(StringTable.Get(txt))
    else
      self._eightFightTipsGo:SetActive(false)
    end
  else
    self._eightFightTipsGo:SetActive(false)
  end
  self:SetClearBtnStatus()
  self:InitTopBtns()
  self:CalcPetScrollViewCount()
  self:_InitSrollView()
  self._firstIn = false
  self:FlushFiltRateRed()
  self:FastTeamLayout()
  self:SetFilterFavImgActive()
end

function UITeamChangeController:FastTeamLayout()
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

function UITeamChangeController:GetHelpPets()
  local helpPetModule = self:GetModule(HelpPetModule)
  local _elements = {
    [1] = ElementType.ElementType_Blue,
    [2] = ElementType.ElementType_Red,
    [3] = ElementType.ElementType_Green,
    [4] = ElementType.ElementType_Yellow
  }
  local _info = {}
  local pets = {}
  for i = 1, #_elements do
    local elem = _elements[i]
    _info[i] = helpPetModule:UI_FindSupportPet(elem)
    pets[elem] = _info[i] and _info[i].m_nPstID or 0
  end
  return pets
end

function UITeamChangeController:HelpPetBranch()
  local pets = self:GetHelpPets()
  self._sortType = PetSortType.Level
  self._sortOrder = PetSortOrder.Descending
  self._slot = self.helpPetElementType
  self._add = false
  if self.ctx:IsFastSelect() then
    self._add = true
  elseif pets[self._slot] == 0 then
    self._add = true
  end
  self._petModule = GameGlobal.GetModule(PetModule)
  local sortFilterCfg
  self._towerTip:SetText("")
  self._towerGo:SetActive(false)
  self._airGo:SetActive(false)
  self._seasonGo:SetActive(false)
  sortFilterCfg = UISortFilterCfg.HelpPetSelf
  local element = self.helpPetElementType
  local cfg = {
    [ElementType.ElementType_Blue] = PetFilterType.MainElementBlue,
    [ElementType.ElementType_Red] = PetFilterType.MainElementRed,
    [ElementType.ElementType_Green] = PetFilterType.MainElementGreen,
    [ElementType.ElementType_Yellow] = PetFilterType.MainElementYellow
  }
  self._filterParams = {
    PetFilterParam:New(cfg[element], PetFilterTag.ShuXing)
  }
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
  self:SetElementSortDefaultParam()
  if self._petModule._sortParam ~= nil then
    sortParams = self._petModule._sortParam
  end
  self._pets = self._petModule:_SortPets(self._petModule:GetPets(), self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  if self.ctx.teamOpenerType == TeamOpenerType.Diff then
    self._pets = self:DiffFilterPets(self._pets)
  elseif self.ctx.teamOpenerType == TeamOpenerType.Sailing then
    self._pets = self:SailingFilterPets(self._pets)
  elseif self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
    self._pets = self:DiffFilterPets(self._pets)
  end
  self._pstidTab = {}
  if not self._add then
    local tabItem = {}
    tabItem.pstid = pets[self._slot]
    tabItem.del = true
    table.insert(self._pstidTab, tabItem)
  end
  local teamLookup = {}
  for i = 1, #pets do
    local pstid = pets[i]
    teamLookup[pstid] = pstid
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
end

function UITeamChangeController:NormalBranch()
  self._sortType = PetSortType.Level
  self._sortOrder = PetSortOrder.Descending
  if self.ctx.teamOpenerType == TeamOpenerType.Maze then
    local teams = self.ctx:GetMazeTeam()
    local team = teams.list[self.ctx.mazeTeamId]
    self._team = team:Clone()
  elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonMaze then
    local teams = self.ctx:Teams()
    local team = teams.list[self.ctx:GetCurrTeamId()]
    self._team = team:Clone()
  else
    self._team = self.ctx.tmpTeam:Clone()
  end
  self._slot = self.ctx.curSlot
  self._add = false
  local hpm = self:GetModule(HelpPetModule)
  local helpPetKey = hpm:UI_GetHelpPetKey()
  if self.ctx:IsFastSelect() then
    self._add = true
  elseif self._team.pets[self._slot] == 0 then
    if 0 < helpPetKey and self._slot == self._slotHelpPet then
      self._add = false
    else
      self._add = true
    end
  end
  if 0 < helpPetKey then
    self._team.pets[self._slotHelpPet] = 0
  end
  self._petModule = self:GetModule(PetModule)
  self._roleModule = self:GetModule(RoleModule)
  local sortFilterCfg
  if self.ctx.teamOpenerType == TeamOpenerType.Tower then
    sortFilterCfg = UISortFilterCfg.TowerTeam
    local element = self.ctx:GetTowerElement()
    if 4 < element then
      element = element - 4
    end
    local cfg = {
      [ElementType.ElementType_Blue] = PetFilterType.MainElementBlue,
      [ElementType.ElementType_Red] = PetFilterType.MainElementRed,
      [ElementType.ElementType_Green] = PetFilterType.MainElementGreen,
      [ElementType.ElementType_Yellow] = PetFilterType.MainElementYellow
    }
    self._filterParams = {
      PetFilterParam:New(cfg[element], PetFilterTag.ShuXing)
    }
    local ceiling = self.ctx:GetTowerTeamCeiling()
    local tip = StringTable.Get("str_tower_formation_cond") .. ":"
    if element == ElementType.ElementType_Blue then
      tip = tip .. string.format(StringTable.Get("str_tower_formation_water"), ceiling)
    elseif element == ElementType.ElementType_Red then
      tip = tip .. string.format(StringTable.Get("str_tower_formation_fire"), ceiling)
    elseif element == ElementType.ElementType_Green then
      tip = tip .. string.format(StringTable.Get("str_tower_formation_wood"), ceiling)
    elseif element == ElementType.ElementType_Yellow then
      tip = tip .. string.format(StringTable.Get("str_tower_formation_thunder"), ceiling)
    end
    self._towerTip:SetText(tip)
    self._towerGo:SetActive(true)
  elseif self.ctx.teamOpenerType == TeamOpenerType.Maze then
    self._sortType = PetSortType.Star
    sortFilterCfg = UISortFilterCfg.MazeTeam
    self._filterParams = {}
    self._towerGo:SetActive(false)
  elseif self.ctx.teamOpenerType == TeamOpenerType.WorldBoss then
    self._sortType = PetSortType.WorldBossRecord
    sortFilterCfg = UISortFilterCfg.WorldBossTeam
    self._filterParams = {}
    self._towerTip:SetText(StringTable.Get("str_world_boss_team_tips"))
    self._towerGo:SetActive(true)
  elseif self.ctx.teamOpenerType == TeamOpenerType.PopStarPro then
    self._sortType = PetSortType.PopstarPro
    sortFilterCfg = UISortFilterCfg.NormalTeam
    self._filterParams = {}
    self._towerGo:SetActive(false)
  elseif self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
    self._sortType = PetSortType.PopstarPro
    sortFilterCfg = UISortFilterCfg.NormalTeam
    self._filterParams = {}
    self._towerGo:SetActive(false)
  else
    sortFilterCfg = UISortFilterCfg.NormalTeam
    self._filterParams = {}
    self._towerGo:SetActive(false)
  end
  self._airGo:SetActive(self.ctx.teamOpenerType == TeamOpenerType.Air)
  self:_CheckSeasonTips()
  self:_CheckCamPaignTips()
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
  if self.ctx.teamOpenerType == TeamOpenerType.Maze then
    sortParams = {}
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.Die, PetSortOrder.Descending))
  elseif self.ctx.teamOpenerType == TeamOpenerType.Air then
    sortParams = {}
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.AirSwitchCount, PetSortOrder.Descending))
  elseif self.ctx.teamOpenerType == TeamOpenerType.WorldBoss then
    sortParams = {}
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.WorldBossRecord, PetSortOrder.Descending))
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
  if self.ctx.teamOpenerType == TeamOpenerType.Vampire then
    local pets = self:InitVampairPets()
    self._pets = self._petModule:_SortPets(pets, self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  else
    local oriAllPets = self._petModule:GetPets()
    local allPets = self:ProcessPetsEnhance(oriAllPets)
    self._pets = self._petModule:_SortPets(allPets, self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  end
  if self.ctx.teamOpenerType == TeamOpenerType.SeasonMaze then
  end
  if self.ctx.teamOpenerType ~= TeamOpenerType.Tower then
    self._petModule:SavePetSortInfo(self._filterParams, self._sortOrder, self._sortType, savedSortParams)
  end
  if self.ctx.teamOpenerType == TeamOpenerType.Diff then
    self._pets = self:DiffFilterPets(self._pets)
  elseif self.ctx.teamOpenerType == TeamOpenerType.Sailing then
    self._pets = self:SailingFilterPets(self._pets)
  elseif self.ctx.teamOpenerType == TeamOpenerType.Vampire then
  elseif self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
    self._pets = self:DiffFilterPets(self._pets)
  end
  self._pstidTab = {}
  if not self._add then
    local tabItem = {}
    tabItem.pstid = self._team.pets[self._slot]
    tabItem.del = true
    tabItem.help = 0 < helpPetKey and self._slot == self._slotHelpPet
    table.insert(self._pstidTab, tabItem)
  end
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  local fromMain = ctx.teamOpenerType == TeamOpenerType.Main
  local isLock = not self._roleModule:CheckModuleUnlock(GameModuleID.MD_HelpPet)
  if not self._disableHelpPetSlot and not isLock and self._slot == self._slotHelpPet and not fromMain then
    local cfg = Cfg.cfg_level
    local tabItem = {}
    tabItem.pstid = self._team.pets[self._slot]
    tabItem.helppet = self.helpPetState
    table.insert(self._pstidTab, tabItem)
  end
  local teamLookup = {}
  for i = 1, #self._team.pets do
    local pstid = self._team.pets[i]
    teamLookup[pstid] = pstid
  end
  if self.ctx:IsFastSelect() then
    teamLookup = {}
    if not self._disableHelpPetSlot and 0 < helpPetKey then
      local tabItem = {}
      tabItem.pstid = self._team.pets[self._slotHelpPet]
      tabItem.help = true
      tabItem.memId = self._slotHelpPet
      table.insert(self._pstidTab, tabItem)
    end
  end
  for i = 1, #self._pets do
    local pet = self._pets[i]
    local pstid = pet:GetPstID()
    if self.ctx.teamOpenerType == TeamOpenerType.Vampire then
      pstid = pet:GetTemplateID()
    end
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

function UITeamChangeController:InitVampairPets()
  local petList = UIN25VampireUtil.GetTryPetList(UIN25VampireUtil.GetComponentConfigId())
  if petList then
    local petTabs = self._petModule:GetPetTabs()
    local pets = self._petModule:GetPets()
    local resultPets = {}
    for k, v in pairs(pets) do
      resultPets[k] = v
    end
    for i = 1, #petList do
      local tmpId = petList[i]
      if not petTabs[tmpId] then
        local pet = UIN25VampireUtil.CreatePetData(tmpId)
        if pet then
          resultPets[tmpId] = pet
        end
      end
    end
    return resultPets
  end
  return self._petModule:GetPets()
end

function UITeamChangeController:OnShow(uiParams)
  self.helpPetBranch = uiParams[1]
  self.helpPetCallBack = uiParams[2]
  self.helpPetElementType = uiParams[3]
  self.helpPetState = uiParams[4] or 0
  self._missionModule = self:GetModule(MissionModule)
  self.ctx = self._missionModule:TeamCtx()
  if self.ctx.teamOpenerType == TeamOpenerType.Main then
    self.helpPetState = nil
  end
  self._disableHelpPetSlot = self.ctx:CheckTeamOpenerType(TeamOpenerType.EightPets)
  self:GetComponents()
  if self.helpPetBranch then
    self.ctx:Init(TeamOpenerType.Main, 0)
    self:HelpPetBranch()
  else
    self:NormalBranch()
  end
  self:OnValue()
  self:AttacEvents()
end

function UITeamChangeController:AttacEvents()
  self:AttachEvent(GameEventType.PetUpLevelEvent, self.RefrenshPetList)
  self:AttachEvent(GameEventType.PetUpGradeEvent, self.RefrenshPetList)
  self:AttachEvent(GameEventType.OnPetFilterTypeChange, self.OnPetFilterTypeChange)
  self:AttachEvent(GameEventType.OnPetSkinChange, self.RefrenshPetList)
end

function UITeamChangeController:InitTopBtns()
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
  local targetPos = Vector2(-topBtnsWidth - 70, self._clearFilterBtn.transform.localPosition.y)
  self._topRightRect.anchoredPosition = targetPos
end

function UITeamChangeController:ChangeSortParams(idx)
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

function UITeamChangeController:FlushTopBtnState()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:Flush(self._sortType, self._sortOrder, self._petModule.PetSortElementIndex)
  end
end

function UITeamChangeController:OnHide()
  self:DetachEvent(GameEventType.OnPetFilterTypeChange, self.OnPetFilterTypeChange)
end

function UITeamChangeController:_InitSrollView()
  self._scrollView:InitListView(self._listShowItemCount, function(scrollView, index)
    return self:InitSpritListInfo(scrollView, index)
  end, self:GetScrollViewParam())
end

function UITeamChangeController:GetScrollViewParam()
  local param = UIDynamicScrollViewInitParam:New()
  param.mItemDefaultWithPaddingSize = 333
  return param
end

function UITeamChangeController:InitSpritListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UITeamChangeItem", self._itemCountPerRow)
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

function UITeamChangeController:NormalShowHeartClick(pstid, del)
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
    if self.ctx.teamOpenerType == TeamOpenerType.Air then
      local airModule = GameGlobal.GetModule(AircraftModule)
      local room = airModule:GetRoomByRoomType(AirRoomType.TacticRoom)
      local switchCount = room:GetPetRemainFightNum(pstid)
      if switchCount <= 0 then
        local tips = StringTable.Get("str_aircraft_tactic_pet_count_zero_click_tips")
        ToastManager.ShowToast(tips)
        Log.debug("###[UITeamChangeController] choose switch count <= 0 pet !")
        return
      end
    end
    if self.ctx.teamOpenerType == TeamOpenerType.SeasonMaze then
      local pet = self._petModule:GetPet(pstid)
      pets[self._slot] = pet:GetTemplateID()
    else
      pets = self:SetTeamData(pets, pstid)
    end
  end
  if self.ctx.teamOpenerType == TeamOpenerType.Vampire then
  end
  local pet = self._petModule:GetPet(pstid)
  local petresid = 0
  if pet then
    petresid = pet:GetTemplateID()
  end
  if self.ctx.teamOpenerType == TeamOpenerType.Vampire then
    petresid = pstid
  end
  self:Lock("UITeamChangeController")
  self:StartTask(self._OnChangeTeam, self, petresid, del, pets)
end

function UITeamChangeController:SetTeamData(pets, pstid)
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

function UITeamChangeController:IsBinderPet(pstid_old, pstid_new)
  if pstid_old and pstid_new then
    local pet_old = self._petModule:GetPet(pstid_old)
    local pet_new = self._petModule:GetPet(pstid_new)
    if self.ctx.teamOpenerType == TeamOpenerType.Vampire then
      pet_old = UIN25VampireUtil.CreatePetData(pstid_old)
      pet_new = UIN25VampireUtil.CreatePetData(pstid_new)
    end
    local tid_old = pet_old:GetTemplateID()
    local tid_new = pet_new:GetTemplateID()
    return self:CheckBinderID(tid_old, tid_new), pet_old:GetPetName(), pet_new:GetPetName()
  end
end

function UITeamChangeController:CheckBinderID(tida, tidb)
  if tida == tidb then
    return true
  end
  local cfg = Cfg.cfg_pet({})
  if cfg then
    local cfga = cfg[tida]
    local cfgb = cfg[tidb]
    if not cfga then
      Log.error("###[UITeamChangeController] cfga is nil ! id --> ", tida)
      return
    end
    if not cfgb then
      Log.error("###[UITeamChangeController] cfgb is nil ! id --> ", tidb)
      return
    end
    if cfga.BinderPetID and cfgb.BinderPetID and cfga.BinderPetID == cfgb.BinderPetID then
      return true
    end
  end
end

function UITeamChangeController:HelpPetShowHeartClick(pstid, del)
  if self.helpPetCallBack then
    local pet = self._petModule:GetPet(pstid)
    local petTempId = pet:GetTemplateID()
    local element = pet:GetPetFirstElement()
    local isAdd = true
    if del then
      isAdd = false
    end
    self.helpPetCallBack(petTempId, element, isAdd)
  end
end

function UITeamChangeController:HelpPetShowHeartLongPress(pstid)
end

function UITeamChangeController:NormalShowHeartLongPress(pstid)
  if self.ctx.teamOpenerType == TeamOpenerType.Vampire then
    local pet = self._petModule:GetPet(pstid)
    if pet then
      self:VampireShowPetInfo(pet:GetTemplateID())
    else
      self:VampireShowPetInfo(pstid)
    end
  else
    local pet = self._petModule:GetPet(pstid)
    if pet then
      local pstids = {}
      table.insert(pstids, pstid)
      self._petModule.uiModule:SetTeamPets(pstids)
      local petid = self._petModule:GetPet(pstid):GetTemplateID()
      self:ShowDialog("UISpiritDetailGroupController", petid)
    end
  end
end

function UITeamChangeController:VampireShowPetInfo(petid)
  local cfgs = Cfg.cfg_component_bloodsucker_pet_attribute({
    ComponentID = UIN25VampireUtil.GetComponentConfigId(),
    PetId = petid
  })
  local customPetData
  for _, cfg in pairs(cfgs) do
    local petData = MatchPetInfo:New()
    petData.pet_pstid = petid
    petData.awakening = cfg.Awakening
    petData.level = 1
    petData.grade = cfg.Grade
    petData.equip_lv = cfg.Equip
    petData.template_id = cfg.PetId
    petData.attack = cfg.Attack
    petData.max_hp = cfg.Hp
    petData.defense = cfg.Def
    customPetData = Pet:New(petData)
    
    function customPetData.IsShowBtnInfo()
      return true
    end
    
    function customPetData.GetBtnInfoCallback()
      GameGlobal.UIStateManager():ShowDialog("UIN25VampireTips")
    end
    
    function customPetData.GetBtnInfoName()
      return "N25_mcwf_btn6"
    end
    
    break
  end
  local customPetDatas = {}
  table.insert(customPetDatas, customPetData)
  self._petModule.uiModule:SetTeamCustomPets(customPetDatas)
  self:ShowDialog("UISpiritDetailGroupController", petid, false, customPetData)
end

function UITeamChangeController:ShowHeartItem(heartItem, index)
  local tabItem = self._pstidTab[index]
  heartItem:GetGameObject():SetActive(true)
  table.insert(self.items, heartItem)
  self._dicItems[heartItem:GetGameObject():GetInstanceID()] = heartItem
  local teamType = self.ctx.teamOpenerType
  if self.helpPetBranch then
    teamType = TeamOpenerType.Stage
  end
  local fastClickItem = heartItem
  heartItem:SetData(tabItem, function(pstid, del, helppetstate, slot)
    if helppetstate then
      if helppetstate == 1 then
        self:ShowDialog("UIHelpPetSelectController")
      elseif helppetstate == 0 then
        ToastManager.ShowToast(StringTable.Get("str_help_pet_cgkwfsyzzgl"))
      end
      return
    end
    if self.helpPetBranch then
      self:HelpPetShowHeartClick(pstid, del)
    elseif self.ctx:IsFastSelect() then
      self:FastSelectHeartClick(fastClickItem, pstid, del, helppetstate, slot)
    else
      local hpm = self:GetModule(HelpPetModule)
      hpm.m_nCurFreshTeamID = 0
      local petModule = self:GetModule(PetModule)
      if not self._disableHelpPetSlot and slot == self._slotHelpPet then
        if 0 < hpm:UI_GetHelpPetKey() then
          hpm:UI_ClearHelpPet()
          if del then
            self:CloseUITeamsMemberSelect()
            GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
            return
          end
        end
      elseif 0 < hpm:UI_GetHelpPetKey() then
        local helpPet = hpm:UI_GetSelectHelpPet()
        if helpPet then
          local selfPet = petModule:GetPet(pstid)
          if selfPet then
            if selfPet:GetTemplateID() == helpPet.m_nTemplateID then
              ToastManager.ShowToast(StringTable.Get("str_help_pet_yczxx", StringTable.Get(selfPet:GetPetName())))
              return
            elseif self:CheckBinderID(selfPet:GetTemplateID(), helpPet.m_nTemplateID) then
              local namea = StringTable.Get(selfPet:GetPetName())
              local nameb = StringTable.Get(Cfg.cfg_pet[helpPet.m_nTemplateID].Name)
              local tips = StringTable.Get("str_team_change_binder_toast_tips", namea, nameb)
              ToastManager.ShowToast(tips)
              hpm:UI_ClearHelpPet()
            end
          end
        end
      end
      self:NormalShowHeartClick(pstid, del)
    end
  end, function(pstid)
    if self.helpPetBranch then
      self:HelpPetShowHeartLongPress(pstid)
    else
      self:NormalShowHeartLongPress(pstid)
    end
  end, self._scrollRect, self._firstIn, teamType, self._slot)
end

function UITeamChangeController:_OnChangeTeam(TT, petResId, del, pets)
  if self.ctx.teamOpenerType == TeamOpenerType.Tower then
    local module = self:GetModule(TowerModule)
    local team = self._team:Clone()
    team.pets = pets
    local res, mul_formations = self.ctx:ReqTowerChangeMulFormationInfo(TT, team)
    if res:GetSucc() then
      self.ctx:InitTowerTeam(mul_formations)
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    else
      ToastManager.ShowToast(module:GetErrorMsg(res:GetResult()))
    end
    self:UnLock("UITeamChangeController")
  elseif self.ctx.teamOpenerType == TeamOpenerType.Maze then
    local mazeModule = self:GetModule(MazeModule)
    local res, data = mazeModule:UpdateMazeFormationInfo(TT, self._team.id, self._team.name, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self.ctx:InitMazeTeam(data)
      local teams = self.ctx:Teams()
      self._team.pets = pets
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    else
      local result = res:GetResult()
      ToastManager.ShowToast(mazeModule:GetErrorMsg(result))
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.Trail then
    local talePetModule = GameGlobal.GetModule(TalePetModule)
    local res = talePetModule:UpdateMainFormationInfo(TT, self._team.id, self._team.name, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.WorldBoss then
    local worldBossModule = GameGlobal.GetModule(WorldBossModule)
    local res = worldBossModule:ReqWorldBossChangeFormationInfo(TT, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.Diff then
    local diffModule = GameGlobal.GetModule(DifficultyMissionModule)
    local param = self.ctx.param
    local nodeid = param[1]
    local stageid = param[2]
    if GameSingle then
      self:UnLock("UITeamChangeController")
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
      return
    end
    local res = diffModule:HandleChangeFormation(TT, nodeid, stageid, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    else
      Log.error("### team change diff result -- ", res:GetResult())
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.Sailing then
    local sailingMissionModule = GameGlobal.GetModule(SailingMissionModule)
    local param = self.ctx.param
    local layerId = param[1]
    local missionId = param[2]
    local res = sailingMissionModule:HandleChangeFormation(TT, layerId, missionId, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    else
      Log.error("### team change diff result -- ", res:GetResult())
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.Vampire then
    local result, hasExpire = UIN25VampireUtil.SaveTeamInfo(TT, pets)
    self:UnLock("UITeamChangeController")
    if result then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.Air then
    local airModule = GameGlobal.GetModule(AircraftModule)
    local res, data = airModule:RequestChangeTacticFormationInfo(TT, self._team.id, self._team.name, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    else
      local result = res:GetResult()
      Log.error("###[UITeamChangeController] RequestChangeTacticFormationInfo fail ! result --> ", result)
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.N21CC then
    local result = UIActivityN4CCHelper.SaveTeamInfo(TT, self._team.id, self._team.name, pets)
    self:UnLock("UITeamChangeController")
    if result then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
    local param = self.ctx.param
    local diffCpt = param[5]
    local nodeid = param[1]
    local stageid = param[2]
    local res = diffCpt:HandleDifficultyChangeFormation(TT, AsyncRequestRes:New(), nodeid, stageid, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    else
      Log.fatal("### 更新活动高难关编队失败:", res:GetResult())
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.EightPets then
    local res = UIN33EightPetsTeamsContext:UpdateFormationInfoTT(TT, self._team.id, self._team.name, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      UIN33EightPetsTeamsContext:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.Season then
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    local res = seasonModule:ReqSeasonChangeFormationInfo(TT, self._team.id, self._team.name, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonMaze then
    local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
    local res = seasonMazeModule:ReqSeasonMazeChangeFormationInfo(TT, self._team.id, self._team.name, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.PopStarPro then
    local param = self.ctx.param
    local linePopStarCpt = param[6]
    local res = AsyncRequestRes:New()
    local tb = {
      id = self._team.id,
      name = self._team.name,
      pet_list = pets
    }
    linePopStarCpt:HandleLinePopStarChangeFormation(TT, res, tb)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      self.ctx.popStarTeam:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
    local anipopModule = GameGlobal.GetModule(AnipopModule)
    local res, info = anipopModule:UpdateAnipopFormationInfo(TT, self._team.id, self._team.name, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      self.ctx.aniPopStarTeam:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonOnceMission then
    local cpt = self.ctx.param[4]
    local teamInfo = LineFormationItem:New()
    teamInfo.id = self._team.id
    teamInfo.name = self._team.name
    teamInfo.pet_list = pets
    local res = AsyncRequestRes:New()
    res:SetSucc(false)
    cpt:HandleLineChangeFormationReq(TT, res, teamInfo)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    else
      Log.fatal("### 赛季一次性战斗关选人失败 ")
    end
  else
    if GameSingle then
      self:UnLock("UITeamChangeController")
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
      if not del then
        GameGlobal.GetModule(PetAudioModule):PlayPetAudio("Formation", petResId)
      end
      return
    end
    local res = self._missionModule:UpdateMainFormationInfo(TT, self._team.id, self._team.name, pets)
    self:UnLock("UITeamChangeController")
    if res:GetSucc() then
      self._team.pets = pets
      local teams = self.ctx:Teams()
      teams:UpdateTeam(self._team)
      self:CloseUITeamsMemberSelect()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryChangeTeamData, self._team.id)
    end
  end
  if not del then
    GameGlobal.GetModule(PetAudioModule):PlayPetAudio("Formation", petResId)
  end
end

function UITeamChangeController:CloseUITeamsMemberSelect()
  if self.ctx.teamOpenerType == TeamOpenerType.Maze then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Stage then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.ExtMission then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Tower then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Main then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.ResInstance then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Trail then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Sailing then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Vampire then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Campaign then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.LostLand then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Conquest then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Air then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.WorldBoss then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.N21CC then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.BlackFist then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Diff then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.EightPets then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.Season then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.PopStarPro then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonOnceMission then
    self:CloseDialog()
  elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonMaze then
    self:CloseDialog()
  else
    self:SwitchState(UIStateType.UITeams)
  end
  if self._isBinderData then
    local namea = StringTable.Get(self._isBinderData.peta)
    local nameb = StringTable.Get(self._isBinderData.petb)
    local tips = StringTable.Get("str_team_change_binder_toast_tips", nameb, namea)
    ToastManager.ShowToast(tips)
  end
end

function UITeamChangeController:CalcPetScrollViewCount()
  self._petCount = table.count(self._pstidTab)
  self._listShowItemCount = math.ceil(self._petCount / self._itemCountPerRow)
  self:CheckEmptyTip()
end

function UITeamChangeController:CheckEmptyTip()
  if self._petCount <= 0 then
    self._emptyDataTip:SetActive(true)
  else
    self._emptyDataTip:SetActive(false)
  end
end

function UITeamChangeController:RefrenshPetList_HelpPetBranch()
  local sortParams = {}
  local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
  if self.ctx.teamOpenerType == TeamOpenerType.Maze then
    if self._sortType == PetSortType.Health then
      tempParams = PetDefaulSort[PetSortType.MazeHealth][self._sortOrder]
    end
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.Die, PetSortOrder.Descending))
  elseif self.ctx.teamOpenerType == TeamOpenerType.WorldBoss then
    if self._sortType == PetSortType.WorldBossRecord then
      tempParams = PetDefaulSort[PetSortType.WorldBossRecord][self._sortOrder]
    end
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.WorldBossRecord, PetSortOrder.Descending))
  elseif self.ctx.teamOpenerType == TeamOpenerType.Air then
    sortParams = {}
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.AirSwitchCount, PetSortOrder.Descending))
  elseif self.ctx.teamOpenerType == TeamOpenerType.PopStarPro then
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.PopstarPro, PetSortOrder.Descending))
  elseif self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.PopstarPro, PetSortOrder.Descending))
  else
    sortParams = tempParams
  end
  if self._sortType == PetSortType.Element then
    sortParams = PetDefaulSort[self._elementSortTypeOrder[self._currentElementSortTypeOrder]][PetSortOrder.Descending]
  end
  self._pets = self._petModule:_SortPets(self._petModule:GetPets(), self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  self._petModule:SavePetSortInfo(self._filterParams, self._sortOrder, self._sortType, sortParams)
  if self.ctx.teamOpenerType == TeamOpenerType.Diff then
    self._pets = self:DiffFilterPets(self._pets)
  elseif self.ctx.teamOpenerType == TeamOpenerType.Sailing then
    self._pets = self:SailingFilterPets(self._pets)
  elseif self.ctx.teamOpenerType == TeamOpenerType.Vampire then
  elseif self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
    self._pets = self:DiffFilterPets(self._pets)
  end
  local pets = self:GetHelpPets()
  self._pstidTab = {}
  if not self._add then
    local tabItem = {}
    tabItem.pstid = pets[self._slot]
    tabItem.del = true
    table.insert(self._pstidTab, tabItem)
  end
  local teamLookup = {}
  for i = 1, #pets do
    local pstid = pets[i]
    teamLookup[pstid] = pstid
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
end

function UITeamChangeController:RefrenshPetList_NormalBranch()
  local sortParams = {}
  local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
  if self.ctx.teamOpenerType == TeamOpenerType.Maze then
    if self._sortType == PetSortType.Health then
      tempParams = PetDefaulSort[PetSortType.MazeHealth][self._sortOrder]
    end
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.Die, PetSortOrder.Descending))
  elseif self.ctx.teamOpenerType == TeamOpenerType.WorldBoss then
    if self._sortType == PetSortType.WorldBossRecord then
      tempParams = PetDefaulSort[PetSortType.WorldBossRecord][self._sortOrder]
    end
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.WorldBossRecord, PetSortOrder.Descending))
  elseif self.ctx.teamOpenerType == TeamOpenerType.Air then
    sortParams = {}
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.AirSwitchCount, PetSortOrder.Descending))
  elseif self.ctx.teamOpenerType == TeamOpenerType.PopStarPro then
    sortParams = {}
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.PopstarPro, PetSortOrder.Descending))
  elseif self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
    sortParams = {}
    local tempParams = PetDefaulSort[self._sortType][self._sortOrder]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    table.insert(sortParams, 1, PetSortParam:New(PetSortType.PopstarPro, PetSortOrder.Descending))
  else
    sortParams = tempParams
  end
  if self._sortType == PetSortType.Element then
    local tempParams = PetDefaulSort[self._elementSortTypeOrder[self._currentElementSortTypeOrder]][PetSortOrder.Descending]
    for i = 1, #tempParams do
      local param = tempParams[i]
      sortParams[i] = param
    end
    if self.ctx.teamOpenerType == TeamOpenerType.WorldBoss then
      table.insert(sortParams, 1, PetSortParam:New(PetSortType.WorldBossRecord, PetSortOrder.Descending))
    end
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
  if self.ctx.teamOpenerType == TeamOpenerType.Vampire then
    local pets = self:InitVampairPets()
    self._pets = self._petModule:_SortPets(pets, self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  else
    local oriAllPets = self._petModule:GetPets()
    local allPets = self:ProcessPetsEnhance(oriAllPets)
    self._pets = self._petModule:_SortPets(allPets, self._filterParams, sortParams, self._petModule.PetSortChooseSecondAttribute)
  end
  self._petModule:SavePetSortInfo(self._filterParams, self._sortOrder, self._sortType, savedSortParams)
  if self.ctx.teamOpenerType == TeamOpenerType.Diff then
    self._pets = self:DiffFilterPets(self._pets)
  elseif self.ctx.teamOpenerType == TeamOpenerType.Sailing then
    self._pets = self:SailingFilterPets(self._pets)
  elseif self.ctx.teamOpenerType == TeamOpenerType.Vampire then
  elseif self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
    self._pets = self:DiffFilterPets(self._pets)
  end
  self._pstidTab = {}
  local hpm = self:GetModule(HelpPetModule)
  local helpPetKey = hpm:UI_GetHelpPetKey()
  if not self._add then
    local tabItem = {}
    tabItem.pstid = self._team.pets[self._slot]
    tabItem.del = true
    tabItem.help = 0 < helpPetKey and self._slot == self._slotHelpPet
    table.insert(self._pstidTab, tabItem)
  end
  local isUnlock = self._roleModule:CheckModuleUnlock(GameModuleID.MD_HelpPet)
  if isUnlock and self._slot == self._slotHelpPet and self.helpPetState then
    local cfg = Cfg.cfg_level
    local tabItem = {}
    tabItem.pstid = self._team.pets[self._slot]
    tabItem.helppet = self.helpPetState
    table.insert(self._pstidTab, tabItem)
  end
  local teamLookup = {}
  for i = 1, #self._team.pets do
    local pstid = self._team.pets[i]
    teamLookup[pstid] = pstid
  end
  if self.ctx:IsFastSelect() then
    teamLookup = {}
    if 0 < helpPetKey then
      local tabItem = {}
      tabItem.pstid = self._team.pets[self._slotHelpPet]
      tabItem.help = true
      tabItem.memId = self._slotHelpPet
      table.insert(self._pstidTab, tabItem)
    end
  end
  for i = 1, #self._pets do
    local pet = self._pets[i]
    local pstid = pet:GetPstID()
    if self.ctx.teamOpenerType == TeamOpenerType.Vampire then
      pstid = pet:GetTemplateID()
    end
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

function UITeamChangeController:RefrenshPetList()
  self._currentElementSortTypeOrder = self._petModule.PetSortElementIndex
  if self.helpPetBranch then
    self:RefrenshPetList_HelpPetBranch()
  else
    self:RefrenshPetList_NormalBranch()
  end
  self:CalcPetScrollViewCount()
  self.items = {}
  self._scrollView:SetListItemCount(self._listShowItemCount)
  self._scrollView:MovePanelToItemIndex(0, 0)
end

function UITeamChangeController:btnFiltrateOnClick(go)
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
  self._petModule:ClickPetEquipRefine()
  self:FlushFiltRateRed()
end

function UITeamChangeController:OnSortFilterChanged(sortType, sortOrder, filterParams)
  self._sortType = sortType
  self._sortOrder = sortOrder
  self._filterParams = filterParams
  self:FlushTopBtnState()
  self:RefrenshPetList()
end

function UITeamChangeController:CloseFiterCallBack()
  self._sortFilterActiveStatus = false
  self:SetClearBtnStatus()
end

function UITeamChangeController:GetPetItem(petTempId)
  for index, value in ipairs(self.items) do
    if value.pet:GetTemplateID() == petTempId then
      return value:GetGameObject("btn")
    end
  end
  return nil
end

function UITeamChangeController:GetPetItemHP(_index)
  for index, value in ipairs(self.items) do
    if index == _index then
      return value.heartItem:GetGameObject("hpbg")
    end
  end
  return nil
end

function UITeamChangeController:GetScroll()
  return self._scrollRect
end

function UITeamChangeController:GetHelpPetItem()
  for _, value in ipairs(self.items) do
    if value:GetHelpPetState() then
      return value:GetGameObject("btn")
    end
  end
  return nil
end

function UITeamChangeController:SelectTeamItem(nIndex)
  local uiTeamItem = self.items[nIndex]
  if nil == uiTeamItem then
    return
  end
  uiTeamItem:bgOnClick()
end

function UITeamChangeController:clearFilterBtnOnClick()
  if self._sortFilterActiveStatus == false then
    self._clearFilterBtn:SetActive(false)
    self._curSortStateIcon.sprite = self._atlas:GetSprite("spirit_jiantou_b_1_frame")
  end
  self._petModule:ClearPetSortFilterInfo()
  if self.helpPetBranch then
    self:HelpPetBranch()
  else
    self:NormalBranch()
  end
  self._isFilterFavPet = false
  self:SetFilterFavImgActive()
  self:FlushTopBtnState()
  self:RefrenshPetList()
  if self._sortFilter then
    self._sortFilter:ClearFilters()
  end
  self._refineTip:SetActive(false)
end

function UITeamChangeController:SetClearBtnStatus()
  if self._isFilterFavPet and self._filterParams and #self._filterParams == 1 then
    self._curSortStateIcon.sprite = self._atlas:GetSprite("spirit_jiantou_b_1_frame")
    self._clearFilterBtn:SetActive(false)
    return
  end
  if not self._petModule:CheckHasCachePetSortInfo(self.ctx.teamOpenerType == TeamOpenerType.Tower) then
    self._curSortStateIcon.sprite = self._atlas:GetSprite("spirit_jiantou_b_1_frame")
    self._clearFilterBtn:SetActive(false)
  else
    self._curSortStateIcon.sprite = self._atlas:GetSprite("spirit_jiantou_b_2_frame")
    self._clearFilterBtn:SetActive(true)
  end
end

function UITeamChangeController:TowerFilterCheck()
end

function UITeamChangeController:FilterFavBtnOnClick()
  self._isFilterFavPet = not self._isFilterFavPet
  if self._isFilterFavPet then
    if not self._filterParams then
      self._filterParams = {}
    end
    local filterParam = PetFilterParam:New(PetFilterType.Fav_Collect, PetFilterType.Fav_Collect)
    table.insert(self._filterParams, filterParam)
  elseif not self._filterParams then
    self._filterParams = {}
  else
    local removeIdx
    for index, value in ipairs(self._filterParams) do
      if value._filter_type == PetFilterType.Fav_Collect then
        removeIdx = index
        break
      end
    end
    if removeIdx then
      table.remove(self._filterParams, removeIdx)
    end
  end
  self:SetFilterFavImgActive()
  self:RefrenshPetList()
end

function UITeamChangeController:SetElementSortDefaultParam()
  if self._petModule.PetSortType ~= nil then
    self._sortType = self._petModule.PetSortType
  end
  if self._petModule.PetSortOrder ~= nil then
    self._sortOrder = self._petModule.PetSortOrder
  end
  if self._petModule.PetSortFilter ~= nil then
    self._filterParams = self._petModule.PetSortFilter
  end
  self:_CheckHasFilterFavPet()
end

function UITeamChangeController:_CheckHasFilterFavPet()
  if self._filterParams then
    for k, param in pairs(self._filterParams) do
      if param._filter_type == PetFilterType.Fav_Collect then
        self._isFilterFavPet = true
        return true
      end
    end
  end
  self._isFilterFavPet = false
end

function UITeamChangeController:DiffFilterPets(oriPets)
  local module = GameGlobal.GetUIModule(DifficultyMissionModule)
  local pets = oriPets
  local filterPets = module:GetFilterPets()
  local cantPets = {}
  local removeIdx = {}
  for i = 1, #self._pets do
    local pet = self._pets[i]
    local pstid = pet:GetPstID()
    if filterPets[pstid] then
      table.insert(cantPets, pet)
      table.insert(removeIdx, i)
    end
  end
  for i = #removeIdx, 1, -1 do
    local ridx = removeIdx[i]
    table.remove(self._pets, ridx)
  end
  for i = 1, #cantPets do
    local pet = cantPets[i]
    table.insert(self._pets, pet)
  end
  return pets
end

function UITeamChangeController:SailingFilterPets(oriPets)
  local sailingMissionModule = GameGlobal.GetModule(SailingMissionModule)
  local filterPets = sailingMissionModule:GetFilterPets()
  local pets = oriPets
  local cantPets = {}
  local removeIdx = {}
  for i = 1, #self._pets do
    local pet = self._pets[i]
    local pstid = pet:GetPstID()
    if filterPets[pstid] then
      table.insert(cantPets, pet)
      table.insert(removeIdx, i)
    end
  end
  for i = #removeIdx, 1, -1 do
    local ridx = removeIdx[i]
    table.remove(self._pets, ridx)
  end
  for i = 1, #cantPets do
    local pet = cantPets[i]
    table.insert(self._pets, pet)
  end
  return pets
end

function UITeamChangeController:HelpPetReplaceFormationPet(TT, helpPet, replacedPetPstID)
  local pets = {}
  for i = 1, #self._team.pets do
    if self._team.pets[i] == replacedPetPstID then
      pets[i] = 0
    else
      pets[i] = self._team.pets[i]
    end
  end
  local replacedPet = self._petModule:GetPet(replacedPetPstID)
  self._isBinderData = {}
  self._isBinderData.peta = replacedPet:GetPetName()
  self._isBinderData.petb = Cfg.cfg_pet[helpPet.m_nTemplateID].Name
  self:Lock("UITeamChangeController")
  self:_OnChangeTeam(TT, replacedPet:GetTemplateID(), true, pets)
end

function UITeamChangeController:OnPetFilterTypeChange(type, isAdd)
  if type == PetFilterType.Refine then
    local isSp = self.ctx.teamOpenerType == TeamOpenerType.WorldBoss
    isSp = isSp or self.ctx.teamOpenerType == TeamOpenerType.Tower
    isSp = isSp or self.ctx.teamOpenerType == TeamOpenerType.Air
    isSp = isSp or self.ctx.teamOpenerType == TeamOpenerType.EightPets
    isSp = isSp or self.ctx.teamOpenerType == TeamOpenerType.Season
    self._refineTip:SetActive(isAdd and not isSp)
  end
end

function UITeamChangeController:FlushFiltRateRed()
  self._redPoint:SetActive(self._petModule:PetEquipRefineNew())
end

function UITeamChangeController:ProcessPetsEnhance(oriAllPets)
  local outPets = {}
  if self.ctx.teamOpenerType == TeamOpenerType.Campaign then
    local ctxParam = self.ctx.param
    if ctxParam then
      local missionId = ctxParam[1]
      local missionComponentId
      if ctxParam[3] then
        local keyMap = ctxParam[3]
        missionComponentId = keyMap[ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId]
      end
      if missionComponentId then
        local campaignModule = GameGlobal.GetModule(CampaignModule)
        for pstid, oriPet in pairs(oriAllPets) do
          local usePet1, isEnhanced1 = campaignModule:ProcressCampaignPetEnhance(oriPet, missionId)
          local usePet2, isEnhanced2 = campaignModule:ProcressPetEnhance(oriPet, missionComponentId)
          if isEnhanced2 then
            outPets[pstid] = usePet2
          else
            outPets[pstid] = usePet1
          end
        end
      end
      return outPets
    end
    return oriAllPets
  elseif self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
    local ctxParam = self.ctx.param
    if ctxParam then
      local missionId = ctxParam[1]
      local diffCpt = ctxParam[5]
      if diffCpt then
        local missionComponentId = diffCpt:GetComponentCfgId()
        if missionComponentId then
          local campaignModule = GameGlobal.GetModule(CampaignModule)
          for pstid, oriPet in pairs(oriAllPets) do
            local usePet1, isEnhanced1 = campaignModule:ProcressCampaignPetEnhance(oriPet, missionId)
            local usePet2, isEnhanced2 = campaignModule:ProcressPetEnhance(oriPet, missionComponentId)
            if isEnhanced2 then
              outPets[pstid] = usePet2
            else
              outPets[pstid] = usePet1
            end
          end
        end
      end
      return outPets
    end
    return oriAllPets
  elseif self.ctx.teamOpenerType == TeamOpenerType.Season then
    self.ctx:GetCurrTeamId()
    local ctxParam = self.ctx.param
    if ctxParam then
      local missionId = ctxParam[1]
      local seasonModule = self:GetModule(SeasonModule)
      for pstid, oriPet in pairs(oriAllPets) do
        local usePet, isEnhanced = seasonModule:ProcressPetEnhance(oriPet, missionId)
        outPets[pstid] = usePet
      end
      return outPets
    end
    return oriAllPets
  else
    return oriAllPets
  end
end

function UITeamChangeController:GetPstidTab()
  if self._pstidTab == nil then
    self._pstidTab = {}
  end
  return self._pstidTab
end

function UITeamChangeController:FastSelectMemID(savedMemID)
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
  local pets = self._petModule:GetPets()
  for k, v in pairs(pets) do
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

function UITeamChangeController:FastSelectHeartClick(fastClickItem, pstid, del, helppetstate, slot)
  local tabItem = fastClickItem:GetTabItem()
  local savedmemId = tabItem.memId
  if tabItem.memId ~= nil and tabItem.help then
    local tips = StringTable.Get("str_discovery_hppet_cancel_pops")
    ToastManager.ShowToast(tips)
  elseif fastClickItem:IsBinderPet() then
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
  if self.ctx.teamOpenerType == TeamOpenerType.EightPets then
    UIN33EightPetsTeamsContext:UpdateFastTeam(self._pstidTab)
  end
  if savedmemId ~= tabItem.memId then
    for k, v in pairs(self._dicItems) do
      if v:GetGameObject().activeSelf then
        v:FastTeamChanged()
      end
    end
    local playVoice = false
    if tabItem.memId ~= nil and playVoice then
      local pet = self._petModule:GetPet(pstid)
      local petResId = 0
      if pet then
        petResId = pet:GetTemplateID()
      end
      if self.ctx.teamOpenerType == TeamOpenerType.Vampire then
        petResId = pstid
      end
      GameGlobal.GetModule(PetAudioModule):PlayPetAudio("Formation", petResId)
    end
  end
end

function UITeamChangeController:BtnFastConfirmOnClick(go)
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
  self:Lock("UITeamChangeController")
  self:StartTask(self._OnChangeTeam, self, petresid, del, pets)
end

function UITeamChangeController:GetTeamConcition()
  local param = self.ctx:GetParam()
  local eightID = param[4]
  local cfgEight = Cfg.cfg_component_eight_pets_mission[eightID]
  return cfgEight.TeamCondition
end

function UITeamChangeController:CancelBtnOnPress(go)
  for k, v in pairs(self._pstidTab) do
    if v.memId ~= nil and not v.help then
      v.memId = nil
    end
  end
  for k, v in pairs(self._dicItems) do
    if v:GetGameObject().activeSelf then
      local tabItem = v:GetTabItem()
      if tabItem.memId ~= nil and tabItem.help then
        local tips = StringTable.Get("str_discovery_hppet_cancel_pops")
        ToastManager.ShowToast(tips)
      else
        v:FastTeamChanged()
      end
    end
  end
  if self.ctx.teamOpenerType == TeamOpenerType.EightPets then
    UIN33EightPetsTeamsContext:UpdateFastTeam(self._pstidTab)
  end
  self:Lock("UITeamChangeController")
end

function UITeamChangeController:CancelBtnOnRelease(go)
  self:UnLock("UITeamChangeController")
end

function UITeamChangeController:_CheckSeasonTips()
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

function UITeamChangeController:_CheckCamPaignTips()
  local active = false
  local text
  if self.ctx.teamOpenerType == TeamOpenerType.Campaign or self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
    self.ctx:GetCurrTeamId()
    local ctxParam = self.ctx.param
    if ctxParam then
      local missionId = ctxParam[1]
      if missionId then
        local missionCfg = Cfg.cfg_campaign_mission[missionId]
        if missionCfg and missionCfg.PetLv ~= nil then
          active = true
          text = StringTable.Get("str_season_pet_enhance_title", missionCfg.PetGrade, missionCfg.PetLv, missionCfg.PetEquip, missionCfg.PetEquip)
        end
      end
    end
  end
  if self._campaignTips then
    self._campaignTips:SetActive(active)
    if active and self._campaignTipsText then
      self._campaignTipsText:SetText(text)
    end
  end
end
