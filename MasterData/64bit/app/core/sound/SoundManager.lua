local SoundManager = class("SoundManager")
local var_0_1 = WWiseHelper and WWiseHelper:getInstance() or nil

if device.isOHOS() then
	var_0_1 = nil
end

local var_0_2 = cc.FileUtils:getInstance()

SoundManager.KEY_MAPS = {
	MUSIC = "MUSIC",
	VOICE = "VOICE",
	SOUND = "SOUND"
}

local var_0_3 = {
	VOICE_OFF = "Voice_Mute",
	ANIMATION_PAUSE = "Animation_Pause",
	SOUND_ON = "SFX_UnMute",
	ANIMATION_RESUME = "Animation_Resume",
	SOUND_OFF = "SFX_Mute",
	MUSIC_PLAY = "Music_Play",
	PV_CG_STOP = "PV_CG_Stop",
	AUDIO_ON = "Audio_On",
	AUDIO_OFF = "Audio_Off",
	SOUND_STOP = "Sound_Stop",
	SOUND_RESUME = "Sound_Resume",
	SOUND_PAUSE = "Sound_Pause",
	MUSIC_STOP = "Music_Stop",
	MUSIC_RESUME = "Music_Resume",
	MUSIC_PAUSE = "Music_Pause",
	MUSIC_ON = "Music_On",
	MUSIC_OFF = "Music_Off",
	VOICE_ON = "Voice_UnMute"
}

function SoundManager:ctor()
	self.preBackMusicName = nil
	self.backgroundMusic = nil
	self.soundList = {}
	self.pre = "audio/"
	self.isLessSoundBanks = not g.core.common.Setting:getValue(g.core.common.Setting.FUNC_SOUND_SWITCH) and not g.core.common.Setting:getValue(g.core.common.Setting.FUNC_VOICE_SWITCH)
	self.loadedBattleBankSet = {}
	self._curSoundVolume = 100
	self._curMusicVolume = 100
	self._curVoiceVolume = 100
	self.uiBanks = {
		"Interface.bnk",
		"Interface_New.bnk"
	}
	self.needUnloadBanks = {
		"Voice.bnk",
		"Voice_New.bnk",
		"Animation.bnk",
		"Ambiences_P1.bnk"
	}

	for iter_1_0, iter_1_1 in ipairs(self.uiBanks) do
		table.insert(self.needUnloadBanks, iter_1_1)
	end

	self.banks = {
		"Init.bnk",
		"SystemSetting.bnk",
		"Music.bnk"
	}

	if not self.isLessSoundBanks then
		for iter_1_2, iter_1_3 in ipairs(self.needUnloadBanks) do
			table.insert(self.banks, iter_1_3)
		end
	end

	self.inited = false

	if var_0_1 then
		self:initWise()
	else
		self.inited = true
	end

	self._lastMusicState = nil
	self._lastSoundState = nil
end

function SoundManager:reset()
	return
end

function SoundManager:stop()
	if var_0_1 then
		var_0_1:postEvent(var_0_3.SOUND_STOP)
		var_0_1:postEvent(var_0_3.MUSIC_STOP)
		var_0_1:stopAll()
		var_0_1:clearBanks()
	end

	self.inited = false
end

function SoundManager:supportOnOff()
	return var_0_1 ~= nil
end

function SoundManager:supportVoice()
	return var_0_1 ~= nil
end

function SoundManager:stopMusicAndSound()
	if var_0_1 then
		var_0_1:postEvent(var_0_3.SOUND_STOP)
		var_0_1:postEvent(var_0_3.MUSIC_STOP)
		var_0_1:stopAll()
	end

	self.inited = false
end

function SoundManager:checkLoadBanks()
	local var_7_0 = g.core.common.Setting:getValue(g.core.common.Setting.FUNC_SOUND_SWITCH) or g.core.common.Setting:getValue(g.core.common.Setting.FUNC_VOICE_SWITCH)

	if self.isLessSoundBanks and var_7_0 then
		self.isLessSoundBanks = not var_7_0

		self:loadBanks()
	elseif not self.isLessSoundBanks and not var_7_0 then
		self.isLessSoundBanks = not var_7_0

		self:unloadBanks()
	end
end

function SoundManager:resetLoadBanks()
	self:checkLoadBanks()
end

function SoundManager:unloadBanks()
	for iter_9_0, iter_9_1 in ipairs(self.needUnloadBanks) do
		var_0_1:unloadBank(iter_9_1)
	end
end

function SoundManager:loadBanks()
	for iter_10_0, iter_10_1 in ipairs(self.needUnloadBanks) do
		var_0_1:loadBank(iter_10_1)
	end
end

function SoundManager:loadGuideBanks()
	if var_0_1 and not self._isGuideLoad then
		self._isGuideLoad = true

		self:loadBanks()
	end
end

function SoundManager:unloadGuideBanks()
	if var_0_1 and self._isGuideLoad then
		self._isGuideLoad = false

		self:unloadBanks()
	end
end

function SoundManager:loadFirstPlayBank()
	return
end

function SoundManager:unloadFirstPlayBank()
	return
end

function SoundManager:initWise()
	local var_15_0 = "src/config.lua"
	local var_15_1 = var_0_2:fullPathForFilename("src/config.lua")

	if var_15_1:len() == 0 then
		var_15_0 = "src/config.luac"
		var_15_1 = var_0_2:fullPathForFilename("src/config.luac")
	end

	local var_15_2 = string.sub(var_15_1, 1, string.find(var_15_1, var_15_0) - 1) .. "res/common/wwise"

	if device.isAndroid() then
		var_15_2 = string.gsub(var_15_2, "assets/", "")
	end

	if device.isWindows() and config.IS_MICRO_PKG then
		var_15_2 = device.obbDirPath .. "res/wwise"
	end

	if device.isOHOS() then
		var_15_2 = "rawfile://" .. var_15_2
	end

	var_0_1:setBasePath(var_15_2)

	if not device.isWindowsDebug() then
		if var_0_1.addBasePath then
			var_0_1:addBasePath(device.obbDirPath .. "res/common/wwise")
			var_0_1:addBasePath(uf.UpgradeManager:getInstance():getUpgradeFolder() .. "res/common/wwise")
		end
	end

	var_0_1:setCurrentLanguage("Japanese")

	for iter_15_0, iter_15_1 in ipairs(self.banks) do
		var_0_1:loadBank(iter_15_1)
	end

	var_0_1:postEvent(var_0_3.MUSIC_PLAY)

	self.inited = true
	self._isFirstPlayLoad = true

	self:setMusicVolume((g.core.common.Setting:getValue(g.core.common.Setting.FUNC_BGM_VOLUME)))
	self:setSoundsVolume((g.core.common.Setting:getValue(g.core.common.Setting.FUNC_SOUND_VOLUME)))
	self:setVoiceVolume((g.core.common.Setting:getValue(g.core.common.Setting.FUNC_VOICE_VOLUME)))
	self:setSoundSwitchEnabled(SoundManager.KEY_MAPS.MUSIC, g.core.common.Setting:getValue(g.core.common.Setting.FUNC_BGM_SWITCH), true)
	self:setSoundSwitchEnabled(SoundManager.KEY_MAPS.SOUND, g.core.common.Setting:getValue(g.core.common.Setting.FUNC_SOUND_SWITCH), true)
	self:setSoundSwitchEnabled(SoundManager.KEY_MAPS.VOICE, g.core.common.Setting:getValue(g.core.common.Setting.FUNC_VOICE_SWITCH), true)
end

function SoundManager:setLanguage(arg_16_1)
	if var_0_1 then
		var_0_1:setCurrentLanguage(arg_16_1)
	end
end

function SoundManager:isCurSoundJapanese()
	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		local var_17_0 = g.core.common.Storage:load("sound_language.json", false) or {}

		if not var_17_0.isJap then
			return true
		else
			return var_17_0.isJap == 1
		end
	end

	return true
end

function SoundManager:saveCurSoundLanguage(arg_18_1)
	if config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.CHINA then
		g.core.common.Storage:save("sound_language.json", {
			isJap = arg_18_1 and 1 or 0
		}, false)
	end
end

function SoundManager:turnToWWiseName(arg_19_1)
	local var_19_0 = string.reverse(arg_19_1)
	local var_19_1 = string.find(var_19_0, "/")

	if var_19_1 then
		arg_19_1 = string.reverse((string.sub(var_19_0, 1, var_19_1 - 1)))
	end

	local var_19_2 = string.find(arg_19_1, ".mp3")

	if var_19_2 then
		arg_19_1 = string.sub(arg_19_1, 1, var_19_2 - 1)
	end

	if not g.core.sound.SoundManager:isCurSoundJapanese() then
		if g.core.const.ConstMgr.SoundConst.CN_SOUND[arg_19_1] then
			arg_19_1 = arg_19_1 .. "_CN"
		elseif g.core.const.ConstMgr.SoundConst.CN_EMPTY_SOUND[arg_19_1] then
			arg_19_1 = "Vo_Empty_CN"
		elseif g.core.const.ConstMgr.SoundConst.CN_EMPTY_SOUND_ROLE[arg_19_1] then
			arg_19_1 = "Vo_Empty_CN_Role"
		end
	end

	return arg_19_1
end

function SoundManager:setSoundsVolume(arg_20_1)
	arg_20_1 = g.core.utils.Number.formatNumberByLimit(arg_20_1 or 100, 0, 100)
	self._curSoundVolume = arg_20_1

	self:setRTPCValue("Sys_Sound", arg_20_1)
end

function SoundManager:getSoundsVolume()
	return self._curSoundVolume
end

function SoundManager:setMusicVolume(arg_22_1)
	arg_22_1 = g.core.utils.Number.formatNumberByLimit(arg_22_1 or 100, 0, 100)
	self._curMusicVolume = arg_22_1

	self:setRTPCValue("Sys_Music", arg_22_1)
end

function SoundManager:getMusicVolume()
	return self._curMusicVolume
end

function SoundManager:setVoiceVolume(arg_24_1)
	arg_24_1 = g.core.utils.Number.formatNumberByLimit(arg_24_1 or 100, 0, 100)
	self._curVoiceVolume = arg_24_1

	self:setRTPCValue("Sys_Voice", arg_24_1)
end

function SoundManager:getVoiceVolume()
	return self._curVoiceVolume
end

function SoundManager:preloadMusic(arg_26_1)
	if not self.inited then
		return
	end

	if var_0_1 then
		local var_26_0 = self:turnToWWiseName(arg_26_1)
	else
		audio.preloadMusic(self.pre .. arg_26_1)
	end
end

function SoundManager:playMusic(arg_27_1, arg_27_2)
	if not arg_27_1 or arg_27_1 == "" then
		return
	end

	local var_27_0 = arg_27_1

	if not arg_27_2 then
		self.preBackMusicName = var_27_0
	end

	if not self.inited then
		return
	end

	if self.backgroundMusic ~= var_27_0 or self._needRePlay then
		if var_0_1 then
			var_27_0 = self:turnToWWiseName(arg_27_1)

			var_0_1:postEvent(var_27_0)
		else
			arg_27_1 = string.gsub(arg_27_1, ".mp3", "")

			if not var_0_2:isFileExist(self.pre .. arg_27_1 .. ".mp3") then
				arg_27_1 = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MAIN_MENU
			end

			if self.backgroundMusic then
				self:stopMusic()
			end

			self._curMusic = table.concat({
				self.pre,
				arg_27_1,
				".mp3"
			})

			audio.playMusic(self._curMusic, true)

			if not audio.isMusicPlaying() then
				g.core.common.Scheduler:newScheduleOnce(handler(self, function(arg_28_0)
					audio.playMusic(arg_28_0._curMusic, true)
				end), 1)
			end
		end

		if not arg_27_2 then
			self.backgroundMusic = var_27_0
			self._needRePlay = false
		end
	end
end

function SoundManager:isMusicPlaying()
	return checkbool(self.backgroundMusic)
end

function SoundManager:getCurBgm()
	return self.backgroundMusic
end

function SoundManager:stopMusic()
	self.backgroundMusic = nil

	if not self.inited then
		return
	end

	if var_0_1 then
		var_0_1:postEvent(var_0_3.MUSIC_STOP)
	else
		audio.stopMusic(true)
	end
end

function SoundManager:pauseMusic()
	if not self.inited then
		return
	end

	if var_0_1 then
		var_0_1:postEvent(var_0_3.MUSIC_PAUSE)
	else
		audio.pauseMusic()
	end
end

function SoundManager:resumeMusic()
	if not self.inited then
		return
	end

	if var_0_1 then
		var_0_1:postEvent(var_0_3.MUSIC_RESUME)
	else
		audio.resumeMusic()
	end
end

function SoundManager:rewindMusic()
	if not self.inited then
		return
	end

	if var_0_1 then
		var_0_1:postEvent((self:turnToWWiseName(self.preBackMusicName)))
	end
end

function SoundManager:playSound(arg_35_1, arg_35_2)
	if not arg_35_1 or arg_35_1 == "" then
		return
	end

	if arg_35_1 and (string.match(arg_35_1, "^Music_") or string.match(arg_35_1, "^CG_")) and not string.match(arg_35_1, "^UI_") then
		self._needRePlay = true

		self:playMusic(arg_35_1, true)

		return
	end

	if not self.inited then
		return
	end

	if var_0_1 then
		local var_35_0 = self:turnToWWiseName(arg_35_1)

		if g.core.const.ConstMgr.BASE_CONST.MUTE_STORY_AND_GUIDE_SOUND and g.core.model.User.storyData:isPlayStorySound() and string.match(arg_35_1, "^Vo_") then
			if arg_35_2 then
				g.core.common.Scheduler:newScheduleOnce(function()
					if arg_35_2 then
						arg_35_2()
					end
				end, 2)
			end

			return
		end

		if string.match(arg_35_1, "^Vo_") and arg_35_2 then
			var_0_1:postEvent(var_35_0, 1, arg_35_2)
		else
			var_0_1:postEvent(var_35_0)
		end
	else
		if not var_0_2:isFileExist(self.pre .. arg_35_1 .. ".mp3") then
			if arg_35_2 then
				g.core.common.Scheduler:newScheduleOnce(handler(self, function(arg_37_0)
					arg_35_2()
				end), 1)
			end

			return
		end

		if arg_35_2 then
			g.core.common.Scheduler:newScheduleOnce(audio.playSound(table.concat({
				self.pre,
				arg_35_1,
				".mp3"
			}), false)(self, function(arg_38_0)
				arg_35_2()
			end), 1)
		end
	end
end

function SoundManager:playBattleSound(arg_39_1, arg_39_2)
	if not self.inited then
		return
	end

	if var_0_1 then
		self:playSound((self:turnToWWiseName(arg_39_1)))
	end
end

function SoundManager:setSkillSoundPause(arg_40_1)
	if not self.inited then
		return
	end

	if not var_0_1 then
		return
	end

	var_0_1:postEvent(var_40_0)
end

function SoundManager:pauseSound(arg_41_1)
	return
end

function SoundManager:resumeSound(arg_42_1)
	return
end

function SoundManager:stopSound(arg_43_1)
	return
end

function SoundManager:stopAllSounds()
	if not self.inited then
		return
	end

	if var_0_1 then
		var_0_1:postEvent(var_0_3.SOUND_STOP)
	else
		audio.stopAllSounds()
	end
end

function SoundManager:pauseAllSounds()
	if not self.inited then
		return
	end

	if var_0_1 then
		var_0_1:postEvent(var_0_3.SOUND_PAUSE)
	else
		audio.pauseAllSounds()
	end
end

function SoundManager:resumeAllSounds()
	if not self.inited then
		return
	end

	if var_0_1 then
		var_0_1:postEvent(var_0_3.SOUND_RESUME)
	else
		audio.resumeAllSounds()
	end
end

function SoundManager:preloadSound(arg_47_1)
	if not self.inited then
		return
	end

	if var_0_1 then
		-- block empty
	else
		audio.preloadSound(self.pre .. arg_47_1)
	end
end

function SoundManager:unloadSound(arg_48_1)
	if not self.inited then
		return
	end

	if var_0_1 then
		-- block empty
	else
		audio.unloadSound(self.pre .. arg_48_1)
	end
end

function SoundManager:setSoundSwitchEnabled(arg_49_1, arg_49_2, arg_49_3)
	if not arg_49_3 and arg_49_2 and not self.inited then
		self:initWise()
	end

	if var_0_1 then
		var_0_1:postEvent(var_0_3[(arg_49_2 or nil) and (arg_49_1 .. "_ON" or arg_49_1 .. "_OFF")])
	end

	self:checkLoadBanks()
end

function SoundManager:pauseAll()
	if not self.inited then
		return
	end
end

function SoundManager:resumeAll()
	if not self.inited then
		return
	end

	if self._lastMusicState ~= nil then
		var_0_1:postEvent(var_0_3.MUSIC_PLAY)
		var_0_1:postEvent((self:turnToWWiseName(self.backgroundMusic)))

		self._lastMusicState = nil
	end

	if self._lastSoundState ~= nil then
		self._lastSoundState = nil
	end
end

function SoundManager:setRTPCValue(arg_52_1, arg_52_2)
	if not self.inited then
		return
	end

	if var_0_1 then
		var_0_1:setRTPCValue(arg_52_1, arg_52_2)
	elseif arg_52_1 == "Sys_Sound" then
		audio.setSoundsVolume(arg_52_2 / 100)
	elseif arg_52_1 == "Sys_Music" then
		audio.setMusicVolume(arg_52_2 / 100)
	end
end

function SoundManager:setGroupState(arg_53_1, arg_53_2)
	if not self.inited then
		return
	end

	if var_0_1 then
		var_0_1:setState(arg_53_1, arg_53_2)
	end
end

function SoundManager:setCurrentGender(arg_54_1)
	if not self.inited then
		return
	end

	if var_0_1 then
		if arg_54_1 then
			var_0_1:postEvent("GenderSelect_Man")
		else
			var_0_1:postEvent("GenderSelect_Woman")
		end
	end
end

function SoundManager:stopCurrentVoice()
	if not self.inited then
		return
	end

	if var_0_1 then
		var_0_1:postEvent("Stop_Voice_Actor")
	end
end

function SoundManager:switchPVCG2Music()
	if var_0_1 then
		var_0_1:postEvent(var_0_3.PV_CG_STOP)
	end
end

function SoundManager:pauseMovieSound()
	if var_0_1 then
		var_0_1:postEvent(var_0_3.ANIMATION_PAUSE)
	end
end

function SoundManager:resumeMovieSound()
	if var_0_1 then
		var_0_1:postEvent(var_0_3.ANIMATION_RESUME)
	end
end

function SoundManager:cacheBattleBanks(arg_59_1)
	if not var_0_1 then
		return
	end

	arg_59_1 = table.concat({
		"s_",
		arg_59_1
	})

	if self.loadedBattleBankSet[arg_59_1] ~= nil then
		return
	end

	print("cacheBattleBanks", arg_59_1)
	var_0_1:loadBank(arg_59_1)

	self.loadedBattleBankSet[arg_59_1] = true
end

function SoundManager:unloadBattleBanks()
	if not var_0_1 then
		return
	end

	for iter_60_0, iter_60_1 in pairs(self.loadedBattleBankSet) do
		print("unCacheBattleBanks", iter_60_0)
		var_0_1:unloadBank(iter_60_0)
	end

	self.loadedBattleBankSet = {}
end

return SoundManager
