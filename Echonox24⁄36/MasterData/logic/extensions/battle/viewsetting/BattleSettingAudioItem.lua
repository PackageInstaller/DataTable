-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingAudioItem.lua

module("logic.extensions.battle.viewsetting.BattleSettingAudioItem", package.seeall)

local BattleSettingAudioItem = class("BattleSettingAudioItem", UIReusableLuaBehavior)

function BattleSettingAudioItem:buildUI()
	self._sliderVolume = UIComponentType.SliderAdapter(goutil.findChild(self.mainGO, "slider"))
	self._goHandle = goutil.findChild(self.mainGO, "slider/handle")
	self._toggleMute = goutil.addComponentOnce(goutil.findChild(self.mainGO, "muteType"), UIComponentType.SpaceXToggle)
	self._toggleAudio = goutil.addComponentOnce(goutil.findChild(self.mainGO, "voicedType"), UIComponentType.SpaceXToggle)
	self._audioType = CriwareAudioFacade.AudioType.NONE
	self._originalVolume = false
end

function BattleSettingAudioItem:destroyUI()
	self._sliderVolume = nil
	self._goHandle = nil
	self._toggleMute = nil
	self._toggleAudio = nil
end

function BattleSettingAudioItem:bindEvents()
	self._sliderVolume:AddOnValueChanged(self._onVolumeChanged, self)
end

function BattleSettingAudioItem:unbindEvents()
	self._sliderVolume:RemoveOnValueChanged()
	self._toggleMute:RemoveListener()
end

function BattleSettingAudioItem:setValueChangeCallback(callback, handler)
	self._valueChangeCallback = callback
	self._valueChangeCallbackHandler = handler
end

function BattleSettingAudioItem:setAudioType(audioType)
	local volume = CriwareAudioFacade.instance:getVolume(audioType)

	self._audioType = audioType
end

function BattleSettingAudioItem:_onMuteStateChanged(toggle, isOn)
	if isOn then
		self._originalVolume = self._sliderVolume:GetValue()

		self:_updateAudioState(0)
	else
		local volume = self._originalVolume or self._sliderVolume:GetValue()

		self:_updateAudioState(volume)
	end
end

function BattleSettingAudioItem:_onVolumeChanged(volume)
	self:_updateAudioState(volume)
end

function BattleSettingAudioItem:setHistoryValue()
	local value = 1

	if self._audioType == CriwareAudioFacade.AudioType.BGM then
		value = PlayerLocalStorageModel.instance:getBgmVolumeHistory()
	elseif self._audioType == CriwareAudioFacade.AudioType.SE then
		value = PlayerLocalStorageModel.instance:getSoundEffVolumeHistory()
	elseif self._audioType == CriwareAudioFacade.AudioType.VOICE then
		value = PlayerLocalStorageModel.instance:getDubVolumeHistory()
	end

	self:_updateAudioState(value)
end

function BattleSettingAudioItem:_updateAudioState(volume)
	self:unbindEvents()

	if volume <= 0 then
		self._toggleMute.IsOn = true
		self._toggleAudio.IsOn = false

		self._sliderVolume:SetValue(0)
		CriwareAudioFacade.instance:setVolume(self._audioType, 0)
	else
		self._toggleAudio.IsOn = true
		self._toggleMute.IsOn = false

		self._sliderVolume:SetValue(volume)
		CriwareAudioFacade.instance:setVolume(self._audioType, volume)
	end

	self:bindEvents()

	self._toggleAudio.IsOn = volume > 0
	self._toggleMute.IsOn = volume <= 0

	if self._audioType == CriwareAudioFacade.AudioType.BGM then
		PlayerLocalStorageModel.instance:setBgmVolume(volume)
	elseif self._audioType == CriwareAudioFacade.AudioType.SE then
		PlayerLocalStorageModel.instance:setSoundEffVolume(volume)
	elseif self._audioType == CriwareAudioFacade.AudioType.VOICE then
		PlayerLocalStorageModel.instance:setDubVolume(volume)
	end

	if self._valueChangeCallback then
		self._valueChangeCallback(self._valueChangeCallbackHandler)
	end
end

function BattleSettingAudioItem:getValue()
	return self._sliderVolume:GetValue()
end

return BattleSettingAudioItem
