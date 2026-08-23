local var_0_0 = g.core.config.arena_robot_info
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = table.insert
local var_0_3 = table.remove
local var_0_4 = table.sort
local ArenaData = class("ArenaData")

function ArenaData:ctor()
	self:initData()
end

function ArenaData:initData()
	self._challengeRank = 0
	self._rank = nil
	self._oldRank = nil
	self._challengeCount = nil
	self._haschallengeCount = 0
	self._rankRewardList = {}
	self._dailyTaskList = {}
	self._dailyChallengeCount = 0
	self._challengeList = {
		_list = {},
		add = function(self, arg_3_1)
			if not arg_3_1.isMyself then
				var_0_2(self._list, arg_3_1)
			end
		end,
		clear = function(arg_4_0)
			arg_4_0._list = {}
		end,
		remove = function(self, arg_5_1)
			var_0_3(self._list, arg_5_1)
		end,
		getLength = function(self)
			return #self._list
		end,
		sort = function(self, arg_7_1)
			var_0_4(self._list, arg_7_1)
		end,
		at = function(self, arg_8_1)
			return self._list[arg_8_1]
		end,
		getIdx = function(self, arg_9_1)
			for iter_9_0, iter_9_1 in ipairs(self._list) do
				if arg_9_1(iter_9_1) then
					return iter_9_0
				end
			end
		end
	}

	self:_initRankReward()
end

function ArenaData:getRank()
	return self._rank, self._oldRank
end

function ArenaData:updateChallengeCount(arg_11_1)
	self._challengeCount = arg_11_1 or 0
end

function ArenaData:updateHasChallengeCount(arg_12_1)
	self._haschallengeCount = arg_12_1 or 0
end

function ArenaData:getChallengeCount()
	return self._challengeCount
end

function ArenaData:getHasChallengeCount()
	return self._haschallengeCount
end

function ArenaData:getChallengeList()
	return self._challengeList
end

function ArenaData:getMaxRank()
	return self._maxRank
end

function ArenaData:getRankRewardList()
	return self._rankRewardList
end

function ArenaData:getDailyTaskList()
	return self._dailyTaskList
end

function ArenaData:getDailyChallengeCount()
	return self._dailyChallengeCount
end

function ArenaData:_initRankReward()
	local var_20_0 = {
		_list = {},
		add = function(self, arg_21_1)
			var_0_2(self._list, arg_21_1)
		end,
		remove = function(self, arg_22_1)
			var_0_3(self._list, arg_22_1)
		end,
		getLength = function(self)
			return #self._list
		end,
		at = function(self, arg_24_1)
			return self._list[arg_24_1]
		end
	}

	self._rankRewardList = var_20_0

	for iter_20_0, iter_20_1 in pairs((g.core.config.rank_award_info.match(function(arg_25_0)
		return arg_25_0.rank_type == 1
	end))) do
		var_20_0:add(iter_20_1)
	end

	function var_20_0:getRewardByRank(arg_26_1)
		arg_26_1 = arg_26_1 or self._rank

		if not arg_26_1 then
			return
		end

		for iter_26_0, iter_26_1 in ipairs(self._list) do
			if arg_26_1 >= iter_26_1.min_rank and arg_26_1 <= iter_26_1.max_rank then
				return iter_26_1, iter_26_0
			end
		end
	end

	function var_20_0:getNextRewardByRank(arg_27_1)
		local var_27_0, var_27_1 = self:getRewardByRank(arg_27_1)

		if var_27_1 then
			return self._list[var_27_1 - 1] or var_27_0
		else
			return self._list[#self._list]
		end
	end
end

function ArenaData:updateArenaData(arg_28_1)
	self._challengeList:clear()

	local var_28_0 = arg_28_1.rank

	if arg_28_1.guide_robot then
		var_28_0 = var_28_0 + 1

		self._challengeList:add(self:_createChallengeUnit(arg_28_1.guide_robot))
	end

	self._rank = var_28_0
	self._oldRank = self._oldRank or self._rank
	self._maxRank = arg_28_1.max_rank
	self._challengeCount = arg_28_1.challenge_count or 0
	self._haschallengeCount = arg_28_1.already_challenge_count or 0

	for iter_28_0, iter_28_1 in ipairs(arg_28_1.arena_units) do
		self._challengeList:add(self:_createChallengeUnit(iter_28_1))
	end

	self._challengeList:sort(function(arg_29_0, arg_29_1)
		return arg_29_0.rank > arg_29_1.rank
	end)
end

function ArenaData:updateRank(arg_30_1, arg_30_2)
	self._oldRank = self._rank

	if arg_30_2 then
		self._rank = arg_30_2
		self._maxRank = arg_30_2
	end
end

function ArenaData:_createChallengeUnit(arg_31_1)
	return {
		rank = arg_31_1.rank,
		user = arg_31_1.user,
		isMyself = arg_31_1.user.id == g.core.model.User:getId(),
		canChallenge = arg_31_1.can_challenge,
		robotId = arg_31_1.robot_id,
		isTop10 = arg_31_1.rank <= 10,
		isTop3 = arg_31_1.rank <= 3
	}
end

function ArenaData:initDailyTaskList(arg_32_1)
	local var_32_1 = {}
	local var_32_2 = 0

	for iter_32_0, iter_32_1 in ipairs(arg_32_1.daily_tasks or {}) do
		var_32_1[iter_32_1.type] = iter_32_1.value
		var_32_2 = var_32_2 + iter_32_1.value
	end

	local var_32_3 = {}

	for iter_32_2, iter_32_3 in ipairs(arg_32_1.daily_awards or {}) do
		var_32_3[iter_32_3] = true
	end

	local var_32_4 = {}

	for iter_32_4, iter_32_5 in ipairs((g.core.config.action_task_info.match(function(arg_33_0)
		return arg_33_0.module == var_0_1.TaskConst.MODULE_ID.ARENA
	end))) do
		if iter_32_5.reset_time == var_0_1.TaskConst.RESET_TYPE.EVERY_DAY then
			local var_32_5 = {
				info = iter_32_5
			}

			var_32_5.count = var_32_1[iter_32_5.require_type] or 0
			var_32_5.got = var_32_3[iter_32_5.id]

			table.insert(var_32_4, var_32_5)
		end
	end

	table.sort(var_32_4, function(arg_34_0, arg_34_1)
		if arg_34_0.got ~= arg_34_1.got then
			return arg_34_1.got
		else
			return arg_34_0.info.id < arg_34_1.info.id
		end
	end)

	self._dailyTaskList = var_32_4
	self._dailyChallengeCount = var_32_2
end

function ArenaData:getOneKeyAwardList(arg_35_1)
	local var_35_0 = {}

	if not arg_35_1 then
		return var_35_0
	end

	if arg_35_1.turn_awards then
		local var_35_1 = 0

		for iter_35_0, iter_35_1 in ipairs(arg_35_1.turn_awards) do
			var_35_1 = var_35_1 + 1
			var_35_0[var_35_1] = {}

			table.insert(var_35_0[var_35_1], (g.core.common.Goods:convert(iter_35_1)))
		end
	end

	if arg_35_1.awards then
		for iter_35_2, iter_35_3 in ipairs(arg_35_1.awards) do
			for iter_35_4, iter_35_5 in ipairs(iter_35_3.detail) do
				table.insert(var_35_0[iter_35_2], (g.core.common.Goods:convert(iter_35_5)))
			end
		end
	end

	for iter_35_6 = 1, #var_35_0 do
		var_35_0[iter_35_6] = g.core.utils.Tools.mergeAwardList(var_35_0[iter_35_6])

		table.sort(var_35_0[iter_35_6], function(arg_36_0, arg_36_1)
			local var_36_0 = arg_36_0.type == 1 and arg_36_0.value == 8
			local var_36_1 = arg_36_1.type == 1 and arg_36_1.value == 8

			if (arg_36_0.type == 1 and arg_36_0.value == 3) ~= (arg_36_1.type == 1 and arg_36_1.value == 3) then
				return arg_36_0.type == 1 and arg_36_0.value == 3
			end

			if var_36_0 ~= var_36_1 then
				return var_36_0
			end

			return arg_36_0.quality > arg_36_1.quality
		end)
	end

	return var_35_0
end

function ArenaData:setChallengeRank(arg_37_1)
	self._challengeRank = arg_37_1
end

function ArenaData:getBeChallengerSnapshot()
	if not self._challengeRank then
		return
	end

	for iter_38_0 = 1, self._challengeList:getLength() do
		local var_38_0 = self._challengeList:at(iter_38_0)

		if var_38_0.rank == self._challengeRank then
			return var_38_0.user
		end
	end
end

function ArenaData:getPaintedIdBySnapshot(arg_39_1)
	local var_39_0
	local var_39_1

	if arg_39_1.robot_type and arg_39_1.robot_type > 0 then
		var_39_0 = var_0_0.get(arg_39_1.base_id).seen_knight
	else
		var_39_0 = arg_39_1.show_knight_id

		if not arg_39_1.show_knight_id or var_39_0 == 0 then
			var_39_0 = arg_39_1.base_id
		end

		var_39_1 = arg_39_1.show_knight_dress
	end

	return g.core.model.User.knightsData:getKnightResInfo({
		knightId = var_39_0,
		skinId = var_39_1
	}).painted_id
end

function ArenaData:isExistTaskAward()
	for iter_40_0, iter_40_1 in ipairs(self._dailyTaskList) do
		if not iter_40_1.got and iter_40_1.count >= iter_40_1.info.require_value then
			return true
		end
	end
end

function ArenaData:isOneKeyGetEnable()
	if g.core.common.ModuleUnlock:isModuleUnlock(var_0_1.FUNCTION_TYPE.ARENA_ONEKEY_GET) then
		return self:isExistTaskAward()
	end
end

function ArenaData:_getTaskSortRule()
	return function(arg_43_0, arg_43_1)
		if arg_43_0.got ~= arg_43_1.got then
			return arg_43_1.got
		else
			return arg_43_0.info.id < arg_43_1.info.id
		end
	end
end

function ArenaData:onS2CFlushRedPoint(arg_44_1)
	if arg_44_1.common_hint and arg_44_1.common_hint.arena_max_rank then
		self._maxRank = arg_44_1.common_hint.arena_max_rank
	end

	local var_44_0 = arg_44_1.arena_hint

	if arg_44_1.arena_hint then
		self._challengeCount = var_44_0.challenge_count or 0
		self._haschallengeCount = var_44_0.already_challenge_count or 0

		self:initDailyTaskList(var_44_0)
	end
end

function ArenaData:onS2CGetModuleTaskAward(arg_45_1)
	for iter_45_0, iter_45_1 in ipairs(self._dailyTaskList) do
		if iter_45_1.info.id == arg_45_1 then
			iter_45_1.got = true

			break
		end
	end

	table.sort(self._dailyTaskList, self:_getTaskSortRule())
end

function ArenaData:isArenaHasLeftCount()
	if not g.core.const.ConstMgr.FUNCTION_TYPE.ARENA then
		return false
	end

	return g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.ARENA) > 0
end

return ArenaData
