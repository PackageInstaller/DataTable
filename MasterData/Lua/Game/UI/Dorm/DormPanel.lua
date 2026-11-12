local DormPanel = class("DormPanel", BasePanel)
DormPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormPanel.prefab",
    sCtrlName = "Game.UI.Dorm.DormCtrl"
  }
}

function DormPanel:Awake()
  self.mapDormRoomInfo = {}
  self.mapDormBaseData = {}
  self.mapFurnitureBag = {}
  self.mapCoverSprites = {}
  self.mapFurnitureUsedCount = {}
  self.mapDormSuitData = {}
  self.mapPresetInfo = nil
  self.tbRoomId = {}
  self.tempEditCount = {}
  self.nCurRoom = 0
  self.nPresetCount = 0
  self.nCurMode = -1
  self.nCurInteractiveMode = 0
  self.nCurVisitFriendUid = 0
  self.nCustomBgm = 0
  self.nModeBeforeVisitFriend = 0
  self:InitSuitData()
  self.bPrevDisc = false
end

function DormPanel:OnEnable()
end

function DormPanel:OnDisable()
  self:ReleaseAllPresetCover()
end

function DormPanel:OnDestroy()
end

function DormPanel:InitSuitData()
  local function forEachLayoutFurniture(mapData)
    if self.mapDormSuitData[mapData.RoomLayoutId] == nil then
      self.mapDormSuitData[mapData.RoomLayoutId] = {}
    end
    table.insert(self.mapDormSuitData[mapData.RoomLayoutId], {
      FurnitureId = mapData.FurnitureId,
      X = mapData.Pos[1],
      Y = mapData.Pos[2],
      Z = mapData.Pos[3],
      Rotation = mapData.Rot
    })
  end
  
  ForEachTableLine(DataTable.DormRoomLayout, forEachLayoutFurniture)
end

function DormPanel:GetFurnitureCount(nId)
  local nTotalCount = self.mapFurnitureBag[nId] or 0
  local nCurUsedCount = 0
  for _, mapRoomUsedCount in pairs(self.mapFurnitureUsedCount) do
    nCurUsedCount = nCurUsedCount + (mapRoomUsedCount[nId] or 0)
  end
  nTotalCount = nTotalCount - nCurUsedCount
  if self.tempEditCount[nId] ~= nil then
    nTotalCount = nTotalCount - self.tempEditCount[nId]
  end
  return nTotalCount
end

function DormPanel:GetBagFurnitureCount(nFurnitureId)
  return self.mapFurnitureBag[nFurnitureId] or 0
end

function DormPanel:GetFurnitureCountIncludeCurRoom(nIncludeRoom, nId)
  local nTotalCount = self.mapFurnitureBag[nId] or 0
  local nCurUsedCount = 0
  for nRoomId, mapRoomUsedCount in pairs(self.mapFurnitureUsedCount) do
    if nRoomId ~= nIncludeRoom then
      nCurUsedCount = nCurUsedCount + (mapRoomUsedCount[nId] or 0)
    end
  end
  nTotalCount = nTotalCount - nCurUsedCount
  return nTotalCount
end

function DormPanel:SetTempFurnitureCount(nId, nCount)
  if nId == 0 then
    return
  end
  if self.tempEditCount[nId] == nil then
    self.tempEditCount[nId] = 0
  end
  self.tempEditCount[nId] = self.tempEditCount[nId] + nCount
end

function DormPanel:GetFixedInCurRoom(nType)
  if nType == 0 then
    return 0, 0
  end
  local mapUsedCountCurRoom = self.mapFurnitureUsedCount[self.nCurRoom]
  if mapUsedCountCurRoom ~= nil then
    for nFurnitureId, nCount in pairs(mapUsedCountCurRoom) do
      local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", nFurnitureId)
      if mapFurnitureConfig ~= nil and mapFurnitureConfig.Fixed == nType then
        local nCurEditorCount = self.tempEditCount[nFurnitureId] or 0
        local nCurCount = nCount + nCurEditorCount
        if 0 < nCurCount then
          return nFurnitureId, nCount
        end
        break
      end
    end
  end
  for nFurnitureId, nCount in pairs(self.tempEditCount) do
    local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", nFurnitureId)
    if mapFurnitureConfig ~= nil and mapFurnitureConfig.Fixed == nType and 0 < nCount then
      return nFurnitureId, nCount
    end
  end
  return 0, 0
end

function DormPanel:GetNextRoom()
  if #self.tbRoomId == 0 then
    for nRoomId, _ in pairs(self.mapDormRoomInfo) do
      table.insert(self.tbRoomId, nRoomId)
    end
    table.sort(self.tbRoomId)
  end
  local curIdx = table.indexof(self.tbRoomId, self.nCurRoom)
  local nNextIdx = curIdx + 1 > #self.tbRoomId and 1 or curIdx + 1
  return self.tbRoomId[nNextIdx]
end

function DormPanel:SaveRoom(completeCallback, bNotNeedConfirm, sContentLanguage, sConfirmLanguage, sCancelLanguage)
  NovaAPI.DispatchEventWithData("DORM_LUA_SAVE_ROOM")
  local csData = safe_call_cs_func(CS.DormModuleHelper.GetDormData)
  
  local function callback()
    self.tempEditCount = {}
    
    local function GetRoomInfoCallback(mapDormRoomInfo)
      self.mapDormRoomInfo = mapDormRoomInfo
    end
    
    PlayerData.PlayerDormData:GetRoomInfo(GetRoomInfoCallback)
    
    local function GetBagInfoCallback(mapFurnitureBag)
      self.mapFurnitureBag = mapFurnitureBag
      self.mapFurnitureUsedCount = PlayerData.PlayerDormData:GetUsedCount()
    end
    
    PlayerData.PlayerDormData:GetBagInfo(GetBagInfoCallback)
    if completeCallback ~= nil and type(completeCallback) == "function" then
      completeCallback(true)
    end
  end
  
  local function confirmCallback()
    if csData[1] ~= 0 then
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
      EventManager.Hit("DormGuide_SaveResult", false, "rejected")
      return
    end
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
    PlayerData.PlayerDormData:SaveDormFurniture(self.nCurRoom, mapData, 0, callback)
  end
  
  local function cancelCallback()
    if completeCallback ~= nil and type(completeCallback) == "function" then
      completeCallback(false)
    end
  end
  
  if csData[0] ~= 3 then
    if completeCallback ~= nil and type(completeCallback) == "function" then
      completeCallback(false)
    end
    return
  end
  local nValue = csData[1]
  if csData[1] == 4 then
    if completeCallback ~= nil and type(completeCallback) == "function" then
      completeCallback(true)
    end
    return
  end
  if bNotNeedConfirm == true then
    confirmCallback()
    return
  else
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sContentLanguage or ConfigTable.GetUIText("Dorm_SaveConfirmContent"),
      callbackConfirmAfterClose = confirmCallback,
      callbackCancel = cancelCallback,
      bDisableSnap = false,
      bCloseNoHandler = true,
      sCancel = sCancelLanguage,
      sConfirm = sConfirmLanguage
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
    return
  end
end

function DormPanel:GetDormRewardId()
  return self.mapDormBaseData.rewardIds or {}
end

function DormPanel:CapturerPresetCover(nTime)
  local sName = tostring(nTime)
  local bOutside = true
  local mapRoomCfg = ConfigTable.GetData("DormRoom", self.nCurRoom)
  if mapRoomCfg ~= nil then
    bOutside = mapRoomCfg.RoomType == GameEnum.DormRoomType.Outdoor
  end
  local bSuc = safe_call_cs_func(CS.DormModuleHelper_HotFix.CaptureSceneImage, tostring(PlayerData.Base._nPlayerId), sName, bOutside)
  if bSuc then
    self.mapCoverSprites[sName] = safe_call_cs_func(CS.DormModuleHelper_HotFix.LoadSceneCaptureImageSprite, tostring(PlayerData.Base._nPlayerId), sName)
  end
end

function DormPanel:LoadCaptureCover(tbCurPreset)
  safe_call_cs_func(CS.DormModuleHelper_HotFix.CleanSceneCaptureImages, tostring(PlayerData.Base._nPlayerId), tbCurPreset)
  for _, sPresetSpriteName in ipairs(tbCurPreset) do
    self.mapCoverSprites[sPresetSpriteName] = safe_call_cs_func(CS.DormModuleHelper_HotFix.LoadSceneCaptureImageSprite, tostring(PlayerData.Base._nPlayerId), sPresetSpriteName)
  end
end

function DormPanel:GetPresetCover(sName)
  return self.mapCoverSprites[sName]
end

function DormPanel:ReleaseAllPresetCover()
  for sName, sp in pairs(self.mapCoverSprites) do
    safe_call_cs_func(CS.DormModuleHelper_HotFix.ReleaseSceneCaptureImageSprite, sp)
  end
  self.mapCoverSprites = {}
end

function DormPanel:SetDormBGM()
  if self.nCurMode == 3 then
    local nBGM = self.nCustomBgm
    if 0 < nBGM then
      local mapIPCfg = ConfigTable.GetData("DiscIP", nBGM)
      if mapIPCfg ~= nil then
        local sVoFile = mapIPCfg.VoFile
        CS.WwiseAudioManager.Instance:SetDormMusic("outfit", sVoFile)
      end
    else
      CS.WwiseAudioManager.Instance:SetDormMusic("system", "houZhai")
    end
  else
    local mapRoomInfo = self.mapDormRoomInfo[self.nCurRoom]
    if mapRoomInfo ~= 0 then
      local nBGM = mapRoomInfo.DiscId
      if 0 < nBGM then
        local mapIPCfg = ConfigTable.GetData("DiscIP", nBGM)
        if mapIPCfg ~= nil then
          local sVoFile = mapIPCfg.VoFile
          CS.WwiseAudioManager.Instance:SetDormMusic("outfit", sVoFile)
        end
      else
        CS.WwiseAudioManager.Instance:SetDormMusic("system", "houZhai")
      end
    end
  end
end

return DormPanel
