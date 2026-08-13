class = var_0_10000

local var_0_0 = "CommanderMsgBoxPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderMsgBoxUI"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_0, "frame/cancel_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.text = var_1.Find(var_2_1, "frame/bg/content/Text")

	local var_2_2 = arg_2_0._tf

	arg_2_0.text1 = var_1.Find(var_2_2, "frame/bg/content/Text1")

	local var_2_3 = arg_2_0._tf

	arg_2_0.text2 = var_1.Find(var_2_3, "frame/bg/content/Text2")

	local var_2_4 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_4, "frame/confirm_btn")

	local var_2_5 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_5, "frame/close_btn")
	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0._tf

	local function var_2_8()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_6, var_2_7, var_2_8, var_1_10006)

	return
end

function var_0_1.Show(arg_4_0, arg_4_1)
	var_0_1.super.Show(arg_4_0)

	if arg_4_1.content1 then
		setText = var_2

		var_2(arg_4_0.text1, arg_4_1.content)

		setText = var_2

		var_2(arg_4_0.text2, arg_4_1.content1)
	elseif arg_4_1.content then
		setText = var_2

		local var_4_0 = arg_4_0.text

		setColorStr = var_1_10005

		var_2(var_4_0, var_1_10005(arg_4_1.content, "#847D7B"))
	end

	onButton = var_2

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.cancelBtn

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0.Hide(var_5_0)

		if arg_4_1.onNo then
			arg_4_1.onNo()
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_4_1, var_4_2, var_4_3, var_1_10007)

	onButton = var_2

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.confirmBtn

	local function var_4_6()
		local var_6_0 = arg_4_0

		var_0.Hide(var_6_0)

		if arg_4_1.onYes then
			arg_4_1.onYes()
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_4_4, var_4_5, var_4_6, var_1_10007)

	onButton = var_2

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.closeBtn

	local function var_4_9()
		local var_7_0 = arg_4_0

		var_0.Hide(var_7_0)

		if arg_4_1.onClose then
			arg_4_1.onClose()
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_4_7, var_4_8, var_4_9, var_1_10007)

	if arg_4_1.onShow then
		arg_4_1.onShow()
	end

	local var_4_10 = arg_4_0._tf

	var_2.SetAsLastSibling(var_4_10)

	return
end

function var_0_1.Hide(arg_8_0)
	var_0_1.super.Hide(arg_8_0)

	setText = var_1

	var_1(arg_8_0.text, "")

	setText = var_1

	var_1(arg_8_0.text1, "")

	setText = var_1

	var_1(arg_8_0.text2, "")

	return
end

function var_0_1.OnDestroy(arg_9_0)
	arg_9_0:Hide()

	return
end

return var_0_1
