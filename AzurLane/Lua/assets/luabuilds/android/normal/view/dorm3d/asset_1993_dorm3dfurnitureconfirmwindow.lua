class = var_0_10000

local var_0_0 = "Dorm3dFurnitureConfirmWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dFurnitureConfirmWindow"
end

function var_0_1.init(arg_2_0)
	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "Window/Confirm")

	local function var_3_3()
		local var_4_0 = arg_3_0.contextData.onYes
		local var_4_1 = arg_3_0

		var_1.closeView(var_4_1)

		existCall = var_1

		var_1(var_4_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "Window/Cancel")

	local function var_3_7()
		local var_5_0 = arg_3_0.contextData.onNo
		local var_5_1 = arg_3_0

		var_1.closeView(var_5_1)

		existCall = var_1

		var_1(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf

	var_1_10001(var_3_8, var_3.Find(var_3_9, "Mask"), function()
		local var_6_0 = arg_3_0.contextData.onClose
		local var_6_1 = arg_3_0

		var_1.closeView(var_6_1)

		existCall = var_1

		var_1(var_6_0)

		return
	end)

	onButton = var_1_10001

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0._tf
	local var_3_12 = var_3.Find(var_3_11, "Window/Close")

	local function var_3_13()
		local var_7_0 = arg_3_0.contextData.onClose
		local var_7_1 = arg_3_0

		var_1.closeView(var_7_1)

		existCall = var_1

		var_1(var_7_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_10, var_3_12, var_3_13, var_5)

	setText = var_1_10001

	local var_3_14 = arg_3_0._tf

	var_1_10001(var_2.Find(var_3_14, "Window/Title"), arg_3_0.contextData.title)

	setText = var_1_10001

	local var_3_15 = arg_3_0._tf

	var_1_10001(var_2.Find(var_3_15, "Window/Content"), arg_3_0.contextData.content)

	setText = var_1_10001

	local var_3_16 = arg_3_0._tf
	local var_3_17 = var_2.Find(var_3_16, "Window/Confirm/Text")

	i18n = var_3_16

	var_1_10001(var_3_17, var_3_16("msgbox_text_confirm"))

	setText = var_1_10001

	local var_3_18 = arg_3_0._tf
	local var_3_19 = var_2.Find(var_3_18, "Window/Cancel/Text")

	i18n = var_3_18

	var_1_10001(var_3_19, var_3_18("msgbox_text_cancel"))

	return
end

function var_0_1.willExit(arg_8_0)
	return
end

return var_0_1
