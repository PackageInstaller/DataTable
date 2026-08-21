local var_0_0 = class("EducateProxy", import(".NetProxy"))

var_0_0.RESOURCE_UPDATED = "EducateProxy.RESOURCE_UPDATED"
var_0_0.ATTR_UPDATED = "EducateProxy.ATTR_UPDATED"
var_0_0.TIME_UPDATED = "EducateProxy.TIME_UPDATED"
var_0_0.TIME_WEEKDAY_UPDATED = "EducateProxy.TIME_WEEKDAY_UPDATED"
var_0_0.BUFF_ADDED = "EducateProxy.BUFF_ADDED"
var_0_0.OPTION_UPDATED = "EducateProxy.OPTION_UPDATED"
var_0_0.ENDING_ADDED = "EducateProxy.ENDING_ADDED"
var_0_0.ITEM_ADDED = "EducateProxy.ITEM_ADDED"
var_0_0.POLAROID_ADDED = "EducateProxy.POLAROID_ADDED"
var_0_0.MEMORY_ADDED = "EducateProxy.MEMORY_ADDED"
var_0_0.UNLCOK_NEW_SECRETARY_BY_CNT = "EducateProxy.UNLCOK_NEW_SECRETARY_BY_CNT"
var_0_0.GUIDE_CHECK = "EducateProxy.GUIDE_CHECK"
var_0_0.MAIN_SCENE_ADD_LAYER = "EducateProxy.MAIN_SCENE_ADD_LAYER"
var_0_0.CLEAR_NEW_TIP = "EducateProxy.CLEAR_NEW_TIP"

function var_0_0.register(arg_1_0)
	arg_1_0.planProxy = EducatePlanProxy.New(arg_1_0)
	arg_1_0.eventProxy = EducateEventProxy.New(arg_1_0)
	arg_1_0.shopProxy = EducateShopProxy.New(arg_1_0)
	arg_1_0.taskProxy = EducateTaskProxy.New(arg_1_0)
	arg_1_0.endTime = pg.gameset.child_end_data.description

	arg_1_0:on(27021, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.tasks) do
			arg_1_0.taskProxy:AddTask(iter_2_1)
		end

		return
	end)
	arg_1_0:on(27022, function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.ids) do
			arg_1_0.taskProxy:RemoveTaskById(iter_3_1)
		end

		return
	end)
	arg_1_0:on(27025, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.tasks) do
			arg_1_0.taskProxy:UpdateTask(iter_4_1)
		end

		return
	end)

	return
end

function var_0_0.initData(arg_5_0, arg_5_1)
	arg_5_0:sendNotification(GAME.EDUCATE_GET_ENDINGS)

	local var_5_0 = arg_5_1.child

	arg_5_0.exsitEnding = arg_5_1.child.is_ending == 1 or false
	arg_5_0.gameCount = var_5_0.new_game_plus_count
	arg_5_0.curTime = var_5_0.cur_time or {
		week = 1,
		month = 3,
		day = 7
	}
	arg_5_0.char = EducateChar.New(var_5_0)

	arg_5_0.eventProxy:SetUp({
		waitTriggerEventIds = var_5_0.home_events,
		needRequestHomeEvents = var_5_0.can_trigger_home_event == 1 or false,
		finishSpecEventIds = var_5_0.spec_events
	})
	arg_5_0.planProxy:SetUp({
		history = var_5_0.plan_history,
		selectedPlans = var_5_0.plans
	})
	arg_5_0.shopProxy:SetUp({
		shops = var_5_0.shop,
		discountEventIds = var_5_0.discount_event_id
	})
	arg_5_0.taskProxy:SetUp({
		targetId = var_5_0.target,
		tasks = var_5_0.tasks,
		finishMindTaskIds = var_5_0.realized_wish,
		isGotTargetAward = var_5_0.had_target_stage_award == 1 or false
	})
	arg_5_0:initItems(var_5_0.items)
	arg_5_0:initPolaroids(var_5_0.polaroids)

	arg_5_0.memories = var_5_0.memorys

	arg_5_0:initBuffs(var_5_0.buffs)
	arg_5_0:initOptions(var_5_0.option_records)

	arg_5_0.siteRandomOpts = nil

	arg_5_0:UpdateGameStatus()
	arg_5_0:initVirtualStage()
	arg_5_0:initUnlockSecretary(var_5_0.is_special_secretary_valid == 1)

	arg_5_0.endingBuyCnt = var_5_0.ending_buy_count
	arg_5_0.memoryBuyCnt = var_5_0.memory_buy_count
	arg_5_0.polaroidBuyCnt = var_5_0.polaroid_buy_count
	arg_5_0.requestDataEnd = true

	return
end

function var_0_0.CheckDataRequestEnd(arg_6_0)
	return arg_6_0.requestDataEnd
end

function var_0_0.GetSelectInfo(arg_7_0)
	local var_7_0 = EducateHelper.GetShowMonthNumber(arg_7_0.curTime.month) .. i18n("word_month") .. i18n("word_which_week", arg_7_0.curTime.week)

	return {
		bg = arg_7_0.char:GetBGName(),
		name = arg_7_0.char:GetName(),
		gameCnt = arg_7_0.gameCount,
		progressStr = arg_7_0.isUnlockSecretary and var_7_0 or i18n("child2_not_start")
	}
end

function var_0_0.CheckGuide(arg_8_0, arg_8_1)
	arg_8_0:sendNotification(var_0_0.GUIDE_CHECK, {
		view = arg_8_1
	})

	return
end

function var_0_0.MainAddLayer(arg_9_0, arg_9_1)
	arg_9_0:sendNotification(var_0_0.MAIN_SCENE_ADD_LAYER, arg_9_1)

	return
end

function var_0_0.initItems(arg_10_0, arg_10_1)
	arg_10_0.itemData = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		arg_10_0.itemData[iter_10_1.id] = EducateItem.New(iter_10_1)
	end

	return
end

function var_0_0.initOptions(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		({})[iter_11_1.id] = iter_11_1.count
	end

	arg_11_0.siteOptionData = {}

	for iter_11_2, iter_11_3 in ipairs(pg.child_site_option.all) do
		arg_11_0.siteOptionData[iter_11_3] = EducateSiteOption.New(iter_11_3, ({})[iter_11_3])
	end

	return
end

function var_0_0.initRandomOpts(arg_12_0, arg_12_1)
	arg_12_0.siteRandomOpts = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		arg_12_0.siteRandomOpts[iter_12_1.site_id] = iter_12_1.option_ids
	end

	return
end

function var_0_0.NeedRequestOptsData(arg_13_0)
	return not arg_13_0.siteRandomOpts
end

function var_0_0.initBuffs(arg_14_0, arg_14_1)
	arg_14_0.buffData = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		arg_14_0.buffData[iter_14_1.id] = EducateBuff.New(iter_14_1)
	end

	return
end

function var_0_0.initPolaroids(arg_15_0, arg_15_1)
	arg_15_0.polaroidData = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		arg_15_0.polaroidData[iter_15_1.id] = EducatePolaroid.New(iter_15_1)
	end

	return
end

function var_0_0.SetEndings(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.endings = arg_16_2
	arg_16_0.completeEndings = arg_16_1

	arg_16_0:updateSecretaryIDs(false)

	return
end

function var_0_0.IsFirstGame(arg_17_0)
	return arg_17_0.gameCount == 1
end

function var_0_0.GetGameCnt(arg_18_0)
	return arg_18_0.gameCount
end

function var_0_0.UpdateGameStatus(arg_19_0)
	arg_19_0.gameStatus = EducateConst.STATUES_NORMAL

	if arg_19_0.exsitEnding then
		arg_19_0.gameStatus = EducateConst.STATUES_RESET
	elseif arg_19_0:IsEndingTime() then
		arg_19_0.gameStatus = EducateConst.STATUES_ENDING
	elseif arg_19_0.taskProxy:CheckTargetSet() then
		arg_19_0.gameStatus = EducateConst.STATUES_PREPARE
	end

	return
end

function var_0_0.GetGameStatus(arg_20_0)
	return arg_20_0.gameStatus
end

function var_0_0.initVirtualStage(arg_21_0)
	local var_21_0 = getProxy(EducateProxy):GetTaskProxy():GetTargetId()

	arg_21_0.isVirtualStage = var_21_0 ~= 0 and pg.child_target_set[var_21_0].stage == arg_21_0.char:GetStage() + 1

	return
end

function var_0_0.SetVirtualStage(arg_22_0, arg_22_1)
	arg_22_0.isVirtualStage = arg_22_1

	return
end

function var_0_0.InVirtualStage(arg_23_0)
	return arg_23_0.isVirtualStage
end

function var_0_0.Reset(arg_24_0, arg_24_1)
	EducateTipHelper.ClearAllRecord()
	arg_24_0:GetPlanProxy():ClearLocalPlansData()
	arg_24_0:sendNotification(GAME.EDUCATE_REQUEST, {
		callback = arg_24_1
	})

	return
end

function var_0_0.Refresh(arg_25_0, arg_25_1)
	EducateTipHelper.ClearAllRecord()
	arg_25_0:GetPlanProxy():ClearLocalPlansData()
	arg_25_0:sendNotification(GAME.EDUCATE_REQUEST, {
		callback = arg_25_1
	})

	return
end

function var_0_0.GetCurTime(arg_26_0)
	return arg_26_0.curTime
end

function var_0_0.UpdateTime(arg_27_0)
	arg_27_0.curTime.week = arg_27_0.curTime.week + 1

	if arg_27_0.curTime.week > 4 then
		arg_27_0.curTime.week = 1
		arg_27_0.curTime.month = arg_27_0.curTime.month + 1
	end

	return
end

function var_0_0.OnNextWeek(arg_28_0)
	arg_28_0:SetVirtualStage(false)
	arg_28_0:UpdateTime()
	arg_28_0.char:OnNewWeek(arg_28_0.curTime)
	arg_28_0.planProxy:OnNewWeek(arg_28_0.curTime)
	arg_28_0.eventProxy:OnNewWeek(arg_28_0.curTime)
	arg_28_0.shopProxy:OnNewWeek(arg_28_0.curTime)
	arg_28_0.taskProxy:OnNewWeek(arg_28_0.curTime)
	arg_28_0:RefreshBuffs()
	arg_28_0:RefreshOptions()

	arg_28_0.siteRandomOpts = nil

	arg_28_0:UpdateGameStatus()
	arg_28_0:sendNotification(var_0_0.TIME_UPDATED)

	return
end

function var_0_0.GetCharData(arg_29_0)
	return arg_29_0.char
end

function var_0_0.GetPersonalityId(arg_30_0)
	return arg_30_0.char:GetPersonalityId()
end

function var_0_0.UpdateRes(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.char:UpdateRes(arg_31_1, arg_31_2)
	arg_31_0:sendNotification(var_0_0.RESOURCE_UPDATED)

	return
end

function var_0_0.ReduceResForPlans(arg_32_0)
	local var_32_0, var_32_1 = arg_32_0.planProxy:GetCost()

	arg_32_0:UpdateRes(EducateChar.RES_MONEY_ID, -var_32_0)
	arg_32_0:UpdateRes(EducateChar.RES_MOOD_ID, -var_32_1)

	return
end

function var_0_0.ReduceResForCosts(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		arg_33_0:UpdateRes(iter_33_1.id, -iter_33_1.num)
	end

	return
end

function var_0_0.UpdateAttr(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.char:UpdateAttr(arg_34_1, arg_34_2)
	arg_34_0:sendNotification(var_0_0.ATTR_UPDATED)

	return
end

function var_0_0.CheckExtraAttr(arg_35_0)
	return arg_35_0.char:CheckExtraAttrAdd()
end

function var_0_0.AddExtraAttr(arg_36_0, arg_36_1)
	arg_36_0:UpdateAttr(arg_36_1, arg_36_0.char:getConfig("attr_2_add"))
	arg_36_0.char:SetIsAddedExtraAttr(true)

	return
end

function var_0_0.GetPlanProxy(arg_37_0)
	return arg_37_0.planProxy
end

function var_0_0.GetEventProxy(arg_38_0)
	return arg_38_0.eventProxy
end

function var_0_0.GetShopProxy(arg_39_0)
	return arg_39_0.shopProxy
end

function var_0_0.GetTaskProxy(arg_40_0)
	return arg_40_0.taskProxy
end

function var_0_0.GetAllEndings(arg_41_0)
	return arg_41_0.endings
end

function var_0_0.GetCompleteEndings(arg_42_0)
	return arg_42_0.completeEndings
end

function var_0_0.GetEndingBuyCnt(arg_43_0)
	return arg_43_0.endingBuyCnt
end

function var_0_0.AddEndingBuyCnt(arg_44_0)
	arg_44_0.endingBuyCnt = arg_44_0.endingBuyCnt + 1

	return
end

function var_0_0.AddEnding(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0.exsitEnding = true

	arg_45_0:UpdateGameStatus()

	if not table.contains(arg_45_0.completeEndings, arg_45_1) then
		table.insert(arg_45_0.completeEndings, arg_45_1)
	end

	local var_45_0 = false

	for iter_45_0, iter_45_1 in ipairs(arg_45_2) do
		if not table.contains(arg_45_0.endings, iter_45_1) then
			table.insert(arg_45_0.endings, iter_45_1)

			var_45_0 = true
		end
	end

	if var_45_0 then
		arg_45_0:updateSecretaryIDs(true)
		arg_45_0:sendNotification(var_0_0.ENDING_ADDED)
	end

	return
end

function var_0_0.AddEndingFromBuy(arg_46_0, arg_46_1)
	if table.contains(arg_46_0.endings, arg_46_1) then
		return
	end

	table.insert(arg_46_0.endings, arg_46_1)
	arg_46_0:updateSecretaryIDs(true)
	arg_46_0:sendNotification(var_0_0.ENDING_ADDED)

	return
end

function var_0_0.IsEndingTime(arg_47_0)
	local var_47_0 = arg_47_0:GetCurTime()

	if var_47_0.month >= arg_47_0.endTime[1] and var_47_0.week >= arg_47_0.endTime[2] and var_47_0.day >= arg_47_0.endTime[3] then
		return true
	end

	return false
end

function var_0_0.GetEndingResult(arg_48_0)
	local var_48_0 = underscore.select(pg.child_ending.all, function(arg_49_0)
		return arg_48_0.char:CheckEndCondition(pg.child_ending[arg_49_0].condition)
	end)

	assert(#var_48_0 > 0, "not matching ending")

	return var_48_0
end

function var_0_0.GetBuffData(arg_50_0)
	return arg_50_0.buffData
end

function var_0_0.GetBuffList(arg_51_0)
	for iter_51_0, iter_51_1 in pairs(arg_51_0.buffData) do
		table.insert({}, iter_51_1)
	end

	return {}
end

function var_0_0.AddBuff(arg_52_0, arg_52_1)
	if arg_52_0.buffData[arg_52_1] then
		arg_52_0.buffData[arg_52_1]:ResetEndTime()
	else
		arg_52_0.buffData[arg_52_1] = EducateBuff.New({
			id = arg_52_1
		})
	end

	arg_52_0:sendNotification(var_0_0.BUFF_ADDED)

	return
end

function var_0_0.RefreshBuffs(arg_53_0)
	for iter_53_0, iter_53_1 in pairs(arg_53_0.buffData) do
		if iter_53_1:IsEnd() then
			arg_53_0.buffData[iter_53_1.id] = nil
		end
	end

	return
end

function var_0_0.GetAttrBuffEffects(arg_54_0, arg_54_1)
	for iter_54_0, iter_54_1 in pairs(arg_54_0.buffData) do
		if iter_54_1:IsAttrType() and iter_54_1:IsId(arg_54_1) then
			table.insert({}, iter_54_1)
		end
	end

	return EducateBuff.GetBuffEffects({})
end

function var_0_0.GetResBuffEffects(arg_55_0, arg_55_1)
	for iter_55_0, iter_55_1 in pairs(arg_55_0.buffData) do
		if iter_55_1:IsResType() and iter_55_1:IsId(arg_55_1) then
			table.insert({}, iter_55_1)
		end
	end

	return EducateBuff.GetBuffEffects({})
end

function var_0_0.GetOptionById(arg_56_0, arg_56_1)
	return arg_56_0.siteOptionData[arg_56_1]
end

function var_0_0.UpdateOptionData(arg_57_0, arg_57_1)
	arg_57_0.siteOptionData[arg_57_1.id] = arg_57_1

	arg_57_0:sendNotification(var_0_0.OPTION_UPDATED)

	return
end

function var_0_0.RefreshOptions(arg_58_0)
	local var_58_0 = arg_58_0:GetCurTime()

	for iter_58_0, iter_58_1 in pairs(arg_58_0.siteOptionData) do
		iter_58_1:OnWeekUpdate(var_58_0)
	end

	return
end

function var_0_0.GetShowSiteIds(arg_59_0)
	return underscore.select(pg.child_site.all, function(arg_60_0)
		return pg.child_site[arg_60_0].type == 1 and EducateHelper.IsSiteUnlock(arg_60_0, arg_59_0:IsFirstGame())
	end)
end

function var_0_0.GetOptionsBySiteId(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:GetCurTime()
	local var_61_1 = {}
	local var_61_2 = {}

	underscore.each(pg.child_site[arg_61_1].option, function(arg_62_0)
		if arg_61_0.siteOptionData[arg_62_0] and arg_61_0.siteOptionData[arg_62_0]:IsShow(var_61_0) then
			if arg_61_0.siteOptionData[arg_62_0]:IsReplace() then
				var_61_2[arg_61_0.siteOptionData[arg_62_0]:getConfig("replace")] = arg_61_0.siteOptionData[arg_62_0]
			else
				table.insert(var_61_1, arg_61_0.siteOptionData[arg_62_0])
			end
		end

		return
	end)
	underscore.each(var_61_1, function(arg_63_0)
		if var_61_2[arg_63_0.id] then
			table.removebyvalue(var_61_1, arg_63_0)
			table.insert(var_61_1, var_61_2[arg_63_0.id])
		end

		return
	end)

	if arg_61_0.siteRandomOpts then
		local var_61_3 = arg_61_0.siteRandomOpts[arg_61_1] or {}

		underscore.each(var_61_3, function(arg_64_0)
			if arg_61_0.siteOptionData[arg_64_0]:IsShow(var_61_0) then
				table.insert(var_61_1, arg_61_0.siteOptionData[arg_64_0])
			end

			return
		end)
		table.sort(var_61_1, CompareFuncs({
			function(arg_65_0)
				return arg_65_0:getConfig("order")
			end,
			function(arg_66_0)
				return arg_66_0.id
			end
		}))

		return var_61_1
	end
end

function var_0_0.GetItemData(arg_67_0)
	return arg_67_0.itemData
end

function var_0_0.GetItemList(arg_68_0)
	for iter_68_0, iter_68_1 in pairs(arg_68_0.itemData) do
		table.insert({}, iter_68_1)
	end

	return {}
end

function var_0_0.AddItem(arg_69_0, arg_69_1, arg_69_2)
	if arg_69_0.itemData[arg_69_1] then
		arg_69_0.itemData[arg_69_1]:AddCount(arg_69_2)
	else
		arg_69_0.itemData[arg_69_1] = EducateItem.New({
			id = arg_69_1,
			num = arg_69_2
		})
	end

	arg_69_0:sendNotification(var_0_0.ITEM_ADDED)

	return
end

function var_0_0.GetItemCntById(arg_70_0, arg_70_1)
	if arg_70_0.itemData[arg_70_1] then
		return arg_70_0.itemData[arg_70_1].count or 0
	end
end

function var_0_0.GetPolaroidData(arg_71_0)
	return arg_71_0.polaroidData
end

function var_0_0.GetPolaroidBuyCnt(arg_72_0)
	return arg_72_0.polaroidBuyCnt
end

function var_0_0.AddPolaroidBuyCnt(arg_73_0)
	arg_73_0.polaroidBuyCnt = arg_73_0.polaroidBuyCnt + 1

	return
end

function var_0_0.GetPolaroidList(arg_74_0)
	for iter_74_0, iter_74_1 in pairs(arg_74_0.polaroidData) do
		table.insert({}, iter_74_1)
	end

	return {}
end

function var_0_0.GetPolaroidIdList(arg_75_0)
	for iter_75_0, iter_75_1 in pairs(arg_75_0.polaroidData) do
		table.insert({}, iter_75_0)
	end

	return {}
end

function var_0_0.AddPolaroid(arg_76_0, arg_76_1)
	if arg_76_0.polaroidData[arg_76_1] then
		return
	end

	arg_76_0.polaroidData[arg_76_1] = EducatePolaroid.New({
		id = arg_76_1,
		time = arg_76_0:GetCurTime()
	})

	EducateTipHelper.SetNewTip(EducateTipHelper.NEW_POLAROID)
	arg_76_0:updateSecretaryIDs(true)
	arg_76_0:sendNotification(var_0_0.POLAROID_ADDED)

	return
end

function var_0_0.IsExistPolaroidByGroup(arg_77_0, arg_77_1)
	return underscore.any(pg.child_polaroid.get_id_list_by_group[arg_77_1], function(arg_78_0)
		return arg_77_0.polaroidData[arg_78_0]
	end)
end

function var_0_0.CanGetPolaroidByGroup(arg_79_0, arg_79_1)
	return underscore.any(pg.child_polaroid.get_id_list_by_group[arg_79_1], function(arg_80_0)
		return arg_79_0:CanGetPolaroidById(arg_80_0)
	end)
end

function var_0_0.CanGetPolaroidById(arg_81_0, arg_81_1)
	if table.contains(pg.child_polaroid[arg_81_1].stage, (arg_81_0.char:GetStage())) then
		if pg.child_polaroid[arg_81_1].xingge == "" then
			return true
		end

		return table.contains(pg.child_polaroid[arg_81_1].xingge, (arg_81_0:GetPersonalityId()))
	end

	return false
end

function var_0_0.GetPolaroidGroupCnt(arg_82_0)
	local var_82_0 = 0
	local var_82_1 = 0

	for iter_82_0, iter_82_1 in pairs(pg.child_polaroid.get_id_list_by_group) do
		if arg_82_0:IsExistPolaroidByGroup(iter_82_0) then
			var_82_0 = var_82_0 + 1
		end

		var_82_1 = var_82_1 + 1
	end

	return var_82_0, var_82_1
end

function var_0_0.GetMemories(arg_83_0)
	return arg_83_0.memories
end

function var_0_0.AddMemory(arg_84_0, arg_84_1)
	if table.contains(arg_84_0.memories, arg_84_1) then
		return
	end

	table.insert(arg_84_0.memories, arg_84_1)
	EducateTipHelper.SetNewTip(EducateTipHelper.NEW_MEMORY, arg_84_1)
	arg_84_0:sendNotification(var_0_0.MEMORY_ADDED)

	return
end

function var_0_0.GetMemoryBuyCnt(arg_85_0)
	return arg_85_0.memoryBuyCnt
end

function var_0_0.CheckGuide(arg_86_0, arg_86_1, arg_86_2)
	arg_86_0:sendNotification(var_0_0.GUIDE_CHECK, {
		view = arg_86_1,
		popActivityWindow = arg_86_2
	})

	return
end

function var_0_0.AddMemoryBuyCnt(arg_87_0)
	arg_87_0.memoryBuyCnt = arg_87_0.memoryBuyCnt + 1

	return
end

function var_0_0.initUnlockSecretary(arg_88_0, arg_88_1)
	arg_88_0.isUnlockSecretary = arg_88_1
	arg_88_0.unlockSecretaryTaskId = (function()
		for iter_89_0, iter_89_1 in ipairs(pg.secretary_special_ship.all) do
			if pg.secretary_special_ship[iter_89_1].unlock_type == EducateConst.SECRETARY_UNLCOK_TYPE_DEFAULT then
				return pg.secretary_special_ship[iter_89_1].unlock[1]
			end
		end

		return
	end)()
	arg_88_0.unlcokTipByPolaroidCnt = {}

	for iter_88_0, iter_88_1 in ipairs(pg.secretary_special_ship.all) do
		if pg.secretary_special_ship[iter_88_1].unlock_type == EducateConst.SECRETARY_UNLCOK_TYPE_POLAROID then
			if not table.contains(arg_88_0.unlcokTipByPolaroidCnt, pg.secretary_special_ship[iter_88_1].unlock[1]) then
				table.insert(arg_88_0.unlcokTipByPolaroidCnt, pg.secretary_special_ship[iter_88_1].unlock[1])
			end
		end
	end

	return
end

function var_0_0.GetUnlockSecretaryTaskId(arg_90_0)
	return arg_90_0.unlockSecretaryTaskId
end

function var_0_0.SetSecretaryUnlock(arg_91_0)
	arg_91_0.isUnlockSecretary = true

	arg_91_0:updateSecretaryIDs(false)

	return
end

function var_0_0.CheckNewSecretaryTip(arg_92_0)
	if table.contains(arg_92_0.unlcokTipByPolaroidCnt, (arg_92_0:GetPolaroidGroupCnt())) then
		arg_92_0:updateSecretaryIDs(false)
		arg_92_0:sendNotification(var_0_0.UNLCOK_NEW_SECRETARY_BY_CNT)

		return true
	end

	return false
end

function var_0_0.checkSecretaryID(arg_93_0, arg_93_1, arg_93_2)
	if arg_93_2 == "or" then
		for iter_93_0, iter_93_1 in ipairs(arg_93_1) do
			if table.contains(arg_93_0.endings, iter_93_1[1]) then
				return true
			end
		end

		return false
	elseif arg_93_2 == "and" then
		for iter_93_2, iter_93_3 in ipairs(arg_93_1) do
			if not table.contains(arg_93_0.endings, iter_93_3) then
				return false
			end

			return true
		end
	end

	return false
end

function var_0_0.updateSecretaryIDs(arg_94_0, arg_94_1)
	if not arg_94_0:IsUnlockSecretary() then
		arg_94_0.unlockSecretaryIds = {}

		return
	end

	local var_94_0

	if arg_94_1 then
		var_94_0 = Clone(NewEducateHelper.GetAllUnlockSecretaryIds())
	end

	arg_94_0.unlockSecretaryIds = {}

	local var_94_1, var_94_2 = arg_94_0:GetPolaroidGroupCnt()

	for iter_94_0, iter_94_1 in ipairs(pg.secretary_special_ship.get_id_list_by_tb_id[0]) do
		local var_94_3 = pg.secretary_special_ship[iter_94_1].unlock

		switch(pg.secretary_special_ship[iter_94_1].unlock_type, {
			[EducateConst.SECRETARY_UNLCOK_TYPE_DEFAULT] = function()
				if arg_94_0:IsUnlockSecretary() then
					table.insert(arg_94_0.unlockSecretaryIds, iter_94_1)
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_POLAROID] = function()
				if var_94_3[1] and var_94_1 >= var_94_3[1] then
					table.insert(arg_94_0.unlockSecretaryIds, iter_94_1)
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_ENDING] = function()
				if var_94_3[1] then
					if type(var_94_3[1]) == "table" then
						if arg_94_0:checkSecretaryID(var_94_3, "or") then
							table.insert(arg_94_0.unlockSecretaryIds, iter_94_1)
						end
					elseif type(var_94_3[1]) == "number" and arg_94_0:checkSecretaryID(var_94_3, "and") then
						table.insert(arg_94_0.unlockSecretaryIds, iter_94_1)
					end
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_SHOP] = function()
				if var_94_3[1] then
					if getProxy(ShipSkinProxy):hasSkin(var_94_3[1]) then
						table.insert(arg_94_0.unlockSecretaryIds, iter_94_1)
					end
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_STORY] = function()
				return
			end
		})
	end

	if arg_94_1 then
		getProxy(SettingsProxy):UpdateEducateCharTip(var_94_0)
	end

	return
end

function var_0_0.GetEducateGroupList(arg_100_0)
	for iter_100_0, iter_100_1 in pairs(pg.secretary_special_ship.get_id_list_by_group) do
		table.insert({}, EducateCharGroup.New(iter_100_0))
	end

	return {}
end

function var_0_0.GetStoryInfo(arg_101_0)
	local var_101_0 = arg_101_0.char:GetPaintingName()
	local var_101_1 = arg_101_0.char:GetCallName()
	local var_101_2 = arg_101_0.char:GetBGName()
end

function var_0_0.GetSecretaryIDs(arg_102_0)
	return arg_102_0.unlockSecretaryIds
end

function var_0_0.GetPolaroidCnt(arg_103_0)
	return #arg_103_0:GetPolaroidIdList()
end

function var_0_0.IsUnlockSecretary(arg_104_0)
	return arg_104_0.isUnlockSecretary
end

function var_0_0.remove(arg_105_0)
	return
end

return var_0_0
