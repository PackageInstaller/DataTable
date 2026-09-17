local var_0_0 = {}
local var_0_1 = {}

local function var_0_2(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return nil
	end

	if not var_0_1[arg_1_0] then
		return arg_1_1
	end

	return var_0_1[arg_1_0](arg_1_1)
end

function var_0_0.dispatchEvent(arg_2_0, arg_2_1)
	local var_2_0 = cc.EventCustom:new(arg_2_0)

	var_2_0.params = var_0_2(arg_2_0, arg_2_1)

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_2_0)
end

return var_0_0
