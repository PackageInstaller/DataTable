class = var_0_10000

local var_0_0 = "IslandSeasonTipMsgBoxWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonMsgBoxForSeasonTip"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "tipTitle/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.tipTitleText = var_2_2(var_2_1, var_4(var_1_10006))

	return
end

function var_0_1.OnShow(arg_3_0)
	var_0_1.super.OnShow(arg_3_0)

	arg_3_0.tipTitleText.text = arg_3_0.settings.tipTitle

	return
end

function var_0_1.FlushBtn(arg_4_0, arg_4_1)
	return
end

return var_0_1
