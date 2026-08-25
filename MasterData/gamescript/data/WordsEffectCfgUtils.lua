local WordsEffectCfgUtils = {}

function WordsEffectCfgUtils.GetCfg(cfgTid)
  if not cfgTid then
    return nil
  end
  return DT.WordsEffectConfig[cfgTid]
end

function WordsEffectCfgUtils.GetCfgField(field, cfgTid)
  local cfg = WordsEffectCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function WordsEffectCfgUtils.GetLinkStateDesc(cfgTid)
  local cfgStateLink = WordsEffectCfgUtils.GetCfgField("StateLink", cfgTid)
  if not cfgStateLink then
    return
  end
  do return StateCfgUtils.GetCfgField, "Desc" end
  return StateCfgUtils.GetCfgField, "Desc", cfgStateLink
end

return WordsEffectCfgUtils
