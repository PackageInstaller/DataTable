class = var_0_10000

local var_0_0 = "SettingsWorldPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsWorld"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("world_setting_title")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / OPERATION SETTINGS"
end

function var_0_1.OnInit(arg_4_0)
	UIItemList = var_1_10001

	local var_4_0 = var_1_10001.New
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "options")
	local var_4_3 = arg_4_0._tf

	arg_4_0.uilist = var_4_0(var_4_2, var_4.Find(var_4_3, "options/notify_tpl"))

	local var_4_4 = arg_4_0.uilist

	var_1.make(var_4_4, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0

			var_3.UpdateItem(var_5_0, arg_5_1 + 1, arg_5_2)
		end

		return
	end)

	findTF = var_1
	arg_4_0.worldbossProgressTip = var_1(arg_4_0._tf, "world_boss")

	return
end

function var_0_1.UpdateItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.list[arg_6_1]
	local var_6_1 = arg_6_2:Find("mask/Text")
	local var_6_2 = var_4.GetComponent(var_6_1, "ScrollText")

	var_4.SetText(var_6_2, var_6_0.title)

	onButton = var_5

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_2
	local var_6_5 = arg_6_2.Find(var_6_4, "mask/Text")

	local function var_6_6()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		NewSettingsMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.SHOW_DESC, var_6_0)

		return
	end

	SFX_PANEL = var_6_4

	var_5(var_6_3, var_6_5, var_6_6, var_6_4)

	removeOnToggle = var_5

	var_5(arg_6_2:Find("on"))

	if arg_6_0:GetDefaultValue(var_6_0) then
		triggerToggle = var_5

		var_5(arg_6_2:Find("on"), true)
	else
		triggerToggle = var_5

		var_5(arg_6_2:Find("off"), true)
	end

	onToggle = var_5

	local var_6_7 = arg_6_0
	local var_6_8 = arg_6_2
	local var_6_9 = arg_6_2.Find(var_6_8, "on")

	local function var_6_10(arg_8_0)
		local var_8_0 = arg_6_0

		var_1.OnItemSwitch(var_8_0, var_6_0, arg_8_0)

		return
	end

	SFX_UI_TAG = var_6_8
	SFX_UI_CANCEL = var_11

	var_5(var_6_7, var_6_9, var_6_10, var_6_8, var_11)

	return
end

function var_0_1.OnItemSwitch(arg_9_0, arg_9_1, arg_9_2)
	getProxy = var_1_10003
	SettingsProxy = var_1_10005

	local var_9_0 = var_1_10003(var_1_10005)

	var_3.SetWorldFlag(var_9_0, arg_9_1.key, arg_9_2)

	return
end

function var_0_1.GetDefaultValue(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10004

	local var_10_0 = var_1_10002(var_1_10004)

	return var_2.GetWorldFlag(var_10_0, arg_10_1.key)
end

function var_0_1.GetList(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {
		key = "story_tips"
	}

	i18n = var_1_10003
	var_11_1.title = var_1_10003("world_setting_quickmode")
	i18n = var_3
	var_11_1.desc = var_3("world_setting_quickmodetip")
	var_11_0[1] = var_11_1

	local var_11_2 = {
		key = "consume_item"
	}

	i18n = var_3
	var_11_2.title = var_3("world_setting_submititem")
	i18n = var_3
	var_11_2.desc = var_3("world_setting_submititemtip")
	var_11_0[2] = var_11_2

	local var_11_3 = {
		key = "auto_save_area"
	}

	i18n = var_3
	var_11_3.title = var_3("world_setting_mapauto")
	i18n = var_3
	var_11_3.desc = var_3("world_setting_mapautotip")
	var_11_0[3] = var_11_3

	return var_11_0
end

function var_0_1.DisplayWorldBossProgressTipSettings(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.NewStoryMgr.GetInstance()
	local var_12_1 = var_1.IsPlayed(var_12_0, "WorldG190")

	setActive = var_1_10002

	var_1_10002(arg_12_0.worldbossProgressTip, var_12_1)

	if var_12_1 then
		arg_12_0:InitWorldBossProgressTipSettings()
	end

	return
end

function var_0_1.InitWorldBossProgressTipSettings(arg_13_0)
	local var_13_0 = arg_13_0.worldbossProgressTip
	local var_13_1 = arg_13_0:GetWorldBossProgressTipConfig()

	getProxy = var_1_10003
	SettingsProxy = var_1_10005

	local var_13_2 = var_1_10003(var_1_10005)
	local var_13_3 = var_3.GetWorldBossProgressTipFlag(var_13_2)

	local function var_13_4(arg_14_0, arg_14_1)
		tostring = var_2_10002

		local var_14_0 = var_2_10002(var_13_1[arg_14_0])

		onToggle = var_2_10003

		local var_14_1 = arg_13_0
		local var_14_2 = arg_14_1

		local function var_14_3(arg_15_0)
			if arg_15_0 then
				getProxy = var_3_10001
				SettingsProxy = var_3_10003

				local var_15_0 = var_3_10001(var_3_10003)

				var_1.WorldBossProgressTipFlag(var_15_0, var_14_0)
			end

			return
		end

		SFX_PANEL = var_2_10008

		var_2_10003(var_14_1, var_14_2, var_14_3, var_2_10008)

		if var_14_0 == var_13_3 then
			triggerToggle = var_3

			var_3(arg_14_1, true)
		end

		return
	end

	local var_13_5 = var_13_0:Find("notify_tpl")
	local var_13_6 = var_5.Find(var_13_5, "mask/Text")
	local var_13_7 = var_6.GetComponent(var_13_6, "ScrollText")
	local var_13_8 = var_6.SetText

	i18n = var_1_10010

	var_13_8(var_13_7, var_1_10010("world_boss_progress_tip_title"))

	for iter_13_0 = 1, #var_13_1 do
		local var_13_9 = var_13_4
		local var_13_10 = iter_13_0
		local var_13_11 = var_5
		local var_13_12 = var_5.Find

		tostring = var_1_10017

		var_13_9(var_13_10, var_13_12(var_13_11, var_1_10017(iter_13_0)))
	end

	onButton = var_7

	local var_13_13 = arg_13_0
	local var_13_14 = var_5
	local var_13_15 = var_5.Find(var_13_14, "mask/Text")

	local function var_13_16()
		pg = var_2_10000

		local var_16_0 = var_2_10000.m02
		local var_16_1 = var_0.sendNotification

		NewSettingsMediator = var_2_10003

		local var_16_2 = var_2_10003.SHOW_DESC
		local var_16_3 = {}

		i18n = var_2_10005
		var_16_3.desc = var_2_10005("world_boss_progress_tip_desc")

		var_16_1(var_16_0, var_16_2, var_16_3)

		return
	end

	SFX_PANEL = var_13_14

	var_7(var_13_13, var_13_15, var_13_16, var_13_14)

	return
end

function var_0_1.GetWorldBossProgressTipConfig(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.gameset.joint_boss_ticket.description
	local var_17_1 = {}

	table = var_1_10003

	var_1_10003.insert(var_17_1, "")

	local var_17_2 = var_17_0[1] + var_17_0[2]

	table = var_4

	var_4.insert(var_17_1, var_17_0[1] .. "&" .. var_17_2)

	table = var_4

	var_4.insert(var_17_1, var_17_2)

	return var_17_1
end

function var_0_1.OnUpdate(arg_18_0)
	arg_18_0.list = arg_18_0:GetList()

	local var_18_0 = arg_18_0.uilist

	var_1.align(var_18_0, #arg_18_0.list)
	arg_18_0:DisplayWorldBossProgressTipSettings()

	return
end

return var_0_1
