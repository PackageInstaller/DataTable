local GuildBossData = class("GuildBossData")
local var_0_1 = g.core.config.guild_boss_info
local var_0_2 = g.core.config.guild_boss_rank_info
local var_0_3 = g.core.common.ServerTime
local var_0_4 = g.core.const.ConstMgr.GuildBossConst

function GuildBossData:ctor()
	self:initData()
end

function GuildBossData:initData()
	self._infoReverseList = {}
	self._infoList = {}
	self._curOpenDay = 0
	self._rankData = {}
	self._posList = {}
	self._activityInfo = nil
	self._userInfo = nil
	self._guildInfo = nil
	self._auctionAwardsBossId = 0
	self._auctionAwards = {}
	self._barrageData = {
		id = 0,
		headIndex = 0,
		barrageList = {}
	}

	self:_initBossInfo()
	self:_initRankInfo()
	self:_initPosInfo()
end

function GuildBossData:_initBossInfo()
	local var_3_0 = {}

	self._infoReverseList = {}

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		var_3_0[iter_3_1.day] = var_3_0[iter_3_1.day] or {}

		table.insert(var_3_0[iter_3_1.day], {
			info = iter_3_1:toObject()
		})
	end

	for iter_3_2, iter_3_3 in pairs(var_3_0) do
		table.insert(self._infoReverseList, {
			openDay = iter_3_2,
			infoList = iter_3_3
		})
	end

	table.sort(self._infoReverseList, function(arg_4_0, arg_4_1)
		if arg_4_0.openDay ~= arg_4_1.openDay then
			return arg_4_0.openDay > arg_4_1.openDay
		end
	end)
end

function GuildBossData:_initRankInfo()
	self._rankData = {}

	for iter_5_0, iter_5_1 in var_0_2.ipairs() do
		self._rankData[iter_5_1.action_type] = self._rankData[iter_5_1.action_type] or {}
		self._rankData[iter_5_1.action_type][iter_5_1.type] = self._rankData[iter_5_1.action_type][iter_5_1.type] or {}

		local var_5_0 = {}

		for iter_5_2, iter_5_3, iter_5_4 in iter_5_1.gmatch({
			"award_type_%d+",
			"award_value_%d+",
			"award_size_%d+"
		}) do
			table.insert(var_5_0, {
				type = iter_5_4[1],
				value = iter_5_4[2],
				size = iter_5_4[3]
			})
		end

		table.insert(self._rankData[iter_5_1.action_type][iter_5_1.type], {
			info = iter_5_1:toObject(),
			award = var_5_0
		})
	end
end

function GuildBossData:getAwardByRank(arg_6_1, arg_6_2, arg_6_3)
	for iter_6_0 = 1, #self._rankData[arg_6_1][arg_6_2] do
		if arg_6_3 >= self._rankData[arg_6_1][arg_6_2][iter_6_0].info.rank_up and arg_6_3 <= self._rankData[arg_6_1][arg_6_2][iter_6_0].info.rank_down then
			return self._rankData[arg_6_1][arg_6_2][iter_6_0].award
		end
	end

	return {}
end

function GuildBossData:_initPosInfo()
	self._posList = {}
	self._posList[1] = {}
	self._posList[2] = {}

	for iter_7_0, iter_7_1 in g.core.config.guild_boss_random_move_info.ipairs() do
		if iter_7_1.position_X > 568 then
			table.insert(self._posList[2], {
				x = iter_7_1.position_X,
				y = iter_7_1.position_Y
			})
		else
			table.insert(self._posList[1], {
				x = iter_7_1.position_X,
				y = iter_7_1.position_Y
			})
		end
	end
end

function GuildBossData:getRandomPosition()
	local var_8_0 = math.random(g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_BOSS_SHOW_PLAYER_MIN).parameter, g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_BOSS_SHOW_PLAYER_MAX).parameter)
	local var_8_1 = g.core.utils.Table.randomMultiple(self._posList[1], var_8_0)

	table.insertto(var_8_1, (g.core.utils.Table.randomMultiple(self._posList[2], var_8_0)))

	return var_8_1
end

function GuildBossData:getTodayBossInfo()
	local var_9_0 = g.core.common.ServerTime:getWeekDay()

	if var_9_0 == 0 then
		var_9_0 = 7
	end

	local var_9_1 = math.min(math.max(1, var_9_0), 7)

	self._infoList = self:getInfoList()

	if self._infoList[var_9_1] then
		return self._infoList[var_9_1].info
	end
end

function GuildBossData:getLastBossInfo()
	local var_10_0 = self:getTodayBossInfo()

	if not var_10_0 then
		return
	end

	if g.core.common.ServerTime:secondsFromToday() >= var_10_0.end_time then
		return var_10_0
	else
		local var_10_1 = g.core.common.ServerTime:getWeekDay()

		if var_10_1 == 0 then
			var_10_1 = 7
		end

		local var_10_2 = (var_10_1 + 5) % 7 + 1
		local var_10_3 = math.max(1, g.core.common.ServerTime:getOpenDays() - 1)

		for iter_10_0, iter_10_1 in ipairs(self._infoReverseList) do
			if var_10_3 >= iter_10_1.openDay then
				return iter_10_1.infoList[var_10_2].info
			end
		end
	end
end

function GuildBossData:isProcess(arg_11_1)
	arg_11_1 = arg_11_1 or g.core.common.ServerTime:getTime()

	local var_11_0 = g.core.common.ServerTime:secondsFromToday(arg_11_1)
	local var_11_1 = self:getTodayBossInfo()

	if not var_11_1 or var_11_1.is_open == 0 then
		return false
	end

	return var_11_0 >= var_11_1.start_time + ((var_11_1.type == g.core.const.ConstMgr.GuildBossConst.TYPE_CROSS_SERVER or nil) and 10) and var_11_0 < var_11_1.end_time
end

function GuildBossData:getGainScoreByRank(arg_12_1, arg_12_2)
	local var_12_0 = self:getTodayBossInfo()

	if not var_12_0 then
		return 0
	end

	local var_12_1 = self._rankData[var_12_0.type][1]

	for iter_12_0 = 1, #self._rankData[var_12_0.type][1] do
		if arg_12_1 >= var_12_1[iter_12_0].info.rank_up and arg_12_1 <= var_12_1[iter_12_0].info.rank_down then
			return math.floor(var_12_1[iter_12_0].info.fixed_gain + arg_12_2 * var_12_1[iter_12_0].info.point_gain / 10000)
		end
	end

	if #var_12_1 > 0 then
		return math.floor(var_12_1[#var_12_1].info.fixed_gain + arg_12_2 * var_12_1[#var_12_1].info.point_gain / 10000)
	end

	return 0
end

function GuildBossData:getInfoList()
	local var_13_0 = g.core.common.ServerTime:getOpenDays()

	for iter_13_0, iter_13_1 in ipairs(self._infoReverseList) do
		if var_13_0 >= iter_13_1.openDay then
			if iter_13_1.openDay == self._curOpenDay then
				return self._infoList
			else
				self._infoList = iter_13_1.infoList
				self._curOpenDay = iter_13_1.openDay

				break
			end
		end
	end

	table.sort(self._infoList, function(arg_14_0, arg_14_1)
		if arg_14_0.info.week_day == 0 ~= (arg_14_1.info.week_day == 0) then
			return arg_14_0.info.week_day ~= 0
		end

		if arg_14_0.info.week_day ~= arg_14_1.info.week_day then
			return arg_14_0.info.week_day < arg_14_1.info.week_day
		end
	end)

	return self._infoList
end

function GuildBossData:getIconCountDown()
	local var_15_0 = g.core.common.ServerTime:secondsFromToday()
	local var_15_1 = self:getTodayBossInfo()

	if not var_15_1 then
		return ""
	end

	local var_15_2 = var_15_1.start_time

	if var_15_1.end_time <= var_15_0 then
		return "activityEnd"
	end

	if var_15_0 < var_15_2 then
		return "activityPreview", g.core.common.ServerTime:getActivityLeftTime(var_15_2)
	elseif var_15_0 <= var_15_1.end_time then
		if var_15_1.end_time - var_15_0 < 86400 then
			return (g.core.common.ServerTime:getActivityLeftTime(var_15_1.end_time - var_15_0))
		else
			return ""
		end
	end

	return "activityEnd"
end

function GuildBossData:updateServerInfo(arg_16_1)
	self:updateActivityInfo(arg_16_1.info)
	self:updateUserInfo(arg_16_1.user_info)
	self:updateGuildInfo(arg_16_1.guild_info)
end

function GuildBossData:getAuctionAwards()
	local var_17_0 = self:getTodayBossInfo()

	if not var_17_0 then
		return {}
	end

	if self._auctionAwardsBossId == var_17_0.id then
		return self._auctionAwards
	else
		self._auctionAwards = {}

		local var_17_1 = {}
		local var_17_2 = var_0_3:getOpenDays()
		local var_17_3 = g.core.config.auction_info.get(var_17_0.auction_id)

		for iter_17_0, iter_17_1 in g.core.config.auction_item_info.ipairs() do
			if iter_17_1.if_show == 1 and iter_17_1.pool == var_17_3.item_pool and var_17_2 >= iter_17_1.service_time_min and var_17_2 <= iter_17_1.service_time_max then
				table.insert(var_17_1, {
					type = iter_17_1.type,
					value = iter_17_1.value,
					size = iter_17_1.size,
					sortOrder = iter_17_1.order,
					id = iter_17_1.id
				})
			end
		end

		table.sort(var_17_1, function(arg_18_0, arg_18_1)
			if arg_18_0.sortOrder ~= arg_18_1.sortOrder then
				return arg_18_0.sortOrder < arg_18_1.sortOrder
			end

			return arg_18_0.id < arg_18_1.id
		end)

		self._auctionAwards = var_17_1

		return self._auctionAwards
	end
end

function GuildBossData:updateChallengeBoss(arg_19_1)
	self:updateUserInfo(arg_19_1.user_info)
end

function GuildBossData:updateRobUser(arg_20_1)
	self:updateUserInfo(arg_20_1.user_info)
end

function GuildBossData:updateActivityInfo(arg_21_1)
	self._activityInfo = arg_21_1
end

function GuildBossData:updateUserInfo(arg_22_1)
	self._userInfo = arg_22_1
end

function GuildBossData:updateGuildInfo(arg_23_1)
	self._guildInfo = arg_23_1
end

function GuildBossData:getChallengeCountdown()
	local var_24_0 = self:getTodayBossInfo()

	if not var_24_0 then
		return 0
	end

	local var_24_1 = 0

	if self._userInfo and self._userInfo.last_challenge_time then
		var_24_1 = self._userInfo.last_challenge_time + var_24_0.challenge_gap + 5 - var_0_3:getTime()

		if self:getLeftChallengeNum() == 0 then
			var_24_1 = 0
		end
	end

	return var_24_1
end

function GuildBossData:getRobCountdown()
	local var_25_0 = self:getTodayBossInfo()

	if not var_25_0 then
		return 0
	end

	return (self._userInfo and self._userInfo.last_rob_time or nil) and self._userInfo.last_rob_time + var_25_0.rob_gap + 5 - var_0_3:getTime()
end

function GuildBossData:getLeftChallengeNum()
	local var_26_0 = self:getTodayBossInfo()

	if not var_26_0 then
		return 0
	end

	return (self._guildInfo and self._userInfo and self._userInfo.challenge_num or nil) and var_26_0.challenge_num - self._userInfo.challenge_num
end

function GuildBossData:getLeftRobNum()
	local var_27_0 = self:getTodayBossInfo()

	if not var_27_0 then
		return 0
	end

	return (self._guildInfo and self._userInfo and self._userInfo.rob_num or nil) and var_27_0.rob_num - self._userInfo.rob_num
end

function GuildBossData:getRankData(arg_28_1)
	local var_28_0 = self:getTodayBossInfo()

	if not var_28_0 then
		return {
			{},
			{}
		}
	end

	return self._rankData[arg_28_1 or var_28_0.type]
end

function GuildBossData:getBarrageList()
	local var_29_0 = self:getTodayBossInfo()

	if not var_29_0 then
		return {}
	end

	if self._barrageData.id ~= var_29_0.id then
		self._barrageData.id = var_29_0.id
		self._barrageData.barrageList = {}
	end

	return self._barrageData.barrageList
end

function GuildBossData:updateBroadcase(arg_30_1)
	local var_30_0 = self:getTodayBossInfo()

	if not var_30_0 then
		return
	end

	if self._barrageData.id ~= var_30_0.id then
		self._barrageData.id = var_30_0.id
		self._barrageData.barrageList = {}
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_1.msgs or {}) do
		local var_30_1 = self:getRankData()[var_0_4.TYPE_LOCAL_SERVER] or {}
		local var_30_2

		for iter_30_2, iter_30_3 in ipairs(var_30_1) do
			if iter_30_1.rank >= iter_30_3.info.rank_up and iter_30_1.rank <= iter_30_3.info.rank_down then
				var_30_2 = iter_30_3

				break
			end
		end

		var_30_2 = var_30_2 or var_30_1[#var_30_1]

		local var_30_3 = {
			rankInfo = var_30_2,
			rank = iter_30_1.rank,
			damage = iter_30_1.damage,
			user = iter_30_1.user,
			time = g.core.common.ServerTime:getTime(),
			aniTime = g.core.common.ServerTime:getTime()
		}

		if #self._barrageData.barrageList < var_0_4.MAX_BARRAGE then
			self._barrageData.headIndex = 1

			table.insert(self._barrageData.barrageList, var_30_3)
		else
			self._barrageData.headIndex = self._barrageData.headIndex + 1
			self._barrageData.headIndex = (self._barrageData.headIndex - 1) % var_0_4.MAX_BARRAGE + 1
			self._barrageData.barrageList[self._barrageData.headIndex] = var_30_3
		end
	end
end

function GuildBossData:isShowAtHome()
	local var_31_0 = g.core.common.ServerTime:secondsFromToday()
	local var_31_1 = self:getTodayBossInfo()

	if not var_31_1 then
		return false
	end

	return var_31_0 < var_31_1.end_time
end

function GuildBossData:getUserScore()
	return (self._userInfo or nil) and (self._userInfo.score or 0)
end

function GuildBossData:getGuildScore()
	return (self._guildInfo or nil) and (self._guildInfo.score or 0)
end

function GuildBossData:getActivityInfo()
	return self._activityInfo
end

function GuildBossData:getUserInfo()
	return self._userInfo
end

function GuildBossData:updateRedData(arg_36_1)
	self._userInfo = self._userInfo or {}
	self._userInfo.challenge_num = arg_36_1.challenge_num or 0
	self._userInfo.rob_num = arg_36_1.rob_num or 0
end

function GuildBossData:isShowRedPointByChallengeCount(arg_37_1)
	if g.core.common.ServerTime:getOpenDays() < g.core.const.ConstMgr.GuildBossConst.SHOW_NEED_OPEN_DAYS then
		return false
	end

	if not self:isProcess() then
		return false
	end

	if self:getLeftChallengeNum() > 0 then
		return true
	end

	if self:getLeftRobNum() > 0 then
		return true
	end

	return false
end

return GuildBossData
