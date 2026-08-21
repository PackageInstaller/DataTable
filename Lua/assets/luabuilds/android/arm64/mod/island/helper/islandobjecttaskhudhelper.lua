local var_0_0 = class("IslandObjectTaskHudHelper")

var_0_0.TYPE_NORMAL = 0
var_0_0.TYPE_ACCEPT = 1
var_0_0.TYPE_TARGET = 2
var_0_0.TYPE_SUBMIT = 3

function var_0_0.BuildData(arg_1_0)
	var_0_0.objectAcceptData = {}
	var_0_0.objectTargetData = {}
	var_0_0.objectSubmitData = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		local var_1_0, var_1_1, var_1_2 = var_0_0.GetLinkObjectsByTaskId(iter_1_1)

		if var_1_0 then
			var_0_0.objectAcceptData[var_1_0] = var_0_0.objectAcceptData[var_1_0] or {}

			table.insert(var_0_0.objectAcceptData[var_1_0], iter_1_1)
		end

		if var_1_1 then
			var_0_0.objectSubmitData[var_1_1] = var_0_0.objectSubmitData[var_1_1] or {}

			table.insert(var_0_0.objectSubmitData[var_1_1], iter_1_1)
		end

		for iter_1_2, iter_1_3 in pairs(var_1_2) do
			var_0_0.objectTargetData[iter_1_2] = var_0_0.objectTargetData[iter_1_2] or {}

			table.insert(var_0_0.objectTargetData[iter_1_2], iter_1_3)
		end
	end

	return
end

function var_0_0.GetLinkObjectsByTaskId(arg_2_0)
	local var_2_0
	local var_2_1

	if pg.island_task[arg_2_0].trigger_type == 1 and pg.island_task[arg_2_0].trigger_data ~= 0 then
		var_2_0 = pg.island_task[arg_2_0].trigger_data
	end

	if pg.island_task[arg_2_0].complete_type == 1 and pg.island_task[arg_2_0].complete_data ~= 0 then
		var_2_1 = pg.island_task[arg_2_0].complete_data
	end

	for iter_2_0, iter_2_1 in ipairs(pg.island_task[arg_2_0].target_id) do
		local var_2_2 = tonumber(pg.island_task_target[iter_2_1].tips)

		if var_2_2 then
			({})[var_2_2] = {
				arg_2_0,
				iter_2_1
			}
		end
	end

	return var_2_0, var_2_1, {}
end

function var_0_0.CheckSubmit(arg_3_0)
	if var_0_0.objectSubmitData[arg_3_0] and #var_0_0.objectSubmitData[arg_3_0] > 0 then
		local var_3_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

		return var_0_0.GetFirstPriorityId((underscore.select(var_0_0.objectSubmitData[arg_3_0], function(arg_4_0)
			local var_4_0 = var_3_0:GetTask(arg_4_0)

			return var_4_0 and var_4_0:IsFinish()
		end)))
	end

	return nil
end

function var_0_0.CheckAccept(arg_5_0)
	if var_0_0.objectAcceptData[arg_5_0] and #var_0_0.objectAcceptData[arg_5_0] > 0 then
		local var_5_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

		return var_0_0.GetFirstPriorityId((underscore.select(var_0_0.objectAcceptData[arg_5_0], function(arg_6_0)
			local var_6_0 = var_5_0:GetFutureTask(arg_6_0)

			return var_6_0 and var_6_0:IsUnlock()
		end)))
	end

	return nil
end

function var_0_0.CheckTarget(arg_7_0)
	if var_0_0.objectTargetData[arg_7_0] and #var_0_0.objectTargetData[arg_7_0] > 0 then
		local var_7_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

		return var_0_0.GetFirstPriorityId((underscore.map(underscore.select(var_0_0.objectTargetData[arg_7_0], function(arg_8_0)
			local var_8_0 = var_7_0:GetTask(arg_8_0[1])
			local var_8_2

			if var_8_0 then
				::label_8_0::

				local var_8_1 = var_8_0:GetTargetById(arg_8_0[2])

				var_8_2 = not var_8_1:IsFinish()
			end

			return var_8_2
		end), function(arg_9_0)
			return arg_9_0[1]
		end)))
	end

	return nil
end

function var_0_0.GetFirstPriorityId(arg_10_0)
	table.sort(arg_10_0, CompareFuncs({
		function(arg_11_0)
			return IslandTaskType.GetHudPriority(IslandTaskType.Type2ShowType[pg.island_task[arg_11_0].type])
		end,
		function(arg_12_0)
			return arg_12_0
		end
	}))

	return arg_10_0[1]
end

function var_0_0.GetObjectTaskHud(arg_13_0)
	local var_13_0 = var_0_0.CheckSubmit(arg_13_0)

	if var_13_0 then
		return var_0_0.TYPE_SUBMIT, var_13_0
	end

	local var_13_1 = var_0_0.CheckAccept(arg_13_0)

	if var_13_1 then
		return var_0_0.TYPE_ACCEPT, var_13_1
	end

	local var_13_2 = var_0_0.CheckTarget(arg_13_0)

	if var_13_2 then
		return var_0_0.TYPE_TARGET, var_13_2
	end

	return var_0_0.TYPE_NORMAL, nil
end

function var_0_0.GetHudDislayInfoByTaskId(arg_14_0)
	return switch(IslandTaskType.Type2ShowType[pg.island_task[arg_14_0].type], {
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
		assert(false, "not exist task showType: " .. var_0)

		return
	end)
end

var_0_0.TaskProcessToHudIcon = {
	[var_0_0.TYPE_ACCEPT] = "icon_accept",
	[var_0_0.TYPE_TARGET] = "icon_inprocess",
	[var_0_0.TYPE_SUBMIT] = "icon_inprocess"
}

return var_0_0
