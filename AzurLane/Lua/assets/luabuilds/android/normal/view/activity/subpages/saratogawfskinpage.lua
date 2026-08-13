class = var_0_10000

local var_0_0 = "SaratogaWFSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	onButton = var_1_10001

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.displayBtn

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_2_2 = var_2_10002.SHOW_AWARD_WINDOW

		PtAwardWindow = var_2_10003

		var_2_1(var_2_0, var_2_2, var_2_10003, {
			type = arg_1_0.ptData.type,
			dropList = arg_1_0.ptData.dropList,
			targets = arg_1_0.ptData.targets,
			level = arg_1_0.ptData.level,
			count = arg_1_0.ptData.count,
			resId = arg_1_0.ptData.resId
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_1_0, var_1_1, var_1_2, var_1_10005)

	onButton = var_1_10001

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.battleBtn

	local function var_1_5()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_3_1(var_3_0, var_2_10002.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_1_3, var_1_4, var_1_5, var_1_10005)

	onButton = var_1_10001

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.getBtn

	local function var_1_8()
		local var_4_0 = arg_1_0.ptData
		local var_4_1, var_4_2 = var_0.GetResProgress(var_4_0)
		local var_4_3 = arg_1_0
		local var_4_4 = var_2.emit

		ActivityMediator = var_2_10004

		local var_4_5 = var_2_10004.EVENT_PT_OPERATION
		local var_4_6 = {
			cmd = 1
		}
		local var_4_7 = arg_1_0.ptData

		var_4_6.activity_id = var_6.GetId(var_4_7)
		var_4_6.arg1 = var_4_2

		var_4_4(var_4_3, var_4_5, var_4_6)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_1_6, var_1_7, var_1_8, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	var_0_1.super.OnUpdateFlush(arg_5_0)

	local var_5_0 = arg_5_0.ptData
	local var_5_1, var_5_2, var_5_3 = var_1.GetResProgress(var_5_0)

	setText = var_1_10004

	local var_5_4 = arg_5_0.progress

	setColorStr = var_1_10006

	var_1_10004(var_5_4, var_1_10006(var_5_1, "#F294B8FF") .. "/" .. var_5_2)

	return
end

return var_0_1
