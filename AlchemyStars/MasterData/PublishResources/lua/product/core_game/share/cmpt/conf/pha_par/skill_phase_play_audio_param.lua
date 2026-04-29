require("skill_phase_param_base")
_class("SkillPhasePlayAudioParam", SkillPhaseParamBase)
SkillPhasePlayAudioParam = SkillPhasePlayAudioParam

function SkillPhasePlayAudioParam:Constructor(t)
  self._audioType = t.audioType
  self._audioID = t.audioID
  self._atkSoundDelay = t.atkSoundDelay or 0
  self._longAtkSoundDelay = t.longAtkSoundDelay or 0
  self._slantAudioID = t.slantAudioID
  self._slantAtkSoundDelay = t.slantAtkSoundDelay or 0
  self._slantLongAtkSoundDelay = t.slantLongAtkSoundDelay or 0
  self._isLoop = t.isLoop
  if self._isLoop == nil then
    self._isLoop = false
  end
  self._isPlay = t.isPlay
  if self._isPlay == nil then
    self._isPlay = true
  end
end

function SkillPhasePlayAudioParam:GetPhaseType()
  return SkillViewPhaseType.PlayAudio
end

function SkillPhasePlayAudioParam:GetAudioID(isSlantAttack)
  if isSlantAttack then
    return self._slantAudioID
  end
  return self._audioID
end

function SkillPhasePlayAudioParam:GetSlantAudioID()
  return self._slantAudioID
end

function SkillPhasePlayAudioParam:GetAudioType()
  return self._audioType
end

function SkillPhasePlayAudioParam:IsLoopSkillAudio()
  return self._isLoop
end

function SkillPhasePlayAudioParam:IsPlaySkillAudio()
  return self._isPlay
end

function SkillPhasePlayAudioParam:GetSoundCacheTable()
  if not self._audioID or self._audioID <= 0 then
    return
  end
  if self._audioType == SkillAudioType.Cast or self._audioType == SkillAudioType.Hit then
    if self._slantAudioID then
      return {
        self._audioID,
        self._slantAudioID
      }
    else
      return {
        self._audioID
      }
    end
  end
end

function SkillPhasePlayAudioParam:GetVoiceCacheTable()
  if not self._audioID or self._audioID <= 0 then
    return
  end
  if self._audioType == SkillAudioType.Voice then
    return {
      self._audioID
    }
  end
end

function SkillPhasePlayAudioParam:GetCacheTable()
  return {}
end

function SkillPhasePlayAudioParam:GetSoundDelay(isFinalAttack, isSlantAttack)
  if isSlantAttack then
    if isFinalAttack then
      return self._slantLongAtkSoundDelay
    else
      return self._slantAtkSoundDelay
    end
  end
  if isFinalAttack then
    return self._longAtkSoundDelay
  else
    return self._atkSoundDelay
  end
end
