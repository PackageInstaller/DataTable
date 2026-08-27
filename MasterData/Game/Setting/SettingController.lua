local SettingController = class("SettingController", ControllerBase)
local rapidjson = require("rapidjson")
local cs_RenderManager = CS.RenderManager.Instance
local cs_QualitySettings = CS.UnityEngine.QualitySettings

function SettingController:OnInit()
  if self.__OnSceneUnload ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnSceneUnload, self.__OnSceneUnload)
  end
  self.__OnSceneUnload = BindCallback(self, self.OnSceneUnload)
  MsgCenter:AddListener(eMsgEventId.OnSceneUnload, self.__OnSceneUnload)
end

function SettingController:InitSettingData()
  PersistentManager:LoadAndDecodeData(PersistentConfig.ePackage.SystemData)
  local audioSetting = self:GetSettingAudioData()
  local cs_AudioManager = CS.AudioManager.Instance
  for index = 1, AudioManager.AudioTypeCount do
    cs_AudioManager:SetVolume(index, audioSetting.volumes[index])
    CS.AudioManager.Instance:SetMute(index, audioSetting.globalMute)
  end
  cs_RenderManager:ResetRenderSetting()
  local systemSaveData = self:GetSystemSaveData()
  self:SetResolutionIndex(systemSaveData:GetDisplaySettingValue("resolution"))
  self:SetTextureLimit(systemSaveData:GetDisplaySettingValue("texture_limit"))
  self:SetFrameRateIndex(systemSaveData:GetDisplaySettingValue("frame_rate"))
  self:SetDynShadowIndex(systemSaveData:GetDisplaySettingValue("dyn_shadow"))
  self:SetAntiAliasingIndex(systemSaveData:GetDisplaySettingValue("anti_aliasing"))
  self:SetEffectQuality(systemSaveData:GetDisplaySettingValue("effect_quality"))
  self:SetModelQuality(systemSaveData:GetDisplaySettingValue("model_quality"))
  self:SetOutlineIndex(systemSaveData:GetDisplaySettingValue("outline"))
  self:SetPostEffect(systemSaveData:GetDisplaySettingValue("post_effect"))
  self:SetOpenLittleManIndex(systemSaveData:GetDisplaySettingValue("open_little_man"))
  self:SetOpenWeatherIndex(systemSaveData:GetDisplaySettingValue("open_weather"))
  self:RefreshSettingReddot()
  systemSaveData:TryClearDecryptedHotRes(CS.ClientConsts.GameVersionStr)
end

function SettingController:GetSystemSaveData()
  return PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData)
end

function SettingController:GetSettingAudioData()
  return PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData):GetAudioData()
end

function SettingController:SetSettingAudioVolume(index, value)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetAudioDataVolume(index, value)
end

function SettingController:SetSettingAudioMute(index, value)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetAudioDataMute(index, value)
end

function SettingController:SetSettingAudioGlobalMute(value)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetAudioDataGlobalMute(value)
end

function SettingController:GetSettingNoticeSwitch()
  return PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetNoticeSwitchOff()
end

function SettingController:GetPerformanceLevel()
  local systemSaveData = self:GetSystemSaveData()
  return systemSaveData:GetDisplayPerformanceLevelValue()
end

function SettingController:SetPerformanceLevel(index)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplayPerformanceLevelValue(index)
end

function SettingController:ForceSetToCurrentPerformanceLevel()
  if self:GetPerformanceLevel() == 0 then
    return
  end
  local systemSaveData = self:GetSystemSaveData()
  local resolutionRatioIndex = systemSaveData:GetDisplaySettingValue("resolution")
  self:__RealChangeResolutionRatio(resolutionRatioIndex)
  local textureLimit = systemSaveData:GetDisplaySettingValue("texture_limit")
  self:__RealChangeTextureLimit(textureLimit)
  local effectQuality = systemSaveData:GetDisplaySettingValue("effect_quality")
  self:__RealChangePostEffectLevel(effectQuality)
  local modelQuality = systemSaveData:GetDisplaySettingValue("model_quality")
  self:__RealChangeModelQualityLevel(modelQuality)
  local postEffectLevel = systemSaveData:GetDisplaySettingValue("post_effect")
  self:__RealChangePostEffectLevel(postEffectLevel)
  local frameRateIndex = systemSaveData:GetDisplaySettingValue("frame_rate")
  self:__RealChangeFrameRate(frameRateIndex)
  local dynShadowIndex = systemSaveData:GetDisplaySettingValue("dyn_shadow")
  self:__RealChangeDynShadow(dynShadowIndex)
  local antiAliasingIndex = systemSaveData:GetDisplaySettingValue("anti_aliasing")
  self:__RealChangeAntiAliasing(antiAliasingIndex)
  local outlineIndex = systemSaveData:GetDisplaySettingValue("outline")
  self:__RealChangeOutlineActive(outlineIndex)
  local openLittleManIndex = systemSaveData:GetDisplaySettingValue("open_little_man")
  self:__RealChangeOpenLittleMan(openLittleManIndex)
  local openWeatherIndex = systemSaveData:GetDisplaySettingValue("open_weather")
  self:__RealChangeOpenWeather(openWeatherIndex)
end

function SettingController:SetResolutionIndex(index)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("resolution", index)
  self.needChangeResolution = true
end

function SettingController:SetTextureLimit(limit)
  self:__RealChangeTextureLimit(limit)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("texture_limit", limit)
end

function SettingController:SetEffectQuality(quality)
  self:__RealChangeEffectQualityLevel(quality)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("effect_quality", quality)
end

function SettingController:SetModelQuality(quality)
  self:__RealChangeModelQualityLevel(quality)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("model_quality", quality)
end

function SettingController:SetPostEffect(quality)
  self:__RealChangePostEffectLevel(quality)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("post_effect", quality)
end

function SettingController:SetFrameRateIndex(index)
  self:__RealChangeFrameRate(index)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("frame_rate", index)
end

function SettingController:GetFrameRateIndex()
  local systemSaveData = self:GetSystemSaveData()
  return systemSaveData:GetDisplaySettingValue("frame_rate")
end

function SettingController:SetDynShadowIndex(index)
  self:__RealChangeDynShadow(index)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("dyn_shadow", index)
end

function SettingController:SetAntiAliasingIndex(index)
  self:__RealChangeAntiAliasing(index)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("anti_aliasing", index)
end

function SettingController:SetOutlineIndex(index)
  self:__RealChangeOutlineActive(index)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("outline", index)
end

function SettingController:SetOpenLittleManIndex(index)
  self:__RealChangeOpenLittleMan(index)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("open_little_man", index)
end

function SettingController:SetOpenWeatherIndex(index)
  self:__RealChangeOpenWeather(index)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetDisplaySettingValue("open_weather", index)
end

function SettingController:__RealChangeResolutionRatio(index)
  local cs_screen_height = CS.UnityEngine.Screen.height
  if cs_screen_height <= 720 then
    if index == 0 then
      cs_RenderManager:SetResolutionRatio(1)
    elseif index == 1 then
      cs_RenderManager:SetResolutionRatio(0.833333)
    elseif index == 2 then
      cs_RenderManager:SetResolutionRatio(0.75)
    elseif index == 3 then
      cs_RenderManager:SetResolutionRatio(0.666666)
    end
  elseif cs_screen_height <= 1080 then
    if index == 0 then
      cs_RenderManager:SetResolutionRatio(1)
    elseif index == 1 then
      cs_RenderManager:SetResolutionRatio(0.833333)
    elseif index == 2 then
      cs_RenderManager:SetResolutionRatio(0.666666)
    elseif index == 3 then
      cs_RenderManager:SetResolutionRatio(0.444444)
    end
  elseif cs_screen_height <= 1300 then
    if index == 0 then
      cs_RenderManager:SetResolutionRatio(1)
    elseif index == 1 then
      cs_RenderManager:SetResolutionRatio(0.75)
    elseif index == 2 then
      cs_RenderManager:SetResolutionRatio(0.5)
    elseif index == 3 then
      cs_RenderManager:SetResolutionRatio(0.4)
    end
  elseif index == 0 then
    cs_RenderManager:SetResolutionRatio(1)
  elseif index == 1 then
    cs_RenderManager:SetResolutionRatio(0.65)
  elseif index == 2 then
    cs_RenderManager:SetResolutionRatio(0.5)
  elseif index == 3 then
    cs_RenderManager:SetResolutionRatio(0.333333)
  end
end

function SettingController:__RealChangeTextureLimit(limit)
  cs_RenderManager:SetTextureLimit(limit)
end

function SettingController:__RealChangeEffectQualityLevel(quality)
  cs_RenderManager:SetEffectQualityLevel(quality)
end

function SettingController:__RealChangeModelQualityLevel(quality)
  cs_RenderManager:SetModelQualityLevel(quality)
end

function SettingController:__RealChangePostEffectLevel(quality)
  cs_RenderManager:SetPostEffectLevel(quality)
end

function SettingController:__RealChangeFrameRate(index)
  if index == 0 then
    cs_RenderManager:SetFrameRate(30)
  elseif index == 1 then
    cs_RenderManager:SetFrameRate(60)
  elseif index == 2 then
    cs_RenderManager:SetFrameRate(120)
  end
end

function SettingController:__RealChangeDynShadow(index)
  if index == 0 then
    cs_RenderManager:SetDynShadow(false)
  elseif 0 < index then
    cs_RenderManager:SetDynShadow(true)
  end
end

function SettingController:__RealChangeAntiAliasing(index)
  cs_QualitySettings.antiAliasing = index * 4
end

function SettingController:__RealChangeOutlineActive(index)
  if index == 0 then
    cs_RenderManager:SetOutlineActive(false)
  elseif 0 < index then
    cs_RenderManager:SetOutlineActive(true)
  end
end

function SettingController:__RealChangeOpenLittleMan(index)
  print("OpenLittleMan " .. tostring(index))
end

function SettingController:__RealChangeOpenWeather(index)
  print("OpenWeather " .. tostring(index))
end

function SettingController:SetNoticeSwitchOff(noticeId, value)
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetNoticeSwitchOff(noticeId, value)
end

function SettingController:UserLogout()
  NetworkManager.luaNetworkAgent:LogoutToLogin(true)
end

function SettingController:OpenUserCenter()
  CS.MicaSDKManager.Instance:OpenUserCenter()
end

function SettingController:EnterCustomService()
  CS.MicaSDKManager.Instance:EnterCustomService()
end

function SettingController:BiliCloseAccount()
  local timeDate = TimeUtil:TimestampToDate(PlayerDataCenter.inforData:GetCreateTime(), nil, true)
  local creatTimeStr = timeDate.year .. "." .. timeDate.month .. "." .. timeDate.day
  local paramTab = {
    role_name = PlayerDataCenter.playerName,
    server_name = "bilibili",
    level = tostring(PlayerDataCenter.playerLevel.level),
    time = creatTimeStr
  }
  local tab = {}
  table.insert(tab, paramTab)
  local paramJson = rapidjson.encode(tab)
  CS.MicaSDKManager.Instance:BiliCloseAccount(paramJson)
end

function SettingController:GetIsShowDetailDescribe(eDescTypeId)
  return PlayerDataCenter.gameSettingData:GetGSIsShowDetailDescribe(eDescTypeId)
end

function SettingController:SetShowDetailDescribe(eDescTypeId, bool)
  PlayerDataCenter.gameSettingData:SetGSDescribe(eDescTypeId, bool)
end

function SettingController:TryReqSaveGameSettingData()
  local isDirty, recordDic = PlayerDataCenter.gameSettingData:IsGSDataDirty()
  if isDirty then
    NetworkManager:GetNetwork(NetworkTypeID.Object):CS_Client_Record_Set(recordDic)
    PlayerDataCenter.gameSettingData:ClearGSDataDirty()
  end
  if self._dormFightCoundBeInvitedDirty == true then
    local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
    local value = self:GetGSMultSettingIndex(eGameSetDescType.dormFightCoundBeInvited) == 0
    dormFightCtrl:MarkRejectInvitation(value)
    self._dormFightCoundBeInvitedDirty = false
  end
end

function SettingController:GetGSMultSettingIndex(eDescTypeId)
  local systemSaveData = self:GetSystemSaveData()
  return systemSaveData:GetMultSettingIndex(eDescTypeId)
end

function SettingController:SetGSMultSettingIndex(eDescTypeId, index)
  local systemSaveData = self:GetSystemSaveData()
  if eDescTypeId == eGameSetDescType.dormFightCoundBeInvited then
    self._dormFightCoundBeInvitedDirty = true
  end
  return systemSaveData:SetMultSettingIndex(eDescTypeId, index)
end

function SettingController:IsTodayPlayedUltSkillAnimi(skillId)
  local systemSaveData = self:GetSystemSaveData()
  return systemSaveData:GetIsTodayPlayedUltSkillAnimi(skillId)
end

function SettingController:SetIsTodayPlayedUltSkillAnimi(skillId, bool)
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetIsTodayPlayedUltSkillAnimi(skillId, bool)
end

function SettingController:CleanIsTodayPlayedUltSkillAnimi()
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:CleanIsTodayPlayedUltSkillAnimi()
end

function SettingController:OnSceneUnload()
  if self.needChangeResolution == true then
    local systemSaveData = self:GetSystemSaveData()
    local index = systemSaveData:GetDisplaySettingValue("resolution")
    self:__RealChangeResolutionRatio(index)
    self.needChangeResolution = false
  end
end

function SettingController:RefreshSettingReddot()
  local isOk, gameSettingNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Setting, RedDotStaticTypeId.GameSetting)
  if not isOk then
    return
  end
  local systemSaveData = self:GetSystemSaveData()
  if systemSaveData:GetGameSettingIsHaveReddot() then
    gameSettingNode:SetRedDotCount(1)
  else
    gameSettingNode:SetRedDotCount(0)
  end
end

function SettingController:SetGameSettingReddotLooked()
  local systemSaveData = self:GetSystemSaveData()
  systemSaveData:SetGameSettingIsHaveReddot(nil)
  self:RefreshSettingReddot()
end

function SettingController:OnDelete()
  if self.__OnSceneUnload ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnSceneUnload, self.__OnSceneUnload)
  end
end

return SettingController
