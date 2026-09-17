local var_0_0 = {}
local var_0_1
local var_0_2 = 0
local var_0_3
local var_0_4 = {}

local function var_0_5()
	for iter_1_0, iter_1_1 in pairs(var_0_4) do
		iter_1_1(var_0_2, var_0_3)
	end
end

local var_0_6 = {}

local function var_0_7(arg_2_0)
	local var_2_0 = cc.EventCustom:new("timeCheckManagerEvent")

	var_2_0.eventType = arg_2_0

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_2_0)
end

local function var_0_8()
	if not var_0_6[1] then
		return
	end

	if var_0_2 > var_0_6[1].time then
		var_0_7(table.remove(var_0_6, 1).eventType)
	end
end

local function var_0_9(arg_4_0)
	var_0_2 = var_0_2 + arg_4_0
	var_0_3 = arg_4_0

	var_0_5()
	var_0_8()
end

local function var_0_10()
	var_0_1 = var_0_1 or cc.Director:getInstance():getScheduler():scheduleScriptFunc(var_0_9, 1, false)
end

local function var_0_11()
	if var_0_1 then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(var_0_1)

		var_0_1 = nil
	end
end

local function var_0_12(arg_7_0)
	local var_7_0 = os.date("*t", checkint(var_0_2))
	local var_7_1 = checkint(var_0_2)
	local var_7_2 = {
		year = var_7_0.year,
		month = var_7_0.month,
		day = var_7_0.day
	}

	var_7_2.hour = arg_7_0.hour or 0
	var_7_2.min = arg_7_0.min or 0
	var_7_2.sec = arg_7_0.sec or 0

	if arg_7_0.wday then
		var_7_2.day = var_7_2.day + arg_7_0.wday - var_7_0.wday

		if var_7_1 >= os.time(var_7_2) then
			var_7_2.day = var_7_2.day + 7
		end
	else
		if arg_7_0.day then
			var_7_2.day = arg_7_0.day
		end

		if var_7_1 >= os.time(var_7_2) then
			if arg_7_0.day then
				var_7_2.month = var_7_2.month + 1
			else
				var_7_2.day = var_7_2.day + 1
			end
		end
	end

	return os.time(var_7_2)
end

function var_0_0.init(arg_8_0, arg_8_1, arg_8_2)
	var_0_11()

	local var_8_0 = os.time()
	local var_8_1 = arg_8_2 * 3600 - os.difftime(var_8_0, os.time(os.date("!*t", var_8_0)))

	print("time_check_manager", arg_8_2, var_8_1)
	assert(arg_8_1 ~= nil, "Timeline can not be nil")

	var_0_2 = arg_8_1 + var_8_1
	dt = 0

	var_0_10()
	var_0_0:insertTriggerEvent(NEXT_DAY, {
		hour = 0
	})
end

function var_0_0.reset(arg_9_0, arg_9_1)
	require("model.playermodel"):getServerTime(arg_9_1)
end

function var_0_0.getCurTime(arg_10_0)
	return var_0_2
end

function var_0_0.addUpdatePool(arg_11_0, arg_11_1)
	var_0_4[#var_0_4 + 1] = arg_11_1

	return #var_0_4 + 1
end

function var_0_0.removeUpdatePool(arg_12_0, arg_12_1)
	var_0_4[arg_12_1] = nil
end

function var_0_0.cleanUpdatePool(arg_13_0)
	var_0_4 = {}
end

function var_0_0.createTimeCountDownHandler(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1
	local var_14_1 = var_0_2

	return function(arg_15_0)
		var_14_1 = var_14_1 or var_0_2

		if arg_15_0 - var_14_1 < 1 then
			return
		end

		var_14_0 = var_14_0 - (arg_15_0 - var_14_1)

		arg_14_2(math.floor(var_14_0))

		var_14_1 = arg_15_0
	end
end

function var_0_0.createTimeAddHandler(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1
	local var_16_1 = var_0_2

	return function(arg_17_0)
		var_16_1 = var_16_1 or var_0_2

		if arg_17_0 - var_16_1 < 1 then
			return
		end

		var_16_0 = var_16_0 + (arg_17_0 - var_16_1)

		arg_16_2(math.floor(var_16_0))

		var_16_1 = arg_17_0
	end
end

function var_0_0.insertTriggerEvent(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = false

	for iter_18_0, iter_18_1 in ipairs(var_0_6) do
		if iter_18_1.eventType == arg_18_1 then
			var_18_0 = true

			break
		end
	end

	local var_18_1

	if var_18_0 then
		do return end

		var_18_1 = {
			eventType = arg_18_1
		}
	end

	var_18_1.time = var_0_12(arg_18_2)

	table.insert(var_0_6, var_18_1)
	table.sort(var_0_6, function(arg_19_0, arg_19_1)
		return arg_19_0.time < arg_19_1.time
	end)
end

function var_0_0.removeTriggerEvent(arg_20_0, arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in ipairs(var_0_6) do
		if iter_20_1.eventType == arg_20_1 then
			var_20_0 = iter_20_0

			break
		end
	end

	if var_20_0 then
		table.remove(var_0_6, var_20_0)
	end
end

function var_0_0:insertShopTimeTrigger(arg_21_1)
	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		if iter_21_1.refreshtype > 0 and iter_21_1.refreshtime then
			if iter_21_1.refreshtype == 1 then
				for iter_21_2 in iter_21_1.refreshtime:gmatch("(%d+)") do
					local var_21_0 = tonumber(iter_21_2)

					self:insertTriggerEvent("HOUR_" .. var_21_0, {
						hour = var_21_0
					})
				end
			elseif iter_21_1.refreshtype == 2 then
				for iter_21_3 in iter_21_1.refreshtime:gmatch("(%d+)") do
					local var_21_1 = tonumber(iter_21_3) + 1

					self:insertTriggerEvent("WDAY_" .. var_21_1, {
						wday = var_21_1
					})
				end
			elseif iter_21_1.refreshtype == 3 then
				for iter_21_4 in iter_21_1.refreshtime:gmatch("(%d+)") do
					local var_21_2 = tonumber(iter_21_4)

					self:insertTriggerEvent("DAY_" .. var_21_2, {
						day = var_21_2
					})
				end
			end
		end
	end
end

return var_0_0
