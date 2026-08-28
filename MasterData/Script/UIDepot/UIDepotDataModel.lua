local DataModel = {
  Data = {},
  Index = 0,
  Sort = EnumDefine.Sort.Quality,
  LevelSort = EnumDefine.LevelSort.LevelDesc,
  TimeSort = EnumDefine.TimeSort.TimeDesc,
  QualitySort = EnumDefine.QualitySort.QualityDesc,
  Sort = EnumDefine.Sort.Quality,
  Select = EnumDefine.Depot.Item,
  NextRefreshLimitedItemTime = 0
}

local function IsShowEquipmentFace(row)
  return row ~= nil and row.server ~= nil and row.server.hid ~= nil and row.server.hid ~= ""
end

local function CompareOrderValue(aValue, bValue, isDesc)
  if aValue ~= bValue then
    if isDesc then
      return bValue < aValue
    end
    return aValue < bValue
  end
end

local function GetEquipmentQuality(row)
  return row ~= nil and row.data ~= nil and row.data.qualityInt or 0
end

local function GetEquipmentLevel(row)
  return row ~= nil and row.server ~= nil and tonumber(row.server.lv) or 0
end

local function GetEquipmentObtainTime(row)
  return row ~= nil and row.server ~= nil and tonumber(row.server.obtain_time) or 0
end

local function CompareEquipmentUid(a, b)
  local aUid = tostring(a.eid or "")
  local bUid = tostring(b.eid or "")
  if aUid ~= bUid then
    return aUid < bUid
  end
  return (tonumber(a.id) or 0) < (tonumber(b.id) or 0)
end

local function WrapEquipmentSort(compare)
  return function(a, b)
    local aShowFace = IsShowEquipmentFace(a)
    local bShowFace = IsShowEquipmentFace(b)
    if aShowFace ~= bShowFace then
      return aShowFace
    end
    return compare(a, b)
  end
end

DataModel.SortEquipment = {
  [EnumDefine.QualitySort.QualityDesc] = WrapEquipmentSort(function(a, b)
    local result = CompareOrderValue(GetEquipmentQuality(a), GetEquipmentQuality(b), true)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentLevel(a), GetEquipmentLevel(b), true)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentObtainTime(a), GetEquipmentObtainTime(b), true)
    if result ~= nil then
      return result
    end
    return CompareEquipmentUid(a, b)
  end),
  [EnumDefine.QualitySort.QualityAsc] = WrapEquipmentSort(function(a, b)
    local result = CompareOrderValue(GetEquipmentQuality(a), GetEquipmentQuality(b), false)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentLevel(a), GetEquipmentLevel(b), true)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentObtainTime(a), GetEquipmentObtainTime(b), true)
    if result ~= nil then
      return result
    end
    return CompareEquipmentUid(a, b)
  end),
  [EnumDefine.TimeSort.TimeDesc] = WrapEquipmentSort(function(a, b)
    local result = CompareOrderValue(GetEquipmentObtainTime(a), GetEquipmentObtainTime(b), true)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentQuality(a), GetEquipmentQuality(b), true)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentLevel(a), GetEquipmentLevel(b), true)
    if result ~= nil then
      return result
    end
    return CompareEquipmentUid(a, b)
  end),
  [EnumDefine.TimeSort.TimeAsc] = WrapEquipmentSort(function(a, b)
    local result = CompareOrderValue(GetEquipmentObtainTime(a), GetEquipmentObtainTime(b), false)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentQuality(a), GetEquipmentQuality(b), true)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentLevel(a), GetEquipmentLevel(b), true)
    if result ~= nil then
      return result
    end
    return CompareEquipmentUid(a, b)
  end),
  [EnumDefine.LevelSort.LevelDesc] = WrapEquipmentSort(function(a, b)
    local result = CompareOrderValue(GetEquipmentLevel(a), GetEquipmentLevel(b), true)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentQuality(a), GetEquipmentQuality(b), true)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentObtainTime(a), GetEquipmentObtainTime(b), true)
    if result ~= nil then
      return result
    end
    return CompareEquipmentUid(a, b)
  end),
  [EnumDefine.LevelSort.LevelAsc] = WrapEquipmentSort(function(a, b)
    local result = CompareOrderValue(GetEquipmentLevel(a), GetEquipmentLevel(b), false)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentQuality(a), GetEquipmentQuality(b), true)
    if result ~= nil then
      return result
    end
    result = CompareOrderValue(GetEquipmentObtainTime(a), GetEquipmentObtainTime(b), true)
    if result ~= nil then
      return result
    end
    return CompareEquipmentUid(a, b)
  end)
}

function DataModel:HaveOwnerEquip()
  self.OwnerEquip = {}
  for i, v in pairs(PlayerData.ServerData.roles) do
    if v.equips then
      for a, b in ipairs(v.equips) do
        if b ~= "" then
          self.OwnerEquip[b] = v.id
        end
      end
    end
  end
end

local function SetItemData(id, source, type)
  if source ~= 0 then
    local ca = PlayerData:GetFactoryData(id)
    local server = {}
    server.obtain_time = ""
    server.dead_line = ""
    server.id = id
    server.num = source
    table.insert(DataModel.Data[type], {
      server = server,
      id = tonumber(id),
      data = ca
    })
  end
end

function DataModel:NewData(type)
  if type == EnumDefine.Depot.Equipment then
    for i, v in pairs(PlayerData:GetEquips()) do
      local data = PlayerData:GetFactoryData(v.id, "EquipmentFactory")
      data.skills = v.skills
      if (self.FilterType[0] or self.FilterType[PlayerData:GetFactoryData(data.equipTagId, "TagFactory").typeID]) and (self.FilterRarity[0] or self.FilterRarity[data.qualityInt + 1]) and (self.FilterState[0] or self.FilterState[1] and self.OwnerEquip[i] or self.FilterState[2] and not self.OwnerEquip[i]) then
        table.insert(DataModel.Data[type], {
          server = v,
          id = tonumber(v.id),
          eid = i,
          data = data
        })
      end
    end
  elseif type == EnumDefine.Depot.Item then
    for i, v in pairs(PlayerData:GetItems()) do
      local CA = PlayerData:GetFactoryData(i, "ItemFactory")
      if CA then
        local mod = CA.mod
        if v.num ~= 0 and not CA.isNotDisplayInBag and mod ~= "\228\191\161\231\137\169" and not CA.isDisplayInKeyWare then
          if not string.nilorempty(CA.endTime) then
            local remainTime = TimeUtil:LastTime(CA.endTime)
            if 0 < remainTime then
              table.insert(DataModel.Data[type], {
                server = v,
                id = tonumber(i),
                data = CA,
                remainTime = remainTime
              })
            end
          else
            table.insert(DataModel.Data[type], {
              server = v,
              id = tonumber(i),
              data = CA
            })
          end
        end
      end
    end
    local limitedCache = {}
    local curTime = TimeUtil:GetServerTimeStamp()
    for k, v in pairs(PlayerData:GetLimitedItems()) do
      local CA = PlayerData:GetFactoryData(v.id, "ItemFactory")
      if CA and not CA.isNotDisplayInBag and CA.limitedTime and 0 < CA.limitedTime and curTime < v.dead_line then
        local remainDay = math.ceil((v.dead_line - curTime) / 86400)
        if limitedCache[v.id] == nil then
          limitedCache[v.id] = {}
        end
        if limitedCache[v.id][remainDay] == nil then
          limitedCache[v.id][remainDay] = {}
        end
        local t
        t = limitedCache[v.id][remainDay]
        t.id = v.id
        t.remainDay = remainDay
        if t.uid == nil then
          t.uid = {}
        end
        table.insert(t.uid, k)
        t.caData = CA
      end
    end
    local limitedInfo = PlayerData:GetLimitedItems()
    for k, v in pairs(limitedCache) do
      for k1, v1 in pairs(v) do
        table.sort(v1.uid, function(a, b)
          return limitedInfo[a].dead_line < limitedInfo[b].dead_line
        end)
        local count = #v1.uid
        v1.dead_line = limitedInfo[v1.uid[1]].dead_line or 0
        v1.num = count
        table.insert(DataModel.Data[type], {
          num = count,
          limitedData = v1,
          id = tonumber(v1.id),
          data = v1.caData
        })
      end
    end
    SetItemData(11400001, PlayerData:GetUserInfo().gold, type)
    SetItemData(11400005, PlayerData:GetUserInfo().bm_rock, type)
    SetItemData(11400017, PlayerData:GetUserInfo().medal, type)
  elseif type == EnumDefine.Depot.Material then
    for i, v in pairs(PlayerData:GetMaterials()) do
      local CA = PlayerData:GetFactoryData(i, "SourceMaterialFactory")
      if v.num ~= 0 and not CA.isNotDisplayInBag then
        table.insert(DataModel.Data[type], {
          server = v,
          id = tonumber(i),
          data = CA
        })
      end
    end
  elseif type == EnumDefine.Depot.Warehouse then
    for i, v in pairs(PlayerData:GetGoods()) do
      local ca = PlayerData:GetFactoryData(i)
      if ca.mod ~= "\229\158\131\229\156\190" and v.num ~= 0 then
        table.insert(DataModel.Data[type], {
          server = v,
          id = tonumber(i),
          data = ca
        })
      end
    end
  elseif type == EnumDefine.Depot.FridgeItem then
    for i, v in pairs(PlayerData:GetFridgeItems()) do
      if v.num ~= 0 then
        local data = PlayerData:GetFactoryData(i, "FridgeItemFactory")
        data.endTime = data.endTime or ""
        table.insert(DataModel.Data[type], {
          server = v,
          id = tonumber(i),
          data = PlayerData:GetFactoryData(i, "FridgeItemFactory")
        })
      end
    end
  elseif type == EnumDefine.Depot.TrainWeapon then
    for k, v in pairs(PlayerData:GetBattery()) do
      local CA = PlayerData:GetFactoryData(v.id)
      table.insert(DataModel.Data[type], {
        server = v,
        id = tonumber(v.id),
        data = CA,
        uid = k
      })
    end
  elseif type == EnumDefine.Depot.Keepsake then
    for i, v in pairs(PlayerData:GetItems()) do
      local CA = PlayerData:GetFactoryData(i, "ItemFactory")
      if CA then
        local mod = CA.mod
        if v.num ~= 0 and mod == "\228\191\161\231\137\169" then
          table.insert(DataModel.Data[type], {
            server = v,
            id = tonumber(i),
            data = CA
          })
        end
      end
    end
  elseif type == EnumDefine.Depot.WareGoods then
    for k, v in pairs(DataModel.wareHouseGoodsList) do
      local CA = PlayerData:GetFactoryData(v.id)
      table.insert(DataModel.Data[type], {
        server = v,
        id = tonumber(v.id),
        data = CA
      })
    end
  elseif type == EnumDefine.Depot.Key then
    for i, v in pairs(PlayerData:GetItems()) do
      local CA = PlayerData:GetFactoryData(i, "ItemFactory")
      if CA and v.num ~= 0 and CA.isDisplayInKeyWare then
        table.insert(DataModel.Data[type], {
          server = v,
          id = tonumber(i),
          data = CA
        })
      end
    end
  end
end

function DataModel:GetDataByType(type, sort, refresh)
  local isNew = false
  if refresh or self.Data[type] == nil or #self.Data[type] == 0 then
    self.Data[type] = {}
    self:NewData(type)
    if type == EnumDefine.Depot.Equipment then
      self.Sort = sort or EnumDefine.Sort.Quality
      if self.Sort == EnumDefine.Sort.Quality then
        table.sort(self.Data[type], DataModel.SortEquipment[self.QualitySort])
      elseif self.Sort == EnumDefine.Sort.Time then
        table.sort(self.Data[type], DataModel.SortEquipment[self.TimeSort])
      elseif self.Sort == EnumDefine.Sort.Level then
        table.sort(self.Data[type], DataModel.SortEquipment[self.LevelSort])
      end
    elseif type == EnumDefine.Depot.Warehouse then
      table.sort(self.Data[type], function(a, b)
        if a.data.sort ~= b.data.sort then
          return a.data.sort > b.data.sort
        end
        if a.data.qualityInt ~= b.data.qualityInt then
          return a.data.qualityInt > b.data.qualityInt
        end
        return a.data.id > b.data.id
      end)
    elseif type == EnumDefine.Depot.TrainWeapon then
      table.sort(self.Data[type], function(a, b)
        local isEquip1 = DataModel.WeaponIsEquipByUid(a.uid)
        local isEquip2 = DataModel.WeaponIsEquipByUid(b.uid)
        if isEquip1 ~= isEquip2 then
          return isEquip1
        end
        if a.data.qualityInt ~= b.data.qualityInt then
          return a.data.qualityInt > b.data.qualityInt
        end
        if a.server.lv ~= b.server.lv then
          return a.server.lv > b.server.lv
        end
        return a.server.obtain_time > b.server.obtain_time
      end)
    else
      table.sort(self.Data[type], function(a, b)
        local aTimeCompare = 0
        local bTimeCompare = 0
        local aLimitedTime = a.limitedData and a.limitedData.dead_line or 0
        local bLimitedTime = b.limitedData and b.limitedData.dead_line or 0
        if a.data.endTime ~= "" then
          aTimeCompare = TimeUtil:TimeStamp(a.data.endTime)
        end
        if b.data.endTime ~= "" then
          bTimeCompare = TimeUtil:TimeStamp(b.data.endTime)
        end
        if aLimitedTime > aTimeCompare then
          aTimeCompare = aLimitedTime
        end
        if bLimitedTime > bTimeCompare then
          bTimeCompare = bLimitedTime
        end
        if aTimeCompare > bTimeCompare then
          return true
        elseif aTimeCompare < bTimeCompare then
          return false
        end
        if a.data.sort ~= b.data.sort then
          return a.data.sort > b.data.sort
        end
        if a.data.qualityInt ~= b.data.qualityInt then
          return a.data.qualityInt > b.data.qualityInt
        end
        return a.data.id > b.data.id
      end)
    end
  end
  return DataModel.Data[type]
end

function DataModel:Reset()
  self:RefreshNextRefreshLimitedItemTime()
  self.Data = {}
  self:HaveOwnerEquip()
  self.EquipType = {}
  self.FilterType = {
    [0] = true
  }
  self.FilterState = {
    [0] = true
  }
  self.FilterRarity = {
    [0] = true
  }
  local ConfigFactory = PlayerData:GetFactoryData(99900017, "ConfigFactory")
  for i, v in ipairs(ConfigFactory.enumEquipTypeList) do
    local data = PlayerData:GetFactoryData(v.equipType, "TagFactory")
    if self.FilterType[i] == nil then
      self.FilterType[i] = false
    end
    self.EquipType[i] = self.EquipType[i] or {
      name = data.Name,
      detail = {},
      id = data.id,
      typeID = data.typeID
    }
  end
  for i, v in ipairs(ConfigFactory.commonRareList) do
    if self.FilterRarity[i] == nil then
      self.FilterRarity[i] = false
    end
  end
  for i = 1, 2 do
    if self.FilterState[i] == nil then
      self.FilterState[i] = false
    end
  end
end

function DataModel:GetNextSoundTime()
  math.randomseed(os.time())
  local TrustConfig = PlayerData:GetFactoryData(99900039)
  self.nextDelay = TrustConfig.talkIntervalMin + math.random(0, TrustConfig.talkIntervalRandom)
  self.nextPlaySoundTime = self.nextDelay + os.time()
end

function DataModel:RefreshNextRefreshLimitedItemTime()
  local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
  local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
  local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
  local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
  local targetTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
  DataModel.NextRefreshLimitedItemTime = targetTime
end

function DataModel.WeaponIsEquipByUid(uid)
  local serverBatteryData = PlayerData:GetBattery()[uid]
  if serverBatteryData.u_cid then
    return serverBatteryData.u_cid ~= ""
  end
  local train_pendant = PlayerData:GetHomeInfo().train_pendant
  for k, v in pairs(train_pendant) do
    if v ~= "" and v == uid then
      return true
    end
  end
  local train_accessories = PlayerData:GetHomeInfo().train_accessories
  for k, v in pairs(train_accessories) do
    if v ~= "" and v == uid then
      return true
    end
  end
  return false
end

function DataModel.CalWareHouseGoodsData(init)
  local isAll = next(DataModel.selectStationDic) == nil
  DataModel.wareHouseGoodsList = {}
  DataModel.wareHouseGoodsNum = 0
  DataModel.wareHouseCapacity = 0
  local wareHouseDic = {}
  for k, v in pairs(PlayerData:GetGoods()) do
    local num = 0
    for k1, v1 in pairs(v.stations or {}) do
      local nowNum = (isAll or DataModel.selectStationDic[k1]) and v1 or 0
      if 0 < nowNum then
        wareHouseDic[k1] = 1
      end
      num = num + nowNum
    end
    DataModel.wareHouseGoodsNum = DataModel.wareHouseGoodsNum + num
    if 0 < num then
      table.insert(DataModel.wareHouseGoodsList, {id = k, num = num})
    end
  end
  for k, v in pairs(wareHouseDic) do
    local stationId = k
    if init then
      table.insert(DataModel.wareHouseStationList, stationId)
    end
    local nowCapacity = PlayerData:GetHomeInfo().stations[stationId].max_goods_space or 0
    DataModel.wareHouseCapacity = DataModel.wareHouseCapacity + nowCapacity
  end
  for i, v in ipairs(DataModel.wareHouseStationList) do
    DataModel.wareHouseGoodsNum = DataModel.wareHouseGoodsNum + PlayerData.GetStationCurrentTransitGoodsNum(v)
  end
  table.sort(DataModel.wareHouseStationList, function(t1, t2)
    return t2 < t1
  end)
end

function DataModel.InitWareHouseData()
  DataModel.wareHouseStationList = {}
  DataModel.selectStationDic = {}
  DataModel.CalWareHouseGoodsData(true)
end

function DataModel.UpdateStationDic(cityId)
  DataModel.lastSelectDic[cityId] = not DataModel.lastSelectDic[cityId] and 1 or nil
end

return DataModel
