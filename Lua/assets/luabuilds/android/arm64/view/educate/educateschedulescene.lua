local var_0_0 = class("EducateScheduleScene", import(".base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateScheduleUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.playerID = getProxy(PlayerProxy):getRawData().id
	arg_3_0.educateProxy = getProxy(EducateProxy)
	arg_3_0.char = arg_3_0.educateProxy:GetCharData()
	arg_3_0.curTime = arg_3_0.educateProxy:GetCurTime()
	arg_3_0.planProxy = arg_3_0.educateProxy:GetPlanProxy()
	arg_3_0.buffList = arg_3_0.educateProxy:GetBuffList()
	arg_3_0.natureIds = arg_3_0.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_PERSONALITY)
	arg_3_0.majorIds = arg_3_0.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_MAJOR)
	arg_3_0.minorIds = arg_3_0.char:GetAttrIdsByType(EducateChar.ATTR_TYPE_MINOR)

	arg_3_0:getLocalGridData()

	arg_3_0.contextData.indexDatas = arg_3_0.contextData.indexDatas or {}

	return
end

function var_0_0.clearLocalPlans(arg_4_0)
	getProxy(EducateProxy):GetPlanProxy():ClearLocalPlansData()
	arg_4_0:getLocalGridData()
	arg_4_0:updateResultPanel()
	arg_4_0:closeSelectPanel()

	return
end

function var_0_0.getLocalGridData(arg_5_0)
	local var_5_0 = arg_5_0.char:GetNextWeekPlanCnt()

	arg_5_0.gridData = {}

	for iter_5_0 = 1, 6 do
		arg_5_0.gridData[iter_5_0] = {}

		for iter_5_1 = 1, 3 do
			if iter_5_1 <= var_5_0 then
				local var_5_1 = EducateGrid.TYPE_EMPTY or EducateGrid.TYPE_LOCK

				arg_5_0.gridData[iter_5_0][iter_5_1] = EducateGrid.New({
					type = var_5_1
				})
			end
		end
	end

	for iter_5_2 = 1, 6 do
		arg_5_0.selectDay = iter_5_2

		for iter_5_3 = 1, var_5_0 do
			arg_5_0.selectIndex = iter_5_3

			local var_5_2 = PlayerPrefs.GetString(EducateConst.PLANS_DATA_KEY .. arg_5_0.playerID .. "_" .. iter_5_2 .. "_" .. iter_5_3)

			if var_5_2 ~= "" then
				local var_5_3 = string.split(var_5_2, "_")
				local var_5_4 = tonumber(var_5_3[1])
				local var_5_5 = tonumber(var_5_3[2])

				if arg_5_0:checkLocalPlan(var_5_4, var_5_5) then
					arg_5_0.gridData[iter_5_2][iter_5_3] = EducateGrid.New({
						id = var_5_4,
						type = var_5_5
					})
				end
			end
		end
	end

	arg_5_0.selectDay = nil
	arg_5_0.selectIndex = nil

	arg_5_0:recoverSpecEventForPlans()

	return
end

function var_0_0.checkLocalPlan(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == EducateGrid.TYPE_PLAN or arg_6_2 == EducateGrid.TYPE_PLAN_OCCUPY then
		local var_6_0 = EducatePlan.New(arg_6_1)
		local var_6_1 = var_6_0:getConfig("pre_next")

		return arg_6_0:CheckCondition(var_6_0) and not var_6_0:ExistNextPlanCanFill(arg_6_0.char)
	end

	return false
end

function var_0_0.recoverSpecEventForPlans(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs((arg_7_0.educateProxy:GetEventProxy():GetPlanSpecEvents())) do
		for iter_7_2, iter_7_3 in ipairs((iter_7_1:GetGridIndexs())) do
			if iter_7_2 == 1 then
				local var_7_0 = EducateGrid.TYPE_EVENT
				local var_7_1

				if not EducateGrid.TYPE_EVENT then
					var_7_0 = EducateGrid.TYPE_EVENT_OCCUPY
					var_7_1 = arg_7_0
				end

				arg_7_0:setGridDataForPlan(iter_7_3[1], iter_7_3[2], (EducateGrid.New({
					type = var_7_0,
					id = iter_7_1.id
				})))
			end
		end
	end

	return
end

function var_0_0.saveGridLocalData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	PlayerPrefs.SetString(EducateConst.PLANS_DATA_KEY .. arg_8_0.playerID .. "_" .. arg_8_1 .. "_" .. arg_8_2, arg_8_3.id .. "_" .. arg_8_3.type)

	return
end

function var_0_0.setGridDataForPlan(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0.gridData[arg_9_1][arg_9_2]:IsEmpty() then
		arg_9_0:clearGridData(arg_9_1, arg_9_2)
	end

	local var_9_0 = arg_9_3:GetOccupyGridCnt()

	if var_9_0 > 1 then
		for iter_9_0 = 1, var_9_0 - 1 do
			arg_9_0.gridData[arg_9_1][arg_9_2 + iter_9_0] = EducateGrid.New({
				type = EducateGrid.TYPE_PLAN_OCCUPY,
				id = arg_9_3.id
			})

			arg_9_0:saveGridLocalData(arg_9_1, arg_9_2 + iter_9_0, arg_9_0.gridData[arg_9_1][arg_9_2 + iter_9_0])
		end
	end

	arg_9_0.gridData[arg_9_1][arg_9_2] = arg_9_3

	arg_9_0:saveGridLocalData(arg_9_1, arg_9_2, arg_9_3)

	return
end

function var_0_0.clearGridData(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.gridData[arg_10_1][arg_10_2]:GetOccupyGridCnt() > 1 then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.gridData[arg_10_1]) do
			if (iter_10_1:IsPlanOccupy() or iter_10_1:IsPlan()) and iter_10_1.id == arg_10_0.gridData[arg_10_1][arg_10_2].id then
				arg_10_0.gridData[arg_10_1][iter_10_0] = EducateGrid.New({
					type = EducateGrid.TYPE_EMPTY
				})

				arg_10_0:saveGridLocalData(arg_10_1, iter_10_0, arg_10_0.gridData[arg_10_1][iter_10_0])
			end
		end
	end

	arg_10_0.gridData[arg_10_1][arg_10_2] = EducateGrid.New({
		type = EducateGrid.TYPE_EMPTY
	})

	arg_10_0:saveGridLocalData(arg_10_1, arg_10_2, arg_10_0.gridData[arg_10_1][arg_10_2])

	return
end

function var_0_0.findUI(arg_11_0)
	arg_11_0.bgTF = arg_11_0._tf:Find("anim_root/bg")
	arg_11_0.topTF = arg_11_0._tf:Find("anim_root/top")
	arg_11_0.returnBtn = arg_11_0.topTF:Find("return_btn/return_btn")
	arg_11_0.mainTF = arg_11_0._tf:Find("anim_root/main")
	arg_11_0.leftPanelTF = arg_11_0.mainTF:Find("schedule_left")
	arg_11_0.targetTF = arg_11_0.leftPanelTF:Find("target")

	setText(arg_11_0.targetTF:Find("title"), i18n("child_btn_target") .. ":")

	arg_11_0.scheduleTF = arg_11_0.leftPanelTF:Find("schedule")
	arg_11_0.dayList = UIItemList.New(arg_11_0.scheduleTF, arg_11_0.leftPanelTF:Find("schedule/day_tpl"))
	arg_11_0.monthText = arg_11_0.leftPanelTF:Find("title/month")

	setText(arg_11_0.leftPanelTF:Find("title/right/content/month"), i18n("word_month"))

	arg_11_0.weekText = arg_11_0.leftPanelTF:Find("title/right/content/week")
	arg_11_0.skipToggle = arg_11_0.leftPanelTF:Find("skip_toggle")
	arg_11_0.skipToggleCom = arg_11_0.skipToggle:GetComponent(typeof(Toggle))

	triggerToggle(arg_11_0.skipToggle, PlayerPrefs.GetInt(EducateConst.SKIP_PLANS_ANIM_KEY .. "_" .. arg_11_0.playerID) == 1)
	setActive(arg_11_0.skipToggle, true)
	setText(arg_11_0.skipToggle:Find("Text"), i18n("child_plan_skip"))

	arg_11_0.skipEventToggle = arg_11_0.leftPanelTF:Find("skip_toggle_event")
	arg_11_0.skipEventToggleCom = arg_11_0.skipEventToggle:GetComponent(typeof(Toggle))

	triggerToggle(arg_11_0.skipEventToggle, PlayerPrefs.GetInt(EducateConst.SKIP_PLANS_EVENT_ANIM_KEY .. "_" .. arg_11_0.playerID) == 1)
	setActive(arg_11_0.skipEventToggle, true)
	setText(arg_11_0.skipEventToggle:Find("Text"), i18n("child_plan_skip_event"))

	arg_11_0.selectPanelTF = arg_11_0.leftPanelTF:Find("select_panel")

	setActive(arg_11_0.selectPanelTF, false)

	arg_11_0.selectCloseBtn = arg_11_0.selectPanelTF:Find("fold_btn")
	arg_11_0.plansView = arg_11_0.selectPanelTF:Find("scrollview")
	arg_11_0.rightPanelTF = arg_11_0.mainTF:Find("result_right")
	arg_11_0.rightEmptyTF = arg_11_0.rightPanelTF:Find("empty")

	setText(arg_11_0.rightEmptyTF:Find("Text"), i18n("child_schedule_empty_tip"))

	arg_11_0.rightContentTF = arg_11_0.rightPanelTF:Find("content")
	arg_11_0.buffUIList = UIItemList.New(arg_11_0.rightContentTF:Find("buff_list"), arg_11_0.rightContentTF:Find("buff_list/tpl"))
	arg_11_0.avatarTF = arg_11_0.rightContentTF:Find("avatar")
	arg_11_0.avatarImage = arg_11_0.avatarTF:Find("mask/Image")
	arg_11_0.natureTF = arg_11_0.rightContentTF:Find("nature/unlock")
	arg_11_0.natureLockTF = arg_11_0.rightContentTF:Find("nature/lock")

	setText(arg_11_0.rightContentTF:Find("major_title/Text"), i18n("child_attr_name1"))
	setText(arg_11_0.rightContentTF:Find("minor_title/Text"), i18n("child_attr_name2"))

	arg_11_0.majorUIList = UIItemList.New(arg_11_0.rightContentTF:Find("major"), arg_11_0.rightContentTF:Find("major/tpl"))
	arg_11_0.minorUIList = UIItemList.New(arg_11_0.rightContentTF:Find("minor"), arg_11_0.rightContentTF:Find("minor/tpl"))
	arg_11_0.nextBtn = arg_11_0.rightPanelTF:Find("next_btn")
	arg_11_0.topPanel = EducateTopPanel.New(arg_11_0.topTF:Find("top_right"), arg_11_0.event)

	arg_11_0.topPanel:Load()

	arg_11_0.resPanel = EducateResPanel.New(arg_11_0.topTF:Find("res"), arg_11_0.event)

	arg_11_0.resPanel:Load()

	return
end

function var_0_0.addListener(arg_12_0)
	setActive(arg_12_0.topTF:Find("clear_btn"), false)
	onButton(arg_12_0, arg_12_0.topTF:Find("clear_btn"), function()
		arg_12_0:clearLocalPlans()
		arg_12_0.resPanel:ActionInvoke("Flush")

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.selectPanelTF:Find("index_btn"), function()
		({}).indexDatas = Clone(arg_12_0.contextData.indexDatas) or {}
		;({}).callback = function(arg_15_0)
			arg_12_0.typeIndex = arg_15_0.typeIndex
			arg_12_0.costIndex = arg_15_0.costIndex
			arg_12_0.awardResIndex = arg_15_0.awardResIndex
			arg_12_0.awardNatureIndex = arg_15_0.awardNatureIndex
			arg_12_0.awardAttr1Index = arg_15_0.awardAttr1Index
			arg_12_0.awardAttr2Index = arg_15_0.awardAttr2Index

			arg_12_0:updateIndexDatas()
			arg_12_0:updatePlanList()

			return
		end

		arg_12_0:emit(EducateScheduleMediator.OPEN_FILTER_LAYER, {})

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.returnBtn, function()
		arg_12_0:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.selectCloseBtn, function()
		arg_12_0:closeSelectPanel()

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.nextBtn, function()
		local var_18_0

		table.insert({}, function(arg_19_0)
			if arg_12_0:haveEmpty() then
				arg_12_0:emit(var_0_0.EDUCATE_ON_MSG_TIP, {
					content = i18n("child_schedule_sure_tip"),
					onYes = function()
						var_18_0 = true

						return
					end,
					onExit = function()
						if var_18_0 then
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
		table.insert({}, function(arg_22_0)
			if getProxy(EducateProxy):GetCharData().site > 0 then
				arg_12_0:emit(var_0_0.EDUCATE_ON_MSG_TIP, {
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
		seriesAsync({}, function()
			arg_12_0:executePlans(arg_12_0.skipToggleCom.isOn, arg_12_0.skipEventToggleCom.isOn)

			return
		end)

		return
	end, SFX_PANEL)
	onToggle(arg_12_0, arg_12_0.skipToggle, function(arg_25_0)
		PlayerPrefs.SetInt(EducateConst.SKIP_PLANS_ANIM_KEY .. "_" .. arg_12_0.playerID, arg_25_0 and 1 or 0)

		return
	end, SFX_PANEL)
	onToggle(arg_12_0, arg_12_0.skipEventToggle, function(arg_26_0)
		PlayerPrefs.SetInt(EducateConst.SKIP_PLANS_EVENT_ANIM_KEY .. "_" .. arg_12_0.playerID, arg_26_0 and 1 or 0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.haveEmpty(arg_27_0)
	for iter_27_0 = 1, 6 do
		for iter_27_1 = 1, 3 do
			if arg_27_0.gridData[iter_27_0][iter_27_1]:IsEmpty() then
				return true
			end
		end
	end

	return false
end

function var_0_0.allEmpty(arg_28_0)
	for iter_28_0 = 1, 6 do
		for iter_28_1 = 1, 3 do
			if not arg_28_0.gridData[iter_28_0][iter_28_1]:IsEmpty() and not arg_28_0.gridData[iter_28_0][iter_28_1]:IsLock() then
				return false
			end
		end
	end

	return true
end

function var_0_0.executePlans(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0:emit(EducateScheduleMediator.GET_PLANS, {
		gridData = arg_29_0.gridData,
		isSkip = arg_29_1,
		isSkipEvent = arg_29_2
	})

	return
end

function var_0_0.didEnter(arg_30_0)
	arg_30_0:updateBg()
	arg_30_0:initTimeTitle()
	arg_30_0:initTargetText()
	arg_30_0:updateIndexDatas()
	arg_30_0:initSchedulePanel()
	arg_30_0:initSelectPlans()
	arg_30_0:initResultPanel()
	arg_30_0:checkTips()
	arg_30_0:OverlayPanel(arg_30_0.mainTF, {
		pbList = {
			arg_30_0.mainTF:Find("bg")
		}
	})
	arg_30_0:OverlayPanel(arg_30_0.topTF, {
		groupDelta = 1
	})

	return
end

function var_0_0.checkTips(arg_31_0)
	arg_31_0.newUnlcokPlanIds = EducateTipHelper.GetPlanUnlockTipIds()

	if #arg_31_0.newUnlcokPlanIds > 0 then
		arg_31_0:emit(var_0_0.EDUCATE_ON_UNLOCK_TIP, {
			type = EducateUnlockTipLayer.UNLOCK_TYPE_PLAN,
			list = arg_31_0.newUnlcokPlanIds
		})
	end

	return
end

function var_0_0.updateBg(arg_32_0)
	setImageSprite(arg_32_0.bgTF, LoadSprite("bg/" .. arg_32_0.char:GetBGName()), false)

	return
end

function var_0_0.initTimeTitle(arg_33_0)
	local var_33_0 = EducateHelper.GetTimeAfterWeeks(arg_33_0.curTime, 1)

	setText(arg_33_0.monthText, (EducateHelper.GetShowMonthNumber(var_33_0.month)))
	setText(arg_33_0.weekText, i18n("word_which_week", (i18n("number_" .. var_33_0.week))))

	return
end

function var_0_0.initTargetText(arg_34_0)
	arg_34_0.showAttrSubtype = 0

	local var_34_0 = arg_34_0.educateProxy:GetTaskProxy()
	local var_34_1 = var_34_0:FilterByGroup(var_34_0:GetTargetTasksForShow())[1]

	if not var_34_0:CanGetTargetAward() then
		setText(arg_34_0.targetTF:Find("Text"), i18n("child_task_finish_all"))
		setActive(arg_34_0.targetTF:Find("icon"), false)

		goto label_34_0
	end

	if not var_34_1 then
		setActive(arg_34_0.targetTF, false)
	end

	setText(arg_34_0.targetTF:Find("Text"), var_34_1:getConfig("name"))

	::label_34_0::

	if var_34_1:GetType() == EducateTask.TYPE_ATTR then
		setActive(arg_34_0.targetTF:Find("icon"), true)

		arg_34_0.showAttrSubtype = var_34_1:getConfig("sub_type")

		if type(arg_34_0.showAttrSubtype) == "string" then
			do
				local var_34_2 = arg_34_0.showAttrSubtype or arg_34_0.showAttrSubtype[1]

				GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. var_34_2, arg_34_0.targetTF:Find("icon"))

				if false then
					setActive(arg_34_0.targetTF:Find("icon"), false)
				end
			end

			return
		end
	end
end

function var_0_0.updateIndexDatas(arg_35_0)
	arg_35_0.contextData.indexDatas = arg_35_0.contextData.indexDatas or {}
	arg_35_0.contextData.indexDatas.typeIndex = arg_35_0.typeIndex
	arg_35_0.contextData.indexDatas.costIndex = arg_35_0.costIndex
	arg_35_0.contextData.indexDatas.awardResIndex = arg_35_0.awardResIndex
	arg_35_0.contextData.indexDatas.awardNatureIndex = arg_35_0.awardNatureIndex
	arg_35_0.contextData.indexDatas.awardAttr1Index = arg_35_0.awardAttr1Index
	arg_35_0.contextData.indexDatas.awardAttr2Index = arg_35_0.awardAttr2Index

	return
end

function var_0_0.initSchedulePanel(arg_36_0)
	arg_36_0.dayList:make(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_0 == UIItemList.EventInit then
			local var_37_0 = arg_37_1 + 1

			arg_37_2.name = tostring(arg_37_1 + 1)

			GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", arg_37_1 + 1, arg_37_2:Find("title"), true)

			for iter_37_0 = 1, 3 do
				local var_37_1 = arg_37_2:Find("cells"):GetChild(iter_37_0 - 1)
				local var_37_2 = arg_36_0.planProxy:GetGridBgName(arg_37_1 + 1, iter_37_0)

				GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", var_37_2[1], var_37_1:Find("empty"), true)
				GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", var_37_2[2], var_37_1:Find("plan/name_bg"), true)
				onButton(arg_36_0, var_37_1, function()
					if arg_36_0.gridData[var_37_0][iter_37_0]:IsEvent() or arg_36_0.gridData[var_37_0][iter_37_0]:IsEventOccupy() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("child_schedule_event_tip"))
					else
						arg_36_0:openSelectPanel(var_37_0, iter_37_0)
					end

					return
				end, SFX_PANEL)
			end
		end

		if arg_37_0 == UIItemList.EventUpdate then
			arg_36_0:updateDayGrids(arg_37_1, arg_37_2)
		end

		return
	end)
	arg_36_0.dayList:align(6)

	return
end

function var_0_0._updateGrid(arg_39_0, arg_39_1, arg_39_2)
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
			local var_39_0 = arg_39_2.data:getConfig("type_param")[1] or ""

			LoadImageSpriteAsync("educateprops/" .. var_39_0, arg_39_1:Find("plan/icon"), true)
			setScrollText(arg_39_1:Find("plan/name_bg/Text"), i18n("child_plan_event"))
		end
	end

	return
end

function var_0_0.updateDayGrids(arg_40_0, arg_40_1, arg_40_2)
	for iter_40_0 = 1, 3 do
		local var_40_0 = arg_40_2:Find("cells"):GetChild(iter_40_0 - 1)

		var_40_0.name = tostring(iter_40_0)

		arg_40_0:_updateGrid(var_40_0, arg_40_0.gridData[arg_40_1 + 1][iter_40_0])
	end

	return
end

function var_0_0.initSelectPlans(arg_41_0)
	arg_41_0.plansRect = arg_41_0.plansView:GetComponent("LScrollRect")
	arg_41_0.planCards = {}

	function arg_41_0.plansRect.onInitItem(arg_42_0)
		arg_41_0.planCards[arg_42_0] = EducateSchedulePlanCard.New(arg_42_0, arg_41_0)

		return
	end

	function arg_41_0.plansRect.onUpdateItem(arg_43_0, arg_43_1)
		arg_41_0.planCards[arg_43_1] = arg_41_0.planCards[arg_43_1] or EducateSchedulePlanCard.New(arg_43_1, arg_41_0)

		local var_43_0 = arg_41_0.showPlans[arg_43_0 + 1]
		local var_43_1 = 0
		local var_43_2 = arg_41_0.gridData[arg_41_0.selectDay][arg_41_0.selectIndex]

		if arg_41_0.gridData[arg_41_0.selectDay][arg_41_0.selectIndex] and var_43_2:IsPlanOccupy() or var_43_2:IsPlan() then
			var_43_1 = var_43_2.id
		end

		arg_41_0.planCards[arg_43_1]:update(var_43_0, var_43_1)

		return
	end

	function arg_41_0.plansRect.onReturnItem(arg_44_0, arg_44_1)
		return
	end

	for iter_41_0 = 1, 3 do
		local var_41_0 = arg_41_0.selectPanelTF:Find("day/cells")

		onButton(arg_41_0, var_41_0:GetChild(iter_41_0 - 1), function()
			if arg_41_0.gridData[arg_41_0.selectDay][iter_41_0]:IsEvent() or arg_41_0.gridData[arg_41_0.selectDay][iter_41_0]:IsEventOccupy() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("child_schedule_event_tip"))
			else
				arg_41_0.selectIndex = iter_41_0

				arg_41_0:updateSelectdDay()
				arg_41_0:updatePlanList()
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.openSelectPanel(arg_46_0, arg_46_1, arg_46_2)
	LoadImageSpriteAtlasAsync("ui/educatescheduleui_atlas", arg_46_1, arg_46_0.selectPanelTF:Find("day/title"), true)
	setActive(arg_46_0.selectPanelTF, true)
	setActive(arg_46_0.scheduleTF, false)

	arg_46_0.selectDay = arg_46_1
	arg_46_0.selectIndex = arg_46_2

	arg_46_0:updateSelectdDay()
	arg_46_0:updatePlanList()

	return
end

function var_0_0.updateSelectdDay(arg_47_0)
	local var_47_9000

	for iter_47_0 = 1, 3 do
		local var_47_0 = arg_47_0.selectPanelTF:Find("day/cells")
		local var_47_1 = var_47_0.GetChild(var_47_9000, iter_47_0 - 1)
		local var_47_2 = arg_47_0.gridData[arg_47_0.selectDay][iter_47_0]
		local var_47_3 = arg_47_0.planProxy:GetGridBgName(arg_47_0.selectDay, iter_47_0)

		GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", var_47_0[1], var_47_1:Find("empty"), true)
		GetImageSpriteFromAtlasAsync("ui/educatescheduleui_atlas", var_47_3[2], var_47_1:Find("plan/name_bg"), true)
		setActive(var_47_1:Find("selected"), arg_47_0.selectIndex == iter_47_0)
		arg_47_0:_updateGrid(var_47_1, var_47_2)
	end

	return
end

function var_0_0.updatePlanList(arg_48_0)
	if arg_48_0.selectIndex ~= 0 then
		arg_48_0.showPlans = arg_48_0:filter(arg_48_0.planProxy:GetShowPlans(arg_48_0.char:GetNextWeekStage(), arg_48_0.selectDay, arg_48_0.selectIndex))

		arg_48_0:sortPlans()
		arg_48_0.plansRect:SetTotalCount(#arg_48_0.showPlans, -1)
	end

	return
end

function var_0_0.sortPlans(arg_49_0)
	table.sort(arg_49_0.showPlans, CompareFuncs({
		function(arg_50_0)
			return table.contains(arg_49_0.newUnlcokPlanIds, arg_50_0.id) and 0 or 1
		end,
		function(arg_51_0)
			return arg_51_0:IsMatchAttr(arg_49_0.char) and 0 or 1
		end,
		function(arg_52_0)
			return arg_52_0:CheckResultBySubType(EducateConst.DROP_TYPE_ATTR, arg_49_0.showAttrSubtype) and 0 or 1
		end,
		function(arg_53_0)
			return -arg_53_0:getConfig("rare")
		end,
		function(arg_54_0)
			return arg_54_0.id
		end
	}))

	arg_49_0.newUnlcokPlanIds = {}

	return
end

function var_0_0.OnPlanCardClick(arg_55_0, arg_55_1)
	local var_55_0, var_55_1 = arg_55_0:CheckCondition(arg_55_1)

	if var_55_0 then
		arg_55_0:setGridDataForPlan(arg_55_0.selectDay, arg_55_0.selectIndex, (EducateGrid.New({
			type = EducateGrid.TYPE_PLAN,
			id = arg_55_1.id
		})))
		arg_55_0:updateSelectdDay()
		arg_55_0:updateResultPanel()
		arg_55_0:closeSelectPanel()
	else
		pg.TipsMgr.GetInstance():ShowTips(var_55_1)
	end

	return
end

function var_0_0.filter(arg_56_0, arg_56_1)
	return underscore.select(arg_56_1, function(arg_57_0)
		return EducatePlanIndexConst.filterByType(arg_57_0, arg_56_0.typeIndex) and EducatePlanIndexConst.filterByCost(arg_57_0, arg_56_0.costIndex) and EducatePlanIndexConst.filterByAwardRes(arg_57_0, arg_56_0.awardResIndex) and EducatePlanIndexConst.filterByAwardNature(arg_57_0, arg_56_0.awardNatureIndex) and EducatePlanIndexConst.filterByAwardAttr1(arg_57_0, arg_56_0.awardAttr1Index) and EducatePlanIndexConst.filterByAwardAttr2(arg_57_0, arg_56_0.awardAttr2Index)
	end)
end

function var_0_0.closeSelectPanel(arg_58_0)
	setActive(arg_58_0.selectPanelTF, false)
	setActive(arg_58_0.scheduleTF, true)
	arg_58_0.dayList:align(6)

	return
end

function var_0_0.CheckCondition(arg_59_0, arg_59_1)
	if arg_59_0.gridData[arg_59_0.selectDay][arg_59_0.selectIndex]:IsEvent() or arg_59_0.gridData[arg_59_0.selectDay][arg_59_0.selectIndex]:IsEventOccupy() then
		local var_59_1 = i18n("child_schedule_event_tip")

		return
	end

	local var_59_3, var_59_4, var_59_5 = arg_59_1:GetCost()

	if var_59_5 > 1 and not arg_59_0:CheckRemainGrid(var_59_5, arg_59_0.gridData[arg_59_0.selectDay][arg_59_0.selectIndex].id) then
		local var_59_7 = i18n("child_plan_check_tip1")

		return
	end

	if not arg_59_1:IsMatchAttr(arg_59_0.char) then
		local var_59_9 = i18n("child_plan_check_tip2")

		return
	end

	if not arg_59_1:IsInStage(arg_59_0.char:GetNextWeekStage()) then
		local var_59_11 = i18n("child_plan_check_tip6")

		return
	end

	if not arg_59_1:IsMatchPre(arg_59_0.planProxy:GetHistoryCntById(arg_59_1:getConfig("pre")[1])) then
		local var_59_13 = i18n("child_plan_check_tip3")

		return
	end

	local var_59_14, var_59_15 = arg_59_0:getPlansCost()
	local var_59_16 = 0

	if arg_59_0.gridData[arg_59_0.selectDay][arg_59_0.selectIndex]:IsPlan() or arg_59_0.gridData[arg_59_0.selectDay][arg_59_0.selectIndex]:IsPlanOccupy() then
		local var_59_18

		var_59_16, var_59_18 = var_59_2:GetCost()
	end

	if arg_59_0.char.money < var_59_14 + var_59_3 - var_59_16 then
		local var_59_20 = i18n("child_plan_check_tip4")

		return
	end

	return true
end

function var_0_0.CheckRemainGrid(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_0.selectIndex + arg_60_1 - 1 > 3 then
		return false
	end

	for iter_60_0 = arg_60_0.selectIndex + 1, arg_60_0.selectIndex + arg_60_1 - 1 do
		if not arg_60_0.gridData[arg_60_0.selectDay][iter_60_0]:IsEmpty() and (not arg_60_0.gridData[arg_60_0.selectDay][iter_60_0]:IsPlanOccupy() or arg_60_0.gridData[arg_60_0.selectDay][iter_60_0].id ~= arg_60_2) then
			return false
		end
	end

	return true
end

function var_0_0.showBuffBox(arg_61_0, arg_61_1)
	arg_61_0:emit(var_0_0.EDUCATE_ON_ITEM, {
		drop = {
			number = 1,
			type = EducateConst.DROP_TYPE_BUFF,
			id = arg_61_1
		}
	})

	return
end

function var_0_0.initResultPanel(arg_62_0)
	arg_62_0.resPanel:ActionInvoke("FlushAddValue", "", "")
	arg_62_0.buffUIList:make(function(arg_63_0, arg_63_1, arg_63_2)
		if arg_63_0 == UIItemList.EventUpdate then
			onButton(arg_62_0, arg_63_2, function()
				arg_62_0:showBuffBox(arg_62_0.buffList[arg_63_1 + 1].id)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_62_0.buffUIList:align(#arg_62_0.buffList)

	local var_62_0 = arg_62_0.natureTF:Find("content")
	local var_62_1 = arg_62_0.avatarTF:Find("progress")

	setImageSprite(arg_62_0.avatarTF:Find("mask/Image"), LoadSprite("squareicon/" .. arg_62_0.char:GetPaintingName()), true)

	for iter_62_0, iter_62_1 in ipairs(arg_62_0.natureIds) do
		local var_62_2 = var_62_0:GetChild(iter_62_0 - 1)

		setActive(var_62_2:Find("tip"), false)

		var_62_2.name = iter_62_1

		setScrollText(var_62_2:Find("mask/Text"), pg.child_attr[iter_62_1].name .. " " .. arg_62_0.char:GetAttrById(iter_62_1))
	end

	arg_62_0.majorUIList:make(function(arg_65_0, arg_65_1, arg_65_2)
		if arg_65_0 == UIItemList.EventInit then
			arg_65_2.name = arg_62_0.majorIds[arg_65_1 + 1]

			GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. arg_62_0.majorIds[arg_65_1 + 1], arg_65_2:Find("icon"), true)
			setScrollText(arg_65_2:Find("name_mask/name"), pg.child_attr[arg_62_0.majorIds[arg_65_1 + 1]].name)

			local var_65_0 = arg_62_0.char:GetAttrInfo(arg_62_0.majorIds[arg_65_1 + 1])

			setText(arg_65_2:Find("grade/Text"), var_65_0)
			setText(arg_65_2:Find("before_value"), arg_62_0.char:GetAttrById(arg_62_0.majorIds[arg_65_1 + 1]))
			setActive(arg_65_2:Find("gradient"), false)
			setImageColor(arg_65_2:Find("grade"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_65_0][2]))
		elseif arg_65_0 == UIItemList.EventUpdate then
			local var_65_1 = tonumber(arg_65_2.name)
			local var_65_2 = arg_62_0.char:GetAttrById(var_65_1)

			if arg_62_0.attrResults and arg_62_0.attrResults[var_65_1] then
				var_65_2 = var_65_2 + arg_62_0.attrResults[var_65_1]

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
	arg_62_0.minorUIList:make(function(arg_66_0, arg_66_1, arg_66_2)
		if arg_66_0 == UIItemList.EventInit then
			arg_66_2.name = arg_62_0.minorIds[arg_66_1 + 1]

			GetImageSpriteFromAtlasAsync("ui/educatecommonui_atlas", "attr_" .. arg_62_0.minorIds[arg_66_1 + 1], arg_66_2:Find("icon"), true)
			setText(arg_66_2:Find("value"), arg_62_0.char:GetAttrById(arg_62_0.minorIds[arg_66_1 + 1]))
		elseif arg_66_0 == UIItemList.EventUpdate then
			local var_66_0 = tonumber(arg_66_2.name)
			local var_66_1 = arg_62_0.char:GetAttrById(var_66_0)

			setText(arg_66_2:Find("name"), pg.child_attr[var_66_0].name)

			if arg_62_0.attrResults and arg_62_0.attrResults[var_66_0] then
				var_66_1 = var_66_1 .. setColorStr("+" .. arg_62_0.attrResults[var_66_0], "#9efffe")
			end

			setText(arg_66_2:Find("value"), var_66_1)
		end

		return
	end)

	arg_62_0.attrResults, arg_62_0.resResult = {}, {}

	arg_62_0:updateResultPanel()

	return
end

function var_0_0.updateResultPanel(arg_67_0)
	local var_67_0 = arg_67_0:allEmpty()

	setActive(arg_67_0.rightEmptyTF, var_67_0)
	setActive(arg_67_0.rightContentTF, not var_67_0)

	if not var_67_0 then
		arg_67_0.attrResults, arg_67_0.resResult = arg_67_0:getPlansResult()

		arg_67_0.majorUIList:align(#arg_67_0.majorIds)
		arg_67_0.minorUIList:align(#arg_67_0.minorIds)

		local var_67_1, var_67_2 = arg_67_0:getPlansCost()
		local var_67_3 = arg_67_0.resResult[EducateChar.RES_MONEY_ID] or 0
		local var_67_4 = arg_67_0.resResult[EducateChar.RES_MOOD_ID] or 0

		if var_67_3 - var_67_1 >= 0 then
			local var_67_5 = "+" .. var_67_3 - var_67_1 or var_67_3 - var_67_1

			if var_67_4 - var_67_2 >= 0 then
				local var_67_6 = "+" .. var_67_4 - var_67_2 or var_67_4 - var_67_2

				arg_67_0.resPanel:ActionInvoke("FlushAddValue", var_67_6, var_67_5)

				local var_67_7 = EducateHelper.IsShowNature()

				setActive(arg_67_0.natureTF, var_67_7)
				setActive(arg_67_0.natureLockTF, not var_67_7)

				if var_67_7 then
					eachChild(arg_67_0.natureTF:Find("content"), function(arg_68_0)
						local var_68_0 = tonumber(arg_68_0.name)

						if arg_67_0.attrResults and arg_67_0.attrResults[var_68_0] and arg_67_0.attrResults[var_68_0] ~= 0 then
							local var_68_1 = arg_67_0.attrResults[var_68_0]
							local var_68_2 = arg_67_0.attrResults[var_68_0] > 0 and "+" or ""

							setActive(arg_68_0:Find("tip"), true)
							setImageColor(arg_68_0:Find("tip"), Color.NewHex(var_68_3))
							setText(arg_68_0:Find("tip/Text"), var_68_2 .. var_68_1)
						else
							setActive(arg_68_0:Find("tip"), false)
						end

						return
					end)
				end

				return
			end
		end
	end
end

function var_0_0.getPlansResult(arg_69_0)
	for iter_69_0, iter_69_1 in ipairs(arg_69_0.gridData) do
		for iter_69_2, iter_69_3 in ipairs(iter_69_1) do
			if iter_69_3:IsPlan() then
				for iter_69_4, iter_69_5 in ipairs(iter_69_3.data:GetResult()) do
					if iter_69_5[1] == EducateConst.DROP_TYPE_ATTR then
						local var_69_0 = ({})[iter_69_5[2]]

						if not ({})[iter_69_5[2]] then
							var_69_0 = 0
						end

						;({})[iter_69_5[2]] = var_69_0 + iter_69_5[3]
					elseif iter_69_5[1] == EducateConst.DROP_TYPE_RES then
						local var_69_1 = ({})[iter_69_5[2]]

						if not ({})[iter_69_5[2]] then
							var_69_1 = 0
						end

						;({})[iter_69_5[2]] = var_69_1 + iter_69_5[3]
					end
				end
			end
		end
	end

	return {}, {}
end

function var_0_0.getPlansCost(arg_70_0)
	local var_70_0 = 0
	local var_70_1 = 0

	for iter_70_0, iter_70_1 in pairs(arg_70_0.gridData) do
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

function var_0_0.getRemainGridCnt(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = 1

	for iter_71_0, iter_71_1 in pairs(arg_71_0.gridData[arg_71_1]) do
		if arg_71_2 < iter_71_0 and iter_71_1:IsEmpty() then
			var_71_0 = var_71_0 + 1
		end
	end

	return var_71_0
end

function var_0_0.DoRecommend(arg_72_0)
	local var_72_0 = arg_72_0.char:GetAttrSortIds()

	for iter_72_0, iter_72_1 in pairs(arg_72_0.gridData) do
		for iter_72_2, iter_72_3 in pairs(iter_72_1) do
			if iter_72_3:IsEmpty() then
				local var_72_1, var_72_2 = arg_72_0:getPlansCost()
				local var_72_3 = arg_72_0.planProxy:GetRecommendPlan(iter_72_0, iter_72_2, arg_72_0.char, var_72_1, var_72_2, arg_72_0:getRemainGridCnt(iter_72_0, iter_72_2), var_72_0)

				if var_72_3 then
					arg_72_0:setGridDataForPlan(iter_72_0, iter_72_2, (EducateGrid.New({
						type = EducateGrid.TYPE_PLAN,
						id = var_72_3.id
					})))
				end
			end
		end
	end

	arg_72_0:updateResultPanel()
	arg_72_0:closeSelectPanel()

	return
end

function var_0_0.onBackPressed(arg_73_0)
	if isActive(arg_73_0.selectPanelTF) then
		arg_73_0:closeSelectPanel()
	else
		var_0_0.super.onBackPressed(arg_73_0)
	end

	return
end

function var_0_0.willExit(arg_74_0)
	arg_74_0.topPanel:Destroy()

	arg_74_0.topPanel = nil

	arg_74_0.resPanel:Destroy()

	arg_74_0.resPanel = nil

	arg_74_0:UnOverlayPanel(arg_74_0.mainTF, arg_74_0._tf:Find("anim_root"))
	arg_74_0:UnOverlayPanel(arg_74_0.topTF, arg_74_0._tf:Find("anim_root"))

	for iter_74_0, iter_74_1 in pairs(arg_74_0.planCards) do
		iter_74_1:dispose()
	end

	return
end

return var_0_0
