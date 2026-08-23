local var_0_0 = g.core.config.subscription_info
local var_0_1 = g.core.config.privilege_info
local ActivityLifeTimeCardData = class("ActivityLifeTimeCardData")

function ActivityLifeTimeCardData:ctor()
	self:initData()
end

function ActivityLifeTimeCardData:initData()
	self._cardId = 0
	self._lastReceiveTime = 0
	self._isSubscription = false
	self._isReceiveDaily = false
	self._isReceiveNetInfo = false

	self:_initPrivilegeInfo()
	self:_initSubscriptionInfo()
end

function ActivityLifeTimeCardData:_initPrivilegeInfo()
	self._privilegeDict = {}

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		self._privilegeDict[iter_3_1.id] = iter_3_1
	end
end

function ActivityLifeTimeCardData:_initSubscriptionInfo()
	self._subscriptionIds = {}

	local var_4_0 = var_0_0.get(1)
	local var_4_1 = 1

	while var_0_0.hasKey("privilege_id_" .. var_4_1) and var_4_0["privilege_id_" .. var_4_1] > 0 do
		table.insert(self._subscriptionIds, var_4_0["privilege_id_" .. var_4_1])

		var_4_1 = var_4_1 + 1
	end

	self._subscriptionRewards = {}

	local var_4_2 = 1

	while var_0_0.hasKey("reward_type_" .. 1) and var_4_0["reward_type_" .. 1] > 0 do
		table.insert(self._subscriptionRewards, {
			type = var_4_0["reward_type_" .. 1],
			value = var_4_0["reward_value_" .. var_4_2],
			size = var_4_0["reward_size_" .. var_4_2]
		})

		var_4_2 = var_4_2 + 1
	end

	self._buyAwardList = {}
	self._buyAwardList = g.core.common.Drops:getGoodsArray(var_4_0.buy_award)
	self._rechargeInfo = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(g.core.const.ConstMgr.RechargeConst.RECHARGE_TYPE.SUBSCRIPTION, var_4_0.money)
end

function ActivityLifeTimeCardData:getSubscriptionIds()
	return self._subscriptionIds
end

function ActivityLifeTimeCardData:getPrivilegeNameById(arg_6_1)
	if self._privilegeDict[arg_6_1] then
		return self._privilegeDict[arg_6_1].name
	end

	return ""
end

function ActivityLifeTimeCardData:getBuyAwardList()
	return self._buyAwardList
end

function ActivityLifeTimeCardData:getSubscriptionRewards()
	return self._subscriptionRewards
end

function ActivityLifeTimeCardData:getRechargeInfo()
	return self._rechargeInfo
end

function ActivityLifeTimeCardData:isReceiveDaily()
	return self._isReceiveDaily
end

function ActivityLifeTimeCardData:updateReceiveStatus()
	self._lastReceiveTime = g.core.common.ServerTime:getTime()
	self._isReceiveDaily = true
end

function ActivityLifeTimeCardData:isSubscription(arg_12_1)
	if arg_12_1 then
		local var_12_0 = g.core.common.Storage:load("life_time_local_cache.json", true)

		if var_12_0 and var_12_0.vit then
			return true
		end
	end

	return self._isSubscription
end

function ActivityLifeTimeCardData:getStatus()
	if not self._isSubscription then
		return 0
	elseif self._isReceiveDaily then
		return 2
	else
		return 1
	end
end

function ActivityLifeTimeCardData:getCardId()
	return self._cardId
end

function ActivityLifeTimeCardData:updateSubscriptionStatus(arg_15_1)
	if arg_15_1 then
		local var_15_0 = arg_15_1[1]

		self._isSubscription = checkbool(arg_15_1[1].end_time > 0)
		self._lastReceiveTime = var_15_0.last_use_time
		self._isReceiveDaily = g.core.common.ServerTime:secondsFromToday(self._lastReceiveTime) >= 0
		self._cardId = var_15_0.mc_id

		if self._isSubscription then
			g.core.common.Storage:save("life_time_local_cache.json", {
				vit = true
			}, true)
		end
	end
end

function ActivityLifeTimeCardData:updateAfterOpRecharge(arg_16_1)
	if arg_16_1.insert then
		self._isSubscription = true
		self._cardId = arg_16_1.insert[1].mc_id

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.ACTIVITY_LIFETIME_CARD_BUY_SUCCESS, false)
		g.core.common.Storage:save("life_time_local_cache.json", {
			vit = true
		}, true)
	end
end

function ActivityLifeTimeCardData:hasAwardCanReceive()
	return self:getStatus() == 1
end

function ActivityLifeTimeCardData:setReceived(arg_18_1)
	self._isReceiveNetInfo = arg_18_1
end

function ActivityLifeTimeCardData:isReceivedNet()
	return self._isReceiveNetInfo
end

return ActivityLifeTimeCardData
