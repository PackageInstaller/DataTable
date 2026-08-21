local var_0_0 = {}
local var_0_1, var_0_2 = pcall(require, "bit")

if not var_0_1 then
	local var_0_3, var_0_4 = pcall(require, "bit32")
end

local var_0_5 = {
	down = -2,
	up = 2,
	left = -1,
	right = 1
}
local var_0_6 = {
	[var_0_5.left] = Vector2.left,
	[var_0_5.right] = Vector2.right,
	[var_0_5.down] = Vector2.down,
	[var_0_5.up] = Vector2.up
}

local function var_0_7(arg_1_0, arg_1_1)
	return arg_1_0 and arg_1_1 and arg_1_0 + arg_1_1 == 0
end

local function var_0_8(arg_2_0, arg_2_1)
	return arg_2_0 and arg_2_1 and arg_2_0 ~= arg_2_1
end

local function var_0_9(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0:IsGridEmpty(arg_3_1, arg_3_2) then
		return true
	end

	local var_3_0 = arg_3_0:Get(arg_3_1, arg_3_2)

	return var_3_0 and var_3_0.passThroughConnect or false
end

local function var_0_10(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_4 == var_0_5.left then
		if arg_4_0 < arg_4_2 or arg_4_1 ~= arg_4_3 then
			return false
		end
	elseif arg_4_4 == var_0_5.right then
		if arg_4_2 < arg_4_0 or arg_4_1 ~= arg_4_3 then
			return false
		end
	elseif arg_4_4 == var_0_5.down then
		if arg_4_1 < arg_4_3 or arg_4_0 ~= arg_4_2 then
			return false
		end
	elseif arg_4_4 == var_0_5.up and (arg_4_3 < arg_4_1 or arg_4_0 ~= arg_4_2) then
		return false
	end

	return true
end

local function var_0_11(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if arg_5_5 == nil then
		for iter_5_0, iter_5_1 in ipairs(var_0_5) do
			if var_0_10(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5) and var_0_11(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, iter_5_1) then
				return true
			end
		end
	else
		local var_5_0 = var_0_6[arg_5_5]
		local var_5_1 = arg_5_1 + var_5_0.x
		local var_5_2 = arg_5_2 + var_5_0.y

		if var_5_1 == arg_5_3 and var_5_2 == arg_5_4 then
			return true
		end

		while var_0_9(arg_5_0, var_5_1, var_5_2) do
			var_5_1 = var_5_1 + var_5_0.x
			var_5_2 = var_5_2 + var_5_0.y

			if var_5_1 == arg_5_3 and var_5_2 == arg_5_4 then
				return true
			end
		end
	end

	return false
end

local function var_0_12(arg_6_0, arg_6_1, arg_6_2)
	table.insert(arg_6_0, Vector2(arg_6_1, arg_6_2))

	return arg_6_0
end

local function var_0_13(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(var_0_5) do
		if not var_0_7(iter_7_1, arg_7_0) and iter_7_1 ~= arg_7_0 then
			table.insert(var_7_0, iter_7_1)
		end
	end

	local var_7_1 = Vector2(arg_7_3 - arg_7_1, arg_7_4 - arg_7_2)

	CommonTools.UniversalSortEx(var_7_0, {
		map = function(arg_8_0)
			return Vector2.Dot(var_0_6[arg_8_0], var_7_1)
		end
	})

	return ipairs(var_7_0)
end

local function var_0_14(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7)
	if var_0_10(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_6) and var_0_11(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_6) then
		return {}
	end

	if arg_9_5 == 0 then
		return nil
	end

	local var_9_0 = var_0_6[arg_9_6]
	local var_9_1 = arg_9_1 + var_9_0.x
	local var_9_2 = arg_9_2 + var_9_0.y

	while var_0_9(arg_9_0, var_9_1, var_9_2) do
		for iter_9_0, iter_9_1 in var_0_13(arg_9_6, arg_9_1, arg_9_2, arg_9_3, arg_9_4) do
			local var_9_3 = var_0_14(arg_9_0, var_9_1, var_9_2, arg_9_3, arg_9_4, arg_9_5 - 1, iter_9_1, arg_9_7)

			if var_9_3 then
				return var_0_12(var_9_3, var_9_1, var_9_2)
			end
		end

		var_9_1, var_9_2 = var_9_1 + var_9_0.x, var_9_2 + var_9_0.y
	end

	if var_9_1 == arg_9_3 and var_9_2 == arg_9_4 then
		return {
			Vector2(arg_9_1, arg_9_2)
		}
	end
end

function var_0_0.TestConnectivity(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	if arg_10_1 == arg_10_3 and arg_10_2 == arg_10_4 then
		return nil
	else
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in var_0_13(nil, arg_10_3, arg_10_4, arg_10_1, arg_10_2) do
			local var_10_1 = var_0_14(arg_10_0, arg_10_3, arg_10_4, arg_10_1, arg_10_2, arg_10_5, iter_10_1, var_10_0)

			if var_10_1 then
				return var_10_1
			end
		end
	end
end

return var_0_0
