local CareerLevelCfgUtils = {}

function CareerLevelCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.CareerLevel[tid]
end

function CareerLevelCfgUtils.GetCfgField(field, cfgTid)
  local cfg = CareerLevelCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function CareerLevelCfgUtils.GetMaxLevel(type)
  local cfgList = CareerLevelCfgUtils.GetcfgListByType(type) or {}
  return #cfgList
end

local careerLevelType2CfgsDict = {}

function CareerLevelCfgUtils.GetcfgListByType(type)
  if careerLevelType2CfgsDict[type] then
    return careerLevelType2CfgsDict[type]
  end
  local cfgs = {}
  for _, cfg in pairs(DT.CareerLevel) do
    if cfg.Type == type then
      table.insert(cfgs, cfg)
    end
  end
  table.sort(cfgs, function(a, b)
    return a.Level < b.Level
  end)
  careerLevelType2CfgsDict[type] = cfgs
  return cfgs
end

function CareerLevelCfgUtils.GetCfgByParams(type, level)
  if not type or not level then
    return nil
  end
  local cfgs = CareerLevelCfgUtils.GetcfgListByType(type)
  for _, cfg in pairs(cfgs) do
    if cfg.Level == level then
      return cfg
    end
  end
  return nil
end

return CareerLevelCfgUtils
