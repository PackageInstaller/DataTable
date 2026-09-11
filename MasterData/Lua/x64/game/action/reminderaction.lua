local var_0_0 = {}

manager.net:Bind(21001, function(arg_1_0)
	SettingAction.ChangeRemindSetting("activity_sign_reminder", arg_1_0.setting.sign_in_propel_switch)
	SettingAction.ChangeRemindSetting("month_card_reminder", arg_1_0.setting.month_card_propel_switch)
end)

function var_0_0:SettingMotify(arg_2_1, arg_2_2)
	manager.net:SendWithLoadingNew(21012, {
		setting = {
			sign_in_propel_switch = arg_2_1,
			month_card_propel_switch = arg_2_2
		}
	}, 21013, handler(self, self.OnSettingMotify))
end

function var_0_0.OnSettingMotify(arg_3_0, arg_3_1, arg_3_2)
	if isSuccess(arg_3_1.result) then
		SettingAction.ChangeRemindSetting("activity_sign_reminder", arg_3_2.setting.sign_in_propel_switch)
		SettingAction.ChangeRemindSetting("month_card_reminder", arg_3_2.setting.month_card_propel_switch)
	else
		ShowTips(arg_3_1.result)
	end
end

return var_0_0
