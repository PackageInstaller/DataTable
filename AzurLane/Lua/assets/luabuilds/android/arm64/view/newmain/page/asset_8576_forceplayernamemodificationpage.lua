class = var_0_10000

local var_0_0 = "ForcePlayerNameModificationPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PlayerVitaeRenamePage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/border/tip")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.content = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_3, "frame/queren")

	local var_2_4 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_4, "frame/cancel")

	local var_2_5 = arg_2_0._tf

	arg_2_0.inputField = var_1.Find(var_2_5, "frame/name_field")

	local var_2_6 = arg_2_0._tf

	arg_2_0.prompt = var_1.Find(var_2_6, "frame/border/prompt")
	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "frame/top/title_list/infomation/title")

	i18n = var_4

	var_1(var_2_8, var_4("change_player_name_title"))

	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "frame/name_field/Placeholder")

	i18n = var_4

	var_1(var_2_10, var_4("change_player_name_input_tip"))

	setText = var_1

	local var_2_11 = arg_2_0.confirmBtn
	local var_2_12 = var_3.Find(var_2_11, "Image")

	i18n = var_4

	var_1(var_2_12, var_4("word_ok"))

	setActive = var_1

	var_1(arg_2_0.cancelBtn, false)

	setAnchoredPosition = var_1

	var_1(arg_2_0.confirmBtn, {
		x = -365
	})

	setAnchoredPosition = var_1

	var_1(arg_2_0.inputField, {
		y = -30
	})

	setAnchoredPosition = var_1

	var_1(arg_2_0.prompt, {
		y = 43
	})

	local var_2_13 = arg_2_0.prompt
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	Text = var_6

	local var_2_15 = var_2_14(var_2_13, var_4(var_6))

	TextAnchor = var_1_10002
	var_2_15.alignment = var_1_10002.MiddleCenter
	var_2_15.fontSize = 27
	var_2_15.lineSpacing = 0.8
	ReflectionHelp = var_2

	local var_2_16 = var_2.RefGetField

	typeof = var_4
	var_2_15.verticalOverflow = var_2_16(var_4("UnityEngine.VerticalWrapMode"), "Overflow")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		getInputText = var_2_10000

		local var_4_0 = var_2_10000(arg_3_0.inputField)

		pg = var_2_10001

		local var_4_1 = var_2_10001.m02
		local var_4_2 = var_1.sendNotification

		GAME = var_2_10004

		var_4_2(var_4_1, var_2_10004.CHANGE_PLAYER_NAME, {
			type = 2,
			name = var_4_0,
			onSuccess = function()
				setInputText = var_3_10000

				var_3_10000(arg_3_0.inputField, "")

				if arg_3_0.callback then
					arg_3_0.callback()
				end

				local var_5_0 = arg_3_0

				var_0.Hide(var_5_0)

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	arg_6_0.showing = true

	var_0_1.super.Show(arg_6_0)

	pg = var_2

	local var_6_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_6_0, arg_6_0._tf)

	getProxy = var_2
	PlayerProxy = var_6_0

	local var_6_1 = var_2(var_6_0)
	local var_6_2 = var_2.getRawData(var_6_1)

	i18n = var_1_10003

	local var_6_3 = var_1_10003("change_player_name_illegal", var_6_2.name)

	setText = var_6_1

	var_6_1(arg_6_0.prompt, var_6_3)

	arg_6_0.callback = arg_6_1

	return
end

function var_0_1.Hide(arg_7_0)
	if arg_7_0.showing then
		arg_7_0.showing = false
		pg = var_1

		local var_7_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_7_0, arg_7_0._tf, arg_7_0._parentTf)
		var_0_1.super.Hide(arg_7_0)

		arg_7_0.callback = nil
	end

	return
end

function var_0_1.OnDestroy(arg_8_0)
	arg_8_0:Hide()

	return
end

return var_0_1
