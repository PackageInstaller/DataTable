class = var_0_10000

local var_0_0 = var_0_10000("TSTaskQueue")

var_0_0.MTPF = 0.03333333333333333

function var_0_0.Ctor(arg_1_0, arg_1_1)
	math = var_1_10002
	arg_1_0.maxTimePerFrame = var_1_10002.min(arg_1_1, var_0_0.MTPF)
	arg_1_0.taskPool = {}
	arg_1_0.taskQueue = {}
	arg_1_0.running = false
	UpdateBeat = var_2
	arg_1_0.updateHandle = var_2:CreateListener(arg_1_0.Update, arg_1_0)

	return
end

function var_0_0.Enqueue(arg_2_0, arg_2_1)
	assert = var_1_10002
	type = var_1_10004

	var_1_10002(var_1_10004(arg_2_1) == "function", "job should be a function")

	if #arg_2_0.taskPool > 0 then
		table = var_2_0

		local var_2_0

		if not var_2_0.remove(arg_2_0.taskPool, #arg_2_0.taskPool) then
			TSTask = var_2_0
			var_2_0 = var_2_0.New()
		end

		var_2_0:SetJob(arg_2_1)

		table = var_3

		var_3.insert(arg_2_0.taskQueue, var_2_0)

		if not arg_2_0.running then
			arg_2_0.running = true
			UpdateBeat = var_3

			var_3:AddListener(arg_2_0.updateHandle)
		end

		return
	end
end

function var_0_0.Update(arg_3_0)
	if not arg_3_0.running then
		return
	end

	local var_3_0 = 0

	while var_3_0 < arg_3_0.maxTimePerFrame do
		if #arg_3_0.taskQueue == 0 then
			UpdateBeat = var_2

			var_2:RemoveListener(arg_3_0.updateHandle)

			arg_3_0.running = false

			return
		end

		table = var_2

		local var_3_1 = var_2.remove(arg_3_0.taskQueue, 1)

		var_3_0 = var_3_0 + var_2.Execute(var_3_1)

		var_2:Clear()

		table = var_3

		var_3.insert(arg_3_0.taskPool, var_2)
	end

	return
end

function var_0_0.IsBusy(arg_4_0)
	return arg_4_0.running
end

function var_0_0.Clear(arg_5_0, arg_5_1)
	for iter_5_0 = #arg_5_0.taskQueue, 1, -1 do
		local var_5_0 = arg_5_0.taskQueue[iter_5_0]

		if arg_5_1 then
			var_5_0:Execute()
		end

		var_5_0:Clear()

		table = var_7

		var_7.insert(arg_5_0.taskPool, var_5_0)
	end

	arg_5_0.taskQueue = {}

	return
end

return var_0_0
