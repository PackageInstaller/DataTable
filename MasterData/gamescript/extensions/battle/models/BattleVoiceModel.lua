local TriggerCondition = PvpVoiceDefine.TriggerCondition
local BattleVoiceModel = NewClass("BattleVoiceModel", BaseModel)

function BattleVoiceModel:OnInit()
  self:ClearData()
end

function BattleVoiceModel:OnReset()
  self:OnInit()
end

function BattleVoiceModel:ClearData()
  self._playingPvpVoice = nil
  self._toPlayVoiceInfoList = {}
  self._playerThinkingPlayable = false
  self._playerThinkingCd = DT.GetConstant("ThinkingTime")
end

function BattleVoiceModel:AddToPlayVoiceInfo(voiceInfo)
  if bg and bg.isReplay then
    return
  end
  table.insert(self._toPlayVoiceInfoList, voiceInfo)
  EventMgr.Instance.PvpAddToPlayVoiceInfo:Dispatch(voiceInfo.voiceTid)
end

function BattleVoiceModel:RemoveLastVoiceInfo()
  table.remove(self._toPlayVoiceInfoList, #self._toPlayVoiceInfoList)
end

function BattleVoiceModel:PopToPlayVoiceInfo()
  local haveSkillReady = false
  for i = #self._toPlayVoiceInfoList, 1, -1 do
    local voiceTid = self._toPlayVoiceInfoList[i].voiceTid
    local triggerCondition = PvpOpeningVoiceCfgUtils.GetVoiceTriggerCondition(voiceTid)
    if triggerCondition == TriggerCondition.SkillReady then
      if not haveSkillReady then
        haveSkillReady = true
      else
        table.remove(self._toPlayVoiceInfoList, i)
      end
    end
  end
  local rst = table.remove(self._toPlayVoiceInfoList, 1)
  return rst
end

function BattleVoiceModel:GetToPlayVoiceInfoListByIdx(idx)
  return self._toPlayVoiceInfoList[idx]
end

function BattleVoiceModel:CreatePvpVoiceInfo(voiceTid, camp, duration)
  return {
    voiceTid = voiceTid,
    camp = camp,
    duration = duration
  }
end

function BattleVoiceModel:SetPlayingPvpVoice(voiceTid)
  self._playingPvpVoice = voiceTid
end

function BattleVoiceModel:SetPvpPlayerThinkingCd(cd)
  self._playerThinkingCd = cd
end

function BattleVoiceModel:ResetPvpPlayerThinking()
  self._playerThinkingCd = DT.GetConstant("ThinkingTime")
  self:SetPvpPlayerThinkingPlayable(true)
end

function BattleVoiceModel:SetPvpPlayerThinkingPlayable(boolVal)
  self._playerThinkingPlayable = boolVal
end

function BattleVoiceModel:GetPlayerThinkingPlayable()
  return self._playerThinkingPlayable
end

function BattleVoiceModel:GetPlayingPvpVoice()
  return self._playingPvpVoice
end

function BattleVoiceModel:GetPvpPlayerThinkingCd()
  return self._playerThinkingCd
end

local needInterruptConditionList = {
  TriggerCondition.PlayerEnter,
  TriggerCondition.ReletedAwakerInEnemies
}

function BattleVoiceModel:IsNeedInterrupt(voiceTid)
  if not self._playingPvpVoice then
    return false
  end
  local playingVoiceCondition = PvpOpeningVoiceCfgUtils.GetVoiceTriggerCondition(self._playingPvpVoice)
  local targetCondition = PvpOpeningVoiceCfgUtils.GetVoiceTriggerCondition(voiceTid)
  if not table.contains(needInterruptConditionList, playingVoiceCondition) and table.contains(needInterruptConditionList, targetCondition) then
    return true
  end
  if playingVoiceCondition == TriggerCondition.OperationStop and table.contains({
    TriggerCondition.OperationImpossible,
    TriggerCondition.AwakerDied
  }, targetCondition) then
    return true
  end
  if playingVoiceCondition == TriggerCondition.CountingStart then
    if targetCondition == TriggerCondition.OperationStop then
      self:RemoveLastVoiceInfo()
      return false
    end
    if table.contains({
      TriggerCondition.SkillReady,
      TriggerCondition.OperationImpossible,
      TriggerCondition.AwakerDied
    }, targetCondition) then
      return true
    end
  end
  if playingVoiceCondition == TriggerCondition.SkillReady then
    if targetCondition == TriggerCondition.OperationStop then
      self:RemoveLastVoiceInfo()
      return false
    end
    if table.contains({
      TriggerCondition.OperationImpossible,
      TriggerCondition.AwakerDied
    }, targetCondition) then
      return true
    end
  end
  if playingVoiceCondition == TriggerCondition.OperationImpossible then
    if targetCondition == TriggerCondition.OperationStop then
      self:RemoveLastVoiceInfo()
      return false
    end
    if table.contains({
      TriggerCondition.OperationImpossible,
      TriggerCondition.AwakerDied
    }, targetCondition) then
      return true
    end
  end
  if playingVoiceCondition == TriggerCondition.AwakerDied then
    if targetCondition == TriggerCondition.OperationStop then
      self:RemoveLastVoiceInfo()
      return false
    end
    if targetCondition == TriggerCondition.OperationImpossible then
      self:RemoveLastVoiceInfo()
      return false
    end
  end
  return false
end

return BattleVoiceModel
