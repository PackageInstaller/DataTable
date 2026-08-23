local GuildWorshipData = class("GuildWorshipData")
local var_0_1 = g.core.config.guild_worship_mission_info

function GuildWorshipData:ctor()
	self:initData()
end

function GuildWorshipData:initData()
	self._progress = 0
	self._numWorship = 0
	self._guildLevel = 1
	self._taskMap = {}
	self._worshipData = {}
	self._receiveIdList = {}
	self._logData = {}
	self._lastLog = ""
end

function GuildWorshipData:updateWorshipData(arg_3_1)
	self._progress = arg_3_1.progress or 0
	self._numWorship = arg_3_1.worship_num or 0

	local var_3_0 = arg_3_1.missions or {}

	self._guildLevel = arg_3_1.zero_hour_level or 1

	if arg_3_1.worship then
		self._worshipData = arg_3_1.worship.state or {}
		self._receiveIdList = arg_3_1.worship.awarded
	else
		self._worshipData = {}
		self._receiveIdList = {}
	end

	for iter_3_0 = 1, #var_3_0 do
		self._taskMap[var_3_0[iter_3_0].type] = var_3_0[iter_3_0].value
	end
end

function GuildWorshipData:updateFinishMission(arg_4_1)
	if arg_4_1.worship then
		self._worshipData = arg_4_1.worship.state or {}
		self._receiveIdList = arg_4_1.worship.awarded
	end

	self._progress = self._progress + var_0_1.get(arg_4_1.id).worship_value * (arg_4_1.num or 1)
end

function GuildWorshipData:updateFinishMissionOneKey(arg_5_1)
	if arg_5_1.worship then
		self._worshipData = arg_5_1.worship.state or {}
		self._receiveIdList = arg_5_1.worship.awarded
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.id) do
		self._progress = self._progress + var_0_1.get(iter_5_1).worship_value * ((not arg_5_1.num[iter_5_0] or nil) and 1)
	end
end

function GuildWorshipData:updateWorshipAwardId(arg_6_1)
	self._receiveIdList = self._receiveIdList or {}

	table.insert(self._receiveIdList, arg_6_1.index)
end

function GuildWorshipData:updateTaskProgress(arg_7_1)
	self._taskMap[arg_7_1.task.type] = arg_7_1.task.value
end

function GuildWorshipData:generateContributeRecord(arg_8_1)
	local var_8_0 = g.core.config.guild_news_info.get(arg_8_1.history.base_id)

	if var_8_0.type ~= 1 then
		if var_8_0.type == 3 then
			local var_8_1 = g.core.common.ServerTime:getDateMDFormat(arg_8_1.history.time)
			local var_8_2 = string.gsub(var_8_0.news, "#time#", var_8_1)
			local var_8_3 = string.gsub(g.core.lang:get(1125), "#time#", var_8_1)

			for iter_8_0 = 1, #arg_8_1.history.key do
				var_8_2 = string.gsub(var_8_2, "#" .. arg_8_1.history.key[iter_8_0] .. "#", arg_8_1.history.value[iter_8_0])
				var_8_3 = string.gsub(var_8_3, "#" .. arg_8_1.history.key[iter_8_0] .. "#", arg_8_1.history.value[iter_8_0])
			end

			if var_8_0.id == 1 then
				table.insert(self._logData, var_8_2)
			end

			self._lastLog = var_8_3
		end
	end
end

function GuildWorshipData:getWorshipLog()
	self._logData = {}

	local var_9_0 = ""
	local var_9_1 = g.core.model.User.guildData:getWorshipLog()

	for iter_9_0 = 1, #var_9_1 do
		local var_9_2 = g.core.config.guild_news_info.get(var_9_1[iter_9_0].base_id)

		if var_9_2.type ~= 1 then
			if var_9_2.type == 3 then
				local var_9_3 = g.core.common.ServerTime:getDateMDFormat(var_9_1[iter_9_0].time)
				local var_9_4 = string.gsub(var_9_2.news, "#time#", var_9_3)

				var_9_0 = string.gsub(g.core.lang:get(1125), "#time#", var_9_3)

				for iter_9_1 = 1, #var_9_1[iter_9_0].key do
					var_9_4 = string.gsub(var_9_4, "#" .. var_9_1[iter_9_0].key[iter_9_1] .. "#", var_9_1[iter_9_0].value[iter_9_1])
					var_9_0 = string.gsub(var_9_0, "#" .. var_9_1[iter_9_0].key[iter_9_1] .. "#", var_9_1[iter_9_0].value[iter_9_1])
				end

				if var_9_2.id == 1 then
					table.insert(self._logData, var_9_4)
				end
			end
		end
	end

	self._lastLog = var_9_0

	return self._logData
end

function GuildWorshipData:getCurWorshipLog()
	return self._logData
end

function GuildWorshipData:getLastLog()
	return self._lastLog
end

function GuildWorshipData:getWorshipNumById(arg_12_1)
	for iter_12_0 = 1, #self._worshipData do
		if self._worshipData[iter_12_0].id == arg_12_1 then
			return self._worshipData[iter_12_0].status
		end
	end

	return 0
end

function GuildWorshipData:getTaskStateById(arg_13_1)
	local var_13_1 = var_0_1.get(arg_13_1)
	local var_13_2 = self:getWorshipNumById(arg_13_1)
	local var_13_3 = 0
	local var_13_4

	if var_13_1.type == 1 then
		var_13_3 = #g.core.model.User.shopData:getBuyPriceInfo(28)
		var_13_4 = not var_13_2 and 1 or var_13_2 < var_13_3 and 1 or 2
	else
		var_13_4 = self._taskMap[arg_13_1] < var_13_1.mission_value and 0 or var_13_2 and var_13_2 > 0 and 2 or 1
	end

	return var_13_4, var_13_3, var_13_2
end

function GuildWorshipData:isWorshipAwardReceive(arg_14_1)
	if not self._receiveIdList then
		return false
	end

	for iter_14_0 = 1, #self._receiveIdList do
		if arg_14_1 == self._receiveIdList[iter_14_0] then
			return true
		end
	end

	return false
end

function GuildWorshipData:canContribute()
	local var_15_0 = true

	for iter_15_0 = 1, #self._worshipData do
		if self._worshipData[iter_15_0] and self._worshipData[iter_15_0].id and var_0_1.get(self._worshipData[iter_15_0].id).type == 1 then
			var_15_0 = false

			break
		end
	end

	if var_15_0 then
		return true
	end

	for iter_15_1, iter_15_2 in pairs(self._taskMap) do
		local var_15_2 = self:getWorshipNumById(iter_15_1)

		if self._taskMap[iter_15_1] >= var_0_1.get(iter_15_1).mission_value and (not var_15_2 or var_15_2 == 0) then
			return true
		end
	end
end

function GuildWorshipData:canReceiveAward()
	local var_16_0 = g.core.model.User.guildData:getCfg()

	for iter_16_0 = 1, 4 do
		if not self:isWorshipAwardReceive(iter_16_0) and self._progress >= var_16_0["worship_value_" .. iter_16_0] then
			return true
		end
	end

	return false
end

function GuildWorshipData:updateRedPointData(arg_17_1)
	self._progress = arg_17_1.worship_progress or 0

	if arg_17_1.worship then
		self._worshipData = arg_17_1.worship.state or {}
		self._receiveIdList = arg_17_1.worship.awarded
	end

	local var_17_0 = arg_17_1.missions or {}

	for iter_17_0 = 1, #var_17_0 do
		self._taskMap[var_17_0[iter_17_0].type] = var_17_0[iter_17_0].value
	end

	self._guildLevel = arg_17_1.zero_hour_level or 1
end

function GuildWorshipData:getGuildLevelAtZero()
	return self._guildLevel
end

function GuildWorshipData:getWorshipProgress()
	return self._progress
end

function GuildWorshipData:getTaskMap()
	return self._taskMap
end

function GuildWorshipData:getTaskList()
	local var_21_0 = {}

	table.insert(var_21_0, {
		id = 1,
		num = 0
	})

	for iter_21_0, iter_21_1 in pairs(self._taskMap) do
		table.insert(var_21_0, {
			id = iter_21_0,
			num = iter_21_1
		})
	end

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		if arg_22_0.id ~= arg_22_1.id then
			return arg_22_0.id < arg_22_1.id
		end
	end)

	return var_21_0
end

function GuildWorshipData:getPlayerSendStr(arg_23_1, arg_23_2)
	return "Guild" .. tostring(arg_23_1) .. "_" .. tostring((g.core.model.User:getId())) .. "_" .. tostring(arg_23_2)
end

function GuildWorshipData:resetGuildPlayerSendGiftRecord()
	self._setConfig = g.core.common.Storage:load("GuildSendGiftRecord.json", false) or {}

	if self._setConfig.time and self._setConfig.time ~= "" and not g.core.common.ServerTime:getIsSameDay(tonumber(self._setConfig.time)) then
		self._setConfig = {}

		g.core.common.Storage:save("GuildSendGiftRecord.json", self._setConfig, false)
	end
end

function GuildWorshipData:setCurGuildPlayerSendGiftRecord(arg_25_1, arg_25_2)
	local var_25_0 = self._setConfig

	if not self._setConfig then
		var_25_0 = g.core.common.Storage:load("GuildSendGiftRecord.json", false)
		var_25_0 = var_25_0 or {}
	end

	self._setConfig = var_25_0
	self._setConfig[self:getPlayerSendStr(arg_25_1, arg_25_2)] = "1"

	if not self._setConfig.time or self._setConfig.time == "" or g.core.common.ServerTime:getIsSameDay(tonumber(self._setConfig.time)) then
		self._setConfig.time = g.core.common.ServerTime:getTime()
	end

	g.core.common.Storage:save("GuildSendGiftRecord.json", self._setConfig, false)
end

function GuildWorshipData:getSendGiftMemberData()
	local var_26_0 = clone(g.core.model.User.guildData:getSortMemberData(0, nil, (clone(g.core.model.User.guildData:getMemberData() or {}))))
	local var_26_1 = g.core.model.User:getId()

	for iter_26_0 = #var_26_0, 1, -1 do
		local var_26_2 = tostring(var_26_0[iter_26_0].user.id)
		local var_26_3 = tostring(var_26_0[iter_26_0].user.guild_id)

		if var_26_2 == tostring(var_26_1) then
			table.remove(var_26_0, iter_26_0)
		else
			var_26_0[iter_26_0].isHasGetGift = false

			if self._setConfig and self._setConfig["Guild" .. var_26_3 .. "_" .. var_26_1 .. "_" .. var_26_2] and self._setConfig["Guild" .. var_26_3 .. "_" .. var_26_1 .. "_" .. var_26_2] ~= "" then
				var_26_0[iter_26_0].isHasGetGift = true
			end
		end
	end

	return var_26_0
end

function GuildWorshipData:getGuildContributeLeftTimes()
	local var_27_0 = self:getWorshipNumById(1) or 0
	local var_27_1, var_27_2, var_27_3 = self:getTaskStateById(1)

	return var_27_2 - var_27_0
end

function GuildWorshipData:getGuildSendGiftLeftTimesByType(arg_28_1)
	local var_28_0 = var_0_1.get(arg_28_1)

	return var_28_0.mission_value - math.min((self:getTaskList()[arg_28_1] or {}).num or 0, var_28_0.mission_value)
end

function GuildWorshipData:getOneKeyGetProgressAwardId()
	local var_29_0 = {}

	for iter_29_0 = 1, 4 do
		if not self:isWorshipAwardReceive(iter_29_0) and self._progress >= g.core.model.User.guildData:getCfg(self:getGuildLevelAtZero() or 1)["worship_value_" .. iter_29_0] then
			table.insert(var_29_0, iter_29_0)
		end
	end

	return var_29_0
end

function GuildWorshipData:getOneKeyGetTaskAwardId()
	local var_30_0 = {}
	local var_30_1 = {}
	local var_30_2 = self:getTaskList()

	for iter_30_0 = 1, #var_30_2 do
		local var_30_3 = var_30_2[iter_30_0].id or 1
		local var_30_4, var_30_5, var_30_6 = self:getTaskStateById(var_30_3)

		if var_30_4 == 1 then
			table.insert(var_30_0, var_30_3)
			table.insert(var_30_1, 1)
		end
	end

	return var_30_0, var_30_1
end

function GuildWorshipData:isShowRedPoint()
	local var_31_0 = self:getTaskList()

	for iter_31_0 = 1, #var_31_0 do
		local var_31_1 = var_31_0[iter_31_0].id or 1

		if (self:getWorshipNumById(var_31_1) or 0) == 0 then
			local var_31_2, var_31_3, var_31_4 = self:getTaskStateById(var_31_1)

			if var_31_2 == 1 then
				return true
			end
		end
	end

	if self:canReceiveAward() then
		return true
	end

	return false
end

return GuildWorshipData
