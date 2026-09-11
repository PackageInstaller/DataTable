local SignInfoStruct_New = class("SignInfoStruct_New")

function SignInfoStruct_New:Ctor(arg_1_1)
	self.activity_id = arg_1_1.activity_id
	self.unlock_reward = arg_1_1.unlock_reward or {}
	self.gain_reward = arg_1_1.gain_reward or {}
	self.unlock_times = arg_1_1.unlock_times or 0
	self.gift_reward = arg_1_1.gift_reward or 0
end

function SignInfoStruct_New:Update(arg_2_1)
	local var_2_0 = 0

	if arg_2_1.id_list then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.id_list) do
			table.insert(self.gain_reward, iter_2_1)

			for iter_2_2, iter_2_3 in ipairs(self.unlock_reward) do
				if iter_2_1 == iter_2_3 then
					var_2_0 = iter_2_2
				end
			end
		end

		table.remove(self.unlock_reward, var_2_0)
	end

	if arg_2_1.id then
		table.insert(self.gain_reward, arg_2_1.id)

		for iter_2_4, iter_2_5 in ipairs(self.unlock_reward) do
			if arg_2_1.id == iter_2_5 then
				var_2_0 = iter_2_4
			end
		end

		table.remove(self.unlock_reward, var_2_0)
	end
end

function SignInfoStruct_New:UpdateUnlockTimes()
	self.unlock_times = self.unlock_times + 1
end

function SignInfoStruct_New:UpdateActivityDataByGiftReward()
	self.gift_reward = 1
end

function SignInfoStruct_New:TotalSignDay()
	return (ActivityCumulativeSignCfg[self.activity_id] or nil) and (#ActivityCumulativeSignCfg[self.activity_id].config_list or 7)
end

function SignInfoStruct_New:OnSignSuccess(arg_6_1)
	self:Update(arg_6_1)
end

function SignInfoStruct_New:EndTime()
	return ActivityData:GetActivityData(self.activity_id).stopTime
end

function SignInfoStruct_New:OnCrossDayNew()
	return
end

function SignInfoStruct_New:ReSignNum()
	return (math.max(self:TotalSignDay() - math.ceil((self:EndTime() - manager.time:GetServerTime()) / 86400) - self.unlock_times, 0))
end

function SignInfoStruct_New:SignRewardList()
	if self.reward_list then
		return self.reward_list
	end

	self.reward_list = {}

	if not ActivityCumulativeSignCfg[self.activity_id] then
		print("ActivityCumulativeSignCfg不存在对应活动的配置------>", self.activity_id)

		return
	end

	for iter_10_0, iter_10_1 in ipairs(ActivityCumulativeSignCfg[self.activity_id].config_list) do
		table.insert(self.reward_list, SignCfg[iter_10_1].reward)
	end

	return self.reward_list
end

function SignInfoStruct_New:RedDotCount()
	return #self.unlock_reward
end

function SignInfoStruct_New:GetGiftRedDotCount()
	return self.gift_reward
end

return SignInfoStruct_New
