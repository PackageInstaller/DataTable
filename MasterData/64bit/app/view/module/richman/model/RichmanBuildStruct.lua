local var_0_0 = g.core.model.User.richmanData
local var_0_1 = g.core.config.richman_construct_info
local var_0_2 = g.core.config.richman_map_level_info
local RichmanBuildStruct = class("RichmanBuildStruct")

function RichmanBuildStruct:ctor(arg_1_1)
	self:updateBuildData(arg_1_1)
end

function RichmanBuildStruct:updateBuildData(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._buildHangUpTime = arg_2_1.begin_time
	self._armistice = arg_2_1.armistice
	self._mapLvCfg = var_0_2.get(var_0_0:getMapLevel())
	self._typeBuild = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.details or {}) do
		self._typeBuild[iter_2_1.tp] = iter_2_1
	end
end

function RichmanBuildStruct:updateBuildCfg()
	self._mapLvCfg = var_0_2.get(var_0_0:getMapLevel())
end

function RichmanBuildStruct:getBuildHangUpStartTime()
	return self._buildHangUpTime
end

function RichmanBuildStruct:getArmistice()
	return self._armistice
end

function RichmanBuildStruct:getTypeBuild(arg_6_1)
	return self._typeBuild[arg_6_1]
end

function RichmanBuildStruct:getBuildLevel(arg_7_1)
	return self._mapLvCfg["construct_" .. arg_7_1]
end

function RichmanBuildStruct:getPreviewReward(arg_8_1, arg_8_2)
	local var_8_0 = var_0_0:getBuildCfgByTypeAndLv(arg_8_1, arg_8_2)
	local var_8_1 = {}

	while var_0_1.hasKey("reward_type_" .. 1) do
		if var_8_0["reward_type_" .. 1] > 0 then
			table.insert(var_8_1, {
				type = var_8_0["reward_type_" .. 1],
				value = var_8_0["reward_value_" .. 1],
				size = var_8_0["reward_size_min_" .. 1],
				chance = var_8_0["probability_" .. 1]
			})
		end
	end

	return var_8_1
end

function RichmanBuildStruct:getTypeBuildStealExAward(arg_9_1)
	local var_9_0 = self:getTypeBuild(arg_9_1)
end

function RichmanBuildStruct:getBuildLevelByMapLvAndType(arg_10_1, arg_10_2)
	return var_0_2.get(arg_10_1)["construct_" .. arg_10_2]
end

function RichmanBuildStruct:getBuildNeedMapLv(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in var_0_2.ipairs() do
		if iter_11_1["construct_" .. arg_11_1] == arg_11_2 then
			return iter_11_1.level
		end
	end

	return 0
end

return RichmanBuildStruct
