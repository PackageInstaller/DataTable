local var_0_0 = g.core.event.enum
local ProtoHandler = import(".ProtoHandler")
local var_0_2 = g.core.model.User.guildWarData
local var_0_3 = g.core.event.EventManager

return {
	on_S2C_GuildWar_GetInfo = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			var_0_2:onS2CGetInfo(arg_1_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_GETINFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_GuildWar_Practice = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			var_0_2:onS2CPractice(arg_2_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_PRACTICE, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_GuildWar_PracticeNotify = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			var_0_2:onS2CPracticeNotify(arg_3_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_PRACTICENOTIFY, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_GuildWar_Achieve_Notify = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			var_0_2:onS2CAchieveNotify(arg_4_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_ACHIEVE_NOTIFY, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_GuildWar_Format = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			var_0_2:onS2CFormat(arg_5_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_FORMAT, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_GuildWar_AttackDefenderBegin = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			var_0_2:onS2CAttackDefenderBegin()
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_ATTACKDEFENDERBEGIN, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_GuildWar_AttackDefenderFinish = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			var_0_2:onS2CAttackDefenderFinish(arg_7_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_ATTACKDEFENDERFINISH, false, arg_7_1, arg_7_2)
		end
	end,
	on_S2C_GuildWar_GetFormation = function(arg_8_0, arg_8_1, arg_8_2)
		if ProtoHandler:onMsgProcess(arg_8_1, arg_8_2) then
			var_0_2:onS2CGetFormation(arg_8_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_GETFORMATION, false, arg_8_1, arg_8_2)
		end
	end,
	on_S2C_GuildWar_FireOn = function(arg_9_0, arg_9_1, arg_9_2)
		if ProtoHandler:onMsgProcess(arg_9_1, arg_9_2) then
			var_0_2:onS2CFireOn(arg_9_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_FIREON, false, arg_9_1, arg_9_2)
		end
	end,
	on_S2C_GuildWar_AttackBuilding = function(arg_10_0, arg_10_1, arg_10_2)
		if ProtoHandler:onMsgProcess(arg_10_1, arg_10_2) then
			var_0_2:onS2CAttackBuilding(arg_10_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_ATTACKBUILDING, false, arg_10_1, arg_10_2)
		end
	end,
	on_S2C_GuildWar_Notify = function(arg_11_0, arg_11_1, arg_11_2)
		if ProtoHandler:onMsgProcess(arg_11_1, arg_11_2) then
			var_0_2:onS2CNotify(arg_11_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_NOTIFY, false, arg_11_1, arg_11_2)
		end
	end,
	on_S2C_GuildWar_NotifyFormat = function(arg_12_0, arg_12_1, arg_12_2)
		var_0_2:onS2CFormat(arg_12_2)
		var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_NOTIFYFORMAT, false, arg_12_1, arg_12_2)
	end,
	on_S2C_GuildWar_NotifyFastFormat = function(arg_13_0, arg_13_1, arg_13_2)
		var_0_2:onS2CGetFormation(arg_13_2)
		var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_NOTIFYFASTFORMAT, false, arg_13_1, arg_13_2)
	end,
	on_S2C_GuildWar_NotifySwapUserBuild = function(arg_14_0, arg_14_1, arg_14_2)
		var_0_2:onSwapUserBuild(arg_14_2)
		var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_NOTIFYSWAPUSERBUILD, false, arg_14_1, arg_14_2)
	end,
	on_S2C_GuildWar_GetServerInfo = function(arg_15_0, arg_15_1, arg_15_2)
		if ProtoHandler:onMsgProcess(arg_15_1, arg_15_2) then
			var_0_2:onS2CGetServerInfo(arg_15_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_GETSERVERINFO, false, arg_15_1, arg_15_2)
		end
	end,
	on_S2C_GuildWar_OpTab = function(arg_16_0, arg_16_1, arg_16_2)
		if ProtoHandler:onMsgProcess(arg_16_1, arg_16_2) then
			var_0_2:onS2COpTab(arg_16_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_OPTAB, false, arg_16_1, arg_16_2)
		end
	end,
	on_S2C_GuildWar_Achieves_GetInfo = function(arg_17_0, arg_17_1, arg_17_2)
		if ProtoHandler:onMsgProcess(arg_17_1, arg_17_2) then
			var_0_2:onS2CAchievesGetInfo(arg_17_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_ACHIEVES_GETINFO, false, arg_17_1, arg_17_2)
		end
	end,
	on_S2C_GuildWar_Achieves_Award = function(arg_18_0, arg_18_1, arg_18_2)
		if ProtoHandler:onMsgProcess(arg_18_1, arg_18_2) then
			var_0_2:onS2CAchievesAward(arg_18_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_ACHIEVES_AWARD, false, arg_18_1, arg_18_2)
		end
	end,
	on_S2C_GuildWar_Report_GetInfo = function(arg_19_0, arg_19_1, arg_19_2)
		if ProtoHandler:onMsgProcess(arg_19_1, arg_19_2) then
			var_0_2:onS2CReportGetInfo(arg_19_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_REPORT_GETINFO, false, arg_19_1, arg_19_2)
		end
	end,
	on_S2C_GuildWar_FastFormat = function(arg_20_0, arg_20_1, arg_20_2)
		if ProtoHandler:onMsgProcess(arg_20_1, arg_20_2) then
			var_0_2:onS2CGetFormation(arg_20_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_FASTFORMAT, false, arg_20_1, arg_20_2)
		end
	end,
	on_S2C_GuildWar_SwapUserBuild = function(arg_21_0, arg_21_1, arg_21_2)
		if ProtoHandler:onMsgProcess(arg_21_1, arg_21_2) then
			var_0_2:onSwapUserBuild(arg_21_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_SWAPUSERBUILD, false, arg_21_1, arg_21_2)
		end
	end,
	on_S2C_GuildWar_SetStrategy = function(arg_22_0, arg_22_1, arg_22_2)
		if ProtoHandler:onMsgProcess(arg_22_1, arg_22_2) then
			var_0_2:onS2CSetStrategy(arg_22_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_SETSTRATEGY, false, arg_22_1, arg_22_2)
		end
	end,
	on_S2C_GuildWar_NotifyStrategy = function(arg_23_0, arg_23_1, arg_23_2)
		if ProtoHandler:onMsgProcess(arg_23_1, arg_23_2) then
			var_0_2:onS2CSetStrategy(arg_23_2)
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_NOTIFYSTRATEGY, false, arg_23_1, arg_23_2)
		end
	end,
	on_S2C_GuildWar_NotifyPullData = function(arg_24_0, arg_24_1, arg_24_2)
		if ProtoHandler:onMsgProcess(arg_24_1, arg_24_2) then
			var_0_3:dispatchEvent(var_0_0.EVENT_NET_S2C_GUILD_WAR_NOTIFYPULLDATA, false, arg_24_1, arg_24_2)
		end
	end
}
