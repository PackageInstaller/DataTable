class = var_0_10000

local var_0_0 = "LinerTime"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPE = {
	EVENT = 3,
	STORY = 4,
	TARGET = 1,
	EXPLORE = 2
}
var_0_1.EVENT_SUB_TYPE = {
	STORY = 2,
	CLUE = 1
}
var_0_1.BG_TYPE = {
	DAY = "day",
	NIGTH = "night",
	AURORA = "aurora",
	DUSK = "dusk"
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_liner_time
end

function var_0_1.GetTime(arg_3_0)
	return arg_3_0:getConfig("time")
end

function var_0_1.GetStartTimeDesc(arg_4_0)
	local var_4_0 = arg_4_0:GetTime()[1] < 12 and "AM" or "PM"
	local var_4_1

	if var_4_1 > 12 then
		var_4_1 = var_4_1 - 12
	end

	return var_4_1 .. ":00 " .. var_4_0
end

function var_0_1.GetEndTimeDesc(arg_5_0)
	local var_5_0 = arg_5_0:GetTime()[2] < 12 and "AM" or "PM"
	local var_5_1

	if var_5_1 > 12 then
		var_5_1 = var_5_1 - 12
	end

	return var_5_1 .. ":00 " .. var_5_0
end

function var_0_1.GetLogDesc(arg_6_0)
	local var_6_0 = arg_6_0:GetTime()[1]
	local var_6_1 = arg_6_0:GetTime()[2] - 1
	local var_6_2 = var_6_0 < 12 and "AM" or "PM"
	local var_6_3 = var_6_1 < 12 and "AM" or "PM"
	local var_6_4

	if not (var_6_0 > 12) or not (var_6_0 - 12) then
		var_6_4 = var_6_0
	end

	var_6_1 = var_6_1 > 12 and var_6_1 - 12 or var_6_1

	local var_6_5 = var_6_4

	string = var_6_4

	return var_6_4.format("%d:00 %s~%d:59 %s", var_6_5, var_6_2, var_6_1, var_6_3)
end

function var_0_1.GetType(arg_7_0)
	return arg_7_0:getConfig("type")
end

function var_0_1.GetEventSubType(arg_8_0, arg_8_1)
	assert = var_1_10002

	var_1_10002(arg_8_0:GetType() == var_0_1.TYPE.EVENT, "error type")

	underscore = var_1_10002

	local var_8_0 = var_1_10002.detect(arg_8_0:GetParamInfo(), function(arg_9_0)
		return arg_9_0[1] == arg_8_1
	end)

	assert = var_1_10003

	var_1_10003(var_8_0, "error roomId")

	return var_8_0[2]
end

function var_0_1.GetParamInfo(arg_10_0)
	return arg_10_0:getConfig("param")
end

function var_0_1.GetTargetRoomIds(arg_11_0)
	local var_11_0 = {}

	switch = var_1_10002

	var_1_10002(arg_11_0:GetType(), {
		[var_0_1.TYPE.TARGET] = function()
			table = var_2_10000

			local var_12_0 = var_2_10000.insert
			local var_12_1 = var_11_0

			tonumber = var_2_10003

			local var_12_2 = arg_11_0

			var_12_0(var_12_1, var_2_10003(var_5.GetParamInfo(var_12_2)[1]))

			return
		end,
		[var_0_1.TYPE.EXPLORE] = function()
			return
		end,
		[var_0_1.TYPE.EVENT] = function()
			ipairs = var_2_10000

			local var_14_0 = arg_11_0

			for iter_14_0, iter_14_1 in var_2_10000(var_2.GetParamInfo(var_14_0)) do
				table = var_2_10005

				var_2_10005.insert(var_11_0, iter_14_1[1])
			end

			return
		end,
		[var_0_1.TYPE.STORY] = function()
			table = var_2_10000

			local var_15_0 = var_2_10000.insert
			local var_15_1 = var_11_0

			tonumber = var_2_10003

			local var_15_2 = arg_11_0

			var_15_0(var_15_1, var_2_10003(var_5.GetParamInfo(var_15_2)[1]))

			return
		end
	})

	return var_11_0
end

function var_0_1.GetExploreCnt(arg_16_0)
	if arg_16_0:GetType() ~= var_0_1.TYPE.EXPLORE then
		return 0
	end

	tonumber = var_1

	return var_1(arg_16_0:GetParamInfo())
end

function var_0_1.GetEventIds(arg_17_0)
	if arg_17_0:GetType() ~= var_0_1.TYPE.EVENT then
		return {}
	end

	local var_17_0 = {}

	ipairs = var_2

	for iter_17_0, iter_17_1 in var_2(arg_17_0:GetParamInfo()) do
		table = var_1_10007
		var_17_0 = var_1_10007.mergeArray(var_17_0, iter_17_1[4], true)
	end

	return var_17_0
end

function var_0_1.GetStory(arg_18_0, arg_18_1)
	local var_18_0 = ""

	switch = var_1_10003

	var_1_10003(arg_18_0:GetType(), {
		[var_0_1.TYPE.TARGET] = function()
			local var_19_0 = arg_18_0

			var_18_0 = var_0.GetParamInfo(var_19_0)[2]

			return
		end,
		[var_0_1.TYPE.EXPLORE] = function()
			return
		end,
		[var_0_1.TYPE.EVENT] = function()
			underscore = var_2_10000

			local var_21_0 = var_2_10000.detect
			local var_21_1 = arg_18_0

			if var_21_0(var_2.GetParamInfo(var_21_1), function(arg_22_0)
				return arg_22_0[1] == arg_18_1
			end) and var_0[2] == var_0_1.EVENT_SUB_TYPE.STORY then
				var_18_0 = var_0[3]
			end

			return
		end,
		[var_0_1.TYPE.STORY] = function()
			local var_23_0 = arg_18_0

			var_18_0 = var_0.GetParamInfo(var_23_0)[2]

			return
		end
	})

	return var_18_0
end

function var_0_1.GetBeforDesc(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getConfig("desc_before")

	type = var_1_10003

	if var_1_10003(var_24_0) == "table" then
		HXSet = var_3

		return var_3.hxLan(var_24_0[arg_24_1][1])
	else
		HXSet = var_3

		return var_3.hxLan(var_24_0)
	end

	return
end

function var_0_1.GetAfterDesc(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getConfig("desc_after")

	type = var_1_10003

	if var_1_10003(var_25_0) == "table" then
		HXSet = var_3

		return var_3.hxLan(var_25_0[arg_25_1][1])
	else
		HXSet = var_3

		return var_3.hxLan(var_25_0)
	end

	return
end

function var_0_1.GetBgType(arg_26_0)
	return arg_26_0:getConfig("bg_name")
end

function var_0_1.GetBgm(arg_27_0, arg_27_1)
	local var_27_0

	if not arg_27_1 then
		::label_27_0::

		var_1_10004 = arg_27_0
		var_27_0 = arg_27_0.GetBgType(var_1_10004)
	end

	local var_27_1 = "story-niceship-soft"

	switch = var_1_10004

	var_1_10004(var_27_0, {
		[var_0_1.BG_TYPE.DAY] = function()
			var_27_1 = "story-niceship-soft"

			return
		end,
		[var_0_1.BG_TYPE.DUSK] = function()
			var_27_1 = "story-richang-5"

			return
		end,
		[var_0_1.BG_TYPE.NIGTH] = function()
			var_27_1 = "story-richang-10"

			return
		end,
		[var_0_1.BG_TYPE.AURORA] = function()
			var_27_1 = "story-richang-quiet"

			return
		end
	})

	return var_27_1
end

return var_0_1
