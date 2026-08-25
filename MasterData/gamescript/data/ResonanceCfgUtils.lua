local ResonanceCfgUtils = {}

function ResonanceCfgUtils.GetCfg(cfgTid, index)
  if not cfgTid then
    return nil
  end
  local resonanceCfg = DT.Resonance[cfgTid]
  if not resonanceCfg or not resonanceCfg.data_list then
    return nil
  end
  if not index then
    return resonanceCfg.data_list
  end
  return resonanceCfg.data_list[index]
end

function ResonanceCfgUtils.GetCfgField(field, dropTid, index)
  if not (field and dropTid) or not index then
    return nil
  end
  local cfg = ResonanceCfgUtils.GetCfg(dropTid, index)
  if not cfg then
    return nil
  end
  return cfg[field]
end

return ResonanceCfgUtils
