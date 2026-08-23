local ValentinesDayVoteLevelRewardStruct = class("ValentinesDayVoteLevelRewardStruct")
local var_0_1 = g.core.config.support_level_info

function ValentinesDayVoteLevelRewardStruct:ctor(arg_1_1)
	self._id = arg_1_1
	self._cfg = var_0_1.get(arg_1_1)
	self._statue = 0
	self._rewardList = {}
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

function ValentinesDayVoteLevelRewardStruct:getCfg()
	return self._cfg
end

function ValentinesDayVoteLevelRewardStruct:getRewardList()
	return self._rewardList
end

function ValentinesDayVoteLevelRewardStruct:updateData(arg_4_1)
	self._isGetReward = arg_4_1
end

function ValentinesDayVoteLevelRewardStruct:isGetReward()
	return self._isGetReward
end

return ValentinesDayVoteLevelRewardStruct
