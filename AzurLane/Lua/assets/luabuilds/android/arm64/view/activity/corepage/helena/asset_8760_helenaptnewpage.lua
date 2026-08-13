class = var_0_10000

local var_0_0 = "HelenaPtNewPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CorePageNewPtTemplatePage"))

function var_0_1.UpdateAward(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1 + 1
	local var_1_1 = arg_1_0.awardList[var_1_0].drop

	updateDrop = var_1_10005

	var_1_10005(arg_1_2:Find("icon"), var_1_1)

	setText = var_1_10005

	var_1_10005(arg_1_2:Find("pt"), arg_1_0.awardList[var_1_0].target)

	local var_1_2 = arg_1_0.ptData

	if not (var_1_0 <= var_5.GetLevel(var_1_2)) then
		local var_1_3 = arg_1_0.ptData
		local var_1_4

		if not (var_1_0 <= var_6.GetMaxAvailableTargetIndex(var_1_3)) then
			var_1_4 = false
		else
			var_1_4 = true
		end

		local var_1_5 = not var_5 and not var_1_4

		setActive = var_1_3

		var_1_3(arg_1_2:Find("got"), var_5)

		setActive = var_1_3

		var_1_3(arg_1_2:Find("get"), var_1_4)

		setActive = var_1_3

		var_1_3(arg_1_2:Find("lock"), not var_1_4)

		setActive = var_1_3

		var_1_3(arg_1_2:Find("lock/lock"), var_1_5)

		onButton = var_1_3

		local var_1_6 = arg_1_0
		local var_1_7 = arg_1_2

		local function var_1_8()
			local var_2_0 = arg_1_0
			local var_2_1 = var_0.emit

			BaseUI = var_2_10003

			var_2_1(var_2_0, var_2_10003.ON_DROP, var_1_1)

			return
		end

		SFX_PANEL = var_13

		var_1_3(var_1_6, var_1_7, var_1_8, var_13)

		return
	end
end

return var_0_1
