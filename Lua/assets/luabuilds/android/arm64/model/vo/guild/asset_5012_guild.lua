local Guild = class("Guild", import(".base.BaseGuild"))
local var_0_1 = pg.guild_technology_template
local var_0_2 = pg.guild_operation_template

function Guild:Ctor(arg_1_1)
	self.member = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.member or {}) do
		local var_1_0 = GuildMember.New(iter_1_1)

		self.member[var_1_0.id] = var_1_0
	end

	self.logInfo = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.log or {}) do
		table.insert(self.logInfo, (GuildLogInfo.New(iter_1_3)))
	end

	self.events = {}

	for iter_1_4, iter_1_5 in ipairs(var_0_2.all) do
		table.insert(self.events, GuildEvent.New({
			id = iter_1_5
		}))
	end

	self:updateBaseInfo(arg_1_1)
	self:updateExtraInfo(arg_1_1)
	self:updateUserInfo({})

	self.completion = false

	return
end

function Guild:updateBaseInfo(arg_2_1)
	local var_2_0 = arg_2_1.base or {}

	self.id = var_2_0.id
	self.policy = var_2_0.policy
	self.faction = var_2_0.faction
	self.name = var_2_0.name
	self.manifesto = var_2_0.manifesto
	self.level = var_2_0.level or 1
	self.memberCount = var_2_0.member_count or 1
	self.announce = var_2_0.announce or ""
	self.exp = var_2_0.exp or 0
	self.changeFactionTime = var_2_0.change_faction_cd or 0
	self.kickLeaderTime = var_2_0.kick_leader_cd or 0

	return
end

function Guild:updateExtraInfo(arg_3_1)
	local var_3_0 = arg_3_1.guild_ex or {}

	self.capital = var_3_0.capital or 0

	self:updateWeeklyTask((GuildTask.New(var_3_0.this_weekly_tasks or {})))

	self.benefitFinishTime = var_3_0.benefit_finish_time or 0
	self.lastBenefitFinishTime = var_3_0.last_benefit_finish_time or 0
	self.technologyGroups = {}

	for iter_3_0, iter_3_1 in pairs(var_0_1.get_id_list_by_group) do
		local var_3_1 = GuildTechnologyGroup.New({
			id = iter_3_0
		})

		self.technologyGroups[var_3_1.id] = var_3_1
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_0.technologys or {}) do
		self.technologyGroups[var_0_1[iter_3_3.id].group]:update(iter_3_3)
	end

	self.maxMemberCntAddition = 0
	self.capitalLogs = {}
	self.requestCapitalLogTime = 0
	self.retreatCnt = var_3_0.retreat_cnt or 0
	self.techCancelCnt = var_3_0.tech_cancel_cnt or 0
	self.activeEventCnt = var_3_0.active_event_cnt or 0
	self.tipActiveEventCnt = pg.guildset.operation_monthly_time.key_value

	return
end

function Guild:SetMaxMemberCntAddition(arg_4_1)
	self.maxMemberCntAddition = arg_4_1

	return
end

function Guild:updateUserInfo(arg_5_1)
	local var_5_0 = arg_5_1.user_info or {}

	self.donateCount = var_5_0.donate_count or 0

	if var_5_0.benefit_time and var_5_0.benefit_time > 0 then
		self.benefitTime = var_5_0.benefit_time or 0
	end

	self.weeklyTaskFlag = var_5_0.weekly_task_flag or 0

	self:setRefreshWeeklyTaskProgressTime()

	self.refreshCaptialTime = 0
	self.donateTasks = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0.donate_tasks or {}) do
		table.insert(self.donateTasks, (GuildDonateTask.New({
			id = iter_5_1
		})))
	end

	self.technologys = {}

	for iter_5_2, iter_5_3 in pairs(var_0_1.get_id_list_by_group) do
		self.technologys[iter_5_2] = GuildTechnology.New(self.technologyGroups[iter_5_2])
	end

	for iter_5_4, iter_5_5 in ipairs(var_5_0.tech_id or {}) do
		self.technologys[var_0_1[iter_5_5].group]:Update(iter_5_5, self.technologyGroups[var_0_1[iter_5_5].group])
	end

	self.extraDonateCnt = var_5_0.extra_donate or 0
	self.extraBattleCnt = var_5_0.extra_operation or 0
	self.completion = true

	return
end

function Guild:IsCompletion()
	return self.completion
end

function Guild:AddExtraDonateCnt(arg_7_1)
	self.extraDonateCnt = self.extraDonateCnt + arg_7_1

	return
end

function Guild:ReduceExtraDonateCnt(arg_8_1)
	if self.extraDonateCnt <= 0 then
		return
	end

	assert(arg_8_1 <= self.extraDonateCnt)

	self.extraDonateCnt = self.extraDonateCnt - arg_8_1

	return
end

function Guild:GetExtraDonateCnt()
	return self.extraDonateCnt
end

function Guild:AddExtraBattleCnt(arg_10_1)
	self.extraBattleCnt = self.extraBattleCnt + arg_10_1

	return
end

function Guild:ReduceExtraBattleCnt(arg_11_1)
	if self.extraBattleCnt <= 0 then
		return
	end

	assert(arg_11_1 <= self.extraBattleCnt)

	self.extraBattleCnt = self.extraBattleCnt - arg_11_1

	return
end

function Guild:GetExtraBattleCnt()
	return self.extraBattleCnt
end

function Guild:StartTech(arg_13_1)
	self.technologyGroups[pg.guild_technology_template[arg_13_1].group]:Start()

	return
end

function Guild:GetEvents()
	return self.events
end

function Guild:GetEventById(arg_15_1)
	return _.detect(self.events, function(arg_16_0)
		return arg_16_0.id == arg_15_1
	end)
end

function Guild:GetActiveEvent()
	return _.detect(self.events, function(arg_18_0)
		return arg_18_0:IsActive()
	end)
end

function Guild:CanCancelTech()
	return self.techCancelCnt == 0
end

function Guild:UpdateTechCancelCnt()
	self.techCancelCnt = self.techCancelCnt + 1

	return
end

function Guild:ResetTechCancelCnt()
	self.techCancelCnt = 0

	return
end

function Guild:shouldRefreshCaptial()
	return self.refreshCaptialTime < pg.TimeMgr.GetInstance():GetServerTime()
end

function Guild:setRefreshCaptialTime()
	self.refreshCaptialTime = pg.TimeMgr.GetInstance():GetServerTime() + GuildConst.REFRESH_CAPITAL_TIME

	return
end

function Guild:shouldRefreshWeeklyTaskProgress()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.weeklyTaskNextRefreshTime
end

function Guild:setRefreshWeeklyTaskProgressTime()
	self.weeklyTaskNextRefreshTime = pg.TimeMgr.GetInstance():GetServerTime() + GuildConst.WEEKLY_TASK_PROGRESS_REFRESH_TIME

	return
end

function Guild:hasWeeklyTaskFlag()
	return self.weeklyTaskFlag ~= 0
end

function Guild:setWeeklyTaskFlag(arg_27_1)
	self.weeklyTaskFlag = arg_27_1

	return
end

function Guild:getTechnologyGroups()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(self.technologyGroups) do
		table.insert(var_28_0, iter_28_1)
	end

	return var_28_0
end

function Guild:getTechnologyGroupById(arg_29_1)
	return self.technologyGroups[arg_29_1]
end

function Guild:getActiveTechnologyGroup()
	for iter_30_0, iter_30_1 in pairs(self.technologyGroups) do
		if iter_30_1:isStarting() then
			return iter_30_1
		end
	end

	return
end

function Guild:GetTechnologys()
	return self.technologys
end

function Guild:getTechnologyById(arg_32_1)
	return self.technologys[arg_32_1]
end

function Guild:getTechnologys()
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(self.technologys) do
		table.insert(var_33_0, iter_33_1)
	end

	return var_33_0
end

function Guild:getSupplyConsume()
	local var_34_1 = math.ceil(self:getSupplyDuration() / 0)
end

function Guild:getSupplyAwardId()
	return pg.guildset.guild_award_id.key_value
end

function Guild:updateSupplyTime(arg_36_1)
	self.benefitTime = arg_36_1

	return
end

function Guild:getSupplyCnt()
	local var_37_0 = 0
	local var_37_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if self.benefitFinishTime > 0 then
		var_37_1 = math.min(self.benefitFinishTime, var_37_1)
	end

	local var_37_2 = self:getSupplyStartTime()

	var_37_0 = (self.benefitTime == 0 or var_37_2 > self.benefitTime) and math.ceil((var_37_1 - var_37_2) / 0) or math.floor(math.max(0, var_37_1 - self.benefitTime) / 0)

	local var_37_3 = self:getMemberById(getProxy(PlayerProxy):getRawData().id):GetJoinZeroTime()

	if self.lastBenefitFinishTime > 0 and self.lastBenefitFinishTime > self.benefitTime and var_37_3 <= self.lastBenefitFinishTime then
		var_37_0 = math.ceil((self.lastBenefitFinishTime - (self.benefitTime <= 0 and var_37_3 or self.benefitTime)) / 0) + var_37_0
	end

	return math.min(var_37_0, GuildConst.MAX_SUPPLY_CNT)
end

function Guild:startSupply(arg_38_1)
	self.benefitFinishTime = arg_38_1

	return
end

function Guild:GetSupplyEndTime()
	return self.benefitFinishTime
end

function Guild:getSupplyLeftCnt()
	return math.floor((self.benefitFinishTime - pg.TimeMgr.GetInstance():GetServerTime()) / 0)
end

function Guild:getSupplyDuration()
	return pg.guildset.guild_award_duration.key_value
end

function Guild:getSupplyStartTime()
	local var_42_0 = self.benefitFinishTime - self:getSupplyDuration() + 1
	local var_42_1 = self:getMemberById(getProxy(PlayerProxy):getRawData().id):GetJoinZeroTime()

	if var_42_0 < var_42_1 then
		return var_42_1
	else
		return var_42_0
	end

	return
end

function Guild:ExistSupply()
	local var_43_0

	if self.benefitFinishTime > 0 then
		if self.benefitFinishTime <= pg.TimeMgr.GetInstance():GetServerTime() then
			var_43_0 = false

			goto label_43_0
		end
	end

	::label_43_0::

	return true
end

function Guild:isOpenedSupply()
	local var_44_0

	if self.benefitFinishTime > 0 then
		if self.benefitFinishTime <= pg.TimeMgr.GetInstance():GetServerTime() and self:getSupplyCnt() <= 0 then
			var_44_0 = false

			goto label_44_0
		end
	end

	::label_44_0::

	return true
end

function Guild:getSelectableWeeklyTasks()
	local var_45_0 = {}

	if GuildMember.IsAdministrator(self:getSelfDuty()) then
		for iter_45_0, iter_45_1 in ipairs(pg.guild_mission_template.all) do
			table.insert(var_45_0, (GuildTask.New({
				progress = 0,
				id = iter_45_1
			})))
		end
	end

	return var_45_0
end

function Guild:shouldRequestCapitalLog()
	if pg.TimeMgr.GetInstance():GetServerTime() - self.requestCapitalLogTime > GuildConst.REQUEST_LOG_TIME then
		return true
	end

	return false
end

function Guild:updateCapitalLogs(arg_47_1)
	self.capitalLogs = arg_47_1
	self.requestCapitalLogTime = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function Guild:getCapitalLogs()
	return self.capitalLogs
end

function Guild:getMaxDonateCnt()
	return pg.guildset.contribution_task_num.key_value
end

function Guild:getRemainDonateCnt()
	return self:getMaxDonateCnt() - self.donateCount
end

function Guild:updateDonateCount()
	if self:getRemainDonateCnt() > 0 then
		self.donateCount = self.donateCount + 1
	else
		self:ReduceExtraDonateCnt(1)
	end

	return
end

function Guild:canDonate()
	return self:getRemainDonateCnt() > 0 or self.extraDonateCnt > 0
end

function Guild:getDonateTasks()
	return self.donateTasks
end

function Guild:updateDonateTasks(arg_54_1)
	self.donateTasks = arg_54_1

	return
end

function Guild:getDonateTaskById(arg_55_1)
	return _.detect(self.donateTasks, function(arg_56_0)
		return arg_56_0.id == arg_55_1
	end)
end

function Guild:updateWeeklyTask(arg_57_1)
	self.weeklyTask = arg_57_1

	return
end

function Guild:getWeeklyTask()
	return self.weeklyTask
end

function Guild:GetActiveWeeklyTask()
	if self.weeklyTask and self.weeklyTask.id ~= 0 then
		return self.weeklyTask
	end

	return nil
end

function Guild:addCapital(arg_60_1)
	self:updateCapital(self.capital + arg_60_1)

	return
end

function Guild:updateCapital(arg_61_1)
	self.capital = arg_61_1

	return
end

function Guild:consumeCapital(arg_62_1)
	self:updateCapital(self.capital - arg_62_1)

	return
end

function Guild:getCapital()
	return self.capital
end

function Guild:setkickLeaderTime(arg_64_1)
	self.kickLeaderTime = arg_64_1

	return
end

function Guild:getKickLeftTime()
	return self.kickLeaderTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function Guild:inKickTime()
	return self.kickLeaderTime ~= 0
end

function Guild:getAssistantMaxCount()
	return pg.guild_data_level[self.level].assistant_commander
end

function Guild:getAssistantCount()
	local var_68_0 = 0

	for iter_68_0, iter_68_1 in pairs(self.member) do
		if iter_68_1.duty == GuildConst.DUTY_DEPUTY_COMMANDER then
			var_68_0 = var_68_0 + 1
		end
	end

	return var_68_0
end

function Guild:setMemberCount(arg_69_1)
	self.memberCount = arg_69_1

	return
end

function Guild:getSortMember()
	local var_70_0 = {}

	for iter_70_0, iter_70_1 in pairs(self.member) do
		table.insert(var_70_0, iter_70_1)
	end

	return var_70_0
end

function Guild:getSortMemberWithoutSelf()
	local var_71_0 = {}
	local var_71_1 = getProxy(PlayerProxy):getRawData().id

	for iter_71_0, iter_71_1 in pairs(self.member) do
		if iter_71_1.id ~= var_71_1 then
			table.insert(var_71_0, iter_71_1)
		end
	end

	return var_71_0
end

function Guild:getBgName()
	if self.faction == GuildConst.FACTION_TYPE_BLHX then
		return "bg/bg_guild_blue_n"
	elseif self.faction == GuildConst.FACTION_TYPE_CSZZ then
		return "bg/bg_guild_red_n"
	end

	return
end

function Guild:addLog(arg_73_1)
	table.insert(self.logInfo, 1, arg_73_1)

	if #self.logInfo > 100 then
		table.remove(self.logInfo, #self.logInfo)
	end

	return
end

function Guild:getLogs()
	return self.logInfo
end

function Guild:getMemberById(arg_75_1)
	return self.member[arg_75_1]
end

function Guild:updateMember(arg_76_1)
	self.member[arg_76_1.id] = arg_76_1

	return
end

function Guild:addMember(arg_77_1)
	self.member[arg_77_1.id] = arg_77_1

	return
end

function Guild:deleteMember(arg_78_1)
	self.member[arg_78_1] = nil

	return
end

function Guild:getDutyByMemberId(arg_79_1)
	for iter_79_0, iter_79_1 in pairs(self.member) do
		if iter_79_1.id == arg_79_1 then
			return iter_79_1.duty
		end
	end

	return
end

function Guild:setId(arg_80_1)
	self.id = arg_80_1

	return
end

function Guild:setName(arg_81_1)
	self.name = arg_81_1

	return
end

function Guild:getPolicyName()
	return GuildConst.POLICY_NAME[self.policy]
end

function Guild:getFactionName()
	return GuildConst.FACTION_NAME[self.faction]
end

function Guild:getName()
	return self.name
end

function Guild:setPolicy(arg_85_1)
	self.policy = arg_85_1

	return
end

function Guild:getPolicy()
	return self.policy
end

function Guild:setFaction(arg_87_1)
	self.faction = arg_87_1

	return
end

function Guild:getFaction()
	return self.faction
end

function Guild:setManifesto(arg_89_1)
	self.manifesto = arg_89_1

	return
end

function Guild:getManifesto()
	return self.manifesto or ""
end

function Guild:inChangefactionTime()
	if self.changeFactionTime ~= 0 and self.changeFactionTime - pg.TimeMgr.GetInstance():GetServerTime() >= 0 then
		return true
	end

	return
end

function Guild:changeFactionLeftTime()
	return pg.TimeMgr.GetInstance():parseTimeFrom(self.changeFactionTime - pg.TimeMgr.GetInstance():GetServerTime())
end

function Guild:getLevelMaxExp()
	if not pg.guild_data_level[self.level] then
		return pg.guild_data_level[pg.guild_data_level.all[#pg.guild_data_level.all]].exp
	else
		return pg.guild_data_level[self.level].exp
	end

	return
end

function Guild:getMaxMember()
	return pg.guild_data_level[math.min(self.level, pg.guild_data_level.all[#pg.guild_data_level.all])].member_num + self:GetGuildMemberCntAddition() + (self.maxMemberCntAddition or 0)
end

function Guild:updateExp(arg_95_1)
	self.exp = arg_95_1

	return
end

function Guild:updateLevel(arg_96_1)
	self.level = arg_96_1

	return
end

function Guild:getCommader()
	for iter_97_0, iter_97_1 in pairs(self.member) do
		if iter_97_1.duty == GuildConst.DUTY_COMMANDER then
			return iter_97_1
		end
	end

	return
end

function Guild:getCommaderName()
	local var_98_0 = self:getCommader()

	if var_98_0 then
		return var_98_0.name
	else
		return ""
	end

	return
end

function Guild:setAnnounce(arg_99_1)
	self.announce = arg_99_1

	return
end

function Guild:GetAnnounce()
	return self.announce
end

function Guild:getEnableDuty(arg_101_1, arg_101_2)
	if arg_101_2 == GuildConst.DUTY_RECRUIT then
		return {}
	end

	local var_101_0 = {}

	if arg_101_1 == GuildConst.DUTY_COMMANDER then
		var_101_0 = self:getAssistantMaxCount() == self:getAssistantCount() and (arg_101_2 == GuildConst.DUTY_DEPUTY_COMMANDER and {
			GuildConst.DUTY_COMMANDER,
			GuildConst.DYTY_PICKED,
			GuildConst.DUTY_ORDINARY
		} or {
			GuildConst.DYTY_PICKED,
			GuildConst.DUTY_ORDINARY
		}) or arg_101_2 == GuildConst.DUTY_DEPUTY_COMMANDER and {
			GuildConst.DUTY_COMMANDER,
			GuildConst.DUTY_DEPUTY_COMMANDER,
			GuildConst.DYTY_PICKED,
			GuildConst.DUTY_ORDINARY
		} or {
			GuildConst.DUTY_DEPUTY_COMMANDER,
			GuildConst.DYTY_PICKED,
			GuildConst.DUTY_ORDINARY
		}
	elseif arg_101_1 == GuildConst.DUTY_DEPUTY_COMMANDER then
		var_101_0 = {
			GuildConst.DYTY_PICKED,
			GuildConst.DUTY_ORDINARY
		}
	end

	for iter_101_0, iter_101_1 in ipairs(var_101_0) do
		if iter_101_1 == arg_101_2 then
			table.remove(var_101_0, iter_101_0)

			break
		end
	end

	return var_101_0
end

function Guild:warpChatInfo(arg_102_1)
	local var_102_0, var_102_1 = wordVer(arg_102_1.content, {
		isReplace = true
	})
	local var_102_2 = GuildMember.New(arg_102_1.player)

	if var_102_2 then
		local var_102_3 = self:getDutyByMemberId(var_102_2.id)

		assert(var_102_3, "palyer duty has not been found" .. var_102_2.id)
		var_102_2:setDuty(var_102_3)

		local var_102_4

		string.gsub(var_102_1, ChatConst.EmojiCodeMatch, function(arg_103_0)
			var_102_4 = tonumber(arg_103_0)

			return
		end)

		if var_102_4 then
			if pg.emoji_template[var_102_4] then
				var_102_1 = pg.emoji_template[var_102_4].desc
			else
				var_102_4 = nil
			end
		end

		return (ChatMsg.New(ChatConst.ChannelGuild, {
			player = var_102_2,
			content = var_102_1,
			emojiId = var_102_4,
			timestamp = arg_102_1.time
		}))
	end

	return
end

function Guild:getSelfDuty()
	return self:getDutyByMemberId(getProxy(PlayerProxy):getRawData().id)
end

function Guild:GetOfficePainting()
	local var_105_0 = self:getFaction()

	if var_105_0 == GuildConst.FACTION_TYPE_BLHX then
		return "guild_office_blue"
	elseif var_105_0 == GuildConst.FACTION_TYPE_CSZZ then
		return "guild_office_red"
	end

	return
end

function Guild:ShouldShowDonateTip()
	return self:getMaxDonateCnt() > self.donateCount
end

function Guild:ShouldWeeklyTaskTip()
	return GuildTask.STATE_EMPTY == self.weeklyTask:getState() and GuildMember.IsAdministrator(self:getSelfDuty())
end

function Guild:ShouldShowOfficeTip()
	return self:ShouldShowDonateTip() or self:ShouldWeeklyTaskTip() or self:ShouldShowSupplyTip()
end

function Guild:ShouldShowTechTip()
	local var_109_0 = self:getActiveTechnologyGroup()

	return var_109_0 and var_109_0:isMaxLevel() and not self:IsFinishAllTechnologyGroup()
end

function Guild:IsFinishAllTechnologyGroup()
	for iter_110_0, iter_110_1 in pairs(self.technologyGroups) do
		if not iter_110_1:isMaxLevel() then
			return false
		end
	end

	return true
end

function Guild:ShouldShowSupplyTip()
	return self:isOpenedSupply() and self:getSupplyCnt() > 0 and (function()
		local var_112_0 = self:getMemberById(getProxy(PlayerProxy):getRawData().id)

		return not var_112_0:IsRecruit() and not var_112_0:isNewMember()
	end)()
end

function Guild:GetMembers()
	return self.member
end

function Guild:GetAllAssaultShip()
	local var_114_0 = {}

	for iter_114_0, iter_114_1 in pairs(self.member) do
		for iter_114_2, iter_114_3 in ipairs((iter_114_1:GetAssaultFleet():GetShipList())) do
			table.insert(var_114_0, iter_114_3)
		end
	end

	return var_114_0
end

function Guild:GetRecomForBossEvent(arg_115_1, arg_115_2, arg_115_3)
	local var_115_0 = {}

	for iter_115_0, iter_115_1 in pairs(self.member) do
		if not table.contains(arg_115_3, iter_115_1.id) then
			local var_115_1 = iter_115_1:GetAssaultFleet():GetStrongestShip(arg_115_1)

			if var_115_1 then
				table.insert(var_115_0, var_115_1)
			end
		end
	end

	table.sort(var_115_0, function(arg_116_0, arg_116_1)
		return arg_116_0.level > arg_116_1.level
	end)

	return _.slice(var_115_0, 1, math.min(arg_115_2, #var_115_0))
end

function Guild:GetMemberShips(arg_117_1)
	local var_117_0 = {}
	local var_117_1 = {}
	local var_117_2 = getProxy(PlayerProxy):getRawData().id

	local function var_117_3(arg_118_0)
		return var_117_2 == arg_118_0.id
	end

	for iter_117_0, iter_117_1 in pairs(self.member) do
		local var_117_4 = iter_117_1:GetShip()
		local var_117_5 = iter_117_1:IsCommander()

		var_117_4.isCommander = var_117_5

		if var_117_5 or var_117_3(iter_117_1) then
			table.insert(var_117_1, var_117_4)
		else
			table.insert(var_117_0, var_117_4)
		end
	end

	for iter_117_2 = 1, arg_117_1 do
		if #var_117_1 == arg_117_1 then
			break
		end

		if var_117_0[iter_117_2] then
			table.insert(var_117_1, var_117_0[iter_117_2])
		end
	end

	return var_117_1
end

function Guild:IsAdministrator()
	return GuildMember.IsAdministrator(self:getSelfDuty())
end

function Guild:GetMissionAndAssultFleetShips()
	local var_120_0 = {}
	local var_120_1 = self:GetActiveEvent()

	if var_120_1 and not var_120_1:IsExpired() then
		for iter_120_0, iter_120_1 in ipairs((var_120_1:GetJoinShips())) do
			table.insert(var_120_0, iter_120_1)
		end
	end

	local var_120_2 = getProxy(PlayerProxy)
	local var_120_3 = self.member[var_120_2:getRawData().id]

	for iter_120_2, iter_120_3 in pairs((var_120_3:GetAssaultFleet().GetShipList(var_120_2))) do
		table.insert(var_120_0, (GuildAssaultFleet.GetRealId(iter_120_3.id)))
	end

	for iter_120_4, iter_120_5 in pairs((var_120_3:GetExternalAssaultFleet():GetShipList())) do
		table.insert(var_120_0, (GuildAssaultFleet.GetRealId(iter_120_5.id)))
	end

	return var_120_0
end

function Guild:GetBossMissionShips()
	local var_121_0 = {}
	local var_121_1 = self:GetActiveEvent()

	if var_121_1 and not var_121_1:IsExpired() then
		for iter_121_0, iter_121_1 in ipairs((var_121_1:GetBossShipIds())) do
			table.insert(var_121_0, iter_121_1)
		end
	end

	return var_121_0
end

function Guild:ExistCommander(arg_122_1)
	local var_122_0 = self:GetActiveEvent()

	if var_122_0 then
		local var_122_1 = var_122_0:GetBossMission()

		return var_122_1:IsActive() and var_122_1:ExistCommander(arg_122_1)
	end

	return false
end

function Guild:IncActiveEventCnt()
	self.activeEventCnt = self.activeEventCnt + 1

	return
end

function Guild:ResetActiveEventCnt()
	self.activeEventCnt = 0

	return
end

function Guild:ShouldTipActiveEvent()
	return self.activeEventCnt + 1 <= self.tipActiveEventCnt
end

function Guild:GetActiveEventCnt()
	return self.activeEventCnt
end

return Guild
