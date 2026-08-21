local var_0_0 = class("IslandEditNamePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandEditNameui"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.input = arg_2_0._tf:Find("frame/name/InputField")
	arg_2_0.closeBtn = arg_2_0._tf:Find("frame/close")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/confirm")
	arg_2_0.content = arg_2_0._tf:Find("frame/Text")

	setText(arg_2_0._tf:Find("frame/title"), i18n("island_rename_title"))
	setText(arg_2_0._tf:Find("frame/confirm/Text"), i18n("word_ok"))
	setText(arg_2_0._tf:Find("frame/name/InputField/Placeholder"), i18n("island_rename_input_tip"))

	return
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddListener(GAME.ISLAND_SET_NAME_DONE, arg_3_0.OnModifyName)

	return
end

function var_0_0.RemoveListeners(arg_4_0)
	arg_4_0:RemoveListener(GAME.ISLAND_SET_NAME_DONE, arg_4_0.OnModifyName)

	return
end

function var_0_0.OnModifyName(arg_5_0)
	arg_5_0:Hide()

	if arg_5_0.callback then
		arg_5_0.callback()
	end

	return
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf, function()
		arg_6_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.closeBtn, function()
		arg_6_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.confirmBtn, function()
		arg_6_0:emit(IslandMediator.SET_NAME, getInputText(arg_6_0.input), 1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_10_0, arg_10_1)
	var_0_0.super.Show(arg_10_0)

	arg_10_0.callback = arg_10_1

	arg_10_0:UpdateContent()
	pg.UIMgr.GetInstance():OverlayPanel(arg_10_0._tf)

	return
end

function var_0_0.Hide(arg_11_0)
	arg_11_0:PlayExitAniamtion(function()
		var_0_0.super.Hide(arg_11_0)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_11_0._tf, arg_11_0._parentTf)

		return
	end)

	return
end

function var_0_0.PlayExitAniamtion(arg_13_0, arg_13_1)
	arg_13_0.isPlayingAnimation = true

	if arg_13_1 then
		arg_13_1()
	end

	return
end

function var_0_0.UpdateContent(arg_14_0)
	setInputText(arg_14_0.input, "")
	setText(arg_14_0.content, i18n("island_rename_consutme_tip"))

	return
end

function var_0_0.OnDestroy(arg_15_0)
	arg_15_0.callback = nil

	return
end

return var_0_0
