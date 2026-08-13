class = var_0_10000

local var_0_0 = "IslandEditCardWordBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandEditCardWordBox"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "frame/title")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("island_card_word_title"))

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "frame/close")

	local var_2_3 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_3, "cancel")
	setText = var_1

	local var_2_4 = arg_2_0.cancelBtn
	local var_2_5 = var_2.Find(var_2_4, "Text")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("word_cancel"))

	local var_2_6 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_6, "confirm")
	setText = var_1

	local var_2_7 = arg_2_0.confirmBtn
	local var_2_8 = var_2.Find(var_2_7, "Text")

	i18n = var_2_7

	var_1(var_2_8, var_2_7("word_ok"))

	local var_2_9 = arg_2_0._tf

	arg_2_0.input = var_1.Find(var_2_9, "InputField")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.cancelBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.confirmBtn

	local function var_3_8()
		getInputText = var_2_10000

		local var_6_0 = var_2_10000(arg_3_0.input)
		local var_6_1 = arg_3_0
		local var_6_2 = var_1.emit

		IslandSelfCardMediator = var_2_10003

		var_6_2(var_6_1, var_2_10003.SET_CARD_WORD, var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Show(arg_7_0)
	var_0_1.super.Show(arg_7_0)

	setInputText = var_1

	var_1(arg_7_0.input, "")

	pg = var_1

	local var_7_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_7_0, arg_7_0._tf)

	return
end

function var_0_1.Hide(arg_8_0)
	var_0_1.super.Hide(arg_8_0)

	pg = var_1

	local var_8_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf, arg_8_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf, arg_9_0._parentTf)

	return
end

return var_0_1
