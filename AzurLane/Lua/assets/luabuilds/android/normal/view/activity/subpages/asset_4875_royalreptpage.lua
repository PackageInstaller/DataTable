class = var_0_10000

local var_0_0 = "RoyalRePtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.progresses = var_1.Find(var_1_0, "progresses")

	local var_1_1 = arg_1_0.progresses

	arg_1_0.progress_r = var_1.Find(var_1_1, "progress_r")

	local var_1_2 = arg_1_0.progresses

	arg_1_0.progress_l = var_1.Find(var_1_2, "progress_l")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	local var_2_0 = arg_2_0.ptData
	local var_2_1 = var_1.getTargetLevel(var_2_0)
	local var_2_2 = arg_2_0.activity
	local var_2_3 = var_2.getConfig(var_2_2, "config_client").story

	checkExist = var_2_2

	if var_2_2(var_2_3, {
		var_2_1
	}, {
		1
	}) then
		pg = var_3

		local var_2_4 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_2_4, var_2_3[var_2_1][1])
	end

	local var_2_5 = arg_2_0.ptData
	local var_2_6, var_2_7, var_2_8 = var_3.GetLevelProgress(var_2_5)
	local var_2_9 = arg_2_0.ptData
	local var_2_10, var_2_11, var_2_12 = var_6.GetResProgress(var_2_9)

	setText = var_1_10009

	var_1_10009(arg_2_0.step, var_2_6 .. "/" .. var_2_7)

	if 1 <= var_2_12 then
		setColorStr = var_9

		local var_2_13 = var_2_10

		COLOR_GREEN = var_11

		local var_2_14

		if not var_9(var_2_13, var_11) then
			var_2_14 = var_2_10
		end

		setText = var_2_13

		var_2_13(arg_2_0.progress_l, var_2_14 .. "/" .. var_2_11)

		setSlider = var_2_13

		var_2_13(arg_2_0.slider, 0, 1, var_2_12)

		local var_2_15 = arg_2_0.ptData
		local var_2_16 = var_10.CanGetAward(var_2_15)
		local var_2_17 = arg_2_0.ptData
		local var_2_18 = var_11.CanGetNextAward(var_2_17)
		local var_2_19 = arg_2_0.ptData
		local var_2_20 = var_12.CanGetMorePt(var_2_19)

		setActive = var_2_19

		var_2_19(arg_2_0.battleBtn, var_2_20 and not var_2_16 and var_2_18)

		setActive = var_2_19

		var_2_19(arg_2_0.getBtn, var_2_16)

		setActive = var_2_19

		var_2_19(arg_2_0.gotBtn, not var_2_18)

		local var_2_21 = arg_2_0.ptData
		local var_2_22 = var_13.GetAward(var_2_21)

		updateDrop = var_2_21

		var_2_21(arg_2_0.awardTF, var_2_22)

		onButton = var_2_21

		local var_2_23 = arg_2_0
		local var_2_24 = arg_2_0.awardTF

		local function var_2_25()
			local var_3_0 = arg_2_0
			local var_3_1 = var_0.emit

			BaseUI = var_2_10002

			var_3_1(var_3_0, var_2_10002.ON_DROP, var_2_22)

			return
		end

		SFX_PANEL = var_1_10018

		var_2_21(var_2_23, var_2_24, var_2_25, var_1_10018)

		return
	end
end

return var_0_1
