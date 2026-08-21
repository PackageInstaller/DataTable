local var_0_0 = class("BossSingleTotalRewardPanel", import("view.activity.worldboss.ActivityBossTotalRewardPanel"))

function var_0_0.getUIName(arg_1_0)
	return "BossSingleTotalRewardPanel"
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)
	setText(arg_2_0.window:Find("Fixed/ButtonGO/pic"), i18n("autofight_onceagain"))

	return
end

function var_0_0.UpdateView(arg_3_0)
	var_0_0.super.UpdateView(arg_3_0)

	local var_3_0 = arg_3_0.contextData

	onButton(arg_3_0, arg_3_0.window:Find("Fixed/ButtonGO"), function()
		existCall(var_3_0.onConfirm)
		arg_3_0:closeView()

		return
	end, SFX_CONFIRM)
	onButton(arg_3_0, arg_3_0.window:Find("Fixed/ButtonExit"), function()
		triggerButton(arg_3_0._tf:Find("BG"))

		return
	end)

	return
end

return var_0_0
