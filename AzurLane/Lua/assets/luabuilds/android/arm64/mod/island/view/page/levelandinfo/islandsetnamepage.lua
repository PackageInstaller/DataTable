local var_0_0 = class("IslandSetNamePage", import(".IslandEditNamePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandNewNameUI"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("frame/title"), i18n("island_rename_subtitle"))
	setActive(arg_2_0.closeBtn, false)

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:emit(IslandMediator.SET_NAME, getInputText(arg_3_0.input), 2)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateContent(arg_5_0)
	setText(arg_5_0.content, "")

	return
end

return var_0_0
