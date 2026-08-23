local var_0_0 = g.core.config.fog_idle_info
local var_0_1 = g.core.config.fog_level_info
local var_0_2 = g.core.config.fog_guild_buff_info
local var_0_3 = g.core.model.User.fogNightmareData
local FogNightmareAssistantData = class("FogNightmareAssistantData")

function FogNightmareAssistantData:ctor()
	self:initData()
end

function FogNightmareAssistantData:initData()
	self._idleFloorDict = {}
	self._idleFloorList = {}
	self._idleInfo = {}
	self._fixedReward = {}
	self._oldIdleTime = 0
	self._redHindFogLv = nil
	self._curIdleSvrData = nil
	self._guildNeedNumDict = {}
	self._guildSvrInfoDict = {}
	self._guildBuffInfo = {}
	self._guildMemberDict = {}

	self:initCfg()
end

function FogNightmareAssistantData:initCfg()
	for iter_3_0 = 1, var_0_0.getLength() do
		local var_3_0 = var_0_0.indexOf(iter_3_0)

		self._idleFloorDict[var_3_0.floor_id] = var_3_0

		table.insert(self._idleFloorList, var_3_0)
	end

	for iter_3_1, iter_3_2 in var_0_2.ipairs() do
		self._guildNeedNumDict[iter_3_2.floor] = self._guildNeedNumDict[iter_3_2.floor] or {}

		table.insert(self._guildNeedNumDict[iter_3_2.floor], iter_3_2.num)
	end

	for iter_3_3, iter_3_4 in pairs(self._guildNeedNumDict) do
		table.sort(iter_3_4, function(arg_4_0, arg_4_1)
			return arg_4_0 < arg_4_1
		end)
	end
end

function FogNightmareAssistantData:getTargetFloorCfg(arg_5_1)
	return self._idleFloorDict[arg_5_1]
end

function FogNightmareAssistantData:updateData(arg_6_1, arg_6_2)
	self._redHindFogLv = arg_6_2 or self._redHindFogLv
	self._idleInfo = arg_6_1.idle_info or {}
	self._oldIdleTime = 0

	self:_updateCheckTime()

	self._curIdleSvrData = nil
	self._fixedReward = {}

	self:calcFixedReward()
end

function FogNightmareAssistantData:_updateCheckTime()
	self._checkTimeRange = {
		max = 0,
		min = 0
	}

	for iter_7_0, iter_7_1 in ipairs(self._idleInfo) do
		if self._checkTimeRange.min == 0 or iter_7_1.start_time < self._checkTimeRange.min then
			self._checkTimeRange.min = iter_7_1.start_time
		end
	end

	self._checkTimeRange.max = self._checkTimeRange.min + 1209600
end

function FogNightmareAssistantData:calcFixedReward()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self._idleInfo) do
		if iter_8_1.end_time ~= 0 then
			self:calcPerReward(iter_8_1, var_8_0, self:_getProductTimeRatio(iter_8_1.start_time, iter_8_1.end_time))

			self._oldIdleTime = self._oldIdleTime + iter_8_1.end_time - iter_8_1.start_time
		else
			self._curIdleSvrData = iter_8_1
		end
	end

	for iter_8_2, iter_8_3 in pairs(var_8_0) do
		for iter_8_4, iter_8_5 in pairs(iter_8_3) do
			table.insert(self._fixedReward, {
				type = iter_8_2,
				value = iter_8_4,
				size = iter_8_5
			})
		end
	end
end

function FogNightmareAssistantData:parseReward(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		for iter_9_2, iter_9_3 in pairs(iter_9_1) do
			if iter_9_3 > 0 then
				table.insert(var_9_0, {
					type = iter_9_0,
					value = iter_9_2,
					size = math.floor(iter_9_3)
				})
			end
		end
	end

	return var_9_0
end

function FogNightmareAssistantData:calcPerReward(arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or {}

	local var_10_0 = self:getLatestIdleCfg(arg_10_1.floor)

	if not var_10_0 then
		return {}
	end

	if var_10_0.idle_num_1 ~= 0 then
		arg_10_2[var_10_0.idle_type_1] = arg_10_2[var_10_0.idle_type_1] or {}
		arg_10_2[var_10_0.idle_type_1][var_10_0.idle_value_1] = arg_10_2[var_10_0.idle_type_1][var_10_0.idle_value_1] or 0
		arg_10_2[var_10_0.idle_type_1][var_10_0.idle_value_1] = arg_10_2[var_10_0.idle_type_1][var_10_0.idle_value_1] + math.floor(math.floor((arg_10_1.end_time - arg_10_1.start_time) / var_10_0.drop_time_1) * var_10_0.idle_num_1)
	end

	if var_10_0.idle_num_2 ~= 0 then
		arg_10_2[var_10_0.idle_type_2] = arg_10_2[var_10_0.idle_type_2] or {}
		arg_10_2[var_10_0.idle_type_2][var_10_0.idle_value_2] = arg_10_2[var_10_0.idle_type_2][var_10_0.idle_value_2] or 0
		arg_10_2[var_10_0.idle_type_2][var_10_0.idle_value_2] = arg_10_2[var_10_0.idle_type_2][var_10_0.idle_value_2] + math.floor(math.floor((arg_10_1.end_time - arg_10_1.start_time) / var_10_0.drop_time_2) * var_10_0.idle_num_2)
	end

	return arg_10_2
end

function FogNightmareAssistantData:getNowReward()
	local var_11_0 = {}
	local var_11_1 = 0

	if self._curIdleSvrData then
		local var_11_2 = self:getEffectiveTime()
		local var_11_3 = g.core.common.ServerTime:getTime() - self._curIdleSvrData.start_time

		var_11_1 = var_11_2

		if var_11_3 < var_11_2 then
			var_11_1 = var_11_3
		end

		var_11_0 = self:parseReward((self:calcPerReward({
			start_time = 0,
			floor = self._curIdleSvrData.floor,
			end_time = var_11_1
		}, {})))
	end

	for iter_11_0, iter_11_1 in ipairs(self._fixedReward) do
		local var_11_4 = false

		for iter_11_2, iter_11_3 in ipairs(var_11_0) do
			if iter_11_3.type == iter_11_1.type and iter_11_3.value == iter_11_1.value then
				iter_11_3.size = iter_11_3.size + iter_11_1.size
				var_11_4 = true
			end
		end

		if not var_11_4 and iter_11_1.size > 0 then
			table.insert(var_11_0, {
				type = iter_11_1.type,
				value = iter_11_1.value,
				size = iter_11_1.size
			})
		end
	end

	if self._checkTimeRange then
		local var_11_5 = self._checkTimeRange.min + self:getCurMaxIdleTime()

		if self._curIdleSvrData then
			var_11_5 = math.min(var_11_5, self._curIdleSvrData.start_time + var_11_1)
		end

		local var_11_6 = self:_getProductTimeRatio(self._checkTimeRange.min, var_11_5)

		for iter_11_4, iter_11_5 in ipairs(var_11_0) do
			iter_11_5.size = math.floor(iter_11_5.size * var_11_6)
		end
	end

	if self._guildBuffInfo and self._guildBuffInfo.totalUpValue then
		for iter_11_6, iter_11_7 in ipairs(var_11_0) do
			iter_11_7.size = math.floor(iter_11_7.size * (1 + self._guildBuffInfo.totalUpValue / 1000))
		end
	end

	return var_11_0
end

function FogNightmareAssistantData:isIdleTimeFull()
	local var_12_0 = self:getEffectiveTime()

	if var_12_0 <= 0 then
		return true
	end

	if self._curIdleSvrData and var_12_0 <= g.core.common.ServerTime:getTime() - self._curIdleSvrData.start_time then
		return true
	end

	return false
end

function FogNightmareAssistantData:getCurDayRewardItem()
	local var_13_0 = self:getLatestIdleCfg()
	local var_13_1 = {}

	if var_13_0.idle_num_1 ~= 0 then
		table.insert(var_13_1, {
			type = var_13_0.idle_type_1,
			value = var_13_0.idle_value_1,
			size = math.floor(86400 / var_13_0.drop_time_1) * var_13_0.idle_num_1
		})
	end

	if var_13_0.idle_num_2 ~= 0 then
		table.insert(var_13_1, {
			type = var_13_0.idle_type_2,
			value = var_13_0.idle_value_2,
			size = math.floor(86400 / var_13_0.drop_time_2) * var_13_0.idle_num_2
		})
	end

	return var_13_1, var_13_0
end

function FogNightmareAssistantData:getNextStageDayRewardItem()
	local var_14_0 = var_0_0.fetch(self:getLatestIdleCfg().id + 1)

	if not var_14_0 then
		return {}
	end

	local var_14_1 = {}

	if var_14_0.idle_num_1 ~= 0 then
		table.insert(var_14_1, {
			type = var_14_0.idle_type_1,
			value = var_14_0.idle_value_1,
			size = math.floor(86400 / var_14_0.drop_time_1) * var_14_0.idle_num_1
		})
	end

	if var_14_0.idle_num_2 ~= 0 then
		table.insert(var_14_1, {
			type = var_14_0.idle_type_2,
			value = var_14_0.idle_value_2,
			size = math.floor(86400 / var_14_0.drop_time_2) * var_14_0.idle_num_2
		})
	end

	return var_14_1, var_14_0
end

function FogNightmareAssistantData:getLatestIdleCfg(arg_15_1)
	arg_15_1 = arg_15_1 or self:getCurFloor()

	if self._idleFloorDict[arg_15_1] then
		return self._idleFloorDict[arg_15_1]
	end

	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(self._idleFloorList) do
		if arg_15_1 >= iter_15_1.floor_id then
			var_15_0 = iter_15_0
		else
			break
		end
	end

	return self._idleFloorList[var_15_0]
end

function FogNightmareAssistantData:getEffectiveTime()
	return self:getCurMaxIdleTime() - self._oldIdleTime
end

function FogNightmareAssistantData:getCurIdleTime()
	local var_17_0 = 0

	if self._curIdleSvrData then
		local var_17_1 = self:getEffectiveTime()
		local var_17_2 = g.core.common.ServerTime:getTime() - self._curIdleSvrData.start_time

		var_17_0 = var_17_1 <= var_17_2 and var_17_1 or var_17_2
	end

	return self._oldIdleTime + var_17_0
end

function FogNightmareAssistantData:getMaxIdleTimeDH()
	local var_18_0 = self:getCurMaxIdleTime()

	return (var_18_0 - var_18_0 % 86400) / 86400, (var_18_0 - (var_18_0 - var_18_0 % 86400) / 86400 * 86400 - var_18_0 % 3600) / 3600
end

function FogNightmareAssistantData:getMaxIdleTimeDHByLevel(arg_19_1)
	local var_19_0 = var_0_1.fetch(arg_19_1)

	if not var_19_0 then
		return 0, 0
	end

	return (var_19_0.idle_time * 3600 - var_19_0.idle_time * 3600 % 86400) / 86400, (var_19_0.idle_time * 3600 - (var_19_0.idle_time * 3600 - var_19_0.idle_time * 3600 % 86400) / 86400 * 86400 - var_19_0.idle_time * 3600 % 3600) / 3600
end

function FogNightmareAssistantData:getCurIdleTimeHMS()
	local var_20_0 = self:getCurIdleTime()

	if var_20_0 < 0 then
		var_20_0 = 0
	end

	return (var_20_0 - var_20_0 % 3600) / 3600, (var_20_0 - (var_20_0 - var_20_0 % 3600) / 3600 * 3600 - var_20_0 % 60) / 60, var_20_0 % 60
end

function FogNightmareAssistantData:getCurMaxIdleTime()
	return var_0_1.get(self:getCurLevel()).idle_time * 3600
end

function FogNightmareAssistantData:getCurFloor()
	local var_22_0 = var_0_3:getTowerData()

	return math.max(math.max(var_22_0:getCurrentMaxFloorNum(), var_22_0:getCurrentFloorNum() - 1), var_22_0:getHistoryMaxFloorNum())
end

function FogNightmareAssistantData:getCurLevel()
	local var_23_0 = var_0_3:getFogLevel()

	if self._redHindFogLv and var_23_0 == 1 then
		return self._redHindFogLv
	end

	return var_23_0
end

function FogNightmareAssistantData:getIdleProductsUpValue(arg_24_1)
	local var_24_0 = 0

	arg_24_1 = arg_24_1 or var_0_3:getWeeklyBuff()

	if arg_24_1 then
		if g.core.const.ConstMgr.FogNightmareConst.WEEK_BUFF_TYPE.NEW_EFFECT_ENUM == arg_24_1.buff_type and arg_24_1.buff_value == g.core.const.ConstMgr.FogNightmareConst.NEW_EFFECT_ENUM.IDLE then
			var_24_0 = math.floor(var_0_1.get((var_0_3:getFogLevel())).weekly_idle_rate / 10)
		end
	end

	return var_24_0
end

function FogNightmareAssistantData:_getProductTimeRatio(arg_25_1, arg_25_2)
	local var_25_0, var_25_1

	if arg_25_1 > self._checkTimeRange.max or arg_25_2 < self._checkTimeRange.min then
		do return 1 end

		var_25_0 = 1
		var_25_1 = {}
	end

	for iter_25_0, iter_25_1 in ipairs((var_0_3:getIdleUpTime())) do
		if arg_25_1 <= iter_25_1.historyInfo.sundayTime and arg_25_2 >= iter_25_1.historyInfo.mondayTime then
			var_25_1[#var_25_1 + 1] = {
				effectTime = math.min(arg_25_2, iter_25_1.historyInfo.sundayTime) - math.max(iter_25_1.historyInfo.mondayTime, arg_25_1),
				upValue = iter_25_1.upValue,
				buffId = iter_25_1.historyInfo.id
			}
		end
	end

	local var_25_2 = 0
	local var_25_3 = 0

	for iter_25_2, iter_25_3 in ipairs(var_25_1) do
		var_25_2 = var_25_2 + iter_25_3.effectTime
		var_25_3 = iter_25_3.upValue
	end

	return 1 + var_25_2 / (arg_25_2 - arg_25_1) * (var_25_3 / 100)
end

function FogNightmareAssistantData:updateIdleGuildData(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1.list or {}) do
		self._guildSvrInfoDict[iter_26_1.floor] = iter_26_1
	end

	self:_updateTotalGuildBuffInfo()
end

function FogNightmareAssistantData:_updateTotalGuildBuffInfo()
	self._guildBuffInfo = {
		totalUpValue = 0,
		subInfos = {}
	}

	for iter_27_0, iter_27_1 in pairs(self._guildNeedNumDict) do
		local var_27_0 = self._guildSvrInfoDict[iter_27_0]
		local var_27_1

		if self._guildSvrInfoDict[iter_27_0] then
			var_27_1 = var_27_0.num or 0
		end

		local var_27_2 = iter_27_1[1]

		for iter_27_2, iter_27_3 in ipairs(iter_27_1) do
			if var_27_1 < iter_27_3 then
				break
			end

			var_27_2 = iter_27_3
		end

		local var_27_3 = var_0_2.get(tonumber(iter_27_0), tonumber(var_27_2))
		local var_27_4 = {
			cfg = var_27_3
		}

		if var_27_1 > 0 and var_27_2 <= var_27_1 then
			var_27_4.enable = true
			var_27_4.serverInfo = var_27_0
			self._guildBuffInfo.totalUpValue = self._guildBuffInfo.totalUpValue + var_27_3.rate
		end

		table.insert(self._guildBuffInfo.subInfos, var_27_4)
	end

	table.sort(self._guildBuffInfo.subInfos, function(arg_28_0, arg_28_1)
		return arg_28_0.cfg.floor < arg_28_1.cfg.floor
	end)

	return self._guildBuffInfo
end

function FogNightmareAssistantData:getGuildBuffInfo()
	return self._guildBuffInfo
end

function FogNightmareAssistantData:clearGuildBuffInfo()
	self._guildBuffInfo = {}
end

function FogNightmareAssistantData:_updateMemberDict(arg_31_1)
	self._guildMemberDict[arg_31_1.floor] = arg_31_1.list
end

function FogNightmareAssistantData:getFloorCfgList()
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(self._guildNeedNumDict) do
		table.insert(var_32_0, iter_32_0)
	end

	table.sort(var_32_0, function(arg_33_0, arg_33_1)
		return arg_33_0 < arg_33_1
	end)

	return var_32_0
end

function FogNightmareAssistantData:getFloorNeedNumList(arg_34_1)
	return self._guildNeedNumDict[arg_34_1] or {}
end

function FogNightmareAssistantData:getFloorCurSvrData(arg_35_1)
	return self._guildSvrInfoDict[arg_35_1]
end

function FogNightmareAssistantData:getFloorCurNum(arg_36_1)
	return (self:getFloorCurSvrData(arg_36_1) or {}).num or 0
end

return FogNightmareAssistantData
