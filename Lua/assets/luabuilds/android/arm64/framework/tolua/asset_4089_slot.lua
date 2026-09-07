local var_0_0 = setmetatable
local var_0_1 = {}

setmetatable(var_0_1, var_0_1)

function var_0_1:__call(...)
	if self.obj == nil then
		return self.func(...)
	else
		return self.func(self.obj, ...)
	end

	return
end

function var_0_1:__eq(arg_2_1)
	return self.func == arg_2_1.func and self.obj == arg_2_1.obj
end

function slot(arg_3_0, arg_3_1)
	return var_0_0({
		func = arg_3_0,
		obj = arg_3_1
	}, var_0_1)
end

return
