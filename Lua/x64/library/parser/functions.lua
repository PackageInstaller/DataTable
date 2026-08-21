local function var_0_0(arg_1_0, arg_1_1)
	return (arg_1_0.x - arg_1_1.x) * (arg_1_0.x - arg_1_1.x) + (arg_1_0.y - arg_1_1.y) * (arg_1_0.y - arg_1_1.y) + (arg_1_0.z - arg_1_1.z) * (arg_1_0.z - arg_1_1.z)
end

return {
	inc = function(arg_2_0)
		return arg_2_0 + 1
	end,
	dec = function(arg_3_0)
		return arg_3_0 - 1
	end,
	sum = function(...)
		local var_4_0 = 0
		local var_4_1 = {
			...
		}

		for iter_4_0 = 1, #var_4_1 do
			var_4_0 = var_4_0 + var_4_1[iter_4_0]
		end

		return var_4_0
	end,
	dist = function(arg_5_0, arg_5_1)
		return math.sqrt(var_0_0(arg_5_0, arg_5_1))
	end,
	count = function(arg_6_0)
		return #arg_6_0
	end,
	index = function(arg_7_0, arg_7_1)
		return arg_7_0[arg_7_1]
	end,
	pointAtCircle = function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = Vector3.New(arg_8_0.x - arg_8_1.x, arg_8_0.y - arg_8_1.y, arg_8_0.z - arg_8_1.z)
		local var_8_1 = Vector3.Normalize(var_8_0)

		var_8_1:Mul(arg_8_2)
		var_8_1:Add(arg_8_1)

		return var_8_1
	end,
	radians4point2d = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		return lk.math2d.radians4point(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	end,
	radians2degrees = function(arg_10_0)
		return lk.math2d.radians2degrees(arg_10_0)
	end,
	kvPair = function(arg_11_0, arg_11_1)
		return {
			[arg_11_0] = arg_11_1
		}
	end,
	["and"] = function(...)
		local var_12_0 = {
			...
		}

		for iter_12_0 = 1, #var_12_0 do
			if not var_12_0[iter_12_0] then
				return false
			end
		end

		return true
	end,
	["or"] = function(...)
		local var_13_0 = {
			...
		}

		for iter_13_0 = 1, #var_13_0 do
			if var_13_0[iter_13_0] then
				return true
			end
		end

		return false
	end,
	["not"] = function(arg_14_0)
		return not arg_14_0
	end,
	["if"] = function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 then
			return arg_15_1
		else
			return arg_15_2
		end
	end
}
