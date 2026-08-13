class = var_0_10000

local var_0_0 = "CourtYardEmptyFoodPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CourtYardEmptyFoodUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_0, "frame/ok_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "frame/cancel_btn")
	setButtonText = var_1

	local var_2_2 = arg_2_0.confirmBtn

	i18n = var_4

	var_1(var_2_2, var_4("text_nofood_yes"))

	setButtonText = var_1

	local var_2_3 = arg_2_0.cancelBtn

	i18n = var_4

	var_1(var_2_3, var_4("text_nofood_no"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.frame = var_1.Find(var_2_4, "frame")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		CourtYardMediator = var_2_10003

		var_4_1(var_4_0, var_2_10003.GO_GRANARY)

		local var_4_2 = arg_3_0

		var_0.Hide(var_4_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.Flush(arg_7_0)
	arg_7_0:Show()

	return
end

function var_0_1.Show(arg_8_0)
	var_0_1.super.Show(arg_8_0)

	pg = var_1

	local var_8_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_8_0, arg_8_0._tf)

	LeanTween = var_1

	local var_8_1 = var_1.cancel

	go = var_8_0

	var_8_1(var_8_0(arg_8_0.frame))

	local var_8_2 = arg_8_0.frame

	Vector3 = var_1_10002
	var_8_2.localScale = var_1_10002(0, 0, 0)
	LeanTween = var_8_2

	local var_8_3 = var_8_2.scale
	local var_8_4 = arg_8_0.frame

	Vector3 = var_4

	local var_8_5 = var_8_3(var_8_4, var_4(1, 1, 1), 0.3)
	local var_8_6 = var_1.setEase

	LeanTweenType = var_4

	var_8_6(var_8_5, var_4.easeOutBack)

	return
end

function var_0_1.Hide(arg_9_0)
	LeanTween = var_1_10001

	local var_9_0 = var_1_10001.cancel

	go = var_1_10003

	var_9_0(var_1_10003(arg_9_0.frame))
	var_0_1.super.Hide(arg_9_0)

	pg = var_1

	local var_9_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_1, arg_9_0._tf, arg_9_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_10_0)
	arg_10_0:Hide()

	return
end

return var_0_1
