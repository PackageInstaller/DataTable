class = var_0_10000

local var_0_0 = "JapanV2frameRePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.gotTag = var_1.Find(var_1_0, "AD/switcher/phase2/got")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity.data1

	var_2_0 = arg_2_0.avatarConfig.target < var_2_0 and var_2 or var_2_0

	local var_2_1 = var_2_0 / var_2

	setText = var_1_10004

	local var_2_2 = arg_2_0.cur

	if 1 <= var_2_1 then
		setColorStr = var_7

		local var_2_3

		if not var_7(var_2_0, "#487CFFFF") then
			var_2_3 = var_2_0
		end

		var_1_10004(var_2_2, var_2_3)

		setText = var_1_10004

		var_1_10004(arg_2_0.target, "/" .. var_2)

		setFillAmount = var_1_10004

		var_1_10004(arg_2_0.bar, var_2_1)

		local var_2_4 = var_2 <= var_2_0
		local var_2_5 = arg_2_0.activity.data2
		local var_2_6 = 1 <= var_2_5

		setActive = var_6

		local var_2_7 = arg_2_0.battleBtn
		local var_2_8

		if arg_2_0.inPhase2 then
			var_2_8 = not var_2_4
		end

		var_6(var_2_7, var_2_8)

		setActive = var_6

		local var_2_9 = arg_2_0.getBtn
		local var_2_10

		if arg_2_0.inPhase2 then
			var_2_10 = not var_2_6 and var_2_4
		end

		var_6(var_2_9, var_2_10)

		setActive = var_6

		local var_2_11 = arg_2_0.gotBtn
		local var_2_12

		if arg_2_0.inPhase2 then
			var_2_12 = var_2_6
		end

		var_6(var_2_11, var_2_12)

		setActive = var_6

		local var_2_13 = arg_2_0.gotTag
		local var_2_14

		if arg_2_0.inPhase2 then
			var_2_14 = var_2_6
		end

		var_6(var_2_13, var_2_14)

		setActive = var_6

		var_6(arg_2_0.cur, not var_2_6)

		setActive = var_6

		var_6(arg_2_0.target, not var_2_6)

		return
	end
end

return var_0_1
