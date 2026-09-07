local SkirmishProxy = class("SkirmishProxy", import(".NetProxy"))

function SkirmishProxy:register()
	self.data = {}

	self:BuildSkirmishData()

	return
end

SkirmishProxy.SkirmishMap = 1250022

function SkirmishProxy:BuildSkirmishData()
	local var_2_0 = SkirmishVO.bindConfigTable()

	for iter_2_0, iter_2_1 in pairs(var_2_0.all) do
		table.insert(self.data, (SkirmishVO.New(var_2_0[iter_2_1].id)))
	end

	return
end

function SkirmishProxy:TryFetchNewTask()
	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_ID_US_SKIRMISH_RE)

	if var_3_0 and not var_3_0:isEnd() then
		return updateActivityTaskStatus(var_3_0)
	end

	return
end

function SkirmishProxy:UpdateSkirmishProgress()
	local var_4_0 = getProxy(TaskProxy)
	local var_4_1 = math.min(getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_ID_US_SKIRMISH_RE):getDayIndex(), #self.data)
	local var_4_2 = false

	for iter_4_0 = #self.data, 1, -1 do
		local var_4_3 = self.data[iter_4_0]
		local var_4_4 = var_4_0:getTaskVO((self.data[iter_4_0]:getConfig("task_id")))
		local var_4_5

		if var_4_1 < iter_4_0 then
			var_4_5 = SkirmishVO.StateInactive
		elseif var_4_4 then
			if var_4_4:isReceive() then
				var_4_5 = SkirmishVO.StateClear
				var_4_2 = var_4_2 or iter_4_0 <= var_4_1
			elseif not var_4_4:isFinish() then
				var_4_5 = SkirmishVO.StateWorking
				var_4_2 = true
			else
				var_4_5 = SkirmishVO.StateWorking
				var_4_2 = true
			end
		else
			var_4_5 = var_4_2 and SkirmishVO.StateClear or SkirmishVO.StateActive
		end

		var_4_3:SetState(var_4_5)
	end

	return
end

return SkirmishProxy
