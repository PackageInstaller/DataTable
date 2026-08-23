local var_0_0 = g.core.config.celebration_login_info
local var_0_1 = g.core.config.celebration_login_reward_info
local var_0_2 = g.core.config.celebration_login_gift_info
local var_0_5 = g.core.common.ServerTime
local ActivityCelebrationLoginData = class("ActivityCelebrationLoginData", require("app.core.model.BaseData"))

function ActivityCelebrationLoginData:ctor()
	self:initData()
end

function ActivityCelebrationLoginData:initData()
	self._actInfoMap = {}
	self._svrRedMap = {}
	self._activityIdMap = {}
	self._activityIdFindMap = {}
	self._activityIdFunctionMap = {}
	self._signInDaysMap = {}
	self._loginDaysMap = {}
	self._isDailyReceived = false
	self._canRecvDays = 0
	self._rewardEndTime = 0
	self._openSvrDays = 0
	self._cumulateRewardGroupMap = {}
	self._cumulateRewardPackMap = {}
	self._cumulateRewardRecvMap = {}
	self._signRewardSendKey = ""
end

function ActivityCelebrationLoginData:_initCumulateRewardMap(arg_3_1)
	local var_3_0 = self:getCelebrationLoginInfo(arg_3_1)

	self._activityIdFunctionMap[var_3_0.function_id] = arg_3_1
	self._activityIdMap[var_3_0.group] = arg_3_1

	if self._cumulateRewardGroupMap[var_3_0.group] then
		return
	end

	self._cumulateRewardGroupMap[var_3_0.group] = {}

	for iter_3_0, iter_3_1 in var_0_2.ipairs() do
		if iter_3_1.group == var_3_0.group then
			self._cumulateRewardGroupMap[var_3_0.group][iter_3_1.day] = {
				cfg = iter_3_1
			}
			self._cumulateRewardPackMap[arg_3_1] = self._cumulateRewardPackMap[arg_3_1] or {}
			self._cumulateRewardPackMap[arg_3_1][iter_3_1.mark] = iter_3_1.pack
		end
	end
end

function ActivityCelebrationLoginData:getCelebrationLoginInfo(arg_4_1)
	return var_0_0.get(arg_4_1)
end

function ActivityCelebrationLoginData:getDailyRewardArrByActId(arg_5_1)
	local var_5_0 = self:getCelebrationLoginInfo(arg_5_1)
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in var_0_1.ipairs() do
		if iter_5_1.group == var_5_0.group then
			table.insert(var_5_1, iter_5_1)
		end
	end

	return var_5_1
end

function ActivityCelebrationLoginData:getCumulateRewardArrByActId(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(self._cumulateRewardGroupMap[self:getCelebrationLoginInfo(arg_6_1).group] or {}) do
		table.insert(var_6_0, iter_6_1)
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		return arg_7_0.cfg.day < arg_7_1.cfg.day
	end)

	return var_6_0
end

function ActivityCelebrationLoginData:getCumulatePacks(arg_8_1)
	return self._cumulateRewardPackMap[arg_8_1]
end

function ActivityCelebrationLoginData:getCumulateRewardKey(arg_9_1, arg_9_2, arg_9_3)
	return string.format("%d_%d_%d", arg_9_1, arg_9_2, arg_9_3)
end

function ActivityCelebrationLoginData:hasAwardCanReceive(arg_10_1)
	local var_10_0 = self._activityIdFunctionMap[arg_10_1] or 0

	if var_10_0 == 0 then
		return false
	end

	if self:hasDailyRewardCanReceive(var_10_0) then
		return true
	end

	if self:hasCumulateRewardCanReceive(var_10_0) then
		return true
	end

	return false
end

function ActivityCelebrationLoginData:hasDailyRewardCanReceive(arg_11_1, arg_11_2)
	local var_11_0 = 0

	if arg_11_1 then
		var_11_0 = arg_11_1
	elseif arg_11_2 then
		var_11_0 = self:getActivityIdByFunction(arg_11_2.functionId)
	end

	if self._svrRedMap[var_11_0] then
		return true
	end

	local var_11_1 = self._signInDaysMap[var_11_0] or 0

	if (self._loginDaysMap[var_11_0] or 0) <= var_11_1 then
		return false
	end

	return var_11_1 < self:getCelebrationLoginInfo(var_11_0).days
end

function ActivityCelebrationLoginData:hasCumulateRewardCanReceive(arg_12_1, arg_12_2)
	local var_12_0 = 0

	if arg_12_1 then
		var_12_0 = arg_12_1
	elseif arg_12_2 then
		var_12_0 = self:getActivityIdByFunction(arg_12_2.functionId)
	end

	if self._svrRedMap[var_12_0] then
		return true
	end

	local var_12_2 = self._signInDaysMap[var_12_0] or 0

	for iter_12_0, iter_12_1 in pairs(self._cumulateRewardGroupMap[self:getCelebrationLoginInfo(var_12_0).group] or {}) do
		if not iter_12_1.reward and var_12_2 >= iter_12_1.cfg.day then
			return true
		end
	end

	return false
end

function ActivityCelebrationLoginData:getSignInDaysByActId(arg_13_1)
	return self._signInDaysMap[arg_13_1] or 0
end

function ActivityCelebrationLoginData:getLoginDaysByActId(arg_14_1)
	return self._loginDaysMap[arg_14_1] or 0
end

function ActivityCelebrationLoginData:isDailyRewardCanRecv(arg_15_1)
	return arg_15_1 <= self._canRecvDays
end

function ActivityCelebrationLoginData:getRewardEndTimeByActId(arg_16_1)
	return (self._actInfoMap[arg_16_1] or nil) and (self._actInfoMap[arg_16_1].expire_time or 0)
end

function ActivityCelebrationLoginData:getActivityIdByGroup(arg_17_1)
	return self._activityIdMap[arg_17_1]
end

function ActivityCelebrationLoginData:isCumulateRewardReceived(arg_18_1, arg_18_2)
	if not self._cumulateRewardRecvMap[arg_18_1] then
		return false
	end

	return checkbool(self._cumulateRewardRecvMap[arg_18_1][arg_18_2])
end

function ActivityCelebrationLoginData:isShowActivity(arg_19_1)
	local var_19_0 = 0

	if arg_19_1 then
		var_19_0 = self._activityIdFunctionMap[arg_19_1]
	end

	if not var_19_0 or var_19_0 == 0 then
		return false
	end

	local var_19_1 = self:getCelebrationLoginInfo(var_19_0)

	if (self._signInDaysMap[var_19_0] or 0) < var_19_1.days then
		return true
	end

	for iter_19_0, iter_19_1 in pairs(self._cumulateRewardGroupMap[var_19_1.group]) do
		if not iter_19_1.reward then
			return true
		end
	end

	return false
end

function ActivityCelebrationLoginData:isShowEntrance(arg_20_1, arg_20_2)
	if arg_20_2 then
		arg_20_1 = self._activityIdFunctionMap[arg_20_2]
	end

	if not arg_20_1 or arg_20_1 == 0 then
		return false
	end

	return self:isTimeSatisfy(arg_20_1)
end

function ActivityCelebrationLoginData:isShowPopup(arg_21_1)
	if not self:isShowEntrance(self._activityIdFunctionMap[arg_21_1]) then
		return false
	end

	if g.core.model.User.dayNotifyTool:isTodayHasRecord("CelebrationLogin_" .. self._activityIdFunctionMap[arg_21_1], true) then
		return false
	end

	return self:hasAwardCanReceive(arg_21_1)
end

function ActivityCelebrationLoginData:isTimeSatisfy(arg_22_1)
	local var_22_0 = self._actInfoMap[arg_22_1]
	local var_22_1, var_22_2

	if not self._actInfoMap[arg_22_1] then
		do return false end

		var_22_1 = var_0_5:getTime()
		var_22_2 = var_22_0.expire_time
	end

	return var_0_5:getOpenDays() >= var_22_0.open_day and var_22_1 < var_22_2
end

function ActivityCelebrationLoginData:getActivityIdByFunction(arg_23_1)
	return self._activityIdFunctionMap[arg_23_1]
end

function ActivityCelebrationLoginData:setSignRewardSendKey(arg_24_1, arg_24_2)
	self._signRewardSendKey = arg_24_1 .. "_" .. arg_24_2
end

function ActivityCelebrationLoginData:isDaySign(arg_25_1, arg_25_2)
	return arg_25_1 .. "_" .. arg_25_2 == self._signRewardSendKey
end

function ActivityCelebrationLoginData:getKnightPreviewData(arg_26_1)
	local var_26_0 = self:getCelebrationLoginInfo(arg_26_1).group
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in var_0_1.ipairs() do
		if iter_26_1.group == var_26_0 and iter_26_1.reward_type == g.core.common.Goods.TYPE_KNIGHT then
			local var_26_2 = g.core.common.Goods:convert({
				type = iter_26_1.reward_type,
				value = iter_26_1.reward_value
			})

			var_26_1[var_26_2.quality] = var_26_1[var_26_2.quality] or {}

			table.insert(var_26_1[var_26_2.quality], {
				good = var_26_2,
				isGot = iter_26_1.day <= self:getSignInDaysByActId(arg_26_1)
			})
		end
	end

	local var_26_3 = g.core.common.Drops:getKeyLength()

	for iter_26_2, iter_26_3 in pairs(self._cumulateRewardPackMap[arg_26_1]) do
		local var_26_4 = 1
		local var_26_5 = g.core.config.drop_info.get(iter_26_3, 1)

		while var_26_5 do
			for iter_26_4 = 1, var_26_3 do
				if var_26_5["reward_type_" .. iter_26_4] ~= 0 then
					if var_26_5["reward_type_" .. iter_26_4] == g.core.common.Goods.TYPE_KNIGHT then
						local var_26_6 = g.core.common.Goods:convert({
							type = var_26_5["reward_type_" .. iter_26_4],
							value = var_26_5["reward_value_" .. iter_26_4]
						})
						local var_26_7

						if not var_26_1[var_26_6.quality] then
							var_26_1[var_26_6.quality] = {}
							var_26_7 = {
								good = var_26_6
							}
						end

						var_26_7.isGot = checkbool(self._cumulateRewardRecvMap[arg_26_1][self:getCumulateRewardKey(iter_26_2, var_26_5["reward_type_" .. iter_26_4], var_26_5["reward_value_" .. iter_26_4])])

						table.insert(var_26_1[var_26_6.quality], var_26_7)
					end
				else
					break
				end
			end

			var_26_4 = var_26_4 + 1
			var_26_5 = g.core.config.drop_info.fetch(iter_26_3, var_26_4)
		end
	end

	table.sort(var_26_1)

	return var_26_1
end

function ActivityCelebrationLoginData:onS2CCelebrationLoginGetInfo(arg_27_1)
	self:_updateLoginInfo(arg_27_1.login or {})
end

function ActivityCelebrationLoginData:onS2CCelebrationLoginSignReward(arg_28_1)
	local var_28_0 = self._activityIdFindMap[arg_28_1.id] or 0

	if var_28_0 == 0 then
		return
	end

	self._signInDaysMap[var_28_0] = self._loginDaysMap[var_28_0] or 0
end

function ActivityCelebrationLoginData:onS2CCelebrationLoginDrawGift(arg_29_1)
	local var_29_0 = self:getActivityIdBySvrId(arg_29_1.id) or 0

	if var_29_0 == 0 then
		return
	end

	local var_29_1 = self._cumulateRewardGroupMap[self:getCelebrationLoginInfo(var_29_0).group][arg_29_1.gift.sign_day]

	if var_29_1 then
		var_29_1.reward = {
			type = arg_29_1.gift.award_type,
			value = arg_29_1.gift.award_value
		}
		self._cumulateRewardRecvMap[var_29_0] = self._cumulateRewardRecvMap[var_29_0] or {}
		self._cumulateRewardRecvMap[var_29_0][self:getCumulateRewardKey(var_29_1.cfg.mark, arg_29_1.gift.award_type, arg_29_1.gift.award_value)] = true
	end
end

function ActivityCelebrationLoginData:onRecvActNotice(arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(arg_30_1.activity_list) do
		local var_30_0 = iter_30_1.sub_id or 0

		if var_30_0 > 0 then
			self._actInfoMap[var_30_0] = iter_30_1
			self._activityIdFindMap[iter_30_1.id] = var_30_0

			self:_initCumulateRewardMap(var_30_0)
		end
	end

	for iter_30_2, iter_30_3 in pairs(arg_30_1.logins) do
		if self._activityIdFindMap[iter_30_3.id] > 0 then
			self:_updateLoginInfo(iter_30_3 or {})
		end
	end
end

function ActivityCelebrationLoginData:updateRedPoint(arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(arg_31_1) do
		local var_31_0 = iter_31_1.activity.sub_id or 0

		if var_31_0 > 0 then
			self._actInfoMap[var_31_0] = iter_31_1.activity
			self._activityIdFindMap[iter_31_1.activity.id] = var_31_0
			self._svrRedMap[var_31_0] = checkbool(iter_31_1.is_hint)

			self:_initCumulateRewardMap(var_31_0)
			g.core.network.GameNetProxy:send_C2S_CelebrationLogin_GetInfo({
				id = iter_31_1.activity.id
			})
		end
	end
end

function ActivityCelebrationLoginData:_updateLoginInfo(arg_32_1)
	local var_32_0 = self:getActivityIdBySvrId((arg_32_1 or nil) and (arg_32_1.id or 0))

	if var_32_0 == 0 then
		return
	end

	self._svrRedMap[var_32_0] = false

	local var_32_1 = self._cumulateRewardGroupMap[self:getCelebrationLoginInfo(var_32_0).group]

	self._signInDaysMap[var_32_0] = arg_32_1.sign_day or 0
	self._loginDaysMap[var_32_0] = arg_32_1.login_day or 0

	for iter_32_0, iter_32_1 in ipairs(arg_32_1.gifts or {}) do
		if var_32_1[iter_32_1.sign_day] then
			var_32_1[iter_32_1.sign_day].reward = {
				type = iter_32_1.award_type,
				value = iter_32_1.award_value
			}
			self._cumulateRewardRecvMap[var_32_0] = self._cumulateRewardRecvMap[var_32_0] or {}
			self._cumulateRewardRecvMap[var_32_0][self:getCumulateRewardKey(var_32_1[iter_32_1.sign_day].cfg.mark, iter_32_1.award_type, iter_32_1.award_value)] = true
		end
	end
end

function ActivityCelebrationLoginData:getActivityIdBySvrId(arg_33_1)
	return self._activityIdFindMap[arg_33_1] or 0
end

function ActivityCelebrationLoginData:getSvrIdByActivityId(arg_34_1)
	for iter_34_0, iter_34_1 in pairs(self._activityIdFindMap) do
		if arg_34_1 == iter_34_1 then
			return iter_34_0
		end
	end

	return 0
end

return ActivityCelebrationLoginData
