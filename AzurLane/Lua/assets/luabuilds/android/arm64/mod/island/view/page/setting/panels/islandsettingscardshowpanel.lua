local var_0_0 = class("IslandSettingsCardShowPanel", import("view.Setting.panels.SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandSettingsCardShow"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("grapihcs3d_setting_card_title")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / ISLAND CARD SETTINGS"
end

function var_0_0.InitTitle(arg_4_0)
	setText(arg_4_0._tf:Find("title/title_point/title_text"), arg_4_0:GetTitle())

	return
end

function var_0_0.OnInit(arg_5_0)
	arg_5_0.labelToggle = arg_5_0._tf:Find("options/label/toggle")
	arg_5_0.labelToggleCom = arg_5_0.labelToggle:GetComponent(typeof(Toggle))

	setText(arg_5_0._tf:Find("options/label/mask/Text"), i18n("grapihcs3d_setting_card_tag"))

	arg_5_0.socialToggle = arg_5_0._tf:Find("options/social/toggle")
	arg_5_0.socialToggleCom = arg_5_0.socialToggle:GetComponent(typeof(Toggle))

	setText(arg_5_0._tf:Find("options/social/mask/Text"), i18n("grapihcs3d_setting_card_socialdata"))

	return
end

function var_0_0.OnUpdate(arg_6_0)
	local var_6_0 = getProxy(IslandProxy):GetIsland():GetSettingsAgency()

	arg_6_0.labelFlag = var_6_0:GetFlagByType(IslandSettingsAgency.FLAG_TYPES.SHOW_CARD_LABEL)
	arg_6_0.socialFlag = var_6_0:GetFlagByType(IslandSettingsAgency.FLAG_TYPES.SHOW_CARD_SOCIAL)

	triggerToggle(arg_6_0.labelToggle, arg_6_0.labelFlag == 1)
	triggerToggle(arg_6_0.socialToggle, arg_6_0.socialFlag == 1)

	return
end

function var_0_0.GetFlags(arg_7_0)
	table.insert({}, {
		type = IslandSettingsAgency.FLAG_TYPES.SHOW_CARD_LABEL,
		flag = arg_7_0.labelToggleCom.isOn and 1 or 0
	})
	table.insert({}, {
		type = IslandSettingsAgency.FLAG_TYPES.SHOW_CARD_SOCIAL,
		flag = arg_7_0.socialToggleCom.isOn and 1 or 0
	})

	return {}
end

return var_0_0
