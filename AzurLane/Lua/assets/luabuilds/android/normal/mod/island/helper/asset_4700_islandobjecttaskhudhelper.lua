class = var_0_10000

local var_0_0 = var_0_10000("IslandObjectTaskHudHelper")

var_0_0.TYPE_NORMAL = 0
var_0_0.TYPE_ACCEPT = 1
var_0_0.TYPE_TARGET = 2
var_0_0.TYPE_SUBMIT = 3

function var_0_0.BuildData(arg_1_0)
	var_0_0.objectAcceptData = {}
	var_0_0.objectTargetData = {}

	local var_1_0 = var_0_0

	var_1_0.objectSubmitData = {}
	ipairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(arg_1_0) do
		local var_1_1, var_1_2, var_1_3 = var_0_0.GetLinkObjectsByTaskId(iter_1_1)

		if var_1_1 then
			if not var_0_0.objectAcceptData[var_1_1] then
				var_1_10009 = var_0_0.objectAcceptData
				var_1_10009[var_1_1] = {}
			end

			table = var_1_10009

			var_1_10009.insert(var_0_0.objectAcceptData[var_1_1], iter_1_1)
		end

		if var_1_2 then
			if not var_0_0.objectSubmitData[var_1_2] then
				var_1_10009 = var_0_0.objectSubmitData
				var_1_10009[var_1_2] = {}
			end

			table = var_1_10009

			var_1_10009.insert(var_0_0.objectSubmitData[var_1_2], iter_1_1)
		end

		pairs = var_1_10009

		for iter_1_2, iter_1_3 in var_1_10009(var_1_3) do
			local var_1_4

			if not var_0_0.objectTargetData[iter_1_2] then
				var_1_4 = var_0_0.objectTargetData
				var_1_4[iter_1_2] = {}
			end

			table = var_1_4

			var_1_4.insert(var_0_0.objectTargetData[iter_1_2], iter_1_3)
		end
	end

	return
end

function var_0_0.GetLinkObjectsByTaskId(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.island_task[arg_2_0]
	local var_2_1
	local var_2_2
	local var_2_3 = {}

	if var_2_0.trigger_type == 1 and var_2_0.trigger_data ~= 0 then
		var_2_1 = var_2_0.trigger_data
	end

	if var_2_0.complete_type == 1 and var_2_0.complete_data ~= 0 then
		var_2_2 = var_2_0.complete_data
	end

	ipairs = var_5

	for iter_2_0, iter_2_1 in var_5(var_2_0.target_id) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.island_task_target[iter_2_1]
		tonumber = var_1_10011

		if var_1_10011(var_1_10010.tips) then
			var_2_3[var_1_10011] = {
				arg_2_0,
				iter_2_1
			}
		end
	end

	return var_2_1, var_2_2, var_2_3
end

function var_0_0.CheckSubmit(arg_3_0)
	if var_0_0.objectSubmitData[arg_3_0] then
		local var_3_0 = #var_1

		if 0 < var_3_0 then
			getProxy = var_3_0
			IslandProxy = var_3

			local var_3_1 = var_3_0(var_3)
			local var_3_2 = var_2.GetIsland(var_3_1)
			local var_3_3 = var_2.GetTaskAgency(var_3_2)

			underscore = var_3_2

			local var_3_4 = var_3_2.select(var_1, function(arg_4_0)
				local var_4_0 = var_3_3
				local var_4_1

				var_4_1 = var_1.GetTask(var_4_0, arg_4_0) and var_1:IsFinish()

				return var_4_1
			end)

			return var_0_0.GetFirstPriorityId(var_3_4)
		end
	end

	return nil
end

function var_0_0.CheckAccept(arg_5_0)
	if var_0_0.objectAcceptData[arg_5_0] then
		local var_5_0 = #var_1

		if 0 < var_5_0 then
			getProxy = var_5_0
			IslandProxy = var_3

			local var_5_1 = var_5_0(var_3)
			local var_5_2 = var_2.GetIsland(var_5_1)
			local var_5_3 = var_2.GetTaskAgency(var_5_2)

			underscore = var_5_2

			local var_5_4 = var_5_2.select(var_1, function(arg_6_0)
				local var_6_0 = var_5_3
				local var_6_1

				var_6_1 = var_1.GetFutureTask(var_6_0, arg_6_0) and var_1:IsUnlock()

				return var_6_1
			end)

			return var_0_0.GetFirstPriorityId(var_5_4)
		end
	end

	return nil
end

function var_0_0.CheckTarget(arg_7_0)
	if var_0_0.objectTargetData[arg_7_0] then
		local var_7_0 = #var_1

		if 0 < var_7_0 then
			getProxy = var_7_0
			IslandProxy = var_3

			local var_7_1 = var_7_0(var_3)
			local var_7_2 = var_2.GetIsland(var_7_1)
			local var_7_3 = var_2.GetTaskAgency(var_7_2)

			underscore = var_7_2

			local var_7_4 = var_7_2.select(var_1, function(arg_8_0)
				local var_8_0 = var_7_3
				local var_8_2

				if var_1.GetTask(var_8_0, arg_8_0[1]) then
					::label_8_0::

					local var_8_1 = var_1:GetTargetById(arg_8_0[2])

					var_8_2 = not var_2.IsFinish(var_8_1)
				end

				return var_8_2
			end)

			underscore = var_4

			local var_7_5 = var_4.map(var_7_4, function(arg_9_0)
				return arg_9_0[1]
			end)

			return var_0_0.GetFirstPriorityId(var_7_5)
		end
	end

	return nil
end

function var_0_0.GetFirstPriorityId(arg_10_0)
	table = var_1_10001

	local var_10_0 = var_1_10001.sort
	local var_10_1 = arg_10_0

	CompareFuncs = var_1_10003

	var_10_0(var_10_1, var_1_10003({
		function(arg_11_0)
			IslandTaskType = var_2_10001

			local var_11_0 = var_2_10001.Type2ShowType

			pg = var_2_10002

			local var_11_1 = var_11_0[var_2_10002.island_task[arg_11_0].type]

			IslandTaskType = var_2

			return var_2.GetHudPriority(var_11_1)
		end,
		function(arg_12_0)
			return arg_12_0
		end
	}))

	return arg_10_0[1]
end

function var_0_0.GetObjectTaskHud(arg_13_0)
	if var_0_0.CheckSubmit(arg_13_0) then
		return var_0_0.TYPE_SUBMIT, var_1
	end

	if var_0_0.CheckAccept(arg_13_0) then
		return var_0_0.TYPE_ACCEPT, var_2
	end

	if var_0_0.CheckTarget(arg_13_0) then
		return var_0_0.TYPE_TARGET, var_3
	end

	return var_0_0.TYPE_NORMAL, nil
end

function var_0_0.GetHudDislayInfoByTaskId(arg_14_0)
	IslandTaskType = var_1_10001

	local var_14_0 = var_1_10001.Type2ShowType

	pg = var_1_10002

	local var_14_1 = var_14_0[var_1_10002.island_task[arg_14_0].type]

	switch = var_2

	local var_14_2 = var_14_1
	local var_14_3 = {}

	IslandTaskType = var_1_10005
	var_14_3[var_1_10005.SHOW_MAIN] = function()
		return "hud_main", "39befe"
	end
	IslandTaskType = var_5
	var_14_3[var_5.SHOW_BRANCH] = function()
		return "hud_branch", "e67ad5"
	end
	IslandTaskType = var_5
	var_14_3[var_5.SHOW_DAILY] = function()
		return "hud_dayly", "b4a0e6"
	end
	IslandTaskType = var_5
	var_14_3[var_5.SHOW_WEEKLY] = function()
		return "hud_weekly", "7ed38f"
	end
	IslandTaskType = var_5
	var_14_3[var_5.SHOW_ACTIVITY] = function()
		return "hud_activity", "eed073"
	end

	return var_2(var_14_2, var_14_3, function()
		assert = var_2_10000

		var_2_10000(false, "not exist task showType: " .. var_14_1)

		return
	end)
end

var_0_0.TaskProcessToHudIcon = {
	[var_0_0.TYPE_ACCEPT] = "icon_accept",
	[var_0_0.TYPE_TARGET] = "icon_inprocess",
	[var_0_0.TYPE_SUBMIT] = "icon_inprocess"
}

return var_0_0
