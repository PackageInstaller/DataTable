class = var_0_10000

local var_0_0 = "GuildProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.NEW_GUILD_ADDED = "GuildProxy:NEW_GUILD_ADDED"
var_0_1.GUILD_UPDATED = "GuildProxy:GUILD_UPDATED"
var_0_1.EXIT_GUILD = "GuildProxy:EXIT_GUILD"
var_0_1.REQUEST_ADDED = "GuildProxy:REQUEST_ADDED"
var_0_1.REQUEST_DELETED = "GuildProxy:REQUEST_DELETED"
var_0_1.NEW_MSG_ADDED = "GuildProxy:NEW_MSG_ADDED"
var_0_1.REQUEST_COUNT_UPDATED = "GuildProxy:REQUEST_COUNT_UPDATED"
var_0_1.LOG_ADDED = "GuildProxy:LOG_ADDED"
var_0_1.WEEKLYTASK_UPDATED = "GuildProxy:WEEKLYTASK_UPDATED"
var_0_1.SUPPLY_STARTED = "GuildProxy:SUPPLY_STARTED"
var_0_1.WEEKLYTASK_ADDED = "GuildProxy:WEEKLYTASK_ADDED"
var_0_1.DONATE_UPDTAE = "GuildProxy:DONATE_UPDTAE"
var_0_1.TECHNOLOGY_START = "GuildProxy:TECHNOLOGY_START"
var_0_1.TECHNOLOGY_STOP = "GuildProxy:TECHNOLOGY_STOP"
var_0_1.CAPITAL_UPDATED = "GuildProxy:CAPITAL_UPDATED"
var_0_1.GUILD_BATTLE_STARTED = "GuildProxy:GUILD_BATTLE_STARTED"
var_0_1.GUILD_BATTLE_CLOSED = "GuildProxy:GUILD_BATTLE_CLOSED"
var_0_1.ON_DELETED_MEMBER = "GuildProxy:ON_DELETED_MEMBER"
var_0_1.ON_ADDED_MEMBER = "GuildProxy:ON_ADDED_MEMBER"
var_0_1.BATTLE_BTN_FLAG_CHANGE = "GuildProxy:BATTLE_BTN_FLAG_CHANGE"
var_0_1.ON_EXIST_DELETED_MEMBER = "GuildProxy:ON_EXIST_DELETED_MEMBER"
var_0_1.ON_DONATE_LIST_UPDATED = "GuildProxy:ON_DONATE_LIST_UPDATED"

function var_0_1.register(arg_1_0)
	arg_1_0:Init()
	arg_1_0:on(60000, function(arg_2_0)
		Guild = var_2_10001

		if var_2_10001.New(arg_2_0.guild).id == 0 then
			local var_2_0 = arg_1_0

			var_2.exitGuild(var_2_0)
		elseif arg_1_0.data == nil then
			local var_2_1 = arg_1_0

			var_2.addGuild(var_2_1, var_1)

			getProxy = var_2
			GuildProxy = var_2_1

			if not var_2(var_2_1).isGetChatMsg then
				local var_2_2 = arg_1_0
				local var_2_3 = var_2.sendNotification

				GAME = var_4

				var_2_3(var_2_2, var_4.GET_GUILD_CHAT_LIST)
			end

			local var_2_4 = arg_1_0
			local var_2_5 = var_2.sendNotification

			GAME = var_4

			var_2_5(var_2_4, var_4.GUILD_GET_USER_INFO)

			local var_2_6 = arg_1_0
			local var_2_7 = var_2.sendNotification

			GAME = var_4

			var_2_7(var_2_6, var_4.GUILD_GET_MY_ASSAULT_FLEET, {})

			local var_2_8 = arg_1_0
			local var_2_9 = var_2.sendNotification

			GAME = var_4

			var_2_9(var_2_8, var_4.GUILD_GET_ASSAULT_FLEET, {})

			local var_2_10 = arg_1_0
			local var_2_11 = var_2.sendNotification

			GAME = var_4

			var_2_11(var_2_10, var_4.GUILD_GET_ACTIVATION_EVENT, {
				force = true
			})

			local var_2_12 = arg_1_0
			local var_2_13 = var_2.sendNotification

			GAME = var_4

			var_2_13(var_2_12, var_4.GUILD_GET_REQUEST_LIST, var_1.id)
		else
			local var_2_14 = arg_1_0

			var_2.updateGuild(var_2_14, var_1)
		end

		return
	end)
	arg_1_0:on(60009, function(arg_3_0)
		arg_1_0.requestCount = arg_3_0.count

		local var_3_0 = arg_1_0

		var_1.sendNotification(var_3_0, var_0_1.REQUEST_COUNT_UPDATED, arg_3_0.count)

		return
	end)
	arg_1_0:on(60030, function(arg_4_0)
		local var_4_0 = arg_1_0

		if not var_1.getData(var_4_0) then
			return
		end

		var_1:updateBaseInfo({
			base = arg_4_0.guild
		})

		local var_4_1 = arg_1_0

		var_2.updateGuild(var_4_1, var_1)

		return
	end)
	arg_1_0:on(60031, function(arg_5_0)
		local var_5_0 = arg_1_0

		if not var_1.getData(var_5_0) then
			return
		end

		local var_5_1 = false

		ipairs = var_2_10003

		for iter_5_0, iter_5_1 in var_2_10003(arg_5_0.member_list) do
			GuildMember = var_2_10008

			if var_2_10008.New(iter_5_1).duty == 0 then
				local var_5_2 = var_1:getMemberById(var_2_10008.id)
				local var_5_3 = var_9.clone(var_5_2)

				var_1:deleteMember(var_2_10008.id)

				local var_5_4 = arg_1_0
				local var_5_5 = var_10.sendNotification

				GuildProxy = var_2_10012

				var_5_5(var_5_4, var_2_10012.ON_DELETED_MEMBER, {
					member = var_5_3
				})

				var_5_1 = true
			elseif var_1.member[var_2_10008.id] then
				var_1:updateMember(var_2_10008)
			else
				var_1:addMember(var_2_10008)

				local var_5_6 = arg_1_0
				local var_5_7 = var_9.sendNotification

				GuildProxy = var_11

				var_5_7(var_5_6, var_11.ON_ADDED_MEMBER, {
					member = var_2_10008
				})
			end
		end

		ipairs = var_3

		for iter_5_2, iter_5_3 in var_3(arg_5_0.log_list) do
			GuildLogInfo = var_2_10008
			var_2_10008 = var_2_10008.New(iter_5_3)

			var_1:addLog(var_2_10008)

			local var_5_8 = arg_1_0
			local var_5_9 = var_9.sendNotification
			local var_5_10 = var_0_1.LOG_ADDED

			Clone = var_2_10012

			var_5_9(var_5_8, var_5_10, var_2_10012(var_2_10008))
		end

		local var_5_11 = var_1
		local var_5_12 = var_1.setMemberCount

		table = var_5

		local var_5_13 = var_5.getCount
		local var_5_14

		if not var_1.member then
			var_5_14 = {}
		end

		var_5_12(var_5_11, var_5_13(var_5_14))

		local var_5_15 = arg_1_0

		var_3.updateGuild(var_5_15, var_1)

		if var_5_1 then
			local var_5_16 = arg_1_0
			local var_5_17 = var_3.sendNotification

			GuildProxy = var_5

			var_5_17(var_5_16, var_5.ON_EXIST_DELETED_MEMBER)
		end

		return
	end)
	arg_1_0:on(0, function(arg_6_0)
		local var_6_0 = arg_1_0

		if not var_1.getData(var_6_0) then
			return
		end

		var_1:updateExp(arg_6_0.exp)
		var_1:updateLevel(arg_6_0.lv)

		local var_6_1 = arg_1_0

		var_2.updateGuild(var_6_1, var_1)

		return
	end)
	arg_1_0:on(60008, function(arg_7_0)
		local var_7_0 = arg_7_0.chat
		local var_7_1 = arg_1_0.data

		if var_2.warpChatInfo(var_7_1, var_7_0) then
			local var_7_2 = arg_1_0

			var_3.AddNewMsg(var_7_2, var_2)
		end

		return
	end)
	arg_1_0:on(62004, function(arg_8_0)
		local var_8_0 = arg_1_0

		if not var_1.getData(var_8_0) or not var_1:IsCompletion() then
			return
		end

		GuildTask = var_8_0

		local var_8_1 = var_8_0.New(arg_8_0.this_weekly_tasks)

		var_1:updateWeeklyTask(var_8_1)
		var_1:setWeeklyTaskFlag(0)

		local var_8_2 = arg_1_0

		var_3.updateGuild(var_8_2, var_1)

		local var_8_3 = arg_1_0

		var_3.sendNotification(var_8_3, var_0_1.WEEKLYTASK_ADDED)

		return
	end)
	arg_1_0:on(62005, function(arg_9_0)
		local var_9_0 = arg_1_0

		if not var_1.getData(var_9_0) or not var_1:IsCompletion() then
			return
		end

		var_1:startSupply(arg_9_0.benefit_finish_time)

		local var_9_1 = var_1:getSupplyConsume()

		var_1:consumeCapital(var_9_1)

		local var_9_2 = arg_1_0

		var_3.updateGuild(var_9_2, var_1)

		local var_9_3 = arg_1_0

		var_3.sendNotification(var_9_3, var_0_1.CAPITAL_UPDATED)

		local var_9_4 = arg_1_0

		var_3.sendNotification(var_9_4, var_0_1.SUPPLY_STARTED)

		return
	end)
	arg_1_0:on(62018, function(arg_10_0)
		local var_10_0 = arg_1_0

		if not var_1.getData(var_10_0) or not var_1:IsCompletion() then
			return
		end

		pg = var_10_0

		local var_10_1 = var_10_0.guild_technology_template[arg_10_0.id].group

		if var_1:getActiveTechnologyGroup() then
			var_3:Stop()
		end

		local var_10_2 = var_1:getTechnologyGroupById(var_10_1)

		var_4.Start(var_10_2)
		var_1:UpdateTechCancelCnt()

		local var_10_3 = arg_1_0

		var_5.updateGuild(var_10_3, var_1)

		local var_10_4 = arg_1_0

		var_5.sendNotification(var_10_4, var_0_1.TECHNOLOGY_START)

		return
	end)
	arg_1_0:on(62019, function(arg_11_0)
		local var_11_0 = arg_1_0

		if not var_1.getData(var_11_0) or not var_1:IsCompletion() then
			return
		end

		GuildDonateTask = var_11_0

		local var_11_1 = var_11_0.New({
			id = arg_11_0.id
		})
		local var_11_2 = arg_11_0.has_capital == 1
		local var_11_3 = arg_11_0.has_tech_point == 1
		local var_11_4 = arg_11_0.user_id

		getProxy = var_2_10006
		PlayerProxy = var_2_10007

		local var_11_5 = var_2_10006(var_2_10007)
		local var_11_6 = var_6.getRawData(var_11_5).id

		if var_11_2 then
			var_11_5 = var_11_1:getCapital()
			var_2_10009 = var_1

			local var_11_7 = var_1.getCapital(var_2_10009)

			var_1:updateCapital(var_11_7 + var_11_5)

			if var_11_6 == var_11_4 then
				pg = var_2_10009

				local var_11_8 = var_2_10009.TipsMgr.GetInstance()

				var_2_10009 = var_2_10009.ShowTips
				i18n = var_11

				var_2_10009(var_11_8, var_11("guild_donate_addition_capital_tip", var_11_5))
			end
		end

		if var_11_3 and var_1:getActiveTechnologyGroup() then
			local var_11_9 = var_11_5.pid

			var_2_10009 = var_11_1:getConfig("award_tech_exp")

			local var_11_10 = var_11_5

			var_11_5.AddProgress(var_11_10, var_2_10009)

			if var_11_9 ~= var_11_5.pid and var_11_5:GuildMemberCntType() then
				local var_11_11 = var_1

				var_11_10 = var_1.getTechnologyById(var_11_11, var_11_5.id)
				assert = var_11_11

				var_11_11(var_11_10)

				var_2_10013 = var_11_10

				var_11_10.Update(var_2_10013, var_10, var_11_5)
			end

			if var_11_6 == var_11_4 then
				pg = var_11_10

				local var_11_12 = var_11_10.TipsMgr.GetInstance()
				local var_11_13 = var_11.ShowTips

				i18n = var_2_10013

				var_11_13(var_11_12, var_2_10013("guild_donate_addition_techpoint_tip", var_2_10009))
			end
		end

		if var_11_2 or var_11_3 then
			local var_11_14 = arg_1_0

			var_11_5.updateGuild(var_11_14, var_1)

			local var_11_15 = arg_1_0

			var_11_5.sendNotification(var_11_15, var_0_1.DONATE_UPDTAE)
		end

		if var_11_2 then
			local var_11_16 = arg_1_0

			var_11_5.sendNotification(var_11_16, var_0_1.CAPITAL_UPDATED)
		end

		if not var_11_2 and var_11_4 == var_11_6 then
			pg = var_11_5

			local var_11_17 = var_11_5.TipsMgr.GetInstance()

			var_11_5 = var_11_5.ShowTips
			i18n = var_2_10009

			var_11_5(var_11_17, var_2_10009("guild_donate_capital_toplimit"))
		end

		if not var_11_3 and var_11_4 == var_11_6 then
			pg = var_11_5

			local var_11_18 = var_11_5.TipsMgr.GetInstance()
			local var_11_19 = var_7.ShowTips

			i18n = var_2_10009

			var_11_19(var_11_18, var_2_10009("guild_donate_techpoint_toplimit"))
		end

		return
	end)
	arg_1_0:on(62031, function(arg_12_0)
		local var_12_0 = arg_1_0

		if var_1.getData(var_12_0) then
			var_2_10003 = var_1

			if not var_1.IsCompletion(var_2_10003) then
				return
			end

			local var_12_1 = {}

			ipairs = var_2_10003

			for iter_12_0, iter_12_1 in var_2_10003(arg_12_0.donate_tasks) do
				GuildDonateTask = var_2_10008
				var_2_10008 = var_2_10008.New({
					id = iter_12_1
				})
				table = var_9

				var_9.insert(var_12_1, var_2_10008)
			end

			if var_1 then
				var_1.donateCount = 0

				var_1:updateDonateTasks(var_12_1)

				local var_12_2 = arg_1_0

				var_3.updateGuild(var_12_2, var_1)

				local var_12_3 = arg_1_0

				var_3.sendNotification(var_12_3, var_0_1.ON_DONATE_LIST_UPDATED)
			else
				local var_12_4 = arg_1_0

				if var_3.GetPublicGuild(var_12_4) then
					var_3:ResetDonateCnt()
					var_3:UpdateDonateTasks(var_12_1)

					local var_12_5 = arg_1_0
					local var_12_6 = var_4.sendNotification

					GAME = var_6

					var_12_6(var_12_5, var_6.PUBLIC_GUILD_REFRESH_DONATE_LIST_DONE)
				end
			end

			return
		end
	end)
	arg_1_0:on(61021, function(arg_13_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10002

		local var_13_0 = var_2_10001(var_2_10002)
		local var_13_1 = var_1.getData(var_13_0)

		arg_1_0.refreshActivationEventTime = 0

		if arg_13_0.user_id ~= var_13_1.id then
			local var_13_2 = arg_1_0

			var_2.sendNotification(var_13_2, var_0_1.GUILD_BATTLE_STARTED)
		end

		return
	end)

	return
end

function var_0_1.timeCall(arg_14_0)
	local var_14_0 = {}

	ProxyRegister = var_1_10002
	var_14_0[var_1_10002.DayCall] = function(arg_15_0)
		local var_15_0 = arg_14_0

		if var_1.getRawData(var_15_0) then
			var_1:ResetTechCancelCnt()

			if var_1:getWeeklyTask() and var_2:isExpire() then
				local var_15_1 = var_2
				local var_15_2 = var_2.GetPresonTaskId(var_15_1)

				getProxy = var_15_1
				TaskProxy = var_2_10005
				var_2_10005 = var_15_1(var_2_10005)

				var_4.deleteTaskById(var_2_10005, var_15_2)

				var_1.weeklyTaskFlag = 0
			end

			if var_1:GetActiveEvent() then
				var_2_10005 = var_3

				local var_15_3 = var_3.GetBossMission(var_2_10005)

				var_4.ResetDailyCnt(var_15_3)
			end

			if arg_15_0 == 1 then
				var_2_10005 = var_1

				var_1.ResetActiveEventCnt(var_2_10005)
			end

			var_2_10005 = arg_14_0

			var_4.updateGuild(var_2_10005, var_1)
		end

		local var_15_4 = arg_14_0

		if var_2.GetPublicGuild(var_15_4) then
			onDelayTick = var_15_4

			local function var_15_5()
				local var_16_0 = arg_14_0
				local var_16_1 = var_0.sendNotification

				GAME = var_3_10002

				var_16_1(var_16_0, var_3_10002.GET_PUBLIC_GUILD_USER_DATA, {
					flag = true
				})

				return
			end

			math = var_2_10005

			var_15_4(var_15_5, var_2_10005.random(2, 5))
		end

		return
	end

	return var_14_0
end

function var_0_1.AddPublicGuild(arg_17_0, arg_17_1)
	arg_17_0.publicGuild = arg_17_1

	return
end

function var_0_1.GetPublicGuild(arg_18_0)
	return arg_18_0.publicGuild
end

function var_0_1.Init(arg_19_0)
	arg_19_0.data = nil
	arg_19_0.chatMsgs = {}
	arg_19_0.bossRanks = {}
	arg_19_0.isGetChatMsg = false
	arg_19_0.refreshActivationEventTime = 0
	arg_19_0.nextRequestBattleRankTime = 0
	arg_19_0.refreshBossTime = 0
	arg_19_0.bossRankUpdateTime = 0
	arg_19_0.isFetchAssaultFleet = false
	arg_19_0.battleRanks = {}
	arg_19_0.ranks = {}
	arg_19_0.requests = nil
	arg_19_0.rankUpdateTime = 0
	arg_19_0.requestReportTime = 0
	arg_19_0.newChatMsgCnt = 0
	arg_19_0.requestCount = 0
	arg_19_0.cdTime = {
		0,
		0
	}

	return
end

function var_0_1.AddNewMsg(arg_20_0, arg_20_1)
	arg_20_0.newChatMsgCnt = arg_20_0.newChatMsgCnt + 1

	arg_20_0:addMsg(arg_20_1)
	arg_20_0:sendNotification(var_0_1.NEW_MSG_ADDED, arg_20_1)

	return
end

function var_0_1.ResetRequestCount(arg_21_0)
	arg_21_0.requestCount = 0

	return
end

function var_0_1.UpdatePosCdTime(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.cdTime[arg_22_1] = arg_22_2

	return
end

function var_0_1.GetNextCanFormationTime(arg_23_0, arg_23_1)
	pg = var_1_10002

	local var_23_0 = var_1_10002.guildset.operation_assault_team_cd.key_value
	local var_23_1

	if not arg_23_0.cdTime[arg_23_1] then
		var_23_1 = 0
	end

	return var_23_1 + var_23_0
end

function var_0_1.CanFormationPos(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.GetNextCanFormationTime(var_24_0, arg_24_1)

	pg = var_24_0

	local var_24_2 = var_24_0.TimeMgr.GetInstance()

	return var_24_1 <= var_3.GetServerTime(var_24_2)
end

function var_0_1.ClearNewChatMsgCnt(arg_25_0)
	arg_25_0.newChatMsgCnt = 0

	return
end

function var_0_1.GetNewChatMsgCnt(arg_26_0)
	return arg_26_0.newChatMsgCnt
end

function var_0_1.setRequestList(arg_27_0, arg_27_1)
	arg_27_0.requests = arg_27_1

	return
end

function var_0_1.addGuild(arg_28_0, arg_28_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_28_0 = arg_28_1

	Guild = var_1_10005

	var_1_10002(var_1_10003(var_28_0, var_1_10005), "guild should instance of Guild")

	arg_28_0.data = arg_28_1

	local var_28_1 = arg_28_0
	local var_28_2 = arg_28_0.sendNotification
	local var_28_3 = var_0_1.NEW_GUILD_ADDED

	Clone = var_1_10005

	var_28_2(var_28_1, var_28_3, var_1_10005(arg_28_1))

	return
end

function var_0_1.updateGuild(arg_29_0, arg_29_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_29_0 = arg_29_1

	Guild = var_1_10005

	var_1_10002(var_1_10003(var_29_0, var_1_10005), "guild should instance of Guild")

	arg_29_0.data = arg_29_1

	local var_29_1 = arg_29_0
	local var_29_2 = arg_29_0.sendNotification
	local var_29_3 = var_0_1.GUILD_UPDATED

	Clone = var_1_10005

	var_29_2(var_29_1, var_29_3, var_1_10005(arg_29_1))

	return
end

function var_0_1.exitGuild(arg_30_0)
	arg_30_0:Init()
	arg_30_0:sendNotification(var_0_1.EXIT_GUILD)

	pg = var_1

	local var_30_0 = var_1.ShipFlagMgr.GetInstance()

	var_1.ClearShipsFlag(var_30_0, "inGuildEvent")

	pg = var_1

	local var_30_1 = var_1.ShipFlagMgr.GetInstance()

	var_1.ClearShipsFlag(var_30_1, "inGuildBossEvent")

	return
end

function var_0_1.getRequests(arg_31_0)
	return arg_31_0.requests
end

function var_0_1.getSortRequest(arg_32_0)
	if not arg_32_0.requests then
		return nil
	end

	local var_32_0 = {}

	pairs = var_1_10002

	for iter_32_0, iter_32_1 in var_1_10002(arg_32_0.requests) do
		table = var_1_10007

		var_1_10007.insert(var_32_0, iter_32_1)
	end

	return var_32_0
end

function var_0_1.deleteRequest(arg_33_0, arg_33_1)
	if not arg_33_0.requests then
		return
	end

	arg_33_0.requests[arg_33_1] = nil

	arg_33_0:sendNotification(var_0_1.REQUEST_DELETED, arg_33_1)

	return
end

function var_0_1.addMsg(arg_34_0, arg_34_1)
	table = var_1_10002

	var_1_10002.insert(arg_34_0.chatMsgs, arg_34_1)

	local var_34_0 = #arg_34_0.chatMsgs

	GuildConst = var_3

	if var_34_0 > var_3.CHAT_LOG_MAX_COUNT then
		table = var_34_0

		var_34_0.remove(arg_34_0.chatMsgs, 1)
	end

	return
end

function var_0_1.getChatMsgs(arg_35_0)
	return arg_35_0.chatMsgs
end

function var_0_1.GetMessagesByUniqueId(arg_36_0, arg_36_1)
	_ = var_1_10002

	return var_1_10002.select(arg_36_0.chatMsgs, function(arg_37_0)
		return arg_37_0.uniqueId == arg_36_1
	end)
end

function var_0_1.UpdateMsg(arg_38_0, arg_38_1)
	ipairs = var_1_10002

	for iter_38_0, iter_38_1 in var_1_10002(arg_38_0.chatMsgs) do
		if iter_38_1:IsSame(arg_38_1.uniqueId) then
			arg_38_0.data[iter_38_0] = arg_38_1
		end
	end

	return
end

function var_0_1.ShouldFetchActivationEvent(arg_39_0)
	pg = var_1_10001

	local var_39_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_39_0) > arg_39_0.refreshActivationEventTime
end

function var_0_1.AddFetchActivationEventCDTime(arg_40_0)
	GuildConst = var_1_10001

	local var_40_0 = var_1_10001.REFRESH_ACTIVATION_EVENT_TIME

	pg = var_1_10002

	local var_40_1 = var_1_10002.TimeMgr.GetInstance()

	arg_40_0.refreshActivationEventTime = var_40_0 + var_2.GetServerTime(var_40_1)

	return
end

function var_0_1.AddActivationEventTimer(arg_41_0, arg_41_1)
	return
end

function var_0_1.RemoveActivationEventTimer(arg_42_0)
	if arg_42_0.timer then
		local var_42_0 = arg_42_0.timer

		var_1.Stop(var_42_0)

		arg_42_0.timer = nil
	end

	return
end

function var_0_1.remove(arg_43_0)
	arg_43_0:RemoveActivationEventTimer()

	return
end

function var_0_1.SetRank(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0.ranks[arg_44_1] = arg_44_2

	local var_44_0 = "rankTimer" .. arg_44_1

	pg = var_4

	local var_44_1 = var_4.TimeMgr.GetInstance()

	arg_44_0[var_44_0] = var_4.GetServerTime(var_44_1) + 8

	return
end

function var_0_1.GetRanks(arg_45_0)
	return arg_45_0.ranks
end

function var_0_1.ShouldRefreshRank(arg_46_0, arg_46_1)
	if arg_46_0["rankTimer" .. arg_46_1] then
		pg = var_2

		local var_46_0 = var_2.TimeMgr.GetInstance()

		if var_2.GetServerTime(var_46_0) >= arg_46_0["rankTimer" .. arg_46_1] then
			return true
		end

		return false
	end
end

function var_0_1.SetReports(arg_47_0, arg_47_1)
	arg_47_0.reports = arg_47_1

	return
end

function var_0_1.GetReports(arg_48_0)
	local var_48_0

	if not arg_48_0.reports then
		var_48_0 = {}
	end

	return var_48_0
end

function var_0_1.GetReportById(arg_49_0, arg_49_1)
	return arg_49_0.reports[arg_49_1]
end

function var_0_1.AddReport(arg_50_0, arg_50_1)
	if not arg_50_0.reports then
		arg_50_0.reports = {}
	end

	arg_50_0.reports[arg_50_1.id] = arg_50_1

	return
end

function var_0_1.GetMaxReportId(arg_51_0)
	local var_51_0 = arg_51_0:GetReports()
	local var_51_1 = 0

	pairs = var_1_10003

	for iter_51_0, iter_51_1 in var_1_10003(var_51_0) do
		if var_51_1 < iter_51_1.id then
			var_51_1 = iter_51_1.id
		end
	end

	return var_51_1
end

function var_0_1.AnyRepoerCanGet(arg_52_0)
	return #arg_52_0:GetCanGetReports() > 0
end

function var_0_1.GetCanGetReports(arg_53_0)
	local var_53_0 = {}
	local var_53_1 = arg_53_0
	local var_53_2 = arg_53_0.GetReports(var_53_1)

	pairs = var_53_1

	for iter_53_0, iter_53_1 in var_53_1(var_53_2) do
		if iter_53_1:CanSubmit() then
			table = var_8

			var_8.insert(var_53_0, iter_53_1.id)
		end
	end

	return var_53_0
end

function var_0_1.ShouldRequestReport(arg_54_0)
	if not arg_54_0.requestReportTime then
		arg_54_0.requestReportTime = 0
	end

	local function var_54_0()
		local var_55_0 = arg_54_0
		local var_55_1 = var_0.getRawData(var_55_0)

		if var_0.GetActiveEvent(var_55_1) and var_1:GetMissionFinishCnt() > 0 then
			return true
		end

		return false
	end

	pg = var_1_10002

	local var_54_1 = var_1_10002.TimeMgr.GetInstance()
	local var_54_2 = var_2.GetServerTime(var_54_1)

	if not arg_54_0.reports and var_54_0() or arg_54_0.requestReportTime < var_54_2 then
		GuildConst = var_3
		arg_54_0.requestReportTime = var_54_2 + var_3.REQUEST_REPORT_CD

		return true
	end

	return false
end

function var_0_1.ShouldRequestForamtion(arg_56_0)
	if not arg_56_0.requestFormationTime then
		arg_56_0.requestFormationTime = 0
	end

	pg = var_1

	local var_56_0 = var_1.TimeMgr.GetInstance()
	local var_56_1 = var_1.GetServerTime(var_56_0)

	if arg_56_0.requestFormationTime < var_56_1 then
		GuildConst = var_2
		arg_56_0.requestFormationTime = var_56_1 + var_2.REQUEST_FORMATION_CD

		return true
	end

	return false
end

function var_0_1.GetRecommendShipsForMission(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_1

	if arg_57_1.IsEliteType(var_57_0) then
		var_57_0 = arg_57_0

		return arg_57_0.GetRecommendShipsForEliteMission(var_57_0, arg_57_1)
	else
		local var_57_1 = {}

		getProxy = var_57_0
		BayProxy = var_1_10004

		local var_57_2 = var_57_0(var_1_10004)
		local var_57_3 = var_3.getRawData(var_57_2)
		local var_57_4 = {}

		pairs = var_1_10006

		for iter_57_0, iter_57_1 in var_1_10006(var_57_3) do
			table = var_1_10011

			var_1_10011.insert(var_57_4, {
				id = iter_57_1.id,
				power = iter_57_1:getShipCombatPower(),
				nation = iter_57_1:getNation(),
				type = iter_57_1:getShipType(),
				level = iter_57_1.level,
				tagList = iter_57_1:getConfig("tag_list"),
				configId = iter_57_1.configId,
				attrs = iter_57_1:getProperties(),
				isActivityNpc = function()
					local var_58_0 = iter_57_1

					return var_0.isActivityNpc(var_58_0)
				end
			})
		end

		local var_57_5 = arg_57_1:GetRecommendShipNation()
		local var_57_6 = arg_57_1
		local var_57_7 = arg_57_1.GetRecommendShipTypes(var_57_6)

		table = var_57_6

		local var_57_8 = var_57_6.sort
		local var_57_9 = var_57_4

		CompareFuncs = iter_57_1

		var_57_8(var_57_9, iter_57_1({
			function(arg_59_0)
				table = var_2_10001

				return var_2_10001.contains(var_57_5, arg_59_0.nation) and 0 or 1
			end,
			function(arg_60_0)
				table = var_2_10001

				return var_2_10001.contains(var_57_7, arg_60_0.type) and 0 or 1
			end,
			function(arg_61_0)
				return -arg_61_0.level
			end,
			function(arg_62_0)
				return -arg_62_0.power
			end
		}))

		ipairs = var_57_8

		for iter_57_2, iter_57_3 in var_57_8(var_57_4) do
			GuildEventMediator = var_1_10013

			if var_1_10013.OnCheckMissionShip(arg_57_1.id, var_57_1, iter_57_3) then
				table = var_1_10013

				var_1_10013.insert(var_57_1, iter_57_3.id)
			end

			if #var_57_1 == 4 then
				break
			end
		end

		return var_57_1
	end

	return
end

function var_0_1.GetRecommendShipsForEliteMission(arg_63_0, arg_63_1)
	assert = var_1_10002

	local var_63_0 = arg_63_1

	var_1_10002(arg_63_1.IsEliteType(var_63_0))

	local var_63_1 = {}

	getProxy = var_3
	BayProxy = var_63_0

	local var_63_2 = var_3(var_63_0)
	local var_63_3 = var_3.getRawData(var_63_2)
	local var_63_4 = {}
	local var_63_5 = {}
	local var_63_6 = {}

	pairs = var_1_10008

	for iter_63_0, iter_63_1 in var_1_10008(var_63_3) do
		local var_63_7 = {
			id = iter_63_1.id,
			power = iter_63_1:getShipCombatPower(),
			nation = iter_63_1:getNation(),
			type = iter_63_1:getShipType(),
			level = iter_63_1.level,
			tagList = iter_63_1:getConfig("tag_list"),
			configId = iter_63_1.configId,
			attrs = iter_63_1:getProperties(),
			isActivityNpc = function()
				local var_64_0 = iter_63_1

				return var_0.isActivityNpc(var_64_0)
			end
		}

		if arg_63_1:SameSquadron(var_63_7) then
			table = var_14

			var_14.insert(var_63_5, var_63_7)
		else
			table = var_14

			var_14.insert(var_63_6, var_63_7)
		end
	end

	local function var_63_8(arg_65_0)
		if arg_65_0 then
			table = var_2_10001

			if not var_2_10001.contains(var_63_1, arg_65_0.id) then
				GuildEventMediator = var_1

				if var_1.OnCheckMissionShip(arg_63_1.id, var_63_1, arg_65_0) then
					table = var_1

					var_1.insert(var_63_1, arg_65_0.id)
				end
			end
		end

		return
	end

	local var_63_9 = arg_63_1
	local var_63_10 = arg_63_1.GetEffectAttr(var_63_9)

	CompareFuncs = var_63_9

	local var_63_11 = var_63_9({
		function(arg_66_0)
			local var_66_0 = arg_63_1

			return var_1.MatchAttr(var_66_0, arg_66_0) and 0 or 1
		end,
		function(arg_67_0)
			local var_67_0 = arg_63_1

			return var_1.MatchNation(var_67_0, arg_67_0) and 0 or 1
		end,
		function(arg_68_0)
			local var_68_0 = arg_63_1

			return var_1.MatchShipType(var_68_0, arg_68_0) and 0 or 1
		end,
		function(arg_69_0)
			local var_69_0

			if not arg_69_0.attrs[var_63_10] then
				var_69_0 = 0
			end

			return -var_69_0
		end,
		function(arg_70_0)
			return -arg_70_0.level
		end,
		function(arg_71_0)
			return -arg_71_0.power
		end
	})
	local var_63_12 = arg_63_1:GetSquadronTargetCnt()

	if #var_63_5 > 0 and 0 < var_63_12 then
		table = var_12

		var_12.sort(var_63_5, var_63_11)

		for iter_63_2 = 1, var_63_12 do
			var_63_8(var_63_5[iter_63_2])
		end
	end

	if #var_63_1 < 4 and #var_63_6 > 0 then
		table = var_12

		var_12.sort(var_63_6, var_63_11)

		for iter_63_3 = 1, #var_63_6 do
			if #var_63_1 == 4 then
				break
			end

			var_63_8(var_63_6[iter_63_3])
		end
	end

	if #var_63_1 < 4 and var_63_12 > 0 and var_63_12 < #var_63_5 then
		for iter_63_4 = var_63_12 + 1, #var_63_5 do
			if #var_63_1 == 4 then
				break
			end

			var_63_8(var_63_5[iter_63_4])
		end
	end

	return var_63_1
end

function var_0_1.ShouldShowApplyTip(arg_72_0)
	if arg_72_0.data then
		GuildMember = var_1

		local var_72_0 = var_1.IsAdministrator
		local var_72_1 = arg_72_0.data

		if var_72_0(var_2.getSelfDuty(var_72_1)) then
			local var_72_2

			if not arg_72_0.requests then
				var_72_2 = arg_72_0.requestCount > 0

				return var_72_2
			end

			table = var_72_2

			return var_72_2.getCount(arg_72_0.requests) + arg_72_0.requestCount > 0
		end
	end

	return false
end

function var_0_1.ShouldShowBattleTip(arg_73_0)
	local var_73_0 = arg_73_0:getData()
	local var_73_1 = false

	local function var_73_2(arg_74_0)
		if arg_74_0 and arg_74_0:IsParticipant() then
			local var_74_0

			if arg_74_0:GetBossMission() and var_1:IsActive() then
				var_74_0 = var_1:CanEnterBattle()
			end

			return var_74_0
		end

		return false
	end

	local function var_73_3()
		ipairs = var_2_10000
		pg = var_2_10001

		for iter_75_0, iter_75_1 in var_2_10000(var_2_10001.guild_operation_template.all) do
			pg = var_2_10005
			var_2_10005 = var_2_10005.guild_operation_template[iter_75_1]

			if var_73_0.level >= var_2_10005.unlock_guild_level then
				local var_75_0 = var_73_0

				if var_6.getCapital(var_75_0) >= var_2_10005.consume then
					return true
				end
			end
		end

		return false
	end

	if var_73_0 then
		local var_73_4 = var_73_0
		local var_73_5 = var_73_0.GetActiveEvent(var_73_4)

		GuildMember = var_73_4

		local var_73_6

		if var_73_4.IsAdministrator(var_73_0:getSelfDuty()) then
			var_73_6 = var_73_0:ShouldTipActiveEvent()
		end

		var_73_1 = arg_73_0:ShouldShowMainTip() or not var_73_5 and var_73_6 and var_73_3() or var_73_5 and not arg_73_0:GetBattleBtnRecord()

		if var_73_5 then
			var_73_1 = var_73_1 or var_73_5:IsParticipant() and var_73_5:AnyMissionCanFormation() or var_73_2(var_73_5) or not var_7 and not var_73_5:IsLimitedJoin()
		end
	end

	return var_73_1
end

function var_0_1.SetBattleBtnRecord(arg_76_0)
	if not arg_76_0:GetBattleBtnRecord() and arg_76_0:getRawData() then
		local var_76_0 = var_2

		if var_2.GetActiveEvent(var_76_0) then
			getProxy = var_3
			PlayerProxy = var_76_0

			local var_76_1 = var_3(var_76_0)
			local var_76_2 = var_3.getRawData(var_76_1)

			PlayerPrefs = var_76_1

			var_76_1.SetInt("guild_battle_btn_flag" .. var_76_2.id, 1)

			PlayerPrefs = var_4

			var_4.Save()
			arg_76_0:sendNotification(var_0_1.BATTLE_BTN_FLAG_CHANGE)
		end
	end

	return
end

function var_0_1.GetBattleBtnRecord(arg_77_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_77_0 = var_1_10001(var_1_10002)
	local var_77_1 = var_1.getRawData(var_77_0)

	PlayerPrefs = var_77_0

	return var_77_0.GetInt("guild_battle_btn_flag" .. var_77_1.id, 0) > 0
end

function var_0_1.ShouldShowMainTip(arg_78_0)
	local function var_78_0()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_79_0 = var_2_10000(var_2_10001)
		local var_79_1 = var_0.getRawData(var_79_0).id
		local var_79_2 = arg_78_0.data
		local var_79_3 = var_1.getMemberById(var_79_2, var_79_1)

		return var_1.IsRecruit(var_79_3)
	end

	_ = var_1_10002

	local var_78_1 = var_1_10002.any
	local var_78_2

	if not arg_78_0.reports then
		var_78_2 = {}
	end

	local var_78_3

	var_78_3 = var_78_1(var_78_2, function(arg_80_0)
		return arg_80_0:CanSubmit()
	end) and not var_78_0()

	return var_78_3
end

function var_0_1.ShouldShowTip(arg_81_0)
	local var_81_0 = {}
	local var_81_1 = arg_81_0

	if arg_81_0.getData(var_81_1) then
		table = var_81_1

		var_81_1.insert(var_81_0, var_2:ShouldShowDonateTip())

		table = var_3

		var_3.insert(var_81_0, arg_81_0:ShouldShowApplyTip())

		table = var_3

		var_3.insert(var_81_0, var_2:ShouldWeeklyTaskTip())

		table = var_3

		var_3.insert(var_81_0, var_2:ShouldShowSupplyTip())

		table = var_3

		var_3.insert(var_81_0, var_2:ShouldShowTechTip())

		LOCK_GUILD_BATTLE = var_3

		if not var_3 then
			table = var_3

			var_3.insert(var_81_0, arg_81_0:ShouldShowBattleTip())
		end
	end

	local var_81_2

	if #var_81_0 > 0 then
		_ = var_3
		var_81_2 = var_3.any(var_81_0, function(arg_82_0)
			return arg_82_0 == true
		end)
	else
		var_81_2 = false
	end

	if false then
		var_81_2 = true
	end

	return var_81_2
end

function var_0_1.SetRefreshBossTime(arg_83_0, arg_83_1)
	GuildConst = var_1_10002
	arg_83_0.refreshBossTime = arg_83_1 + var_1_10002.REFRESH_BOSS_TIME

	return
end

function var_0_1.ShouldRefreshBoss(arg_84_0)
	local var_84_0 = arg_84_0:getRawData()
	local var_84_1

	if var_1.GetActiveEvent(var_84_0) then
		::label_84_0::

		var_1_10003 = var_1
		var_84_1 = not var_1.IsExpired(var_1_10003)
	end

	if var_84_1 then
		::label_84_1::

		pg = var_1_10003

		local var_84_2 = var_1_10003.TimeMgr.GetInstance()

		var_1_10003 = var_1_10003.GetServerTime(var_84_2) >= arg_84_0.refreshBossTime
	end

	return var_1_10003
end

function var_0_1.ResetRefreshBossTime(arg_85_0)
	arg_85_0.refreshBossTime = 0

	return
end

function var_0_1.ShouldRefreshBossRank(arg_86_0)
	local var_86_0 = arg_86_0:getRawData()
	local var_86_1 = var_1.GetActiveEvent(var_86_0)

	pg = var_86_0

	local var_86_2 = var_86_0.TimeMgr.GetInstance()
	local var_86_3 = var_2.GetServerTime(var_86_2)

	if var_86_1 then
		::label_86_0::

		var_86_2 = var_86_3 - arg_86_0.bossRankUpdateTime
		GuildConst = var_1_10004
		var_86_2 = var_86_2 >= var_1_10004.REFRESH_MISSION_BOSS_RANK_TIME
	end

	return var_86_2
end

function var_0_1.UpdateBossRank(arg_87_0, arg_87_1)
	arg_87_0.bossRanks = arg_87_1

	return
end

function var_0_1.GetBossRank(arg_88_0)
	return arg_88_0.bossRanks
end

function var_0_1.ResetBossRankTime(arg_89_0)
	arg_89_0.rankUpdateTime = 0

	return
end

function var_0_1.UpdateBossRankRefreshTime(arg_90_0, arg_90_1)
	arg_90_0.rankUpdateTime = arg_90_1

	return
end

function var_0_1.GetAdditionGuild(arg_91_0)
	if arg_91_0.data == nil then
		return arg_91_0.publicGuild
	else
		return arg_91_0.data
	end

	return
end

function var_0_1.SetReportRankList(arg_92_0, arg_92_1, arg_92_2)
	if not arg_92_0.reportRankList then
		arg_92_0.reportRankList = {}
	end

	arg_92_0.reportRankList[arg_92_1] = arg_92_2

	return
end

function var_0_1.GetReportRankList(arg_93_0, arg_93_1)
	if arg_93_0.reportRankList then
		return arg_93_0.reportRankList[arg_93_1]
	end

	return nil
end

return var_0_1
