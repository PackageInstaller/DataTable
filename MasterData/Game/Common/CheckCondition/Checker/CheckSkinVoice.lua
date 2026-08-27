local CheckSkinVoice = {}

function CheckSkinVoice.LengthCheck(param)
  if 3 == #param then
    return true
  end
  return false
end

function CheckSkinVoice.ParamsCheck(param)
  local skinId = param[2]
  local voiceId = param[3]
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  if not cvCtr:HasSkinCv(skinId) then
    return true
  end
  if not cvCtr:IsExistVoiceId(voiceId) then
    return true
  end
  if PlayerDataCenter.skinData:IsHaveSkin(skinId) then
    return true
  end
  return false
end

function CheckSkinVoice.GetUnlockInfo(param)
  return string.format(ConfigData:GetTipContent(16001))
end

return CheckSkinVoice
