local SuccessPanelUtils = {}

function SuccessPanelUtils.ShowAwakerVoice(voiceId, uiElement)
  if 0 == voiceId then
    return
  end
  local self = uiElement
  local voiceConfig = DT.Voice[voiceId]
  self.ui.Image_Gradient:SetActive(true)
  if self.binder then
    self.binder:SetText(self.ui.Text_Voice, voiceConfig.AwakerVoiceContent)
  else
    self:SetText(self.ui.Text_Voice, voiceConfig.AwakerVoiceContent)
  end
  local soundEventName = AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  local duration = AudioManager.Instance:GetEventLength(soundEventName)
  if self.showawakervoicetimer ~= nil then
    if self.binder then
      self.binder:StopTimer(self.showawakervoicetimer)
    else
      self:StopTimer(self.showawakervoicetimer)
    end
    self.showawakervoicetimer = nil
  end
  if self.binder then
    self.showawakervoicetimer = self.binder:BindTimer(duration, 1, nil, function()
      self.ui.Image_Gradient:SetActive(false)
    end)
  else
    self.showawakervoicetimer = self:BindTimer(duration, 1, nil, function()
      self.ui.Image_Gradient:SetActive(false)
    end)
  end
  AudioManager.Instance:PostSoundEvent(soundEventName)
end

return SuccessPanelUtils
