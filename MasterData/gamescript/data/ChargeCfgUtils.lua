local ChargeCfgUtils = {}

function ChargeCfgUtils.GetCfg(taskTid)
  if not taskTid then
    return nil
  end
  return DT.Charge[taskTid]
end

function ChargeCfgUtils.GetCfgField(field, cfgTid)
  local cfg = ChargeCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function ChargeCfgUtils.GetFirstPayGetItemTid(chargeTid)
  local map = ChargeCfgUtils.GetCfgField("FirstPayGet", chargeTid)
  if not map then
    return nil
  end
  local itemTid = table.next(map)
  return itemTid
end

function ChargeCfgUtils.GetNonFirstPayGetGetItemTid(chargeTid)
  local map = ChargeCfgUtils.GetCfgField("nonFirstPayGet", chargeTid)
  if not map then
    return nil
  end
  local itemTid = table.next(map)
  return itemTid
end

function ChargeCfgUtils.CheckUsePlayCoin(chargeTid)
  local playCoinCfg = ChargeCfgUtils.GetCfgField("PlayCoin", chargeTid)
  do return ChargeCfgUtils.CheckCoinEnough end
  return ChargeCfgUtils.CheckCoinEnough, playCoinCfg
end

function ChargeCfgUtils.CheckUseVoucher(chargeTid)
  local voucherCfg = ChargeCfgUtils.GetCfgField("Voucher", chargeTid)
  do return ChargeCfgUtils.CheckCoinEnough end
  return ChargeCfgUtils.CheckCoinEnough, voucherCfg
end

function ChargeCfgUtils.CheckCoinEnough(cfgInfo)
  if not cfgInfo or table.next(cfgInfo) == nil then
    return false
  end
  for itemTid, num in pairs(cfgInfo) do
    if not itemTid or not DT.Item[itemTid] then
      return false
    end
    if not num or num <= 0 then
      return false
    end
    local ownedNum = ItemDataUtils.GetItemNum(itemTid) or 0
    if num > ownedNum then
      return false
    end
  end
  return true
end

function ChargeCfgUtils.GetPlayCoinCostData(chargeTid)
  local playCoinCfg = ChargeCfgUtils.GetCfgField("PlayCoin", chargeTid)
  do return ChargeCfgUtils.GetCostData end
  return ChargeCfgUtils.GetCostData, playCoinCfg
end

function ChargeCfgUtils.GetVoucherCostData(chargeTid)
  local voucherCfg = ChargeCfgUtils.GetCfgField("Voucher", chargeTid)
  do return ChargeCfgUtils.GetCostData end
  return ChargeCfgUtils.GetCostData, voucherCfg
end

function ChargeCfgUtils.GetCostData(cfgInfo)
  if not cfgInfo or table.next(cfgInfo) == nil then
    return
  end
  for itemTid, num in pairs(cfgInfo) do
    if not itemTid or not DT.Item[itemTid] then
      return
    end
    if not num or num <= 0 then
      return
    end
    return {tid = itemTid, num = num}
  end
end

return ChargeCfgUtils
