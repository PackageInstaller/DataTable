local AudioManager = {}
local CS_AudioManager = CS.AudioManager.Instance
local CS_GameData_Ins = CS.GameData.instance
AudioManager.AudioTypeCount = 3

function AudioManager:PlayAudio(cueName, cueSheetName, sourceType, completeEvent, ignoreSameBgm)
  if ignoreSameBgm == nil then
    ignoreSameBgm = true
  end
  return CS_AudioManager:PlayAudio(cueName, cueSheetName, sourceType, completeEvent, ignoreSameBgm)
end

function AudioManager:PlayAudioById(audioId, completeEvent, ignoreSameBgm)
  if audioId < 0 then
    return
  end
  if ignoreSameBgm == nil then
    return CS_AudioManager:PlayAudioById(audioId, completeEvent)
  else
    return CS_AudioManager:PlayAudioById(audioId, completeEvent, ignoreSameBgm)
  end
end

function AudioManager:PlayHitSelectorAudio(auSource, atcSelectorLableId, hitSelectorLableId)
  if auSource == nil or IsNull(auSource.Source) then
    return
  end
  local atcLable = eAuSelct.Atk_Mat.lables[atcSelectorLableId]
  if atcLable == nil then
    error("Cant get eAuSelct.Atk_Mat.lables, atcSelectorLableId = " .. tostring(atcSelectorLableId))
    return
  end
  local hitLable = eAuSelct.Hit_Mat.lables[hitSelectorLableId]
  if hitLable == nil then
    error("Cant get eAuSelct.Atk_Mat.lables, atcSelectorLableId = " .. tostring(atcSelectorLableId))
    return
  end
  local auBack = auSource:PlayAudioById(999)
  auSource:SetSelectorLabel(eAuSelct.Atk_Mat.name, atcLable)
  auSource:SetSelectorLabel(eAuSelct.Hit_Mat.name, hitLable)
  return auBack
end

function AudioManager:StopSource(sourceType)
  CS_AudioManager:StopSource(sourceType)
end

function AudioManager:StopAudioByBack(audioPlayback)
  CS_AudioManager:StopAudioByBack(audioPlayback)
end

function AudioManager:SetVolume(sourceType, volume)
  CS_AudioManager:SetVolume(sourceType, volume)
end

function AudioManager:PauseSource(sourceType, pause)
  CS_AudioManager:PauseSource(sourceType, pause)
end

function AudioManager:PauseAudioBack(audioPlayback, pause)
  CS_AudioManager:PauseAudioBack(audioPlayback, pause)
end

function AudioManager:GetVolume(sourceType)
  return CS_AudioManager:GetVolume(sourceType)
end

function AudioManager:RecordCurBgm()
  CS_AudioManager:RecordCurBgm()
end

function AudioManager:ResumeLastBgm()
  CS_AudioManager:ResumeLastBgm()
end

function AudioManager:SetSourceSelectorLabel(sourceType, selector, label)
  CS_AudioManager:SetSourceSelectorLabel(sourceType, selector, label)
end

function AudioManager:RemoveCueSheet(cueSheet)
  CS_AudioManager:RemoveCueSheet(cueSheet)
end

function AudioManager:RemoveCueSheetsWithPrefix(prefix)
  CS_AudioManager:RemoveCueSheetsWithPrefix(prefix)
end

function AudioManager:SetSourceAisacControl(sourceType, controlName, value)
  CS_AudioManager:SetSourceAisacControl(sourceType, controlName, value)
end

function AudioManager:SetBgmSourceFadeInAndOutTime(fadeInTime, fadeOutTime)
  CS_AudioManager:SetBgmSourceFadeInAndOutTime(fadeInTime, fadeOutTime)
end

function AudioManager:ResetBgmSourceFadeParam()
  CS_AudioManager:ResetBgmSourceFadeParam()
end

function AudioManager:RemoveBgmSourceFader()
  CS_AudioManager:RemoveBgmSourceFader()
end

function AudioManager:GetAudioPlayedTime(audioPlayback)
  return CS_AudioManager:GetAudioPlayedTime(audioPlayback)
end

function AudioManager:GetAudioLengthById(sheetName, cueName)
  return self:GetAudioLength(sheetName, cueName)
end

function AudioManager:GetAudioLength(sheetName, cueName)
  return CS_AudioManager:GetAudioLength(sheetName, cueName)
end

function AudioManager:GetAudioCfg(audioId)
  local auCfg = CS_GameData_Ins.listAudioCfg:GetDataById(audioId)
  if auCfg == nil then
    error("Cant find AudioCfg, id = " .. tostring(audioId))
    return nil
  end
  return auCfg
end

function AudioManager:RemoveAllVoice(removeLastCvHero)
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv)
  if cvCtr ~= nil then
    cvCtr:RemoveAllCvText()
    cvCtr:RemoveCvAllCueSheet(removeLastCvHero)
  end
end

return AudioManager
