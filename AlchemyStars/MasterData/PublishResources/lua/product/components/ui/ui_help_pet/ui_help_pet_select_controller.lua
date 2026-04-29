_class("UIHelpPetSelectController", UIController)
UIHelpPetSelectController = UIHelpPetSelectController

function UIHelpPetSelectController:Constructor()
  self._helpPetModule = self:GetModule(HelpPetModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._refreshTimeGap = 3
  self._itemCountPerRow = 3
  self._listShowItemCount = 0
  self._btnCount = 4
  self.showBtns = true
  self.m_bInitUI = false
  self._viewList = {}
  self._filerType = nil
  self._filterType2Name = {
    [PetProfType.PetProf_Attack] = StringTable.Get("str_pet_tag_job_name_attack"),
    [PetProfType.PetProf_Blood] = StringTable.Get("str_pet_tag_job_name_return_blood"),
    [PetProfType.PetProf_Color] = StringTable.Get("str_pet_tag_job_name_color_change"),
    [PetProfType.PetProf_Function] = StringTable.Get("str_pet_tag_job_name_function")
  }
  self._filterTab = {
    [1] = PetProfType.PetProf_Color,
    [2] = PetProfType.PetProf_Blood,
    [3] = PetProfType.PetProf_Attack,
    [4] = PetProfType.PetProf_Function
  }
  self._filerInited = false
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstid = roleModule:GetPstId()
  self.localHelpPetSelectElement = pstid .. "LOCAL_HELP_PET_SELECT_ELEMENT"
  self._helpPetElementType = LocalDB.GetInt(self.localHelpPetSelectElement, 1)
  self:StartTask(function(TT)
    self:Lock("UIHelpPetSelectLock")
    YIELD(TT, 1000)
    self:UnLock("UIHelpPetSelectLock")
  end)
end

function UIHelpPetSelectController:GetComponents()
  self.bottomTxt = self:GetUIComponent("UILocalizationText", "bottomtxt")
  self.bottomTxt:SetText(StringTable.Get("str_help_pet_glxx", Cfg.cfg_global.help_pet_max_equip_level.IntValue))
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, function()
    self:ShowDialog("UIHelpController", "UIHelpPetSelectController")
  end)
  self._sortBtns = self:GetUIComponent("UISelectObjectPath", "sortBtns")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._emptyDataTip = self:GetGameObject("EmptyTip")
  self._emptyDataTip:SetActive(false)
  self._refreshTex = self:GetGameObject("refreshTex")
  self._refreshTimeGapGo = self:GetGameObject("refreshTimeGapGo")
  self._refreshTimeGapTex = self:GetUIComponent("UILocalizationText", "refreshTimeGap")
  self:SetRefreshTimeActive(false)
  self._filterTex = self:GetUIComponent("UILocalizationText", "filterTex")
  self._filterGo = self:GetGameObject("filterPanelGo")
  self._FilterBtnView = self:GetUIComponent("Image", "FilterBtnView")
  self._atlas = self:GetAsset("UIHelpPet.spriteatlas", LoadType.SpriteAtlas)
  self._filterBtnViewSp1 = self._atlas:GetSprite("spirit_jiantou_b_1_frame2")
  self._filterBtnViewSp2 = self._atlas:GetSprite("spirit_jiantou_b_2_frame2")
  self.m_bInitUI = true
end

function UIHelpPetSelectController:OnValue()
  self:FlushFilterTex()
  self:FilterProf()
  self:CalcPetScrollViewCount()
  self:_GenerateRandomDefaultUserIDList()
  self:_InitSrollView()
end

function UIHelpPetSelectController:ConvertDataList()
  self._dataList = {}
  local _dataList = self._helpPetModule:UI_EnumHelpPet(self._helpPetElementType).elements
  local maxPet = self._helpPetModule:UI_GetTeamMaxMatchPet()
  local curHelpPet
  if self._helpPetModule:UI_GetHelpPetKey() ~= 0 then
    curHelpPet = self._helpPetModule:UI_GetSelectHelpPet()
  end
  local _dataList1 = {}
  for i, data in ipairs(_dataList) do
    if not curHelpPet or curHelpPet.m_nPstID ~= data.m_nPstID or curHelpPet.m_nPstID == 0 and curHelpPet.m_nTemplateID ~= data.m_nTemplateID then
      local a = self._helpPetModule:ConvertDataByMaxPet(data, maxPet, true)
      table.insert(_dataList1, a)
    end
  end
  self._dataList = self._helpPetModule:UI_ReSort(_dataList1).elements
  local socialModule = self:GetModule(SocialModule)
  return self:StartTask(function(TT)
    local idList = {}
    for index, value in ipairs(self._dataList) do
      if value.m_nPlayerID ~= 0 then
        table.insert(idList, value.m_nPlayerID)
      end
    end
    local res, playerList = socialModule:HandleSearchPlayer(TT, idList)
    if res:GetSucc() then
      self.playerList = {}
      for _, playerData in pairs(playerList) do
        self.playerList[playerData.pstid] = playerData
      end
    end
  end)
end

function UIHelpPetSelectController:FilterProf()
  if self._filerType then
    self._viewList = {}
    for index, value in ipairs(self._dataList) do
      local petid = value.m_nTemplateID
      local cfg_pet = Cfg.cfg_pet[petid]
      local prof = cfg_pet.Prof
      if prof == self._filerType then
        table.insert(self._viewList, value)
      end
    end
  else
    self._viewList = self._dataList
  end
end

function UIHelpPetSelectController:SetFilterPool()
  self._filterPool = self:GetUIComponent("UISelectObjectPath", "filterPool")
  self._filterPool:SpawnObjects("UIHelpPetFilterItem", #self._filterTab)
  local pools = self._filterPool:GetAllSpawnList()
  for i = 1, #self._filterTab do
    local type = self._filterTab[i]
    local item = pools[i]
    local filterName = self._filterType2Name[type]
    item:SetData(type, filterName, self._filerType, function(type)
      self:FilterItemOnClick(type)
    end)
  end
end

function UIHelpPetSelectController:FilterBtnOnClick(go)
  if self._filerInited then
  else
    self._filerInited = true
    self:SetFilterPool()
  end
  self._filterGo:SetActive(true)
  self._FilterBtnView.sprite = self._filterBtnViewSp2
end

function UIHelpPetSelectController:FilterItemOnClick(type)
  if self._filerType == type then
    self._filerType = nil
  else
    self._filerType = type
  end
  self:FlushFilterTex()
  self:FlushFilterItemSelect()
  self:RefreshElementList()
end

function UIHelpPetSelectController:FlushFilterItemSelect()
  local pools = self._filterPool:GetAllSpawnList()
  for i = 1, #self._filterTab do
    local item = pools[i]
    item:Flush(self._filerType)
  end
end

function UIHelpPetSelectController:FlushFilterTex()
  local filterName
  if self._filerType then
    filterName = self._filterType2Name[self._filerType]
  else
    filterName = StringTable.Get("str_help_pet_no_filter")
  end
  self._filterTex:SetText(filterName)
end

function UIHelpPetSelectController:CloseFilterBtnOnClick(go)
  self._filterGo:SetActive(false)
  if self._filerType then
    self._FilterBtnView.sprite = self._filterBtnViewSp2
  else
    self._FilterBtnView.sprite = self._filterBtnViewSp1
  end
end

function UIHelpPetSelectController:LoadDataOnEnter(TT, res, uiParams)
  self.params = uiParams
  local _module = self:GetModule(MissionModule)
  local ctx = _module:TeamCtx()
  local teamId = ctx:GetCurrTeamId()
  self.teamId = teamId
  local recordTeamId = self._helpPetModule:UI_GetCurFreshTeamID()
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local lastRefreshTime = self._helpPetModule:UI_GetLastRefreshTime()
  local bSuccess = false
  if recordTeamId == self.teamId and curTime - lastRefreshTime < self._refreshTimeGap then
    bSuccess = self:_RefreshOldData(TT, self.teamId)
  else
    bSuccess = self:_RefreshNewData(TT, 0, self.teamId)
  end
  res:SetSucc(bSuccess)
end

function UIHelpPetSelectController:OnShow(uiParams)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIHelpPetSelect)
  self:GetComponents()
  self:AttacEvents()
  self:InitTopBtns()
  self:OnValue()
end

function UIHelpPetSelectController:InitTopBtns()
  self._sortBtns:SpawnObjects("UIHelpPetSortBtn", self._btnCount)
  self._sortBtnsPool = self._sortBtns:GetAllSpawnList()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:SetData(i, self._helpPetElementType, function(ElementType)
      self:ChangeSortParams(ElementType)
    end)
  end
end

function UIHelpPetSelectController:ChangeSortParams(ElementType)
  self._helpPetElementType = ElementType
  LocalDB.SetInt(self.localHelpPetSelectElement, self._helpPetElementType)
  local listHelpPet = self._helpPetModule:UI_EnumHelpPet(ElementType)
  if listHelpPet:Size() > 0 then
    self:StartTask(function(TT)
      self:Lock("UIHelpPetSelectController:ChangeSortParams")
      local taskId = self:ConvertDataList()
      while TaskHelper:GetInstance():IsTaskFinished(taskId) == false do
        YIELD(TT)
      end
      self:RefreshElementList()
      self:FlushTopBtnState()
      self:UnLock("UIHelpPetSelectController:ChangeSortParams")
    end)
  else
    self:StartTask(function(TT)
      self:_RefreshNewData(TT, self._helpPetElementType, self.teamId)
      self:FlushTopBtnState()
    end)
  end
end

function UIHelpPetSelectController:FlushTopBtnState()
  for i = 1, self._btnCount do
    self._sortBtnsPool[i]:Flush(self._helpPetElementType)
  end
end

function UIHelpPetSelectController:AttacEvents()
end

function UIHelpPetSelectController:DetachEvents()
end

function UIHelpPetSelectController:OnHide()
  self:DetachEvents()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
    self._timer = nil
  end
end

function UIHelpPetSelectController:_InitSrollView()
  self._scrollView:InitListView(self._listShowItemCount, function(scrollView, index)
    return self:InitSpritListInfo(scrollView, index)
  end)
end

function UIHelpPetSelectController:InitSpritListInfo(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowAnim = item.gameObject:GetComponent("Animation")
  rowAnim:Stop()
  rowAnim:Play()
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIHelpPetSelectCell", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local HelpPetItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._petCount then
      HelpPetItem:GetGameObject():SetActive(false)
    else
      self:ShowHelpPetItem(HelpPetItem, itemIndex)
    end
  end
  return item
end

function UIHelpPetSelectController:_GenerateRandomDefaultUserIDList()
  local count = #Cfg.cfg_help_pet_default_users({})
  self._curRandomIndex = 0
  self._randomTable = {}
  for i = 1, count do
    self._randomTable[i] = i
  end
  local randomIndex = 1
  local temp = 1
  for i = 1, count do
    randomIndex = math.random(1, count)
    temp = self._randomTable[randomIndex]
    self._randomTable[randomIndex] = self._randomTable[i]
    self._randomTable[i] = temp
  end
end

function UIHelpPetSelectController:GetRandomDefaultUserID()
  self._curRandomIndex = self._curRandomIndex + 1
  if self._curRandomIndex > #self._randomTable then
    self._curRandomIndex = 1
  end
  return self._randomTable[self._curRandomIndex]
end

function UIHelpPetSelectController:ShowHelpPetItem(HelpPetItem, index)
  local config = self._viewList[index]
  HelpPetItem:GetGameObject():SetActive(true)
  if config ~= nil then
    local playerData
    if self.playerList then
      playerData = self.playerList[config.m_nPlayerID]
    end
    HelpPetItem:SetData(config, index, playerData)
  end
end

function UIHelpPetSelectController:CalcPetScrollViewCount()
  self._petCount = table.count(self._viewList)
  self._listShowItemCount = math.ceil(self._petCount / self._itemCountPerRow)
  self:CheckEmptyTip()
end

function UIHelpPetSelectController:CheckEmptyTip()
  if nil == self._emptyDataTip then
    return
  end
  if self._petCount <= 0 then
    self._emptyDataTip:SetActive(true)
  else
    self._emptyDataTip:SetActive(false)
  end
end

function UIHelpPetSelectController:RefreshElementList()
  self:FilterProf()
  self:_GenerateRandomDefaultUserIDList()
  self:CalcPetScrollViewCount()
  self._scrollView:SetListItemCount(self._listShowItemCount)
  self._scrollView:MovePanelToItemIndex(0, 0)
end

function UIHelpPetSelectController:btnrefreshOnClick()
  if false == self:_CheckRefreshTime() then
    return
  end
  self:StartTask(function(TT)
    self:Lock("UIHelpPetSelectController:btnrefreshOnClick")
    local succ = self:_RefreshNewData(TT, self._helpPetElementType, self.teamId, true)
    if succ then
      self:SetRefreshTimeActive(true)
    end
    self:UnLock("UIHelpPetSelectController:btnrefreshOnClick")
  end)
end

function UIHelpPetSelectController:_CheckRefreshTime()
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local lastRefreshTime = self._helpPetModule:UI_GetLastRefreshTime()
  if lastRefreshTime and curTime - lastRefreshTime < self._refreshTimeGap then
    local time = math.floor(self._refreshTimeGap - (curTime - lastRefreshTime))
    ToastManager.ShowToast(StringTable.Get("str_help_pet_zcsx", time))
    return false
  end
  return true
end

function UIHelpPetSelectController:SetRefreshTimeActive(active)
  self._refreshTex:SetActive(not active)
  self._refreshTimeGapGo:SetActive(active)
  if active then
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
      self._timer = nil
    end
    self:SetRefreshTimeTex()
    self._timer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:SetRefreshTimeTex()
    end)
  end
end

function UIHelpPetSelectController:SetRefreshTimeTex()
  local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local lastRefreshTime = self._helpPetModule:UI_GetLastRefreshTime()
  local time = math.floor(self._refreshTimeGap - (curTime - lastRefreshTime))
  if 0 < time then
    self._refreshTimeGapTex:SetText("00:0" .. time)
  else
    if self._timer then
      GameGlobal.Timer():CancelEvent(self._timer)
      self._timer = nil
    end
    self:SetRefreshTimeActive(false)
  end
end

function UIHelpPetSelectController:_RefreshNewData(TT, nPetType, nTeamID, setRefreshTime)
  local matchType
  local module = self:GetModule(MissionModule)
  local ctx = module:TeamCtx()
  local teamOpenerType = ctx:GetTeamOpenerType()
  local param = ctx:GetParam()
  local component_id, mission_component_id
  if teamOpenerType == TeamOpenerType.Stage then
    matchType = MatchType.MT_Mission
  elseif teamOpenerType == TeamOpenerType.ExtMission then
    matchType = MatchType.MT_ExtMission
  elseif teamOpenerType == TeamOpenerType.Maze then
    matchType = MatchType.MT_Maze
  elseif teamOpenerType == TeamOpenerType.ResInstance then
    matchType = MatchType.MT_ResDungeon
  elseif teamOpenerType == TeamOpenerType.Tower then
    matchType = MatchType.MT_Tower
  elseif teamOpenerType == TeamOpenerType.Trail then
    matchType = MatchType.MT_TalePet
  elseif teamOpenerType == TeamOpenerType.Campaign then
    matchType = MatchType.MT_Campaign
    if param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_SimulatorBlackfist then
      matchType = MatchType.MT_BlackFist
    else
      mission_component_id = param[2]
      component_id = param[3][ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId]
    end
  elseif teamOpenerType == TeamOpenerType.LostLand then
    matchType = MatchType.MT_LostArea
  elseif teamOpenerType == TeamOpenerType.Conquest then
    matchType = MatchType.MT_Conquest
  elseif teamOpenerType == TeamOpenerType.WorldBoss then
    matchType = MatchType.MT_WorldBoss
  elseif teamOpenerType == TeamOpenerType.N21CC then
    matchType = MatchType.MT_Campaign
    mission_component_id = param[2]
    component_id = param[3][ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId]
  elseif teamOpenerType == TeamOpenerType.BlackFist then
    matchType = MatchType.MT_BlackFist
  elseif teamOpenerType == TeamOpenerType.Air then
    matchType = MatchType.MT_Campaign
    if param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_AircraftBlackfist then
      matchType = MatchType.MT_BlackFist
    else
      mission_component_id = param[2]
      component_id = param[3][ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId]
    end
  elseif teamOpenerType == TeamOpenerType.Diff then
    matchType = MatchType.MT_DifficultyMission
  elseif teamOpenerType == TeamOpenerType.Sailing then
    matchType = MatchType.MT_SailingMission
  elseif teamOpenerType == TeamOpenerType.Vampire then
    matchType = MatchType.MT_MiniMaze
  elseif teamOpenerType == TeamOpenerType.Camp_Diff then
    matchType = MatchType.MT_DifficultyMission
  end
  local res = self._helpPetModule:RequestHelpPet_HelpRefresh(TT, nPetType, nTeamID, matchType, component_id, mission_component_id)
  if nil == res or not res:GetSucc() then
    return false
  end
  local taskId = self:ConvertDataList()
  while TaskHelper:GetInstance():IsTaskFinished(taskId) == false do
    YIELD(TT)
  end
  if self.m_bInitUI then
    self:RefreshElementList()
  end
  if setRefreshTime then
    local curTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
    self._helpPetModule:UI_SetLastRefreshTime(curTime)
  end
  return true
end

function UIHelpPetSelectController:_RefreshOldData(TT, nTeamID)
  local _res = self._helpPetModule:RequestHelpPet_HelpList(TT, nTeamID)
  if nil == _res or not _res:GetSucc() then
    return false
  end
  local taskId = self:ConvertDataList()
  while TaskHelper:GetInstance():IsTaskFinished(taskId) == false do
    YIELD(TT)
  end
  return true
end
