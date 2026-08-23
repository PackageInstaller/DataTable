local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Reborn_Preview = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBORN_PREVIEW, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Reborn_Execute = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			if arg_2_2.kb then
				g.core.model.User.knightSoulData:setBookStarById(arg_2_2.kb.id, arg_2_2.kb.star)
			end

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBORN_EXECUTE, false, arg_2_1, arg_2_2)
		end
	end
}
