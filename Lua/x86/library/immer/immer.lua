local var_0_0 = require("library/immer/utils")
local var_0_1 = require("library/immer/proxy")
local var_0_2 = {
	NOTHING = var_0_0.NOTHING,
	insert = var_0_1.insert,
	remove = var_0_1.remove,
	getn = var_0_1.getn,
	ipairs = var_0_1.ipairs,
	pairs = var_0_1.pairs
}

function var_0_2.produce(arg_1_0, arg_1_1)
	if not var_0_0.isProxyable(arg_1_0) or var_0_0.isProxy(arg_1_0) then
		local var_1_0 = arg_1_1(arg_1_0)

		if var_1_0 == nil then
			return arg_1_0
		else
			return var_0_2.normalizeResult(var_1_0)
		end
	end

	return var_0_2.normalizeResult(var_0_1.produceImpl(arg_1_0, arg_1_1))
end

function var_0_2.normalizeResult(arg_2_0)
	if arg_2_0 == var_0_0.NOTHING then
		return nil
	else
		return arg_2_0
	end
end

return var_0_2
