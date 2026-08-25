local AudioManager, Super = System.NewClass("AudioManager", Manager, IUpdater)
local isShowLog = true
if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.WindowsEditor then
  isShowLog = false
end
local VolArray = {
  CommonDefine.rtpcWwiseName.Main,
  CommonDefine.rtpcWwiseName.Mus,
  CommonDefine.rtpcWwiseName.Sfx,
  CommonDefine.rtpcWwiseName.Voc
}

function AudioManager:ctor()
  Super.ctor(self)
  
  function CS.EffectAudioMgr.PlayAudio(eventName)
    self:PostSoundEvent(eventName)
  end
  
  function CS.EffectAudioMgr.StopAudio(eventName)
    self:StopPlayingSound(eventName)
  end
  
  if CS.AkUnitySoundEngine.IsInitialized() then
    CS.AkUnitySoundEngine.Term()
  end
  self._isMute = false
  self._volumes = {}
  self.initBankPath = nil
  if not ApplicationUtils.is_editor_mode() then
    local downLoadPath = CS.ResourceManager.DownloadHelper.GetDownloadPathDefault() .. "/" .. "Audio/GeneratedSoundBanks/"
    if ApplicationUtils.IsAndroid() then
      self.initBankPath = downLoadPath .. "Android/Init.bnk"
    elseif ApplicationUtils.IsIOS() then
      self.initBankPath = downLoadPath .. "iOS/Init.bnk"
    else
      self.initBankPath = downLoadPath .. "Windows/Init.bnk"
    end
  end
  if self.initBankPath then
    local targetPath = CS.UnityEngine.Application.persistentDataPath .. "/Init.bnk"
    pcall(ApplicationUtils.CopyFile, self.initBankPath, targetPath)
  end
  self.isAddBasePath = false
  self.wwiseManager = CS.UnityEngine.GameObject.Find("GameApp"):GetComponent(typeof(CS.WwiseManager.WwiseManager))
  if not self.wwiseManager then
    self.wwiseManager = CS.UnityEngine.GameObject.Find("GameApp"):AddComponent(typeof(CS.WwiseManager.WwiseManager))
  end
  self.loadedBankName = {}
  self.eventSoundDict = {}
  self.isRot = false
  self.unLoadBankNameTimer = {}
  self.cameraTransform = UIRootMgr.GetMainCamera().gameObject.transform
  self.curBgm = nil
  self._cacheEvents = nil
  self.wwiseManager:SetPernamant("Globle_Common.bnk", true)
end

function AudioManager:Awake(binder)
  Super.Awake(self)
  self.wwiseManager:Init()
  self.wwiseManager:SetCurrentSoundLanguage("Japanese")
  self:PreDealCfg()
  self:SetSoundVolume()
  binder:BindEvent(EventMgr.Instance.CSAudioEvent, function(eventName)
    self:PostSoundEvent(eventName)
  end)
end

function AudioManager:PreDealCfg()
  local soundEventMap = {}
  for _, info in pairs(DT.AudioConfig) do
    soundEventMap[info.ID] = info.WwiseEvent
    if info.SoundId then
      soundEventMap[info.SoundId] = info.WwiseEvent
    end
  end
  self.cfgSoundEventMap = soundEventMap
end

function AudioManager:GetEventLength(evtName)
  if not self.wwiseManager then
    return 0
  end
  do return self.wwiseManager.GetEventLength, self.wwiseManager end
  return self.wwiseManager.GetEventLength, self.wwiseManager, evtName
end

function AudioManager:SetSoundVolume()
  for _, v in pairs(VolArray) do
    local localStorageVal = MobileFileDataManager.Instance:GetCommFileValue(CommonDefine.LocalSaveKeyCommon.AudioPrefix .. v .. "_val")
    local tmpVal = localStorageVal and tonumber(localStorageVal) or 100
    local vol = tmpVal * 10
    self:SetRTPCValueByName(v, self._isMute and 0 or vol)
    self._volumes[v] = vol
  end
end

function AudioManager:MuteAllEvents(isMute)
  if self._isMute == isMute then
    return
  end
  self._isMute = isMute
  for _, v in pairs(VolArray) do
    if self._volumes[v] then
      local val = self._isMute and 0 or self._volumes[v]
      self:SetRTPCValueByName(v, val)
    end
  end
end

function AudioManager:CheckAudioBank(eventName, eventData)
  local bankCfg = DT.AudioBank
  for bankName, cfg in pairs(bankCfg) do
    if cfg.LoadTime and table.contains(cfg.LoadTime, eventName) then
      self:LoadSoundBank(bankName)
    end
    if cfg.UnloadTime and table.contains(cfg.UnloadTime, eventName) then
      self:UnloadSoundBank(bankName)
    end
  end
end

function AudioManager:LoadSoundBank(bankName)
  self:CancelUnloadTimer(bankName)
  if not self.loadedBankName[bankName] then
    local result = self.wwiseManager:LoadSoundBank(bankName)
    if result then
      self.loadedBankName[bankName] = true
      self:Log("[AudioManager] 成功加载SoundBank:" .. bankName)
    else
      self:Log("[AudioManager] 未能顺利加载SoundBank:" .. bankName)
    end
    return result
  end
  self:Log("[AudioManager] 已加载SoundBank:" .. bankName)
  return true
end

function AudioManager:UnloadSoundBank(bankName, delay)
  local function unloadImpl()
    if not self.loadedBankName[bankName] then
      return
    end
    self:Log("[AudioManager] 卸载SoundBank: ", bankName)
    self.wwiseManager:UnLoadSoundBank(bankName)
    self.loadedBankName[bankName] = nil
  end
  
  self:CancelUnloadTimer(bankName)
  if delay and 0 ~= delay then
    local timerId = TimerManager.Instance:CreateTimer(delay, 0, nil, function()
      unloadImpl()
    end)
    self.unLoadBankNameTimer[bankName] = timerId
  else
    unloadImpl()
  end
end

function AudioManager:CancelUnloadTimer(bankName)
  if self.unLoadBankNameTimer[bankName] then
    TimerManager.Instance:StopTimer(self.unLoadBankNameTimer[bankName])
    self.unLoadBankNameTimer[bankName] = nil
  end
end

function AudioManager:ClearAllSound()
  self.wwiseManager:SetPernamant("Globle_Common.bnk", false)
  self.wwiseManager:ClearBanks()
  for k in pairs(self.eventSoundDict) do
    self.eventSoundDict[k] = nil
  end
  self._isMute = false
  self._cacheEvents = nil
  self.loadedBankName = {}
  self.eventSoundDict = {}
end

function AudioManager:StopAll()
  self._cacheEvents = nil
  if not self.wwiseManager or not self.wwiseManager:IsInitialized() then
    return
  end
  self.wwiseManager:StopAll()
end

function AudioManager:PlayBGM(bgm)
  self.curBgm = bgm
  self:PostSoundEvent(bgm)
end

function AudioManager:GetCurBgm()
  return self.curBgm
end

function AudioManager:StopBGM()
  if self.curBgm then
    self:StopPlayingSound(self.curBgm)
    self.curBgm = nil
  end
end

function AudioManager:GetEventDuration(eventName)
  return self:GetEventLength(eventName) or 0
end

function AudioManager:CheckIsPlayingBGM()
  return self.curBgm and self.curBgm ~= ""
end

function AudioManager:HasSoundEvent(eventName)
  return self.cfgSoundEventMap[eventName]
end

function AudioManager:_FixBasePath()
  if self.isAddBasePath then
    return
  end
  self.isAddBasePath = true
  CS.AkUnitySoundEngine.AddBasePath(CS.WwiseManager.WwiseManager.OutBankPath)
end

function AudioManager:Update()
  if self._cacheEvents then
    if not self.wwiseManager or not self.wwiseManager:IsInitialized() then
      return
    end
    for i = 1, #self._cacheEvents do
      local evtCfg = self._cacheEvents[i]
      if evtCfg then
        self:PostSoundEvent(evtCfg.eventName, evtCfg.gameObject, evtCfg.delay)
      end
    end
    self._cacheEvents = nil
  end
end

function AudioManager:PostSoundEvent(eventName, gameObject, delay)
  if not self.wwiseManager or not self.wwiseManager:IsInitialized() then
    self._cacheEvents = self._cacheEvents or {}
    table.insert(self._cacheEvents, {
      eventName = eventName,
      gameObject = gameObject,
      delay = delay
    })
    return
  end
  self:_FixBasePath()
  if not eventName or "" == eventName or "table" == type(eventName) or "" == string.replace(eventName, " ", "") then
    return
  end
  if self.cfgSoundEventMap[eventName] then
    self:Log("[AudioManager] play cfg event name: " .. eventName)
    local defaultBgMusicId = ConstantCfgUtils.GetDefaultBgMusicId()
    local bgMusicId = ClientDataUtils.GetData(cd.ClientDataMainKey.AVG, "MainBgMusicTid", defaultBgMusicId)
    local eventList
    if "MAININTERFACE_MUSIC" == eventName and defaultBgMusicId ~= bgMusicId then
      local musicCfg = ArtCollectionModel.Instance:GetCfg(bgMusicId)
      eventList = {
        musicCfg.Video,
        "Set_State_Aa_00None"
      }
    else
      eventList = self.cfgSoundEventMap[eventName]
    end
    for _, _eventName in ipairs(eventList or {}) do
      self:PostSoundEvent(_eventName, gameObject, delay)
    end
    return
  end
  self:Log("[AudioManager] play sound event name: " .. eventName)
  local soundId = 0
  
  local function PlaySound()
    if gameObject and IsNil(gameObject) then
      return
    end
    soundId = self.wwiseManager:PlaySound(eventName, gameObject)
    if self.eventSoundDict[eventName] == nil then
      self.eventSoundDict[eventName] = soundId
    end
    if soundId == CS.AkUnitySoundEngine.AK_INVALID_PLAYING_ID then
      self:Log("[AudioManager] event %s is invalid", eventName)
      local bankName = self.wwiseManager:GetBankOfEvent(eventName)
      if bankName then
        for i = 1, 5 do
          self.wwiseManager:UnLoadSoundBank(bankName)
        end
      end
    end
  end
  
  if delay and delay > 0 then
    local timerStart
    timerStart = TimerManager.Instance:CreateTimer(delay / 1000, 1, nil, function()
      TimerManager.Instance:StopTimer(timerStart)
      PlaySound()
    end)
  else
    PlaySound()
  end
  return soundId
end

function AudioManager:UnloadSoundEvent(soundEVent, delay)
end

function AudioManager:StopPlayingSoundById(soundId)
  self.wwiseManager:StopSound(soundId)
  self:Log(string.format("[AudioManager] Stop Play soundId: %d", soundId))
end

function AudioManager:StopPlayingSound(eventName)
  local soundId = self.eventSoundDict[eventName]
  if soundId then
    self.wwiseManager:StopSound(soundId)
    self.eventSoundDict[eventName] = nil
    self:Log(string.format([[
[AudioManager] Stop Play Sound: %s
 soundId: %d]], eventName, soundId))
  end
end

function AudioManager:OnDestroy()
  CS.EffectAudioMgr.StopAudio = nil
  CS.EffectAudioMgr.PlayAudio = nil
  self._cacheEvents = nil
  self._isMute = false
  self:ClearAllSound()
  self.wwiseManager:Destory()
  Super.OnDestroy(self)
  self.cameraTransform = nil
end

function AudioManager:GetDefaultListener()
  do return self.wwiseManager.GetDefaultListener end
  return self.wwiseManager.GetDefaultListener, self.wwiseManager
end

function AudioManager:SetListenerOffsetPosition(x, y, z)
  self.wwiseManager:SetListenerOffsetPosition(x, y, z)
end

function AudioManager:SetListenerOffsetMode(isRot)
  self.isRot = isRot
end

function AudioManager:UpdateListenerPos()
  assert(self.cameraTransform ~= nil, "cameraTransform is nil in AudioManager.UpdateListenerPos")
  local localPosition = self.cameraTransform.localPosition
  if self.isRot then
    self:SetListenerOffsetPosition(0, -localPosition.y, -localPosition.z)
  else
    self:SetListenerOffsetPosition(0, -localPosition.z, localPosition.y)
  end
end

function AudioManager:GetLoadedBanks()
  return self.loadedBankName
end

function AudioManager:IsBankGroupLoaded(tid)
  return self.loadedBankGroup[tid] ~= nil
end

function AudioManager:SetRTPCValueByName(rtpcName, val, gameObject)
  self.wwiseManager:SetRTPCValueByName(rtpcName, val, gameObject)
end

function AudioManager:HasLoadedBankGroup(id)
  return self.loadedBankGroup[id]
end

function AudioManager:HasLoadedBankName(id)
  return self.loadedBankName[id]
end

function AudioManager:Log(...)
  if isShowLog then
    Logger.Debug(...)
  end
end

function AudioManager:PrintLoadedBank()
  local content = "当前AudoBank: \n"
  for bankName, v in pairs(self.loadedBankName) do
    local bankCfg = DT.AudioBank[bankName]
    if bankCfg then
      content = string.format("%s%s\n", content, string.format("bankName: %s, loadTime: %s, unloadTime: %s", bankName, table.tostring(bankCfg.LoadTime or {}), table.tostring(bankCfg.UnloadTime or {})))
    else
      content = string.format("%s%s\n", content, string.format("bankName: %s", bankName))
    end
  end
  Logger.Info(content)
end

function AudioManager:PostEnchantUpgradeSound(enchantQuality)
  if enchantQuality == CommonDefine.EnchantQuality.White then
    self:PostSoundEvent("CARD_ENCHANT_NORMAL")
  elseif enchantQuality == CommonDefine.EnchantQuality.Red then
    self:PostSoundEvent("CARD_ENCHANT_DEBUFF")
  elseif enchantQuality == CommonDefine.EnchantQuality.Orange then
    self:PostSoundEvent("CARD_ENCHANT_ADVANCED")
  end
end

return AudioManager
