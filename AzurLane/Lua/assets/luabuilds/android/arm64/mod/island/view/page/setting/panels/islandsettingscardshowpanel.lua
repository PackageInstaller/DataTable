class = var_0_10000

local var_0_0 = "IslandSettingsCardShowPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.Setting.panels.SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandSettingsCardShow"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("grapihcs3d_setting_card_title")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / ISLAND CARD SETTINGS"
end

function var_0_1.InitTitle(arg_4_0)
	setText = var_1_10001

	local var_4_0 = arg_4_0._tf

	var_1_10001(var_3.Find(var_4_0, "title/title_point/title_text"), arg_4_0:GetTitle())

	return
end

function var_0_1.OnInit(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.labelToggle = var_1.Find(var_5_0, "options/label/toggle")

	local var_5_1 = arg_5_0.labelToggle
	local var_5_2 = var_1.GetComponent

	typeof = var_4
	Toggle = var_1_10006
	arg_5_0.labelToggleCom = var_5_2(var_5_1, var_4(var_1_10006))
	setText = var_1

	local var_5_3 = arg_5_0._tf
	local var_5_4 = var_3.Find(var_5_3, "options/label/mask/Text")

	i18n = var_4

	var_1(var_5_4, var_4("grapihcs3d_setting_card_tag"))

	local var_5_5 = arg_5_0._tf

	arg_5_0.socialToggle = var_1.Find(var_5_5, "options/social/toggle")

	local var_5_6 = arg_5_0.socialToggle
	local var_5_7 = var_1.GetComponent

	typeof = var_4
	Toggle = var_6
	arg_5_0.socialToggleCom = var_5_7(var_5_6, var_4(var_6))
	setText = var_1

	local var_5_8 = arg_5_0._tf
	local var_5_9 = var_3.Find(var_5_8, "options/social/mask/Text")

	i18n = var_4

	var_1(var_5_9, var_4("grapihcs3d_setting_card_socialdata"))

	return
end

function var_0_1.OnUpdate(arg_6_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.GetIsland(var_6_0)
	local var_6_2 = var_1.GetSettingsAgency(var_6_1)
	local var_6_3 = var_1.GetFlagByType

	IslandSettingsAgency = var_1_10005
	arg_6_0.labelFlag = var_6_3(var_6_2, var_1_10005.FLAG_TYPES.SHOW_CARD_LABEL)

	local var_6_4 = var_1
	local var_6_5 = var_1.GetFlagByType

	IslandSettingsAgency = var_5
	arg_6_0.socialFlag = var_6_5(var_6_4, var_5.FLAG_TYPES.SHOW_CARD_SOCIAL)
	triggerToggle = var_2

	var_2(arg_6_0.labelToggle, arg_6_0.labelFlag == 1)

	triggerToggle = var_2

	var_2(arg_6_0.socialToggle, arg_6_0.socialFlag == 1)

	return
end

function var_0_1.GetFlags(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = arg_7_0.labelToggleCom.isOn and 1 or 0

	table = var_1_10003

	local var_7_2 = var_1_10003.insert
	local var_7_3 = var_7_0
	local var_7_4 = {}

	IslandSettingsAgency = var_1_10007
	var_7_4.type = var_1_10007.FLAG_TYPES.SHOW_CARD_LABEL
	var_7_4.flag = var_7_1

	var_7_2(var_7_3, var_7_4)

	local var_7_5 = arg_7_0.socialToggleCom.isOn and 1 or 0

	table = var_1_10004

	local var_7_6 = var_1_10004.insert
	local var_7_7 = var_7_0
	local var_7_8 = {}

	IslandSettingsAgency = var_1_10008
	var_7_8.type = var_1_10008.FLAG_TYPES.SHOW_CARD_SOCIAL
	var_7_8.flag = var_7_5

	var_7_6(var_7_7, var_7_8)

	return var_7_0
end

return var_0_1
