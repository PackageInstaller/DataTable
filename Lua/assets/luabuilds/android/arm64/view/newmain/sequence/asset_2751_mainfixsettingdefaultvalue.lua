local MainFixSettingDefaultValue = class("MainFixSettingDefaultValue")

function MainFixSettingDefaultValue:Ctor()
	self.isExecute = false

	return
end

function MainFixSettingDefaultValue:Execute(arg_2_1)
	if self.isExecute then
		arg_2_1()

		return
	end

	self.isExecute = true

	for iter_2_0, iter_2_1 in ipairs(pg.settings_other_template.all) do
		if not noEmptyStr(_G[pg.settings_other_template[iter_2_1].name]) then
			print("settings_other_template without register this key:", pg.settings_other_template[iter_2_1].name)
		elseif not PlayerPrefs.HasKey(_G[pg.settings_other_template[iter_2_1].name]) then
			PlayerPrefs.SetInt(_G[pg.settings_other_template[iter_2_1].name], pg.settings_other_template[iter_2_1].default)
		end
	end

	self:FixMainSceneSettings()
	PlayerPrefs.Save()
	self:FixPlayerPrefsKey()
	arg_2_1()

	return
end

function MainFixSettingDefaultValue:FixMainSceneSettings()
	for iter_3_0, iter_3_1 in ipairs({
		SettingsMainScenePanel.STANDBY_MODE_KEY,
		SettingsMainScenePanel.FLAGSHIP_INTERACTION_KEY
	}) do
		local var_3_0 = iter_3_1 .. "_" .. getProxy(PlayerProxy):getRawData().id

		if not PlayerPrefs.HasKey(var_3_0) then
			PlayerPrefs.SetInt(var_3_0, 1)
		end
	end

	return
end

function MainFixSettingDefaultValue:FixPlayerPrefsKey()
	USAGE_NEW_MAINUI = "USAGE_NEW_MAINUI" .. getProxy(PlayerProxy):getRawData().id

	local var_4_0

	if not PlayerPrefs.HasKey(USAGE_NEW_MAINUI) then
		PlayerPrefs.GetInt(USAGE_NEW_MAINUI, 2)
		PlayerPrefs.Save()

		var_4_0 = {
			isLogin = 1
		}
	end

	var_4_0.isNewMainUI = PlayerPrefs.GetInt(USAGE_NEW_MAINUI, 1)

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildNewMainUI(var_4_0))

	return
end

function MainFixSettingDefaultValue:Dispose()
	self.isExecute = false

	return
end

return MainFixSettingDefaultValue
