local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_FlushShop_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.shopFlushData:updateShopFlushInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_SHOP_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_FlushShop_Flush = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.shopFlushData:updateShopFlushInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_SHOP_FLUSH, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_FlushShop_Buy = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.shopFlushData:updateShopFlushInfo(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_FLUSH_SHOP_BUY, false, arg_3_1, arg_3_2)
		end
	end
}
