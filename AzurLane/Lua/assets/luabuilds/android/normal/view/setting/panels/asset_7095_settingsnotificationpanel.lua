class = var_0_10000

local var_0_0 = "SettingsNotificationPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsBasePanel"))

var_0_1.UPDATE_ALARM_PANEL = "SettingsNotificationPanel.UPDATE_ALARM_PANEL"

function var_0_1.GetUIName(arg_1_0)
	return "SettingsNotifications"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_Notification")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / ENABLE NOTIFICATIONS"
end

function var_0_1.OnInit(arg_4_0)
	UIItemList = var_1_10001

	local var_4_0 = var_1_10001.New
	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_2.Find(var_4_1, "options")
	local var_4_3 = arg_4_0._tf

	arg_4_0.uilist = var_4_0(var_4_2, var_3.Find(var_4_3, "options/notify_tpl"))

	local var_4_4 = arg_4_0.uilist

	var_1.make(var_4_4, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0

			var_3.UpdateItem(var_5_0, arg_5_1 + 1, arg_5_2)
		end

		return
	end)
	arg_4_0:UpdateAndroidAlarm()

	return
end

function var_0_1.UpdateAndroidAlarm(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.alarmBtn = var_1.Find(var_6_0, "android_alarm_btn")

	local var_6_1 = arg_6_0._tf

	arg_6_0.alarmPanel = var_1.Find(var_6_1, "android_alarm_panel")
	PermissionHelper = var_1

	local var_6_2 = var_1.IsAndroid()

	YSNormalTool = var_6_1

	local var_6_3 = var_6_1.NotificationTool.CanScheduleExactAlarms()

	if var_6_2 then
		LOCK_ANDROID_EXACT_ALARM = var_3

		if var_3 then
			setActive = var_3

			var_3(arg_6_0.alarmBtn, false)

			setActive = var_3

			var_3(arg_6_0.alarmPanel, false)
		elseif not var_6_3 then
			setActive = var_3

			var_3(arg_6_0.alarmBtn, true)

			setActive = var_3

			var_3(arg_6_0.alarmPanel, true)

			local var_6_4 = arg_6_0.alarmPanel

			arg_6_0.alarmPanelTipText = var_3.Find(var_6_4, "tip/Text")
			setText = var_3

			local var_6_5 = arg_6_0.alarmPanelTipText

			i18n = var_5

			var_3(var_6_5, var_5("notify_clock_tip"))

			onButton = var_3

			local var_6_6 = arg_6_0
			local var_6_7 = arg_6_0.alarmBtn

			local function var_6_8()
				YSNormalTool = var_2_10000

				var_2_10000.NotificationTool.RequestScheduleExactAlarmsPermission()

				return
			end

			SFX_PANEL = var_1_10007

			var_3(var_6_6, var_6_7, var_6_8, var_1_10007)
		else
			setActive = var_3

			var_3(arg_6_0.alarmBtn, false)

			setActive = var_3

			var_3(arg_6_0.alarmPanel, false)
		end

		return
	end
end

function var_0_1.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.list[arg_8_1]
	local var_8_1 = arg_8_2:Find("mask/Text")
	local var_8_2 = var_4.GetComponent(var_8_1, "ScrollText")

	var_4.SetText(var_8_2, var_8_0.title)

	onButton = var_5

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_2:Find("mask/Text")

	local function var_8_5()
		pg = var_2_10000

		local var_9_0 = var_2_10000.m02
		local var_9_1 = var_0.sendNotification

		NewSettingsMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.SHOW_DESC, var_8_0)

		return
	end

	SFX_PANEL = var_9

	var_5(var_8_3, var_8_4, var_8_5, var_9)

	removeOnToggle = var_5

	var_5(arg_8_2:Find("on"))

	if arg_8_0:GetDefaultValue(var_8_0) then
		triggerToggle = var_5

		var_5(arg_8_2:Find("on"), true)
	else
		triggerToggle = var_5

		var_5(arg_8_2:Find("off"), true)
	end

	onToggle = var_5

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_2:Find("on")

	local function var_8_8(arg_10_0)
		local var_10_0 = arg_8_0

		var_1.OnItemSwitch(var_10_0, var_8_0, arg_10_0)

		return
	end

	SFX_UI_TAG = var_9
	SFX_UI_CANCEL = var_1_10010

	var_5(var_8_6, var_8_7, var_8_8, var_9, var_1_10010)
	arg_8_0:OnUpdateItem(var_8_0)
	arg_8_0:OnUpdateItemWithTr(var_8_0, arg_8_2)

	return
end

function var_0_1.OnUpdateItem(arg_11_0, arg_11_1)
	return
end

function var_0_1.OnUpdateItemWithTr(arg_12_0, arg_12_1, arg_12_2)
	return
end

function var_0_1.OnItemSwitch(arg_13_0, arg_13_1, arg_13_2)
	pg = var_1_10003

	local var_13_0 = var_1_10003.PushNotificationMgr.GetInstance()

	var_3.setSwitch(var_13_0, arg_13_1.id, arg_13_2)

	return
end

function var_0_1.GetDefaultValue(arg_14_0, arg_14_1)
	pg = var_1_10002

	local var_14_0 = var_1_10002.PushNotificationMgr.GetInstance()

	return var_2.isEnabled(var_14_0, arg_14_1.id)
end

function var_0_1.GetList(arg_15_0)
	local var_15_0 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_15_0, iter_15_1 in var_1_10002(var_1_10003.push_data_template.all) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_15_1 = var_15_0

		pg = var_1_10009

		var_1_10007(var_15_1, var_1_10009.push_data_template[iter_15_1])
	end

	return var_15_0
end

function var_0_1.OnUpdate(arg_16_0)
	arg_16_0.list = arg_16_0:GetList()

	local var_16_0 = arg_16_0.uilist

	var_1.align(var_16_0, #arg_16_0.list)

	return
end

return var_0_1
