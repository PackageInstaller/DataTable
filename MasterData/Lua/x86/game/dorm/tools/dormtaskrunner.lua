local DormTaskRunner = class("DormTaskRunner")

function DormTaskRunner:Ctor()
	self.timers = {}
end

function DormTaskRunner:Init()
	self.taskList, self.taskListAdd = {}, {}
	self.lastUpdate = nil
	self.now = 0
end

function DormTaskRunner:Reset()
	for iter_3_0, iter_3_1 in ipairs(self.taskList) do
		iter_3_1:Abort()
	end

	for iter_3_2, iter_3_3 in ipairs(self.taskListAdd) do
		iter_3_3:Abort()
	end

	self.taskList, self.taskListAdd = nil

	for iter_3_4, iter_3_5 in pairs(self.timers) do
		iter_3_5:Stop()
	end

	self.timers = {}
end

function DormTaskRunner:DoTask(arg_4_1)
	if arg_4_1:IsCancelled() then
		arg_4_1:Abort()
	end

	while arg_4_1.progress >= 1 and arg_4_1.progress <= #arg_4_1.taskList do
		local var_4_0, var_4_1, var_4_2 = unpack(arg_4_1.taskList[arg_4_1.progress])

		if var_4_0(var_4_2) then
			if arg_4_1.progress ~= -1 then
				arg_4_1.progress = arg_4_1.progress + 1
			end

			if var_4_1 then
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

function DormTaskRunner:TickUpdate()
	if self.pause then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(self.taskListAdd) do
		table.insert(self.taskList, iter_5_1)

		self.taskListAdd[iter_5_0] = nil
	end

	self.now = self:Time()
	self.lastUpdate = self.lastUpdate or self.now

	local var_5_0 = {}

	for iter_5_2, iter_5_3 in ipairs(self.taskList) do
		if not self:DoTask(iter_5_3) then
			table.insert(var_5_0, iter_5_3)

			self.taskList[iter_5_2] = nil
		end
	end

	self.taskList = var_5_0
	self.lastUpdate = self.now
end

function DormTaskRunner:RegisterTask(arg_6_1)
	table.insert(self.taskListAdd, arg_6_1)
end

function DormTaskRunner:NewTask(arg_7_1)
	local var_7_0 = DormTask.New(arg_7_1)

	var_7_0:SetRunner(self)

	return var_7_0
end

function DormTaskRunner:NewTimer(...)
	local var_8_0 = Timer.New(...)

	table.insert(self.timers, var_8_0)

	return var_8_0
end

function DormTaskRunner:DeltaTime()
	if self.lastUpdate then
		return self:Now() - self.lastUpdate
	end

	return 0
end

function DormTaskRunner:Now()
	return self.now
end

function DormTaskRunner:Time()
	return Time.time
end

return DormTaskRunner
