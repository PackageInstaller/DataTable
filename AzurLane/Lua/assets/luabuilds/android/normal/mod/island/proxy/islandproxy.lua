class = var_0_10000

local var_0_0 = "IslandProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.proxy.NetProxy"))

var_0_1.STORY_START = "IslandProxy:STORY_START"
var_0_1.STORY_END = "IslandProxy:STORY_END"
var_0_1.PERFORMANCE_START = "IslandProxy:PERFORMANCE_START"
var_0_1.PERFORMANCE_END = "IslandProxy:PERFORMANCE_END"
var_0_1.START_PATHFINDER = "IslandProxy:START_PATHFINDER"
var_0_1.END_PATHFINDER = "IslandProxy:END_PATHFINDER"
var_0_1.ACTIVE_OR_DISABLE_UNIT = "IslandProxy:ACTIVE_OR_DISABLE_UNIT"
var_0_1.LINK_CORE = "IslandProxy:LINK_CORE"
var_0_1.GEN_RECYCLEITEM = "IslandProxy:GEN_RECYCLEITEM"
var_0_1.LOCK_NPC_REFRESH = "IslandProxy:LOCK_NPC_REFRESH"
var_0_1.RELEASE_NPC_REFRESH = "IslandProxy:RELEASE_NPC_REFRESH"
var_0_1.RESET_SP = "IslandProxy:RESET_SP"
var_0_1.PRESS_BACK = "IslandProxy:PRESS_BACK"
var_0_1.CHAT_MSG_UPDATE = "IslandProxy:CHAT_MSG_UPDATE"

function var_0_1.register(arg_1_0)
	arg_1_0.cahce = {}
	arg_1_0.giftCache = {}
	arg_1_0.chatMsgs = {}
	IslandHearBeatMgr = var_1
	arg_1_0.islandHeartBeatMgr = var_1.New()

	arg_1_0:on(21216, function(arg_2_0)
		local var_2_0 = arg_1_0

		if not var_1.GetIsland(var_2_0) then
			return
		end

		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.visitor_list) do
			IslandVisitorLog = var_2_10007

			local var_2_1 = var_2_10007.New(iter_2_1)

			if not var_2_10007.IsSelf(var_2_1) then
				local var_2_2 = var_1:GetAccessAgency()

				var_8.AddVisitorLog(var_2_2, var_2_10007)

				pg = var_8

				local var_2_3 = var_8.IslandVisitorNotificationMgr.GetInstance()

				var_8.Enqueue(var_2_3, var_2_10007)
			end
		end

		return
	end)

	return
end

function var_0_1.AddChatMsg(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if not arg_3_0.chatMsgs[arg_3_1] then
		var_3_0 = arg_3_0.chatMsgs
		var_3_0[arg_3_1] = {}
	end

	table = var_3_0

	var_3_0.insert(arg_3_0.chatMsgs[arg_3_1], arg_3_2)

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.sendNotification

	IslandProxy = var_5

	var_3_2(var_3_1, var_5.CHAT_MSG_UPDATE, {
		islandId = arg_3_1,
		msg = arg_3_2
	})

	return
end

function var_0_1.GetChatMsgList(arg_4_0, arg_4_1)
	local var_4_0

	if not arg_4_0.chatMsgs[arg_4_1] then
		var_4_0 = {}
	end

	return var_4_0
end

function var_0_1.SetIsland(arg_5_0, arg_5_1)
	arg_5_0.island = arg_5_1

	return
end

function var_0_1.GetIsland(arg_6_0)
	return arg_6_0.island
end

function var_0_1.remove(arg_7_0)
	arg_7_0.island = nil

	return
end

function var_0_1.ShouldTip(arg_8_0)
	local function var_8_0()
		local var_9_0 = arg_8_0
		local var_9_1

		var_9_1 = var_0.GetIsland(var_9_0) and var_0:CanLevelUp()

		return var_9_1
	end

	local function var_8_1()
		local var_10_0 = arg_8_0
		local var_10_1

		var_10_1 = var_0.GetIsland(var_10_0) and var_0:AnyProsperityAwardCanGet()

		return var_10_1
	end

	local var_8_2

	if not var_8_0() then
		var_8_2 = var_8_1()
	end

	return var_8_2
end

function var_0_1.AddPlayerDataCache(arg_11_0, arg_11_1)
	arg_11_0.cahce[arg_11_1.id] = arg_11_1

	return
end

function var_0_1.GetPlayerDataCache(arg_12_0, arg_12_1)
	return arg_12_0.cahce[arg_12_1]
end

function var_0_1.ClearAllPlayerDataCache(arg_13_0)
	arg_13_0.cahce = {}

	return
end

function var_0_1.AddGiftTagInfoCache(arg_14_0, arg_14_1)
	arg_14_0.giftCache[arg_14_1.playerId] = arg_14_1

	return
end

function var_0_1.GetGiftTagInfoCache(arg_15_0, arg_15_1)
	return arg_15_0.giftCache[arg_15_1]
end

function var_0_1.UpdateGiftTagCache(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0

	if arg_16_0.GetGiftTagInfoCache(var_16_0, arg_16_1) then
		var_4:Flush(arg_16_2, arg_16_3)
	else
		IslandGiftTagInfo = var_16_0

		local var_16_1 = var_16_0.New({
			key = arg_16_1,
			value1 = arg_16_3,
			value2 = arg_16_2
		})

		arg_16_0:AddGiftTagInfoCache(var_16_1)
	end

	return
end

function var_0_1.ClearAllGiftTagInfo(arg_17_0)
	arg_17_0.giftCache = {}

	return
end

function var_0_1.SetSharedIsland(arg_18_0, arg_18_1)
	arg_18_0.sharedIsland = arg_18_1

	return
end

function var_0_1.GetSharedIsland(arg_19_0)
	return arg_19_0.sharedIsland
end

function var_0_1.SetSyncObjInitData(arg_20_0, arg_20_1)
	arg_20_0.syncObjInitData = arg_20_1

	return
end

function var_0_1.GetSyncObjInitData(arg_21_0)
	local var_21_0

	if not arg_21_0.syncObjInitData or not arg_21_0.syncObjInitData then
		var_21_0 = {}
	end

	return var_21_0
end

function var_0_1.timeCall(arg_22_0)
	local var_22_0 = {}

	ProxyRegister = var_1_10002
	var_22_0[var_1_10002.SecondCall] = function(arg_23_0)
		if not arg_22_0.island then
			return
		end

		local var_23_0 = arg_22_0.island

		var_1.UpdatePerSecond(var_23_0)

		if not arg_22_0.sharedIsland then
			return
		end

		local var_23_1 = arg_22_0.sharedIsland

		var_1.UpdatePerSecond(var_23_1)

		return
	end
	ProxyRegister = var_2
	var_22_0[var_2.HourCall] = function(arg_24_0)
		if not arg_22_0.island then
			return
		end

		local var_24_0 = arg_22_0.island

		var_1.UpdatePerHour(var_24_0, arg_24_0)

		if not arg_22_0.sharedIsland then
			return
		end

		local var_24_1 = arg_22_0.sharedIsland

		var_1.UpdatePerHour(var_24_1, arg_24_0)

		return
	end
	ProxyRegister = var_2
	var_22_0[var_2.DayCall] = function(arg_25_0)
		if not arg_22_0.island then
			return
		end

		local var_25_0 = arg_22_0.island

		var_1.UpdatePerDay(var_25_0)

		return
	end

	return var_22_0
end

function var_0_1.RecordEnterTime(arg_26_0)
	pg = var_1_10001

	local var_26_0 = var_1_10001.TimeMgr.GetInstance()

	arg_26_0.enterTimeStamp = var_1.GetServerTime(var_26_0)

	return
end

function var_0_1.GetEnterTime(arg_27_0)
	return arg_27_0.enterTimeStamp
end

function var_0_1.RecordTempPlayerPosition(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0.tempPlayerPosition = {
		arg_28_1,
		arg_28_2,
		arg_28_3
	}

	return
end

function var_0_1.GetTempPlayerPosition(arg_29_0)
	return arg_29_0.tempPlayerPosition
end

function var_0_1.EnterIsland(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.islandHeartBeatMgr

	var_2.EnterIsland(var_30_0, arg_30_1)

	return
end

function var_0_1.ExitIsland(arg_31_0)
	local var_31_0 = arg_31_0.islandHeartBeatMgr

	var_1.ExitIsland(var_31_0)

	return
end

function var_0_1.remove(arg_32_0)
	local var_32_0 = arg_32_0.islandHeartBeatMgr

	var_1.Dispose(var_32_0)

	arg_32_0.islandHeartBeatMgr = nil

	return
end

return var_0_1
