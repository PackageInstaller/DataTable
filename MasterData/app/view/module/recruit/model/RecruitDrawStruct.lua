local var_0_0 = g.core.const.ConstMgr.RecruitConst
local RecruitDrawStruct = class("RecruitDrawStruct")

function RecruitDrawStruct:ctor(arg_1_1, arg_1_2)
	local var_1_0

	self._netId = arg_1_1

	if arg_1_1 then
		local var_1_1 = self:_checkAndFixId(arg_1_1)

		if var_1_1 then
			self._activityId = arg_1_1
			arg_1_1 = var_1_1
		end

		var_1_0 = g.core.model.User.recruitData:getRecruitCfgByIdOrActId(arg_1_1, arg_1_2)
	elseif arg_1_2 then
		for iter_1_0 = 1, g.core.config.recruit_knight_info.getLength() do
			local var_1_2 = g.core.config.recruit_knight_info.indexOf(iter_1_0)

			if var_1_2.type == arg_1_2 then
				var_1_0 = var_1_2

				break
			end
		end
	end

	if not var_1_0 then
		return
	end

	self._cfg = var_1_0
	self._id = var_1_0.id
	self._recruitType = var_1_0.type
	self._drawDailyCount = 0
	self._drawTotalCount = 0
	self._maxFreeTimes = 0
	self._usedFreeTimes = 0
	self._freeCDTime = nil
	self._lastDrawDate = nil
	self._wishIds = {}
	self._wishLucks = {}
	self._drawDailyLimit = var_1_0.limit_num
	self._bottomInfos = {}
	self._totalLimit = var_1_0.forever_limit_num
	self._progressAwardList = {}

	local var_1_3 = g.core.config.recruit_knight_cost_gain_info.fetch(var_1_0.single_summon_cost)

	if var_1_3 then
		self._maxFreeTimes = var_1_3.daily_free_times
	end

	self:_initDrawProgressAwardList()
end

function RecruitDrawStruct:_checkAndFixId(arg_2_1, arg_2_2)
	local var_2_0 = {
		arg_2_2
	}
	local var_2_1

	if #var_2_0 == 0 then
		var_2_0 = {
			var_0_0.RECRUIT_TYPE.LIMIT,
			var_0_0.RECRUIT_TYPE.UNITE_TOKEN_LIMIT,
			var_0_0.RECRUIT_TYPE.ARTIFACT_LIMIT,
			var_0_0.RECRUIT_TYPE.PET_LIMIT,
			var_0_0.RECRUIT_TYPE.PRIMARY,
			var_0_0.RECRUIT_TYPE.LIMIT_KNIGHT_SOUL_RECRUIT,
			var_0_0.RECRUIT_TYPE.PRECIOUS,
			var_0_0.RECRUIT_TYPE.RECRUIT_ACT_UNITE_TOKEN,
			var_0_0.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING,
			var_0_0.RECRUIT_TYPE.RECRUIT_RESONATOR_CAPTAIN
		}
	end

	local var_2_2 = g.core.model.User.recruitData:getLimitRecruitDataListByType(var_2_0)

	if not var_2_2 or #var_2_2 == 0 then
		return var_2_1
	end

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		if iter_2_1:getActivityId() == arg_2_1 then
			var_2_1 = iter_2_1:getInfo().sub_activity_id or iter_2_1:getActivityValue()

			break
		end
	end

	return var_2_1
end

function RecruitDrawStruct:_initDrawProgressAwardList()
	if self._recruitType ~= var_0_0.RECRUIT_TYPE.RECRUIT_KNIGHT_SPRING and self._recruitType ~= var_0_0.RECRUIT_TYPE.RECRUIT_RESONATOR_CAPTAIN then
		return
	end

	if self._cfg.reward_group == 0 then
		return
	end

	for iter_3_0 = 1, g.core.config.recruit_knight_progress_reward_info.getLength() do
		local var_3_0 = g.core.config.recruit_knight_progress_reward_info.indexOf(iter_3_0)

		if var_3_0.group == self._cfg.reward_group then
			local var_3_1 = {
				cur = 0,
				state = "none",
				cfg = var_3_0,
				target = var_3_0.num,
				awards = {}
			}
			local var_3_2 = 1

			while g.core.config.recruit_knight_progress_reward_info.hasKey("reward_type_" .. 1) do
				if var_3_0["reward_type_" .. 1] ~= 0 then
					table.insert(var_3_1.awards, {
						type = var_3_0["reward_type_" .. 1],
						value = var_3_0["reward_value_" .. var_3_2],
						size = var_3_0["reward_size_" .. var_3_2]
					})
				end

				var_3_2 = var_3_2 + 1
			end

			self._progressAwardList[#self._progressAwardList + 1] = var_3_1
		end
	end
end

function RecruitDrawStruct:updateStruct(arg_4_1)
	self._drawTotalCount = arg_4_1.total_count
	self._drawDailyCount = arg_4_1.daily_count
	self._usedFreeTimes = arg_4_1.free_count
	self._freeCDTime = arg_4_1.free_time
	self._wishIds = arg_4_1.wish_ids or {}
	self._wishLucks = {}

	if arg_4_1.wish_luck then
		for iter_4_0, iter_4_1 in pairs(arg_4_1.wish_luck) do
			self._wishLucks[iter_4_1.id] = iter_4_1
		end
	end

	self._bottomInfos = arg_4_1.bottom or {}
	self._captainSynced = arg_4_1.captain_synced or 0

	self:updateProgressAwardList(arg_4_1.progress_award_ids or {})
end

function RecruitDrawStruct:isMatch(arg_5_1, arg_5_2)
	local var_5_0 = false

	if arg_5_1 then
		var_5_0 = self._id == arg_5_1
	elseif arg_5_2 then
		var_5_0 = self._recruitType == arg_5_2
	end

	return var_5_0
end

function RecruitDrawStruct:getCfg()
	return self._cfg
end

function RecruitDrawStruct:getNetId()
	return self._netId
end

function RecruitDrawStruct:getId()
	return self._id
end

function RecruitDrawStruct:getRecruitType()
	return self._recruitType
end

function RecruitDrawStruct:getWishIds()
	return self._wishIds
end

function RecruitDrawStruct:getWishLucks()
	return self._wishLucks
end

function RecruitDrawStruct:setDailyCount(arg_12_1)
	self._drawDailyCount = arg_12_1
end

function RecruitDrawStruct:getDailyCount()
	return self._drawDailyCount
end

function RecruitDrawStruct:getDailyLimitNum()
	return self._drawDailyLimit
end

function RecruitDrawStruct:setTotalCount(arg_15_1)
	self._drawTotalCount = arg_15_1
end

function RecruitDrawStruct:getTotalCount()
	return self._drawTotalCount
end

function RecruitDrawStruct:setMaxFreeTimes(arg_17_1)
	self._maxFreeTimes = arg_17_1
end

function RecruitDrawStruct:getMaxFreeTimes()
	return self._maxFreeTimes
end

function RecruitDrawStruct:setUsedFreeTime(arg_19_1)
	self._usedFreeTimes = arg_19_1
end

function RecruitDrawStruct:getUsedFreeTime()
	return self._usedFreeTimes
end

function RecruitDrawStruct:getLeftFreeTimes()
	return self._maxFreeTimes - self._usedFreeTimes
end

function RecruitDrawStruct:getFreeCDTime()
	return self._freeCDTime
end

function RecruitDrawStruct:setFreeCDTime(arg_23_1)
	self._freeCDTime = arg_23_1
end

function RecruitDrawStruct:getBottomInfos()
	return self._bottomInfos
end

function RecruitDrawStruct:getTotalLimitNum()
	return self._totalLimit
end

function RecruitDrawStruct:getShowQuality()
	return self._cfg.gacha_display_quality
end

function RecruitDrawStruct:getCaptainSynced()
	return self._captainSynced or 0
end

function RecruitDrawStruct:updateProgressAwardList(arg_28_1)
	self._progressAwardList = self._progressAwardList or {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		for iter_28_2, iter_28_3 in ipairs(self._progressAwardList) do
			if iter_28_3.cfg.id == iter_28_1 then
				iter_28_3.state = "got"

				break
			end
		end
	end

	self:updateProgressAwardListState()
end

function RecruitDrawStruct:updateProgressAwardListState()
	for iter_29_0, iter_29_1 in ipairs(self._progressAwardList) do
		iter_29_1.cur = self._recruitType == var_0_0.RECRUIT_TYPE.RECRUIT_RESONATOR_CAPTAIN and g.core.model.User.recruitData:getThreeThemeTicketNum() or self._drawTotalCount

		if iter_29_1.state ~= "got" and iter_29_1.cur >= iter_29_1.target then
			iter_29_1.state = "match"
		end
	end
end

function RecruitDrawStruct:getProgressAwardList()
	local var_30_0 = {}
	local var_30_1 = g.core.config.parameter_info.get(15048).parameter

	for iter_30_0, iter_30_1 in ipairs(self._progressAwardList) do
		if iter_30_1.cur < iter_30_1.target then
			var_30_1 = var_30_1 - 1
		end

		var_30_0[#var_30_0 + 1] = iter_30_1

		if var_30_1 < 0 then
			return var_30_0
		end
	end

	return var_30_0
end

function RecruitDrawStruct:getLeaderProgressAwardList()
	return self._progressAwardList
end

return RecruitDrawStruct
