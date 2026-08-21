local var_0_0 = class("TSTaskQueue")

var_0_0.MTPF = 0.03333333333333333

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.maxTimePerFrame = math.min(arg_1_1, var_0_0.MTPF)
	arg_1_0.taskPool = {}
	arg_1_0.taskQueue = {}
	arg_1_0.running = false
	arg_1_0.updateHandle = UpdateBeat:CreateListener(arg_1_0.Update, arg_1_0)

	return
end

function var_0_0.Enqueue(arg_2_0, arg_2_1)
	assert(type(arg_2_1) == "function", "job should be a function")

	local var_2_0 = #arg_2_0.taskPool > 0 and table.remove(arg_2_0.taskPool, #arg_2_0.taskPool) or TSTask.New()

	var_2_0:SetJob(arg_2_1)
	table.insert(arg_2_0.taskQueue, var_2_0)

	if not arg_2_0.running then
		arg_2_0.running = true

		UpdateBeat:AddListener(arg_2_0.updateHandle)
	end

	return
end

function var_0_0.Update(arg_3_0)
	if not arg_3_0.running then
		return
	end

	local var_3_0 = 0

	while var_3_0 < arg_3_0.maxTimePerFrame do
		if #arg_3_0.taskQueue == 0 then
			UpdateBeat:RemoveListener(arg_3_0.updateHandle)

			arg_3_0.running = false

			return
		end

		local var_3_1 = table.remove(arg_3_0.taskQueue, 1)

		var_3_0 = var_3_0 + var_3_1:Execute()

		var_3_1:Clear()
		table.insert(arg_3_0.taskPool, var_3_1)
	end

	return
end

function var_0_0.IsBusy(arg_4_0)
	return arg_4_0.running
end

function var_0_0.Clear(arg_5_0, arg_5_1)
	for iter_5_0 = #arg_5_0.taskQueue, 1, -1 do
		if arg_5_1 then
			arg_5_0.taskQueue[iter_5_0]:Execute()
		end

		arg_5_0.taskQueue[iter_5_0]:Clear()
		table.insert(arg_5_0.taskPool, arg_5_0.taskQueue[iter_5_0])
	end

	arg_5_0.taskQueue = {}

	return
end

return var_0_0
