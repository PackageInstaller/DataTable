local var_0_0 = class("IslandEditCardNameBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandEditCardNameBox"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.input = arg_2_0._tf:Find("frame/name/InputField")
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/confirm")
	arg_2_0.content = arg_2_0._tf:Find("frame/Text")

	setText(arg_2_0._tf:Find("frame/title"), i18n("island_rename_title"))
	setText(arg_2_0._tf:Find("frame/confirm/Text"), i18n("word_ok"))
	setText(arg_2_0._tf:Find("frame/name/InputField/Placeholder"), i18n("island_rename_input_tip"))

	arg_2_0.animator = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.aniDft = arg_2_0._tf:GetComponent(typeof(DftAniEvent))
	arg_2_0.isPlayingAnimation = false

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:emit(IslandSelfCardMediator.SET_CARD_NAME, getInputText(arg_3_0.input), 1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)

	arg_7_0.isPlayingAnimation = false
	arg_7_0.callback = arg_7_1

	arg_7_0:UpdateContent()
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)
	arg_7_0.animator:Play("anim_IslandEditNameUI_In")

	return
end

function var_0_0.Hide(arg_8_0)
	if arg_8_0.isPlayingAnimation then
		return
	end

	arg_8_0.isPlayingAnimation = true

	arg_8_0:PlayExitAniamtion(function()
		arg_8_0.isPlayingAnimation = false

		arg_8_0.aniDft:SetEndEvent(nil)
		var_0_0.super.Hide(arg_8_0)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf, arg_8_0._parentTf)

		return
	end)

	return
end

function var_0_0.PlayExitAniamtion(arg_10_0, arg_10_1)
	arg_10_0.aniDft:SetEndEvent(function()
		if arg_10_1 then
			arg_10_1()
		end

		return
	end)
	arg_10_0.animator:Play("anim_IslandEditNameUI_Out")

	return
end

function var_0_0.UpdateContent(arg_12_0)
	setInputText(arg_12_0.input, "")
	setText(arg_12_0.content, i18n("island_rename_consutme_tip"))

	return
end

function var_0_0.OnDestroy(arg_13_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_13_0._tf, arg_13_0._parentTf)
	arg_13_0.aniDft:SetEndEvent(nil)

	return
end

return var_0_0
