local ActivityOnlineGiftData = class("ActivityOnlineGiftData")
local var_0_1 = g.core.config.online_gift_info
local var_0_2 = g.core.const.ConstMgr.ActivityConst

function ActivityOnlineGiftData:ctor()
	self:initData()
end

function ActivityOnlineGiftData:initData()
	self._infoList = {}
	self._lastAwardTime = 0
	self._recAward = {}
	self._isHasData = false

	self:_initOnlineInfo()
end

function ActivityOnlineGiftData:_initOnlineInfo()
	self._infoList = {}

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		table.insert(self._infoList, {
			isReceive = false,
			recTime = 0,
			info = iter_3_1:toObject()
		})
	end

	table.sort(self._infoList, function(arg_4_0, arg_4_1)
		if arg_4_0.info.order ~= arg_4_1.info.order then
			return arg_4_0.info.order < arg_4_1.info.order
		end
	end)

	for iter_3_2 = 1, #self._infoList do
		local var_3_0 = self._infoList[iter_3_2]

		var_3_0.waitTime = iter_3_2 == 1 and var_3_0.info.time or var_3_0.info.time - self._infoList[iter_3_2 - 1].info.time
	end
end

function ActivityOnlineGiftData:updateInfo(arg_5_1)
	self._isHasData = self._isHasData or true
	self._recAward = arg_5_1.reward_record or {}
	self._lastAwardTime = arg_5_1.last_award_time or 0

	self:_updateAwardState()
end

function ActivityOnlineGiftData:updateAwardData(arg_6_1)
	self._recAward = arg_6_1.reward_record or {}
	self._lastAwardTime = arg_6_1.last_award_time or 0

	self:_updateAwardState()
end

function ActivityOnlineGiftData:_updateAwardState()
	self:_initOnlineInfo()

	for iter_7_0 = 1, #self._recAward do
		for iter_7_1 = 1, #self._infoList do
			if self._infoList[iter_7_1].info.order == self._recAward[iter_7_0].id then
				self._infoList[iter_7_1].isReceive = true

				break
			end
		end
	end
end

function ActivityOnlineGiftData:getCurGift()
	for iter_8_0 = 1, #self._infoList do
		if not self._infoList[iter_8_0].isReceive then
			local var_8_0 = self._infoList[iter_8_0]
			local var_8_1 = self._lastAwardTime + self._infoList[iter_8_0].waitTime - g.core.common.ServerTime:getTime()

			if var_8_1 > 0 then
				var_8_0.state = 0
				var_8_0.curRemainTime = var_8_1
			else
				var_8_0.state = 1
				var_8_0.curRemainTime = 0
			end

			var_8_0.endTime = self._lastAwardTime + var_8_0.waitTime

			return self._infoList[iter_8_0]
		end
	end
end

function ActivityOnlineGiftData:getAllGift()
	return self._infoList
end

function ActivityOnlineGiftData:isAllReceive()
	return #self._recAward == #self._infoList
end

function ActivityOnlineGiftData:isHasData()
	return self._isHasData
end

function ActivityOnlineGiftData:isCanGetCurAward()
	local var_12_0 = g.core.model.User.activityDataManager:getActivityDataDuringDisplay(var_0_2.ACTIVITY_SOURCE_TYPE.CONFIG_TABLE, var_0_2.ACTIVITY_TYPE.ONLINE_GIFT)

	if var_12_0 and g.core.common.ModuleUnlock:isModuleUnlock((var_12_0:getFunctionId())) and var_12_0:isDuringDisplay() then
		local var_12_1 = self:getCurGift()

		if var_12_1 and var_12_1.state == 1 then
			return true
		end
	end

	return false
end

function ActivityOnlineGiftData:isCanShowOnlineAwardBtn()
	local var_13_0 = g.core.model.User.activityDataManager:getActivityDataDuringDisplay(var_0_2.ACTIVITY_SOURCE_TYPE.CONFIG_TABLE, var_0_2.ACTIVITY_TYPE.ONLINE_GIFT)

	if var_13_0 and var_13_0:isShow() and not self:isAllReceive() then
		return true
	end

	return false
end

function ActivityOnlineGiftData:isOnlineActivityOpen()
	local var_14_0 = g.core.model.User.activityDataManager:getActivityDataDuringDisplay(var_0_2.ACTIVITY_SOURCE_TYPE.CONFIG_TABLE, var_0_2.ACTIVITY_TYPE.ONLINE_GIFT)

	if var_14_0 and var_14_0:isShow() then
		return true
	end

	return false
end

return ActivityOnlineGiftData
