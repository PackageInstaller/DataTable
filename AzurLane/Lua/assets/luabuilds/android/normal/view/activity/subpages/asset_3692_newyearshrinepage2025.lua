class = var_0_10000

local var_0_0 = "NewYearShrinePage2025"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewYearShrinePage"))

var_0_1.GO_MINI_GAME_ID = 71

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.goBtn

	local function var_1_2()
		pg = var_2_10000

		local var_2_0 = var_2_10000.m02
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10002

		var_2_1(var_2_0, var_2_10002.GO_MINI_GAME, var_0_1.GO_MINI_GAME_ID, {})

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_1_0, var_1_1, var_1_2, var_1_10005)

	return
end

return var_0_1
