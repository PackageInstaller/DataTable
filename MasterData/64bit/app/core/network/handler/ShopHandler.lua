local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Shop_Shopping = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.shopData:updateShopInfo(arg_1_2.info)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Shop_GetShopInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.shopData:initShopInfo(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SHOP_GETSHOPINFO, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Shop_SkinShopping = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SHOP_SKINSHOPPING, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Shop_SkinShopByItem = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SHOP_SKINSHOPBYITEM, false, arg_4_1, arg_4_2)
		end
	end
}
