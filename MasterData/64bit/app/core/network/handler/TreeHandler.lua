local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Tree_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.treeData:onS2CGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Tree_Node_UpStage = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.model.User.treeData:onS2CUpgradeStage(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREE_NODE_UPSTAGE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Tree_Node_LevelUp = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.treeData:onS2CUpgradeLevel(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREE_NODE_LEVELUP, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Tree_Update_Notify = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_SHOW, false, {
				treeActive = arg_4_2
			})
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_TREE_UPDATE_NOTIFY, false, arg_4_1, arg_4_2)
		end
	end
}
