local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_WeekGift_PurchaseWithGold = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.weekGiftData:updatePurchaseInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_WEEK_GIFT_PURCHASEWITHGOLD, false, arg_1_1, arg_1_2)
		end
	end
}
