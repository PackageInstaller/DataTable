local var_0_0 = singletonClass("HeroDisplayData")
local cjson = require("cjson")

function var_0_0.Init(arg_1_0)
	local var_1_0 = getData("HeroDisplay", "settingProfile")

	arg_1_0.settingProfile_ = var_1_0 == nil and {
		cardShowUID = true,
		cardShowLv = true,
		logoPos = 0,
		cardPos = 1,
		cardShow = true
	} or var_1_0
	arg_1_0.heroExpressionParams_ = {}
	arg_1_0.heroCustomExpression_ = {}
	arg_1_0.heroPoseList_ = {}
end

function var_0_0:SaveSetting(arg_2_1)
	self.settingProfile_.logoPos = arg_2_1.logoPos
	self.settingProfile_.cardPos = arg_2_1.cardPos
	self.settingProfile_.cardShow = arg_2_1.cardShow
	self.settingProfile_.cardShowLv = arg_2_1.cardShowLv
	self.settingProfile_.cardShowUID = arg_2_1.cardShowUID

	saveData("HeroDisplay", "settingProfile", self.settingProfile_)
end

function var_0_0:GetSetting()
	return self.settingProfile_
end

function var_0_0:GetCustomExpressionParams(arg_4_1)
	if self.heroCustomExpression_[arg_4_1] == nil then
		local var_4_0 = getData("HeroDisplay", "expressionParams" .. arg_4_1)

		self.heroCustomExpression_[arg_4_1] = var_4_0 and var_4_0 or {}
	end

	return self.heroCustomExpression_[arg_4_1]
end

function var_0_0:AddCustomExpressionParams(arg_5_1, arg_5_2)
	table.insert(self.heroCustomExpression_[arg_5_1], arg_5_2)
	saveData("HeroDisplay", "expressionParams" .. arg_5_1, self.heroCustomExpression_[arg_5_1])
end

function var_0_0:ReplaceCustomExpressionParams(arg_6_1, arg_6_2, arg_6_3)
	self.heroCustomExpression_[arg_6_1][arg_6_2] = arg_6_3

	saveData("HeroDisplay", "expressionParams" .. arg_6_1, self.heroCustomExpression_[arg_6_1])
end

function var_0_0:DeleteCustomExpressionParams(arg_7_1, arg_7_2)
	table.remove(self.heroCustomExpression_[arg_7_1], arg_7_2)
	saveData("HeroDisplay", "expressionParams" .. arg_7_1, self.heroCustomExpression_[arg_7_1])
end

function var_0_0:InitPreset(arg_8_1, arg_8_2)
	self.heroExpressionParams_[arg_8_1] = {}
	self.heroExpressionParams_[arg_8_1][1] = {
		preset = true,
		effectID = 0,
		name = GetTips("DEFAULT_PRESET"),
		values = arg_8_2
	}

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
		var_8_0[iter_8_0] = 0
	end

	self.heroExpressionParams_[arg_8_1][2] = {
		preset = true,
		effectID = 0,
		name = GetTips("INIT_PRESET"),
		values = var_8_0
	}

	for iter_8_2, iter_8_3 in ipairs(HeroDisplayCfg[arg_8_1].skinMeshPresetName) do
		local var_8_1 = {
			preset = true,
			name = iter_8_3,
			values = HeroDisplayCfg[arg_8_1].skinMeshPresetValue[iter_8_2]
		}

		var_8_1.effectID = HeroDisplayCfg[arg_8_1].skinMeshPresetEffect[iter_8_2] or 0

		table.insert(self.heroExpressionParams_[arg_8_1], var_8_1)
	end

	for iter_8_4, iter_8_5 in ipairs((self:GetCustomExpressionParams(arg_8_1))) do
		table.insert(self.heroExpressionParams_[arg_8_1], iter_8_5)
	end
end

function var_0_0:GetHeroExpressionParams(arg_9_1)
	return self.heroExpressionParams_[arg_9_1]
end

function var_0_0:ReplaceHeroExpressionParams(arg_10_1, arg_10_2, arg_10_3)
	self.heroExpressionParams_[arg_10_1][arg_10_2] = arg_10_3

	self:ReplaceCustomExpressionParams(arg_10_1, arg_10_2 - self:GetCustomStartIndex(arg_10_1), arg_10_3)
end

function var_0_0:SaveHeroExpressionParams(arg_11_1, arg_11_2)
	table.insert(self.heroExpressionParams_[arg_11_1], arg_11_2)
	self:AddCustomExpressionParams(arg_11_1, arg_11_2)
end

function var_0_0:DeleteHeroExpressionParams(arg_12_1, arg_12_2)
	table.remove(self.heroExpressionParams_[arg_12_1], arg_12_2)
	self:DeleteCustomExpressionParams(arg_12_1, arg_12_2 - self:GetCustomStartIndex(arg_12_1))
end

function var_0_0.GetCustomStartIndex(arg_13_0, arg_13_1)
	return #HeroDisplayCfg[arg_13_1].skinMeshPresetName + 2
end

function var_0_0:InitCacheExpressionParams(arg_14_1)
	self.cacheExpressionParams_ = {
		values = clone(self.heroExpressionParams_[arg_14_1][1].values),
		effectID = self.heroExpressionParams_[arg_14_1][1].effectID
	}
end

function var_0_0:SetCacheExpressionParams(arg_15_1, arg_15_2)
	self.cacheExpressionParams_.values[arg_15_1] = arg_15_2
end

function var_0_0:SetCacheExpressionEffect(arg_16_1)
	self.cacheExpressionParams_.effectID = arg_16_1
end

function var_0_0:GetCacheExpressionParams()
	return self.cacheExpressionParams_
end

function var_0_0:InitHeroPose(arg_18_1, arg_18_2)
	self.heroPoseList_[arg_18_1] = {}

	for iter_18_0, iter_18_1 in ipairs((HeroDisplayCfg[arg_18_2] or HeroDisplayCfg[arg_18_1]).poseList) do
		table.insert(self.heroPoseList_[arg_18_1], {
			id = iter_18_1[1],
			weaponState = iter_18_1[2]
		})
	end
end

function var_0_0:GetHeroPoseList(arg_19_1)
	return self.heroPoseList_[arg_19_1]
end

return var_0_0
