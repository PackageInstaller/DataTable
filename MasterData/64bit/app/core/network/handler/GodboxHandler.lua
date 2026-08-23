local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_GodBox_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.godboxData:updateGodbox(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOD_BOX_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GodBox_Triggle = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.common.ActivitySort:setSortTp(g.core.common.ActivitySort.CHARGE_BUY)
			g.core.model.User.godboxData:updateGodbox(arg_2_2, true)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOD_BOX_TRIGGLE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GodBox_Shopping = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.common.ActivitySort:setSortTp(g.core.common.ActivitySort.CHARGE_ACHIEVE)
			g.core.model.User.godboxData:updateShopping(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GOD_BOX_SHOPPING, false, arg_3_1, arg_3_2)
		end
	end
}
