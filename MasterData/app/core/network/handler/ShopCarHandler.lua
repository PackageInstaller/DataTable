local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_ShopCar_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.shopData:onS2CShopCarInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SHOP_CAR_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_ShopCar_Follow = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.shopData:onS2CShopCarFollow(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SHOP_CAR_FOLLOW, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_ShopCar_Unfollow = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.shopData:onS2CShopCarUnfollow(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SHOP_CAR_UNFOLLOW, false, arg_3_1, arg_3_2)
		end
	end
}
