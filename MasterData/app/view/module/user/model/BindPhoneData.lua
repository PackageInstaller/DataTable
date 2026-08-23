local BindPhoneData = class("BindPhoneData")

function BindPhoneData:ctor()
	self:initData()
end

function BindPhoneData:initData()
	self._isGetAwards = false
	self._rewards = {}
end

function BindPhoneData:updatePhoneReward(arg_3_1)
	self._isGetAwards = arg_3_1.next_award_time and arg_3_1.next_award_time > 0
	self._rewards = arg_3_1.awards or {}
end

function BindPhoneData:updateBindPhoneInfo(arg_4_1)
	self._isGetAwards = arg_4_1.next_award_time and arg_4_1.next_award_time > 0
end

function BindPhoneData:hasGetAwards()
	return self._isGetAwards
end

function BindPhoneData:getPhoneReward()
	return self._rewards
end

return BindPhoneData
