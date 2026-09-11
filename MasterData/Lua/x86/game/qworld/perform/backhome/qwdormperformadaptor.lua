return {
	Init = function(self)
		local SyncUpdateDormTaskRunner = class("SyncUpdateDormTaskRunner", DormTaskRunner)

		function SyncUpdateDormTaskRunner:Time()
			return self.now
		end

		self.frameTaskRunner = SyncUpdateDormTaskRunner.New()

		self.frameTaskRunner:Init()

		self.isRunning = false
		self.now = Time.time
		self.maxIdentify = 1
		self.taskList = {}
	end,
	StartPerformTask = function(self, arg_3_1)
		if arg_3_1 then
			local var_3_0 = self.frameTaskRunner:NewTask({
				start = Time.time
			})

			self:InsertTask(var_3_0)
			arg_3_1(var_3_0)
			var_3_0:Start()
			self:StartRunner()
		end
	end,
	StartRunner = function(self)
		if not self.tick then
			self:RunnerFunc()

			self.tick = Timer.New(function()
				self:RunnerFunc()
			end, 0.03333333333333333, -1)

			self.tick:Start()
		end
	end,
	RunnerFunc = function(self)
		self.now = Time.time

		self.frameTaskRunner:TickUpdate()

		if not self:HasExecuteingTask() then
			self:StopRunner()
		end
	end,
	StopRunner = function(self)
		if self.tick then
			self.taskList = {}

			self.tick:Stop()

			self.tick = nil

			self.frameTaskRunner:Reset()
			self.frameTaskRunner:Init()
		end
	end,
	InsertTask = function(self, arg_8_1)
		self.maxIdentify = self.maxIdentify + 1
		self.taskList[self.maxIdentify] = arg_8_1
	end,
	HasExecuteingTask = function(self)
		for iter_9_0, iter_9_1 in pairs(self.taskList) do
			if not iter_9_1:IsFinished() then
				return true
			end
		end

		return false
	end,
	Dispose = function(self)
		self:StopRunner()
	end
}
