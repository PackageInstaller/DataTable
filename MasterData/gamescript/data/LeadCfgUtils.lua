local LeadCfgUtils = {}

function LeadCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.Lead[tid]
end

function LeadCfgUtils.GetCfgField(field, cfgTid)
  local cfg = LeadCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function LeadCfgUtils.GetPlayerGerderHeadIcon()
  local genderTid = PlayerDataUtils.GetGender()
  do return LeadCfgUtils.GetCfgField, "AVGAvatarRes" end
  return LeadCfgUtils.GetCfgField, "AVGAvatarRes", genderTid
end

return LeadCfgUtils
