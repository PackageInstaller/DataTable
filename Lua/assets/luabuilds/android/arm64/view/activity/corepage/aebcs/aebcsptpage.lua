local var_0_0 = class("AEBCSPtPage", import("view.activity.CorePage.CorePtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD/task_bg")
	arg_1_0.progress = arg_1_0.bg:Find("progress")
	arg_1_0.progres = arg_1_0.bg:Find("progres")
	arg_1_0.slider = arg_1_0.bg:Find("slider")
	arg_1_0.step = arg_1_0.bg:Find("step")
	arg_1_0.displayBtn = arg_1_0.bg:Find("display_btn")
	arg_1_0.awardTF = arg_1_0.bg:Find("award")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("got_btn")
	arg_1_0.battleBtn = arg_1_0.bg:Find("battle_btn")

	setText(arg_1_0.displayBtn:Find("Text"), i18n("other_world_temple_award"))
	setText(arg_1_0.bg:Find("Text"), i18n("Outpost_20250904_Progress"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.battleBtn, function()
		arg_2_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	var_0_0.super.OnUpdateFlush(arg_4_0)

	local var_4_0, var_4_1, var_4_2 = arg_4_0.ptData:GetResProgress()

	setText(arg_4_0.progress, "/" .. var_4_1)

	local var_4_3 = var_4_2 >= 1 and setColorStr(var_4_0, "#6ef0ff") or var_4_0

	setText(arg_4_0.progres, var_4_3)

	return
end

return var_0_0
