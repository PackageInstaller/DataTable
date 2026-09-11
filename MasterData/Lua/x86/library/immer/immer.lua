local utils = require("library/immer/utils")
local proxy = require("library/immer/proxy")
local var_0_2 = {
	NOTHING = utils.NOTHING,
	insert = proxy.insert,
	remove = proxy.remove,
	getn = proxy.getn,
	ipairs = proxy.ipairs,
	pairs = proxy.pairs
}

function var_0_2.produce(arg_1_0, arg_1_1)
	if not utils.isProxyable(arg_1_0) or utils.isProxy(arg_1_0) then
		local var_1_0 = arg_1_1(arg_1_0)

		if var_1_0 == nil then
			return arg_1_0
		else
			return var_0_2.normalizeResult(var_1_0)
		end
	end

	return var_0_2.normalizeResult(proxy.produceImpl(arg_1_0, arg_1_1))
end

function var_0_2.normalizeResult(arg_2_0)
	if arg_2_0 == utils.NOTHING then
		return nil
	else
		return arg_2_0
	end
end

return var_0_2
