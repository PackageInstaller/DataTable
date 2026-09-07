local SettingsNotificationPanel = class("SettingsNotificationPanel", import(".SettingsBasePanel"))

SettingsNotificationPanel.UPDATE_ALARM_PANEL = "SettingsNotificationPanel.UPDATE_ALARM_PANEL"

function SettingsNotificationPanel:GetUIName()
	return "SettingsNotifications"
end

function SettingsNotificationPanel:GetTitle()
	return i18n("Settings_title_Notification")
end

function SettingsNotificationPanel:GetTitleEn()
	return "  / ENABLE NOTIFICATIONS"
end

function SettingsNotificationPanel:OnInit()
	self.uilist = UIItemList.New(self._tf:Find("options"), self._tf:Find("options/notify_tpl"))

	self.uilist:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			self:UpdateItem(arg_5_1 + 1, arg_5_2)
		end

		return
	end)
	self:UpdateAndroidAlarm()

	return
end

function SettingsNotificationPanel:UpdateAndroidAlarm()
	self.alarmBtn = self._tf:Find("android_alarm_btn")
	self.alarmPanel = self._tf:Find("android_alarm_panel")

	if not PermissionHelper.IsAndroid() or LOCK_ANDROID_EXACT_ALARM then
		setActive(self.alarmBtn, false)
		setActive(self.alarmPanel, false)
	elseif not YSNormalTool.NotificationTool.CanScheduleExactAlarms() then
		setActive(self.alarmBtn, true)
		setActive(self.alarmPanel, true)

		self.alarmPanelTipText = self.alarmPanel:Find("tip/Text")

		setText(self.alarmPanelTipText, i18n("notify_clock_tip"))
		onButton(self, self.alarmBtn, function()
			YSNormalTool.NotificationTool.RequestScheduleExactAlarmsPermission()

			return
		end, SFX_PANEL)
	else
		setActive(self.alarmBtn, false)
		setActive(self.alarmPanel, false)
	end

	return
end

function SettingsNotificationPanel:UpdateItem(arg_8_1, arg_8_2)
	local var_8_0 = self.list[arg_8_1]

	arg_8_2:Find("mask/Text"):GetComponent("ScrollText"):SetText(self.list[arg_8_1].title)
	onButton(self, arg_8_2:Find("mask/Text"), function()
		pg.m02:sendNotification(NewSettingsMediator.SHOW_DESC, var_8_0)

		return
	end, SFX_PANEL)
	removeOnToggle(arg_8_2:Find("on"))

	if self:GetDefaultValue(var_8_0) then
		triggerToggle(arg_8_2:Find("on"), true)
	else
		triggerToggle(arg_8_2:Find("off"), true)
	end

	onToggle(self, arg_8_2:Find("on"), function(arg_10_0)
		self:OnItemSwitch(var_8_0, arg_10_0)

		return
	end, SFX_UI_TAG, SFX_UI_CANCEL)
	self:OnUpdateItem(var_8_0)
	self:OnUpdateItemWithTr(var_8_0, arg_8_2)

	return
end

function SettingsNotificationPanel:OnUpdateItem(arg_11_1)
	return
end

function SettingsNotificationPanel:OnUpdateItemWithTr(arg_12_1, arg_12_2)
	return
end

function SettingsNotificationPanel:OnItemSwitch(arg_13_1, arg_13_2)
	pg.PushNotificationMgr.GetInstance():setSwitch(arg_13_1.id, arg_13_2)

	return
end

function SettingsNotificationPanel:GetDefaultValue(arg_14_1)
	return pg.PushNotificationMgr.GetInstance():isEnabled(arg_14_1.id)
end

function SettingsNotificationPanel:GetList()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(pg.push_data_template.all) do
		table.insert(var_15_0, pg.push_data_template[iter_15_1])
	end

	return var_15_0
end

function SettingsNotificationPanel:OnUpdate()
	self.list = self:GetList()

	self.uilist:align(#self.list)

	return
end

return SettingsNotificationPanel
