class = var_0_10000

local var_0_0 = "CommanderRenamePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CommandeRenameUI"
end

function var_0_1.OnInit(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_4.Find(var_2_1, "frame/close_btn")

	local function var_2_3()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_2_1

	var_1_10001(var_2_0, var_2_2, var_2_3, var_2_1)

	onButton = var_1_10001

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0._tf

	local function var_2_6()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_2_1

	var_1_10001(var_2_4, var_2_5, var_2_6, var_2_1)

	onButton = var_1_10001

	local var_2_7 = arg_2_0
	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_4.Find(var_2_8, "frame/cancel_btn")

	local function var_2_10()
		local var_5_0 = arg_2_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_2_8

	var_1_10001(var_2_7, var_2_9, var_2_10, var_2_8)

	findTF = var_1_10001
	arg_2_0.input = var_1_10001(arg_2_0._tf, "frame/bg/content/input")

	local var_2_11 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_11, "frame/confirm_btn")
	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "frame/bg/content/label")

	i18n = var_4

	var_1(var_2_13, var_4("commander_rename_tip"))

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	arg_6_0.isShowMsgBox = true
	setActive = var_2

	var_2(arg_6_0._tf, true)

	local var_6_0 = arg_6_0._tf

	var_2.SetAsLastSibling(var_6_0)

	setInputText = var_2

	var_2(arg_6_0.input, "")

	onButton = var_2

	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.confirmBtn

	local function var_6_3()
		getInputText = var_2_10000

		if not var_2_10000(arg_6_0.input) or var_0 == "" then
			return
		end

		local var_7_0 = arg_6_0
		local var_7_1 = var_1.emit

		CommanderCatMediator = var_2_10004

		var_7_1(var_7_0, var_2_10004.RENAME, arg_6_1.id, var_0)

		local var_7_2 = arg_6_0

		var_1.Hide(var_7_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_6_1, var_6_2, var_6_3, var_1_10007)

	pg = var_2

	local var_6_4 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_6_4, arg_6_0._tf)

	return
end

function var_0_1.Hide(arg_8_0)
	arg_8_0.isShowMsgBox = nil
	setActive = var_1

	var_1(arg_8_0._tf, false)

	pg = var_1

	local var_8_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf, arg_8_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_9_0)
	if arg_9_0.isShowMsgBox then
		arg_9_0:Hide()
	end

	return
end

return var_0_1
