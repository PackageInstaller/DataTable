local var_0_0 = class("AEBCSHestiaPage", import("view.activity.CorePage.BRS.HeiYanPtPage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)
	setText(arg_1_0.displayBtn:Find("Text"), i18n("other_world_temple_award"))
	setText(arg_1_0.task_bg:Find("schedule"), i18n("Outpost_20250904_Progress"))

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	arg_2_0.super.OnUpdateFlush(arg_2_0)

	local var_2_0, var_2_1, var_2_2 = arg_2_0.ptData:GetResProgress()

	setText(arg_2_0.progress, "/" .. var_2_1)

	local var_2_3 = var_2_2 >= 1 and setColorStr(var_2_0, "#2572ff") or var_2_0

	setText(arg_2_0.progres, var_2_3)
	setSlider(arg_2_0.slider, 0, 1, var_2_2)

	return
end

return var_0_0
