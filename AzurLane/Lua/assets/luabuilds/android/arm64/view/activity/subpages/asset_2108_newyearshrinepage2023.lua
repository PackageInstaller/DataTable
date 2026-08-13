class = var_0_10000

local var_0_0 = "NewYearShrinePage2023"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewYearShrinePage"))

var_0_1.GO_MINI_GAME_ID = 45
SCENE = var_1
var_0_1.GO_BACKHILL_SCENE = var_1.NEWYEAR_BACKHILL_2023

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.goBtn

	local function var_1_2()
		pg = var_2_10000

		local var_2_0 = var_2_10000.m02
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10003

		var_2_1(var_2_0, var_2_10003.GO_MINI_GAME, var_0_1.GO_MINI_GAME_ID, {
			callback = function()
				Context = var_3_10000

				local var_3_0 = var_3_10000.New()

				SCENE = var_3_10001

				var_3_10001.SetSceneInfo(var_3_0, var_0_1.GO_BACKHILL_SCENE)

				getProxy = var_1
				ContextProxy = var_3

				local var_3_1 = var_1(var_3)

				var_1.PushContext2Prev(var_3_1, var_3_0)

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

return var_0_1
