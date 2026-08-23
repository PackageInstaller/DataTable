local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_WishShop_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.wishShopData:updateWishData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WISH_SHOP_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_WishShop_DailyWishAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.wishShopData:setDailyWish(true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WISH_SHOP_DAILYWISHAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_WishShop_DailyWishChoseAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.wishShopData:setDailyWishSelect(arg_3_2.index, arg_3_2.is_chose)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WISH_SHOP_DAILYWISHCHOSEAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_WishShop_TaskAward = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.wishShopData:updateTaskData(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WISH_SHOP_TASKAWARD, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_WishShop_TaskNotify = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WISH_SHOP_TASKNOTIFY, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_WishShop_GiftAward = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.wishShopData:updateGiftData(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WISH_SHOP_GIFTAWARD, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_WishShop_GiftBuyNotify = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.wishShopData:updateGiftData(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WISH_SHOP_GIFTBUYNOTIFY, false, arg_7_1, arg_7_2)
		end
	end
}
