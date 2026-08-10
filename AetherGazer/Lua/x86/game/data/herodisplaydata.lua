local var_0_0 = singletonClass("HeroDisplayData")
local var_0_1 = require("cjson")

function var_0_0.Init(arg_1_0)
	local var_1_0 = getData("HeroDisplay", "settingProfile")

	if var_1_0 == nil then
		arg_1_0.settingProfile_ = {
			cardShowUID = true,
			cardShowLv = true,
			logoPos = 0,
			cardPos = 1,
			cardShow = true
		}
	else
		arg_1_0.settingProfile_ = var_1_0
	end

	arg_1_0.heroExpressionParams_ = {}
	arg_1_0.heroCustomExpression_ = {}
	arg_1_0.heroPoseList_ = {}
end

function var_0_0.SaveSetting(arg_2_0, arg_2_1)
	arg_2_0.settingProfile_.logoPos = arg_2_1.logoPos
	arg_2_0.settingProfile_.cardPos = arg_2_1.cardPos
	arg_2_0.settingProfile_.cardShow = arg_2_1.cardShow
	arg_2_0.settingProfile_.cardShowLv = arg_2_1.cardShowLv
	arg_2_0.settingProfile_.cardShowUID = arg_2_1.cardShowUID

	saveData("HeroDisplay", "settingProfile", arg_2_0.settingProfile_)
end

function var_0_0.GetSetting(arg_3_0)
	return arg_3_0.settingProfile_
end

function var_0_0.GetCustomExpressionParams(arg_4_0, arg_4_1)
	if arg_4_0.heroCustomExpression_[arg_4_1] == nil then
		local var_4_0 = getData("HeroDisplay", "expressionParams" .. arg_4_1)

		if var_4_0 then
			arg_4_0.heroCustomExpression_[arg_4_1] = var_4_0
		else
			arg_4_0.heroCustomExpression_[arg_4_1] = {}
		end
	end

	return arg_4_0.heroCustomExpression_[arg_4_1]
end

function var_0_0.AddCustomExpressionParams(arg_5_0, arg_5_1, arg_5_2)
	table.insert(arg_5_0.heroCustomExpression_[arg_5_1], arg_5_2)
	saveData("HeroDisplay", "expressionParams" .. arg_5_1, arg_5_0.heroCustomExpression_[arg_5_1])
end

function var_0_0.ReplaceCustomExpressionParams(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.heroCustomExpression_[arg_6_1][arg_6_2] = arg_6_3

	saveData("HeroDisplay", "expressionParams" .. arg_6_1, arg_6_0.heroCustomExpression_[arg_6_1])
end

function var_0_0.DeleteCustomExpressionParams(arg_7_0, arg_7_1, arg_7_2)
	table.remove(arg_7_0.heroCustomExpression_[arg_7_1], arg_7_2)
	saveData("HeroDisplay", "expressionParams" .. arg_7_1, arg_7_0.heroCustomExpression_[arg_7_1])
end

function var_0_0.InitPreset(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.heroExpressionParams_[arg_8_1] = {}
	arg_8_0.heroExpressionParams_[arg_8_1][1] = {
		preset = true,
		effectID = 0,
		name = GetTips("DEFAULT_PRESET"),
		values = arg_8_2
	}

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
		var_8_0[iter_8_0] = 0
	end

	arg_8_0.heroExpressionParams_[arg_8_1][2] = {
		preset = true,
		effectID = 0,
		name = GetTips("INIT_PRESET"),
		values = var_8_0
	}

	local var_8_1 = HeroDisplayCfg[arg_8_1]

	for iter_8_2, iter_8_3 in ipairs(var_8_1.skinMeshPresetName) do
		table.insert(arg_8_0.heroExpressionParams_[arg_8_1], {
			preset = true,
			name = iter_8_3,
			values = var_8_1.skinMeshPresetValue[iter_8_2],
			effectID = var_8_1.skinMeshPresetEffect[iter_8_2] or 0
		})
	end

	local var_8_2 = arg_8_0:GetCustomExpressionParams(arg_8_1)

	for iter_8_4, iter_8_5 in ipairs(var_8_2) do
		table.insert(arg_8_0.heroExpressionParams_[arg_8_1], iter_8_5)
	end
end

function var_0_0.GetHeroExpressionParams(arg_9_0, arg_9_1)
	return arg_9_0.heroExpressionParams_[arg_9_1]
end

function var_0_0.ReplaceHeroExpressionParams(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.heroExpressionParams_[arg_10_1][arg_10_2] = arg_10_3

	local var_10_0 = arg_10_2 - arg_10_0:GetCustomStartIndex(arg_10_1)

	arg_10_0:ReplaceCustomExpressionParams(arg_10_1, var_10_0, arg_10_3)
end

function var_0_0.SaveHeroExpressionParams(arg_11_0, arg_11_1, arg_11_2)
	table.insert(arg_11_0.heroExpressionParams_[arg_11_1], arg_11_2)
	arg_11_0:AddCustomExpressionParams(arg_11_1, arg_11_2)
end

function var_0_0.DeleteHeroExpressionParams(arg_12_0, arg_12_1, arg_12_2)
	table.remove(arg_12_0.heroExpressionParams_[arg_12_1], arg_12_2)

	local var_12_0 = arg_12_2 - arg_12_0:GetCustomStartIndex(arg_12_1)

	arg_12_0:DeleteCustomExpressionParams(arg_12_1, var_12_0)
end

function var_0_0.GetCustomStartIndex(arg_13_0, arg_13_1)
	return #HeroDisplayCfg[arg_13_1].skinMeshPresetName + 2
end

function var_0_0.InitCacheExpressionParams(arg_14_0, arg_14_1)
	arg_14_0.cacheExpressionParams_ = {
		values = clone(arg_14_0.heroExpressionParams_[arg_14_1][1].values),
		effectID = arg_14_0.heroExpressionParams_[arg_14_1][1].effectID
	}
end

function var_0_0.SetCacheExpressionParams(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.cacheExpressionParams_.values[arg_15_1] = arg_15_2
end

function var_0_0.SetCacheExpressionEffect(arg_16_0, arg_16_1)
	arg_16_0.cacheExpressionParams_.effectID = arg_16_1
end

function var_0_0.GetCacheExpressionParams(arg_17_0)
	return arg_17_0.cacheExpressionParams_
end

function var_0_0.InitHeroPose(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.heroPoseList_[arg_18_1] = {}

	local var_18_0 = HeroDisplayCfg[arg_18_2] or HeroDisplayCfg[arg_18_1]

	for iter_18_0, iter_18_1 in ipairs(var_18_0.poseList) do
		table.insert(arg_18_0.heroPoseList_[arg_18_1], {
			id = iter_18_1[1],
			weaponState = iter_18_1[2]
		})
	end
end

function var_0_0.GetHeroPoseList(arg_19_0, arg_19_1)
	return arg_19_0.heroPoseList_[arg_19_1]
end

return var_0_0
