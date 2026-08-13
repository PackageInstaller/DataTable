class = var_0_10000

local var_0_0 = "CourtYardRenamePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "CourtYardRenameUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_0, "frame/confirm")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "frame/cancel")

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "frame/close")

	local var_2_3 = arg_2_0._tf

	arg_2_0.input = var_1.Find(var_2_3, "frame/input")
	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "frame/cancel/Text")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("word_cancel"))

	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_2.Find(var_2_6, "frame/confirm/Text")

	i18n = var_2_6

	var_1(var_2_7, var_2_6("word_ok"))

	setText = var_1

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_2.Find(var_2_8, "frame/title")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("backyard_rename_title"))

	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "frame/input/placehoder")

	i18n = var_2_10

	var_1(var_2_11, var_2_10("backyard_rename_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		getInputText = var_2_10000

		local var_4_1

		if not var_2_10000(arg_3_0.input) or var_0 == "" then
			pg = var_4_1

			local var_4_0 = var_4_1.TipsMgr.GetInstance()

			var_4_1 = var_4_1.ShowTips
			i18n = var_2_10003

			var_4_1(var_4_0, var_2_10003("word_should_input"))

			return
		end

		nameValidityCheck = var_4_1

		if not var_4_1(var_0, 0, 20, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"playerinfo_mask_word"
		}) then
			return
		end

		local var_4_2 = arg_3_0
		local var_4_3 = var_1.emit

		CourtYardMediator = var_3

		var_4_3(var_4_2, var_3.RENAME, var_0)

		local var_4_4 = arg_3_0

		var_1.Hide(var_4_4)

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
	local var_3_7 = arg_3_0.closeBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0._tf

	local function var_3_11()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	return
end

function var_0_1.Flush(arg_8_0)
	arg_8_0:Show()

	return
end

function var_0_1.OnDestroy(arg_9_0)
	arg_9_0:Hide()

	return
end

return var_0_1
