class = var_0_10000

local var_0_0 = "StarSeaPtPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.PtTemplatePage"))
local var_0_2 = "#CCB5FF"

function var_0_1.OnUpdateFlush(arg_1_0)
	local var_1_0 = arg_1_0.ptData
	local var_1_1 = var_1.getTargetLevel(var_1_0)
	local var_1_2 = arg_1_0.activity
	local var_1_3 = var_2.getConfig(var_1_2, "config_client").story

	checkExist = var_1_0

	if var_1_0(var_1_3, {
		var_1_1
	}, {
		1
	}) then
		pg = var_3

		local var_1_4 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_1_4, var_1_3[var_1_1][1])
	end

	if arg_1_0.step then
		local var_1_5 = arg_1_0.ptData
		local var_1_6, var_1_7, var_1_8 = var_3.GetLevelProgress(var_1_5)

		setText = var_6

		local var_1_9 = arg_1_0.step

		setColorStr = var_1_10009

		var_6(var_1_9, var_1_10009(var_1_6, var_0_2) .. "/" .. var_1_7)
	end

	local var_1_10 = arg_1_0.ptData
	local var_1_11, var_1_12, var_1_13 = var_3.GetResProgress(var_1_10)

	setText = var_6

	local var_1_14 = arg_1_0.progress

	if 1 <= var_1_13 then
		setColorStr = var_9

		local var_1_15

		if not var_9(var_1_11, var_0_2) then
			var_1_15 = var_1_11
		end

		var_6(var_1_14, var_1_15 .. "/" .. var_1_12)

		setSlider = var_6

		var_6(arg_1_0.slider, 0, 1, var_1_13)

		local var_1_16 = arg_1_0.ptData
		local var_1_17 = var_6.CanGetAward(var_1_16)
		local var_1_18 = arg_1_0.ptData
		local var_1_19 = var_7.CanGetNextAward(var_1_18)
		local var_1_20 = arg_1_0.ptData
		local var_1_21 = var_8.CanGetMorePt(var_1_20)

		setActive = var_1_18

		var_1_18(arg_1_0.battleBtn, var_1_21 and not var_1_17 and var_1_19)

		setActive = var_1_18

		var_1_18(arg_1_0.getBtn, var_1_17)

		setActive = var_1_18

		var_1_18(arg_1_0.gotBtn, not var_1_19)

		local var_1_22 = arg_1_0.ptData
		local var_1_23 = var_9.GetAward(var_1_22)

		updateDrop = var_1_20

		var_1_20(arg_1_0.awardTF, var_1_23)

		onButton = var_1_20

		local var_1_24 = arg_1_0
		local var_1_25 = arg_1_0.awardTF

		local function var_1_26()
			local var_2_0 = arg_1_0
			local var_2_1 = var_0.emit

			BaseUI = var_2_10003

			var_2_1(var_2_0, var_2_10003.ON_DROP, var_1_23)

			return
		end

		SFX_PANEL = var_1_10015

		var_1_20(var_1_24, var_1_25, var_1_26, var_1_10015)

		return
	end
end

return var_0_1
