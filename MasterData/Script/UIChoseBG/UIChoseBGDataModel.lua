local DataModel = {
  MainUIConfigId = 99900034,
  HomeConfigId = 99900014,
  PlayerPrefsKey = "AdjutantRoomBack",
  LockPrefsKeyPrefix = "AdjutantRoomBackLock_",
  LockSceneIndexPrefsKeyPrefix = "AdjutantRoomBackLockSceneIndex_",
  CurrentRoomBackField = "room_back",
  InitParams = nil,
  RoomBackList = {},
  RoomBackConfigMap = {},
  RoomBackRowMap = {},
  CurrentRoomBackId = 0,
  SelectIndex = 1,
  ReturnSelectRoomBackId = 0,
  NeedMoveToSelectIndex = false,
  NeedMoveToTop = false
}

local function ToId(value)
  if type(value) == "table" then
    value = value.id or value.ID
  end
  return tonumber(value) or 0
end

local function IsEmpty(value)
  return value == nil or value == ""
end

local function ToNumber(value, default)
  return tonumber(value) or default or 0
end

local function ToCostId(value)
  local costId = ToId(value)
  if 0 < costId then
    return tostring(costId)
  end
  return nil
end

local function ParseTimeToSecond(value)
  if type(value) ~= "string" then
    return 0
  end
  local h, m, s = string.match(value, "^(%d+):(%d+):(%d+)")
  if h == nil then
    h, m = string.match(value, "^(%d+):(%d+)")
    s = 0
  end
  h = tonumber(h) or 0
  m = tonumber(m) or 0
  s = tonumber(s) or 0
  return h * 3600 + m * 60 + s
end

local function GetUserInfo()
  if PlayerData and PlayerData.GetUserInfo then
    return PlayerData:GetUserInfo()
  end
  return PlayerData and PlayerData.ServerData and PlayerData.ServerData.user_info or nil
end

local function BuildOwnedRoomBackItemMap()
  local map = {}
  local items = PlayerData and PlayerData.GetItems and PlayerData:GetItems() or {}
  for itemId, item in pairs(items or {}) do
    local roomBackId = ToId(itemId)
    if 0 < roomBackId and (type(item) ~= "table" or item.num == nil or 0 < item.num) then
      map[roomBackId] = true
    end
  end
  return map
end

local function HasRoomBackByItemMap(roomBackId, ownedRoomBackItemMap)
  roomBackId = ToId(roomBackId)
  if roomBackId <= 0 then
    return false
  end
  if DataModel.IsDefaultRoomBack(roomBackId) then
    return true
  end
  return ownedRoomBackItemMap ~= nil and ownedRoomBackItemMap[roomBackId] == true
end

function DataModel.GetMainUIConfig()
  return PlayerData:GetFactoryData(DataModel.MainUIConfigId, "ConfigFactory")
end

function DataModel.GetDefaultRoomBackId()
  local config = DataModel.GetMainUIConfig()
  return config and ToId(config.defaultRoomBack) or 0
end

function DataModel.IsDefaultRoomBack(roomBackId)
  return ToId(roomBackId) == DataModel.GetDefaultRoomBackId()
end

function DataModel.GetRoomBackConfigList()
  local config = DataModel.GetMainUIConfig()
  local list = {}
  local added = {}
  
  local function AddRoomBack(value)
    local roomBackId = ToId(value)
    if roomBackId <= 0 or added[roomBackId] then
      return
    end
    added[roomBackId] = true
    if type(value) == "table" then
      value.id = roomBackId
      table.insert(list, value)
    else
      table.insert(list, {id = roomBackId})
    end
  end
  
  if config == nil then
    return list
  end
  AddRoomBack(config.defaultRoomBack)
  for _, value in ipairs(config.roomBackList or {}) do
    AddRoomBack(value)
  end
  return list
end

local function IsRoomBackInConfigList(roomBackId, roomBackConfigList)
  roomBackId = ToId(roomBackId)
  for _, value in ipairs(roomBackConfigList or {}) do
    if value.id == roomBackId then
      return true
    end
  end
  return false
end

function DataModel.IsRoomBackInConfig(roomBackId)
  return IsRoomBackInConfigList(roomBackId, DataModel.GetRoomBackConfigList())
end

function DataModel.HasRoomBack(roomBackId)
  return HasRoomBackByItemMap(roomBackId, BuildOwnedRoomBackItemMap())
end

function DataModel.GetServerRoomBackId()
  local userInfo = GetUserInfo()
  if userInfo and userInfo[DataModel.CurrentRoomBackField] ~= nil then
    local roomBackId = ToId(userInfo[DataModel.CurrentRoomBackField])
    if 0 < roomBackId then
      return roomBackId
    end
    return DataModel.GetDefaultRoomBackId()
  end
  local localRoomBackId = PlayerData:GetPlayerPrefs("int", DataModel.PlayerPrefsKey)
  if localRoomBackId and 0 < localRoomBackId then
    return localRoomBackId
  end
  return DataModel.GetDefaultRoomBackId()
end

function DataModel.SetServerRoomBackId(roomBackId)
  roomBackId = ToId(roomBackId)
  local userInfo = GetUserInfo()
  if userInfo then
    userInfo[DataModel.CurrentRoomBackField] = roomBackId
  end
  PlayerData:SetPlayerPrefs("int", DataModel.PlayerPrefsKey, roomBackId)
end

function DataModel.GetCurrentRoomBackId(roomBackConfigList, ownedRoomBackItemMap)
  local roomBackId = DataModel.GetServerRoomBackId()
  roomBackConfigList = roomBackConfigList or DataModel.GetRoomBackConfigList()
  ownedRoomBackItemMap = ownedRoomBackItemMap or BuildOwnedRoomBackItemMap()
  if not IsRoomBackInConfigList(roomBackId, roomBackConfigList) or not HasRoomBackByItemMap(roomBackId, ownedRoomBackItemMap) then
    roomBackId = DataModel.GetDefaultRoomBackId()
  end
  return roomBackId
end

function DataModel.GetTodaySecond()
  local serverTime = TimeUtil:GetServerTimeStamp()
  local timeZone = PlayerData.TimeZone or 0
  local homeConfig = PlayerData:GetFactoryData(DataModel.HomeConfigId, "ConfigFactory")
  if homeConfig and homeConfig.dayScale and 0 < homeConfig.dayScale then
    local scaleOneDaySecond = 86400 / homeConfig.dayScale
    local scaleTimeToday = (serverTime + timeZone * 3600) % scaleOneDaySecond
    return scaleTimeToday / scaleOneDaySecond * 86400
  end
  return (serverTime + timeZone * 3600) % 86400
end

local function BuildRoomBackSceneList(bgPathList, timeKey)
  local list = {}
  if bgPathList == nil or #bgPathList == 0 then
    return list
  end
  for index, value in ipairs(bgPathList) do
    local bgPath = value.bgPath or ""
    if not IsEmpty(bgPath) then
      table.insert(list, {
        time = ParseTimeToSecond(value[timeKey] or value.time or value.changeTime),
        sceneIndex = index,
        bgPath = bgPath
      })
    end
  end
  table.sort(list, function(a, b)
    return a.time < b.time
  end)
  for index, value in ipairs(list) do
    value.sceneIndex = index
  end
  return list
end

local function GetBgPathInfoByTimeList(bgPathList, timeKey, sceneIndex)
  local list = BuildRoomBackSceneList(bgPathList, timeKey)
  if #list == 0 then
    return {
      bgPath = "",
      sceneIndex = 0,
      sceneCount = 0
    }
  end
  sceneIndex = tonumber(sceneIndex)
  if sceneIndex ~= nil and 0 < sceneIndex then
    sceneIndex = math.max(1, math.min(sceneIndex, #list))
    local scene = list[sceneIndex]
    return {
      bgPath = scene.bgPath,
      sceneIndex = sceneIndex,
      sceneCount = #list
    }
  end
  local todaySecond = DataModel.GetTodaySecond()
  local target = list[#list]
  local targetIndex = #list
  for index, value in ipairs(list) do
    if todaySecond >= value.time then
      target = value
      targetIndex = index
    else
      break
    end
  end
  return {
    bgPath = target.bgPath,
    sceneIndex = targetIndex,
    sceneCount = #list
  }
end

function DataModel.GetBgPathByTimeList(bgPathList, timeKey)
  return GetBgPathInfoByTimeList(bgPathList, timeKey).bgPath
end

function DataModel.GetLegacyAdjutantBgPath()
  local config = DataModel.GetMainUIConfig()
  return config and DataModel.GetBgPathByTimeList(config.bgList or {}, "changeTime") or ""
end

function DataModel.GetRoomBackItem(roomBackId)
  roomBackId = ToId(roomBackId)
  if roomBackId <= 0 then
    return nil
  end
  return PlayerData:GetFactoryData(roomBackId, "ItemFactory")
end

local function GetRoomBackCostId(itemConfig, roomBackConfig)
  if itemConfig ~= nil then
    local costId = ToCostId(itemConfig.bgCost or itemConfig.BgCost or itemConfig.BGCost)
    if costId ~= nil then
      return costId
    end
  end
  if roomBackConfig ~= nil then
    return ToCostId(roomBackConfig.bgCost or roomBackConfig.BgCost or roomBackConfig.BGCost)
  end
  return nil
end

local function GetRoomBackPreviewPathByItem(itemConfig)
  if itemConfig == nil then
    return ""
  end
  if itemConfig.bgPathList and itemConfig.bgPathList[1] and not IsEmpty(itemConfig.bgPathList[1].bgPath) then
    return itemConfig.bgPathList[1].bgPath
  end
  return itemConfig.iconPath or ""
end

local function GetRoomBackBgPathInfoByItem(itemConfig, sceneIndex)
  if itemConfig == nil then
    return {
      bgPath = "",
      sceneIndex = 0,
      sceneCount = 0
    }
  end
  return GetBgPathInfoByTimeList(itemConfig.bgPathList or {}, "time", sceneIndex)
end

local function GetRoomBackTimedPathByItem(itemConfig)
  return GetRoomBackBgPathInfoByItem(itemConfig).bgPath
end

local function BuildRoomBackBgPicList(itemConfig)
  local list = {}
  if itemConfig == nil or type(itemConfig.bgIconPathList) ~= "table" then
    return list
  end
  for _, value in ipairs(itemConfig.bgIconPathList) do
    local path = value.path or ""
    if not IsEmpty(path) then
      table.insert(list, {
        path = path,
        pathX = ToNumber(value.pathX),
        pathY = ToNumber(value.pathY)
      })
    end
  end
  return list
end

local function AddRoomBackGetWay(list, getway)
  if type(getway) ~= "table" or IsEmpty(getway.UIName) then
    return
  end
  table.insert(list, {
    funcId = getway.funcId or -1,
    FromLevel = getway.FromLevel or -1,
    DisplayName = getway.DisplayName or getway.GetWay or "",
    UIName = getway.UIName,
    Way3 = getway.Way3 or getway.Way or ""
  })
end

local function AddRoomBackGetWayList(list, getwayList)
  if type(getwayList) ~= "table" then
    return
  end
  for _, getway in ipairs(getwayList) do
    AddRoomBackGetWay(list, getway)
  end
end

local function BuildRoomBackGetWayList(itemConfig, roomBackConfig)
  local list = {}
  if itemConfig == nil and roomBackConfig == nil then
    return list
  end
  if roomBackConfig then
    AddRoomBackGetWayList(list, roomBackConfig.Getway)
    AddRoomBackGetWayList(list, roomBackConfig.GetWay)
    AddRoomBackGetWay(list, roomBackConfig)
  end
  if itemConfig then
    AddRoomBackGetWayList(list, itemConfig.Getway)
    AddRoomBackGetWayList(list, itemConfig.GetWay)
    AddRoomBackGetWay(list, itemConfig)
  end
  return list
end

function DataModel.GetRoomBackGetWayList(roomBackId)
  roomBackId = ToId(roomBackId)
  local row = DataModel.RoomBackRowMap[roomBackId]
  if row and row.getwayList then
    return row.getwayList
  end
  return BuildRoomBackGetWayList(DataModel.GetRoomBackItem(roomBackId), DataModel.RoomBackConfigMap[roomBackId])
end

function DataModel.HasRoomBackGetWay(roomBackId)
  return #DataModel.GetRoomBackGetWayList(roomBackId) > 0
end

function DataModel.GetFirstGetWayIndex(getwayList)
  if type(getwayList) ~= "table" then
    return nil
  end
  for index, getway in ipairs(getwayList) do
    if not IsEmpty(getway.UIName) then
      return index
    end
  end
  return nil
end

function DataModel.GetFirstRoomBackGetWayIndex(roomBackId)
  return DataModel.GetFirstGetWayIndex(DataModel.GetRoomBackGetWayList(roomBackId))
end

function DataModel.GetRoomBackUnlockCostId(roomBackId)
  roomBackId = ToId(roomBackId)
  local row = DataModel.RoomBackRowMap[roomBackId]
  if row then
    return row.bgCost
  end
  return GetRoomBackCostId(DataModel.GetRoomBackItem(roomBackId), DataModel.RoomBackConfigMap[roomBackId])
end

function DataModel.MarkReturnSelectRoomBackId(roomBackId)
  DataModel.ReturnSelectRoomBackId = ToId(roomBackId)
end

function DataModel.HasReturnSelectRoomBackId()
  return ToId(DataModel.ReturnSelectRoomBackId) > 0
end

function DataModel.TakeReturnSelectRoomBackId()
  local roomBackId = ToId(DataModel.ReturnSelectRoomBackId)
  DataModel.ReturnSelectRoomBackId = 0
  return roomBackId
end

function DataModel.GetRoomBackPreviewPath(roomBackId)
  return GetRoomBackPreviewPathByItem(DataModel.GetRoomBackItem(roomBackId))
end

function DataModel.GetRoomBackTimedPath(roomBackId)
  return GetRoomBackTimedPathByItem(DataModel.GetRoomBackItem(roomBackId))
end

function DataModel.GetRoomBackSceneCount(roomBackId)
  return GetRoomBackBgPathInfoByItem(DataModel.GetRoomBackItem(roomBackId)).sceneCount
end

function DataModel.GetRoomBackBgPicList(roomBackId)
  return BuildRoomBackBgPicList(DataModel.GetRoomBackItem(roomBackId))
end

function DataModel.GetCurrentRoomBackBgPicList()
  return DataModel.GetRoomBackBgPicList(DataModel.GetCurrentRoomBackId())
end

local function GetRoomBackLockKey(roomBackId)
  return DataModel.LockPrefsKeyPrefix .. tostring(ToId(roomBackId))
end

local function GetRoomBackLockSceneIndexKey(roomBackId)
  return DataModel.LockSceneIndexPrefsKeyPrefix .. tostring(ToId(roomBackId))
end

function DataModel.GetRoomBackLockState(roomBackId)
  roomBackId = ToId(roomBackId)
  return 0 < roomBackId and PlayerData:GetPlayerPrefs("int", GetRoomBackLockKey(roomBackId)) == 1
end

function DataModel.GetLockedSceneIndex(roomBackId)
  roomBackId = ToId(roomBackId)
  if roomBackId <= 0 then
    return 0
  end
  return PlayerData:GetPlayerPrefs("int", GetRoomBackLockSceneIndexKey(roomBackId))
end

function DataModel.IsRoomBackLocked(roomBackId)
  roomBackId = ToId(roomBackId)
  return DataModel.GetRoomBackLockState(roomBackId) and DataModel.GetLockedSceneIndex(roomBackId) > 0
end

function DataModel.SetRoomBackLock(roomBackId, sceneIndex, isLocked)
  roomBackId = ToId(roomBackId)
  sceneIndex = tonumber(sceneIndex) or 0
  if isLocked and 0 < roomBackId and 0 < sceneIndex then
    PlayerData:SetPlayerPrefs("int", GetRoomBackLockKey(roomBackId), 1)
    PlayerData:SetPlayerPrefs("int", GetRoomBackLockSceneIndexKey(roomBackId), sceneIndex)
    return
  end
  if 0 < roomBackId then
    PlayerData:SetPlayerPrefs("int", GetRoomBackLockKey(roomBackId), 0)
    PlayerData:SetPlayerPrefs("int", GetRoomBackLockSceneIndexKey(roomBackId), 0)
  end
end

function DataModel.ClearRoomBackLock(roomBackId)
  DataModel.SetRoomBackLock(roomBackId, 0, false)
end

function DataModel.GetRoomBackBgPathInfo(roomBackId, sceneIndex)
  roomBackId = ToId(roomBackId)
  if sceneIndex == nil and DataModel.IsRoomBackLocked(roomBackId) then
    sceneIndex = DataModel.GetLockedSceneIndex(roomBackId)
  end
  return GetRoomBackBgPathInfoByItem(DataModel.GetRoomBackItem(roomBackId), sceneIndex)
end

function DataModel.GetCurrentRoomBackBgPathInfo()
  return DataModel.GetRoomBackBgPathInfo(DataModel.GetCurrentRoomBackId())
end

function DataModel.GetCurrentRoomBackBgPath()
  local info = DataModel.GetCurrentRoomBackBgPathInfo()
  local bgPath = info.bgPath
  if IsEmpty(bgPath) then
    bgPath = DataModel.GetLegacyAdjutantBgPath()
  end
  return bgPath
end

local function GetRoomBackDesc(itemConfig)
  if itemConfig == nil then
    return ""
  end
  return itemConfig.description or itemConfig.desc or itemConfig.des or itemConfig.tips or itemConfig.name or ""
end

local function RefreshRoomBackRowScene(row)
  if row == nil then
    return
  end
  row.sceneCount = DataModel.GetRoomBackSceneCount(row.id)
  row.isLock = DataModel.IsRoomBackLocked(row.id)
  row.bgPicList = row.bgPicList or DataModel.GetRoomBackBgPicList(row.id)
  local sceneIndex = row.sceneIndex
  if row.isLock then
    sceneIndex = DataModel.GetLockedSceneIndex(row.id)
  end
  local info = DataModel.GetRoomBackBgPathInfo(row.id, sceneIndex)
  row.sceneIndex = info.sceneIndex
  row.bgPath = info.bgPath
  row.sceneCount = info.sceneCount
end

local function SortRoomBackList()
  table.sort(DataModel.RoomBackList, function(a, b)
    if a.isHave ~= b.isHave then
      return a.isHave == true
    end
    local aIndex = tonumber(a.sortIndex) or 0
    local bIndex = tonumber(b.sortIndex) or 0
    if aIndex ~= bIndex then
      return aIndex < bIndex
    end
    return ToId(a.id) < ToId(b.id)
  end)
end

local function GetRoomBackRowIndex(roomBackId)
  roomBackId = ToId(roomBackId)
  if roomBackId <= 0 then
    return nil
  end
  for index, row in ipairs(DataModel.RoomBackList) do
    if row.id == roomBackId then
      return index
    end
  end
  return nil
end

function DataModel.RefreshRoomBackStates()
  local selectedRow = DataModel.GetSelectedRow()
  local selectedRoomBackId = selectedRow and selectedRow.id or nil
  DataModel.CurrentRoomBackId = DataModel.GetCurrentRoomBackId()
  local ownedRoomBackItemMap = BuildOwnedRoomBackItemMap()
  for _, row in ipairs(DataModel.RoomBackList) do
    row.isHave = HasRoomBackByItemMap(row.id, ownedRoomBackItemMap)
    row.isWear = row.id == DataModel.CurrentRoomBackId
    RefreshRoomBackRowScene(row)
  end
  SortRoomBackList()
  DataModel.SelectIndex = GetRoomBackRowIndex(selectedRoomBackId) or math.min(DataModel.SelectIndex, #DataModel.RoomBackList)
  if DataModel.SelectIndex <= 0 then
    DataModel.SelectIndex = 1
  end
  for index, row in ipairs(DataModel.RoomBackList) do
    row.isSelect = index == DataModel.SelectIndex
  end
end

function DataModel.Init(initParams)
  DataModel.InitParams = initParams
  DataModel.RoomBackList = {}
  DataModel.RoomBackConfigMap = {}
  DataModel.RoomBackRowMap = {}
  DataModel.SelectIndex = 1
  DataModel.NeedMoveToSelectIndex = false
  DataModel.NeedMoveToTop = false
  local roomBackConfigList = DataModel.GetRoomBackConfigList()
  local ownedRoomBackItemMap = BuildOwnedRoomBackItemMap()
  local currentRoomBackId = DataModel.GetCurrentRoomBackId(roomBackConfigList, ownedRoomBackItemMap)
  local returnSelectRoomBackId = DataModel.TakeReturnSelectRoomBackId()
  local currentRoomBackIndex, returnSelectRoomBackIndex
  for _, value in ipairs(roomBackConfigList) do
    local itemConfig = DataModel.GetRoomBackItem(value.id)
    if itemConfig ~= nil then
      local previewPath = GetRoomBackPreviewPathByItem(itemConfig)
      local bgPathInfo = GetRoomBackBgPathInfoByItem(itemConfig)
      local getwayList = BuildRoomBackGetWayList(itemConfig, value)
      local bgCost = GetRoomBackCostId(itemConfig, value)
      DataModel.RoomBackConfigMap[value.id] = value
      local row = {
        id = value.id,
        config = value,
        itemConfig = itemConfig,
        name = itemConfig.name or "",
        desc = GetRoomBackDesc(itemConfig),
        iconPath = itemConfig.iconPath or previewPath,
        previewPath = previewPath,
        sortIndex = #DataModel.RoomBackList + 1,
        bgPath = bgPathInfo.bgPath,
        sceneIndex = bgPathInfo.sceneIndex,
        sceneCount = bgPathInfo.sceneCount,
        bgName = itemConfig.bgName,
        bgPicList = BuildRoomBackBgPicList(itemConfig),
        bgCost = bgCost,
        hasBgCost = bgCost ~= nil,
        getwayList = getwayList,
        hasGetWay = 0 < #getwayList,
        isHave = HasRoomBackByItemMap(value.id, ownedRoomBackItemMap)
      }
      table.insert(DataModel.RoomBackList, row)
      DataModel.RoomBackRowMap[row.id] = row
      if row.id == currentRoomBackId then
        currentRoomBackIndex = #DataModel.RoomBackList
      end
      if row.id == returnSelectRoomBackId then
        returnSelectRoomBackIndex = #DataModel.RoomBackList
      end
    end
  end
  DataModel.SelectIndex = returnSelectRoomBackIndex or currentRoomBackIndex or DataModel.SelectIndex
  DataModel.NeedMoveToSelectIndex = returnSelectRoomBackIndex ~= nil
  DataModel.NeedMoveToTop = returnSelectRoomBackIndex == nil
  DataModel.RefreshRoomBackStates()
end

function DataModel.GetSelectedRow()
  return DataModel.RoomBackList[DataModel.SelectIndex]
end

function DataModel.SelectRoomBack(index)
  index = tonumber(index) or 1
  local row = DataModel.RoomBackList[index]
  if row == nil then
    return false
  end
  DataModel.SelectIndex = index
  DataModel.RefreshRoomBackStates()
  return true
end

function DataModel.SwitchSelectedRoomBackScene()
  local row = DataModel.GetSelectedRow()
  if row == nil or (row.sceneCount or 0) <= 1 then
    return false
  end
  local sceneIndex = (tonumber(row.sceneIndex) or 0) + 1
  if sceneIndex > row.sceneCount then
    sceneIndex = 1
  end
  row.sceneIndex = sceneIndex
  if row.isLock then
    DataModel.SetRoomBackLock(row.id, row.sceneIndex, true)
  end
  RefreshRoomBackRowScene(row)
  return true
end

function DataModel.ToggleSelectedRoomBackLock()
  local row = DataModel.GetSelectedRow()
  if row == nil or (row.sceneCount or 0) <= 1 then
    return false
  end
  if row.isLock then
    DataModel.ClearRoomBackLock(row.id)
    row.sceneIndex = nil
  else
    DataModel.SetRoomBackLock(row.id, row.sceneIndex, true)
  end
  DataModel.RefreshRoomBackStates()
  return true
end

local function ExtractRoomBackIdFromJson(json, fallbackRoomBackId)
  if type(json) ~= "table" then
    return fallbackRoomBackId
  end
  local roomBackId = ToId(json[DataModel.CurrentRoomBackField])
  if 0 < roomBackId then
    return roomBackId
  end
  roomBackId = ToId(json.roomBackId)
  if 0 < roomBackId then
    return roomBackId
  end
  local id = ToId(json.id)
  if 0 < id and DataModel.IsRoomBackInConfig(id) then
    return id
  end
  if type(json.user_info) == "table" then
    return ExtractRoomBackIdFromJson(json.user_info, fallbackRoomBackId)
  end
  return fallbackRoomBackId
end

function DataModel.SetSelectedAsCurrent(callback)
  local row = DataModel.GetSelectedRow()
  if row == nil or not row.isHave then
    if callback then
      callback(false)
    end
    return
  end
  if row.isWear then
    if callback then
      callback(false)
    end
    return
  end
  local roomBackId = row.id
  if Net and Net.SendProto then
    Net:SendProto("main.set_room_back", function(json)
      local newRoomBackId = ExtractRoomBackIdFromJson(json, roomBackId)
      DataModel.SetServerRoomBackId(newRoomBackId)
      DataModel.RefreshRoomBackStates()
      if callback then
        callback(true)
      end
    end, roomBackId)
  else
    DataModel.SetServerRoomBackId(roomBackId)
    DataModel.RefreshRoomBackStates()
    if callback then
      callback(true)
    end
  end
end

return DataModel
