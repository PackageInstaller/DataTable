local DSBuff = class("DSBuff")
local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
local DSFetureEnum = {
  AddAcceleration = 1,
  AddMaxMoveSpeed = 2,
  AddDrag = 3
}
local DSAddBuffFeatureFunc = {
  [DSFetureEnum.AddAcceleration] = function(isAddOrRemove, dsEntity, dsFetureParam)
    dsEntity:SetAddAcceleration(isAddOrRemove and dsFetureParam or -dsFetureParam)
  end,
  [DSFetureEnum.AddMaxMoveSpeed] = function(isAddOrRemove, dsEntity, dsFetureParam)
    dsEntity:SetAddMaxMoveSpeed(isAddOrRemove and dsFetureParam or -dsFetureParam)
  end,
  [DSFetureEnum.AddDrag] = function(isAddOrRemove, dsEntity, dsFetureParam)
    dsEntity:SetAddDrag(isAddOrRemove and dsFetureParam or -dsFetureParam)
  end
}
local DSRemoveBuffFeatureFunc = {}
local DSBuffOverlayType = {
  ReSetDuration = 1,
  AddTier = 2,
  Over = 3
}
local DSOverlayBuffFunc = {
  [DSBuffOverlayType.ReSetDuration] = function(dsBuff)
    dsBuff.endTime = dsBuff.duration + Time.time
  end
}
local DSBuffPerformanceType = {
  ChangeAnimatorParam = 1,
  ShowEffect = 2,
  PlayAudio = 4
}
local DSBuffPerformanceFunc = {
  [DSBuffPerformanceType.ChangeAnimatorParam] = function(dsbuff, dsEntity, dsBuffPerformanceParam)
    dsEntity.animator:SetFloat(dsBuffPerformanceParam[1], dsBuffPerformanceParam[2])
  end,
  [DSBuffPerformanceType.ShowEffect] = function(dsbuff, dsEntity, dsBuffPerformanceParam)
    local effect = CS_AnimationEffectController_Ins:AddAnimationEffectByBattleEffectId(tonumber(dsBuffPerformanceParam), dsEntity.gameObject)
    table.insert(dsbuff.effectList, effect)
    effect:Play()
  end
}

function DSBuff:ctor()
  self:Reset()
end

function DSBuff:InitDSBuff(buffId)
  self.DSbuffId = buffId
  self.buffCfg = ConfigData.delivery_buff[buffId]
  self.endTime = 0
end

function DSBuff:GetName()
  return LanguageUtil.GetLocaleText(self.buffCfg.name)
end

function DSBuff:GetDuration()
  return self.buffCfg.buff_time
end

function DSBuff:IsHasDuration()
  return self:GetDuration() > 0
end

function DSBuff:GetRemainingTimeProgress()
  if self.endTime == nil or self.endTime <= 0 then
    return 1
  end
  return (self.endTime - Time.time) / self:GetDuration()
end

function DSBuff:AddBuff(dsEntity)
  self.dsEntity = dsEntity
  if self:IsHasDuration() then
    self.endTime = Time.time + self:GetDuration()
  end
  local cfg = self.buffCfg
  for index, dsFeatureId in ipairs(cfg.feature) do
    if DSAddBuffFeatureFunc[dsFeatureId] ~= nil then
      DSAddBuffFeatureFunc[dsFeatureId](true, dsEntity, cfg.feature_value[dsFeatureId])
    end
  end
  if cfg.perform_type_list ~= nil then
    for index, dsBuffPerformanceType in ipairs(cfg.perform_type_list) do
      if DSBuffPerformanceFunc[dsBuffPerformanceType] ~= nil then
        DSBuffPerformanceFunc[dsBuffPerformanceType](self, dsEntity, cfg.perform_value_dic[index])
      end
    end
  end
end

function DSBuff:RemoveBuff()
  local cfg = self.buffCfg
  local dsEntity = self.dsEntity
  for index, dsFeatureId in ipairs(cfg.feature) do
    if DSRemoveBuffFeatureFunc[dsFeatureId] ~= nil then
      DSRemoveBuffFeatureFunc[dsFeatureId](dsEntity, cfg.feature_value[dsFeatureId])
    elseif DSAddBuffFeatureFunc[dsFeatureId] ~= nil then
      DSAddBuffFeatureFunc[dsFeatureId](false, dsEntity, cfg.feature_value[dsFeatureId])
    end
  end
  for index, effect in ipairs(self.effectList) do
    CS_AnimationEffectController_Ins:KillEffect(effect)
    CS_AnimationEffectController_Ins:RecycleEffect(effect)
    self.effectList[index] = nil
  end
  for index, audiocallback in ipairs(self.audiocallbackList) do
    AudioManager:StopAudioByBack(audiocallback)
    self.audiocallbackList[index] = nil
  end
  if self.removeDSBuffPerformance ~= nil then
    for index, dsBuffPerformanceType in ipairs(self.removeDSBuffPerformance) do
      if DSBuffPerformanceFunc[dsBuffPerformanceType] ~= nil then
        DSBuffPerformanceFunc[dsBuffPerformanceType](self, dsEntity, cfg.removeDSBuffPerformanceParam[index])
      end
    end
  end
  self.dsEntity = nil
end

function DSBuff:OverlayBuff(dsEntity)
  if dsEntity ~= self.dsEntity then
    return
  end
  if DSOverlayBuffFunc[self.OverlayType] ~= nil then
    DSOverlayBuffFunc[self.OverlayType](self, dsEntity)
  end
  if self.OverlayDSBuffPerformance ~= nil then
    for index, dsBuffPerformanceType in ipairs(self.OverlayDSBuffPerformance) do
      if DSBuffPerformanceFunc[dsBuffPerformanceType] ~= nil then
        DSBuffPerformanceFunc[dsBuffPerformanceType](self, dsEntity, self.OverlayDSBuffPerformanceParam[index])
      end
    end
  end
end

function DSBuff:IsEnd(currentTime)
  if self:IsHasDuration() and self.endTime ~= nil and currentTime >= self.endTime then
    return true
  end
  return false
end

function DSBuff:Reset()
  self.DSbuffId = 0
  self.buffCfg = nil
  self.endTime = nil
  if self.effectList == nil then
    self.effectList = {}
  else
    for index, effect in ipairs(self.effectList) do
      CS_AnimationEffectController_Ins:KillEffect(effect)
      CS_AnimationEffectController_Ins:RecycleEffect(effect)
      self.effectList[index] = nil
    end
    table.clearmap(self.effectList)
  end
  if self.audiocallbackList == nil then
    self.audiocallbackList = {}
  else
    table.clearmap(self.audiocallbackList)
  end
end

return DSBuff
