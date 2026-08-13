class = var_0_10000

local var_0_0 = "CarWashMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.Dorm3dGameBaseSubView"))

var_0_1.SHOW_BLACK_SCREEN = "CarWashMainPage.SHOW_BLACK_SCREEN"
var_0_1.SHOW_HELP_BOX = "CarWashMainPage.SHOW_HELP_BOX"
var_0_1.SHOW_EXPRESSION_HUD = "CarWashMainPage.SHOW_EXPRESSION_HUD"
var_0_1.ENABLE_BLOCK = "CarWashMainPage.ENABLE_BLOCK"
var_0_1.EXPRESSION_TYPE = {
	LIKE = "LIKE",
	HATE = "HATE"
}

function var_0_1.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:BindEvent()

	return
end

function var_0_1.InitUI(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf

	var_1_10001(var_2_0, var_4.Find(var_2_1, "btn_back"), function()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		BaseUI = var_2_10003

		var_3_1(var_3_0, var_2_10003.ON_BACK)

		return
	end)

	onButton = var_1_10001

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0._tf

	var_1_10001(var_2_2, var_4.Find(var_2_3, "btn_help"), function()
		local var_4_0 = arg_2_0

		var_0.ShowHelpBox(var_4_0)

		return
	end)

	local var_2_4 = arg_2_0._tf

	arg_2_0.expressionRoot = var_1.Find(var_2_4, "expression_root")

	local var_2_5 = arg_2_0.expressionRoot

	arg_2_0.expressionLike = var_1.Find(var_2_5, "vfx_car_aixin01")

	local var_2_6 = arg_2_0.expressionRoot

	arg_2_0.expressionHate = var_1.Find(var_2_6, "vfx_car_xixian01")
	setActive = var_1

	var_1(arg_2_0.expressionLike, false)

	setActive = var_1

	var_1(arg_2_0.expressionHate, false)

	local var_2_7 = arg_2_0._tf

	arg_2_0.blockLayer = var_1.Find(var_2_7, "block")

	arg_2_0:EnableBlock(false)

	local var_2_8 = arg_2_0._tf

	arg_2_0.blackLayer = var_1.Find(var_2_8, "BlackScreen")

	local var_2_9 = arg_2_0._tf

	arg_2_0.povLayer = var_1.Find(var_2_9, "POVControl")

	arg_2_0:UpdatePOV()

	return
end

function var_0_1.BindEvent(arg_5_0)
	arg_5_0:bind(var_0_1.SHOW_BLACK_SCREEN, arg_5_0.ShowBlackScreen)
	arg_5_0:bind(var_0_1.SHOW_HELP_BOX, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0

		var_2.ShowHelpBox(var_6_0, arg_6_1)

		return
	end)

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.bind

	CarWashLadySystem = var_4

	var_5_1(var_5_0, var_4.UPDATE_EXPRESSION_HUD_POSITION, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_5_0

		var_2.UpdateExpressionHUDPosition(var_7_0, arg_7_1)

		return
	end)
	arg_5_0:bind(var_0_1.SHOW_EXPRESSION_HUD, function(arg_8_0, arg_8_1)
		switch = var_2_10002

		local var_8_0 = var_2_10002(arg_8_1, {
			[var_0_1.EXPRESSION_TYPE.LIKE] = function()
				return arg_5_0.expressionLike
			end,
			[var_0_1.EXPRESSION_TYPE.HATE] = function()
				return arg_5_0.expressionHate
			end
		}, function()
			assert = var_3_10000

			local var_11_0 = false
			local var_11_1 = "CarWashMainPage: unknown expression type: "

			tostring = var_3_10004

			var_3_10000(var_11_0, var_11_1 .. var_3_10004(arg_8_1))

			return nil
		end)

		setActive = var_2_10003

		var_2_10003(var_8_0, false)

		setActive = var_2_10003

		var_2_10003(var_8_0, true)

		return
	end)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.bind

	CarWashTimelineSystem = var_4

	var_5_3(var_5_2, var_4.TIMELINE_SEQUENCE_BEGIN, function(arg_12_0, arg_12_1)
		if arg_12_1 and arg_12_1.data and arg_12_1.data.hideUI == false then
			return
		end

		local var_12_0 = arg_5_0

		var_2.Hide(var_12_0)

		return
	end)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.bind

	CarWashTimelineSystem = var_4

	var_5_5(var_5_4, var_4.TIMELINE_SEQUENCE_END, function(arg_13_0, arg_13_1)
		if arg_13_1 and arg_13_1.data and arg_13_1.data.hideUI == false then
			return
		end

		local var_13_0 = arg_5_0

		var_2.Show(var_13_0)

		return
	end)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.bind

	CarWashTimelineSystem = var_4

	var_5_7(var_5_6, var_4.TRANSITION_BEGIN, function()
		local var_14_0 = arg_5_0

		var_0.EnableBlock(var_14_0, true)

		return
	end)

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.bind

	CarWashTimelineSystem = var_4

	var_5_9(var_5_8, var_4.TRANSITION_END, function()
		local var_15_0 = arg_5_0

		var_0.EnableBlock(var_15_0, false)

		return
	end)

	return
end

function var_0_1.UpdatePOV(arg_16_0)
	local var_16_0 = arg_16_0.povLayer
	local var_16_1 = var_1.Find(var_16_0, "Move")
	local var_16_2 = var_1.GetComponent

	typeof = var_4
	SlideController = var_1_10006

	local var_16_3 = var_16_2(var_16_1, var_4(var_1_10006))

	var_1.AddBeginDragFunc(var_16_3, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_16_0
		local var_17_1 = var_2.emit

		CarWashPovControlSystem = var_2_10005

		var_17_1(var_17_0, var_2_10005.ON_STICK_MOVE_BEGIN, arg_17_1)

		return
	end)
	var_1:SetStickFunc(function(arg_18_0)
		local var_18_0 = arg_16_0
		local var_18_1 = var_1.emit

		CarWashPovControlSystem = var_2_10004

		var_18_1(var_18_0, var_2_10004.ON_STICK_MOVE, arg_18_0)

		return
	end)
	var_1:AddDragEndFunc(function(arg_19_0, arg_19_1)
		local var_19_0 = arg_16_0
		local var_19_1 = var_2.emit

		CarWashPovControlSystem = var_2_10005

		var_19_1(var_19_0, var_2_10005.ON_STICK_MOVE_END, arg_19_1)

		return
	end)

	local var_16_4 = arg_16_0.povLayer
	local var_16_5 = var_2.Find(var_16_4, "View")
	local var_16_6 = var_2.GetComponent

	typeof = var_5
	SlideController = var_1_10007

	local var_16_7 = var_16_6(var_16_5, var_5(var_1_10007))

	var_2.SetStickFunc(var_16_7, function(arg_20_0)
		local var_20_0 = arg_16_0
		local var_20_1 = var_1.emit

		CarWashPovControlSystem = var_2_10004

		var_20_1(var_20_0, var_2_10004.ON_STICK_VIEW, arg_20_0)

		return
	end)

	return
end

function var_0_1.Flush(arg_21_0)
	return
end

function var_0_1.UpdateExpressionHUDPosition(arg_22_0, arg_22_1)
	if not arg_22_1 then
		return
	end

	setActive = var_1_10002

	var_1_10002(arg_22_0.expressionRoot, arg_22_1.visible)

	if arg_22_1.visible then
		setLocalPosition = var_2

		local var_22_0 = arg_22_0.expressionRoot

		LuaHelper = var_5

		local var_22_1 = var_5.ScreenToLocal
		local var_22_2 = arg_22_0.expressionRoot.parent
		local var_22_3 = arg_22_1.screenPosition

		pg = var_1_10009

		var_2(var_22_0, var_22_1(var_22_2, var_22_3, var_1_10009.UIMgr.GetInstance().uiCameraComp))
	end

	return
end

function var_0_1.ShowHelpBox(arg_23_0, arg_23_1)
	pg = var_1_10002

	local var_23_0 = var_1_10002.NewStyleMsgboxMgr.GetInstance()
	local var_23_1 = var_2.Show

	pg = var_1_10005

	local var_23_2 = var_1_10005.NewStyleMsgboxMgr.TYPE_MSGBOX
	local var_23_3 = {}

	i18n = var_1_10007
	var_23_3.title = var_1_10007("dorm3d_carwash_title")
	i18n = var_7
	var_23_3.contentText = var_7("dorm3d_carwash_tiiiiiip")

	function var_23_3.onConfirm()
		existCall = var_2_10000

		var_2_10000(arg_23_1)

		return
	end

	function var_23_3.onClose()
		existCall = var_2_10000

		var_2_10000(arg_23_1)

		return
	end

	var_23_1(var_23_0, var_23_2, var_23_3)

	return
end

function var_0_1.EnableBlock(arg_26_0, arg_26_1)
	setActive = var_1_10002

	var_1_10002(arg_26_0.blockLayer, arg_26_1)

	return
end

function var_0_1.ShowBlackScreen(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = {
		color = "#000000",
		time = 0.3,
		delay = arg_27_1 and 0 or 0.3
	}

	setImageColor = var_4

	local var_27_1 = arg_27_0.blackLayer

	Color = var_1_10007

	var_4(var_27_1, var_1_10007.NewHex(var_27_0.color))

	setActive = var_4

	var_4(arg_27_0.blackLayer, true)

	setCanvasGroupAlpha = var_4

	var_4(arg_27_0.blackLayer, arg_27_1 and 0 or 1)

	local var_27_2 = arg_27_0
	local var_27_3 = arg_27_0.managedTween

	LeanTween = var_7

	local var_27_4 = var_7.alphaCanvas

	local function var_27_5()
		if not arg_27_1 then
			setActive = var_0

			var_0(arg_27_0.blackLayer, false)
		end

		existCall = var_0

		var_0(arg_27_2)

		return
	end

	GetComponent = var_9

	local var_27_6 = arg_27_0.blackLayer

	typeof = var_1_10012
	CanvasGroup = var_1_10014

	local var_27_7 = var_27_3(var_27_2, var_27_4, var_27_5, var_9(var_27_6, var_1_10012(var_1_10014)), arg_27_1 and 1 or 0, var_27_0.time)

	var_4.setDelay(var_27_7, var_27_0.delay)

	return
end

return var_0_1
