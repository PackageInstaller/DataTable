local var_0_0 = class("BossRushVerZenkerFleetSelectView", import("view.activity.BossRush.BossRushFleetSelectView"))

function var_0_0.GetTextColor(arg_1_0)
	local var_1_0 = Color.NewHex("1C231F")
	local var_1_1 = Color.NewHex("979A98")
end

function var_0_0.getUIName(arg_2_0)
	return "BossRushVerZenkerFleetSelectUI"
end

function var_0_0.tempCache(arg_3_0)
	return true
end

function var_0_0.didEnter(arg_4_0)
	var_0_0.super.didEnter(arg_4_0)
	removeOnButton(arg_4_0._tf:Find("BG"))
	setText(arg_4_0.btnGo:Find("Text"), i18n("zengke_series_confirm"))
	onButton(arg_4_0, arg_4_0._tf:Find("BG/close"), function()
		arg_4_0:onCancelHard()

		return
	end, SFX_CANCEL)

	return
end

return var_0_0
