local TSTaskQueue = class("TSTaskQueue")

TSTaskQueue.MTPF = 0.03333333333333333

function TSTaskQueue:Ctor(arg_1_1)
	self.maxTimePerFrame = math.min(arg_1_1, TSTaskQueue.MTPF)
	self.taskPool = {}
	self.taskQueue = {}
	self.running = false
	self.updateHandle = UpdateBeat:CreateListener(self.Update, self)

	return
end

function TSTaskQueue:Enqueue(arg_2_1)
	assert(type(arg_2_1) == "function", "job should be a function")

	local var_2_0 = #self.taskPool > 0 and table.remove(self.taskPool, #self.taskPool) or TSTask.New()

	var_2_0:SetJob(arg_2_1)
	table.insert(self.taskQueue, var_2_0)

	if not self.running then
		self.running = true

		UpdateBeat:AddListener(self.updateHandle)
	end

	return
end

function TSTaskQueue:Update()
	if not self.running then
		return
	end

	local var_3_0 = 0

	while var_3_0 < self.maxTimePerFrame do
		if #self.taskQueue == 0 then
			UpdateBeat:RemoveListener(self.updateHandle)

			self.running = false

			return
		end

		local var_3_1 = table.remove(self.taskQueue, 1)

		var_3_0 = var_3_0 + var_3_1:Execute()

		var_3_1:Clear()
		table.insert(self.taskPool, var_3_1)
	end

	return
end

function TSTaskQueue:IsBusy()
	return self.running
end

function TSTaskQueue:Clear(arg_5_1)
	for iter_5_0 = #self.taskQueue, 1, -1 do
		if arg_5_1 then
			self.taskQueue[iter_5_0]:Execute()
		end

		self.taskQueue[iter_5_0]:Clear()
		table.insert(self.taskPool, self.taskQueue[iter_5_0])
	end

	self.taskQueue = {}

	return
end

return TSTaskQueue
