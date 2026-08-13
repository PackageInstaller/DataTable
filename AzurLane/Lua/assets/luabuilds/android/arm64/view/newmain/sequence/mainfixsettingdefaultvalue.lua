class = var_0_10000

local var_0_0 = var_0_10000("MainFixSettingDefaultValue")

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
	pg = var_2

	local var_2_0 = var_2.settings_other_template

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(var_2_0.all) do
		_G = var_1_10008
		var_1_10008 = var_1_10008[var_2_0[iter_2_1].name]

		local var_2_1 = var_2_0[iter_2_1].default

		noEmptyStr = var_1_10010

		if not var_1_10010(var_1_10008) then
			print = var_1_10010

			var_1_10010("settings_other_template without register this key:", var_2_0[iter_2_1].name)
		else
			PlayerPrefs = var_1_10010

			if not var_1_10010.HasKey(var_1_10008) then
				PlayerPrefs = var_1_10010

				var_1_10010.SetInt(var_1_10008, var_2_1)
			end
		end
	end

	arg_2_0:FixMainSceneSettings()

	PlayerPrefs = var_3

	var_3.Save()
	arg_2_0:FixPlayerPrefsKey()
	arg_2_1()

	return
end

function var_0_0.FixMainSceneSettings(arg_3_0)
	local var_3_0 = {}

	SettingsMainScenePanel = var_1_10002
	var_3_0[1] = var_1_10002.STANDBY_MODE_KEY
	SettingsMainScenePanel = var_2
	var_3_0[2] = var_2.FLAGSHIP_INTERACTION_KEY
	ipairs = var_2

	for iter_3_0, iter_3_1 in var_2(var_3_0) do
		local var_3_1 = iter_3_1
		local var_3_2 = "_"

		getProxy = var_1_10009
		PlayerProxy = var_1_10011
		var_1_10011 = var_1_10009(var_1_10011)

		local var_3_3 = var_3_1 .. var_3_2 .. var_1_10009.getRawData(var_1_10011).id

		PlayerPrefs = var_3_2

		if not var_3_2.HasKey(var_3_3) then
			PlayerPrefs = var_8

			var_8.SetInt(var_3_3, 1)
		end
	end

	return
end

function var_0_0.FixPlayerPrefsKey(arg_4_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.getRawData(var_4_0)
	local var_4_2 = "USAGE_NEW_MAINUI" .. var_4_1.id

	PlayerPrefs = USAGE_NEW_MAINUI

	local var_4_3 = var_2.HasKey

	USAGE_NEW_MAINUI = var_1_10004

	local var_4_4

	if not var_4_3(var_1_10004) then
		PlayerPrefs = var_4_4
		var_4_4 = var_4_4.GetInt
		USAGE_NEW_MAINUI = var_1_10004

		var_4_4(var_1_10004, 2)

		PlayerPrefs = var_4_4

		var_4_4.Save()
	end

	PlayerPrefs = var_4_4

	local var_4_5 = var_4_4.GetInt

	USAGE_NEW_MAINUI = var_1_10004

	local var_4_6 = var_4_5(var_1_10004, 1)

	pg = var_3

	local var_4_7 = var_3.GameTrackerMgr.GetInstance()
	local var_4_8 = var_3.Record

	GameTrackerBuilder = var_1_10006

	var_4_8(var_4_7, var_1_10006.BuildNewMainUI({
		isLogin = 1,
		isNewMainUI = var_4_6
	}))

	return
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.isExecute = false

	return
end

return var_0_0
