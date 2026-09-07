local EducateProxy = class("EducateProxy", import(".NetProxy"))

EducateProxy.RESOURCE_UPDATED = "EducateProxy.RESOURCE_UPDATED"
EducateProxy.ATTR_UPDATED = "EducateProxy.ATTR_UPDATED"
EducateProxy.TIME_UPDATED = "EducateProxy.TIME_UPDATED"
EducateProxy.TIME_WEEKDAY_UPDATED = "EducateProxy.TIME_WEEKDAY_UPDATED"
EducateProxy.BUFF_ADDED = "EducateProxy.BUFF_ADDED"
EducateProxy.OPTION_UPDATED = "EducateProxy.OPTION_UPDATED"
EducateProxy.ENDING_ADDED = "EducateProxy.ENDING_ADDED"
EducateProxy.ITEM_ADDED = "EducateProxy.ITEM_ADDED"
EducateProxy.POLAROID_ADDED = "EducateProxy.POLAROID_ADDED"
EducateProxy.MEMORY_ADDED = "EducateProxy.MEMORY_ADDED"
EducateProxy.UNLCOK_NEW_SECRETARY_BY_CNT = "EducateProxy.UNLCOK_NEW_SECRETARY_BY_CNT"
EducateProxy.GUIDE_CHECK = "EducateProxy.GUIDE_CHECK"
EducateProxy.MAIN_SCENE_ADD_LAYER = "EducateProxy.MAIN_SCENE_ADD_LAYER"
EducateProxy.CLEAR_NEW_TIP = "EducateProxy.CLEAR_NEW_TIP"

function EducateProxy:register()
	self.planProxy = EducatePlanProxy.New(self)
	self.eventProxy = EducateEventProxy.New(self)
	self.shopProxy = EducateShopProxy.New(self)
	self.taskProxy = EducateTaskProxy.New(self)
	self.endTime = pg.gameset.child_end_data.description

	self:on(27021, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.tasks) do
			self.taskProxy:AddTask(iter_2_1)
		end

		return
	end)
	self:on(27022, function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.ids) do
			self.taskProxy:RemoveTaskById(iter_3_1)
		end

		return
	end)
	self:on(27025, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.tasks) do
			self.taskProxy:UpdateTask(iter_4_1)
		end

		return
	end)

	return
end

function EducateProxy:initData(arg_5_1)
	self:sendNotification(GAME.EDUCATE_GET_ENDINGS)

	local var_5_0 = arg_5_1.child

	self.exsitEnding = arg_5_1.child.is_ending == 1 or false
	self.gameCount = var_5_0.new_game_plus_count
	self.curTime = var_5_0.cur_time or {
		week = 1,
		month = 3,
		day = 7
	}
	self.char = EducateChar.New(var_5_0)

	self.eventProxy:SetUp({
		waitTriggerEventIds = var_5_0.home_events,
		needRequestHomeEvents = var_5_0.can_trigger_home_event == 1 or false,
		finishSpecEventIds = var_5_0.spec_events
	})
	self.planProxy:SetUp({
		history = var_5_0.plan_history,
		selectedPlans = var_5_0.plans
	})
	self.shopProxy:SetUp({
		shops = var_5_0.shop,
		discountEventIds = var_5_0.discount_event_id
	})
	self.taskProxy:SetUp({
		targetId = var_5_0.target,
		tasks = var_5_0.tasks,
		finishMindTaskIds = var_5_0.realized_wish,
		isGotTargetAward = var_5_0.had_target_stage_award == 1 or false
	})
	self:initItems(var_5_0.items)
	self:initPolaroids(var_5_0.polaroids)

	self.memories = var_5_0.memorys

	self:initBuffs(var_5_0.buffs)
	self:initOptions(var_5_0.option_records)

	self.siteRandomOpts = nil

	self:UpdateGameStatus()
	self:initVirtualStage()
	self:initUnlockSecretary(var_5_0.is_special_secretary_valid == 1)

	self.endingBuyCnt = var_5_0.ending_buy_count
	self.memoryBuyCnt = var_5_0.memory_buy_count
	self.polaroidBuyCnt = var_5_0.polaroid_buy_count
	self.requestDataEnd = true

	return
end

function EducateProxy:CheckDataRequestEnd()
	return self.requestDataEnd
end

function EducateProxy:GetSelectInfo()
	local var_7_0 = EducateHelper.GetShowMonthNumber(self.curTime.month) .. i18n("word_month") .. i18n("word_which_week", self.curTime.week)

	return {
		bg = self.char:GetBGName(),
		name = self.char:GetName(),
		gameCnt = self.gameCount,
		progressStr = self.isUnlockSecretary and var_7_0 or i18n("child2_not_start")
	}
end

function EducateProxy:CheckGuide(arg_8_1)
	self:sendNotification(EducateProxy.GUIDE_CHECK, {
		view = arg_8_1
	})

	return
end

function EducateProxy:MainAddLayer(arg_9_1)
	self:sendNotification(EducateProxy.MAIN_SCENE_ADD_LAYER, arg_9_1)

	return
end

function EducateProxy:initItems(arg_10_1)
	self.itemData = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		self.itemData[iter_10_1.id] = EducateItem.New(iter_10_1)
	end

	return
end

function EducateProxy:initOptions(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		var_11_0[iter_11_1.id] = iter_11_1.count
	end

	self.siteOptionData = {}

	for iter_11_2, iter_11_3 in ipairs(pg.child_site_option.all) do
		self.siteOptionData[iter_11_3] = EducateSiteOption.New(iter_11_3, var_11_0[iter_11_3])
	end

	return
end

function EducateProxy:initRandomOpts(arg_12_1)
	self.siteRandomOpts = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		self.siteRandomOpts[iter_12_1.site_id] = iter_12_1.option_ids
	end

	return
end

function EducateProxy:NeedRequestOptsData()
	return not self.siteRandomOpts
end

function EducateProxy:initBuffs(arg_14_1)
	self.buffData = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		self.buffData[iter_14_1.id] = EducateBuff.New(iter_14_1)
	end

	return
end

function EducateProxy:initPolaroids(arg_15_1)
	self.polaroidData = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		self.polaroidData[iter_15_1.id] = EducatePolaroid.New(iter_15_1)
	end

	return
end

function EducateProxy:SetEndings(arg_16_1, arg_16_2)
	self.endings = arg_16_2
	self.completeEndings = arg_16_1

	self:updateSecretaryIDs(false)

	return
end

function EducateProxy:IsFirstGame()
	return self.gameCount == 1
end

function EducateProxy:GetGameCnt()
	return self.gameCount
end

function EducateProxy:UpdateGameStatus()
	self.gameStatus = EducateConst.STATUES_NORMAL

	if self.exsitEnding then
		self.gameStatus = EducateConst.STATUES_RESET
	elseif self:IsEndingTime() then
		self.gameStatus = EducateConst.STATUES_ENDING
	elseif self.taskProxy:CheckTargetSet() then
		self.gameStatus = EducateConst.STATUES_PREPARE
	end

	return
end

function EducateProxy:GetGameStatus()
	return self.gameStatus
end

function EducateProxy:initVirtualStage()
	local var_21_0 = getProxy(EducateProxy):GetTaskProxy():GetTargetId()

	self.isVirtualStage = var_21_0 ~= 0 and pg.child_target_set[var_21_0].stage == self.char:GetStage() + 1

	return
end

function EducateProxy:SetVirtualStage(arg_22_1)
	self.isVirtualStage = arg_22_1

	return
end

function EducateProxy:InVirtualStage()
	return self.isVirtualStage
end

function EducateProxy:Reset(arg_24_1)
	EducateTipHelper.ClearAllRecord()
	self:GetPlanProxy():ClearLocalPlansData()
	self:sendNotification(GAME.EDUCATE_REQUEST, {
		callback = arg_24_1
	})

	return
end

function EducateProxy:Refresh(arg_25_1)
	EducateTipHelper.ClearAllRecord()
	self:GetPlanProxy():ClearLocalPlansData()
	self:sendNotification(GAME.EDUCATE_REQUEST, {
		callback = arg_25_1
	})

	return
end

function EducateProxy:GetCurTime()
	return self.curTime
end

function EducateProxy:UpdateTime()
	self.curTime.week = self.curTime.week + 1

	if self.curTime.week > 4 then
		self.curTime.week = 1
		self.curTime.month = self.curTime.month + 1
	end

	return
end

function EducateProxy:OnNextWeek()
	self:SetVirtualStage(false)
	self:UpdateTime()
	self.char:OnNewWeek(self.curTime)
	self.planProxy:OnNewWeek(self.curTime)
	self.eventProxy:OnNewWeek(self.curTime)
	self.shopProxy:OnNewWeek(self.curTime)
	self.taskProxy:OnNewWeek(self.curTime)
	self:RefreshBuffs()
	self:RefreshOptions()

	self.siteRandomOpts = nil

	self:UpdateGameStatus()
	self:sendNotification(EducateProxy.TIME_UPDATED)

	return
end

function EducateProxy:GetCharData()
	return self.char
end

function EducateProxy:GetPersonalityId()
	return self.char:GetPersonalityId()
end

function EducateProxy:UpdateRes(arg_31_1, arg_31_2)
	self.char:UpdateRes(arg_31_1, arg_31_2)
	self:sendNotification(EducateProxy.RESOURCE_UPDATED)

	return
end

function EducateProxy:ReduceResForPlans()
	local var_32_0, var_32_1 = self.planProxy:GetCost()

	self:UpdateRes(EducateChar.RES_MONEY_ID, -var_32_0)
	self:UpdateRes(EducateChar.RES_MOOD_ID, -var_32_1)

	return
end

function EducateProxy:ReduceResForCosts(arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		self:UpdateRes(iter_33_1.id, -iter_33_1.num)
	end

	return
end

function EducateProxy:UpdateAttr(arg_34_1, arg_34_2)
	self.char:UpdateAttr(arg_34_1, arg_34_2)
	self:sendNotification(EducateProxy.ATTR_UPDATED)

	return
end

function EducateProxy:CheckExtraAttr()
	return self.char:CheckExtraAttrAdd()
end

function EducateProxy:AddExtraAttr(arg_36_1)
	self:UpdateAttr(arg_36_1, self.char:getConfig("attr_2_add"))
	self.char:SetIsAddedExtraAttr(true)

	return
end

function EducateProxy:GetPlanProxy()
	return self.planProxy
end

function EducateProxy:GetEventProxy()
	return self.eventProxy
end

function EducateProxy:GetShopProxy()
	return self.shopProxy
end

function EducateProxy:GetTaskProxy()
	return self.taskProxy
end

function EducateProxy:GetAllEndings()
	return self.endings
end

function EducateProxy:GetCompleteEndings()
	return self.completeEndings
end

function EducateProxy:GetEndingBuyCnt()
	return self.endingBuyCnt
end

function EducateProxy:AddEndingBuyCnt()
	self.endingBuyCnt = self.endingBuyCnt + 1

	return
end

function EducateProxy:AddEnding(arg_45_1, arg_45_2)
	self.exsitEnding = true

	self:UpdateGameStatus()

	if not table.contains(self.completeEndings, arg_45_1) then
		table.insert(self.completeEndings, arg_45_1)
	end

	local var_45_0 = false

	for iter_45_0, iter_45_1 in ipairs(arg_45_2) do
		if not table.contains(self.endings, iter_45_1) then
			table.insert(self.endings, iter_45_1)

			var_45_0 = true
		end
	end

	if var_45_0 then
		self:updateSecretaryIDs(true)
		self:sendNotification(EducateProxy.ENDING_ADDED)
	end

	return
end

function EducateProxy:AddEndingFromBuy(arg_46_1)
	if table.contains(self.endings, arg_46_1) then
		return
	end

	table.insert(self.endings, arg_46_1)
	self:updateSecretaryIDs(true)
	self:sendNotification(EducateProxy.ENDING_ADDED)

	return
end

function EducateProxy:IsEndingTime()
	local var_47_0 = self:GetCurTime()

	if var_47_0.month >= self.endTime[1] and var_47_0.week >= self.endTime[2] and var_47_0.day >= self.endTime[3] then
		return true
	end

	return false
end

function EducateProxy:GetEndingResult()
	local var_48_0 = underscore.select(pg.child_ending.all, function(arg_49_0)
		return self.char:CheckEndCondition(pg.child_ending[arg_49_0].condition)
	end)

	assert(#var_48_0 > 0, "not matching ending")

	return var_48_0
end

function EducateProxy:GetBuffData()
	return self.buffData
end

function EducateProxy:GetBuffList()
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in pairs(self.buffData) do
		table.insert(var_51_0, iter_51_1)
	end

	return var_51_0
end

function EducateProxy:AddBuff(arg_52_1)
	if self.buffData[arg_52_1] then
		self.buffData[arg_52_1]:ResetEndTime()
	else
		self.buffData[arg_52_1] = EducateBuff.New({
			id = arg_52_1
		})
	end

	self:sendNotification(EducateProxy.BUFF_ADDED)

	return
end

function EducateProxy:RefreshBuffs()
	for iter_53_0, iter_53_1 in pairs(self.buffData) do
		if iter_53_1:IsEnd() then
			self.buffData[iter_53_1.id] = nil
		end
	end

	return
end

function EducateProxy:GetAttrBuffEffects(arg_54_1)
	local var_54_0 = {}

	for iter_54_0, iter_54_1 in pairs(self.buffData) do
		if iter_54_1:IsAttrType() and iter_54_1:IsId(arg_54_1) then
			table.insert(var_54_0, iter_54_1)
		end
	end

	return EducateBuff.GetBuffEffects(var_54_0)
end

function EducateProxy:GetResBuffEffects(arg_55_1)
	local var_55_0 = {}

	for iter_55_0, iter_55_1 in pairs(self.buffData) do
		if iter_55_1:IsResType() and iter_55_1:IsId(arg_55_1) then
			table.insert(var_55_0, iter_55_1)
		end
	end

	return EducateBuff.GetBuffEffects(var_55_0)
end

function EducateProxy:GetOptionById(arg_56_1)
	return self.siteOptionData[arg_56_1]
end

function EducateProxy:UpdateOptionData(arg_57_1)
	self.siteOptionData[arg_57_1.id] = arg_57_1

	self:sendNotification(EducateProxy.OPTION_UPDATED)

	return
end

function EducateProxy:RefreshOptions()
	local var_58_0 = self:GetCurTime()

	for iter_58_0, iter_58_1 in pairs(self.siteOptionData) do
		iter_58_1:OnWeekUpdate(var_58_0)
	end

	return
end

function EducateProxy:GetShowSiteIds()
	return underscore.select(pg.child_site.all, function(arg_60_0)
		return pg.child_site[arg_60_0].type == 1 and EducateHelper.IsSiteUnlock(arg_60_0, self:IsFirstGame())
	end)
end

function EducateProxy:GetOptionsBySiteId(arg_61_1)
	local var_61_0 = self:GetCurTime()
	local var_61_1 = {}
	local var_61_2 = {}

	underscore.each(pg.child_site[arg_61_1].option, function(arg_62_0)
		if self.siteOptionData[arg_62_0] and self.siteOptionData[arg_62_0]:IsShow(var_61_0) then
			if self.siteOptionData[arg_62_0]:IsReplace() then
				var_61_2[self.siteOptionData[arg_62_0]:getConfig("replace")] = self.siteOptionData[arg_62_0]
			else
				table.insert(var_61_1, self.siteOptionData[arg_62_0])
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
	underscore.each((self.siteRandomOpts or nil) and (self.siteRandomOpts[arg_61_1] or {}), function(arg_64_0)
		if self.siteOptionData[arg_64_0]:IsShow(var_61_0) then
			table.insert(var_61_1, self.siteOptionData[arg_64_0])
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

function EducateProxy:GetItemData()
	return self.itemData
end

function EducateProxy:GetItemList()
	local var_68_0 = {}

	for iter_68_0, iter_68_1 in pairs(self.itemData) do
		table.insert(var_68_0, iter_68_1)
	end

	return var_68_0
end

function EducateProxy:AddItem(arg_69_1, arg_69_2)
	if self.itemData[arg_69_1] then
		self.itemData[arg_69_1]:AddCount(arg_69_2)
	else
		self.itemData[arg_69_1] = EducateItem.New({
			id = arg_69_1,
			num = arg_69_2
		})
	end

	self:sendNotification(EducateProxy.ITEM_ADDED)

	return
end

function EducateProxy:GetItemCntById(arg_70_1)
	return (self.itemData[arg_70_1] or nil) and (self.itemData[arg_70_1].count or 0)
end

function EducateProxy:GetPolaroidData()
	return self.polaroidData
end

function EducateProxy:GetPolaroidBuyCnt()
	return self.polaroidBuyCnt
end

function EducateProxy:AddPolaroidBuyCnt()
	self.polaroidBuyCnt = self.polaroidBuyCnt + 1

	return
end

function EducateProxy:GetPolaroidList()
	local var_74_0 = {}

	for iter_74_0, iter_74_1 in pairs(self.polaroidData) do
		table.insert(var_74_0, iter_74_1)
	end

	return var_74_0
end

function EducateProxy:GetPolaroidIdList()
	local var_75_0 = {}

	for iter_75_0, iter_75_1 in pairs(self.polaroidData) do
		table.insert(var_75_0, iter_75_0)
	end

	return var_75_0
end

function EducateProxy:AddPolaroid(arg_76_1)
	if self.polaroidData[arg_76_1] then
		return
	end

	self.polaroidData[arg_76_1] = EducatePolaroid.New({
		id = arg_76_1,
		time = self:GetCurTime()
	})

	EducateTipHelper.SetNewTip(EducateTipHelper.NEW_POLAROID)
	self:updateSecretaryIDs(true)
	self:sendNotification(EducateProxy.POLAROID_ADDED)

	return
end

function EducateProxy:IsExistPolaroidByGroup(arg_77_1)
	return underscore.any(pg.child_polaroid.get_id_list_by_group[arg_77_1], function(arg_78_0)
		return self.polaroidData[arg_78_0]
	end)
end

function EducateProxy:CanGetPolaroidByGroup(arg_79_1)
	return underscore.any(pg.child_polaroid.get_id_list_by_group[arg_79_1], function(arg_80_0)
		return self:CanGetPolaroidById(arg_80_0)
	end)
end

function EducateProxy:CanGetPolaroidById(arg_81_1)
	if table.contains(pg.child_polaroid[arg_81_1].stage, (self.char:GetStage())) then
		if pg.child_polaroid[arg_81_1].xingge == "" then
			return true
		end

		return table.contains(pg.child_polaroid[arg_81_1].xingge, (self:GetPersonalityId()))
	end

	return false
end

function EducateProxy:GetPolaroidGroupCnt()
	local var_82_0 = 0
	local var_82_1 = 0

	for iter_82_0, iter_82_1 in pairs(pg.child_polaroid.get_id_list_by_group) do
		if self:IsExistPolaroidByGroup(iter_82_0) then
			var_82_0 = var_82_0 + 1
		end

		var_82_1 = var_82_1 + 1
	end

	return var_82_0, var_82_1
end

function EducateProxy:GetMemories()
	return self.memories
end

function EducateProxy:AddMemory(arg_84_1)
	if table.contains(self.memories, arg_84_1) then
		return
	end

	table.insert(self.memories, arg_84_1)
	EducateTipHelper.SetNewTip(EducateTipHelper.NEW_MEMORY, arg_84_1)
	self:sendNotification(EducateProxy.MEMORY_ADDED)

	return
end

function EducateProxy:GetMemoryBuyCnt()
	return self.memoryBuyCnt
end

function EducateProxy:CheckGuide(arg_86_1, arg_86_2)
	self:sendNotification(EducateProxy.GUIDE_CHECK, {
		view = arg_86_1,
		popActivityWindow = arg_86_2
	})

	return
end

function EducateProxy:AddMemoryBuyCnt()
	self.memoryBuyCnt = self.memoryBuyCnt + 1

	return
end

function EducateProxy:initUnlockSecretary(arg_88_1)
	self.isUnlockSecretary = arg_88_1
	self.unlockSecretaryTaskId = (function()
		for iter_89_0, iter_89_1 in ipairs(pg.secretary_special_ship.all) do
			if pg.secretary_special_ship[iter_89_1].unlock_type == EducateConst.SECRETARY_UNLCOK_TYPE_DEFAULT then
				return pg.secretary_special_ship[iter_89_1].unlock[1]
			end
		end

		return
	end)()
	self.unlcokTipByPolaroidCnt = {}

	for iter_88_0, iter_88_1 in ipairs(pg.secretary_special_ship.all) do
		if pg.secretary_special_ship[iter_88_1].unlock_type == EducateConst.SECRETARY_UNLCOK_TYPE_POLAROID then
			if not table.contains(self.unlcokTipByPolaroidCnt, pg.secretary_special_ship[iter_88_1].unlock[1]) then
				table.insert(self.unlcokTipByPolaroidCnt, pg.secretary_special_ship[iter_88_1].unlock[1])
			end
		end
	end

	return
end

function EducateProxy:GetUnlockSecretaryTaskId()
	return self.unlockSecretaryTaskId
end

function EducateProxy:SetSecretaryUnlock()
	self.isUnlockSecretary = true

	self:updateSecretaryIDs(false)

	return
end

function EducateProxy:CheckNewSecretaryTip()
	if table.contains(self.unlcokTipByPolaroidCnt, (self:GetPolaroidGroupCnt())) then
		self:updateSecretaryIDs(false)
		self:sendNotification(EducateProxy.UNLCOK_NEW_SECRETARY_BY_CNT)

		return true
	end

	return false
end

function EducateProxy:checkSecretaryID(arg_93_1, arg_93_2)
	if arg_93_2 == "or" then
		for iter_93_0, iter_93_1 in ipairs(arg_93_1) do
			if table.contains(self.endings, iter_93_1[1]) then
				return true
			end
		end

		return false
	elseif arg_93_2 == "and" then
		for iter_93_2, iter_93_3 in ipairs(arg_93_1) do
			if not table.contains(self.endings, iter_93_3) then
				return false
			end

			return true
		end
	end

	return false
end

function EducateProxy:updateSecretaryIDs(arg_94_1)
	if not self:IsUnlockSecretary() then
		self.unlockSecretaryIds = {}

		return
	end

	local var_94_0

	if arg_94_1 then
		var_94_0 = Clone(NewEducateHelper.GetAllUnlockSecretaryIds())
	end

	self.unlockSecretaryIds = {}

	local var_94_1, var_94_2 = self:GetPolaroidGroupCnt()

	for iter_94_0, iter_94_1 in ipairs(pg.secretary_special_ship.get_id_list_by_tb_id[0]) do
		local var_94_3 = pg.secretary_special_ship[iter_94_1].unlock

		switch(pg.secretary_special_ship[iter_94_1].unlock_type, {
			[EducateConst.SECRETARY_UNLCOK_TYPE_DEFAULT] = function()
				if self:IsUnlockSecretary() then
					table.insert(self.unlockSecretaryIds, iter_94_1)
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_POLAROID] = function()
				if var_94_3[1] and var_94_1 >= var_94_3[1] then
					table.insert(self.unlockSecretaryIds, iter_94_1)
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_ENDING] = function()
				if var_94_3[1] then
					if type(var_94_3[1]) == "table" then
						if self:checkSecretaryID(var_94_3, "or") then
							table.insert(self.unlockSecretaryIds, iter_94_1)
						end
					elseif type(var_94_3[1]) == "number" and self:checkSecretaryID(var_94_3, "and") then
						table.insert(self.unlockSecretaryIds, iter_94_1)
					end
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_SHOP] = function()
				if var_94_3[1] then
					if getProxy(ShipSkinProxy):hasSkin(var_94_3[1]) then
						table.insert(self.unlockSecretaryIds, iter_94_1)
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

function EducateProxy:GetEducateGroupList()
	local var_100_0 = {}

	for iter_100_0, iter_100_1 in pairs(pg.secretary_special_ship.get_id_list_by_group) do
		table.insert(var_100_0, EducateCharGroup.New(iter_100_0))
	end

	return var_100_0
end

function EducateProxy:GetStoryInfo()
	local var_101_0 = self.char:GetPaintingName()
	local var_101_1 = self.char:GetCallName()
	local var_101_2 = self.char:GetBGName()
end

function EducateProxy:GetSecretaryIDs()
	return self.unlockSecretaryIds
end

function EducateProxy:GetPolaroidCnt()
	return #self:GetPolaroidIdList()
end

function EducateProxy:IsUnlockSecretary()
	return self.isUnlockSecretary
end

function EducateProxy:remove()
	return
end

return EducateProxy
