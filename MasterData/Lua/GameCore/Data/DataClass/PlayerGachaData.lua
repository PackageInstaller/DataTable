local RapidJson = require("rapidjson")
local PlayerGachaData = class("PlayerGachaData")

function IsOpenCardPool(sStartTime, sEndTime)
  if string.len(sStartTime) == 0 or string.len(sEndTime) == 0 then
    return true
  end
  local nowTime = CS.ClientManager.Instance.serverTimeStamp
  return nowTime > String2Time(sStartTime) and nowTime < String2Time(sEndTime)
end

function String2Time(sTime)
  if sTime ~= "" then
    return CS.ClientManager.Instance:ISO8601StrToTimeStamp(sTime)
  else
    return 0
  end
end

function PlayerGachaData:Init()
  self.hadData = false
  self._openedPool = {}
  self:RefreshOpenedPool()
  self._mapGachaCount = {}
  self._mapAupMissTimes = {}
  self._mapAMissTimes = {}
  self._AupGuaranteeTimes = {}
  self._mapTotalGachaTimes = {}
  self._mapRecvFirstTenReward = {}
  self._mapRecvGuaranteeReward = {}
  self._mapGachaTotalTimes = {}
  self._mapGachaHistory = {}
  self._mapPoolProbCache = {}
  self._mapNewbieData = {}
  
  local function func_ForEach_Gacha(mapGacha)
    if type(mapGacha.OnceTicket) == "string" then
      mapGacha.OnceTicket = RapidJson.decode(mapGacha.OnceTicket)
    end
    if type(mapGacha.TenTimesTicket) == "string" then
      mapGacha.TenTimesTicket = RapidJson.decode(mapGacha.TenTimesTicket)
    end
  end
  
  ForEachTableLine(DataTable.Gacha, func_ForEach_Gacha)
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
end

function PlayerGachaData:RefreshOpenedPool()
  self._openedPool = {}
  
  local function func_ForEach_Gacha(mapGacha)
    if IsOpenCardPool(mapGacha.StartTime, mapGacha.EndTime) then
      table.insert(self._openedPool, mapGacha.ID)
    end
  end
  
  ForEachTableLine(DataTable.Gacha, func_ForEach_Gacha)
end

function PlayerGachaData:GetOpenedPool()
  local ret = {}
  
  local function func_ForEach_Gacha(mapGacha)
    if mapGacha.StorageId == GameEnum.gachaStorageType.BeginnerCardPool then
      local newbieData = self:GetGachaNewbieData(mapGacha.Id)
      if newbieData ~= nil and not newbieData.Receive then
        table.insert(ret, mapGacha.Id)
      end
    elseif IsOpenCardPool(mapGacha.StartTime, mapGacha.EndTime) then
      table.insert(ret, mapGacha.Id)
    end
  end
  
  ForEachTableLine(DataTable.Gacha, func_ForEach_Gacha)
  return ret
end

function PlayerGachaData:CheckPoolOpen(nPoolId)
  local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolId)
  if mapPoolCfgData == nil then
    return false
  end
  return IsOpenCardPool(mapPoolCfgData.StartTime, mapPoolCfgData.EndTime)
end

function PlayerGachaData:CacheGachaData(mapData)
  if self._mapGachaReward == nil then
    self._mapGachaReward = {}
    
    local function foreach_GachaReward(mapCfgData)
      printLog(mapCfgData.Id)
      if self._mapGachaReward[mapCfgData.GachaId] == nil then
        self._mapGachaReward[mapCfgData.GachaId] = {}
      end
      table.insert(self._mapGachaReward[mapCfgData.GachaId], {
        nId = mapCfgData.Id,
        nIdx = mapCfgData.Index,
        nNum = mapCfgData.Num,
        nItemId = mapCfgData.Tid,
        bRec = false,
        bCan = false
      })
    end
    
    ForEachTableLine(DataTable.GachaReward, foreach_GachaReward)
  end
  for k, v in pairs(mapData) do
    self._mapGachaCount[v.Id] = v.DaysCount
    self._mapAupMissTimes[v.Id] = v.AupMissTimes
    self._mapTotalGachaTimes[v.Id] = v.TotalTimes
    self._AupGuaranteeTimes[v.Id] = v.AupGuaranteeTimes
    self._mapRecvFirstTenReward[v.Id] = v.ReveFirstTenReward
    self._mapRecvGuaranteeReward[v.Id] = v.RecvGuaranteeReward
    self._mapGachaTotalTimes[v.Id] = v.GachaTotalTimes
    self._mapAMissTimes[v.Id] = v.AMissTimes
    if type(self._mapGachaReward[v.Id]) == "table" then
      local data = UTILS.ParseByteString(v.RewardsRecords)
      for ii, vv in ipairs(self._mapGachaReward[v.Id]) do
        vv.bRec = UTILS.IsBitSet(data, vv.nIdx) == true
        vv.bCan = self._mapGachaTotalTimes[v.Id] >= vv.nNum
      end
    else
      local cfg = ConfigTable.GetData("Gacha", v.Id)
      local nStorageId = cfg.StorageId
      if nStorageId == GameEnum.gachaStorageType.CharacterCardRewardPool then
        printError("角色卡池累抽赠奖数据错误：数据。卡池id" .. tostring(v.Id))
      end
    end
  end
  self:CheckRedDot()
end

function PlayerGachaData:CacheGachaHistory(nSaveId, mapData)
  if self._mapGachaHistory[nSaveId] == nil then
    self._mapGachaHistory[nSaveId] = {}
  end
  for _, mapHistory in ipairs(mapData.List) do
    table.insert(self._mapGachaHistory[nSaveId], mapHistory)
  end
end

function PlayerGachaData:AddGachaHistory(nSaveId, nGachaId, mapData)
  if self._mapGachaHistory[nSaveId] == nil then
    return
  end
  local Ids = {}
  for _, mapCard in ipairs(mapData.Cards) do
    table.insert(Ids, mapCard.Card.Tid)
  end
  table.insert(self._mapGachaHistory[nSaveId], {
    Ids = Ids,
    Time = mapData.Time,
    Gid = nGachaId
  })
end

function PlayerGachaData:GetGachaCountById(nPoolID)
  if self._mapGachaCount[nPoolID] == nil then
    return 0
  else
    return self._mapGachaCount[nPoolID]
  end
end

function PlayerGachaData:GetGachaTotalCountById(nPoolID)
  if self._mapTotalGachaTimes[nPoolID] == nil then
    return 0
  else
    return self._mapTotalGachaTimes[nPoolID]
  end
end

function PlayerGachaData:GetAupMissTimesById(nPoolID)
  local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolID)
  if self._mapAupMissTimes[nPoolID] == nil then
    if mapPoolCfgData ~= nil then
      for nId, nCount in pairs(self._mapAupMissTimes) do
        local mapPoolCfg = ConfigTable.GetData("Gacha", nId)
        if mapPoolCfg ~= nil and mapPoolCfg.StorageId == mapPoolCfgData.StorageId then
          self._mapAupMissTimes[nPoolID] = nCount
          return self._mapAupMissTimes[nPoolID]
        end
      end
    else
      return 0
    end
  else
    return self._mapAupMissTimes[nPoolID]
  end
  return 0
end

function PlayerGachaData:GetAMissTimesById(nPoolID)
  local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolID)
  if self._mapAMissTimes[nPoolID] == nil then
    if mapPoolCfgData ~= nil then
      for nId, nCount in pairs(self._mapAMissTimes) do
        local mapPoolCfg = ConfigTable.GetData("Gacha", nId)
        if mapPoolCfg ~= nil and mapPoolCfg.StorageId == mapPoolCfgData.StorageId then
          self._mapAMissTimes[nPoolID] = nCount
          return self._mapAMissTimes[nPoolID]
        end
      end
    else
      return 0
    end
  else
    return self._mapAMissTimes[nPoolID]
  end
  return 0
end

function PlayerGachaData:GetAupGuaranteeById(nPoolID)
  local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolID)
  if self._AupGuaranteeTimes[nPoolID] == nil then
    if mapPoolCfgData ~= nil then
      for nId, nCount in pairs(self._AupGuaranteeTimes) do
        local mapPoolCfg = ConfigTable.GetData("Gacha", nId)
        if mapPoolCfg ~= nil and mapPoolCfg.StorageId == mapPoolCfgData.StorageId then
          self._AupGuaranteeTimes[nPoolID] = nCount
          return self._AupGuaranteeTimes[nPoolID]
        end
      end
    else
      return 0
    end
  else
    return self._AupGuaranteeTimes[nPoolID]
  end
  return 0
end

function PlayerGachaData:GetRecvFirstTenReward(nPoolID)
  if self._mapRecvFirstTenReward[nPoolID] == nil then
    return false
  else
    return self._mapRecvFirstTenReward[nPoolID]
  end
end

function PlayerGachaData:GetRecvGuaranteeReward(nPoolID)
  if self._mapRecvGuaranteeReward[nPoolID] == nil then
    return false
  else
    return self._mapRecvGuaranteeReward[nPoolID]
  end
end

function PlayerGachaData:GetGachaTotalTimes(nPoolID)
  if self._mapGachaTotalTimes[nPoolID] == nil then
    return 0
  else
    return self._mapGachaTotalTimes[nPoolID]
  end
end

function PlayerGachaData:GachaCountChanged(nPoolID, nDayCount)
  self._mapGachaCount[nPoolID] = nDayCount
end

function PlayerGachaData:AupMissTimesCountChanged(nPoolID, nCount)
  local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolID)
  if mapPoolCfgData ~= nil then
    if nCount == nil then
      nCount = 0
    end
    for nId, _ in pairs(self._mapAupMissTimes) do
      local mapPoolCfg = ConfigTable.GetData("Gacha", nId)
      if mapPoolCfg ~= nil and mapPoolCfg.StorageId == mapPoolCfgData.StorageId then
        self._mapAupMissTimes[nId] = nCount
      end
    end
  end
  self._mapAupMissTimes[nPoolID] = nCount
end

function PlayerGachaData:AMissTimesCountChanged(nPoolID, nCount)
  local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolID)
  if mapPoolCfgData ~= nil then
    if nCount == nil then
      nCount = 0
    end
    for nId, _ in pairs(self._mapAMissTimes) do
      local mapPoolCfg = ConfigTable.GetData("Gacha", nId)
      if mapPoolCfg ~= nil and mapPoolCfg.StorageId == mapPoolCfgData.StorageId then
        self._mapAMissTimes[nId] = nCount
      end
    end
  end
  self._mapAMissTimes[nPoolID] = nCount
end

function PlayerGachaData:TotalCountChanged(nPoolID, nCount)
  self._mapTotalGachaTimes[nPoolID] = nCount
end

function PlayerGachaData:AupGuaranteeTimesChanged(nPoolID, nCount)
  self._AupGuaranteeTimes[nPoolID] = nCount
end

function PlayerGachaData:RecvFirstTenReward(nPoolID, bValue)
  self._mapRecvFirstTenReward[nPoolID] = bValue
end

function PlayerGachaData:RecvGuaranteeReward(nPoolID, bValue)
  self._mapRecvGuaranteeReward[nPoolID] = bValue
end

function PlayerGachaData:GachaTotalTimes(nPoolID, nCount)
  self._mapGachaTotalTimes[nPoolID] = nCount
  local tbData = self._mapGachaReward[nPoolID]
  if type(tbData) == "table" then
    for _, mapData in ipairs(tbData) do
      mapData.bCan = nCount >= mapData.nNum
    end
    self:CheckRedDot()
  end
end

function PlayerGachaData:GetGachaInfomation(callback)
  local function GetInfoCallback(_, mapData)
    self.hadData = true
    
    self:CacheGachaData(mapData.Information)
    if type(callback) == "function" then
      callback()
    end
  end
  
  if self.hadData then
    if type(callback) == "function" then
      callback()
    end
  else
    HttpNetHandler.SendMsg(NetMsgId.Id.gacha_information_req, {}, nil, GetInfoCallback)
  end
end

function PlayerGachaData:GetGachaHistory(nSaveId, callback)
  if self._mapGachaHistory[nSaveId] ~= nil then
    if type(callback) == "function" then
      callback(self._mapGachaHistory[nSaveId])
    end
    return
  end
  
  local function GetHistoryCallback(_, mapData)
    self:CacheGachaHistory(nSaveId, mapData)
    if type(callback) == "function" then
      callback(self._mapGachaHistory[nSaveId])
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.gacha_histories_req, {Value = nSaveId}, nil, GetHistoryCallback)
end

function PlayerGachaData:SendGachaReq(nId, nMode, callback)
  local mapMsgData = {Id = nId, Mode = nMode}
  local tbCheck = {}
  local mapGacha = ConfigTable.GetData("Gacha", nId)
  local mapGachaStorage = ConfigTable.GetData("GachaStorage", mapGacha.StorageId)
  local rapidjson = require("rapidjson")
  if mapGacha.SpecificTid > 0 then
    local nCurCount = PlayerData.Item:GetItemCountByID(mapGacha.SpecificTid)
    table.insert(tbCheck, {
      Tid = mapGacha.SpecificTid,
      Qty = nCurCount
    })
  end
  if nMode == 2 then
    if type(mapGachaStorage.TenTimesPreferred) == "string" then
      local tbTen = rapidjson.decode(mapGachaStorage.TenTimesPreferred)
      if tbTen ~= nil then
        mapGachaStorage.TenTimesPreferred = tbTen
      else
        mapGachaStorage.TenTimesPreferred = {}
      end
    end
    if 0 < #mapGachaStorage.TenTimesPreferred then
      for nIdx, mapCost in ipairs(mapGachaStorage.TenTimesPreferred) do
        local f = pairs(mapCost)
        local sTid, nCount = f(mapCost)
        local nTid = tonumber(sTid)
        local nCurCount = PlayerData.Item:GetItemCountByID(nTid)
        table.insert(tbCheck, {Tid = nTid, Qty = nCurCount})
      end
    end
  else
    if type(mapGachaStorage.OncePreferred) == "string" then
      local tbTen = rapidjson.decode(mapGachaStorage.OncePreferred)
      if tbTen ~= nil then
        mapGachaStorage.OncePreferred = tbTen
      else
        mapGachaStorage.OncePreferred = {}
      end
    end
    if 0 < #mapGachaStorage.OncePreferred then
      for nIdx, mapCost in ipairs(mapGachaStorage.OncePreferred) do
        local f = pairs(mapCost)
        local sTid, nCount = f(mapCost)
        local nTid = tonumber(sTid)
        local nCurCount = PlayerData.Item:GetItemCountByID(nTid)
        table.insert(tbCheck, {Tid = nTid, Qty = nCurCount})
      end
    end
  end
  mapMsgData.Check = tbCheck
  
  local function GachaCallback(_, mapData)
    if mapData.DaysCount == nil then
      EventManager.Hit("GachaProcessStart", false)
      for _, mapItemTpl in ipairs(tbCheck) do
        EventManager.Hit(EventId.CoinResChange, mapItemTpl.Tid, mapItemTpl.Qty)
      end
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        EventManager.Hit(EventId.OpenMessageBox, {
          nType = AllEnum.MessageBox.Alert,
          sContent = ConfigTable.GetUIText("Gacha_sync_ack"),
          callbackConfirm = function()
          end
        })
      end
      
      cs_coroutine.start(wait)
      return
    end
    self:GachaCountChanged(nId, mapData.DaysCount)
    self:AupMissTimesCountChanged(nId, mapData.AupMissTimes)
    self:AMissTimesCountChanged(nId, mapData.AMissTimes)
    self:TotalCountChanged(nId, mapData.TotalTimes)
    self:AupGuaranteeTimesChanged(nId, mapData.AupGuaranteeTimes)
    self:GachaTotalTimes(nId, mapData.GachaTotalTimes)
    if nMode == 2 then
      self:RecvFirstTenReward(nId, true)
    end
    local mapGacha = ConfigTable.GetData("Gacha", nId)
    if mapGacha ~= nil and mapGacha.StorageId > 0 then
      self:AddGachaHistory(mapGacha.StorageId, nId, mapData)
    end
    if type(callback) == "function" then
      callback(mapData)
    end
    if nMode == 2 then
      local tab = {}
      table.insert(tab, {
        "role_id",
        tostring(PlayerData.Base._nPlayerId)
      })
      if mapGacha.StorageId == GameEnum.gachaStorageType.CharacterCardPool then
        NovaAPI.UserEventUpload("standard_trekker_gacha10", tab)
      elseif mapGacha.StorageId == GameEnum.gachaStorageType.DiscCardPool then
        NovaAPI.UserEventUpload("standard_disc_gacha10", tab)
      elseif mapGacha.StorageId == GameEnum.gachaStorageType.CharacterUpCardPool then
        NovaAPI.UserEventUpload("limited_trekker_gacha10", tab)
      elseif mapGacha.StorageId == GameEnum.gachaStorageType.DiscUpCardPool then
        NovaAPI.UserEventUpload("limited_disc_gacha10", tab)
      elseif mapGacha.StorageId == GameEnum.gachaStorageType.BeginnerCardPool then
        NovaAPI.UserEventUpload("guaranteed5star_gacha10", tab)
      end
    end
  end
  
  EventManager.Hit("GachaProcessStart", true)
  HttpNetHandler.SendMsg(NetMsgId.Id.gacha_spin_req, mapMsgData, nil, GachaCallback)
end

function PlayerGachaData:GetPoolProbData(nPoolId)
  if self._mapPoolProbCache[nPoolId] ~= nil then
    return self._mapPoolProbCache[nPoolId]
  else
    local probUpItem, probItem = self:GetPoolProbDetail(nPoolId)
    self._mapPoolProbCache[nPoolId] = {tbProbUpItem = probUpItem, tbProbItem = probItem}
    return self._mapPoolProbCache[nPoolId]
  end
end

function PlayerGachaData:GetPoolProbDetail(nPoolID)
  local tbUpItemList = {}
  local tbItemList = {}
  local gachaConfig = ConfigTable.GetData("Gacha", nPoolID)
  local nStorageType = gachaConfig.StorageId
  local gachaStorageConfig = ConfigTable.GetData("GachaStorage", nStorageType)
  local nBTypeProb = gachaStorageConfig.BTypeProb
  local gachaATypeProbConfig
  
  local function func_ForEach_GachaATypeProb(mapData)
    if mapData.Group == gachaStorageConfig.ATypeGroup and mapData.Times == 0 then
      gachaATypeProbConfig = mapData
    end
  end
  
  ForEachTableLine(DataTable.GachaATypeProb, func_ForEach_GachaATypeProb)
  local nATypeProb = gachaATypeProbConfig.Prob
  local nCTypeProb = 10000 - nATypeProb - nBTypeProb
  local nATypePkgUpProb = nATypeProb * gachaStorageConfig.ATypeUpProb / 10000
  local nATypePkgProb = nATypeProb * (1 - gachaStorageConfig.ATypeUpProb / 10000)
  local nBTypePkgUpProb = nBTypeProb * gachaStorageConfig.BTypeUpProb / 10000
  local nBTypePkgGuaranteeProb = nBTypeProb * gachaStorageConfig.BTypeGuaranteeProb / 10000
  local nBTypePkgProb = nBTypeProb * (1 - (gachaStorageConfig.BTypeUpProb + gachaStorageConfig.BTypeGuaranteeProb) / 10000)
  local nCTypePkgProb = 10000 - nATypePkgUpProb - nATypePkgProb - nBTypePkgUpProb - nBTypePkgProb - nBTypePkgGuaranteeProb
  local tbATypeItem = {}
  local tbBTypeItem = {}
  local tbCTypeItem = {}
  local tbATypeUpItem = {}
  local tbBTypeUpItem = {}
  local tbBTypeGuaranteeItem = {}
  local nATypeTotalWeight = 0
  local nBTypeTotalWeight = 0
  local nCTypeTotalWeight = 0
  local nATypeUpTotalWeight = 0
  local nBTypeUpTotalWeight = 0
  local nBTypeGuaranteeWeight = 0
  
  local function func_ForEachGachaPkg(mapData)
    if mapData.PkgId == gachaConfig.ATypePkg then
      table.insert(tbATypeItem, {
        nGoodsId = mapData.GoodsId,
        nWeight = mapData.Weight
      })
      nATypeTotalWeight = nATypeTotalWeight + mapData.Weight
    elseif mapData.PkgId == gachaConfig.BTypePkg then
      table.insert(tbBTypeItem, {
        nGoodsId = mapData.GoodsId,
        nWeight = mapData.Weight
      })
      nBTypeTotalWeight = nBTypeTotalWeight + mapData.Weight
    elseif mapData.PkgId == gachaConfig.BGuaranteePkg then
      table.insert(tbBTypeGuaranteeItem, {
        nGoodsId = mapData.GoodsId,
        nWeight = mapData.Weight
      })
      nBTypeGuaranteeWeight = nBTypeGuaranteeWeight + mapData.Weight
    elseif mapData.PkgId == gachaConfig.CTypePkg then
      table.insert(tbCTypeItem, {
        nGoodsId = mapData.GoodsId,
        nWeight = mapData.Weight
      })
      nCTypeTotalWeight = nCTypeTotalWeight + mapData.Weight
    elseif mapData.PkgId == gachaConfig.ATypeUpPkg then
      table.insert(tbATypeUpItem, {
        nGoodsId = mapData.GoodsId,
        nWeight = mapData.Weight
      })
      nATypeUpTotalWeight = nATypeUpTotalWeight + mapData.Weight
    elseif mapData.PkgId == gachaConfig.BTypeUpPkg then
      table.insert(tbBTypeUpItem, {
        nGoodsId = mapData.GoodsId,
        nWeight = mapData.Weight
      })
      nBTypeUpTotalWeight = nBTypeUpTotalWeight + mapData.Weight
    end
  end
  
  ForEachTableLine(DataTable.GachaPkg, func_ForEachGachaPkg)
  for _, v in pairs(tbATypeItem) do
    local nProb = v.nWeight / nATypeTotalWeight * nATypePkgProb / 10000 * 100
    table.insert(tbItemList, {
      nGoodsId = v.nGoodsId,
      nProbValue = nProb
    })
  end
  for _, v in pairs(tbBTypeItem) do
    local nProb = v.nWeight / nBTypeTotalWeight * nBTypePkgProb / 10000 * 100
    table.insert(tbItemList, {
      nGoodsId = v.nGoodsId,
      nProbValue = nProb
    })
  end
  for _, v in pairs(tbBTypeGuaranteeItem) do
    local nProb = v.nWeight / nBTypeGuaranteeWeight * nBTypePkgGuaranteeProb / 10000 * 100
    table.insert(tbItemList, {
      nGoodsId = v.nGoodsId,
      nProbValue = nProb
    })
  end
  for _, v in pairs(tbCTypeItem) do
    local nProb = v.nWeight / nCTypeTotalWeight * nCTypePkgProb / 10000 * 100
    table.insert(tbItemList, {
      nGoodsId = v.nGoodsId,
      nProbValue = nProb
    })
  end
  for _, v in pairs(tbATypeUpItem) do
    local nProb = v.nWeight / nATypeUpTotalWeight * nATypePkgUpProb / 10000 * 100
    table.insert(tbUpItemList, {
      nGoodsId = v.nGoodsId,
      nProbValue = nProb
    })
  end
  for _, v in pairs(tbBTypeUpItem) do
    local nProb = v.nWeight / nBTypeUpTotalWeight * nBTypePkgUpProb / 10000 * 100
    table.insert(tbUpItemList, {
      nGoodsId = v.nGoodsId,
      nProbValue = nProb
    })
  end
  
  local function sortItem(a, b)
    local aItemConfig = ConfigTable.GetData_Item(a.nGoodsId)
    local bItemConfig = ConfigTable.GetData_Item(b.nGoodsId)
    if aItemConfig.Rarity < bItemConfig.Rarity then
      return true
    elseif aItemConfig.Rarity > bItemConfig.Rarity then
      return false
    elseif aItemConfig.Type == GameEnum.itemType.Char and bItemConfig.Type == GameEnum.itemType.Disc then
      return true
    elseif aItemConfig.Type == GameEnum.itemType.Disc and bItemConfig.Type == GameEnum.itemType.Char then
      return false
    else
      return aItemConfig.Id < bItemConfig.Id
    end
  end
  
  table.sort(tbUpItemList, sortItem)
  table.sort(tbItemList, sortItem)
  return tbUpItemList, tbItemList
end

function PlayerGachaData:SendGachaGuaranteeRewardReq(nId, callback)
  local function GachaCallback(_, mapData)
    self:RecvGuaranteeReward(nId, true)
    
    if type(callback) == "function" then
      callback(mapData)
    end
  end
  
  local mapMsgData = {Value = nId}
  HttpNetHandler.SendMsg(NetMsgId.Id.gacha_guarantee_reward_receive_req, mapMsgData, nil, GachaCallback)
end

function PlayerGachaData:OnEvent_NewDay()
  self.hadData = false
end

function PlayerGachaData:CacheGachaNewbieData(mapData)
  for _, v in ipairs(mapData) do
    local newbie = {}
    newbie.Id = v.Id
    newbie.Receive = v.Receive
    newbie.Times = v.Times
    newbie.Cards = {}
    for _, v1 in ipairs(v.Cards) do
      local cards = {}
      for _, v2 in ipairs(v1.Values) do
        table.insert(cards, v2)
      end
      table.insert(newbie.Cards, cards)
    end
    newbie.Temp = {}
    if v.Temp ~= nil then
      for _, v2 in ipairs(v.Temp.Values) do
        table.insert(newbie.Temp, v2)
      end
    end
    self._mapNewbieData[v.Id] = newbie
  end
  printTable(self._mapNewbieData)
end

function PlayerGachaData:GetGachaNewbieData(nId)
  if self._mapNewbieData[nId] == nil then
    local newbie = {}
    newbie.Id = nId
    newbie.Receive = false
    newbie.Times = 0
    newbie.Cards = {}
    newbie.Temp = {}
    self._mapNewbieData[nId] = newbie
  end
  return self._mapNewbieData[nId]
end

function PlayerGachaData:GetGachaNewbieInfomation(callback)
  local function GetInfoCallback(_, mapData)
    self.hadNewbieData = true
    
    self:CacheGachaNewbieData(mapData.List)
    if type(callback) == "function" then
      callback()
    end
  end
  
  if self.hadNewbieData then
    if type(callback) == "function" then
      callback()
    end
  else
    HttpNetHandler.SendMsg(NetMsgId.Id.gacha_newbie_info_req, {}, nil, GetInfoCallback)
  end
end

function PlayerGachaData:SendGachaNewbieReq(nId, callback)
  local function GachaCallback(_, mapData)
    local data = self._mapNewbieData[nId]
    
    data.Times = data.Times + 1
    data.Temp = {}
    for _, v in ipairs(mapData.Cards) do
      table.insert(data.Temp, v)
    end
    self._mapNewbieData[nId] = data
    if type(callback) == "function" then
      callback(mapData)
    end
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    NovaAPI.UserEventUpload("guaranteed5star_gacha10", tab)
  end
  
  local mapMsgData = {Value = nId}
  EventManager.Hit("GachaProcessStart", true)
  HttpNetHandler.SendMsg(NetMsgId.Id.gacha_newbie_spin_req, mapMsgData, nil, GachaCallback)
end

function PlayerGachaData:SendGachaNewbieSaveReq(nId, idx, callback)
  local function GachaCallback(_, mapData)
    local data = self._mapNewbieData[nId]
    
    local cards = {}
    for _, v in ipairs(data.Temp) do
      table.insert(cards, v)
    end
    if idx == 0 then
      table.insert(data.Cards, cards)
    elseif 0 < idx then
      data.Cards[idx] = cards
    end
    data.Temp = {}
    self._mapNewbieData[nId] = data
    if type(callback) == "function" then
      callback(mapData)
    end
    local tab = {}
    table.insert(tab, {
      "role_id",
      tostring(PlayerData.Base._nPlayerId)
    })
    NovaAPI.UserEventUpload("guaranteed5star_gacha10", tab)
  end
  
  local mapMsgData = {Id = nId, Idx = idx}
  HttpNetHandler.SendMsg(NetMsgId.Id.gacha_newbie_save_req, mapMsgData, nil, GachaCallback)
end

function PlayerGachaData:SendGachaNewbieObtainReq(nId, idx, callback)
  local function GachaCallback(_, mapData)
    local data = self._mapNewbieData[nId]
    
    data.Receive = true
    self._mapNewbieData[nId] = data
    if type(callback) == "function" then
      callback(mapData)
    end
  end
  
  local mapMsgData = {Id = nId, Idx = idx}
  HttpNetHandler.SendMsg(NetMsgId.Id.gacha_newbie_obtain_req, mapMsgData, nil, GachaCallback)
end

function PlayerGachaData:GetGachaReward(nPoolID)
  return self._mapGachaReward[nPoolID]
end

function PlayerGachaData:GetReward(nPoolID, nId, nIndex, callback)
  local function GetRewardCallback(_, mapData)
    if type(self._mapGachaReward[nPoolID]) == "table" then
      for k, v in pairs(self._mapGachaReward[nPoolID]) do
        if v.nId == nId and v.nIdx == nIndex then
          self._mapGachaReward[nPoolID][k].bRec = true
        end
      end
    else
      printError("角色卡池累抽赠奖数据错误：数据，领奖消息返回。卡池id" .. tostring(nPoolID))
    end
    self:CheckRedDot()
    if type(callback) == "function" then
      callback(mapData)
    end
  end
  
  local mapMsgData = {Value = nId}
  HttpNetHandler.SendMsg(NetMsgId.Id.gacha_reward_get_req, mapMsgData, nil, GetRewardCallback)
end

function PlayerGachaData:CheckRedDot()
  for nPoolId, tbData in pairs(self._mapGachaReward) do
    for _, mapData in ipairs(tbData) do
      local bOn = mapData.bRec == false and mapData.bCan == true
      RedDotManager.SetValid(RedDotDefine.Gacha_Reward, {
        nPoolId,
        mapData.nIdx
      }, bOn)
    end
  end
end

return PlayerGachaData
