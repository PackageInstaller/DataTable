local var_0_0 = class("IslandEditCardWordBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandEditCardWordBox"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("frame/title"), i18n("island_card_word_title"))

	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("cancel")

	setText(arg_2_0.cancelBtn:Find("Text"), i18n("word_cancel"))

	arg_2_0.confirmBtn = arg_2_0._tf:Find("confirm")

	setText(arg_2_0.confirmBtn:Find("Text"), i18n("word_ok"))

	arg_2_0.input = arg_2_0._tf:Find("InputField")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:emit(IslandSelfCardMediator.SET_CARD_WORD, (getInputText(arg_3_0.input)))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0)
	var_0_0.super.Show(arg_7_0)
	setInputText(arg_7_0.input, "")
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)

	return
end

function var_0_0.Hide(arg_8_0)
	var_0_0.super.Hide(arg_8_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf, arg_8_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf, arg_9_0._parentTf)

	return
end

return var_0_0
