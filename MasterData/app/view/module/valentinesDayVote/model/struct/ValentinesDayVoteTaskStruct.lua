local ValentinesDayVoteTaskStruct = class("ValentinesDayVoteTaskStruct")
local var_0_1 = g.core.config.support_task_info

function ValentinesDayVoteTaskStruct:ctor(arg_1_1)
	self._id = arg_1_1
	self._cfg = var_0_1.get(arg_1_1)
	self._statue = 0
	self._rewardList = {}
	self._curProgress = 0
	self._isGetReward = false

	while var_0_1.hasKey("reward_type_" .. 1) do
		if self._cfg["reward_type_" .. 1] > 0 then
			table.insert(self._rewardList, {
				type = self._cfg["reward_type_" .. 1],
				value = self._cfg["reward_value_" .. 1],
				size = self._cfg["reward_size_" .. 1]
			})
		end
	end
end

function ValentinesDayVoteTaskStruct:getCfg()
	return self._cfg
end

function ValentinesDayVoteTaskStruct:getRewardList()
	return self._rewardList
end

function ValentinesDayVoteTaskStruct:updateData(arg_4_1)
	self._curProgress = arg_4_1.task_value
	self._isGetReward = arg_4_1.is_award
end

function ValentinesDayVoteTaskStruct:getCurProgress()
	return self._curProgress
end

function ValentinesDayVoteTaskStruct:isGetReward()
	return self._isGetReward
end

return ValentinesDayVoteTaskStruct
