class = var_0_10000

local var_0_0 = "CastStep"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".StoryStep"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.layout = arg_1_1.layout

	local var_1_0

	if not arg_1_1.time then
		var_1_0 = 5
	end

	arg_1_0.time = var_1_0

	local var_1_1

	if not arg_1_1.spacing then
		var_1_1 = 35
	end

	arg_1_0.spacing = var_1_1

	return
end

function var_0_1.GetMode(arg_2_0)
	Story = var_1_10001

	return var_1_10001.MODE_CAST
end

function var_0_1.DataToLayout(arg_3_0, arg_3_1)
	if arg_3_1[1] == var_0_2 then
		return {
			type = var_0_2,
			text = arg_3_1[2]
		}
	elseif arg_3_1[1] == var_0_3 then
		Vector2 = var_2

		local var_3_0

		if not arg_3_1[3] then
			var_3_0 = 0
		end

		local var_3_1

		if not arg_3_1[4] then
			var_3_1 = 0
		end

		local var_3_2 = var_2(var_3_0, var_3_1)

		return {
			type = var_0_3,
			path = arg_3_1[2],
			size = var_3_2
		}
	elseif arg_3_1[1] == var_0_4 then
		local var_3_3 = {}
		local var_3_4 = arg_3_1[2]
		local var_3_5 = arg_3_0:ShouldReplacePlayer()

		for iter_3_0 = 1, #var_3_4 do
			local var_3_6 = var_3_4[iter_3_0]

			if var_3_5 then
				var_3_6 = arg_3_0:ReplacePlayerName(var_3_6)
			end

			if arg_3_0:ShouldReplaceCar2026() then
				var_3_6 = arg_3_0:ReplaceCar2026Name(var_3_6)
			end

			HXSet = var_10

			local var_3_7 = var_10.hxLan(var_3_6)

			table = var_10

			var_10.insert(var_3_3, var_3_7)
		end

		local var_3_8 = {
			type = var_0_4,
			names = var_3_3
		}
		local var_3_9

		if not arg_3_1[3] then
			var_3_9 = 2
		end

		var_3_8.column = var_3_9

		local var_3_10

		if not arg_3_1[4] then
			var_3_10 = "#c2c2c2"
		end

		var_3_8.evenColumnColor = var_3_10

		return var_3_8
	elseif arg_3_1[1] == var_0_5 then
		return {
			type = var_0_5
		}
	end

	return
end

function var_0_1.GetLayout(arg_4_0)
	local var_4_0 = {}

	ipairs = var_1_10002

	local var_4_1

	if not arg_4_0.layout then
		var_4_1 = {}
	end

	for iter_4_0, iter_4_1 in var_1_10002(var_4_1) do
		local var_4_2 = arg_4_0
		local var_4_3 = arg_4_0.DataToLayout(var_4_2, iter_4_1)

		table = var_4_2

		var_4_2.insert(var_4_0, var_4_3)
	end

	return var_4_0
end

function var_0_1.GetSpacing(arg_5_0)
	return arg_5_0.spacing
end

function var_0_1.GetPlayTime(arg_6_0)
	return arg_6_0.time
end

return var_0_1
