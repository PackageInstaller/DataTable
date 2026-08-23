local var_0_0 = g.core.config.activity_login_group_info
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.config.activity_login_reward_info
local var_0_3 = g.core.const.ConstMgr.SignActivityConst
local SignActivityData = class("SignActivityData", require("app.core.model.BaseData"))

function SignActivityData:ctor()
	self:initData()
end

function SignActivityData:initData()
	self.super.ctor(self)

	self._actSignsDict = {}
	self._actRewardDict = {}
	self._groupRewards = {}
	self._getAwardIds = {}

	self:_initGroupRewardConfig()
end

function SignActivityData:_initGroupRewardConfig()
	for iter_3_0 = 1, var_0_2.getLength() do
		local var_3_0 = var_0_2.indexOf(iter_3_0).toObject()

		self._groupRewards[var_3_0.group] = self._groupRewards[var_3_0.group] or {}

		table.insert(self._groupRewards[var_3_0.group], var_3_0)
	end
end

function SignActivityData:onS2CGmLoginGetInfo(arg_4_1)
	self._actSignsDict = {}
	self._actRewardDict = {}

	local var_4_0 = var_0_1:getTime()

	if arg_4_1.act_login_info then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.act_login_info) do
			if var_4_0 < iter_4_1.limit_end_time and not g.core.model.User.homeData:isCensorSign(iter_4_1.sub_id) then
				table.insert(self._actSignsDict, iter_4_1)
			end
		end
	end

	if arg_4_1.act_login_awards then
		self._getAwardIds = {}

		for iter_4_2, iter_4_3 in ipairs(arg_4_1.act_login_awards) do
			table.insert(self._actRewardDict, iter_4_3)

			if iter_4_3.award_ids then
				self._getAwardIds[iter_4_3.id] = self._getAwardIds[iter_4_3.id] or {}
				self._getAwardIds[iter_4_3.id] = iter_4_3.award_ids
			end
		end
	end
end

function SignActivityData:onS2CGmLoginGetAward(arg_5_1)
	if arg_5_1.id and arg_5_1.day then
		self._getAwardIds[arg_5_1.id] = self._getAwardIds[arg_5_1.id] or {}

		table.insert(self._getAwardIds[arg_5_1.id], arg_5_1.day)
	end
end

function SignActivityData:getIsSigned(arg_6_1, arg_6_2)
	if self._getAwardIds[arg_6_1] then
		for iter_6_0 = 1, #self._getAwardIds[arg_6_1] do
			local var_6_0 = var_0_2.get(self._getAwardIds[arg_6_1][iter_6_0])

			if not var_6_0 then
				return false
			end

			if var_6_0.day == arg_6_2 then
				return true
			end
		end
	end

	return false
end

function SignActivityData:getSignSvrDataBySubId(arg_7_1)
	local var_7_0

	if g.core.model.User.homeData:isCensorSign(arg_7_1) then
		return
	end

	for iter_7_0 = 1, #self._actSignsDict do
		if self._actSignsDict[iter_7_0].sub_id == arg_7_1 then
			var_7_0 = self._actSignsDict[iter_7_0]
		end
	end

	return var_7_0
end

function SignActivityData:getSignRewardsByMainId(arg_8_1)
	local var_8_0

	for iter_8_0 = 1, #self._actRewardDict do
		if self._actRewardDict[iter_8_0].id == arg_8_1 then
			var_8_0 = self._actRewardDict[iter_8_0]
		end
	end

	return var_8_0
end

function SignActivityData:getSingleDayRewardInfo(arg_9_1, arg_9_2)
	if self._groupRewards[arg_9_1] then
		for iter_9_0, iter_9_1 in ipairs(self._groupRewards[arg_9_1]) do
			if arg_9_2 == iter_9_1.day then
				return iter_9_1
			end
		end
	end
end

function SignActivityData:getSignActivityDayCount(arg_10_1)
	if arg_10_1 == 999 then
		return 7
	end

	if not self._groupRewards[arg_10_1] then
		return 0
	end

	return #self._groupRewards[arg_10_1]
end

function SignActivityData:isGroupAllSigned(arg_11_1)
	local var_11_0 = 0

	for iter_11_0 = 1, #self._actSignsDict do
		if self._actSignsDict[iter_11_0].id == arg_11_1 then
			var_11_0 = self._actSignsDict[iter_11_0].sub_id
		end
	end

	local var_11_1 = 0
	local var_11_2 = var_0_0.get(var_11_0)

	if var_11_2 then
		var_11_1 = var_11_2.group
	end

	local var_11_3 = self:getSignRewardsByMainId(arg_11_1)

	if var_11_3 then
		if var_11_3.award_ids and table.nums(var_11_3.award_ids) >= self:getSignActivityDayCount(var_11_1) then
			return true
		end
	end

	return false
end

function SignActivityData:isOnShowTime(arg_12_1)
	local var_12_0 = self:getSignSvrDataBySubId(var_0_3.SIGN_ACT_INDEX[arg_12_1])

	if var_12_0 then
		if self:isGroupAllSigned(var_12_0.id) then
			return false
		end

		if var_0_1:getTime() <= var_12_0.limit_end_time then
			return true
		end
	end

	return false
end

function SignActivityData:isCanGetSignAward(arg_13_1)
	local var_13_0 = self:getSignSvrDataBySubId(var_0_3.SIGN_ACT_INDEX[arg_13_1])

	if var_13_0 then
		if self:isGroupAllSigned(var_13_0.id) then
			return false
		end

		local var_13_1 = self:getSignRewardsByMainId(var_13_0.id)

		if var_0_1:getTime() <= var_13_0.limit_end_time and var_13_1 then
			if var_13_1.last_time == 0 or not var_0_1:isToday(var_13_1.last_time) then
				return true
			end
		end
	end

	return false
end

function SignActivityData:getCanAwardDayIdx(arg_14_1)
	local var_14_0 = 0
	local var_14_1 = self:getSignSvrDataBySubId(arg_14_1)

	if var_14_1 then
		local var_14_2 = self:getSignRewardsByMainId(var_14_1.id)

		if var_0_1:getTime() <= var_14_1.limit_end_time and var_14_2 then
			if var_14_2.award_ids then
				var_14_0 = #var_14_2.award_ids
			end
		end
	end

	return var_14_0 + 1
end

function SignActivityData:isSignActivityCanAward()
	for iter_15_0, iter_15_1 in pairs(var_0_3.SIGN_ACT_INDEX) do
		if self:isCanGetSignAward(iter_15_0) then
			return true
		end
	end

	return false
end

function SignActivityData:getLoginNameInfoByNameId(arg_16_1)
	return (g.core.config.activity_login_name_info.get(arg_16_1))
end

function SignActivityData:getLoginResInfoById(arg_17_1)
	return (g.core.config.activity_login_res_info.get(arg_17_1))
end

return SignActivityData
