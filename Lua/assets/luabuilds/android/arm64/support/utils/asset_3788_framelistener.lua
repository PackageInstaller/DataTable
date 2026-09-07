FrameListener = class("FrameListener")

function FrameListener.Ctor(arg_1_0)
	arg_1_0.jobs = {}

	return
end

function FrameListener:UnShift(...)
	local var_2_0 = {
		...
	}

	for iter_2_0 = #var_2_0, 1, -1 do
		table.insert(self.jobs, 1, var_2_0[iter_2_0])
	end

	self:TryStart()

	return
end

function FrameListener:Push(...)
	local var_3_0 = {
		...
	}

	for iter_3_0 = 1, #var_3_0 do
		table.insert(self.jobs, var_3_0[iter_3_0])
	end

	self:TryStart()

	return
end

function FrameListener:Remove(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.jobs) do
		if iter_4_1 == arg_4_1 then
			table.remove(self.jobs, iter_4_0)
			self:TryStop()

			break
		end
	end

	return
end

function FrameListener:TryStart()
	if not self.running and #self.jobs > 0 then
		self.running = true

		UpdateBeat:Add(self.Update, self)
	end

	return
end

function FrameListener:TryStop()
	if self.running and #self.jobs == 0 then
		UpdateBeat:Remove(self.Update, self)

		self.running = false
	end

	return
end

function FrameListener:Update()
	if #self.jobs == 0 then
		self:TryStop()
	else
		table.remove(self.jobs, 1)()
	end

	return
end

return FrameListener
