local ActivityOtherReturnPayData = class("ActivityOtherReturnPayData")

function ActivityOtherReturnPayData:ctor()
	self._returnInfo = nil
end

function ActivityOtherReturnPayData:updateOtherServerInfo(arg_2_1)
	self._returnInfo = arg_2_1.info
end

function ActivityOtherReturnPayData:getRechargeAmount()
	if not self._returnInfo then
		return 0, 0
	end

	return self._returnInfo.recharge_amount, math.ceil(self._returnInfo.recharge_amount * 1.05) * 10
end

function ActivityOtherReturnPayData:isCanAward()
	return self:isShow()
end

function ActivityOtherReturnPayData:setAward(arg_5_1)
	if self._returnInfo then
		self._returnInfo.award_time = arg_5_1.award_time
	end
end

function ActivityOtherReturnPayData:isShow()
	if not self._returnInfo then
		return false
	end

	if self._returnInfo.recharge_amount == 0 then
		return false
	end

	if self._returnInfo.award_time > 0 then
		return false
	end

	return true
end

return ActivityOtherReturnPayData
