local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_CustomActivity_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.activityDataManager:onRcvCustomActivityGetInfo(arg_1_2)
			g.core.model.User.activityCollectData:onRcvCustomActivityGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_CustomActivity_GetAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			-- block empty
		end
	end,
	on_S2C_CustomActivity_Exchange = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			-- block empty
		end
	end,
	on_S2C_CustomActivity_SyncTask = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			-- block empty
		end
	end,
	on_S2C_CustomActivity_UpdateInfo = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.activityDataManager:onRcvCustomActivityUpdateInfo(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_UPDATEINFO, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_CustomActivity_ReqInfo = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.activityDataManager:onRcvCustomActivityReqInfo(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_REQINFO, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_CustomActivity_Collection = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.activityCollectData:onRcvCustomActivityCollection(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CUSTOM_ACTIVITY_COLLECTION, false, arg_7_1, arg_7_2)
		end
	end
}
