local SignInfoStruct = class("SignInfoStruct")

function SignInfoStruct:Ctor(arg_1_1)
	self.activity_id = arg_1_1.activity_id

	self:Update(arg_1_1)
end

function SignInfoStruct:Update(arg_2_1)
	self.sign_num = arg_2_1.sign_num or 0
	self.today_buy_num = arg_2_1.today_buy_num or 0
	self.left_sign_time = arg_2_1.left_sign_time or 1
end

function SignInfoStruct:SignDay()
	return self.sign_num or 0
end

function SignInfoStruct:TotalSignDay()
	return (ActivityCumulativeSignCfg[self.activity_id] or nil) and (#ActivityCumulativeSignCfg[self.activity_id].config_list or 7)
end

function SignInfoStruct:CumulativeLoginDay()
	return self.sign_num + self.left_sign_time
end

function SignInfoStruct:TodayBuyNum()
	return self.today_buy_num or 0
end

function SignInfoStruct:LeftSignTimes()
	return self.left_sign_time or 0
end

function SignInfoStruct:OnSignSuccess(arg_8_1)
	self:Update(arg_8_1)
end

function SignInfoStruct:EndTime()
	return ActivityData:GetActivityData(self.activity_id).stopTime
end

function SignInfoStruct:OnCrossDay()
	if self:TotalSignDay() > self:CumulativeLoginDay() then
		self.left_sign_time = 1
	end
end

function SignInfoStruct:IsReSign()
	if self.left_sign_time > 0 then
		return false
	end

	local var_11_0 = self:TotalSignDay()
	local var_11_1

	if var_11_0 <= self:CumulativeLoginDay() then
		do return false end

		var_11_1 = 86400
	end

	return math.max(var_11_0 - math.ceil((self:EndTime() - manager.time:GetServerTime()) / var_11_1) - self.today_buy_num, 0) > 0
end

function SignInfoStruct:ReSignNum()
	if self.left_sign_time > 0 then
		return 0
	end

	local var_12_0 = self:TotalSignDay()

	if var_12_0 <= self:CumulativeLoginDay() then
		return 0
	end

	return (math.max(var_12_0 - math.ceil((self:EndTime() - manager.time:GetServerTime()) / 86400) - self.today_buy_num, 0))
end

function SignInfoStruct:SignRewardList()
	if self.reward_list then
		return self.reward_list
	end

	self.reward_list = {}

	if not ActivityCumulativeSignCfg[self.activity_id] then
		print("ActivityCumulativeSignCfg不存在对应活动的配置------>", self.activity_id)

		return
	end

	for iter_13_0, iter_13_1 in ipairs(ActivityCumulativeSignCfg[self.activity_id].config_list) do
		table.insert(self.reward_list, SignCfg[iter_13_1].reward)
	end

	return self.reward_list
end

function SignInfoStruct:RedDotCount()
	return self.left_sign_time
end

return SignInfoStruct
