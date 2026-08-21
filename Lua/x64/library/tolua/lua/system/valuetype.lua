local var_0_0 = {
	[Vector3] = 1,
	[Quaternion] = 2,
	[Vector2] = 3,
	[Color] = 4,
	[Vector4] = 5,
	[Ray] = 6,
	[Bounds] = 7,
	[Touch] = 8,
	[LayerMask] = 9,
	[RaycastHit] = 10,
	[int64] = 11,
	[uint64] = 12
}

local function var_0_1()
	local var_1_0 = getmetatable
	local var_1_1 = var_0_0

	return function(arg_2_0)
		local var_2_0 = var_1_0(arg_2_0)

		if var_2_0 == nil then
			return 0
		end

		return var_1_1[var_2_0] or 0
	end
end

function AddValueType(arg_3_0, arg_3_1)
	var_0_0[arg_3_0] = arg_3_1
end

GetLuaValueType = var_0_1()
