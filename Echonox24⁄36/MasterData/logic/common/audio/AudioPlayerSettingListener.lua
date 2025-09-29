-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/AudioPlayerSettingListener.lua

module("logic.common.audio.AudioPlayerSettingListener", package.seeall)

local AudioPlayerSettingListener = class("AudioPlayerSettingListener")

function AudioPlayerSettingListener:init()
	GlobalDispatcher:addEventListener(EventType.APPLICATION_PAUSE, self._onHandleOnApplicationPause, self)
	GlobalDispatcher:addEventListener(EventType.APPLICATION_RESUME, self._onHandleOnApplicationResume, self)
	GlobalDispatcher:addEventListener(EventType.ON_MUSIC_OPEN, self._onHandleMusicMuteUpdate, self)
	GlobalDispatcher:addEventListener(EventType.ON_MUSIC_CLOSE, self._onHandleMusicMuteUpdate, self)
	GlobalDispatcher:addEventListener(EventType.ON_SOUND_EFFECT_ON, self._onHandleSoundEffectUpdate, self)
	GlobalDispatcher:addEventListener(EventType.ON_SOUND_EFFECT_OFF, self._onHandleSoundEffectUpdate, self)
	self:_updateMusicMute()
	self:_updateSoundEffectMute()
end

function AudioPlayerSettingListener:_onHandleMusicMuteUpdate()
	self:_updateMusicMute()
end

function AudioPlayerSettingListener:_onHandleSoundEffectUpdate()
	self:_updateSoundEffectMute()
end

function AudioPlayerSettingListener:_onHandleOnApplicationPause()
	AudioMixerMgr.Instance.IsBgmMute = true
	AudioMixerMgr.Instance.IsEffectMute = true
end

function AudioPlayerSettingListener:_onHandleOnApplicationResume()
	AudioMixerMgr.Instance.IsBgmMute = false
	AudioMixerMgr.Instance.IsEffectMute = false
end

function AudioPlayerSettingListener:_updateMusicMute()
	local isMusicOff = not PlayerLocalStorgeModel.instance:getMusic()

	AudioPlayer.instance:setVolumeMute(AudioSettingEnum.VolumeKeyEnum.BG, isMusicOff)
end

function AudioPlayerSettingListener:_updateSoundEffectMute()
	local isSoundEffectOff = not PlayerLocalStorgeModel.instance:getSoundEff()

	AudioPlayer.instance:setVolumeMute(AudioSettingEnum.VolumeKeyEnum.ENV, isSoundEffectOff)
	AudioPlayer.instance:setVolumeMute(AudioSettingEnum.VolumeKeyEnum.LEVEL_1, isSoundEffectOff)
	AudioPlayer.instance:setVolumeMute(AudioSettingEnum.VolumeKeyEnum.LEVEL_2, isSoundEffectOff)
	AudioPlayer.instance:setVolumeMute(AudioSettingEnum.VolumeKeyEnum.LEVEL_3, isSoundEffectOff)
	AudioPlayer.instance:setVolumeMute(AudioSettingEnum.VolumeKeyEnum.LEVEL_4, isSoundEffectOff)
end

return AudioPlayerSettingListener
