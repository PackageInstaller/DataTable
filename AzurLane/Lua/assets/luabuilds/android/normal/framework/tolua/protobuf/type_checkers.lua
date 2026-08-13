type = var_0_10000
error = var_0_10001
string = var_0_10002
module = var_0_10003

var_0_10003("protobuf.type_checkers")

local function var_0_0(arg_1_0)
	local var_1_0 = arg_1_0

	return function(arg_2_0)
		local var_2_0 = var_0_10000(arg_2_0)

		if var_1_0[var_0_10000(arg_2_0)] == nil then
			var_0_10001(var_0_10002.format("%s has type %s, but expected one of: %s", arg_2_0, var_0_10000(arg_2_0), var_1_0))
		end

		return
	end
end

local var_0_1 = TypeChecker

local function var_0_2()
	local var_3_0 = 0
	local var_3_1 = 2147483647

	return function(arg_4_0)
		if var_0_10000(arg_4_0) ~= "number" then
			var_0_10001(var_0_10002.format("%s has type %s, but expected one of: number", arg_4_0, var_0_10000(arg_4_0)))
		end

		if arg_4_0 < var_3_0 or arg_4_0 > var_3_1 then
			var_0_10001("Value out of range: " .. arg_4_0)
		end

		return
	end
end

local var_0_3 = Int32ValueChecker

local function var_0_4(arg_5_0)
	local var_5_0 = 0
	local var_5_1 = 4294967295

	return function(arg_6_0)
		if var_0_10000(arg_6_0) ~= "number" then
			var_0_10001(var_0_10002.format("%s has type %s, but expected one of: number", arg_6_0, var_0_10000(arg_6_0)))
		end

		if arg_6_0 < var_5_0 or arg_6_0 > var_5_1 then
			var_0_10001("Value out of range: " .. arg_6_0)
		end

		return
	end
end

local var_0_5 = Uint32ValueChecker

local function var_0_6()
	return function(arg_8_0)
		if var_0_10000(arg_8_0) ~= "string" then
			var_0_10001(var_0_10002.format("%s has type %s, but expected one of: string", arg_8_0, var_0_10000(arg_8_0)))
		end

		return
	end
end

local var_0_7 = UnicodeValueChecker

return
