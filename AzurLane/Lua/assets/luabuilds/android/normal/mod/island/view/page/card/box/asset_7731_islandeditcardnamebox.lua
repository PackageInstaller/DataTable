class = var_0_10000

local var_0_0 = "IslandEditCardNameBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandEditCardNameBox"
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

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	Animation = var_4
	arg_2_0.animator = var_2_11(var_2_10, var_3(var_4))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4
	arg_2_0.aniDft = var_2_13(var_2_12, var_3(var_4))
	arg_2_0.isPlayingAnimation = false

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.closeBtn

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

		var_6_2(var_6_1, var_2_10003.SET_CARD_NAME, var_6_0, 1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	arg_7_0.isPlayingAnimation = false
	arg_7_0.callback = arg_7_1

	arg_7_0:UpdateContent()

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_0._tf)

	local var_7_1 = arg_7_0.animator

	var_2.Play(var_7_1, "anim_IslandEditNameUI_In")

	return
end

function var_0_1.Hide(arg_8_0)
	if arg_8_0.isPlayingAnimation then
		return
	end

	arg_8_0.isPlayingAnimation = true

	arg_8_0:PlayExitAniamtion(function()
		arg_8_0.isPlayingAnimation = false

		local var_9_0 = arg_8_0.aniDft

		var_0.SetEndEvent(var_9_0, nil)
		var_0_1.super.Hide(arg_8_0)

		pg = var_0

		local var_9_1 = var_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_9_1, arg_8_0._tf, arg_8_0._parentTf)

		return
	end)

	return
end

function var_0_1.PlayExitAniamtion(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.aniDft

	var_2.SetEndEvent(var_10_0, function()
		if arg_10_1 then
			arg_10_1()
		end

		return
	end)

	local var_10_1 = arg_10_0.animator

	var_2.Play(var_10_1, "anim_IslandEditNameUI_Out")

	return
end

function var_0_1.UpdateContent(arg_12_0)
	setInputText = var_1_10001

	var_1_10001(arg_12_0.input, "")

	setText = var_1_10001

	local var_12_0 = arg_12_0.content

	i18n = var_3

	var_1_10001(var_12_0, var_3("island_rename_consutme_tip"))

	return
end

function var_0_1.OnDestroy(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf, arg_13_0._parentTf)

	local var_13_1 = arg_13_0.aniDft

	var_1.SetEndEvent(var_13_1, nil)

	return
end

return var_0_1
