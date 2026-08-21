local var_0_0 = class("SettingsNotificationPanel", import(".SettingsBasePanel"))

var_0_0.UPDATE_ALARM_PANEL = "SettingsNotificationPanel.UPDATE_ALARM_PANEL"

function var_0_0.GetUIName(arg_1_0)
	return "SettingsNotifications"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_Notification")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / ENABLE NOTIFICATIONS"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.uilist = UIItemList.New(arg_4_0._tf:Find("options"), arg_4_0._tf:Find("options/notify_tpl"))

	arg_4_0.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			arg_4_0:UpdateItem(arg_5_1 + 1, arg_5_2)
		end

		return
	end)
	arg_4_0:UpdateAndroidAlarm()

	return
end

function var_0_0.UpdateAndroidAlarm(arg_6_0)
	arg_6_0.alarmBtn = arg_6_0._tf:Find("android_alarm_btn")
	arg_6_0.alarmPanel = arg_6_0._tf:Find("android_alarm_panel")

	if not PermissionHelper.IsAndroid() or LOCK_ANDROID_EXACT_ALARM then
		setActive(arg_6_0.alarmBtn, false)
		setActive(arg_6_0.alarmPanel, false)
	elseif not YSNormalTool.NotificationTool.CanScheduleExactAlarms() then
		setActive(arg_6_0.alarmBtn, true)
		setActive(arg_6_0.alarmPanel, true)

		arg_6_0.alarmPanelTipText = arg_6_0.alarmPanel:Find("tip/Text")

		setText(arg_6_0.alarmPanelTipText, i18n("notify_clock_tip"))
		onButton(arg_6_0, arg_6_0.alarmBtn, function()
			YSNormalTool.NotificationTool.RequestScheduleExactAlarmsPermission()

			return
		end, SFX_PANEL)
	else
		setActive(arg_6_0.alarmBtn, false)
		setActive(arg_6_0.alarmPanel, false)
	end

	return
end

function var_0_0.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.list[arg_8_1]

	arg_8_2:Find("mask/Text"):GetComponent("ScrollText"):SetText(arg_8_0.list[arg_8_1].title)
	onButton(arg_8_0, arg_8_2:Find("mask/Text"), function()
		pg.m02:sendNotification(NewSettingsMediator.SHOW_DESC, var_8_0)

		return
	end, SFX_PANEL)
	removeOnToggle(arg_8_2:Find("on"))

	if arg_8_0:GetDefaultValue(var_8_0) then
		triggerToggle(arg_8_2:Find("on"), true)
	else
		triggerToggle(arg_8_2:Find("off"), true)
	end

	onToggle(arg_8_0, arg_8_2:Find("on"), function(arg_10_0)
		arg_8_0:OnItemSwitch(var_8_0, arg_10_0)

		return
	end, SFX_UI_TAG, SFX_UI_CANCEL)
	arg_8_0:OnUpdateItem(var_8_0)
	arg_8_0:OnUpdateItemWithTr(var_8_0, arg_8_2)

	return
end

function var_0_0.OnUpdateItem(arg_11_0, arg_11_1)
	return
end

function var_0_0.OnUpdateItemWithTr(arg_12_0, arg_12_1, arg_12_2)
	return
end

function var_0_0.OnItemSwitch(arg_13_0, arg_13_1, arg_13_2)
	pg.PushNotificationMgr.GetInstance():setSwitch(arg_13_1.id, arg_13_2)

	return
end

function var_0_0.GetDefaultValue(arg_14_0, arg_14_1)
	return pg.PushNotificationMgr.GetInstance():isEnabled(arg_14_1.id)
end

function var_0_0.GetList(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(pg.push_data_template.all) do
		table.insert({}, pg.push_data_template[iter_15_1])
	end

	return {}
end

function var_0_0.OnUpdate(arg_16_0)
	arg_16_0.list = arg_16_0:GetList()

	arg_16_0.uilist:align(#arg_16_0.list)

	return
end

return var_0_0
