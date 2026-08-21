-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Helper\\GameSettings.lua

local PlayerPrefs = UnityEngine.PlayerPrefs
local GameSettingHelper = Framework.Settings.GameSettingHelper
local GameQualitySettings = Framework.Settings.GameQualitySettings
local UIUtils = Framework.UI.UIUtils
local AudioType = Framework.AudioSystem.AudioType
local SystemInfo = UnityEngine.SystemInfo
local NativeUtils = Framework.Plugin.NativeUtils
local ScreenUtils = Framework.Device.ScreenUtils
local SettingConfig = require("DesignerScript/SettingConfig")
local QualityLevelByGpu = require("Helper/GpuQualityLevel")
local UserData = require("Helper/UserData")
local VersionUtils = require("System/VersionUtils")
local LuaToolkit = Framework.Tools.LuaToolkit
local GameSettings = {}
local self = GameSettings
local GamePrefKeys = {
	GameQuality = "GameQuality",
	VocalIsMute = "VocalIsMute",
	CustomQuality = "CustomQuality",
	BulletInBattle = "BulletInBattle",
	Cookie = "Cookie",
	ShowLamp = "ShowLamp",
	SFXIsMute = "SFXIsMute",
	BGMIsMute = "BGMIsMute",
	QualityNoticed = "QualityNoticed",
	VocalLanguage = "VocalLanguage",
	VocalVolume = "VocalVolume",
	SFXVolume = "SFXVolume",
	BGMVolume = "BGMVolume"
}

GameSettings.gameQuality = Const.GAME_QUALITY.High
GameSettings.customQuality = false
GameSettings.bgmVolume = 1
GameSettings.bgmIsMute = false
GameSettings.sfxVolume = 1
GameSettings.sfxIsMute = false
GameSettings.vocalVolume = 1
GameSettings.vocalIsMute = false
GameSettings.bulletInBattle = false
GameSettings.cookie = true
GameSettings.showLamp = false

function GameSettings.initGameSettings()
	self._loadPreferences()
	self.setUIIndents()
end

function GameSettings._loadPreferences()
	if PlayerPrefs.HasKey(GamePrefKeys.BGMIsMute) then
		self.bgmIsMute = PlayerPrefs.GetInt(GamePrefKeys.BGMIsMute) ~= 0 and true or false
	end

	if PlayerPrefs.HasKey(GamePrefKeys.BGMVolume) then
		self.bgmVolume = PlayerPrefs.GetFloat(GamePrefKeys.BGMVolume)
	end

	self._realSetSoundVolume(Const.VOLUME_TYPE_MUSIC, self.bgmVolume, self.bgmIsMute)

	if PlayerPrefs.HasKey(GamePrefKeys.SFXIsMute) then
		self.sfxIsMute = PlayerPrefs.GetInt(GamePrefKeys.SFXIsMute) ~= 0 and true or false
	end

	if PlayerPrefs.HasKey(GamePrefKeys.SFXVolume) then
		self.sfxVolume = PlayerPrefs.GetFloat(GamePrefKeys.SFXVolume)
	end

	self._realSetSoundVolume(Const.VOLUME_TYPE_SFX, self.sfxVolume, self.sfxIsMute)

	if PlayerPrefs.HasKey(GamePrefKeys.VocalIsMute) then
		self.vocalIsMute = PlayerPrefs.GetInt(GamePrefKeys.VocalIsMute) ~= 0 and true or false
	end

	if PlayerPrefs.HasKey(GamePrefKeys.VocalVolume) then
		self.vocalVolume = PlayerPrefs.GetFloat(GamePrefKeys.VocalVolume)
	end

	self._realSetSoundVolume(Const.VOLUME_TYPE_VOCAL, self.vocalVolume, self.vocalIsMute)

	if PlayerPrefs.HasKey(GamePrefKeys.VocalLanguage) then
		self.vocalLang = PlayerPrefs.GetString(GamePrefKeys.VocalLanguage)
	else
		self.vocalLang = Const.CV_TYPE_STRING[Const.CV_LIST[1]]
	end

	self._realSetVocalLang(self.vocalLang)

	if not self.gameQualityProposed then
		self.gameQualityProposed = self._proposeQualityLevel()
	end

	if PlayerPrefs.HasKey(GamePrefKeys.GameQuality) then
		self.gameQuality = PlayerPrefs.GetInt(GamePrefKeys.GameQuality)
	else
		self.gameQuality = self.gameQualityProposed
	end

	if PlayerPrefs.HasKey(GamePrefKeys.CustomQuality) then
		self.customQuality = PlayerPrefs.GetInt(GamePrefKeys.CustomQuality) ~= 0 and true or false
	else
		self.customQuality = false
	end

	self.setGameQuality(self.gameQuality)

	if PlayerPrefs.HasKey(GamePrefKeys.QualityNoticed) then
		self.qualityAlreadyNoticed = true
	end

	if PlayerPrefs.HasKey(GamePrefKeys.BulletInBattle) then
		self.bulletInBattle = PlayerPrefs.GetInt(GamePrefKeys.BulletInBattle) ~= 0 and true or false
	end

	if PlayerPrefs.HasKey(GamePrefKeys.Cookie) then
		self.cookie = PlayerPrefs.GetInt(GamePrefKeys.Cookie) ~= 0 and true or false
	end

	if PlayerPrefs.HasKey(GamePrefKeys.ShowLamp) then
		self.showLamp = PlayerPrefs.GetInt(GamePrefKeys.ShowLamp) ~= 0 and true or false
	end
end

function GameSettings.savePreferences()
	PlayerPrefs.SetInt(GamePrefKeys.BGMIsMute, self.bgmIsMute and 1 or 0)
	PlayerPrefs.SetFloat(GamePrefKeys.BGMVolume, self.bgmVolume)
	PlayerPrefs.SetInt(GamePrefKeys.SFXIsMute, self.sfxIsMute and 1 or 0)
	PlayerPrefs.SetFloat(GamePrefKeys.SFXVolume, self.sfxVolume)
	PlayerPrefs.SetInt(GamePrefKeys.VocalIsMute, self.vocalIsMute and 1 or 0)
	PlayerPrefs.SetFloat(GamePrefKeys.VocalVolume, self.vocalVolume)
	PlayerPrefs.SetInt(GamePrefKeys.GameQuality, self.gameQuality)
	PlayerPrefs.SetString(GamePrefKeys.VocalLanguage, self.vocalLang or "")
	PlayerPrefs.SetInt(GamePrefKeys.CustomQuality, self.customQuality and 1 or 0)

	if self.customQuality then
		self.saveCustomPreferences()
	end

	PlayerPrefs.SetInt(GamePrefKeys.BulletInBattle, self.bulletInBattle and 1 or 0)
	PlayerPrefs.SetInt(GamePrefKeys.Cookie, self.cookie and 1 or 0)
	PlayerPrefs.SetInt(GamePrefKeys.ShowLamp, self.showLamp and 1 or 0)
end

function GameSettings.setBGMVolume(vol)
	self.bgmVolume = vol

	self._realSetSoundVolume(Const.VOLUME_TYPE_MUSIC, vol, self.bgmIsMute)
end

function GameSettings.setBGMMute(isMute)
	self.bgmIsMute = isMute

	self._realSetSoundVolume(Const.VOLUME_TYPE_MUSIC, self.bgmVolume, isMute)
end

function GameSettings.getBGMVolume()
	return self.bgmVolume, self.bgmIsMute
end

function GameSettings.setSFXVolume(vol)
	self.sfxVolume = vol

	self._realSetSoundVolume(Const.VOLUME_TYPE_SFX, vol, self.sfxIsMute)
end

function GameSettings.setSFXMute(isMute)
	self.sfxIsMute = isMute

	self._realSetSoundVolume(Const.VOLUME_TYPE_SFX, self.sfxVolume, isMute)
end

function GameSettings.getSFXVolume()
	return self.sfxVolume, self.sfxIsMute
end

function GameSettings.setVocalVolume(vol)
	self.vocalVolume = vol

	self._realSetSoundVolume(Const.VOLUME_TYPE_VOCAL, vol, self.vocalIsMute)
end

function GameSettings.setVocalMute(isMute)
	self.vocalIsMute = isMute

	self._realSetSoundVolume(Const.VOLUME_TYPE_VOCAL, self.vocalVolume, isMute)
end

function GameSettings.getVocalVolume()
	return self.vocalVolume, self.vocalIsMute
end

function GameSettings.setVocalLanguage(langStr)
	self.vocalLang = langStr

	self._realSetVocalLang(langStr)
end

function GameSettings.getVocalLanguage()
	return self.vocalLang
end

function GameSettings.isAllVoiceClosed()
	return self.bgmIsMute and self.sfxIsMute and self.vocalIsMute
end

function GameSettings.openAllVoice(notChangeSetting)
	if notChangeSetting then
		self._realSetSoundVolume(Const.VOLUME_TYPE_MUSIC, self.bgmVolume, false)
		self._realSetSoundVolume(Const.VOLUME_TYPE_SFX, self.sfxVolume, false)
		self._realSetSoundVolume(Const.VOLUME_TYPE_VOCAL, self.vocalVolume, false)
	else
		self.setBGMMute(false)
		self.setSFXMute(false)
		self.setVocalMute(false)
	end
end

function GameSettings.closeAllVoice(notChangeSetting)
	if notChangeSetting then
		self._realSetSoundVolume(Const.VOLUME_TYPE_MUSIC, self.bgmVolume, true)
		self._realSetSoundVolume(Const.VOLUME_TYPE_SFX, self.sfxVolume, true)
		self._realSetSoundVolume(Const.VOLUME_TYPE_VOCAL, self.vocalVolume, true)
	else
		self.setBGMMute(true)
		self.setSFXMute(true)
		self.setVocalMute(true)
	end
end

function GameSettings.revertVoiceSetting()
	self.setBGMMute(self.bgmIsMute)
	self.setSFXMute(self.sfxIsMute)
	self.setVocalMute(self.vocalIsMute)
end

function GameSettings.setGameQuality(level)
	local preLevel = self.gameQuality

	self.gameQuality = level

	self._setQualityFlag(level)
	self.initCustomSettings(self.customQuality, self.gameQuality)
	GameSettingHelper.SetGameQuality(level)
end

function GameSettings.getCurGameQuality()
	if self.gameQuality ~= nil then
		return self.gameQuality
	else
		return GameSettingHelper.GetGameQuality()
	end
end

function GameSettings.isLowQuality()
	return self.gameQuality <= Const.GAME_QUALITY.Fast
end

local UIIndentByModel = {}

function GameSettings.setUIIndents()
	local indent
	local customIndent = tonumber(UserData.loadCommonData(Const.UD_KEY_NOTCH_ADAPT))

	if customIndent then
		indent = customIndent
	else
		local unityNotch = ScreenUtils.GetUnityNotch()

		if unityNotch > 0.001 then
			indent = unityNotch
		else
			ScreenUtils.GetNativeNotchFullScreen(GameSettings._setNotch)
		end
	end

	local DeviceHelper = require("Helper/DeviceHelper")

	if DeviceHelper.isAndroid() and (indent == nil or indent == 0) then
		local screenWidth = DeviceHelper.screenWidth
		local screenHeight = DeviceHelper.screenHeight

		if screenWidth / screenHeight >= 1.8888888888888888 then
			indent = 0.025
		end
	end

	GameSettings._setNotch(indent)
end

function GameSettings._setNotch(indent)
	if indent and indent > 0 then
		self._indent = indent

		UIUtils.SetAdaptConfig(indent)
	end
end

function GameSettings.selectQualityProfile(profileId)
	GameSettingHelper.SelectQualityProfile(profileId)
end

function GameSettings.setResoluation(width, height)
	GameSettingHelper.SetResoluation(width, height)
end

function GameSettings.getOrigResolution()
	local platform = GameSettingHelper.GetPlatformName()

	if platform == "Android" then
		if not self.gameQualityProposed then
			self.gameQualityProposed = self._proposeQualityLevel()
		end

		if self.gameQualityProposed >= Const.GAME_QUALITY.Mid then
			local width, height, density = GameSettings.getScreenRealMetrics()

			if density then
				local model = string.lower(SystemInfo.deviceModel)

				if string.find(model, "mumu") then
					if height <= 720 then
						return 1920, 1080
					else
						return width, height
					end
				end

				if density <= 2 and height <= 720 then
					return math.floor(width * 1.35), math.floor(height * 1.35)
				end
			end
		end
	end

	local resolution = GameSettingHelper.GetOrigResolution()

	return resolution.width, resolution.height
end

function GameSettings.getScreenRealMetrics()
	local str = NativeUtils.GetScreenRealMetrics()

	if str then
		local metrics = GameSettings._string2Table(str)

		if metrics.widthPixels and metrics.heightPixels and metrics.density then
			return metrics.widthPixels, metrics.heightPixels, metrics.density
		end
	end

	return nil
end

function GameSettings._string2Table(stringData)
	local json = require("cjson")
	local tableData = {}

	if type(stringData) ~= "string" then
		-- block empty
	else
		local succ, t = pcall(json.decode, stringData)

		if succ and type(t) == "table" then
			tableData = t
		end
	end

	return tableData
end

function GameSettings.tryToNoticeQuality(...)
	if self.qualityAlreadyNoticed then
		return
	end

	if self.gameQualityProposed <= Const.GAME_QUALITY.Fast then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", SettingConfig.LOW_QUALITY_NOTICE)
	end

	self.qualityAlreadyNoticed = true

	PlayerPrefs.SetInt(GamePrefKeys.QualityNoticed, 1)
end

function GameSettings._realSetSoundVolume(volumeType, vol, isMute)
	if volumeType == Const.VOLUME_TYPE_SFX then
		CueManager.audioMgr:changeSettingVolume(AudioType.SFX, not isMute and vol or 0)
		CueManager.audioMgr:changeSettingVolume(AudioType.UISfx, not isMute and vol or 0)
	elseif volumeType == Const.VOLUME_TYPE_MUSIC then
		CueManager.audioMgr:changeSettingVolume(AudioType.Music, not isMute and vol or 0)
		CueManager.audioMgr:changeSettingVolume(AudioType.Noise, not isMute and vol or 0)
	elseif volumeType == Const.VOLUME_TYPE_VOCAL then
		CueManager.audioMgr:changeSettingVolume(AudioType.Vocal, not isMute and vol or 0)
	end
end

function GameSettings._realSetVocalLang(langStr)
	CueManager.audioMgr:setVocalLanguage(langStr)
end

function GameSettings._proposeQualityLevel()
	local platform = GameSettingHelper.GetPlatformName()

	if platform ~= "iOS" and platform ~= "Android" then
		return Const.GAME_QUALITY.High
	end

	local gpuName = SystemInfo.graphicsDeviceName

	if platform == "iOS" then
		return GameSettings._proposeIOSQualityLevel()
	end

	for i, info in ipairs(QualityLevelByGpu) do
		if string.find(gpuName, info[1], 1, true) ~= nil then
			return info[2]
		end
	end

	return Const.GAME_QUALITY.Mid
end

function GameSettings._proposeIOSQualityLevel()
	local targetLV = Const.GAME_QUALITY.Mid
	local dModel = SystemInfo.deviceModel
	local commaIdx = string.find(dModel, ",")

	if commaIdx ~= nil then
		if string.match(dModel, "iPad") ~= nil then
			local ver = tonumber(string.sub(dModel, 5, commaIdx - 1))

			if ver > 5 then
				targetLV = Const.GAME_QUALITY.High
			end
		elseif string.match(dModel, "iPhone") ~= nil then
			local ver = tonumber(string.sub(dModel, 7, commaIdx - 1))

			if ver > 8 then
				targetLV = Const.GAME_QUALITY.High
			end
		end
	end

	local memorySize = UnityEngine.SystemInfo.systemMemorySize

	if memorySize < 1025 then
		targetLV = Const.GAME_QUALITY.Fast
	end

	return targetLV
end

function GameSettings.openPhysics(v)
	GameSettingHelper.OpenPhysics(v)
end

function GameSettings.setShadowDistance(v, usage)
	GameSettingHelper.SetLogicShadowDistance(v, usage)
end

function GameSettings.resetShadowDistance(usage)
	GameSettingHelper.ResetLogicShadowDistance(usage)
end

function GameSettings._realSetShadowDistance(v)
	GameSettingHelper.SetShadowDistance(v)
end

function GameSettings._realResetShadowDistance(...)
	GameSettingHelper.ResetShadowDistance()
end

GameSettings.QUALITY_MAP = {
	CharacterPBR = {
		Const.GAME_QUALITY.Low,
		"LowCharacterPBR"
	},
	GlobalShaderLOD = {
		Const.GAME_QUALITY.Fast,
		"LowGlobalShaderLOD"
	},
	HDR = {
		Const.GAME_QUALITY.Low,
		"LowHDR"
	},
	Shadow = {
		Const.GAME_QUALITY.Mid,
		"LowShadow"
	},
	BlurImage = {
		Const.GAME_QUALITY.Mid,
		"LowBlurImage"
	},
	UnionTexture = {
		Const.GAME_QUALITY.Mid,
		"LowUnionTexture"
	},
	Reflection = {
		Const.GAME_QUALITY.Mid,
		"LowReflection"
	},
	PostProcess = {
		Const.GAME_QUALITY.Low,
		"LowPostProcess"
	},
	Tonemapping = {
		Const.GAME_QUALITY.Low,
		"LowTonemapping"
	},
	Vignette = {
		Const.GAME_QUALITY.Fast,
		"LowVignette"
	},
	Bloom = {
		Const.GAME_QUALITY.Mid,
		"LowBloom"
	},
	Dof = {
		Const.GAME_QUALITY.High,
		"LowDof"
	},
	AO = {
		Const.GAME_QUALITY.High,
		"LowAO"
	},
	AA = {
		Const.GAME_QUALITY.Artist,
		"LowAA"
	}
}

if VersionUtils.hasAbilityQualitySettingsV1() then
	GameSettings.QUALITY_MAP.Flare = {
		Const.GAME_QUALITY.Artist,
		"LowFlare"
	}
	GameSettings.QUALITY_MAP.HeightFog = {
		Const.GAME_QUALITY.Artist,
		"LowHeightFog"
	}
	GameSettings.QUALITY_MAP.SoftMask = {
		Const.GAME_QUALITY.Mid,
		"LowSoftMask"
	}
end

function GameSettings._setQualityFlag(curQuality)
	for k, mapInfo in pairs(GameSettings.QUALITY_MAP) do
		GameQualitySettings[mapInfo[2]] = curQuality < mapInfo[1]
	end
end

GameSettings.CUSTOM_SETTINGS = {
	HighFramerate = {
		"bool",
		{
			false,
			false,
			false,
			false
		},
		"setHighFramerate"
	},
	ResolutionLv = {
		"int",
		{
			1,
			2,
			3,
			4
		},
		"setResolutionLv"
	},
	MSAAEnable = {
		"int",
		{
			1,
			1,
			1,
			1
		},
		"setMSAAEnable"
	}
}
GameSettings.WINDOWS_CUSTOM_SETTINGS = {
	HighFramerate = {
		"bool",
		{
			false,
			false,
			true,
			true
		},
		"setHighFramerate"
	},
	ResolutionLv = {
		"int",
		{
			3,
			3,
			4,
			4
		},
		"setResolutionLv"
	},
	MSAAEnable = {
		"int",
		{
			1,
			2,
			3,
			3
		},
		"setMSAAEnable"
	}
}

function GameSettings.initCustomSettings(isCustom, quality)
	local DeviceHelper = require("Helper/DeviceHelper")
	local customSettings

	if DeviceHelper.isWindows() then
		customSettings = GameSettings.WINDOWS_CUSTOM_SETTINGS
		GameSettings.CUSTOM_SETTINGS = GameSettings.WINDOWS_CUSTOM_SETTINGS
	else
		customSettings = GameSettings.CUSTOM_SETTINGS
	end

	if isCustom then
		for settingName, info in pairs(customSettings) do
			if info[1] == "bool" then
				self[settingName] = PlayerPrefs.GetInt(settingName) ~= 0 and true or false
			else
				self[settingName] = PlayerPrefs.GetInt(settingName)
			end

			self._realSetCustomSetting(settingName, self[settingName], true)
		end
	else
		for settingName, _ in pairs(customSettings) do
			self[settingName] = self.getCustomSettingDefault(settingName, quality)

			self._realSetCustomSetting(settingName, self[settingName], true)
		end
	end
end

function GameSettings.saveCustomPreferences()
	for settingName, info in pairs(GameSettings.CUSTOM_SETTINGS) do
		if info[1] == "bool" then
			PlayerPrefs.SetInt(settingName, self[settingName] and 1 or 0)
		else
			PlayerPrefs.SetInt(settingName, self[settingName])
		end
	end
end

function GameSettings.getCustomSettingDefault(settingName, quality)
	local info = GameSettings.CUSTOM_SETTINGS[settingName]

	if info and info[2] then
		return info[2][quality + 1]
	end
end

function GameSettings.setCustomSetting(name, value)
	self[name] = value

	self._realSetCustomSetting(name, value)
end

function GameSettings.getCustomSetting(name)
	return self[name]
end

function GameSettings._realSetCustomSetting(name, value, changeLater)
	local info = GameSettings.CUSTOM_SETTINGS[name]

	if info and info[3] and self[info[3]] then
		return self[info[3]](value, changeLater)
	end
end

function GameSettings.setHighFramerate(enableHighFPS, changeLater)
	local value = enableHighFPS and 60 or 30

	LuaToolkit.SetTargetFrameRate(value)
end

function GameSettings.setResolutionLv(lv, changeLater)
	local DeviceHelper = require("Helper/DeviceHelper")

	DeviceHelper.setRenderResolution()
end

GameSettings.msaaSample = 1

function GameSettings.setMSAAEnable(lv, changeLater)
	if lv == 1 then
		self.msaaSample = 1
	elseif lv == 2 then
		self.msaaSample = 2
	elseif lv == 3 then
		self.msaaSample = 4
	end

	local DeviceHelper = require("Helper/DeviceHelper")

	DeviceHelper.setMsaa(self.msaaSample, self.gameQuality)
end

return GameSettings
