local var_0_0 = class("CommanderRenamePage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CommandeRenameUI"
end

function var_0_0.OnInit(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("frame/close_btn"), function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf, function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf:Find("frame/cancel_btn"), function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	arg_2_0.input = findTF(arg_2_0._tf, "frame/bg/content/input")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/confirm_btn")

	setText(arg_2_0._tf:Find("frame/bg/content/label"), i18n("commander_rename_tip"))

	return
end

function var_0_0.Show(arg_6_0, arg_6_1)
	arg_6_0.isShowMsgBox = true

	setActive(arg_6_0._tf, true)
	arg_6_0._tf:SetAsLastSibling()
	setInputText(arg_6_0.input, "")
	onButton(arg_6_0, arg_6_0.confirmBtn, function()
		local var_7_0 = getInputText(arg_6_0.input)

		if not var_7_0 or var_7_0 == "" then
			return
		end

		arg_6_0:emit(CommanderCatMediator.RENAME, arg_6_1.id, var_7_0)
		arg_6_0:Hide()

		return
	end, SFX_PANEL)
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	return
end

function var_0_0.Hide(arg_8_0)
	arg_8_0.isShowMsgBox = nil

	setActive(arg_8_0._tf, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf, arg_8_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_9_0)
	if arg_9_0.isShowMsgBox then
		arg_9_0:Hide()
	end

	return
end

return var_0_0
