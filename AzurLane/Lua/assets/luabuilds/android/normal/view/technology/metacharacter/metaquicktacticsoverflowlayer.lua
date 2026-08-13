class = var_0_10000

local var_0_0 = "MetaQuickTacticsOverflowLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MetaQuickTacticsOverflowUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "MetaCharacterScene"
end

function var_0_1.init(arg_3_0)
	arg_3_0:initData()
	arg_3_0:initUI()
	arg_3_0:addListener()
	arg_3_0:overlayPanel(true)

	return
end

function var_0_1.didEnter(arg_4_0)
	return
end

function var_0_1.willExit(arg_5_0)
	arg_5_0:overlayPanel(false)

	return
end

function var_0_1.onBackPressed(arg_6_0)
	arg_6_0:closeView()

	return
end

function var_0_1.overlayPanel(arg_7_0, arg_7_1)
	if arg_7_1 and arg_7_0._tf then
		arg_7_0:OverlayPanel(arg_7_0._tf)
	elseif arg_7_0._tf then
		arg_7_0:UnOverlayPanel(arg_7_0._tf)
	end

	return
end

function var_0_1.initData(arg_8_0)
	arg_8_0.shipID = arg_8_0.contextData.shipID
	arg_8_0.skillID = arg_8_0.contextData.skillID
	arg_8_0.useCountDict = arg_8_0.contextData.useCountDict
	arg_8_0.overExp = arg_8_0.contextData.overExp

	return
end

function var_0_1.initUI(arg_9_0)
	local var_9_0 = arg_9_0._tf

	arg_9_0.bg = var_1.Find(var_9_0, "BG")

	local var_9_1 = arg_9_0._tf

	arg_9_0.text = var_1.Find(var_9_1, "Content/Context/Text")

	local var_9_2 = arg_9_0._tf

	arg_9_0.cancelBtn = var_1.Find(var_9_2, "Content/CancelBtn")

	local var_9_3 = arg_9_0._tf

	arg_9_0.confirmBtn = var_1.Find(var_9_3, "Content/ConfirmBtn")
	setText = var_1

	local var_9_4 = arg_9_0.text

	i18n = var_3

	var_1(var_9_4, var_3("metaskill_overflow_tip", arg_9_0.overExp))

	return
end

function var_0_1.addListener(arg_10_0)
	local function var_10_0()
		local var_11_0 = arg_10_0

		var_0.closeView(var_11_0)

		return
	end

	onButton = var_1_10002

	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.bg
	local var_10_3 = var_10_0

	SFX_PANEL = var_1_10006

	var_1_10002(var_10_1, var_10_2, var_10_3, var_1_10006)

	onButton = var_1_10002

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.cancelBtn
	local var_10_6 = var_10_0

	SFX_PANEL = var_1_10006

	var_1_10002(var_10_4, var_10_5, var_10_6, var_1_10006)

	onButton = var_1_10002

	local var_10_7 = arg_10_0
	local var_10_8 = arg_10_0.confirmBtn

	local function var_10_9()
		local var_12_0 = arg_10_0
		local var_12_1 = var_0.emit

		MetaQuickTacticsOverflowMediator = var_2_10002

		var_12_1(var_12_0, var_2_10002.USE_TACTICS_BOOK, arg_10_0.shipID, arg_10_0.skillID, arg_10_0.useCountDict)

		local var_12_2 = arg_10_0

		var_0.closeView(var_12_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_10_7, var_10_8, var_10_9, var_1_10006)

	return
end

return var_0_1
