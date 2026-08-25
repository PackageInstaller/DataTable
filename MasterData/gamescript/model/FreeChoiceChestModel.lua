local function createAwakerInfo(itemCfg, dropIdx)
  local awakerTid = itemCfg.SpParam[1]
  
  local awakerCfg = DT.AwakerConfig[awakerTid]
  local schoolCfg = DT.SchoolConfig[awakerCfg.School]
  local qualityCfg = DT.ItemQuality[awakerCfg.Quality]
  local alreadyOwned = false
  local maxPotency = false
  alreadyOwned = AwakerDataUtils.HasOwnedAwaker(awakerTid)
  if alreadyOwned then
    local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
    local potencyIdx = AwakerDataUtils.GetAwakerPotencyIndex(awakerTid, awakerData.potency)
    local numFragments = ItemDataUtils.GetItemNum(awakerCfg.AwakerSpecialItem)
    local costNumList = DT.GetOriginalConstant("AwakerPotencyUpgradeConsumeNum")
    maxPotency = potencyIdx + numFragments >= #costNumList
  end
  return {
    awakerTid = awakerTid,
    tid = itemCfg.ID,
    itemType = itemCfg.Type,
    name = LT.Text(awakerCfg.Name),
    icon = AwakerDataUtils.GetFullHeadIcon(awakerTid),
    quality = qualityCfg.AwakerWeaponSelectQualityColor,
    schoolIcon = schoolCfg.Icon,
    alreadyOwned = alreadyOwned,
    maxPotency = maxPotency,
    dropIdx = dropIdx
  }
end

local function createWeaponInfo(itemCfg, dropIdx)
  local qualityCfg = DT.ItemQuality[itemCfg.Quality]
  return {
    tid = itemCfg.ID,
    itemType = itemCfg.Type,
    name = LT.Text(itemCfg.Name),
    icon = itemCfg.SpIcon,
    quality = qualityCfg.AwakerWeaponSelectQualityColor,
    alreadyOwned = ItemDataUtils.GetItemByTid(itemCfg.ID) ~= nil,
    dropIdx = dropIdx
  }
end

local function createItemInfos(dropId, isAlreadyOwn, createItemInfo)
  local itemInfos = {}
  local dropCfg = DT.Drop[dropId]
  local now = TimeUtils.GetServerTime()
  for idx, drop in ipairs(dropCfg.data_list) do
    local dropItemCfg = DT.Item[drop.DropItem]
    if dropItemCfg.StartDropDate and now < dropItemCfg.StartDropDate then
    else
      table.insert(itemInfos, createItemInfo(dropItemCfg, idx))
    end
  end
  return itemInfos
end

local function createState(chestItemTid)
  local chestItemCfg = DT.Item[chestItemTid]
  local dropId = chestItemCfg.SpParam[1]
  local state = {}
  state.chestItemTid = chestItemTid
  state.isAwakerChest = chestItemCfg.SubType == CommonDefine.ItemSubType.AwakerChest
  state.isWeaponChest = chestItemCfg.SubType == CommonDefine.ItemSubType.WeaponChest
  if state.isAwakerChest then
    state.itemInfos = createItemInfos(dropId, function(dropItemCfg)
      local awakerTid = dropItemCfg.SpParam[1]
      do return AwakerDataUtils.HasOwnedAwaker end
      return AwakerDataUtils.HasOwnedAwaker, awakerTid
    end, createAwakerInfo)
    table.sort(state.itemInfos, function(a, b)
      if not a.alreadyOwned and b.alreadyOwned then
        return true
      end
      if a.alreadyOwned and not b.alreadyOwned then
        return false
      end
      if not a.maxPotency and b.maxPotency then
        return true
      end
      if a.maxPotency and not b.maxPotency then
        return false
      end
      return a.dropIdx < b.dropIdx
    end)
  elseif state.isWeaponChest then
    state.itemInfos = createItemInfos(dropId, function(dropItemCfg)
      do return ItemDataUtils.GetItemByTid end
      return ItemDataUtils.GetItemByTid, dropItemCfg.ID
    end, createWeaponInfo)
    table.sort(state.itemInfos, function(a, b)
      if not a.alreadyOwned and b.alreadyOwned then
        return true
      end
      if a.alreadyOwned and not b.alreadyOwned then
        return false
      end
      local aIsMaxPotency = MainShopDataUtils.IsMaxPotencyByItemId(a.tid) and 1 or 0
      local bIsMaxPotency = MainShopDataUtils.IsMaxPotencyByItemId(b.tid) and 1 or 0
      if aIsMaxPotency ~= bIsMaxPotency then
        return aIsMaxPotency < bIsMaxPotency
      end
      return a.dropIdx < b.dropIdx
    end)
  else
    local useAwakerChipList = ItemDataUtils.GetUseAwakerChipList(chestItemCfg.SpParam[1])
    local chipInfoData = {}
    for _, chip in ipairs(useAwakerChipList) do
      local itemCfg = DT.Item[chip.tid]
      local isAwakerChip = itemCfg.SubType == CommonDefine.ItemSubType.AwakerChip
      local chipData = {
        alreadyOwned = isAwakerChip and AwakerDataUtils.HasOwnedAwaker(itemCfg.SpParam[1]) or false,
        schoolIcon = isAwakerChip and AwakerDataUtils.GetAwakerSchoolIcon(itemCfg.SpParam[1]) or "",
        maxPotency = isAwakerChip and ItemDataUtils.IsAwakerChipOverFlow(chip.tid) or false,
        SubType = itemCfg.SubType,
        awakerTid = isAwakerChip and itemCfg.SpParam[1] or nil,
        tid = chip.tid,
        icon = isAwakerChip and AwakerDataUtils.GetAwakerDefaultBust(itemCfg.SpParam[1]) or itemCfg.Icon,
        name = itemCfg.Name,
        quality = DT.ItemQuality[itemCfg.Quality].AwakerWeaponSelectQualityColor
      }
      table.insert(chipInfoData, chipData)
    end
    state.itemInfos = chipInfoData
  end
  state.currSelectedIdx = 1
  return state
end

local function createViews(_)
  local views = {}
  return views
end

local function createActions(data)
  local actions = {}
  
  function actions:SelectItem(idx)
    data.currSelectedIdx = idx
  end
  
  function actions:RequestChooseItem(callback)
    EventMgr.Instance.OpenReqMask:Dispatch()
    local currSelectedItemInfo = data.itemInfos[data.currSelectedIdx]
    ProtoManager.Instance:ReqServer("GameRequest", "OnUseChooseItem", function(svrData)
      if callback then
        callback(svrData)
      end
    end, function()
    end, data.chestItemTid, currSelectedItemInfo.tid, 1)
  end
  
  return actions
end

local function onSetup(_, _)
end

local FreeChoiceChestModel = Vue.model("FreeChoiceChestModel", createState):views(createViews):actions(createActions):setup(onSetup)
return FreeChoiceChestModel
