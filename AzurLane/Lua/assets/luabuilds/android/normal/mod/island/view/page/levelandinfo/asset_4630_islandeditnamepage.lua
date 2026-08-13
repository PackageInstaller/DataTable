class = var_0_10000

local var_0_0 = "IslandEditNamePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandEditNameui"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.input = var_1.Find(var_2_0, "frame/name/InputField")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "frame/close")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_2, "frame/confirm")

	local var_2_3 = arg_2_0._tf

	arg_2_0.content = var_1.Find(var_2_3, "frame/Text")
	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "frame/title")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("island_rename_title"))

	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "frame/confirm/Text")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("word_ok"))

	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "frame/name/InputField/Placeholder")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("island_rename_input_tip"))

	return
end

function var_0_1.AddListeners(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.AddListener

	GAME = var_1_10003

	var_3_1(var_3_0, var_1_10003.ISLAND_SET_NAME_DONE, arg_3_0.OnModifyName)

	return
end

function var_0_1.RemoveListeners(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.RemoveListener

	GAME = var_1_10003

	var_4_1(var_4_0, var_1_10003.ISLAND_SET_NAME_DONE, arg_4_0.OnModifyName)

	return
end

function var_0_1.OnModifyName(arg_5_0)
	arg_5_0:Hide()

	if arg_5_0.callback then
		arg_5_0.callback()
	end

	return
end

function var_0_1.OnInit(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf

	local function var_6_2()
		local var_7_0 = arg_6_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.closeBtn

	local function var_6_5()
		local var_8_0 = arg_6_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10005)

	onButton = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.confirmBtn

	local function var_6_8()
		getInputText = var_2_10000

		local var_9_0 = var_2_10000(arg_6_0.input)
		local var_9_1 = arg_6_0
		local var_9_2 = var_1.emit

		IslandMediator = var_2_10003

		var_9_2(var_9_1, var_2_10003.SET_NAME, var_9_0, 1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10005)

	return
end

function var_0_1.Show(arg_10_0, arg_10_1)
	var_0_1.super.Show(arg_10_0)

	arg_10_0.callback = arg_10_1

	arg_10_0:UpdateContent()

	pg = var_2

	local var_10_0 = var_2.UIMgr.GetInstance()

	var_2.OverlayPanel(var_10_0, arg_10_0._tf)

	return
end

function var_0_1.Hide(arg_11_0)
	arg_11_0:PlayExitAniamtion(function()
		var_0_1.super.Hide(arg_11_0)

		pg = var_0

		local var_12_0 = var_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_12_0, arg_11_0._tf, arg_11_0._parentTf)

		return
	end)

	return
end

function var_0_1.PlayExitAniamtion(arg_13_0, arg_13_1)
	arg_13_0.isPlayingAnimation = true

	if arg_13_1 then
		arg_13_1()
	end

	return
end

function var_0_1.UpdateContent(arg_14_0)
	setInputText = var_1_10001

	var_1_10001(arg_14_0.input, "")

	setText = var_1_10001

	local var_14_0 = arg_14_0.content

	i18n = var_3

	var_1_10001(var_14_0, var_3("island_rename_consutme_tip"))

	return
end

function var_0_1.OnDestroy(arg_15_0)
	arg_15_0.callback = nil

	return
end

return var_0_1
