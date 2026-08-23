local var_0_0 = 0.25
local UserSettingSoundComp = class("UserSettingSoundComp", require("app.fairyGUI.user.UI_UserSettingSoundComp"))

function UserSettingSoundComp:ctor()
	self:_addListeners()
	self:_reset()
end

function UserSettingSoundComp:_resetOther()
	self._syncBGM = nil
	self._syncEffect = nil
	self._syncVoice = nil
	self._soundEnable = false
end

function UserSettingSoundComp:_resetUI()
	self.m_bgmSlider:setMax(100)
	self.m_effectSlider:setMax(100)
	self.m_voiceSlider:setMax(100)
	self.m_voiceGroup:setVisible(g.core.sound.SoundManager:supportVoice())
	self.m_soundBgmBtn:setVisible(g.core.sound.SoundManager:supportOnOff())
	self.m_soundVoiceBtn:setVisible(g.core.sound.SoundManager:supportOnOff())
	self.m_soundEffBtn:setVisible(g.core.sound.SoundManager:supportOnOff())
end

function UserSettingSoundComp:_reset()
	self:_resetUI()
	self:_resetOther()
end

function UserSettingSoundComp:_addListeners()
	self.m_bgmSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self.m_effectSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self.m_voiceSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self.m_soundBgmBtn:addClickListener(handler(self, self._onEnableBgmBtnClicked))
	self.m_soundEffBtn:addClickListener(handler(self, self._onEnableEffBtnClicked))
	self.m_soundVoiceBtn:addClickListener(handler(self, self._onEnableVoiceBtnClicked))
end

function UserSettingSoundComp:onLoad()
	self.m_soundBgmBtn:setSelected((g.core.common.Setting:get(g.core.common.Setting.FUNC_BGM_SWITCH)))
	self.m_soundEffBtn:setSelected((g.core.common.Setting:get(g.core.common.Setting.FUNC_SOUND_SWITCH)))

	local var_6_0 = g.core.common.Setting:get(g.core.common.Setting.FUNC_VOICE_SWITCH)

	self.m_soundVoiceBtn:setSelected(var_6_0)

	if not var_6_0 then
		self.m_sliderEnableController:setSelectedIndex(0)
	else
		self.m_sliderEnableController:setSelectedIndex(1)
	end

	local var_6_1 = g.core.common.Setting:getValue(g.core.common.Setting.FUNC_BGM_VOLUME) or g.core.sound.SoundManager:getMusicVolume()
	local var_6_2 = g.core.common.Setting:getValue(g.core.common.Setting.FUNC_SOUND_VOLUME) or g.core.sound.SoundManager:getSoundsVolume()
	local var_6_3 = g.core.common.Setting:getValue(g.core.common.Setting.FUNC_VOICE_VOLUME) or g.core.sound.SoundManager:getVoiceVolume()

	self.m_bgmSlider:setValue(var_6_1)
	self.m_effectSlider:setValue(var_6_2)
	self.m_voiceSlider:setValue(var_6_3)
	self.m_enterTransition:play()
end

function UserSettingSoundComp:_onSliderChanged(arg_7_1)
	local var_7_0 = arg_7_1:getSender():getName()

	if var_7_0 == "bgmSlider" then
		if not self._syncBGM then
			self:newScheduleOnce(handler(self, self._onSynchronizeBGM), var_0_0)
		end

		self._syncBGM = true
	elseif var_7_0 == "effectSlider" then
		if not self._syncEffect then
			self:newScheduleOnce(handler(self, self._onSynchronizeEffect), var_0_0)
		end

		self._syncEffect = true
	else
		if not self._syncVoice then
			self:newScheduleOnce(handler(self, self._onSynchronizeVoice), var_0_0)
		end

		self._syncVoice = true
	end
end

function UserSettingSoundComp:_onEnableBtnClicked()
	return
end

function UserSettingSoundComp:_onEnableBgmBtnClicked()
	local var_9_0 = self.m_soundBgmBtn:isSelected()

	if not var_9_0 then
		g.core.common.Setting:set(g.core.common.Setting.FUNC_BGM_SWITCH, false)
	else
		g.core.common.Setting:set(g.core.common.Setting.FUNC_BGM_SWITCH, true)
	end

	g.core.sound.SoundManager:setSoundSwitchEnabled(g.core.sound.SoundManager.KEY_MAPS.MUSIC, var_9_0)
end

function UserSettingSoundComp:_onEnableEffBtnClicked()
	local var_10_0 = self.m_soundEffBtn:isSelected()

	if not var_10_0 then
		g.core.common.Setting:set(g.core.common.Setting.FUNC_SOUND_SWITCH, false)
	else
		g.core.common.Setting:set(g.core.common.Setting.FUNC_SOUND_SWITCH, true)
	end

	g.core.sound.SoundManager:setSoundSwitchEnabled(g.core.sound.SoundManager.KEY_MAPS.SOUND, var_10_0)
end

function UserSettingSoundComp:_onEnableVoiceBtnClicked()
	local var_11_0 = self.m_soundVoiceBtn:isSelected()

	if not var_11_0 then
		g.core.common.Setting:set(g.core.common.Setting.FUNC_VOICE_SWITCH, false)
	else
		g.core.common.Setting:set(g.core.common.Setting.FUNC_VOICE_SWITCH, true)
	end

	g.core.sound.SoundManager:setSoundSwitchEnabled(g.core.sound.SoundManager.KEY_MAPS.VOICE, var_11_0)
end

function UserSettingSoundComp:_onSynchronizeBGM()
	local var_12_0 = self.m_bgmSlider:getValue()

	g.core.sound.SoundManager:setMusicVolume(var_12_0)
	g.core.common.Setting:set(g.core.common.Setting.FUNC_BGM_VOLUME, var_12_0)

	self._syncBGM = false
end

function UserSettingSoundComp:_onSynchronizeEffect()
	local var_13_0 = self.m_effectSlider:getValue()

	g.core.sound.SoundManager:setSoundsVolume(var_13_0)
	g.core.common.Setting:set(g.core.common.Setting.FUNC_SOUND_VOLUME, var_13_0)

	self._syncEffect = false
end

function UserSettingSoundComp:_onSynchronizeVoice()
	local var_14_0 = self.m_voiceSlider:getValue()

	g.core.sound.SoundManager:setVoiceVolume(var_14_0)
	g.core.common.Setting:set(g.core.common.Setting.FUNC_VOICE_VOLUME, var_14_0)

	self._syncVoice = false
end

function UserSettingSoundComp:onShow()
	self:setVisible(true)
end

function UserSettingSoundComp:onHide()
	self:setVisible(false)
end

function UserSettingSoundComp:playBackAction()
	self.m_backTransition:play()
end

return UserSettingSoundComp
