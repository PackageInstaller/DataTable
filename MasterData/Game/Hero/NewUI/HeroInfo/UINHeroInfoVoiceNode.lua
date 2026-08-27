local UINHeroInfoVoiceNode = class("UINHeroInfoVoiceNode", UIBaseNode)
local base = UIBaseNode
local UISkinVoiceISelectItem = require("Game.Hero.NewUI.HeroInfo.UISkinVoiceISelectItem")
local UINHeroInfoVoiceNodeItem = require("Game.Hero.NewUI.HeroInfo.UINHeroInfoVoiceNodeItem")
local VowEnum = require("Game.VowSystem.Data.VowEnum")
local HeroVoiceEnum = require("Game.Hero.InfoAndVoice.HeroVoiceEnum")
local defaultSkinVoiceName = ConfigData:GetTipContent(16002)
local CS_Ease = CS.DG.Tweening.Ease

function UINHeroInfoVoiceNode:OnInit()
  self.__playStoryVoice = BindCallback(self, self.PlayStoryVoice)
  self.defaultVoiceDatas = nil
  self.skinVoiceDatas = nil
  self.isOpenVoiceFilter = false
  self.hasSkinVoice = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.skinVoiceItem:SetActive(false)
  self.voiceItemPool = UIItemPool.New(UINHeroInfoVoiceNodeItem, self.ui.friendShipItem)
  self.ui.friendShipItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_SwitchAudio, self, self.OnClickSwitchAudio)
end

function UINHeroInfoVoiceNode:GetCurrentSelectVoiceSkinId()
  return self.currentSelectVoiceSkinId
end

function UINHeroInfoVoiceNode:SetCurrentSelectVoiceSkinId(newSkinId)
  self.currentSelectVoiceSkinId = newSkinId
  return true
end

function UINHeroInfoVoiceNode:InitUsefulData(heroData, HeroInfoTextUtil)
  self.heroData = heroData
  self.defaultVoiceDatas = nil
  self.skinVoiceDatas = nil
  self:SetCurrentSelectVoiceSkinId(self:GetHeroId())
end

function UINHeroInfoVoiceNode:GetVoiceDatas()
  self:InitVoiceDatas()
  if not self.hasSkinVoice then
    return self.defaultVoiceDatas
  end
  if not self:IsSelectSkinVoiceFilter() then
    return self.defaultVoiceDatas
  end
  local skinId = self:GetCurrentSelectVoiceSkinId()
  return self.skinVoiceDatas[skinId]
end

function UINHeroInfoVoiceNode:InitVoiceDatas()
  local heroId = self:GetHeroId()
  local hasVoice = ControllerManager:GetController(ControllerTypeId.Cv, true):HasCv(heroId)
  if self.defaultVoiceDatas == nil then
    local defaultVoiceCfgList = ConfigData.audio_voice
    self.defaultVoiceDatas = self:GenerateVoiceDatas(defaultVoiceCfgList, heroId, heroId, hasVoice, false)
  end
  if self:HasSkinVoice() and self.skinVoiceDatas == nil then
    self.skinVoiceDatas = {}
    local skinVoiceIdList = ConfigData.audio_voice.skinVoice
    for skinId, voiceIdList in pairs(skinVoiceIdList) do
      local skinVOiceCfgList = {}
      for index, voiceId in ipairs(voiceIdList) do
        table.insert(skinVOiceCfgList, ConfigData.audio_voice[voiceId])
      end
      self.skinVoiceDatas[skinId] = self:GenerateVoiceDatas(skinVOiceCfgList, heroId, skinId, hasVoice, true)
    end
  end
end

function UINHeroInfoVoiceNode:GenerateVoiceDatas(cfgList, heroId, skinId, hasVoice, needSkinVoice)
  local voiceDatas = {}
  for key, cfg in pairs(cfgList) do
    if cfg.is_show > 0 then
      local isSkinVoice = cfg.exclusive_skin ~= nil and cfg.exclusive_skin ~= 0
      if isSkinVoice == needSkinVoice then
        local isNewVoice = not self.heroData:IsAudioListed(cfg.is_show)
        local isUnlock = CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
        local unlockInfo
        if not isUnlock then
          unlockInfo = CheckCondition.GetUnlockInfoLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
        end
        if isUnlock and cfg.extra_condition == HeroVoiceEnum.UnlockType.Vowed then
          isUnlock = self.heroData:GetHeroVowState() == VowEnum.EVowState.Vowed
          if not isUnlock then
            unlockInfo = ConfigData:GetTipContent(cfg.extra_lock_tip)
          end
        end
        table.insert(voiceDatas, {
          heroData = self.heroData,
          isNewVoice = isNewVoice,
          isUnlock = isUnlock,
          cfg = cfg,
          unlockInfo = unlockInfo,
          heroId = heroId,
          skinId = skinId,
          hasVoice = hasVoice
        })
      end
    end
  end
  return voiceDatas
end

function UINHeroInfoVoiceNode:InitHeroInfoNode()
  self:InitVoiceDatas()
  self:RefreshVoiceSkinData()
  self:RefreshBtnSwitchVoiceState()
  local currentSelectVoiceSkinName = self:GetCurrentVoiceSkinName()
  self:RefreshVoiceSkinBtnName(currentSelectVoiceSkinName)
  self:SortAllVoiceItem()
  self:RefreshAllVoiceItem()
end

function UINHeroInfoVoiceNode:GetHeroId()
  if self.heroData ~= nil then
    return self.heroData.dataId
  end
end

function UINHeroInfoVoiceNode:HasSkinVoice()
  return self.hasSkinVoice
end

function UINHeroInfoVoiceNode:RefreshVoiceSkinData()
  local heroId = self:GetHeroId()
  self.hasSkinVoice = ConfigData.audio_voice.heroVoiceSkinIdList[heroId] ~= nil
  self.isOpenVoiceFilter = false
  if not self.hasSkinVoice then
    return
  end
  self.voiceSkinIdList = ConfigData.audio_voice.heroVoiceSkinIdList[heroId]
  self.voiceSkinNameList = {}
  table.insert(self.voiceSkinNameList, defaultSkinVoiceName)
  for i = 2, #self.voiceSkinIdList do
    local skinId = self.voiceSkinIdList[i]
    local name = LanguageUtil.GetLocaleText(ConfigData.skin[skinId].name)
    table.insert(self.voiceSkinNameList, name)
  end
end

function UINHeroInfoVoiceNode:OnClickSwitchAudio()
  local hasSkinVoice = self:HasSkinVoice()
  if not hasSkinVoice then
    return
  end
  self.isOpenVoiceFilter = not self.isOpenVoiceFilter
  self:StopPlayVoice()
  self:ActiveSwitchVoiceList(self.isOpenVoiceFilter)
  self:RefreshAllVoiceItem()
end

function UINHeroInfoVoiceNode:ActiveSwitchVoiceList(active)
  self.ui.switchSkinVoiceList:SetActive(active)
  self.ui.img_Arrow.localEulerAngles = active and Vector3.New(0, 0, 90) or Vector3.New(180, 0, 90)
  if active then
    self:RefreshSkinVoiceList(self.voiceSkinNameList, self.voiceSkinIdList)
  else
    self:HideAllSkinVoiceSelectItem()
  end
end

function UINHeroInfoVoiceNode:RefreshSkinVoiceList(skinNameList, skinIdList)
  for index, value in ipairs(skinNameList) do
    local skinName = skinNameList[index]
    local skinId = skinIdList[index]
    if self.skinVoiceSelectItemPool == nil then
      self.skinVoiceSelectItemPool = UIItemPool.New(UISkinVoiceISelectItem, self.ui.skinVoiceItem)
    end
    local skinVoiceSelectItem = self.skinVoiceSelectItemPool:GetOne()
    
    local function __SelectSkinVoice(skinId, index)
      self:SelectSkinVoice(skinId, index)
    end
    
    skinVoiceSelectItem:InitVoiceSelectItem(skinName, skinId, index, __SelectSkinVoice)
  end
end

function UINHeroInfoVoiceNode:SelectSkinVoice(skinId, index)
  self:SetCurrentSelectVoiceSkinId(skinId)
  self.isOpenVoiceFilter = false
  local name = self.voiceSkinNameList[index]
  self:StopPlayVoice()
  self:RefreshVoiceSkinBtnName(name)
  self:ActiveSwitchVoiceList(false)
  self:InitHeroInfoNode()
end

function UINHeroInfoVoiceNode:HideAllSkinVoiceSelectItem()
  if self.skinVoiceSelectItemPool ~= nil then
    self.skinVoiceSelectItemPool:HideAll()
  end
end

function UINHeroInfoVoiceNode:GetCurrentVoiceSkinName()
  if self.voiceSkinNameList == nil then
    return defaultSkinVoiceName
  end
  if not self.hasSkinVoice then
    return defaultSkinVoiceName
  end
  if not self:IsSelectSkinVoiceFilter() then
    return defaultSkinVoiceName
  end
  local currentSelectVoiceSkinId = self:GetCurrentSelectVoiceSkinId()
  local index = self:GetSkinVoiceIndexBySkinId(currentSelectVoiceSkinId)
  return self.voiceSkinNameList[index]
end

function UINHeroInfoVoiceNode:GetSkinVoiceIndexBySkinId(skinId)
  if self.voiceSkinIdList == nil then
    return 1
  end
  for index, value in ipairs(self.voiceSkinIdList) do
    if self.voiceSkinIdList[index] == skinId then
      return index
    end
  end
  return 1
end

function UINHeroInfoVoiceNode:IsSelectSkinVoiceFilter()
  if not self.hasSkinVoice then
    return false
  end
  local currentSelectVoiceSkinId = self:GetCurrentSelectVoiceSkinId()
  if currentSelectVoiceSkinId ~= nil and currentSelectVoiceSkinId ~= self:GetHeroId() then
    return true
  end
  return false
end

function UINHeroInfoVoiceNode:RefreshVoiceSkinBtnName(name)
  self.ui.text_SwitchAudio.text = name
end

function UINHeroInfoVoiceNode:RefreshBtnSwitchVoiceState()
  self.ui.btn_SwitchAudioParent:SetActive(self.hasSkinVoice)
  self.ui.switchSkinVoiceList:SetActive(self.isOpenVoiceFilter)
end

function UINHeroInfoVoiceNode:SortAllVoiceItem()
  local function sortFunc(a, b)
    return a.cfg.is_show < b.cfg.is_show
  end
  
  local voiceDatas = self:GetVoiceDatas()
  table.sort(voiceDatas, sortFunc)
end

function UINHeroInfoVoiceNode:RefreshAllVoiceItem()
  self.voiceItemPool:HideAll()
  if self.isOpenVoiceFilter then
    return
  end
  local voiceDatas = self:GetVoiceDatas()
  for _, voiceData in ipairs(voiceDatas) do
    if self.heroData.dataId == voiceData.cfg.exclusive_hero or voiceData.cfg.exclusive_hero == 0 then
      local item = self.voiceItemPool:GetOne()
      item:InitHeroInfoNodeItem(voiceData, self.__playStoryVoice)
    end
  end
end

function UINHeroInfoVoiceNode:PlayStoryVoice(heroId, skinId, voiceId, playerRateCallback, playOverCallback)
  local CVController = ControllerManager:GetController(ControllerTypeId.Cv, true)
  if self.isPlayingVoice and self.AudioPlayback ~= nil then
    AudioManager:StopAudioByBack(self.AudioPlayback)
    self.AudioPlayback = nil
    self:__HideVoiceWords()
    if self.playOverCallback ~= nil then
      self.playOverCallback()
    end
    TimerManager:StopTimer(self.playerRateTimerId)
    self.playerRateTimerId = nil
    if self.playerRateCallback ~= nil then
      self.playerRateCallback(0)
    end
  end
  if self.__isShowingCvTextWithoutVoice then
    self.playerRateCallback(0)
    self.__isShowingCvTextWithoutVoice = false
  end
  self.playOverCallback = playOverCallback
  self.playerRateCallback = playerRateCallback
  if not CVController:HasCv(heroId) then
    self.__isShowingCvTextWithoutVoice = true
    local audioText = CVController:GetCvText(heroId, voiceId)
    local audioLength = CVController:GetVoiceLength(heroId, voiceId)
    local voiceTextDuration = audioLength / 1000
    self:ShowHeroVoiceText(true, audioText, true, voiceTextDuration)
    self.playerRateCallback(1)
    return
  end
  self:ClearNoAudioTimer()
  local no_voiceCfg = ConfigData.audio_no_voice.heroNotHaveVoiceDataList[heroId]
  if no_voiceCfg ~= nil then
    if no_voiceCfg[voiceId] == false then
      return
    elseif no_voiceCfg[voiceId] then
      local audioText = CVController:GetCvText(heroId, voiceId, skinId)
      local textCount = math.ceil(string.len(audioText) / 3)
      local duration = textCount / 10
      if duration < 3 then
        duration = 3
      end
      self.ui.voiceScrollRect.verticalNormalizedPosition = 1
      self:ShowNoAudioDialog(audioText, duration)
      self.noAudioTimer = TimerManager:StartTimer(duration, function()
        self:ClearNoAudioTimer()
        self:ShowHeroVoiceText(false)
      end)
      return
    end
  end
  self.isPlayingVoice = true
  if skinId == nil then
    skinId = self:GetCurrentSelectVoiceSkinId()
  end
  self.AudioPlayback = CVController:PlayCv(heroId, voiceId, function()
    self.AudioPlayback = nil
    self.isPlayingVoice = false
    self:__HideVoiceWords()
    if self.playOverCallback ~= nil then
      self.playOverCallback()
    end
    TimerManager:StopTimer(self.playerRateTimerId)
    self.playerRateTimerId = nil
    if self.playerRateCallback ~= nil then
      self.playerRateCallback(0)
    end
  end, nil, skinId)
  local sheetName, cueName = CVController:GetSheetNameAndCueName(heroId, voiceId, skinId)
  
  local function RefreshPlayRate()
    local curLength = 0
    local totalLength = 1
    if self.AudioPlayback ~= nil then
      totalLength = AudioManager:GetAudioLengthById(sheetName, cueName)
      curLength = AudioManager:GetAudioPlayedTime(self.AudioPlayback)
    end
    if self.playerRateCallback ~= nil then
      self.playerRateCallback(curLength / totalLength)
    end
  end
  
  RefreshPlayRate()
  self.playerRateTimerId = TimerManager:StartTimer(0.0167, function()
    RefreshPlayRate()
  end, self, false, false, false)
  local audioText = CVController:GetCvText(heroId, voiceId, skinId)
  local audioLength = CVController:GetVoiceLength(heroId, voiceId, skinId)
  local voiceTextDuration = audioLength / 1000
  self:ShowHeroVoiceText(true, audioText, false, voiceTextDuration)
end

function UINHeroInfoVoiceNode:__ShowVoiceWords(text, notNeedWave)
  self.ui.tex_VoiceDialog.text = text
  self.ui.obj_imgwave:SetActive(not notNeedWave)
  self.ui.obj_ani_VoiceIcon:SetActive(not notNeedWave)
  self.ui.voiceDialog:SetActive(true)
end

function UINHeroInfoVoiceNode:ShowHeroVoiceText(show, text, notShowWave, voiceDuration)
  self.ui.voiceScrollRect:DOKill()
  if self._heroVoiceTextTimerId ~= nil then
    TimerManager:StopTimer(self._heroVoiceTextTimerId)
    self._heroVoiceTextTimerId = nil
  end
  if show then
    self.ui.tex_VoiceDialog.text = text
    self.ui.voiceScrollRect.verticalNormalizedPosition = 1
    self._heroVoiceTextTimerId = TimerManager:StartTimer(1, function()
      self._heroVoiceTextTimerId = nil
      if voiceDuration <= 0 or self.ui.tex_VoiceDialog.transform.rect.height <= self.ui.voiceScrollRect.transform.rect.height then
        return
      end
      local duration = voiceDuration * 0.8
      local delay = voiceDuration * 0.1
      self.ui.voiceScrollRect:DOVerticalNormalizedPos(0, duration):SetLink(self.ui.voiceScrollRect.gameObject):SetDelay(delay):SetEase(CS_Ease.Linear)
    end, nil, true, true, true)
  end
  self.ui.obj_ani_VoiceIcon:SetActive(show and not notShowWave)
  self.ui.obj_imgwave:SetActive(show and not notShowWave)
  self.ui.voiceScrollRect.gameObject:SetActive(show)
  self.ui.voiceDialog:SetActive(show)
end

function UINHeroInfoVoiceNode:ShowNoAudioDialog(text, textDuration)
  self.ui.voiceScrollRect:DOKill()
  if self._heroVoiceTextTimerId ~= nil then
    TimerManager:StopTimer(self._heroVoiceTextTimerId)
    self._heroVoiceTextTimerId = nil
  end
  self.ui.tex_VoiceDialog.text = text
  self.ui.obj_ani_VoiceIcon:SetActive(false)
  self.ui.obj_imgwave:SetActive(false)
  self.ui.voiceScrollRect.gameObject:SetActive(true)
  self.ui.voiceDialog:SetActive(true)
  local delay = textDuration * 0.1
  local duration = textDuration * 0.8
  self._heroVoiceTextTimerId = TimerManager:StartTimer(1, function()
    self._heroVoiceTextTimerId = nil
    self.ui.voiceScrollRect:DOVerticalNormalizedPos(0, duration):SetLink(self.ui.voiceScrollRect.gameObject):SetDelay(delay):SetEase(CS_Ease.Linear)
  end, nil, true, true, true)
end

function UINHeroInfoVoiceNode:__HideVoiceWords()
  if self.ui == nil or self.ui.voiceDialog == nil then
    return
  end
  self.ui.voiceDialog:SetActive(false)
end

function UINHeroInfoVoiceNode:StopPlayVoice()
  self:ShowHeroVoiceText(false)
  if self.isPlayingVoice and self.AudioPlayback ~= nil then
    AudioManager:StopAudioByBack(self.AudioPlayback)
    self.AudioPlayback = nil
    self:__HideVoiceWords()
    if self.playOverCallback ~= nil then
      self.playOverCallback()
      self.playOverCallback = nil
    end
    TimerManager:StopTimer(self.playerRateTimerId)
    self.playerRateTimerId = nil
    if self.playerRateCallback ~= nil then
      self.playerRateCallback(0)
      self.playerRateCallback = nil
    end
  end
  if self.__isShowingCvTextWithoutVoice then
    self:__HideVoiceWords()
    self.playerRateCallback(0)
    self.__isShowingCvTextWithoutVoice = false
  end
end

function UINHeroInfoVoiceNode:ClearNoAudioTimer()
  if self.noAudioTimer ~= nil then
    TimerManager:StopTimer(self.noAudioTimer)
    self.noAudioTimer = nil
  end
end

function UINHeroInfoVoiceNode:OnHide()
  if self.__isShowingCvTextWithoutVoice then
    self:__HideVoiceWords()
    self.playerRateCallback(0)
    self.__isShowingCvTextWithoutVoice = false
  end
  if self.skinVoiceSelectItemPool ~= nil then
    self.skinVoiceSelectItemPool:HideAll()
  end
  self:ShowHeroVoiceText(false)
  base.OnHide(self)
end

function UINHeroInfoVoiceNode:OnTcpLogOut_HeroInfoNode()
  TimerManager:StopTimer(self.playerRateTimerId)
  self.playerRateTimerId = nil
end

function UINHeroInfoVoiceNode:OnDelete()
  TimerManager:StopTimer(self.playerRateTimerId)
  self.playerRateTimerId = nil
  self:ClearNoAudioTimer()
  self:SetCurrentSelectVoiceSkinId(nil)
  if self.skinVoiceSelectItemPool ~= nil then
    self.skinVoiceSelectItemPool:DeleteAll()
    self.skinVoiceSelectItemPool = nil
  end
  if self.voiceItemPool ~= nil then
    self.voiceItemPool:DeleteAll()
    self.voiceItemPool = nil
  end
  base.OnDelete(self)
end

return UINHeroInfoVoiceNode
