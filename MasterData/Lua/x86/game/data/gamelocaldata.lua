local var_0_0 = singletonClass("GameLocalData")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.json_ = require("cjson")
end

function var_0_0:GetCommonModule(arg_2_1)
	return (self.json_.decode((PlayerPrefs.GetString(arg_2_1, "{}"))))
end

function var_0_0:SaveToCommonModule(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = self.json_.decode((PlayerPrefs.GetString(arg_3_1, "{}")))

	var_3_0[arg_3_2] = arg_3_3

	PlayerPrefs.SetString(arg_3_1, (self.json_.encode(var_3_0)))
end

function var_0_0:SaveCommonModule(arg_4_1, arg_4_2)
	PlayerPrefs.SetString(arg_4_1, (self.json_.encode(arg_4_2)))
end

function var_0_0:GetValueFromCommonModule(arg_5_1, arg_5_2)
	local var_5_0 = self:GetCommonModule(arg_5_1)[arg_5_2]

	if var_5_0 == nil then
		print("不存在的键名", arg_5_2)

		return
	end

	return var_5_0
end

function var_0_0:SaveUserSettingsData(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = self:GetUserData()

	var_6_0[arg_6_1].userSettings[arg_6_2] = arg_6_3

	PlayerPrefs.SetString("UserData", (self.json_.encode(var_6_0)))
end

function var_0_0:SaveTargetModule(arg_7_1, arg_7_2)
	PlayerPrefs.SetString(arg_7_1 .. "_" .. PlayerPrefs.GetString("UserID"), (self.json_.encode(arg_7_2)))
end

function var_0_0:GetUserData()
	return (self.json_.decode((PlayerPrefs.GetString("UserData", "{}"))))
end

function var_0_0:SaveUserInfoToUserData(arg_9_1, arg_9_2)
	local var_9_0 = self:GetUserData()

	var_9_0[arg_9_1] = arg_9_2

	PlayerPrefs.SetString("UserData", (self.json_.encode(var_9_0)))
end

function var_0_0:SaveModuleNameToIndex(arg_10_1)
	local var_10_0 = self.json_.decode((PlayerPrefs.GetString("ModuleList_" .. USER_ID, "{}")))

	var_10_0[arg_10_1 .. "_" .. USER_ID] = 1

	PlayerPrefs.SetString("ModuleList_" .. USER_ID, (self.json_.encode(var_10_0)))
end

function var_0_0:GetTargetModule(arg_11_1)
	if PlayerPrefs.HasKey(arg_11_1 .. "_" .. USER_ID) == false then
		self:SaveModuleNameToIndex(arg_11_1)
	end

	return (self.json_.decode((PlayerPrefs.GetString(arg_11_1 .. "_" .. USER_ID, "{}"))))
end

function var_0_0:SaveToTargetModule(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = self:GetTargetModule(arg_12_1)

	var_12_0[arg_12_2] = arg_12_3

	PlayerPrefs.SetString(arg_12_1 .. "_" .. USER_ID, (self.json_.encode(var_12_0)))
end

function var_0_0:GetValueFromTargetModule(arg_13_1, arg_13_2)
	local var_13_0 = self:GetTargetModule(arg_13_1)[arg_13_2]

	if var_13_0 == nil then
		return
	end

	return var_13_0
end

function var_0_0:ClearTargetUser(arg_14_1)
	local var_14_0 = self.json_.decode((PlayerPrefs.GetString("UserData")))

	var_14_0[arg_14_1] = nil

	PlayerPrefs.SetString("UserData", (self.json_.encode(var_14_0)))

	if PlayerPrefs.HasKey("ModuleList_" .. arg_14_1) == false then
		return
	end

	for iter_14_0, iter_14_1 in pairs((self.json_.decode((PlayerPrefs.GetString("ModuleList_" .. arg_14_1))))) do
		PlayerPrefs.DeleteKey(iter_14_0)
	end

	PlayerPrefs.DeleteKey("ModuleList_" .. arg_14_1)
end

function var_0_0.ClearAllData(arg_15_0)
	PlayerPrefs.DeleteAll()
end

return var_0_0
