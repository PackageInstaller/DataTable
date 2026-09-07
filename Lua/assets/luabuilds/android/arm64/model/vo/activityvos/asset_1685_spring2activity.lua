local Spring2Activity = class("Spring2Activity", import("model.vo.ActivityVOs.ITaskActivity"))

Spring2Activity.OPERATION_SETSHIP = 1

function Spring2Activity:Ctor(...)
	Spring2Activity.super.Ctor(self, ...)

	for iter_1_0 = 1, self:GetSlotCount() do
		self.data1_list[iter_1_0] = self.data1_list[iter_1_0] or 0
	end

	return
end

function Spring2Activity:GetSlotCount()
	return self:getConfig("config_data")[2]
end

function Spring2Activity:GetTotalSlotCount()
	return self:getConfig("config_data")[2]
end

function Spring2Activity:GetAvaliableShipIds()
	return _.filter(self.data1_list, function(arg_5_0)
		return arg_5_0 > 0
	end)
end

function Spring2Activity:GetShipIds()
	return self.data1_list
end

function Spring2Activity:SetShipIds(arg_7_1)
	table.Foreach(arg_7_1, function(arg_8_0, arg_8_1)
		self.data1_list[arg_8_1.key] = arg_8_1.value

		return
	end)

	return
end

function Spring2Activity:GetEnergyRecoverAddition()
	return self:getConfig("config_data")[1]
end

function Spring2Activity:GetUnlockTaskIds()
	return _.flatten(self:GetTaskIdsByDay())
end

function Spring2Activity:GetFinishedTaskIds()
	return self.data2_list
end

function Spring2Activity:GetTaskIdsByDay()
	return self:getConfig("config_data")[3]
end

function Spring2Activity:readyToAchieve()
	assert(isa(self, Spring2Activity))

	return _.any(getProxy(ActivityTaskProxy):getTaskVOsByActId((self:GetConfigID())), function(arg_14_0)
		return arg_14_0:isFinish() and not arg_14_0:isOver()
	end)
end

return Spring2Activity
