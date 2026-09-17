local this = class("heroVoiceManager")
local charVoiceHeroTabTpl = L_GameTpl:getCharVoiceHeroTabTpl()
local voiceMap = {
  [L_Const.heroModuleType.Property] = "detailsVoice",
  [L_Const.heroModuleType.Skill] = "skillVoice",
  [L_Const.heroModuleType.Star] = "breakVoice",
  [L_Const.heroModuleType.SoulEssence] = "soulEssenceVoice",
  [L_Const.heroModuleType.Accessory] = "equipVoice",
  [L_Const.heroModuleType.Data] = "dataVoice",
  [L_Const.heroModuleType.Talent] = "talentVoice",
  [L_Const.heroModuleType.Present] = "dataVoice"
}
local delayMap = {
  [L_Const.heroModuleType.Property] = "detailsDelay",
  [L_Const.heroModuleType.Skill] = "skillDelay",
  [L_Const.heroModuleType.Star] = "breakDelay",
  [L_Const.heroModuleType.SoulEssence] = "soulEssenceDelay",
  [L_Const.heroModuleType.Accessory] = "equipDelay",
  [L_Const.heroModuleType.Data] = "dataDelay",
  [L_Const.heroModuleType.Talent] = "talentDelay",
  [L_Const.heroModuleType.Present] = "dataDelay"
}

function this:playHeroVoiceByConfigId(heroConifgId, moduleType)
  if not voiceMap[moduleType] or not delayMap[moduleType] then
    return
  end
  local voiceTpl = charVoiceHeroTabTpl:getTplById(heroConifgId)
  if not voiceTpl then
    errorf(string.format("英雄:%s char_voice_hero_tab表配置不存在", heroConifgId), 2)
    return
  end
  local audioEvent = voiceTpl[voiceMap[moduleType]]
  local delayTime = voiceTpl[delayMap[moduleType]]
  self:stopHeroVoice()
  if not math.isEmpty(delayTime) then
    self.voiceTimer = Timer.once(delayTime / 1000, function()
      self:playHeroVoice(audioEvent)
      printf("角色语音播放", string.format("角色: %s    语音: %s", heroConifgId, audioEvent))
      if self.voiceTimer then
        Timer.remove(self.voiceTimer)
        self.voiceTimer = nil
      end
    end, self)
  else
    self:playHeroVoice(audioEvent)
    printf("角色语音播放", string.format("角色: %s    语音: %s", heroConifgId, audioEvent))
  end
end

function this:playHeroVoice(audioEvent)
  self:stopHeroVoice()
  if not string.isEmpty(audioEvent) then
    self.curVoice = C_AudioManager.Play(audioEvent)
    self.curVoice:SetStopTransitionDuration(0)
    if L_CommonUtil.isValid(self.curVoice) then
      self.curVoice:SetAutoRelease(false)
    end
  end
end

function this:stopHeroVoice()
  if self.voiceTimer then
    Timer.remove(self.voiceTimer)
    self.voiceTimer = nil
  end
  if L_CommonUtil.isValid(self.curVoice) then
    C_AudioManager.FreeSource(self.curVoice)
  end
  self.curVoice = nil
end

function this:playHeroVoiceByUnitrule(voiceKey, isDefaultHero, voiceIndex, timerControl, entityCfgId)
  if not string.isEmpty(voiceKey) then
    isDefaultHero = isDefaultHero and true or false
    voiceIndex = math.isEmpty(voiceIndex) and 0 or voiceIndex
    timerControl = timerControl and true or false
    entityCfgId = math.isEmpty(entityCfgId) and 0 or entityCfgId
    self:stopHeroVoice()
    local warp = C_AliveVoiceManager.PlayEntityVoice(voiceKey, isDefaultHero, voiceIndex, timerControl, entityCfgId)
    if warp:IsValid() then
      self.curVoice = warp
    end
  end
end

return this
