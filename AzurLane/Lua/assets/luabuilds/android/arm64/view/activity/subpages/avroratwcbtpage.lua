local var_0_0 = class("AvroraTWCBTPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.get = arg_1_0.bg:Find("get")
	arg_1_0.go = arg_1_0.bg:Find("go")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.go, function()
		arg_2_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)

	local var_2_0 = getProxy(ChapterProxy):isClear(304)

	setActive(arg_2_0.go, not var_2_0)
	setActive(arg_2_0.get, var_2_0)

	return
end

return var_0_0
