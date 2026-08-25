local AwakerCfgUtils = {}

function AwakerCfgUtils.GetCfg(awakerTid)
  if not awakerTid then
    return nil
  end
  return DT.AwakerConfig[awakerTid]
end

function AwakerCfgUtils.GetCfgField(field, cfgTid)
  local cfg = AwakerCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function AwakerCfgUtils.GetFirstRecommendWeapon(awakerTid)
  if not awakerTid then
    return
  end
  local recommendWeapon = AwakerCfgUtils.GetCfgField("RecommendWeapon", awakerTid)
  return recommendWeapon and recommendWeapon[1]
end

function AwakerCfgUtils.GetAwakerSchoolType(awakerTid)
  local schoolTid = AwakerDataUtils.GetAwakerSchool(awakerTid)
  return DT.SchoolConfig[schoolTid] and DT.SchoolConfig[schoolTid].NameEn
end

function AwakerCfgUtils.GetAwakerSchoolIcon(awakerTid)
  local schoolTid = AwakerDataUtils.GetAwakerSchool(awakerTid)
  return DT.SchoolConfig[schoolTid] and DT.SchoolConfig[schoolTid].Icon
end

function AwakerCfgUtils.IsAwakerOpened(awakerTid)
  local cfgOpenDate = AwakerCfgUtils.GetCfgField("OpenDate", awakerTid)
  if not cfgOpenDate then
    return true
  end
  local svrTime = TimeUtils.GetServerTime()
  return cfgOpenDate <= svrTime
end

return AwakerCfgUtils
