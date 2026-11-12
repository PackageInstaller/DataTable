local ConfigData = require("GameCore.Data.ConfigData")
local PlayerItemData = class("PlayerItemData")

function PlayerItemData:Init()
  self._mapItem = {}
  self:PreProcess()
end

function PlayerItemData:GetAllItemMinExpire()
  local nMinExpire = -1
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  for Tid, value in pairs(self._mapItem) do
    local itemCfg = ConfigTable.GetData_Item(Tid)
    if itemCfg ~= nil and itemCfg.Display then
      for nExpire, _ in pairs(value.mapExpires) do
        if (nMinExpire == -1 or nExpire < nMinExpire) and 0 < nExpire and nExpire > curTime then
          nMinExpire = nExpire
        end
      end
    end
  end
  return nMinExpire
end

function PlayerItemData:GetItemsByStype(nType)
  local tbItem = {}
  for index, value in pairs(self._mapItem) do
    if ConfigTable.GetData_Item(index).Stype == nType then
      table.insert(tbItem, 1, value)
    end
  end
  return tbItem
end

function PlayerItemData:GetItemsByMark(nMark)
  local tbItem = {}
  local tbType = {}
  
  local function foreachItemPackMark(mapData)
    if mapData.PackMark == nMark then
      tbType = mapData.ItemStype
    end
  end
  
  ForEachTableLine(DataTable.ItemPackMark, foreachItemPackMark)
  for index, value in pairs(self._mapItem) do
    if table.indexof(tbType, ConfigTable.GetData_Item(index).Stype) > 0 then
      table.insert(tbItem, 1, value)
    end
  end
  return tbItem
end

function PlayerItemData:GetItemSortByExpire(nTid)
  local ret = {}
  if self._mapItem[nTid] ~= nil then
    local tbExpires = {}
    for nExpire, _ in pairs(self._mapItem[nTid].mapExpires) do
      local curTime = CS.ClientManager.Instance.serverTimeStamp
      local remainTime = nExpire - curTime
      if 0 < remainTime or nExpire == 0 then
        table.insert(tbExpires, nExpire)
      end
    end
    table.sort(tbExpires)
    for _, nExpire in ipairs(tbExpires) do
      for nId, nCount in pairs(self._mapItem[nTid].mapExpires[nExpire].mapId) do
        table.insert(ret, {nId, nCount})
      end
    end
  end
  return ret
end

function PlayerItemData:GetCharFragmentsData()
  local tbFragment = {}
  for k, v in pairs(self._mapItem) do
    local mapData = ConfigTable.GetData_Item(v.Tid)
    if mapData ~= nil and mapData.Stype == GameEnum.itemStype.CharShard then
      local mapChar
      
      local function func_EachChar(mapLineData)
        if mapLineData.FragmentsId == v.Tid and PlayerData.Char:GetCharDataByTid(mapLineData.Id) == nil then
          mapChar = mapLineData
        end
      end
      
      ForEachTableLine(DataTable.Character, func_EachChar)
      if mapChar ~= nil then
        do
          local data = {
            nId = mapChar.Id,
            Rare = mapChar.Grade,
            Level = 0,
            nFragments = self:GetItemCountByID(v.Tid),
            nNeedFragments = mapChar.RecruitmentQty,
            EET = mapChar.EET
          }
          table.insert(tbFragment, data)
        end
      end
    end
  end
  return tbFragment
end

function PlayerItemData:GetCharHoldingState(nCharId, nGetChar, nGetFragments)
  nGetFragments = nGetFragments or 0
  local mapCharCfg = ConfigTable.GetData_Character(nCharId)
  if mapCharCfg == nil then
    return
  end
  local nRemain, bNew = PlayerData.Talent:GetRemainFragments(nCharId)
  if nGetChar and 0 < nGetChar then
    if bNew then
      nGetFragments = nGetFragments + (nGetChar - 1) * mapCharCfg.TransformQty
    else
      nGetFragments = nGetFragments + nGetChar * mapCharCfg.TransformQty
    end
  end
  if nRemain - nGetFragments < 0 then
    local mapGradeCfg = ConfigTable.GetData("CharGrade", mapCharCfg.Grade)
    if mapGradeCfg == nil then
      return
    end
    local sMaxTsName = ConfigTable.GetData_Item(mapGradeCfg.SubstituteItemId).Title
    local sTsName = ConfigTable.GetData_Item(mapCharCfg.FragmentsId).Title
    return orderedFormat(ConfigTable.GetUIText("Overflow_BuyChar"), sTsName, sTsName, sMaxTsName)
  else
    return
  end
end

function PlayerItemData:GetDiscHoldingState(nId, nGetCount)
  local mapDisc = PlayerData.Disc:GetDiscById(nId)
  local mapCfg = ConfigTable.GetData("Disc", nId)
  local mapItem = ConfigTable.GetData_Item(nId)
  if mapCfg == nil or mapItem == nil then
    return
  end
  local nTsId = mapCfg.TransformItemId
  local sTsName = ConfigTable.GetData_Item(nTsId).Title
  local nMaxTsId = mapCfg.MaxStarTransformItem[1]
  local sMaxTsName = ConfigTable.GetData_Item(nMaxTsId).Title
  local nHasTs = self:GetItemCountByID(nTsId)
  local nRemain = 0
  if mapDisc then
    nRemain = mapDisc.nMaxStar - mapDisc.nStar - nHasTs - nGetCount
  else
    local nMaxStar = PlayerData.Disc:GetDiscMaxStar(mapItem.Rarity)
    nRemain = nMaxStar - nHasTs - (nGetCount - 1)
  end
  if nRemain < 0 and mapDisc and mapDisc.nMaxStar == mapDisc.nStar then
    return orderedFormat(ConfigTable.GetUIText("Overflow_BuyDiscMaxStar"), mapDisc.sName, sTsName, sMaxTsName)
  elseif nRemain < 0 then
    return orderedFormat(ConfigTable.GetUIText("Overflow_BuyDisc"), sTsName, sTsName, sMaxTsName)
  else
    return
  end
end

function PlayerItemData:PreProcess()
  local mapDrop = {}
  
  local function func_EachDrop(mapLineData)
    local nDropId = mapLineData.DropId
    local nDropPkgId = mapLineData.PkgId
    if mapDrop[nDropId] == nil then
      mapDrop[nDropId] = {}
    end
    local idx = table.indexof(mapDrop[nDropId], nDropPkgId)
    if idx <= 0 then
      table.insert(mapDrop[nDropId], nDropPkgId)
    end
  end
  
  ForEachTableLine(DataTable.Drop, func_EachDrop)
  local mapDropPgk = {}
  
  local function func_EachDropPkg(mapLineData)
    local nDropPkgId = mapLineData.PkgId
    local nItemId = mapLineData.ItemId
    if mapDropPgk[nDropPkgId] == nil then
      mapDropPgk[nDropPkgId] = {}
    end
    local idx = table.indexof(mapDropPgk[nDropPkgId], nItemId)
    if idx <= 0 then
      table.insert(mapDropPgk[nDropPkgId], nItemId)
    end
  end
  
  ForEachTableLine(DataTable.DropPkg, func_EachDropPkg)
  self._mapDropItem = {}
  for nDropId, tbDropPkgId in pairs(mapDrop) do
    if self._mapDropItem[nDropId] == nil then
      self._mapDropItem[nDropId] = {}
    end
    for __, nDropPkgId in ipairs(tbDropPkgId) do
      local tbItemId = mapDropPgk[nDropPkgId]
      for ___, nItemId in ipairs(tbItemId) do
        local idx = table.indexof(self._mapDropItem[nDropId], nItemId)
        if idx <= 0 then
          table.insert(self._mapDropItem[nDropId], nItemId)
        end
      end
    end
  end
  self._mapDropShow = {}
  
  local function forEachDropShow(mapData)
    if self._mapDropShow[mapData.DropId] == nil then
      self._mapDropShow[mapData.DropId] = {}
    end
    table.insert(self._mapDropShow[mapData.DropId], mapData)
  end
  
  ForEachTableLine(DataTable.DropItemShow, forEachDropShow)
  self._mapMaxAcquireReward = {}
  
  local function forEachAcquireReward(mapData)
    if self._mapMaxAcquireReward[mapData.itemStype] == nil then
      self._mapMaxAcquireReward[mapData.itemStype] = {}
    end
    if self._mapMaxAcquireReward[mapData.itemStype][mapData.itemRarity] == nil then
      self._mapMaxAcquireReward[mapData.itemStype][mapData.itemRarity] = mapData.AcquireTimes
    end
    if mapData.AcquireTimes > self._mapMaxAcquireReward[mapData.itemStype][mapData.itemRarity] then
      self._mapMaxAcquireReward[mapData.itemStype][mapData.itemRarity] = mapData.AcquireTimes
    end
  end
  
  ForEachTableLine(DataTable.AcquireReward, forEachAcquireReward)
end

function PlayerItemData:GetDropItem(nDropId)
  return self._mapDropItem[nDropId]
end

function PlayerItemData:GetDropItemShow(nDropId)
  return self._mapDropShow[nDropId]
end

function PlayerItemData:CacheItemData(mapData)
  self._mapItem = {}
  for k, v in ipairs(mapData) do
    if self._mapItem[v.Tid] == nil then
      self._mapItem[v.Tid] = {}
      self._mapItem[v.Tid].Tid = v.Tid
      self._mapItem[v.Tid].nExpireCount = 0
      self._mapItem[v.Tid].mapExpires = {}
    end
    if self._mapItem[v.Tid].mapExpires[v.Expire] == nil then
      self._mapItem[v.Tid].mapExpires[v.Expire] = {}
      self._mapItem[v.Tid].mapExpires[v.Expire].nTotalCount = 0
      self._mapItem[v.Tid].mapExpires[v.Expire].mapId = {}
      self._mapItem[v.Tid].nExpireCount = self._mapItem[v.Tid].nExpireCount + 1
    end
    self._mapItem[v.Tid].mapExpires[v.Expire].mapId[v.Id] = v.Qty
    self._mapItem[v.Tid].mapExpires[v.Expire].nTotalCount = self._mapItem[v.Tid].mapExpires[v.Expire].nTotalCount + v.Qty
  end
end

function PlayerItemData:GetItemCountByTidExpire(nTid, nExpire)
  if self._mapItem[nTid] ~= nil and self._mapItem[nTid].tbmapExpires[nExpire] ~= nil then
    return self._mapItem[nTid].tbmapExpires[nExpire].nTotalCount
  end
  return 0
end

function PlayerItemData:ChangeItem(mapChange)
  if type(mapChange) ~= "table" then
    return
  end
  for k, v in ipairs(mapChange) do
    if self._mapItem[v.Tid] == nil then
      self._mapItem[v.Tid] = {}
      self._mapItem[v.Tid].Tid = v.Tid
      self._mapItem[v.Tid].nExpireCount = 0
      self._mapItem[v.Tid].mapExpires = {}
    end
    if self._mapItem[v.Tid].mapExpires[v.Expire] == nil then
      self._mapItem[v.Tid].mapExpires[v.Expire] = {}
      self._mapItem[v.Tid].mapExpires[v.Expire].nTotalCount = 0
      self._mapItem[v.Tid].mapExpires[v.Expire].mapId = {}
      self._mapItem[v.Tid].nExpireCount = self._mapItem[v.Tid].nExpireCount + 1
    end
    if self._mapItem[v.Tid].mapExpires[v.Expire].mapId[v.Id] == nil then
      self._mapItem[v.Tid].mapExpires[v.Expire].mapId[v.Id] = v.Qty
      self._mapItem[v.Tid].mapExpires[v.Expire].nTotalCount = self._mapItem[v.Tid].mapExpires[v.Expire].nTotalCount + v.Qty
    else
      self._mapItem[v.Tid].mapExpires[v.Expire].mapId[v.Id] = v.Qty + self._mapItem[v.Tid].mapExpires[v.Expire].mapId[v.Id]
      self._mapItem[v.Tid].mapExpires[v.Expire].nTotalCount = v.Qty + self._mapItem[v.Tid].mapExpires[v.Expire].nTotalCount
      if 0 >= self._mapItem[v.Tid].mapExpires[v.Expire].mapId[v.Id] then
        self._mapItem[v.Tid].mapExpires[v.Expire].mapId[v.Id] = nil
      end
      if 0 >= self._mapItem[v.Tid].mapExpires[v.Expire].nTotalCount then
        self._mapItem[v.Tid].mapExpires[v.Expire] = nil
        self._mapItem[v.Tid].nExpireCount = self._mapItem[v.Tid].nExpireCount - 1
        if self._mapItem[v.Tid].nExpireCount <= 0 then
          self._mapItem[v.Tid] = nil
        end
      end
    end
    EventManager.Hit(EventId.CoinResChange, v.Tid, v.Qty)
  end
  PlayerData.Talent:UpdateCharTalentRedDotByItem(mapChange)
  PlayerData.Disc:UpdateBreakLimitRedDotByItem(mapChange)
  PlayerData.StarTower:UpdateGrowthRedDotByItem(mapChange)
end

function PlayerItemData:GetItemCountByID(Tid)
  local itemCfgData = ConfigTable.GetData_Item(Tid, true)
  if itemCfgData == nil then
    return 0
  end
  if itemCfgData.Type == GameEnum.itemType.Res then
    return PlayerData.Coin:GetCoinCount(Tid)
  end
  if itemCfgData.Type == GameEnum.itemType.Energy then
    return PlayerData.Base:GetCurEnergy().nEnergy
  end
  if itemCfgData.Type == GameEnum.itemType.Honor then
    local tbHonor = PlayerData.Base:GetPlayerHonorTitleList()
    local bHas = false
    for k, v in pairs(tbHonor) do
      if v.Id == Tid then
        bHas = true
        break
      end
    end
    return bHas and 1 or 0
  end
  if self._mapItem[Tid] ~= nil then
    local count = 0
    for key, value in pairs(self._mapItem[Tid].mapExpires) do
      local nCurTime = CS.ClientManager.Instance.serverTimeStamp
      if key == 0 or key > nCurTime then
        count = count + value.nTotalCount
      end
    end
    return count
  end
  return 0
end

function PlayerItemData:GetItemCacheDataByID(Tid)
  if self._mapItem[Tid] ~= nil then
    return self._mapItem[Tid]
  end
  return nil
end

function PlayerItemData:GetCYODisplayItem(nId)
  local tbDetailItem = {}
  local sDetailTitle = ""
  local mapItemCfgData = ConfigTable.GetData_Item(nId)
  if mapItemCfgData == nil then
    return tbDetailItem, sDetailTitle
  end
  
  local function sort(a, b)
    local mapItemCfgDataA = ConfigTable.GetData_Item(a.nId)
    local mapItemCfgDataB = ConfigTable.GetData_Item(b.nId)
    if mapItemCfgDataA and mapItemCfgDataB and mapItemCfgDataA.Rarity ~= mapItemCfgDataB.Rarity then
      return mapItemCfgDataA.Rarity < mapItemCfgDataB.Rarity
    end
    return a.nId < b.nId
  end
  
  if mapItemCfgData.Stype == GameEnum.itemStype.RandomPackage then
    local mapItemUseCfg = decodeJson(mapItemCfgData.UseArgs)
    for sTid, _ in pairs(mapItemUseCfg) do
      local nItemTid = tonumber(sTid)
      if nItemTid ~= nil then
        local tbDropShowData = self:GetDropItemShow(nItemTid)
        if tbDropShowData ~= nil then
          for _, mapData in ipairs(tbDropShowData) do
            table.insert(tbDetailItem, {
              nId = mapData.ItemId,
              nCount = mapData.ItemQty
            })
          end
        end
      end
    end
    table.sort(tbDetailItem, sort)
    sDetailTitle = ConfigTable.GetUIText("ItemTip_RandomPackageTitle")
  elseif mapItemCfgData.Stype == GameEnum.itemStype.ComCYO then
    local mapItemUseCfg = decodeJson(mapItemCfgData.UseArgs)
    for sTid, nCount in pairs(mapItemUseCfg) do
      local nItemTid = tonumber(sTid)
      if nItemTid ~= nil then
        table.insert(tbDetailItem, {nId = nItemTid, nCount = nCount})
      end
    end
    table.sort(tbDetailItem, sort)
    sDetailTitle = ConfigTable.GetUIText("ItemTip_ComCYOTitle")
  end
  return tbDetailItem, sDetailTitle
end

function PlayerItemData:AutoFillMat(tbNeedItem)
  local bAllNone = true
  local tbEmptyItem = {}
  for _, v in ipairs(tbNeedItem) do
    local nId = v.nId
    local mapHelperCfg = ConfigTable.GetData("ProduceHelper", nId, true)
    if mapHelperCfg then
      bAllNone = false
    else
      tbEmptyItem[nId] = true
    end
  end
  if bAllNone then
    return {}, {}, {}
  end
  
  local function sort(a, b)
    local mapItemCfgDataA = ConfigTable.GetData_Item(a.nId)
    local mapItemCfgDataB = ConfigTable.GetData_Item(b.nId)
    if mapItemCfgDataA and mapItemCfgDataB and mapItemCfgDataA.Rarity ~= mapItemCfgDataB.Rarity then
      return mapItemCfgDataA.Rarity > mapItemCfgDataB.Rarity
    end
    return a.nId < b.nId
  end
  
  table.sort(tbNeedItem, sort)
  local tbFillStep, tbPick, tbReadyToFillStep, tbReadyToPick = {}, {}, {}, {}
  local tbUseItem, tbReadyToUseItem = {}, {}
  local tbNeedCount, tbRemainCount = {}, {}
  local tbAlreadyItem = {}
  local tbGetItem = {}
  local tbReadyLog = {}
  for _, v in ipairs(tbNeedItem) do
    local nId = v.nId
    local nHasCount = self:GetItemCountByID(v.nId)
    if nHasCount < v.nCount then
      tbNeedCount[nId] = v.nCount - nHasCount
      tbRemainCount[nId] = 0
    else
      tbNeedCount[nId] = 0
      tbRemainCount[nId] = nHasCount - v.nCount
      tbAlreadyItem[nId] = true
    end
  end
  
  local function buildCountData(nId)
    if not tbReadyToUseItem[nId] then
      tbReadyToUseItem[nId] = 0
    end
    if not tbRemainCount[nId] then
      tbRemainCount[nId] = self:GetItemCountByID(nId)
    end
  end
  
  local function readyUse(nId, nNeed)
    tbReadyToUseItem[nId] = tbReadyToUseItem[nId] + nNeed
  end
  
  local function useCYO(mapHelperCfg, nNeedCYO)
    if nNeedCYO == 0 then
      return
    end
    for _, nCYOId in ipairs(mapHelperCfg.ComCYOIds) do
      local nCurCYORemain = tbRemainCount[nCYOId] - tbReadyToUseItem[nCYOId]
      if 0 < nCurCYORemain then
        if nNeedCYO <= nCurCYORemain then
          table.insert(tbReadyLog, "快捷养成-自选包 道具ID:" .. mapHelperCfg.Id .. " 自选包ID:" .. nCYOId .. " 使用次数:" .. nNeedCYO .. " 名称:" .. ConfigTable.GetData_Item(mapHelperCfg.Id).Title)
          local tbList = self:GetAutoFillPickList(nCYOId, mapHelperCfg.Id, nNeedCYO)
          for _, v in ipairs(tbList) do
            table.insert(tbReadyToPick, v)
          end
          readyUse(nCYOId, nNeedCYO)
          return
        else
          table.insert(tbReadyLog, "快捷养成-自选包 道具ID:" .. mapHelperCfg.Id .. " 自选包ID:" .. nCYOId .. " 使用次数:" .. nCurCYORemain .. " 名称:" .. ConfigTable.GetData_Item(mapHelperCfg.Id).Title)
          local tbList = self:GetAutoFillPickList(nCYOId, mapHelperCfg.Id, nCurCYORemain)
          for _, v in ipairs(tbList) do
            table.insert(tbReadyToPick, v)
          end
          readyUse(nCYOId, nCurCYORemain)
          nNeedCYO = nNeedCYO - nCurCYORemain
        end
      end
    end
  end
  
  local function fill(nId, nNeed, bUseCYO)
    buildCountData(nId)
    local nCurRemain = tbRemainCount[nId] - tbReadyToUseItem[nId]
    if nNeed <= nCurRemain then
      table.insert(tbReadyLog, "快捷养成-道具直接满足 道具ID:" .. nId .. " 数量:" .. nNeed .. " 名称:" .. ConfigTable.GetData_Item(nId).Title)
      readyUse(nId, nNeed)
      return true
    end
    local mapHelperCfg = ConfigTable.GetData("ProduceHelper", nId, true)
    if not mapHelperCfg then
      printLog("自动填充失败，该道具无ProduceHelper配置：" .. nId)
      return false
    end
    
    local function Crafting(nNeedCrafting)
      if mapHelperCfg.ProductionId == 0 then
        return false
      end
      local mapProductionCfg = ConfigTable.GetData("Production", mapHelperCfg.ProductionId)
      if not mapProductionCfg then
        printError("自动填充失败，该配方无Production配置：" .. mapHelperCfg.ProductionId)
        return false
      end
      if mapProductionCfg.ProductionId ~= nId then
        printError("自动填充失败，该配方（" .. mapHelperCfg.ProductionId .. "）的产物" .. mapProductionCfg.ProductionId .. "与目标产物不同" .. nId)
        return false
      end
      local bOpen = PlayerData.Crafting:CheckProductionUnlock(mapHelperCfg.ProductionId)
      if not bOpen then
        return false
      end
      local nCraftTimes = math.ceil(nNeedCrafting / mapProductionCfg.ProductionPerBatch)
      local nCraftedCount = nCraftTimes * mapProductionCfg.ProductionPerBatch
      for i = 1, 4 do
        local nMtId = mapProductionCfg["RawMaterialId" .. i]
        local nMtCount = mapProductionCfg["RawMaterialCount" .. i]
        if 0 < nMtId then
          local bAble = fill(nMtId, nMtCount * nCraftTimes, bUseCYO)
          if not bAble then
            return false
          end
        end
      end
      if nNeedCrafting < nCraftedCount then
        readyUse(nId, nNeedCrafting - nCraftedCount)
      end
      table.insert(tbReadyLog, "快捷养成-合成 道具ID:" .. nId .. " 配方ID:" .. mapHelperCfg.ProductionId .. " 合成次数:" .. nCraftTimes .. " 名称:" .. ConfigTable.GetData_Item(nId).Title)
      local msgData = {}
      msgData.Product = {
        Id = mapHelperCfg.ProductionId,
        Num = nCraftTimes
      }
      table.insert(tbReadyToFillStep, msgData)
      return true
    end
    
    if bUseCYO then
      local nAllCYOCount = 0
      for _, nCYOId in ipairs(mapHelperCfg.ComCYOIds) do
        buildCountData(nCYOId)
        nAllCYOCount = nAllCYOCount + tbRemainCount[nCYOId] - tbReadyToUseItem[nCYOId]
      end
      if nNeed <= nCurRemain + nAllCYOCount then
        local nNeedCYO = nNeed - nCurRemain
        useCYO(mapHelperCfg, nNeedCYO)
        if 0 < nCurRemain then
          table.insert(tbReadyLog, "快捷养成-道具满足部分 道具ID:" .. nId .. " 数量:" .. nCurRemain .. " 名称:" .. ConfigTable.GetData_Item(nId).Title)
          readyUse(nId, nCurRemain)
        end
        return true
      else
        local nAfterCYONeed = nNeed - nCurRemain - nAllCYOCount
        local bAble = Crafting(nAfterCYONeed)
        if bAble then
          useCYO(mapHelperCfg, nAllCYOCount)
          if 0 < nCurRemain then
            table.insert(tbReadyLog, "快捷养成-道具满足部分 道具ID:" .. nId .. " 数量:" .. nCurRemain .. " 名称:" .. ConfigTable.GetData_Item(nId).Title)
            readyUse(nId, nCurRemain)
          end
        end
        return bAble
      end
    else
      local nNeedCrafting = nNeed - nCurRemain
      local bAble = Crafting(nNeedCrafting)
      if bAble and 0 < nCurRemain then
        table.insert(tbReadyLog, "快捷养成-道具满足部分 道具ID:" .. nId .. " 数量:" .. nCurRemain .. " 名称:" .. ConfigTable.GetData_Item(nId).Title)
        readyUse(nId, nCurRemain)
      end
      return bAble
    end
  end
  
  local function addUse(bAddAble, nAddId)
    if bAddAble then
      if not tbGetItem[nAddId] then
        tbGetItem[nAddId] = 0
      end
      tbGetItem[nAddId] = tbGetItem[nAddId] + 1
      for nUseId, nUseCount in pairs(tbReadyToUseItem) do
        tbRemainCount[nUseId] = tbRemainCount[nUseId] - nUseCount
        if not tbUseItem[nUseId] then
          tbUseItem[nUseId] = 0
        end
        tbUseItem[nUseId] = tbUseItem[nUseId] + nUseCount
      end
      for _, mapStep in ipairs(tbReadyToFillStep) do
        local bHasStep = false
        for k, v in pairs(tbFillStep) do
          if v.Product.Id == mapStep.Product.Id then
            tbFillStep[k].Product.Num = tbFillStep[k].Product.Num + mapStep.Product.Num
            bHasStep = true
            break
          end
        end
        if not bHasStep then
          table.insert(tbFillStep, mapStep)
        end
      end
      for _, mapReadyPick in ipairs(tbReadyToPick) do
        local bAdded = false
        for _, mapPick in ipairs(tbPick) do
          if mapPick.Id == mapReadyPick.Id and mapPick.Tid == mapReadyPick.Tid and mapPick.SelectTid == mapReadyPick.SelectTid then
            local nAdd = mapReadyPick.Qty == 0 and 1 or mapReadyPick.Qty
            local nHas = mapPick.Qty == 0 and 1 or mapPick.Qty
            mapPick.Qty = nAdd + nHas
            bAdded = true
            break
          end
        end
        if not bAdded then
          table.insert(tbPick, mapReadyPick)
        end
      end
      for _, sLog in ipairs(tbReadyLog) do
        printLog(sLog)
      end
    end
    tbReadyToUseItem = {}
    tbReadyToFillStep = {}
    tbReadyToPick = {}
    tbReadyLog = {}
  end
  
  for _, v in ipairs(tbNeedItem) do
    local nId = v.nId
    if not tbAlreadyItem[nId] and not tbEmptyItem[nId] then
      for _ = 1, tbNeedCount[nId] do
        local bAble = fill(nId, 1)
        addUse(bAble, nId)
        if not bAble then
          local bAbleAfterCYO = fill(nId, 1, true)
          addUse(bAbleAfterCYO, nId)
        end
      end
    end
  end
  table.sort(tbFillStep, function(a, b)
    local mapProductionCfg_a = ConfigTable.GetData("Production", a.Product.Id)
    local mapProductionCfg_b = ConfigTable.GetData("Production", b.Product.Id)
    if mapProductionCfg_a and mapProductionCfg_b then
      local mapItemCfg_a = ConfigTable.GetData_Item(mapProductionCfg_a.ProductionId)
      local mapItemCfg_b = ConfigTable.GetData_Item(mapProductionCfg_b.ProductionId)
      if mapItemCfg_a and mapItemCfg_b then
        return mapItemCfg_a.Rarity > mapItemCfg_b.Rarity
      end
    end
    return a.Product.Id < b.Product.Id
  end)
  local msgData = {}
  msgData.Pick = {}
  msgData.Pick.List = tbPick
  table.insert(tbFillStep, 1, msgData)
  local tbShowNeedItem = {}
  for _, v in ipairs(tbNeedItem) do
    if tbGetItem[v.nId] then
      local nHasCount = self:GetItemCountByID(v.nId)
      local nAfterCount = nHasCount + tbGetItem[v.nId]
      table.insert(tbShowNeedItem, {
        nId = v.nId,
        nCount = nAfterCount,
        nNeed = v.nCount
      })
    end
  end
  local sUseLog = "消耗的道具：\n"
  for nId, nCount in pairs(tbUseItem) do
    sUseLog = sUseLog .. "id:" .. nId .. " count:" .. nCount .. " 名称:" .. ConfigTable.GetData_Item(nId).Title .. "\n"
  end
  printLog(sUseLog)
  local sRemainLog = "剩余的道具：\n"
  for nId, nCount in pairs(tbRemainCount) do
    sRemainLog = sRemainLog .. "id:" .. nId .. " count:" .. nCount .. " 名称:" .. ConfigTable.GetData_Item(nId).Title .. "\n"
  end
  printLog(sRemainLog)
  local sGetLog = "目标获得的道具：\n"
  for nId, nCount in pairs(tbGetItem) do
    sGetLog = sGetLog .. "id:" .. nId .. " count:" .. nCount .. " 名称:" .. ConfigTable.GetData_Item(nId).Title .. "\n"
  end
  printLog(sGetLog)
  return tbFillStep, tbUseItem, tbShowNeedItem
end

function PlayerItemData:GetAutoFillPickList(nItemId, nChooseTid, nCount)
  local tbItem = self:GetItemSortByExpire(nItemId)
  if #tbItem == 0 then
    printError("没有可使用的道具：" .. nItemId)
    return {}
  end
  local tbUseItem = {}
  local nRemainCount = nCount
  for _, tbItemCount in ipairs(tbItem) do
    if nRemainCount > tbItemCount[2] then
      table.insert(tbUseItem, {
        Id = tbItemCount[1],
        Tid = nItemId,
        SelectTid = nChooseTid,
        Qty = tbItemCount[2] == 1 and 0 or tbItemCount[2]
      })
      nRemainCount = nRemainCount - tbItemCount[2]
    else
      table.insert(tbUseItem, {
        Id = tbItemCount[1],
        Tid = nItemId,
        SelectTid = nChooseTid,
        Qty = nRemainCount == 1 and 0 or nRemainCount
      })
      nRemainCount = 0
      break
    end
  end
  return tbUseItem
end

function PlayerItemData:SendItemGrowthReq(tbStep, callback)
  if not tbStep or next(tbStep) == nil then
    return
  end
  local msgData = {List = tbStep}
  
  local function msgCallback(sendData, netMsg)
    EventManager.Hit("AutoFillSuccess")
    UTILS.OpenReceiveByChangeInfo(netMsg)
    if callback ~= nil and type(callback) == "function" then
      callback(sendData, netMsg)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.item_quick_growth_req, msgData, nil, msgCallback)
end

function PlayerItemData:CheckItemCountExceededLimit(callBack)
  callBack(false)
end

function PlayerItemData:ProcessRewardChangeInfo(mapChangeInfo)
  local mapDecodeInfo = UTILS.DecodeChangeInfo(mapChangeInfo)
  local tbRewardById = {}
  local tbReward, tbSpReward = {}, {}
  local tbDst, tbSrc = {}, {}
  local tbDstByIdx, tbSrcByIdx = {}, {}
  local tbNewCharOrDisc = {}
  local tbAcquireInfo = {}
  local tbItemAcquireReward = {}
  
  local function add_reward(nId, nCount)
    if not tbRewardById[nId] then
      tbRewardById[nId] = 0
    end
    tbRewardById[nId] = tbRewardById[nId] + nCount
  end
  
  local function add_acquire_reward(tbItem)
    for _, v in ipairs(tbItem) do
      if not tbItemAcquireReward[v.Tid] then
        tbItemAcquireReward[v.Tid] = 0
      end
      tbItemAcquireReward[v.Tid] = tbItemAcquireReward[v.Tid] + v.Qty
    end
  end
  
  if type(mapDecodeInfo) == "table" then
    if type(mapDecodeInfo["proto.Acquire"]) == "table" then
      tbAcquireInfo = self:ProcessAcquireInfo(mapDecodeInfo["proto.Acquire"])
    end
    if type(mapDecodeInfo["proto.Char"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.Char"]) do
        local itemInfo = ConfigTable.GetData_Character(mapData.Tid)
        if itemInfo then
          local tbItemList = self:GetAcquireReward(mapData.Tid, 1)
          add_acquire_reward(tbItemList)
          local rewardData = {
            nId = mapData.Tid,
            nType = GameEnum.itemType.Char,
            bNew = true,
            tbItemList = tbItemList
          }
          table.insert(tbSpReward, rewardData)
          add_reward(mapData.Tid, 1)
          tbNewCharOrDisc[mapData.Tid] = true
        end
      end
    end
    if type(mapDecodeInfo["proto.Disc"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.Disc"]) do
        local itemInfo = ConfigTable.GetData("Disc", mapData.Id)
        if itemInfo then
          local tbItemList = self:GetAcquireReward(mapData.Id, 1)
          add_acquire_reward(tbItemList)
          local rewardData = {
            nId = mapData.Id,
            bNew = true,
            tbItemList = tbItemList
          }
          table.insert(tbSpReward, rewardData)
          add_reward(mapData.Id, 1)
          tbNewCharOrDisc[mapData.Id] = true
        end
      end
    end
    if type(mapDecodeInfo["proto.Transform"]) == "table" then
      for _, mapTrans in ipairs(mapDecodeInfo["proto.Transform"]) do
        for _, mapData in ipairs(mapTrans.Src) do
          if not tbSrc[mapData.Tid] then
            tbSrc[mapData.Tid] = {
              Tid = mapData.Tid,
              Qty = 0
            }
          end
          tbSrc[mapData.Tid].Qty = tbSrc[mapData.Tid].Qty + mapData.Qty
        end
        for _, mapData in ipairs(mapTrans.Dst) do
          if not tbDst[mapData.Tid] then
            tbDst[mapData.Tid] = {
              Tid = mapData.Tid,
              Qty = 0
            }
          end
          tbDst[mapData.Tid].Qty = tbDst[mapData.Tid].Qty + mapData.Qty
        end
      end
      for _, mapData in pairs(tbSrc) do
        local nSrcId = mapData.Tid
        local mapAcquireInfo = tbAcquireInfo[nSrcId]
        if mapAcquireInfo and mapAcquireInfo.Begin == 0 then
          mapAcquireInfo.Begin = 1
        end
        if ConfigTable.GetData_Character(nSrcId, true) and tbNewCharOrDisc[nSrcId] == nil then
          for k = 1, mapData.Qty do
            local tbItemList = {}
            if mapAcquireInfo then
              tbItemList = self:GetAcquireReward(nSrcId, mapAcquireInfo.Begin + k)
            end
            add_acquire_reward(tbItemList)
            local rewardData = {
              nId = nSrcId,
              nType = GameEnum.itemType.Char,
              bNew = false,
              tbItemList = tbItemList
            }
            table.insert(tbSpReward, rewardData)
          end
        end
        if ConfigTable.GetData("Disc", nSrcId, true) and tbNewCharOrDisc[nSrcId] == nil then
          for k = 1, mapData.Qty do
            local tbItemList = {}
            if mapAcquireInfo then
              tbItemList = self:GetAcquireReward(nSrcId, mapAcquireInfo.Begin + k)
            end
            add_acquire_reward(tbItemList)
            local rewardData = {
              nId = nSrcId,
              bNew = false,
              tbItemList = tbItemList
            }
            table.insert(tbSpReward, rewardData)
          end
        end
      end
      for _, v in pairs(tbSrc) do
        table.insert(tbSrcByIdx, v)
      end
      for _, v in pairs(tbDst) do
        table.insert(tbDstByIdx, v)
      end
    end
    if type(mapDecodeInfo["proto.Res"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.Res"]) do
        local itemInfo = ConfigTable.GetData_Item(mapData.Tid)
        if itemInfo then
          add_reward(mapData.Tid, mapData.Qty)
        end
      end
    end
    if type(mapDecodeInfo["proto.Item"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.Item"]) do
        local itemInfo = ConfigTable.GetData_Item(mapData.Tid)
        if itemInfo then
          add_reward(mapData.Tid, mapData.Qty)
        end
      end
    end
    if type(mapDecodeInfo["proto.Energy"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.Energy"]) do
        local mapEnergy = PlayerData.Base:GetCurEnergy()
        local itemInfo = ConfigTable.GetData_Item(AllEnum.CoinItemId.Energy)
        if itemInfo and 0 < mapData.Primary then
          add_reward(AllEnum.CoinItemId.Energy, mapData.Primary - mapEnergy.nEnergy)
        end
      end
    end
    if type(mapDecodeInfo["proto.WorldClass"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.WorldClass"]) do
        local itemInfo = ConfigTable.GetData_Item(AllEnum.CoinItemId.WorldClassExp)
        if itemInfo and 0 < mapData.ExpChange then
          add_reward(AllEnum.CoinItemId.WorldClassExp, mapData.ExpChange)
        end
      end
    end
    if type(mapDecodeInfo["proto.Title"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.Title"]) do
        local titleInfo = ConfigTable.GetData("Title", mapData.TitleId)
        if titleInfo ~= nil then
          local itemInfo = ConfigTable.GetData_Item(titleInfo.ItemId)
          if itemInfo then
            add_reward(titleInfo.ItemId, 1)
          end
        end
      end
    end
    if type(mapDecodeInfo["proto.Honor"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.Honor"]) do
        local itemInfo = ConfigTable.GetData_Item(mapData.NewId)
        if itemInfo then
          add_reward(mapData.NewId, 1)
        end
      end
    end
    if type(mapDecodeInfo["proto.HeadIcon"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.HeadIcon"]) do
        local itemInfo = ConfigTable.GetData_Item(mapData.Tid)
        if itemInfo then
          add_reward(mapData.Tid, 1)
        end
      end
    end
    if type(mapDecodeInfo["proto.TraceHuntItem"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.TraceHuntItem"]) do
        local itemInfo = ConfigTable.GetData_Item(mapData.Tid)
        if itemInfo and 0 < mapData.ConvertQty + mapData.GrantQty then
          add_reward(mapData.Tid, mapData.ConvertQty + mapData.GrantQty)
        end
      end
    end
    if type(mapDecodeInfo["proto.DormItem"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.DormItem"]) do
        local itemInfo = ConfigTable.GetData_Item(mapData.Tid)
        if itemInfo then
          add_reward(mapData.Tid, mapData.Qty)
        end
      end
    end
    for nId, nCount in pairs(tbRewardById) do
      if nCount <= 0 then
        tbRewardById[nId] = nil
      elseif tbDst[nId] then
        if nCount > tbDst[nId].Qty then
          tbRewardById[nId] = nCount - tbDst[nId].Qty
        else
          tbRewardById[nId] = nil
        end
      end
    end
    for _, mapData in pairs(tbSrc) do
      add_reward(mapData.Tid, mapData.Qty)
    end
    if next(tbItemAcquireReward) ~= nil then
      for nId, nCount in pairs(tbItemAcquireReward) do
        if tbRewardById[nId] then
          if nCount < tbRewardById[nId] then
            tbRewardById[nId] = tbRewardById[nId] - nCount
          else
            tbRewardById[nId] = nil
          end
        end
      end
    end
    for nId, nCount in pairs(tbRewardById) do
      table.insert(tbReward, {id = nId, count = nCount})
    end
  end
  return {
    tbReward = tbReward,
    tbSpReward = tbSpReward,
    tbSrc = tbSrcByIdx,
    tbDst = tbDstByIdx
  }
end

function PlayerItemData:ProcessRewardDisplayItem(tbItem, mapTrans)
  local tbReward, tbSpReward = {}, {}
  if not tbItem then
    return tbReward, tbSpReward
  end
  
  local function process_sp(mapData)
    local bNew = false
    if mapTrans and mapTrans.tbNewCharOrDisc[mapData.Tid] then
      bNew = true
      mapTrans.tbNewCharOrDisc[mapData.Tid] = false
    end
    local mapAcquireInfo = mapTrans.tbAcquireInfo[mapData.Tid]
    for i = 1, mapData.Qty do
      if 1 < i then
        bNew = false
      end
      local tbItemList = {}
      if mapAcquireInfo then
        tbItemList = self:GetAcquireReward(mapData.Tid, mapAcquireInfo.Begin + i)
      end
      local rewardData = {
        nId = mapData.Tid,
        bNew = bNew,
        tbItemList = tbItemList
      }
      table.insert(tbSpReward, rewardData)
    end
    table.insert(tbReward, {
      id = mapData.Tid,
      count = mapData.Qty,
      rewardType = mapData.rewardType
    })
  end
  
  local tbItemAfter = {}
  for _, mapData in ipairs(tbItem) do
    table.insert(tbItemAfter, mapData)
  end
  for _, mapData in ipairs(tbItem) do
    local mapItemCfg = ConfigTable.GetData_Item(mapData.Tid)
    if mapItemCfg ~= nil then
      local nType = mapItemCfg.Type
      if nType == GameEnum.itemType.Char or nType == GameEnum.itemType.CharacterSkin then
        process_sp(mapData)
      elseif nType == GameEnum.itemType.Disc then
        process_sp(mapData)
      else
        table.insert(tbReward, {
          id = mapData.Tid,
          count = mapData.Qty,
          rewardType = mapData.rewardType
        })
      end
    end
  end
  return tbReward, tbSpReward
end

function PlayerItemData:ProcessTransChangeInfo(mapChangeInfo)
  local mapDecodeInfo = UTILS.DecodeChangeInfo(mapChangeInfo)
  local tbDst, tbSrc = {}, {}
  local tbDstByIdx, tbSrcByIdx = {}, {}
  local tbAcquireInfo = {}
  local tbNewCharOrDisc = {}
  if type(mapDecodeInfo) == "table" then
    if type(mapDecodeInfo["proto.Char"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.Char"]) do
        local itemInfo = ConfigTable.GetData_Character(mapData.Tid)
        if itemInfo then
          tbNewCharOrDisc[mapData.Tid] = true
        end
      end
    end
    if type(mapDecodeInfo["proto.Disc"]) == "table" then
      for _, mapData in ipairs(mapDecodeInfo["proto.Disc"]) do
        local itemInfo = ConfigTable.GetData("Disc", mapData.Id)
        if itemInfo then
          tbNewCharOrDisc[mapData.Id] = true
        end
      end
    end
    if type(mapDecodeInfo["proto.Transform"]) == "table" then
      for _, mapTrans in ipairs(mapDecodeInfo["proto.Transform"]) do
        for _, mapData in ipairs(mapTrans.Src) do
          if not tbSrc[mapData.Tid] then
            tbSrc[mapData.Tid] = {
              Tid = mapData.Tid,
              Qty = 0
            }
          end
          tbSrc[mapData.Tid].Qty = tbSrc[mapData.Tid].Qty + mapData.Qty
        end
        for _, mapData in ipairs(mapTrans.Dst) do
          if not tbDst[mapData.Tid] then
            tbDst[mapData.Tid] = {
              Tid = mapData.Tid,
              Qty = 0
            }
          end
          tbDst[mapData.Tid].Qty = tbDst[mapData.Tid].Qty + mapData.Qty
        end
      end
      for _, v in pairs(tbSrc) do
        table.insert(tbSrcByIdx, v)
      end
      for _, v in pairs(tbDst) do
        table.insert(tbDstByIdx, v)
      end
    end
    if type(mapDecodeInfo["proto.Acquire"]) == "table" then
      tbAcquireInfo = self:ProcessAcquireInfo(mapDecodeInfo["proto.Acquire"])
    end
  end
  return {
    tbSrc = tbSrcByIdx,
    tbDst = tbDstByIdx,
    tbNewCharOrDisc = tbNewCharOrDisc,
    tbAcquireInfo = tbAcquireInfo
  }
end

function PlayerItemData:ProcessAcquireInfo(mapAcquire)
  local tbAcqById = {}
  for _, tbAcqList in ipairs(mapAcquire) do
    for _, mapAcq in ipairs(tbAcqList.List) do
      if not tbAcqById[mapAcq.Tid] then
        tbAcqById[mapAcq.Tid] = {}
      end
      table.insert(tbAcqById[mapAcq.Tid], mapAcq)
    end
  end
  local tbCombinedAcq = {}
  for Tid, v in pairs(tbAcqById) do
    table.sort(v, function(a, b)
      return a.Begin < b.Begin
    end)
    local Begin = v[1].Begin
    local Count = 0
    for _, mapAcq in ipairs(v) do
      Count = Count + mapAcq.Count
    end
    tbCombinedAcq[Tid] = {Begin = Begin, Count = Count}
  end
  return tbCombinedAcq
end

function PlayerItemData:GetAcquireReward(nTid, nAcquireTimes)
  local tbList = {}
  local mapItemCfg = ConfigTable.GetData_Item(nTid)
  if not mapItemCfg then
    return tbList
  end
  local nMax = self._mapMaxAcquireReward[mapItemCfg.Stype][mapItemCfg.Rarity]
  if nAcquireTimes > nMax then
    nAcquireTimes = nMax
  end
  local nId = mapItemCfg.Stype * 1000 + mapItemCfg.Rarity * 100 + nAcquireTimes
  local mapCfg = ConfigTable.GetData("AcquireReward", nId)
  if not mapCfg or mapCfg.ItemNum == 0 then
    return tbList
  end
  table.insert(tbList, {
    Tid = mapCfg.ItemId,
    Qty = mapCfg.ItemNum
  })
  return tbList
end

function PlayerItemData:CacheFragmentsOverflow(mapChangeInfo, mapGachaChangeInfo)
  if mapChangeInfo then
    self.mapOverTrans = self:ProcessTransChangeInfo(mapChangeInfo)
  end
  if mapGachaChangeInfo then
    self.mapGachaTrans = self:ProcessTransChangeInfo(mapGachaChangeInfo)
  end
end

function PlayerItemData:TryOpenFragmentsOverflow(callback)
  local tbSrc, tbDst = {}, {}
  if self.mapGachaTrans and self.mapGachaTrans.tbSrc and #self.mapGachaTrans.tbSrc > 0 then
    for _, v in ipairs(self.mapGachaTrans.tbSrc) do
      table.insert(tbSrc, v)
    end
    for _, v in ipairs(self.mapGachaTrans.tbDst) do
      table.insert(tbDst, v)
    end
    self.mapGachaTrans = nil
  end
  if self.mapOverTrans and self.mapOverTrans.tbSrc and 0 < #self.mapOverTrans.tbSrc then
    for _, v in ipairs(self.mapOverTrans.tbSrc) do
      table.insert(tbSrc, v)
    end
    for _, v in ipairs(self.mapOverTrans.tbDst) do
      table.insert(tbDst, v)
    end
    self.mapOverTrans = nil
  end
  if 0 < #tbDst and 0 < #tbSrc then
    EventManager.Hit(EventId.OpenPanel, PanelId.ReceiveAutoTrans, tbSrc, tbDst, callback)
  elseif callback then
    callback()
  end
end

function PlayerItemData:GetFragmentsOverflow()
  return self.mapOverTrans
end

function PlayerItemData:SendUseItemMsg(itemList, callback, bShowReceiveProps)
  local msgData = {}
  msgData.Use = {}
  
  local function msgCallback(sendData, netMsg)
    local function showRewardCallback()
      if callback ~= nil and type(callback) == "function" then
        callback(sendData, netMsg)
      end
    end
    
    if bShowReceiveProps then
      UTILS.OpenReceiveByChangeInfo(netMsg, showRewardCallback)
    else
      showRewardCallback()
    end
  end
  
  if nil ~= itemList then
    msgData.Use.List = itemList
    HttpNetHandler.SendMsg(NetMsgId.Id.item_use_req, msgData, nil, msgCallback)
  end
end

function PlayerItemData:SendPickItemMsg(itemList, callback, bShowReceiveProps)
  local msgData = {}
  msgData.Pick = {}
  
  local function msgCallback(sendData, netMsg)
    local function showRewardCallback()
      if callback ~= nil and type(callback) == "function" then
        callback(sendData, netMsg)
      end
    end
    
    if bShowReceiveProps then
      UTILS.OpenReceiveByChangeInfo(netMsg, showRewardCallback)
    else
      showRewardCallback()
    end
  end
  
  if nil ~= itemList then
    msgData.Pick.List = itemList
    HttpNetHandler.SendMsg(NetMsgId.Id.item_use_req, msgData, nil, msgCallback)
  end
end

return PlayerItemData
