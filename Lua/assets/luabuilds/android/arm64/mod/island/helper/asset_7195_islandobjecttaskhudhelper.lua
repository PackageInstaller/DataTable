local IslandObjectTaskHudHelper = class("IslandObjectTaskHudHelper")

IslandObjectTaskHudHelper.TYPE_NORMAL = 0
IslandObjectTaskHudHelper.TYPE_ACCEPT = 1
IslandObjectTaskHudHelper.TYPE_TARGET = 2
IslandObjectTaskHudHelper.TYPE_SUBMIT = 3

function IslandObjectTaskHudHelper:BuildData()
	IslandObjectTaskHudHelper.objectAcceptData = {}
	IslandObjectTaskHudHelper.objectTargetData = {}
	IslandObjectTaskHudHelper.objectSubmitData = {}

	for iter_1_0, iter_1_1 in ipairs(self) do
		local var_1_0, var_1_1, var_1_2 = IslandObjectTaskHudHelper.GetLinkObjectsByTaskId(iter_1_1)

		if var_1_0 then
			IslandObjectTaskHudHelper.objectAcceptData[var_1_0] = IslandObjectTaskHudHelper.objectAcceptData[var_1_0] or {}

			table.insert(IslandObjectTaskHudHelper.objectAcceptData[var_1_0], iter_1_1)
		end

		if var_1_1 then
			IslandObjectTaskHudHelper.objectSubmitData[var_1_1] = IslandObjectTaskHudHelper.objectSubmitData[var_1_1] or {}

			table.insert(IslandObjectTaskHudHelper.objectSubmitData[var_1_1], iter_1_1)
		end

		for iter_1_2, iter_1_3 in pairs(var_1_2) do
			IslandObjectTaskHudHelper.objectTargetData[iter_1_2] = IslandObjectTaskHudHelper.objectTargetData[iter_1_2] or {}

			table.insert(IslandObjectTaskHudHelper.objectTargetData[iter_1_2], iter_1_3)
		end
	end

	return
end

function IslandObjectTaskHudHelper:GetLinkObjectsByTaskId()
	local var_2_0
	local var_2_1
	local var_2_2 = {}

	if pg.island_task[self].trigger_type == 1 and pg.island_task[self].trigger_data ~= 0 then
		var_2_0 = pg.island_task[self].trigger_data
	end

	if pg.island_task[self].complete_type == 1 and pg.island_task[self].complete_data ~= 0 then
		var_2_1 = pg.island_task[self].complete_data
	end

	for iter_2_0, iter_2_1 in ipairs(pg.island_task[self].target_id) do
		local var_2_3 = tonumber(pg.island_task_target[iter_2_1].tips)

		if var_2_3 then
			var_2_2[var_2_3] = {
				self,
				iter_2_1
			}
		end
	end

	return var_2_0, var_2_1, var_2_2
end

function IslandObjectTaskHudHelper:CheckSubmit()
	if IslandObjectTaskHudHelper.objectSubmitData[self] and #IslandObjectTaskHudHelper.objectSubmitData[self] > 0 then
		local var_3_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

		return IslandObjectTaskHudHelper.GetFirstPriorityId((underscore.select(IslandObjectTaskHudHelper.objectSubmitData[self], function(arg_4_0)
			local var_4_0 = var_3_0:GetTask(arg_4_0)

			return var_4_0 and var_4_0:IsFinish()
		end)))
	end

	return nil
end

function IslandObjectTaskHudHelper:CheckAccept()
	if IslandObjectTaskHudHelper.objectAcceptData[self] and #IslandObjectTaskHudHelper.objectAcceptData[self] > 0 then
		local var_5_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

		return IslandObjectTaskHudHelper.GetFirstPriorityId((underscore.select(IslandObjectTaskHudHelper.objectAcceptData[self], function(arg_6_0)
			local var_6_0 = var_5_0:GetFutureTask(arg_6_0)

			return var_6_0 and var_6_0:IsUnlock()
		end)))
	end

	return nil
end

function IslandObjectTaskHudHelper:CheckTarget()
	if IslandObjectTaskHudHelper.objectTargetData[self] and #IslandObjectTaskHudHelper.objectTargetData[self] > 0 then
		local var_7_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

		return IslandObjectTaskHudHelper.GetFirstPriorityId((underscore.map(underscore.select(IslandObjectTaskHudHelper.objectTargetData[self], function(arg_8_0)
			local var_8_0 = var_7_0:GetTask(arg_8_0[1])
			local var_8_1

			if var_8_0 then
				::label_8_0::

				var_8_1 = not var_8_0:GetTargetById(arg_8_0[2]):IsFinish()
			end

			return var_8_1
		end), function(arg_9_0)
			return arg_9_0[1]
		end)))
	end

	return nil
end

function IslandObjectTaskHudHelper:GetFirstPriorityId()
	table.sort(self, CompareFuncs({
		function(arg_11_0)
			return IslandTaskType.GetHudPriority(IslandTaskType.Type2ShowType[pg.island_task[arg_11_0].type])
		end,
		function(arg_12_0)
			return arg_12_0
		end
	}))

	return self[1]
end

function IslandObjectTaskHudHelper:GetObjectTaskHud()
	local var_13_0 = IslandObjectTaskHudHelper.CheckSubmit(self)

	if var_13_0 then
		return IslandObjectTaskHudHelper.TYPE_SUBMIT, var_13_0
	end

	local var_13_1 = IslandObjectTaskHudHelper.CheckAccept(self)

	if var_13_1 then
		return IslandObjectTaskHudHelper.TYPE_ACCEPT, var_13_1
	end

	local var_13_2 = IslandObjectTaskHudHelper.CheckTarget(self)

	if var_13_2 then
		return IslandObjectTaskHudHelper.TYPE_TARGET, var_13_2
	end

	return IslandObjectTaskHudHelper.TYPE_NORMAL, nil
end

function IslandObjectTaskHudHelper:GetHudDislayInfoByTaskId()
	local var_14_0 = IslandTaskType.Type2ShowType[pg.island_task[self].type]

	return switch(IslandTaskType.Type2ShowType[pg.island_task[self].type], {
		[IslandTaskType.SHOW_MAIN] = function()
			return "hud_main", "39befe"
		end,
		[IslandTaskType.SHOW_BRANCH] = function()
			return "hud_branch", "e67ad5"
		end,
		[IslandTaskType.SHOW_DAILY] = function()
			return "hud_dayly", "b4a0e6"
		end,
		[IslandTaskType.SHOW_WEEKLY] = function()
			return "hud_weekly", "7ed38f"
		end,
		[IslandTaskType.SHOW_ACTIVITY] = function()
			return "hud_activity", "eed073"
		end
	}, function()
		assert(false, "not exist task showType: " .. var_14_0)

		return
	end)
end

IslandObjectTaskHudHelper.TaskProcessToHudIcon = {
	[IslandObjectTaskHudHelper.TYPE_ACCEPT] = "icon_accept",
	[IslandObjectTaskHudHelper.TYPE_TARGET] = "icon_inprocess",
	[IslandObjectTaskHudHelper.TYPE_SUBMIT] = "icon_inprocess"
}

return IslandObjectTaskHudHelper
