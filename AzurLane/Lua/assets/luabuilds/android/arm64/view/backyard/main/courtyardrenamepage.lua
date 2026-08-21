local var_0_0 = class("CourtYardRenamePage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CourtYardRenameUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/confirm")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel")
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.input = arg_2_0._tf:Find("frame/input")

	setText(arg_2_0._tf:Find("frame/cancel/Text"), i18n("word_cancel"))
	setText(arg_2_0._tf:Find("frame/confirm/Text"), i18n("word_ok"))
	setText(arg_2_0._tf:Find("frame/title"), i18n("backyard_rename_title"))
	setText(arg_2_0._tf:Find("frame/input/placehoder"), i18n("backyard_rename_tip"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		local var_4_0 = getInputText(arg_3_0.input)

		if not var_4_0 or var_4_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("word_should_input"))

			return
		end

		if not nameValidityCheck(var_4_0, 0, 20, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"playerinfo_mask_word"
		}) then
			return
		end

		arg_3_0:emit(CourtYardMediator.RENAME, var_4_0)
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Flush(arg_8_0)
	arg_8_0:Show()

	return
end

function var_0_0.OnDestroy(arg_9_0)
	arg_9_0:Hide()

	return
end

return var_0_0
