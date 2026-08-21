local var_0_0 = type
local var_0_1 = {}
local var_0_2 = tolua.typeof
local var_0_3 = tolua.findtype

function typeof(arg_1_0)
	local var_1_0 = var_0_0(arg_1_0)
	local var_1_1

	if var_1_0 == "table" then
		var_1_1 = var_0_1[arg_1_0]

		if var_1_1 == nil then
			var_1_1 = var_0_2(arg_1_0)
			var_0_1[arg_1_0] = var_1_1
		end
	elseif var_1_0 == "string" then
		var_1_1 = var_0_1[arg_1_0]

		if var_1_1 == nil then
			var_1_1 = var_0_3(arg_1_0)
			var_0_1[arg_1_0] = var_1_1
		end
	else
		error(debug.traceback("attemp to call typeof on type " .. var_1_0))
	end

	return var_1_1
end
