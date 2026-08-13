class = var_0_10000

local var_0_0 = "SVAchievement"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.HideView = "SVAchievement.HideView"

function var_0_1.getUIName(arg_1_0)
	return "SVAchievement"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "display")
	local var_3_2 = arg_3_0._tf.rect.width / var_3_1.rect.width

	Vector3 = var_3
	var_3_1.localScale = var_3.New(var_3_2, var_3_2, 0)
	arg_3_0.rtDesc = var_3_1:Find("desc")

	local var_3_3 = arg_3_0.rtDesc

	arg_3_0.rtStar = var_3.Find(var_3_3, "star")
	onButton = var_3

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	local function var_3_6()
		if arg_3_0.isClosing then
			return
		end

		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10008

	var_3(var_3_4, var_3_5, var_3_6, var_1_10008)

	return
end

function var_0_1.OnDestroy(arg_5_0)
	return
end

function var_0_1.Show(arg_6_0)
	setAnchoredPosition = var_1_10001

	local var_6_0 = arg_6_0.rtStar

	Vector2 = var_1_10004

	var_1_10001(var_6_0, var_1_10004.New(100, 0))

	setActive = var_1_10001

	local var_6_1 = arg_6_0.rtStar

	var_1_10001(var_3.Find(var_6_1, "SVAstar"), false)

	pg = var_1_10001

	local var_6_2 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_6_2, arg_6_0._tf)

	setActive = var_1

	var_1(arg_6_0._tf, true)

	return
end

function var_0_1.Hide(arg_7_0)
	arg_7_0.isClosing = true

	local var_7_0 = arg_7_0.rtDesc
	local var_7_1 = var_1.InverseTransformPoint(var_7_0, arg_7_0.starWorldPos)
	local var_7_2 = {}

	table = var_7_0

	var_7_0.insert(var_7_2, function(arg_8_0)
		setActive = var_2_10001

		local var_8_0 = arg_7_0.rtStar

		var_2_10001(var_3.Find(var_8_0, "SVAstar"), true)

		LeanTween = var_2_10001

		local var_8_1 = var_2_10001.moveLocal

		go = var_3

		local var_8_2 = var_3(arg_7_0.rtStar)

		Vector3 = var_4

		local var_8_3 = var_8_1(var_8_2, var_4.New(var_7_1.x, var_7_1.y, 0), 0.5)
		local var_8_4 = var_1.setEase

		LeanTweenType = var_4

		local var_8_5 = var_8_4(var_8_3, var_4.easeInOutSine)
		local var_8_6 = var_1.setOnComplete

		System = var_4

		var_8_6(var_8_5, var_4.Action(arg_8_0))

		return
	end)

	table = var_3

	var_3.insert(var_7_2, function(arg_9_0)
		Timer = var_2_10001

		local var_9_0 = var_2_10001.New(arg_9_0, 1.1)

		var_1.Start(var_9_0)

		return
	end)

	seriesAsync = var_3

	var_3(var_7_2, function()
		local var_10_0 = arg_7_0

		var_10_0.isClosing = false
		pg = var_10_0

		local var_10_1 = var_10_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_10_1, arg_7_0._tf, arg_7_0._parentTf)

		setActive = var_0

		var_0(arg_7_0._tf, false)

		local var_10_2 = arg_7_0

		var_0.emit(var_10_2, var_0_1.HideView)

		return
	end)

	return
end

function var_0_1.Setup(arg_11_0, arg_11_1, arg_11_2)
	setText = var_1_10003

	var_1_10003(arg_11_0.rtDesc, arg_11_1.config.target_desc)

	arg_11_0.starWorldPos = arg_11_2

	return
end

return var_0_1
