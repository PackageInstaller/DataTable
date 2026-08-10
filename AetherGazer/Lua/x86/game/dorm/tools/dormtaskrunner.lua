local var_0_0 = class("DormTaskRunner")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.timers = {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0.taskList, arg_2_0.taskListAdd = {}, {}
	arg_2_0.lastUpdate = nil
	arg_2_0.now = 0
end

function var_0_0.Reset(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.taskList) do
		iter_3_1:Abort()
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.taskListAdd) do
		iter_3_3:Abort()
	end

	arg_3_0.taskList, arg_3_0.taskListAdd = nil

	for iter_3_4, iter_3_5 in pairs(arg_3_0.timers) do
		iter_3_5:Stop()
	end

	arg_3_0.timers = {}
end

function var_0_0.DoTask(arg_4_0, arg_4_1)
	if arg_4_1:IsCancelled() then
		arg_4_1:Abort()
	end

	while arg_4_1.progress >= 1 and arg_4_1.progress <= #arg_4_1.taskList do
		local var_4_0 = arg_4_1.taskList[arg_4_1.progress]
		local var_4_1, var_4_2, var_4_3 = unpack(var_4_0)
		local var_4_4

		if var_4_1(var_4_3) then
			if arg_4_1.progress ~= -1 then
				arg_4_1.progress = arg_4_1.progress + 1
			end

			if var_4_2 then
				return false
			end
		else
			return false
		end
	end

	if not arg_4_1:IsAborted() and arg_4_1.onComplete then
		arg_4_1.onComplete()
	end

	return true
end

function var_0_0.TickUpdate(arg_5_0)
	if arg_5_0.pause then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.taskListAdd) do
		table.insert(arg_5_0.taskList, iter_5_1)

		arg_5_0.taskListAdd[iter_5_0] = nil
	end

	arg_5_0.now = arg_5_0:Time()
	arg_5_0.lastUpdate = arg_5_0.lastUpdate or arg_5_0.now

	local var_5_0 = {}

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.taskList) do
		if not arg_5_0:DoTask(iter_5_3) then
			table.insert(var_5_0, iter_5_3)

			arg_5_0.taskList[iter_5_2] = nil
		end
	end

	arg_5_0.taskList = var_5_0, arg_5_0.taskList
	arg_5_0.lastUpdate = arg_5_0.now
end

function var_0_0.RegisterTask(arg_6_0, arg_6_1)
	table.insert(arg_6_0.taskListAdd, arg_6_1)
end

function var_0_0.NewTask(arg_7_0, arg_7_1)
	local var_7_0 = DormTask.New(arg_7_1)

	var_7_0:SetRunner(arg_7_0)

	return var_7_0
end

function var_0_0.NewTimer(arg_8_0, ...)
	local var_8_0 = Timer.New(...)

	table.insert(arg_8_0.timers, var_8_0)

	return var_8_0
end

function var_0_0.DeltaTime(arg_9_0)
	if arg_9_0.lastUpdate then
		return arg_9_0:Now() - arg_9_0.lastUpdate
	end

	return 0
end

function var_0_0.Now(arg_10_0)
	return arg_10_0.now
end

function var_0_0.Time(arg_11_0)
	return Time.time
end

return var_0_0
