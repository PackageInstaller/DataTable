local var_0_0 = setmetatable
local var_0_1 = Mathf
local var_0_2 = Vector3
local var_0_3 = {}

function var_0_3.__index(arg_1_0, arg_1_1)
	return rawget(var_0_3, arg_1_1)
end

function var_0_3.__call(arg_2_0, arg_2_1)
	return var_0_3.New(arg_2_1)
end

function var_0_3:New(arg_3_1)
	return var_0_0({
		normal = self:Normalize(),
		distance = arg_3_1
	}, var_0_3)
end

function var_0_3:Get()
	return self.normal, self.distance
end

function var_0_3:Raycast(arg_5_1)
	local var_5_0 = var_0_2.Dot(arg_5_1.direction, self.normal)
	local var_5_1

	if var_0_1.Approximately(var_5_0, 0) then
		do return false, 0 end

		var_5_1 = (-var_0_2.Dot(arg_5_1.origin, self.normal) - self.distance) / var_5_0 > 0
	end

	return var_5_1, (-var_0_2.Dot(arg_5_1.origin, self.normal) - self.distance) / var_5_0
end

function var_0_3.SetNormalAndPosition(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.normal = arg_6_1:Normalize()
	arg_6_0.distance = -var_0_2.Dot(arg_6_1, arg_6_2)

	return
end

function var_0_3:Set3Points(arg_7_1, arg_7_2, arg_7_3)
	self.normal = var_0_2.Normalize(var_0_2.Cross(arg_7_2 - arg_7_1, arg_7_3 - arg_7_1))
	self.distance = -var_0_2.Dot(self.normal, arg_7_1)

	return
end

function var_0_3:GetDistanceToPoint(arg_8_1)
	return var_0_2.Dot(self.normal, arg_8_1) + self.distance
end

function var_0_3:GetSide(arg_9_1)
	return var_0_2.Dot(self.normal, arg_9_1) + self.distance > 0
end

function var_0_3:SameSide(arg_10_1, arg_10_2)
	local var_10_0 = self:GetDistanceToPoint(arg_10_1)
	local var_10_1 = self:GetDistanceToPoint(arg_10_2)

	return var_10_0 > 0 and var_10_1 > 0 or var_10_0 <= 0 and var_10_1 <= 0
end

UnityEngine.Plane = var_0_3

setmetatable(var_0_3, var_0_3)

return var_0_3
