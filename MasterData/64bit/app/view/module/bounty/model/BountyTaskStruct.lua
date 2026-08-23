local BountyTaskStruct = class("BountyTaskStruct")

function BountyTaskStruct:ctor(arg_1_1, arg_1_2)
	self._id = arg_1_1
	self._actId = arg_1_2
	self._cfg = g.core.config.bounty_task_info.get(arg_1_1, self._actId)
	self._curValue = 0
	self._goalValue = self._cfg.goal
	self._freshType = self._cfg.refresh
	self._finishLimit = 1
	self._finishTimes = 0
	self._receiveTimes = 0
	self._rewards = {}

	self:_initRewards()
end

function BountyTaskStruct:_initRewards()
	self._rewards = {}

	local var_2_0 = 1
	local var_2_1 = {
		"reward_type_"
	}

	var_2_1[2] = 1

	local var_2_2 = table.concat(var_2_1)
	local var_2_3 = table.concat({
		"reward_value_",
		var_2_0
	})
	local var_2_4 = table.concat({
		"reward_size_",
		var_2_0
	})

	while g.core.config.bounty_task_info.hasKey(var_2_4) do
		if self._cfg[var_2_4] < 1 then
			break
		end

		self._rewards[#self._rewards + 1] = {
			type = self._cfg[var_2_2],
			value = self._cfg[var_2_3],
			size = self._cfg[var_2_4]
		}
		var_2_0 = var_2_0 + 1
		var_2_2 = table.concat({
			"reward_type_",
			var_2_0
		})
		var_2_3 = table.concat({
			"reward_value_",
			var_2_0
		})
		var_2_4 = table.concat({
			"reward_size_",
			var_2_0
		})
	end
end

function BountyTaskStruct:updateTask(arg_3_1)
	self._curValue = arg_3_1.value or 0
	self._finishTimes = arg_3_1.task_finish_times or 0
	self._receiveTimes = arg_3_1.awarded and 1 or 0
end

function BountyTaskStruct:updateCurValue(arg_4_1)
	self._curValue = arg_4_1
end

function BountyTaskStruct:receiveAward()
	self._receiveTimes = self._receiveTimes + 1
end

function BountyTaskStruct:getOrder()
	return self._cfg.order
end

function BountyTaskStruct:canReceive()
	return self._curValue >= self._goalValue and self._receiveTimes < 1
end

function BountyTaskStruct:getReceiveTimes()
	return self._receiveTimes
end

function BountyTaskStruct:getProgressValue()
	return self._curValue, self._goalValue
end

function BountyTaskStruct:getRefreshType()
	return self._freshType
end

function BountyTaskStruct:getAward()
	return self._rewards
end

function BountyTaskStruct:getCfg()
	return self._cfg
end

return BountyTaskStruct
