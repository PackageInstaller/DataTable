require("skill_phase_param_base")
_class("SkillPhasePlayLoopAudioParam", SkillPhaseParamBase)
SkillPhasePlayLoopAudioParam = SkillPhasePlayLoopAudioParam

function SkillPhasePlayLoopAudioParam:Constructor(t)
  self._audioID = t.audioID
  self._isPlay = t.isPlay
  if self._isPlay == nil then
    self._isPlay = true
  end
end

function SkillPhasePlayLoopAudioParam:GetPhaseType()
  return SkillViewPhaseType.PlayLoopAudio
end

function SkillPhasePlayLoopAudioParam:GetAudioID()
  return self._audioID
end

function SkillPhasePlayLoopAudioParam:IsPlayLoopAudio()
  return self._isPlay
end

function SkillPhasePlayLoopAudioParam:GetSoundCacheTable()
  if not self._audioID or self._audioID <= 0 then
    return
  end
  return {
    self._audioID
  }
end

function SkillPhasePlayLoopAudioParam:GetCacheTable()
  return {}
end
