local var_0_0 = singletonClass("GameLocalData")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.json_ = require("cjson")
end

function var_0_0.GetCommonModule(arg_2_0, arg_2_1)
	local var_2_0 = PlayerPrefs.GetString(arg_2_1, "{}")

	return (arg_2_0.json_.decode(var_2_0))
end

function var_0_0.SaveToCommonModule(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = PlayerPrefs.GetString(arg_3_1, "{}")
	local var_3_1 = arg_3_0.json_.decode(var_3_0)

	var_3_1[arg_3_2] = arg_3_3

	local var_3_2 = arg_3_0.json_.encode(var_3_1)

	PlayerPrefs.SetString(arg_3_1, var_3_2)
end

function var_0_0.SaveCommonModule(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.json_.encode(arg_4_2)

	PlayerPrefs.SetString(arg_4_1, var_4_0)
end

function var_0_0.GetValueFromCommonModule(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetCommonModule(arg_5_1)[arg_5_2]

	if var_5_0 == nil then
		print("不存在的键名", arg_5_2)

		return
	end

	return var_5_0
end

function var_0_0.SaveUserSettingsData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:GetUserData()

	var_6_0[arg_6_1].userSettings[arg_6_2] = arg_6_3

	local var_6_1 = arg_6_0.json_.encode(var_6_0)

	PlayerPrefs.SetString("UserData", var_6_1)
end

function var_0_0.SaveTargetModule(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1 .. "_" .. PlayerPrefs.GetString("UserID")
	local var_7_1 = arg_7_0.json_.encode(arg_7_2)

	PlayerPrefs.SetString(var_7_0, var_7_1)
end

function var_0_0.GetUserData(arg_8_0)
	local var_8_0 = PlayerPrefs.GetString("UserData", "{}")

	return (arg_8_0.json_.decode(var_8_0))
end

function var_0_0.SaveUserInfoToUserData(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:GetUserData()

	var_9_0[arg_9_1] = arg_9_2

	local var_9_1 = arg_9_0.json_.encode(var_9_0)

	PlayerPrefs.SetString("UserData", var_9_1)
end

function var_0_0.SaveModuleNameToIndex(arg_10_0, arg_10_1)
	local var_10_0 = USER_ID
	local var_10_1 = "ModuleList_" .. var_10_0
	local var_10_2 = PlayerPrefs.GetString(var_10_1, "{}")
	local var_10_3 = arg_10_0.json_.decode(var_10_2)

	var_10_3[arg_10_1 .. "_" .. var_10_0] = 1

	local var_10_4 = arg_10_0.json_.encode(var_10_3)

	PlayerPrefs.SetString(var_10_1, var_10_4)
end

function var_0_0.GetTargetModule(arg_11_0, arg_11_1)
	local var_11_0 = USER_ID
	local var_11_1 = arg_11_1 .. "_" .. var_11_0

	if PlayerPrefs.HasKey(var_11_1) == false then
		arg_11_0:SaveModuleNameToIndex(arg_11_1)
	end

	local var_11_2 = PlayerPrefs.GetString(var_11_1, "{}")

	return (arg_11_0.json_.decode(var_11_2))
end

function var_0_0.SaveToTargetModule(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:GetTargetModule(arg_12_1)

	var_12_0[arg_12_2] = arg_12_3

	local var_12_1 = arg_12_1 .. "_" .. USER_ID
	local var_12_2 = arg_12_0.json_.encode(var_12_0)

	PlayerPrefs.SetString(var_12_1, var_12_2)
end

function var_0_0.GetValueFromTargetModule(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetTargetModule(arg_13_1)[arg_13_2]

	if var_13_0 == nil then
		return
	end

	return var_13_0
end

function var_0_0.ClearTargetUser(arg_14_0, arg_14_1)
	local var_14_0 = PlayerPrefs.GetString("UserData")
	local var_14_1 = arg_14_0.json_.decode(var_14_0)

	var_14_1[arg_14_1] = nil

	local var_14_2 = arg_14_0.json_.encode(var_14_1)

	PlayerPrefs.SetString("UserData", var_14_2)

	local var_14_3 = "ModuleList_" .. arg_14_1

	if PlayerPrefs.HasKey(var_14_3) == false then
		return
	end

	local var_14_4 = PlayerPrefs.GetString(var_14_3)
	local var_14_5 = arg_14_0.json_.decode(var_14_4)

	for iter_14_0, iter_14_1 in pairs(var_14_5) do
		PlayerPrefs.DeleteKey(iter_14_0)
	end

	PlayerPrefs.DeleteKey(var_14_3)
end

function var_0_0.ClearAllData(arg_15_0)
	PlayerPrefs.DeleteAll()
end

return var_0_0
