local BaseLadyEnv = class("BaseLadyEnv")

function BaseLadyEnv:Ctor(arg_1_1, arg_1_2)
	self.event = arg_1_1
	self.scene = arg_1_2

	return
end

function BaseLadyEnv:Emit(arg_2_1, ...)
	self.event:emit(arg_2_1, ...)

	return
end

function BaseLadyEnv:Func(arg_3_1, ...)
	assert(self.scene[arg_3_1], "Function " .. arg_3_1 .. " not found in scene")

	return self.scene[arg_3_1](self.scene, ...)
end

function BaseLadyEnv:Get(arg_4_1)
	return self.scene[arg_4_1]
end

function BaseLadyEnv:Init()
	return
end

function BaseLadyEnv:HandleNotification(arg_6_1, arg_6_2)
	return
end

function BaseLadyEnv.GetInterests()
	return {}
end

function BaseLadyEnv.IsOpen()
	return false
end

function BaseLadyEnv:Dispose()
	return
end

return BaseLadyEnv
