local var_0_0 = class("NewEducateScheduleScene", import("view.newEducate.base.NewEducateBaseUI"))

var_0_0.PLAN_CNT = 5
var_0_0.TALENT_CNT = 4

function var_0_0.getUIName(arg_1_0)
	return "NewEducateScheduleUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.rootTF = arg_2_0._tf:Find("root")
	arg_2_0.bgTF = arg_2_0.rootTF:Find("bg")
	arg_2_0.mainTF = arg_2_0.rootTF:Find("main")
	arg_2_0.leftTF = arg_2_0.rootTF:Find("main/left")

	local var_2_0 = arg_2_0.leftTF:Find("title")

	arg_2_0.titleRoundTF = var_2_0:Find("round_container/title_round")

	setText(var_2_0:Find("title_front"), i18n("child2_plan_title_front"))
	setText(var_2_0:Find("title_back"), i18n("child2_plan_title_back"))

	arg_2_0.targetTF = arg_2_0.leftTF:Find("target")

	arg_2_0:InitPlanView()

	arg_2_0.planCountTF = arg_2_0.leftTF:Find("cell_title/Text")

	local var_2_1 = arg_2_0.leftTF:Find("cells")
	local var_2_2 = arg_2_0.leftTF:Find("cell_tpl")

	setActive(var_2_2, false)

	arg_2_0.cells = {}

	for iter_2_0 = 1, var_0_0.PLAN_CNT do
		arg_2_0.cells[iter_2_0] = {
			tf = cloneTplTo(var_2_2, var_2_1, iter_2_0)
		}
	end

	arg_2_0.rightTF = arg_2_0.rootTF:Find("main/right")
	arg_2_0.effectTF = arg_2_0.rightTF:Find("effect")
	arg_2_0.moneyTF = arg_2_0.rightTF:Find("money")
	arg_2_0.moodTF = arg_2_0.rightTF:Find("mood")

	setText(arg_2_0.rightTF:Find("attrs/attr_title/Text"), i18n("child2_attr_title"))

	arg_2_0.attrsTF = arg_2_0.rightTF:Find("attrs/attrs")

	setText(arg_2_0.rightTF:Find("talent/talent_title/Text"), i18n("child2_talent_title"))

	arg_2_0.talentsTF = arg_2_0.rightTF:Find("talent/talents")
	arg_2_0.statusTF = arg_2_0.rightTF:Find("status")

	setText(arg_2_0.statusTF:Find("status_title/Text"), i18n("child2_status_title"))

	arg_2_0.tarotTF = arg_2_0.rightTF:Find("tarot")

	setText(arg_2_0.tarotTF:Find("title/Text"), i18n("child2_tarot_title"))

	arg_2_0.tarotIconTF = arg_2_0.tarotTF:Find("bg/icon")
	arg_2_0.tarotNameTF = arg_2_0.tarotTF:Find("bg/name")
	arg_2_0.tarotEntryTF = arg_2_0.tarotTF:Find("bg/entry")

	arg_2_0:InitRightPanel()

	arg_2_0.skipToggle = arg_2_0.rightTF:Find("skip/skip_toggle")

	setText(arg_2_0.rightTF:Find("skip/Text"), i18n("child_plan_skip"))

	arg_2_0.skipToggleCom = arg_2_0.skipToggle:GetComponent(typeof(Toggle))
	arg_2_0.nextBtn = arg_2_0.rightTF:Find("next")
	arg_2_0.nextTempBtn = arg_2_0.rightTF:Find("next_temp")

	return
end

function var_0_0.GetSkipLocalKey(arg_3_0)
	return NewEducateConst.NEW_EDUCATE_SKIP_PLANS_ANIM .. "_" .. arg_3_0.playerID .. "_" .. arg_3_0.contextData.char.id
end

function var_0_0.SetData(arg_4_0)
	arg_4_0.playerID = getProxy(PlayerProxy):getRawData().id
	arg_4_0.planList = arg_4_0.contextData.char:GetPlanList()
	arg_4_0.attrIds = arg_4_0.contextData.char:GetAttrIds()
	arg_4_0.talents = arg_4_0.contextData.char:GetTalentList()
	arg_4_0.status = arg_4_0.contextData.char:GetStatusList()
	arg_4_0.unlockPlanNum = arg_4_0.contextData.char:GetRoundData():getConfig("plan_num")
	arg_4_0.moneyResId = arg_4_0.contextData.char:GetResIdByType(NewEducateChar.RES_TYPE.MONEY)
	arg_4_0.moodResId = arg_4_0.contextData.char:GetResIdByType(NewEducateChar.RES_TYPE.MOOD)
	arg_4_0.selectedCellIdx = 1
	arg_4_0.discountInfos = arg_4_0.contextData.char:GetPlanDiscountInfos()

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:OverlayPanel(arg_5_0.mainTF, {
		pbList = {
			arg_5_0.mainTF:Find("bg")
		}
	})
	onButton(arg_5_0, arg_5_0.mainTF:Find("top/return_btn"), function()
		arg_5_0:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.tarotTF:Find("bg"), function()
		arg_5_0:emit(var_0_0.GO_SUBLAYER, Context.New({
			mediator = NewEducateTarotEntryMediator,
			viewComponent = NewEducateTarotEntryLayer
		}))

		return
	end, SFX_PANEL)
	onToggle(arg_5_0, arg_5_0.skipToggle, function(arg_8_0)
		PlayerPrefs.SetInt(arg_5_0:GetSkipLocalKey(), arg_8_0 and 1 or 0)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.nextBtn, function()
		arg_5_0:OnClickNextBtn()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.nextTempBtn, function()
		arg_5_0:OnClickNextBtn()

		return
	end, SFX_PANEL)
	onScroll(arg_5_0, arg_5_0.statusTF:Find("status"), function(arg_11_0)
		eachChild(arg_5_0.statusUIList.container, function(arg_12_0)
			triggerToggle(arg_12_0, false)

			return
		end)

		return
	end)
	arg_5_0:SetData()
	setActive(arg_5_0.nextTempBtn, arg_5_0.contextData.char:GetRoundData():NextIsTemp())
	triggerToggle(arg_5_0.skipToggle, PlayerPrefs.GetInt(arg_5_0:GetSkipLocalKey()) == 1)
	arg_5_0:UpdateTitle()
	arg_5_0:FlushPlanView()
	arg_5_0:UpdateCells()

	arg_5_0.isTarotChar = arg_5_0.contextData.char:GetPermanentData():IsTarotType()

	setActive(arg_5_0.tarotTF, arg_5_0.isTarotChar)
	setActive(arg_5_0.statusTF, not arg_5_0.isTarotChar)
	arg_5_0:FlushTarot()

	arg_5_0.talentRoundIds = arg_5_0.contextData.char:GetRoundData():GetTalentRoundIds()

	arg_5_0.talentUIList:align(#arg_5_0.talentRoundIds)
	arg_5_0.statusUIList:align(#arg_5_0.status)
	arg_5_0:UpdateReuslt()
	arg_5_0:CheckUpgradePlans()

	return
end

function var_0_0.CheckUpgradePlans(arg_13_0)
	local var_13_0 = underscore.select(arg_13_0.planList, function(arg_14_0)
		return arg_14_0:GetNextId() and arg_13_0.contextData.char:IsMatchComplex(arg_14_0:getConfig("level_condition"))
	end)

	if #var_13_0 > 0 then
		local var_13_1 = {}

		underscore.select(var_13_0, function(arg_15_0)
			table.insert(var_13_1, arg_15_0.id)

			return
		end)
		arg_13_0:emit(NewEducateScheduleMediator.ON_UPGRADE_PLANS, {})
	else
		NewEducateGuideSequence.CheckGuide(arg_13_0.__cname)
	end

	return
end

function var_0_0.OnUpgradePlans(arg_16_0)
	arg_16_0.planList = getProxy(NewEducateProxy):GetCurChar():GetPlanList()

	arg_16_0:FlushPlanView()
	NewEducateGuideSequence.CheckGuide(arg_16_0.__cname)

	return
end

function var_0_0.InitPlanView(arg_17_0)
	local var_17_0 = arg_17_0.leftTF:Find("plan_view/content")
	local var_17_1 = var_17_0:Find("tpl")

	setText(var_17_1:Find("condition/Text"), i18n("child2_plan_upgrade_condition"))

	arg_17_0.planUIList = UIItemList.New(var_17_0, var_17_1)

	arg_17_0.planUIList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			arg_17_0:UpdatePlan(arg_18_1, arg_18_2)
		end

		return
	end)

	return
end

function var_0_0.InitRightPanel(arg_19_0)
	arg_19_0.attrUIList = UIItemList.New(arg_19_0.attrsTF, arg_19_0.attrsTF:Find("tpl"))

	arg_19_0.attrUIList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventInit then
			LoadImageSpriteAsync("neweducateicon/" .. pg.child2_attr[arg_19_0.attrIds[arg_20_1 + 1]].icon, arg_20_2:Find("icon_bg/icon"))
			setScrollText(arg_20_2:Find("name_mask/name"), pg.child2_attr[arg_19_0.attrIds[arg_20_1 + 1]].name)
			setToggleEnabled(arg_20_2, arg_19_0.isTarotChar)

			if arg_19_0.isTarotChar then
				setText(arg_20_2:Find("info/content/name"), pg.child2_attr[arg_19_0.attrIds[arg_20_1 + 1]].name)

				local var_20_0, var_20_1 = NewEducateInfoPanel.GetArrtInfo(pg.child2_attr[arg_19_0.attrIds[arg_20_1 + 1]].rank, (arg_19_0.contextData.char:GetAttr(arg_19_0.attrIds[arg_20_1 + 1])))

				setText(arg_20_2:Find("info/content/value"), var_20_1)

				local var_20_2, var_20_3 = arg_19_0.contextData.char:GetBenefitData():GetDisplayPctByDrop({
					type = NewEducateConst.DROP_TYPE.ATTR,
					id = arg_19_0.attrIds[arg_20_1 + 1]
				})

				setText(arg_20_2:Find("info/content/desc"), i18n("child2_benefit_summary") .. var_20_2 .. "%" .. "\n" .. i18n("child2_benefit_summary2") .. var_20_3 .. "%")
			end
		elseif arg_20_0 == UIItemList.EventUpdate then
			arg_19_0:UpdateAttr(arg_20_1, arg_20_2)
		end

		return
	end)

	arg_19_0.talentUIList = UIItemList.New(arg_19_0.talentsTF, arg_19_0.talentsTF:Find("tpl"))

	arg_19_0.talentUIList:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventInit then
			arg_19_0:UpdateTalent(arg_21_1, arg_21_2)
		end

		return
	end)

	local var_19_0 = arg_19_0.statusTF:Find("status/content/content")

	arg_19_0.statusUIList = UIItemList.New(var_19_0, var_19_0:Find("tpl"))

	arg_19_0.statusUIList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventInit then
			arg_19_0:UpdateStatus(arg_22_1, arg_22_2)
		end

		return
	end)

	return
end

function var_0_0.UpdateTitle(arg_23_0)
	if arg_23_0.contextData.char:GetRoundData():IsEndless() then
		arg_23_0:UpdateEndlessTitle()
	else
		arg_23_0:UpdateNormalTitle()
	end

	local var_23_0 = arg_23_0.contextData.char:GetRoundData()

	setImageSprite(arg_23_0.bgTF, LoadSprite("bg/" .. var_23_0:getConfig("main_background")), false)

	return
end

function var_0_0.UpdateNormalTitle(arg_24_0)
	local var_24_0, var_24_1, var_24_2 = arg_24_0.contextData.char:GetRoundData():GetProgressInfo()

	setText(arg_24_0.titleRoundTF, var_24_0)
	setText(arg_24_0.targetTF:Find("round"), i18n("child2_assess_round", var_24_1))

	local var_24_3 = arg_24_0.contextData.char:GetAttrSum()

	setText(arg_24_0.targetTF:Find("target"), i18n("child2_schedule_target", var_24_3, var_24_2))

	local var_24_4 = var_24_3 < var_24_2 and setColorStr(var_24_3, "#ff6767") or var_24_3

	setText(arg_24_0.targetTF:Find("value"), var_24_4 .. "/" .. var_24_2)

	return
end

function var_0_0.UpdateEndlessTitle(arg_25_0)
	local var_25_0, var_25_1, var_25_2 = arg_25_0.contextData.char:GetRoundData():GetEndlessProgressInfos()

	setText(arg_25_0.titleRoundTF, var_25_0)
	setText(arg_25_0.targetTF:Find("round"), i18n("child2_assess_round", 0))

	local var_25_3 = arg_25_0.contextData.char:GetAttrSum()

	setText(arg_25_0.targetTF:Find("target"), i18n("child2_schedule_target", var_25_3, var_25_2))

	local var_25_4 = var_25_3 < var_25_2 and setColorStr(var_25_3, "#ff6767") or var_25_3

	setText(arg_25_0.targetTF:Find("value"), var_25_4 .. "/" .. var_25_2)

	return
end

function var_0_0.UpdateCells(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.cells) do
		arg_26_0:UpdateCell(iter_26_0)
	end

	return
end

function var_0_0.UpdateCellReduce(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.cells) do
		local var_27_0 = arg_27_0.cells[iter_27_0].tf:Find("unlock/reduce")
		local var_27_1 = arg_27_0.cells[iter_27_0].plan and iter_27_0 + 1 == arg_27_0.selectedCellIdx

		setActive(var_27_0, var_27_1)
	end

	return
end

function var_0_0.UpdateCell(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.cells[arg_28_1].tf
	local var_28_1 = arg_28_0.cells[arg_28_1].plan

	var_28_0.name = arg_28_1

	local var_28_2 = arg_28_1 <= arg_28_0.unlockPlanNum

	setActive(var_28_0:Find("unlock"), arg_28_1 <= arg_28_0.unlockPlanNum)
	setActive(var_28_0:Find("lock"), not var_28_2)

	if var_28_2 then
		setActive(var_28_0:Find("unlock/arrows"), false)
		setActive(var_28_0:Find("unlock/icon"), var_28_1)
		setActive(var_28_0:Find("unlock/reduce"), var_28_1 and arg_28_1 + 1 == arg_28_0.selectedCellIdx)

		if var_28_1 then
			LoadImageSpriteAsync("neweducateicon/" .. var_28_1:getConfig("icon_square"), var_28_0:Find("unlock/icon"))
		end
	end

	onButton(arg_28_0, var_28_0, function()
		if var_28_1 and arg_28_1 + 1 == arg_28_0.selectedCellIdx then
			arg_28_0.cells[arg_28_1].plan = nil
			arg_28_0.selectedCellIdx = math.max(arg_28_0.selectedCellIdx - 1, 1)

			arg_28_0:UpdateCell(arg_28_1)
			arg_28_0:UpdateCellReduce()
			arg_28_0:UpdateReuslt()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdatePlan(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.showList[arg_30_1 + 1]
	local var_30_1 = arg_30_0.showList[arg_30_1 + 1]:GetNextId()

	setText(arg_30_2:Find("name"), arg_30_0.showList[arg_30_1 + 1]:getConfig("name"))
	onButton(arg_30_0, arg_30_2, function()
		arg_30_0:OnClickPlan(var_30_0)

		return
	end, SFX_PANEL)
	LoadImageSpriteAsync("neweducateicon/" .. arg_30_0.showList[arg_30_1 + 1]:getConfig("icon_rectangle"), arg_30_2:Find("icon"))

	local var_30_2 = arg_30_0.showList[arg_30_1 + 1]:GetCostShowInfos()
	local var_30_3 = arg_30_0.showList[arg_30_1 + 1]:GetCostWithBenefit(arg_30_0.discountInfos)
	local var_30_4 = UIItemList.New(arg_30_2:Find("normal/cost"), arg_30_2:Find("normal/cost/tpl"))

	var_30_4:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			NewEducateHelper.UpdateVectorItem(arg_32_2, var_30_2[arg_32_1 + 1], "-")

			if var_30_3[arg_32_1 + 1].number ~= var_30_2[arg_32_1 + 1].number then
				setText(arg_32_2:Find("value"), "-" .. var_30_2[arg_32_1 + 1].number .. "(" .. var_30_3[arg_32_1 + 1].number .. ")")
			end
		end

		return
	end)
	var_30_4:align(#arg_30_0.showList[arg_30_1 + 1]:GetCostShowInfos())
	LoadImageSpriteAtlasAsync("ui/neweducatescheduleui_atlas", arg_30_0.showList[arg_30_1 + 1]:GetAwardBg(), arg_30_2:Find("normal/award"))

	local var_30_5 = arg_30_0.showList[arg_30_1 + 1]:GetAwardShowInfos()
	local var_30_6 = UIItemList.New(arg_30_2:Find("normal/award"), arg_30_2:Find("normal/award/tpl"))

	var_30_6:make(function(arg_33_0, arg_33_1, arg_33_2)
		if arg_33_0 == UIItemList.EventUpdate then
			NewEducateHelper.UpdateVectorItem(arg_33_2, var_30_5[arg_33_1 + 1], var_30_5[arg_33_1 + 1].number > 0 and "+" or "")
		end

		return
	end)
	var_30_6:align(#arg_30_0.showList[arg_30_1 + 1]:GetAwardShowInfos())
	setActive(arg_30_2:Find("toggle"), var_30_1)

	if var_30_1 then
		local var_30_7 = arg_30_0.showList[arg_30_1 + 1]:getConfig("condition_desc")
		local var_30_8 = UIItemList.New(arg_30_2:Find("condition/conditions"), arg_30_2:Find("condition/conditions/tpl"))

		var_30_8:make(function(arg_34_0, arg_34_1, arg_34_2)
			if arg_34_0 == UIItemList.EventUpdate then
				local var_34_0 = var_30_7[arg_34_1 + 1][2]

				if not arg_30_0.contextData.char:LogicalOperator({
					operator = "||",
					conditions = var_30_7[arg_34_1 + 1][1]
				}) then
					var_34_0 = string.gsub(var_34_0, "f7f7f7", "ff6767")
				end

				setText(arg_34_2:Find("name"), var_34_0)
				setActive(arg_34_2:Find("icon"), false)
				setActive(arg_34_2:Find("value"), false)
			end

			return
		end)
		var_30_8:align(#arg_30_0.showList[arg_30_1 + 1]:getConfig("condition_desc"))
	end

	return
end

function var_0_0.OnClickPlan(arg_35_0, arg_35_1)
	if arg_35_0.selectedCellIdx > arg_35_0.unlockPlanNum then
		return
	end

	seriesAsync({
		function(arg_36_0)
			local var_36_0, var_36_1, var_36_2 = arg_35_0:CalcPlanResult(arg_35_1)

			if arg_35_0.contextData.char:GetRes(arg_35_0.moneyResId) + arg_35_0.moneyResult + var_36_0 < 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("child_plan_check_tip4"))

				return
			end

			arg_36_0()

			return
		end
	}, function()
		arg_35_0.cells[arg_35_0.selectedCellIdx].plan = arg_35_1

		arg_35_0:UpdateCell(arg_35_0.selectedCellIdx)

		arg_35_0.selectedCellIdx = arg_35_0.selectedCellIdx + 1

		arg_35_0:UpdateCellReduce()
		arg_35_0:UpdateReuslt()

		return
	end)

	return
end

function var_0_0.FlushPlanView(arg_38_0)
	arg_38_0.showList = underscore.select(arg_38_0.planList, function(arg_39_0)
		return arg_39_0:IsShow()
	end)

	arg_38_0.planUIList:align(#arg_38_0.showList)

	return
end

function var_0_0.FlushTarot(arg_40_0)
	arg_40_0.tarotId = arg_40_0.contextData.char:GetTarotId()

	setActive(arg_40_0.tarotIconTF, arg_40_0.tarotId)

	if arg_40_0.tarotId then
		LoadImageSpriteAsync("neweducateicon/" .. pg.child2_benefit_list[arg_40_0.tarotId].item_icon_little, arg_40_0.tarotIconTF)
	end

	local var_40_1 = arg_40_0.tarotNameTF

	if arg_40_0.tarotId then
		local var_40_2 = pg.child2_benefit_list[arg_40_0.tarotId].name or "EMPTY"

		var_40_0(var_40_1, var_40_2)

		arg_40_0.entries = arg_40_0.contextData.char:GetBenefitData():GetListByType(NewEducateBuff.TYPE.ENTRY)

		setText(arg_40_0.tarotEntryTF, i18n("child2_entry_summary") .. #arg_40_0.entries)

		return
	end
end

function var_0_0.UpdateEffect(arg_41_0, arg_41_1)
	setText(arg_41_0.effectTF, string.gsub("$1", "$1", i18n("child2_mood_desc" .. arg_41_0.contextData.char:GetMoodStage(arg_41_1))))

	return
end

function var_0_0.UpdateTalent(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0.talents[arg_42_1 + 1]

	setActive(arg_42_2:Find("unlock"), arg_42_0.talents[arg_42_1 + 1])
	setActive(arg_42_2:Find("lock"), not var_42_0)
	setImageAlpha(arg_42_2, var_42_0 and 1 or 0.4)

	if var_42_0 then
		LoadImageSpriteAsync("neweducateicon/" .. var_42_0:getConfig("item_icon_little"), arg_42_2:Find("unlock/icon"))
		setText(arg_42_2:Find("unlock/name"), shortenString(var_42_0:getConfig("name"), 5))
		setText(arg_42_2:Find("unlock/info/content/name"), var_42_0:getConfig("name"))
		setText(arg_42_2:Find("unlock/info/content/desc"), var_42_0:getConfig("desc"))
	end

	return
end

function var_0_0.UpdateStatus(arg_43_0, arg_43_1, arg_43_2)
	LoadImageSpriteAsync("neweducateicon/" .. arg_43_0.status[arg_43_1 + 1]:getConfig("item_icon"), arg_43_2:Find("icon"))

	local var_43_1 = var_43_0:getConfig("during_time") == -1 and i18n("child2_status_time2") or i18n("child2_status_time1", var_43_0:GetEndRound() - arg_43_0.contextData.char:GetRoundData().round)

	setText(arg_43_2:Find("time/Text"), var_43_1)
	setText(arg_43_2:Find("info/content/name"), var_43_0:getConfig("name"))
	setText(arg_43_2:Find("info/content/desc"), var_43_0:getConfig("desc"))

	return
end

function var_0_0.CalcPlanResult(arg_44_0, arg_44_1)
	local var_44_0 = 0
	local var_44_1 = 0

	underscore.each(arg_44_1:GetCostWithBenefit(arg_44_0.discountInfos), function(arg_45_0)
		switch(arg_45_0.type, {
			[NewEducateConst.DROP_TYPE.RES] = function()
				if arg_45_0.id == arg_44_0.moneyResId then
					var_44_0 = var_44_0 + arg_45_0.number
				elseif arg_45_0.id == arg_44_0.moodResId then
					var_44_1 = var_44_1 + arg_45_0.number
				end

				return
			end
		})

		return
	end)

	local var_44_2 = 0
	local var_44_3 = 0
	local var_44_4 = {}

	underscore.each(arg_44_1:GetAwardShowInfos(), function(arg_47_0)
		switch(arg_47_0.type, {
			[NewEducateConst.DROP_TYPE.RES] = function()
				if arg_47_0.id == arg_44_0.moneyResId then
					var_44_2 = var_44_2 + arg_47_0.number
				elseif arg_47_0.id == arg_44_0.moodResId then
					var_44_3 = var_44_3 + arg_47_0.number
				end

				return
			end,
			[NewEducateConst.DROP_TYPE.ATTR] = function()
				var_44_4[arg_47_0.id] = var_44_4[arg_47_0.id] or 0
				var_44_4[arg_47_0.id] = var_44_4[arg_47_0.id] + arg_47_0.number

				return
			end
		})

		return
	end)

	return 0 - 0, 0 - 0, {}
end

function var_0_0.CalcCurResult(arg_50_0)
	arg_50_0.attrResult = {}
	arg_50_0.moneyResult = 0
	arg_50_0.moodResult = 0

	underscore.each(arg_50_0.cells, function(arg_51_0)
		if arg_51_0.plan then
			local var_51_0, var_51_1, var_51_2 = arg_50_0:CalcPlanResult(arg_51_0.plan)

			arg_50_0.moneyResult = arg_50_0.moneyResult + var_51_0
			arg_50_0.moodResult = arg_50_0.moodResult + var_51_1

			for iter_51_0, iter_51_1 in pairs(var_51_2) do
				arg_50_0.attrResult[iter_51_0] = arg_50_0.attrResult[iter_51_0] or 0
				arg_50_0.attrResult[iter_51_0] = arg_50_0.attrResult[iter_51_0] + iter_51_1
			end
		end

		return
	end)

	return
end

function var_0_0.GetColor(arg_52_0, arg_52_1)
	if arg_52_1 == 0 then
		return "ffffff"
	else
		return arg_52_1 > 0 and "2df7bc" or "ff6767"
	end

	return
end

function var_0_0.UpdateAttr(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_0.contextData.char:GetAttr(arg_53_0.attrIds[arg_53_1 + 1])
	local var_53_1, var_53_2 = NewEducateInfoPanel.GetArrtInfo(pg.child2_attr[arg_53_0.attrIds[arg_53_1 + 1]].rank, var_53_0)

	setText(arg_53_2:Find("rank/Text"), var_53_1)
	setImageColor(arg_53_2:Find("rank"), Color.NewHex(EducateConst.GRADE_2_COLOR[var_53_1][2]))
	setText(arg_53_2:Find("before_value"), var_53_0)

	local var_53_3 = arg_53_0.attrResult[arg_53_0.attrIds[arg_53_1 + 1]] or 0

	setText(arg_53_2:Find("after_value"), var_53_0 + var_53_3)

	local var_53_4 = arg_53_0:GetColor(var_53_3)

	setImageColor(arg_53_2:Find("arrow"), Color.NewHex(var_53_4))
	setTextColor(arg_53_2:Find("after_value"), Color.NewHex(var_53_4))

	return
end

function var_0_0.UpdateReuslt(arg_54_0)
	arg_54_0.selectedCnt = underscore.reduce(arg_54_0.cells, 0, function(arg_55_0, arg_55_1)
		return arg_55_0 + (arg_55_1.plan and 1 or 0)
	end)

	setText(arg_54_0.planCountTF, arg_54_0.selectedCnt .. "/" .. arg_54_0.unlockPlanNum)
	arg_54_0:CalcCurResult()

	local var_54_0 = arg_54_0.contextData.char:GetRes(arg_54_0.moneyResId)

	setText(arg_54_0.moneyTF:Find("before_value"), var_54_0)
	setText(arg_54_0.moneyTF:Find("after_value"), var_54_0 + arg_54_0.moneyResult)

	local var_54_1 = arg_54_0:GetColor(arg_54_0.moneyResult)

	setImageColor(arg_54_0.moneyTF:Find("arrow"), Color.NewHex(var_54_1))
	setTextColor(arg_54_0.moneyTF:Find("after_value"), Color.NewHex(var_54_1))

	local var_54_2 = arg_54_0.contextData.char:GetRes(arg_54_0.moodResId)

	setText(arg_54_0.moodTF:Find("before_value"), var_54_2)

	local var_54_3 = math.min(pg.child2_resource[arg_54_0.moodResId].max_value, (math.max(pg.child2_resource[arg_54_0.moodResId].min_value, var_54_2 + arg_54_0.moodResult)))

	setText(arg_54_0.moodTF:Find("after_value"), var_54_3)

	local var_54_4 = arg_54_0:GetColor(arg_54_0.moodResult)

	setImageColor(arg_54_0.moodTF:Find("arrow"), Color.NewHex(var_54_4))
	setTextColor(arg_54_0.moodTF:Find("after_value"), Color.NewHex(var_54_4))
	arg_54_0:UpdateEffect(var_54_3)
	arg_54_0.attrUIList:align(#arg_54_0.attrIds)

	return
end

function var_0_0.SetScheduleData(arg_56_0, arg_56_1)
	arg_56_0.contextData.scheduleDataTable.OnScheduleDone = arg_56_1

	return
end

function var_0_0.OnClickNextBtn(arg_57_0)
	local var_57_0 = ""
	local var_57_1 = false

	if arg_57_0.selectedCnt < arg_57_0.unlockPlanNum then
		var_57_0 = i18n("child2_schedule_sure_tip")
		var_57_1 = true
	end

	if arg_57_0.contextData.char:GetPoint() > 0 then
		var_57_0 = var_57_1 and i18n("child2_schedule_sure_tip3") or i18n("child2_schedule_sure_tip2")
	end

	table.insert({}, function(arg_58_0)
		if var_57_0 ~= "" then
			arg_57_0:emit(var_0_0.ON_BOX, {
				content = var_57_0,
				onYes = arg_58_0
			})
		else
			arg_58_0()
		end

		return
	end)
	seriesAsync({}, function()
		arg_57_0:emit(NewEducateScheduleMediator.ON_SELECTED_PLANS, arg_57_0.skipToggleCom.isOn, arg_57_0.cells)

		return
	end)

	return
end

function var_0_0.willExit(arg_60_0)
	arg_60_0:UnOverlayPanel(arg_60_0.mainTF, arg_60_0.rootTF)

	return
end

return var_0_0
