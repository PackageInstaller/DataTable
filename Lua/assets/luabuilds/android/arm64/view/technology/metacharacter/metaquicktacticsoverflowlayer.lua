local var_0_0 = class("MetaQuickTacticsOverflowLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "MetaQuickTacticsOverflowUI"
end

function var_0_0.getGroupName(arg_2_0)
	return "MetaCharacterScene"
end

function var_0_0.init(arg_3_0)
	arg_3_0:initData()
	arg_3_0:initUI()
	arg_3_0:addListener()
	arg_3_0:overlayPanel(true)

	return
end

function var_0_0.didEnter(arg_4_0)
	return
end

function var_0_0.willExit(arg_5_0)
	arg_5_0:overlayPanel(false)

	return
end

function var_0_0.onBackPressed(arg_6_0)
	arg_6_0:closeView()

	return
end

function var_0_0.overlayPanel(arg_7_0, arg_7_1)
	if arg_7_1 and arg_7_0._tf then
		arg_7_0:OverlayPanel(arg_7_0._tf)
	elseif arg_7_0._tf then
		arg_7_0:UnOverlayPanel(arg_7_0._tf)
	end

	return
end

function var_0_0.initData(arg_8_0)
	arg_8_0.shipID = arg_8_0.contextData.shipID
	arg_8_0.skillID = arg_8_0.contextData.skillID
	arg_8_0.useCountDict = arg_8_0.contextData.useCountDict
	arg_8_0.overExp = arg_8_0.contextData.overExp

	return
end

function var_0_0.initUI(arg_9_0)
	arg_9_0.bg = arg_9_0._tf:Find("BG")
	arg_9_0.text = arg_9_0._tf:Find("Content/Context/Text")
	arg_9_0.cancelBtn = arg_9_0._tf:Find("Content/CancelBtn")
	arg_9_0.confirmBtn = arg_9_0._tf:Find("Content/ConfirmBtn")

	setText(arg_9_0.text, i18n("metaskill_overflow_tip", arg_9_0.overExp))

	return
end

function var_0_0.addListener(arg_10_0)
	onButton(arg_10_0, arg_10_0.bg, function()
		arg_10_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.cancelBtn, function()
		arg_10_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_0.confirmBtn, function()
		arg_10_0:emit(MetaQuickTacticsOverflowMediator.USE_TACTICS_BOOK, arg_10_0.shipID, arg_10_0.skillID, arg_10_0.useCountDict)
		arg_10_0:closeView()

		return
	end, SFX_PANEL)

	return
end

return var_0_0
