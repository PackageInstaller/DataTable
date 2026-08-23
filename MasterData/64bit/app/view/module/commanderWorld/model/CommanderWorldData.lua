local var_0_0 = g.core.config.order_world_info
local var_0_1 = g.core.config.order_world_guild_info
local var_0_2 = g.core.config.order_world_task_info
local var_0_3 = g.core.config.order_world_item_info
local var_0_4 = g.core.config.rank_award_info
local var_0_5 = g.core.config.order_world_shop_info
local var_0_6 = g.core.config.order_world_rank_info
local var_0_7 = g.core.config.order_world_barrage_info
local var_0_8 = g.core.const.ConstMgr.CommanderWorldConst
local var_0_9 = g.core.common.ServerTime
local var_0_10 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.COMMANDER_WORLD
local var_0_11 = g.core.model.User.giftData
local var_0_12 = g.core.const.ConstMgr.ShopConst
local CommanderWorldData = class("CommanderWorldData", require("app.core.model.BaseData"))

function CommanderWorldData:ctor()
	CommanderWorldData.super.ctor(self)
	self:initData()
end

function CommanderWorldData:initData()
	self._rankShowInfos = {}
	self._maxLevel = 0
	self._acticityOpenTime = 0
	self._acticityCloseTime = 0
	self._localSrvDays = 0
	self._crossSrvDays = 0
	self._awardPeriodDays = 0
	self._activityHasOpenDays = 0
	self._activityGuildLevel = 0
	self._activityGuildScore = 0
	self._activityJoinGuildTime = 0
	self._activityMyScore = 0
	self._taskInfo = {}
	self._tasks = {}
	self._init = false
	self._serverOpenDays = 0
	self._commanderSubId = 0
	self._commanderShopId = 0
	self._commanderName = ""
	self._commanderRankGuaranteedScore = {}
	self._commanderGuildLevelInfo = {}
	self._commanderRankRewardInfo = {}
	self._commanderRankInfo = {}
	self._commanderShopInfo = {}
	self._commanderShopTabNames = {}
	self._commanderDonateInfo = {}
	self._commanderGuildLevelScoreInfo = {}
	self._commanderMarsRankInfo = {}
	self._commanderItemAddScore = {}
	self._commanderShopIdMap = {}
	self._commanderMarsGetRewardInfo = {}
	self._commanderLocalServerMarsLowestRank = 0
	self._commanderCrossServerMarsLowestRank = 0
	self._commanderHasGuildMarsReward = false
	self._commanderHasServerMarsReward = false
	self._commanderHasGuildLvUpReward = false
	self._commanderHasTaskReward = false
	self._commanderNoGuildTip = false
	self._commanderIsGerRewardTip = false
	self._serverInfo = {}
	self._hasGetGuildAwardNum = 0
	self._hasGetServerAwardNum = 0
	self._needFullBom = false
	self._setTimes = 0

	self:initItemAddScore()
	self:initGuildLevelInfo()
end

function CommanderWorldData:getIsGerRewardTip()
	return self._commanderIsGerRewardTip
end

function CommanderWorldData:setGuildMaxLevelTip(arg_4_1)
	self._commanderIsGerRewardTip = arg_4_1
end

function CommanderWorldData:getNoGuildTip()
	return self._commanderNoGuildTip
end

function CommanderWorldData:setNoGuildTip()
	self._commanderNoGuildTip = true
end

function CommanderWorldData:getHasGuildLvUpReward()
	if not self:checkActivityOpen() then
		return false
	end

	return checkbool(self._commanderHasGuildLvUpReward)
end

function CommanderWorldData:getHasTaskReward()
	return self._commanderHasTaskReward or false
end

function CommanderWorldData:initItemAddScore()
	self._commanderItemAddScore = {}

	for iter_9_0, iter_9_1 in var_0_3.ipairs() do
		self._commanderItemAddScore[iter_9_1.id] = {
			personScore = iter_9_1.per_num,
			guildScore = iter_9_1.guild_num,
			rewardType = iter_9_1.reward_type,
			rewardValue = iter_9_1.reward_value,
			rewardSize = iter_9_1.reward_size
		}
	end
end

function CommanderWorldData:getItemAddScoreByItemId(arg_10_1)
	return self._commanderItemAddScore[arg_10_1] or {}
end

function CommanderWorldData:getMyPersonScore()
	return self._activityMyScore
end

function CommanderWorldData:getMyGuildScore()
	return self._activityGuildScore
end

function CommanderWorldData:getNextLevelUpScore(arg_13_1)
	return self._commanderGuildLevelScoreInfo[arg_13_1] or 0
end

function CommanderWorldData:getMyGuildLevel()
	return (self._activityGuildLevel or nil) and (self._activityGuildLevel or 0)
end

function CommanderWorldData:getActivityStageAndRemainTime()
	local var_15_0 = var_0_9:getZeroClockSeconds(self._acticityOpenTime)

	if self._activityHasOpenDays <= self._localSrvDays then
		return var_0_8.STAGE.LOCALSERVICE, (var_0_9:getRemainTimeFromNow((var_0_9:getEndTimeStamp(var_15_0, self._localSrvDays))))
	elseif self._activityHasOpenDays <= self._localSrvDays + self._crossSrvDays then
		return var_0_8.STAGE.CROSSSERVICE, (var_0_9:getRemainTimeFromNow((var_0_9:getEndTimeStamp(var_15_0, self._localSrvDays + self._crossSrvDays))))
	elseif self._activityHasOpenDays <= self._localSrvDays + self._crossSrvDays + self._awardPeriodDays then
		return var_0_8.STAGE.REWARDDAY, (var_0_9:getRemainTimeFromNow((var_0_9:getEndTimeStamp(var_15_0, self._localSrvDays + self._crossSrvDays + self._awardPeriodDays))))
	end

	return 0, 0
end

function CommanderWorldData:getActivityCrossOpenTime()
	return var_0_9:getZeroClockSeconds(self._acticityOpenTime) + var_0_8.OPENDAYS.LOCALSERVICEDAY * 86400
end

function CommanderWorldData:updateTaskData(arg_17_1)
	local var_17_0 = arg_17_1 or {}

	for iter_17_0 = 1, #var_17_0 do
		local var_17_1 = var_17_0[iter_17_0]

		if self._taskInfo[var_17_0[iter_17_0].id].subId == self._commanderSubId then
			self._taskInfo[var_17_1.id].currentNum = var_17_1.value
			self._taskInfo[var_17_1.id].isFinish = var_17_1.value >= self._taskInfo[var_17_1.id].goal
			self._taskInfo[var_17_1.id].isGetReward = var_17_1.awarded
		end
	end

	self:updateTasks()
end

function CommanderWorldData:updateMarsRewardInfo(arg_18_1)
	self._hasGetAwardNum = 0
	self._commanderMarsGetRewardInfo = {}
	self._commanderMarsGetRewardInfo[1] = {}
	self._commanderMarsGetRewardInfo[2] = {}

	if self._activityJoinGuildTime <= self._localSrvDays * 86400 + g.core.common.ServerTime:getZeroClockSeconds(self._acticityOpenTime) and arg_18_1.guild_mars then
		self._hasGetGuildAwardNum = #arg_18_1.guild_mars

		for iter_18_0, iter_18_1 in ipairs(arg_18_1.guild_mars) do
			self._commanderMarsGetRewardInfo[1] = self._commanderMarsGetRewardInfo[1] or {}
			self._commanderMarsGetRewardInfo[1][iter_18_1] = 1
		end
	end

	if arg_18_1.server_mars then
		self._hasGetServerAwardNum = #arg_18_1.server_mars

		for iter_18_2, iter_18_3 in ipairs(arg_18_1.server_mars) do
			self._commanderMarsGetRewardInfo[2] = self._commanderMarsGetRewardInfo[2] or {}
			self._commanderMarsGetRewardInfo[2][iter_18_3] = 1
		end
	end
end

function CommanderWorldData:getGuildAwardNum()
	return self._hasGetGuildAwardNum
end

function CommanderWorldData:getServerAwardNum()
	return self._hasGetServerAwardNum
end

function CommanderWorldData:getMarsRewardInfo(arg_21_1, arg_21_2)
	if arg_21_1 == 1 then
		if self._activityJoinGuildTime > self._localSrvDays * 86400 + var_0_9:getZeroClockSeconds(self._acticityOpenTime) then
			return 1
		end
	end

	return self._commanderMarsGetRewardInfo[arg_21_1][arg_21_2] or 0
end

function CommanderWorldData:updateTask(arg_22_1)
	if not arg_22_1 or not self._init then
		return
	end

	local var_22_0 = arg_22_1.id

	if next(self._taskInfo) == nil then
		return
	end

	if self._taskInfo[var_22_0] then
		self._taskInfo[var_22_0].currentNum = arg_22_1.status
		self._taskInfo[var_22_0].isFinish = arg_22_1.status >= self._taskInfo[var_22_0].goal
		self._taskInfo[var_22_0].isGetReward = self._taskInfo[var_22_0].isGetReward or false
	end

	self:updateTasks()
end

function CommanderWorldData:updateTasks()
	self._tasks = {}
	self._commanderHasTaskReward = false

	for iter_23_0, iter_23_1 in pairs(self._taskInfo) do
		if not self._tasks[iter_23_1.type] then
			self._tasks[iter_23_1.type] = {}
			self._tasks[iter_23_1.type].hasReward = false
			self._tasks[iter_23_1.type].isFinish = false
		end

		self._tasks[iter_23_1.type].order = iter_23_1.order
		self._tasks[iter_23_1.type].isFinish = iter_23_1.isFinish

		if iter_23_1.isFinish and not iter_23_1.isGetReward then
			self._tasks[iter_23_1.type].hasReward = true
			self._commanderHasTaskReward = true
		end

		table.insert(self._tasks[iter_23_1.type], iter_23_1)
	end

	for iter_23_2, iter_23_3 in pairs(self._tasks) do
		table.sort(iter_23_3, function(arg_24_0, arg_24_1)
			return arg_24_0.id < arg_24_1.id
		end)

		for iter_23_4, iter_23_5 in ipairs(iter_23_3) do
			iter_23_3.isFinish = iter_23_5.isFinish
		end
	end
end

function CommanderWorldData:updateTaskAward(arg_25_1)
	self._taskInfo[arg_25_1.task_id].isGetReward = true

	self:updateTasks()
end

function CommanderWorldData:updateGuildLevelUpAwards()
	if g.core.model.User.guildData:getGuildId() == 0 then
		self._commanderHasGuildLvUpReward = false

		return
	end

	for iter_26_0, iter_26_1 in pairs(self._commanderGuildLevelInfo) do
		if iter_26_1.level <= self._activityGuildLevel and iter_26_1.hasReward == false and iter_26_1.hasGotReward == false then
			iter_26_1.hasReward = true
			iter_26_1.canRec = var_0_8.RECEIVE_STATUS.RECEIVE_ABLE
			self._commanderHasGuildLvUpReward = true
		end
	end
end

function CommanderWorldData:updateGuildLevelAwards(arg_27_1)
	arg_27_1 = arg_27_1 or {}
	self._commanderHasGuildLvUpReward = false

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		for iter_27_2, iter_27_3 in pairs(self._commanderGuildLevelInfo) do
			if iter_27_3.level + 1 == iter_27_0 then
				iter_27_3.rewardState = iter_27_1

				if iter_27_1 == 1 then
					iter_27_3.hasReward = false
					iter_27_3.hasGotReward = true
					iter_27_3.canRec = var_0_8.RECEIVE_STATUS.RECEIVE_FINISH
				elseif iter_27_1 == 0 or iter_27_1 == 2 then
					iter_27_3.hasReward = false
					iter_27_3.hasGotReward = false
					iter_27_3.canRec = var_0_8.RECEIVE_STATUS.RECEIVE_NOT_ABLE
				elseif iter_27_1 == 3 then
					iter_27_3.hasReward = true
					iter_27_3.hasGotReward = false
					iter_27_3.canRec = var_0_8.RECEIVE_STATUS.RECEIVE_ABLE
					self._commanderHasGuildLvUpReward = true
				end
			end
		end
	end
end

function CommanderWorldData:getGuildLevelName(arg_28_1)
	if self._commanderGuildLevelInfo[arg_28_1] then
		return self._commanderGuildLevelInfo[arg_28_1].name
	end

	return ""
end

function CommanderWorldData:updateGetALlGuildLevelAward()
	self._commanderHasGuildLvUpReward = false

	for iter_29_0, iter_29_1 in pairs(self._commanderGuildLevelInfo) do
		if iter_29_1.canRec == var_0_8.RECEIVE_STATUS.RECEIVE_ABLE then
			iter_29_1.hasReward = false
			iter_29_1.hasGotReward = true
			iter_29_1.canRec = var_0_8.RECEIVE_STATUS.RECEIVE_FINISH
		end
	end
end

function CommanderWorldData:updateGuildLevelAward(arg_30_1)
	self._commanderHasGuildLvUpReward = false

	local var_30_0 = arg_30_1.level or 0

	for iter_30_0, iter_30_1 in pairs(self._commanderGuildLevelInfo) do
		if var_30_0 == iter_30_1.level then
			iter_30_1.hasReward = false
			iter_30_1.hasGotReward = true
			iter_30_1.canRec = var_0_8.RECEIVE_STATUS.RECEIVE_FINISH
		elseif iter_30_1.canRec == var_0_8.RECEIVE_STATUS.RECEIVE_ABLE then
			self._commanderHasGuildLvUpReward = true
		end
	end
end

function CommanderWorldData:getTopGuildLevelAwardLevel()
	local var_31_0 = 0

	for iter_31_0 = 0, #self._commanderGuildLevelInfo do
		if self._commanderGuildLevelInfo[iter_31_0].canRec == var_0_8.RECEIVE_STATUS.RECEIVE_ABLE and not self._commanderGuildLevelInfo[iter_31_0].hasGotReward and var_31_0 < self._commanderGuildLevelInfo[iter_31_0].level + 1 then
			var_31_0 = self._commanderGuildLevelInfo[iter_31_0].level + 1
		end
	end

	return var_31_0
end

function CommanderWorldData:getBuyLimitLeft(arg_32_1)
	if arg_32_1.buy_num and arg_32_1.buy_num == 0 then
		return
	end

	return (self._commanderShopInfo[arg_32_1.shop_type][arg_32_1.goods_id].buyTimes < arg_32_1.buy_num or nil) and (arg_32_1.buy_num - self._commanderShopInfo[arg_32_1.shop_type][arg_32_1.goods_id].buyTimes or 0)
end

function CommanderWorldData:getFragNumInfo(arg_33_1)
	if not arg_33_1 then
		return false
	end

	if arg_33_1.type == g.core.common.Goods.TYPE_FRAGMENT then
		local var_33_0 = g.core.config.fragment_info.get(arg_33_1.value)

		if not var_33_0 then
			return false
		end

		local var_33_1 = g.core.model.User.fragmentsData:getFragmentNumById(arg_33_1.value)
		local var_33_2 = 0

		if var_33_0.fragment_type == g.core.common.Goods.TYPE_EQUIP then
			var_33_2 = var_33_0.combine_num
		elseif var_33_0.fragment_type == g.core.common.Goods.TYPE_UNITETOKEN then
			local var_33_3 = g.core.model.User.uniteTokenData:getTokenByAdvId(var_33_0.fragment_value)

			if var_33_3:isOwn() then
				var_33_1, var_33_2 = var_33_3:getStarUpFragmentNum()
			else
				var_33_2 = var_33_0.combine_num
			end
		elseif var_33_0.fragment_type == g.core.common.Goods.TYPE_KNIGHT then
			local var_33_4 = g.core.model.User.knightsData:getKnightByAdvanceId(var_33_0.fragment_value)

			if var_33_4:isOwn() then
				local var_33_5 = var_33_4:getBaseInfo()

				var_33_2 = var_33_5.next_star_id ~= 0 and (var_33_5.next_star_num or 0) or 0
			else
				var_33_2 = var_33_0.combine_num
			end
		elseif var_33_0.fragment_type == g.core.common.Goods.TYPE_ARTIFACT then
			local var_33_6 = g.core.model.User.artifactData:getArtifactByAdvacnceId(var_33_0.fragment_value)

			if var_33_6:isOwn() then
				if var_33_6:getCfg().nextstar ~= 0 then
					local var_33_7 = var_33_6:getStarInfo()

					var_33_2 = var_33_7.fragment_num

					while g.core.config.artifact_star_info.fetch(var_33_7.id, var_33_7.level + 1) do
						local var_33_8 = g.core.config.artifact_star_info.fetch(var_33_7.id, var_33_7.level + 1)
						local var_33_9

						if var_33_8.star == var_33_7.star then
							var_33_2 = var_33_2 + var_33_8.fragment_num
							var_33_9 = var_33_7.level + 1
						else
							break
						end
					end
				else
					var_33_2 = 0
				end
			else
				var_33_2 = var_33_0.combine_num
			end
		elseif var_33_0.fragment_type == g.core.common.Goods.TYPE_ITEM then
			var_33_2 = var_33_0.combine_num
		end

		return true, var_33_1, var_33_2
	end

	return false
end

function CommanderWorldData:getBuyItemPrice(arg_34_1, arg_34_2, arg_34_3)
	arg_34_2 = arg_34_2 or 1
	arg_34_3 = arg_34_3 or 1

	return arg_34_1["price_size_" .. arg_34_3] * arg_34_2, arg_34_1.discount
end

function CommanderWorldData:getTasks()
	return self._tasks
end

function CommanderWorldData:initTaskInfo()
	self._taskInfo = {}

	for iter_36_0, iter_36_1 in var_0_2.ipairs() do
		if iter_36_1.sub_id == self._commanderSubId then
			self._taskInfo[iter_36_1.id] = self._taskInfo[iter_36_1.id] or {}

			local var_36_0 = {
				id = iter_36_1.id,
				subId = iter_36_1.sub_id,
				type = iter_36_1.task_type,
				goal = iter_36_1.goal
			}

			var_36_0.currentNum = 0
			var_36_0.isRefresh = iter_36_1.refresh == 1
			var_36_0.isFinish = var_36_0.currentNum >= var_36_0.goal
			var_36_0.isGetReward = true
			var_36_0.order = iter_36_1.order

			local var_36_1 = {}

			while var_0_2.hasKey("reward_type_" .. 1) do
				if iter_36_1["reward_type_" .. 1] > 0 then
					table.insert(var_36_1, {
						rewardType = iter_36_1["reward_type_" .. 1],
						rewardValue = iter_36_1["reward_value_" .. 1],
						rewardSize = iter_36_1["reward_size_" .. 1]
					})
				end
			end

			var_36_0.rewardList = var_36_1
			var_36_0.taskName = iter_36_1.task_name
			var_36_0.taskDesc = iter_36_1.task_describe
			var_36_0.sourceId = iter_36_1.source_id
			self._taskInfo[iter_36_1.id] = var_36_0
		end
	end

	self:updateTasks()
end

function CommanderWorldData:initRewardInfo()
	self._commanderRankRewardInfo = {}

	for iter_37_0, iter_37_1 in var_0_4.ipairs() do
		if iter_37_1.activity_id == self._commanderSubId then
			for iter_37_2 = iter_37_1.min_rank, iter_37_1.max_rank do
				local var_37_0 = {}
				local var_37_1 = 1

				while var_0_4.hasKey("reward_type" .. var_37_1) do
					if iter_37_1["reward_type" .. var_37_1] > 0 then
						table.insert(var_37_0, {
							rewardType = iter_37_1["reward_type" .. var_37_1],
							rewardValue = iter_37_1["reward_value" .. var_37_1],
							rewardNum = iter_37_1["reward_size" .. var_37_1]
						})
					end

					var_37_1 = var_37_1 + 1
				end

				local var_37_3 = 0

				if iter_37_1.rank_type == var_0_8.REWARDTYPE.LOCALSERVICEPERSONAL then
					var_37_3 = 1
				elseif iter_37_1.rank_type == var_0_8.REWARDTYPE.LOCALSERVICEPUBLIC then
					var_37_3 = 2
				end

				self._commanderRankRewardInfo[var_37_3] = self._commanderRankRewardInfo[var_37_3] or {}
				self._commanderRankRewardInfo[var_37_3][iter_37_2] = self._commanderRankRewardInfo[var_37_3][iter_37_2] or {}

				table.insert(self._commanderRankRewardInfo[var_37_3][iter_37_2], var_37_0)
			end
		end
	end

	for iter_37_3, iter_37_4 in var_0_6.ipairs() do
		if iter_37_4.activity_id == self._commanderSubId then
			if iter_37_4.rank_type == var_0_8.REWARDTYPE.LOCALSERVICEPERSONAL and self._commanderLocalServerMarsLowestRank <= iter_37_4.max_rank then
				self._commanderLocalServerMarsLowestRank = iter_37_4.max_rank
			end

			if iter_37_4.rank_type == var_0_8.REWARDTYPE.LOCALSERVICEPUBLIC and self._commanderCrossServerMarsLowestRank < iter_37_4.max_rank then
				self._commanderCrossServerMarsLowestRank = iter_37_4.max_rank
			end

			for iter_37_5 = iter_37_4.min_rank, iter_37_4.max_rank do
				local var_37_4 = {}

				for iter_37_6 = 1, 4 do
					if iter_37_4["reward_type" .. iter_37_6] > 0 then
						if iter_37_4["reward_value" .. iter_37_6] == 0 then
							if iter_37_4["reward_size" .. iter_37_6] ~= 0 then
								table.insert(var_37_4, {
									rewardType = iter_37_4["reward_type" .. iter_37_6],
									rewardValue = iter_37_4["reward_value" .. iter_37_6],
									rewardNum = iter_37_4["reward_size" .. iter_37_6]
								})
							end
						end
					end
				end

				local var_37_7 = 0

				if iter_37_4.rank_type == var_0_8.REWARDTYPE.LOCALSERVICEPERSONAL then
					var_37_7 = 3
				elseif iter_37_4.rank_type == var_0_8.REWARDTYPE.LOCALSERVICEPUBLIC then
					var_37_7 = 4
				end

				self._commanderRankRewardInfo[var_37_7] = self._commanderRankRewardInfo[var_37_7] or {}
				self._commanderRankRewardInfo[var_37_7][iter_37_5] = self._commanderRankRewardInfo[var_37_7][iter_37_5] or {}

				table.insert(self._commanderRankRewardInfo[var_37_7][iter_37_5], var_37_4)
			end
		end
	end
end

function CommanderWorldData:getAllRankReardInfos(arg_38_1)
	return self._commanderRankRewardInfo[arg_38_1] or {}
end

function CommanderWorldData:getRankRewardInfos(arg_39_1, arg_39_2)
	return self._commanderRankRewardInfo[arg_39_1][arg_39_2] or {}
end

function CommanderWorldData:getGuildLevelInfo()
	return self._commanderGuildLevelInfo or {}
end

function CommanderWorldData:initGuildLevelInfo()
	self._commanderGuildLevelScoreInfo = {}
	self._commanderGuildLevelInfo = {}

	for iter_41_0, iter_41_1 in ipairs((var_0_1.match(function(arg_42_0)
		return arg_42_0.id == self._commanderSubId
	end))) do
		local var_41_0 = {}

		var_41_0.level = iter_41_1.level or 0
		var_41_0.name = iter_41_1.name or ""
		var_41_0.score = iter_41_1.score or 0

		if self._maxLevel < iter_41_1.level then
			self._maxLevel = iter_41_1.level
		end

		local var_41_1 = {}
		local var_41_2 = 1

		while var_0_1.hasKey("reward_type_" .. var_41_2) do
			if iter_41_1["reward_type_" .. var_41_2] == 0 and iter_41_1["reward_value_" .. var_41_2] == 0 then
				if iter_41_1["reward_size_" .. var_41_2] ~= 0 then
					table.insert(var_41_1, {
						rewardType = iter_41_1["reward_type_" .. var_41_2],
						rewardValue = iter_41_1["reward_value_" .. var_41_2],
						rewardNum = iter_41_1["reward_size_" .. var_41_2]
					})
				end
			end

			var_41_2 = var_41_2 + 1
		end

		var_41_0.rewardList = var_41_1
		var_41_0.hasReward = false
		var_41_0.hasGotReward = false
		var_41_0.canRec = var_0_8.RECEIVE_STATUS.RECEIVE_NOT_ABLE
		var_41_0.guildName = iter_41_1.guild_name
		self._commanderGuildLevelScoreInfo[iter_41_1.level] = iter_41_1.score
		self._commanderGuildLevelInfo[var_41_0.level] = var_41_0
	end
end

function CommanderWorldData:reInitDailyData()
	for iter_43_0, iter_43_1 in pairs(self._taskInfo) do
		if iter_43_1.isRefresh then
			iter_43_1.currentNum = 0
			iter_43_1.isFinish = false
			iter_43_1.isGetReward = false
		end
	end

	for iter_43_2, iter_43_3 in pairs(self._commanderShopInfo) do
		for iter_43_4, iter_43_5 in pairs(iter_43_3) do
			if iter_43_5.info.reset == 1 then
				iter_43_5.buyTimes = 0
				iter_43_5.isSold = false
			end
		end
	end
end

function CommanderWorldData:initShopInfo()
	self._commanderShopInfo = {}
	self._commanderShopIdMap = {}

	for iter_44_0, iter_44_1 in var_0_5.ipairs() do
		if iter_44_1.id == self._commanderShopId then
			self._commanderShopInfo[iter_44_1.shop_type] = self._commanderShopInfo[iter_44_1.shop_type] or {}

			if self._commanderShopTabNames[iter_44_1.shop_type] == nil then
				self._commanderShopTabNames[iter_44_1.shop_type] = iter_44_1.shop_name
			end

			self._commanderShopInfo[iter_44_1.shop_type][iter_44_1.goods_id] = {
				buyTimes = 0,
				isSold = false,
				info = iter_44_1
			}
			self._commanderShopIdMap[iter_44_1.goods_id] = iter_44_1.shop_type
		end
	end
end

function CommanderWorldData:updateBuyShopData(arg_45_1)
	for iter_45_0, iter_45_1 in pairs(self._commanderShopInfo) do
		for iter_45_2, iter_45_3 in pairs(iter_45_1) do
			if iter_45_2 == arg_45_1.goods_id then
				iter_45_3.buyTimes = arg_45_1.bought_num
				iter_45_3.isSold = iter_45_3.buyTimes >= iter_45_3.info.buy_num
			end
		end
	end
end

function CommanderWorldData:updateShopData(arg_46_1)
	arg_46_1 = arg_46_1 or {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		local var_46_0 = self._commanderShopIdMap[iter_46_1.goods_id]

		if self._commanderShopIdMap[iter_46_1.goods_id] then
			self._commanderShopInfo[var_46_0][iter_46_1.goods_id].buyTimes = iter_46_1.buy_num
			self._commanderShopInfo[var_46_0][iter_46_1.goods_id].isSold = iter_46_1.buy_num >= self._commanderShopInfo[var_46_0][iter_46_1.goods_id].info.buy_num
		end
	end
end

function CommanderWorldData:getTabNames()
	return self._commanderShopTabNames or {}
end

function CommanderWorldData:getShopDataByType(arg_48_1)
	return self._commanderShopInfo[arg_48_1] or {}
end

function CommanderWorldData:getRankGuaranteedScore(arg_49_1)
	return self._commanderRankGuaranteedScore[arg_49_1] or 0
end

function CommanderWorldData:_initBarrageInfo()
	self._conditionValueDict = {}
	self._barrageDict = {}

	for iter_50_0, iter_50_1 in var_0_7.ipairs() do
		self._barrageDict[iter_50_1.condition_type] = self._barrageDict[iter_50_1.condition_type] or {}
		self._conditionValueDict[iter_50_1.condition_type] = iter_50_1.condition_value

		table.insert(self._barrageDict[iter_50_1.condition_type], iter_50_1.barrage_value)
	end
end

function CommanderWorldData:getBarrageStyle(arg_51_1)
	local var_51_0 = 1

	for iter_51_0 = 1, #self._conditionValueDict do
		if self._conditionValueDict[iter_51_0] <= arg_51_1.num then
			var_51_0 = iter_51_0
		else
			break
		end
	end

	return g.core.lang:getByString(self._barrageDict[var_51_0][math.random(1, #self._barrageDict[var_51_0])], {
		guild = (arg_51_1.guild and arg_51_1.guild ~= "" or nil) and g.core.lang:get(410325, {
			guildName = arg_51_1.guild
		}),
		name = arg_51_1.name,
		num = arg_51_1.num
	})
end

function CommanderWorldData:initWorldData()
	local var_52_0 = var_0_0.get(self._commanderSubId)

	if var_52_0 == nil then
		return
	end

	self._commanderShopId = var_52_0.shop_id or 0
	self._commanderName = var_52_0.name or ""
	self._commanderRankGuaranteedScore[var_0_8.SERVER_TYPE.LOCAL] = var_52_0.grade_1 or 0
	self._commanderRankGuaranteedScore[var_0_8.SERVER_TYPE.CROSS] = var_52_0.grade_2 or 0

	self:initTaskInfo()
	self:initShopInfo()
	self:initGuildLevelInfo()
	self:initRewardInfo()
	self:_initBarrageInfo()
end

function CommanderWorldData:getMyRankInfo(arg_53_1)
	if not self._rankShowInfos[arg_53_1] then
		return 0
	end

	return self._rankShowInfos[arg_53_1].mySelfRank or 0
end

function CommanderWorldData:updateRankDataByNotify(arg_54_1)
	local var_54_0 = self:getActivityStageAndRemainTime()
	local var_54_1 = {}
	local var_54_2 = self._commanderLocalServerMarsLowestRank
	local var_54_3 = self:getRankGuaranteedScore(var_0_8.SERVER_TYPE.LOCAL)

	if var_54_0 == var_0_8.STAGE.LOCALSERVICE then
		var_54_1 = self._rankShowInfos[1]
	elseif var_54_0 == var_0_8.STAGE.CROSSSERVICE then
		var_54_1 = self._rankShowInfos[2]
		var_54_2 = self._commanderCrossServerMarsLowestRank
		var_54_3 = self:getRankGuaranteedScore(var_0_8.SERVER_TYPE.CROSS)
	else
		return
	end

	if var_54_3 > arg_54_1.score then
		return
	end

	local var_54_4 = g.core.model.User:getId()

	if var_54_4 == arg_54_1.id then
		self._activityMyScore = arg_54_1.score
	end

	local var_54_5 = #var_54_1.rankData + 1
	local var_54_6 = -1

	for iter_54_0 = 1, #var_54_1.rankData do
		if arg_54_1.id == var_54_1.rankData[iter_54_0].id then
			var_54_6 = iter_54_0
		end

		if arg_54_1.score > var_54_1.rankData[iter_54_0].score and iter_54_0 < var_54_5 then
			var_54_5 = iter_54_0
		elseif arg_54_1.score == var_54_1.rankData[iter_54_0].score then
			var_54_5 = iter_54_0 + 1
		end
	end

	local var_54_7

	if var_54_6 ~= -1 then
		table.remove(var_54_1.rankData, var_54_6)
		table.insert(var_54_1.rankData, var_54_5, arg_54_1)
	else
		table.insert(var_54_1.rankData, var_54_5, arg_54_1)

		var_54_7 = {}
	end

	for iter_54_1 = 1, math.min(#var_54_1.rankData, var_54_2) do
		if var_54_4 == var_54_1.rankData[iter_54_1].id then
			var_54_1.mySelfRank = iter_54_1
		end

		var_54_1.rankData[iter_54_1].rank = iter_54_1

		table.insert(var_54_7, var_54_1.rankData[iter_54_1])
	end

	var_54_1.rankData = var_54_7

	self:updateMarsRankInfo()
end

function CommanderWorldData:updateRankInfos(arg_55_1)
	local var_55_1 = table.values(arg_55_1.rank_units or {})
	local var_55_2 = arg_55_1.self_rank or 0

	if arg_55_1.id == var_0_8.RANKTYPE.LOCALSERVICERANK then
		self._rankShowInfos[1] = {}

		local var_55_3 = {}

		for iter_55_0 = 1, math.min(self._commanderLocalServerMarsLowestRank, #var_55_1) do
			table.insert(var_55_3, var_55_1[iter_55_0])
		end

		self._rankShowInfos[1].rankData = var_55_3
		self._rankShowInfos[1].mySelfRank = var_55_2
	elseif arg_55_1.id == var_0_8.RANKTYPE.CROSSSERVICERANK then
		self._rankShowInfos[2] = {}

		local var_55_4 = {}

		for iter_55_1 = 1, math.min(self._commanderCrossServerMarsLowestRank, #var_55_1) do
			table.insert(var_55_4, var_55_1[iter_55_1])
		end

		self._rankShowInfos[2].rankData = var_55_4
		self._rankShowInfos[2].mySelfRank = var_55_2
	end

	self:updateMarsRankInfo()
end

function CommanderWorldData:updateGetMarsRewardInfo(arg_56_1)
	self._commanderHasGuildMarsReward = false
	self._commanderHasServerMarsReward = false

	local var_56_0 = 1

	if arg_56_1.genre == var_0_8.REWARDTYPE.LOCALSERVICEPERSONAL then
		var_56_0 = 1
		self._hasGetGuildAwardNum = self._hasGetGuildAwardNum + 1
	elseif arg_56_1.genre == var_0_8.REWARDTYPE.LOCALSERVICEPUBLIC then
		var_56_0 = 2
		self._hasGetServerAwardNum = self._hasGetServerAwardNum + 1
	end

	self._commanderMarsGetRewardInfo[var_56_0][arg_56_1.rank] = 1

	for iter_56_0 = 1, #self._commanderMarsRankInfo do
		for iter_56_1, iter_56_2 in pairs(self._commanderMarsRankInfo[iter_56_0]) do
			if iter_56_0 == 1 then
				if self:getMarsRewardInfo(iter_56_0, iter_56_2.rank) == 0 then
					self._commanderHasGuildMarsReward = true
				end
			elseif self:getMarsRewardInfo(iter_56_0, iter_56_2.rank) == 0 then
				self._commanderHasServerMarsReward = true
			end
		end
	end
end

function CommanderWorldData:updateMarsRankInfo()
	self._commanderHasGuildMarsReward = false
	self._commanderHasServerMarsReward = false
	self._commanderMarsRankInfo[1] = {}
	self._commanderMarsRankInfo[2] = {}

	for iter_57_0 = 1, #self._rankShowInfos do
		self._commanderMarsRankInfo[iter_57_0] = {}

		if self._rankShowInfos[iter_57_0].rankData then
			for iter_57_1, iter_57_2 in ipairs(self._rankShowInfos[iter_57_0].rankData) do
				local var_57_0 = iter_57_2.user or g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_57_2.id)

				if var_57_0 then
					if iter_57_0 == 1 then
						local var_57_1 = g.core.model.User.guildData:getGuildId()

						if var_57_1 ~= 0 and var_57_1 == var_57_0.guild_id and iter_57_2.rank <= self._commanderLocalServerMarsLowestRank then
							self._commanderMarsRankInfo[1] = self._commanderMarsRankInfo[1] or {}

							table.insert(self._commanderMarsRankInfo[1], iter_57_2)

							if self:getMarsRewardInfo(1, iter_57_2.rank) == 0 then
								self._commanderHasGuildMarsReward = true
							end

							if table.nums(self._commanderMarsRankInfo[1]) >= 3 then
								break
							end
						end
					elseif iter_57_0 == 2 and g.core.platform.ServerListProxy:isSameMergeGroup(var_57_0.sid, g.core.platform.ServerListProxy:getSelectedServer().sid) and iter_57_2.rank <= self._commanderCrossServerMarsLowestRank then
						self._commanderMarsRankInfo[2] = self._commanderMarsRankInfo[2] or {}

						table.insert(self._commanderMarsRankInfo[2], iter_57_2)

						if self:getMarsRewardInfo(2, iter_57_2.rank) == 0 then
							self._commanderHasServerMarsReward = true
						end

						if table.nums(self._commanderMarsRankInfo[2]) >= 3 then
							break
						end
					end
				end
			end
		end
	end

	for iter_57_3 = 1, #self._commanderMarsRankInfo do
		table.sort(self._commanderMarsRankInfo[iter_57_3], function(arg_58_0, arg_58_1)
			return arg_58_0.rank < arg_58_1.rank
		end)
	end
end

function CommanderWorldData:getCommanderMarsRankInfo(arg_59_1)
	return self._commanderMarsRankInfo[arg_59_1] or {}
end

function CommanderWorldData:updateRedPoint(arg_60_1)
	if arg_60_1 and arg_60_1.activity then
		local var_60_0 = arg_60_1.activity.sub_id or 0

		self._serverOpenDays = arg_60_1.activity.open_day or 0
		self._activityHasOpenDays = arg_60_1.activity.days or 0
		self._acticityOpenTime = arg_60_1.activity.start_time or 0
		self._acticityCloseTime = arg_60_1.activity.end_time or 0
		self._localSrvDays = arg_60_1.activity.game_day or 0
		self._crossSrvDays = arg_60_1.activity.cross_day or 0
		self._awardPeriodDays = arg_60_1.activity.end_view_day or 0
		self._commanderHasGuildMarsReward = arg_60_1.guild_mars or false
		self._commanderHasServerMarsReward = arg_60_1.server_mars or false
		self._commanderHasGuildLvUpReward = arg_60_1.level_award or false
		self._commanderHasTaskReward = arg_60_1.task_award or false

		if var_60_0 ~= 0 and (not self._init or self._commanderSubId ~= var_60_0) then
			self._commanderSubId = var_60_0

			self:initWorldData()
			self:addToGmActivityMgr()
		end
	end
end

function CommanderWorldData:updateInfo(arg_61_1)
	if not arg_61_1.activity then
		return
	end

	self._activityHasOpenDays = arg_61_1.activity.days or 0
	self._acticityOpenTime = arg_61_1.activity.start_time or 0
	self._acticityCloseTime = arg_61_1.activity.end_time or 0
	self._localSrvDays = arg_61_1.activity.game_day or 0
	self._crossSrvDays = arg_61_1.activity.cross_day or 0
	self._awardPeriodDays = arg_61_1.activity.end_view_day or 0
	self._activityGuildLevel = arg_61_1.guild_level or 0
	self._activityGuildScore = arg_61_1.guild_score or 0
	self._activityMyScore = arg_61_1.self_score or 0
	self._activityJoinGuildTime = arg_61_1.join_guild_time or 0

	local var_61_0 = arg_61_1.activity.sub_id or 0

	if var_61_0 ~= 0 then
		if not self._init or self._commanderSubId ~= var_61_0 then
			self._commanderSubId = var_61_0
			self._init = true

			self:initWorldData()
		end

		self:updateTaskData(arg_61_1.task_list)
		self:donateRecord(arg_61_1.records)
		self:updateShopData(arg_61_1.buys)
		self:updateGuildLevelAwards(arg_61_1.guild_level_award)
		self:updateMarsRewardInfo(arg_61_1)
	end
end

function CommanderWorldData:addToGmActivityMgr()
	if self._commanderSubId == 0 then
		return
	end

	g.core.model.User.activityDataManager:addIndependentCustomActivity({
		type = var_0_10,
		id = self._commanderSubId,
		sub_activity_id = self._commanderSubId,
		start_time = self._acticityOpenTime,
		finish_time = self._acticityCloseTime
	})
end

function CommanderWorldData:updateDonate(arg_63_1)
	self._activityMyScore = arg_63_1.self_score or self._activityMyScore

	self:updateGuildLevelAwards(arg_63_1.guild_level_award)
end

function CommanderWorldData:updateDonateNotify(arg_64_1)
	self._activityGuildLevel = arg_64_1.level or self._activityGuildLevel
	self._activityGuildScore = arg_64_1.score or self._activityGuildScore

	if self._commanderGuildLevelInfo[self._activityGuildLevel] and self._commanderGuildLevelInfo[self._activityGuildLevel].canRec == var_0_8.RECEIVE_STATUS.RECEIVE_NOT_ABLE and self._activityGuildLevel > 0 and self._commanderGuildLevelInfo[self._activityGuildLevel].rewardState == 0 and self._activityGuildLevel < self._activityGuildLevel then
		self._commanderGuildLevelInfo[self._activityGuildLevel].canRec = var_0_8.RECEIVE_STATUS.RECEIVE_ABLE
		self._commanderGuildLevelInfo[self._activityGuildLevel].hasReward = true
		self._commanderHasGuildLvUpReward = true
	end
end

function CommanderWorldData:getDonateRecordByServerType(arg_65_1)
	return self._commanderDonateInfo[arg_65_1] or {}
end

function CommanderWorldData:donateRecord(arg_66_1)
	self._commanderDonateInfo[var_0_8.SERVER_TYPE.LOCAL] = {}
	self._commanderDonateInfo[var_0_8.SERVER_TYPE.CROSS] = {}

	if arg_66_1 == nil then
		return
	end

	for iter_66_0, iter_66_1 in ipairs(arg_66_1) do
		if iter_66_1.sid and g.core.platform.ServerListProxy:isSameMergeGroup(iter_66_1.sid, g.core.platform.ServerListProxy:getSelectedServer().sid) then
			if #self._commanderDonateInfo[var_0_8.SERVER_TYPE.LOCAL] < var_0_8.RECORD_UP_LIMIT then
				table.insert(self._commanderDonateInfo[var_0_8.SERVER_TYPE.LOCAL], iter_66_1)
			else
				table.remove(self._commanderDonateInfo[var_0_8.SERVER_TYPE.LOCAL], 1)
				table.insert(self._commanderDonateInfo[var_0_8.SERVER_TYPE.LOCAL], iter_66_1)
			end
		end

		if iter_66_1.sid then
			if #self._commanderDonateInfo[var_0_8.SERVER_TYPE.CROSS] < var_0_8.RECORD_UP_LIMIT then
				table.insert(self._commanderDonateInfo[var_0_8.SERVER_TYPE.CROSS], iter_66_1)
			else
				table.remove(self._commanderDonateInfo[var_0_8.SERVER_TYPE.CROSS], 1)
				table.insert(self._commanderDonateInfo[var_0_8.SERVER_TYPE.CROSS], iter_66_1)
			end
		end
	end
end

function CommanderWorldData:broadcastDonateRecord(arg_67_1)
	if arg_67_1.record.activityId == self._commanderSubId then
		local var_67_0 = arg_67_1.record or {}

		if var_67_0.sid and g.core.platform.ServerListProxy:isSameMergeGroup(var_67_0.sid, g.core.platform.ServerListProxy:getSelectedServer().sid) then
			if #self._commanderDonateInfo[var_0_8.SERVER_TYPE.LOCAL] < var_0_8.RECORD_UP_LIMIT then
				table.insert(self._commanderDonateInfo[var_0_8.SERVER_TYPE.LOCAL], var_67_0)
			else
				table.remove(self._commanderDonateInfo[var_0_8.SERVER_TYPE.LOCAL], #self._commanderDonateInfo[var_0_8.SERVER_TYPE.LOCAL])
				table.insert(self._commanderDonateInfo[var_0_8.SERVER_TYPE.LOCAL], var_67_0)
			end
		end

		if var_67_0.sid then
			if #self._commanderDonateInfo[var_0_8.SERVER_TYPE.CROSS] < var_0_8.RECORD_UP_LIMIT then
				table.insert(self._commanderDonateInfo[var_0_8.SERVER_TYPE.CROSS], var_67_0)
			else
				table.remove(self._commanderDonateInfo[var_0_8.SERVER_TYPE.CROSS], #self._commanderDonateInfo[var_0_8.SERVER_TYPE.CROSS])
				table.insert(self._commanderDonateInfo[var_0_8.SERVER_TYPE.CROSS], var_67_0)
			end
		end
	end
end

function CommanderWorldData:getMaxLevel()
	return self._maxLevel or 1
end

function CommanderWorldData:getRankShowInfos(arg_69_1)
	return self._rankShowInfos[arg_69_1] or {}
end

function CommanderWorldData:getIconCountDown()
	if self:isProcess() then
		if self._activityHasOpenDays <= 2 then
			return g.core.common.ServerTime:getLeftDHFormat(self._acticityCloseTime - 86400)
		elseif self._activityHasOpenDays <= 3 then
			return g.core.common.ServerTime:getLeftSecondsString(self._acticityCloseTime - 86400)
		else
			return "activityEnd"
		end
	else
		return ""
	end
end

function CommanderWorldData:checkActivityOpen(arg_71_1)
	if arg_71_1 and arg_71_1 ~= self._commanderSubId then
		return false
	end

	return var_0_9:getOpenDays() >= self._serverOpenDays and var_0_9:getTime() < self._acticityCloseTime
end

function CommanderWorldData:getEndTime()
	local var_72_0 = self:getActivityStageAndRemainTime()

	if var_72_0 == var_0_8.STAGE.REWARDDAY then
		return self._acticityCloseTime, g.core.lang:get(410324)
	elseif var_72_0 == var_0_8.STAGE.LOCALSERVICE or var_72_0 == var_0_8.STAGE.CROSSSERVICE then
		return self._acticityCloseTime - self._awardPeriodDays * 86400, nil
	end

	return 0, nil
end

function CommanderWorldData:isProcess()
	return self._activityHasOpenDays > 0 and not not self:checkActivityOpen()
end

function CommanderWorldData:isActivityOpen(arg_74_1)
	local var_74_0 = g.core.model.User.activityDataManager:getCustomActivityData(g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.COMMANDER_WORLD, self._commanderSubId)

	if not var_74_0 then
		return false
	end

	if not arg_74_1 then
		return var_74_0:isOpen()
	end

	return arg_74_1 == self._commanderSubId and var_74_0:isOpen()
end

function CommanderWorldData:getActivityOpenDays()
	return self._activityHasOpenDays
end

function CommanderWorldData:onS2COrderWorldGetServerInfos(arg_76_1)
	self._serverInfo = arg_76_1.server_infos
end

function CommanderWorldData:getServerInfo()
	return self._serverInfo or {}
end

function CommanderWorldData:setNeedFullBom(arg_78_1)
	self._needFullBom = arg_78_1
end

function CommanderWorldData:getNeedFullBom()
	return self._needFullBom
end

function CommanderWorldData:isMaxLevel()
	return self._activityGuildLevel >= self._maxLevel
end

function CommanderWorldData:getServerNameBySid(arg_81_1)
	for iter_81_0, iter_81_1 in ipairs(g.core.platform.ServerListProxy:getServerList() or {}) do
		if iter_81_1.id == arg_81_1 then
			return iter_81_1.name
		end
	end

	return ""
end

function CommanderWorldData:isJoinGuildBefore(arg_82_1)
	if g.core.model.User:getGuildId() == 0 then
		return false
	end

	if arg_82_1 == var_0_8.STAGE.CROSSSERVICE then
		return self._acticityOpenTime + self._localSrvDays * 86400 > self._activityJoinGuildTime
	elseif arg_82_1 == var_0_8.STAGE.REWARDDAY then
		return self._acticityOpenTime + (self._localSrvDays + self._crossSrvDays) * 86400 > self._activityJoinGuildTime
	end

	return true
end

function CommanderWorldData:isNeedPopTip()
	local var_83_0 = self:getActivityStageAndRemainTime()

	if (var_83_0 == var_0_8.STAGE.CROSSSERVICE or var_83_0 == var_0_8.STAGE.LOCALSERVICE) and g.core.model.User:getGuildId() > 0 then
		return false
	end

	local var_83_1 = g.core.common.Storage:load(var_0_8.JSON_NAME_TIP, true) or {}
	local var_83_2 = g.core.common.ServerTime:getDateObject()

	return not checkbool(var_83_1[string.format("%d_%d_%d", var_83_2.year, var_83_2.month, var_83_2.day)])
end

function CommanderWorldData:savePopStatus()
	local var_84_0 = g.core.common.Storage:load(var_0_8.JSON_NAME_TIP, true) or {}
	local var_84_1 = g.core.common.ServerTime:getDateObject()

	var_84_0[string.format("%d_%d_%d", var_84_1.year, var_84_1.month, var_84_1.day)] = true

	g.core.common.Storage:save(var_0_8.JSON_NAME_TIP, var_84_0, true)
end

function CommanderWorldData:isExistItemCanDonate(arg_85_1)
	if not self:checkActivityOpen() then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.COMMANDER_WORLD) then
		return false
	end

	if self:getActivityStageAndRemainTime() == var_0_8.STAGE.REWARDDAY then
		return false
	end

	local var_85_0 = var_0_8.DONATE_ITEM_TYPE

	if arg_85_1.itemValue then
		return g.core.model.User.bagData:getOwnNum(var_85_0, arg_85_1.itemValue) > 0
	else
		return g.core.model.User.bagData:getOwnNum(var_85_0, var_0_8.DONATE_ITEM_ID[1]) > 0 or g.core.model.User.bagData:getOwnNum(var_85_0, var_0_8.DONATE_ITEM_ID[2]) > 0
	end
end

function CommanderWorldData:hasMarsRankRewardCanReceive(arg_86_1)
	if not self:checkActivityOpen() then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.COMMANDER_WORLD) then
		return false
	end

	local var_86_0 = g.core.model.User:getGuildId()
	local var_86_1 = self:getActivityStageAndRemainTime()

	if not arg_86_1.stage then
		if var_86_1 == var_0_8.STAGE.LOCALSERVICE then
			return false
		elseif var_86_1 == var_0_8.STAGE.CROSSSERVICE then
			return var_86_0 > 0 and self._commanderHasGuildMarsReward
		elseif var_86_1 == var_0_8.STAGE.REWARDDAY then
			return (false or nil) and true
		end
	elseif arg_86_1.stage == 1 then
		if var_86_1 == var_0_8.STAGE.LOCALSERVICE then
			return false
		elseif var_86_1 == var_0_8.STAGE.CROSSSERVICE then
			return self._commanderHasGuildMarsReward
		end
	elseif arg_86_1.stage == 2 then
		if var_86_1 == var_0_8.STAGE.LOCALSERVICE then
			return false
		elseif var_86_1 == var_0_8.STAGE.CROSSSERVICE then
			return false
		elseif var_86_1 == var_0_8.STAGE.REWARDDAY then
			return self._commanderHasServerMarsReward
		end
	end

	return false
end

function CommanderWorldData:hasTaskFinished()
	if not self:checkActivityOpen() then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.COMMANDER_WORLD) then
		return false
	end

	if self:getActivityStageAndRemainTime() == var_0_8.STAGE.REWARDDAY then
		return false
	end

	return self:getHasTaskReward()
end

function CommanderWorldData:hasGiftCanReceive()
	if not self:checkActivityOpen() then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.COMMANDER_WORLD) then
		return false
	end

	if self:getActivityStageAndRemainTime() == var_0_8.STAGE.REWARDDAY then
		return false
	end

	for iter_88_0, iter_88_1 in ipairs(var_0_11:getGiftListByShopTypeValue(var_0_12.SHOP_TYPE.GIFT, var_0_12.SHOP_GIFT_VALUE.COMMANDER_GIFT) or {}) do
		if iter_88_1.diamond_price == 0 and iter_88_1.recharge_type == 0 then
			return iter_88_1.buyTimes == 0
		end
	end

	return false
end

return CommanderWorldData
