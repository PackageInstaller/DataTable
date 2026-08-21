local var_0_0 = class("IslandSettingsEscapePanel", import("view.Setting.panels.SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandSettingsEscape"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("grapihcs3d_setting_common_title")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / "
end

function var_0_0.InitTitle(arg_4_0)
	setText(arg_4_0._tf:Find("title/title_point/title_text"), arg_4_0:GetTitle())

	return
end

function var_0_0.OnInit(arg_5_0)
	arg_5_0.escapeBtn = arg_5_0._tf:Find("options/escape/btn")

	setText(arg_5_0._tf:Find("options/escape/mask/Text"), i18n("grapihcs3d_setting_common_unstuck"))
	setText(arg_5_0._tf:Find("options/escape/btn/Text"), i18n("grapihcs3d_setting_common_use"))
	onButton(arg_5_0, arg_5_0.escapeBtn, function()
		pg.m02:sendNotification(GAME.ISLAND_RESET_SP)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetFlags(arg_7_0)
	return {}
end

return var_0_0
