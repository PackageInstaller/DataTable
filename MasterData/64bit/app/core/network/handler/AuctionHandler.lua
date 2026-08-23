local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Auction_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.AuctionData:initAuctionData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_AUCTION_GETINFO, false, arg_1_2)
		end
	end,
	on_S2C_Auction_BidPrice = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_AUCTION_BIDPRICE, false, arg_2_2)
		end
	end,
	on_S2C_Auction_GetRecord = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_AUCTION_GETRECORD, false, arg_3_2)
		end
	end,
	on_S2C_Auction_ClickTab = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_AUCTION_CLICKTAB, false, arg_4_2)
		end
	end,
	on_S2C_Auction_Quit = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_AUCTION_QUIT, false, arg_5_2)
		end
	end,
	on_S2C_Auction_GoodsNotify = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_AUCTION_GOODSNOTIFY, false, arg_6_2)
		end
	end,
	on_S2C_Auction_CreateNotify = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.AuctionData:setActId(arg_7_2.act_id)
			g.core.model.User.AuctionData:updateNewActId(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_AUCTION_CREATENOTIFY, false, arg_7_2)
		end
	end
}
