type = var_0_10000

local var_0_0 = {}

tolua = var_0_10002

local var_0_1 = var_0_10002.typeof

tolua = var_0_10003

local var_0_2 = var_0_10003.findtype

local function var_0_3(arg_1_0)
	local var_1_0 = var_0_10000(arg_1_0)
	local var_1_1
	local var_1_2

	if var_1_0 == "table" then
		if var_0_0[arg_1_0] == nil then
			var_1_1 = var_0_1(arg_1_0)
			var_1_2 = var_0_0
			var_1_2[arg_1_0] = var_1_1
		end
	elseif var_1_0 == "string" then
		if var_0_0[arg_1_0] == nil then
			var_1_1 = var_0_2(arg_1_0)
			var_1_2 = var_0_0
			var_1_2[arg_1_0] = var_1_1
		end
	else
		error = var_1_2
		debug = var_1_10005

		var_1_2(var_1_10005.traceback("attemp to call typeof on type " .. var_1_0))
	end

	if var_1_1 == nil then
		warning = var_1_2

		var_1_2(var_1_1)
	end

	return var_1_1
end

local var_0_4 = typeof

return
