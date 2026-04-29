_class("SeasonMazeAudioManager", Object)
SeasonMazeAudioManager = SeasonMazeAudioManager

function SeasonMazeAudioManager:Constructor()
end

function SeasonMazeAudioManager:OnInit()
  self._seasonMazeAudio = SeasonMazeAudio:New()
end

function SeasonMazeAudioManager:Update(deltaTime)
  self._seasonMazeAudio:Update(deltaTime)
end

function SeasonMazeAudioManager:Dispose()
  self._seasonMazeAudio:Dispose()
  self._seasonMazeAudio = nil
end

function SeasonMazeAudioManager:GetSeasonMazeAudio()
  return self._seasonMazeAudio
end
