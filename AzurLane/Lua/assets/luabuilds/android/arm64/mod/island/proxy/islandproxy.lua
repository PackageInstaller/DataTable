local var_0_0 = class("IslandProxy", import("model.proxy.NetProxy"))

var_0_0.STORY_START = "IslandProxy:STORY_START"
var_0_0.STORY_END = "IslandProxy:STORY_END"
var_0_0.PERFORMANCE_START = "IslandProxy:PERFORMANCE_START"
var_0_0.PERFORMANCE_END = "IslandProxy:PERFORMANCE_END"
var_0_0.START_PATHFINDER = "IslandProxy:START_PATHFINDER"
var_0_0.END_PATHFINDER = "IslandProxy:END_PATHFINDER"
var_0_0.ACTIVE_OR_DISABLE_UNIT = "IslandProxy:ACTIVE_OR_DISABLE_UNIT"
var_0_0.LINK_CORE = "IslandProxy:LINK_CORE"
var_0_0.GEN_RECYCLEITEM = "IslandProxy:GEN_RECYCLEITEM"
var_0_0.LOCK_NPC_REFRESH = "IslandProxy:LOCK_NPC_REFRESH"
var_0_0.RELEASE_NPC_REFRESH = "IslandProxy:RELEASE_NPC_REFRESH"
var_0_0.RESET_SP = "IslandProxy:RESET_SP"
var_0_0.PRESS_BACK = "IslandProxy:PRESS_BACK"
var_0_0.CHAT_MSG_UPDATE = "IslandProxy:CHAT_MSG_UPDATE"

function var_0_0.register(arg_1_0)
	arg_1_0.cahce = {}
	arg_1_0.giftCache = {}
	arg_1_0.chatMsgs = {}
	arg_1_0.islandHeartBeatMgr = IslandHearBeatMgr.New()

	arg_1_0:on(21216, function(arg_2_0)
		local var_2_0 = arg_1_0:GetIsland()

		if not var_2_0 then
			return
		end

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.visitor_list) do
			local var_2_1 = IslandVisitorLog.New(iter_2_1)

			if not var_2_1:IsSelf() then
				var_2_0:GetAccessAgency():AddVisitorLog(var_2_1)
				pg.IslandVisitorNotificationMgr.GetInstance():Enqueue(var_2_1)
			end
		end

		return
	end)

	return
end

function var_0_0.AddChatMsg(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.chatMsgs[arg_3_1] = arg_3_0.chatMsgs[arg_3_1] or {}

	table.insert(arg_3_0.chatMsgs[arg_3_1], arg_3_2)
	arg_3_0:sendNotification(IslandProxy.CHAT_MSG_UPDATE, {
		islandId = arg_3_1,
		msg = arg_3_2
	})

	return
end

function var_0_0.GetChatMsgList(arg_4_0, arg_4_1)
	return arg_4_0.chatMsgs[arg_4_1] or {}
end

function var_0_0.SetIsland(arg_5_0, arg_5_1)
	arg_5_0.island = arg_5_1

	return
end

function var_0_0.GetIsland(arg_6_0)
	return arg_6_0.island
end

function var_0_0.remove(arg_7_0)
	arg_7_0.island = nil

	return
end

function var_0_0.ShouldTip(arg_8_0)
	return (function()
		local var_9_0 = arg_8_0:GetIsland()

		return var_9_0 and var_9_0:CanLevelUp()
	end)() or (function()
		local var_10_0 = arg_8_0:GetIsland()

		return var_10_0 and var_10_0:AnyProsperityAwardCanGet()
	end)()
end

function var_0_0.AddPlayerDataCache(arg_11_0, arg_11_1)
	arg_11_0.cahce[arg_11_1.id] = arg_11_1

	return
end

function var_0_0.GetPlayerDataCache(arg_12_0, arg_12_1)
	return arg_12_0.cahce[arg_12_1]
end

function var_0_0.ClearAllPlayerDataCache(arg_13_0)
	arg_13_0.cahce = {}

	return
end

function var_0_0.AddGiftTagInfoCache(arg_14_0, arg_14_1)
	arg_14_0.giftCache[arg_14_1.playerId] = arg_14_1

	return
end

function var_0_0.GetGiftTagInfoCache(arg_15_0, arg_15_1)
	return arg_15_0.giftCache[arg_15_1]
end

function var_0_0.UpdateGiftTagCache(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0:GetGiftTagInfoCache(arg_16_1)

	if var_16_0 then
		var_16_0:Flush(arg_16_2, arg_16_3)
	else
		arg_16_0:AddGiftTagInfoCache((IslandGiftTagInfo.New({
			key = arg_16_1,
			value1 = arg_16_3,
			value2 = arg_16_2
		})))
	end

	return
end

function var_0_0.ClearAllGiftTagInfo(arg_17_0)
	arg_17_0.giftCache = {}

	return
end

function var_0_0.SetSharedIsland(arg_18_0, arg_18_1)
	arg_18_0.sharedIsland = arg_18_1

	return
end

function var_0_0.GetSharedIsland(arg_19_0)
	return arg_19_0.sharedIsland
end

function var_0_0.SetSyncObjInitData(arg_20_0, arg_20_1)
	arg_20_0.syncObjInitData = arg_20_1

	return
end

function var_0_0.GetSyncObjInitData(arg_21_0)
	if arg_21_0.syncObjInitData then
		return arg_21_0.syncObjInitData or {}
	end
end

function var_0_0.timeCall(arg_22_0)
	return {
		[ProxyRegister.SecondCall] = function(arg_23_0)
			if not arg_22_0.island then
				return
			end

			arg_22_0.island:UpdatePerSecond()

			if not arg_22_0.sharedIsland then
				return
			end

			arg_22_0.sharedIsland:UpdatePerSecond()

			return
		end,
		[ProxyRegister.HourCall] = function(arg_24_0)
			if not arg_22_0.island then
				return
			end

			arg_22_0.island:UpdatePerHour(arg_24_0)

			if not arg_22_0.sharedIsland then
				return
			end

			arg_22_0.sharedIsland:UpdatePerHour(arg_24_0)

			return
		end,
		[ProxyRegister.DayCall] = function(arg_25_0)
			if not arg_22_0.island then
				return
			end

			arg_22_0.island:UpdatePerDay()

			return
		end
	}
end

function var_0_0.RecordEnterTime(arg_26_0)
	arg_26_0.enterTimeStamp = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.GetEnterTime(arg_27_0)
	return arg_27_0.enterTimeStamp
end

function var_0_0.RecordTempPlayerPosition(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0.tempPlayerPosition = {
		arg_28_1,
		arg_28_2,
		arg_28_3
	}

	return
end

function var_0_0.GetTempPlayerPosition(arg_29_0)
	return arg_29_0.tempPlayerPosition
end

function var_0_0.EnterIsland(arg_30_0, arg_30_1)
	arg_30_0.islandHeartBeatMgr:EnterIsland(arg_30_1)

	return
end

function var_0_0.ExitIsland(arg_31_0)
	arg_31_0.islandHeartBeatMgr:ExitIsland()

	return
end

function var_0_0.remove(arg_32_0)
	arg_32_0.islandHeartBeatMgr:Dispose()

	arg_32_0.islandHeartBeatMgr = nil

	return
end

return var_0_0
