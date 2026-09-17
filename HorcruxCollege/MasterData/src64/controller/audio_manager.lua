local var_0_0 = {
	infight = {}
}

var_0_0.isPlayVoice = false
var_0_0.music_volume = 2
var_0_0.effect_volume = 2
var_0_0.voice_volume = 3
var_0_0.audioVolume = {
	[0] = 0,
	0.5,
	0.8,
	1
}
var_0_0._musicscale = 0.2
var_0_0._effectscale = 0.4
var_0_0._fightscale = 0.4
var_0_0._voicescale = 1
BOSS_VOLUME = 0.8

require("data.audio_constants")

local audio_module = require("controller.audio_module")

var_0_0.activeBGM = LOADING_BGM
var_0_0._buffers = {}
var_0_0._sources = {}
var_0_0._fightsources = setmetatable({}, {
	__mode = "kv"
})
var_0_0._scheduler = nil
var_0_0._switchscheduler = nil
var_0_0._switchaction = nil
var_0_0._loopeffects = {}

local function var_0_4(arg_1_0)
	local var_1_0 = #var_0_0._sources

	while 2 <= var_1_0 do
		local var_1_1

		if var_0_0._sources[2]:getStat() == 4 then
			var_0_0._sources[2]:__gc()
			table.remove(var_0_0._sources, 2)

			var_1_0 = var_1_0 - 1
		else
			var_1_1 = 2 + 1
		end
	end

	if var_1_0 == 1 then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_0._scheduler)

		var_0_0._scheduler = nil
	end
end

function var_0_0.isAudioExist(arg_2_0, arg_2_1)
	local file_check_manager = require("controller.filedownloader.file_check_manager")

	if file_check_manager:checkFileNeedDownload(arg_2_1) then
		local var_2_1 = {}

		table.insert(var_2_1, (file_check_manager:getFileDownloadInfo(arg_2_1)))
		require("controller.filedownloader.download_manager"):insertDownloadTasks(var_2_1)
	else
		return true
	end
end

function var_0_0:loadAudio(arg_3_1, arg_3_2)
	if self._buffers[arg_3_1] then
		if arg_3_2 then
			arg_3_2()
		end

		return
	end

	if not self:isAudioExist(arg_3_1) then
		return
	end

	Rapid2D_CAudio.newBuffer(arg_3_1, function(arg_4_0)
		if arg_4_0 then
			self._buffers[arg_3_1] = arg_4_0
		end

		if arg_3_2 then
			arg_3_2()
		end
	end)
end

function var_0_0:unloadAudio(arg_5_1)
	if self._buffers[arg_5_1] then
		self._buffers[arg_5_1]:__gc()
	end

	self._buffers[arg_5_1] = nil
end

function var_0_0:unloadAllAudio()
	for iter_6_0, iter_6_1 in pairs(self._buffers) do
		iter_6_1:__gc()
	end

	self._buffers = {}
end

function var_0_0.init(arg_7_0)
	arg_7_0.music_volume = cc.UserDefault:getInstance():getIntegerForKey("music_volume", 2)
	arg_7_0.effect_volume = cc.UserDefault:getInstance():getIntegerForKey("effect_volume", 2)
	arg_7_0.voice_volume = cc.UserDefault:getInstance():getIntegerForKey("voice_volume", 2)
end

function var_0_0:pauseAllSources()
	for iter_8_0, iter_8_1 in pairs(self._sources) do
		iter_8_1:pause()
	end
end

function var_0_0:resumeAllSources()
	for iter_9_0, iter_9_1 in pairs(self._sources) do
		iter_9_1:resume()
	end
end

function var_0_0:stopAllSources()
	for iter_10_0, iter_10_1 in pairs(self._sources) do
		iter_10_1:stop()
		iter_10_1:__gc()
	end

	self._sources = {}

	if self._scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._scheduler)

		self._scheduler = nil
	end
end

function var_0_0:playbackgroundMusic(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_2 ~= nil and arg_11_2 or true

	arg_11_3 = arg_11_3 or 1
	arg_11_4 = arg_11_4 or arg_11_3

	self:loadAudio(arg_11_1 .. ".ogg", function()
		local var_12_0 = self._buffers[arg_11_1 .. ".ogg"]

		if not self._buffers[arg_11_1 .. ".ogg"] then
			print(arg_11_1 .. " have not loaded!!!")

			return
		end

		local var_12_1 = self.audioVolume[self.music_volume] * self._musicscale * arg_11_3

		if not self._sources[1] then
			self._sources[1] = audio_module.new(self.audioVolume[self.music_volume] * self._musicscale * arg_11_4)
		else
			self._sources[1]:setRawVolume(self.audioVolume[self.music_volume] * self._musicscale * arg_11_4)
		end

		self._sources[1]:stop()
		self._sources[1]:play2d(var_12_0, var_11_0)
		self._sources[1]:setVolume(var_12_1)

		var_0_0.activeBGM = arg_11_1
		var_0_0.curbgmVolume = arg_11_3
	end)
end

function var_0_0:setbackgroundMusicVolume(arg_13_1)
	arg_13_1 = self.audioVolume[self.music_volume] * self._musicscale * arg_13_1

	self._sources[1]:setVolume(arg_13_1)
end

function var_0_0:pausebackgroundMusic()
	self._sources[1]:pause()
end

function var_0_0:stopbackgroundMusic()
	if self._sources[1] then
		self._sources[1]:stop()
	end
end

function var_0_0:resumebackgroundMusic()
	self._sources[1]:resume()
end

function var_0_0:switchLayerBGM(arg_17_1, arg_17_2, arg_17_3)
	if self.activeBGM ~= arg_17_1 then
		if not self._sources[1] or self.music_volume == 0 then
			self:playbackgroundMusic(arg_17_1, arg_17_2, arg_17_3)
		else
			self:runSwitchBGMAction(arg_17_1, arg_17_2, arg_17_3)
		end
	end
end

local tween = require("fight.tween")

local function var_0_6(arg_18_0)
	var_0_0._sources[1]:setVolume(var_0_0._sources[1]:getRawVolume() * arg_18_0)

	for iter_18_0, iter_18_1 in pairs(var_0_0._fightsources) do
		iter_18_1:setVolume(iter_18_1:getRawVolume() * arg_18_0)
	end
end

local function var_0_7(arg_19_0)
	if not var_0_0._switchaction then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_0._switchscheduler)

		var_0_0._switchscheduler = nil

		return
	end

	if var_0_0._switchaction.actionStat == "loading" then
		return
	end

	if var_0_0._switchaction:update(arg_19_0) then
		if var_0_0._switchaction.actionStat == "fadeout" then
			var_0_0._switchaction.actionStat = "loading"

			var_0_0:playbackgroundMusic(var_0_0._switchaction.switchconf[1], var_0_0._switchaction.switchconf[2], var_0_0._switchaction.switchconf[3], var_0_0._switchaction.switchconf[3])

			var_0_0._switchaction = tween.new(0.5, {
				volume = 0
			}, {
				volume = 1
			}, "outQuad")
			var_0_0._switchaction.actionStat = "fadein"

			var_0_0._sources[1]:setVolume(0)
		else
			var_0_6(var_0_0._switchaction.subject.volume)

			var_0_0._switchaction = nil

			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_0._switchscheduler)

			var_0_0._switchscheduler = nil
		end
	else
		var_0_6(var_0_0._switchaction.subject.volume)
	end
end

function var_0_0:runSwitchBGMAction(arg_20_1, arg_20_2, arg_20_3)
	if self._switchscheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._switchscheduler)
	end

	self._switchaction = tween.new(0.5, {
		volume = self._sources[1]:getVolume() / self._sources[1]:getRawVolume()
	}, {
		volume = 0
	}, "inQuad")
	self._switchaction.actionStat = "fadeout"
	self._switchaction.switchconf = {
		arg_20_1,
		arg_20_2,
		arg_20_3 or 1
	}
	self._switchscheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_7, 0, false)
end

function var_0_0:stopSwtichBGMAction()
	self._switchaction = nil

	if self._switchscheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._switchscheduler)

		self._switchscheduler = nil
	end
end

function var_0_0:setMusicVolume()
	self._sources[1]:setVolume(self.audioVolume[self.music_volume] * self._musicscale * self.curbgmVolume)
	self._sources[1]:setRawVolume(self.audioVolume[self.music_volume] * self._musicscale * self.curbgmVolume)
end

function var_0_0:playeffectMusic(arg_23_1, arg_23_2, arg_23_3)
	if self.effect_volume == 0 then
		return
	end

	local var_23_0 = arg_23_2 ~= nil and arg_23_2 or false
	local var_23_1 = (arg_23_3 or 1) * self.audioVolume[self.effect_volume] * self._effectscale

	if (arg_23_3 or 1) * self.audioVolume[self.effect_volume] * self._effectscale > 1 then
		var_23_1 = 1
	end

	if var_23_1 < 0 then
		var_23_1 = 0
	end

	if not arg_23_1:find("^sound") then
		arg_23_1 = "sound/" .. arg_23_1
	end

	arg_23_1 = arg_23_1 .. ".ogg"

	self:loadAudio(arg_23_1, function()
		if not self._buffers[arg_23_1] then
			print(arg_23_1 .. " have not loaded!!!")

			return
		end

		local var_24_0 = audio_module.new(var_23_1)

		if not var_24_0 then
			return
		end

		table.insert(self._sources, var_24_0)
		var_24_0:setVolume(var_23_1)
		var_24_0:play2d(self._buffers[arg_23_1], var_23_0)

		self._scheduler = self._scheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_4, 0.1, false)
	end)
end

function var_0_0:playeffectMusic2(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if self.effect_volume == 0 then
		return
	end

	local var_25_0 = arg_25_2 ~= nil and arg_25_2 or false
	local var_25_1 = (arg_25_3 or 1) * self.audioVolume[self.effect_volume] * self._effectscale

	if (arg_25_3 or 1) * self.audioVolume[self.effect_volume] * self._effectscale > 1 then
		var_25_1 = 1
	end

	if var_25_1 < 0 then
		var_25_1 = 0
	end

	if not arg_25_1:find("^sound") then
		arg_25_1 = "sound/" .. arg_25_1
	end

	arg_25_1 = arg_25_1 .. ".ogg"

	self:loadAudio(arg_25_1, function()
		if not self._buffers[arg_25_1] then
			print(arg_25_1 .. " have not loaded!!!")

			return
		end

		local var_26_0 = audio_module.new(var_25_1)

		if not var_26_0 then
			return
		end

		table.insert(self._sources, var_26_0)
		var_26_0:setVolume(var_25_1)
		var_26_0:play2d(self._buffers[arg_25_1], var_25_0)

		if not var_26_0:isFinished() and arg_25_4 then
			arg_25_4(var_26_0)
		end

		self._scheduler = self._scheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_4, 0.1, false)
	end)
end

var_0_0.playeffectMusicTest = var_0_0.playeffectMusic

function var_0_0:playLoopEffectMusic(arg_27_1, arg_27_2)
	if self.effect_volume == 0 then
		return
	end

	local var_27_0 = (arg_27_2 or 1) * self.audioVolume[self.effect_volume] * self._effectscale

	if (arg_27_2 or 1) * self.audioVolume[self.effect_volume] * self._effectscale > 1 then
		var_27_0 = 1
	end

	if var_27_0 < 0 then
		var_27_0 = 0
	end

	if not arg_27_1:find("^sound") then
		arg_27_1 = "sound/" .. arg_27_1
	end

	arg_27_1 = arg_27_1 .. ".ogg"

	if self._loopeffects[arg_27_1] then
		return
	end

	self:loadAudio(arg_27_1, function()
		if not self._buffers[arg_27_1] then
			print(arg_27_1 .. " have not loaded!!!")

			return
		end

		local var_28_0 = audio_module.new(var_27_0)

		if not var_28_0 then
			return
		end

		table.insert(self._sources, var_28_0)
		var_28_0:setVolume(var_27_0)
		var_28_0:play2d(self._buffers[arg_27_1], true)

		self._loopeffects[arg_27_1] = #self._sources
	end)
end

function var_0_0:stopLoopEffectMusicForKey(arg_29_1)
	if not arg_29_1:find("^sound") then
		arg_29_1 = "sound/" .. arg_29_1
	end

	arg_29_1 = arg_29_1 .. ".ogg"

	if not self._loopeffects[arg_29_1] then
		return
	end

	local var_29_0 = self._loopeffects[arg_29_1]

	self._loopeffects[arg_29_1] = nil

	if not self._sources[var_29_0] then
		return
	end

	self._sources[var_29_0]:stop()

	self._scheduler = self._scheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_4, 0.1, false)
end

function var_0_0:pauseAllEffect()
	for iter_30_0 = 2, #self._sources do
		self._sources[iter_30_0]:pause()
	end
end

function var_0_0:stopAllEffects()
	for iter_31_0 = 2, #self._sources do
		self._sources[iter_31_0]:stop()
	end
end

function var_0_0:pauseeffectMusic()
	self:stopAllEffects()
end

function var_0_0:playFightEffect(arg_33_1, arg_33_2, arg_33_3)
	if self.effect_volume == 0 then
		return
	end

	if not self.infight then
		return
	end

	if self._switchaction and self._switchaction.actionStat ~= "fadein" then
		return
	end

	local var_33_0 = arg_33_2 or 1

	var_33_0 = arg_33_1:find("role_voice") and var_33_0 * self.audioVolume[self.voice_volume] * self._voicescale or var_33_0 * self.audioVolume[self.effect_volume] * self._fightscale

	if var_33_0 > 1 then
		var_33_0 = 1
	end

	if var_33_0 < 0 then
		var_33_0 = 0
	end

	if not arg_33_1:find("^sound") then
		arg_33_1 = "sound/" .. arg_33_1
	end

	arg_33_1 = arg_33_1 .. ".ogg"
	arg_33_3 = arg_33_3 or 1

	self:loadAudio(arg_33_1, function()
		if not self._buffers[arg_33_1] then
			print(arg_33_1 .. " have not loaded!!!")

			return
		end

		local var_34_0 = audio_module.new(var_33_0, nil, "fight")

		if not var_34_0 then
			return
		end

		table.insert(self._sources, var_34_0)

		self._fightsources[#self._fightsources + 1] = var_34_0

		if self._switchaction then
			var_33_0 = var_33_0 * self._switchaction.subject.volume
		end

		var_34_0:setVolume(var_33_0)
		var_34_0:play2d(self._buffers[arg_33_1], false)
		var_34_0:setSpeed(arg_33_3)

		self._scheduler = self._scheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_4, 0.1, false)
	end)
end

var_0_0.playingplayersound = false

function var_0_0:playPlayerSound(arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	if self.voice_volume == 0 then
		if arg_35_4 then
			arg_35_4()
		end

		return
	end

	local var_35_0 = arg_35_2 ~= nil and arg_35_2 or false
	local var_35_2 = self.audioVolume[self.voice_volume] * self._voicescale

	if self.audioVolume[self.voice_volume] * self._voicescale > 1 then
		var_35_2 = 1
	end

	if var_35_2 < 0 then
		var_35_2 = 0
	end

	if not arg_35_1:find("^sound") then
		arg_35_1 = "sound/" .. arg_35_1
	end

	arg_35_1 = arg_35_1 .. ".ogg"

	self:loadAudio(arg_35_1, function()
		if not self._buffers[arg_35_1] then
			print(arg_35_1 .. " have not loaded!!!")

			if arg_35_4 then
				arg_35_4()
			end

			return
		end

		local var_36_0 = audio_module.new(var_35_2, arg_35_4, "role")

		if not var_36_0 then
			return
		end

		table.insert(self._sources, var_36_0)
		var_36_0:setVolume(var_35_2)
		var_36_0:play2d(self._buffers[arg_35_1], var_35_0)

		self._scheduler = self._scheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_4, 0.1, false)
	end)
end

function var_0_0:playPlayerSoundTalkLayer(arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5)
	if self.voice_volume == 0 then
		if arg_37_4 then
			arg_37_4()
		end

		return
	end

	local var_37_0 = arg_37_2 ~= nil and arg_37_2 or false
	local var_37_2 = self.audioVolume[self.voice_volume] * self._voicescale

	if self.audioVolume[self.voice_volume] * self._voicescale > 1 then
		var_37_2 = 1
	end

	if var_37_2 < 0 then
		var_37_2 = 0
	end

	if not arg_37_1:find("^sound") then
		arg_37_1 = "sound/" .. arg_37_1
	end

	arg_37_1 = arg_37_1 .. ".ogg"

	self:loadAudio(arg_37_1, function()
		if not self._buffers[arg_37_1] then
			print(arg_37_1 .. " have not loaded!!!")

			if arg_37_4 then
				arg_37_4()
			end

			return
		end

		local var_38_0 = audio_module.new(var_37_2, arg_37_4, "role")

		if not var_38_0 then
			return
		end

		table.insert(self._sources, var_38_0)
		var_38_0:setVolume(var_37_2)
		var_38_0:play2d(self._buffers[arg_37_1], var_37_0)

		if not var_38_0:isFinished() and arg_37_5 then
			arg_37_5(var_38_0)
		end

		self._scheduler = self._scheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_4, 0.1, false)
	end)
end

function var_0_0:stopAllRoleSound()
	for iter_39_0 = 1, #self._sources do
		if self._sources[iter_39_0]:getSourceType() == "role" then
			self._sources[iter_39_0]:stop()
		end
	end
end

function var_0_0:pauseAllFightSound()
	for iter_40_0 = 1, #self._sources do
		if self._sources[iter_40_0]:getSourceType() == "fight" then
			self._sources[iter_40_0]:pause()
		end
	end
end

function var_0_0:resumeAllFightSound()
	for iter_41_0 = 1, #self._sources do
		if self._sources[iter_41_0]:getSourceType() == "fight" then
			self._sources[iter_41_0]:resume()
		end
	end
end

function var_0_0.setEffectVolume(arg_42_0)
	return
end

function var_0_0.setVoiceVolume(arg_43_0)
	return
end

function var_0_0:isPlayerSoundValid()
	return self.voice_volume > 0 and not self.playingplayersound
end

function var_0_0:isCVNeedDelay()
	return self._switchaction ~= nil and self._switchaction.actionStat ~= "fadein"
end

return var_0_0
