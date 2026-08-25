local SummonCfgUtils = {}

function SummonCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.Summon[tid]
end

function SummonCfgUtils.GetCfgField(field, cfgTid)
  local cfg = SummonCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

local SummonTid2DropRateKeyDict = {}

function SummonCfgUtils.GetSummonDropRateKey(summonTid, schoolEn)
  local summonCfg = SummonCfgUtils.GetCfg(summonTid)
  if not table.next(SummonTid2DropRateKeyDict) then
    local cfgSpecialPoolRateShow = DT.GetOriginalConstant("SpecialPoolRateShow")
    for i = 1, #cfgSpecialPoolRateShow, 2 do
      local dropRateKey = cfgSpecialPoolRateShow[i]
      local targetSummonTid = cfgSpecialPoolRateShow[i + 1]
      SummonTid2DropRateKeyDict[targetSummonTid] = dropRateKey
    end
  end
  local dropRateKey = "PoolRate_" .. summonCfg.Type
  if schoolEn then
    dropRateKey = dropRateKey .. "_" .. schoolEn
  end
  if SummonTid2DropRateKeyDict[summonTid] then
    dropRateKey = SummonTid2DropRateKeyDict[summonTid]
  end
  return dropRateKey
end

function SummonCfgUtils.GetShowAwakerTidByCorrectedAwardSSR(poolTid)
  local correctedAwardSSR = SummonCfgUtils.GetCfgField("CorrectedAwardSSR", poolTid)
  if not correctedAwardSSR then
    return
  end
  local targetItemTid
  local dropCfg = DropCfgUtils.GetCfg(correctedAwardSSR) or {}
  for _, dropData in pairs(dropCfg.data_list or {}) do
    local itemTid = dropData.DropItem
    local itemType = ItemCfgUtils.GetCfgField("Type", itemTid)
    if itemType == CommonDefine.ItemType.AwakerItem then
      targetItemTid = itemTid
      break
    end
  end
  if targetItemTid then
    do return ItemDataUtils.GetAwakerTidByItemTid end
    return ItemDataUtils.GetAwakerTidByItemTid, targetItemTid, pairs(dropCfg.data_list or {})
  end
  return nil
end

function SummonCfgUtils.GetShowWeaponTidByCorrectedAwardSSR(poolTid)
  local correctedAwardSSR = SummonCfgUtils.GetCfgField("CorrectedAwardSSR", poolTid)
  if not correctedAwardSSR then
    return
  end
  local dropCfg = DropCfgUtils.GetCfg(correctedAwardSSR) or {}
  for _, dropData in pairs(dropCfg.data_list or {}) do
    local itemTid = dropData.DropItem
    local itemType = ItemCfgUtils.GetCfgField("Type", itemTid)
    if itemType == CommonDefine.ItemType.Weapon then
      return itemTid
    end
  end
  return nil
end

function SummonCfgUtils.GetPoolCostItemTidList(poolTid)
  local rst = {}
  local poolCfg = SummonCfgUtils.GetCfg(poolTid)
  if not poolCfg then
    return rst
  end
  local cfgConsumeTicket = poolCfg.ConsumeTicket or {}
  local cfgPriorityConsumeTicket = poolCfg.PriorityConsumeTicket or {}
  table.insert(rst, cfgConsumeTicket[1])
  table.insert(rst, cfgPriorityConsumeTicket[1])
  return rst
end

function SummonCfgUtils.GetPoolPriorityConsumeItemTid(poolTid)
  local poolCfg = SummonCfgUtils.GetCfg(poolTid)
  if not poolCfg then
    return nil
  end
  local rst = poolCfg.TenTimesConsumeTicket and poolCfg.TenTimesConsumeTicket[1]
  if poolCfg.PriorityConsumeTicket then
    local priorityConsumeItemTid = poolCfg.PriorityConsumeTicket[1]
    if priorityConsumeItemTid and ItemDataUtils.GetItemNum(priorityConsumeItemTid) > 0 then
      rst = priorityConsumeItemTid
    end
  end
  return rst
end

function SummonCfgUtils.GetPoolOneTimesConsumeItemInfo(poolTid)
  local poolCfg = SummonCfgUtils.GetCfg(poolTid)
  if not poolCfg then
    return nil
  end
  local itemTid = poolCfg.ConsumeTicket and poolCfg.ConsumeTicket[1]
  local itemNum = poolCfg.ConsumeTicket and poolCfg.ConsumeTicket[2]
  if not itemTid or not itemNum then
    return nil
  end
  return {tid = itemTid, num = itemNum}
end

function SummonCfgUtils.GetTargetedAwakerWeaponSummonShowInfo(poolTid)
  if SummonCfgUtils.GetCfgField("Type", poolTid) ~= CommonDefine.SummonPoolType.TargetedAwakerWeapon then
    return nil
  end
  local correctedAwardSSR = SummonCfgUtils.GetCfgField("CorrectedAwardSSR", poolTid)
  if not correctedAwardSSR then
    return nil
  end
  local rst = {awakerTid = nil, weaponTid = nil}
  local dropCfg = DropCfgUtils.GetCfg(correctedAwardSSR) or {}
  for _, dropData in pairs(dropCfg.data_list or {}) do
    local itemTid = dropData.DropItem
    local itemType = ItemCfgUtils.GetCfgField("Type", itemTid)
    if itemType == CommonDefine.ItemType.AwakerItem then
      rst.awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
    elseif itemType == CommonDefine.ItemType.Weapon then
      rst.weaponTid = itemTid
    end
    if rst.awakerTid and rst.weaponTid then
      break
    end
  end
  return rst
end

function SummonCfgUtils.IsTripleLuckyBagPool(poolTid)
  return SummonCfgUtils.GetCfgField("Type", poolTid) == CommonDefine.SummonPoolType.TripleLuckyBag
end

function SummonCfgUtils.IsCashDirectPurchasePool(poolId)
  local poolCfg = SummonCfgUtils.GetCfg(poolId)
  if not poolCfg then
    return false
  end
  local cashCfg = poolCfg.CashDirectPurchase
  if cashCfg and cashCfg[1] and "" ~= cashCfg[1] then
    if not poolCfg.TenTimesConsumeTicket then
      Logger.Error("[SummonCfgUtils] 直购卡池 %s 缺少 TenTimesConsumeTicket 配置，唤醒后无法扣除道具", tostring(poolId))
    end
    return true
  end
  return false
end

function SummonCfgUtils.GetCashDirectPurchaseChargeInfo(poolId)
  local poolCfg = SummonCfgUtils.GetCfg(poolId)
  local cashCfg = poolCfg and poolCfg.CashDirectPurchase
  if not (cashCfg and cashCfg[1]) or "" == cashCfg[1] then
    return nil, nil
  end
  local chargeGroup = cashCfg[1]
  local chargeId = ShopDataUtils.GetChargeIdByChargeGroup(chargeGroup)
  if not chargeId then
    Logger.Warn("[SummonCfgUtils] GetCashDirectPurchaseChargeInfo: 找不到充值组对应的充值项 chargeGroup=%s", tostring(chargeGroup))
    return nil, nil
  end
  local priceStr = ShopDataUtils.GetChargePriceStr(chargeId)
  return chargeId, priceStr
end

function SummonCfgUtils.IsPoolTentimesCurrencyEnough(summonPoolTid)
  local cfg = SummonCfgUtils.GetCfg(summonPoolTid)
  if not cfg or not cfg.TenTimesConsumeTicket then
    return false
  end
  local costItemTid = cfg.TenTimesConsumeTicket[1]
  local costItemNum = cfg.TenTimesConsumeTicket[2]
  local haveNum = ItemDataUtils.GetItemNum(costItemTid)
  return costItemNum <= haveNum
end

return SummonCfgUtils
