local DormEditorCtrl = class("DormEditorCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
DormEditorCtrl._mapNodeConfig = {
  rtFurnitureBg = {
    sComponentName = "RectTransform"
  },
  rtFurnitureBgAnim = {
    sNodeName = "rtFurnitureBg",
    sComponentName = "Animator"
  },
  rtOperate = {
    sComponentName = "CanvasGroup"
  },
  rtEditorListContent = {},
  rtFurnitureList = {},
  rtEmptyListFurniture = {},
  rtPresetList = {},
  listTog = {
    sComponentName = "UIButton",
    nCount = 3,
    callback = "OnBtnClick_MainTabTog"
  },
  listTogCtrl = {
    sNodeName = "listTog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl",
    nCount = 3
  },
  btnHideFurniture = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HideForniture"
  },
  btnUnHideFurniture = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ShowForniture"
  },
  furnitureListTog = {
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_FurnitureTabTog"
  },
  furnitureListTogCtrl = {
    sNodeName = "furnitureListTog",
    sCtrlName = "Game.UI.Dorm.DormEditor.DormFurnitureTogCtrl",
    nCount = 5
  },
  presetListTog = {
    sComponentName = "UIButton",
    nCount = 2,
    callback = "OnBtnClick_PresetTabTog"
  },
  presetListTogCtrl = {
    sNodeName = "presetListTog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl",
    nCount = 2
  },
  svFurniture = {
    sComponentName = "LoopScrollView"
  },
  svPreset = {
    sComponentName = "LoopScrollView"
  },
  btnInteractiveMode = {sComponentName = "UIButton"},
  btnSaveRoom = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SaveRoom"
  },
  btnUnSaveRoom = {sComponentName = "UIButton"},
  btnSaveRoom2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SaveRoom2"
  },
  btnUnSaveRoom2 = {sComponentName = "UIButton"},
  btnClearRoom = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClearRoom"
  },
  btnRevert = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RevertRoom"
  },
  btnFurnitureListOpen = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FurnitureListOpen"
  },
  btnFurnitureListClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FurnitureListClose"
  },
  TMPDormDensity = {sComponentName = "TMP_Text"},
  TMPEditorName = {sComponentName = "TMP_Text"},
  btnEditIcon = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Renmae"
  },
  rtAnimEditor = {},
  rtCutScene = {sConponentName = "Animator"},
  snapshotCutScene = {},
  rtCenter = {},
  rtHud = {},
  animHud = {sNodeName = "rtHud", sComponentName = "Animator"},
  btnHudDelete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HudDelete"
  },
  imgIconDelete = {sComponentName = "Image"},
  imgIconRot = {sComponentName = "Image"},
  btnHudRotation = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HudRotation"
  },
  btnExitEditor = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CancelEdit"
  },
  btnHudCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ExitEditor"
  },
  txtInteractiveMode = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_InteractiveMode"
  },
  txtBtnSaveRoom = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_SaveRoom"
  },
  txtBtnUnSaveRoom = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_SaveRoom"
  },
  txtBtnSaveRoom2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Editor_Save"
  },
  txtBtnUnSaveRoom2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Editor_Save"
  },
  txtBtnClearRoom = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_Clear"
  },
  txtBtnRevert = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_Revert"
  },
  txtBtnHideFurniture = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_HideFurniture"
  },
  txtBtnUnHideFurniture = {
    sComponentName = "TMP_Text",
    sLanguageId = "DormBtn_ShowFurniture"
  },
  txtEdiorTransition = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Editor_ApplicatSuccess"
  },
  txtBtnGetFurniture = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_EditorBtn_GetFurniture"
  },
  txtEmptyFurniture = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Editor_EmptyFurniture"
  },
  txtPresetCount = {sComponentName = "TMP_Text"}
}
DormEditorCtrl._mapEventConfig = {
  DORM_CS_SWITCH_FURNITURE = "OnEvent_DORM_CS_SWITCH_FURNITURE",
  DORM_CS_SET_FUR_HUD = "OnEvent_DORM_CS_SET_FUR_HUD",
  DormNameUpdate = "OnEvent_DormNameUpdate",
  DormPresetGrid_Save = "OnEvent_SavePreset",
  DormPresetGrid_Use = "OnEvent_ApplyPreset",
  DormSuitGrid_Use = "OnEvent_ApplySuit",
  DormFurnitureChanged = "OnEvent_DormFurnitureChanged"
}
DormEditorCtrl._mapRedDotConfig = {}
local iconRootPath = "UI/Dorm/Sprite/Edit/"
local mapFurnitureTogIcon = {
  [1] = "DormFurniture_tab2_furniture_",
  [2] = "DormFurniture_tab2_goods_",
  [3] = "DormFurniture_tab2_carpet_",
  [4] = "DormFurniture_tab2_wallfacing_",
  [5] = "DormFurniture_tab2_wall_",
  [6] = "DormFurniture_tab2_floor_",
  [7] = "DormFurniture_tab2_elevator_",
  [8] = "DormFurniture_tab2_special_"
}

function DormEditorCtrl:Awake()
  self.nDormDefaultPresetNum = ConfigTable.GetConfigNumber("DormDefaultPresetNum")
  self.tbFurTab1 = ConfigTable.GetConfigNumberArray("DormFurnitureTab_Furniture")
  self.tbFurTab2 = ConfigTable.GetConfigNumberArray("DormFurnitureTab_Fitment")
  self.nFurTabCount1 = #self.tbFurTab1
  self.nFurTabCount2 = #self.tbFurTab2
  self.tbSuit = {}
  self.mapFurnitureCtrl = {}
  self.mapPresetCtrl = {}
  self.tbFurniture = {}
  self.nCurMainTab = 1
  self.nCurFurniturTab1 = 1
  self.nCurFurniturTab2 = 1
  self.nCurPresetTab = 2
  self.nCurPresetIdx = 0
  self.nCurSuitId = 0
  self.nCurSelectPresetIdx = 0
  self.mapFurnitureData = {}
  self.mapFurnitureType = {}
end

function DormEditorCtrl:FadeIn()
end

function DormEditorCtrl:FadeOut()
end

function DormEditorCtrl:OnEnable()
  self.bInitPresetListSuc = false
  self.nCurPresetIdx = 0
  self.nCurSuitId = 0
  self.nCurSelectPresetIdx = 0
  self._mapNode.btnUnHideFurniture.gameObject:SetActive(false)
  self._mapNode.btnHideFurniture.gameObject:SetActive(true)
  self.hudAnimTimer = nil
  self._mapNode.btnSaveRoom.gameObject:SetActive(false)
  self._mapNode.btnUnSaveRoom.gameObject:SetActive(true)
  self._mapNode.rtCutScene.gameObject:SetActive(false)
  self._mapNode.rtAnimEditor:SetActive(false)
  self.bEditor = nil
end

function DormEditorCtrl:OnDisable()
  self:UnbindAllCtrl()
end

function DormEditorCtrl:OnDestroy()
end

function DormEditorCtrl:OnRelease()
end

function DormEditorCtrl:UnbindAllCtrl()
  for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapFurnitureCtrl = {}
  for _, mapCtrl in pairs(self.mapPresetCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapPresetCtrl = {}
end

function DormEditorCtrl:InitListToggle()
  for nIdx, togCtrl in ipairs(self._mapNode.listTogCtrl) do
    togCtrl:SetDefaultDorm(nIdx == self.nCurMainTab)
    togCtrl:SetText(ConfigTable.GetUIText("Dorm_Editor_MainTog" .. nIdx))
  end
  for nIdx, togCtrl in ipairs(self._mapNode.furnitureListTogCtrl) do
    local nCurTabIdx = self.nCurMainTab == 1 and self.nCurFurniturTab1 or self.nCurFurniturTab2
    togCtrl:SetDefaultDorm(nIdx == nCurTabIdx)
  end
  for nIdx, togCtrl in ipairs(self._mapNode.presetListTogCtrl) do
    local nCurTabIdx = self.nCurPresetTab
    togCtrl:SetDefaultDorm(nIdx == nCurTabIdx)
    togCtrl:SetText(ConfigTable.GetUIText("Dorm_SuitList_Tog" .. nIdx))
  end
  if self.nCurMainTab < 3 then
    self._mapNode.rtPresetList:SetActive(false)
    self._mapNode.rtFurnitureList:SetActive(true)
    self:SetFurnitureTog()
    self:RefreshFurnitureList()
  else
    if not self.bInitPresetListSuc then
      self:InitPresetList()
    else
      self:SetPresetList()
    end
    self._mapNode.rtFurnitureList:SetActive(false)
  end
  self._mapNode.rtEditorListContent:SetActive(true)
end

function DormEditorCtrl:Init(nRoomId)
  self.mapFurnitureType = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {},
    [7] = {},
    [8] = {}
  }
  self.tbFurniture = {}
  self.tbSuit = {}
  self.nCurEditFurniture = 0
  self.nListWidth = self._mapNode.rtFurnitureBg.rect.width
  self.gameObject:SetActive(false)
  self._mapNode.rtHud:SetActive(false)
  local mapRoomConfig = ConfigTable.GetData("DormRoom", nRoomId)
  if mapRoomConfig == nil then
    return
  end
  self.mapRoomConfig = mapRoomConfig
  for nFurnitureId, nTotalCount in pairs(self._panel.mapFurnitureBag) do
    local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", nFurnitureId)
    if mapFurnitureConfig ~= nil and 0 < self._panel:GetFurnitureCount(nFurnitureId) then
      local tbType = self.mapFurnitureType[mapFurnitureConfig.Tab]
      if tbType ~= nil then
        table.insert(tbType, nFurnitureId)
      end
    end
  end
  for _, tbFurniture in pairs(self.mapFurnitureType) do
    table.sort(tbFurniture)
  end
  
  local function forEachLayout(mapData)
    if not mapData.noShow then
      table.insert(self.tbSuit, mapData)
    end
  end
  
  local function sortSuit(a, b)
    return a.Id > b.Id
  end
  
  ForEachTableLine(DataTable.DormLayoutReward, forEachLayout)
  table.sort(self.tbSuit, sortSuit)
  local sDormName = self._panel.mapDormRoomInfo[self._panel.nCurRoom].RoomName
  if sDormName == nil or sDormName == "" then
    sDormName = mapRoomConfig.DefaultName
  end
  NovaAPI.SetTMPText(self._mapNode.TMPEditorName, sDormName)
  self:InitListToggle()
  self:InitFurnitureList()
  self.nGuideEditorRoom = nRoomId
  self.nGuideEditorVer = (self.nGuideEditorVer or 0) + 1
end

function DormEditorCtrl:SwitchRoom(nRoomId)
  local mapRoomConfig = ConfigTable.GetData("DormRoom", nRoomId)
  if mapRoomConfig == nil then
    return
  end
  self.mapRoomConfig = mapRoomConfig
  local sDormName = self._panel.mapDormRoomInfo[self._panel.nCurRoom].RoomName
  if sDormName == nil or sDormName == "" then
    sDormName = mapRoomConfig.DefaultName
  end
  NovaAPI.SetTMPText(self._mapNode.TMPEditorName, sDormName)
  self:InitFurnitureList()
end

function DormEditorCtrl:InitFurnitureList()
  if self.nCurMainTab == 3 then
    return
  end
  local nCurTabIdx = self.nCurMainTab == 1 and self.tbFurTab1[self.nCurFurniturTab1] or self.tbFurTab2[self.nCurFurniturTab2]
  local tbCurTab = self.mapFurnitureType[nCurTabIdx]
  local tbCount = #tbCurTab
  if 0 < tbCount then
    self._mapNode.svFurniture.gameObject:SetActive(true)
    self._mapNode.rtEmptyListFurniture.gameObject:SetActive(false)
    self._mapNode.svFurniture:Init(tbCount, self, self.OnFurnitureGridRefresh, self.OnFurnitureBtnClickGrid, false)
  else
    self._mapNode.svFurniture.gameObject:SetActive(false)
    self._mapNode.rtEmptyListFurniture.gameObject:SetActive(true)
  end
  self.nGuideListVer = (self.nGuideListVer or 0) + 1
end

function DormEditorCtrl:ResetFurnitrueListData()
  self.mapFurnitureType = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {},
    [7] = {},
    [8] = {}
  }
  for nFurnitureId, nTotalCount in pairs(self._panel.mapFurnitureBag) do
    local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", nFurnitureId)
    if mapFurnitureConfig ~= nil and self._panel:GetFurnitureCount(nFurnitureId) > 0 then
      local tbType = self.mapFurnitureType[mapFurnitureConfig.Tab]
      if tbType ~= nil then
        table.insert(tbType, nFurnitureId)
      end
    end
  end
  for _, tbFurniture in pairs(self.mapFurnitureType) do
    table.sort(tbFurniture)
  end
end

function DormEditorCtrl:SetFurnitureList(bRemove, nFurnitureId, tbCurTab)
  if bRemove then
    local nIdx = table.indexof(tbCurTab, nFurnitureId)
    if 0 < nIdx then
      table.remove(tbCurTab, nIdx)
    end
  else
    table.insert(tbCurTab, nFurnitureId)
  end
  table.sort(tbCurTab)
  if self.nCurMainTab == 3 then
    return
  end
  if 0 < #tbCurTab then
    self._mapNode.svFurniture.gameObject:SetActive(true)
    self._mapNode.rtEmptyListFurniture.gameObject:SetActive(false)
    self._mapNode.svFurniture:Init(#tbCurTab, self, self.OnFurnitureGridRefresh, self.OnFurnitureBtnClickGrid, true)
  else
    self._mapNode.svFurniture.gameObject:SetActive(false)
    self._mapNode.rtEmptyListFurniture.gameObject:SetActive(true)
  end
end

function DormEditorCtrl:SetFurnitureListData(bRemove, nFurnitureId, tbCurTab)
  if bRemove then
    local nIdx = table.indexof(tbCurTab, nFurnitureId)
    if 0 < nIdx then
      table.remove(tbCurTab, nIdx)
    end
  else
    table.insert(tbCurTab, nFurnitureId)
  end
  table.sort(tbCurTab)
end

function DormEditorCtrl:RefreshFurnitureList()
  if self.nCurMainTab == 3 then
    return
  end
  local nCurTabIdx = self.nCurMainTab == 1 and self.tbFurTab1[self.nCurFurniturTab1] or self.tbFurTab2[self.nCurFurniturTab2]
  local tbCurTab = self.mapFurnitureType[nCurTabIdx]
  if 0 < #tbCurTab then
    self._mapNode.svFurniture.gameObject:SetActive(true)
    self._mapNode.rtEmptyListFurniture.gameObject:SetActive(false)
    self._mapNode.svFurniture:Init(#tbCurTab, self, self.OnFurnitureGridRefresh, self.OnFurnitureBtnClickGrid, true)
  else
    self._mapNode.svFurniture.gameObject:SetActive(false)
    self._mapNode.rtEmptyListFurniture.gameObject:SetActive(true)
  end
end

function DormEditorCtrl:InitPresetList()
  local function Callback(mapData, nPresetCount)
    self._panel.mapPresetInfo = mapData
    
    self._panel.nPresetCount = nPresetCount
    self:SetPresetCount()
    self.bInitPresetListSuc = true
    local tbPresetCreateTime = {}
    for key, value in pairs(self._panel.mapPresetInfo) do
      table.insert(tbPresetCreateTime, tostring(value.CreateTime))
    end
    if 0 < #tbPresetCreateTime then
      self._panel:LoadCaptureCover(tbPresetCreateTime)
    end
    self:SetPresetList()
  end
  
  if not self.bInitPresetListSuc then
    PlayerData.PlayerDormData:GetPresetInfo(Callback)
  else
    self:SetPresetList()
  end
end

function DormEditorCtrl:SetPresetList()
  if not self.bInitPresetListSuc then
    return
  end
  self._mapNode.rtPresetList.gameObject:SetActive(true)
  local nGridCount = self.nCurPresetTab == 1 and self.nDormDefaultPresetNum or #self.tbSuit
  self._mapNode.txtPresetCount.gameObject:SetActive(self.nCurPresetTab == 1)
  self._mapNode.svPreset:Init(nGridCount, self, self.OnPresetGridRefresh, self.OnPresetBtnClickGrid, false)
end

function DormEditorCtrl:SetEditorState(bEditor, bNoNeedAudio)
  if self.bEditor == bEditor then
    return
  end
  self.bEditor = bEditor
  if bEditor then
    self:SetSaveState(true)
    self:OnBtnClick_FurnitureListClose()
    self:SetRoomRatio()
  else
    if bNoNeedAudio ~= true then
      WwiseAudioMgr:PostEvent("Home_UI_furniture_put")
    end
    safe_call_cs_func(CS.DormModuleHelper.UnsetHudFollowTarget, self._mapNode.rtCenter)
    self.nCurEditFurniture = 0
    self:InitListToggle()
    self._mapNode.rtFurnitureBgAnim:Play("FurnitureList_in")
    self._mapNode.rtEditorListContent:SetActive(true)
    self:SetHudActive(false)
  end
end

function DormEditorCtrl:SetSaveState(bCanSave)
  self._mapNode.btnSaveRoom.gameObject:SetActive(bCanSave)
  self._mapNode.btnUnSaveRoom.gameObject:SetActive(not bCanSave)
  self._mapNode.btnSaveRoom2.gameObject:SetActive(bCanSave)
  self._mapNode.btnUnSaveRoom2.gameObject:SetActive(not bCanSave)
end

function DormEditorCtrl:SetRoomRatio()
  local mapRoomConfig = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
  if mapRoomConfig == nil then
    return
  end
  local curUsedCount = safe_call_cs_func(CS.DormModuleHelper_HotFix.GetCurRoomUsedCellNum) or 0
  local curMax = mapRoomConfig.FloorRatio
  local str = orderedFormat(ConfigTable.GetUIText("Dorm_Furniture_FloorRatioTitle"), curUsedCount > curMax and "#ef3d5c" or "#FFFFFF", curUsedCount, curMax)
  NovaAPI.SetTMPText(self._mapNode.TMPDormDensity, str)
end

function DormEditorCtrl:SetFurnitureTog()
  if self.nCurMainTab == 3 then
    return
  end
  local tbToggle = self.nCurMainTab == 1 and self.tbFurTab1 or self.tbFurTab2
  if tbToggle == nil then
    return
  end
  for i = 1, 5 do
    if tbToggle[i] == nil then
      self._mapNode.furnitureListTogCtrl[i].gameObject:SetActive(false)
    else
      local nIdx = tbToggle[i]
      self._mapNode.furnitureListTogCtrl[i].gameObject:SetActive(true)
      self._mapNode.furnitureListTogCtrl[i]:SetText(ConfigTable.GetUIText(string.format("Dorm_FurnitureList_Tog%d", nIdx)))
      local spriteName = mapFurnitureTogIcon[nIdx]
      local spriteName1 = string.format("%s%s%s", iconRootPath, spriteName, "01")
      local spriteName2 = string.format("%s%s%s", iconRootPath, spriteName, "02")
      self._mapNode.furnitureListTogCtrl[i]:SetIconUnSel(spriteName2)
      self._mapNode.furnitureListTogCtrl[i]:SetIconSel(spriteName1)
    end
  end
end

function DormEditorCtrl:ExitEdiorMode()
  self._panel.tempEditCount = {}
  self:ResetFurnitrueListData()
  self:SetSaveState(false)
  if self.nCurMainTab < 3 then
    self:InitFurnitureList()
  end
  self:OnBtnClick_ShowForniture()
end

function DormEditorCtrl:SetHudActive(bActive)
  if bActive then
    if self.hudAnimTimer ~= nil then
      self.hudAnimTimer:Cancel()
      self.hudAnimTimer = nil
    end
    self._mapNode.rtHud:SetActive(true)
    self._mapNode.animHud:Play("RoomEditorbtn_in")
  else
    self._mapNode.animHud:Play("RoomEditorbtn_out")
    self.hudAnimTimer = self:AddTimer(1, 0.13, function()
      self._mapNode.rtHud:SetActive(false)
    end, true, true, true, nil)
  end
end

function DormEditorCtrl:SetPresetCount()
  local nCurCount = 0
  for _, mapPreset in pairs(self._panel.mapPresetInfo) do
    nCurCount = nCurCount + 1
  end
  NovaAPI.SetTMPText(self._mapNode.txtPresetCount, orderedFormat(ConfigTable.GetUIText("Dorm_PresetCount"), nCurCount, self.nDormDefaultPresetNum))
end

function DormEditorCtrl:OnEvent_SavePreset(nBuildId)
  NovaAPI.DispatchEventWithData("DORM_LUA_SAVE_ROOM")
  local csData = safe_call_cs_func(CS.DormModuleHelper.GetDormData)
  local sContent
  local bCover = false
  if self._panel.mapPresetInfo[nBuildId] == nil then
    sContent = ConfigTable.GetUIText("Dorm_PresetSaveHint")
  else
    sContent = ConfigTable.GetUIText("Dorm_PresetCoverHint")
    bCover = true
  end
  
  local function callback()
    local function GetNewDataCallback(mapData, nPresetCount)
      self._panel.mapPresetInfo = mapData
      
      self._panel.nPresetCount = nPresetCount
      self:SetPresetCount()
      local mapPreset = self._panel.mapPresetInfo[nBuildId]
      if mapPreset ~= nil then
        self._panel:CapturerPresetCover(mapPreset.CreateTime)
      end
      if self.nCurMainTab == 3 then
        self:SetPresetList()
      end
    end
    
    PlayerData.PlayerDormData:GetPresetInfo(GetNewDataCallback)
    if bCover then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_PresetCoverSuccess"))
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_PresetSaveSuccess"))
    end
    self.nCurPresetIdx = 0
    self.nCurSuitId = 0
    self.nCurSelectPresetIdx = 0
    self:SetPresetList()
    self:OnBtnClick_ShowForniture()
  end
  
  local function confirmCallback()
    local mapData = {}
    local nLength = math.floor(csData.Length / 5)
    if 2 <= nLength then
      for i = 1, nLength - 1 do
        table.insert(mapData, {
          FurnitureId = csData[i * 5 + 0],
          X = csData[i * 5 + 1],
          Y = csData[i * 5 + 2],
          Z = csData[i * 5 + 3],
          Rotation = csData[i * 5 + 4]
        })
      end
    end
    self:OnBtnClick_ShowForniture()
    PlayerData.PlayerDormData:SaveDormFurniture(self._panel.nCurRoom, mapData, nBuildId, callback)
  end
  
  local function cancelCallback()
  end
  
  if csData[0] ~= 3 then
    NovaAPI.DispatchEventWithData("DORM_LUA_ABANDON_SAVE_ROOM")
    self._panel.tempEditCount = {}
    callback()
    return
  end
  if csData[1] ~= 0 and csData[1] ~= 4 then
    local sTip
    if csData[1] == 1 then
      sTip = ConfigTable.GetUIText("Dorm_Hint_Err_FurniturePos")
    elseif csData[1] == 2 then
      sTip = ConfigTable.GetUIText("Dorm_Hint_Err_FixedFurniture")
    elseif csData[1] == 3 then
      sTip = ConfigTable.GetUIText("Dorm_Hint_Err_FloorCapacity")
    elseif csData[1] == 4 then
      sTip = ConfigTable.GetUIText("Dorm_Hint_Err_NoNeedToSave")
    else
      sTip = csData[1]
    end
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = sContent,
    callbackConfirmAfterClose = confirmCallback,
    callbackCancel = cancelCallback,
    bDisableSnap = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function DormEditorCtrl:OnEvent_ApplyPreset(nBuildId)
  local mapTempCount = {}
  local mapPresetData = self._panel.mapPresetInfo[nBuildId]
  if mapPresetData == nil then
    printError("No PresetData:" .. nBuildId)
    return
  end
  local mapDormCfg = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
  if mapDormCfg == nil then
    return
  end
  if mapPresetData.DormType ~= mapDormCfg.RoomType then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_PresetUseSuccess"))
    return
  end
  local roomData = {}
  local nFurnitureLen = 0
  for _, mapFurniture in ipairs(mapPresetData.FurnitureList) do
    local nCount = self._panel:GetFurnitureCountIncludeCurRoom(self._panel.nCurRoom, mapFurniture.FurnitureId)
    local curUseCount = mapTempCount[mapFurniture.FurnitureId] or 0
    local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", mapFurniture.FurnitureId)
    if mapFurnitureConfig ~= nil and (nCount >= curUseCount + 1 or 0 < mapFurnitureConfig.Fixed) then
      if mapFurnitureConfig.Fixed == 0 then
        if mapTempCount[mapFurniture.FurnitureId] == nil then
          mapTempCount[mapFurniture.FurnitureId] = 0
        end
        mapTempCount[mapFurniture.FurnitureId] = mapTempCount[mapFurniture.FurnitureId] + 1
      end
      nFurnitureLen = nFurnitureLen + 1
      table.insert(roomData, {
        mapFurniture.FurnitureId,
        mapFurniture.X,
        mapFurniture.Y,
        mapFurniture.Z,
        mapFurniture.Rotation
      })
    end
  end
  table.insert(roomData, 1, {
    2,
    mapDormCfg.RoomType,
    nBuildId,
    nFurnitureLen,
    0
  })
  safe_call_cs_func(CS.DormModuleHelper.SetDormData, roomData)
  NovaAPI.DispatchEventWithData("DORM_LUA_APPLY_PRESET")
  local csData = safe_call_cs_func(CS.DormModuleHelper.GetDormData)
  if csData == nil then
    printError("ApplyPresetResult Nil")
    return
  end
  if csData[0] ~= 4 then
    printError("ApplyPresetResult TypeError:" .. csData[0])
    return
  end
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_PresetUseSuccess"))
  local mapUsedCount = self._panel.mapFurnitureUsedCount[self._panel.nCurRoom]
  self._panel.tempEditCount = {}
  if mapUsedCount ~= nil then
    for nItemId, nUsedCount in pairs(mapUsedCount) do
      local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", nItemId)
      if mapFurnitureConfig ~= nil and mapFurnitureConfig.Fixed == 0 then
        self._panel.tempEditCount[nItemId] = -nUsedCount
      end
    end
  end
  local nLeng = csData[1]
  local nTotalDataLeng = 2 + 2 * nLeng
  if 0 < nLeng then
    for i = 1, nLeng do
      local nFurnitureId = csData[2 * i]
      local nCount = csData[2 * i + 1]
      self._panel:SetTempFurnitureCount(nFurnitureId, -nCount)
    end
  end
  for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
    mapCtrl:SetCount(self._panel:GetFurnitureCount(mapCtrl.nFurnitureId))
  end
  self.nCurPresetIdx = 0
  self.nCurSuitId = 0
  self.nCurSelectPresetIdx = 0
  self:SetPresetList()
  self:ResetFurnitrueListData()
  self:SetSaveState(true)
  self:OnBtnClick_ShowForniture()
  local spCover = self._panel:GetPresetCover(tostring(mapPresetData.CreateTime))
  if spCover == nil then
    local function wait()
      EventManager.Hit(EventId.BlockInput, true)
      
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._panel:CapturerPresetCover(mapPresetData.CreateTime)
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if self.nCurMainTab == 3 then
        self:SetPresetList()
      end
      EventManager.Hit(EventId.BlockInput, false)
    end
    
    cs_coroutine.start(wait)
  end
end

function DormEditorCtrl:OnEvent_ApplySuit(nSuitId)
  local mapTempCount = {}
  local mapSuitData = ConfigTable.GetData("DormLayoutReward", nSuitId)
  if mapSuitData == nil then
    printError("No Suit Data:" .. nSuitId)
    return
  end
  local mapDormCfg = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
  if mapDormCfg == nil then
    return
  end
  if mapSuitData.RoomType ~= mapDormCfg.RoomType then
    return
  end
  local roomData = {}
  local tbFurnitrueList = self._panel.mapDormSuitData[nSuitId]
  local nFurnitureLen = 0
  for _, mapFurniture in ipairs(tbFurnitrueList) do
    local nCount = self._panel:GetFurnitureCountIncludeCurRoom(self._panel.nCurRoom, mapFurniture.FurnitureId)
    local curUseCount = mapTempCount[mapFurniture.FurnitureId] or 0
    local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", mapFurniture.FurnitureId)
    if mapFurnitureConfig ~= nil and nCount >= curUseCount + 1 then
      if mapFurnitureConfig.Fixed == 0 then
        if mapTempCount[mapFurniture.FurnitureId] == nil then
          mapTempCount[mapFurniture.FurnitureId] = 0
        end
        mapTempCount[mapFurniture.FurnitureId] = mapTempCount[mapFurniture.FurnitureId] + 1
      end
      table.insert(roomData, {
        mapFurniture.FurnitureId,
        mapFurniture.X,
        mapFurniture.Y,
        mapFurniture.Z,
        mapFurniture.Rotation
      })
      nFurnitureLen = nFurnitureLen + 1
    end
  end
  table.insert(roomData, 1, {
    2,
    mapDormCfg.RoomType,
    nSuitId,
    nFurnitureLen,
    0
  })
  safe_call_cs_func(CS.DormModuleHelper.SetDormData, roomData)
  NovaAPI.DispatchEventWithData("DORM_LUA_APPLY_PRESET")
  local csData = safe_call_cs_func(CS.DormModuleHelper.GetDormData)
  if csData == nil then
    printError("ApplyPresetResult Nil")
    return
  end
  if csData[0] ~= 4 then
    printError("ApplyPresetResult TypeError:" .. csData[0])
    return
  end
  local mapUsedCount = self._panel.mapFurnitureUsedCount[self._panel.nCurRoom]
  self._panel.tempEditCount = {}
  if mapUsedCount ~= nil then
    for nItemId, nUsedCount in pairs(mapUsedCount) do
      local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", nItemId)
      if mapFurnitureConfig ~= nil and mapFurnitureConfig.Fixed == 0 then
        self._panel.tempEditCount[nItemId] = -nUsedCount
      end
    end
  end
  local nLeng = csData[1]
  local nTotalDataLeng = 2 + 2 * nLeng
  if 0 < nLeng then
    for i = 1, nLeng do
      local nFurnitureId = csData[2 * i]
      local nCount = csData[2 * i + 1]
      self._panel:SetTempFurnitureCount(nFurnitureId, -nCount)
    end
  end
  for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
    mapCtrl:SetCount(self._panel:GetFurnitureCount(mapCtrl.nFurnitureId))
  end
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_Set_UseSuccess"))
  PlayerData.PlayerDormData:UploadDormEvent("2", self._panel.nCurRoom, nSuitId)
  self.nCurPresetIdx = 0
  self.nCurSuitId = nSuitId
  self:SetPresetList()
  self:ResetFurnitrueListData()
  self:SetSaveState(true)
  self:SetRoomRatio()
end

function DormEditorCtrl:OnEvent_DormNameUpdate(nRoomId, sName)
  if nRoomId == self._panel.nCurRoom then
    self._panel.mapDormRoomInfo[self._panel.nCurRoom].RoomName = sName
    if sName == nil or sName == "" then
      local mapRoomConfig = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
      if mapRoomConfig ~= nil then
        sName = mapRoomConfig.DefaultName
      end
    end
    NovaAPI.SetTMPText(self._mapNode.TMPEditorName, sName)
  end
end

function DormEditorCtrl:OnFurnitureGridRefresh(goGrid, idx)
  if self.nCurMainTab == 3 then
    return
  end
  local nCurTabIdx = self.nCurMainTab == 1 and self.tbFurTab1[self.nCurFurniturTab1] or self.tbFurTab2[self.nCurFurniturTab2]
  local tbCurTab = self.mapFurnitureType[nCurTabIdx]
  idx = idx + 1
  local nFurnitureId = tbCurTab[idx]
  local nInstanceId = goGrid:GetInstanceID()
  if self.mapFurnitureCtrl[nInstanceId] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormEditor.TemplateDormFurnitureItem")
    self.mapFurnitureCtrl[nInstanceId] = mapCtrl
  end
  self.mapFurnitureCtrl[nInstanceId]:Refresh(nFurnitureId, self._panel:GetFurnitureCount(nFurnitureId), self._panel.nCurRoom)
end

function DormEditorCtrl:OnFurnitureBtnClickGrid(goGrid, idx)
  if self.nCurMainTab == 3 then
    return
  end
  local nCurTabIdx = self.nCurMainTab == 1 and self.tbFurTab1[self.nCurFurniturTab1] or self.tbFurTab2[self.nCurFurniturTab2]
  local tbCurTab = self.mapFurnitureType[nCurTabIdx]
  idx = idx + 1
  local nId = tbCurTab[idx]
  local nInstanceId = goGrid:GetInstanceID()
  if 1 > self._panel:GetFurnitureCount(nId) then
    return
  end
  if self.mapFurnitureCtrl[nInstanceId].nItemCount <= 0 then
    return
  end
  self.nCurEditFurniture = nId
  local mapFurnitureCfg = ConfigTable.GetData("DormFurniture", self.nCurEditFurniture)
  local mapFurnitureItemCfg = ConfigTable.GetData("Item", self.nCurEditFurniture)
  local mapRoomConfig = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
  if mapFurnitureCfg == nil or mapFurnitureItemCfg == nil or mapRoomConfig == nil then
    return
  end
  local bEnable = 0 < table.indexof(mapFurnitureCfg.CanIn, mapRoomConfig.RoomType)
  if not bEnable then
    return
  end
  local nFixedType = mapFurnitureCfg.Fixed
  local bNeedAddFurniture = false
  local nChangedFixedFurniture = 0
  if 0 < nFixedType then
    local nCurFixedFurniture, nFixedCount = self._panel:GetFixedInCurRoom(nFixedType)
    if 0 < nCurFixedFurniture then
      nChangedFixedFurniture = nCurFixedFurniture
      self._panel:SetTempFurnitureCount(nCurFixedFurniture, -1)
      bNeedAddFurniture = self._panel:GetFurnitureCount(nCurFixedFurniture) == 1
      if bNeedAddFurniture then
        self:SetFurnitureListData(false, nCurFixedFurniture, tbCurTab)
      end
    end
  end
  self._panel:SetTempFurnitureCount(self.nCurEditFurniture, 1)
  local nCount = self._panel:GetFurnitureCount(self.nCurEditFurniture)
  if nCount == 0 then
    self:SetFurnitureListData(true, self.nCurEditFurniture, tbCurTab)
  end
  if nCount == 0 or bNeedAddFurniture then
    self:RefreshFurnitureList()
  else
    self.mapFurnitureCtrl[nInstanceId]:SetCount(nCount)
    if 0 < nChangedFixedFurniture then
      for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
        if mapCtrl.nFurnitureId == nChangedFixedFurniture then
          mapCtrl:SetCount(self._panel:GetFurnitureCount(nChangedFixedFurniture))
        end
      end
    end
  end
  self:SetEditorState(true)
  NovaAPI.DispatchEventWithData("DORM_LUA_CREATE_FURNITURE", nil, self.nCurEditFurniture)
end

function DormEditorCtrl:OnPresetGridRefresh(goGrid, idx)
  idx = idx + 1
  local mapPresetData = self._panel.mapPresetInfo[idx]
  local nInstanceId = goGrid:GetInstanceID()
  if self.mapPresetCtrl[nInstanceId] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormEditor.DormPresetGridCtrl")
    self.mapPresetCtrl[nInstanceId] = mapCtrl
  end
  if self.nCurPresetTab == 1 then
    local bEmpty = mapPresetData == nil
    local sName = (bEmpty or mapPresetData.BuildName == "") and orderedFormat(ConfigTable.GetUIText("Dorm_PresetDefaultName"), idx) or mapPresetData.BuildName
    local bEnable = not bEmpty and self.mapRoomConfig.RoomType == mapPresetData.DormType
    local bUse = not bEmpty and self.nCurPresetIdx == idx
    local bSelect = self.nCurSelectPresetIdx == idx
    local creatTime = bEmpty and 0 or mapPresetData.CreateTime
    self.mapPresetCtrl[nInstanceId]:SetPreset(sName, bEnable, bEmpty, bUse, bSelect, idx, creatTime, self._panel.nCurRoom)
  else
    local mapSuitData = self.tbSuit[idx]
    if mapSuitData == nil then
      return
    end
    local bEnable = self.mapRoomConfig.RoomType == mapSuitData.RoomType
    local bSelect = false
    self.mapPresetCtrl[nInstanceId]:SetSuit(mapSuitData.Id, bEnable, bSelect)
  end
end

function DormEditorCtrl:OnPresetBtnClickGrid(goGrid, idx)
  idx = idx + 1
  if self.nCurPresetTab == 1 then
    if self.nCurSelectPresetIdx ~= 0 then
      for _, mapCtrl in pairs(self.mapPresetCtrl) do
        mapCtrl:SetSelectPreset(false)
      end
    end
    self.nCurSelectPresetIdx = idx
    local nInstanceId = goGrid:GetInstanceID()
    local mapCurCtrl = self.mapPresetCtrl[nInstanceId]
    if mapCurCtrl ~= nil then
      mapCurCtrl:SetSelectPreset(true)
    end
  else
    local nInstanceId = goGrid:GetInstanceID()
    local mapCurCtrl = self.mapPresetCtrl[nInstanceId]
    mapCurCtrl:OnBtnClick_Detail()
  end
end

function DormEditorCtrl:OnBtnClick_FurnitureListOpen()
  self:OnBtnClick_ExitEditor()
  self._mapNode.rtFurnitureBgAnim:Play("FurnitureList_in")
  self._mapNode.rtEditorListContent:SetActive(true)
end

function DormEditorCtrl:OnBtnClick_FurnitureListClose()
  self._mapNode.rtFurnitureBgAnim:Play("FurnitureList_out")
  self._mapNode.rtEditorListContent:SetActive(false)
end

function DormEditorCtrl:OnBtnClick_SaveRoom()
  local function callback(bSaveSuc)
    EventManager.Hit("DormGuide_SaveResult", bSaveSuc == true, bSaveSuc and "done" or "rejected")
    
    if bSaveSuc then
      self:OnBtnClick_ShowForniture()
      self:SetSaveState(false)
      EventManager.Hit("DORM_LUA_SAVE_ROOM_SUCC")
      NovaAPI.DispatchEventWithData("DORM_LUA_SAVE_ROOM_SUCC")
      self:ResetFurnitrueListData()
      if self.nCurMainTab < 3 then
        self:InitFurnitureList()
      end
      self._mapNode.rtOperate.gameObject:SetActive(false)
      self._mapNode.rtAnimEditor.gameObject:SetActive(true)
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        NovaAPI.UIEffectSnapShotCapture(self._mapNode.snapshotCutScene)
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self._mapNode.rtCutScene.gameObject:SetActive(true)
      end
      
      cs_coroutine.start(wait)
      EventManager.Hit(EventId.TemporaryBlockInput, 3)
      self:AddTimer(1, 3, function()
        self._mapNode.rtAnimEditor.gameObject:SetActive(false)
        self._mapNode.rtCutScene.gameObject:SetActive(false)
        self._mapNode.rtOperate.gameObject:SetActive(true)
        EventManager.Hit("DormGuide_SaveCutsceneEnd")
        EventManager.Hit("DormPanel_BtnInteractive", true)
      end, true, true, true, nil)
    end
  end
  
  self._panel:SaveRoom(callback, true)
end

function DormEditorCtrl:OnBtnClick_SaveRoom2()
  local function callback(bSaveSuc)
    if bSaveSuc then
      self:OnBtnClick_ShowForniture()
      
      self:SetSaveState(false)
      EventManager.Hit("DORM_LUA_SAVE_ROOM_SUCC")
      NovaAPI.DispatchEventWithData("DORM_LUA_SAVE_ROOM_SUCC")
      self:ResetFurnitrueListData()
      if self.nCurMainTab < 3 then
        self:InitFurnitureList()
      end
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Dorm_Editor_SaveSuccess"))
    end
  end
  
  self._panel:SaveRoom(callback, true)
end

function DormEditorCtrl:OnBtnClick_RevertRoom()
  local function callback()
    NovaAPI.DispatchEventWithData("DORM_LUA_ABANDON_SAVE_ROOM")
    
    self._panel.tempEditCount = {}
    self:ResetFurnitrueListData()
    self:OnBtnClick_ShowForniture()
    self:SetRoomRatio()
    self:SetSaveState(false)
    self.nCurPresetIdx = 0
    self.nCurSuitId = 0
    if self.nCurMainTab < 3 then
      self:InitFurnitureList()
    else
      self:SetPresetList()
    end
  end
  
  local data = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Dorm_EditorRevertHint"),
    sContentSub = "",
    callbackConfirm = callback
  }
  EventManager.Hit(EventId.OpenMessageBox, data)
end

function DormEditorCtrl:OnBtnClick_HideForniture()
  self:OnBtnClick_ExitEditor()
  self._mapNode.btnUnHideFurniture.gameObject:SetActive(true)
  self._mapNode.btnHideFurniture.gameObject:SetActive(false)
  NovaAPI.DispatchEventWithData("DORM_LUA_HIDE_FLOOR_FUR", nil, false)
end

function DormEditorCtrl:OnBtnClick_ShowForniture()
  self._mapNode.btnUnHideFurniture.gameObject:SetActive(false)
  self._mapNode.btnHideFurniture.gameObject:SetActive(true)
  NovaAPI.DispatchEventWithData("DORM_LUA_HIDE_FLOOR_FUR", nil, true)
end

function DormEditorCtrl:OnBtnClick_ExitEditor()
  NovaAPI.DispatchEventWithData("DORM_LUA_UNSELECT_FURNITURE")
  self:SetEditorState(false)
end

function DormEditorCtrl:OnBtnClick_CancelEdit()
  local tempId = self.nCurEditFurniture
  NovaAPI.DispatchEventWithData("DORM_LUA_CANCEL_FURNITURE")
  local csData = safe_call_cs_func(CS.DormModuleHelper.GetDormData)
  if csData ~= nil and csData.Length >= 1 and csData[0] == 1 and 0 < tempId then
    self._panel:SetTempFurnitureCount(tempId, -1)
    local mapFurnitureCfg = ConfigTable.GetData("DormFurniture", tempId)
    if mapFurnitureCfg == nil then
      return
    end
    local tabIdx = mapFurnitureCfg.Tab
    if tabIdx == 0 then
      printError("Furniture Cfg Error Tab = 0")
      return
    end
    local bFurnitureListNeedRefresh = false
    local tbCurTab = self.mapFurnitureType[tabIdx]
    local nCount = self._panel:GetFurnitureCount(tempId)
    if nCount == 1 then
      self:SetFurnitureListData(false, tempId, tbCurTab)
      bFurnitureListNeedRefresh = true
    end
    local tempFurnitureId = 0
    if csData.Length >= 2 then
      tempFurnitureId = csData[1]
      if 0 < tempFurnitureId then
        self._panel:SetTempFurnitureCount(tempFurnitureId, 1)
      end
      local nAfterAddCount = self._panel:GetFurnitureCount(tempFurnitureId)
      if nAfterAddCount == 0 then
        self:SetFurnitureListData(true, tempFurnitureId, tbCurTab)
        bFurnitureListNeedRefresh = true
      end
    end
    if self.nCurMainTab ~= 3 then
      if bFurnitureListNeedRefresh then
        self:RefreshFurnitureList()
      else
        for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
          if mapCtrl.nFurnitureId == tempId then
            mapCtrl:SetCount(self._panel:GetFurnitureCount(mapCtrl.nFurnitureId))
          end
          if mapCtrl.nFurnitureId == tempFurnitureId then
            mapCtrl:SetCount(self._panel:GetFurnitureCount(tempFurnitureId))
          end
        end
      end
    end
  end
  self:SetRoomRatio()
  self:SetEditorState(false)
end

function DormEditorCtrl:OnBtnClick_HudRotation()
  NovaAPI.DispatchEventWithData("DORM_LUA_ROTATE_FURNITURE", nil, true)
  self:SetRoomRatio()
end

function DormEditorCtrl:OnBtnClick_HudDelete()
  local mapFurnitureCfg = ConfigTable.GetData("DormFurniture", self.nCurEditFurniture)
  if mapFurnitureCfg == nil then
    return
  end
  local tabIdx = mapFurnitureCfg.Tab
  if tabIdx == 0 then
    printError("Furniture Cfg Error Tab = 0")
    return
  end
  local tbCurTab = self.mapFurnitureType[tabIdx]
  self._panel:SetTempFurnitureCount(self.nCurEditFurniture, -1)
  local nCount = self._panel:GetFurnitureCount(self.nCurEditFurniture)
  if nCount == 1 then
    self:SetFurnitureList(false, self.nCurEditFurniture, tbCurTab)
  elseif self.mapFurnitureCtrl ~= nil then
    for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
      if mapCtrl.nFurnitureId == self.nCurEditFurniture then
        mapCtrl:SetCount(self._panel:GetFurnitureCount(mapCtrl.nFurnitureId))
      end
    end
  end
  self:SetEditorState(false, true)
  NovaAPI.DispatchEventWithData("DORM_LUA_DELETE_FURNITURE")
  self:SetRoomRatio()
end

function DormEditorCtrl:OnBtnClick_ClearRoom()
  local function confirmCallback()
    local mapRoomCfgData = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
    
    if mapRoomCfgData == nil then
      return
    end
    local nDefaultLayoutId = mapRoomCfgData.DefaultLayoutId
    local mapDefaultCount = {}
    local mapLayoutCfgData = ConfigTable.GetData("DormLayoutReward", nDefaultLayoutId)
    if mapLayoutCfgData ~= nil then
      local nLayoutFurnitrueCount = mapLayoutCfgData.FurnitureCount
      for i = 1, nLayoutFurnitrueCount do
        local nLayoutId = nDefaultLayoutId * 100 + i
        local mapLayoutData = ConfigTable.GetData("DormRoomLayout", nLayoutId)
        if mapLayoutData ~= nil then
          if mapDefaultCount[mapLayoutData.FurnitureId] == nil then
            mapDefaultCount[mapLayoutData.FurnitureId] = 0
          end
          mapDefaultCount[mapLayoutData.FurnitureId] = mapDefaultCount[mapLayoutData.FurnitureId] + 1
        end
      end
    end
    self.nCurEditFurniture = 0
    self:SetEditorState(false, true)
    NovaAPI.DispatchEventWithData("DORM_LUA_CLEAR_ROOM")
    local mapUsedCount = self._panel.mapFurnitureUsedCount[self._panel.nCurRoom]
    self._panel.tempEditCount = {}
    if mapUsedCount ~= nil then
      for nItemId, nUsedCount in pairs(mapUsedCount) do
        local nDefaultCount = mapDefaultCount[nItemId] or 0
        self._panel.tempEditCount[nItemId] = nDefaultCount - nUsedCount
      end
    end
    self:ResetFurnitrueListData()
    self:SetRoomRatio()
    self:OnBtnClick_ShowForniture()
    self:SetSaveState(true)
    self.nCurPresetIdx = 0
    self.nCurSuitId = 0
    if self.nCurMainTab < 3 then
      self:InitFurnitureList()
    else
      self:SetPresetList()
    end
  end
  
  local data = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Dorm_EditorClearHint"),
    sContentSub = "",
    callbackConfirm = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, data)
end

function DormEditorCtrl:OnBtnClick_Renmae()
  if not PlayerData.PlayerDormData:CheckCanRenameRoom(self._panel.nCurRoom) then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.DormRenamePanel, self._panel.nCurRoom)
end

function DormEditorCtrl:OnBtnClick_MainTabTog(btn, nIdx)
  if nIdx == self.nCurMainTab then
    return
  end
  self._mapNode.listTogCtrl[self.nCurMainTab]:SetDefaultDorm(false)
  self._mapNode.listTogCtrl[nIdx]:SetDefaultDorm(true)
  self.nCurMainTab = nIdx
  if self.nCurMainTab < 3 then
    local nIdx = self.nCurMainTab == 1 and self.nCurFurniturTab1 or self.nCurFurniturTab2
    for i, mapCtrl in ipairs(self._mapNode.furnitureListTogCtrl) do
      mapCtrl:SetDefaultDorm(nIdx == i)
    end
    self:InitFurnitureList()
    self:SetFurnitureTog()
    self._mapNode.rtPresetList:SetActive(false)
    self._mapNode.rtFurnitureList:SetActive(true)
  else
    if not self.bInitPresetListSuc then
      self:InitPresetList()
    else
      self:SetPresetList()
    end
    self._mapNode.rtFurnitureList:SetActive(false)
  end
end

function DormEditorCtrl:OnBtnClick_FurnitureTabTog(btn, nIdx)
  if self.nCurMainTab == 3 then
    return
  end
  local nCurTab
  if self.nCurMainTab == 1 then
    nCurTab = self.nCurFurniturTab1
    self.nCurFurniturTab1 = nIdx
  elseif self.nCurMainTab == 2 then
    nCurTab = self.nCurFurniturTab2
    self.nCurFurniturTab2 = nIdx
  end
  if nCurTab == nIdx then
    return
  end
  if nCurTab ~= nil then
    self._mapNode.furnitureListTogCtrl[nCurTab]:SetDefaultDorm(false)
  end
  self._mapNode.furnitureListTogCtrl[nIdx]:SetDefaultDorm(true)
  self:InitFurnitureList()
end

function DormEditorCtrl:OnBtnClick_PresetTabTog(btn, nIdx)
  if nIdx == self.nCurPresetTab then
    return
  end
  if self.nCurPresetTab ~= nil then
    self._mapNode.presetListTogCtrl[self.nCurPresetTab]:SetDefaultDorm(false)
  end
  self.nCurPresetTab = nIdx
  self._mapNode.presetListTogCtrl[self.nCurPresetTab]:SetDefaultDorm(true)
  self:SetPresetList()
end

function DormEditorCtrl:OnEvent_DORM_CS_SWITCH_FURNITURE(goObj, nFurnitureId, nRatioCur, nRatioMax)
  if goObj == nil then
    self.nCurEditFurniture = 0
    self:SetEditorState(false)
    return
  end
  self:SetRoomRatio()
  local rt = goObj.transform
  if rt ~= nil then
    local bShowDelete = true
    local bShowRot = true
    local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", nFurnitureId)
    if mapFurnitureConfig ~= nil then
      bShowDelete = mapFurnitureConfig.Fixed == 0
      bShowRot = mapFurnitureConfig.Fixed ~= GameEnum.DormFurFixedType.Elevator and mapFurnitureConfig.Fixed ~= GameEnum.DormFurFixedType.Floor and mapFurnitureConfig.Fixed ~= GameEnum.DormFurFixedType.Wall
    end
    self.nCurEditFurniture = nFurnitureId
    self:SetEditorState(true)
    self._mapNode.btnHudDelete.interactable = bShowDelete
    self._mapNode.btnHudRotation.interactable = bShowRot
    NovaAPI.SetImageColor(self._mapNode.imgIconDelete, bShowDelete and Color(1, 1, 1, 1) or Color(1, 1, 1, 0.5))
    NovaAPI.SetImageColor(self._mapNode.imgIconRot, bShowRot and Color(1, 1, 1, 1) or Color(1, 1, 1, 0.5))
    self:SetHudActive(true)
    safe_call_cs_func(CS.DormModuleHelper.SetHudFollowTarget, self._mapNode.rtCenter, rt, Vector3.zero)
  end
end

function DormEditorCtrl:OnEvent_DORM_CS_SET_FUR_HUD(bVisible, bEnableUpdateHudPos)
  self:SetHudActive(bVisible)
  safe_call_cs_func(CS.DormModuleHelper.EnableUpdateHudPos, self._mapNode.rtCenter, bVisible, bEnableUpdateHudPos)
  self:SetRoomRatio()
end

function DormEditorCtrl:OnEvent_DormFurnitureChanged()
  local function GetDormBagInfo(mapFurnitureBag)
    self._panel.mapFurnitureBag = mapFurnitureBag
    
    self._panel.mapFurnitureUsedCount = PlayerData.PlayerDormData:GetUsedCount()
    self.mapFurnitureType = {
      [1] = {},
      [2] = {},
      [3] = {},
      [4] = {},
      [5] = {},
      [6] = {},
      [7] = {},
      [8] = {}
    }
    for nFurnitureId, nTotalCount in pairs(self._panel.mapFurnitureBag) do
      local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", nFurnitureId)
      if mapFurnitureConfig ~= nil and self._panel:GetFurnitureCount(nFurnitureId) > 0 then
        local tbType = self.mapFurnitureType[mapFurnitureConfig.Tab]
        if tbType ~= nil then
          table.insert(tbType, nFurnitureId)
        end
      end
    end
    for _, tbFurniture in pairs(self.mapFurnitureType) do
      table.sort(tbFurniture)
    end
    self:InitFurnitureList()
  end
  
  PlayerData.PlayerDormData:GetBagInfo(GetDormBagInfo)
end

return DormEditorCtrl
