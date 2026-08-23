local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.geneData

return {
	on_S2C_Gene_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CGeneGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GENE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Gene_ActivateSegment = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CGeneActivateSegment(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GENE_ACTIVATESEGMENT, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Gene_ActivateMap = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CGeneActivateMap(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GENE_ACTIVATEMAP, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Gene_ChangePosition = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CGeneChangePosition(arg_4_2)
			var_0_1:setSwapInfo(nil)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_GENE_CHANGEPOSITION, false, arg_4_1, arg_4_2)
		end
	end
}
