local ItemType = CommonDefine.ItemType
local tableInsert = table.insert
local ItemSubType = CommonDefine.ItemSubType
local QualitySortID = CommonDefine.QualitySortID
local FastPromotionSpParamKey = CommonDefine.FastPromotionSpParamKey
local AWAKER_BREAKTHROUGH_SKILL_1_IDX = 7
local AWAKER_BREAKTHROUGH_SKILL_2_IDX = 8
local REASON_WEAPON_AUTO_REFINE = CommonDefine.ItemReason.WeaponAutoRefine
local AccountExpItemTid = DT.GetConstant("AccountExpItemTid")
local UnLockExtraSSRWeaponLv = DT.GetConstant("UnLockExtraSSRWeaponLv")
local MAX_WEAPON_LV = DT.GetConstant("UnLockExtraSSRWeaponLv")
local NeedInheritConsumeItems = DT.GetConstant("NeedInheritConsumeItems")
local RevivalItemIdTid = DT.GetConstant("RevivalItemId")
local BoundTrinketTipsQuality = "UR"
local ItemDataUtils = {}
local notInSpecialBagSubTypeGroup = {
  ItemSubType.PlayerAvatar,
  ItemSubType.Emoji,
  ItemSubType.GenderDifference,
  ItemSubType.ExpBonus,
  ItemSubType.AvatarFrame
}

function ItemDataUtils.ResetAll()
  DataCenter.itemData.MockItemData = {}
  DataCenter.itemData.BagItemData = {}
  DataCenter.itemData.CurrencyData = {}
  DataCenter.itemData.itemTidToUidMap = {}
  DataCenter.itemData.EquipItemDataMap = {}
  DataCenter.itemData.TrinketPosMap = {}
  DataCenter.itemData.EquipableGoodWeaponMap = {}
  DataCenter.itemData.ActivedKeeperSkill = {}
  DataCenter.itemData.keeperSkillIds = {}
  ItemDataUtils.InitTrinketSuitNumMap()
  ItemDataUtils.PredealItemConfig()
  ItemDataUtils.__SpecificOnceRedItem = nil
  ItemDataUtils.HandleMockDataLock = nil
  ItemDataUtils.ResetMockItemData()
end

local VaildJumpReasonInBattle = {
  [CommonDefine.ItemReason.BattlePass] = true
}

function ItemDataUtils.IsVaildJumpReasonInBattle(itemDataList)
  for _, itemData in ipairs(itemDataList or {}) do
    if VaildJumpReasonInBattle[itemData and itemData.reason or CommonDefine.ItemReason.Common] then
      return true
    end
  end
  return false
end

ItemDataUtils.HandleMockDataLock = nil

function ItemDataUtils.InitMockItemData(table)
  if not ItemDataUtils.HandleMockDataLock then
    ItemDataUtils.ResetMockItemData()
    if table then
      for _, itemData in pairs(table) do
        DataCenter.itemData.MockItemData[itemData.uid] = itemData
      end
    end
  end
end

function ItemDataUtils.AddMockItemData(table)
  if table then
    for _, itemData in pairs(table) do
      DataCenter.itemData.MockItemData[itemData.uid] = itemData
    end
  end
end

function ItemDataUtils.ResetMockItemData()
  if not ItemDataUtils.HandleMockDataLock then
    DataCenter.itemData.MockItemData = {}
  end
end

function ItemDataUtils.GetBagItemByUid(uid)
  if not uid or 0 == uid then
    return nil
  end
  return DataCenter.itemData.BagItemData[uid]
end

function ItemDataUtils.OpenHandleMockDataLock(strVal)
  if not ItemDataUtils.HandleMockDataLock then
    ItemDataUtils.HandleMockDataLock = strVal
  end
end

function ItemDataUtils.CloseHandleMockDataLock(strVal)
  if ItemDataUtils.HandleMockDataLock == strVal then
    ItemDataUtils.HandleMockDataLock = nil
  end
end

function ItemDataUtils.PredealItemConfig()
  local KeeperSkill2Item = {}
  local Item2KeeperSKill = {}
  local TypeKeeperSkill = CommonDefine.ItemType.KeeperSkill
  for _, v in pairs(DT.Item) do
    if v.Type ~= TypeKeeperSkill then
    elseif v.SpParam and v.SpParam[1] then
      KeeperSkill2Item[v.SpParam[1]] = v.ID
      Item2KeeperSKill[v.ID] = v.SpParam[1]
    elseif v.PVPSkill and v.PVPSkill[1] then
      KeeperSkill2Item[v.PVPSkill[1]] = v.ID
      Item2KeeperSKill[v.ID] = v.PVPSkill[1]
    end
  end
  DataCenter.itemData.KeeperSkill2Item = KeeperSkill2Item
  DataCenter.itemData.Item2KeeperSkill = Item2KeeperSKill
end

function ItemDataUtils.SetItemTidToUid(tid, uid)
  if DataCenter.itemData.itemTidToUidMap[tid] == nil then
    DataCenter.itemData.itemTidToUidMap[tid] = {}
  end
  DataCenter.itemData.itemTidToUidMap[tid][uid] = true
end

function ItemDataUtils.GetItemUidMap(tid)
  return DataCenter.itemData.itemTidToUidMap[tid]
end

function ItemDataUtils.RemoveItemTidToUid(tid, uid)
  local uids = ItemDataUtils.GetItemUidMap(tid)
  if uids then
    uids[uid] = nil
  end
end

function ItemDataUtils.GetMaxLevelItemOfTid(tid, excludeUids)
  if not tid or 0 == tid then
    return
  end
  local uidMap = DataCenter.itemData.itemTidToUidMap[tid] or {}
  local maxLevel = -1
  local maxLevelItem
  for uid in pairs(uidMap) do
    local item = ItemDataUtils.GetItemByUid(uid)
    if excludeUids and excludeUids[uid] then
    elseif maxLevel < (item.level or 0) then
      maxLevel = item.level
      maxLevelItem = item
    end
  end
  return maxLevelItem
end

function ItemDataUtils.InitItems(items)
  for _, v in ipairs(items) do
    ItemDispatchManager.Instance:InitItem(v)
  end
  EventMgr.Instance.UpdateBagEvent:Dispatch()
  RedPointDataUtils.InitSpecificItemOnceRed()
  RedPointDataUtils.UpdateEmojiNew()
  if items.expiredItems then
    ItemDataUtils.UpdateaExpiredItems(items.expiredItems)
  end
  ItemDataUtils.SetSkillIdsMap()
  AlchemyDecomposeWeaponExtModel.Instance:Init_decompositeItemList()
  AlchemyDecomposeTrinketExtModel.Instance:Init_decompositeItemList()
  AlchemyDecomposeItemExtModel.Instance:Init_decompositeItemList()
end

function ItemDataUtils.UpdateaExpiredItems(items)
  DataCenter.itemData.ExpiredItems = items or {}
end

function ItemDataUtils.GetExpiredItems()
  return DataCenter.itemData.ExpiredItems
end

function ItemDataUtils.GetExpiredItemByUid(uid)
  local item = ItemDataUtils.GetItemByUid(uid)
  local itemTid = item.tid
  local now = TimeUtils.GetServerTime()
  for _, recycleCfg in pairs(DT.ItemRecycle) do
    local recycleTime = recycleCfg.RecycleTime
    if now < recycleTime then
      for _, itemInfo in ipairs(recycleCfg.RecycleItem or {}) do
        if itemInfo[1] == itemTid then
          return recycleTime
        end
      end
    end
  end
end

function ItemDataUtils.InitTrinketSuitNumMap()
  local suitNumMap = {}
  for suitId, _ in pairs(DT.TrinketSuitEffect) do
    suitNumMap[suitId] = 0
  end
  DataCenter.itemData.TrinketSuitNumMap = suitNumMap
end

function ItemDataUtils.SyncItemList(items)
  local isHaveAutoRefine
  for _, v in pairs(items) do
    if type(v) ~= "table" then
    else
      ItemDataUtils.SyncItem(v, v.reason)
      if v.reason == REASON_WEAPON_AUTO_REFINE then
        isHaveAutoRefine = true
      end
    end
  end
  if isHaveAutoRefine then
    ItemDataUtils.SyncWeaponAutoRefine(items)
  end
  EventMgr.Instance.UpdateBagEvent:Dispatch(items)
  RedPointDataUtils.UpdateBackTrackOnceRed()
  RedPointDataUtils.UpdateAwakerRed()
end

function ItemDataUtils.SyncWeaponAutoRefine(items)
  local uid2levelMap = {}
  for i, item in ipairs(items) do
    if item.reason == REASON_WEAPON_AUTO_REFINE and item.targetUid then
      local preLevel = uid2levelMap[item.targetUid] or 0
      uid2levelMap[item.targetUid] = math.max(preLevel, item.targetLevel or 0)
    end
  end
  for uid, level in pairs(uid2levelMap) do
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if itemData then
      itemData.level = level
    end
  end
end

function ItemDataUtils.InitBagItem(item)
  if item.num <= 0 then
    return
  end
  local BagItemData = DataCenter.itemData.BagItemData
  local uid, tid, itemCfg, itemType
  uid, tid, itemCfg = item.uid, item.tid, DT.Item[item.tid]
  itemType = itemCfg.Type
  local is_exist = false
  if BagItemData[uid] then
    is_exist = true
    for k, value in pairs(item) do
      BagItemData[uid][k] = value
    end
  else
    BagItemData[uid] = item
  end
  ItemDataUtils.SetItemTidToUid(tid, uid)
  if not is_exist then
    if itemType == ItemType.Trinket then
      ItemDataUtils.AddTrinketToPosMap(item)
      ItemDataUtils.UpdateTrinketSuitNumMap(item, 1)
      TrinketSortingModel.Instance:PushToCalSortingParam(item)
    elseif itemType == ItemType.Weapon then
      ItemDataUtils.UpdateEquipableGoodWeaponMap(item)
    elseif itemType == ItemType.KeeperSkill then
      DataCenter.itemData.ActivedKeeperSkill[tid] = true
    end
  end
end

function ItemDataUtils.SyncBagItem(itemNew, reason, proxy)
  proxy = proxy or {}
  if not itemNew.uid then
    return
  end
  local item = ItemDataUtils.GetItemByUid(itemNew.uid)
  if itemNew.num > 0 then
    local oldNum = 0
    if nil == item then
      local clientItem = table.clone(itemNew)
      clientItem.extraOrigin = nil
      DataCenter.itemData.BagItemData[itemNew.uid] = clientItem
      ItemDataUtils.SetItemTidToUid(itemNew.tid, itemNew.uid)
      item = ItemDataUtils.GetItemByUid(itemNew.uid)
    else
      oldNum = item.num
      for k, v in pairs(itemNew) do
        item[k] = v
      end
    end
    if 0 == oldNum and proxy.onAdd then
      proxy.onAdd()
    end
    if oldNum > 0 and itemNew.num ~= oldNum and proxy.onChangeNum then
      proxy.onChangeNum()
    end
    if oldNum < itemNew.num then
      EventMgr.Instance.AddItemEvent:Dispatch(item, oldNum, reason)
      if 0 == oldNum then
        EventMgr.Instance.NewAcquiredItemEvent:Dispatch(item, reason)
      end
    elseif oldNum > itemNew.num then
      EventMgr.Instance.RemoveItemEvent:Dispatch(item, oldNum, reason)
    end
  elseif item then
    if proxy.onRemove then
      proxy.onRemove()
    end
    DataCenter.itemData.BagItemData[item.uid] = nil
    ItemDataUtils.RemoveItemTidToUid(item.tid, item.uid)
    TrinketSortingModel.Instance:RemoveCalSortingParam(item)
    EventMgr.Instance.RemoveItemEvent:Dispatch(item, reason)
  end
  GlobalDispatcher:Dispatch(NotifyId.OnBagItemDataChanged, itemNew.uid, itemNew.tid)
end

function ItemDataUtils.HandleExpBonusReward(rst)
  local totalExp = 0
  for _, awardInfo in pairs(rst) do
    if awardInfo.tid == AccountExpItemTid then
      totalExp = totalExp + awardInfo.changedNum
    end
  end
  local bonusExpNum = PlayerDataUtils.GetBonusExpNum(totalExp)
  if bonusExpNum > 0 then
    table.insert(rst, {
      tid = AccountExpItemTid,
      changedNum = PlayerDataUtils.GetBonusExpNum(totalExp),
      extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Default,
      extraDesc = LT.Text("RewardItemAccelerateTag"),
      reason = "ExpBonus"
    })
  end
  return rst
end

function ItemDataUtils.GetExtraDescByReason(reason)
  local extraDescBgType, extraDesc
  if "ExpBonus" == reason then
    extraDesc = LT.Text("RewardItemAccelerateTag")
  elseif reason == cd.ItemReason.AutoDecompose then
    extraDesc = LT.Text("WeaponRefined_04")
    extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Blue
  elseif reason == CommonDefine.ItemReason.GuideNoteExtra then
    extraDesc = LT.Text("BpRewardSourceName")
  elseif reason == CommonDefine.ItemReason.BattlePassDoubleEx then
    extraDesc = LT.Text("DoubleExperience_02")
    extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Blue
  end
  if extraDesc and not extraDescBgType then
    extraDescBgType = CommonDefine.CommonIconExtraDescBgType.Default
  end
  return extraDesc, extraDescBgType
end

function ItemDataUtils.GetBagItemByTid(tid)
  local uids = ItemDataUtils.GetItemUidMap(tid)
  if table.next(uids or {}) then
    do return ItemDataUtils.GetItemByUid, table.next(uids) end
    return ItemDataUtils.GetItemByUid, table.next(uids)
  end
end

function ItemDataUtils.SyncItem(itemNew, reason)
  if not itemNew.uid then
    return
  end
  ItemDispatchManager.Instance:SyncItem(itemNew, reason)
end

function ItemDataUtils.GetBagItemNum(tid)
  local num = 0
  local uids = ItemDataUtils.GetItemUidMap(tid)
  if uids then
    for uid, _ in pairs(uids) do
      local item = ItemDataUtils.GetItemByUid(uid)
      if item then
        num = num + item.num
      end
    end
  end
  return num
end

function ItemDataUtils.GetItemNum(tid, excludeBound)
  if bg.IsInBattle() and not bg.isReplay and tid == RevivalItemIdTid then
    do return math.max, (bg.battleRender.lives or 1) - 1 end
    return math.max, (bg.battleRender.lives or 1) - 1, 0
  end
  if not excludeBound and ItemDataUtils.IsPayMoneyType(tid) then
    do return end
    return ItemDataUtils.GetPayMoneyTotalNum, tid, 0
  end
  do return ItemDispatchManager.Instance.GetItemCount, ItemDispatchManager.Instance end
  return ItemDispatchManager.Instance.GetItemCount, ItemDispatchManager.Instance, tid
end

function ItemDataUtils.IsPayMoneyType(tid)
  return tid == CommonDefine.CurrencyType.PayMoney
end

function ItemDataUtils.GetPayMoneyTotalNum()
  return ItemDispatchManager.Instance:GetItemCount(CommonDefine.CurrencyType.PayMoney) + ItemDispatchManager.Instance:GetItemCount(CommonDefine.CurrencyType.FreePayMoney)
end

function ItemDataUtils.CalcPayMoneyCost(needCount)
  local freePayMoneyNum = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.FreePayMoney, true)
  local freePayMoneyCost = math.min(freePayMoneyNum, needCount)
  local payMoneyCost = needCount - freePayMoneyCost
  return payMoneyCost, freePayMoneyCost
end

function ItemDataUtils.IsItemEnough(itemId, needCount, isShowTip)
  local haveCount = ItemDataUtils.GetItemNum(itemId)
  if needCount > haveCount then
    if isShowTip then
      if ItemDataUtils.IsPayMoneyType(itemId) then
        Alert.Show(10635, nil, function()
          SdkMgr.Instance:OpenChargePanel()
        end)
      else
        Alert.ShowWithParams(10210, {
          ItemDataUtils.GetItemName(itemId)
        })
      end
    end
    return false
  end
  return true
end

function ItemDataUtils.GetItemByUid(uid)
  if not uid or 0 == uid then
    return nil
  end
  local result
  if table.next(DataCenter.itemData.MockItemData) then
    result = DataCenter.itemData.MockItemData[uid]
  end
  result = result or DataCenter.itemData.BagItemData[uid]
  if not result then
    return nil
  end
  local itemType = ItemDataUtils.GetItemType(result.tid)
  if itemType == ItemType.Weapon then
    result.locked = false
  end
  return result
end

function ItemDataUtils.CheckIsMaxLvSSRWeapon(weaponUid)
  if not weaponUid or 0 == weaponUid then
    return false
  end
  local lv = ItemDataUtils.GetItemLevel(weaponUid, CommonDefine.ItemType.Weapon)
  local weaponTid = ItemDataUtils.GetItemDataByField("tid", weaponUid)
  local quality = ItemDataUtils.GetItemConfigByField("Quality", weaponTid)
  return lv >= UnLockExtraSSRWeaponLv and quality == CommonDefine.CommonQuality.Orange
end

function ItemDataUtils.IsHaveMaxLevelWeapon(weaponTid)
  local cfg = ItemDataUtils.GetItemConfig(weaponTid)
  if not cfg or cfg.Type ~= ItemType.Weapon then
    return false
  end
  local weaponMap = ItemDataUtils.GetItemUidMap(weaponTid) or {}
  for uid, _ in pairs(weaponMap) do
    if ItemDataUtils.IsMaxLevelWeapon(uid) then
      return true
    end
  end
end

function ItemDataUtils.IsMaxLevelWeapon(weaponUid)
  local lv = ItemDataUtils.GetItemLevel(weaponUid, CommonDefine.ItemType.Weapon)
  return lv >= MAX_WEAPON_LV
end

function ItemDataUtils.GetItemDataByField(field, uid)
  if not field or not uid then
    return nil
  end
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    return nil
  end
  return itemData[field]
end

function ItemDataUtils.GetWeaponByUid(uid)
  if not uid or 0 == uid then
    return nil
  end
  local result
  if table.next(DataCenter.itemData.MockItemData) then
    result = DataCenter.itemData.MockItemData[uid]
    if result then
      local itemType = ItemDataUtils.GetItemType(result.tid)
      if itemType == ItemType.Weapon then
        result.locked = false
        return result
      end
    end
  end
  return DataCenter.itemData.BagItemData[uid]
end

function ItemDataUtils.IsSSRWeaponByUid(uid)
  local weaponData = ItemDataUtils.GetWeaponByUid(uid)
  if not (weaponData and weaponData.tid) or 0 == weaponData.tid then
    return false
  end
  local weaponTid = weaponData.tid
  local weaponCfg = ItemDataUtils.GetItemConfig(weaponTid)
  if weaponCfg and weaponCfg.quality == CommonDefine.CommonQuality.Orange then
    return true
  end
end

function ItemDataUtils.IsMaxLevelSSRWeapon(uid)
  local weaponData = ItemDataUtils.GetWeaponByUid(uid)
  if not (weaponData and weaponData.tid) or 0 == weaponData.tid then
    return false
  end
  if weaponData.level < UnLockExtraSSRWeaponLv then
    return false
  end
  do return ItemDataUtils.IsSSRWeaponByUid end
  return ItemDataUtils.IsSSRWeaponByUid, uid
end

function ItemDataUtils.GetWeaponAllRefineLevelByTid(tid)
  local itemUidMap = ItemDataUtils.GetItemUidMap(tid)
  if not itemUidMap then
    return 0
  end
  local rst = 0
  for uid, _ in pairs(itemUidMap) do
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if not itemData then
    else
      local itemType = ItemDataUtils.GetItemType(itemData.tid)
      if itemType ~= ItemType.Weapon then
      else
        rst = rst + itemData.level + 1
      end
    end
  end
  return rst
end

function ItemDataUtils.GetWeaponRefineLevelByUid(uid)
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    return 0
  end
  local itemType = ItemDataUtils.GetItemType(itemData.tid)
  if itemType ~= ItemType.Weapon then
    return 0
  end
  return itemData.level or 0
end

function ItemDataUtils.GetBattleAwakerItemByUid(uid)
  if table.next(DataCenter.itemData.MockItemData) then
    return DataCenter.itemData.MockItemData[uid]
  end
  return DataCenter.itemData.BagItemData[uid]
end

function ItemDataUtils.GetItemByTid(tid)
  if tid <= 0 then
    return nil
  end
  do return ItemDispatchManager.Instance.GetItemByTid, ItemDispatchManager.Instance end
  return ItemDispatchManager.Instance.GetItemByTid, ItemDispatchManager.Instance, tid
end

function ItemDataUtils.GetItemName(itemId)
  do return ItemDispatchManager.Instance.GetItemName, ItemDispatchManager.Instance end
  return ItemDispatchManager.Instance.GetItemName, ItemDispatchManager.Instance, itemId
end

function ItemDataUtils.GetReviveItemName()
  local reviveItemId = DT.GetConstant("RevivalItemId")
  do return ItemDataUtils.GetItemName end
  return ItemDataUtils.GetItemName, reviveItemId
end

function ItemDataUtils.GetRichItemName(itemId, appendStr, isUnderLine)
  do return ItemDispatchManager.Instance.GetRichItemName, ItemDispatchManager.Instance, itemId, appendStr end
  return ItemDispatchManager.Instance.GetRichItemName, ItemDispatchManager.Instance, itemId, appendStr, isUnderLine
end

function ItemDataUtils.OnClickItemUse(uid)
  ItemUseController.Instance:CheckOpenItemUseView(uid)
end

function ItemDataUtils.OnClickBoxItemShow(tid)
  local isPreview = true
  if ItemCfgUtils.IsAwakerChest(tid) or ItemCfgUtils.IsWeaponChest(tid) then
    UIManager.Instance:Reopen(Urls.FreeChoiceChestView, tid, nil, isPreview)
    return
  end
  if ItemCfgUtils.IsAwakerRandomChest(tid) then
    UIManager.Instance:Reopen(Urls.RandomChestAwakerView, tid, isPreview)
    return
  end
  if ItemCfgUtils.IsWeaponRandomChest(tid) then
    UIManager.Instance:Reopen(Urls.RandomChestWeaponView, tid, isPreview)
    return
  end
  local cfg = DT.Item[tid]
  if cfg.SubType == ItemSubType.Chest then
    local panelData = {itemId = tid, useNum = 1}
    UIManager.Instance:Reopen(Urls.ItemUseSelectPanel, panelData, isPreview)
    return
  end
  if cfg.SubType == ItemSubType.AwakerChipChest then
    UIManager.Instance:Reopen(Urls.FreeChoiceChestView, tid, nil, isPreview)
  elseif cfg.SubType == ItemSubType.CosmeticsChest then
    UIManager.Instance:Reopen(Urls.UI_Bag_Panel_AppearancePreview, tid)
  elseif cfg.SubType == ItemSubType.CosmeticsRandChest then
    UIManager.Instance:Reopen(Urls.UI_Bag_Panel_AppearancePreview, tid)
  end
end

function ItemDataUtils.IsHaveUseCount(tid)
  local itemSubType = ItemDataUtils.GetItemSubType(tid)
  return itemSubType == cd.ItemSubType.CosmeticsRandChest or itemSubType == cd.ItemSubType.CosmeticsChest
end

function ItemDataUtils.GetMinUseCount(tid)
  local itemCfg = ItemDataUtils.GetItemConfig(tid)
  if ItemDataUtils.IsHaveUseCount(tid) then
    return itemCfg.SpParam and itemCfg.SpParam[2] or 1
  end
  return 1
end

function ItemDataUtils.OpenItemUsePanel(tid, useAfterCall)
  ItemUseController.Instance:OnOpenItemUseView(tid, useAfterCall)
end

function ItemDataUtils.CheckCanAddEnergy()
  local haveEnergy = ItemDataUtils.GetItemNum(CommonDefine.CurrencyType.Energy)
  local maxEnergy = DT.GetConstant("Energy_Max")
  local perRecoverEnergy = DT.GetConstant("ReplenishEnergyItemRestoreNum")
  return haveEnergy <= maxEnergy - perRecoverEnergy
end

function ItemDataUtils.GetShowRewardList()
  return DataCenter.itemData.ShowRewardList
end

function ItemDataUtils.SetShowRewardList(tbl)
  DataCenter.itemData.ShowRewardList = tbl
  EventMgr.Instance.OnShowRewardListChanged:Dispatch()
end

function ItemDataUtils.GetShowRewards()
  local rewards = ItemDataUtils.GetShowRewardList()
  local copiesSettleData = DataCenter.copiesData.copiesSettleData
  local stageId = copiesSettleData and copiesSettleData.stageId
  if stageId then
    rewards = require("Data.CopyDataUtils").SortCopyRewards(rewards, stageId)
  end
  return rewards
end

function ItemDataUtils.AddShowRewards(rewards)
  if not rewards then
    return
  end
  local curRewardList = ItemDataUtils.GetShowRewardList()
  if 0 == #curRewardList then
    curRewardList = table.clone(rewards)
  else
    table.append(curRewardList, rewards)
  end
  curRewardList = ItemDataUtils.MergeSameRewards(curRewardList)
  
  local function sortFunc(a, b)
    local sortIndexA = a.sortIndex
    local sortIndexB = b.sortIndex
    if sortIndexA ~= sortIndexB and sortIndexA and sortIndexB then
      return sortIndexA < sortIndexB
    end
    if a.tid == b.tid then
      local aIsLabeled = a.awardType and a.awardType ~= cd.ItemAwardType.Normal or a.reason == cd.ItemReason.ExpBonus or a.extraDesc ~= nil
      local bIsLabeled = b.awardType and b.awardType ~= cd.ItemAwardType.Normal or b.reason == cd.ItemReason.ExpBonus or b.extraDesc ~= nil
      if aIsLabeled ~= bIsLabeled then
        return not aIsLabeled
      end
    end
    local isExtraItemA = a.extraOrigin and 1 or 0
    local isExtraItemB = b.extraOrigin and 1 or 0
    if isExtraItemA == isExtraItemB then
      do return ItemDataUtils.CommonItemSortFunc, a end
      return ItemDataUtils.CommonItemSortFunc, a, b
    end
    return isExtraItemA < isExtraItemB
  end
  
  table.sort(curRewardList, sortFunc)
  ItemDataUtils.SetShowRewardList(curRewardList)
end

function ItemDataUtils.MergeSameRewards(tmp)
  local rst = {}
  local rewardUidMap = {}
  local Type_Weapon = cd.ItemType.Weapon
  local mergeKey
  local isAutoRefine = ZoneFeatureUtils.IsWeaponAutoRefine()
  for _, newData in pairs(tmp) do
    if newData.reason == cd.ItemReason.UseItem then
      table.insert(rst, newData)
    else
      if isAutoRefine and newData.tid and ItemDataUtils.GetItemConfigByField("Type", newData.tid) == Type_Weapon then
        mergeKey = newData.tid
      else
        mergeKey = string.format("%s_%s_%s_%s", newData.uid or newData.tid, newData.awardType or "", newData.extraDesc or "", newData.reason or "")
      end
      if not rewardUidMap[mergeKey] then
        rewardUidMap[mergeKey] = newData
      else
        local rewardData = rewardUidMap[mergeKey]
        rewardData.num = newData.num or 1
        if rewardData.changedNum and newData.changedNum then
          rewardData.changedNum = rewardData.changedNum + newData.changedNum
        end
      end
    end
  end
  for _, data in pairs(rewardUidMap) do
    table.insert(rst, data)
  end
  return rst
end

function ItemDataUtils.CommonItemSortFunc(a, b)
  local aTid = a.tid
  local bTid = b.tid
  local aConfig = ItemDataUtils.GetItemConfig(aTid)
  local bConfig = ItemDataUtils.GetItemConfig(bTid)
  local qualitySortA = DT.ItemQuality[aConfig.Quality].Sort
  local qualitySortB = DT.ItemQuality[bConfig.Quality].Sort
  if qualitySortA == qualitySortB then
    if aConfig.BaseSortID ~= bConfig.BaseSortID then
      return aConfig.BaseSortID < bConfig.BaseSortID
    end
    if aTid == bTid and a.changedNum and b.changedNum then
      return a.changedNum > b.changedNum
    end
    return aTid < bTid
  end
  return qualitySortA > qualitySortB
end

function ItemDataUtils.MovePlayerExpToEnd(list)
  if not list then
    return {}
  end
  local playerExpTid = CommonDefine.CurrencyType.PlayerExp
  local others = {}
  local expItems = {}
  for _, v in ipairs(list) do
    if v.tid == playerExpTid then
      table.insert(expItems, v)
    else
      table.insert(others, v)
    end
  end
  for _, v in ipairs(expItems) do
    table.insert(others, v)
  end
  return others
end

function ItemDataUtils.RemoveShowRewards(s, e)
  local tmpShowRewardList = table.deepclone(ItemDataUtils.GetShowRewardList())
  for i = #tmpShowRewardList, 1, -1 do
    if s <= i and e >= i then
      table.remove(tmpShowRewardList, i)
    end
  end
  ItemDataUtils.SetShowRewardList(tmpShowRewardList)
end

function ItemDataUtils.ClearShowRewards()
  ItemDataUtils.SetShowRewardList({})
end

function ItemDataUtils.PlayRewardPanelVoice()
  local AudioManager = require("Managers.AudioManager")
  AudioManager.Instance:PostSoundEvent("POPUP_CM_WIND_ACROSS_GETITEM_ON")
end

function ItemDataUtils.ShowRewardPanel(title, subTitle, list, closeCb, isBattleEnd, showStatisticsFirst)
  if ApplicationUtils.is_editor_mode() then
    print("Show Reward Panel", debug.traceback())
  end
  local SceneMgr = require("Managers.Scene.SceneMgr")
  local showRewardQueueTag = "QueueShowReward"
  if ItemDataUtils.CheckNeedShowRewardPanel(list) then
    if not ItemDataUtils.IsShowRewardPanelOpen() then
      if not SceneMgr.Instance:IsInBattle() or ItemDataUtils.IsVaildJumpReasonInBattle(list) then
        ItemDataUtils.AddShowRewards(list)
        if SceneMgr.Instance:IsInTown() then
          local curScene = SceneMgr.Instance:GetCurScene()
          assert(curScene, "ERROR: curScene为空")
          
          local function cb()
            UIManager.Instance:Reopen(Urls.ShowRewardPanel, title, subTitle, function()
              if closeCb then
                closeCb()
              end
              curScene:FinishQueue(showRewardQueueTag)
            end, isBattleEnd, showStatisticsFirst)
          end
          
          if curScene._town.queue:IsHave(showRewardQueueTag) and not ItemDataUtils.IsShowRewardPanelOpen() then
            Logger.Warn("ItemDataUtils.ShowRewardPanel queue slot leak detected, force releasing")
            curScene:FinishQueue(showRewardQueueTag)
          end
          if not curScene._town.queue:IsHave(showRewardQueueTag) then
            curScene:InsertQueue(showRewardQueueTag, cb)
          end
        else
          UIManager.Instance:Reopen(Urls.ShowRewardPanel, title, subTitle, closeCb, isBattleEnd, showStatisticsFirst)
        end
      end
    else
      local panelInstance = UIManager.Instance:GetWindow(Urls.ShowRewardPanel)
      local siblingIdx = panelInstance.ui.uiNode.transform:GetSiblingIndex()
      local childCount = panelInstance.ui.uiNode.transform.parent.childCount - 1
      if siblingIdx < childCount then
        panelInstance:SetClearRewardsTag(false)
        panelInstance:Close()
        if SceneMgr.Instance:IsInTown() then
          local curScene = SceneMgr.Instance:GetCurScene()
          if curScene and curScene._town.queue:IsHave(showRewardQueueTag) then
            curScene:FinishQueue(showRewardQueueTag)
          end
        end
        ItemDataUtils.ClearShowRewards()
        ItemDataUtils.AddShowRewards(list)
        UIManager.Instance:Reopen(Urls.ShowRewardPanel, title, subTitle, closeCb, isBattleEnd, showStatisticsFirst)
      else
        ItemDataUtils.AddShowRewards(list)
      end
    end
  end
end

function ItemDataUtils.CheckNeedShowRewardPanel(list)
  if not list or 0 == #list then
    return false
  end
  if ItemDataUtils.IsAllExpBonus(list) then
    return false
  end
  return true
end

function ItemDataUtils.IsAllExpBonus(list)
  local isAllExpBonus = #list > 0
  for _, data in ipairs(list) do
    if data.reason ~= cd.ItemReason.ExpBonus then
      return false
    end
  end
  return isAllExpBonus
end

function ItemDataUtils.IsShowRewardPanelOpen()
  return UIManager.Instance:GetWindow(Urls.ShowRewardPanel) ~= nil
end

function ItemDataUtils.IsSameQuality(itemCfg1, itemCfg2)
  return itemCfg1.Quality == itemCfg2.Quality
end

function ItemDataUtils.IsSeniorQuality(itemCfg1, itemCfg2)
  if not itemCfg1.Quality or not itemCfg2.Quality then
    return
  end
  return QualitySortID[itemCfg1.Quality] > QualitySortID[itemCfg2.Quality]
end

function ItemDataUtils.GetItemEndTimeByTid(itemTid)
  local itemConfig = ItemDataUtils.GetItemConfig(itemTid or 0)
  if not itemConfig then
    return
  end
  local isNotBackTrack = not itemConfig or not itemConfig.SubType or itemConfig.SubType ~= CommonDefine.ItemSubType.BackTrack
  local isExpiredItem = table.contains(CommonDefine.ExpiredItemTidList, itemTid)
  if isNotBackTrack and not isExpiredItem then
    return
  end
  local battlePassEndTime = BattlePassDataUtils.GetItemEndTs()
  local backTrackEndTime = BackTrackDataUtils.GetEndTime()
  local endTime = isExpiredItem and battlePassEndTime or backTrackEndTime
  return endTime
end

function ItemDataUtils.ShowItemDetailTips(binder, parentNode, uid, tid, banLock, extraData)
  ItemDetailsController.Instance:ShowItemDetailTips(parentNode, uid, tid, banLock, extraData)
end

function ItemDataUtils.ConstructWeaponItem(tid, exParams)
  local cfg = DT.Item[tid]
  local level = ItemDataUtils.GetItemDefaultLevel(tid)
  if exParams and exParams.potencyLv then
    level = exParams.potencyLv
  end
  if not cfg or not cfg.WeaponMainAttribute then
    return {
      tid = tid,
      uid = 1,
      mainAttr = {},
      subAttr = {},
      enhanceLevel = 1,
      breakLevel = 0,
      level = level
    }
  end
  local mainAttr = {}
  for idx = 1, #cfg.WeaponMainAttribute - 1, 2 do
    local id = cfg.WeaponMainAttribute[idx]
    local name = DT.ActorAttrType[id].Name
    local value = cfg.WeaponMainAttribute[idx + 1]
    mainAttr[name] = value
  end
  local subAttr = {}
  if cfg.WeaponSubAttribute then
    local id = cfg.WeaponSubAttribute[1]
    local name = DT.ActorAttrType[id].Name
    local value = cfg.WeaponSubAttribute[2]
    subAttr[name] = value
  end
  return {
    tid = tid,
    uid = 1,
    mainAttr = mainAttr,
    subAttr = subAttr,
    enhanceLevel = 1,
    breakLevel = 0,
    level = level
  }
end

function ItemDataUtils.GetName(configId, withColor)
  local config = ItemDataUtils.GetItemConfig(configId)
  if not config then
    return "config Not Found"
  end
  local name = LT.Text(config.Name)
  local itemQualityConfig = ItemDataUtils.GetItemQualityConfig(config.Quality)
  if withColor then
    assert(itemQualityConfig, string.format("item tid: %d, DT.ItemQuality[%s] is nil", configId, config.Quality))
    local color = itemQualityConfig.ItemNameColor
    name = string.format("<color=#%s>%s</color>", color, name)
  end
  return name
end

function ItemDataUtils.GetIcon(configId)
  configId = ItemDataUtils.GetGenderDifferenceRealItem(configId)
  local config = ItemDataUtils.GetItemConfig(configId)
  if not config then
    Logger.Info("找不到配置: %s", configId)
    return ""
  end
  return config.Icon
end

function ItemDataUtils.GetCommonItemBottomQualityFrame(cfg, blackBgObj)
  local qualityCfg = DT.ItemQuality[cfg.Quality]
  local rst = qualityCfg.WhiteBgBottomQualityFrame
  if blackBgObj.activeSelf then
    rst = qualityCfg.BlackBgBottomQualityFrame
  end
  return rst
end

function ItemDataUtils.GetItemGets(configId)
  local config = ItemDataUtils.GetItemConfig(configId)
  if not config then
    Logger.Info("找不到配置: %s", configId)
    return {}
  end
  return config.Gets or {}
end

function ItemDataUtils.GetQualityIcon(configId)
  local config = ItemDataUtils.GetItemConfig(configId)
  if not config then
    Logger.Info("找不到配置: %s", configId)
    return ""
  end
  local itemQualityConfig = ItemDataUtils.GetItemQualityConfig(config.Quality)
  return itemQualityConfig and itemQualityConfig.ItemQualityFrame
end

function ItemDataUtils.GetSmallIcon(configId)
  local config = ItemDataUtils.GetItemConfig(configId)
  if not config then
    return ""
  end
  if ItemDataUtils.IsCurrencyItem(configId) or config.Type == ItemType.Trinket or ItemType.Material then
    return config.SpIcon
  end
  return ""
end

function ItemDataUtils.GetSpIcon(configId)
  local config = ItemDataUtils.GetItemConfig(configId)
  if not config then
    return
  end
  return config.SpIcon
end

function ItemDataUtils.GetFastPromotionSpParamValByKey(itemSpParams, key)
  local rst
  for _, strVal in pairs(itemSpParams) do
    if string.find(strVal, key) then
      local index = string.find(strVal, ":")
      rst = string.sub(strVal, index + 1)
      break
    end
  end
  return rst
end

function ItemDataUtils.CheckFastPromotionAwakerLevelEffecting(awakerLevel, toLevel)
  return awakerLevel < toLevel
end

function ItemDataUtils.CheckFastPromotionAwakerSkillLevelEffecting(skills, toSkillLevel)
  local rst = false
  for index, skillData in ipairs(skills) do
    if index <= 6 then
      local skillCfg = DT.Skill[skillData.tid]
      local level = skillData.level
      if skillCfg and skillCfg.Slot ~= CommonDefine.TypeAwakerSkill and toSkillLevel > level then
        rst = true
        break
      end
    end
  end
  return rst
end

function ItemDataUtils.CheckFastPromotionAwakerBreakSkillEffecting(awakerData, toBreakLevel)
  local breakLevel = awakerData.currBreakthroughStar
  return toBreakLevel > breakLevel
end

function ItemDataUtils.CheckFastPromotionAwakerBreakThroughSkillLevel1Effecting(skills, toBreakSkillUnlock, skillIdx)
  local rst = false
  local skillData = skills[skillIdx]
  local unlock = skillData.lock and 0 or 1
  if skillData.isBreakthroughSkill and toBreakSkillUnlock > unlock then
    rst = true
  end
  return rst
end

function ItemDataUtils.GetItemLevelUpAwakerList(itemUid, isInsertCannotUse)
  local AwakerDataUtils = require("Data.AwakerDataUtils")
  local awakerList = {}
  local item = ItemDataUtils.GetItemByUid(itemUid)
  if item then
    local cfg = DT.Item[item.tid]
    local SpParam = cfg.SpParam or {}
    local availableAwakerId = ItemDataUtils.GetFastPromotionSpParamValByKey(SpParam, FastPromotionSpParamKey.AvailableAwaker)
    local toSkillLevel = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(SpParam, FastPromotionSpParamKey.DirectSkillPromotionLevel))
    local toBreakLevel = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(SpParam, FastPromotionSpParamKey.DirectBreakthroughStage))
    local toBreakSkillUnlock1 = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(SpParam, FastPromotionSpParamKey.BreakthroughSkill1Unlocked))
    local toBreakSkillUnlock2 = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(SpParam, FastPromotionSpParamKey.BreakthroughSkill2Unlocked))
    local toLevel = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(SpParam, FastPromotionSpParamKey.DirectPromotionLevel))
    for tid, awakerData in pairs(DataCenter.awakerData.awakerMap) do
      local isMatch = false
      if not availableAwakerId then
        isMatch = false
      elseif "AllAwaker" == availableAwakerId then
        isMatch = true
      elseif tonumber(availableAwakerId) == tid then
        isMatch = true
      end
      if AwakerDataUtils.HasOwnedAwaker(tid) and isMatch and AwakerDataUtils.IsAwakerShow(tid) then
        local isCanUse = false
        if ItemDataUtils.CheckFastPromotionAwakerLevelEffecting(awakerData.level, toLevel) then
          isCanUse = true
        end
        if toSkillLevel and ItemDataUtils.CheckFastPromotionAwakerSkillLevelEffecting(awakerData.skills, toSkillLevel) then
          isCanUse = true
        end
        if toBreakLevel and ItemDataUtils.CheckFastPromotionAwakerBreakSkillEffecting(awakerData, toBreakLevel) then
          isCanUse = true
        end
        if toBreakSkillUnlock1 and ItemDataUtils.CheckFastPromotionAwakerBreakThroughSkillLevel1Effecting(awakerData.skills, toBreakSkillUnlock1, AWAKER_BREAKTHROUGH_SKILL_1_IDX) then
          isCanUse = true
        end
        if toBreakSkillUnlock2 and ItemDataUtils.CheckFastPromotionAwakerBreakThroughSkillLevel1Effecting(awakerData.skills, toBreakSkillUnlock2, AWAKER_BREAKTHROUGH_SKILL_2_IDX) then
          isCanUse = true
        end
        local isInsert = isCanUse or isInsertCannotUse
        if isInsert then
          table.insert(awakerList, {
            awakerData = awakerData,
            awakerCfg = DT.AwakerConfig[tid],
            qualitySort = AwakerDataUtils.GetQualitySort(tid),
            isCanUse = isCanUse
          })
        end
      end
    end
  end
  return awakerList
end

function ItemDataUtils.GetItemQualityStar(tid)
  if not tid then
    Logger.Info("Error: GetItemQualityStar.tid => ", 0)
    return 0
  end
  local config = ItemDataUtils.GetItemConfig(tid)
  if not config then
    Logger.Info("Error: GetItemQualityStar.config => nil")
    return 0
  end
  local qualityConfig = ItemDataUtils.GetItemQualityConfig(config.Quality)
  if not qualityConfig then
    Logger.Info("Error: GetItemQualityStar.qualityConfig => nil, quality:", tostring(config.Quality))
    return 0
  end
  return qualityConfig.Sort
end

function ItemDataUtils.GetWeaponIconPath()
  local path = DT.GetConstant("ItemType_Weapon_SmallIcon")
  return path
end

ItemDataUtils.QualityIconMap = nil

function ItemDataUtils.GetQualityIconPath(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "ItemDataUtils.GetQualityIconPath failed: tid -> " .. tid)
  if ItemDataUtils.QualityIconMap then
    return ItemDataUtils.QualityIconMap[config.Quality]
  end
  ItemDataUtils.QualityIconMap = {
    Blue = DT.GetConstant("Quality_R_Icon"),
    Purple = DT.GetConstant("Quality_SR_Icon"),
    Orange = DT.GetConstant("Quality_SSR_Icon")
  }
  return ItemDataUtils.QualityIconMap[config.Quality]
end

function ItemDataUtils.GetQualityFramePath(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "找不到配置:" .. tostring(tid))
  local qualityConfig = ItemDataUtils.GetItemQualityConfig(config.Quality)
  assert(nil ~= qualityConfig, "找不到配置:" .. tostring(config.Quality))
  return qualityConfig.ItemQualityFrame or ""
end

function ItemDataUtils.GetItemQualityConfig(quality)
  if not quality then
    return
  end
  return DT.ItemQuality[quality]
end

function ItemDataUtils.GetQualityFramePathByQuality(quality)
  if not quality then
    return
  end
  local config = ItemDataUtils.GetItemQualityConfig(quality)
  return config.ItemQualityFrame
end

function ItemDataUtils.GetTeamFramePathByQuality(quality)
  if not quality then
    return
  end
  local config = ItemDataUtils.GetItemQualityConfig(quality)
  return config.TeamFrame
end

function ItemDataUtils.GetTitleQualityFramePath(tid, uid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "找不到配置:" .. tostring(tid))
  if uid and AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) then
    local boundQualityConfig = ItemDataUtils.GetItemQualityConfig(BoundTrinketTipsQuality)
    return boundQualityConfig and boundQualityConfig.TipsTitleFrame or ""
  end
  local qualityConfig = ItemDataUtils.GetItemQualityConfig(config.Quality)
  assert(nil ~= qualityConfig, "找不到配置:" .. tostring(config.Quality))
  return qualityConfig.TipsTitleFrame or ""
end

function ItemDataUtils.GetBgQualityFramePath(tid, uid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "找不到配置:" .. tostring(tid))
  if uid and AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) then
    local boundQualityConfig = ItemDataUtils.GetItemQualityConfig(BoundTrinketTipsQuality)
    return boundQualityConfig and boundQualityConfig.TipsTypeFrame or ""
  end
  local qualityConfig = ItemDataUtils.GetItemQualityConfig(config.Quality)
  assert(nil ~= qualityConfig, "找不到配置:" .. tostring(config.Quality))
  return qualityConfig.TipsTypeFrame or ""
end

function ItemDataUtils.IsBoundTrinketTips(uid)
  if not uid then
    return false
  end
  return AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) ~= nil
end

function ItemDataUtils.GetKeeperSkillItemConfig(skillTid)
  if not skillTid then
    return
  end
  return DT.Skill[skillTid]
end

function ItemDataUtils.GetKeeperSkillIconPath(tid)
  local itemType = ItemDataUtils.GetItemType(tid)
  local isKeeperSkill = itemType == ItemType.KeeperSkill
  if not isKeeperSkill then
    return ""
  end
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "找不到配置:" .. tostring(tid))
  local keeperSkill = config.SpParam and config.SpParam[1]
  keeperSkill = keeperSkill or config.PVPSkill and config.PVPSkill[1]
  assert(keeperSkill, "钥令没有配置技能:" .. config.Name)
  local keeperSkillConfig = ItemDataUtils.GetKeeperSkillItemConfig(keeperSkill)
  assert(nil ~= keeperSkillConfig, "找不到钥令技能配置:" .. keeperSkill)
  return keeperSkillConfig.Icon or ""
end

function ItemDataUtils.GetKeeperSkillName(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  local skillId = config.SpParam and config.SpParam[1]
  skillId = skillId or config.PVPSkill and config.PVPSkill[1]
  do return KeeperSkillUtils.GetSkillName end
  return KeeperSkillUtils.GetSkillName, skillId
end

function ItemDataUtils.GetKeeperSkillDesc(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "找不到配置:" .. tostring(tid))
  local keeperSkill = config.SpParam and config.SpParam[1]
  keeperSkill = keeperSkill or config.PVPSkill and config.PVPSkill[1]
  return KeeperSkillUtils.GetKeeperSkillDesc(keeperSkill) or ""
end

function ItemDataUtils.GetKeeperSkillStoryDesc(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "找不到配置:" .. tostring(tid))
  return config.StoryDesc or ""
end

function ItemDataUtils.ReqEquipItemDatas()
  ProtoManager.Instance:ReqServer("TrinketRequest", "OnShowTrinket", function(data)
    Logger.Info(">>>>>> equip item datas:", table.tostring(data))
    for _, equipData in ipairs(data) do
      DataCenter.itemData.EquipItemDataMap[equipData.eid] = equipData
    end
  end, function(data)
    Logger.Info(">>>>>> 装备道具请求失败:", table.tostring(data))
  end)
end

function ItemDataUtils.ReqWeaponItemDatas()
  ProtoManager.Instance:ReqServer("GameRequest", "OnShowWeapon", function(data)
    Logger.Info(">>>>>> weapon item datas:", table.tostring(data))
  end, function(data)
    Logger.Info(">>>>>> 武器道具请求失败:", table.tostring(data))
  end)
end

function ItemDataUtils.ReqCalWeaponAttr(tid, level, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnCalWeaponAttr", function(data)
    Logger.Info("ReqCalWeaponAttr Successful", table.tostring(data))
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("ReqCalWeaponAttr Failed", table.tostring(data))
  end, tid, level)
end

function ItemDataUtils.ReqOnUseItem(itemTid, num, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnUseItem", function(data)
    Logger.Info("ReqOnUseItem Successful")
    if callback then
      callback(data)
    end
  end, function(data)
    Logger.Info("ReqOnUseItem Failed")
  end, itemTid, num)
end

function ItemDataUtils.UpdateEuqipData(eid, data)
  local equip = DataCenter.itemData.EquipItemDataMap[eid]
  if not equip then
    DataCenter.itemData.EquipItemDataMap[eid] = table.deepclone(data)
    return
  end
  for k, v in pairs(data) do
    if "attrs" == k then
      for attrId, attrVal in pairs(v) do
        equip[k][attrId] = attrVal
      end
    else
      equip[k] = v
    end
  end
end

function ItemDataUtils.GetEquipItemDataMap()
  return DataCenter.itemData.EquipItemDataMap
end

function ItemDataUtils.GetEquipItemDataList(hideEquipped, filterMap)
  local equipsMap = ItemDataUtils.GetEquipItemDataMap()
  local list = {}
  for _, data in pairs(equipsMap) do
    if not data then
    elseif hideEquipped and 0 ~= data.awaker then
    elseif filterMap and filterMap[data.eid] then
    else
      tableInsert(list, data)
    end
  end
  return list
end

function ItemDataUtils.GetWeaponList()
  local list = {}
  local TypeWeapon = CommonDefine.ItemType.Weapon
  for _, v in pairs(DataCenter.itemData.BagItemData) do
    local config = ItemDataUtils.GetItemConfig(v.tid)
    if config.Type == TypeWeapon then
      table.insert(list, v)
    end
  end
  return list
end

function ItemDataUtils.GetItemLevel(uid, type)
  if type == CommonDefine.ItemType.Weapon then
    do return ItemDataUtils.GetWeaponLevel end
    return ItemDataUtils.GetWeaponLevel, uid
  elseif type == CommonDefine.ItemType.Trinket then
    do return ItemDataUtils.GetTrinketLevel end
    return ItemDataUtils.GetTrinketLevel, uid
  end
  return 0
end

function ItemDataUtils.GetWeaponLevel(uid)
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    Logger.Info(string.format("找不到道具uid: %s(可能被黑池回收了)", uid), debug.traceback())
    return 0
  end
  local config = DT.Item[itemData.tid]
  if not config then
    Logger.Info("找不到道具tid:", itemData.tid, debug.traceback())
    return 0
  end
  local level = itemData.level
  if nil == level then
    level = config.Quality == "White" and 0 or 1
  end
  return level
end

function ItemDataUtils.GetTrinketLevel(uid)
  local itemData = ItemDataUtils.GetItemByUid(uid)
  return itemData and itemData.level or 0
end

function ItemDataUtils.GetItemAttrValByAttrName(itemUid, attrName)
  local itemData = ItemDataUtils.GetItemByUid(itemUid)
  if not itemData or not itemData.attrs then
    return 0
  end
  for _, attrData in pairs(itemData.attrs) do
    local attrCfg = DT.ActorAttrType[attrData.attrId]
    if attrCfg.Name == attrName then
      return attrData.val
    end
  end
  return 0
end

function ItemDataUtils.GetWeaponAttrName(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  if nil == config or nil == config.SpParam then
    return ""
  end
  local attrId = config.SpParam[1]
  local attrConfig = DT.ActorAttrType[attrId]
  do return LT.Text end
  return LT.Text, attrConfig.Text
end

function ItemDataUtils.GetWeaponAttrValue(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  if nil == config or nil == config.SpParam then
    return ""
  end
  local attrId = config.SpParam[1]
  local attrConfig = DT.ActorAttrType[attrId]
  local value = config.SpParam[2]
  if attrConfig.Percentage then
    value = value .. "%"
  end
  return value
end

function ItemDataUtils.GetWeaponAttrNum(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  if nil == config or nil == config.WeaponSubAttribute then
    return 0
  end
  local attrId = config.WeaponSubAttribute[1]
  local value = config.WeaponSubAttribute[2]
  return value, attrId
end

function ItemDataUtils.GetItemOwner(uid)
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    Logger.Info("找不到数据:", uid)
    return 0
  end
  local itemType = ItemDataUtils.GetItemType(itemData.tid)
  if itemType ~= ItemType.Weapon and itemType ~= ItemType.Trinket then
    return nil
  end
  return itemData.awaker
end

function ItemDataUtils.GetItemLocked(uid)
  if not uid or 0 == uid then
    return false
  end
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    Logger.Info("找不到数据:", uid)
    return false
  end
  local itemType = ItemDataUtils.GetItemType(itemData.tid)
  if itemType == ItemType.Weapon then
    return false
  end
  if itemType ~= ItemType.Trinket then
    return false
  end
  return itemData.locked
end

function ItemDataUtils.UpdateEquipableGoodWeaponMap(weapon)
  if not weapon then
    return
  end
  local QualityWhite = CommonDefine.CommonQuality.White
  local config = ItemDataUtils.GetItemConfig(weapon.tid)
  if not config or config.Quality == QualityWhite then
    return
  end
  if weapon.num <= 0 or weapon.awaker and weapon.awaker > 0 then
    if DataCenter.itemData.EquipableGoodWeaponMap[weapon.uid] then
      DataCenter.itemData.EquipableGoodWeaponMap[weapon.uid] = nil
    end
  else
    DataCenter.itemData.EquipableGoodWeaponMap[weapon.uid] = weapon
  end
end

function ItemDataUtils.HasEquipableGoodWeapon()
  return table.next(DataCenter.itemData.EquipableGoodWeaponMap) ~= nil
end

function ItemDataUtils.GetEquipableGoodWeaponMap()
  return DataCenter.itemData.EquipableGoodWeaponMap
end

ItemDataUtils.TrinketPosMap = {
  I = 1,
  II = 2,
  III = 3,
  IV = 4,
  V = 5,
  VI = 6
}

function ItemDataUtils.GetTrinketPosIndex(trinket)
  if not trinket then
    return
  end
  local trinketInfo = ItemDataUtils.GetTrinketInfoByItemTid(trinket.tid)
  if not trinketInfo then
    return
  end
  local pos = trinketInfo[1]
  pos = ItemDataUtils.TrinketPosMap[pos]
  return pos
end

function ItemDataUtils.AddTrinketToPosMap(trinket)
  if not trinket then
    return
  end
  local pos = ItemDataUtils.GetTrinketPosIndex(trinket)
  if not DataCenter.itemData.TrinketPosMap[pos] then
    DataCenter.itemData.TrinketPosMap[pos] = {}
  end
  local data = DataCenter.itemData.TrinketPosMap[pos][trinket.uid]
  if data then
    for k, v in pairs(trinket) do
      data[k] = v
    end
    return
  end
  DataCenter.itemData.TrinketPosMap[pos][trinket.uid] = trinket
end

function ItemDataUtils.RemoveTrinketFromPosMap(trinket)
  if not trinket then
    return
  end
  local pos = ItemDataUtils.GetTrinketPosIndex(trinket)
  if not DataCenter.itemData.TrinketPosMap[pos] then
    return
  end
  local data = DataCenter.itemData.TrinketPosMap[pos][trinket.uid]
  if data then
    DataCenter.itemData.TrinketPosMap[pos][trinket.uid] = nil
  end
end

function ItemDataUtils.UpdateTrinketSuitNumMap(trinket, updateNum)
  if not trinket or not updateNum then
    return
  end
  local suitId = trinket.suitId
  if not DataCenter.itemData.TrinketSuitNumMap[suitId] then
    DataCenter.itemData.TrinketSuitNumMap[suitId] = 0
  end
  if DataCenter.itemData.TrinketSuitNumMap[suitId] + updateNum < 0 then
    DataCenter.itemData.TrinketSuitNumMap[suitId] = 0
  end
  DataCenter.itemData.TrinketSuitNumMap[suitId] = DataCenter.itemData.TrinketSuitNumMap[suitId] + updateNum
end

function ItemDataUtils.GetTrinketSuitNumMap()
  return DataCenter.itemData.TrinketSuitNumMap
end

function ItemDataUtils.GetSuitItemNum(suitId)
  if not suitId then
    return 0
  end
  return DataCenter.itemData.TrinketSuitNumMap[suitId] or 0
end

function ItemDataUtils.GetTrinketMapByPos(pos)
  if not pos then
    return
  end
  return DataCenter.itemData.TrinketPosMap[pos] or {}
end

function ItemDataUtils.TrinketShowTimeMatch(suitId)
  local curTime = math.floor(TimeUtils.GetServerTime())
  local own = ItemDataUtils.GetSuitItemNum(suitId) > 0
  local config = DT.TrinketSuitEffect[suitId]
  local canShow = config.SuitDisplayDate and curTime >= config.SuitDisplayDate
  canShow = nil == canShow and true or canShow
  local result = own or canShow
  return result
end

function ItemDataUtils.GetItemConfig(tid)
  return DT.Item[tid]
end

function ItemDataUtils.GetItemConfigByField(field, tid)
  if not field or not tid then
    return nil
  end
  local cfg = ItemDataUtils.GetItemConfig(tid)
  if not cfg then
    return nil
  end
  return cfg[field]
end

function ItemDataUtils.GetItemOverflowConfig(tid)
  return DT.ItemOverflow[tid]
end

function ItemDataUtils.GetItemDefaultLevel(tid)
  local itemCfg = DT.Item[tid or 0]
  if itemCfg and itemCfg.Type == cd.ItemType.Weapon then
    return itemCfg.SpParam and itemCfg.SpParam[1] or 0
  end
  return 0
end

function ItemDataUtils.GetAwakerTidByItemTid(tid)
  if not tid then
    return
  end
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "config is nil:" .. tid)
  if config.Type == CommonDefine.ItemType.SkinItem then
    do return AwakerSkinUtils.GetAwakerTidBySkin end
    return AwakerSkinUtils.GetAwakerTidBySkin, tid, "config is nil:" .. tid, tid
  end
  if config.Type ~= CommonDefine.ItemType.AwakerItem and config.SubType ~= CommonDefine.ItemSubType.AwakerChip then
    return
  end
  return config.SpParam and config.SpParam[1]
end

function ItemDataUtils.GetTrinketInfoByItemTid(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "config is nil:" .. tid)
  if config.Type ~= CommonDefine.ItemType.Trinket then
    return
  end
  return config.SpParam
end

function ItemDataUtils.GetTrinketDropItemSuit(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  if not config then
    return
  end
  if config.Type == CommonDefine.ItemType.DropItem and config.SubType == CommonDefine.ItemSubType.TrinketDropItem then
    return config.TrinketDropItemSuit
  end
end

local trinketDropItemSuit2TidCache

function ItemDataUtils.GetTrinketDropItemTidBySuit(suitId)
  if not suitId or 0 == suitId then
    return nil
  end
  if not trinketDropItemSuit2TidCache then
    trinketDropItemSuit2TidCache = {}
    for itemTid, cfg in pairs(DT.Item) do
      if cfg.Type == CommonDefine.ItemType.DropItem and cfg.SubType == CommonDefine.ItemSubType.TrinketDropItem and cfg.TrinketDropItemSuit then
        local existTid = trinketDropItemSuit2TidCache[cfg.TrinketDropItemSuit]
        local existCfg = existTid and DT.Item[existTid] or nil
        if not existCfg or cfg.BaseSortID < existCfg.BaseSortID then
          trinketDropItemSuit2TidCache[cfg.TrinketDropItemSuit] = itemTid
        end
      end
    end
  end
  return trinketDropItemSuit2TidCache[suitId]
end

function ItemDataUtils.GetItemDesc(itemTid)
  itemTid = ItemDataUtils.GetGenderDifferenceRealItem(itemTid)
  do return ItemDispatchManager.Instance.GetItemDesc, ItemDispatchManager.Instance end
  return ItemDispatchManager.Instance.GetItemDesc, ItemDispatchManager.Instance, itemTid
end

function ItemDataUtils.GetItemIcon(itemTid)
  itemTid = ItemDataUtils.GetGenderDifferenceRealItem(itemTid)
  do return ItemDispatchManager.Instance.GetItemIcon, ItemDispatchManager.Instance end
  return ItemDispatchManager.Instance.GetItemIcon, ItemDispatchManager.Instance, itemTid
end

function ItemDataUtils.GetAvatarIcon(itemTid)
  if itemTid and ItemDataUtils.IsAvatarItem(itemTid) and PlayerDataUtils.IsInAprileFool() then
    local replacementTid = PlayerDataUtils.GetAprileFoolReplaceItem()
    if replacementTid and ItemDataUtils.IsAvatarItem(replacementTid) then
      itemTid = replacementTid
    end
  end
  do return ItemDispatchManager.Instance.GetItemIcon, ItemDispatchManager.Instance end
  return ItemDispatchManager.Instance.GetItemIcon, ItemDispatchManager.Instance, itemTid
end

local Gender2ParamIdxMap = {
  [CommonDefine.GenderString.Gender_Boy] = 1,
  [CommonDefine.GenderString.Gender_Girl] = 2
}

function ItemDataUtils.GetGenderDifferenceRealItem(itemTid)
  local cfg = DT.Item[itemTid] or {}
  if not (cfg.Type and cfg.SubType) or cfg.Type ~= ItemType.Special or cfg.SubType ~= ItemSubType.GenderDifference then
    return itemTid
  end
  local genderCfg = GenderDataUtils.GetGenderCfgByRoleData() or {}
  local paramIdx = Gender2ParamIdxMap[genderCfg.Gender or CommonDefine.GenderString.Gender_Boy] or 1
  return cfg.SpParam[paramIdx]
end

function ItemDataUtils.GetItemNumText(needNum, currNum)
  if not needNum or not currNum then
    return ""
  end
  local currNumText = currNum
  local notEnough = currNum < needNum
  if notEnough then
    currNumText = string.format("<Color4:%d>", currNum)
  end
  do return string.format, "%s/%s", currNumText end
  return string.format, "%s/%s", currNumText, needNum
end

function ItemDataUtils.GetItemSubTypeName(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "找不到物品配置:" .. tid)
  if not config.SubType then
    return ""
  end
  local itemTagId = config.ItemTag
  return DT.ItemTag[itemTagId].Name or ""
end

function ItemDataUtils.GetItemType(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "找不到物品配置:" .. tid)
  return config.Type
end

function ItemDataUtils.GetItemTypeByUid(uid)
  local itemData = ItemDataUtils.GetItemByUid(uid) or {}
  local tid = itemData.tid
  if not tid then
    return nil
  end
  do return ItemDataUtils.GetItemType end
  return ItemDataUtils.GetItemType, tid
end

function ItemDataUtils.GetQuality(tid)
  do return ItemDataUtils.GetItemConfigByField, "Quality" end
  return ItemDataUtils.GetItemConfigByField, "Quality", tid
end

function ItemDataUtils.GetQualitySortValue(tid)
  local quality = ItemDataUtils.GetQuality(tid)
  return quality and cd.QualitySortValueTable[quality] or 0
end

function ItemDataUtils.GetTrinketLevelByUid(uid)
  local itemData = ItemDataUtils.GetItemByUid(uid)
  if not itemData then
    Logger.Info("找不到数据:", uid)
    return 0
  end
  local itemType = ItemDataUtils.GetItemType(itemData.tid)
  if itemType ~= ItemType.Trinket then
    return 0
  end
  return itemData.level or 0
end

function ItemDataUtils.GetItemSubType(tid)
  local config = ItemDataUtils.GetItemConfig(tid)
  assert(nil ~= config, "找不到物品配置:" .. tid)
  return config.SubType
end

function ItemDataUtils.IsCurrencyItem(tid)
  local itemType = ItemDataUtils.GetItemType(tid)
  return itemType == CommonDefine.ItemType.TopBarItem or itemType == CommonDefine.ItemType.Energy
end

function ItemDataUtils.IsAwakerChip(tid)
  local subType = ItemDataUtils.GetItemSubType(tid)
  return "AwakerChip" == subType
end

function ItemDataUtils.IsAwakerChipOverFlow(tid)
  if not ItemCfgUtils.IsAwakerChip(tid) then
    return false
  end
  return ItemDataUtils.GetAwakerChipRemainOwnedNum(tid) <= 0
end

function ItemDataUtils.GetAwakerChipRemainOwnedNum(tid)
  if not ItemCfgUtils.IsAwakerChip(tid) then
    return 0
  end
  local itemCfg = ItemCfgUtils.GetCfg(tid)
  if not itemCfg then
    return 0
  end
  local awakerTid = itemCfg.SpParam[1]
  if not awakerTid then
    return 0
  end
  local awakerChipTid
  if itemSubType == ItemSubType.AwakerChip then
    awakerChipTid = itemTid
  else
    awakerChipTid = DT.AwakerConfig[awakerTid].AwakerSpecialItem
  end
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local awakerChipNum = ItemDataUtils.GetItemNum(awakerChipTid)
  local awakerPotencyLevel = awakerData and AwakerDataUtils.GetAwakerPotencyIndex(awakerTid, awakerData.potency) or 0
  local chipMaxOwnedNum = DT.GetConstant("AwakerChipMaxOwnedNum")
  do return math.max, chipMaxOwnedNum - (awakerChipNum + awakerPotencyLevel) end
  return math.max, chipMaxOwnedNum - (awakerChipNum + awakerPotencyLevel), 0
end

function ItemDataUtils.IsItemsForChoose(tid)
  local itemCfg = DT.Item[tid]
  if itemCfg.Type == ItemType.Special and itemCfg.SubType == ItemSubType.Chest then
    local dropCfg = DT.Drop[itemCfg.SpParam[1]]
    return dropCfg.data_list[1].Type == "Choose"
  elseif itemCfg.Type == ItemType.Special and itemCfg.SubType == ItemSubType.AwakerChipChest then
    local dropCfg = DT.Drop[itemCfg.SpParam[1]]
    return dropCfg.data_list[1].Type == "Choose"
  end
  return false
end

function ItemDataUtils.IsResonanceParticle(tid)
  local subType = ItemDataUtils.GetItemSubType(tid)
  return subType == ItemSubType.ResonanceParticle
end

function ItemDataUtils.GetItemStory(tid)
  if not tid or 0 == tid then
    return ""
  end
  local config = ItemDataUtils.GetItemConfig(tid)
  local story = config and config.StoryDesc and LT.Text(config.StoryDesc) or ""
  return story
end

function ItemDataUtils.GetWeaponCountInfo()
  local info = {}
  local cnt = 0
  for _, item in pairs(DT.Item) do
    if item.Type == CommonDefine.ItemType.Weapon then
      local num = ItemDataUtils.GetItemNum(item.ID)
      info[item.ID] = num
      cnt = cnt + num
    end
  end
  return info, cnt
end

function ItemDataUtils.GetWeaponOwnedDisplayText(tid)
  local refineSum = ItemDataUtils.GetWeaponAllRefineLevelByTid(tid)
  if refineSum <= 0 then
    do return LT.Text end
    return LT.Text, "NotOwned", nil
  end
  do return LT.Textf, "OwnedCount" end
  return LT.Textf, "OwnedCount", refineSum
end

function ItemDataUtils.GetTrinketCount()
  local cnt = 0
  local targetDataGroup = DataCenter.itemData.BagItemData
  if table.next(DataCenter.itemData.MockItemData) then
    targetDataGroup = DataCenter.itemData.MockItemData
  end
  for _, v in pairs(targetDataGroup) do
    if v then
      local config = DT.Item[v.tid]
      if config.Type == ItemType.Trinket then
        local item = ItemDataUtils.GetItemByUid(v.uid)
        if item then
          cnt = cnt + item.num
        end
      end
    end
  end
  return cnt
end

function ItemDataUtils.KickoutAwakerFavorItem(items)
  local isArr = table.isarray(items)
  local awakerFavor = {}
  local TYPE_AWAKER_FAVAOR = CommonDefine.ItemType.AwakerFavor
  local DtItem = DT.Item
  
  local function isAwakerFavor(k, v)
    local itemCfg
    if type(v) == "table" then
      itemCfg = DtItem[v.tid or v.id] or {}
    else
      itemCfg = DtItem[k] or DtItem[v] or {}
    end
    return itemCfg.Type == TYPE_AWAKER_FAVAOR
  end
  
  if isArr then
    for i = #items, 1, -1 do
      if isAwakerFavor(i, items[i]) then
        table.insert(awakerFavor, items[i])
        table.remove(items, i)
      end
    end
  else
    for k, v in pairs(table.clone(items)) do
      if isAwakerFavor(k, v) then
        awakerFavor[k] = v
        items[k] = v
      end
    end
  end
  return items, awakerFavor
end

function ItemDataUtils.ItemListToDict(list)
  local dict = {}
  for i = 1, #list, 2 do
    local id = list[i]
    local count = list[i + 1]
    dict[id] = count
  end
  return dict
end

function ItemDataUtils.ShowItemGain(items, closeCallback, titleKey)
  local showTitleKey = "ItemGain_String_MainTitle"
  if titleKey then
    showTitleKey = titleKey
  end
  ItemDataUtils.ShowRewardPanel(LT.Text(showTitleKey), "", items, closeCallback)
end

function ItemDataUtils.GetWeaponSecAttr(weapon)
  if not weapon.tid then
    return {}
  end
  local config = ItemDataUtils.GetItemConfig(weapon.tid)
  if nil == config or nil == config.WeaponSubAttribute then
    return {}
  end
  local attrId = config.WeaponSubAttribute[1]
  if weapon.attrs then
    for _, v in pairs(weapon.attrs) do
      if v.attrId == attrId then
        return {
          id = attrId,
          value = v.val
        }
      end
    end
  else
    local value, attrId = ItemDataUtils.GetWeaponAttrNum(weapon.tid)
    return {
      id = attrId or 0,
      value = value
    }
  end
  return {}
end

function ItemDataUtils.RemoveDotZero(value)
  local i, f = math.modf(value)
  if 0 == f then
    return i
  else
    return value
  end
end

function ItemDataUtils.IsSpecificOnceRedItem(itemTid)
  local specificItemList = DT.GetOriginalConstant("BagOnceReddotItemList")
  if ItemDataUtils.__SpecificOnceRedItem then
    return ItemDataUtils.__SpecificOnceRedItem[itemTid]
  end
  ItemDataUtils.__SpecificOnceRedItem = {}
  if not specificItemList or table.next(specificItemList) == nil then
    return false
  end
  for _, tid in ipairs(specificItemList) do
    ItemDataUtils.__SpecificOnceRedItem[tid] = true
  end
  return ItemDataUtils.__SpecificOnceRedItem[itemTid]
end

function ItemDataUtils.IsAvatarItem(itemTid)
  local itemCfg = ItemDataUtils.GetItemConfig(itemTid)
  if not itemCfg then
    return false
  end
  local itemType, subItemType = itemCfg.Type, itemCfg.SubType
  return itemType == ItemType.Special and subItemType == ItemSubType.PlayerAvatar
end

function ItemDataUtils.IsEmojiItem(itemTid)
  local itemType = ItemDataUtils.GetItemType(itemTid)
  local subItemType = ItemDataUtils.GetItemSubType(itemTid)
  return itemType == ItemType.Special and subItemType == ItemSubType.Emoji
end

function ItemDataUtils.IsMaterialItem(itemTid)
  local itemType = ItemDataUtils.GetItemType(itemTid)
  return itemType == ItemType.Material
end

function ItemDataUtils.IsBagSpecialItem(itemTid)
  local itemType = ItemDataUtils.GetItemType(itemTid)
  local subItemType = ItemDataUtils.GetItemSubType(itemTid)
  return itemType == ItemType.Special and not table.contains(notInSpecialBagSubTypeGroup, subItemType)
end

function ItemDataUtils.IsShowRefineBtn(itemUid)
  local itemData = ItemDataUtils.GetItemByUid(itemUid)
  local itemType = ItemCfgUtils.GetCfgField("Type", itemData and itemData.tid)
  if itemType ~= ItemType.Weapon then
    return false
  end
  if ItemDataUtils.IsMaxLevelWeapon(itemUid) then
    return false
  end
  if ItemDataUtils.GetItemNum(NeedInheritConsumeItems) > 0 then
    return true
  end
  local uidMap = ItemDataUtils.GetItemUidMap(itemData.tid) or {}
  return table.length(uidMap) > 1
end

function ItemDataUtils.SetSkillIdsMap()
  DataCenter.itemData.keeperSkillIds = {}
  for _, item in pairs(DT.Item) do
    if item.PVPSkill and item.Type == "KeeperSkill" then
      local ultiSkillId = item.PVPSkill[1]
      DataCenter.itemData.keeperSkillIds[ultiSkillId] = item.ID
    end
  end
end

function ItemDataUtils.CheckItemTidsContainType(itemTids, itemType)
  if not itemTids or type(itemTids) ~= "table" or not itemType then
    return false
  end
  for _, tid in pairs(itemTids) do
    local itemCfg = DT.Item[tid]
    if itemCfg and itemCfg.Type == itemType then
      return true
    end
  end
  return false
end

function ItemDataUtils.IsPlayerHasKeeperSkill(skillId)
  if not DataCenter.itemData.keeperSkillIds then
    ItemDataUtils.SetSkillIdsMap()
  end
  if DataCenter.itemData.keeperSkillIds then
    local itemId = DataCenter.itemData.keeperSkillIds[skillId]
    if nil == itemId or not table.contains(DT.Skill[skillId].Type, "Card_KeeperSkill") then
      return
    end
    do return ItemDataUtils.GetItemByTid end
    return ItemDataUtils.GetItemByTid, itemId, "Card_KeeperSkill"
  end
end

function ItemDataUtils.IsItemNew(uid)
  if not uid or 0 == uid then
    return false
  end
  local redData = RedPointDataUtils.GetRedDataByTid(RedPointDataUtils.RedType.Item, uid)
  if nil == redData then
    return false
  end
  return 1 == redData.isNew
end

function ItemDataUtils.ReqRemoveNew(uid)
  local isNew = ItemDataUtils.IsItemNew(uid)
  if not isNew then
    return
  end
  RedPointDataUtils.ReqRemoveData(RedPointDataUtils.RedType.Item, RedPointDataUtils.RedAttrType.IsNew, uid)
end

function ItemDataUtils.CheckStageGroupUnlockedItemOverLimit(willObtainNum)
  willObtainNum = willObtainNum or 0
  local unlockItemTid = DT.GetConstant("KeysItemIndex")
  local itemInfoArr = DT.GetOriginalConstant("MaximumNumberOfKeysHeld")
  local ownNumLimit = itemInfoArr and itemInfoArr[2] or 0
  local ownNum = ItemDataUtils.GetItemNum(unlockItemTid) or 0
  local total = ownNum + willObtainNum
  return ownNumLimit < total
end

function ItemDataUtils.GetStageGroupUnlockItemName()
  local unlockItemTid = DT.GetConstant("KeysItemIndex")
  do return ItemDataUtils.GetItemName end
  return ItemDataUtils.GetItemName, unlockItemTid
end

function ItemDataUtils.GetWeaponQualityLarge(weaponUid)
  if weaponUid and 0 ~= weaponUid then
    local weapon = ItemDataUtils.GetItemByUid(weaponUid)
    if weapon then
      local weaponCfg = DT.Item[weapon.tid]
      local qualityCfg = DT.ItemQuality[weaponCfg.Quality]
      return qualityCfg.PaitingFrame
    else
      return ""
    end
  else
    return ""
  end
end

function ItemDataUtils.GetWeaponSecondaryAttr(weaponUid)
  if weaponUid and 0 ~= weaponUid then
    local weapon = ItemDataUtils.GetItemByUid(weaponUid)
    if weapon then
      do return ItemDataUtils.GetWeaponSecAttr end
      return ItemDataUtils.GetWeaponSecAttr, weapon
    else
      do return ItemDataUtils.GetWeaponSecAttr end
      return ItemDataUtils.GetWeaponSecAttr, {}
    end
  else
    do return ItemDataUtils.GetWeaponSecAttr end
    return ItemDataUtils.GetWeaponSecAttr, {}, {}
  end
end

function ItemDataUtils.GetLockTips(slotType)
  local tips = ""
  if slotType == CommonDefine.WeaponSlotType.Primary then
    tips = PlayerDataUtils.GetFeatureLogicUnlockTips(CommonDefine.FeatureId.MainWeapon, 0)
  elseif slotType == CommonDefine.WeaponSlotType.Secondary then
    tips = PlayerDataUtils.GetFeatureLogicUnlockTips(CommonDefine.FeatureId.SecondaryWeapon, 0)
  end
  do return LT.Text end
  return LT.Text, tips, 0
end

local commonSummonItemTid = DT.GetConstant("CommonSummonItemTid")

function ItemDataUtils.GetUseAwakerChipList(dropId)
  local rst = {}
  local dropCfg = DT.Drop[dropId]
  for dropIndex, dropData in pairs(dropCfg.data_list) do
    if dropData.FilterPara and dropData.FilterPara[1] then
      local awakerId = dropData.FilterPara[1]
      local awakerClipId = dropData.DropItem
      if AwakerDataUtils.HasOwnedAwaker(awakerId) then
        table.insert(rst, {
          tid = awakerClipId,
          num = dropData.DropNum,
          dropIndex = dropIndex
        })
      end
    else
      table.insert(rst, {
        tid = dropData.DropItem,
        num = dropData.DropNum,
        dropIndex = dropIndex
      })
    end
  end
  table.sort(rst, function(a, b)
    if a.tid == commonSummonItemTid and b.tid ~= commonSummonItemTid then
      return false
    end
    if a.tid ~= commonSummonItemTid and b.tid == commonSummonItemTid then
      return true
    end
    local aAwakerChipOverFlow = ItemDataUtils.IsAwakerChipOverFlow(a.tid) and 1 or 0
    local bAwakerChipOverFlow = ItemDataUtils.IsAwakerChipOverFlow(b.tid) and 1 or 0
    if aAwakerChipOverFlow ~= bAwakerChipOverFlow then
      return aAwakerChipOverFlow < bAwakerChipOverFlow
    end
    local aIsAwakerChip = DT.Item[a.tid].SubType == CommonDefine.ItemSubType.AwakerChip and 1 or 0
    local bIsAwakerChip = DT.Item[b.tid].SubType == CommonDefine.ItemSubType.AwakerChip and 1 or 0
    if aIsAwakerChip ~= bIsAwakerChip then
      return aIsAwakerChip > bIsAwakerChip
    end
    return a.dropIndex < b.dropIndex
  end)
  return rst
end

function ItemDataUtils.GetDropItemList(dropId)
  local dropCfg = DT.Drop[dropId] or {}
  local rst = {}
  local now = TimeUtils.GetServerTime()
  for _, dropData in pairs(dropCfg.data_list or {}) do
    if now >= (dropData.StartDropTime or 0) then
      if DT.Drop[dropData.DropItem] then
        local subRst = ItemDataUtils.GetDropItemList(dropData.DropItem)
        for _, v in ipairs(subRst) do
          table.insert(rst, v)
        end
      elseif DT.Item[dropData.DropItem] then
        table.insert(rst, dropData.DropItem)
      end
    end
  end
  local duplicates = {}
  local itemId
  for i = #rst, 1, -1 do
    itemId = rst[i]
    if not duplicates[itemId] then
      duplicates[itemId] = true
    else
      table.remove(rst, i)
    end
  end
  return rst
end

function ItemDataUtils.GetRedundantWeaponList()
  local rst = {}
  local sumLimit = MAX_WEAPON_LV + 1
  local tid2Items = {}
  for _, item in pairs(DataCenter.itemData.BagItemData) do
    if item and item.tid and item.uid and 0 ~= item.uid and ItemDataUtils.GetItemType(item.tid) == ItemType.Weapon then
      local list = tid2Items[item.tid]
      if not list then
        list = {}
        tid2Items[item.tid] = list
      end
      table.insert(list, item)
    end
  end
  for _, items in pairs(tid2Items) do
    if #items >= 2 then
      table.sort(items, function(a, b)
        local lvA = ItemDataUtils.GetWeaponLevel(a.uid)
        local lvB = ItemDataUtils.GetWeaponLevel(b.uid)
        if lvA ~= lvB then
          return lvA > lvB
        end
        return (a.uid or 0) < (b.uid or 0)
      end)
      local curSum = 0
      local breakIdx
      for i, item in ipairs(items) do
        local lv = ItemDataUtils.GetWeaponLevel(item.uid) or 0
        curSum = curSum + lv + 1
        if sumLimit <= curSum then
          breakIdx = i
          break
        end
      end
      if breakIdx and breakIdx < #items then
        for i = breakIdx + 1, #items do
          if items[i] and items[i].uid and 0 ~= items[i].uid then
            table.insert(rst, items[i])
          end
        end
      end
    end
  end
  return rst
end

return ItemDataUtils
