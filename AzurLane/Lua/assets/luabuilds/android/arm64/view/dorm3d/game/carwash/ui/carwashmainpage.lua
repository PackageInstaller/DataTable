local var_0_0 = class("CarWashMainPage", import("view.dorm3d.Game.Dorm3dGameBaseSubView"))

var_0_0.SHOW_BLACK_SCREEN = "CarWashMainPage.SHOW_BLACK_SCREEN"
var_0_0.SHOW_HELP_BOX = "CarWashMainPage.SHOW_HELP_BOX"
var_0_0.SHOW_EXPRESSION_HUD = "CarWashMainPage.SHOW_EXPRESSION_HUD"
var_0_0.ENABLE_BLOCK = "CarWashMainPage.ENABLE_BLOCK"
var_0_0.EXPRESSION_TYPE = {
	LIKE = "LIKE",
	HATE = "HATE"
}

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:BindEvent()

	return
end

function var_0_0.InitUI(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("btn_back"), function()
		arg_2_0:emit(BaseUI.ON_BACK)

		return
	end)
	onButton(arg_2_0, arg_2_0._tf:Find("btn_help"), function()
		arg_2_0:ShowHelpBox()

		return
	end)

	arg_2_0.expressionRoot = arg_2_0._tf:Find("expression_root")
	arg_2_0.expressionLike = arg_2_0.expressionRoot:Find("vfx_car_aixin01")
	arg_2_0.expressionHate = arg_2_0.expressionRoot:Find("vfx_car_xixian01")

	setActive(arg_2_0.expressionLike, false)
	setActive(arg_2_0.expressionHate, false)

	arg_2_0.blockLayer = arg_2_0._tf:Find("block")

	arg_2_0:EnableBlock(false)

	arg_2_0.blackLayer = arg_2_0._tf:Find("BlackScreen")
	arg_2_0.povLayer = arg_2_0._tf:Find("POVControl")

	arg_2_0:UpdatePOV()

	return
end

function var_0_0.BindEvent(arg_5_0)
	arg_5_0:bind(var_0_0.SHOW_BLACK_SCREEN, arg_5_0.ShowBlackScreen)
	arg_5_0:bind(var_0_0.SHOW_HELP_BOX, function(arg_6_0, arg_6_1)
		arg_5_0:ShowHelpBox(arg_6_1)

		return
	end)
	arg_5_0:bind(CarWashLadySystem.UPDATE_EXPRESSION_HUD_POSITION, function(arg_7_0, arg_7_1)
		arg_5_0:UpdateExpressionHUDPosition(arg_7_1)

		return
	end)
	arg_5_0:bind(var_0_0.SHOW_EXPRESSION_HUD, function(arg_8_0, arg_8_1)
		local var_8_0 = switch(arg_8_1, {
			[var_0_0.EXPRESSION_TYPE.LIKE] = function()
				return arg_5_0.expressionLike
			end,
			[var_0_0.EXPRESSION_TYPE.HATE] = function()
				return arg_5_0.expressionHate
			end
		}, function()
			assert(false, "CarWashMainPage: unknown expression type: " .. tostring(arg_8_1))

			return nil
		end)

		setActive(var_8_0, false)
		setActive(var_8_0, true)

		return
	end)
	arg_5_0:bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, function(arg_12_0, arg_12_1)
		if arg_12_1 and arg_12_1.data and arg_12_1.data.hideUI == false then
			return
		end

		arg_5_0:Hide()

		return
	end)
	arg_5_0:bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, function(arg_13_0, arg_13_1)
		if arg_13_1 and arg_13_1.data and arg_13_1.data.hideUI == false then
			return
		end

		arg_5_0:Show()

		return
	end)
	arg_5_0:bind(CarWashTimelineSystem.TRANSITION_BEGIN, function()
		arg_5_0:EnableBlock(true)

		return
	end)
	arg_5_0:bind(CarWashTimelineSystem.TRANSITION_END, function()
		arg_5_0:EnableBlock(false)

		return
	end)

	return
end

function var_0_0.UpdatePOV(arg_16_0)
	local var_16_0 = arg_16_0.povLayer:Find("Move"):GetComponent(typeof(SlideController))

	var_16_0:AddBeginDragFunc(function(arg_17_0, arg_17_1)
		arg_16_0:emit(CarWashPovControlSystem.ON_STICK_MOVE_BEGIN, arg_17_1)

		return
	end)
	var_16_0:SetStickFunc(function(arg_18_0)
		arg_16_0:emit(CarWashPovControlSystem.ON_STICK_MOVE, arg_18_0)

		return
	end)
	var_16_0:AddDragEndFunc(function(arg_19_0, arg_19_1)
		arg_16_0:emit(CarWashPovControlSystem.ON_STICK_MOVE_END, arg_19_1)

		return
	end)
	arg_16_0.povLayer:Find("View"):GetComponent(typeof(SlideController)):SetStickFunc(function(arg_20_0)
		arg_16_0:emit(CarWashPovControlSystem.ON_STICK_VIEW, arg_20_0)

		return
	end)

	return
end

function var_0_0.Flush(arg_21_0)
	return
end

function var_0_0.UpdateExpressionHUDPosition(arg_22_0, arg_22_1)
	if not arg_22_1 then
		return
	end

	setActive(arg_22_0.expressionRoot, arg_22_1.visible)

	if arg_22_1.visible then
		setLocalPosition(arg_22_0.expressionRoot, LuaHelper.ScreenToLocal(arg_22_0.expressionRoot.parent, arg_22_1.screenPosition, pg.UIMgr.GetInstance().uiCameraComp))
	end

	return
end

function var_0_0.ShowHelpBox(arg_23_0, arg_23_1)
	pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
		title = i18n("dorm3d_carwash_title"),
		contentText = i18n("dorm3d_carwash_tiiiiiip"),
		onConfirm = function()
			existCall(arg_23_1)

			return
		end,
		onClose = function()
			existCall(arg_23_1)

			return
		end
	})

	return
end

function var_0_0.EnableBlock(arg_26_0, arg_26_1)
	setActive(arg_26_0.blockLayer, arg_26_1)

	return
end

function var_0_0.ShowBlackScreen(arg_27_0, arg_27_1, arg_27_2)
	setImageColor(arg_27_0.blackLayer, Color.NewHex(({
		color = "#000000",
		time = 0.3,
		delay = arg_27_1 and 0 or 0.3
	}).color))
	setActive(arg_27_0.blackLayer, true)
	setCanvasGroupAlpha(arg_27_0.blackLayer, arg_27_1 and 0 or 1)
	arg_27_0:managedTween(LeanTween.alphaCanvas, function()
		if not arg_27_1 then
			setActive(arg_27_0.blackLayer, false)
		end

		existCall(arg_27_2)

		return
	end, GetComponent(arg_27_0.blackLayer, typeof(CanvasGroup)), arg_27_1 and 1 or 0, ({
		color = "#000000",
		time = 0.3,
		delay = arg_27_1 and 0 or 0.3
	}).time):setDelay(({
		color = "#000000",
		time = 0.3,
		delay = arg_27_1 and 0 or 0.3
	}).delay)

	return
end

return var_0_0
