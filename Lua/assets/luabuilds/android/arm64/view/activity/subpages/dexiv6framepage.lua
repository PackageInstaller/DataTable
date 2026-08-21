local var_0_0 = class("DexiV6FramePage", import(".TemplatePage.NewFrameTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.battleBtn = arg_1_0.bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("got_btn")
	arg_1_0.switchBtn = arg_1_0._tf:Find("AD/switch_btn")
	arg_1_0.phases = {
		arg_1_0._tf:Find("AD/switcher/phase1"),
		arg_1_0._tf:Find("AD/switcher/phase2")
	}
	arg_1_0.bar = arg_1_0._tf:Find("AD/switcher/phase2/Image/barContent/bar")
	arg_1_0.cur = arg_1_0._tf:Find("AD/switcher/phase2/Image/step")
	arg_1_0.gotTag = arg_1_0._tf:Find("AD/switcher/phase2/Image/got")
	arg_1_0.getTag = arg_1_0._tf:Find("AD/switcher/phase2/Image/get")

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity.data1
	local var_2_1 = arg_2_0.avatarConfig.target

	var_2_0 = arg_2_0.avatarConfig.target < arg_2_0.activity.data1 and var_2_1 or var_2_0

	local var_2_2 = var_2_0 / var_2_1
	local var_2_3 = var_2_0 / var_2_1 >= 1 and setColorStr(var_2_0, COLOR_GREEN) or setColorStr(var_2_0, "#81CBD0")

	setText(arg_2_0.cur, var_2_3 .. setColorStr("/" .. var_2_1, "#1AB3B1"))
	setFillAmount(arg_2_0.bar, var_2_2)

	local var_2_4 = var_2_1 <= var_2_0
	local var_2_5 = arg_2_0.activity.data2 >= 1
	local var_2_7 = arg_2_0.inPhase2 and not var_2_4

	var_2_6(arg_2_0.battleBtn, var_2_7)

	local var_2_8 = arg_2_0.inPhase2 and not var_2_5 and var_2_4

	setActive(arg_2_0.getBtn, var_2_8)

	local var_2_9 = arg_2_0.inPhase2 and var_2_5

	setActive(arg_2_0.gotBtn, var_2_9)

	local var_2_10 = arg_2_0.inPhase2 and var_2_5

	setActive(arg_2_0.gotTag, var_2_10)

	local var_2_11 = arg_2_0.inPhase2 and not var_2_5 and var_2_4

	setActive(arg_2_0.getTag, var_2_11)
	setActive(arg_2_0.cur, not var_2_5)

	return
end

return var_0_0
