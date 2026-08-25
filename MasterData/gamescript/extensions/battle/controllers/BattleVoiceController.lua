local BattleVoiceController = NewClass("BattleVoiceController", BaseController)

function BattleVoiceController:OnInit()
end

function BattleVoiceController:OnReset()
end

function BattleVoiceController:PlayPvpVoice(needInterrupt)
  if not bg.battleScene then
    return
  end
  local targetVoiceInfo = BattleVoiceModel.Instance:GetToPlayVoiceInfoListByIdx(1)
  if not targetVoiceInfo then
    return
  end
  if not needInterrupt and BattleVoiceModel.Instance:GetPlayingPvpVoice() then
    return
  end
  if needInterrupt then
    BattleVoiceController.Instance:StopAllPvpVoice()
  end
  BattleVoiceModel.Instance:PopToPlayVoiceInfo()
  local awakerClientList = bg.battleScene:GetAwakerListByCamp(targetVoiceInfo.camp)
  local targetAwakerTid = PvpOpeningVoiceCfgUtils.GetVoiceBelongAwaker(targetVoiceInfo.voiceTid)
  for _, awakerClient in pairs(awakerClientList) do
    if awakerClient.tid == targetAwakerTid then
      if AwakerVoiceModel.Instance:GetPvpVoiceState(targetVoiceInfo.voiceTid) == CommonDefine.AwakerStoryVoiceState.Lock and AwakerDataUtils.HasOwnedAwaker(targetAwakerTid) then
        AwakerVoiceController.Instance:ReqUnlockPvpOpeningVoice(targetVoiceInfo.voiceTid)
      end
      awakerClient:ShowPvpVoice(targetVoiceInfo.voiceTid, targetVoiceInfo.duration)
      BattleVoiceModel.Instance:SetPlayingPvpVoice(targetVoiceInfo.voiceTid)
      break
    end
  end
end

function BattleVoiceController:StopAllPvpVoice()
  local awakerList = bg.battleScene:GetAllAwakerList()
  for _, awaker in pairs(awakerList) do
    awaker:HidePvpVoice()
  end
  BattleVoiceModel.Instance:SetPlayingPvpVoice(nil)
end

function BattleVoiceController:StopPvpVoiceByCondition(targetCondition)
  local awakerList = bg.battleScene:GetAllAwakerList()
  for _, awaker in pairs(awakerList) do
    local playingPvpVoiceTid = awaker:GetPlayingPvpVoiceTid()
    if not playingPvpVoiceTid then
    else
      local condition = PvpOpeningVoiceCfgUtils.GetVoiceTriggerCondition(playingPvpVoiceTid)
      if condition == targetCondition then
        awaker:HidePvpVoice()
      end
    end
  end
end

function BattleVoiceController:OnPvpVoiceAwakerDied(awakerTid, camp)
  local pvpVoiceTid = PvpOpeningVoiceCfgUtils.GetAwakerPvpVoiceWithCondition(awakerTid, PvpVoiceDefine.TriggerCondition.AwakerDied)
  if not pvpVoiceTid then
    return
  end
  local voiceInfo = BattleVoiceModel.Instance:CreatePvpVoiceInfo(pvpVoiceTid, camp, DT.GetConstant("OtherDisplayTime"))
  BattleVoiceModel.Instance:AddToPlayVoiceInfo(voiceInfo)
end

function BattleVoiceController:OnPvpVoiceSkillReady(awakerTid, camp)
  local pvpVoiceTid = PvpOpeningVoiceCfgUtils.GetAwakerPvpVoiceWithCondition(awakerTid, PvpVoiceDefine.TriggerCondition.SkillReady)
  if not pvpVoiceTid then
    return
  end
  local voiceInfo = BattleVoiceModel.Instance:CreatePvpVoiceInfo(pvpVoiceTid, camp, DT.GetConstant("OtherDisplayTime"))
  BattleVoiceModel.Instance:AddToPlayVoiceInfo(voiceInfo)
end

function BattleVoiceController:OnPvpVoiceOperationImpossible(awakerTid, camp)
  local pvpVoiceTid = PvpOpeningVoiceCfgUtils.GetAwakerPvpVoiceWithCondition(awakerTid, PvpVoiceDefine.TriggerCondition.OperationImpossible)
  if not pvpVoiceTid then
    return
  end
  local voiceInfo = BattleVoiceModel.Instance:CreatePvpVoiceInfo(pvpVoiceTid, camp, DT.GetConstant("OtherDisplayTime"))
  BattleVoiceModel.Instance:AddToPlayVoiceInfo(voiceInfo)
end

function BattleVoiceController:OnPvpVoiceCountingStart()
  if UIManager.Instance:GetWindow(Urls.PvPSelectInitCardPanel) then
    return
  end
  local boutMgr = bg.battleRender.boutMgr
  local camp = boutMgr:GetCamp()
  local targetAwakerClient = bg.battleScene:GetAliveRandomAwakerByCamp(camp)
  if not targetAwakerClient then
    return
  end
  local pvpVoiceTid = PvpOpeningVoiceCfgUtils.GetAwakerPvpVoiceWithCondition(targetAwakerClient.tid, PvpVoiceDefine.TriggerCondition.CountingStart)
  if not pvpVoiceTid then
    return
  end
  local voiceInfo = BattleVoiceModel.Instance:CreatePvpVoiceInfo(pvpVoiceTid, camp, DT.GetConstant("OtherDisplayTime"))
  BattleVoiceModel.Instance:AddToPlayVoiceInfo(voiceInfo)
end

function BattleVoiceController:OnPvpPlayerThinkingTick()
  local curThinkCd = BattleVoiceModel.Instance:GetPvpPlayerThinkingCd()
  if not curThinkCd then
    BattleVoiceModel.Instance:ResetPvpPlayerThinking()
  end
  if not BattleVoiceModel.Instance:GetPlayerThinkingPlayable() then
    return
  end
  curThinkCd = curThinkCd - 1
  BattleVoiceModel.Instance:SetPvpPlayerThinkingCd(curThinkCd)
  if 0 == curThinkCd then
    local boutMgr = bg.battleRender.boutMgr
    local camp = boutMgr:GetCamp()
    local targetAwakerClient = bg.battleScene:GetAliveRandomAwakerByCamp(camp)
    if not targetAwakerClient then
      return
    end
    local pvpVoiceTid = PvpOpeningVoiceCfgUtils.GetAwakerPvpVoiceWithCondition(targetAwakerClient.tid, PvpVoiceDefine.TriggerCondition.OperationStop)
    if not pvpVoiceTid then
      return
    end
    BattleVoiceModel.Instance:SetPvpPlayerThinkingPlayable(false)
    local voiceInfo = BattleVoiceModel.Instance:CreatePvpVoiceInfo(pvpVoiceTid, camp, DT.GetConstant("OtherDisplayTime"))
    BattleVoiceModel.Instance:AddToPlayVoiceInfo(voiceInfo)
  end
end

return BattleVoiceController
