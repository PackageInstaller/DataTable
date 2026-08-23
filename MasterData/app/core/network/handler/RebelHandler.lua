local ProtoHandler = import(".ProtoHandler")
local var_0_1 = g.core.model.User.rebelData

return {
	on_S2C_Rebel_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_1:onS2CRebelInfo(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBEL_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_Rebel_AttackBegin = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBEL_ATTACKBEGIN, false, arg_2_1, arg_2_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REBEL_ATTACK_FAILED, false)
		end
	end,
	on_S2C_Rebel_AttackFinish = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBEL_ATTACKFINISH, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_Rebel_Share = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_1:onRebelShare(arg_4_2)
		end
	end,
	on_S2C_Rebel_Award = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_1:addRebelAward(arg_5_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBEL_AWARD, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_Rebel_NotifyCreate = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_1:addNotifyRebel(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBEL_NOTIFYCREATE, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_Rebel_One_Button_Award = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			arg_7_2.awards = var_0_1:addRebelAwardArr(arg_7_2)

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBEL_ONE_BUTTON_AWARD, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_Rebel_OneKeyAttackBegin = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBEL_ONEKEYATTACKBEGIN, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_Rebel_OneKey_AttackFinish = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBEL_ONEKEY_ATTACKFINISH, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_Rebel_SpiritHelp_OneKeyAttackBegin = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBEL_SPIRITHELP_ONEKEYATTACKBEGIN, false, arg_10_1, arg_10_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_Rebel_SpiritHelp_OneKey_AttackFinish = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_REBEL_SPIRITHELP_ONEKEY_ATTACKFINISH, false, arg_11_1, arg_11_2)
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.SPIRIT_HELP_NET_ERROR, false, arg_11_1, arg_11_2)
		end
	end
}
