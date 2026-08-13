class = var_0_10000

local var_0_0 = "AEBCSHestiaPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.BRS.HeiYanPtPage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.displayBtn
	local var_1_1 = var_2.Find(var_1_0, "Text")

	i18n = var_1_0

	var_1(var_1_1, var_1_0("other_world_temple_award"))

	setText = var_1

	local var_1_2 = arg_1_0.task_bg
	local var_1_3 = var_2.Find(var_1_2, "schedule")

	i18n = var_1_2

	var_1(var_1_3, var_1_2("Outpost_20250904_Progress"))

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	arg_2_0.super.OnUpdateFlush(arg_2_0)

	local var_2_0 = arg_2_0.ptData
	local var_2_1, var_2_2, var_2_3 = var_1.GetResProgress(var_2_0)

	setText = var_1_10004

	var_1_10004(arg_2_0.progress, "/" .. var_2_2)

	setText = var_1_10004

	local var_2_4 = arg_2_0.progres

	if 1 <= var_2_3 then
		setColorStr = var_6

		local var_2_5

		if not var_6(var_2_1, "#2572ff") then
			var_2_5 = var_2_1
		end

		var_1_10004(var_2_4, var_2_5)

		setSlider = var_1_10004

		var_1_10004(arg_2_0.slider, 0, 1, var_2_3)

		return
	end
end

return var_0_1
