_class("UISeasonMazeBanPetController", UIController)
UISeasonMazeBanPetController = UISeasonMazeBanPetController

function UISeasonMazeBanPetController:Constructor()
end

function UISeasonMazeBanPetController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeBanPetController:OnShow(uiParams)
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._uiSeasonMazeModule = self._seasonMazeModule:UIModule()
  self._seasonMazeObj = self._seasonMazeModule:CurSeasonObj()
  self._com = self._seasonMazeObj:GetMazeComponent()
  self._cmptInfo = self._seasonMazeObj:GetComponentInfo(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
  self._isInDiscovery = true
  if self._cmptInfo.hard == 0 or self._cmptInfo.hard == nil then
    self._isInDiscovery = false
  end
  self._backClose = false
  self:InitWidget()
  self:InitUI()
end

function UISeasonMazeBanPetController:InitWidget()
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  self.topRightAnchor = self:GetGameObject("TopRightAnchor")
  self._manualView = self:GetGameObject("ManualView")
  self._rotateView = self:GetGameObject("RotateView")
  self._fastBanArea = self:GetGameObject("FastBanArea")
  self._manualName = self:GetUIComponent("UILocalizationText", "manualName")
  self._rotateName = self:GetUIComponent("UILocalizationText", "rotateName")
  self._manualContentGen = self:GetUIComponent("UISelectObjectPath", "ManualContent")
  self._rotateContentGen = self:GetUIComponent("UISelectObjectPath", "RotateContent")
end

function UISeasonMazeBanPetController:InitUI()
  self.openTag = 2
  self._manualBanCellCount = 8
  self._manualBanCellUnlockCount = 6
  self._allPets = self._uiSeasonMazeModule:GetSeasonMazeCfgPets()
  self._rotateBanPetList = self._uiSeasonMazeModule:SeasonMazeCfgBanPetList()
  self._rotateBanPetList = self:_SortRotateBanPetList(self._rotateBanPetList)
  self._rotateBanCellCount = #self._rotateBanPetList
  self._primaryMap = {}
  for i = 1, self._manualBanCellUnlockCount do
    self._primaryMap[i] = 0
  end
  local manualBanList = self._cmptInfo.manunl_ban_pets
  for index, value in ipairs(manualBanList) do
    self._primaryMap[index] = value
  end
  self.whiteTextColor = Color.New(1, 1, 1)
  self.yellowTextColor = Color.New(0.8352941, 0.7215686, 0.4705882)
  self._manualBtn = self:GetUIComponent("Toggle", "ManualBtn")
  
  function self._manualBtnValueChanged(isOn)
    if isOn then
      self:ActiveTagView(1)
    else
    end
  end
  
  self._manualBtn.onValueChanged:AddListener(self._manualBtnValueChanged)
  self._rotateBtn = self:GetUIComponent("Toggle", "RotateBtn")
  
  function self._rotateBtnValueChanged(isOn)
    if isOn then
      self:ActiveTagView(2)
    else
    end
  end
  
  self._rotateBtn.onValueChanged:AddListener(self._rotateBtnValueChanged)
  self:_InitBackBtn()
  if self.openTag == 1 then
    self:ActiveTagView(1)
    self._rotateBtn.isOn = false
    self._manualBtn.isOn = true
  elseif self.openTag == 2 then
    self:ActiveTagView(2)
    self._rotateBtn.isOn = true
    self._manualBtn.isOn = false
  end
end

function UISeasonMazeBanPetController:_InitBackBtn()
  local hideHomeBtn = false
  if self._innerGame then
    hideHomeBtn = true
  end
  self.backBtns:SetData(function()
    self._backClose = true
    self:CloseDialog()
  end, function()
    local pageIdx = 4
    UISeasonMazeModule.OpenHelpUI(UISeasonMazeHelperTabIndex.Temp3, pageIdx)
  end, nil, hideHomeBtn, nil, false, nil)
end

function UISeasonMazeBanPetController:ActiveTagView(tag)
  self._manualView:SetActive(false)
  self._rotateView:SetActive(false)
  self._fastBanArea:SetActive(false)
  if tag == 1 then
    self._manualView:SetActive(true)
    self._fastBanArea:SetActive(true)
    self:RefreshManualView()
  elseif tag == 2 then
    self._rotateView:SetActive(true)
    self:RefreshRotateView()
  end
  self._TmpTag = tag
end

function UISeasonMazeBanPetController:RefreshManualView()
  self._manualContentGen:SpawnObjects("UISeasonMazeBanPetCellItem", self._manualBanCellCount)
  self._manualCells = self._manualContentGen:GetAllSpawnList()
  local cellCount = #self._manualCells
  for i = 1, cellCount do
    local cell = self._manualCells[i]
    local isLockByBank = i > self._manualBanCellUnlockCount
    local unlockBankLevel = i
    local pet
    if not isLockByBank then
      local petTemplateID = self._primaryMap[i]
      if petTemplateID then
        pet = self._allPets[petTemplateID]
      end
    end
    cell:SetData(i, pet, true, false, isLockByBank, unlockBankLevel, self._isInDiscovery, function(cellIndex)
      self:OnManualCellClick(cellIndex)
    end)
  end
end

function UISeasonMazeBanPetController:RefreshRotateView()
  self._rotateContentGen:SpawnObjects("UISeasonMazeBanPetCellItem", self._rotateBanCellCount)
  self._rotateCells = self._rotateContentGen:GetAllSpawnList()
  local cellCount = #self._rotateCells
  for i = 1, cellCount do
    local cell = self._rotateCells[i]
    local pet
    local petTemplateID = self._rotateBanPetList[i]
    if petTemplateID then
      pet = self._allPets[petTemplateID]
    end
    cell:SetData(i, pet, false, true, false, 0, self._isInDiscovery, nil)
  end
end

function UISeasonMazeBanPetController:OnManualCellClick(cellIndex)
  local slot = cellIndex
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  local openList = {}
  for key, value in pairs(self._allPets) do
    local pstid = value:GetPstID()
    if table.icontains(self._primaryMap, pstid) then
    else
      openList[key] = value
    end
  end
  local openPet
  if self._primaryMap[slot] > 0 then
    openPet = self._allPets[self._primaryMap[slot]]
    openList[self._primaryMap[slot]] = openPet
  end
  self:ShowDialog("UISeasonMazeBanPetChangeController", openList, function(pstid, del)
    if del then
      self._primaryMap[slot] = 0
    else
      self._primaryMap[slot] = pstid
    end
    self:ReqBanPet()
  end, openPet, false, self._primaryMap, self._allPets, 0, self._rotateBanPetList)
end

function UISeasonMazeBanPetController:ReqBanPet()
  self:Lock("UISeasonMazeBanPetController:ReqBanPet")
  local banList = {}
  for i = 1, self._manualBanCellUnlockCount do
    if self._primaryMap[i] and self._primaryMap[i] > 0 then
      table.insert(banList, self._primaryMap[i])
    end
  end
  GameGlobal.TaskManager():StartTask(self.TaskReqBanPet, self, banList)
end

function UISeasonMazeBanPetController:TaskReqBanPet(TT, banList)
  local res = AsyncRequestRes:New()
  local response = self._com:HandleSeasonMazeBanPet(TT, res, banList)
  self:UnLock("UISeasonMazeBanPetController:ReqBanPet")
  if res:GetSucc() then
    self:RefreshManualView()
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazeBanPetController] HandleSeasonMazeBanPet fail! result:", result)
    if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
      return
    end
  end
end

function UISeasonMazeBanPetController:ManualBtnOnClick(go)
end

function UISeasonMazeBanPetController:RotateBtnOnClick(go)
end

function UISeasonMazeBanPetController:BtnClearOnClick(go)
end

function UISeasonMazeBanPetController:BtnFastBanOnClick(go)
  local allPets = self._uiSeasonMazeModule:GetSeasonMazeCfgPets()
  self:ShowDialog("UISeasonMazeBanPetChangeController", allPets, function(petList)
    if petList and next(petList) then
      for index, value in ipairs(petList) do
        self._primaryMap[index] = value
      end
    else
      self._primaryMap = {}
      for i = 1, self._manualBanCellUnlockCount do
        self._primaryMap[i] = 0
      end
    end
    self:ReqBanPet()
  end, nil, true, self._primaryMap, self._allPets, self._manualBanCellUnlockCount, self._rotateBanPetList)
end

function UISeasonMazeBanPetController:_SortRotateBanPetList(petIDList)
  local retList = {}
  local sortDataList = {}
  for index, petID in ipairs(petIDList) do
    local cfgPet = Cfg.cfg_pet[petID]
    if cfgPet then
      table.insert(sortDataList, {
        id = petID,
        star = cfgPet.Star
      })
    end
  end
  table.sort(sortDataList, function(a, b)
    if a.star == b.star then
      return a.id < b.id
    else
      return a.star > b.star
    end
  end)
  for index, data in ipairs(sortDataList) do
    table.insert(retList, data.id)
  end
  return retList
end
