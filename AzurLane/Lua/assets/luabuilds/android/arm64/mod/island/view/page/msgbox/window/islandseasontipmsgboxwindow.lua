local var_0_0 = class("IslandSeasonTipMsgBoxWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForSeasonTip"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.tipTitleText = arg_2_0._tf:Find("tipTitle/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnShow(arg_3_0)
	var_0_0.super.OnShow(arg_3_0)

	arg_3_0.tipTitleText.text = arg_3_0.settings.tipTitle

	return
end

function var_0_0.FlushBtn(arg_4_0, arg_4_1)
	return
end

return var_0_0
