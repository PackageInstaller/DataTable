class = var_0_10000

local var_0_0 = "StoryCancelTipPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MsgboxSubPanel"))

function var_0_1.getUIName(arg_1_0)
	return "Msgbox4StoryCancelTip"
end

function var_0_1.OnInit(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "Name")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("autofight_story"))

	return
end

function var_0_1.PreRefresh(arg_3_0, arg_3_1)
	pg = var_1_10002
	arg_3_1.title = var_1_10002.MsgboxMgr.TITLE_INFORMATION

	var_0_1.super.PreRefresh(arg_3_0, arg_3_1)

	return
end

function var_0_1.OnRefresh(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.SetWindowSize

	Vector2 = var_1_10004

	var_4_1(var_4_0, var_1_10004(1000, 640))

	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_2.Find(var_4_2, "CircleProgress")
	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_3.Find(var_4_4, "TimeText")
	local var_4_6 = 5

	LeanTween = var_5

	local var_4_7 = var_5.value

	go = var_6

	local var_4_8 = var_4_7(var_6(var_4_3), var_4_6, 0, var_4_6)
	local var_4_9 = var_5.setOnUpdate

	System = var_7

	local var_4_10 = var_4_9(var_4_8, var_7.Action_float(function(arg_5_0)
		setFillAmount = var_2_10001

		local var_5_0 = var_4_3

		math = var_2_10003

		var_2_10001(var_5_0, arg_5_0 - var_2_10003.floor(arg_5_0))

		setText = var_2_10001

		local var_5_1 = var_4_5

		math = var_3

		local var_5_2 = var_3.clamp

		math = var_4

		var_2_10001(var_5_1, var_5_2(var_4.ceil(arg_5_0), 0, var_4_6))

		return
	end))
	local var_4_11 = var_5.setOnComplete

	System = var_7

	var_4_11(var_4_10, var_7.Action(function()
		existCall = var_2_10000

		var_2_10000(arg_4_1.onYes)

		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end))

	return
end

function var_0_1.OnHide(arg_7_0)
	return
end

function var_0_1.OnDestory(arg_8_0)
	LeanTween = var_1_10001

	local var_8_0 = var_1_10001.cancel
	local var_8_1 = arg_8_0._tf

	var_8_0(var_2.Find(var_8_1, "CircleProgress"))

	return
end

return var_0_1
