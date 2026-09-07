local EducateScheduleScene = class("EducateScheduleScene", import(".base.EducateBaseUI"))

function EducateScheduleScene:getUIName()
	return "EducateScheduleUI"
end

function EducateScheduleScene:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateScheduleScene:initData()
	self.playerID = getProxy(PlayerProxy):getRawData().id
	self.educateProxy = getProxy(EducateProxy)
	self.char = self.educateProxy:GetCharData()
	self.curTime = self.educateProxy:GetCurTime()
	self.planProxy = self.educateProxy:GetPlanProxy()
	self.buffList = self.educateProxy:GetBuffList()
	self.natureIds = self.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_PERSONALITY)
	self.majorIds = self.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_MAJOR)
	self.minorIds = self.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_MINOR)

	self:getLocalGridData()

	self.contextData.indexDatas = self.contextData.indexDatas or {}

	return
end

function EducateScheduleScene:clearLocalPlans()
	getProxy(EducateProxy):GetPlanProxy():ClearLocalPlansData()
	self:getLocalGridData()
	self:updateResultPanel()
	self:closeSelectPanel()

	return
end

function EducateScheduleScene:getLocalGridData()
	local var_5_0 = self.char:GetNextWeekPlanCnt()

	self.gridData = {}

	for iter_5_0 = 1, 6 do
		self.gridData[iter_5_0] = {}

		for iter_5_1 = 1, 3 do
			self.gridData[iter_5_0][iter_5_1] = EducateGrid.New({
				type = (iter_5_1 <= var_5_0 or nil) and (EducateGrid.TYPE_EMPTY or EducateGrid.TYPE_LOCK)
			})
		end
	end

	for iter_5_2 = 1, 6 do
		self.selectDay = iter_5_2

		for iter_5_3 = 1, var_5_0 do
			self.selectIndex = iter_5_3

			local var_5_1 = PlayerPrefs.GetString(EducateConst.PLANS_DATA_KEY .. self.playerID .. "_" .. iter_5_2 .. "_" .. iter_5_3)

			if var_5_1 ~= "" then
				local var_5_2 = string.split(var_5_1, "_")
				local var_5_3 = tonumber(var_5_2[1])
				local var_5_4 = tonumber(var_5_2[2])

				if self:checkLocalPlan(var_5_3, var_5_4) then
					self.gridData[iter_5_2][iter_5_3] = EducateGrid.New({
						id = var_5_3,
						type = var_5_4
					})
				end
			end
		end
	end

	self.selectDay = nil
	self.selectIndex = nil

	self:recoverSpecEventForPlans()

	return
end

function EducateScheduleScene:checkLocalPlan(arg_6_1, arg_6_2)
	if arg_6_2 == EducateGrid.TYPE_PLAN or arg_6_2 == EducateGrid.TYPE_PLAN_OCCUPY then
		local var_6_0 = EducatePlan.New(arg_6_1)
		local var_6_1 = var_6_0:getConfig("pre_next")

		return self:CheckCondition(var_6_0) and not var_6_0:ExistNextPlanCanFill(self.char)
	end

	return false
end

function EducateScheduleScene:recoverSpecEventForPlans()
	for iter_7_0, iter_7_1 in ipairs((self.educateProxy:GetEventProxy():GetPlanSpecEvents())) do
		for iter_7_2, iter_7_3 in ipairs((iter_7_1:GetGridIndexs())) do
			self:setGridDataForPlan(iter_7_3[1], iter_7_3[2], (EducateGrid.New({
				type = (iter_7_2 == 1 or nil) and (EducateGrid.TYPE_EVENT or EducateGrid.TYPE_EVENT_OCCUPY),
				id = iter_7_1.id
			})))
		end
	end

	return
end

function EducateScheduleScene:saveGridLocalData(arg_8_1, arg_8_2, arg_8_3)
	PlayerPrefs.SetString(EducateConst.PLANS_DATA_KEY .. self.playerID .. "_" .. arg_8_1 .. "_" .. arg_8_2, arg_8_3.id .. "_" .. arg_8_3.type)

	return
end

function EducateScheduleScene:setGridDataForPlan(arg_9_1, arg_9_2, arg_9_3)
	if not self.gridData[arg_9_1][arg_9_2]:IsEmpty() then
		self:clearGridData(arg_9_1, arg_9_2)
	end

	local var_9_0 = arg_9_3:GetOccupyGridCnt()

	if var_9_0 > 1 then
		for iter_9_0 = 1, var_9_0 - 1 do
			self.gridData[arg_9_1][arg_9_2 + iter_9_0] = EducateGrid.New({
				type = EducateGrid.TYPE_PLAN_OCCUPY,
				id = arg_9_3.id
			})

			self:saveGridLocalData(arg_9_1, arg_9_2 + iter_9_0, self.gridData[arg_9_1][arg_9_2 + iter_9_0])
		end
	end

	self.gridData[arg_9_1][arg_9_2] = arg_9_3

	self:saveGridLocalData(arg_9_1, arg_9_2, arg_9_3)

	return
end

function EducateScheduleScene:clearGridData(arg_10_1, arg_10_2)
	if self.gridData[arg_10_1][arg_10_2]:GetOccupyGridCnt() > 1 then
		for iter_10_0, iter_10_1 in pairs(self.gridData[arg_10_1]) do
			if (iter_10_1:IsPlanOccupy() or iter_10_1:IsPlan()) and iter_10_1.id == self.gridData[arg_10_1][arg_10_2].id then
				self.gridData[arg_10_1][iter_10_0] = EducateGrid.New({
					type = EducateGrid.TYPE_EMPTY
				})

				self:saveGridLocalData(arg_10_1, iter_10_0, self.gridData[arg_10_1][iter_10_0])
			end
		end
	end

	self.gridData[arg_10_1][arg_10_2] = EducateGrid.New({
		type = EducateGrid.TYPE_EMPTY
	})

	self:saveGridLocalData(arg_10_1, arg_10_2, self.gridData[arg_10_1][arg_10_2])

	return
end

function EducateScheduleScene:findUI()
	self.bgTF = self._tf:Find("anim_root/bg")
	self.topTF = self._tf:Find("anim_root/top")
	self.returnBtn = self.topTF:Find("return_btn/return_btn")
	self.mainTF = self._tf:Find("anim_root/main")
	self.leftPanelTF = self.mainTF:Find("schedule_left")
	self.targetTF = self.leftPanelTF:Find("target")

	setText(self.targetTF:Find("title"), i18n("child_btn_target") .. ":")

	self.scheduleTF = self.leftPanelTF:Find("schedule")
	self.dayList = UIItemList.New(self.scheduleTF, self.leftPanelTF:Find("schedule/day_tpl"))
	self.monthText = self.leftPanelTF:Find("title/month")

	setText(self.leftPanelTF:Find("title/right/content/month"), i18n("word_month"))

	self.weekText = self.leftPanelTF:Find("title/right/content/week")
	self.skipToggle = self.leftPanelTF:Find("skip_toggle")
	self.skipToggleCom = self.skipToggle:GetComponent(typeof(Toggle))

	triggerToggle(self.skipToggle, PlayerPrefs.GetInt(EducateConst.SKIP_PLANS_ANIM_KEY .. "_" .. self.playerID) == 1)
	setActive(self.skipToggle, true)
	setText(self.skipToggle:Find("Text"), i18n("child_plan_skip"))

	self.skipEventToggle = self.leftPanelTF:Find("skip_toggle_event")
	self.skipEventToggleCom = self.skipEventToggle:GetComponent(typeof(Toggle))

	triggerToggle(self.skipEventToggle, PlayerPrefs.GetInt(EducateConst.SKIP_PLANS_EVENT_ANIM_KEY .. "_" .. self.playerID) == 1)
	setActive(self.skipEventToggle, true)
	setText(self.skipEventToggle:Find("Text"), i18n("child_plan_skip_event"))

	self.selectPanelTF = self.leftPanelTF:Find("select_panel")

	setActive(self.selectPanelTF, false)

	self.selectCloseBtn = self.selectPanelTF:Find("fold_btn")
	self.plansView = self.selectPanelTF:Find("scrollview")
	self.rightPanelTF = self.mainTF:Find("result_right")
	self.rightEmptyTF = self.rightPanelTF:Find("empty")

	setText(self.rightEmptyTF:Find("Text"), i18n("child_schedule_empty_tip"))

	self.rightContentTF = self.rightPanelTF:Find("content")
	self.buffUIList = UIItemList.New(self.rightContentTF:Find("buff_list"), self.rightContentTF:Find("buff_list/tpl"))
	self.avatarTF = self.rightContentTF:Find("avatar")
	self.avatarImage = self.avatarTF:Find("mask/Image")
	self.natureTF = self.rightContentTF:Find("nature/unlock")
	self.natureLockTF = self.rightContentTF:Find("nature/lock")

	setText(self.rightContentTF:Find("major_title/Text"), i18n("child_attr_name1"))
	setText(self.rightContentTF:Find("minor_title/Text"), i18n("child_attr_name2"))

	self.majorUIList = UIItemList.New(self.rightContentTF:Find("major"), self.rightContentTF:Find("major/tpl"))
	self.minorUIList = UIItemList.New(self.rightContentTF:Find("minor"), self.rightContentTF:Find("minor/tpl"))
	self.nextBtn = self.rightPanelTF:Find("next_btn")
	self.topPanel = EducateTopPanel.New(self.topTF:Find("top_right"), self.event)

	self.topPanel:Load()

	self.resPanel = EducateResPanel.New(self.topTF:Find("res"), self.event)

	self.resPanel:Load()

	return
end

function EducateScheduleScene:addListener()
	setActive(self.topTF:Find("clear_btn"), false)
	onButton(self, self.topTF:Find("clear_btn"), function()
		self:clearLocalPlans()
		self.resPanel:ActionInvoke("Flush")

		return
	end, SFX_PANEL)
	onButton(self, self.selectPanelTF:Find("index_btn"), function()
		local var_14_0 = {}

		var_14_0.indexDatas = Clone(self.contextData.indexDatas) or {}

		function var_14_0:callback()
			self.typeIndex = self.typeIndex
			self.costIndex = self.costIndex
			self.awardResIndex = self.awardResIndex
			self.awardNatureIndex = self.awardNatureIndex
			self.awardAttr1Index = self.awardAttr1Index
			self.awardAttr2Index = self.awardAttr2Index

			self:updateIndexDatas()
			self:updatePlanList()

			return
		end

		self:emit(EducateScheduleMediator.OPEN_FILTER_LAYER, var_14_0)

		return
	end, SFX_PANEL)
	onButton(self, self.returnBtn, function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self.selectCloseBtn, function()
		self:closeSelectPanel()

		return
	end, SFX_PANEL)
	onButton(self, self.nextBtn, function()
		local var_18_0 = {}
		local var_18_1

		table.insert(var_18_0, function(arg_19_0)
			if self:haveEmpty() then
				self:emit(EducateScheduleScene.EDUCATE_ON_MSG_TIP, {
					content = i18n("child_schedule_sure_tip"),
					onYes = function()
						var_18_1 = true

						return
					end,
					onExit = function()
						if var_18_1 then
							arg_19_0()
						end

						return
					end
				})
			else
				arg_19_0()
			end

			return
		end)
		table.insert(var_18_0, function(arg_22_0)
			if getProxy(EducateProxy):GetCharData().site > 0 then
				self:emit(EducateScheduleScene.EDUCATE_ON_MSG_TIP, {
					content = i18n("child_schedule_sure_tip2"),
					onYes = function()
						arg_22_0()

						return
					end
				})
			else
				arg_22_0()
			end

			return
		end)
		seriesAsync(var_18_0, function()
			self:executePlans(self.skipToggleCom.isOn, self.skipEventToggleCom.isOn)

			return
		end)

		return
	end, SFX_PANEL)
	onToggle(self, self.skipToggle, function(arg_25_0)
		PlayerPrefs.SetInt(EducateConst.SKIP_PLANS_ANIM_KEY .. "_" .. self.playerID, arg_25_0 and 1 or 0)

		return
	end, SFX_PANEL)
	onToggle(self, self.skipEventToggle, function(arg_26_0)
		PlayerPrefs.SetInt(EducateConst.SKIP_PLANS_EVENT_ANIM_KEY .. "_" .. self.playerID, arg_26_0 and 1 or 0)

		return
	end, SFX_PANEL)

	return
end

function EducateScheduleScene:haveEmpty()
	for iter_27_0 = 1, 6 do
		for iter_27_1 = 1, 3 do
			if self.gridData[iter_27_0][iter_27_1]:IsEmpty() then
				return true
			end
		end
	end

	return false
end

function EducateScheduleScene:allEmpty()
	for iter_28_0 = 1, 6 do
		for iter_28_1 = 1, 3 do
			if not self.gridData[iter_28_0][iter_28_1]:IsEmpty() and not self.gridData[iter_28_0][iter_28_1]:IsLock() then
				return false
			end
		end
	end

	return true
end

function EducateScheduleScene:executePlans(arg_29_1, arg_29_2)
	self:emit(EducateScheduleMediator.GET_PLANS, {
		gridData = self.gridData,
		isSkip = arg_29_1,
		isSkipEvent = arg_29_2
	})

	return
end

function EducateScheduleScene:didEnter()
	self:updateBg()
	self:initTimeTitle()
	self:initTargetText()
	self:updateIndexDatas()
	self:initSchedulePanel()
	self:initSelectPlans()
	self:initResultPanel()
	self:checkTips()
	self:OverlayPanel(self.mainTF, {
		pbList = {
			self.mainTF:Find("bg")
		}
	})
	self:OverlayPanel(self.topTF, {
		groupDelta = 1
	})

	return
end

function EducateScheduleScene:checkTips()
	self.newUnlcokPlanIds = EducateTipHelper.GetPlanUnlockTipIds()

	if #self.newUnlcokPlanIds > 0 then
		self:emit(EducateScheduleScene.EDUCATE_ON_UNLOCK_TIP, {
			type = EducateUnlockTipLayer.UNLOCK_TYPE_PLAN,
			list = self.newUnlcokPlanIds
		})
	end

	return
end

function EducateScheduleScene:updateBg()
	setImageSprite(self.bgTF, LoadSprite("bg/" .. self.char:GetBGName()), false)

	return
end

function EducateScheduleScene:initTimeTitle()
	local var_33_0 = EducateHelper.GetTimeAfterWeeks(self.curTime, 1)

	setText(self.monthText, (EducateHelper.GetShowMonthNumber(var_33_0.month)))
	setText(self.weekText, i18n("word_which_week", (i18n("number_" .. var_33_0.week))))

	return
end

function EducateScheduleScene:initTargetText()
	self.showAttrSubtype = 0

	local var_34_0 = self.educateProxy:GetTaskProxy()

	if not var_34_0:CanGetTargetAward() then
		setText(self.targetTF:Find("Text"), i18n("child_task_finish_all"))
		setActive(self.targetTF:Find("icon"), false)
	else
		local var_34_1 = var_34_0:FilterByGroup(var_34_0:GetTargetTasksForShow())[1]

		if not var_34_1 then
			setActive(self.targetTF, false)
		end

		setText(self.targetTF:Find("Text"), var_34_1:getConfig("name"))

		if var_34_1:GetType() == EducateTask.TYPE_ATTR then
			setActive(self.targetTF:Find("icon"), true)

			self.showAttrSubtype = var_34_1:getConfig("sub_type")

			GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. ((type(self.showAttrSubtype) == "string" or nil) and (self.showAttrSubtype or self.showAttrSubtype[1])), self.targetTF:Find("icon"))
		else
			setActive(self.targetTF:Find("icon"), false)
		end
	end

	return
end

function EducateScheduleScene:updateIndexDatas()
	self.contextData.indexDatas = self.contextData.indexDatas or {}
	self.contextData.indexDatas.typeIndex = self.typeIndex
	self.contextData.indexDatas.costIndex = self.costIndex
	self.contextData.indexDatas.awardResIndex = self.awardResIndex
	self.contextData.indexDatas.awardNatureIndex = self.awardNatureIndex
	self.contextData.indexDatas.awardAttr1Index = self.awardAttr1Index
	self.contextData.indexDatas.awardAttr2Index = self.awardAttr2Index

	return
end

function EducateScheduleScene:initSchedulePanel()
	self.dayList:make(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_0 == UIItemList.EventInit then
			local var_37_0 = arg_37_1 + 1

			arg_37_2.name = tostring(arg_37_1 + 1)

			GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", arg_37_1 + 1, arg_37_2:Find("title"), true)

			for iter_37_0 = 1, 3 do
				local var_37_1 = arg_37_2:Find("cells"):GetChild(iter_37_0 - 1)
				local var_37_2 = self.planProxy:GetGridBgName(arg_37_1 + 1, iter_37_0)

				GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", var_37_2[1], var_37_1:Find("empty"), true)
				GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", var_37_2[2], var_37_1:Find("plan/name_bg"), true)
				onButton(self, var_37_1, function()
					if self.gridData[var_37_0][iter_37_0]:IsEvent() or self.gridData[var_37_0][iter_37_0]:IsEventOccupy() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("child_schedule_event_tip"))
					else
						self:openSelectPanel(var_37_0, iter_37_0)
					end

					return
				end, SFX_PANEL)
			end
		end

		if arg_37_0 == UIItemList.EventUpdate then
			self:updateDayGrids(arg_37_1, arg_37_2)
		end

		return
	end)
	self.dayList:align(6)

	return
end

function EducateScheduleScene:_updateGrid(arg_39_1, arg_39_2)
	setActive(arg_39_1, not arg_39_2:IsLock())

	if not arg_39_2:IsLock() then
		setActive(arg_39_1:Find("empty"), arg_39_2:IsEmpty())

		arg_39_1:GetComponent(typeof(Image)).enabled = not arg_39_2:IsEmpty()

		setActive(arg_39_1:Find("plan"), not arg_39_2:IsEmpty())

		if arg_39_2:IsPlan() or arg_39_2:IsPlanOccupy() then
			LoadImageSpriteAsync("educateprops/" .. arg_39_2.data:getConfig("icon"), arg_39_1:Find("plan/icon"), true)
			setScrollText(arg_39_1:Find("plan/name_bg/Text"), arg_39_2.data:getConfig("name"))
		end

		if arg_39_2:IsEvent() or arg_39_2:IsEventOccupy() then
			LoadImageSpriteAsync("educateprops/" .. (arg_39_2.data:getConfig("type_param")[1] or ""), arg_39_1:Find("plan/icon"), true)
			setScrollText(arg_39_1:Find("plan/name_bg/Text"), i18n("child_plan_event"))
		end
	end

	return
end

function EducateScheduleScene:updateDayGrids(arg_40_1, arg_40_2)
	for iter_40_0 = 1, 3 do
		local var_40_0 = arg_40_2:Find("cells"):GetChild(iter_40_0 - 1)

		var_40_0.name = tostring(iter_40_0)

		self:_updateGrid(var_40_0, self.gridData[arg_40_1 + 1][iter_40_0])
	end

	return
end

function EducateScheduleScene:initSelectPlans()
	self.plansRect = self.plansView:GetComponent("LScrollRect")
	self.planCards = {}

	function self.plansRect.onInitItem(arg_42_0)
		self.planCards[arg_42_0] = EducateSchedulePlanCard.New(arg_42_0, self)

		return
	end

	function self.plansRect.onUpdateItem(arg_43_0, arg_43_1)
		self.planCards[arg_43_1] = self.planCards[arg_43_1] or EducateSchedulePlanCard.New(arg_43_1, self)

		local var_43_2 = self.gridData[self.selectDay][self.selectIndex]

		self.planCards[arg_43_1]:update(self.showPlans[arg_43_0 + 1], (self.gridData[self.selectDay][self.selectIndex] and var_43_2:IsPlanOccupy() or var_43_2:IsPlan() or nil) and var_43_2.id)

		return
	end

	function self.plansRect.onReturnItem(arg_44_0, arg_44_1)
		return
	end

	for iter_41_0 = 1, 3 do
		onButton(self, self.selectPanelTF:Find("day/cells"):GetChild(iter_41_0 - 1), function()
			if self.gridData[self.selectDay][iter_41_0]:IsEvent() or self.gridData[self.selectDay][iter_41_0]:IsEventOccupy() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("child_schedule_event_tip"))
			else
				self.selectIndex = iter_41_0

				self:updateSelectdDay()
				self:updatePlanList()
			end

			return
		end, SFX_PANEL)
	end

	return
end

function EducateScheduleScene:openSelectPanel(arg_46_1, arg_46_2)
	LoadImageSpriteAtlasAsync("ui/educatescheduleui_atlas", arg_46_1, self.selectPanelTF:Find("day/title"), true)
	setActive(self.selectPanelTF, true)
	setActive(self.scheduleTF, false)

	self.selectDay = arg_46_1
	self.selectIndex = arg_46_2

	self:updateSelectdDay()
	self:updatePlanList()

	return
end

function EducateScheduleScene:updateSelectdDay()
	for iter_47_0 = 1, 3 do
		local var_47_0 = self.selectPanelTF:Find("day/cells")
		local var_47_1 = var_47_0:GetChild(iter_47_0 - 1)
		local var_47_2 = self.gridData[self.selectDay][iter_47_0]
		local var_47_3 = self.planProxy:GetGridBgName(self.selectDay, iter_47_0)

		GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", var_47_0[1], var_47_1:Find("empty"), true)
		GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", var_47_3[2], var_47_1:Find("plan/name_bg"), true)
		setActive(var_47_1:Find("selected"), self.selectIndex == iter_47_0)
		self:_updateGrid(var_47_1, var_47_2)
	end

	return
end

function EducateScheduleScene:updatePlanList()
	if self.selectIndex ~= 0 then
		self.showPlans = self:filter(self.planProxy:GetShowPlans(self.char:GetNextWeekStage(), self.selectDay, self.selectIndex))

		self:sortPlans()
		self.plansRect:SetTotalCount(#self.showPlans, -1)
	end

	return
end

function EducateScheduleScene:sortPlans()
	table.sort(self.showPlans, CompareFuncs({
		function(arg_50_0)
			return table.contains(self.newUnlcokPlanIds, arg_50_0.id) and 0 or 1
		end,
		function(arg_51_0)
			return arg_51_0:IsMatchAttr(self.char) and 0 or 1
		end,
		function(arg_52_0)
			return arg_52_0:CheckResultBySubType(EducateConst.DROP_TYPE_ATTR, self.showAttrSubtype) and 0 or 1
		end,
		function(arg_53_0)
			return -arg_53_0:getConfig("rare")
		end,
		function(arg_54_0)
			return arg_54_0.id
		end
	}))

	self.newUnlcokPlanIds = {}

	return
end

function EducateScheduleScene:OnPlanCardClick(arg_55_1)
	local var_55_0, var_55_1 = self:CheckCondition(arg_55_1)

	if var_55_0 then
		self:setGridDataForPlan(self.selectDay, self.selectIndex, (EducateGrid.New({
			type = EducateGrid.TYPE_PLAN,
			id = arg_55_1.id
		})))
		self:updateSelectdDay()
		self:updateResultPanel()
		self:closeSelectPanel()
	else
		pg.TipsMgr.GetInstance():ShowTips(var_55_1)
	end

	return
end

function EducateScheduleScene:filter(arg_56_1)
	return underscore.select(arg_56_1, function(arg_57_0)
		return EducatePlanIndexConst.filterByType(arg_57_0, self.typeIndex) and EducatePlanIndexConst.filterByCost(arg_57_0, self.costIndex) and EducatePlanIndexConst.filterByAwardRes(arg_57_0, self.awardResIndex) and EducatePlanIndexConst.filterByAwardNature(arg_57_0, self.awardNatureIndex) and EducatePlanIndexConst.filterByAwardAttr1(arg_57_0, self.awardAttr1Index) and EducatePlanIndexConst.filterByAwardAttr2(arg_57_0, self.awardAttr2Index)
	end)
end

function EducateScheduleScene:closeSelectPanel()
	setActive(self.selectPanelTF, false)
	setActive(self.scheduleTF, true)
	self.dayList:align(6)

	return
end

function EducateScheduleScene:CheckCondition(arg_59_1)
	if self.gridData[self.selectDay][self.selectIndex]:IsEvent() or self.gridData[self.selectDay][self.selectIndex]:IsEventOccupy() then
		local var_59_1 = i18n("child_schedule_event_tip")

		return
	end

	local var_59_2 = self.gridData[self.selectDay][self.selectIndex].data
	local var_59_3, var_59_4, var_59_5 = arg_59_1:GetCost()

	if var_59_5 > 1 and not self:CheckRemainGrid(var_59_5, self.gridData[self.selectDay][self.selectIndex].id) then
		local var_59_7 = i18n("child_plan_check_tip1")

		return
	end

	if not arg_59_1:IsMatchAttr(self.char) then
		local var_59_9 = i18n("child_plan_check_tip2")

		return
	end

	if not arg_59_1:IsInStage(self.char:GetNextWeekStage()) then
		local var_59_11 = i18n("child_plan_check_tip6")

		return
	end

	if not arg_59_1:IsMatchPre(self.planProxy:GetHistoryCntById(arg_59_1:getConfig("pre")[1])) then
		local var_59_13 = i18n("child_plan_check_tip3")

		return
	end

	local var_59_14, var_59_15 = self:getPlansCost()
	local var_59_16 = 0

	if self.gridData[self.selectDay][self.selectIndex]:IsPlan() or self.gridData[self.selectDay][self.selectIndex]:IsPlanOccupy() then
		local var_59_18

		var_59_16, var_59_18 = var_59_2:GetCost()
	end

	if self.char.money < var_59_14 + var_59_3 - var_59_16 then
		local var_59_20 = i18n("child_plan_check_tip4")

		return
	end

	return true
end

function EducateScheduleScene:CheckRemainGrid(arg_60_1, arg_60_2)
	if self.selectIndex + arg_60_1 - 1 > 3 then
		return false
	end

	for iter_60_0 = self.selectIndex + 1, self.selectIndex + arg_60_1 - 1 do
		if not self.gridData[self.selectDay][iter_60_0]:IsEmpty() and (not self.gridData[self.selectDay][iter_60_0]:IsPlanOccupy() or self.gridData[self.selectDay][iter_60_0].id ~= arg_60_2) then
			return false
		end
	end

	return true
end

function EducateScheduleScene:showBuffBox(arg_61_1)
	self:emit(EducateScheduleScene.EDUCATE_ON_ITEM, {
		drop = {
			number = 1,
			type = EducateConst.DROP_TYPE_BUFF,
			id = arg_61_1
		}
	})

	return
end

function EducateScheduleScene:initResultPanel()
	self.resPanel:ActionInvoke("FlushAddValue", "", "")
	self.buffUIList:make(function(arg_63_0, arg_63_1, arg_63_2)
		if arg_63_0 == UIItemList.EventUpdate then
			onButton(self, arg_63_2, function()
				self:showBuffBox(self.buffList[arg_63_1 + 1].id)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.buffUIList:align(#self.buffList)

	local var_62_0 = self.natureTF:Find("content")
	local var_62_1 = self.avatarTF:Find("progress")

	setImageSprite(self.avatarTF:Find("mask/Image"), LoadSprite("squareicon/" .. self.char:GetPaintingName()), true)

	for iter_62_0, iter_62_1 in ipairs(self.natureIds) do
		local var_62_2 = var_62_0:GetChild(iter_62_0 - 1)

		setActive(var_62_2:Find("tip"), false)

		var_62_2.name = iter_62_1

		setScrollText(var_62_2:Find("mask/Text"), pg.child_attr[iter_62_1].name .. " " .. self.char:GetAttrById(iter_62_1))
	end

	self.majorUIList:make(function(arg_65_0, arg_65_1, arg_65_2)
		if arg_65_0 == UIItemList.EventInit then
			arg_65_2.name = self.majorIds[arg_65_1 + 1]

			GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. self.majorIds[arg_65_1 + 1], arg_65_2:Find("icon"), true)
			setScrollText(arg_65_2:Find("name_mask/name"), pg.child_attr[self.majorIds[arg_65_1 + 1]].name)

			local var_65_0 = self.char:GetAttrInfo(self.majorIds[arg_65_1 + 1])

			setText(arg_65_2:Find("grade/Text"), var_65_0)
			setText(arg_65_2:Find("before_value"), self.char:GetAttrById(self.majorIds[arg_65_1 + 1]))
			setActive(arg_65_2:Find("gradient"), false)
			setImageColor(arg_65_2:Find("grade"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_65_0][2]))
		elseif arg_65_0 == UIItemList.EventUpdate then
			local var_65_1 = tonumber(arg_65_2.name)
			local var_65_2 = self.char:GetAttrById(var_65_1)

			if self.attrResults and self.attrResults[var_65_1] then
				var_65_2 = var_65_2 + self.attrResults[var_65_1]

				setActive(arg_65_2:Find("gradient"), true)
				setImageColor(arg_65_2:Find("arrow"), Color.NewHex("9efffe"))
				setText(arg_65_2:Find("after_value"), setColorStr(var_65_2, "#9efffe"))
			else
				setActive(arg_65_2:Find("gradient"), false)
				setImageColor(arg_65_2:Find("arrow"), Color.NewHex("dddedf"))
				setText(arg_65_2:Find("after_value"), setColorStr(var_65_2, "#ffffff"))
			end
		end

		return
	end)
	self.minorUIList:make(function(arg_66_0, arg_66_1, arg_66_2)
		if arg_66_0 == UIItemList.EventInit then
			arg_66_2.name = self.minorIds[arg_66_1 + 1]

			GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. self.minorIds[arg_66_1 + 1], arg_66_2:Find("icon"), true)
			setText(arg_66_2:Find("value"), self.char:GetAttrById(self.minorIds[arg_66_1 + 1]))
		elseif arg_66_0 == UIItemList.EventUpdate then
			local var_66_0 = tonumber(arg_66_2.name)
			local var_66_1 = self.char:GetAttrById(var_66_0)

			setText(arg_66_2:Find("name"), pg.child_attr[var_66_0].name)

			if self.attrResults and self.attrResults[var_66_0] then
				var_66_1 = var_66_1 .. setColorStr("+" .. self.attrResults[var_66_0], "#9efffe")
			end

			setText(arg_66_2:Find("value"), var_66_1)
		end

		return
	end)

	self.attrResults, self.resResult = {}, {}

	self:updateResultPanel()

	return
end

function EducateScheduleScene:updateResultPanel()
	local var_67_0 = self:allEmpty()

	setActive(self.rightEmptyTF, var_67_0)
	setActive(self.rightContentTF, not var_67_0)

	if not var_67_0 then
		self.attrResults, self.resResult = self:getPlansResult()

		self.majorUIList:align(#self.majorIds)
		self.minorUIList:align(#self.minorIds)

		local var_67_1, var_67_2 = self:getPlansCost()
		local var_67_3 = self.resResult[EducateChar.RES_MONEY_ID] or 0
		local var_67_4 = self.resResult[EducateChar.RES_MOOD_ID] or 0
		local var_67_5

		if var_67_3 - var_67_1 >= 0 then
			var_67_5 = "+" .. var_67_3 - var_67_1 or var_67_3 - var_67_1

			local var_67_6

			if var_67_4 - var_67_2 >= 0 then
				var_67_6 = "+" .. var_67_4 - var_67_2 or var_67_4 - var_67_2
			end
		end

		self.resPanel:ActionInvoke("FlushAddValue", var_67_6, var_67_5)

		local var_67_7 = EducateHelper.IsShowNature()

		setActive(self.natureTF, var_67_7)
		setActive(self.natureLockTF, not var_67_7)

		if var_67_7 then
			eachChild(self.natureTF:Find("content"), function(arg_68_0)
				local var_68_0 = tonumber(arg_68_0.name)

				if self.attrResults and self.attrResults[var_68_0] and self.attrResults[var_68_0] ~= 0 then
					local var_68_1 = self.attrResults[var_68_0]
					local var_68_2 = self.attrResults[var_68_0] > 0 and "+" or ""
					local var_68_3 = self.attrResults[var_68_0] > 0 and "39bfff" or "a9a9a9"

					setActive(arg_68_0:Find("tip"), true)
					setImageColor(arg_68_0:Find("tip"), Color.NewHex(var_68_3))
					setText(arg_68_0:Find("tip/Text"), var_68_2 .. var_68_1)
				else
					setActive(arg_68_0:Find("tip"), false)
				end

				return
			end)
		end
	end

	return
end

function EducateScheduleScene:getPlansResult()
	local var_69_0 = {}
	local var_69_1 = {}

	for iter_69_0, iter_69_1 in ipairs(self.gridData) do
		for iter_69_2, iter_69_3 in ipairs(iter_69_1) do
			if iter_69_3:IsPlan() then
				for iter_69_4, iter_69_5 in ipairs(iter_69_3.data:GetResult()) do
					if iter_69_5[1] == EducateConst.DROP_TYPE_ATTR then
						var_69_0[iter_69_5[2]] = (var_69_0[iter_69_5[2]] or 0) + iter_69_5[3]
					elseif iter_69_5[1] == EducateConst.DROP_TYPE_RES then
						var_69_1[iter_69_5[2]] = (var_69_1[iter_69_5[2]] or 0) + iter_69_5[3]
					end
				end
			end
		end
	end

	return var_69_0, var_69_1
end

function EducateScheduleScene:getPlansCost()
	local var_70_0 = 0
	local var_70_1 = 0

	for iter_70_0, iter_70_1 in pairs(self.gridData) do
		for iter_70_2, iter_70_3 in pairs(iter_70_1) do
			if iter_70_3:IsPlan() then
				local var_70_3, var_70_4 = iter_70_3.data:GetCost()

				var_70_0 = var_70_0 + var_70_3
				var_70_1 = var_70_1 + var_70_4
			end
		end
	end

	return var_70_0, var_70_1
end

function EducateScheduleScene:getRemainGridCnt(arg_71_1, arg_71_2)
	local var_71_0 = 1

	for iter_71_0, iter_71_1 in pairs(self.gridData[arg_71_1]) do
		if arg_71_2 < iter_71_0 and iter_71_1:IsEmpty() then
			var_71_0 = var_71_0 + 1
		end
	end

	return var_71_0
end

function EducateScheduleScene:DoRecommend()
	local var_72_0 = self.char:GetAttrSortIds()

	for iter_72_0, iter_72_1 in pairs(self.gridData) do
		for iter_72_2, iter_72_3 in pairs(iter_72_1) do
			if iter_72_3:IsEmpty() then
				local var_72_1, var_72_2 = self:getPlansCost()
				local var_72_3 = self.planProxy:GetRecommendPlan(iter_72_0, iter_72_2, self.char, var_72_1, var_72_2, self:getRemainGridCnt(iter_72_0, iter_72_2), var_72_0)

				if var_72_3 then
					self:setGridDataForPlan(iter_72_0, iter_72_2, (EducateGrid.New({
						type = EducateGrid.TYPE_PLAN,
						id = var_72_3.id
					})))
				end
			end
		end
	end

	self:updateResultPanel()
	self:closeSelectPanel()

	return
end

function EducateScheduleScene:onBackPressed()
	if isActive(self.selectPanelTF) then
		self:closeSelectPanel()
	else
		EducateScheduleScene.super.onBackPressed(self)
	end

	return
end

function EducateScheduleScene:willExit()
	self.topPanel:Destroy()

	self.topPanel = nil

	self.resPanel:Destroy()

	self.resPanel = nil

	self:UnOverlayPanel(self.mainTF, self._tf:Find("anim_root"))
	self:UnOverlayPanel(self.topTF, self._tf:Find("anim_root"))

	for iter_74_0, iter_74_1 in pairs(self.planCards) do
		iter_74_1:dispose()
	end

	return
end

return EducateScheduleScene
