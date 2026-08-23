local var_0_0 = g.core.model.User.anniversaryData
local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_Anniversary_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_0:onS2CGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Anniversary_GetFloorAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_0:onS2CAnniversaryGetFloorAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETFLOORAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Anniversary_GetTaskAward = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_0:onS2CAnniversaryTaskAward(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETTASKAWARD, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Anniversary_TaskNotify = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_0:onS2CAnniversaryTaskNotify(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_TASKNOTIFY, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Anniversary_DrawJigsaw = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_0:onS2CAnniversaryDrawJigsaw(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_DRAWJIGSAW, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Anniversary_GetShareJigsaw = function(arg_6_0, arg_6_1, arg_6_2)
		var_0_0:onS2CAnniversaryGetShareJigsaw(arg_6_2)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETSHAREJIGSAW, false, arg_6_1, arg_6_2)

		if arg_6_2.ret and arg_6_2.ret ~= g.core.network.proto.RET_OK then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RET_ERROR, false, arg_6_2.ret)
		end
	end,
	on_S2C_Anniversary_GetDrawNumAward = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_0:onS2CAnniversaryGetDrawNumAward(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETDRAWNUMAWARD, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Anniversary_GetTotalScoreAward = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_0:onS2CAnniversaryGetTotalScoreAward(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETTOTALSCOREAWARD, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Anniversary_SignDay = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_0:onS2CAnniversarySignDay(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_SIGNDAY, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Anniversary_GetJigsawGroupAward = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_0:onS2CAnniversaryGetJigsawGroupAward(arg_10_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_ANNIVERSARY_GETJIGSAWGROUPAWARD, false, arg_10_1, arg_10_2)
		end
	end
}
