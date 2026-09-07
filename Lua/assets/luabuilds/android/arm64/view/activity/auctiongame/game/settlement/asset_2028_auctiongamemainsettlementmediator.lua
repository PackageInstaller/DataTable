local AuctionGameMainSettlementMediator = class("AuctionGameMainSettlementMediator", import("view.base.ContextMediator"))

function AuctionGameMainSettlementMediator:register()
	local var_1_0 = getProxy(ContextProxy):getContextByMediator(AuctionGameMainMediator)

	if var_1_0 then
		getProxy(ContextProxy):RemoveContext(var_1_0)
	end

	return
end

function AuctionGameMainSettlementMediator:remove()
	return
end

return AuctionGameMainSettlementMediator
