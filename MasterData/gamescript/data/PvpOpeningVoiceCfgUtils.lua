local PvpOpeningVoiceCfgUtils = {}

function PvpOpeningVoiceCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.PVPOpeningVoice[tid]
end

function PvpOpeningVoiceCfgUtils.GetCfgField(field, cfgTid)
  local cfg = PvpOpeningVoiceCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function PvpOpeningVoiceCfgUtils.GetVoiceBelongAwaker(tid)
  do return PvpOpeningVoiceCfgUtils.GetCfgField, "AwakerID" end
  return PvpOpeningVoiceCfgUtils.GetCfgField, "AwakerID", tid
end

function PvpOpeningVoiceCfgUtils.GetVoiceTriggerCondition(tid)
  local cfgTriggerConditions = PvpOpeningVoiceCfgUtils.GetCfgField("TriggerConditions", tid)
  return cfgTriggerConditions and cfgTriggerConditions[1]
end

function PvpOpeningVoiceCfgUtils.GetVoiceName(tid)
  local triggerCondition = PvpOpeningVoiceCfgUtils.GetVoiceTriggerCondition(tid)
  if not triggerCondition then
    return ""
  end
  local langKey = PvpVoiceDefine.VoiceNameLangPrefix .. triggerCondition
  if triggerCondition == PvpVoiceDefine.TriggerCondition.ReletedAwakerInEnemies then
    local awakerTid = PvpOpeningVoiceCfgUtils.GetCfgField("ReletedAwaker", tid)
    local awakerName = LT.Text(AwakerCfgUtils.GetCfgField("Name", awakerTid))
    do return LT.Textf, langKey end
    return LT.Textf, langKey, awakerName
  end
  do return LT.Text end
  return LT.Text, langKey, LT.Textf, langKey, awakerName
end

function PvpOpeningVoiceCfgUtils.GetAwakerPvpVoiceTidList(awakerTid)
  local rst = {}
  for _, cfg in pairs(DT.PVPOpeningVoice) do
    if cfg.AwakerID == awakerTid then
      table.insert(rst, cfg.ID)
    end
  end
  return rst
end

function PvpOpeningVoiceCfgUtils.GetAwakerPvpVoiceWithCondition(awakerTid, condition)
  local rst = {}
  for _, cfg in pairs(DT.PVPOpeningVoice) do
    if cfg.AwakerID == awakerTid and cfg.TriggerConditions and cfg.TriggerConditions[1] == condition then
      return cfg.ID
    end
  end
  return rst
end

return PvpOpeningVoiceCfgUtils
