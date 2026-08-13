class = var_0_10000

local var_0_0 = "RyzaMainRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CorePreviewTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	local var_1_0 = arg_1_0.btnList

	arg_1_0.gameBtn = var_1.Find(var_1_0, "activity")

	local var_1_1 = arg_1_0.btnList

	arg_1_0.fightBtn = var_1.Find(var_1_1, "fight")

	local var_1_2 = arg_1_0.btnList

	arg_1_0.shopBtn = var_1.Find(var_1_2, "shop")
	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.gameBtn

	local function var_1_5()
		pg = var_2_10000

		local var_2_0 = var_2_10000.m02
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10003

		var_2_1(var_2_0, var_2_10003.GO_MINI_GAME, 43)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_3, var_1_4, var_1_5, var_1_10006)

	onButton = var_1

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.fightBtn

	local function var_1_8()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.SKIP_ACTIVITY_MAP, 50042)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_6, var_1_7, var_1_8, var_1_10006)

	onButton = var_1

	local var_1_9 = arg_1_0
	local var_1_10 = arg_1_0.shopBtn

	local function var_1_11()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.GO_SHOPS_LAYER
		local var_4_3 = {
			actId = 50052
		}

		NewShopsScene = var_2_10005
		var_4_3.warp = var_2_10005.TYPE_ACTIVITY

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_9, var_1_10, var_1_11, var_1_10006)

	return
end

return var_0_1
