local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_UserBack_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			if arg_1_2.info then
				g.core.model.User.userBackData:updateUserBackInfo(arg_1_2)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_UserBack_GetSignReward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.userBackData:updateSignData(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETSIGNREWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_UserBack_BuyGift = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.userBackData:updateGiftData(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_USER_BACK_BUYGIFT, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_UserBack_GetBackRes = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.userBackData:updateResourceGet(arg_4_2.day, arg_4_2.target_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETBACKRES, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_UserBack_ResActionNotify = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.userBackData:updateResourceActionValue(arg_5_2.datas)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_USER_BACK_RESACTIONNOTIFY, false, arg_5_1, arg_5_2)
		end
	end
}
