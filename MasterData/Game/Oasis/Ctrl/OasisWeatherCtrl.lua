local base = require("Game.Oasis.Ctrl.OasisCtrlBase")
local OasisWeatherCtrl = class("OasisWeatherCtrl", base)
local cs_OasisWeatherController = CS.OasisWeatherController
local cs_WeatherConfig = CS.WeatherConfig
local cs_SkyController = CS.SkyController
local cs_ResLoader = CS.ResLoader
local cs_time = CS.UnityEngine.Time
local cs_Shader = CS.UnityEngine.Shader
local snowIntensityNameId = cs_Shader.PropertyToID("_snowIntensity")
local snowColorNameId = cs_Shader.PropertyToID("_snowColor")

function OasisWeatherCtrl:InitOasisWeatherCtrl()
  self.isInOasis = false
  local unlockSkySetting = PlayerDataCenter.AllBuildingData.built[eBuildingId.SkyBuilding] ~= nil
  local systemData = PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData)
  local effectQuality = systemData:GetDisplaySettingValue("effect_quality")
  self.isActive = unlockSkySetting and systemData:GetDisplaySettingValue("open_weather") == 1
  self:SetOasisWeatherSetting(effectQuality)
  self.lastTranWeatherTime = 0
  self.weatherDuration = 0
  local weatherConfigData = ConfigData.oasis_weather
  self.oasisWeatherController = cs_OasisWeatherController.Instance
  self.defaultWeatherConfig = cs_WeatherConfig()
  self.defaultWeatherConfig.transDuration = 1
  if not IsNull(cs_SkyController.Instance) then
    self.cloud2d = cs_SkyController.Instance.clouds
    self.uskyPro = cs_SkyController.Instance.gameObject:GetComponent(typeof(CS.uSkyPro))
  end
  self.resLoader = cs_ResLoader.Create()
  self.mainCamera = UIManager:GetMainCamera()
  self:GenerateweatherList(weatherConfigData)
  self:ResetDefaultWeather()
  if self.isActive then
    self:RandomNewWeather()
    self:TransToHomeEffect()
  end
  self:__InitSnowShaderGlobalValue()
end

function OasisWeatherCtrl:__InitSnowShaderGlobalValue()
  cs_Shader.SetGlobalFloat(snowIntensityNameId, 0)
  cs_Shader.SetGlobalColor(snowColorNameId, Color.white)
end

function OasisWeatherCtrl:SetOasisWeatherSetting(effectQuality)
  self._effectQuality = effectQuality
  if IsNull(self.oasisWeatherController) then
    self.oasisWeatherController = cs_OasisWeatherController.Instance
  end
  if IsNull(self.oasisWeatherController) then
    return
  end
  if effectQuality == 0 then
    self.oasisWeatherController:SetMaxSnowParticleCount(0)
    self.oasisWeatherController:SetMaxRainBoxCount(0)
  elseif effectQuality == 1 then
    self.oasisWeatherController:SetMaxSnowParticleCount(1000)
    self.oasisWeatherController:SetMaxRainBoxCount(3)
  elseif effectQuality == 2 then
    self.oasisWeatherController:SetMaxSnowParticleCount(2000)
    self.oasisWeatherController:SetMaxRainBoxCount(5)
  end
end

function OasisWeatherCtrl:GenerateweatherList(weatherConfigData)
  self.weatherList = {}
  self.totalWeight = 0
  for _, weatherData in pairs(weatherConfigData) do
    local weather = {}
    weather.weight = weatherData.weight
    self.totalWeight = self.totalWeight + weather.weight
    local weatherConfig = cs_WeatherConfig()
    weatherConfig.transDuration = weatherData.trans_duration
    weatherConfig.weatherDuration = weatherData.weather_duration
    weatherConfig.rainIntensity = weatherData.rain_intensity * 0.01
    weatherConfig.wettingIntensity = weatherData.wetting_intensity * 0.01
    weatherConfig.snowIntensity = weatherData.snow_intensity * 0.01
    weatherConfig.accumulatedSnowIntensity = weatherData.accumulated_snow_intensity * 0.01
    weatherConfig.windIntensity = weatherData.wind_intensity * 0.01
    weatherConfig.lightningIntensity = weatherData.lightning_intensity * 0.01
    weather.weatherConfig = weatherConfig
    weather.weatherData = weatherData
    table.insert(self.weatherList, weather)
  end
end

function OasisWeatherCtrl:RandomNewWeather()
  if not self.isActive then
    return
  end
  local newRandomWeather
  if self:GetCurrentWeather() == nil or self:GetCurrentWeather().weatherData == nil then
    newRandomWeather = self:GetRandomWeather()
  end
  if newRandomWeather == nil then
    local lastChangeWeatherTimeStamp = PlayerDataCenter.cacheSaveData:GetLastChangeWeatherTimeStamp()
    local isWeatherEnd = cs_time.time - lastChangeWeatherTimeStamp > self:GetCurrentWeather().weatherData.weather_duration
    if isWeatherEnd then
      newRandomWeather = self:GetRandomWeather()
      PlayerDataCenter.cacheSaveData:SetLastChangeWeatherTimeStamp(cs_time.time)
    else
      newRandomWeather = self:GetCurrentWeather()
    end
  end
  if newRandomWeather == nil then
    return
  end
  self:SetEffect(newRandomWeather.weatherData)
end

function OasisWeatherCtrl:StopWeatherEffect()
  self:_StopAmbienceAudio()
end

function OasisWeatherCtrl:GetCurrentWeather()
  local weatherIndex = PlayerDataCenter.cacheSaveData:GetLastWeatherIndex()
  if weatherIndex ~= nil then
    return self.weatherList[weatherIndex]
  end
end

function OasisWeatherCtrl:GetRandomWeather()
  local weight = math.random(self.totalWeight)
  local curWeight = 0
  for i = 1, #self.weatherList do
    curWeight = curWeight + self.weatherList[i].weight
    if weight <= curWeight then
      PlayerDataCenter.cacheSaveData:SetLastWeatherIndex(i)
      return self:GetCurrentWeather()
    end
  end
end

function OasisWeatherCtrl:SetWeatherManager(weatherConfig, isForce)
  if not self.isInOasis and not isForce then
    return
  end
  if IsNull(self.oasisWeatherController) then
    self.oasisWeatherController = cs_OasisWeatherController.Instance
  end
  if IsNull(self.oasisWeatherController) then
    return
  end
  if IsNull(self.oasisWeatherController.weatherManagers) then
    return
  end
  local weatherManagers = self.oasisWeatherController.weatherManagers
  for i = 0, weatherManagers.Length - 1 do
    local weatherManager = weatherManagers[i]
    if not IsNull(weatherManager) and not IsNull(weatherConfig) then
      weatherManager:SetCurrentWeatherConfig(weatherConfig)
    end
  end
end

local homeRainEffectPrefabPaths = {
  "FX/Scene/tianqi/new/FX_003_Oasis_001_rain_low.prefab",
  "FX/Scene/tianqi/new/FX_003_Oasis_001_rain_mid.prefab",
  "FX/Scene/tianqi/new/FX_003_Oasis_001_rain_high.prefab",
  "FX/Scene/tianqi/new/FX_003_Oasis_001_high_snow_low.prefab",
  "FX/Scene/tianqi/new/FX_003_Oasis_001_high_snow_mid.prefab",
  "FX/Scene/tianqi/new/FX_003_Oasis_001_high_snow_high.prefab"
}
local oasisWeatherEffectPrefabPaths = {
  "FX/Scene/tianqi/new/FX_003_Oasis_001_rain_low-lvzhou.prefab",
  "FX/Scene/tianqi/new/FX_003_Oasis_001_rain_mid-lvzhou.prefab",
  "FX/Scene/tianqi/new/FX_003_Oasis_001_rain_high-lvzhou.prefab"
}

function OasisWeatherCtrl:SetEffect(weatherData)
  if weatherData == nil then
    return
  end
  self:_SetAmbienceAuido(weatherData)
  self:ReSetEffect()
  if weatherData.snow_intensity == 0 and weatherData.rain_intensity == 0 then
    return
  end
  local effectId = 1
  if weatherData.snow_intensity > 75 then
    effectId = 6
  elseif weatherData.snow_intensity > 50 then
    effectId = 5
  else
    effectId = 4
  end
  if weatherData.rain_intensity > 75 then
    effectId = 3
  elseif weatherData.rain_intensity > 50 then
    effectId = 2
  else
    effectId = 1
  end
  if self.resLoader == nil then
    return
  end
  local homeWeatherEffectPath = homeRainEffectPrefabPaths[effectId]
  if homeWeatherEffectPath ~= nil then
    self.resLoader:LoadABAssetAsync(homeWeatherEffectPath, function(prefab)
      if prefab == nil then
        return
      end
      self.homeRainEffect = prefab:Instantiate(self.mainCamera.transform)
    end)
  end
  local oasisRainEffectPrefabPath = oasisWeatherEffectPrefabPaths[effectId]
  if oasisRainEffectPrefabPath then
    self.resLoader:LoadABAssetAsync(oasisRainEffectPrefabPath, function(prefab)
      if prefab == nil then
        return
      end
      self.oasisRainEffect = prefab:Instantiate(self.mainCamera.transform)
    end)
  end
  self:SetSkyProParam(effectId)
end

function OasisWeatherCtrl:_SetAmbienceAuido(oasisWeatherCfg)
  if oasisWeatherCfg.amb_audio_id == 0 or self._effectQuality < 2 then
    self:_StopAmbienceAudio()
    return
  end
  if self._ambAuId ~= oasisWeatherCfg.amb_audio_id then
    self:_StopAmbienceAudio()
    self._ambAuId = oasisWeatherCfg.amb_audio_id
    self._ambAuBack = AudioManager:PlayAudioById(oasisWeatherCfg.amb_audio_id)
  end
  if not string.IsNullOrEmpty(oasisWeatherCfg.audio_aisac_control) then
    local audioCfg = AudioManager:GetAudioCfg(self._ambAuId)
    if audioCfg ~= nil then
      AudioManager:SetSourceAisacControl(audioCfg.Type, oasisWeatherCfg.audio_aisac_control, oasisWeatherCfg.audio_aisac_value)
    end
  end
end

function OasisWeatherCtrl:_StopAmbienceAudio()
  if self._ambAuBack ~= nil then
    AudioManager:StopAudioByBack(self._ambAuBack)
  end
  self._ambAuBack = nil
  self._ambAuId = nil
end

local skyCloudMatPaths = {
  "FX/Scene/tianqi/new/uSkyPro Clouds 2D_rain_low.mat",
  "FX/Scene/tianqi/new/uSkyPro Clouds 2D_rain_mid.mat",
  "FX/Scene/tianqi/new/uSkyPro Clouds 2D_rain_high.mat"
}

function OasisWeatherCtrl:SetSkyProParam(effectId)
  if not IsNull(self.uskyPro) then
    self.uskyPro.StarIntensity = 0
    self.uskyPro.OuterSpaceIntensity = 0
    self.uskyPro.SunSize = 0
  end
  local skyCloudMatPath = skyCloudMatPaths[effectId]
  if not IsNull(self.cloud2d) and self.resLoader ~= nil then
    self.resLoader:LoadABAssetAsync(skyCloudMatPath, function(material)
      if material == nil then
        return
      end
      self.cloud2d.Clouds2DMaterial = CS.UnityEngine.Material(material)
    end)
  end
end

function OasisWeatherCtrl:ReSetEffect()
  if not IsNull(self.homeRainEffect) then
    DestroyUnityObject(self.homeRainEffect.gameObject)
  end
  if not IsNull(self.oasisRainEffect) then
    DestroyUnityObject(self.oasisRainEffect.gameObject)
  end
end

function OasisWeatherCtrl:ResetDefaultWeather()
  self:SetWeatherManager(self.defaultWeatherConfig, true)
  self:ReSetEffect()
end

function OasisWeatherCtrl:TransEffect(isInOasis)
  if not IsNull(self.homeRainEffect) then
    self.homeRainEffect.gameObject:SetActive(not isInOasis)
  end
  if not IsNull(self.oasisRainEffect) then
    self.oasisRainEffect.gameObject:SetActive(isInOasis)
  end
end

function OasisWeatherCtrl:TransToOasisEffect()
  if self.isActive then
    self:TransEffect(true)
    if self:GetCurrentWeather() ~= nil then
      self:SetWeatherManager(self:GetCurrentWeather().weatherConfig)
    end
  end
end

function OasisWeatherCtrl:TransToHomeEffect()
  self:TransEffect(false)
  self:SetWeatherManager(self.defaultWeatherConfig, true)
end

function OasisWeatherCtrl:OnEnterOasis()
  self.isInOasis = true
  self:TransToOasisEffect()
  local cloud = CS.SkyController.Instance.clouds
  local material = cloud.Clouds2DMaterial
end

function OasisWeatherCtrl:OnExitOasis()
  self.isInOasis = false
  self:TransToHomeEffect()
end

function OasisWeatherCtrl:OnDelete()
  self:_StopAmbienceAudio()
  self:ResetDefaultWeather()
  self.isInOasis = false
  self.defaultWeatherConfig = nil
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
  end
  self.resLoader = nil
  if not IsNull(self.cloud2d) and isEditorMode then
    self.cloud2d.Clouds2DMaterial = nil
  end
end

return OasisWeatherCtrl
