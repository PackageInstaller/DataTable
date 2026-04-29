_class("UIAircraftEnterBuildController", UIController)
UIAircraftEnterBuildController = UIAircraftEnterBuildController

function UIAircraftEnterBuildController:OnShow(uiParams)
  self.items = {}
  self._buildData = uiParams[1]
  self._pstid = uiParams[2]
  self._oriPstid = uiParams[2]
  self._index = uiParams[3]
  self._spaceID = self._buildData:SpaceId()
  self._uiAircraftEnterBuildAtlas = self:GetAsset("UIAircraftEnterBuild.spriteatlas", LoadType.SpriteAtlas)
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, function()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI")
  end)
  self:InitComponents()
  self:OnValue()
end

function UIAircraftEnterBuildController:Constructor()
  self._showCount = 16
  self._pet_module = GameGlobal.GetModule(PetModule)
  self._itemTable = {}
  self._aircraft_module = GameGlobal.GetModule(AircraftModule)
  self._countPerCol = 2
  self._upSortBtnCount = 2
  self._currentPetRoom = nil
end

function UIAircraftEnterBuildController:Dispose()
  self._itemTable = nil
  self.countDownTime = 0
  self._pet_module = nil
  self._aircraft_module = nil
  self._countPerCol = 0
  self._petList = nil
  self._sortCls = nil
  self._startOrder = 0
  self._currentSortBtnIndex = 0
  self._upSortBtnCount = 0
  self._currentPetRoom = nil
  self._btnFiltrateImg = nil
  self._RightDown = nil
end

function UIAircraftEnterBuildController:OnHide()
  self._backBtns = nil
end

function UIAircraftEnterBuildController:InitComponents()
  self._imgPetBig = self:GetUIComponent("RawImageLoader", "imgPetBig")
  self._rawPetBigGo = self:GetGameObject("imgPetBig")
  self._SkillInfo = self:GetGameObject("Info")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._selectPetName = self:GetUIComponent("UILocalizationText", "txtName")
  self._selectPetNameEn = self:GetUIComponent("UILocalizationText", "txtNameEn1")
  self._workSkillPool = self:GetUIComponent("UISelectObjectPath", "skills")
  self._upSortBtnPath = self:GetUIComponent("UISelectObjectPath", "upSortBtnPool")
  self._RightDown = self:GetGameObject("RightDown")
  self._Down = self:GetGameObject("Down")
  self._LeftDown = self:GetGameObject("LeftDown")
  self._room = self:GetGameObject("room")
  self._btnFiltrateImg = self:GetUIComponent("Image", "btnFiltrate")
  self._sortPanel = self:GetGameObject("sortPanel")
  self._sortBtnPool = self:GetUIComponent("UISelectObjectPath", "sortBtnPool")
  self._chooseBtnPool = self:GetUIComponent("UISelectObjectPath", "chooseBtnPool")
  self._noPet = self:GetGameObject("noPet")
  self._logo = self:GetUIComponent("RawImageLoader", "logo")
  self._roomLv = self:GetUIComponent("UILocalizationText", "TextLevel")
  self._roomName = self:GetUIComponent("UILocalizationText", "TextTitle")
end

function UIAircraftEnterBuildController:GetFilterParams()
  local filterParamTab = {}
  return filterParamTab
end

function UIAircraftEnterBuildController:ChangeFilterParams(index)
  for i = 1, #self._filter_params do
    if self._filter_params[i]._filter_type == Cfg.cfg_aircraft_pet_filter_element_config[index].attributeID then
      table.remove(self._filter_params, i)
      return
    end
  end
  local filterParam = PetFilterParam:New(Cfg.cfg_aircraft_pet_filter_element_config[index].attributeID, Cfg.cfg_aircraft_pet_filter_element_config[index].Tag)
  table.insert(self._filter_params, filterParam)
end

function UIAircraftEnterBuildController:GetSortParams()
  local sortTypeTab = {}
  local PetSortParam1 = PetSortParam:New(PetSortType.InRoom, PetSortOrder.Ascending, self._buildData)
  table.insert(sortTypeTab, PetSortParam1)
  local PetSortParam2 = PetSortParam:New(PetSortType.InOtherRoom, PetSortOrder.Descending, self._buildData)
  table.insert(sortTypeTab, PetSortParam2)
  local PetSortParam3 = PetSortParam:New(PetSortType.WorkState, PetSortOrder.Ascending, self._buildData:GetRoomType())
  table.insert(sortTypeTab, PetSortParam3)
  local PetSortParam4 = PetSortParam:New(Cfg.cfg_aircraft_pet_sort_element_config[1].attributeID, PetSortOrder.Descending)
  table.insert(sortTypeTab, PetSortParam4)
  local PetSortParam5 = PetSortParam:New(PetSortType.ID, PetSortOrder.Descending)
  table.insert(sortTypeTab, PetSortParam5)
  return sortTypeTab
end

function UIAircraftEnterBuildController:ChangeSortParams(index)
  self._sortIndex = index
  if self._sort_params[4]._sort_type == Cfg.cfg_aircraft_pet_sort_element_config[index].attributeID then
    if self._sort_params[4]._sort_order == PetSortOrder.Ascending then
      self._sort_params[4]._sort_order = PetSortOrder.Descending
    else
      self._sort_params[4]._sort_order = PetSortOrder.Ascending
    end
  else
    local PetSortParam3 = PetSortParam:New(Cfg.cfg_aircraft_pet_sort_element_config[index].attributeID, PetSortOrder.Descending)
    self._sort_params[4] = PetSortParam3
  end
end

function UIAircraftEnterBuildController:OnValue()
  self._roomName:SetText(StringTable.Get(self._buildData:GetRoomName()))
  self._roomLv:SetText(self._buildData:Level() .. "/<color=#ff6100>" .. self._buildData:MaxLevel() .. "</color>")
  self._sortPanel:SetActive(false)
  self._sortIndex = 1
  local tempIndex = 1
  local pets = self._pet_module:GetPets()
  local p = {}
  for _, pet in pairs(pets) do
    p[#p + 1] = pet
  end
  self._allPets = p
  self._filter_params = self:GetFilterParams()
  self._sort_params = self:GetSortParams()
  self._petList = self._pet_module:_SortPets(self._allPets, self._filter_params, self._sort_params)
  self:InitUpSortBtns()
  self:_SortPanelSpawnBtns()
  if table.count(self._petList) <= 0 then
    self._noPet:SetActive(true)
    self._RightDown:SetActive(false)
    self._Down:SetActive(false)
    self._LeftDown:SetActive(false)
    self._room:SetActive(false)
  else
    self._noPet:SetActive(false)
    self._RightDown:SetActive(true)
    self._Down:SetActive(true)
    self._LeftDown:SetActive(true)
    self._room:SetActive(true)
  end
  if self._pstid ~= 0 then
    local pet
    local idx = 0
    for i = 1, #self._petList do
      local pstid = self._petList[i]:GetPstID()
      if pstid == self._pstid then
        pet = self._petList[i]
        idx = i
      end
    end
    if idx ~= 0 then
      table.remove(self._petList, idx)
    else
      pet = self._pet_module:GetPet(self._pstid)
    end
    table.insert(self._petList, 1, pet)
  end
  self._currentPetItemIndex = 0
  if self._pstid ~= 0 then
    self._currentPetItemIndex = 1
  end
  self:_InitSrollView()
end

function UIAircraftEnterBuildController:InitUpSortBtns()
  self._upSortBtnPath:SpawnObjects("UIAircraftEnterUpSortBtnPrefab", self._upSortBtnCount)
  self._upSortBtnPool = self._upSortBtnPath:GetAllSpawnList()
  local cfg_sort = Cfg.cfg_aircraft_pet_sort_element_config({})
  if cfg_sort then
    for i = 1, self._upSortBtnCount do
      self._upSortBtnPool[i]:SetData(i, cfg_sort[i].attributeID, cfg_sort[i].Name, self._sort_params[4], function(index, sortType)
        self:ChangeAircraftSortType(index, sortType)
      end)
    end
  end
end

function UIAircraftEnterBuildController:RefrenshListView()
  self._currentPetItemIndex = 0
  self:_Flush()
end

function UIAircraftEnterBuildController:_Flush()
  self._petList = self._pet_module:_SortPets(self._allPets, self._filter_params, self._sort_params)
  if self._pstid ~= 0 then
    local pet
    local idx = 0
    for i = 1, #self._petList do
      local pstid = self._petList[i]:GetPstID()
      if pstid == self._pstid then
        pet = self._petList[i]
        idx = i
      end
    end
    if idx ~= 0 then
      table.remove(self._petList, idx)
    else
      pet = self._pet_module:GetPet(self._pstid)
    end
    table.insert(self._petList, 1, pet)
  end
  local len = table.count(self._petList)
  if len <= 0 then
    self._noPet:SetActive(true)
    self._RightDown:SetActive(false)
  else
    self._noPet:SetActive(false)
    self._RightDown:SetActive(true)
  end
  self._scrollView:SetListItemCount(self:_CalcTotalRow(len))
  self._scrollView:MovePanelToItemIndex(0, 0)
  if self._pstid ~= 0 then
    local skillState = {}
    local pet = self._petList[1]
    local grade = pet:GetPetGrade()
    local tab = pet:PetGradeNewSkill()
    for i = 1, table.count(tab) do
      skillState[i] = {}
      skillState[i].ID = tab[i].NewSkill
      skillState[i].grade = tab[i].Grade
      if grade < tab[i].Grade then
        skillState[i].isLock = true
      else
        skillState[i].isLock = false
      end
    end
    local pet = self._petList[1]
    self:_ShowPetInfo(pet, skillState)
  else
    self._rawPetBigGo:SetActive(false)
  end
end

function UIAircraftEnterBuildController:ChangeSortState()
  if self._currentSortBtnIndex ~= 0 then
    if self._upSortBtnPool and 0 < table.count(self._upSortBtnPool) then
      self._upSortBtnPool[self._currentSortBtnIndex]:CancelActive()
    end
    if self._sortPools and 0 < table.count(self._sortPools) then
      self._sortPools[self._currentSortBtnIndex]:CancelActive()
    end
  end
  self._currentSortBtnIndex = self._sortCls._sortType
  if self._upSortBtnPool and 0 < table.count(self._upSortBtnPool) then
    self._upSortBtnPool[self._currentSortBtnIndex]:SelectActive(self._sortCls._sortOrder)
  end
  if self._sortPools and 0 < table.count(self._sortPools) then
    self._sortPools[self._currentSortBtnIndex]:SelectActive(self._sortCls._sortOrder)
  end
end

function UIAircraftEnterBuildController:_InitSrollView()
  if self._scrollView then
    self._scrollView:InitListView(self:_CalcTotalRow(table.count(self._petList)), function(scrollView, index)
      return self:_InitListView(scrollView, index)
    end)
  end
  if self._pstid ~= 0 then
    local skillState = {}
    local pet = self._petList[1]
    local grade = pet:GetPetGrade()
    local tab = pet:PetGradeNewSkill()
    for i = 1, table.count(tab) do
      skillState[i] = {}
      skillState[i].ID = tab[i].NewSkill
      skillState[i].grade = tab[i].Grade
      if grade < tab[i].Grade then
        skillState[i].isLock = true
      else
        skillState[i].isLock = false
      end
    end
    local pet = self._petList[1]
    self:_ShowPetInfo(pet, skillState)
  else
    self._rawPetBigGo:SetActive(false)
  end
end

function UIAircraftEnterBuildController:_InitListView(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  rowPool:SpawnObjects("UIAircraftEnterBuildPetPrefab", self._countPerCol)
  local cols = rowPool:GetAllSpawnList()
  table.insert(self.items, cols[1])
  for i = 1, self._countPerCol do
    local idx = index * self._countPerCol + i
    if idx > table.count(self._petList) then
      cols[i]:GetGameObject():SetActive(false)
    else
      cols[i]:GetGameObject():SetActive(true)
      local pstid = self._petList[idx]:GetPstID()
      local petCls = self._petList[idx]
      local room = self._petList[idx]:GetPetAirRoom()
      local sprite_xing_1 = self._uiAircraftEnterBuildAtlas:GetSprite("spirit_xing3_frame")
      local sprite_xing_2 = self._uiAircraftEnterBuildAtlas:GetSprite("spirit_xing2_frame")
      local sprite_xing_3 = self._uiAircraftEnterBuildAtlas:GetSprite("spirit_xiangqing_icon28")
      cols[i]:SetData(idx, sprite_xing_1, sprite_xing_2, sprite_xing_3, petCls, function(index, pstid, skillState, spPet)
        self:OnItemSelect(index, pstid, skillState, spPet)
      end, room, self._pstid, self._spaceID, self._buildData:GetRoomType())
    end
  end
  return item
end

function UIAircraftEnterBuildController:GetSpPet(pstid)
  local pet = self._pet_module:GetPet(pstid)
  for i = 1, #self._petList do
    local tpet = self._petList[i]
    local tpetid = tpet:GetTemplateID()
    local isBinderPet = pet:IsBinderPet(tpetid)
    if isBinderPet then
      return tpet
    end
  end
  return nil
end

function UIAircraftEnterBuildController:_SortPanelSpawnBtns()
  local cfg_sort = Cfg.cfg_aircraft_pet_sort_element_config({})
  if cfg_sort then
    self._sortBtnPool:SpawnObjects("UIAircraftEnterSortBtnPrefab", table.count(cfg_sort))
    self._sortPools = {}
    self._sortPools = self._sortBtnPool:GetAllSpawnList()
    for i = 1, table.count(self._sortPools) do
      local sortType = cfg_sort[i].attributeID
      local sortOrder = AircraftEnterSortOrder.UpToDown
      self._sortPools[i]:SetData(i, sortType, cfg_sort[i].Name, self._sort_params[4], function(index, sortType)
        self:ChangeAircraftSortType(index, sortType)
      end)
    end
  end
  local cfg_choose = Cfg.cfg_aircraft_pet_filter_element_config({})
  if cfg_choose then
    self._chooseBtnPool:SpawnObjects("UIAircraftEnterChooseBtnPrefab", table.count(cfg_choose))
    local pools = self._chooseBtnPool:GetAllSpawnList()
    for i = 1, table.count(pools) do
      local chooseType = cfg_choose[i].attributeID
      pools[i]:SetData(i, chooseType, cfg_choose[i].Name, self._filter_params, function(index, chooseType)
        self:ChangeAircraftChooseType(index, chooseType)
      end)
    end
  end
end

function UIAircraftEnterBuildController:ChangeAircraftSortType(index, sortType)
  self:ChangeSortParams(index)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftEnterBuildChangeSort, self._sort_params[4])
  self:RefrenshListView()
end

function UIAircraftEnterBuildController:ChangeAircraftChooseType(index, chooseType)
  self:ChangeFilterParams(index)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftEnterBuildChangeFilter, self._filter_params)
  self:RefrenshListView()
end

function UIAircraftEnterBuildController:_ShowPetInfo(itemData, skillState)
  if itemData == nil then
    self._pstid = 0
    self._rawPetBigGo:SetActive(false)
    self._SkillInfo:SetActive(false)
    return
  end
  self._pstid = itemData:GetPstID()
  self._rawPetBigGo:SetActive(true)
  self._SkillInfo:SetActive(true)
  self._selectPetName:SetText(StringTable.Get(itemData:GetPetName()))
  self._selectPetNameEn:SetText(StringTable.Get(itemData:GetPetEnglishName()))
  self._logo:LoadImage(itemData:GetPetLogo())
  local bodyName = itemData:GetPetStaticBody(PetSkinEffectPath.BODY_INTO_AIRCRAFT)
  local size = Cfg.cfg_global.ui_interface_common_size.ArrayValue
  self._imgPetBig:GetComponent("RectTransform").sizeDelta = Vector2(size[1], size[2])
  self._imgPetBig:LoadImage(bodyName)
  UICG.SetTransform(self._imgPetBig.transform, self:GetName(), bodyName)
  local _skillState = skillState
  local skillCount = table.count(_skillState)
  self._workSkillPool:SpawnObjects("UIAircraftWorkSkillPrefab", skillCount)
  local pools = self._workSkillPool:GetAllSpawnList()
  for i = 1, skillCount do
    pools[i]:SetData(i, _skillState[i], self._buildData:GetRoomType())
  end
  self._petInfoSkillContent = self:GetUIComponent("RectTransform", "petInfoSkillContent")
  self._petInfoSkillContent.anchoredPosition = Vector2(self._petInfoSkillContent.anchoredPosition.x, 0)
end

function UIAircraftEnterBuildController:GetTimeStr(speed, value)
  local second = math.modf(value * 3600)
  local hour = math.modf(second / 3600)
  local hourStr
  if hour < 10 then
    hourStr = "0" .. hour
  else
    hourStr = hour .. ""
  end
  local min = math.modf((second - hour * 3600) / 60)
  local minStr
  if min < 10 then
    minStr = "0" .. min
  else
    minStr = min .. ""
  end
  local sec = second % 60
  local secStr
  if sec < 10 then
    secStr = "0" .. sec
  else
    secStr = sec .. ""
  end
  local timeStr = hourStr .. ":" .. minStr .. ":" .. secStr
  return timeStr
end

function UIAircraftEnterBuildController:OnItemSelect(index, pet, skillState, spPet)
  self._currentSpPet = spPet
  local pstid = pet:GetPstID()
  if pstid == self._pstid then
    self._pstid = 0
    self:_ShowPetInfo(nil, nil)
  else
    self._pstid = pstid
    self:_ShowPetInfo(pet, skillState)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftEnterClearPetList, self._pstid)
end

function UIAircraftEnterBuildController:btnSureOnClick()
  local same = true
  if self._pstid == self._oriPstid then
    same = true
  else
    same = false
  end
  if same == false and self._pstid ~= 0 then
    local list = self._buildData:GetPetsId()
    for i = 1, #list do
      if self._pstid == list[i] then
        ToastManager.ShowToast(StringTable.Get("str_aircraft_the_same_pet_enter_room"))
        return
      end
    end
  end
  if same == false then
    self:Lock("UIAircraftEnterBuildController:OnBtnSureOnClick")
    local spSpaceID = 0
    local spPetIdx = 0
    if self._currentSpPet then
      local room = self._aircraft_module:GetPetAirRoom(self._currentSpPet)
      spSpaceID = room:SpaceId()
      local petids = room:GetPetsId()
      for idx, petpstid in ipairs(petids) do
        if petpstid == self._currentSpPet:GetPstID() then
          spPetIdx = idx
          break
        end
      end
    end
    GameGlobal.TaskManager():StartTask(self.OnBtnSureOnClick, self, self._buildData:SpaceId(), self._index, self._pstid, spSpaceID, spPetIdx)
  else
    self:CloseDialog()
  end
end

function UIAircraftEnterBuildController:OnBtnSureOnClick(TT, spaceid, idx, pstid, spSpaceID, spPetIdx)
  local res = self._aircraft_module:RequestCheckInOnePet(TT, spaceid, idx, pstid, spSpaceID, spPetIdx)
  self:UnLock("UIAircraftEnterBuildController:OnBtnSureOnClick")
  if res:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSettledPetChanged)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshNavMenuData)
    self:CloseDialog()
  else
    ToastManager.ShowToast(self._aircraft_module:GetErrorMsg(res:GetResult()))
  end
end

function UIAircraftEnterBuildController:btnCancelOnClick()
  self:_ShowPetInfo(nil, nil)
  self._pstid = 0
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftEnterClearPetList, self._pstid)
end

function UIAircraftEnterBuildController:btnFiltrateOnClick()
  self._btnFiltrateImg.sprite = self._uiAircraftEnterBuildAtlas:GetSprite("spirit_jiantou_b_2_frame")
  self._sortPanel:SetActive(true)
  self._sortPools = nil
end

function UIAircraftEnterBuildController:_CalcTotalRow(totalCount)
  local col = math.ceil(totalCount / self._countPerCol)
  return col
end

function UIAircraftEnterBuildController:sortPanelOnClick()
  self._btnFiltrateImg.sprite = self._uiAircraftEnterBuildAtlas:GetSprite("spirit_jiantou_b_1_frame")
  self._sortPanel:SetActive(false)
end

function UIAircraftEnterBuildController:GetPetPrefabCell(index)
  return self.items and self.items[index] and self.items[index]:GetGameObject("imgBgBlack")
end
