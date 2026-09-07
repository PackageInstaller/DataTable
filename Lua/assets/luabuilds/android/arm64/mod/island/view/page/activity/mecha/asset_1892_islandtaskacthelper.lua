local IslandTaskActhelper = class("IslandTaskActhelper")

IslandTaskActhelper.TASK_STATET_NORMAL = 0
IslandTaskActhelper.TASK_STATET_FINISH = 1
IslandTaskActhelper.TASK_STATET_RECIVED = 2

function IslandTaskActhelper:GetIslandTaskState()
	local var_1_0 = getProxy(IslandProxy):GetIsland()
	local var_1_1 = var_1_0:GetTaskAgency()
	local var_1_2 = 0
	local var_1_3 = IslandTask.New({
		id = self,
		process_list = {}
	}).GetTargetList(var_1_0)[1]

	assert(var_1_3, "target no exist")

	local var_1_4 = var_1_3:GetTargetNum()
	local var_1_5 = IslandTaskActhelper.TASK_STATET_NORMAL
	local var_1_6 = var_1_1:GetTask(self)

	if var_1_1:IsFinishTask(self) then
		var_1_5 = IslandTaskActhelper.TASK_STATET_RECIVED
		var_1_2 = var_1_4
	elseif var_1_6 and var_1_6:IsFinish() then
		var_1_5 = IslandTaskActhelper.TASK_STATET_FINISH
		var_1_2 = var_1_4
	end

	return (var_1_6 or nil) and var_1_6:GetTargetList()[1]:GetProgress(), var_1_4, var_1_5
end

function IslandTaskActhelper:GetNDay()
	local var_2_0 = self:getIslandConfig("config_data")
	local var_2_1 = 1

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if _.all(iter_2_1, function(arg_3_0)
			local var_3_0, var_3_1, var_3_2 = IslandTaskActhelper.GetIslandTaskState(arg_3_0)

			return var_3_2 == IslandTaskActhelper.TASK_STATET_RECIVED
		end) then
			var_2_1 = iter_2_0 + 1
		end
	end

	return math.min(#var_2_0, math.min(self:getDayIndex(), var_2_1))
end

function IslandTaskActhelper:IsIslandTaskAct()
	if self:getConfig("type") ~= ActivityConst.ACTIVITY_TYPE_TASK_LIST then
		return false
	end

	if #self:getConfig("config_data") <= 0 and pg.island_activity_template[self.configId] then
		return true
	end

	return false
end

local var_0_1 = "_ISLAND_MECHA_TASK_ACT_"

function IslandTaskActhelper.FirstEnter()
	return PlayerPrefs.GetInt(var_0_1 .. getProxy(PlayerProxy):getRawData().id, 0) == 0
end

function IslandTaskActhelper:SetNonFirstEnter()
	PlayerPrefs.SetInt(var_0_1 .. getProxy(PlayerProxy):getRawData().id, 1)
	PlayerPrefs.Save()

	local var_6_0 = getProxy(ActivityProxy):RawGetActivityById(self)

	if var_6_0 then
		pg.m02:sendNotification(ActivityProxy.ACTIVITY_UPDATED, var_6_0)
	end

	return
end

function IslandTaskActhelper:ShouldTipIslandTask()
	if self:getConfig("type") ~= ActivityConst.ACTIVITY_TYPE_TASK_LIST then
		return false
	end

	return IslandTaskActhelper.FirstEnter() or _.any(self:getIslandConfig("config_data")[IslandTaskActhelper.GetNDay(self)] or {}, function(arg_8_0)
		local var_8_0, var_8_1, var_8_2 = IslandTaskActhelper.GetIslandTaskState(arg_8_0)

		return var_8_2 == IslandTaskActhelper.TASK_STATET_FINISH
	end)
end

function IslandTaskActhelper:_TriggerTasks()
	local var_9_0 = {}
	local var_9_1 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

	for iter_9_0, iter_9_1 in ipairs((_.flatten((self:getIslandConfig("config_data"))))) do
		if not var_9_1:IsFinishTask(iter_9_1) and not var_9_1:GetTask(iter_9_1) then
			table.insert(var_9_0, iter_9_1)
		end
	end

	if #var_9_0 > 0 then
		pg.m02:sendNotification(GAME.ISLAND_ACCEPT_TASK, {
			taskIds = var_9_0
		})
	end

	return
end

function IslandTaskActhelper:TriggerActTasks()
	for iter_10_0, iter_10_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST))) do
		if IslandTaskActhelper.IsIslandTaskAct(iter_10_1) then
			IslandTaskActhelper._TriggerTasks(iter_10_1)
		end
	end

	self()

	return
end

return IslandTaskActhelper
