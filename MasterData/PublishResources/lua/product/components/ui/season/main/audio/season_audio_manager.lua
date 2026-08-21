_class("SeasonAudioManager", Object)
SeasonAudioManager = SeasonAudioManager

function SeasonAudioManager:Constructor()
end

function SeasonAudioManager:OnInit()
  self._seasonAudio = SeasonAudio:New()
end

function SeasonAudioManager:OnAfterInit()
  self._seasonAudio:OnAfterInit()
end

function SeasonAudioManager:Update(deltaTime)
  self._seasonAudio:Update(deltaTime)
end

function SeasonAudioManager:Dispose()
  self._seasonAudio:Dispose()
  self._seasonAudio = nil
end

function SeasonAudioManager:GetSeasonAudio()
  return self._seasonAudio
end
