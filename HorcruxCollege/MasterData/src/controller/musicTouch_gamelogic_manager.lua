local audio_manager = require("controller.audio_manager")
local var_0_1 = {}
local var_0_2 = {}

var_0_2.__index = var_0_2

function var_0_2.new()
	return setmetatable({
		first = 0,
		last = -1
	}, var_0_2)
end

function var_0_2:push(arg_2_1)
	self.last = self.last + 1
	self[self.last] = arg_2_1
end

function var_0_2:pop()
	if self.first > self.last then
		error("Queue is empty")
	end

	self[self.first] = nil
	self.first = self.first + 1

	return self[self.first]
end

function var_0_2:front()
	if self.first > self.last then
		return nil
	end

	return self[self.first]
end

function var_0_2:back()
	if self.first > self.last then
		return nil
	end

	return self[self.last]
end

function var_0_2:size()
	return self.last - self.first + 1
end

function var_0_2:empty()
	return self.first > self.last
end

local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 2
local var_0_6 = 4
local var_0_7 = 4
local var_0_8 = 25
local var_0_9 = {
	end_height = -75,
	great_juding_abs = 100,
	perfect_score = 20,
	limit_time = 60,
	perfect_judging_abs = 20,
	miss_score = 1,
	great_score = 10,
	speacial_score_multiple = 2,
	note_time_space_max = 2.5,
	progress_time = 20,
	note_time_space_min = 1,
	speacial_duration = 5,
	combo_to_progress_multiple = 0.1,
	fall_speed = 120,
	init_height = 700,
	note_add_num = 2
}
local var_0_10 = {
	end_height = -25,
	great_juding_abs = 100,
	perfect_score = 20,
	limit_time = 60,
	perfect_judging_abs = 20,
	miss_score = 1,
	great_score = 10,
	speacial_score_multiple = 2,
	note_time_space_max = 1.5,
	progress_time = 20,
	note_time_space_min = 0.8,
	speacial_duration = 5,
	combo_to_progress_multiple = 0.1,
	fall_speed = 220,
	init_height = 750,
	note_add_num = 2
}

var_0_1.mode = 1

function var_0_1:resetData()
	self.mode = self.mode or var_0_3
	self.channel_num = 0
	self.channels = {}
	self.game_conf = nil
	self.note_time = 0
	self.random_note_time = 0
	self.score = 0
	self.combo = 0
	self.max_combo = 0
	self.time = 0
	self.progress_time = 0
	self.inSpeacialTime = false
end

function var_0_1:initData()
	self.mode = self.mode or var_0_3

	if self.mode == var_0_3 then
		self.channel_num = var_0_5 or var_0_6
	end

	self.channels = {}

	for iter_9_0 = 1, self.channel_num do
		table.insert(self.channels, (var_0_2.new()))
	end

	if self.mode == var_0_3 then
		self.game_conf = var_0_9 or var_0_10
	end

	self.note_time = 0
	self.random_note_time = math.random(self.game_conf.note_time_space_min * 100, self.game_conf.note_time_space_max * 100) / 100
	self.score = 0
	self.combo = 0
	self.max_combo = 0
	self.time = 0
	self.progress_time = 0
	self.inSpeacialTime = false
end

function var_0_1.registerUIRef(arg_10_0, arg_10_1)
	arg_10_0.uiref = arg_10_1
end

function var_0_1.unregisterUIRef(arg_11_0)
	arg_11_0.uiref = nil
end

function var_0_1:exitGame()
	self:unloop()
	self:resetData()
	self:unregisterUIRef()

	self.gameEvents = {}
end

function var_0_1:registerGameEvent(arg_13_1, arg_13_2, arg_13_3)
	self.gameEvents = self.gameEvents or {}
	self.gameEvents[arg_13_1] = self.gameEvents[arg_13_1] or {}

	table.insert(self.gameEvents[arg_13_1], {
		obj = arg_13_2,
		handler = arg_13_3
	})
end

function var_0_1:unregisterGameEvent(arg_14_1, arg_14_2)
	if self.gameEvents[arg_14_1] then
		for iter_14_0, iter_14_1 in pairs(self.gameEvents[arg_14_1]) do
			if iter_14_1.handler == arg_14_2 then
				table.remove(self.gameEvents[arg_14_1], iter_14_1)
			end
		end
	end
end

function var_0_1:dispatcherEvent(arg_15_1, ...)
	if self.gameEvents[arg_15_1] then
		for iter_15_0, iter_15_1 in pairs(self.gameEvents[arg_15_1]) do
			iter_15_1.handler(iter_15_1.obj, ...)
		end
	end
end

function var_0_1:gameStart()
	if not self.uiref then
		return
	end

	if self.mainloop then
		return
	end

	self:initData()
	self:createMainLoop()
end

function var_0_1:gameUpdate(arg_17_1)
	if not self.mainloop then
		return
	end

	if self.gamePaused then
		return
	end

	if self.time < self.game_conf.limit_time then
		self.time = self.time + arg_17_1
	else
		self:gameEnd()

		return
	end

	if self.inSpeacialTime then
		self.progress_time = self.progress_time - arg_17_1

		if self.progress_time <= 0 then
			self.inSpeacialTime = false
			self.progress_time = 0
		end
	else
		self.progress_time = self.progress_time + arg_17_1 * (1 + self.game_conf.combo_to_progress_multiple * self.combo)

		if self.progress_time >= self.game_conf.progress_time then
			self.inSpeacialTime = true
			self.progress_time = self.game_conf.progress_time
		end
	end

	self.note_time = self.note_time + arg_17_1

	if self.note_time > self.random_note_time then
		self.note_time = 0
		self.random_note_time = math.random(self.game_conf.note_time_space_min * 100, self.game_conf.note_time_space_max * 100) / 100

		self:addNote()
	end

	for iter_17_0, iter_17_1 in pairs(self.channels) do
		if iter_17_1.first <= iter_17_1.last then
			for iter_17_2 = iter_17_1.first, iter_17_1.last do
				iter_17_1[iter_17_2].pos_y = iter_17_1[iter_17_2].pos_y - arg_17_1 * self.game_conf.fall_speed

				if iter_17_1[iter_17_2].node then
					iter_17_1[iter_17_2].node:setPositionY(iter_17_1[iter_17_2].pos_y)
				end

				if iter_17_1[iter_17_2].pos_y < self.game_conf.end_height then
					local var_17_0 = self.channels[iter_17_0]:pop()

					self.score = self.score + self.game_conf.miss_score
					self.combo = 0

					self:dispatcherEvent("CHANNEL_DELETE_NOTE", {
						show = "bad",
						index = iter_17_0,
						value = var_17_0
					})
				end
			end
		end
	end

	self:dispatcherEvent("UPDATE_GAMEDATA", {
		score = self.score,
		combo = self.combo,
		progress_total = self.game_conf.progress_time,
		progress_current = self.progress_time,
		time = math.max(0, self.game_conf.limit_time - self.time),
		inSpeacialTime = self.inSpeacialTime
	})
end

function var_0_1:addNote()
	local var_18_0 = {}

	while 0 < math.min(math.random(self.game_conf.note_add_num), #self.channels) do
		local var_18_1 = math.random(#self.channels)
		local var_18_2

		if not var_18_0[var_18_1] then
			var_18_0[var_18_1] = true
			var_18_2 = 0 + 1
		end
	end

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		local var_18_3 = {
			type = math.random(var_0_7),
			pos_y = self.game_conf.init_height
		}

		self.channels[iter_18_0]:push(var_18_3)
		self:dispatcherEvent("CHANNEL_ADD_NOTE", {
			index = iter_18_0,
			value = var_18_3
		})
	end
end

function var_0_1:MusicChannelTouch(arg_19_1)
	if not self.mainloop then
		return
	end

	if self.channels[arg_19_1]:empty() then
		return
	end

	local var_19_0 = self.channels[arg_19_1]:pop()
	local var_19_1 = "bad"

	if math.abs(var_19_0.pos_y - var_0_8) <= self.game_conf.perfect_judging_abs then
		self.score = self.score + self.game_conf.perfect_score
		self.combo = self.combo + 1
		var_19_1 = "perfect"

		audio_manager:playeffectMusic("sound/musicTouch_perfect")
		print("MusicChannelTouch perfect")
	elseif math.abs(var_19_0.pos_y - var_0_8) <= self.game_conf.great_juding_abs then
		if self.inSpeacialTime then
			self.score = self.score + self.game_conf.perfect_score
			var_19_1 = "perfect"

			audio_manager:playeffectMusic("sound/musicTouch_perfect")
			print("MusicChannelTouch great in speacial time")
		else
			self.score = self.score + self.game_conf.great_score
			var_19_1 = "good"

			audio_manager:playeffectMusic("sound/musicTouch_great")
			print("MusicChannelTouch great")
		end

		self.combo = self.combo + 1
	else
		self.score = self.score + self.game_conf.miss_score
		self.combo = 0
		var_19_1 = "bad"

		audio_manager:playeffectMusic("sound/musicTouch_miss")
		print("MusicChannelTouch miss")
	end

	if self.combo > self.max_combo then
		self.max_combo = self.combo
	end

	self:dispatcherEvent("CHANNEL_DELETE_NOTE", {
		index = arg_19_1,
		value = var_19_0,
		show = var_19_1
	})
	self:dispatcherEvent("UPDATE_GAMEDATA", {
		score = self.score,
		combo = self.combo,
		progress_total = self.game_conf.progress_time,
		progress_current = self.progress_time,
		inSpeacialTime = self.inSpeacialTime
	})
end

function var_0_1:gameEnd()
	self:unloop()
	self:dispatcherEvent("GAME_END", {
		score = self.score,
		mode = self.mode,
		max_combo = self.max_combo
	})
	self:resetData()
end

function var_0_1:switch_difficulty()
	if self.mainloop then
		return
	end

	if self.mode == var_0_3 then
		self.mode = var_0_4 or var_0_3
	end
end

function var_0_1:createMainLoop()
	self.mainloop = self.mainloop or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_23_0)
		self:gameUpdate(arg_23_0)
	end, 0, false)
end

function var_0_1:unloop()
	if self.mainloop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.mainloop)

		self.mainloop = nil
	end
end

return var_0_1
