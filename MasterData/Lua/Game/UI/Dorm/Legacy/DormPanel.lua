local DormPanel = class("DormPanel", BasePanel)
DormPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/Legacy1/DormPanel.prefab",
    sCtrlName = "Game.UI.Dorm.Legacy.DormCtrl"
  }
}

function DormPanel:Awake()
  self.mapDormRoomInfo = {}
  self.mapFurnitureBag = {}
  self.mapFurnitureUsedCount = {}
  self.mapPresetInfo = nil
  self.mapDormSuitData = {}
  self.tbRoomId = {}
  self.tempEditCount = {}
  self.nCurRoom = 0
  self.nPresetCount = 0
  self.nCurMode = 0
  self.nCurInteractiveMode = 0
  self:InitSuitData()
end

function DormPanel:OnEnable()
end

function DormPanel:OnDisable()
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

function DormPanel:GetFurnitureCountIncludeCurRoom(nIncludeRoom, nId)
  local nTotalCount = self.mapFurnitureBag[nId] or 0
  local nCurUsedCount = 0
  for nRoomId, mapRoomUsedCount in pairs(self.mapFurnitureUsedCount) do
    if nRoomId ~= nIncludeRoom then
      nCurUsedCount = nCurUsedCount + (mapRoomUsedCount[nId] or 0)
    end
  end
  nTotalCount = nTotalCount - nCurUsedCount
  if self.tempEditCount[nId] ~= nil then
    nTotalCount = nTotalCount - self.tempEditCount[nId]
  end
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

function DormPanel:SaveRoom(completeCallback)
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
  if csData[1] == 4 then
    if completeCallback ~= nil and type(completeCallback) == "function" then
      completeCallback(true)
    end
    return
  end
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

return DormPanel
