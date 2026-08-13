class = var_0_10000

local var_0_0 = var_0_10000("EducateTaskProxy")

var_0_0.TASK_ADDED = "EducateTaskProxy.TASK_ADDED"
var_0_0.TASK_REMOVED = "EducateTaskProxy.TASK_REMOVED"
var_0_0.TASK_UPDATED = "EducateTaskProxy.TASK_UPDATED"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.binder = arg_1_1
	arg_1_0.data = {}
	arg_1_0.targetSetDays = {}
	ipairs = var_2
	pg = var_1_10004

	for iter_1_0, iter_1_1 in var_2(var_1_10004.gameset.child_target_set_date.description) do
		local var_1_0 = arg_1_0.targetSetDays

		EducateHelper = var_1_10008
		var_1_0[iter_1_0] = var_1_10008.GetTimeFromCfg(iter_1_1)
	end

	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	arg_2_0.data = {}
	ipairs = var_2

	local var_2_0

	if not arg_2_1.tasks then
		var_2_0 = {}
	end

	for iter_2_0, iter_2_1 in var_2(var_2_0) do
		local var_2_1 = arg_2_0.data
		local var_2_2 = iter_2_1.id

		EducateTask = var_1_10009
		var_2_1[var_2_2] = var_1_10009.New(iter_2_1)
	end

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.SetTarget
	local var_2_5

	if not arg_2_1.targetId then
		var_2_5 = 0
	end

	var_2_4(var_2_3, var_2_5)

	arg_2_0.finishMindTaskIds = arg_2_1.finishMindTaskIds
	arg_2_0.isGotTargetAward = arg_2_1.isGotTargetAward

	return
end

function var_0_0.UpdateTargetAwardStatus(arg_3_0, arg_3_1)
	arg_3_0.isGotTargetAward = arg_3_1

	return
end

function var_0_0.CanGetTargetAward(arg_4_0)
	return not arg_4_0.isGotTargetAward
end

function var_0_0.AddTask(arg_5_0, arg_5_1)
	EducateTask = var_1_10002

	local var_5_0 = var_1_10002.New(arg_5_1)

	arg_5_0.data[var_5_0.id] = var_5_0

	local var_5_1 = var_5_0

	if var_5_0.IsMind(var_5_1) then
		EducateTipHelper = var_3

		local var_5_2 = var_3.SetNewTip

		EducateTipHelper = var_5_1

		var_5_2(var_5_1.NEW_MIND_TASK)
	end

	local var_5_3 = arg_5_0.binder

	var_3.sendNotification(var_5_3, var_0_0.TASK_ADDED)

	return
end

function var_0_0.RemoveTaskById(arg_6_0, arg_6_1)
	arg_6_0.data[arg_6_1] = nil

	local var_6_0 = arg_6_0.binder

	var_2.sendNotification(var_6_0, var_0_0.TASK_REMOVED)

	return
end

function var_0_0.UpdateTask(arg_7_0, arg_7_1)
	if arg_7_0.data[arg_7_1.id] == nil then
		return
	end

	var_2.progress = arg_7_1.progress

	local var_7_0 = arg_7_0.binder

	var_3.sendNotification(var_7_0, var_0_0.TASK_UPDATED)

	return
end

function var_0_0.GetTasksBySystem(arg_8_0, arg_8_1)
	local var_8_0 = {}

	pairs = var_1_10003

	for iter_8_0, iter_8_1 in var_1_10003(arg_8_0.data) do
		if iter_8_1:GetSystemType() == arg_8_1 then
			table = var_8

			var_8.insert(var_8_0, iter_8_1:clone())
		end
	end

	return var_8_0
end

function var_0_0.GetTaskById(arg_9_0, arg_9_1)
	if arg_9_0.data[arg_9_1] then
		local var_9_0 = arg_9_0.data[arg_9_1]
		local var_9_1

		if not var_2.clone(var_9_0) then
			var_9_1 = nil
		end

		return var_9_1
	end
end

function var_0_0.SetTarget(arg_10_0, arg_10_1)
	arg_10_0.targetId = arg_10_1

	if arg_10_0.targetId == 0 then
		arg_10_0.targetTaskIds = {}
	else
		pg = var_2
		arg_10_0.targetTaskIds = var_2.child_target_set[arg_10_0.targetId].ids
	end

	return
end

function var_0_0.GetTargetId(arg_11_0)
	return arg_11_0.targetId
end

function var_0_0.GetTargetSetDays(arg_12_0)
	return arg_12_0.targetSetDays
end

function var_0_0.CheckTargetSet(arg_13_0)
	if arg_13_0.targetId == 0 then
		return true
	end

	getProxy = var_1
	EducateProxy = var_1_10003

	local var_13_0 = var_1(var_1_10003)
	local var_13_1 = var_1.GetCurTime(var_13_0)

	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.targetSetDays) do
		EducateHelper = var_1_10007

		if var_1_10007.IsSameDay(iter_13_1, var_13_1) then
			pg = var_1_10007
			var_1_10007 = var_1_10007.child_target_set[arg_13_0.targetId].stage ~= iter_13_0

			return var_1_10007
		end
	end

	return false
end

function var_0_0.GetTargetTasksForShow(arg_14_0)
	local var_14_0 = {}

	ipairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0.targetTaskIds) do
		if arg_14_0.data[iter_14_1] and not arg_14_0.isGotTargetAward then
			table = var_7

			var_7.insert(var_14_0, arg_14_0:GetTaskById(iter_14_1))
		else
			EducateTask = var_7

			local var_14_1 = var_7.New({
				id = iter_14_1
			})

			var_7.SetRecieve(var_14_1)

			table = var_8

			var_8.insert(var_14_0, var_7)
		end
	end

	return var_14_0
end

function var_0_0.GetMainTasksForShow(arg_15_0)
	local var_15_0 = {}

	ipairs = var_1_10002
	pg = var_1_10004

	for iter_15_0, iter_15_1 in var_1_10002(var_1_10004.child_task.all) do
		pg = var_1_10007

		local var_15_1 = var_1_10007.child_task[iter_15_1].type_1

		EducateTask = var_1_10009

		if var_15_1 == var_1_10009.STSTEM_TYPE_MAIN then
			if arg_15_0.data[iter_15_1] then
				table = var_8

				var_8.insert(var_15_0, arg_15_0:GetTaskById(iter_15_1))
			else
				EducateTask = var_8

				local var_15_2 = var_8.New({
					id = iter_15_1
				})

				if var_8.InTime(var_15_2) then
					var_8:SetRecieve()

					table = var_1_10009

					var_1_10009.insert(var_15_0, var_8)
				end
			end
		end
	end

	return var_15_0
end

function var_0_0.FilterByGroup(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}

	ipairs = var_1_10004

	for iter_16_0, iter_16_1 in var_1_10004(arg_16_1) do
		var_1_10011 = iter_16_1

		if not var_16_0[iter_16_1.getConfig(var_1_10011, "group")] then
			var_16_0[var_9] = {}
		end

		table = var_1_10010

		var_1_10010.insert(var_16_0[var_9], iter_16_1)
	end

	local var_16_1 = {}

	pairs = var_5

	for iter_16_2, iter_16_3 in var_5(var_16_0) do
		table = var_1_10010
		var_1_10010 = var_1_10010.sort

		local var_16_2 = iter_16_3

		CompareFuncs = var_1_10013

		var_1_10010(var_16_2, var_1_10013({
			function(arg_17_0)
				return arg_17_0:IsReceive() and 1 or 0
			end,
			function(arg_18_0)
				return -arg_18_0:getConfig("order")
			end,
			function(arg_19_0)
				return -arg_19_0.id
			end
		}))

		if arg_16_2 then
			underscore = var_1_10010

			if var_1_10010.any(iter_16_3, function(arg_20_0)
				return not arg_20_0:IsReceive()
			end) then
				table = var_1_10011

				var_1_10011.insert(var_16_1, iter_16_3[1])
			end
		else
			table = var_1_10010

			var_1_10010.insert(var_16_1, iter_16_3[1])
		end
	end

	table = var_5

	local var_16_3 = var_5.sort
	local var_16_4 = var_16_1

	CompareFuncs = iter_16_2

	var_16_3(var_16_4, iter_16_2({
		function(arg_21_0)
			return arg_21_0:IsReceive() and 1 or 0
		end,
		function(arg_22_0)
			return arg_22_0:IsFinish() and 0 or 1
		end,
		function(arg_23_0)
			return arg_23_0:getConfig("group")
		end,
		function(arg_24_0)
			return -arg_24_0.id
		end
	}))

	return var_16_1
end

function var_0_0.GetOtherTargetTaskProgress(arg_25_0)
	if arg_25_0.targetId == 0 then
		return 0, 0
	end

	pg = var_1

	local var_25_0 = var_1.child_target_set[arg_25_0.targetId].target_progress

	pg = var_2

	local var_25_1 = var_2.child_target_set[arg_25_0.targetId].ids

	underscore = var_3

	return var_3.reduce(var_25_1, 0, function(arg_26_0, arg_26_1)
		local var_26_0

		if arg_25_0.data[arg_26_1] then
			var_26_0 = 0
		else
			pg = var_26_0
			var_26_0 = var_26_0.child_task[arg_26_1].task_target_progress
		end

		return arg_26_0 + var_26_0
	end), var_25_0
end

function var_0_0.GetMainTargetTaskProgress(arg_27_0)
	local var_27_0 = 0
	local var_27_1 = 0

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_27_0, iter_27_1 in var_1_10003(var_1_10005.child_task.all) do
		pg = var_1_10008

		local var_27_2 = var_1_10008.child_task[iter_27_1].type_1

		EducateTask = var_1_10010

		if var_27_2 == var_1_10010.STSTEM_TYPE_MAIN then
			if arg_27_0.data[iter_27_1] then
				var_27_0 = var_27_0 + 1
			else
				EducateTask = var_9

				local var_27_3 = var_9.New({
					id = iter_27_1
				})

				if var_9.InTime(var_27_3) then
					var_27_1 = var_27_1 + 1
					var_27_0 = var_27_0 + 1
				end
			end
		end
	end

	return var_27_1, var_27_0
end

function var_0_0.GetShowTargetTasks(arg_28_0)
	local var_28_0 = arg_28_0:FilterByGroup(arg_28_0:GetTargetTasksForShow())

	table = var_1_10002

	local var_28_1 = var_1_10002.sort
	local var_28_2 = var_28_0

	CompareFuncs = var_1_10005

	var_28_1(var_28_2, var_1_10005({
		function(arg_29_0)
			return arg_29_0:IsReceive() and 1 or 0
		end,
		function(arg_30_0)
			return -arg_30_0:getConfig("order")
		end,
		function(arg_31_0)
			return -arg_31_0.id
		end
	}))

	return var_28_0
end

function var_0_0.GetSiteEnterAddTasks(arg_32_0, arg_32_1)
	local var_32_0 = {}

	pairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(arg_32_0.data) do
		if iter_32_1:NeedAddProgressFromSiteEnter() then
			EducateHelper = var_8

			if var_8.IsMatchSubType(iter_32_1:getConfig("sub_type"), arg_32_1) then
				table = var_8

				var_8.insert(var_32_0, iter_32_1:clone())
			end
		end
	end

	return var_32_0
end

function var_0_0.GetPerformAddTasks(arg_33_0, arg_33_1)
	local var_33_0 = {}

	pairs = var_1_10003

	for iter_33_0, iter_33_1 in var_1_10003(arg_33_0.data) do
		if iter_33_1:NeedAddProgressFromPerform() then
			EducateHelper = var_8

			if var_8.IsMatchSubType(iter_33_1:getConfig("sub_type"), arg_33_1) then
				table = var_8

				var_8.insert(var_33_0, iter_33_1:clone())
			end
		end
	end

	return var_33_0
end

function var_0_0.OnNewWeek(arg_34_0)
	return
end

function var_0_0.IsShowMindTasksTip(arg_35_0)
	pairs = var_1_10001

	for iter_35_0, iter_35_1 in var_1_10001(arg_35_0.data) do
		if iter_35_1:IsMind() and iter_35_1:IsFinish() then
			return true
		end
	end

	return false
end

function var_0_0.IsShowMainTasksTip(arg_36_0)
	return arg_36_0:FilterByGroup(arg_36_0:GetMainTasksForShow())[1] and not var_1:IsReceive() and var_1:IsFinish()
end

function var_0_0.IsShowTargetTasksTip(arg_37_0)
	pairs = var_1_10001

	for iter_37_0, iter_37_1 in var_1_10001(arg_37_0.data) do
		if iter_37_1:IsTarget() and iter_37_1:IsFinish() then
			return true
		end
	end

	return false
end

function var_0_0.IsShowOtherTasksTip(arg_38_0)
	if arg_38_0:IsShowMainTasksTip() then
		return true
	end

	if arg_38_0.isGotTargetAward then
		return false
	end

	local var_38_0, var_38_1 = arg_38_0:GetOtherTargetTaskProgress()

	if var_38_0 / var_38_1 >= 1 then
		return true
	end

	return arg_38_0:IsShowTargetTasksTip()
end

return var_0_0
