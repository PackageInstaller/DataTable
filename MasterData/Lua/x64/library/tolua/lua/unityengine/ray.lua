local var_0_0 = rawget
local var_0_1 = setmetatable
local var_0_2 = {
	direction = Vector3.zero,
	origin = Vector3.zero
}
local var_0_3 = tolua.initget(var_0_2)

function var_0_2.__index(arg_1_0, arg_1_1)
	local var_1_0 = var_0_0(var_0_2, arg_1_1)

	if var_1_0 == nil then
		var_1_0 = var_0_0(var_0_3, arg_1_1)

		if var_1_0 ~= nil then
			return var_1_0(arg_1_0)
		end
	end

	return var_1_0
end

function var_0_2.__call(arg_2_0, arg_2_1, arg_2_2)
	return var_0_2.New(arg_2_1, arg_2_2)
end

function var_0_2:New(arg_3_1)
	local var_3_0 = {
		direction = self:Normalize(),
		origin = arg_3_1
	}

	var_0_1(var_3_0, var_0_2)

	return var_3_0
end

function var_0_2:GetPoint(arg_4_1)
	(self.direction * arg_4_1):Add(self.origin)

	return self.direction * arg_4_1
end

function var_0_2:Get()
	return self.origin.x, self.origin.y, self.origin.z, self.direction.x, self.direction.y, self.direction.z
end

function var_0_2:__tostring()
	return string.format("Origin:(%f,%f,%f),Dir:(%f,%f, %f)", self.origin.x, self.origin.y, self.origin.z, self.direction.x, self.direction.y, self.direction.z)
end

UnityEngine.Ray = var_0_2

setmetatable(var_0_2, var_0_2)

return var_0_2
