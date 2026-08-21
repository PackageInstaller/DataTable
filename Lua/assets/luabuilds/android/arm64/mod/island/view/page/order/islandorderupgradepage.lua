local var_0_0 = class("IslandOrderUpgradePage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandOrderUpgradeUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.levelTxt = arg_2_0._tf:Find("level"):GetComponent(typeof(Text))
	arg_2_0.nextLevelTxt = arg_2_0._tf:Find("next_level"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1, arg_5_2)
	var_0_0.super.Show(arg_5_0)

	arg_5_0.levelTxt.text = arg_5_1 - 1
	arg_5_0.nextLevelTxt.text = arg_5_1
	arg_5_0.callback = arg_5_2

	return
end

function var_0_0.Hide(arg_6_0)
	var_0_0.super.Hide(arg_6_0)

	if arg_6_0.callback then
		arg_6_0.callback()

		arg_6_0.callback = nil
	end

	return
end

function var_0_0.OnDestroy(arg_7_0)
	return
end

return var_0_0
