local Dispatcher = class("Dispatcher")

function Dispatcher:Emit(arg_1_1, ...)
	local var_1_0 = {
		...
	}

	if self.events[arg_1_1] then
		local var_1_1 = {}

		table.merge(var_1_1, self.events[arg_1_1])

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			iter_1_1(arg_1_1, unpack(var_1_0))
		end
	end
end

function Dispatcher:Bind(arg_2_1, arg_2_2)
	self.events = self.events or {}

	local var_2_0 = self.events[arg_2_1]

	if not self.events[arg_2_1] then
		var_2_0 = {}
		self.events[arg_2_1] = var_2_0
	end

	if not table.indexof(var_2_0, arg_2_2) then
		table.insert(var_2_0, arg_2_2)
	end
end

function Dispatcher:Unbind(arg_3_1, arg_3_2)
	if self.events[arg_3_1] then
		if arg_3_2 ~= nil then
			table.removebyvalue(self.events[arg_3_1], arg_3_2)
		else
			self.events[arg_3_1] = {}
		end
	end
end

function Dispatcher:Dispose()
	self.events = nil
end

return Dispatcher
