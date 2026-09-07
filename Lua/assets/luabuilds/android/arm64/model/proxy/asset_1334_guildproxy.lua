local GuildProxy = class("GuildProxy", import(".NetProxy"))

GuildProxy.NEW_GUILD_ADDED = "GuildProxy:NEW_GUILD_ADDED"
GuildProxy.GUILD_UPDATED = "GuildProxy:GUILD_UPDATED"
GuildProxy.EXIT_GUILD = "GuildProxy:EXIT_GUILD"
GuildProxy.REQUEST_ADDED = "GuildProxy:REQUEST_ADDED"
GuildProxy.REQUEST_DELETED = "GuildProxy:REQUEST_DELETED"
GuildProxy.NEW_MSG_ADDED = "GuildProxy:NEW_MSG_ADDED"
GuildProxy.REQUEST_COUNT_UPDATED = "GuildProxy:REQUEST_COUNT_UPDATED"
GuildProxy.LOG_ADDED = "GuildProxy:LOG_ADDED"
GuildProxy.WEEKLYTASK_UPDATED = "GuildProxy:WEEKLYTASK_UPDATED"
GuildProxy.SUPPLY_STARTED = "GuildProxy:SUPPLY_STARTED"
GuildProxy.WEEKLYTASK_ADDED = "GuildProxy:WEEKLYTASK_ADDED"
GuildProxy.DONATE_UPDTAE = "GuildProxy:DONATE_UPDTAE"
GuildProxy.TECHNOLOGY_START = "GuildProxy:TECHNOLOGY_START"
GuildProxy.TECHNOLOGY_STOP = "GuildProxy:TECHNOLOGY_STOP"
GuildProxy.CAPITAL_UPDATED = "GuildProxy:CAPITAL_UPDATED"
GuildProxy.GUILD_BATTLE_STARTED = "GuildProxy:GUILD_BATTLE_STARTED"
GuildProxy.GUILD_BATTLE_CLOSED = "GuildProxy:GUILD_BATTLE_CLOSED"
GuildProxy.ON_DELETED_MEMBER = "GuildProxy:ON_DELETED_MEMBER"
GuildProxy.ON_ADDED_MEMBER = "GuildProxy:ON_ADDED_MEMBER"
GuildProxy.BATTLE_BTN_FLAG_CHANGE = "GuildProxy:BATTLE_BTN_FLAG_CHANGE"
GuildProxy.ON_EXIST_DELETED_MEMBER = "GuildProxy:ON_EXIST_DELETED_MEMBER"
GuildProxy.ON_DONATE_LIST_UPDATED = "GuildProxy:ON_DONATE_LIST_UPDATED"

function GuildProxy:register()
	self:Init()
	self:on(60000, function(arg_2_0)
		local var_2_0 = Guild.New(arg_2_0.guild)

		if var_2_0.id == 0 then
			self:exitGuild()
		elseif self.data == nil then
			self:addGuild(var_2_0)

			if not getProxy(GuildProxy).isGetChatMsg then
				self:sendNotification(GAME.GET_GUILD_CHAT_LIST)
			end

			self:sendNotification(GAME.GUILD_GET_USER_INFO)
			self:sendNotification(GAME.GUILD_GET_MY_ASSAULT_FLEET, {})
			self:sendNotification(GAME.GUILD_GET_ASSAULT_FLEET, {})
			self:sendNotification(GAME.GUILD_GET_ACTIVATION_EVENT, {
				force = true
			})
			self:sendNotification(GAME.GUILD_GET_REQUEST_LIST, var_2_0.id)
		else
			self:updateGuild(var_2_0)
		end

		return
	end)
	self:on(60009, function(arg_3_0)
		self.requestCount = arg_3_0.count

		self:sendNotification(GuildProxy.REQUEST_COUNT_UPDATED, arg_3_0.count)

		return
	end)
	self:on(60030, function(arg_4_0)
		local var_4_0 = self:getData()

		if not var_4_0 then
			return
		end

		var_4_0:updateBaseInfo({
			base = arg_4_0.guild
		})
		self:updateGuild(var_4_0)

		return
	end)
	self:on(60031, function(arg_5_0)
		local var_5_0 = self:getData()

		if not var_5_0 then
			return
		end

		local var_5_1 = false

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.member_list) do
			local var_5_2 = GuildMember.New(iter_5_1)

			if var_5_2.duty == 0 then
				local var_5_3 = var_5_0:getMemberById(var_5_2.id):clone()

				var_5_0:deleteMember(var_5_2.id)
				self:sendNotification(GuildProxy.ON_DELETED_MEMBER, {
					member = var_5_3
				})

				var_5_1 = true
			elseif var_5_0.member[var_5_2.id] then
				var_5_0:updateMember(var_5_2)
			else
				var_5_0:addMember(var_5_2)
				self:sendNotification(GuildProxy.ON_ADDED_MEMBER, {
					member = var_5_2
				})
			end
		end

		for iter_5_2, iter_5_3 in ipairs(arg_5_0.log_list) do
			local var_5_4 = GuildLogInfo.New(iter_5_3)

			var_5_0:addLog(var_5_4)
			self:sendNotification(GuildProxy.LOG_ADDED, Clone(var_5_4))
		end

		var_5_0:setMemberCount(table.getCount(var_5_0.member or {}))
		self:updateGuild(var_5_0)

		if var_5_1 then
			self:sendNotification(GuildProxy.ON_EXIST_DELETED_MEMBER)
		end

		return
	end)
	self:on(0, function(arg_6_0)
		local var_6_0 = self:getData()

		if not var_6_0 then
			return
		end

		var_6_0:updateExp(arg_6_0.exp)
		var_6_0:updateLevel(arg_6_0.lv)
		self:updateGuild(var_6_0)

		return
	end)
	self:on(60008, function(arg_7_0)
		local var_7_0 = self.data:warpChatInfo(arg_7_0.chat)

		if var_7_0 then
			self:AddNewMsg(var_7_0)
		end

		return
	end)
	self:on(62004, function(arg_8_0)
		local var_8_0 = self:getData()

		if not var_8_0 or not var_8_0:IsCompletion() then
			return
		end

		var_8_0:updateWeeklyTask((GuildTask.New(arg_8_0.this_weekly_tasks)))
		var_8_0:setWeeklyTaskFlag(0)
		self:updateGuild(var_8_0)
		self:sendNotification(GuildProxy.WEEKLYTASK_ADDED)

		return
	end)
	self:on(62005, function(arg_9_0)
		local var_9_0 = self:getData()

		if not var_9_0 or not var_9_0:IsCompletion() then
			return
		end

		var_9_0:startSupply(arg_9_0.benefit_finish_time)
		var_9_0:consumeCapital((var_9_0:getSupplyConsume()))
		self:updateGuild(var_9_0)
		self:sendNotification(GuildProxy.CAPITAL_UPDATED)
		self:sendNotification(GuildProxy.SUPPLY_STARTED)

		return
	end)
	self:on(62018, function(arg_10_0)
		local var_10_0 = self:getData()

		if not var_10_0 or not var_10_0:IsCompletion() then
			return
		end

		local var_10_1 = pg.guild_technology_template[arg_10_0.id].group
		local var_10_2 = var_10_0:getActiveTechnologyGroup()

		if var_10_2 then
			var_10_2:Stop()
		end

		var_10_0:getTechnologyGroupById(var_10_1):Start()
		var_10_0:UpdateTechCancelCnt()
		self:updateGuild(var_10_0)
		self:sendNotification(GuildProxy.TECHNOLOGY_START)

		return
	end)
	self:on(62019, function(arg_11_0)
		local var_11_0 = self:getData()

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
			self:updateGuild(var_11_0)
			self:sendNotification(GuildProxy.DONATE_UPDTAE)
		end

		if var_11_2 then
			self:sendNotification(GuildProxy.CAPITAL_UPDATED)
		end

		if not var_11_2 and var_11_4 == var_11_5 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_donate_capital_toplimit"))
		end

		if not var_11_3 and var_11_4 == var_11_5 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_donate_techpoint_toplimit"))
		end

		return
	end)
	self:on(62031, function(arg_12_0)
		local var_12_0 = self:getData()

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
			self:updateGuild(var_12_0)
			self:sendNotification(GuildProxy.ON_DONATE_LIST_UPDATED)
		else
			local var_12_2 = self:GetPublicGuild()

			if var_12_2 then
				var_12_2:ResetDonateCnt()
				var_12_2:UpdateDonateTasks(var_12_1)
				self:sendNotification(GAME.PUBLIC_GUILD_REFRESH_DONATE_LIST_DONE)
			end
		end

		return
	end)
	self:on(61021, function(arg_13_0)
		self.refreshActivationEventTime = 0

		if arg_13_0.user_id ~= getProxy(PlayerProxy):getData().id then
			self:sendNotification(GuildProxy.GUILD_BATTLE_STARTED)
		end

		return
	end)

	return
end

function GuildProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_15_0)
			local var_15_0 = self:getRawData()

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

				self:updateGuild(var_15_0)
			end

			if self:GetPublicGuild() then
				onDelayTick(function()
					self:sendNotification(GAME.GET_PUBLIC_GUILD_USER_DATA, {
						flag = true
					})

					return
				end, math.random(2, 5))
			end

			return
		end
	}
end

function GuildProxy:AddPublicGuild(arg_17_1)
	self.publicGuild = arg_17_1

	return
end

function GuildProxy:GetPublicGuild()
	return self.publicGuild
end

function GuildProxy:Init()
	self.data = nil
	self.chatMsgs = {}
	self.bossRanks = {}
	self.isGetChatMsg = false
	self.refreshActivationEventTime = 0
	self.nextRequestBattleRankTime = 0
	self.refreshBossTime = 0
	self.bossRankUpdateTime = 0
	self.isFetchAssaultFleet = false
	self.battleRanks = {}
	self.ranks = {}
	self.requests = nil
	self.rankUpdateTime = 0
	self.requestReportTime = 0
	self.newChatMsgCnt = 0
	self.requestCount = 0
	self.cdTime = {
		0,
		0
	}

	return
end

function GuildProxy:AddNewMsg(arg_20_1)
	self.newChatMsgCnt = self.newChatMsgCnt + 1

	self:addMsg(arg_20_1)
	self:sendNotification(GuildProxy.NEW_MSG_ADDED, arg_20_1)

	return
end

function GuildProxy:ResetRequestCount()
	self.requestCount = 0

	return
end

function GuildProxy:UpdatePosCdTime(arg_22_1, arg_22_2)
	self.cdTime[arg_22_1] = arg_22_2

	return
end

function GuildProxy:GetNextCanFormationTime(arg_23_1)
	return (self.cdTime[arg_23_1] or 0) + pg.guildset.operation_assault_team_cd.key_value
end

function GuildProxy:CanFormationPos(arg_24_1)
	return self:GetNextCanFormationTime(arg_24_1) <= pg.TimeMgr.GetInstance():GetServerTime()
end

function GuildProxy:ClearNewChatMsgCnt()
	self.newChatMsgCnt = 0

	return
end

function GuildProxy:GetNewChatMsgCnt()
	return self.newChatMsgCnt
end

function GuildProxy:setRequestList(arg_27_1)
	self.requests = arg_27_1

	return
end

function GuildProxy:addGuild(arg_28_1)
	assert(isa(arg_28_1, Guild), "guild should instance of Guild")

	self.data = arg_28_1

	self:sendNotification(GuildProxy.NEW_GUILD_ADDED, Clone(arg_28_1))

	return
end

function GuildProxy:updateGuild(arg_29_1)
	assert(isa(arg_29_1, Guild), "guild should instance of Guild")

	self.data = arg_29_1

	self:sendNotification(GuildProxy.GUILD_UPDATED, Clone(arg_29_1))

	return
end

function GuildProxy:exitGuild()
	self:Init()
	self:sendNotification(GuildProxy.EXIT_GUILD)
	pg.ShipFlagMgr.GetInstance():ClearShipsFlag("inGuildEvent")
	pg.ShipFlagMgr.GetInstance():ClearShipsFlag("inGuildBossEvent")

	return
end

function GuildProxy:getRequests()
	return self.requests
end

function GuildProxy:getSortRequest()
	if not self.requests then
		return nil
	end

	local var_32_0 = {}

	for iter_32_0, iter_32_1 in pairs(self.requests) do
		table.insert(var_32_0, iter_32_1)
	end

	return var_32_0
end

function GuildProxy:deleteRequest(arg_33_1)
	if not self.requests then
		return
	end

	self.requests[arg_33_1] = nil

	self:sendNotification(GuildProxy.REQUEST_DELETED, arg_33_1)

	return
end

function GuildProxy:addMsg(arg_34_1)
	table.insert(self.chatMsgs, arg_34_1)

	if #self.chatMsgs > GuildConst.CHAT_LOG_MAX_COUNT then
		table.remove(self.chatMsgs, 1)
	end

	return
end

function GuildProxy:getChatMsgs()
	return self.chatMsgs
end

function GuildProxy:GetMessagesByUniqueId(arg_36_1)
	return _.select(self.chatMsgs, function(arg_37_0)
		return arg_37_0.uniqueId == arg_36_1
	end)
end

function GuildProxy:UpdateMsg(arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(self.chatMsgs) do
		if iter_38_1:IsSame(arg_38_1.uniqueId) then
			self.data[iter_38_0] = arg_38_1
		end
	end

	return
end

function GuildProxy:ShouldFetchActivationEvent()
	return pg.TimeMgr.GetInstance():GetServerTime() > self.refreshActivationEventTime
end

function GuildProxy:AddFetchActivationEventCDTime()
	self.refreshActivationEventTime = GuildConst.REFRESH_ACTIVATION_EVENT_TIME + pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function GuildProxy:AddActivationEventTimer(arg_41_1)
	return
end

function GuildProxy:RemoveActivationEventTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function GuildProxy:remove()
	self:RemoveActivationEventTimer()

	return
end

function GuildProxy:SetRank(arg_44_1, arg_44_2)
	self.ranks[arg_44_1] = arg_44_2
	self["rankTimer" .. arg_44_1] = pg.TimeMgr.GetInstance():GetServerTime() + 8

	return
end

function GuildProxy:GetRanks()
	return self.ranks
end

function GuildProxy:ShouldRefreshRank(arg_46_1)
	if self["rankTimer" .. arg_46_1] then
		if pg.TimeMgr.GetInstance():GetServerTime() >= self["rankTimer" .. arg_46_1] then
			return true
		end
	end

	return false
end

function GuildProxy:SetReports(arg_47_1)
	self.reports = arg_47_1

	return
end

function GuildProxy:GetReports()
	return self.reports or {}
end

function GuildProxy:GetReportById(arg_49_1)
	return self.reports[arg_49_1]
end

function GuildProxy:AddReport(arg_50_1)
	self.reports = self.reports or {}
	self.reports[arg_50_1.id] = arg_50_1

	return
end

function GuildProxy:GetMaxReportId()
	local var_51_0 = 0

	for iter_51_0, iter_51_1 in pairs((self:GetReports())) do
		if var_51_0 < iter_51_1.id then
			var_51_0 = iter_51_1.id
		end
	end

	return var_51_0
end

function GuildProxy:AnyRepoerCanGet()
	return #self:GetCanGetReports() > 0
end

function GuildProxy:GetCanGetReports()
	local var_53_0 = {}

	for iter_53_0, iter_53_1 in pairs((self:GetReports())) do
		if iter_53_1:CanSubmit() then
			table.insert(var_53_0, iter_53_1.id)
		end
	end

	return var_53_0
end

function GuildProxy:ShouldRequestReport()
	self.requestReportTime = self.requestReportTime or 0

	local function var_54_0()
		local var_55_0 = self:getRawData():GetActiveEvent()

		if var_55_0 and var_55_0:GetMissionFinishCnt() > 0 then
			return true
		end

		return false
	end

	local var_54_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if not self.reports and var_54_0() or var_54_1 > self.requestReportTime then
		self.requestReportTime = var_54_1 + GuildConst.REQUEST_REPORT_CD

		return true
	end

	return false
end

function GuildProxy:ShouldRequestForamtion()
	self.requestFormationTime = self.requestFormationTime or 0

	local var_56_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_56_0 > self.requestFormationTime then
		self.requestFormationTime = var_56_0 + GuildConst.REQUEST_FORMATION_CD

		return true
	end

	return false
end

function GuildProxy:GetRecommendShipsForMission(arg_57_1)
	if arg_57_1:IsEliteType() then
		return self:GetRecommendShipsForEliteMission(arg_57_1)
	else
		local var_57_0 = {}
		local var_57_1 = {}

		for iter_57_0, iter_57_1 in pairs((getProxy(BayProxy):getRawData())) do
			table.insert(var_57_1, {
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

		local var_57_2 = arg_57_1:GetRecommendShipNation()
		local var_57_3 = arg_57_1:GetRecommendShipTypes()

		table.sort(var_57_1, CompareFuncs({
			function(arg_59_0)
				return table.contains(var_57_2, arg_59_0.nation) and 0 or 1
			end,
			function(arg_60_0)
				return table.contains(var_57_3, arg_60_0.type) and 0 or 1
			end,
			function(arg_61_0)
				return -arg_61_0.level
			end,
			function(arg_62_0)
				return -arg_62_0.power
			end
		}))

		for iter_57_2, iter_57_3 in ipairs(var_57_1) do
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

function GuildProxy:GetRecommendShipsForEliteMission(arg_63_1)
	assert(arg_63_1:IsEliteType())

	local var_63_0 = {}
	local var_63_2 = {}
	local var_63_3 = {}

	for iter_63_0, iter_63_1 in pairs((getProxy(BayProxy):getRawData())) do
		local var_63_4 = {
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

		if arg_63_1:SameSquadron(var_63_4) then
			table.insert(var_63_2, var_63_4)
		else
			table.insert(var_63_3, var_63_4)
		end
	end

	local function var_63_5(arg_65_0)
		if arg_65_0 and not table.contains(var_63_0, arg_65_0.id) and GuildEventMediator.OnCheckMissionShip(arg_63_1.id, var_63_0, arg_65_0) then
			table.insert(var_63_0, arg_65_0.id)
		end

		return
	end

	local var_63_6 = arg_63_1:GetEffectAttr()
	local var_63_7 = CompareFuncs({
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
			return -(arg_69_0.attrs[var_63_6] or 0)
		end,
		function(arg_70_0)
			return -arg_70_0.level
		end,
		function(arg_71_0)
			return -arg_71_0.power
		end
	})
	local var_63_8 = arg_63_1:GetSquadronTargetCnt()

	if #var_63_2 > 0 and var_63_8 > 0 then
		table.sort(var_63_2, var_63_7)

		for iter_63_2 = 1, var_63_8 do
			var_63_5(var_63_2[iter_63_2])
		end
	end

	if #var_63_0 < 4 and #var_63_3 > 0 then
		table.sort(var_63_3, var_63_7)

		for iter_63_3 = 1, #var_63_3 do
			if #var_63_0 == 4 then
				break
			end

			var_63_5(var_63_3[iter_63_3])
		end
	end

	if #var_63_0 < 4 and var_63_8 > 0 and var_63_8 < #var_63_2 then
		for iter_63_4 = var_63_8 + 1, #var_63_2 do
			if #var_63_0 == 4 then
				break
			end

			var_63_5(var_63_2[iter_63_4])
		end
	end

	return var_63_0
end

function GuildProxy:ShouldShowApplyTip()
	if self.data and GuildMember.IsAdministrator(self.data:getSelfDuty()) then
		if not self.requests then
			return self.requestCount > 0
		end

		return table.getCount(self.requests) + self.requestCount > 0
	end

	return false
end

function GuildProxy:ShouldShowBattleTip()
	local var_73_0 = self:getData()
	local var_73_1 = false

	if var_73_0 then
		local var_73_2 = var_73_0:GetActiveEvent()

		var_73_1 = self:ShouldShowMainTip() or not var_73_2 and GuildMember.IsAdministrator(var_73_0:getSelfDuty()) and var_73_0:ShouldTipActiveEvent() and (function()
			for iter_75_0, iter_75_1 in ipairs(pg.guild_operation_template.all) do
				if var_73_0.level >= pg.guild_operation_template[iter_75_1].unlock_guild_level and var_73_0:getCapital() >= pg.guild_operation_template[iter_75_1].consume then
					return true
				end
			end

			return false
		end)() or var_73_2 and not self:GetBattleBtnRecord()

		if var_73_2 and not var_73_1 then
			local var_73_3 = var_73_2:IsParticipant()

			var_73_1 = var_73_3 and var_73_2:AnyMissionCanFormation() or (function(arg_74_0)
				if arg_74_0 and arg_74_0:IsParticipant() then
					local var_74_0 = arg_74_0:GetBossMission()

					return var_74_0 and var_74_0:IsActive() and var_74_0:CanEnterBattle()
				end

				return false
			end)(var_73_2) or not var_73_3 and not var_73_2:IsLimitedJoin()
		end
	end

	return var_73_1
end

function GuildProxy:SetBattleBtnRecord()
	if not self:GetBattleBtnRecord() then
		local var_76_0 = self:getRawData()

		if var_76_0 and var_76_0:GetActiveEvent() then
			PlayerPrefs.SetInt("guild_battle_btn_flag" .. getProxy(PlayerProxy):getRawData().id, 1)
			PlayerPrefs.Save()
			self:sendNotification(GuildProxy.BATTLE_BTN_FLAG_CHANGE)
		end
	end

	return
end

function GuildProxy:GetBattleBtnRecord()
	return PlayerPrefs.GetInt("guild_battle_btn_flag" .. getProxy(PlayerProxy):getRawData().id, 0) > 0
end

function GuildProxy:ShouldShowMainTip()
	return _.any(self.reports or {}, function(arg_80_0)
		return arg_80_0:CanSubmit()
	end) and not (function()
		return self.data:getMemberById(getProxy(PlayerProxy):getRawData().id):IsRecruit()
	end)()
end

function GuildProxy:ShouldShowTip()
	local var_81_0 = {}
	local var_81_1 = self:getData()

	if var_81_1 then
		table.insert(var_81_0, var_81_1:ShouldShowDonateTip())
		table.insert(var_81_0, self:ShouldShowApplyTip())
		table.insert(var_81_0, var_81_1:ShouldWeeklyTaskTip())
		table.insert(var_81_0, var_81_1:ShouldShowSupplyTip())
		table.insert(var_81_0, var_81_1:ShouldShowTechTip())

		if not LOCK_GUILD_BATTLE then
			table.insert(var_81_0, self:ShouldShowBattleTip())
		end
	end

	return #var_81_0 > 0 and _.any(var_81_0, function(arg_82_0)
		return arg_82_0 == true
	end)
end

function GuildProxy:SetRefreshBossTime(arg_83_1)
	self.refreshBossTime = arg_83_1 + GuildConst.REFRESH_BOSS_TIME

	return
end

function GuildProxy:ShouldRefreshBoss()
	local var_84_0 = self:getRawData():GetActiveEvent()
	local var_84_1

	if var_84_0 and not var_84_0:IsExpired() then
		::label_84_0::

		var_84_1 = pg.TimeMgr.GetInstance():GetServerTime() >= self.refreshBossTime
	end

	return var_84_1
end

function GuildProxy:ResetRefreshBossTime()
	self.refreshBossTime = 0

	return
end

function GuildProxy:ShouldRefreshBossRank()
	return self:getRawData():GetActiveEvent() and pg.TimeMgr.GetInstance():GetServerTime() - self.bossRankUpdateTime >= GuildConst.REFRESH_MISSION_BOSS_RANK_TIME
end

function GuildProxy:UpdateBossRank(arg_87_1)
	self.bossRanks = arg_87_1

	return
end

function GuildProxy:GetBossRank()
	return self.bossRanks
end

function GuildProxy:ResetBossRankTime()
	self.rankUpdateTime = 0

	return
end

function GuildProxy:UpdateBossRankRefreshTime(arg_90_1)
	self.rankUpdateTime = arg_90_1

	return
end

function GuildProxy:GetAdditionGuild()
	if self.data == nil then
		return self.publicGuild
	else
		return self.data
	end

	return
end

function GuildProxy:SetReportRankList(arg_92_1, arg_92_2)
	self.reportRankList = self.reportRankList or {}
	self.reportRankList[arg_92_1] = arg_92_2

	return
end

function GuildProxy:GetReportRankList(arg_93_1)
	if self.reportRankList then
		return self.reportRankList[arg_93_1]
	end

	return nil
end

return GuildProxy
