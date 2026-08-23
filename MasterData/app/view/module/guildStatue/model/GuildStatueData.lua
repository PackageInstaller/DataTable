local GuildStatueData = class("GuildStatueData")
local var_0_1 = g.core.config.guild_statue_info

function GuildStatueData:ctor()
	self:initData()
end

function GuildStatueData:initData()
	self._statueData = {}
	self._awardStage = {}
	self._partState = {}
	self._poolIdList = {}
	self._finalAward = {}
	self._leftTimes = 0
	self._numStone = 0
	self._canGetFinalReward = false
	self._isAward = true
	self._totalProg = 0
	self._contRankData = {}
	self._meRankData = {}

	self:_initFinalAward()
end

function GuildStatueData:_initFinalAward()
	self._poolIdList = {}

	for iter_3_0 = 1, var_0_1.getLength() do
		local var_3_0 = var_0_1.indexOf(iter_3_0)

		self._poolIdList[var_3_0.level] = self._poolIdList[var_3_0.level] or {}
		self._poolIdList[var_3_0.level][var_3_0.stage] = self._poolIdList[var_3_0.level][var_3_0.stage] or var_3_0.statue_final_reward
	end
end

function GuildStatueData:updateStatueInfo(arg_4_1)
	self._awardStage = arg_4_1.awarded_stage or {}
	self._totalProg = arg_4_1.total_progress or 0

	self:_updateContRankData(arg_4_1.contributes)
	self:updateStatueData(arg_4_1)

	self._isAward = not arg_4_1.isAward
end

function GuildStatueData:updateStatueData(arg_5_1)
	self._statueData = {}

	if arg_5_1.statue then
		for iter_5_0, iter_5_1 in pairs(arg_5_1.statue.portions or {}) do
			self._statueData[iter_5_1.type] = iter_5_1
		end
	end

	if arg_5_1.stone_used then
		self._numStone = arg_5_1.stone_used
	end

	self:updateFinalAward(arg_5_1.statue)
	self:updatePartState()
end

function GuildStatueData:_updateContRankData(arg_6_1)
	local var_6_0 = arg_6_1 or {}

	self._contRankData = {}

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = g.core.model.User.guildData:getGuildMemberByPlayerId(var_6_0[iter_6_0].member_id)

		if var_6_1 then
			table.insert(self._contRankData, {
				player = var_6_1,
				contribute = var_6_0[iter_6_0].contribute,
				stone = var_6_0[iter_6_0].cost_stone,
				playerId = var_6_0[iter_6_0].member_id
			})
		end
	end

	table.sort(self._contRankData, function(arg_7_0, arg_7_1)
		if arg_7_0.contribute ~= arg_7_1.contribute then
			return arg_7_0.contribute > arg_7_1.contribute
		end

		if arg_7_0.playerId ~= arg_7_1.playerId then
			return math.uint64_lt(arg_7_0.playerId, arg_7_1.playerId)
		end
	end)

	local var_6_2 = g.core.model.User:getId()

	for iter_6_1 = 1, #self._contRankData do
		self._contRankData[iter_6_1].rank = iter_6_1

		if var_6_2 == self._contRankData[iter_6_1].playerId then
			self._meRankData = self._contRankData[iter_6_1]
		end
	end
end

function GuildStatueData:updateFinalAward(arg_8_1)
	if not arg_8_1 then
		return
	end

	local var_8_0 = arg_8_1.acquired_pos or {}

	for iter_8_0 = 1, #var_8_0 do
		self._finalAward[var_8_0[iter_8_0]] = self._finalAward[var_8_0[iter_8_0]] or {}
		self._finalAward[var_8_0[iter_8_0]].pos = var_8_0[iter_8_0]
		self._finalAward[var_8_0[iter_8_0]].userId = arg_8_1.acquired_user[iter_8_0]
		self._finalAward[var_8_0[iter_8_0]].boxId = arg_8_1.acquired_box[iter_8_0]
	end
end

function GuildStatueData:updateFinalAwardBySelf(arg_9_1)
	if arg_9_1.ret == 1 then
		self._isAward = false
	end
end

function GuildStatueData:updateAwardState(arg_10_1)
	self._awardStage = arg_10_1.awarded_stage or {}

	self:updatePartState()
end

function GuildStatueData:updateStatueByPush(arg_11_1)
	if arg_11_1.name == g.core.model.User:getName() then
		return
	end

	local var_11_0 = self._statueData[arg_11_1.type]

	if not self._statueData[arg_11_1.type] then
		return
	end

	if var_11_0.base_id ~= arg_11_1.base_id then
		var_11_0.progress = 0
		var_11_0.base_id = arg_11_1.base_id
	else
		var_11_0.progress = var_11_0.progress + arg_11_1.value
	end

	self:updatePartState()
end

function GuildStatueData:updatePartState()
	local var_12_0 = self:getStatueQuality()

	for iter_12_0, iter_12_1 in pairs(self._statueData) do
		local var_12_1 = var_0_1.get(iter_12_1.base_id).stage

		self._partState[iter_12_0] = var_12_1 > self._awardStage[iter_12_0] + 1 and 1 or var_12_1 == var_12_0 and 0 or 2
	end
end

function GuildStatueData:updateOneKeySprite(arg_13_1)
	self._statueData = {}

	if arg_13_1.statue then
		for iter_13_0, iter_13_1 in pairs(arg_13_1.statue.portions or {}) do
			self._statueData[iter_13_1.type] = iter_13_1
		end
	end

	if arg_13_1.stone_used then
		self._numStone = arg_13_1.stone_used
	end

	self:updateFinalAward(arg_13_1.statue)
end

function GuildStatueData:updateOneKeyAward(arg_14_1)
	self._awardStage = arg_14_1.awarded_stage or self._awardStage

	self:updatePartState()
end

function GuildStatueData:getStatueTimeStage()
	local var_15_0 = g.core.config.time_event_info.get(5, 0)
	local var_15_1 = g.core.config.time_event_info.get(6, 0)
	local var_15_2 = g.core.common.ServerTime:secondsFromToday()

	if var_15_2 >= var_15_0.open_time and var_15_2 <= var_15_0.end_time then
		return 0, math.floor(var_15_0.end_time / 3600), math.floor(var_15_0.end_time % 3600 / 60)
	else
		return 1, math.floor(var_15_1.end_time / 3600), math.floor(var_15_1.end_time % 3600 / 60)
	end
end

function GuildStatueData:isAvailRecAward()
	if not g.core.model.User.guildData:hasGuild() then
		return false
	end

	local var_16_0 = g.core.model.User.guildData:getJoinGuildTime()

	if not g.core.common.ServerTime:isToday(var_16_0) then
		return true
	end

	local var_16_1 = g.core.common.ServerTime:secondsFromToday(var_16_0)
	local var_16_2 = g.core.config.time_event_info.get(6, 0)

	if var_16_1 >= var_16_2.open_time and var_16_1 <= var_16_2.end_time then
		return false
	else
		return true
	end
end

function GuildStatueData:getTimeStageStr()
	local var_17_0 = g.core.config.time_event_info.get(5, 0)
	local var_17_1 = g.core.config.time_event_info.get(6, 0)

	local function var_17_2(arg_18_0)
		local var_18_0 = math.floor(arg_18_0 / 3600)
		local var_18_1 = math.floor(arg_18_0 % 3600 / 60)

		if var_18_0 < 10 then
			var_18_0 = "0" .. var_18_0
		end

		if var_18_1 < 10 then
			var_18_1 = "0" .. var_18_1
		end

		return var_18_0 .. ":" .. var_18_1
	end

	local var_17_3 = {}

	table.insert(var_17_3, {
		var_17_2(var_17_0.open_time),
		var_17_2(var_17_0.end_time)
	})
	table.insert(var_17_3, {
		var_17_2(var_17_1.open_time),
		var_17_2(var_17_1.end_time)
	})

	return var_17_3
end

function GuildStatueData:getStatueQuality()
	local var_19_0 = 100

	for iter_19_0, iter_19_1 in pairs(self._statueData) do
		var_19_0 = math.min(var_19_0, var_0_1.get(iter_19_1.base_id).stage)

		if var_19_0 == 1 then
			return 1
		end
	end

	if var_19_0 == 100 then
		var_19_0 = 1
	end

	return var_19_0
end

function GuildStatueData:getMultipleByIndex(arg_20_1)
	local var_20_0 = 1

	if arg_20_1 == 1 then
		var_20_0 = 5
	elseif arg_20_1 == 2 then
		var_20_0 = 10
	end

	return var_20_0
end

function GuildStatueData:getPartStageAwardByType(arg_21_1, arg_21_2)
	local var_21_0 = g.core.model.User.guildData:getGuildZeroLevel()
	local var_21_1 = var_0_1.get(arg_21_1.base_id)

	for iter_21_0 = 1, var_0_1.getLength() do
		local var_21_2 = var_0_1.indexOf(iter_21_0)

		if var_21_2.level == var_21_0 and var_21_2.type == arg_21_1.type and var_21_2.stage == (arg_21_2 == 2 and math.max(1, var_21_1.stage - 1) or self._awardStage[arg_21_1.type] + 1) then
			if var_21_2.next_stage_award > 0 then
				return (g.core.common.Drops:getGoodsArray(var_21_2.next_stage_award))
			else
				return {}
			end
		end
	end
end

function GuildStatueData:getPartBoxIcon(arg_22_1)
	local var_22_0 = math.min(var_0_1.get(self._statueData[arg_22_1].base_id).stage, self._awardStage[arg_22_1] + 2)
	local var_22_1 = g.core.model.User.guildData:getGuildZeroLevel()

	for iter_22_0 = 1, var_0_1.getLength() do
		local var_22_2 = var_0_1.indexOf(iter_22_0)

		if var_22_2.level == var_22_1 and var_22_2.type == arg_22_1 and var_22_2.stage == var_22_0 then
			return var_22_2.box
		end
	end

	return 3
end

function GuildStatueData:getFinalAwardPool(arg_23_1)
	local var_23_0 = {}
	local var_23_1 = g.core.model.User.guildData:getGuildZeroLevel()
	local var_23_2 = 0

	if self._poolIdList[var_23_1] then
		var_23_2 = self._poolIdList[var_23_1]
	else
		local var_23_3 = 1

		for iter_23_0, iter_23_1 in pairs(self._poolIdList) do
			if iter_23_0 <= var_23_1 then
				var_23_3 = iter_23_0
			else
				break
			end
		end

		var_23_2 = self._poolIdList[var_23_3]
	end

	local var_23_4 = g.core.config.drop_info.match(function(arg_24_0)
		return arg_24_0.id == var_23_2[arg_23_1]
	end)

	if var_23_4 then
		for iter_23_2, iter_23_3 in ipairs(var_23_4) do
			for iter_23_4 = 1, 5 do
				if iter_23_3["reward_type_" .. iter_23_4] == 0 then
					break
				end

				table.insert(var_23_0, {
					type = iter_23_3["reward_type_" .. iter_23_4],
					value = iter_23_3["reward_value_" .. iter_23_4],
					size = iter_23_3["reward_min_" .. iter_23_4]
				})
			end
		end
	end

	return var_23_0
end

function GuildStatueData:getPoolAwardCount()
	local var_25_0 = self:getFinalAwardPool((self:getStatueQuality()))
	local var_25_1 = 0

	for iter_25_0 = 1, #var_25_0 do
		var_25_1 = var_25_1 + var_25_0[iter_25_0].info.num
	end

	return var_25_1
end

function GuildStatueData:getMissAwardByType(arg_26_1, arg_26_2)
	local var_26_0 = {}
	local var_26_1 = g.core.model.User.guildData:getGuildZeroLevel()

	for iter_26_0 = 1, var_0_1.getLength() do
		local var_26_2 = var_0_1.indexOf(iter_26_0)

		if var_26_2.level == var_26_1 and var_26_2.type == arg_26_1 and var_26_2.stage >= self._awardStage[arg_26_1] + 1 and arg_26_2 > var_26_2.stage and var_26_2.next_stage_award > 0 then
			table.insert(var_26_0, (g.core.common.Drops:getGoodsArray(var_26_2.next_stage_award)))
		end
	end

	return var_26_0
end

function GuildStatueData:getMissStageAward()
	local var_27_0 = {}

	for iter_27_0 = 1, #self._partState do
		if self._partState[iter_27_0] == 1 then
			local var_27_1 = self:getMissAwardByType(iter_27_0, var_0_1.get(self._statueData[iter_27_0].base_id).stage)

			for iter_27_1 = 1, #var_27_1 do
				table.insert(var_27_0, var_27_1[iter_27_1])
			end
		end
	end

	local var_27_2 = {}

	for iter_27_2 = 1, #var_27_0 do
		for iter_27_3, iter_27_4 in pairs(var_27_0[iter_27_2]) do
			if not var_27_2[100 * iter_27_4.type + iter_27_4.value] then
				var_27_2[100 * iter_27_4.type + iter_27_4.value] = iter_27_4
			else
				var_27_2[100 * iter_27_4.type + iter_27_4.value].size = var_27_2[100 * iter_27_4.type + iter_27_4.value].size + iter_27_4.size
			end
		end
	end

	return var_27_2
end

function GuildStatueData:hasReceiveFinalAward()
	return self._isAward
end

function GuildStatueData:isStoneMax(arg_29_1)
	local var_29_0

	if not arg_29_1 then
		arg_29_1 = 1
		var_29_0 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_STATUE_STONE_MAX).parameter
	end

	return arg_29_1 + self._numStone <= var_29_0, var_29_0, var_29_0 - self._numStone
end

function GuildStatueData:getLastStoneTimes()
	return g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_STATUE_STONE_MAX).parameter - self._numStone
end

function GuildStatueData:updateRedPointData(arg_31_1)
	if not arg_31_1.guild_hint or not arg_31_1.guild_hint.statue then
		return
	end

	local var_31_0 = arg_31_1.guild_hint.statue

	self._awardStage = arg_31_1.guild_hint.statue.awarded_stage or {}
	self._canGetFinalReward = var_31_0.awarded_final or false
	self._isAward = var_31_0.awarded_final or false

	local var_31_1 = {}
	local var_31_2 = {}

	var_31_2.portions = var_31_0.portions or {}
	var_31_1.statue = var_31_2

	self:updateStatueData(var_31_1)
end

function GuildStatueData:hasFinalAwardCanGet()
	local var_32_0, var_32_1, var_32_2 = self:getStatueTimeStage()

	return var_32_0 == 1 and self._isAward
end

function GuildStatueData:hasStageAwardCanGet()
	local var_33_0, var_33_1, var_33_2 = self:getStatueTimeStage()

	if var_33_0 == 1 then
		return false
	end

	for iter_33_0, iter_33_1 in ipairs(self._partState) do
		if iter_33_1 == 1 then
			return true
		end
	end

	return false
end

function GuildStatueData:getStageAwardIds()
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in ipairs(self._partState) do
		if iter_34_1 == 1 then
			table.insert(var_34_0, iter_34_0)
		end
	end

	return var_34_0
end

function GuildStatueData:hasStatueStageAward()
	if not self:isAvailRecAward() then
		return false
	end

	for iter_35_0, iter_35_1 in pairs((self:getAllPartState())) do
		if iter_35_1 == 1 then
			return true
		end
	end

	return false
end

function GuildStatueData:getPartDataByType(arg_36_1)
	return self._statueData[arg_36_1]
end

function GuildStatueData:getStatueData()
	return self._statueData
end

function GuildStatueData:getPartStateByType(arg_38_1)
	return self._partState[arg_38_1]
end

function GuildStatueData:getFinalAward()
	return self._finalAward
end

function GuildStatueData:getAllPartState()
	return self._partState
end

function GuildStatueData:getContributeRank()
	return self._contRankData
end

function GuildStatueData:getMeRankData()
	return self._meRankData
end

function GuildStatueData:getTotalProgress()
	return self._totalProg
end

function GuildStatueData:isCanOneKeyReward()
	local var_44_0, var_44_1, var_44_2 = self:getStatueTimeStage()

	return var_44_0 == 0 and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_ONEKEY_STATUE_AWARD) and self:hasStatueStageAward()
end

function GuildStatueData:canGetStartAward()
	return self:hasFinalAwardCanGet()
end

function GuildStatueData:isHasRewardCanGet(arg_46_1)
	return g.core.model.User.guildStatueData:getPartStateByType(arg_46_1.type) == 1
end

return GuildStatueData
