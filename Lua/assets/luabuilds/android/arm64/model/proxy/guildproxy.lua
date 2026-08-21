local var_0_0 = class("GuildProxy", import(".NetProxy"))

var_0_0.NEW_GUILD_ADDED = "GuildProxy:NEW_GUILD_ADDED"
var_0_0.GUILD_UPDATED = "GuildProxy:GUILD_UPDATED"
var_0_0.EXIT_GUILD = "GuildProxy:EXIT_GUILD"
var_0_0.REQUEST_ADDED = "GuildProxy:REQUEST_ADDED"
var_0_0.REQUEST_DELETED = "GuildProxy:REQUEST_DELETED"
var_0_0.NEW_MSG_ADDED = "GuildProxy:NEW_MSG_ADDED"
var_0_0.REQUEST_COUNT_UPDATED = "GuildProxy:REQUEST_COUNT_UPDATED"
var_0_0.LOG_ADDED = "GuildProxy:LOG_ADDED"
var_0_0.WEEKLYTASK_UPDATED = "GuildProxy:WEEKLYTASK_UPDATED"
var_0_0.SUPPLY_STARTED = "GuildProxy:SUPPLY_STARTED"
var_0_0.WEEKLYTASK_ADDED = "GuildProxy:WEEKLYTASK_ADDED"
var_0_0.DONATE_UPDTAE = "GuildProxy:DONATE_UPDTAE"
var_0_0.TECHNOLOGY_START = "GuildProxy:TECHNOLOGY_START"
var_0_0.TECHNOLOGY_STOP = "GuildProxy:TECHNOLOGY_STOP"
var_0_0.CAPITAL_UPDATED = "GuildProxy:CAPITAL_UPDATED"
var_0_0.GUILD_BATTLE_STARTED = "GuildProxy:GUILD_BATTLE_STARTED"
var_0_0.GUILD_BATTLE_CLOSED = "GuildProxy:GUILD_BATTLE_CLOSED"
var_0_0.ON_DELETED_MEMBER = "GuildProxy:ON_DELETED_MEMBER"
var_0_0.ON_ADDED_MEMBER = "GuildProxy:ON_ADDED_MEMBER"
var_0_0.BATTLE_BTN_FLAG_CHANGE = "GuildProxy:BATTLE_BTN_FLAG_CHANGE"
var_0_0.ON_EXIST_DELETED_MEMBER = "GuildProxy:ON_EXIST_DELETED_MEMBER"
var_0_0.ON_DONATE_LIST_UPDATED = "GuildProxy:ON_DONATE_LIST_UPDATED"

function var_0_0.register(arg_1_0)
	arg_1_0:Init()
	arg_1_0:on(60000, function(arg_2_0)
		local var_2_0 = Guild.New(arg_2_0.guild)

		if var_2_0.id == 0 then
			arg_1_0:exitGuild()
		elseif arg_1_0.data == nil then
			arg_1_0:addGuild(var_2_0)

			if not getProxy(GuildProxy).isGetChatMsg then
				arg_1_0:sendNotification(GAME.GET_GUILD_CHAT_LIST)
			end

			arg_1_0:sendNotification(GAME.GUILD_GET_USER_INFO)
			arg_1_0:sendNotification(GAME.GUILD_GET_MY_ASSAULT_FLEET, {})
			arg_1_0:sendNotification(GAME.GUILD_GET_ASSAULT_FLEET, {})
			arg_1_0:sendNotification(GAME.GUILD_GET_ACTIVATION_EVENT, {
				force = true
			})
			arg_1_0:sendNotification(GAME.GUILD_GET_REQUEST_LIST, var_2_0.id)
		else
			arg_1_0:updateGuild(var_2_0)
		end

		return
	end)
	arg_1_0:on(60009, function(arg_3_0)
		arg_1_0.requestCount = arg_3_0.count

		arg_1_0:sendNotification(var_0_0.REQUEST_COUNT_UPDATED, arg_3_0.count)

		return
	end)
	arg_1_0:on(60030, function(arg_4_0)
		local var_4_0 = arg_1_0:getData()

		if not var_4_0 then
			return
		end

		var_4_0:updateBaseInfo({
			base = arg_4_0.guild
		})
		arg_1_0:updateGuild(var_4_0)

		return
	end)
	arg_1_0:on(60031, function(arg_5_0)
		local var_5_0 = arg_1_0:getData()

		if not var_5_0 then
			return
		end

		local var_5_1 = false

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.member_list) do
			local var_5_2 = GuildMember.New(iter_5_1)

			if var_5_2.duty == 0 then
				local var_5_3 = var_5_0:getMemberById(var_5_2.id):clone()

				var_5_0:deleteMember(var_5_2.id)
				arg_1_0:sendNotification(GuildProxy.ON_DELETED_MEMBER, {
					member = var_5_3
				})

				var_5_1 = true
			elseif var_5_0.member[var_5_2.id] then
				var_5_0:updateMember(var_5_2)
			else
				var_5_0:addMember(var_5_2)
				arg_1_0:sendNotification(GuildProxy.ON_ADDED_MEMBER, {
					member = var_5_2
				})
			end
		end

		for iter_5_2, iter_5_3 in ipairs(arg_5_0.log_list) do
			local var_5_4 = GuildLogInfo.New(iter_5_3)

			var_5_0:addLog(var_5_4)
			arg_1_0:sendNotification(var_0_0.LOG_ADDED, Clone(var_5_4))
		end

		var_5_0:setMemberCount(table.getCount(var_5_5))
		arg_1_0:updateGuild(var_5_0)

		if var_5_1 then
			arg_1_0:sendNotification(GuildProxy.ON_EXIST_DELETED_MEMBER)
		end

		return
	end)
	arg_1_0:on(0, function(arg_6_0)
		local var_6_0 = arg_1_0:getData()

		if not var_6_0 then
			return
		end

		var_6_0:updateExp(arg_6_0.exp)
		var_6_0:updateLevel(arg_6_0.lv)
		arg_1_0:updateGuild(var_6_0)

		return
	end)
	arg_1_0:on(60008, function(arg_7_0)
		local var_7_0 = arg_1_0.data:warpChatInfo(arg_7_0.chat)

		if var_7_0 then
			arg_1_0:AddNewMsg(var_7_0)
		end

		return
	end)
	arg_1_0:on(62004, function(arg_8_0)
		local var_8_0 = arg_1_0:getData()

		if not var_8_0 or not var_8_0:IsCompletion() then
			return
		end

		var_8_0:updateWeeklyTask((GuildTask.New(arg_8_0.this_weekly_tasks)))
		var_8_0:setWeeklyTaskFlag(0)
		arg_1_0:updateGuild(var_8_0)
		arg_1_0:sendNotification(var_0_0.WEEKLYTASK_ADDED)

		return
	end)
	arg_1_0:on(62005, function(arg_9_0)
		local var_9_0 = arg_1_0:getData()

		if not var_9_0 or not var_9_0:IsCompletion() then
			return
		end

		var_9_0:startSupply(arg_9_0.benefit_finish_time)
		var_9_0:consumeCapital((var_9_0:getSupplyConsume()))
		arg_1_0:updateGuild(var_9_0)
		arg_1_0:sendNotification(var_0_0.CAPITAL_UPDATED)
		arg_1_0:sendNotification(var_0_0.SUPPLY_STARTED)

		return
	end)
	arg_1_0:on(62018, function(arg_10_0)
		local var_10_0 = arg_1_0:getData()

		if not var_10_0 or not var_10_0:IsCompletion() then
			return
		end

		local var_10_2 = var_10_0:getActiveTechnologyGroup()

		if var_10_2 then
			var_10_2:Stop()
		end

		var_10_0:getTechnologyGroupById(var_10_1):Start()
		var_10_0:UpdateTechCancelCnt()
		arg_1_0:updateGuild(var_10_0)
		arg_1_0:sendNotification(var_0_0.TECHNOLOGY_START)

		return
	end)
	arg_1_0:on(62019, function(arg_11_0)
		local var_11_0 = arg_1_0:getData()

		if not var_11_0 or not var_11_0:IsCompletion() then
			return
		end

		local var_11_1 = GuildDonateTask.New({
			id = arg_11_0.id
		})
		local var_11_2 = arg_11_0.has_capital == 1
		local var_11_3 = arg_11_0.has_tech_point == 1
		local var_11_4 = arg_11_0.user_id
		local var_11_5 = getProxy(PlayerProxy):getRawData().id

		if arg_11_0.has_capital == 1 then
			local var_11_6 = var_11_1:getCapital()

			var_11_0:updateCapital(var_11_0:getCapital() + var_11_6)

			if var_11_5 == var_11_4 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("guild_donate_addition_capital_tip", var_11_6))
			end
		end

		if var_11_3 then
			local var_11_7 = var_11_0:getActiveTechnologyGroup()

			if var_11_7 then
				local var_11_8 = var_11_1:getConfig("award_tech_exp")

				var_11_7:AddProgress(var_11_8)

				if var_11_7.pid ~= var_11_7.pid and var_11_7:GuildMemberCntType() then
					local var_11_9 = var_11_0:getTechnologyById(var_11_7.id)

					assert(var_11_9)
					var_11_9:Update(var_11_7.pid, var_11_7)
				end

				if var_11_5 == var_11_4 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("guild_donate_addition_techpoint_tip", var_11_8))
				end
			end
		end

		if var_11_2 or var_11_3 then
			arg_1_0:updateGuild(var_11_0)
			arg_1_0:sendNotification(var_0_0.DONATE_UPDTAE)
		end

		if var_11_2 then
			arg_1_0:sendNotification(var_0_0.CAPITAL_UPDATED)
		end

		if not var_11_2 and var_11_4 == var_11_5 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_donate_capital_toplimit"))
		end

		if not var_11_3 and var_11_4 == var_11_5 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_donate_techpoint_toplimit"))
		end

		return
	end)
	arg_1_0:on(62031, function(arg_12_0)
		local var_12_0 = arg_1_0:getData()

		if not var_12_0 or not var_12_0:IsCompletion() then
			return
		end

		local var_12_1 = {}

		for iter_12_0, iter_12_1 in ipairs(arg_12_0.donate_tasks) do
			table.insert(var_12_1, (GuildDonateTask.New({
				id = iter_12_1
			})))
		end

		if var_12_0 then
			var_12_0.donateCount = 0

			var_12_0:updateDonateTasks(var_12_1)
			arg_1_0:updateGuild(var_12_0)
			arg_1_0:sendNotification(var_0_0.ON_DONATE_LIST_UPDATED)
		else
			local var_12_2 = arg_1_0:GetPublicGuild()

			if var_12_2 then
				var_12_2:ResetDonateCnt()
				var_12_2:UpdateDonateTasks(var_12_1)
				arg_1_0:sendNotification(GAME.PUBLIC_GUILD_REFRESH_DONATE_LIST_DONE)
			end
		end

		return
	end)
	arg_1_0:on(61021, function(arg_13_0)
		arg_1_0.refreshActivationEventTime = 0

		if arg_13_0.user_id ~= getProxy(PlayerProxy):getData().id then
			arg_1_0:sendNotification(var_0_0.GUILD_BATTLE_STARTED)
		end

		return
	end)

	return
end

function var_0_0.timeCall(arg_14_0)
	return {
		[ProxyRegister.DayCall] = function(arg_15_0)
			local var_15_0 = arg_14_0:getRawData()

			if var_15_0 then
				var_15_0:ResetTechCancelCnt()

				local var_15_1 = var_15_0:getWeeklyTask()

				if var_15_1 and var_15_1:isExpire() then
					getProxy(TaskProxy):deleteTaskById((var_15_1:GetPresonTaskId()))

					var_15_0.weeklyTaskFlag = 0
				end

				local var_15_2 = var_15_0:GetActiveEvent()

				if var_15_2 then
					var_15_2:GetBossMission():ResetDailyCnt()
				end

				if arg_15_0 == 1 then
					var_15_0:ResetActiveEventCnt()
				end

				arg_14_0:updateGuild(var_15_0)
			end

			if arg_14_0:GetPublicGuild() then
				onDelayTick(function()
					arg_14_0:sendNotification(GAME.GET_PUBLIC_GUILD_USER_DATA, {
						flag = true
					})

					return
				end, math.random(2, 5))
			end

			return
		end
	}
end

function var_0_0.AddPublicGuild(arg_17_0, arg_17_1)
	arg_17_0.publicGuild = arg_17_1

	return
end

function var_0_0.GetPublicGuild(arg_18_0)
	return arg_18_0.publicGuild
end

function var_0_0.Init(arg_19_0)
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

function var_0_0.AddNewMsg(arg_20_0, arg_20_1)
	arg_20_0.newChatMsgCnt = arg_20_0.newChatMsgCnt + 1

	arg_20_0:addMsg(arg_20_1)
	arg_20_0:sendNotification(var_0_0.NEW_MSG_ADDED, arg_20_1)

	return
end

function var_0_0.ResetRequestCount(arg_21_0)
	arg_21_0.requestCount = 0

	return
end

function var_0_0.UpdatePosCdTime(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.cdTime[arg_22_1] = arg_22_2

	return
end

function var_0_0.GetNextCanFormationTime(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.cdTime[arg_23_1] or 0

	return var_23_0 + pg.guildset.operation_assault_team_cd.key_value
end

function var_0_0.CanFormationPos(arg_24_0, arg_24_1)
	local var_24_0 = pg.TimeMgr.GetInstance()

	return arg_24_0:GetNextCanFormationTime(arg_24_1) <= var_24_0:GetServerTime()
end

function var_0_0.ClearNewChatMsgCnt(arg_25_0)
	arg_25_0.newChatMsgCnt = 0

	return
end

function var_0_0.GetNewChatMsgCnt(arg_26_0)
	return arg_26_0.newChatMsgCnt
end

function var_0_0.setRequestList(arg_27_0, arg_27_1)
	arg_27_0.requests = arg_27_1

	return
end

function var_0_0.addGuild(arg_28_0, arg_28_1)
	assert(isa(arg_28_1, Guild), "guild should instance of Guild")

	arg_28_0.data = arg_28_1

	arg_28_0:sendNotification(var_0_0.NEW_GUILD_ADDED, Clone(arg_28_1))

	return
end

function var_0_0.updateGuild(arg_29_0, arg_29_1)
	assert(isa(arg_29_1, Guild), "guild should instance of Guild")

	arg_29_0.data = arg_29_1

	arg_29_0:sendNotification(var_0_0.GUILD_UPDATED, Clone(arg_29_1))

	return
end

function var_0_0.exitGuild(arg_30_0)
	arg_30_0:Init()
	arg_30_0:sendNotification(var_0_0.EXIT_GUILD)
	pg.ShipFlagMgr.GetInstance():ClearShipsFlag("inGuildEvent")
	pg.ShipFlagMgr.GetInstance():ClearShipsFlag("inGuildBossEvent")

	return
end

function var_0_0.getRequests(arg_31_0)
	return arg_31_0.requests
end

function var_0_0.getSortRequest(arg_32_0)
	if not arg_32_0.requests then
		return nil
	end

	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(arg_32_0.requests) do
		table.insert(var_32_0, iter_32_1)
	end

	return var_32_0
end

function var_0_0.deleteRequest(arg_33_0, arg_33_1)
	if not arg_33_0.requests then
		return
	end

	arg_33_0.requests[arg_33_1] = nil

	arg_33_0:sendNotification(var_0_0.REQUEST_DELETED, arg_33_1)

	return
end

function var_0_0.addMsg(arg_34_0, arg_34_1)
	table.insert(arg_34_0.chatMsgs, arg_34_1)

	if #arg_34_0.chatMsgs > GuildConst.CHAT_LOG_MAX_COUNT then
		table.remove(arg_34_0.chatMsgs, 1)
	end

	return
end

function var_0_0.getChatMsgs(arg_35_0)
	return arg_35_0.chatMsgs
end

function var_0_0.GetMessagesByUniqueId(arg_36_0, arg_36_1)
	return _.select(arg_36_0.chatMsgs, function(arg_37_0)
		return arg_37_0.uniqueId == arg_36_1
	end)
end

function var_0_0.UpdateMsg(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(arg_38_0.chatMsgs) do
		if iter_38_1:IsSame(arg_38_1.uniqueId) then
			arg_38_0.data[iter_38_0] = arg_38_1
		end
	end

	return
end

function var_0_0.ShouldFetchActivationEvent(arg_39_0)
	local var_39_0 = pg.TimeMgr.GetInstance()

	return var_39_0:GetServerTime() > arg_39_0.refreshActivationEventTime
end

function var_0_0.AddFetchActivationEventCDTime(arg_40_0)
	arg_40_0.refreshActivationEventTime = GuildConst.REFRESH_ACTIVATION_EVENT_TIME + pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.AddActivationEventTimer(arg_41_0, arg_41_1)
	return
end

function var_0_0.RemoveActivationEventTimer(arg_42_0)
	if arg_42_0.timer then
		arg_42_0.timer:Stop()

		arg_42_0.timer = nil
	end

	return
end

function var_0_0.remove(arg_43_0)
	arg_43_0:RemoveActivationEventTimer()

	return
end

function var_0_0.SetRank(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0.ranks[arg_44_1] = arg_44_2
	arg_44_0["rankTimer" .. arg_44_1] = pg.TimeMgr.GetInstance():GetServerTime() + 8

	return
end

function var_0_0.GetRanks(arg_45_0)
	return arg_45_0.ranks
end

function var_0_0.ShouldRefreshRank(arg_46_0, arg_46_1)
	if arg_46_0["rankTimer" .. arg_46_1] then
		if pg.TimeMgr.GetInstance():GetServerTime() >= arg_46_0["rankTimer" .. arg_46_1] then
			return true
		end

		return false
	end
end

function var_0_0.SetReports(arg_47_0, arg_47_1)
	arg_47_0.reports = arg_47_1

	return
end

function var_0_0.GetReports(arg_48_0)
	return arg_48_0.reports or {}
end

function var_0_0.GetReportById(arg_49_0, arg_49_1)
	return arg_49_0.reports[arg_49_1]
end

function var_0_0.AddReport(arg_50_0, arg_50_1)
	arg_50_0.reports = arg_50_0.reports or {}
	arg_50_0.reports[arg_50_1.id] = arg_50_1

	return
end

function var_0_0.GetMaxReportId(arg_51_0)
	local var_51_0 = 0

	for iter_51_0, iter_51_1 in pairs((arg_51_0:GetReports())) do
		if var_51_0 < iter_51_1.id then
			var_51_0 = iter_51_1.id
		end
	end

	return var_51_0
end

function var_0_0.AnyRepoerCanGet(arg_52_0)
	return #arg_52_0:GetCanGetReports() > 0
end

function var_0_0.GetCanGetReports(arg_53_0)
	for iter_53_0, iter_53_1 in pairs((arg_53_0:GetReports())) do
		if iter_53_1:CanSubmit() then
			table.insert({}, iter_53_1.id)
		end
	end

	return {}
end

function var_0_0.ShouldRequestReport(arg_54_0)
	arg_54_0.requestReportTime = arg_54_0.requestReportTime or 0

	local var_54_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if not arg_54_0.reports and var_54_0() or var_54_1 > arg_54_0.requestReportTime then
		arg_54_0.requestReportTime = var_54_1 + GuildConst.REQUEST_REPORT_CD

		return true
	end

	return false
end

function var_0_0.ShouldRequestForamtion(arg_56_0)
	arg_56_0.requestFormationTime = arg_56_0.requestFormationTime or 0

	local var_56_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_56_0 > arg_56_0.requestFormationTime then
		arg_56_0.requestFormationTime = var_56_0 + GuildConst.REQUEST_FORMATION_CD

		return true
	end

	return false
end

function var_0_0.GetRecommendShipsForMission(arg_57_0, arg_57_1)
	if arg_57_1:IsEliteType() then
		return arg_57_0:GetRecommendShipsForEliteMission(arg_57_1)
	else
		local var_57_0 = {}

		for iter_57_0, iter_57_1 in pairs((getProxy(BayProxy):getRawData())) do
			table.insert({}, {
				id = iter_57_1.id,
				power = iter_57_1:getShipCombatPower(),
				nation = iter_57_1:getNation(),
				type = iter_57_1:getShipType(),
				level = iter_57_1.level,
				tagList = iter_57_1:getConfig("tag_list"),
				configId = iter_57_1.configId,
				attrs = iter_57_1:getProperties(),
				isActivityNpc = function()
					return iter_57_1:isActivityNpc()
				end
			})
		end

		local var_57_1 = arg_57_1:GetRecommendShipNation()
		local var_57_2 = arg_57_1:GetRecommendShipTypes()

		table.sort({}, CompareFuncs({
			function(arg_59_0)
				return table.contains(var_57_1, arg_59_0.nation) and 0 or 1
			end,
			function(arg_60_0)
				return table.contains(var_57_2, arg_60_0.type) and 0 or 1
			end,
			function(arg_61_0)
				return -arg_61_0.level
			end,
			function(arg_62_0)
				return -arg_62_0.power
			end
		}))

		for iter_57_2, iter_57_3 in ipairs({}) do
			if GuildEventMediator.OnCheckMissionShip(arg_57_1.id, var_57_0, iter_57_3) then
				table.insert(var_57_0, iter_57_3.id)
			end

			if #var_57_0 == 4 then
				break
			end
		end

		return var_57_0
	end

	return
end

function var_0_0.GetRecommendShipsForEliteMission(arg_63_0, arg_63_1)
	assert(arg_63_1:IsEliteType())

	local var_63_0 = {}

	for iter_63_0, iter_63_1 in pairs((getProxy(BayProxy):getRawData())) do
		local var_63_2 = {
			id = iter_63_1.id,
			power = iter_63_1:getShipCombatPower(),
			nation = iter_63_1:getNation(),
			type = iter_63_1:getShipType(),
			level = iter_63_1.level,
			tagList = iter_63_1:getConfig("tag_list"),
			configId = iter_63_1.configId,
			attrs = iter_63_1:getProperties(),
			isActivityNpc = function()
				return iter_63_1:isActivityNpc()
			end
		}

		if arg_63_1:SameSquadron(var_63_2) then
			table.insert({}, var_63_2)
		else
			table.insert({}, var_63_2)
		end
	end

	local var_63_3 = arg_63_1:GetEffectAttr()
	local var_63_4 = CompareFuncs({
		function(arg_66_0)
			return arg_63_1:MatchAttr(arg_66_0) and 0 or 1
		end,
		function(arg_67_0)
			return arg_63_1:MatchNation(arg_67_0) and 0 or 1
		end,
		function(arg_68_0)
			return arg_63_1:MatchShipType(arg_68_0) and 0 or 1
		end,
		function(arg_69_0)
			local var_69_0 = arg_69_0.attrs[var_63_3] or 0

			return -var_69_0
		end,
		function(arg_70_0)
			return -arg_70_0.level
		end,
		function(arg_71_0)
			return -arg_71_0.power
		end
	})
	local var_63_5 = arg_63_1:GetSquadronTargetCnt()

	if #{} > 0 and var_63_5 > 0 then
		table.sort({}, var_63_4)

		for iter_63_2 = 1, var_63_5 do
			(function(arg_65_0)
				if arg_65_0 and not table.contains(var_63_0, arg_65_0.id) and GuildEventMediator.OnCheckMissionShip(arg_63_1.id, var_63_0, arg_65_0) then
					table.insert(var_63_0, arg_65_0.id)
				end

				return
			end)(({})[iter_63_2])
		end
	end

	if #{} < 4 and #{} > 0 then
		table.sort({}, var_63_4)

		for iter_63_3 = 1, #{} do
			if #{} == 4 then
				break
			end

			;(function(arg_65_0)
				if arg_65_0 and not table.contains(var_63_0, arg_65_0.id) and GuildEventMediator.OnCheckMissionShip(arg_63_1.id, var_63_0, arg_65_0) then
					table.insert(var_63_0, arg_65_0.id)
				end

				return
			end)(({})[iter_63_3])
		end
	end

	if #{} < 4 and var_63_5 > 0 and var_63_5 < #{} then
		for iter_63_4 = var_63_5 + 1, #{} do
			if #{} == 4 then
				break
			end

			;(function(arg_65_0)
				if arg_65_0 and not table.contains(var_63_0, arg_65_0.id) and GuildEventMediator.OnCheckMissionShip(arg_63_1.id, var_63_0, arg_65_0) then
					table.insert(var_63_0, arg_65_0.id)
				end

				return
			end)(({})[iter_63_4])
		end
	end

	return {}
end

function var_0_0.ShouldShowApplyTip(arg_72_0)
	if arg_72_0.data and GuildMember.IsAdministrator(arg_72_0.data:getSelfDuty()) then
		if not arg_72_0.requests then
			return arg_72_0.requestCount > 0
		end

		return table.getCount(arg_72_0.requests) + arg_72_0.requestCount > 0
	end

	return false
end

function var_0_0.ShouldShowBattleTip(arg_73_0)
	local var_73_0 = arg_73_0:getData()
	local var_73_1 = false

	if var_73_0 then
		local var_73_3 = var_73_0:GetActiveEvent()
		local var_73_4 = GuildMember.IsAdministrator(var_73_0:getSelfDuty()) and var_73_0:ShouldTipActiveEvent()

		var_73_1 = arg_73_0:ShouldShowMainTip() or not var_73_3 and var_73_4 and (function()
			for iter_75_0, iter_75_1 in ipairs(pg.guild_operation_template.all) do
				if var_73_0.level >= pg.guild_operation_template[iter_75_1].unlock_guild_level and var_73_0:getCapital() >= pg.guild_operation_template[iter_75_1].consume then
					return true
				end
			end

			return false
		end)() or var_73_3 and not arg_73_0:GetBattleBtnRecord()

		if var_73_3 and not var_73_1 then
			local var_73_5 = var_73_3:IsParticipant()

			var_73_1 = var_73_5 and var_73_3:AnyMissionCanFormation() or var_73_2(var_73_3) or not var_73_5 and not var_73_3:IsLimitedJoin()
		end
	end

	return var_73_1
end

function var_0_0.SetBattleBtnRecord(arg_76_0)
	if not arg_76_0:GetBattleBtnRecord() then
		local var_76_0 = arg_76_0:getRawData()

		if var_76_0 and var_76_0:GetActiveEvent() then
			PlayerPrefs.SetInt("guild_battle_btn_flag" .. getProxy(PlayerProxy):getRawData().id, 1)
			PlayerPrefs.Save()
			arg_76_0:sendNotification(var_0_0.BATTLE_BTN_FLAG_CHANGE)
		end
	end

	return
end

function var_0_0.GetBattleBtnRecord(arg_77_0)
	local var_77_0 = PlayerPrefs.GetInt("guild_battle_btn_flag" .. getProxy(PlayerProxy):getRawData().id, 0)

	return var_77_0 > 0
end

function var_0_0.ShouldShowMainTip(arg_78_0)
	local var_78_0 = arg_78_0.reports or {}

	return _.any(var_78_0, function(arg_80_0)
		return arg_80_0:CanSubmit()
	end) and not (function()
		return arg_78_0.data:getMemberById(getProxy(PlayerProxy):getRawData().id):IsRecruit()
	end)()
end

function var_0_0.ShouldShowTip(arg_81_0)
	local var_81_0 = arg_81_0:getData()

	if var_81_0 then
		table.insert({}, var_81_0:ShouldShowDonateTip())
		table.insert({}, arg_81_0:ShouldShowApplyTip())
		table.insert({}, var_81_0:ShouldWeeklyTaskTip())
		table.insert({}, var_81_0:ShouldShowSupplyTip())
		table.insert({}, var_81_0:ShouldShowTechTip())

		if not LOCK_GUILD_BATTLE then
			table.insert({}, arg_81_0:ShouldShowBattleTip())
		end
	end

	return #{} > 0 and _.any({}, function(arg_82_0)
		return arg_82_0 == true
	end)
end

function var_0_0.SetRefreshBossTime(arg_83_0, arg_83_1)
	arg_83_0.refreshBossTime = arg_83_1 + GuildConst.REFRESH_BOSS_TIME

	return
end

function var_0_0.ShouldRefreshBoss(arg_84_0)
	local var_84_0 = arg_84_0:getRawData():GetActiveEvent()
	local var_84_2

	if var_84_0 and not var_84_0:IsExpired() then
		::label_84_0::

		local var_84_1 = pg.TimeMgr.GetInstance()

		var_84_2 = var_84_1:GetServerTime() >= arg_84_0.refreshBossTime
	end

	return var_84_2
end

function var_0_0.ResetRefreshBossTime(arg_85_0)
	arg_85_0.refreshBossTime = 0

	return
end

function var_0_0.ShouldRefreshBossRank(arg_86_0)
	return arg_86_0:getRawData():GetActiveEvent() and pg.TimeMgr.GetInstance():GetServerTime() - arg_86_0.bossRankUpdateTime >= GuildConst.REFRESH_MISSION_BOSS_RANK_TIME
end

function var_0_0.UpdateBossRank(arg_87_0, arg_87_1)
	arg_87_0.bossRanks = arg_87_1

	return
end

function var_0_0.GetBossRank(arg_88_0)
	return arg_88_0.bossRanks
end

function var_0_0.ResetBossRankTime(arg_89_0)
	arg_89_0.rankUpdateTime = 0

	return
end

function var_0_0.UpdateBossRankRefreshTime(arg_90_0, arg_90_1)
	arg_90_0.rankUpdateTime = arg_90_1

	return
end

function var_0_0.GetAdditionGuild(arg_91_0)
	if arg_91_0.data == nil then
		return arg_91_0.publicGuild
	else
		return arg_91_0.data
	end

	return
end

function var_0_0.SetReportRankList(arg_92_0, arg_92_1, arg_92_2)
	arg_92_0.reportRankList = arg_92_0.reportRankList or {}
	arg_92_0.reportRankList[arg_92_1] = arg_92_2

	return
end

function var_0_0.GetReportRankList(arg_93_0, arg_93_1)
	if arg_93_0.reportRankList then
		return arg_93_0.reportRankList[arg_93_1]
	end

	return nil
end

return var_0_0
