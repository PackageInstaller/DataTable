local State = class("State")

function State:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.name = arg_1_1

	if arg_1_2 ~= nil then
		self.entering = arg_1_2
	end

	if arg_1_3 ~= nil then
		self.exiting = arg_1_3
	end

	if arg_1_4 ~= nil then
		self.changed = arg_1_4
	end

	self.transitions = {}

	return
end

function State:defineTrans(arg_2_1, arg_2_2)
	assert(arg_2_1, "action should not be nil at " .. self.name)
	assert(arg_2_2, "target should not be nil at " .. self.name)

	if self:getTarget(arg_2_1) ~= nil then
		return
	end

	self.transitions[arg_2_1] = arg_2_2

	return
end

function State:removeTrans(arg_3_1)
	self.transitions[arg_3_1] = nil

	return
end

function State:getTarget(arg_4_1)
	return self.transitions[arg_4_1]
end

return State
