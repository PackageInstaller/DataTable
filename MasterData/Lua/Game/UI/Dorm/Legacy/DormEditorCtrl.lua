local DormEditorCtrl = class("DormEditorCtrl", BaseCtrl)
DormEditorCtrl._mapNodeConfig = {
  rtFurnitureBg = {
    sComponentName = "RectTransform"
  },
  btnFurnitureListOpen = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FurnitureListOpen"
  },
  btnFurnitureListClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FurnitureListClose"
  },
  rtPresetBg = {
    sComponentName = "RectTransform"
  },
  btnPresetOpen = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PresetOpen"
  },
  btnPresetClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PresetClose"
  },
  btnInteractiveMode = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_InteractiveMode"
  },
  btnExitEditor = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ExitEditor"
  },
  btnHudDelete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HudDelete"
  },
  btnHudRotation = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HudRotation"
  },
  btnPresetSave = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PresetSave"
  },
  btnPresetApply = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PresetApply"
  },
  btnSaveRoom = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SaveRoom"
  },
  btnClearRoom = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClearRoom"
  },
  btnNextRoom = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NextRoom"
  },
  btnHudCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CancelEdit"
  },
  svFurniture = {
    sComponentName = "LoopScrollView"
  },
  svPreset = {
    sComponentName = "LoopScrollView"
  },
  rtOperate = {
    sComponentName = "CanvasGroup"
  },
  rtCenter = {},
  rtHud = {}
}
DormEditorCtrl._mapEventConfig = {
  DORM_CS_SWITCH_FURNITURE = "OnEvent_DORM_CS_SWITCH_FURNITURE",
  DORM_CS_SET_FUR_HUD = "OnEvent_DORM_CS_SET_FUR_HUD"
}
DormEditorCtrl._mapRedDotConfig = {}

function DormEditorCtrl:Awake()
  self.mapFurnitureCtrl = {}
  self.mapPresetCtrl = {}
  self.tbFurniture = {}
end

function DormEditorCtrl:FadeIn()
end

function DormEditorCtrl:FadeOut()
end

function DormEditorCtrl:OnEnable()
  self.bInitPresetList = false
  self.bInitPresetListSuc = false
  self.bPresetSaveMode = false
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

function DormEditorCtrl:Init(nRoomId)
  self.tbFurniture = {}
  self.nCurEditFurniture = 0
  self.nListWidth = self._mapNode.rtFurnitureBg.rect.width
  self.nPresetHeight = self._mapNode.rtPresetBg.rect.height
  self.gameObject:SetActive(false)
  self._mapNode.rtHud:SetActive(false)
  self:OnBtnClick_PresetClose()
  self:OnBtnClick_FurnitureListOpen()
  self.nCurRoomId = nRoomId
  local nRoomType = 0
  local mapRoomConfig = ConfigTable.GetData("DormRoom", nRoomId)
  if mapRoomConfig ~= nil then
    nRoomType = mapRoomConfig.RoomType
  end
  for nFurnitureId, nTotalCount in pairs(self._panel.mapFurnitureBag) do
    local bAdd = false
    local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", nFurnitureId)
    if mapFurnitureConfig ~= nil then
      bAdd = 0 < table.indexof(mapFurnitureConfig.CanIn, nRoomType)
    end
    if bAdd then
      table.insert(self.tbFurniture, {
        nFurnitureId,
        self._panel:GetFurnitureCount(nFurnitureId)
      })
    end
  end
  self._mapNode.svFurniture:Init(#self.tbFurniture, self, self.OnFurnitureGridRefresh, self.OnFurnitureBtnClickGrid, false)
end

function DormEditorCtrl:InitPresetList()
  local function InitList()
    self._mapNode.svPreset:Init(self._panel.nPresetCount, self, self.OnPresetGridRefresh, self.OnPresetBtnClickGrid, false)
    
    self.bInitPresetListSuc = true
    self:OnBtnClick_PresetOpen()
  end
  
  local function Callback(mapData, nPresetCount)
    self._panel.mapPresetInfo = mapData
    self._panel.nPresetCount = nPresetCount
    InitList()
  end
  
  if self._panel.mapPresetInfo == nil then
    PlayerData.PlayerDormData:GetPresetInfo(Callback)
  else
    InitList()
  end
end

function DormEditorCtrl:SetEditorState(bEditor)
  self._mapNode.rtFurnitureBg.gameObject:SetActive(not bEditor)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtOperate, not bEditor and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.rtOperate, not bEditor)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.rtOperate, not bEditor)
  if not bEditor then
    safe_call_cs_func(CS.DormModuleHelper.UnsetHudFollowTarget, self._mapNode.rtCenter)
    self._mapNode.rtHud:SetActive(false)
    self.nCurEditFurniture = 0
    self._mapNode.svFurniture:ForceRefresh()
  end
end

function DormEditorCtrl:SavePreset(nBuildId)
  NovaAPI.DispatchEventWithData("DORM_LUA_SAVE_ROOM")
  local csData = safe_call_cs_func(CS.DormModuleHelper.GetDormData)
  
  local function callback()
    local function GetNewDataCallback(mapData, nPresetCount)
      self._panel.mapPresetInfo = mapData
      
      self._panel.nPresetCount = nPresetCount
      self._mapNode.svPreset:Init(self._panel.nPresetCount, self, self.OnPresetGridRefresh, self.OnPresetBtnClickGrid, false)
    end
    
    PlayerData.PlayerDormData:GetPresetInfo(GetNewDataCallback)
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
    sContent = "是否保存当前修改",
    callbackConfirm = confirmCallback,
    callbackCancel = cancelCallback,
    bDisableSnap = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function DormEditorCtrl:ApplyPreset(nBuildId)
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
    EventManager.Hit(EventId.OpenMessageBox, "不是该房间类型的预设")
    return
  end
  local roomData = {}
  local nFurnitureLen = #mapPresetData.FurnitureList
  table.insert(roomData, {
    2,
    mapDormCfg.RoomType,
    nBuildId,
    nFurnitureLen,
    0
  })
  for _, mapFurniture in ipairs(mapPresetData.FurnitureList) do
    local nCount = self._panel:GetFurnitureCount(mapFurniture.FurnitureId)
    local curUseCount = mapTempCount[mapFurniture.FurnitureId] or 0
    local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", mapFurniture.FurnitureId)
    if mapFurnitureConfig ~= nil and (nCount >= curUseCount + 1 or 0 < mapFurnitureConfig.Fixed) then
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
    end
  end
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
    mapCtrl:SetCount(self._panel:GetFurnitureCount(mapCtrl.nItemId))
  end
end

function DormEditorCtrl:OnFurnitureGridRefresh(goGrid, idx)
  idx = idx + 1
  local nInstanceId = goGrid:GetInstanceID()
  if self.mapFurnitureCtrl[nInstanceId] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.Legacy.DormFurnitureGridCtrl")
    self.mapFurnitureCtrl[nInstanceId] = mapCtrl
  end
  local tbData = self.tbFurniture[idx]
  self.mapFurnitureCtrl[nInstanceId]:Refresh(tbData[1], self._panel:GetFurnitureCount(tbData[1]), self._panel.nCurRoom)
  self.mapFurnitureCtrl[nInstanceId]:SetSelect(tbData[1] == self.nCurEditFurniture)
end

function DormEditorCtrl:OnFurnitureBtnClickGrid(goGrid, idx)
  idx = idx + 1
  local nInstanceId = goGrid:GetInstanceID()
  local tbData = self.tbFurniture[idx]
  if 1 > self._panel:GetFurnitureCount(tbData[1]) then
    return
  end
  if self.mapFurnitureCtrl[nInstanceId].nItemCount <= 0 then
    return
  end
  self.nCurEditFurniture = tbData[1]
  self.mapFurnitureCtrl[nInstanceId]:SetSelect(true)
  self._panel:SetTempFurnitureCount(self.nCurEditFurniture, 1)
  self.mapFurnitureCtrl[nInstanceId]:SetCount(self._panel:GetFurnitureCount(self.nCurEditFurniture))
  self:SetEditorState(true)
  NovaAPI.DispatchEventWithData("DORM_LUA_CREATE_FURNITURE", nil, self.nCurEditFurniture)
end

function DormEditorCtrl:OnPresetGridRefresh(goGrid, idx)
  idx = idx + 1
  local mapPresetData = self._panel.mapPresetInfo[idx]
  local nInstanceId = goGrid:GetInstanceID()
  if self.mapPresetCtrl[nInstanceId] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.Legacy.DormPresetGridCtrl")
    self.mapPresetCtrl[nInstanceId] = mapCtrl
    mapCtrl:SetSelect(self.bPresetSaveMode)
  end
  if mapPresetData ~= nil then
    self.mapPresetCtrl[nInstanceId]:Refresh("预设" .. idx)
  else
    self.mapPresetCtrl[nInstanceId]:Refresh("暂无预设" .. idx)
  end
end

function DormEditorCtrl:OnPresetBtnClickGrid(goGrid, idx)
  idx = idx + 1
  if self.bPresetSaveMode then
    self:SavePreset(idx)
  else
    local mapPresetData = self._panel.mapPresetInfo[idx]
    if mapPresetData == nil then
      EventManager.Hit(EventId.OpenMessageBox, "暂无预设")
      return
    end
    self:ApplyPreset(idx)
  end
end

function DormEditorCtrl:OnBtnClick_FurnitureListOpen()
  self._mapNode.rtFurnitureBg.anchoredPosition = Vector2(self.nListWidth, 0)
  self._mapNode.btnFurnitureListOpen.gameObject:SetActive(false)
  self._mapNode.btnFurnitureListClose.gameObject:SetActive(true)
end

function DormEditorCtrl:OnBtnClick_FurnitureListClose()
  self._mapNode.rtFurnitureBg.anchoredPosition = Vector2(0, 0)
  self._mapNode.btnFurnitureListOpen.gameObject:SetActive(true)
  self._mapNode.btnFurnitureListClose.gameObject:SetActive(false)
end

function DormEditorCtrl:OnBtnClick_PresetOpen()
  if not self.bInitPresetList then
    self.bInitPresetList = true
    self:InitPresetList()
    return
  end
  if self.bInitPresetListSuc then
    self._mapNode.rtPresetBg.anchoredPosition = Vector2(0, 0)
    self._mapNode.btnPresetOpen.gameObject:SetActive(false)
    self._mapNode.btnPresetClose.gameObject:SetActive(true)
  end
end

function DormEditorCtrl:OnBtnClick_PresetClose()
  self._mapNode.rtPresetBg.anchoredPosition = Vector2(0, -self.nPresetHeight)
  self._mapNode.btnPresetOpen.gameObject:SetActive(true)
  self._mapNode.btnPresetClose.gameObject:SetActive(false)
end

function DormEditorCtrl:OnBtnClick_SaveRoom()
  local function callback(bSaveSuc)
    if bSaveSuc then
      self._panel.tempEditCount = {}
      
      NovaAPI.DispatchEventWithData("DORM_LUA_SAVE_ROOM_SUCC")
    end
  end
  
  self._panel:SaveRoom(callback, false)
end

function DormEditorCtrl:OnBtnClick_NextRoom()
  local function callback(bSaveSuc)
    self._panel.tempEditCount = {}
    
    if bSaveSuc then
      NovaAPI.DispatchEventWithData("DORM_LUA_SAVE_ROOM_SUCC")
    end
    EventManager.Hit("DormPanel_NextRoom")
  end
  
  self._panel:SaveRoom(callback, false)
end

function DormEditorCtrl:OnBtnClick_InteractiveMode()
  EventManager.Hit("DormPanel_BtnInteractive")
end

function DormEditorCtrl:OnBtnClick_ExitEditor()
  NovaAPI.DispatchEventWithData("DORM_LUA_UNSELECT_FURNITURE")
  self:SetEditorState(false)
end

function DormEditorCtrl:OnBtnClick_CancelEdit()
  local tempId = self.nCurEditFurniture
  NovaAPI.DispatchEventWithData("DORM_LUA_CANCEL_FURNITURE")
  local csData = safe_call_cs_func(CS.DormModuleHelper.GetDormData)
  if csData ~= nil and csData.Length == 1 and csData[0] == 1 and 0 < tempId then
    self._panel:SetTempFurnitureCount(tempId, -1)
    for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
      if mapCtrl.nItemId == tempId then
        mapCtrl:SetCount(self._panel:GetFurnitureCount(mapCtrl.nItemId))
      end
    end
  end
end

function DormEditorCtrl:OnBtnClick_HudRotation()
  NovaAPI.DispatchEventWithData("DORM_LUA_ROTATE_FURNITURE", nil, true)
end

function DormEditorCtrl:OnBtnClick_HudDelete()
  self._panel:SetTempFurnitureCount(self.nCurEditFurniture, -1)
  for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
    if mapCtrl.nItemId == self.nCurEditFurniture then
      mapCtrl:SetCount(self._panel:GetFurnitureCount(mapCtrl.nItemId))
    end
  end
  self:SetEditorState(false)
  NovaAPI.DispatchEventWithData("DORM_LUA_DELETE_FURNITURE")
end

function DormEditorCtrl:OnBtnClick_PresetSave()
  self.bPresetSaveMode = true
  for _, mapCtrl in pairs(self.mapPresetCtrl) do
    mapCtrl:SetSelect(true)
  end
end

function DormEditorCtrl:OnBtnClick_PresetApply()
  self.bPresetSaveMode = false
  for _, mapCtrl in pairs(self.mapPresetCtrl) do
    mapCtrl:SetSelect(false)
  end
end

function DormEditorCtrl:OnBtnClick_ClearRoom()
  local mapRoomCfgData = ConfigTable.GetData("DormRoom", self._panel.nCurRoom)
  if mapRoomCfgData == nil then
    return
  end
  local nDefaultLayoutId = mapRoomCfgData.DefaultLayoutId
  local mapDefaultCount = {}
  
  local function forEachLayoutFurniture(mapData)
    if mapData.RoomLayoutId == nDefaultLayoutId then
      if mapDefaultCount[mapData.FurnitureId] == nil then
        mapDefaultCount[mapData.FurnitureId] = 0
      end
      mapDefaultCount[mapData.FurnitureId] = mapDefaultCount[mapData.FurnitureId] + 1
    end
  end
  
  ForEachTableLine(DataTable.DormRoomLayout, forEachLayoutFurniture)
  self.nCurEditFurniture = 0
  self:SetEditorState(false)
  NovaAPI.DispatchEventWithData("DORM_LUA_CLEAR_ROOM")
  local mapUsedCount = self._panel.mapFurnitureUsedCount[self._panel.nCurRoom]
  self._panel.tempEditCount = {}
  if mapUsedCount ~= nil then
    for nItemId, nUsedCount in pairs(mapUsedCount) do
      local nDefaultCount = mapDefaultCount[nItemId] or 0
      self._panel.tempEditCount[nItemId] = nDefaultCount - nUsedCount
    end
    for _, mapCtrl in pairs(self.mapFurnitureCtrl) do
      mapCtrl:SetCount(self._panel:GetFurnitureCount(mapCtrl.nItemId))
    end
  end
end

function DormEditorCtrl:OnEvent_DORM_CS_SWITCH_FURNITURE(goObj, nFurnitureId)
  if goObj == nil then
    self.nCurEditFurniture = 0
    self:SetEditorState(false)
    return
  end
  local rt = goObj.transform
  if rt ~= nil then
    local bShowDelete = true
    local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", nFurnitureId)
    if mapFurnitureConfig ~= nil then
      bShowDelete = mapFurnitureConfig.Fixed == 0
    end
    self.nCurEditFurniture = nFurnitureId
    self._mapNode.rtHud:SetActive(true)
    self:SetEditorState(true)
    self._mapNode.btnHudDelete.gameObject:SetActive(bShowDelete)
    safe_call_cs_func(CS.DormModuleHelper.SetHudFollowTarget, self._mapNode.rtCenter, rt, Vector3.zero)
  end
end

function DormEditorCtrl:OnEvent_DORM_CS_SET_FUR_HUD(bVisible, bEnableUpdateHudPos)
  self._mapNode.rtHud:SetActive(bVisible)
  safe_call_cs_func(CS.DormModuleHelper.EnableUpdateHudPos, self._mapNode.rtCenter, bVisible, bEnableUpdateHudPos)
end

return DormEditorCtrl
