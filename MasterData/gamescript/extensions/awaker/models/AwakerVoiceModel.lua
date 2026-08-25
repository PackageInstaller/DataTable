local AwakerVoiceModel = NewClass("AwakerVoiceModel", BaseModel)

function AwakerVoiceModel:OnInit()
  self._pvpVoiceStateDict = {}
end

function AwakerVoiceModel:OnReset()
  self:OnInit()
end

function AwakerVoiceModel:UpdatePvpVoiceStateDict(svrData)
  for awakerTid, tbl in pairs(svrData) do
    for pvpVoiceTid, voiceState in pairs(tbl) do
      self:SetPvpVoiceState(pvpVoiceTid, voiceState)
    end
  end
end

function AwakerVoiceModel:SetPvpVoiceState(pvpVoiceTid, voiceState)
  if not pvpVoiceTid or not voiceState then
    return
  end
  self._pvpVoiceStateDict[pvpVoiceTid] = voiceState
  EventMgr.Instance.OnAwakerPvpVoiceStateChanged:Dispatch(pvpVoiceTid)
end

function AwakerVoiceModel:GetPvpVoiceState(pvpVoiceTid)
  local triggerCondition = PvpOpeningVoiceCfgUtils.GetVoiceTriggerCondition(pvpVoiceTid)
  if triggerCondition == PvpVoiceDefine.TriggerCondition.ReletedAwakerInEnemies then
    local relatedAwakerTid = PvpOpeningVoiceCfgUtils.GetCfgField("ReletedAwaker", pvpVoiceTid)
    if not AwakerCfgUtils.IsAwakerOpened(relatedAwakerTid) then
      return CommonDefine.AwakerStoryVoiceState.Hide
    end
  end
  return self._pvpVoiceStateDict[pvpVoiceTid] or CommonDefine.AwakerStoryVoiceState.Lock
end

function AwakerVoiceModel:IsAwakerHaveUnlockPvpVoice(awakerTid)
  local pvpVoiceTidList = PvpOpeningVoiceCfgUtils.GetAwakerPvpVoiceTidList(awakerTid)
  for _, voiceTid in pairs(pvpVoiceTidList or {}) do
    if self:GetPvpVoiceState(voiceTid) == CommonDefine.AwakerStoryVoiceState.Unlock then
      return true
    end
  end
  return false
end

return AwakerVoiceModel
