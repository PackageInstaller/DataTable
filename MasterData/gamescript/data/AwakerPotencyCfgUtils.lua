local AwakerPotencyCfgUtils = {}

function AwakerPotencyCfgUtils.GetCfg(potencyTid)
  if not potencyTid then
    return nil
  end
  return DT.AwakerPotency[potencyTid]
end

function AwakerPotencyCfgUtils.GetCfgField(field, potencyTid)
  local cfg = AwakerPotencyCfgUtils.GetCfg(potencyTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function AwakerPotencyCfgUtils.IsMaxPotency(potencyTid)
  do return AwakerPotencyCfgUtils.GetCfgField, "IfMaxPotency" end
  return AwakerPotencyCfgUtils.GetCfgField, "IfMaxPotency", potencyTid
end

local AwakerTid2PotencyTidsDict = {}

function AwakerPotencyCfgUtils.GetAwakerPotencyList(awakerTid)
  if not awakerTid or not AwakerCfgUtils.GetCfg(awakerTid) then
    return nil
  end
  if AwakerTid2PotencyTidsDict[awakerTid] then
    return AwakerTid2PotencyTidsDict[awakerTid]
  end
  for potencyTid, cfg in pairs(DT.AwakerPotency) do
    if not AwakerTid2PotencyTidsDict[cfg.AwakerID] then
      AwakerTid2PotencyTidsDict[cfg.AwakerID] = {}
    end
    table.insert(AwakerTid2PotencyTidsDict[cfg.AwakerID], potencyTid)
  end
  return AwakerTid2PotencyTidsDict[awakerTid]
end

function AwakerPotencyCfgUtils.GetAwakerMaxPotencyTid(awakerTid)
  local potencyList = AwakerPotencyCfgUtils.GetAwakerPotencyList(awakerTid)
  if not potencyList then
    return nil
  end
  for _, potencyTid in pairs(potencyList) do
    if AwakerPotencyCfgUtils.IsMaxPotency(potencyTid) then
      return potencyTid
    end
  end
  return nil
end

return AwakerPotencyCfgUtils
