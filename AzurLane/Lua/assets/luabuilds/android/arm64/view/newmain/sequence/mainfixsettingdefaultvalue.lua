local var_0_0 = class("MainFixSettingDefaultValue")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.isExecute = false

	return
end

function var_0_0.Execute(arg_2_0, arg_2_1)
	if arg_2_0.isExecute then
		arg_2_1()

		return
	end

	arg_2_0.isExecute = true

	for iter_2_0, iter_2_1 in ipairs(pg.settings_other_template.all) do
		if not noEmptyStr(_G[pg.settings_other_template[iter_2_1].name]) then
			print("settings_other_template without register this key:", pg.settings_other_template[iter_2_1].name)
		elseif not PlayerPrefs.HasKey(_G[pg.settings_other_template[iter_2_1].name]) then
			PlayerPrefs.SetInt(_G[pg.settings_other_template[iter_2_1].name], pg.settings_other_template[iter_2_1].default)
		end
	end

	arg_2_0:FixMainSceneSettings()
	PlayerPrefs.Save()
	arg_2_0:FixPlayerPrefsKey()
	arg_2_1()

	return
end

function var_0_0.FixMainSceneSettings(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs({
		SettingsMainScenePanel.STANDBY_MODE_KEY,
		SettingsMainScenePanel.FLAGSHIP_INTERACTION_KEY
	}) do
		local var_3_0 = getProxy(PlayerProxy)
		local var_3_1 = iter_3_1 .. "_" .. var_3_0:getRawData().id

		if not PlayerPrefs.HasKey(var_3_1) then
			PlayerPrefs.SetInt(var_3_1, 1)
		end
	end

	return
end

function var_0_0.FixPlayerPrefsKey(arg_4_0)
	USAGE_NEW_MAINUI = "USAGE_NEW_MAINUI" .. getProxy(PlayerProxy):getRawData().id

	if not PlayerPrefs.HasKey(USAGE_NEW_MAINUI) then
		PlayerPrefs.GetInt(USAGE_NEW_MAINUI, 2)
		PlayerPrefs.Save()
	end

	;({
		isLogin = 1
	}).isNewMainUI = PlayerPrefs.GetInt(USAGE_NEW_MAINUI, 1)

	pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildNewMainUI({
		isLogin = 1
	}))

	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.isExecute = false

	return
end

return var_0_0
