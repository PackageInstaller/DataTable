local ColorCfgUtils = {}

function ColorCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.ColorConfig[tid]
end

function ColorCfgUtils.GetCfgField(field, cfgTid)
  local cfg = ColorCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

return ColorCfgUtils
