local this = {}

function this:playVoice(cvType, index)
  local curCtrl = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if curCtrl then
  end
end

function this:playHeroVoice(heroId, cvType, index)
  self:stopHeroVoice()
  local heroTpl = L_GameTpl.getHeroTpl()
  local tpl = heroTpl:getTplById(heroId)
  local voice = heroTpl:getVoice(tpl)
  if not voice or voice == "" then
    return
  end
  local sConcat = string.concat
  local voiceEventName = sConcat("cv_", voice, "__", cvType)
  self.playingHeroCV = C_AudioManager.Play(voiceEventName)
  if L_CommonUtil.isValid(self.playingHeroCV) then
    self.playingHeroCV:SetAutoRelease(false)
  end
  return self.playingHeroCV
end

function this:stopHeroVoice()
  if L_CommonUtil.isValid(self.playingHeroCV) then
    C_AudioManager.FreeSource(self.playingHeroCV)
    self.playingHeroCV = nil
  end
end

return this
