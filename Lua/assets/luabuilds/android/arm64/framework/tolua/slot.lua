local var_0_0 = {}

setmetatable({}, {})

;({}).__call = function(arg_1_0, ...)
	if arg_1_0.obj == nil then
		return arg_1_0.func(...)
	else
		return arg_1_0.func(arg_1_0.obj, ...)
	end

	return
end
;({}).__eq = function(arg_2_0, arg_2_1)
	return arg_2_0.func == arg_2_1.func and arg_2_0.obj == arg_2_1.obj
end

function slot(arg_3_0, arg_3_1)
	return var_0({
		func = arg_3_0,
		obj = arg_3_1
	}, var_0_0)
end

return
