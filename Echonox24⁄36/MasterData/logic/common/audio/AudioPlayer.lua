-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/AudioPlayer.lua

module("logic.common.audio.AudioPlayer", package.seeall)

local GroupKeyEnum = AudioSettingEnum.GroupKeyEnum
local AudioPlayer = class("AudioPlayer")
local groupKeyMapInfo = {
	[GroupKeyEnum.BG] = 0,
	[GroupKeyEnum.ENV] = 1,
	[GroupKeyEnum.LEVEL_1] = 11,
	[GroupKeyEnum.LEVEL_2] = 12,
	[GroupKeyEnum.LEVEL_3] = 13,
	[GroupKeyEnum.LEVEL_4] = 14
}

local function kv(key)
	return groupKeyMapInfo[key]
end

function AudioPlayer:ctor()
	self._audioCfg = nil
	self._limitPlayInfo = false
	self._recordGroupPlayInfo = false
end

function AudioPlayer:init()
	self._recordGroupPlayInfo = {}
	self._limitPlayInfo = {
		{
			limitNum = 3,
			relatedGroups = {
				[kv(GroupKeyEnum.LEVEL_1)] = true,
				[kv(GroupKeyEnum.LEVEL_2)] = true
			}
		}
	}

	local go = goutil.create("AudioMixer", false)

	goutil.addComponentOnce(go, typeof(AudioMixerMgr))
	goutil.addComponentOnce(go, typeof(UnityEngine.AudioListener))

	local audioMixer = CommonPreloader.instance:getAsset(CommonResPath.AudioMixer)

	AudioMixerMgr.Instance:SetAudioMixer(audioMixer)
	AudioMixerMgr.Instance:SetMaxAudioSource(10)

	for k, v in pairs(groupKeyMapInfo) do
		AudioMixerMgr.Instance:SetGroupId(k, v)
	end

	AudioMixerMgr.Instance:RecordSetting(AudioSettingEnum.VolumeKeyEnum.BG)
	AudioMixerMgr.Instance:RecordSetting(AudioSettingEnum.VolumeKeyEnum.ENV)
	AudioMixerMgr.Instance:RecordSetting(AudioSettingEnum.VolumeKeyEnum.LEVEL_1)
	AudioMixerMgr.Instance:RecordSetting(AudioSettingEnum.VolumeKeyEnum.LEVEL_2)
	AudioMixerMgr.Instance:RecordSetting(AudioSettingEnum.VolumeKeyEnum.LEVEL_3)
	AudioMixerMgr.Instance:RecordSetting(AudioSettingEnum.VolumeKeyEnum.LEVEL_4)

	local settingListener = AudioPlayerSettingListener.New()

	settingListener:init()
	AudioMixerMgr.Instance:AddBgmStopListener(self, self._onBgmStop)
	ConfigMgr.instance:requestConfig("audio", self)

	self._currentBgmId = 0
	self._currentOverrideAudioId = 0
end

function AudioPlayer:handleConfig(name, content)
	if name == "audio" then
		self._audioCfg = content
	end
end

function AudioPlayer:setVolume(volumeKeyEnum, volume)
	AudioMixerMgr.Instance:ModifySetting(volumeKeyEnum, volume)
end

function AudioPlayer:resetVolume(volumeKeyEnum)
	AudioMixerMgr.Instance:ResetSetting(volumeKeyEnum)
end

function AudioPlayer:fadeResetValume(volumeKeyEnum)
	AudioMixerMgr.Instance:DOResetSetting(volumeKeyEnum, 1)
end

function AudioPlayer:fadeVolume(volumeKeyEnum, volume)
	AudioMixerMgr.Instance:DOFadeSetting(volumeKeyEnum, volume, 1)
end

function AudioPlayer:setVolumeMute(volumeKeyEnum, mute)
	if mute then
		self:setVolume(volumeKeyEnum, -80)
	else
		self:resetVolume(volumeKeyEnum)
	end
end

function AudioPlayer:playBgmInner(bgmId, isLoop)
	if not bgmId or bgmId <= 0 or isLoop and self._currentBgmId == bgmId then
		return
	end

	local co = self._audioCfg[bgmId]

	if not co then
		return
	end

	if isInEditorMode and enableWarnLog then
		printWarn("AudioPlayer playBgm：", co.name)
	end

	if isLoop then
		AudioMixerMgr.Instance:PlayBgm(co.name, 0)
	else
		AudioMixerMgr.Instance:PlayBgmWithoutLoop(co.name, 0)
	end

	self._currentBgmId = bgmId
end

function AudioPlayer:_onBgmStop(clipName)
	local tmp = self._currentBgmId

	self._currentBgmId = 0

	GlobalDispatcher:dispatchEvent(EventType.BGM_STOP_EVENT, tmp)
end

function AudioPlayer:playBgm(bgmId)
	self:playBgmInner(bgmId, true)
end

function AudioPlayer:playBgmForce(bgmId)
	self._currentBgmId = 0

	self:playBgmInner(bgmId, true)
end

function AudioPlayer:playBgmWithoutLoop(bgmId)
	self:playBgmInner(bgmId, false)
end

function AudioPlayer:lowerBgm(lower)
	if PlayerLocalStorgeModel.instance:getMusic() then
		if lower then
			AudioPlayer.instance:fadeVolume(AudioSettingEnum.VolumeKeyEnum.BG, -15)
		else
			AudioPlayer.instance:fadeResetValume(AudioSettingEnum.VolumeKeyEnum.BG)
		end
	end
end

function AudioPlayer:stopBgm()
	if isInEditorMode and enableWarnLog then
		printWarn("AudioPlayer stopBgm")
	end

	AudioMixerMgr.Instance:StopBgm()
end

function AudioPlayer:_checkGroupLimite(groupId)
	local limitCount = 0
	local isLimit = false

	for k, v in ipairs(self._limitPlayInfo) do
		limitCount = 0

		if v.relatedGroups[groupId] then
			for n, m in pairs(v.relatedGroups) do
				limitCount = limitCount + (self._recordGroupPlayInfo[n] or 0)
			end

			if limitCount >= v.limitNum then
				isLimit = true

				break
			end
		end
	end

	return isLimit
end

function AudioPlayer:playEffectByPath(path, groupId, callback, callbackSelf)
	if string.nilorempty(path) then
		printError("audio path is nil")

		return
	end

	groupId = groupId or 1

	if not self:_checkGroupLimite(groupId) then
		self._recordGroupPlayInfo[groupId] = (self._recordGroupPlayInfo[groupId] or 0) + 1

		local function playOverCall(respath)
			self._recordGroupPlayInfo[groupId] = self._recordGroupPlayInfo[groupId] - 1

			if callback then
				if callbackSelf then
					callback(callbackSelf, respath)
				else
					callback(respath)
				end
			end
		end

		AudioMixerMgr.Instance:PlayEffect(path, groupId, playOverCall)
	end
end

function AudioPlayer:playAudioEffect(audioId, callback, callbackSelf)
	local co = self._audioCfg[audioId]

	if not co then
		return
	end

	if co.name == nil or co.name == "" then
		if callback then
			callback(callbackSelf)
		end

		return
	end

	self:playEffectByPath(co.name, co.groupType, callback, callbackSelf)
end

function AudioPlayer:stopAudioEffect(audioId, needInvoke)
	local co = self._audioCfg[audioId]

	if not co then
		return
	end

	if needInvoke ~= false then
		needInvoke = true
	else
		for k, v in ipairs(self._limitPlayInfo) do
			if v.relatedGroups[co.groupType] then
				printError("audioId is need Invoke")

				break
			end
		end
	end

	AudioMixerMgr.Instance:StopEffect(co.name, needInvoke)
end

function AudioPlayer:playLoopAudioEffect(audioId)
	local co = self._audioCfg[audioId]

	if not co then
		return
	end

	if co.name == nil or co.name == "" then
		if enableWarnLog then
			printWarn("audio id:" .. audioId .. "audio's name is null")
		end

		return
	end

	AudioMixerMgr.Instance:PlayLoopEffect(co.name, co.groupType)
end

function AudioPlayer:stopLoopAudioEffect(audioId)
	local co = self._audioCfg[audioId]

	if not co then
		return
	end

	AudioMixerMgr.Instance:StopLoopEffect(co.name)
end

function AudioPlayer:isAudioExist(audioId)
	local co = self._audioCfg[audioId]

	if co then
		return true
	else
		return false
	end
end

function AudioPlayer:getAudioCO(audioId)
	return self._audioCfg[audioId]
end

function AudioPlayer:playOnceEffect(audioId, callback, callbackSelf)
	self:stopAudioEffect(audioId, false)
	self:playAudioEffect(audioId, callback, callbackSelf)
end

function AudioPlayer:playModelAudio(modelId, modelAudioEnum)
	if modelId <= 0 then
		return
	end

	local modelCO = ModelConfig.instance:getModelCO(modelId)
	local audioId = modelCO:getAudioId(modelAudioEnum)

	self:playAudioEffect(audioId)
end

function AudioPlayer:stopModelAudio(modelId, modelAudioEnum)
	if modelId <= 0 then
		return
	end

	local modelCO = ModelConfig.instance:getModelCO(modelId)
	local audioId = modelCO:getAudioId(modelAudioEnum)

	self:stopAudioEffect(audioId)
end

function AudioPlayer:getAudioPath(audioId)
	local co = self._audioCfg[audioId]

	if not co then
		return
	end

	return co.name
end

function AudioPlayer:playOverrideEffect(audioId, callback, callbackSelf)
	self:stopOverrideEffect(false)

	self._currentOverrideAudioId = audioId

	self:playAudioEffect(audioId, callback, callbackSelf)
end

function AudioPlayer:stopOverrideEffect(needInvoke)
	if needInvoke == nil then
		needInvoke = true
	end

	self:stopAudioEffect(self._currentOverrideAudioId, needInvoke)

	self._currentOverrideAudioId = 0
end

function AudioPlayer:stopAllEffect(needInvoke)
	AudioMixerMgr.Instance:StopAllEffect(needInvoke)
end

function AudioPlayer:getCurrentBgmId()
	return self._currentBgmId
end

AudioPlayer.instance = AudioPlayer.New()

return AudioPlayer
