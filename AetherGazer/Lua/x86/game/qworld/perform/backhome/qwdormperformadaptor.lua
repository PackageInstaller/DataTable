return {
	Init = function(arg_1_0)
		local var_1_0 = class("SyncUpdateDormTaskRunner", DormTaskRunner)

		function var_1_0.Time(arg_2_0)
			return arg_1_0.now
		end

		arg_1_0.frameTaskRunner = var_1_0.New()

		arg_1_0.frameTaskRunner:Init()

		arg_1_0.isRunning = false
		arg_1_0.now = Time.time
		arg_1_0.maxIdentify = 1
		arg_1_0.taskList = {}
	end,
	StartPerformTask = function(arg_3_0, arg_3_1)
		if arg_3_1 then
			local var_3_0 = arg_3_0.frameTaskRunner:NewTask({
				start = Time.time
			})

			arg_3_0:InsertTask(var_3_0)
			arg_3_1(var_3_0)
			var_3_0:Start()
			arg_3_0:StartRunner()
		end
	end,
	StartRunner = function(arg_4_0)
		if not arg_4_0.tick then
			arg_4_0:RunnerFunc()

			arg_4_0.tick = Timer.New(function()
				arg_4_0:RunnerFunc()
			end, 0.03333333333333333, -1)

			arg_4_0.tick:Start()
		end
	end,
	RunnerFunc = function(arg_6_0)
		arg_6_0.now = Time.time

		arg_6_0.frameTaskRunner:TickUpdate()

		if not arg_6_0:HasExecuteingTask() then
			arg_6_0:StopRunner()
		end
	end,
	StopRunner = function(arg_7_0)
		if arg_7_0.tick then
			arg_7_0.taskList = {}

			arg_7_0.tick:Stop()

			arg_7_0.tick = nil

			arg_7_0.frameTaskRunner:Reset()
			arg_7_0.frameTaskRunner:Init()
		end
	end,
	InsertTask = function(arg_8_0, arg_8_1)
		arg_8_0.maxIdentify = arg_8_0.maxIdentify + 1
		arg_8_0.taskList[arg_8_0.maxIdentify] = arg_8_1
	end,
	HasExecuteingTask = function(arg_9_0)
		for iter_9_0, iter_9_1 in pairs(arg_9_0.taskList) do
			if not iter_9_1:IsFinished() then
				return true
			end
		end

		return false
	end,
	Dispose = function(arg_10_0)
		arg_10_0:StopRunner()
	end
}
