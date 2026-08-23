local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_PushGift_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.pushGiftData:initPushGiftInfo(arg_1_2)
			g.core.model.User.hotSaleGMGiftData:initHotSaleGiftInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_PushGift_Award = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.pushGiftData:updateGiftInfoByBuyRec(arg_2_2.gifts)
			g.core.model.User.hotSaleGMGiftData:removeGetAwardsGMGifts(arg_2_2.gifts)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_AWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_PushGift_Buy = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.pushGiftData:updateGiftInfoByBuyRec(arg_3_2.gifts)
			g.core.model.User.hotSaleGMGiftData:updateGMGiftInfoByBuyRec(arg_3_2.gifts)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_BUY, false, arg_3_1, arg_3_2)
		else
			g.core.network.GameNetProxy:send_C2S_PushGift_Info({})
			g.core.network.GameNetProxy:send_C2S_PushGift_GetGmActInfo({})
		end
	end,
	on_S2C_PushGift_GetGmActInfo = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.pushGiftData:updatePushGiftGMInfo(arg_4_2)
			g.core.model.User.hotSaleGMGiftData:updateHotSaleGiftGMInfo(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PUSH_GIFT_GETGMACTINFO, false, arg_4_1, arg_4_2)
		end
	end
}
