local this = class("settingAdapter")
local _optionDataTpl = L_GameTpl:getOptionDataTpl()
local _gameConstTpl = L_GameTpl:getGameConstTpl()

function this:ctor()
end

function this:adapt(id, value)
  error("lua设置已废弃，如果还有在调用的@wangsongyan  调用堆栈" .. debug.traceback())
  if self[id] then
    self[id](self, value)
  else
  end
end

function this:initText(value)
  local tpl = _gameConstTpl:getOptionLanguage()
  local lang = tpl[tonumber(value)] or C_I18NConst.LanguageChs
  printf("多语言  当前语言：" .. lang)
  if C_I18NManager.CurLanguageTag == lang then
    return
  end
  local isHas, langEnum = C_I18NConst.LanguageTag2Enum:TryGetValue(lang)
  if isHas then
    C_PlayerPrefsUtility.SetInt(C_I18NConst.LangPrefsKey, langEnum)
    C_I18NManager.SetLanguage(langEnum)
  end
end

function this:setQualityValue(value, settings, factor)
  value = tostring(value)
  for i, v in pairs(settings) do
    local val = v[value]
    if val then
      if factor then
        val = tostring(val * factor)
      end
      C_DeviceGradingManager.SetQualityValue(i, val)
    end
  end
end

function this:setKey(id, value)
end

function this:calResolutionFactor()
  return 1
end

this[L_Const.settingType.cameraSpeed] = function(self, value)
  C_CameraManager.PlayLoadCameraSpeed()
end
this[L_Const.settingType.uiOffset] = function(self, value)
end
this[L_Const.settingType.softCamera] = function(self, value)
  local camTactics = C_CameraManager.GetTactics(C_ECameraType.NewWorld)
  if camTactics then
    camTactics:RefreshSoftCamera()
  end
end
this[L_Const.settingType.bgm] = function(self, value)
  local tpl = _optionDataTpl:getTplById(L_Const.settingType.bgm)
  local list = _optionDataTpl:getOptionPara2(tpl)
  value = value / list[2]
  C_AudioManager.SetRTPCValue(L_Const.wwiseSoundGroup.bgm, value * 100)
end
this[L_Const.settingType.se] = function(self, value)
  local tpl = _optionDataTpl:getTplById(L_Const.settingType.se)
  local list = _optionDataTpl:getOptionPara2(tpl)
  value = value / list[2]
  C_AudioManager.SetRTPCValue(L_Const.wwiseSoundGroup.worldSe, value * 100)
  C_AudioManager.SetRTPCValue(L_Const.wwiseSoundGroup.uiSe, value * 100)
end
this[L_Const.settingType.cv] = function(self, value)
  local tpl = _optionDataTpl:getTplById(L_Const.settingType.cv)
  local list = _optionDataTpl:getOptionPara2(tpl)
  value = value / list[2]
  C_AudioManager.SetRTPCValue(L_Const.wwiseSoundGroup.cv, value * 100)
end
this[L_Const.settingType.mute] = function(self, value)
  value = tostring(value) == "true" and 0 or 1
  C_AudioManager.SetRTPCValue(L_Const.wwiseSoundGroup.all, value * 100)
end
this[L_Const.settingType.text] = function(self, value)
  self:initText(value)
  local tpl = _gameConstTpl:getOptionLanguage()
  local lang = tpl[tonumber(value)] or C_I18NConst.LanguageChs
  local u32 = L_Const.mailLanguage[lang]
  L_MailStore:req_changeCSProtoSetLanguage(u32)
end
this[L_Const.settingType.indicatorHud] = function(self, value)
end
this[L_Const.settingType.language] = function(self, value)
  local lang = L_Const.settingText[L_Const.settingType.language][tonumber(value)]
  if lang then
    C_I18NManager.SetAudioLanguage(lang)
  end
end
this[L_Const.settingType.resolution] = function(self, id)
end
this[L_Const.settingType.frame] = function(self, value)
  local level = tonumber(value)
  local frame
  if C_AppConfigManager.Platform == C_EAppPlatform.IOS then
    if level == 1 then
      frame = 30
    elseif level == 2 then
      frame = 60
    end
  elseif L_DeviceTpl:getIsMobile() then
    if level == 1 then
      frame = 30
    elseif level == 2 then
      frame = 45
    elseif level == 3 then
      frame = 60
    end
  elseif level == 1 then
    frame = 30
  elseif level == 2 then
    frame = 60
  elseif level == 3 then
    frame = -1
  end
  if frame then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.TARGET_FRAME_RATE, tostring(frame))
  end
end
this[L_Const.settingType.image] = function(self, value)
  return
end
this[L_Const.settingType.renderSet] = function(self, value)
  self:setQualityValue(value, L_Const.settingType_Render_pc)
end
this[L_Const.settingType.renderAccuracy] = function(self, value)
  local v = tonumber(value) or 100
  if v < 10 then
    self:setQualityValue(value, L_Const.settingType_RenderScale_pc)
  else
    v = v / 100
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.PIPELINE_RENDER_SCALE, tostring(v))
  end
end
this[L_Const.settingType.shadow] = function(self, value)
  value = tostring(value)
  local val
  if value == "1" then
    val = "1"
  elseif value == "2" then
    val = "2"
  elseif value == "3" then
    val = "3"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.SHADOW_QUALITY, val)
  end
end
this[L_Const.settingType.module] = function(self, value)
  value = tostring(value)
  local val
  if value == "1" then
    val = "1"
  elseif value == "2" then
    val = "2"
  elseif value == "3" then
    val = "3"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.MODEL_QUALITY, val)
  end
end
this[L_Const.settingType.specialEffects] = function(self, value)
  self:setQualityValue(value, L_Const.settingType_Effects_pc)
end
this[L_Const.settingType.GIQuality] = function(self, value)
  local def = C_QualityConstants.GI
  value = tostring(value)
  local val
  if value == "1" then
    val = "1"
  elseif value == "2" then
    val = "2"
  elseif value == "3" then
    val = "3"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(def, val)
  end
end
this[L_Const.settingType.AOQuality] = function(self, value)
  local def = C_QualityConstants.AO
  value = tostring(value)
  value = tostring(value)
  local val
  if value == "1" then
    val = "1"
  elseif value == "2" then
    val = "2"
  elseif value == "3" then
    val = "3"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(def, val)
  end
end
this[L_Const.settingType.reflectQuality] = function(self, value)
  local def = C_QualityConstants.RFLECTION
  value = tostring(value)
  local val
  if value == "1" then
    val = "1"
  elseif value == "2" then
    val = "2"
  elseif value == "3" then
    val = "3"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(def, val)
  end
end
this[L_Const.settingType.depthOfField] = function(self, value)
  local def = C_QualityConstants.DEPTHOFIELD
  value = tostring(value)
  local val = "1"
  if value == "1" then
    val = "0"
  elseif value == "2" then
    val = "1"
  end
  C_DeviceGradingManager.SetQualityValue(def, val)
end
this[L_Const.settingType.bloom] = function(self, value)
  local def = C_QualityConstants.BLOOM
  C_DeviceGradingManager.SetQualityValue(def, value)
end
this[L_Const.settingType.skinAccuracy] = function(self, value)
end
this[L_Const.settingType.AOI] = function(self, value)
  local def = C_QualityConstants.AOI
  value = tostring(value)
  local val
  if value == "1" then
    val = "1"
  elseif value == "2" then
    val = "2"
  elseif value == "3" then
    val = "3"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(def, val)
  end
end
this[L_Const.settingType.vSync] = function(self, value)
  value = tonumber(value)
  if value == 2 then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.VSYNC, "1")
  else
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.VSYNC, "0")
  end
end
this[L_Const.settingType.battleCameraAlign] = function(self, value)
  local val = tostring(value) == "false"
  C_CameraManager.resetIgnore = val
end
this[L_Const.settingType.ultimateSkillAnim] = function(self, value)
  local val = tostring(value) == "false"
  C_CameraManager.herotimelineIgnore = val
end
this[L_Const.settingType.petSkillAnim] = function(self, value)
  local val = tostring(value) == "false"
  C_CameraManager.pettimelineIgnore = val
end
this[L_Const.settingType.petSummonCamera] = function(self, value)
  local val = tostring(value) == "false"
  C_CameraManager.petZhihuiIgnore = val
end
this[L_Const.settingType.breakCamera] = function(self, value)
  local val = tostring(value) == "false"
  C_CameraManager.breakIgnore = val
end
this[L_Const.settingType.switchCamera] = function(self, value)
  local val = tostring(value) == "false"
  C_CameraManager.switchFovTimelineIgnore = val
end
this[L_Const.settingType.petTogetherSkillCamera] = function(self, value)
  local val = tostring(value) == "false"
  C_CameraManager.petTogetherSkillIgnore = val
end
this[L_Const.settingType.bright] = function(self, value)
  L_SettingStore:setbright(value)
end
this[L_Const.settingType.saturation] = function(self, value)
  L_SettingStore:setSaturation(value)
end
this[L_Const.settingType.contrast] = function(self, value)
  L_SettingStore:setContrast(value)
end
this[L_Const.settingType.npcDensityLevel] = function(self, value)
end
this[L_Const.settingType.damageTextSize] = function(self, value)
  if value == "1" then
    C_DamageTextManager.SetDamageTextEnable(false)
  elseif value == "2" then
    C_DamageTextManager.SetDamageTextScale(0.4)
  elseif value == "3" then
    C_DamageTextManager.SetDamageTextScale(0.6)
  elseif value == "4" then
    C_DamageTextManager.SetDamageTextScale(0.8)
  end
end
this[L_Const.settingType.smallMap] = function(self, value)
  AzurWorld.MapMgr:RefreshIsLockMap()
end
this[L_Const.settingType.textureQuality] = function(self, value)
  value = tostring(value)
  local v
  if value == "1" then
    v = "2"
  elseif value == "2" then
    v = "3"
  end
  if v then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.TEXTURE_QUALITY, v)
  end
end
this[L_Const.settingType.guideLine] = function(self, value)
  AzurWorld.traceMgr.settings = value
end
this[L_Const.settingType.heroSkillOpacity] = function(self, value)
  local v = tonumber(value)
  v = math.clamp(v / 100, 0, 1)
  CS.Lens.Gameplay.Modules.BigWorld.EffectManager.globalConfig:SetHeroEffectOpacity(v)
end
this[L_Const.settingType.kiboSkillOpacity] = function(self, value)
  local v = tonumber(value)
  v = math.clamp(v / 100, 0, 1)
  CS.Lens.Gameplay.Modules.BigWorld.EffectManager.globalConfig:SetPetEffectOpacity(v)
end
this[L_Const.settingType.allySkillOpacity] = function(self, value)
  local v = tonumber(value)
  v = math.clamp(v / 100, 0, 1)
  CS.Lens.Gameplay.Modules.BigWorld.EffectManager.globalConfig:SetAllyEffectOpacity(v)
end
this[L_Const.settingType.enemySkillOpacity] = function(self, value)
  local v = tonumber(value)
  v = math.clamp(v / 100, 0, 1)
  CS.Lens.Gameplay.Modules.BigWorld.EffectManager.globalConfig:SetEnemyEffectOpacity(v)
end
this[L_Const.settingType.grassQuality] = function(self, value)
  value = tostring(value)
  local val
  if value == "1" then
    val = "1"
  elseif value == "2" then
    val = "2"
  elseif value == "3" then
    val = "3"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.GRASS_QUALITY, val)
  end
end
this[L_Const.settingType.LightShaft] = function(self, value)
  value = tostring(value)
  local val = "1"
  if value == "1" then
    val = "0"
  elseif value == "2" then
    val = "1"
  end
  C_DeviceGradingManager.SetQualityValue(C_QualityConstants.LIGHTSHAFT, val)
end
this[L_Const.settingType.Para] = function(self, value)
  value = tostring(value)
  local val = "1"
  if value == "1" then
    val = "0"
  elseif value == "2" then
    val = "1"
  end
  C_DeviceGradingManager.SetQualityValue(C_QualityConstants.PARA, val)
end
this[L_Const.settingType.LensFlare] = function(self, value)
  value = tostring(value)
  local val = "1"
  if value == "1" then
    val = "0"
  elseif value == "2" then
    val = "1"
  end
  C_DeviceGradingManager.SetQualityValue(C_QualityConstants.LENSFLARE, val)
end
this[L_Const.settingType.UVDistort] = function(self, value)
  value = tostring(value)
  local val = "1"
  if value == "1" then
    val = "0"
  elseif value == "2" then
    val = "1"
  end
  C_DeviceGradingManager.SetQualityValue(C_QualityConstants.UVDISTORT, val)
end
this[L_Const.settingType.heroShadowQuality] = function(self, value)
  local def = C_QualityConstants.CHARACTER_SHADOW
  value = tostring(value)
  local val
  if value == "1" then
    val = "2"
  elseif value == "2" then
    val = "3"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(def, val)
  end
end
this[L_Const.settingType.RetileHlod] = function(self, value)
  value = tostring(value)
  local val
  if value == "1" then
    val = "1"
  elseif value == "2" then
    val = "2"
  elseif value == "3" then
    val = "3"
  end
  if val then
    C_DeviceGradingManager.SetQualityValue(C_QualityConstants.RETILE_HLOD, val)
  end
end
this[L_Const.settingType.cameraDirectionAssist] = function(self, value)
  local v = tostring(value) == "true"
  C_CameraManager.OpenCameraDirectionAssist = v
end
return this
