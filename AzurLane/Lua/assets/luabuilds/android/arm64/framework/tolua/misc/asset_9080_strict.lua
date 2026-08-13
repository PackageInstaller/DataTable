debug = var_0_10000

local var_0_0 = var_0_10000.getinfo

error = var_0_10001
rawset = var_0_10002
rawget = var_0_10003
getmetatable = var_0_10004
_G = var_0_10006

local var_0_1

if var_0_10004(var_0_10006) == nil then
	var_0_1 = {}
	setmetatable = var_0_10005
	_G = var_0_10007

	var_0_10005(var_0_10007, var_0_1)
end

var_0_1.__declared = {}

function var_0_1.__newindex(arg_1_0, arg_1_1, arg_1_2)
	if not var_0_1.__declared[arg_1_1] then
		if var_0_0(2, "S") and var_3.linedefined > 0 then
			var_0_10001("assign to undeclared variable '" .. arg_1_1 .. "'", 2)
		end

		var_0_1.__declared[arg_1_1] = true
	end

	var_0_10002(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.__index(arg_2_0, arg_2_1)
	if not var_0_1.__declared[arg_2_1] and var_0_0(2, "S") and var_2.linedefined > 0 then
		var_0_10001("variable '" .. arg_2_1 .. "' is not declared", 2)
	end

	return var_0_10003(arg_2_0, arg_2_1)
end

return
