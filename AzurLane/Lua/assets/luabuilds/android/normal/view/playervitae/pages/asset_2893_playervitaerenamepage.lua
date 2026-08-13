class = var_0_10000

local var_0_0 = "PlayerVitaeRenamePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PlayerVitaeRenamePage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/border/tip")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.content = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_3, "frame/queren")

	local var_2_4 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_4, "frame/cancel")

	local var_2_5 = arg_2_0._tf

	arg_2_0.inputField = var_1.Find(var_2_5, "frame/name_field")
	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "frame/top/title_list/infomation/title")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("change_player_name_title"))

	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "frame/border/prompt")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("change_player_name_subtitle"))

	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "frame/name_field/Placeholder")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("change_player_name_input_tip"))

	setText = var_1

	local var_2_12 = arg_2_0.confirmBtn
	local var_2_13 = var_2.Find(var_2_12, "Image")

	i18n = var_2_12

	var_1(var_2_13, var_2_12("word_ok"))

	setText = var_1

	local var_2_14 = arg_2_0.cancelBtn
	local var_2_15 = var_2.Find(var_2_14, "Image")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("word_cancel"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		getInputText = var_2_10000

		local var_4_0 = var_2_10000(arg_3_0.inputField)
		local var_4_1 = arg_3_0
		local var_4_2 = var_1.emit

		PlayerVitaeMediator = var_2_10003

		var_4_2(var_4_1, var_2_10003.ON_CHANGE_PLAYER_NAME, var_4_0)

		setInputText = var_4_2

		var_4_2(arg_3_0.inputField, "")

		local var_4_3 = arg_3_0

		var_1.Hide(var_4_3)

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
	local var_3_7 = arg_3_0._tf

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	Drop = var_2

	local var_7_0 = var_2.Create
	local var_7_1 = arg_7_1
	local var_7_2 = var_7_0(arg_7_1.getModifyNameComsume(var_7_1))
	local var_7_3 = arg_7_0.content

	i18n = var_7_1
	var_7_3.text = var_7_1("player_name_change_windows_tip", var_7_2:getName(), var_7_2:getOwnedCount() .. "/" .. var_7_2.count)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	arg_8_0:Hide()

	return
end

return var_0_1
