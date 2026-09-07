local TSTask = class("TSTask")

function TSTask:SetJob(arg_1_1)
	self.job = arg_1_1

	return
end

function TSTask:Execute()
	self.job()

	return os.clock() - os.clock()
end

function TSTask:Clear()
	self.job = nil

	return
end

return TSTask
