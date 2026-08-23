local ValentinesDayVoteData = class("ValentinesDayVoteData")
local var_0_1 = g.core.config.support_task_info
local var_0_2 = g.core.config.support_level_info
local var_0_3 = g.core.config.support_info
local ValentinesDayVoteTaskStruct = require("app.view.module.valentinesDayVote.model.struct.ValentinesDayVoteTaskStruct")
local ValentinesDayVoteLevelRewardStruct = require("app.view.module.valentinesDayVote.model.struct.ValentinesDayVoteLevelRewardStruct")
local var_0_6 = g.core.model.User.giftData
local var_0_7 = g.core.const.ConstMgr.ValentinesDayVoteConst

function ValentinesDayVoteData:ctor()
	self:initData()
end

function ValentinesDayVoteData:initData()
	self._taskDataById = {}
	self._taskDataByTab = {}
	self._levelRewardDataById = {}
	self._levelRewardData = {}
	self._actInfo = {}
	self._voteMap = {}
	self._ownVoteMap = {}
	self._isFinalVote = false
	self._allKnightsData = {}
	self._curLevel = 0
	self._totalScore = 0

	self:_initTaskData()
	self:_initLevelRewardData()
	self:_initKnightVoteData()
end

function ValentinesDayVoteData:_initTaskData()
	for iter_3_0 = 1, var_0_1.getLength() do
		local var_3_0 = var_0_1.indexOf(iter_3_0)
		local var_3_1 = ValentinesDayVoteTaskStruct.new(var_3_0.id)

		self._taskDataById[var_3_0.id] = var_3_1

		if self._taskDataByTab[var_3_0.type] then
			table.insert(self._taskDataByTab[var_3_0.type], var_3_1)
		else
			self._taskDataByTab[var_3_0.type] = {
				var_3_1
			}
		end
	end
end

function ValentinesDayVoteData:_initLevelRewardData()
	for iter_4_0 = 1, var_0_2.getLength() do
		local var_4_0 = var_0_2.indexOf(iter_4_0)
		local var_4_1 = ValentinesDayVoteLevelRewardStruct.new(var_4_0.id)

		self._levelRewardDataById[var_4_0.id] = var_4_1

		table.insert(self._levelRewardData, var_4_1)
	end
end

function ValentinesDayVoteData:_updateVoteData(arg_5_1)
	self._voteMap = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		self._voteMap[iter_5_1.knight_id] = iter_5_1.support_value
	end
end

function ValentinesDayVoteData:_updateOwnVoteData(arg_6_1)
	self._ownVoteMap = {}
	self._totalScore = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		self._ownVoteMap[iter_6_1.knight_id] = iter_6_1.support_value
		self._totalScore = self._totalScore + iter_6_1.support_value
	end

	for iter_6_2, iter_6_3 in ipairs(self._levelRewardDataById) do
		if iter_6_3:getCfg().exp > self._totalScore then
			self._curLevel = iter_6_2 - 1

			break
		end
	end

	if self._levelRewardDataById[#self._levelRewardDataById]:getCfg().exp <= self._totalScore then
		self._curLevel = #self._levelRewardDataById
	end
end

function ValentinesDayVoteData:updateTaskData(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		self._taskDataById[iter_7_1.task_id]:updateData(iter_7_1)
	end
end

function ValentinesDayVoteData:updateLevelRewardData(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		self._levelRewardDataById[iter_8_1]:updateData(true)
	end
end

function ValentinesDayVoteData:getTaskDataByTab(arg_9_1)
	return self._taskDataByTab[arg_9_1]
end

function ValentinesDayVoteData:getLevelRewardDataWithReward()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self._levelRewardData) do
		if #iter_10_1:getRewardList() > 0 then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function ValentinesDayVoteData:getLevelRewardDataById(arg_11_1)
	return self._levelRewardDataById[arg_11_1]
end

function ValentinesDayVoteData:getGiftArr()
	local var_12_0 = {}

	for iter_12_0 = 1, var_0_3.getLength() do
		local var_12_1 = var_0_6:getGiftDataById(var_0_3.indexOf(iter_12_0).gift_id)

		if var_12_1 then
			table.insert(var_12_0, var_12_1)
		end
	end

	return var_12_0
end

function ValentinesDayVoteData:getCurLevel()
	return self._curLevel
end

function ValentinesDayVoteData:getCurExpSum()
	return self._totalScore
end

function ValentinesDayVoteData:getCanGetLevelAward()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(self._levelRewardDataById) do
		if iter_15_1:getCfg().id <= self._curLevel and not iter_15_1:isGetReward() then
			for iter_15_2, iter_15_3 in ipairs((iter_15_1:getRewardList())) do
				local var_15_1 = false

				for iter_15_4, iter_15_5 in ipairs(var_15_0) do
					if iter_15_3.type == iter_15_5.type and iter_15_3.value == iter_15_5.value then
						iter_15_5.size = iter_15_5.size + iter_15_3.size
						var_15_1 = true
					end
				end

				if not var_15_1 then
					table.insert(var_15_0, {
						type = iter_15_3.type,
						value = iter_15_3.value,
						size = iter_15_3.size
					})
				end
			end
		end
	end

	return var_15_0
end

function ValentinesDayVoteData:onGetInfo(arg_16_1)
	self._actInfo = arg_16_1.activity_info or {}

	if arg_16_1.vote_data then
		self:_updateVoteData(arg_16_1.vote_data)
	end

	if arg_16_1.own_vote_data then
		self:_updateOwnVoteData(arg_16_1.own_vote_data)
	end

	self:_updateKnightsVoteData()

	if arg_16_1.task_data then
		self:updateTaskData(arg_16_1.task_data)
	end

	if arg_16_1.award_ids then
		self:updateLevelRewardData(arg_16_1.award_ids)
	end

	self._isFinalVote = arg_16_1.is_final_vote or false
end

function ValentinesDayVoteData:onVote(arg_17_1)
	return
end

function ValentinesDayVoteData:onVoteAward(arg_18_1)
	self._levelRewardDataById[arg_18_1.id]:updateData(true)
end

function ValentinesDayVoteData:onVoteAwardAll(arg_19_1)
	if arg_19_1.id then
		self:updateLevelRewardData(arg_19_1.id)
	end
end

function ValentinesDayVoteData:onTaskAward(arg_20_1)
	self._taskDataById[arg_20_1.id]:updateData({
		is_award = true,
		task_value = self._taskDataById[arg_20_1.id]:getCfg().task_value
	})
end

function ValentinesDayVoteData:onTaskAwardAll(arg_21_1)
	if arg_21_1.task_data then
		self:updateTaskData(arg_21_1.task_data)
	end
end

function ValentinesDayVoteData:onS2CFlushRedPoint(arg_22_1)
	self._actInfo = arg_22_1.act_info or {}
end

function ValentinesDayVoteData:isProcess()
	if (self._actInfo.activity_id or 0) == 0 then
		return false
	end

	local var_23_1 = g.core.common.ServerTime:getTime()
	local var_23_2 = self._actInfo.start_time or 0

	if not self._actInfo.end_time then
		-- block empty
	end

	local var_23_4 = self._actInfo.expire_time or 0
	local var_23_5 = self._actInfo.start_level or 1
	local var_23_6 = self._actInfo.end_level or 1
	local var_23_7 = g.core.model.User:getLevel()

	return var_23_2 < var_23_1 and var_23_1 < var_23_4 and var_23_5 <= var_23_7 and var_23_7 <= var_23_6 and (self._actInfo.open_days or 1) <= g.core.common.ServerTime:getOpenDays()
end

function ValentinesDayVoteData:getTimeData()
	return self._actInfo.start_time or 0, self._actInfo.end_time or 0, self._actInfo.expire_time or 0
end

function ValentinesDayVoteData:getActivityStage()
	local var_25_0 = g.core.common.ServerTime:getTime()

	if (self._actInfo.start_time or 0) < var_25_0 and var_25_0 < (self._actInfo.end_time or 0) then
		return var_0_7.ACTIVITY_STAGE.VOTE
	else
		return var_0_7.ACTIVITY_STAGE.SHOW
	end
end

function ValentinesDayVoteData:isFinalResult()
	return self._isFinalVote
end

function ValentinesDayVoteData:_caculateTotalScore()
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in pairs(self._voteMap) do
		var_27_0 = var_27_0 + iter_27_1
	end

	self._totalScore = var_27_0
end

function ValentinesDayVoteData:getActivityId()
	return self._actInfo.activity_id or 0
end

function ValentinesDayVoteData:_initKnightVoteData()
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs((g.core.model.User.knightsData:getAllPutKnight())) do
		local var_29_1 = iter_29_1:getBaseInfo()

		var_29_0[iter_29_0] = {
			myScore = 0,
			score = 0,
			rank = 0,
			knight = iter_29_1,
			quality = var_29_1.quality,
			id = var_29_1.advance_id
		}
	end

	self._allKnightsData = var_29_0

	self:_sortKnightsData()
end

function ValentinesDayVoteData:_updateKnightsVoteData()
	for iter_30_0, iter_30_1 in ipairs(self._allKnightsData) do
		iter_30_1.score = self._voteMap[iter_30_1.id] or 0
		iter_30_1.myScore = self._ownVoteMap[iter_30_1.id] or 0
	end

	self:_sortKnightsData()
end

function ValentinesDayVoteData:_sortKnightsData()
	table.sort(self._allKnightsData, function(arg_32_0, arg_32_1)
		if arg_32_0.score ~= arg_32_1.score then
			return arg_32_1.score < arg_32_0.score
		end

		if arg_32_0.quality ~= arg_32_1.quality then
			return arg_32_1.quality < arg_32_0.quality
		end

		return arg_32_0.id > arg_32_1.id
	end)

	for iter_31_0, iter_31_1 in ipairs(self._allKnightsData) do
		iter_31_1.rank = iter_31_0
	end
end

function ValentinesDayVoteData:getAllKnightsData(arg_33_1)
	arg_33_1 = arg_33_1 or 0

	if arg_33_1 == 0 then
		return self._allKnightsData
	else
		local var_33_0 = {}

		for iter_33_0, iter_33_1 in ipairs(self._allKnightsData) do
			if arg_33_1 == iter_33_1.knight:getBaseInfo().group then
				var_33_0[#var_33_0 + 1] = iter_33_1
			end
		end

		return var_33_0
	end
end

function ValentinesDayVoteData:getTopKnightData()
	return self._allKnightsData[1]
end

function ValentinesDayVoteData:hasTaskAwardCanGet(arg_35_1)
	if self:getActivityStage() == var_0_7.ACTIVITY_STAGE.VOTE then
		if arg_35_1.type then
			for iter_35_0, iter_35_1 in ipairs(self._taskDataByTab[arg_35_1.type]) do
				if not iter_35_1:isGetReward() and iter_35_1:getCurProgress() >= iter_35_1:getCfg().task_value then
					return true
				end
			end
		else
			for iter_35_2, iter_35_3 in ipairs(self._taskDataByTab) do
				for iter_35_4, iter_35_5 in pairs(iter_35_3) do
					if not iter_35_5:isGetReward() and iter_35_5:getCurProgress() >= iter_35_5:getCfg().task_value then
						return true
					end
				end
			end
		end
	end
end

function ValentinesDayVoteData:hasTicketCanVote(arg_36_1)
	if self:getActivityStage() == var_0_7.ACTIVITY_STAGE.VOTE then
		return g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, g.core.common.Goods.ITEM.TYPE_SUPPORT_TICKET) > 0
	else
		return false
	end
end

function ValentinesDayVoteData:hasLevelAwardCanGet(arg_37_1)
	if #self:getCanGetLevelAward() > 0 then
		return true
	end
end

function ValentinesDayVoteData:getActivityTime()
	if self:getActivityStage() == var_0_7.ACTIVITY_STAGE.VOTE then
		return self._actInfo.start_time, self._actInfo.end_time
	else
		return self._actInfo.end_time, self._actInfo.expire_time
	end
end

function ValentinesDayVoteData:getEnterBtnInfo()
	local var_39_0 = {
		activity_type = 3,
		activity_id = self._actInfo.activity_id,
		open_days = self._actInfo.open_days,
		preview_time = self._actInfo.start_time,
		start_time = self._actInfo.start_time,
		end_time = self._actInfo.expire_time,
		expire_time = self._actInfo.expire_time,
		start_level = self._actInfo.start_level,
		end_level = self._actInfo.end_level,
		icon_path = g.core.config.function_info.get(g.core.const.ConstMgr.FUNCTION_TYPE.VALENTINES_DAY_VOTE).icon,
		goto_module = g.view.entrance.VALENTINES_DAY_VOTE_MAIN_LAYER
	}

	var_39_0.end_time = self:getActivityStage() == var_0_7.ACTIVITY_STAGE.VOTE and self._actInfo.end_time or self._actInfo.expire_time

	return var_39_0
end

return ValentinesDayVoteData
