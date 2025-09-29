local var_0_0 = debug.getinfo
local var_0_1 = error
local var_0_2 = rawset
local var_0_3 = rawget
local var_0_4 = getmetatable(_G)

if var_0_4 == nil then
	var_0_4 = {}

	setmetatable(_G, var_0_4)
end

var_0_4.__declared = {}

function var_0_4.__newindex(arg_1_0, arg_1_1, arg_1_2)
	if not var_0_4.__declared[arg_1_1] then
		local var_1_0 = var_0_0(2, "S")

		if var_1_0 and var_1_0.linedefined > 0 then
			var_0_1("assign to undeclared variable '" .. arg_1_1 .. "'", 2)
		end

		var_0_4.__declared[arg_1_1] = true
	end

	var_0_2(arg_1_0, arg_1_1, arg_1_2)
end

function var_0_4.__index(arg_2_0, arg_2_1)
	if not var_0_4.__declared[arg_2_1] then
		local var_2_0 = var_0_0(2, "S")

		if var_2_0 and var_2_0.linedefined > 0 then
			var_0_1("variable '" .. arg_2_1 .. "' is not declared", 2)
		end
	end

	return var_0_3(arg_2_0, arg_2_1)
end
