local var_0_0 = class("TianYuTianYuanFramePage", import("view.activity.CorePage.CoreNewFrameTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.super.OnInit(arg_1_0)

	arg_1_0.switchBtn = arg_1_0._tf:Find("AD/switcher/switch_btn")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.phases) do
		setActive(iter_2_1, true)

		GetOrAddComponent(iter_2_1, typeof(CanvasGroup)).alpha = 0
	end

	var_0_0.super.OnFirstFlush(arg_2_0)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.avatarConfig.target
	local var_3_1, var_3_2

	if arg_3_0.avatarConfig.target < arg_3_0.activity.data1 and not var_3_0 then
		var_3_1 = setText
		var_3_2 = arg_3_0.cur
	end

	local var_3_3 = arg_3_0.activity.data1 / var_3_0 >= 1 and setColorStr(arg_3_0.activity.data1, "#FCE87A") or setColorStr(arg_3_0.activity.data1, "#FCE87A")

	var_3_1(var_3_2, var_3_3 .. setColorStr("/" .. var_3_0, "#FFFFFF"))
	setActive(arg_3_0.target, false)

	return
end

function var_0_0.Switch(arg_4_0, arg_4_1)
	arg_4_0.isSwitching = true

	setToggleEnabled(arg_4_0.switchBtn, false)

	local var_4_0
	local var_4_1

	if arg_4_1 then
		var_4_1 = arg_4_0.phases[2]
		var_4_0 = arg_4_0.phases[1]

		goto label_4_0

		var_4_1 = arg_4_0.phases[1]
	end

	var_4_0 = arg_4_0.phases[2]

	::label_4_0::

	local var_4_2 = var_4_0.localPosition

	var_4_1:SetAsLastSibling()
	setCanvasGroupAlpha(GetOrAddComponent(var_4_0, typeof(CanvasGroup)), 0)
	setCanvasGroupAlpha(GetOrAddComponent(var_4_1, typeof(CanvasGroup)), 1)

	arg_4_0.isSwitching = nil

	setToggleEnabled(arg_4_0.switchBtn, true)

	return
end

return var_0_0
