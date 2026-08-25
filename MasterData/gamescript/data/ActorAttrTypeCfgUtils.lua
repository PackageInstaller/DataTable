local ActorAttrTypeCfgUtils = {}

function ActorAttrTypeCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.ActorAttrType[tid]
end

function ActorAttrTypeCfgUtils.GetCfgField(field, cfgTid)
  local cfg = ActorAttrTypeCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function ActorAttrTypeCfgUtils.GetCfgByName(targetName)
  for tid, cfg in pairs(DT.ActorAttrType) do
    if cfg.Name == targetName then
      return cfg
    end
  end
  return nil
end

return ActorAttrTypeCfgUtils
