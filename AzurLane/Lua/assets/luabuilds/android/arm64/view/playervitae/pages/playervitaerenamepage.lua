local var_0_0 = class("PlayerVitaeRenamePage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "PlayerVitaeRenamePage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.content = arg_2_0._tf:Find("frame/border/tip"):GetComponent(typeof(Text))
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/queren")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel")
	arg_2_0.inputField = arg_2_0._tf:Find("frame/name_field")

	setText(arg_2_0._tf:Find("frame/top/title_list/infomation/title"), i18n("change_player_name_title"))
	setText(arg_2_0._tf:Find("frame/border/prompt"), i18n("change_player_name_subtitle"))
	setText(arg_2_0._tf:Find("frame/name_field/Placeholder"), i18n("change_player_name_input_tip"))
	setText(arg_2_0.confirmBtn:Find("Image"), i18n("word_ok"))
	setText(arg_2_0.cancelBtn:Find("Image"), i18n("word_cancel"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:emit(PlayerVitaeMediator.ON_CHANGE_PLAYER_NAME, (getInputText(arg_3_0.inputField)))
		setInputText(arg_3_0.inputField, "")
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)

	local var_7_0 = Drop.Create(arg_7_1:getModifyNameComsume())

	arg_7_0.content.text = i18n("player_name_change_windows_tip", var_7_0:getName(), var_7_0:getOwnedCount() .. "/" .. var_7_0.count)

	return
end

function var_0_0.OnDestroy(arg_8_0)
	arg_8_0:Hide()

	return
end

return var_0_0
