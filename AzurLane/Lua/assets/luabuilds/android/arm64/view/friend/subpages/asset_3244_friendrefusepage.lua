class = var_0_10000

local var_0_0 = "FriendRefusePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "FriendRefuseUI"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "window/frame/Text")
	local var_3_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.context = var_3_2(var_3_1, var_4(var_1_10006))

	local var_3_3 = arg_3_0._tf

	arg_3_0.remind = var_1.Find(var_3_3, "window/remind")

	local var_3_4 = arg_3_0._tf

	arg_3_0.confirmBtn = var_1.Find(var_3_4, "window/confirm_btn")

	local var_3_5 = arg_3_0._tf

	arg_3_0.cancelBtn = var_1.Find(var_3_5, "window/cancel_btn")

	local var_3_6 = arg_3_0._tf

	arg_3_0.closeBtn = var_1.Find(var_3_6, "window/top/btnBack")

	local var_3_7 = arg_3_0.remind
	local var_3_8 = var_1.Find(var_3_7, "Text")
	local var_3_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.checkLabel = var_3_9(var_3_8, var_4(var_1_10006))
	onButton = var_1

	local var_3_10
	local var_3_11 = arg_3_0.cancelBtn

	local function var_3_12()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_10, var_3_11, var_3_12, var_1_10006)

	onButton = var_1

	local var_3_13
	local var_3_14 = arg_3_0._tf

	local function var_3_15()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_13, var_3_14, var_3_15, var_1_10006)

	onButton = var_1

	local var_3_16
	local var_3_17 = arg_3_0.closeBtn

	local function var_3_18()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_16, var_3_17, var_3_18, var_1_10006)

	arg_3_0.isOn = false
	onToggle = var_1

	local var_3_19
	local var_3_20 = arg_3_0.remind

	local function var_3_21(arg_7_0)
		arg_3_0.isOn = arg_7_0

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_19, var_3_20, var_3_21, var_1_10006)

	onButton = var_1

	local var_3_22
	local var_3_23 = arg_3_0.confirmBtn

	local function var_3_24()
		if arg_3_0.func then
			arg_3_0.func(arg_3_0.isOn)
		end

		local var_8_0 = arg_3_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_22, var_3_23, var_3_24, var_1_10006)

	return
end

function var_0_1.Show(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	pg = var_1_10004

	local var_9_0 = var_1_10004.UIMgr.GetInstance()

	var_4.BlurPanel(var_9_0, arg_9_0._tf)

	arg_9_0.func = arg_9_3

	local var_9_1 = arg_9_0.context

	var_9_1.text = arg_9_1
	triggerToggle = var_9_1

	var_9_1(arg_9_0.remind, false)

	setActive = var_9_1

	var_9_1(arg_9_0._tf, true)

	arg_9_0.checkLabel.text = arg_9_2

	local var_9_2 = arg_9_0._tf

	var_4.SetAsLastSibling(var_9_2)

	return
end

function var_0_1.Hide(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0._parentTf)

	setActive = var_1

	var_1(arg_10_0._tf, false)

	arg_10_0.func = nil
	arg_10_0.context.text = ""
	arg_10_0.checkLabel.text = ""

	return
end

function var_0_1.OnDestroy(arg_11_0)
	arg_11_0:Hide()

	removeOnButton = var_1

	var_1(arg_11_0._tf)

	removeOnButton = var_1

	var_1(arg_11_0.cancelBtn)

	return
end

return var_0_1
