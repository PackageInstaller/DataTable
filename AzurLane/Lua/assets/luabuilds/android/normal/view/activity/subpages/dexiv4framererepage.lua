class = var_0_10000

local var_0_0 = "DexiV4FrameReRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	arg_1_0.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.redDot = var_1.Find(var_1_0, "AD/switcher/phase2/Image/red")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.battleBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_3_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_3_1(var_3_0, var_3_2, var_2_10003.TASK)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.getBtn

	local function var_2_5()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.activity.id
		})

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	local var_5_0 = arg_5_0.activity.data1

	var_5_0 = arg_5_0.avatarConfig.target < var_5_0 and var_2 or var_5_0

	local var_5_1 = var_5_0 / var_2

	setText = var_1_10004

	local var_5_2 = arg_5_0.cur

	if 1 <= var_5_1 then
		setColorStr = var_6

		local var_5_3 = var_5_0

		COLOR_GREEN = var_1_10008

		local var_5_4

		if not var_6(var_5_3, var_1_10008) then
			var_5_4 = var_5_0
		end

		var_1_10004(var_5_2, var_5_4)

		setText = var_1_10004

		var_1_10004(arg_5_0.target, "/" .. var_2)

		setFillAmount = var_1_10004

		var_1_10004(arg_5_0.bar, var_5_1)

		local var_5_5 = var_2 <= var_5_0
		local var_5_6 = arg_5_0.activity.data2
		local var_5_7 = 1 <= var_5_6

		setActive = var_6

		var_6(arg_5_0.battleBtn, not var_5_5)

		setActive = var_6

		var_6(arg_5_0.getBtn, not var_5_7 and var_5_5)

		setActive = var_6

		var_6(arg_5_0.gotBtn, var_5_7)

		setActive = var_6

		var_6(arg_5_0.gotTag, var_5_7)

		setActive = var_6

		local var_5_8 = arg_5_0.redDot
		local var_5_9 = arg_5_0.activity

		var_6(var_5_8, var_8.readyToAchieve(var_5_9))

		return
	end
end

return var_0_1
