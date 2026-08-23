local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Screen_Items_Notify = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.homeData:addAndDelUnputList(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SCREEN_ITEMS_NOTIFY, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Screen_Items_Infos = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.service.ServiceManager:getServiceByName("LoopService"):addToLoopFuncList((handler(g.core.model.User.homeData, function(arg_3_0)
				arg_3_0:initUnputList(arg_2_2)
			end)))
			g.core.service.ServiceManager:getServiceByName("LoopService"):addToLoopFuncList(function()
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_SCREEN_ITEMS_INFOS, false, arg_2_1, arg_2_2)
			end)
		end
	end
}
