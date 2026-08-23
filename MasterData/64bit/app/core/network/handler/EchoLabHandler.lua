local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.echoLabData

return {
	on_S2C_Palace_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CPalaceGetInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PALACE_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Palace_GetHangupAward = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_1:onS2CPalaceGetHangupAward(arg_2_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PALACE_GETHANGUPAWARD, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_Palace_ActiveCompose = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_1:onS2CPalaceActiveCompose(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PALACE_ACTIVECOMPOSE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Palace_UpgradeCompose = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onS2CPalaceUpgradeCompose(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PALACE_UPGRADECOMPOSE, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_Palace_OneKeyUpgradeCompose = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:onS2CPalaceOneKeyUpgradeCompose(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PALACE_ONEKEYUPGRADECOMPOSE, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Palace_ActiveAltarNode = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_1:onS2CPalaceActiveAltarNode(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PALACE_ACTIVEALTARNODE, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Palace_UseCompose = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_1:onS2CPalaceUseCompose(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PALACE_USECOMPOSE, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Palace_UnuseCompose = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_1:onS2CPalaceUnuseCompose(arg_8_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PALACE_UNUSECOMPOSE, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Palace_FirstEnterBuild = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_1:onS2CPalaceFirstEnterBuild(arg_9_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_PALACE_FIRSTENTERBUILD, false, arg_9_1, arg_9_2)
		end
	end
}
