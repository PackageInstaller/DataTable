local var_0_0 = rawget
local var_0_1 = setmetatable
local var_0_2 = {
	direction = Vector3.zero,
	origin = Vector3.zero
}
local var_0_3 = tolua.initget({
	direction = Vector3.zero,
	origin = Vector3.zero
})

;({
	direction = Vector3.zero,
	origin = Vector3.zero
}).__index = function(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0(var_0_2, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_0(var_0_3, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end
;({
	direction = Vector3.zero,
	origin = Vector3.zero
}).__call = function(arg_2_0, arg_2_1, arg_2_2)
	return var_0_2.New(arg_2_1, arg_2_2)
end
;({
	direction = Vector3.zero,
	origin = Vector3.zero
}).New = function(arg_3_0, arg_3_1)
	local var_3_0 = {
		direction = arg_3_0:Normalize(),
		origin = arg_3_1
	}

	var_0_1(var_3_0, var_0_2)

	return var_3_0
end
;({
	direction = Vector3.zero,
	origin = Vector3.zero
}).GetPoint = function(arg_4_0, arg_4_1)
	(arg_4_0.direction * arg_4_1):Add(arg_4_0.origin)

	return arg_4_0.direction * arg_4_1
end
;({
	direction = Vector3.zero,
	origin = Vector3.zero
}).Get = function(arg_5_0)
	return arg_5_0.origin.x, arg_5_0.origin.y, arg_5_0.origin.z, arg_5_0.direction.x, arg_5_0.direction.y, arg_5_0.direction.z
end
;({
	direction = Vector3.zero,
	origin = Vector3.zero
}).__tostring = function(arg_6_0)
	return string.format("Origin:(%f,%f,%f),Dir:(%f,%f, %f)", arg_6_0.origin.x, arg_6_0.origin.y, arg_6_0.origin.z, arg_6_0.direction.x, arg_6_0.direction.y, arg_6_0.direction.z)
end
UnityEngine.Ray = {
	direction = Vector3.zero,
	origin = Vector3.zero
}

setmetatable({
	direction = Vector3.zero,
	origin = Vector3.zero
}, {
	direction = Vector3.zero,
	origin = Vector3.zero
})

return {
	direction = Vector3.zero,
	origin = Vector3.zero
}
