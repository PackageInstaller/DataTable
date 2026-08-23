local HallOfFameData = class("HallOfFameData")

function HallOfFameData:ctor()
	self:initData()
end

function HallOfFameData:initData()
	self._lvRankList = {}
	self._powerRankList = {}
	self._lordRankList = {}
	self._lvHallList = {}
	self._powHallList = {}
	self._lordHallList = {}
	self._lvRank = 0
	self._fvRank = 0
	self._lordRank = 0
	self._likes = 0
	self._awards = {}
end

function HallOfFameData:updateRankInfo(arg_3_1)
	if arg_3_1.type == 1 then
		self._powerRankList = arg_3_1.users or {}
		self._fvRank = arg_3_1.self_rank
	elseif arg_3_1.type == 2 then
		self._lvRankList = arg_3_1.users or {}
		self._lvRank = arg_3_1.self_rank
	elseif arg_3_1.type == 3 then
		self._lordRankList = arg_3_1.users or {}
		self._lordRank = arg_3_1.self_rank
	end

	if arg_3_1.liked_num then
		self._likes = arg_3_1.liked_num
	end

	self:_updateHallList(arg_3_1.type)
end

function HallOfFameData:updateLikesInfo(arg_4_1)
	self._awards = arg_4_1.awards
	self._likes = arg_4_1.liked_num

	for iter_4_0, iter_4_1 in pairs(self._powerRankList) do
		if iter_4_1.id == arg_4_1.like_id then
			self._powerRankList[iter_4_0].hof_fv_like = arg_4_1.user.hof_fv_like

			if arg_4_1.type and (arg_4_1.type == 1 or arg_4_1.type == 2) then
				self._powerRankList[iter_4_0] = arg_4_1.user
			end

			break
		end
	end

	for iter_4_2, iter_4_3 in pairs(self._lvRankList) do
		if iter_4_3.id == arg_4_1.like_id then
			self._lvRankList[iter_4_2].hof_fv_like = arg_4_1.user.hof_fv_like

			if arg_4_1.type and (arg_4_1.type == 1 or arg_4_1.type == 2) then
				self._lvRankList[iter_4_2] = arg_4_1.user
			end

			break
		end
	end

	for iter_4_4, iter_4_5 in ipairs(self._lordRankList) do
		if iter_4_5.id == arg_4_1.like_id then
			self._lordRankList[iter_4_4].hof_fv_like = arg_4_1.user.hof_fv_like

			if arg_4_1.type and arg_4_1.type == 3 then
				self._lordRankList[iter_4_4] = arg_4_1.user
			end

			break
		end
	end

	self:_updateHallList(1)
	self:_updateHallList(2)
	self:_updateHallList(3)
end

function HallOfFameData:_updateHallList(arg_5_1)
	if arg_5_1 == 1 then
		self._powHallList = {}

		for iter_5_0, iter_5_1 in ipairs(self._powerRankList) do
			if iter_5_0 <= 5 then
				table.insert(self._powHallList, iter_5_1)
			end
		end
	elseif arg_5_1 == 2 then
		self._lvHallList = {}

		for iter_5_2, iter_5_3 in ipairs(self._lvRankList) do
			if iter_5_2 <= 5 then
				table.insert(self._lvHallList, iter_5_3)
			end
		end
	elseif arg_5_1 == 3 then
		self._lordHallList = {}

		for iter_5_4, iter_5_5 in ipairs(self._lordRankList) do
			if iter_5_4 <= 5 then
				table.insert(self._lordHallList, iter_5_5)
			end
		end
	end
end

function HallOfFameData:getCurRankList(arg_6_1)
	return ({
		self._powerRankList,
		self._lvRankList,
		self._lordRankList
	})[arg_6_1]
end

function HallOfFameData:getCurHallList(arg_7_1)
	return ({
		self._powHallList,
		self._lvHallList,
		self._lordHallList
	})[arg_7_1]
end

function HallOfFameData:getLikesByType()
	return self._likes
end

function HallOfFameData:getSelfRank(arg_9_1)
	return ({
		self._fvRank,
		self._lvRank,
		self._lordRank
	})[arg_9_1]
end

function HallOfFameData:getHallOfFameAwards()
	return self._awards
end

function HallOfFameData:updateRedPoint(arg_11_1)
	if not arg_11_1.hallOfFame_hint then
		return
	end

	self._likes = arg_11_1.hallOfFame_hint.like_times
end

function HallOfFameData:isLordRankUnlock()
	if not g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.LORD_RANK) then
		return false
	end

	return #self._lordHallList > 0
end

function HallOfFameData:getLordHallList()
	return self._lordHallList
end

function HallOfFameData:getMyselfIdxInLordRank()
	local var_14_0 = -1
	local var_14_1

	for iter_14_0, iter_14_1 in ipairs(self._lordRankList) do
		if g.core.model.User:getId() == iter_14_1.id then
			var_14_0 = iter_14_0
			var_14_1 = iter_14_1

			break
		end
	end

	return var_14_0, var_14_1
end

return HallOfFameData
