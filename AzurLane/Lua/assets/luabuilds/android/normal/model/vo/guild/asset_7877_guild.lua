class = var_0_10000

local var_0_0 = "Guild"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".base.BaseGuild"))

pg = var_0_0

local var_0_2 = var_0_0.guild_technology_template

pg = var_2

local var_0_3 = var_2.guild_operation_template
local var_0_4 = true

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.member = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.member then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		GuildMember = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_1)
		arg_1_0.member[var_1_10007.id] = var_1_10007
	end

	arg_1_0.logInfo = {}
	ipairs = var_2

	local var_1_1

	if not arg_1_1.log then
		var_1_1 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_1) do
		GuildLogInfo = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_3)
		table = var_8

		var_8.insert(arg_1_0.logInfo, var_1_10007)
	end

	arg_1_0.events = {}
	ipairs = var_2

	for iter_1_4, iter_1_5 in var_2(var_0_3.all) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_1_2 = arg_1_0.events

		GuildEvent = var_1_10009

		var_1_10007(var_1_2, var_1_10009.New({
			id = iter_1_5
		}))
	end

	arg_1_0:updateBaseInfo(arg_1_1)
	arg_1_0:updateExtraInfo(arg_1_1)
	arg_1_0:updateUserInfo({})

	arg_1_0.completion = false

	return
end

function var_0_1.updateBaseInfo(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_1.base then
		var_2_0 = {}
	end

	arg_2_0.id = var_2_0.id
	arg_2_0.policy = var_2_0.policy
	arg_2_0.faction = var_2_0.faction
	arg_2_0.name = var_2_0.name
	arg_2_0.manifesto = var_2_0.manifesto

	local var_2_1

	if not var_2_0.level then
		var_2_1 = 1
	end

	arg_2_0.level = var_2_1

	local var_2_2

	if not var_2_0.member_count then
		var_2_2 = 1
	end

	arg_2_0.memberCount = var_2_2

	local var_2_3

	if not var_2_0.announce then
		var_2_3 = ""
	end

	arg_2_0.announce = var_2_3

	local var_2_4

	if not var_2_0.exp then
		var_2_4 = 0
	end

	arg_2_0.exp = var_2_4

	local var_2_5

	if not var_2_0.change_faction_cd then
		var_2_5 = 0
	end

	arg_2_0.changeFactionTime = var_2_5

	local var_2_6

	if not var_2_0.kick_leader_cd then
		var_2_6 = 0
	end

	arg_2_0.kickLeaderTime = var_2_6

	return
end

function var_0_1.updateExtraInfo(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_1.guild_ex then
		var_3_0 = {}
	end

	local var_3_1

	if not var_3_0.capital then
		var_3_1 = 0
	end

	arg_3_0.capital = var_3_1
	GuildTask = var_3_1

	local var_3_2 = var_3_1.New
	local var_3_3

	if not var_3_0.this_weekly_tasks then
		var_3_3 = {}
	end

	local var_3_4 = var_3_2(var_3_3)

	arg_3_0:updateWeeklyTask(var_3_4)

	local var_3_5

	if not var_3_0.benefit_finish_time then
		var_3_5 = 0
	end

	arg_3_0.benefitFinishTime = var_3_5

	local var_3_6

	if not var_3_0.last_benefit_finish_time then
		var_3_6 = 0
	end

	arg_3_0.lastBenefitFinishTime = var_3_6
	arg_3_0.technologyGroups = {}
	pairs = var_4

	for iter_3_0, iter_3_1 in var_4(var_0_2.get_id_list_by_group) do
		GuildTechnologyGroup = var_1_10009
		var_1_10009 = var_1_10009.New({
			id = iter_3_0
		})
		arg_3_0.technologyGroups[var_1_10009.id] = var_1_10009
	end

	ipairs = var_4

	local var_3_7

	if not var_3_0.technologys then
		var_3_7 = {}
	end

	for iter_3_2, iter_3_3 in var_4(var_3_7) do
		local var_3_8 = var_0_2[iter_3_3.id]
		local var_3_9 = arg_3_0.technologyGroups[var_3_8.group]

		var_10.update(var_3_9, iter_3_3)
	end

	arg_3_0.maxMemberCntAddition = 0
	arg_3_0.capitalLogs = {}
	arg_3_0.requestCapitalLogTime = 0

	local var_3_10

	if not var_3_0.retreat_cnt then
		var_3_10 = 0
	end

	arg_3_0.retreatCnt = var_3_10

	local var_3_11

	if not var_3_0.tech_cancel_cnt then
		var_3_11 = 0
	end

	arg_3_0.techCancelCnt = var_3_11

	local var_3_12

	if not var_3_0.active_event_cnt then
		var_3_12 = 0
	end

	arg_3_0.activeEventCnt = var_3_12
	pg = var_3_12
	arg_3_0.tipActiveEventCnt = var_3_12.guildset.operation_monthly_time.key_value

	return
end

function var_0_1.SetMaxMemberCntAddition(arg_4_0, arg_4_1)
	arg_4_0.maxMemberCntAddition = arg_4_1

	return
end

function var_0_1.updateUserInfo(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_1.user_info then
		var_5_0 = {}
	end

	local var_5_1

	if not var_5_0.donate_count then
		var_5_1 = 0
	end

	arg_5_0.donateCount = var_5_1

	local var_5_2

	if not var_5_0.benefit_time or not (var_5_0.benefit_time > 0) or not var_5_0.benefit_time then
		var_5_2 = 0
	end

	arg_5_0.benefitTime = var_5_2

	local var_5_3

	if not var_5_0.weekly_task_flag then
		var_5_3 = 0
	end

	arg_5_0.weeklyTaskFlag = var_5_3

	arg_5_0:setRefreshWeeklyTaskProgressTime()

	arg_5_0.refreshCaptialTime = 0
	arg_5_0.donateTasks = {}
	ipairs = var_3

	local var_5_4

	if not var_5_0.donate_tasks then
		var_5_4 = {}
	end

	for iter_5_0, iter_5_1 in var_3(var_5_4) do
		GuildDonateTask = var_1_10008
		var_1_10008 = var_1_10008.New({
			id = iter_5_1
		})
		table = var_1_10009

		var_1_10009.insert(arg_5_0.donateTasks, var_1_10008)
	end

	arg_5_0.technologys = {}
	pairs = var_3

	for iter_5_2, iter_5_3 in var_3(var_0_2.get_id_list_by_group) do
		local var_5_5 = arg_5_0.technologyGroups[iter_5_2]

		GuildTechnology = var_1_10009
		var_1_10009 = var_1_10009.New(var_5_5)
		arg_5_0.technologys[iter_5_2] = var_1_10009
	end

	ipairs = var_3

	local var_5_6

	if not var_5_0.tech_id then
		var_5_6 = {}
	end

	for iter_5_4, iter_5_5 in var_3(var_5_6) do
		local var_5_7 = var_0_2[iter_5_5].group
		local var_5_8 = arg_5_0.technologyGroups[var_5_7]
		local var_5_9 = arg_5_0.technologys[var_5_7]

		var_10.Update(var_5_9, iter_5_5, var_5_8)
	end

	local var_5_10

	if not var_5_0.extra_donate then
		var_5_10 = 0
	end

	arg_5_0.extraDonateCnt = var_5_10

	local var_5_11

	if not var_5_0.extra_operation then
		var_5_11 = 0
	end

	arg_5_0.extraBattleCnt = var_5_11
	arg_5_0.completion = true

	return
end

function var_0_1.IsCompletion(arg_6_0)
	return arg_6_0.completion
end

function var_0_1.AddExtraDonateCnt(arg_7_0, arg_7_1)
	arg_7_0.extraDonateCnt = arg_7_0.extraDonateCnt + arg_7_1

	return
end

function var_0_1.ReduceExtraDonateCnt(arg_8_0, arg_8_1)
	if arg_8_0.extraDonateCnt <= 0 then
		return
	end

	assert = var_2

	var_2(arg_8_1 <= arg_8_0.extraDonateCnt)

	arg_8_0.extraDonateCnt = arg_8_0.extraDonateCnt - arg_8_1

	return
end

function var_0_1.GetExtraDonateCnt(arg_9_0)
	return arg_9_0.extraDonateCnt
end

function var_0_1.AddExtraBattleCnt(arg_10_0, arg_10_1)
	arg_10_0.extraBattleCnt = arg_10_0.extraBattleCnt + arg_10_1

	return
end

function var_0_1.ReduceExtraBattleCnt(arg_11_0, arg_11_1)
	if arg_11_0.extraBattleCnt <= 0 then
		return
	end

	assert = var_2

	var_2(arg_11_1 <= arg_11_0.extraBattleCnt)

	arg_11_0.extraBattleCnt = arg_11_0.extraBattleCnt - arg_11_1

	return
end

function var_0_1.GetExtraBattleCnt(arg_12_0)
	return arg_12_0.extraBattleCnt
end

function var_0_1.StartTech(arg_13_0, arg_13_1)
	pg = var_1_10002

	local var_13_0 = var_1_10002.guild_technology_template[arg_13_1].group
	local var_13_1 = arg_13_0.technologyGroups[var_13_0]

	var_3.Start(var_13_1)

	return
end

function var_0_1.GetEvents(arg_14_0)
	return arg_14_0.events
end

function var_0_1.GetEventById(arg_15_0, arg_15_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_15_0.events, function(arg_16_0)
		return arg_16_0.id == arg_15_1
	end)
end

function var_0_1.GetActiveEvent(arg_17_0)
	_ = var_1_10001

	return var_1_10001.detect(arg_17_0.events, function(arg_18_0)
		return arg_18_0:IsActive()
	end)
end

function var_0_1.CanCancelTech(arg_19_0)
	return arg_19_0.techCancelCnt == 0
end

function var_0_1.UpdateTechCancelCnt(arg_20_0)
	arg_20_0.techCancelCnt = arg_20_0.techCancelCnt + 1

	return
end

function var_0_1.ResetTechCancelCnt(arg_21_0)
	arg_21_0.techCancelCnt = 0

	return
end

function var_0_1.shouldRefreshCaptial(arg_22_0)
	local var_22_0 = arg_22_0.refreshCaptialTime

	pg = var_1_10002

	local var_22_1 = var_1_10002.TimeMgr.GetInstance()

	return var_22_0 < var_2.GetServerTime(var_22_1)
end

function var_0_1.setRefreshCaptialTime(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.TimeMgr.GetInstance()
	local var_23_1 = var_1.GetServerTime(var_23_0)

	GuildConst = var_23_0
	arg_23_0.refreshCaptialTime = var_23_1 + var_23_0.REFRESH_CAPITAL_TIME

	return
end

function var_0_1.shouldRefreshWeeklyTaskProgress(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_24_0) >= arg_24_0.weeklyTaskNextRefreshTime
end

function var_0_1.setRefreshWeeklyTaskProgressTime(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.TimeMgr.GetInstance()
	local var_25_1 = var_1.GetServerTime(var_25_0)

	GuildConst = var_25_0
	arg_25_0.weeklyTaskNextRefreshTime = var_25_1 + var_25_0.WEEKLY_TASK_PROGRESS_REFRESH_TIME

	return
end

function var_0_1.hasWeeklyTaskFlag(arg_26_0)
	return arg_26_0.weeklyTaskFlag ~= 0
end

function var_0_1.setWeeklyTaskFlag(arg_27_0, arg_27_1)
	arg_27_0.weeklyTaskFlag = arg_27_1

	return
end

function var_0_1.getTechnologyGroups(arg_28_0)
	local var_28_0 = {}

	pairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.technologyGroups) do
		table = var_1_10007

		var_1_10007.insert(var_28_0, iter_28_1)
	end

	return var_28_0
end

function var_0_1.getTechnologyGroupById(arg_29_0, arg_29_1)
	return arg_29_0.technologyGroups[arg_29_1]
end

function var_0_1.getActiveTechnologyGroup(arg_30_0)
	pairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0.technologyGroups) do
		if iter_30_1:isStarting() then
			return iter_30_1
		end
	end

	return
end

function var_0_1.GetTechnologys(arg_31_0)
	return arg_31_0.technologys
end

function var_0_1.getTechnologyById(arg_32_0, arg_32_1)
	return arg_32_0.technologys[arg_32_1]
end

function var_0_1.getTechnologys(arg_33_0)
	local var_33_0 = {}

	pairs = var_1_10002

	for iter_33_0, iter_33_1 in var_1_10002(arg_33_0.technologys) do
		table = var_1_10007

		var_1_10007.insert(var_33_0, iter_33_1)
	end

	return var_33_0
end

function var_0_1.getSupplyConsume(arg_34_0)
	pg = var_1_10001

	local var_34_0, var_34_1 = var_1_10001.guildset.guild_award_consume.key_value, arg_34_0:getSupplyDuration()

	math = var_1_10004

	local var_34_2 = var_1_10004.ceil(var_34_1 / 0)
end

function var_0_1.getSupplyAwardId(arg_35_0)
	pg = var_1_10001

	return var_1_10001.guildset.guild_award_id.key_value
end

function var_0_1.updateSupplyTime(arg_36_0, arg_36_1)
	arg_36_0.benefitTime = arg_36_1

	return
end

function var_0_1.getSupplyCnt(arg_37_0)
	local var_37_0 = 0

	pg = var_1_10002

	local var_37_1 = var_1_10002.TimeMgr.GetInstance()
	local var_37_2 = var_2.GetServerTime(var_37_1)

	if arg_37_0.benefitFinishTime > 0 then
		math = var_3
		var_37_2 = var_3.min(arg_37_0.benefitFinishTime, var_37_2)
	end

	local var_37_3 = arg_37_0:getSupplyStartTime()

	if arg_37_0.benefitTime == 0 or arg_37_0.benefitTime < var_37_3 then
		math = var_4
		var_37_0 = var_4.ceil((var_37_2 - var_37_3) / 0)
	else
		math = var_4

		local var_37_4 = var_4.max(0, var_37_2 - arg_37_0.benefitTime)

		math = var_5
		var_37_0 = var_5.floor(var_37_4 / 0)
	end

	local var_37_5 = arg_37_0
	local var_37_6 = arg_37_0.getMemberById

	getProxy = var_1_10006
	PlayerProxy = var_1_10007

	local var_37_7 = var_1_10006(var_1_10007)
	local var_37_8 = var_37_6(var_37_5, var_6.getRawData(var_37_7).id)
	local var_37_9 = var_4.GetJoinZeroTime(var_37_8)
	local var_37_10

	if arg_37_0.lastBenefitFinishTime > 0 and arg_37_0.lastBenefitFinishTime > arg_37_0.benefitTime and var_37_9 <= arg_37_0.lastBenefitFinishTime then
		var_37_10 = arg_37_0.benefitTime <= 0 and var_37_9 or arg_37_0.benefitTime
		math = var_7
		var_37_0 = var_7.ceil((arg_37_0.lastBenefitFinishTime - var_37_10) / 0) + var_37_0
	end

	math = var_37_10

	local var_37_11 = var_37_10.min
	local var_37_12 = var_37_0

	GuildConst = var_1_10008

	return var_37_11(var_37_12, var_1_10008.MAX_SUPPLY_CNT)
end

function var_0_1.startSupply(arg_38_0, arg_38_1)
	arg_38_0.benefitFinishTime = arg_38_1

	return
end

function var_0_1.GetSupplyEndTime(arg_39_0)
	return arg_39_0.benefitFinishTime
end

function var_0_1.getSupplyLeftCnt(arg_40_0)
	pg = var_1_10001

	local var_40_0 = var_1_10001.TimeMgr.GetInstance()
	local var_40_1 = var_1.GetServerTime(var_40_0)

	math = var_40_0

	return var_40_0.floor((arg_40_0.benefitFinishTime - var_40_1) / 0)
end

function var_0_1.getSupplyDuration(arg_41_0)
	pg = var_1_10001

	return var_1_10001.guildset.guild_award_duration.key_value
end

function var_0_1.getSupplyStartTime(arg_42_0)
	local var_42_0 = arg_42_0.benefitFinishTime - arg_42_0:getSupplyDuration() + 1
	local var_42_1 = arg_42_0
	local var_42_2 = arg_42_0.getMemberById

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_42_3 = var_1_10004(var_1_10005)
	local var_42_4 = var_42_2(var_42_1, var_4.getRawData(var_42_3).id)

	if var_42_0 < var_2.GetJoinZeroTime(var_42_4) then
		return var_3
	else
		return var_42_0
	end

	return
end

function var_0_1.ExistSupply(arg_43_0)
	local var_43_0 = arg_43_0.benefitFinishTime

	if 0 < var_43_0 then
		local var_43_1 = arg_43_0.benefitFinishTime

		pg = var_2

		local var_43_2 = var_2.TimeMgr.GetInstance()
		local var_43_3

		if not (var_43_1 > var_2.GetServerTime(var_43_2)) then
			var_43_3 = false
		else
			var_43_3 = true
		end

		return var_43_3
	end
end

function var_0_1.isOpenedSupply(arg_44_0)
	local var_44_0 = arg_44_0.benefitFinishTime

	if 0 < var_44_0 then
		local var_44_1 = arg_44_0.benefitFinishTime

		pg = var_2

		local var_44_2 = var_2.TimeMgr.GetInstance()
		local var_44_3

		if not (var_44_1 > var_2.GetServerTime(var_44_2)) and not (arg_44_0:getSupplyCnt() > 0) then
			var_44_3 = false
		else
			var_44_3 = true
		end

		return var_44_3
	end
end

function var_0_1.getSelectableWeeklyTasks(arg_45_0)
	local var_45_0 = {}

	GuildMember = var_1_10002

	if var_1_10002.IsAdministrator(arg_45_0:getSelfDuty()) then
		pg = var_2

		local var_45_1 = var_2.guild_mission_template

		ipairs = var_3

		for iter_45_0, iter_45_1 in var_3(var_45_1.all) do
			GuildTask = var_1_10008
			var_1_10008 = var_1_10008.New({
				progress = 0,
				id = iter_45_1
			})
			table = var_9

			var_9.insert(var_45_0, var_1_10008)
		end
	end

	return var_45_0
end

function var_0_1.shouldRequestCapitalLog(arg_46_0)
	pg = var_1_10001

	local var_46_0 = var_1_10001.TimeMgr.GetInstance()
	local var_46_1 = var_1.GetServerTime(var_46_0) - arg_46_0.requestCapitalLogTime

	GuildConst = var_1_10003

	if var_46_1 > var_1_10003.REQUEST_LOG_TIME then
		return true
	end

	return false
end

function var_0_1.updateCapitalLogs(arg_47_0, arg_47_1)
	arg_47_0.capitalLogs = arg_47_1
	pg = var_1_10002

	local var_47_0 = var_1_10002.TimeMgr.GetInstance()

	arg_47_0.requestCapitalLogTime = var_2.GetServerTime(var_47_0)

	return
end

function var_0_1.getCapitalLogs(arg_48_0)
	return arg_48_0.capitalLogs
end

function var_0_1.getMaxDonateCnt(arg_49_0)
	pg = var_1_10001

	return var_1_10001.guildset.contribution_task_num.key_value
end

function var_0_1.getRemainDonateCnt(arg_50_0)
	return arg_50_0:getMaxDonateCnt() - arg_50_0.donateCount
end

function var_0_1.updateDonateCount(arg_51_0)
	if arg_51_0:getRemainDonateCnt() > 0 then
		arg_51_0.donateCount = arg_51_0.donateCount + 1
	else
		arg_51_0:ReduceExtraDonateCnt(1)
	end

	return
end

function var_0_1.canDonate(arg_52_0)
	return arg_52_0:getRemainDonateCnt() > 0 or arg_52_0.extraDonateCnt > 0
end

function var_0_1.getDonateTasks(arg_53_0)
	return arg_53_0.donateTasks
end

function var_0_1.updateDonateTasks(arg_54_0, arg_54_1)
	arg_54_0.donateTasks = arg_54_1

	return
end

function var_0_1.getDonateTaskById(arg_55_0, arg_55_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_55_0.donateTasks, function(arg_56_0)
		return arg_56_0.id == arg_55_1
	end)
end

function var_0_1.updateWeeklyTask(arg_57_0, arg_57_1)
	arg_57_0.weeklyTask = arg_57_1

	return
end

function var_0_1.getWeeklyTask(arg_58_0)
	return arg_58_0.weeklyTask
end

function var_0_1.GetActiveWeeklyTask(arg_59_0)
	if arg_59_0.weeklyTask and arg_59_0.weeklyTask.id ~= 0 then
		return arg_59_0.weeklyTask
	end

	return nil
end

function var_0_1.addCapital(arg_60_0, arg_60_1)
	arg_60_0:updateCapital(arg_60_0.capital + arg_60_1)

	return
end

function var_0_1.updateCapital(arg_61_0, arg_61_1)
	arg_61_0.capital = arg_61_1

	return
end

function var_0_1.consumeCapital(arg_62_0, arg_62_1)
	arg_62_0:updateCapital(arg_62_0.capital - arg_62_1)

	return
end

function var_0_1.getCapital(arg_63_0)
	return arg_63_0.capital
end

function var_0_1.setkickLeaderTime(arg_64_0, arg_64_1)
	arg_64_0.kickLeaderTime = arg_64_1

	return
end

function var_0_1.getKickLeftTime(arg_65_0)
	pg = var_1_10001

	local var_65_0 = var_1_10001.TimeMgr.GetInstance()
	local var_65_1 = var_1.GetServerTime(var_65_0)

	return arg_65_0.kickLeaderTime - var_65_1
end

function var_0_1.inKickTime(arg_66_0)
	return arg_66_0.kickLeaderTime ~= 0
end

function var_0_1.getAssistantMaxCount(arg_67_0)
	pg = var_1_10001

	return var_1_10001.guild_data_level[arg_67_0.level].assistant_commander
end

function var_0_1.getAssistantCount(arg_68_0)
	local var_68_0 = 0

	pairs = var_1_10002

	for iter_68_0, iter_68_1 in var_1_10002(arg_68_0.member) do
		local var_68_1 = iter_68_1.duty

		GuildConst = var_1_10008

		if var_68_1 == var_1_10008.DUTY_DEPUTY_COMMANDER then
			var_68_0 = var_68_0 + 1
		end
	end

	return var_68_0
end

function var_0_1.setMemberCount(arg_69_0, arg_69_1)
	arg_69_0.memberCount = arg_69_1

	return
end

function var_0_1.getSortMember(arg_70_0)
	local var_70_0 = {}

	pairs = var_1_10002

	for iter_70_0, iter_70_1 in var_1_10002(arg_70_0.member) do
		table = var_1_10007

		var_1_10007.insert(var_70_0, iter_70_1)
	end

	return var_70_0
end

function var_0_1.getSortMemberWithoutSelf(arg_71_0)
	local var_71_0 = {}

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_71_1 = var_1_10002(var_1_10003)
	local var_71_2 = var_2.getRawData(var_71_1).id

	pairs = var_71_1

	for iter_71_0, iter_71_1 in var_71_1(arg_71_0.member) do
		if iter_71_1.id ~= var_71_2 then
			table = var_8

			var_8.insert(var_71_0, iter_71_1)
		end
	end

	return var_71_0
end

function var_0_1.getBgName(arg_72_0)
	local var_72_0 = arg_72_0.faction

	GuildConst = var_1_10002

	if var_72_0 == var_1_10002.FACTION_TYPE_BLHX then
		return "bg/bg_guild_blue_n"
	else
		local var_72_1 = arg_72_0.faction

		GuildConst = var_2

		if var_72_1 == var_2.FACTION_TYPE_CSZZ then
			return "bg/bg_guild_red_n"
		end
	end

	return
end

function var_0_1.addLog(arg_73_0, arg_73_1)
	table = var_1_10002

	var_1_10002.insert(arg_73_0.logInfo, 1, arg_73_1)

	if #arg_73_0.logInfo > 100 then
		table = var_2

		var_2.remove(arg_73_0.logInfo, #arg_73_0.logInfo)
	end

	return
end

function var_0_1.getLogs(arg_74_0)
	return arg_74_0.logInfo
end

function var_0_1.getMemberById(arg_75_0, arg_75_1)
	return arg_75_0.member[arg_75_1]
end

function var_0_1.updateMember(arg_76_0, arg_76_1)
	arg_76_0.member[arg_76_1.id] = arg_76_1

	return
end

function var_0_1.addMember(arg_77_0, arg_77_1)
	arg_77_0.member[arg_77_1.id] = arg_77_1

	return
end

function var_0_1.deleteMember(arg_78_0, arg_78_1)
	arg_78_0.member[arg_78_1] = nil

	return
end

function var_0_1.getDutyByMemberId(arg_79_0, arg_79_1)
	pairs = var_1_10002

	for iter_79_0, iter_79_1 in var_1_10002(arg_79_0.member) do
		if iter_79_1.id == arg_79_1 then
			return iter_79_1.duty
		end
	end

	return
end

function var_0_1.setId(arg_80_0, arg_80_1)
	arg_80_0.id = arg_80_1

	return
end

function var_0_1.setName(arg_81_0, arg_81_1)
	arg_81_0.name = arg_81_1

	return
end

function var_0_1.getPolicyName(arg_82_0)
	GuildConst = var_1_10001

	return var_1_10001.POLICY_NAME[arg_82_0.policy]
end

function var_0_1.getFactionName(arg_83_0)
	GuildConst = var_1_10001

	return var_1_10001.FACTION_NAME[arg_83_0.faction]
end

function var_0_1.getName(arg_84_0)
	return arg_84_0.name
end

function var_0_1.setPolicy(arg_85_0, arg_85_1)
	arg_85_0.policy = arg_85_1

	return
end

function var_0_1.getPolicy(arg_86_0)
	return arg_86_0.policy
end

function var_0_1.setFaction(arg_87_0, arg_87_1)
	arg_87_0.faction = arg_87_1

	return
end

function var_0_1.getFaction(arg_88_0)
	return arg_88_0.faction
end

function var_0_1.setManifesto(arg_89_0, arg_89_1)
	arg_89_0.manifesto = arg_89_1

	return
end

function var_0_1.getManifesto(arg_90_0)
	local var_90_0

	if not arg_90_0.manifesto then
		var_90_0 = ""
	end

	return var_90_0
end

local var_0_5 = 0

function var_0_1.inChangefactionTime(arg_91_0)
	local var_91_0 = arg_91_0.changeFactionTime

	pg = var_1_10002

	local var_91_1 = var_1_10002.TimeMgr.GetInstance()
	local var_91_2 = var_91_0 - var_2.GetServerTime(var_91_1)

	if arg_91_0.changeFactionTime ~= 0 and not (var_91_2 < 0) then
		return true
	end

	return
end

function var_0_1.changeFactionLeftTime(arg_92_0)
	local var_92_0 = arg_92_0.changeFactionTime

	pg = var_1_10002

	local var_92_1 = var_1_10002.TimeMgr.GetInstance()
	local var_92_2 = var_92_0 - var_2.GetServerTime(var_92_1)

	pg = var_2

	local var_92_3 = var_2.TimeMgr.GetInstance()

	return var_2.parseTimeFrom(var_92_3, var_92_2)
end

function var_0_1.getLevelMaxExp(arg_93_0)
	pg = var_1_10001

	if not var_1_10001.guild_data_level[arg_93_0.level] then
		return var_1[var_1.all[#var_1.all]].exp
	else
		return var_1[arg_93_0.level].exp
	end

	return
end

function var_0_1.getMaxMember(arg_94_0)
	pg = var_1_10001

	local var_94_0 = var_1_10001.guild_data_level.all[#var_1.all]

	math = var_3

	local var_94_1 = var_1[var_3.min(arg_94_0.level, var_94_0)].member_num
	local var_94_2

	if not arg_94_0.maxMemberCntAddition then
		var_94_2 = 0
	end

	return var_94_1 + arg_94_0:GetGuildMemberCntAddition() + var_94_2
end

function var_0_1.updateExp(arg_95_0, arg_95_1)
	arg_95_0.exp = arg_95_1

	return
end

function var_0_1.updateLevel(arg_96_0, arg_96_1)
	arg_96_0.level = arg_96_1

	return
end

function var_0_1.getCommader(arg_97_0)
	pairs = var_1_10001

	for iter_97_0, iter_97_1 in var_1_10001(arg_97_0.member) do
		local var_97_0 = iter_97_1.duty

		GuildConst = var_1_10007

		if var_97_0 == var_1_10007.DUTY_COMMANDER then
			return iter_97_1
		end
	end

	return
end

function var_0_1.getCommaderName(arg_98_0)
	if arg_98_0:getCommader() then
		return var_1.name
	else
		return ""
	end

	return
end

function var_0_1.setAnnounce(arg_99_0, arg_99_1)
	arg_99_0.announce = arg_99_1

	return
end

function var_0_1.GetAnnounce(arg_100_0)
	return arg_100_0.announce
end

function var_0_1.getEnableDuty(arg_101_0, arg_101_1, arg_101_2)
	GuildConst = var_1_10003

	if arg_101_2 == var_1_10003.DUTY_RECRUIT then
		return {}
	end

	local var_101_0 = {}

	GuildConst = var_1_10004

	if arg_101_1 == var_1_10004.DUTY_COMMANDER then
		var_1_10005 = arg_101_0

		if arg_101_0.getAssistantMaxCount(var_1_10005) == arg_101_0:getAssistantCount() then
			GuildConst = var_101_1

			if arg_101_2 == var_101_1.DUTY_DEPUTY_COMMANDER then
				local var_101_1 = {}

				GuildConst = var_1_10005
				var_101_1[1] = var_1_10005.DUTY_COMMANDER
				GuildConst = var_1_10005
				var_101_1[2] = var_1_10005.DYTY_PICKED
				GuildConst = var_1_10005
				var_101_1[3] = var_1_10005.DUTY_ORDINARY

				if not var_101_1 then
					::label_101_0::

					var_101_1 = {}
					GuildConst = var_1_10005
					var_101_1[1] = var_1_10005.DYTY_PICKED
					GuildConst = var_1_10005
					var_101_1[2] = var_1_10005.DUTY_ORDINARY
					var_101_0 = var_101_1
				end

				goto label_101_2

				GuildConst = var_101_1

				if arg_101_2 == var_101_1.DUTY_DEPUTY_COMMANDER then
					var_101_1 = {}
					GuildConst = var_1_10005
					var_101_1[1] = var_1_10005.DUTY_COMMANDER
					GuildConst = var_1_10005
					var_101_1[2] = var_1_10005.DUTY_DEPUTY_COMMANDER
					GuildConst = var_1_10005
					var_101_1[3] = var_1_10005.DYTY_PICKED
					GuildConst = var_1_10005
					var_101_1[4] = var_1_10005.DUTY_ORDINARY

					if not var_101_1 then
						::label_101_1::

						var_101_1 = {}
						GuildConst = var_1_10005
						var_101_1[1] = var_1_10005.DUTY_DEPUTY_COMMANDER
						GuildConst = var_1_10005
						var_101_1[2] = var_1_10005.DYTY_PICKED
						GuildConst = var_1_10005
						var_101_1[3] = var_1_10005.DUTY_ORDINARY
						var_101_0 = var_101_1
					end

					goto label_101_2

					GuildConst = var_101_1

					if arg_101_1 == var_101_1.DUTY_DEPUTY_COMMANDER then
						var_101_1 = {}
						GuildConst = var_1_10005
						var_101_1[1] = var_1_10005.DYTY_PICKED
						GuildConst = var_5
						var_101_1[2] = var_5.DUTY_ORDINARY
						var_101_0 = var_101_1
					end

					::label_101_2::

					ipairs = var_101_1

					for iter_101_0, iter_101_1 in var_101_1(var_101_0) do
						if iter_101_1 == arg_101_2 then
							table = var_1_10009

							var_1_10009.remove(var_101_0, iter_101_0)

							break
						end
					end

					return var_101_0
				end
			end
		end
	end
end

function var_0_1.warpChatInfo(arg_102_0, arg_102_1)
	wordVer = var_1_10002

	local var_102_0, var_102_1 = var_1_10002(arg_102_1.content, {
		isReplace = true
	})

	GuildMember = var_4

	if var_4.New(arg_102_1.player) then
		local var_102_2 = arg_102_0
		local var_102_3 = arg_102_0.getDutyByMemberId(var_102_2, var_4.id)

		assert = var_102_2

		var_102_2(var_102_3, "palyer duty has not been found" .. var_4.id)

		local var_102_4 = var_4

		var_4.setDuty(var_102_4, var_102_3)

		local var_102_5

		string = var_102_4

		local var_102_6 = var_102_4.gsub
		local var_102_7 = var_102_1

		ChatConst = var_9

		var_102_6(var_102_7, var_9.EmojiCodeMatch, function(arg_103_0)
			tonumber = var_2_10001
			var_102_5 = var_2_10001(arg_103_0)

			return
		end)

		if var_102_5 then
			pg = var_102_6

			if var_102_6.emoji_template[var_102_5] then
				var_102_1 = var_102_6.desc
			else
				var_102_5 = nil
			end
		end

		ChatMsg = var_102_6

		local var_102_8 = var_102_6.New

		ChatConst = var_102_7

		return (var_102_8(var_102_7.ChannelGuild, {
			player = var_4,
			content = var_102_1,
			emojiId = var_102_5,
			timestamp = arg_102_1.time
		}))
	end

	return
end

function var_0_1.getSelfDuty(arg_104_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_104_0 = var_1_10001(var_1_10002)
	local var_104_1 = var_1.getRawData(var_104_0)

	return arg_104_0:getDutyByMemberId(var_104_1.id)
end

function var_0_1.GetOfficePainting(arg_105_0)
	local var_105_0 = arg_105_0
	local var_105_1 = arg_105_0.getFaction(var_105_0)

	GuildConst = var_105_0

	if var_105_1 == var_105_0.FACTION_TYPE_BLHX then
		return "guild_office_blue"
	else
		GuildConst = var_2

		if var_105_1 == var_2.FACTION_TYPE_CSZZ then
			return "guild_office_red"
		end
	end

	return
end

function var_0_1.ShouldShowDonateTip(arg_106_0)
	return arg_106_0:getMaxDonateCnt() > arg_106_0.donateCount
end

function var_0_1.ShouldWeeklyTaskTip(arg_107_0)
	local var_107_0 = arg_107_0.weeklyTask
	local var_107_1 = var_1.getState(var_107_0)

	GuildTask = var_107_0

	if var_107_0.STATE_EMPTY == var_107_1 then
		::label_107_0::

		GuildMember = var_1_10003
		var_1_10003 = var_1_10003.IsAdministrator(arg_107_0:getSelfDuty())
	end

	return var_1_10003
end

function var_0_1.ShouldShowOfficeTip(arg_108_0)
	local var_108_0

	if not arg_108_0:ShouldShowDonateTip() and not arg_108_0:ShouldWeeklyTaskTip() then
		var_108_0 = arg_108_0:ShouldShowSupplyTip()
	end

	return var_108_0
end

function var_0_1.ShouldShowTechTip(arg_109_0)
	local var_109_0

	if arg_109_0:getActiveTechnologyGroup() and var_1:isMaxLevel() then
		var_109_0 = not arg_109_0:IsFinishAllTechnologyGroup()
	end

	return var_109_0
end

function var_0_1.IsFinishAllTechnologyGroup(arg_110_0)
	pairs = var_1_10001

	for iter_110_0, iter_110_1 in var_1_10001(arg_110_0.technologyGroups) do
		if not iter_110_1:isMaxLevel() then
			return false
		end
	end

	return true
end

function var_0_1.ShouldShowSupplyTip(arg_111_0)
	local function var_111_0()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_112_0 = var_2_10000(var_2_10001)
		local var_112_1 = var_0.getRawData(var_112_0).id
		local var_112_2 = arg_111_0
		local var_112_3 = var_1.getMemberById(var_112_2, var_112_1)

		return not var_1.IsRecruit(var_112_3) and not var_1:isNewMember()
	end

	local var_111_1 = arg_111_0:getSupplyCnt()

	return arg_111_0:isOpenedSupply() and var_111_1 > 0 and var_111_0()
end

function var_0_1.GetMembers(arg_113_0)
	return arg_113_0.member
end

function var_0_1.GetAllAssaultShip(arg_114_0)
	local var_114_0 = {}

	pairs = var_1_10002

	for iter_114_0, iter_114_1 in var_1_10002(arg_114_0.member) do
		local var_114_1 = iter_114_1:GetAssaultFleet()
		local var_114_2 = var_7.GetShipList(var_114_1)

		ipairs = var_114_1

		for iter_114_2, iter_114_3 in var_114_1(var_114_2) do
			table = var_1_10014

			var_1_10014.insert(var_114_0, iter_114_3)
		end
	end

	return var_114_0
end

function var_0_1.GetRecomForBossEvent(arg_115_0, arg_115_1, arg_115_2, arg_115_3)
	local var_115_0 = {}

	pairs = var_1_10005

	for iter_115_0, iter_115_1 in var_1_10005(arg_115_0.member) do
		table = var_1_10010

		if not var_1_10010.contains(arg_115_3, iter_115_1.id) then
			local var_115_1 = iter_115_1:GetAssaultFleet()

			if var_1_10010.GetStrongestShip(var_115_1, arg_115_1) then
				table = var_115_1

				var_115_1.insert(var_115_0, var_11)
			end
		end
	end

	table = var_5

	var_5.sort(var_115_0, function(arg_116_0, arg_116_1)
		return arg_116_0.level > arg_116_1.level
	end)

	_ = var_5

	local var_115_2 = var_5.slice
	local var_115_3 = var_115_0
	local var_115_4 = 1

	math = iter_115_0

	return var_115_2(var_115_3, var_115_4, iter_115_0.min(arg_115_2, #var_115_0))
end

function var_0_1.GetMemberShips(arg_117_0, arg_117_1)
	local var_117_0 = {}
	local var_117_1 = {}

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_117_2 = var_1_10004(var_1_10005)
	local var_117_3 = var_4.getRawData(var_117_2).id

	local function var_117_4(arg_118_0)
		return var_117_3 == arg_118_0.id
	end

	pairs = var_1_10006

	for iter_117_0, iter_117_1 in var_1_10006(arg_117_0.member) do
		var_1_10011 = iter_117_1:GetShip()

		local var_117_5 = iter_117_1

		var_1_10011.isCommander = iter_117_1.IsCommander(var_117_5)

		if var_12 or var_117_4(iter_117_1) then
			table = var_117_5

			var_117_5.insert(var_117_1, var_1_10011)
		else
			table = var_117_5

			var_117_5.insert(var_117_0, var_1_10011)
		end
	end

	for iter_117_2 = 1, arg_117_1 do
		if #var_117_1 == arg_117_1 then
			break
		end

		if var_117_0[iter_117_2] then
			table = var_1_10011

			var_1_10011.insert(var_117_1, var_10)
		end
	end

	return var_117_1
end

function var_0_1.IsAdministrator(arg_119_0)
	GuildMember = var_1_10001

	return var_1_10001.IsAdministrator(arg_119_0:getSelfDuty())
end

function var_0_1.GetMissionAndAssultFleetShips(arg_120_0)
	local var_120_0 = {}
	local var_120_1 = arg_120_0

	if arg_120_0.GetActiveEvent(var_120_1) then
		var_1_10004 = var_2

		if not var_2.IsExpired(var_1_10004) then
			var_1_10004 = var_2
			var_120_1 = var_2.GetJoinShips(var_1_10004)
			ipairs = var_1_10004

			for iter_120_0, iter_120_1 in var_1_10004(var_120_1) do
				table = var_1_10009

				var_1_10009.insert(var_120_0, iter_120_1)
			end
		end
	end

	getProxy = var_120_1
	PlayerProxy = var_1_10004

	local var_120_2 = var_120_1(var_1_10004)
	local var_120_3 = var_3.getRawData(var_120_2).id
	local var_120_4 = arg_120_0.member[var_120_3]
	local var_120_5 = var_4.GetAssaultFleet(var_120_4)
	local var_120_6 = var_4:GetExternalAssaultFleet()
	local var_120_7 = var_120_5
	local var_120_8 = var_120_5.GetShipList(var_120_7)

	pairs = var_120_7

	for iter_120_2, iter_120_3 in var_120_7(var_120_8) do
		GuildAssaultFleet = var_1_10013
		var_1_10013 = var_1_10013.GetRealId(iter_120_3.id)
		table = var_1_10014

		var_1_10014.insert(var_120_0, var_1_10013)
	end

	local var_120_9 = var_120_6
	local var_120_10 = var_120_6.GetShipList(var_120_9)

	pairs = var_120_9

	for iter_120_4, iter_120_5 in var_120_9(var_120_10) do
		GuildAssaultFleet = var_1_10014
		var_1_10014 = var_1_10014.GetRealId(iter_120_5.id)
		table = var_15

		var_15.insert(var_120_0, var_1_10014)
	end

	return var_120_0
end

function var_0_1.GetBossMissionShips(arg_121_0)
	local var_121_0 = {}

	if arg_121_0:GetActiveEvent() and not var_2:IsExpired() then
		local var_121_1 = var_2
		local var_121_2 = var_2.GetBossShipIds(var_121_1)

		ipairs = var_121_1

		for iter_121_0, iter_121_1 in var_121_1(var_121_2) do
			table = var_1_10009

			var_1_10009.insert(var_121_0, iter_121_1)
		end
	end

	return var_121_0
end

function var_0_1.ExistCommander(arg_122_0, arg_122_1)
	if arg_122_0:GetActiveEvent() then
		local var_122_0 = var_2:GetBossMission()
		local var_122_1

		if var_3.IsActive(var_122_0) then
			var_122_1 = var_3:ExistCommander(arg_122_1)
		end

		return var_122_1
	end

	return false
end

function var_0_1.IncActiveEventCnt(arg_123_0)
	arg_123_0.activeEventCnt = arg_123_0.activeEventCnt + 1

	return
end

function var_0_1.ResetActiveEventCnt(arg_124_0)
	arg_124_0.activeEventCnt = 0

	return
end

function var_0_1.ShouldTipActiveEvent(arg_125_0)
	return arg_125_0.activeEventCnt + 1 <= arg_125_0.tipActiveEventCnt
end

function var_0_1.GetActiveEventCnt(arg_126_0)
	return arg_126_0.activeEventCnt
end

return var_0_1
