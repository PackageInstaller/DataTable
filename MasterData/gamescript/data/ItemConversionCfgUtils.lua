local ItemConversionCfgUtils = {}

function ItemConversionCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.ItemConversion[tid]
end

function ItemConversionCfgUtils.GetCfgField(field, cfgTid)
  local cfg = ItemConversionCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function ItemConversionCfgUtils.GetConvertionRefreshTime(tid)
  local cfgRefreshTime = ItemConversionCfgUtils.GetCfgField("RefreshTime", tid)
  if not cfgRefreshTime then
    return nil
  end
  local refreshType = cfgRefreshTime[1]
  if not refreshType then
    return nil
  end
  if "Monthly" == refreshType then
    do return end
    return TimeCfgUtils.GetNextMonthFirstDay
  elseif "Weekly" == refreshType then
    do return end
    return TimeCfgUtils.GetNextMonday
  elseif "Daily" == refreshType then
    do return end
    return TimeCfgUtils.GetNextDailyRefreshTimeStamp
  end
  return nil
end

return ItemConversionCfgUtils
