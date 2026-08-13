class = var_0_10000

local var_0_0 = "ShenshengxvmuPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	setActive = var_1

	var_1(arg_1_0.displayBtn, false)

	setActive = var_1

	var_1(arg_1_0.awardTF, false)

	onButton = var_1

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.battleBtn

	local function var_1_2()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_2_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.TASK, {
			page = "activity"
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_1_0, var_1_1, var_1_2, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.activity
	local var_3_1 = var_1.getConfig(var_3_0, "config_client")

	pg = var_3

	local var_3_2 = var_3.TimeMgr.GetInstance()
	local var_3_3 = var_3.inTime(var_3_2, var_3_1)

	setActive = var_3_0

	local var_3_4 = arg_3_0.battleBtn

	isActive = var_1_10007

	local var_3_5

	if var_1_10007(arg_3_0.battleBtn) then
		var_3_5 = var_3_3
	end

	var_3_0(var_3_4, var_3_5)

	local var_3_6 = arg_3_0.bg
	local var_3_7

	var_3_7, setActive = var_4.Find(var_3_6, "got"), var_3_2

	local var_3_8 = arg_3_0.ptData

	var_3_2(var_3_7, not var_8.CanGetNextAward(var_3_8))

	local var_3_9 = arg_3_0.ptData
	local var_3_10, var_3_11, var_3_12 = var_5.GetResProgress(var_3_9)

	setText = var_8

	local var_3_13 = arg_3_0.step

	if 1 <= var_3_12 then
		setColorStr = var_11

		local var_3_14 = var_3_10

		COLOR_GREEN = var_1_10014

		local var_3_15

		if not var_11(var_3_14, var_1_10014) then
			var_3_15 = var_3_10
		end

		var_8(var_3_13, var_3_15)

		setText = var_8

		var_8(arg_3_0.progress, "/" .. var_3_11)

		return
	end
end

return var_0_1
