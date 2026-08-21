local var_0_0 = class("AuctionGameMainSettlementMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(ContextProxy):getContextByMediator(AuctionGameMainMediator)

	if var_1_0 then
		getProxy(ContextProxy):RemoveContext(var_1_0)
	end

	return
end

function var_0_0.remove(arg_2_0)
	return
end

return var_0_0
