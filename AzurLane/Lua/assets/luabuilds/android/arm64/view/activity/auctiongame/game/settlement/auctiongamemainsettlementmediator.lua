class = var_0_10000

local var_0_0 = "AuctionGameMainSettlementMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getContextByMediator

	AuctionGameMainMediator = var_1_10004

	if var_1_1(var_1_0, var_1_10004) then
		getProxy = var_1_10002
		ContextProxy = var_1_10004

		local var_1_2 = var_1_10002(var_1_10004)

		var_2.RemoveContext(var_1_2, var_1)
	end

	return
end

function var_0_1.remove(arg_2_0)
	return
end

return var_0_1
