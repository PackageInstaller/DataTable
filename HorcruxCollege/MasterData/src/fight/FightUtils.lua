local var_0_0 = {}

local function var_0_1(arg_1_0)
	local var_1_0 = require("data.buff_data")[arg_1_0]

	if not var_1_0 then
		return nil, nil
	end

	if var_1_0.exe_type ~= 0 then
		return nil, nil
	end

	if var_1_0.status_add2 ~= nil then
		return nil, nil
	end

	local var_1_1 = require("data.status_data")[var_1_0.status_add1]

	if not var_1_1 then
		return nil, nil
	end

	local var_1_2 = require("fight.fightstatus.fightstatus_manager"):getRegisterAttribute(var_1_1.status_type)

	if not var_1_2 then
		return nil, nil
	end

	if var_1_1.param1 then
		return nil, nil
	end

	if var_1_1.value2 or var_1_1.value3 or var_1_1.value4 then
		return nil, nil
	end

	return var_1_2, var_1_1.value1
end

function var_0_0.getBuffInfo(arg_2_0, arg_2_1)
	local var_2_0 = require("data.buff_data")[arg_2_1]

	if not var_2_0 then
		return nil
	end

	local var_2_1, var_2_2 = var_0_1(arg_2_1)
	local var_2_3 = {
		name = var_2_0.name
	}

	var_2_3.desc = var_2_0.detail or var_2_0.name
	var_2_3.attr = var_2_1
	var_2_3.attrvalue = var_2_2

	return var_2_3
end

return var_0_0
