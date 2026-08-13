class = var_0_10000

local var_0_0 = "TianYuTianYuanFramePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreNewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	arg_1_0.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.switchBtn = var_1.Find(var_1_0, "AD/switcher/switch_btn")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	ipairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0.phases) do
		setActive = var_1_10006

		var_1_10006(iter_2_1, true)

		GetOrAddComponent = var_1_10006

		local var_2_0 = iter_2_1

		typeof = var_9
		CanvasGroup = var_1_10011
		var_1_10006 = var_1_10006(var_2_0, var_9(var_1_10011))
		var_1_10006.alpha = 0
	end

	var_0_1.super.OnFirstFlush(arg_2_0)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.activity.data1

	var_3_0 = arg_3_0.avatarConfig.target < var_3_0 and var_2 or var_3_0

	local var_3_1 = var_3_0 / var_2

	setText = var_1_10004

	local var_3_2 = arg_3_0.cur

	if 1 <= var_3_1 then
		setColorStr = var_3_3

		local var_3_3

		if not var_3_3(var_3_0, "#FCE87A") then
			setColorStr = var_3_3
			var_3_3 = var_3_3(var_3_0, "#FCE87A")
		end

		setColorStr = var_1_10008

		var_1_10004(var_3_2, var_3_3 .. var_1_10008("/" .. var_2, "#FFFFFF"))

		setActive = var_1_10004

		var_1_10004(arg_3_0.target, false)

		return
	end
end

function var_0_1.Switch(arg_4_0, arg_4_1)
	arg_4_0.isSwitching = true
	setToggleEnabled = var_2

	var_2(arg_4_0.switchBtn, false)

	local var_4_0
	local var_4_1

	if arg_4_1 then
		var_4_0, var_4_1 = arg_4_0.phases[1], arg_4_0.phases[2]
	else
		var_4_0, var_4_1 = arg_4_0.phases[2], arg_4_0.phases[1]
	end

	local var_4_2 = var_4_0.localPosition
	local var_4_3 = var_4_1.localPosition
	local var_4_4 = var_4_1

	var_4_1.SetAsLastSibling(var_4_4)

	setCanvasGroupAlpha = var_6
	GetOrAddComponent = var_4_4

	local var_4_5 = var_4_0

	typeof = var_1_10011
	CanvasGroup = var_1_10013

	var_6(var_4_4(var_4_5, var_1_10011(var_1_10013)), 0)

	setCanvasGroupAlpha = var_6
	GetOrAddComponent = var_8

	local var_4_6 = var_4_1

	typeof = var_11
	CanvasGroup = var_1_10013

	var_6(var_8(var_4_6, var_11(var_1_10013)), 1)

	arg_4_0.isSwitching = nil
	setToggleEnabled = var_6

	var_6(arg_4_0.switchBtn, true)

	return
end

return var_0_1
