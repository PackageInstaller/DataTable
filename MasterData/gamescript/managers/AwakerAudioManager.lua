local AwakerVoiceTrigger = CommonDefine.AwakerVoiceTrigger
local AwakerAudioManager, Super = System.NewClass("AwakerAudioManager", Manager, IUpdater)
local unBanableTriggerGroup = {
  AwakerVoiceTrigger.ActivatePotency_1,
  AwakerVoiceTrigger.ActivatePotency_2,
  AwakerVoiceTrigger.ActivatePotency_3,
  AwakerVoiceTrigger.ActivatePotency_4,
  AwakerVoiceTrigger.ActivatePotency_5,
  AwakerVoiceTrigger.ActivatePotency_6,
  AwakerVoiceTrigger.ActivatePotency_7
}

function AwakerAudioManager:ctor()
  Super.ctor(self)
end

function AwakerAudioManager:Awake(binder)
  Super.Awake(self)
  self.inited = false
end

function AwakerAudioManager:Init()
  local awakerVoiceMap = {}
  local HaveSpecificItem = cd.TaskUnlockCondType.HaveSpecificItem
  for _, config in pairs(DT.Voice) do
    local awakerId = config.AwakerID
    local triggerTimes = config.TriggerTime
    local skinTid = cd.DefaultSkinTid
    if config.ConditionType == HaveSpecificItem then
      skinTid = config.ConditionPara and config.ConditionPara[2] or cd.DefaultSkinTid
    elseif config.ConditionType_1 == HaveSpecificItem then
      skinTid = config.ConditionPara_1 and config.ConditionPara_1[2] or cd.DefaultSkinTid
    end
    if not awakerVoiceMap[awakerId] then
      awakerVoiceMap[awakerId] = {}
    end
    for _, triggerTime in pairs(triggerTimes) do
      local voiceMap = awakerVoiceMap[awakerId][triggerTime] or {}
      awakerVoiceMap[awakerId][triggerTime] = voiceMap
      local skinMap = voiceMap[skinTid] or {}
      voiceMap[skinTid] = skinMap
      table.insert(skinMap, config.ID)
    end
  end
  self.awakerVoiceMap = awakerVoiceMap
  self.takenVoiceMap = {}
end

function AwakerAudioManager:GetAwakerVoiceIdFromBattle(triggerTime, awakerId, curSkin, isNoLineVoice)
  do return self.GetAwakerVoiceId, self, triggerTime, awakerId, curSkin, isNoLineVoice end
  return self.GetAwakerVoiceId, self, triggerTime, awakerId, curSkin, isNoLineVoice, true
end

function AwakerAudioManager:GetAwakerVoiceId(triggerTime, awakerId, curSkin, isNoLineVoice, isFromBattle)
  if self.inited == false then
    AwakerAudioManager:Init()
    self.inited = true
  end
  curSkin = curSkin or cd.DefaultSkinTid
  local retVoiceId = 0
  local voiceMap = self.awakerVoiceMap[awakerId] and self.awakerVoiceMap[awakerId][triggerTime]
  local soundList = voiceMap and voiceMap[curSkin]
  if (not soundList or 0 == #soundList) and curSkin ~= cd.DefaultSkinTid then
    do return self.GetAwakerVoiceId, self, triggerTime, awakerId, cd.DefaultSkinTid, isNoLineVoice end
    return self.GetAwakerVoiceId, self, triggerTime, awakerId, cd.DefaultSkinTid, isNoLineVoice, isFromBattle, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  if not table.contains(unBanableTriggerGroup, triggerTime) then
    local tmpList = {}
    local unlockVoices = AwakerDataUtils.GetAwakerData(awakerId).voices
    for _, voiceId in pairs(soundList or {}) do
      if isFromBattle then
        table.insert(tmpList, voiceId)
      else
        for key, _ in pairs(unlockVoices or {}) do
          if key == voiceId then
            table.insert(tmpList, voiceId)
          end
        end
      end
    end
    if isNoLineVoice then
      for i = #tmpList, 1, -1 do
        local voiceId = tmpList[i]
        local voiceCfg = DT.Voice[voiceId]
        if 1 == voiceCfg.NoLines then
          table.remove(tmpList, i)
        end
      end
    end
    soundList = tmpList
  end
  if not soundList or 0 == #soundList then
    if curSkin ~= cd.DefaultSkinTid then
      do return self.GetAwakerVoiceId, self, triggerTime, awakerId, cd.DefaultSkinTid, isNoLineVoice end
      return self.GetAwakerVoiceId, self, triggerTime, awakerId, cd.DefaultSkinTid, isNoLineVoice, isFromBattle, DT.Voice[voiceId], table.remove, tmpList, i, pairs(unlockVoices or {})
    end
    return 0
  end
  retVoiceId = self:GetUnTakenVoiceId(soundList)
  return retVoiceId
end

function AwakerAudioManager:GetUnTakenVoiceId(soundList)
  if not soundList or 0 == #soundList then
    return 0
  end
  local randomIdx = math.random(1, #soundList)
  for index = randomIdx, #soundList + randomIdx do
    if index > #soundList then
      index = index - #soundList
    end
    local voiceId = soundList[index]
    if not self.takenVoiceMap[voiceId] then
      self.takenVoiceMap[voiceId] = true
      return voiceId
    end
  end
  for _, voiceId in pairs(soundList) do
    self.takenVoiceMap[voiceId] = nil
  end
  do return self.GetUnTakenVoiceId, self end
  return self.GetUnTakenVoiceId, self, soundList, pairs(soundList)
end

return AwakerAudioManager
