class = var_0_10000

local var_0_0 = "EducateProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.RESOURCE_UPDATED = "EducateProxy.RESOURCE_UPDATED"
var_0_1.ATTR_UPDATED = "EducateProxy.ATTR_UPDATED"
var_0_1.TIME_UPDATED = "EducateProxy.TIME_UPDATED"
var_0_1.TIME_WEEKDAY_UPDATED = "EducateProxy.TIME_WEEKDAY_UPDATED"
var_0_1.BUFF_ADDED = "EducateProxy.BUFF_ADDED"
var_0_1.OPTION_UPDATED = "EducateProxy.OPTION_UPDATED"
var_0_1.ENDING_ADDED = "EducateProxy.ENDING_ADDED"
var_0_1.ITEM_ADDED = "EducateProxy.ITEM_ADDED"
var_0_1.POLAROID_ADDED = "EducateProxy.POLAROID_ADDED"
var_0_1.MEMORY_ADDED = "EducateProxy.MEMORY_ADDED"
var_0_1.UNLCOK_NEW_SECRETARY_BY_CNT = "EducateProxy.UNLCOK_NEW_SECRETARY_BY_CNT"
var_0_1.GUIDE_CHECK = "EducateProxy.GUIDE_CHECK"
var_0_1.MAIN_SCENE_ADD_LAYER = "EducateProxy.MAIN_SCENE_ADD_LAYER"
var_0_1.CLEAR_NEW_TIP = "EducateProxy.CLEAR_NEW_TIP"

function var_0_1.register(arg_1_0)
	EducatePlanProxy = var_1_10001
	arg_1_0.planProxy = var_1_10001.New(arg_1_0)
	EducateEventProxy = var_1
	arg_1_0.eventProxy = var_1.New(arg_1_0)
	EducateShopProxy = var_1
	arg_1_0.shopProxy = var_1.New(arg_1_0)
	EducateTaskProxy = var_1
	arg_1_0.taskProxy = var_1.New(arg_1_0)
	pg = var_1
	arg_1_0.endTime = var_1.gameset.child_end_data.description

	arg_1_0:on(27021, function(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0.tasks) do
			local var_2_0 = arg_1_0.taskProxy

			var_6.AddTask(var_2_0, iter_2_1)
		end

		return
	end)
	arg_1_0:on(27022, function(arg_3_0)
		ipairs = var_2_10001

		for iter_3_0, iter_3_1 in var_2_10001(arg_3_0.ids) do
			local var_3_0 = arg_1_0.taskProxy

			var_6.RemoveTaskById(var_3_0, iter_3_1)
		end

		return
	end)
	arg_1_0:on(27025, function(arg_4_0)
		ipairs = var_2_10001

		for iter_4_0, iter_4_1 in var_2_10001(arg_4_0.tasks) do
			local var_4_0 = arg_1_0.taskProxy

			var_6.UpdateTask(var_4_0, iter_4_1)
		end

		return
	end)

	return
end

function var_0_1.initData(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.sendNotification

	GAME = var_1_10004

	var_5_1(var_5_0, var_1_10004.EDUCATE_GET_ENDINGS)

	arg_5_0.exsitEnding = arg_5_1.child.is_ending == 1 or false
	arg_5_0.gameCount = var_2.new_game_plus_count

	local var_5_2

	if not var_2.cur_time then
		var_5_2 = {
			week = 1,
			month = 3,
			day = 7
		}
	end

	arg_5_0.curTime = var_5_2
	EducateChar = var_5_2
	arg_5_0.char = var_5_2.New(var_2)

	local var_5_3 = arg_5_0.eventProxy

	var_3.SetUp(var_5_3, {
		waitTriggerEventIds = var_2.home_events,
		needRequestHomeEvents = var_2.can_trigger_home_event == 1 or false,
		finishSpecEventIds = var_2.spec_events
	})

	local var_5_4 = arg_5_0.planProxy

	var_3.SetUp(var_5_4, {
		history = var_2.plan_history,
		selectedPlans = var_2.plans
	})

	local var_5_5 = arg_5_0.shopProxy

	var_3.SetUp(var_5_5, {
		shops = var_2.shop,
		discountEventIds = var_2.discount_event_id
	})

	local var_5_6 = arg_5_0.taskProxy

	var_3.SetUp(var_5_6, {
		targetId = var_2.target,
		tasks = var_2.tasks,
		finishMindTaskIds = var_2.realized_wish,
		isGotTargetAward = var_2.had_target_stage_award == 1 or false
	})
	arg_5_0:initItems(var_2.items)
	arg_5_0:initPolaroids(var_2.polaroids)

	arg_5_0.memories = var_2.memorys

	arg_5_0:initBuffs(var_2.buffs)
	arg_5_0:initOptions(var_2.option_records)

	arg_5_0.siteRandomOpts = nil

	arg_5_0:UpdateGameStatus()
	arg_5_0:initVirtualStage()
	arg_5_0:initUnlockSecretary(var_2.is_special_secretary_valid == 1)

	arg_5_0.endingBuyCnt = var_2.ending_buy_count
	arg_5_0.memoryBuyCnt = var_2.memory_buy_count
	arg_5_0.polaroidBuyCnt = var_2.polaroid_buy_count
	arg_5_0.requestDataEnd = true

	return
end

function var_0_1.CheckDataRequestEnd(arg_6_0)
	return arg_6_0.requestDataEnd
end

function var_0_1.GetSelectInfo(arg_7_0)
	EducateHelper = var_1_10001

	local var_7_0 = var_1_10001.GetShowMonthNumber(arg_7_0.curTime.month)

	i18n = var_1_10003

	local var_7_1 = var_1_10003("word_month")

	i18n = var_4

	local var_7_2 = var_7_0 .. var_7_1 .. var_4("word_which_week", arg_7_0.curTime.week)
	local var_7_3 = {}
	local var_7_4 = arg_7_0.char

	var_7_3.bg = var_4.GetBGName(var_7_4)

	local var_7_5 = arg_7_0.char

	var_7_3.name = var_4.GetName(var_7_5)
	var_7_3.gameCnt = arg_7_0.gameCount

	local var_7_6

	if not arg_7_0.isUnlockSecretary or not var_7_2 then
		::label_7_0::

		i18n = var_7_6
		var_7_6 = var_7_6("child2_not_start")
	end

	var_7_3.progressStr = var_7_6

	return var_7_3
end

function var_0_1.CheckGuide(arg_8_0, arg_8_1)
	arg_8_0:sendNotification(var_0_1.GUIDE_CHECK, {
		view = arg_8_1
	})

	return
end

function var_0_1.MainAddLayer(arg_9_0, arg_9_1)
	arg_9_0:sendNotification(var_0_1.MAIN_SCENE_ADD_LAYER, arg_9_1)

	return
end

function var_0_1.initItems(arg_10_0, arg_10_1)
	arg_10_0.itemData = {}
	ipairs = var_2

	for iter_10_0, iter_10_1 in var_2(arg_10_1) do
		local var_10_0 = arg_10_0.itemData
		local var_10_1 = iter_10_1.id

		EducateItem = var_1_10009
		var_10_0[var_10_1] = var_1_10009.New(iter_10_1)
	end

	return
end

function var_0_1.initOptions(arg_11_0, arg_11_1)
	local var_11_0 = {}

	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_1) do
		var_11_0[iter_11_1.id] = iter_11_1.count
	end

	arg_11_0.siteOptionData = {}
	ipairs = var_3
	pg = var_4

	for iter_11_2, iter_11_3 in var_3(var_4.child_site_option.all) do
		EducateSiteOption = var_1_10008
		var_1_10008 = var_1_10008.New(iter_11_3, var_11_0[iter_11_3])
		arg_11_0.siteOptionData[iter_11_3] = var_1_10008
	end

	return
end

function var_0_1.initRandomOpts(arg_12_0, arg_12_1)
	arg_12_0.siteRandomOpts = {}
	ipairs = var_2

	for iter_12_0, iter_12_1 in var_2(arg_12_1) do
		arg_12_0.siteRandomOpts[iter_12_1.site_id] = iter_12_1.option_ids
	end

	return
end

function var_0_1.NeedRequestOptsData(arg_13_0)
	return not arg_13_0.siteRandomOpts
end

function var_0_1.initBuffs(arg_14_0, arg_14_1)
	arg_14_0.buffData = {}
	ipairs = var_2

	for iter_14_0, iter_14_1 in var_2(arg_14_1) do
		local var_14_0 = arg_14_0.buffData
		local var_14_1 = iter_14_1.id

		EducateBuff = var_1_10009
		var_14_0[var_14_1] = var_1_10009.New(iter_14_1)
	end

	return
end

function var_0_1.initPolaroids(arg_15_0, arg_15_1)
	arg_15_0.polaroidData = {}
	ipairs = var_2

	for iter_15_0, iter_15_1 in var_2(arg_15_1) do
		local var_15_0 = arg_15_0.polaroidData
		local var_15_1 = iter_15_1.id

		EducatePolaroid = var_1_10009
		var_15_0[var_15_1] = var_1_10009.New(iter_15_1)
	end

	return
end

function var_0_1.SetEndings(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.endings = arg_16_2
	arg_16_0.completeEndings = arg_16_1

	arg_16_0:updateSecretaryIDs(false)

	return
end

function var_0_1.IsFirstGame(arg_17_0)
	return arg_17_0.gameCount == 1
end

function var_0_1.GetGameCnt(arg_18_0)
	return arg_18_0.gameCount
end

function var_0_1.UpdateGameStatus(arg_19_0)
	EducateConst = var_1_10001
	arg_19_0.gameStatus = var_1_10001.STATUES_NORMAL

	if arg_19_0.exsitEnding then
		EducateConst = var_1
		arg_19_0.gameStatus = var_1.STATUES_RESET
	elseif arg_19_0:IsEndingTime() then
		EducateConst = var_1
		arg_19_0.gameStatus = var_1.STATUES_ENDING
	else
		local var_19_0 = arg_19_0.taskProxy

		if var_1.CheckTargetSet(var_19_0) then
			EducateConst = var_1
			arg_19_0.gameStatus = var_1.STATUES_PREPARE
		end
	end

	return
end

function var_0_1.GetGameStatus(arg_20_0)
	return arg_20_0.gameStatus
end

function var_0_1.initVirtualStage(arg_21_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10002

	local var_21_0 = var_1_10001(var_1_10002)
	local var_21_1 = var_1.GetTaskProxy(var_21_0)
	local var_21_2 = var_1.GetTargetId(var_21_1)
	local var_21_3 = arg_21_0.char
	local var_21_4 = var_2.GetStage(var_21_3)

	if var_21_2 ~= 0 then
		pg = var_21_3

		if var_21_3.child_target_set[var_21_2].stage == var_21_4 + 1 then
			arg_21_0.isVirtualStage = true

			goto label_21_0
		end
	end

	arg_21_0.isVirtualStage = false

	::label_21_0::

	return
end

function var_0_1.SetVirtualStage(arg_22_0, arg_22_1)
	arg_22_0.isVirtualStage = arg_22_1

	return
end

function var_0_1.InVirtualStage(arg_23_0)
	return arg_23_0.isVirtualStage
end

function var_0_1.Reset(arg_24_0, arg_24_1)
	EducateTipHelper = var_1_10002

	var_1_10002.ClearAllRecord()

	local var_24_0 = arg_24_0:GetPlanProxy()

	var_2.ClearLocalPlansData(var_24_0)

	local var_24_1 = arg_24_0
	local var_24_2 = arg_24_0.sendNotification

	GAME = var_1_10004

	var_24_2(var_24_1, var_1_10004.EDUCATE_REQUEST, {
		callback = arg_24_1
	})

	return
end

function var_0_1.Refresh(arg_25_0, arg_25_1)
	EducateTipHelper = var_1_10002

	var_1_10002.ClearAllRecord()

	local var_25_0 = arg_25_0:GetPlanProxy()

	var_2.ClearLocalPlansData(var_25_0)

	local var_25_1 = arg_25_0
	local var_25_2 = arg_25_0.sendNotification

	GAME = var_1_10004

	var_25_2(var_25_1, var_1_10004.EDUCATE_REQUEST, {
		callback = arg_25_1
	})

	return
end

function var_0_1.GetCurTime(arg_26_0)
	return arg_26_0.curTime
end

function var_0_1.UpdateTime(arg_27_0)
	arg_27_0.curTime.week = arg_27_0.curTime.week + 1

	if arg_27_0.curTime.week > 4 then
		arg_27_0.curTime.week = 1
		arg_27_0.curTime.month = arg_27_0.curTime.month + 1
	end

	return
end

function var_0_1.OnNextWeek(arg_28_0)
	arg_28_0:SetVirtualStage(false)
	arg_28_0:UpdateTime()

	local var_28_0 = arg_28_0.char

	var_1.OnNewWeek(var_28_0, arg_28_0.curTime)

	local var_28_1 = arg_28_0.planProxy

	var_1.OnNewWeek(var_28_1, arg_28_0.curTime)

	local var_28_2 = arg_28_0.eventProxy

	var_1.OnNewWeek(var_28_2, arg_28_0.curTime)

	local var_28_3 = arg_28_0.shopProxy

	var_1.OnNewWeek(var_28_3, arg_28_0.curTime)

	local var_28_4 = arg_28_0.taskProxy

	var_1.OnNewWeek(var_28_4, arg_28_0.curTime)
	arg_28_0:RefreshBuffs()
	arg_28_0:RefreshOptions()

	arg_28_0.siteRandomOpts = nil

	arg_28_0:UpdateGameStatus()
	arg_28_0:sendNotification(var_0_1.TIME_UPDATED)

	return
end

function var_0_1.GetCharData(arg_29_0)
	return arg_29_0.char
end

function var_0_1.GetPersonalityId(arg_30_0)
	local var_30_0 = arg_30_0.char

	return var_1.GetPersonalityId(var_30_0)
end

function var_0_1.UpdateRes(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.char

	var_3.UpdateRes(var_31_0, arg_31_1, arg_31_2)
	arg_31_0:sendNotification(var_0_1.RESOURCE_UPDATED)

	return
end

function var_0_1.ReduceResForPlans(arg_32_0)
	local var_32_0 = arg_32_0.planProxy
	local var_32_1, var_32_2 = var_1.GetCost(var_32_0)
	local var_32_3 = arg_32_0
	local var_32_4 = arg_32_0.UpdateRes

	EducateChar = var_1_10005

	var_32_4(var_32_3, var_1_10005.RES_MONEY_ID, -var_32_1)

	local var_32_5 = arg_32_0
	local var_32_6 = arg_32_0.UpdateRes

	EducateChar = var_5

	var_32_6(var_32_5, var_5.RES_MOOD_ID, -var_32_2)

	return
end

function var_0_1.ReduceResForCosts(arg_33_0, arg_33_1)
	ipairs = var_1_10002

	for iter_33_0, iter_33_1 in var_1_10002(arg_33_1) do
		arg_33_0:UpdateRes(iter_33_1.id, -iter_33_1.num)
	end

	return
end

function var_0_1.UpdateAttr(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.char

	var_3.UpdateAttr(var_34_0, arg_34_1, arg_34_2)
	arg_34_0:sendNotification(var_0_1.ATTR_UPDATED)

	return
end

function var_0_1.CheckExtraAttr(arg_35_0)
	local var_35_0 = arg_35_0.char

	return var_1.CheckExtraAttrAdd(var_35_0)
end

function var_0_1.AddExtraAttr(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.UpdateAttr
	local var_36_2 = arg_36_1
	local var_36_3 = arg_36_0.char

	var_36_1(var_36_0, var_36_2, var_5.getConfig(var_36_3, "attr_2_add"))

	local var_36_4 = arg_36_0.char

	var_2.SetIsAddedExtraAttr(var_36_4, true)

	return
end

function var_0_1.GetPlanProxy(arg_37_0)
	return arg_37_0.planProxy
end

function var_0_1.GetEventProxy(arg_38_0)
	return arg_38_0.eventProxy
end

function var_0_1.GetShopProxy(arg_39_0)
	return arg_39_0.shopProxy
end

function var_0_1.GetTaskProxy(arg_40_0)
	return arg_40_0.taskProxy
end

function var_0_1.GetAllEndings(arg_41_0)
	return arg_41_0.endings
end

function var_0_1.GetCompleteEndings(arg_42_0)
	return arg_42_0.completeEndings
end

function var_0_1.GetEndingBuyCnt(arg_43_0)
	return arg_43_0.endingBuyCnt
end

function var_0_1.AddEndingBuyCnt(arg_44_0)
	arg_44_0.endingBuyCnt = arg_44_0.endingBuyCnt + 1

	return
end

function var_0_1.AddEnding(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0.exsitEnding = true

	arg_45_0:UpdateGameStatus()

	table = var_3

	if not var_3.contains(arg_45_0.completeEndings, arg_45_1) then
		table = var_3

		var_3.insert(arg_45_0.completeEndings, arg_45_1)
	end

	local var_45_0 = false

	ipairs = var_4

	for iter_45_0, iter_45_1 in var_4(arg_45_2) do
		table = var_1_10009

		if not var_1_10009.contains(arg_45_0.endings, iter_45_1) then
			table = var_1_10009

			var_1_10009.insert(arg_45_0.endings, iter_45_1)

			var_45_0 = true
		end
	end

	if var_45_0 then
		arg_45_0:updateSecretaryIDs(true)
		arg_45_0:sendNotification(var_0_1.ENDING_ADDED)
	end

	return
end

function var_0_1.AddEndingFromBuy(arg_46_0, arg_46_1)
	table = var_1_10002

	if var_1_10002.contains(arg_46_0.endings, arg_46_1) then
		return
	end

	table = var_2

	var_2.insert(arg_46_0.endings, arg_46_1)
	arg_46_0:updateSecretaryIDs(true)
	arg_46_0:sendNotification(var_0_1.ENDING_ADDED)

	return
end

function var_0_1.IsEndingTime(arg_47_0)
	if arg_47_0:GetCurTime().month >= arg_47_0.endTime[1] and var_1.week >= arg_47_0.endTime[2] and var_1.day >= arg_47_0.endTime[3] then
		return true
	end

	return false
end

function var_0_1.GetEndingResult(arg_48_0)
	underscore = var_1_10001

	local var_48_0 = var_1_10001.select

	pg = var_1_10002

	local var_48_1 = var_48_0(var_1_10002.child_ending.all, function(arg_49_0)
		pg = var_2_10001

		local var_49_0 = var_2_10001.child_ending[arg_49_0].condition
		local var_49_1 = arg_48_0.char

		return var_2.CheckEndCondition(var_49_1, var_49_0)
	end)

	assert = var_2

	var_2(#var_48_1 > 0, "not matching ending")

	return var_48_1
end

function var_0_1.GetBuffData(arg_50_0)
	return arg_50_0.buffData
end

function var_0_1.GetBuffList(arg_51_0)
	local var_51_0 = {}

	pairs = var_1_10002

	for iter_51_0, iter_51_1 in var_1_10002(arg_51_0.buffData) do
		table = var_1_10007

		var_1_10007.insert(var_51_0, iter_51_1)
	end

	return var_51_0
end

function var_0_1.AddBuff(arg_52_0, arg_52_1)
	if arg_52_0.buffData[arg_52_1] then
		var_1_10003 = arg_52_0.buffData[arg_52_1]

		var_2.ResetEndTime(var_1_10003)
	else
		local var_52_0 = arg_52_0.buffData

		EducateBuff = var_1_10003
		var_52_0[arg_52_1] = var_1_10003.New({
			id = arg_52_1
		})
	end

	arg_52_0:sendNotification(var_0_1.BUFF_ADDED)

	return
end

function var_0_1.RefreshBuffs(arg_53_0)
	pairs = var_1_10001

	for iter_53_0, iter_53_1 in var_1_10001(arg_53_0.buffData) do
		if iter_53_1:IsEnd() then
			arg_53_0.buffData[iter_53_1.id] = nil
		end
	end

	return
end

function var_0_1.GetAttrBuffEffects(arg_54_0, arg_54_1)
	local var_54_0 = {}

	pairs = var_1_10003

	for iter_54_0, iter_54_1 in var_1_10003(arg_54_0.buffData) do
		if iter_54_1:IsAttrType() and iter_54_1:IsId(arg_54_1) then
			table = var_8

			var_8.insert(var_54_0, iter_54_1)
		end
	end

	EducateBuff = var_3

	return var_3.GetBuffEffects(var_54_0)
end

function var_0_1.GetResBuffEffects(arg_55_0, arg_55_1)
	local var_55_0 = {}

	pairs = var_1_10003

	for iter_55_0, iter_55_1 in var_1_10003(arg_55_0.buffData) do
		if iter_55_1:IsResType() and iter_55_1:IsId(arg_55_1) then
			table = var_8

			var_8.insert(var_55_0, iter_55_1)
		end
	end

	EducateBuff = var_3

	return var_3.GetBuffEffects(var_55_0)
end

function var_0_1.GetOptionById(arg_56_0, arg_56_1)
	return arg_56_0.siteOptionData[arg_56_1]
end

function var_0_1.UpdateOptionData(arg_57_0, arg_57_1)
	arg_57_0.siteOptionData[arg_57_1.id] = arg_57_1

	arg_57_0:sendNotification(var_0_1.OPTION_UPDATED)

	return
end

function var_0_1.RefreshOptions(arg_58_0)
	local var_58_0 = arg_58_0
	local var_58_1 = arg_58_0.GetCurTime(var_58_0)

	pairs = var_58_0

	for iter_58_0, iter_58_1 in var_58_0(arg_58_0.siteOptionData) do
		iter_58_1:OnWeekUpdate(var_58_1)
	end

	return
end

function var_0_1.GetShowSiteIds(arg_59_0)
	underscore = var_1_10001

	local var_59_0 = var_1_10001.select

	pg = var_1_10002

	return var_59_0(var_1_10002.child_site.all, function(arg_60_0)
		pg = var_2_10001

		local var_60_3

		if var_2_10001.child_site[arg_60_0].type == 1 then
			EducateHelper = var_2

			local var_60_0 = var_2.IsSiteUnlock
			local var_60_1 = arg_60_0
			local var_60_2 = arg_59_0

			var_60_3 = var_60_0(var_60_1, var_4.IsFirstGame(var_60_2))
		else
			var_60_3 = false
		end

		if false then
			var_60_3 = true
		end

		return var_60_3
	end)
end

function var_0_1.GetOptionsBySiteId(arg_61_0, arg_61_1)
	pg = var_1_10002

	local var_61_0 = var_1_10002.child_site[arg_61_1].option
	local var_61_1 = arg_61_0:GetCurTime()
	local var_61_2 = {}
	local var_61_3 = {}

	underscore = var_1_10006

	var_1_10006.each(var_61_0, function(arg_62_0)
		if arg_61_0.siteOptionData[arg_62_0] and var_1:IsShow(var_61_1) then
			local var_62_0

			if var_1:IsReplace() then
				var_62_0 = var_61_3
				var_62_0[var_1:getConfig("replace")] = var_1
			else
				table = var_62_0

				var_62_0.insert(var_61_2, var_1)
			end
		end

		return
	end)

	underscore = var_6

	var_6.each(var_61_2, function(arg_63_0)
		if var_61_3[arg_63_0.id] then
			table = var_1

			var_1.removebyvalue(var_61_2, arg_63_0)

			table = var_1

			var_1.insert(var_61_2, var_61_3[arg_63_0.id])
		end

		return
	end)

	local var_61_4

	if not arg_61_0.siteRandomOpts or not arg_61_0.siteRandomOpts[arg_61_1] then
		var_61_4 = {}
	end

	underscore = var_7

	var_7.each(var_61_4, function(arg_64_0)
		local var_64_0 = arg_61_0.siteOptionData[arg_64_0]

		if var_1.IsShow(var_64_0, var_61_1) then
			table = var_2

			var_2.insert(var_61_2, var_1)
		end

		return
	end)

	table = var_7

	local var_61_5 = var_7.sort
	local var_61_6 = var_61_2

	CompareFuncs = var_9

	var_61_5(var_61_6, var_9({
		function(arg_65_0)
			return arg_65_0:getConfig("order")
		end,
		function(arg_66_0)
			return arg_66_0.id
		end
	}))

	return var_61_2
end

function var_0_1.GetItemData(arg_67_0)
	return arg_67_0.itemData
end

function var_0_1.GetItemList(arg_68_0)
	local var_68_0 = {}

	pairs = var_1_10002

	for iter_68_0, iter_68_1 in var_1_10002(arg_68_0.itemData) do
		table = var_1_10007

		var_1_10007.insert(var_68_0, iter_68_1)
	end

	return var_68_0
end

function var_0_1.AddItem(arg_69_0, arg_69_1, arg_69_2)
	if arg_69_0.itemData[arg_69_1] then
		var_1_10004 = arg_69_0.itemData[arg_69_1]

		var_3.AddCount(var_1_10004, arg_69_2)
	else
		local var_69_0 = arg_69_0.itemData

		EducateItem = var_1_10004
		var_69_0[arg_69_1] = var_1_10004.New({
			id = arg_69_1,
			num = arg_69_2
		})
	end

	arg_69_0:sendNotification(var_0_1.ITEM_ADDED)

	return
end

function var_0_1.GetItemCntById(arg_70_0, arg_70_1)
	local var_70_0

	if not arg_70_0.itemData[arg_70_1] or not arg_70_0.itemData[arg_70_1].count then
		var_70_0 = 0
	end

	return var_70_0
end

function var_0_1.GetPolaroidData(arg_71_0)
	return arg_71_0.polaroidData
end

function var_0_1.GetPolaroidBuyCnt(arg_72_0)
	return arg_72_0.polaroidBuyCnt
end

function var_0_1.AddPolaroidBuyCnt(arg_73_0)
	arg_73_0.polaroidBuyCnt = arg_73_0.polaroidBuyCnt + 1

	return
end

function var_0_1.GetPolaroidList(arg_74_0)
	local var_74_0 = {}

	pairs = var_1_10002

	for iter_74_0, iter_74_1 in var_1_10002(arg_74_0.polaroidData) do
		table = var_1_10007

		var_1_10007.insert(var_74_0, iter_74_1)
	end

	return var_74_0
end

function var_0_1.GetPolaroidIdList(arg_75_0)
	local var_75_0 = {}

	pairs = var_1_10002

	for iter_75_0, iter_75_1 in var_1_10002(arg_75_0.polaroidData) do
		table = var_1_10007

		var_1_10007.insert(var_75_0, iter_75_0)
	end

	return var_75_0
end

function var_0_1.AddPolaroid(arg_76_0, arg_76_1)
	if arg_76_0.polaroidData[arg_76_1] then
		return
	end

	local var_76_0 = arg_76_0.polaroidData

	EducatePolaroid = var_1_10003
	var_76_0[arg_76_1] = var_1_10003.New({
		id = arg_76_1,
		time = arg_76_0:GetCurTime()
	})
	EducateTipHelper = var_76_0

	local var_76_1 = var_76_0.SetNewTip

	EducateTipHelper = var_3

	var_76_1(var_3.NEW_POLAROID)
	arg_76_0:updateSecretaryIDs(true)
	arg_76_0:sendNotification(var_0_1.POLAROID_ADDED)

	return
end

function var_0_1.IsExistPolaroidByGroup(arg_77_0, arg_77_1)
	pg = var_1_10002

	local var_77_0 = var_1_10002.child_polaroid.get_id_list_by_group[arg_77_1]

	underscore = var_1_10003

	return var_1_10003.any(var_77_0, function(arg_78_0)
		return arg_77_0.polaroidData[arg_78_0]
	end)
end

function var_0_1.CanGetPolaroidByGroup(arg_79_0, arg_79_1)
	pg = var_1_10002

	local var_79_0 = var_1_10002.child_polaroid.get_id_list_by_group[arg_79_1]

	underscore = var_1_10003

	return var_1_10003.any(var_79_0, function(arg_80_0)
		local var_80_0 = arg_79_0

		return var_1.CanGetPolaroidById(var_80_0, arg_80_0)
	end)
end

function var_0_1.CanGetPolaroidById(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0.char
	local var_81_1 = var_2.GetStage(var_81_0)
	local var_81_2 = arg_81_0
	local var_81_3 = arg_81_0.GetPersonalityId(var_81_2)

	pg = var_81_2

	local var_81_4 = var_81_2.child_polaroid[arg_81_1]

	table = var_1_10005

	if var_1_10005.contains(var_81_4.stage, var_81_1) then
		if var_81_4.xingge == "" then
			return true
		end

		table = var_5

		return var_5.contains(var_81_4.xingge, var_81_3)
	end

	return false
end

function var_0_1.GetPolaroidGroupCnt(arg_82_0)
	local var_82_0 = 0
	local var_82_1 = 0

	pairs = var_1_10003
	pg = var_1_10004

	for iter_82_0, iter_82_1 in var_1_10003(var_1_10004.child_polaroid.get_id_list_by_group) do
		if arg_82_0:IsExistPolaroidByGroup(iter_82_0) then
			var_82_0 = var_82_0 + 1
		end

		var_82_1 = var_82_1 + 1
	end

	return var_82_0, var_82_1
end

function var_0_1.GetMemories(arg_83_0)
	return arg_83_0.memories
end

function var_0_1.AddMemory(arg_84_0, arg_84_1)
	table = var_1_10002

	if var_1_10002.contains(arg_84_0.memories, arg_84_1) then
		return
	end

	table = var_2

	var_2.insert(arg_84_0.memories, arg_84_1)

	EducateTipHelper = var_2

	local var_84_0 = var_2.SetNewTip

	EducateTipHelper = var_3

	var_84_0(var_3.NEW_MEMORY, arg_84_1)
	arg_84_0:sendNotification(var_0_1.MEMORY_ADDED)

	return
end

function var_0_1.GetMemoryBuyCnt(arg_85_0)
	return arg_85_0.memoryBuyCnt
end

function var_0_1.CheckGuide(arg_86_0, arg_86_1, arg_86_2)
	arg_86_0:sendNotification(var_0_1.GUIDE_CHECK, {
		view = arg_86_1,
		popActivityWindow = arg_86_2
	})

	return
end

function var_0_1.AddMemoryBuyCnt(arg_87_0)
	arg_87_0.memoryBuyCnt = arg_87_0.memoryBuyCnt + 1

	return
end

function var_0_1.initUnlockSecretary(arg_88_0, arg_88_1)
	arg_88_0.isUnlockSecretary = arg_88_1
	arg_88_0.unlockSecretaryTaskId = (function()
		ipairs = var_2_10000
		pg = var_2_10001

		for iter_89_0, iter_89_1 in var_2_10000(var_2_10001.secretary_special_ship.all) do
			pg = var_2_10005
			var_2_10005 = var_2_10005.secretary_special_ship[iter_89_1].unlock_type
			EducateConst = var_2_10006

			if var_2_10005 == var_2_10006.SECRETARY_UNLCOK_TYPE_DEFAULT then
				pg = var_2_10005

				return var_2_10005.secretary_special_ship[iter_89_1].unlock[1]
			end
		end

		return
	end)()
	arg_88_0.unlcokTipByPolaroidCnt = {}
	ipairs = var_3
	pg = var_1_10004

	for iter_88_0, iter_88_1 in var_3(var_1_10004.secretary_special_ship.all) do
		pg = var_1_10008

		local var_88_0 = var_1_10008.secretary_special_ship[iter_88_1].unlock_type

		EducateConst = var_1_10010

		if var_88_0 == var_1_10010.SECRETARY_UNLCOK_TYPE_POLAROID then
			local var_88_1 = var_1_10008.unlock[1]

			table = var_1_10010

			if not var_1_10010.contains(arg_88_0.unlcokTipByPolaroidCnt, var_88_1) then
				table = var_1_10010

				var_1_10010.insert(arg_88_0.unlcokTipByPolaroidCnt, var_88_1)
			end
		end
	end

	return
end

function var_0_1.GetUnlockSecretaryTaskId(arg_90_0)
	return arg_90_0.unlockSecretaryTaskId
end

function var_0_1.SetSecretaryUnlock(arg_91_0)
	arg_91_0.isUnlockSecretary = true

	arg_91_0:updateSecretaryIDs(false)

	return
end

function var_0_1.CheckNewSecretaryTip(arg_92_0)
	local var_92_0 = arg_92_0
	local var_92_1 = arg_92_0.GetPolaroidGroupCnt(var_92_0)

	table = var_92_0

	if var_92_0.contains(arg_92_0.unlcokTipByPolaroidCnt, var_92_1) then
		arg_92_0:updateSecretaryIDs(false)
		arg_92_0:sendNotification(var_0_1.UNLCOK_NEW_SECRETARY_BY_CNT)

		return true
	end

	return false
end

function var_0_1.checkSecretaryID(arg_93_0, arg_93_1, arg_93_2)
	if arg_93_2 == "or" then
		ipairs = var_1_10003

		for iter_93_0, iter_93_1 in var_1_10003(arg_93_1) do
			table = var_1_10008

			if var_1_10008.contains(arg_93_0.endings, iter_93_1[1]) then
				return true
			end
		end

		return false
	elseif arg_93_2 == "and" then
		ipairs = var_1_10003

		for iter_93_2, iter_93_3 in var_1_10003(arg_93_1) do
			table = var_1_10008

			if not var_1_10008.contains(arg_93_0.endings, iter_93_3) then
				return false
			end

			return true
		end
	end

	return false
end

function var_0_1.updateSecretaryIDs(arg_94_0, arg_94_1)
	local var_94_0 = arg_94_0

	if not arg_94_0.IsUnlockSecretary(var_94_0) then
		arg_94_0.unlockSecretaryIds = {}

		return
	end

	local var_94_1

	if arg_94_1 then
		Clone = var_94_0
		NewEducateHelper = var_1_10004
		var_94_1 = var_94_0(var_1_10004.GetAllUnlockSecretaryIds())
	end

	arg_94_0.unlockSecretaryIds = {}

	local var_94_2, var_94_3 = arg_94_0:GetPolaroidGroupCnt()

	ipairs = var_1_10005
	pg = var_1_10006

	for iter_94_0, iter_94_1 in var_1_10005(var_1_10006.secretary_special_ship.get_id_list_by_tb_id[0]) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.secretary_special_ship[iter_94_1].unlock_type
		pg = var_1_10011
		var_1_10011 = var_1_10011.secretary_special_ship[iter_94_1].unlock
		switch = var_1_10012

		local var_94_4 = var_1_10010
		local var_94_5 = {}

		EducateConst = var_1_10015
		var_94_5[var_1_10015.SECRETARY_UNLCOK_TYPE_DEFAULT] = function()
			local var_95_0 = arg_94_0

			if var_0.IsUnlockSecretary(var_95_0) then
				table = var_0

				var_0.insert(arg_94_0.unlockSecretaryIds, iter_94_1)
			end

			return
		end
		EducateConst = var_1_10015
		var_94_5[var_1_10015.SECRETARY_UNLCOK_TYPE_POLAROID] = function()
			if var_1_10011[1] and var_94_2 >= var_1_10011[1] then
				table = var_0

				var_0.insert(arg_94_0.unlockSecretaryIds, iter_94_1)
			end

			return
		end
		EducateConst = var_1_10015
		var_94_5[var_1_10015.SECRETARY_UNLCOK_TYPE_ENDING] = function()
			if var_1_10011[1] then
				type = var_0

				if var_0(var_1_10011[1]) == "table" then
					local var_97_0 = arg_94_0

					if var_0.checkSecretaryID(var_97_0, var_1_10011, "or") then
						table = var_0

						var_0.insert(arg_94_0.unlockSecretaryIds, iter_94_1)
					end
				else
					type = var_0

					if var_0(var_1_10011[1]) == "number" then
						local var_97_1 = arg_94_0

						if var_0.checkSecretaryID(var_97_1, var_1_10011, "and") then
							table = var_0

							var_0.insert(arg_94_0.unlockSecretaryIds, iter_94_1)
						end
					end
				end
			end

			return
		end
		EducateConst = var_1_10015
		var_94_5[var_1_10015.SECRETARY_UNLCOK_TYPE_SHOP] = function()
			if var_1_10011[1] then
				getProxy = var_0
				ShipSkinProxy = var_2_10001

				local var_98_0 = var_0(var_2_10001)

				if var_0.hasSkin(var_98_0, var_1_10011[1]) then
					table = var_0

					var_0.insert(arg_94_0.unlockSecretaryIds, iter_94_1)
				end
			end

			return
		end
		EducateConst = var_1_10015
		var_94_5[var_1_10015.SECRETARY_UNLCOK_TYPE_STORY] = function()
			return
		end

		var_1_10012(var_94_4, var_94_5)
	end

	if arg_94_1 then
		getProxy = var_5
		SettingsProxy = var_6

		local var_94_6 = var_5(var_6)

		var_5.UpdateEducateCharTip(var_94_6, var_94_1)
	end

	return
end

function var_0_1.GetEducateGroupList(arg_100_0)
	local var_100_0 = {}

	pairs = var_1_10002
	pg = var_1_10003

	for iter_100_0, iter_100_1 in var_1_10002(var_1_10003.secretary_special_ship.get_id_list_by_group) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_100_1 = var_100_0

		EducateCharGroup = var_1_10009

		var_1_10007(var_100_1, var_1_10009.New(iter_100_0))
	end

	return var_100_0
end

function var_0_1.GetStoryInfo(arg_101_0)
	local var_101_0 = arg_101_0.char
	local var_101_1 = var_1.GetPaintingName(var_101_0)
	local var_101_2 = arg_101_0.char
	local var_101_3 = var_2.GetCallName(var_101_2)
	local var_101_4 = arg_101_0.char
	local var_101_5 = var_3.GetBGName(var_101_4)
end

function var_0_1.GetSecretaryIDs(arg_102_0)
	return arg_102_0.unlockSecretaryIds
end

function var_0_1.GetPolaroidCnt(arg_103_0)
	return #arg_103_0:GetPolaroidIdList()
end

function var_0_1.IsUnlockSecretary(arg_104_0)
	return arg_104_0.isUnlockSecretary
end

function var_0_1.remove(arg_105_0)
	return
end

return var_0_1
