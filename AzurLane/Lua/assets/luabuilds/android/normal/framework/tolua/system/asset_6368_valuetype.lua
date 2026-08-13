local var_0_0 = {}

Vector3 = var_0_10001
var_0_0[var_0_10001] = 1
Quaternion = var_0_10001
var_0_0[var_0_10001] = 2
Vector2 = var_0_10001
var_0_0[var_0_10001] = 3
Color = var_0_10001
var_0_0[var_0_10001] = 4
Vector4 = var_0_10001
var_0_0[var_0_10001] = 5
Ray = var_0_10001
var_0_0[var_0_10001] = 6
Bounds = var_0_10001
var_0_0[var_0_10001] = 7
Touch = var_0_10001
var_0_0[var_0_10001] = 8
LayerMask = var_0_10001
var_0_0[var_0_10001] = 9
RaycastHit = var_0_10001
var_0_0[var_0_10001] = 10
int64 = var_0_10001
var_0_0[var_0_10001] = 11
uint64 = var_0_10001
var_0_0[var_0_10001] = 12

local function var_0_1()
	getmetatable = var_1_10000

	local var_1_0 = var_0_0

	return function(arg_2_0)
		if var_1_10000(arg_2_0) == nil then
			return 0
		end

		local var_2_0

		if not var_1_0[var_1] then
			var_2_0 = 0
		end

		return var_2_0
	end
end

local function var_0_2(arg_3_0, arg_3_1)
	var_0_0[arg_3_0] = arg_3_1

	return
end

local var_0_3 = AddValueType
local var_0_4 = var_0_1()
local var_0_5 = GetLuaValueType

return
