local ProtoHandler = import(".ProtoHandler")
local var_0_1 = {}
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.model.User.redCliffData

function var_0_1.on_S2C_ChiBi_GetInfo(arg_1_0, arg_1_1, arg_1_2)
	if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
		var_0_4:onS2CChibiGetInfo(arg_1_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_GETINFO, false, arg_1_1, arg_1_2)
	end
end

function var_0_1.on_S2C_ChiBi_Apply(arg_2_0, arg_2_1, arg_2_2)
	if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
		var_0_4:onS2CChibiApply(arg_2_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_APPLY, false, arg_2_1, arg_2_2)
	end
end

function var_0_1.on_S2C_ChiBi_GetFinalRoom(arg_3_0, arg_3_1, arg_3_2)
	if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
		var_0_4:onS2CGetFinalRoom(arg_3_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_GETFINALROOM, false, arg_3_1, arg_3_2)
	end
end

function var_0_1.on_S2C_ChiBi_EnterRoom(arg_4_0, arg_4_1, arg_4_2)
	if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
		var_0_4:onS2CChibiEnterRoom(arg_4_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_ENTERROOM, false, arg_4_1, arg_4_2)
	end
end

function var_0_1.on_S2C_ChiBi_LevelRoom(arg_5_0, arg_5_1, arg_5_2)
	var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_LEVELROOM, false, arg_5_1, arg_5_2)
end

function var_0_1.on_S2C_ChiBi_LevelComponent(arg_6_0, arg_6_1, arg_6_2)
	if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
		var_0_4:onS2CLeaveComponent(arg_6_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_LEVELCOMPONENT, false, arg_6_1, arg_6_2)
	end
end

function var_0_1.on_S2C_ChiBi_GetRankInfo(arg_7_0, arg_7_1, arg_7_2)
	var_0_4:onS2CChibiGetRankInfo(arg_7_2)
	var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_GETRANKINFO, false, arg_7_1, arg_7_2)
end

function var_0_1.on_S2C_ChiBi_Battle(arg_8_0, arg_8_1, arg_8_2)
	if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_BATTLE, false, arg_8_1, arg_8_2)
	else
		var_0_2:dispatchEvent(var_0_3.RED_CLIFF_S2C_CHI_BI_BATTLE_RET, false, arg_8_1, arg_8_2)
	end
end

function var_0_1.on_S2C_ChiBi_CheckBattle(arg_9_0, arg_9_1, arg_9_2)
	if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
		var_0_4:onS2CCheckBattle(arg_9_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_CHECKBATTLE, false, arg_9_1, arg_9_2)
	else
		var_0_2:dispatchEvent(var_0_3.RED_CLIFF_S2C_CHI_BI_BATTLE_RET, false, arg_9_1, arg_9_2)
	end
end

function var_0_1.on_S2C_ChiBi_CheckBattleFinish(arg_10_0, arg_10_1, arg_10_2)
	var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_CHECKBATTLEFINISH, false, arg_10_1, arg_10_2)

	if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
		-- block empty
	end
end

function var_0_1.on_S2C_ChiBi_NotifyUserRevive(arg_11_0, arg_11_1, arg_11_2)
	if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
		var_0_4:onS2CNotifyUserRevive(arg_11_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_NOTIFYUSERREVIVE, false, arg_11_1, arg_11_2)
	end
end

function var_0_1.on_S2C_ChiBi_NotifyOccupyChange(arg_12_0, arg_12_1, arg_12_2)
	if ProtoHandler:onMsgProcess(arg_12_1, arg_12_2) then
		var_0_4:onS2COccupyChange(arg_12_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_NOTIFYOCCUPYCHANGE, false, arg_12_1, arg_12_2)
	end
end

function var_0_1.on_S2C_ChiBi_NotifyFertility(arg_13_0, arg_13_1, arg_13_2)
	if ProtoHandler:onMsgProcess(arg_13_1, arg_13_2) then
		var_0_4:onS2CNotifyFertility(arg_13_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_NOTIFYFERTILITY, false, arg_13_1, arg_13_2)
	end
end

function var_0_1.on_S2C_ChiBi_NotifyMatchEnd(arg_14_0, arg_14_1, arg_14_2)
	if ProtoHandler:onMsgProcess(arg_14_1, arg_14_2) then
		var_0_4:onS2CMatchEnd(arg_14_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_NOTIFYMATCHEND, false, arg_14_1, arg_14_2)
	end
end

function var_0_1.on_S2C_ChiBi_AchievementAward(arg_15_0, arg_15_1, arg_15_2)
	if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
		var_0_4:recvAchievementData(arg_15_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_ACHIEVEMENTAWARD, false, arg_15_1, arg_15_2)
	end
end

function var_0_1.on_S2C_ChiBi_NotifyUserInfo(arg_16_0, arg_16_1, arg_16_2)
	if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
		var_0_4:onS2cNotifyUserInfo(arg_16_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_NOTIFYUSERINFO, false, arg_16_1, arg_16_2)
	end
end

function var_0_1.on_S2C_ChiBi_NotifyPromotionList(arg_17_0, arg_17_1, arg_17_2)
	if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
		var_0_4:onS2CNotifyPromotionList(arg_17_2, true)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_NOTIFYPROMOTIONLIST, false, arg_17_1, arg_17_2)
	end
end

function var_0_1.on_S2C_ChiBi_GetPromotionList(arg_18_0, arg_18_1, arg_18_2)
	var_0_4:onS2CNotifyPromotionList(arg_18_2)
	var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_GETPROMOTIONLIST, false, arg_18_1, arg_18_2)
end

function var_0_1.on_S2C_ChiBi_GetRoomUser(arg_19_0, arg_19_1, arg_19_2)
	if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
		var_0_4:onS2cGetRoomUser(arg_19_2)
		var_0_2:dispatchEvent(var_0_3.EVENT_NET_S2C_CHI_BI_GETROOMUSER, false, arg_19_1, arg_19_2)
	end
end

return var_0_1
