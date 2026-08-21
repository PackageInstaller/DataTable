local var_0_0 = class("IslandTaskActhelper")

var_0_0.TASK_STATET_NORMAL = 0
var_0_0.TASK_STATET_FINISH = 1
var_0_0.TASK_STATET_RECIVED = 2

function var_0_0.GetIslandTaskState(arg_1_0)
	local var_1_9000
	local var_1_0 = getProxy(IslandProxy):GetIsland()
	local var_1_1 = var_1_0.GetTaskAgency(var_1_9000)
	local var_1_2 = 0
	local var_1_3 = IslandTask.New({
		id = arg_1_0,
		process_list = {}
	}).GetTargetList(var_1_0)[1]

	assert(var_1_3, "target no exist")

	local var_1_4 = var_1_3:GetTargetNum()
	local var_1_5 = var_0_0.TASK_STATET_NORMAL
	local var_1_6 = var_1_1:GetTask(arg_1_0)

	if var_1_1:IsFinishTask(arg_1_0) then
		var_1_5 = var_0_0.TASK_STATET_RECIVED
		var_1_2 = var_1_4
	elseif var_1_6 and var_1_6:IsFinish() then
		var_1_5 = var_0_0.TASK_STATET_FINISH
		var_1_2 = var_1_4
	end

	if var_1_6 then
		var_1_2 = var_1_6:GetTargetList()[1]:GetProgress()
	end

	return var_1_2, var_1_4, var_1_5
end

function var_0_0.GetNDay(arg_2_0)
	local var_2_0 = arg_2_0:getIslandConfig("config_data")
	local var_2_1 = 1

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if _.all(iter_2_1, function(arg_3_0)
			local var_3_0, var_3_1, var_3_2 = var_0_0.GetIslandTaskState(arg_3_0)

			return var_3_2 == var_0_0.TASK_STATET_RECIVED
		end) then
			var_2_1 = iter_2_0 + 1
		end
	end

	return math.min(#var_2_0, math.min(arg_2_0:getDayIndex(), var_2_1))
end

function var_0_0.IsIslandTaskAct(arg_4_0)
	if arg_4_0:getConfig("type") ~= ActivityConst.ACTIVITY_TYPE_TASK_LIST then
		return false
	end

	if #arg_4_0:getConfig("config_data") <= 0 and pg.island_activity_template[arg_4_0.configId] then
		return true
	end

	return false
end

local var_0_1 = "_ISLAND_MECHA_TASK_ACT_"

function var_0_0.FirstEnter()
	local var_5_0 = getProxy(PlayerProxy)

	return PlayerPrefs.GetInt(var_0_1 .. var_5_0:getRawData().id, 0) == 0
end

function var_0_0.SetNonFirstEnter(arg_6_0)
	PlayerPrefs.SetInt(var_0_1 .. getProxy(PlayerProxy):getRawData().id, 1)
	PlayerPrefs.Save()

	local var_6_0 = getProxy(ActivityProxy):RawGetActivityById(arg_6_0)

	if var_6_0 then
		pg.m02:sendNotification(ActivityProxy.ACTIVITY_UPDATED, var_6_0)
	end

	return
end

function var_0_0.ShouldTipIslandTask(arg_7_0)
	if arg_7_0:getConfig("type") ~= ActivityConst.ACTIVITY_TYPE_TASK_LIST then
		return false
	end

	local var_7_0 = arg_7_0:getIslandConfig("config_data")[var_0_0.GetNDay(arg_7_0)] or {}

	return var_0_0.FirstEnter() or _.any(var_7_0, function(arg_8_0)
		local var_8_0, var_8_1, var_8_2 = var_0_0.GetIslandTaskState(arg_8_0)

		return var_8_2 == var_0_0.TASK_STATET_FINISH
	end)
end

function var_0_0._TriggerTasks(arg_9_0)
	local var_9_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

	for iter_9_0, iter_9_1 in ipairs((_.flatten((arg_9_0:getIslandConfig("config_data"))))) do
		local var_9_1 = var_9_0:GetTask(iter_9_1)

		if not var_9_0:IsFinishTask(iter_9_1) and not var_9_1 then
			table.insert({}, iter_9_1)
		end
	end

	if #{} > 0 then
		pg.m02:sendNotification(GAME.ISLAND_ACCEPT_TASK, {
			taskIds = {}
		})
	end

	return
end

function var_0_0.TriggerActTasks(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST))) do
		if var_0_0.IsIslandTaskAct(iter_10_1) then
			var_0_0._TriggerTasks(iter_10_1)
		end
	end

	arg_10_0()

	return
end

return var_0_0
