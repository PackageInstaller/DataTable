_class("PetAudioModule", GameModule)
PetAudioModule = PetAudioModule

function PetAudioModule:RequestAdx2VoiceCueSheetByAnyAudioId(filed, petResId)
  if not USEADX2AUDIO then
    return
  end
  if petResId == nil or petResId <= 0 then
    Log.error("RequestVoiceCueSheetByAnyAudioId petId invalid petResId")
    return
  end
  local voiceId = self:MultiChooseOne(petResId, filed, nil, true, true)
  if voiceId == nil then
    Log.error("RequestVoiceCueSheetByAnyAudioId not find voice id :", voiceId, " petId:", petResId)
    return nil
  end
  AudioHelperController.RequestUIVoice(voiceId)
end

function PetAudioModule:ReleaseAdx2VoiceCueSheetByAnyAudioId(filed, petResId)
  if not USEADX2AUDIO then
    return
  end
  if petResId == nil or petResId <= 0 then
    Log.error("ReleaseAdx2VoiceCueSheetByAnyAudioId petId invalid petResId")
    return
  end
  local voiceId = self:MultiChooseOne(petResId, filed, nil, true, true)
  if voiceId == nil then
    Log.error("ReleaseAdx2VoiceCueSheetByAnyAudioId not find voice id :", voiceId, " petId:", petResId)
    return nil
  end
  AudioHelperController.ReleaseUIVoiceByAudioId(voiceId)
end

function PetAudioModule:PlayPetAudio(filed, petResId, notRand, bLoginVoice, voiceSkinID, click, replaceVoiceID)
  local rz, pro = self:FildPriority(petResId, filed)
  if rz ~= true then
    return nil
  end
  if petResId == nil then
    petResId = self.mRoleModule:GetResId()
  end
  local petData = self.mPetModule:GetPetByTemplateId(petResId)
  local voiceId = self:MultiChooseOne(petResId, filed, petData, notRand, bLoginVoice, voiceSkinID, click)
  if voiceId == nil then
    return nil
  end
  if replaceVoiceID then
    voiceId = replaceVoiceID
  end
  local oid = self:PlayAudio(voiceId)
  if oid == nil or oid == -1 then
    return nil
  end
  self.mCurrPetResId = petResId
  self.mCurFiled = filed
  self.mCurFiledPro = pro
  self.mCurrAudioResId = voiceId
  self.mCurId = oid
  self.mTimeFinish = nil
  if bLoginVoice then
    self.mLoginPlayerId = self.mCurId
  end
  if self.mTimeEvent ~= nil then
    GameGlobal.Timer():CancelEvent(self.mTimeEvent)
  end
  self.mTimeEvent = GameGlobal.Timer():AddEvent(self.SSGAPTIME, function()
    self.mTimeFinish = true
  end)
  return voiceId, self.mCurId
end

function PetAudioModule:RandomPlayPetLoginVoice()
  local cfg_pet_voice_table = Cfg.cfg_pet_voice({})
  local l_TotalNum = table.count(cfg_pet_voice_table)
  local l_random_num = math.random(l_TotalNum)
  local l_nIndex = 1
  local l_Key
  for key, value in pairs(cfg_pet_voice_table) do
    if l_nIndex == l_random_num then
      l_Key = key
      break
    end
    l_nIndex = l_nIndex + 1
  end
  if l_Key == nil then
    return
  end
  local l_template = Cfg.cfg_pet_voice[l_Key]
  if l_template == nil then
    return
  end
  local l_templateId = l_template.PetID
  self:PlayPetAudio("LoginVoice", l_templateId, false, true)
end

function PetAudioModule:StopAll()
  if self.mCurId == nil or self.mCurId == self.mLoginPlayerId then
    return
  end
  AudioHelperController.StopUIVoice(self.mCurId)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClosePetAudio, false)
  self:ClearData()
end

function PetAudioModule:IsUnLock(ruleId, petData)
  local condition = Cfg.pet_intimacy_condition[ruleId]
  if condition == nil then
    return false
  end
  if condition.ConditionType == PetIntimacyCondition.Affinity then
    if petData == nil then
      return false
    end
    if petData:GetPetAffinityLevel() < condition.Value then
      return false
    end
  elseif condition.ConditionType == PetIntimacyCondition.Grade then
    if petData == nil then
      return false
    end
    if petData:GetPetGrade() < condition.Value then
      return false
    end
  elseif condition.ConditionType == PetIntimacyCondition.Three then
    if petData == nil then
      return false
    end
    if not petData:IsFinishedStory(condition.Value) then
      return false
    end
  elseif condition.ConditionType == PetIntimacyCondition.Time then
    local curt = TodayPastTimeSec()
    if curt < condition.Value or curt > condition.Value2 then
      return false
    end
  elseif condition.ConditionType == PetIntimacyCondition.ServerTime then
    local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
    if not time_mod then
      return false
    end
    local tmSecond = math.floor(time_mod:GetServerTime() / 1000)
    if tmSecond < condition.Value or tmSecond > condition.Value2 then
      return false
    end
  elseif condition.ConditionType == PetIntimacyCondition.AffinityEqual then
    if petData == nil then
      return false
    end
    if petData:GetPetAffinityLevel() ~= condition.Value then
      return false
    end
  elseif condition.ConditionType == PetIntimacyCondition.DateLock then
    local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
    local tmSecond = math.floor(time_mod:GetServerTime() / 1000)
    local l_month = tonumber(os.date("%m", tmSecond))
    local l_day = tonumber(os.date("%d", tmSecond))
    if l_month ~= condition.Value or l_day ~= condition.Value2 then
      return
    end
  elseif condition.ConditionType == PetIntimacyCondition.SpeSkin then
    local skinid = condition.Value
    local petModule = GameGlobal.GetModule(PetModule)
    local haveSkin = petModule:HaveSkin(skinid)
    if not haveSkin then
      return false
    end
  end
  return true
end

function PetAudioModule:ClearData()
  self.mCurrPetResId = nil
  self.mCurFiled = nil
  self.mCurFiledPro = nil
  self.mCurrAudioResId = nil
  self.mCurId = nil
  self.mLoginPlayerId = nil
  if self.mTimeEvent ~= nil then
    GameGlobal.Timer():CancelEvent(self.mTimeEvent)
  end
  self.mTimeEvent = nil
  self.mTimeFinish = nil
end

function PetAudioModule:FildPriority(petResId, filed)
  if filed == nil then
    return false, nil
  end
  local cfgpvp = Cfg.cfg_pet_voice_priority[filed]
  if cfgpvp == nil then
    Log.error("cfg_pet_voice_priority ", filed, " error")
    return false, nil
  end
  if petResId == self.mCurrPetResId then
    if self.mCurFiled == filed then
      if self.mTimeFinish ~= true then
        return false, nil
      end
    elseif self.mCurFiledPro ~= nil and cfgpvp.Priority < self.mCurFiledPro then
      return false, nil
    end
  end
  return true, cfgpvp.Priority
end

function PetAudioModule:CheckPetDailyHasPlayAudio(petId, model)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local time_mod = GameGlobal.GetModule(SvrTimeModule)
  local tmSecond = math.floor(time_mod:GetServerTime() / 1000)
  local l_year = tonumber(os.date("%y", tmSecond))
  local l_month = tonumber(os.date("%m", tmSecond))
  local l_day = tonumber(os.date("%d", tmSecond))
  local key = pstId .. petId .. l_year .. l_month .. l_day .. model
  if UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  UnityEngine.PlayerPrefs.SetInt(key, 1)
  return nil
end

function PetAudioModule:MultiChooseOne(petResId, filed, petData, notRand, ignorePetData, voiceSkinID, click)
  local cfg_pet_voice_skin, checkSkinID
  if voiceSkinID then
    checkSkinID = voiceSkinID
  elseif petData then
    checkSkinID = petData:GetSkinId()
  end
  if petData then
    local cfgs = Cfg.cfg_pet_voice({PetID = petResId, SkinID = checkSkinID})
    if cfgs and next(cfgs) then
      cfg_pet_voice_skin = cfgs[1]
    else
      local _cfgs = Cfg.cfg_pet_voice({PetID = petResId, SkinID = nil})
      if _cfgs and next(_cfgs) then
        cfg_pet_voice_skin = _cfgs[1]
      end
    end
  else
    local _cfgs = Cfg.cfg_pet_voice({PetID = petResId, SkinID = nil})
    if _cfgs and next(_cfgs) then
      cfg_pet_voice_skin = _cfgs[1]
    end
  end
  if not cfg_pet_voice_skin then
    Log.debug("###[PetAudioModule] cfg_pet_voice_skin is nil ! id --> ", petResId)
    return
  end
  if click and filed == "MainLobbyInteract" then
    local cfgDaily = cfg_pet_voice_skin.MainLobbyDailyInteract
    if cfgDaily and #cfgDaily == 2 then
      local dailyVoiceId = cfgDaily[1]
      local condition = cfgDaily[2]
      if self:IsUnLock(condition, petData) then
        local hasPlay = self:CheckPetDailyHasPlayAudio(petResId, "mainlobby1")
        if not hasPlay then
          return dailyVoiceId
        end
      end
    end
  end
  local randomWight
  local cfg_priority = Cfg.cfg_pet_voice_priority[filed]
  if cfg_priority and cfg_priority.RandomType then
    randomWight = cfg_priority.RandomWeight
  end
  local cfgPetVoice
  local ids = {}
  local skinVal
  if cfg_pet_voice_skin and cfg_pet_voice_skin[filed] then
    skinVal = cfg_pet_voice_skin[filed]
  end
  if not skinVal then
    Log.error("###[PetAudioModule] skinVal is nil ! id --> ", petResId, " | filed --> ", filed)
    return
  end
  if type(skinVal) == "table" then
    for key, value in ipairs(skinVal) do
      if self.mCurrAudioResId == value[1] then
      elseif value[2] == nil or value[2] == -1 then
        local data = {}
        data.id = value[1]
        if value[3] then
          data.skin = true
        end
        table.insert(ids, data)
      elseif self:IsUnLock(value[2], petData) == true or ignorePetData == true then
        local data = {}
        data.id = value[1]
        if value[3] then
          data.skin = true
        end
        table.insert(ids, data)
      end
    end
  elseif type(skinVal) == "number" then
    return skinVal
  else
    Log.error("PetAudioModule:MultiChooseOne type error")
    return nil
  end
  if next(ids) then
    if notRand then
      local skinCfgList = Cfg.cfg_pet_skin({id = checkSkinID})
      if skinCfgList then
        local skinCfg = skinCfgList[1]
        if skinCfg and skinCfg.UnlockType then
          local baseSkin = table.icontains(skinCfg.UnlockType, PetSkinUnlockType.PSUT_BASE)
          if baseSkin then
            return ids[1].id
          end
        end
      end
      return ids[#ids].id
    end
    local skinWeight = 10
    if randomWight then
      skinWeight = randomWight[1]
    end
    local normWeight = 10
    if randomWight then
      normWeight = randomWight[2]
    end
    local weightList = {}
    local _weight = 0
    for i = 1, #ids do
      local data = ids[i]
      local unit = {}
      unit.id = data.id
      if data.skin then
        unit.weight = _weight + skinWeight
        _weight = _weight + skinWeight
      else
        unit.weight = _weight + normWeight
        _weight = _weight + normWeight
      end
      table.insert(weightList, unit)
    end
    local randomVal = math.random(1, _weight)
    for i = 1, #weightList do
      local unit = weightList[i]
      local weight = unit.weight
      if randomVal <= weight then
        return unit.id
      end
    end
  end
end

function PetAudioModule:PlayAudio(audioResId)
  if audioResId == nil then
    return nil
  end
  if self.mCurId ~= nil then
    AudioHelperController.StopUIVoice(self.mCurId, self.FADEOUTTIME)
  end
  local id = AudioHelperController.RequestAndPlayUIVoiceAutoRelease(audioResId)
  return id
end

function PetAudioModule:UIStateHandle(uiStateType)
  self:StopAll()
end

function PetAudioModule:Constructor()
  self.mCurrPetResId = nil
  self.mCurFiled = nil
  self.mCurFiledPro = nil
  self.mCurrAudioResId = nil
  self.mCurId = nil
  self.mLoginPlayerId = nil
  self.mTimeEvent = nil
  self.mTimeFinish = nil
  self.mRoleModule = nil
  self.mPetModule = nil
  self.SSGAPTIME = 1000
  self.FADEOUTTIME = 500
end

function PetAudioModule:Init()
  PetAudioModule.super.Init(self)
  self.mRoleModule = self:GetModule(RoleModule)
  self.mPetModule = self:GetModule(PetModule)
end

function PetAudioModule:Dispose()
  PetAudioModule.super.Dispose(self)
end

function PetAudioModule:Update()
  if self.mCurId == nil then
    return
  end
  local isPlaying = AudioHelperController.CheckUIVoicePlaying(self.mCurId)
  if isPlaying ~= false then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClosePetAudio, true)
  self:ClearData()
end
