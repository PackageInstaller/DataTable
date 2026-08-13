class = var_0_10000

local var_0_0 = var_0_10000("IslandTaskActhelper")

var_0_0.TASK_STATET_NORMAL = 0
var_0_0.TASK_STATET_FINISH = 1
var_0_0.TASK_STATET_RECIVED = 2

function var_0_0.GetIslandTaskState(arg_1_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.GetIsland(var_1_0)
	local var_1_2 = var_1.GetTaskAgency(var_1_1)
	local var_1_3 = 0

	IslandTask = var_1_1

	local var_1_4 = var_1_1.New({
		id = arg_1_0,
		process_list = {}
	})
	local var_1_5 = var_3.GetTargetList(var_1_4)[1]

	assert = var_1_4

	var_1_4(var_1_5, "target no exist")

	local var_1_6 = var_1_5:GetTargetNum()
	local var_1_7 = var_0_0.TASK_STATET_NORMAL
	local var_1_8 = var_1_2:GetTask(arg_1_0)

	if var_1_2:IsFinishTask(arg_1_0) then
		var_1_7 = var_0_0.TASK_STATET_RECIVED
		var_1_3 = var_1_6
	elseif var_1_8 and var_1_8:IsFinish() then
		var_1_7 = var_0_0.TASK_STATET_FINISH
		var_1_3 = var_1_6
	end

	if var_1_8 then
		local var_1_9 = var_1_8:GetTargetList()[1]

		var_1_3 = var_9.GetProgress(var_1_9)
	end

	return var_1_3, var_1_6, var_1_7
end

function var_0_0.GetNDay(arg_2_0)
	local var_2_0 = arg_2_0:getIslandConfig("config_data")
	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.getDayIndex(var_2_1)
	local var_2_3 = 1

	ipairs = var_2_1

	for iter_2_0, iter_2_1 in var_2_1(var_2_0) do
		_ = var_1_10009

		if var_1_10009.all(iter_2_1, function(arg_3_0)
			local var_3_0, var_3_1, var_3_2 = var_0_0.GetIslandTaskState(arg_3_0)

			return var_3_2 == var_0_0.TASK_STATET_RECIVED
		end) then
			var_2_3 = iter_2_0 + 1
		end
	end

	math = var_4

	local var_2_4 = var_4.min
	local var_2_5 = #var_2_0

	math = iter_2_0

	return var_2_4(var_2_5, iter_2_0.min(var_2_2, var_2_3))
end

function var_0_0.IsIslandTaskAct(arg_4_0)
	local var_4_0 = arg_4_0:getConfig("type")

	ActivityConst = var_1_10002

	if var_4_0 ~= var_1_10002.ACTIVITY_TYPE_TASK_LIST then
		return false
	end

	if #arg_4_0:getConfig("config_data") <= 0 then
		pg = var_2

		if var_2.island_activity_template[arg_4_0.configId] then
			return true
		end
	end

	return false
end

local var_0_1 = "_ISLAND_MECHA_TASK_ACT_"

function var_0_0.FirstEnter()
	getProxy = var_1_10000
	PlayerProxy = var_1_10002

	local var_5_0 = var_1_10000(var_1_10002)
	local var_5_1 = var_0.getRawData(var_5_0).id

	PlayerPrefs = var_1_10001

	return var_1_10001.GetInt(var_0_1 .. var_5_1, 0) == 0
end

function var_0_0.SetNonFirstEnter(arg_6_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getRawData(var_6_0).id

	PlayerPrefs = var_1_10002

	var_1_10002.SetInt(var_0_1 .. var_6_1, 1)

	PlayerPrefs = var_2

	var_2.Save()

	getProxy = var_2
	ActivityProxy = var_4

	local var_6_2 = var_2(var_4)

	if var_2.RawGetActivityById(var_6_2, arg_6_0) then
		pg = var_6_0

		local var_6_3 = var_6_0.m02
		local var_6_4 = var_3.sendNotification

		ActivityProxy = var_1_10006

		var_6_4(var_6_3, var_1_10006.ACTIVITY_UPDATED, var_2)
	end

	return
end

function var_0_0.ShouldTipIslandTask(arg_7_0)
	local var_7_0 = arg_7_0:getConfig("type")

	ActivityConst = var_1_10002

	if var_7_0 ~= var_1_10002.ACTIVITY_TYPE_TASK_LIST then
		return false
	end

	local var_7_1 = var_0_0.GetNDay(arg_7_0)
	local var_7_2

	if not arg_7_0:getIslandConfig("config_data")[var_7_1] then
		var_7_2 = {}
	end

	local var_7_3

	if not var_0_0.FirstEnter() then
		_ = var_7_3
		var_7_3 = var_7_3.any(var_7_2, function(arg_8_0)
			local var_8_0, var_8_1, var_8_2 = var_0_0.GetIslandTaskState(arg_8_0)

			return var_8_2 == var_0_0.TASK_STATET_FINISH
		end)
	end

	return var_7_3
end

function var_0_0._TriggerTasks(arg_9_0)
	local var_9_0 = arg_9_0:getIslandConfig("config_data")

	_ = var_1_10002

	local var_9_1 = var_1_10002.flatten(var_9_0)
	local var_9_2 = {}

	getProxy = var_4
	IslandProxy = var_1_10006

	local var_9_3 = var_4(var_1_10006)
	local var_9_4 = var_4.GetIsland(var_9_3)
	local var_9_5 = var_4.GetTaskAgency(var_9_4)

	ipairs = var_1_10005

	for iter_9_0, iter_9_1 in var_1_10005(var_9_1) do
		local var_9_6 = var_9_5:GetTask(iter_9_1)

		if not var_9_5:IsFinishTask(iter_9_1) and not var_9_6 then
			table = var_11

			var_11.insert(var_9_2, iter_9_1)
		end
	end

	if #var_9_2 > 0 then
		pg = var_5

		local var_9_7 = var_5.m02
		local var_9_8 = var_5.sendNotification

		GAME = iter_9_0

		var_9_8(var_9_7, iter_9_0.ISLAND_ACCEPT_TASK, {
			taskIds = var_9_2
		})
	end

	return
end

function var_0_0.TriggerActTasks(arg_10_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003)
	local var_10_1 = var_1.getActivitiesByType

	ActivityConst = var_1_10004

	local var_10_2 = var_10_1(var_10_0, var_1_10004.ACTIVITY_TYPE_TASK_LIST)

	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(var_10_2) do
		if var_0_0.IsIslandTaskAct(iter_10_1) then
			var_0_0._TriggerTasks(iter_10_1)
		end
	end

	arg_10_0()

	return
end

return var_0_0
