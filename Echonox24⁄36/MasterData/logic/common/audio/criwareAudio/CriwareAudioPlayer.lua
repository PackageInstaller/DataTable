-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/criwareAudio/CriwareAudioPlayer.lua

module("logic.common.audio.criwareAudio.CriwareAudioPlayer", package.seeall)

local CriwareAudioPlayer = class("CriwareAudioPlayer")

function CriwareAudioPlayer:ctor()
	self._audioCfg = false
	self._currentBgmId = 0
	self._currentEnvironmentId = 0
	self._criwareIdList = {}
	self._cueSheetNames = {}
	self._cueSheetNamesTime = 0
	self._cacheCueSheetCount = 10
end

function CriwareAudioPlayer:getTime(cueSheetName)
	self._cueSheetNamesTime = self._cueSheetNamesTime + 1

	local data = self._cueSheetNames[cueSheetName]

	if not data then
		data = {
			name = cueSheetName,
			time = self._cueSheetNamesTime
		}
	else
		data.time = self._cueSheetNamesTime
	end

	return data
end

function CriwareAudioPlayer:init()
	local go = goutil.create("CriwareAudio", false)

	goutil.addComponentOnce(go, typeof(Adx2AudioMgr))
	Adx2AudioMgr.Instance:Init(self._handleAudioEvent, self)

	local settingListener = CriwareAudioPlayerSettingListener.New()

	settingListener:init()
end

function CriwareAudioPlayer:_handleAudioEvent(position, eventId, playbackId, eventType, eventTag)
	GlobalDispatcher:dispatchEvent(EventType.CRIWARE_CALLBACK, position, eventId, playbackId, eventType, eventTag)
end

function CriwareAudioPlayer:RegisterAcf(acfFile, dspBusSetting)
	Adx2AudioMgr.Instance:Register(acfFile, dspBusSetting)
end

function CriwareAudioPlayer:moveCriwareListenerPos()
	local width = UnityEngine.Screen.width
	local height = UnityEngine.Screen.height
	local screenCenterPos = UnityEngine.Vector2.New(width / 2, height / 2)
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
	local go = Adx2AudioMgr.Instance:getDefaultListenerGameObject()
	local raycastProxy = RaycastProxy.Get(go)

	raycastProxy:SetMainCamera(mainCamera)

	local pos = raycastProxy:getHitPosByScreenPoint(screenCenterPos)

	Astral.TransformUtil.SetPos(go.transform, pos.x, pos.y, pos.z)
end

function CriwareAudioPlayer:setBgmVolume(volume)
	Adx2AudioMgr.Instance.SoundVolumeBGM = volume
end

function CriwareAudioPlayer:setSEVolume(volume)
	Adx2AudioMgr.Instance.SoundVolumeSE = volume
end

function CriwareAudioPlayer:setVoiceVolume(volume)
	Adx2AudioMgr.Instance.SoundVolumeVoice = volume
end

function CriwareAudioPlayer:loadCueSheet(name, acbFile, awbFile)
	self._cueSheetNames[name] = self:getTime(name)

	Adx2AudioMgr.Instance:LoadCueSheet(name, acbFile, awbFile)
end

function CriwareAudioPlayer:removeCueSheet(name)
	self._cueSheetNames[name] = nil

	Adx2AudioMgr.Instance:RemoveCueSheet(name)
end

function CriwareAudioPlayer:unloadOldCueSheet()
	local list = {}
	local count = 0

	for k, v in pairs(self._cueSheetNames) do
		count = count + 1

		table.insert(list, v)
	end

	if count < self._cacheCueSheetCount then
		return
	end

	table.sort(list, function(a, b)
		return a.time > b.time
	end)

	for i = self._cacheCueSheetCount, #list do
		self:removeCueSheet(list[i].name)
	end
end

function CriwareAudioPlayer:loadCueSheetBySoundId(soundId)
	local audioCO = CriwareAudioConfig.instance:getAudioCOById(soundId)

	if audioCO then
		local awbFile = ""

		if not string.nilorempty(audioCO.awbName) then
			awbFile = GameUrl.getAudioFileUrl(audioCO.awbName)
		end

		local acbFile = GameUrl.getAudioFileUrl(audioCO.acbName)
		local name = string.gsub(audioCO.acbName, ".acb", "")

		self._cueSheetNames[name] = self:getTime(name)

		Adx2AudioMgr.Instance:LoadCueSheet(name, acbFile, awbFile)
	end
end

function CriwareAudioPlayer:getCriwareIdBySoundId(soundId)
	return self._criwareIdList[soundId]
end

function CriwareAudioPlayer:getCriwareIdByName(name)
	local audioCO = CriwareAudioConfig.instance:getCOByName(name)

	if audioCO then
		local soundId = audioCO.code

		return self._criwareIdList[soundId]
	end

	return false
end

function CriwareAudioPlayer:getCueTotalTimeByName(soundName)
	local audioCO = CriwareAudioConfig.instance:getCOByName(soundName)
	local totalTime = 1

	if audioCO then
		local acbname = string.gsub(audioCO.acbName, ".acb", "")

		totalTime = Adx2AudioMgr.Instance:GetCueTotalTime(acbname, soundName)
	end

	if totalTime < 0 and enableWarnLog then
		printWarn("CriwareAudioPlayer:cue sheet setting contain loop,plz check source file")
	end

	return totalTime
end

function CriwareAudioPlayer:getCueTotalTimeById(soundId)
	local audioCO = CriwareAudioConfig.instance:getAudioCOById(soundId)
	local totalTime = 1

	if audioCO then
		local name = string.gsub(audioCO.acbName, ".acb", "")

		totalTime = Adx2AudioMgr.Instance:GetCueTotalTime(name, audioCO.cueName)
	end

	if totalTime < 0 and enableWarnLog then
		printWarn("CriwareAudioPlayer:cue sheet setting contain loop,plz check source file")
	end

	return totalTime
end

function CriwareAudioPlayer:SetStartTimeById(cueId, time)
	local audioCO = CriwareAudioConfig.instance:getAudioCOById(cueId)

	if audioCO then
		Adx2AudioMgr.Instance:SetStartTime(cueId, time)
	end
end

function CriwareAudioPlayer:SetStartTimeByName(cueName, time)
	local audioCO = CriwareAudioConfig.instance:getCOByName(cueName)

	if audioCO then
		Adx2AudioMgr.Instance:SetStartTime(audioCO.code, time)
	end
end

function CriwareAudioPlayer:playBgm(bgmId, callBack, handler)
	if not bgmId or bgmId <= 0 then
		return
	end

	self:_logAudioInfo(bgmId)
	self:loadCueSheetBySoundId(bgmId)

	self._currentBgmId = bgmId

	local criwareId = Adx2AudioMgr.Instance:PlayBGMSound(bgmId, callBack, handler)

	self._criwareIdList[bgmId] = criwareId
end

function CriwareAudioPlayer:setBgmNextBlockIndex(index)
	Adx2AudioMgr.Instance:SetBgmNextBlockIndex(index)
end

function CriwareAudioPlayer:setEnvironmentNextBlockIndex(index)
	Adx2AudioMgr.Instance:SetEnviorBlockIndex(index)
end

function CriwareAudioPlayer:playEnvironmentSound(soundId, callBack, handler)
	if not soundId or soundId <= 0 then
		return
	end

	self:_logAudioInfo(soundId)
	self:loadCueSheetBySoundId(soundId)

	self._currentEnvironmentId = soundId

	local criwareId = Adx2AudioMgr.Instance:PlayEnvironmentSound(soundId, callBack, handler)

	self._criwareIdList[soundId] = criwareId
end

function CriwareAudioPlayer:stopSoundById(id)
	local criwareId = CriwareAudioPlayer.instance:getCriwareIdBySoundId(id)

	if criwareId and criwareId ~= 0 then
		if self._currentBgmId == id then
			self._currentBgmId = 0
		end

		if self._currentEnvironmentId == id then
			self._currentEnvironmentId = 0
		end

		Adx2AudioMgr.Instance:StopPlayingID(criwareId)
	end
end

function CriwareAudioPlayer:stopAllBgm()
	self._currentBgmId = 0

	Adx2AudioMgr.Instance:StopBMGSound()
end

function CriwareAudioPlayer:playSESound(soundId, gameObject, callBack, handler)
	if not soundId then
		if enableWarnLog then
			printWarn("CriwareAudioPlayer:playSESound soundId is nil")
		end

		return
	end

	self:loadCueSheetBySoundId(soundId)

	local criwareId = Adx2AudioMgr.Instance:PlaySESound(soundId, gameObject, callBack, handler)

	self._criwareIdList[soundId] = criwareId
end

function CriwareAudioPlayer:playVoiceSound(voiceId, callBack, handler)
	if not voiceId then
		if enableWarnLog then
			printWarn("CriwareAudioPlayer:playVoiceSound voiceId is nil")
		end

		return
	end

	self:loadCueSheetBySoundId(voiceId)

	local criwareId = Adx2AudioMgr.Instance:PlayVoiceSound(voiceId, callBack, handler)

	self._criwareIdList[voiceId] = criwareId
end

function CriwareAudioPlayer:AddDefaultListener(gameObject)
	Adx2AudioMgr.Instance:AddDefaultAudioListener(gameObject)
end

function CriwareAudioPlayer:isAudioExist(audioId)
	local co = CriwareAudioConfig.instance:getAudioCOById(audioId)

	if co then
		return true
	else
		return false
	end
end

function CriwareAudioPlayer:stopAllSESound()
	Adx2AudioMgr.Instance:StopSESound()
end

function CriwareAudioPlayer:stopAllVoiceSound()
	Adx2AudioMgr.Instance:StopVoiceSound()
end

function CriwareAudioPlayer:getCurrentBgmId()
	return self._currentBgmId or 0
end

function CriwareAudioPlayer:getCurrentEnvironmentId()
	return self._currentEnvironmentId or 0
end

function CriwareAudioPlayer:clearCueSheets()
	Adx2AudioMgr.Instance:ClearCueSheets()
end

function CriwareAudioPlayer:_logAudioInfo(audioId)
	if enableLog then
		local audioCO = CriwareAudioConfig.instance:getAudioCOById(audioId)

		print("play audio::", audioCO.cueName)
	end
end

function CriwareAudioPlayer:setAisacControl(name, controlName, value)
	if string.nilorempty(name) or string.nilorempty(controlName) then
		return
	end

	Adx2AudioMgr.Instance:SetAisacControl(name, controlName, value)
end

CriwareAudioPlayer.instance = CriwareAudioPlayer.New()

return CriwareAudioPlayer
