local var_0_0 = {}
local var_0_1 = {
	perfect_score_time = 1.2,
	refresh_time_max = 2.5,
	refresh_time_reduce_speed = 0.1,
	refresh_time_min = 1,
	level_time = 45,
	refresh_time_reduce_time = 5,
	mouse_conf = {
		{
			score = 1,
			exist_time = 3,
			weight = 35,
			type = 1
		},
		{
			score = 2,
			exist_time = 2,
			weight = 25,
			type = 2
		},
		{
			score = 3,
			exist_time = 1,
			weight = 15,
			type = 3
		},
		{
			score = 0,
			error_reduce_time = 3,
			type = 4,
			weight = 25,
			exist_time = 2
		}
	}
}

var_0_1.max_mouse_count = 8

local function var_0_2(arg_1_0)
	if type(arg_1_0) ~= "table" then
		return
	end

	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		if next(iter_1_1) then
			var_1_0 = var_1_0 + 1
		end
	end

	return var_1_0
end

function var_0_0:initData()
	self.mouseData = {}
	self.score = 0
	self.mouse_num = 0
	self.time = 0
	self.limit_time = var_0_1.level_time
	self.refresh_time = 0
	self.refresh_time_reduce_time = 0
	self.refresh_time_min = var_0_1.refresh_time_min
	self.refresh_time_max = var_0_1.refresh_time_max
	self.ever_refresh_time = math.random(self.refresh_time_min * 100, self.refresh_time_max * 100) / 100
	self.gameEvents = {}
	self.all_right = true
	self.perfect_score_time = var_0_1.perfect_score_time
	self.mouse = {}

	for iter_2_0 = 1, var_0_1.max_mouse_count do
		self.mouse[iter_2_0] = {}
	end
end

function var_0_0.registerUIRef(arg_3_0, arg_3_1)
	arg_3_0.uiref = arg_3_1
end

function var_0_0.unregisterUIRef(arg_4_0)
	arg_4_0.uiref = nil
end

function var_0_0:exitGame()
	self:unloop()
	self:initData()
	self:unregisterUIRef()
end

function var_0_0:registerGameEvent(arg_6_1, arg_6_2, arg_6_3)
	self.gameEvents[arg_6_1] = self.gameEvents[arg_6_1] or {}

	table.insert(self.gameEvents[arg_6_1], {
		obj = arg_6_2,
		handler = arg_6_3
	})
end

function var_0_0:unregisterGameEvent(arg_7_1, arg_7_2)
	if self.gameEvents[arg_7_1] then
		for iter_7_0, iter_7_1 in pairs(self.gameEvents[arg_7_1]) do
			if iter_7_1.handler == arg_7_2 then
				table.remove(self.gameEvents[arg_7_1], iter_7_1)
			end
		end
	end
end

function var_0_0:dispatcherEvent(arg_8_1, ...)
	if self.gameEvents[arg_8_1] then
		for iter_8_0, iter_8_1 in pairs(self.gameEvents[arg_8_1]) do
			iter_8_1.handler(iter_8_1.obj, ...)
		end
	end
end

function var_0_0:gameStart()
	if not self.uiref then
		return
	end

	if self.mainloop then
		return
	end

	self:initData()
	self.uiref:registerGameEvent()
	self:createMainLoop()
end

function var_0_0:gameUpdate(arg_10_1)
	if self.gamePaused then
		return
	end

	if self.time < self.limit_time then
		self.time = self.time + arg_10_1
	else
		self:gameEnd()
	end

	for iter_10_0, iter_10_1 in pairs(self.mouse) do
		if next(iter_10_1) then
			if iter_10_1.time < iter_10_1.exist_time then
				iter_10_1.time = iter_10_1.time + arg_10_1
			else
				self:mouse_disappear(iter_10_0)
			end
		end
	end

	if self.refresh_time_reduce_time < var_0_1.refresh_time_reduce_time then
		self.refresh_time_reduce_time = self.refresh_time_reduce_time + arg_10_1
	else
		self.refresh_time_min = self.refresh_time_min * (1 - var_0_1.refresh_time_reduce_speed)
		self.refresh_time_max = self.refresh_time_max * (1 - var_0_1.refresh_time_reduce_speed)
		self.refresh_time_reduce_time = 0
	end

	if var_0_2(self.mouse) < var_0_1.max_mouse_count then
		if self.refresh_time < self.ever_refresh_time then
			self.refresh_time = self.refresh_time + arg_10_1
		else
			self.ever_refresh_time = math.random(self.refresh_time_min * 100, self.refresh_time_max * 100) / 100
			self.refresh_time = 0

			self:create_new_mouse()
		end
	end

	self:dispatcherEvent("UPDATE_UI", {
		time = self.time,
		limit_time = self.limit_time,
		score = self.score
	})
end

function var_0_0:create_new_mouse()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self.mouse) do
		if not next(iter_11_1) then
			table.insert(var_11_0, iter_11_0)
		end
	end

	if #var_11_0 <= 0 then
		return
	end

	local var_11_1 = var_11_0[math.random(#var_11_0)]
	local var_11_2 = math.random(4)

	self.mouse[var_11_1] = {
		time = 0,
		type = var_11_2,
		exist_time = var_0_1.mouse_conf[var_11_2].exist_time,
		score = var_0_1.mouse_conf[var_11_2].score,
		error_reduce_time = var_0_1.mouse_conf[var_11_2].error_reduce_time,
		index = var_11_1
	}

	self:dispatcherEvent("CREATE_NEW_MOUSE", self.mouse[var_11_1])
end

function var_0_0:mouse_disappear(arg_12_1)
	self.mouse[arg_12_1] = {}

	self:dispatcherEvent("MOUSE_DISAPPEAR", arg_12_1)
end

function var_0_0:gameEnd()
	self:unloop()

	local var_13_0

	if self.all_right then
		var_13_0 = self.score * self.perfect_score_time

		local var_13_1

		if not (self.score * self.perfect_score_time) then
			var_13_0 = self.score
			var_13_1 = {}
		end
	end

	var_13_1.key_point_num = math.max(0, (math.floor(var_13_0)))
	var_13_1.score = self.mouse_num
	var_13_1.all_right = self.all_right

	self:dispatcherEvent("GAME_END", var_13_1)
	self:initData()
end

function var_0_0:hit_mouse(arg_14_1)
	if not self.mouse[arg_14_1] then
		return
	end

	local var_14_0 = self.mouse[arg_14_1]
	local var_14_2

	if self.mouse[arg_14_1].error_reduce_time then
		self.time = self.time + var_14_0.error_reduce_time
		self.all_right = false
		var_14_2 = false
	else
		self.mouse_num = self.mouse_num + 1
		self.score = self.score + var_14_0.score
		var_14_2 = true
	end

	self.mouse[arg_14_1] = {}

	self:dispatcherEvent("MOUSE_DISAPPEAR", arg_14_1, true, var_14_2)
	self:dispatcherEvent("UPDATE_UI", {
		time = self.time,
		limit_time = self.limit_time,
		score = self.score
	})
end

function var_0_0:createMainLoop()
	self.mainloop = self.mainloop or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_16_0)
		self:gameUpdate(arg_16_0)
	end, 0, false)
end

function var_0_0:unloop()
	if self.mainloop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.mainloop)

		self.mainloop = nil
	end
end

return var_0_0
