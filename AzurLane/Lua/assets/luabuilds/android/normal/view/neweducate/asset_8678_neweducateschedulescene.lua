class = var_0_10000

local var_0_0 = "NewEducateScheduleScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.newEducate.base.NewEducateBaseUI"))

var_0_1.PLAN_CNT = 5
var_0_1.TALENT_CNT = 4

function var_0_1.getUIName(arg_1_0)
	return "NewEducateScheduleUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rootTF = var_1.Find(var_2_0, "root")

	local var_2_1 = arg_2_0.rootTF

	arg_2_0.bgTF = var_1.Find(var_2_1, "bg")

	local var_2_2 = arg_2_0.rootTF

	arg_2_0.mainTF = var_1.Find(var_2_2, "main")

	local var_2_3 = arg_2_0.rootTF

	arg_2_0.leftTF = var_1.Find(var_2_3, "main/left")

	local var_2_4 = arg_2_0.leftTF
	local var_2_5 = var_1.Find(var_2_4, "title")

	arg_2_0.titleRoundTF = var_1.Find(var_2_5, "round_container/title_round")
	setText = var_2

	local var_2_6 = var_1
	local var_2_7 = var_1.Find(var_2_6, "title_front")

	i18n = var_2_6

	var_2(var_2_7, var_2_6("child2_plan_title_front"))

	setText = var_2

	local var_2_8 = var_1
	local var_2_9 = var_1.Find(var_2_8, "title_back")

	i18n = var_2_8

	var_2(var_2_9, var_2_8("child2_plan_title_back"))

	local var_2_10 = arg_2_0.leftTF

	arg_2_0.targetTF = var_2.Find(var_2_10, "target")

	arg_2_0:InitPlanView()

	local var_2_11 = arg_2_0.leftTF

	arg_2_0.planCountTF = var_2.Find(var_2_11, "cell_title/Text")

	local var_2_12 = arg_2_0.leftTF
	local var_2_13 = var_2.Find(var_2_12, "cells")
	local var_2_14 = arg_2_0.leftTF
	local var_2_15 = var_3.Find(var_2_14, "cell_tpl")

	setActive = var_2_14

	var_2_14(var_2_15, false)

	arg_2_0.cells = {}

	for iter_2_0 = 1, var_0_1.PLAN_CNT do
		local var_2_16 = arg_2_0.cells
		local var_2_17 = {}

		cloneTplTo = var_1_10010
		var_2_17.tf = var_1_10010(var_2_15, var_2_13, iter_2_0)
		var_2_16[iter_2_0] = var_2_17
	end

	local var_2_18 = arg_2_0.rootTF

	arg_2_0.rightTF = var_4.Find(var_2_18, "main/right")

	local var_2_19 = arg_2_0.rightTF

	arg_2_0.effectTF = var_4.Find(var_2_19, "effect")

	local var_2_20 = arg_2_0.rightTF

	arg_2_0.moneyTF = var_4.Find(var_2_20, "money")

	local var_2_21 = arg_2_0.rightTF

	arg_2_0.moodTF = var_4.Find(var_2_21, "mood")
	setText = var_4

	local var_2_22 = arg_2_0.rightTF
	local var_2_23 = var_5.Find(var_2_22, "attrs/attr_title/Text")

	i18n = var_2_22

	var_4(var_2_23, var_2_22("child2_attr_title"))

	local var_2_24 = arg_2_0.rightTF

	arg_2_0.attrsTF = var_4.Find(var_2_24, "attrs/attrs")
	setText = var_4

	local var_2_25 = arg_2_0.rightTF
	local var_2_26 = var_5.Find(var_2_25, "talent/talent_title/Text")

	i18n = var_2_25

	var_4(var_2_26, var_2_25("child2_talent_title"))

	local var_2_27 = arg_2_0.rightTF

	arg_2_0.talentsTF = var_4.Find(var_2_27, "talent/talents")

	local var_2_28 = arg_2_0.rightTF

	arg_2_0.statusTF = var_4.Find(var_2_28, "status")
	setText = var_4

	local var_2_29 = arg_2_0.statusTF
	local var_2_30 = var_5.Find(var_2_29, "status_title/Text")

	i18n = var_2_29

	var_4(var_2_30, var_2_29("child2_status_title"))

	local var_2_31 = arg_2_0.rightTF

	arg_2_0.tarotTF = var_4.Find(var_2_31, "tarot")
	setText = var_4

	local var_2_32 = arg_2_0.tarotTF
	local var_2_33 = var_5.Find(var_2_32, "title/Text")

	i18n = var_2_32

	var_4(var_2_33, var_2_32("child2_tarot_title"))

	local var_2_34 = arg_2_0.tarotTF

	arg_2_0.tarotIconTF = var_4.Find(var_2_34, "bg/icon")

	local var_2_35 = arg_2_0.tarotTF

	arg_2_0.tarotNameTF = var_4.Find(var_2_35, "bg/name")

	local var_2_36 = arg_2_0.tarotTF

	arg_2_0.tarotEntryTF = var_4.Find(var_2_36, "bg/entry")

	arg_2_0:InitRightPanel()

	local var_2_37 = arg_2_0.rightTF

	arg_2_0.skipToggle = var_4.Find(var_2_37, "skip/skip_toggle")
	setText = var_4

	local var_2_38 = arg_2_0.rightTF
	local var_2_39 = var_5.Find(var_2_38, "skip/Text")

	i18n = var_2_38

	var_4(var_2_39, var_2_38("child_plan_skip"))

	local var_2_40 = arg_2_0.skipToggle
	local var_2_41 = var_4.GetComponent

	typeof = var_6
	Toggle = var_7
	arg_2_0.skipToggleCom = var_2_41(var_2_40, var_6(var_7))

	local var_2_42 = arg_2_0.rightTF

	arg_2_0.nextBtn = var_4.Find(var_2_42, "next")

	local var_2_43 = arg_2_0.rightTF

	arg_2_0.nextTempBtn = var_4.Find(var_2_43, "next_temp")

	return
end

function var_0_1.GetSkipLocalKey(arg_3_0)
	NewEducateConst = var_1_10001

	return var_1_10001.NEW_EDUCATE_SKIP_PLANS_ANIM .. "_" .. arg_3_0.playerID .. "_" .. arg_3_0.contextData.char.id
end

function var_0_1.SetData(arg_4_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)

	arg_4_0.playerID = var_1.getRawData(var_4_0).id

	local var_4_1 = arg_4_0.contextData.char

	arg_4_0.planList = var_1.GetPlanList(var_4_1)

	local var_4_2 = arg_4_0.contextData.char

	arg_4_0.attrIds = var_1.GetAttrIds(var_4_2)

	local var_4_3 = arg_4_0.contextData.char

	arg_4_0.talents = var_1.GetTalentList(var_4_3)

	local var_4_4 = arg_4_0.contextData.char

	arg_4_0.status = var_1.GetStatusList(var_4_4)

	local var_4_5 = arg_4_0.contextData.char
	local var_4_6 = var_1.GetRoundData(var_4_5)

	arg_4_0.unlockPlanNum = var_1.getConfig(var_4_6, "plan_num")

	local var_4_7 = arg_4_0.contextData.char
	local var_4_8 = var_1.GetResIdByType

	NewEducateChar = var_3
	arg_4_0.moneyResId = var_4_8(var_4_7, var_3.RES_TYPE.MONEY)

	local var_4_9 = arg_4_0.contextData.char
	local var_4_10 = var_1.GetResIdByType

	NewEducateChar = var_3
	arg_4_0.moodResId = var_4_10(var_4_9, var_3.RES_TYPE.MOOD)
	arg_4_0.selectedCellIdx = 1

	local var_4_11 = arg_4_0.contextData.char

	arg_4_0.discountInfos = var_1.GetPlanDiscountInfos(var_4_11)

	return
end

function var_0_1.didEnter(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.OverlayPanel
	local var_5_2 = arg_5_0.mainTF
	local var_5_3 = {}
	local var_5_4 = {}
	local var_5_5 = arg_5_0.mainTF

	var_5_4[1] = var_6.Find(var_5_5, "bg")
	var_5_3.pbList = var_5_4

	var_5_1(var_5_0, var_5_2, var_5_3)

	onButton = var_5_1

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.mainTF
	local var_5_8 = var_3.Find(var_5_7, "top/return_btn")

	local function var_5_9()
		local var_6_0 = arg_5_0

		var_0.onBackPressed(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_5_1(var_5_6, var_5_8, var_5_9, var_5)

	onButton = var_5_1

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.tarotTF
	local var_5_12 = var_3.Find(var_5_11, "bg")

	local function var_5_13()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit
		local var_7_2 = var_0_1.GO_SUBLAYER

		Context = var_2_10003

		local var_7_3 = var_2_10003.New
		local var_7_4 = {}

		NewEducateTarotEntryMediator = var_2_10005
		var_7_4.mediator = var_2_10005
		NewEducateTarotEntryLayer = var_2_10005
		var_7_4.viewComponent = var_2_10005

		var_7_1(var_7_0, var_7_2, var_7_3(var_7_4))

		return
	end

	SFX_PANEL = var_5

	var_5_1(var_5_10, var_5_12, var_5_13, var_5)

	onToggle = var_5_1

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0.skipToggle

	local function var_5_16(arg_8_0)
		PlayerPrefs = var_2_10001

		local var_8_0 = var_2_10001.SetInt
		local var_8_1 = arg_5_0

		var_8_0(var_2.GetSkipLocalKey(var_8_1), arg_8_0 and 1 or 0)

		return
	end

	SFX_PANEL = var_5

	var_5_1(var_5_14, var_5_15, var_5_16, var_5)

	onButton = var_5_1

	local var_5_17 = arg_5_0
	local var_5_18 = arg_5_0.nextBtn

	local function var_5_19()
		local var_9_0 = arg_5_0

		var_0.OnClickNextBtn(var_9_0)

		return
	end

	SFX_PANEL = var_5

	var_5_1(var_5_17, var_5_18, var_5_19, var_5)

	onButton = var_5_1

	local var_5_20 = arg_5_0
	local var_5_21 = arg_5_0.nextTempBtn

	local function var_5_22()
		local var_10_0 = arg_5_0

		var_0.OnClickNextBtn(var_10_0)

		return
	end

	SFX_PANEL = var_5

	var_5_1(var_5_20, var_5_21, var_5_22, var_5)

	onScroll = var_5_1

	local var_5_23 = arg_5_0
	local var_5_24 = arg_5_0.statusTF

	var_5_1(var_5_23, var_3.Find(var_5_24, "status"), function(arg_11_0)
		eachChild = var_2_10001

		var_2_10001(arg_5_0.statusUIList.container, function(arg_12_0)
			triggerToggle = var_3_10001

			var_3_10001(arg_12_0, false)

			return
		end)

		return
	end)
	arg_5_0:SetData()

	setActive = var_1

	local var_5_25 = arg_5_0.nextTempBtn
	local var_5_26 = arg_5_0.contextData.char
	local var_5_27 = var_3.GetRoundData(var_5_26)

	var_1(var_5_25, var_3.NextIsTemp(var_5_27))

	PlayerPrefs = var_1

	local var_5_28 = var_1.GetInt(arg_5_0:GetSkipLocalKey())

	triggerToggle = var_2

	var_2(arg_5_0.skipToggle, var_5_28 == 1)
	arg_5_0:UpdateTitle()
	arg_5_0:FlushPlanView()
	arg_5_0:UpdateCells()

	local var_5_29 = arg_5_0.contextData.char
	local var_5_30 = var_2.GetPermanentData(var_5_29)

	arg_5_0.isTarotChar = var_2.IsTarotType(var_5_30)
	setActive = var_2

	var_2(arg_5_0.tarotTF, arg_5_0.isTarotChar)

	setActive = var_2

	var_2(arg_5_0.statusTF, not arg_5_0.isTarotChar)
	arg_5_0:FlushTarot()

	local var_5_31 = arg_5_0.contextData.char
	local var_5_32 = var_2.GetRoundData(var_5_31)

	arg_5_0.talentRoundIds = var_2.GetTalentRoundIds(var_5_32)

	local var_5_33 = arg_5_0.talentUIList

	var_2.align(var_5_33, #arg_5_0.talentRoundIds)

	local var_5_34 = arg_5_0.statusUIList

	var_2.align(var_5_34, #arg_5_0.status)
	arg_5_0:UpdateReuslt()
	arg_5_0:CheckUpgradePlans()

	return
end

function var_0_1.CheckUpgradePlans(arg_13_0)
	underscore = var_1_10001

	local var_13_0 = #var_1_10001.select(arg_13_0.planList, function(arg_14_0)
		local var_14_1

		if arg_14_0:GetNextId() then
			local var_14_0 = arg_13_0.contextData.char

			var_14_1 = var_1.IsMatchComplex(var_14_0, arg_14_0:getConfig("level_condition"))
		end

		return var_14_1
	end)

	if 0 < var_13_0 then
		var_13_0 = {}
		underscore = var_3

		var_3.select(var_1, function(arg_15_0)
			table = var_2_10001

			var_2_10001.insert(var_13_0, arg_15_0.id)

			return
		end)

		local var_13_1 = arg_13_0
		local var_13_2 = arg_13_0.emit

		NewEducateScheduleMediator = var_5

		var_13_2(var_13_1, var_5.ON_UPGRADE_PLANS, var_13_0)
	else
		NewEducateGuideSequence = var_13_0

		var_13_0.CheckGuide(arg_13_0.__cname)
	end

	return
end

function var_0_1.OnUpgradePlans(arg_16_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10002

	local var_16_0 = var_1_10001(var_1_10002)
	local var_16_1 = var_1.GetCurChar(var_16_0)

	arg_16_0.planList = var_1.GetPlanList(var_16_1)

	arg_16_0:FlushPlanView()

	NewEducateGuideSequence = var_1

	var_1.CheckGuide(arg_16_0.__cname)

	return
end

function var_0_1.InitPlanView(arg_17_0)
	local var_17_0 = arg_17_0.leftTF
	local var_17_1 = var_1.Find(var_17_0, "plan_view/content")
	local var_17_2 = var_1.Find(var_17_1, "tpl")

	setText = var_17_1

	local var_17_3 = var_17_2
	local var_17_4 = var_17_2.Find(var_17_3, "condition/Text")

	i18n = var_17_3

	var_17_1(var_17_4, var_17_3("child2_plan_upgrade_condition"))

	UIItemList = var_17_1
	arg_17_0.planUIList = var_17_1.New(var_1, var_17_2)

	local var_17_5 = arg_17_0.planUIList

	var_3.make(var_17_5, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			local var_18_0 = arg_17_0

			var_3.UpdatePlan(var_18_0, arg_18_1, arg_18_2)
		end

		return
	end)

	return
end

function var_0_1.InitRightPanel(arg_19_0)
	UIItemList = var_1_10001

	local var_19_0 = var_1_10001.New
	local var_19_1 = arg_19_0.attrsTF
	local var_19_2 = arg_19_0.attrsTF

	arg_19_0.attrUIList = var_19_0(var_19_1, var_3.Find(var_19_2, "tpl"))

	local var_19_3 = arg_19_0.attrUIList

	var_1.make(var_19_3, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		local var_20_0

		if arg_20_0 == var_2_10003.EventInit then
			var_20_0 = arg_19_0.attrIds[arg_20_1 + 1]
			pg = var_4

			local var_20_1 = var_4.child2_attr[var_20_0]

			LoadImageSpriteAsync = var_2_10005

			var_2_10005("neweducateicon/" .. var_20_1.icon, arg_20_2:Find("icon_bg/icon"))

			setScrollText = var_2_10005

			var_2_10005(arg_20_2:Find("name_mask/name"), var_20_1.name)

			setToggleEnabled = var_2_10005

			var_2_10005(arg_20_2, arg_19_0.isTarotChar)

			if arg_19_0.isTarotChar then
				setText = var_5

				var_5(arg_20_2:Find("info/content/name"), var_20_1.name)

				local var_20_2 = arg_19_0.contextData.char
				local var_20_3 = var_5.GetAttr(var_20_2, var_20_0)

				NewEducateInfoPanel = var_20_2

				local var_20_4, var_20_5 = var_20_2.GetArrtInfo(var_20_1.rank, var_20_3)

				setText = var_8

				var_8(arg_20_2:Find("info/content/value"), var_20_5)

				local var_20_6 = arg_19_0.contextData.char
				local var_20_7 = var_8.GetBenefitData(var_20_6)
				local var_20_8 = var_8.GetDisplayPctByDrop
				local var_20_9 = {}

				NewEducateConst = var_2_10012
				var_20_9.type = var_2_10012.DROP_TYPE.ATTR
				var_20_9.id = var_20_0

				local var_20_10, var_20_11 = var_20_8(var_20_7, var_20_9)

				i18n = var_20_9

				local var_20_12 = var_20_9("child2_benefit_summary")
				local var_20_13 = var_20_10
				local var_20_14 = "%"
				local var_20_15 = "\n"

				i18n = var_2_10015

				local var_20_16 = var_20_12 .. var_20_13 .. var_20_14 .. var_20_15 .. var_2_10015("child2_benefit_summary2") .. var_20_11 .. "%"

				setText = var_20_13

				var_20_13(arg_20_2:Find("info/content/desc"), var_20_16)
			end
		else
			UIItemList = var_20_0

			if arg_20_0 == var_20_0.EventUpdate then
				local var_20_17 = arg_19_0

				var_3.UpdateAttr(var_20_17, arg_20_1, arg_20_2)
			end
		end

		return
	end)

	UIItemList = var_1

	local var_19_4 = var_1.New
	local var_19_5 = arg_19_0.talentsTF
	local var_19_6 = arg_19_0.talentsTF

	arg_19_0.talentUIList = var_19_4(var_19_5, var_3.Find(var_19_6, "tpl"))

	local var_19_7 = arg_19_0.talentUIList

	var_1.make(var_19_7, function(arg_21_0, arg_21_1, arg_21_2)
		UIItemList = var_2_10003

		if arg_21_0 == var_2_10003.EventInit then
			local var_21_0 = arg_19_0

			var_3.UpdateTalent(var_21_0, arg_21_1, arg_21_2)
		end

		return
	end)

	local var_19_8 = arg_19_0.statusTF
	local var_19_9 = var_1.Find(var_19_8, "status/content/content")

	UIItemList = var_19_8
	arg_19_0.statusUIList = var_19_8.New(var_19_9, var_19_9:Find("tpl"))

	local var_19_10 = arg_19_0.statusUIList

	var_2.make(var_19_10, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventInit then
			local var_22_0 = arg_19_0

			var_3.UpdateStatus(var_22_0, arg_22_1, arg_22_2)
		end

		return
	end)

	return
end

function var_0_1.UpdateTitle(arg_23_0)
	local var_23_0 = arg_23_0.contextData.char
	local var_23_1 = var_1.GetRoundData(var_23_0)

	if var_1.IsEndless(var_23_1) then
		arg_23_0:UpdateEndlessTitle()
	else
		arg_23_0:UpdateNormalTitle()
	end

	local var_23_2 = arg_23_0.contextData.char
	local var_23_3 = var_1.GetRoundData(var_23_2)
	local var_23_4 = var_1.getConfig(var_23_3, "main_background")

	setImageSprite = var_23_3

	local var_23_5 = arg_23_0.bgTF

	LoadSprite = var_1_10004

	var_23_3(var_23_5, var_1_10004("bg/" .. var_23_4), false)

	return
end

function var_0_1.UpdateNormalTitle(arg_24_0)
	local var_24_0 = arg_24_0.contextData.char
	local var_24_1 = var_1.GetRoundData(var_24_0)
	local var_24_2, var_24_3, var_24_4 = var_1.GetProgressInfo(var_24_1)

	setText = var_1_10005

	var_1_10005(arg_24_0.titleRoundTF, var_24_2)

	setText = var_1_10005

	local var_24_5 = arg_24_0.targetTF
	local var_24_6 = var_6.Find(var_24_5, "round")

	i18n = var_24_5

	var_1_10005(var_24_6, var_24_5("child2_assess_round", var_24_3))

	local var_24_7 = arg_24_0.contextData.char
	local var_24_8 = var_5.GetAttrSum(var_24_7)

	setText = var_24_7

	local var_24_9 = arg_24_0.targetTF
	local var_24_10 = var_7.Find(var_24_9, "target")

	i18n = var_24_9

	var_24_7(var_24_10, var_24_9("child2_schedule_target", var_24_8, var_24_4))

	setText = var_24_7

	local var_24_11 = arg_24_0.targetTF
	local var_24_12 = var_7.Find(var_24_11, "value")

	if var_24_8 < var_24_4 then
		setColorStr = var_24_11

		local var_24_13

		if not var_24_11(var_24_8, "#ff6767") then
			var_24_13 = var_24_8
		end

		var_24_7(var_24_12, var_24_13 .. "/" .. var_24_4)

		return
	end
end

function var_0_1.UpdateEndlessTitle(arg_25_0)
	local var_25_0 = arg_25_0.contextData.char
	local var_25_1 = var_1.GetRoundData(var_25_0)
	local var_25_2, var_25_3, var_25_4 = var_1.GetEndlessProgressInfos(var_25_1)

	setText = var_1_10005

	var_1_10005(arg_25_0.titleRoundTF, var_25_2)

	setText = var_1_10005

	local var_25_5 = arg_25_0.targetTF
	local var_25_6 = var_6.Find(var_25_5, "round")

	i18n = var_25_5

	var_1_10005(var_25_6, var_25_5("child2_assess_round", 0))

	local var_25_7 = arg_25_0.contextData.char
	local var_25_8 = var_5.GetAttrSum(var_25_7)

	setText = var_25_7

	local var_25_9 = arg_25_0.targetTF
	local var_25_10 = var_7.Find(var_25_9, "target")

	i18n = var_25_9

	var_25_7(var_25_10, var_25_9("child2_schedule_target", var_25_8, var_25_4))

	setText = var_25_7

	local var_25_11 = arg_25_0.targetTF
	local var_25_12 = var_7.Find(var_25_11, "value")

	if var_25_8 < var_25_4 then
		setColorStr = var_25_11

		local var_25_13

		if not var_25_11(var_25_8, "#ff6767") then
			var_25_13 = var_25_8
		end

		var_25_7(var_25_12, var_25_13 .. "/" .. var_25_4)

		return
	end
end

function var_0_1.UpdateCells(arg_26_0)
	ipairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0.cells) do
		arg_26_0:UpdateCell(iter_26_0)
	end

	return
end

function var_0_1.UpdateCellReduce(arg_27_0)
	ipairs = var_1_10001

	for iter_27_0, iter_27_1 in var_1_10001(arg_27_0.cells) do
		local var_27_0 = arg_27_0.cells[iter_27_0].tf

		setActive = var_1_10007

		local var_27_1 = var_27_0:Find("unlock/reduce")
		local var_27_2

		if arg_27_0.cells[iter_27_0].plan then
			var_27_2 = iter_27_0 + 1 == arg_27_0.selectedCellIdx
		end

		var_1_10007(var_27_1, var_27_2)
	end

	return
end

function var_0_1.UpdateCell(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.cells[arg_28_1].tf
	local var_28_1 = arg_28_0.cells[arg_28_1].plan

	var_28_0.name = arg_28_1

	local var_28_2 = arg_28_1 <= arg_28_0.unlockPlanNum

	setActive = var_1_10005

	var_1_10005(var_28_0:Find("unlock"), var_28_2)

	setActive = var_1_10005

	var_1_10005(var_28_0:Find("lock"), not var_28_2)

	if var_28_2 then
		setActive = var_1_10005

		var_1_10005(var_28_0:Find("unlock/arrows"), false)

		setActive = var_1_10005

		var_1_10005(var_28_0:Find("unlock/icon"), var_28_1)

		setActive = var_1_10005

		var_1_10005(var_28_0:Find("unlock/reduce"), var_28_1 and arg_28_1 + 1 == arg_28_0.selectedCellIdx)

		if var_28_1 then
			LoadImageSpriteAsync = var_1_10005

			var_1_10005("neweducateicon/" .. var_28_1:getConfig("icon_square"), var_28_0:Find("unlock/icon"))
		end
	end

	onButton = var_1_10005

	local var_28_3 = arg_28_0
	local var_28_4 = var_28_0

	local function var_28_5()
		if var_28_1 and arg_28_1 + 1 == arg_28_0.selectedCellIdx then
			arg_28_0.cells[arg_28_1].plan = nil

			local var_29_0 = arg_28_0

			math = var_1
			var_29_0.selectedCellIdx = var_1.max(arg_28_0.selectedCellIdx - 1, 1)

			local var_29_1 = arg_28_0

			var_0.UpdateCell(var_29_1, arg_28_1)

			local var_29_2 = arg_28_0

			var_0.UpdateCellReduce(var_29_2)

			local var_29_3 = arg_28_0

			var_0.UpdateReuslt(var_29_3)
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_1_10005(var_28_3, var_28_4, var_28_5, var_1_10009)

	return
end

function var_0_1.UpdatePlan(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.showList[arg_30_1 + 1]
	local var_30_1 = var_3.GetNextId(var_30_0)

	setText = var_30_0

	var_30_0(arg_30_2:Find("name"), var_3:getConfig("name"))

	onButton = var_30_0

	local var_30_2 = arg_30_0
	local var_30_3 = arg_30_2

	local function var_30_4()
		local var_31_0 = arg_30_0

		var_0.OnClickPlan(var_31_0, var_0)

		return
	end

	SFX_PANEL = var_9

	var_30_0(var_30_2, var_30_3, var_30_4, var_9)

	LoadImageSpriteAsync = var_30_0

	var_30_0("neweducateicon/" .. var_3:getConfig("icon_rectangle"), arg_30_2:Find("icon"))

	local var_30_5 = var_3:GetCostShowInfos()
	local var_30_6 = var_3
	local var_30_7 = var_3.GetCostWithBenefit(var_30_6, arg_30_0.discountInfos)

	UIItemList = var_30_6

	local var_30_8 = var_30_6.New(arg_30_2:Find("normal/cost"), arg_30_2:Find("normal/cost/tpl"))

	var_7.make(var_30_8, function(arg_32_0, arg_32_1, arg_32_2)
		UIItemList = var_2_10003

		if arg_32_0 == var_2_10003.EventUpdate then
			local var_32_0 = var_30_5[arg_32_1 + 1]

			NewEducateHelper = var_4

			var_4.UpdateVectorItem(arg_32_2, var_32_0, "-")

			if var_30_7[arg_32_1 + 1].number ~= var_32_0.number then
				local var_32_1 = "(" .. var_4.number .. ")"

				setText = var_6

				var_6(arg_32_2:Find("value"), "-" .. var_32_0.number .. var_32_1)
			end
		end

		return
	end)
	var_7:align(#var_30_5)

	LoadImageSpriteAtlasAsync = var_8

	var_8("ui/neweducatescheduleui_atlas", var_3:GetAwardBg(), arg_30_2:Find("normal/award"))

	local var_30_9 = var_3
	local var_30_10 = var_3.GetAwardShowInfos(var_30_9)

	UIItemList = var_30_9

	local var_30_11 = var_30_9.New(arg_30_2:Find("normal/award"), arg_30_2:Find("normal/award/tpl"))

	var_9.make(var_30_11, function(arg_33_0, arg_33_1, arg_33_2)
		UIItemList = var_2_10003

		if arg_33_0 == var_2_10003.EventUpdate then
			local var_33_0 = var_30_10[arg_33_1 + 1]

			NewEducateHelper = var_4

			var_4.UpdateVectorItem(arg_33_2, var_33_0, var_33_0.number > 0 and "+" or "")
		end

		return
	end)
	var_9:align(#var_30_10)

	setActive = var_10

	var_10(arg_30_2:Find("toggle"), var_30_1)

	if var_30_1 then
		local var_30_12 = var_3
		local var_30_13 = var_3.getConfig(var_30_12, "condition_desc")

		UIItemList = var_30_12

		local var_30_14 = var_30_12.New(arg_30_2:Find("condition/conditions"), arg_30_2:Find("condition/conditions/tpl"))

		var_11.make(var_30_14, function(arg_34_0, arg_34_1, arg_34_2)
			UIItemList = var_2_10003

			if arg_34_0 == var_2_10003.EventUpdate then
				local var_34_0 = var_30_13[arg_34_1 + 1]
				local var_34_1 = arg_30_0.contextData.char
				local var_34_2 = var_4.LogicalOperator(var_34_1, {
					operator = "||",
					conditions = var_34_0[1]
				})
				local var_34_3 = var_34_0[2]

				if not var_34_2 then
					string = var_6
					var_34_3 = var_6.gsub(var_34_3, "f7f7f7", "ff6767")
				end

				setText = var_6

				var_6(arg_34_2:Find("name"), var_34_3)

				setActive = var_6

				var_6(arg_34_2:Find("icon"), false)

				setActive = var_6

				var_6(arg_34_2:Find("value"), false)
			end

			return
		end)
		var_11:align(#var_30_13)
	end

	return
end

function var_0_1.OnClickPlan(arg_35_0, arg_35_1)
	if arg_35_0.selectedCellIdx > arg_35_0.unlockPlanNum then
		return
	end

	seriesAsync = var_2

	var_2({
		function(arg_36_0)
			local var_36_0 = arg_35_0
			local var_36_1, var_36_2, var_36_3 = var_1.CalcPlanResult(var_36_0, arg_35_1)
			local var_36_4 = arg_35_0.contextData.char

			if var_4.GetRes(var_36_4, arg_35_0.moneyResId) + arg_35_0.moneyResult + var_36_1 < 0 then
				pg = var_5

				local var_36_5 = var_5.TipsMgr.GetInstance()
				local var_36_6 = var_5.ShowTips

				i18n = var_2_10007

				var_36_6(var_36_5, var_2_10007("child_plan_check_tip4"))

				return
			end

			arg_36_0()

			return
		end
	}, function()
		arg_35_0.cells[arg_35_0.selectedCellIdx].plan = arg_35_1

		local var_37_0 = arg_35_0

		var_0.UpdateCell(var_37_0, arg_35_0.selectedCellIdx)

		arg_35_0.selectedCellIdx = arg_35_0.selectedCellIdx + 1

		local var_37_1 = arg_35_0

		var_0.UpdateCellReduce(var_37_1)

		local var_37_2 = arg_35_0

		var_0.UpdateReuslt(var_37_2)

		return
	end)

	return
end

function var_0_1.FlushPlanView(arg_38_0)
	underscore = var_1_10001
	arg_38_0.showList = var_1_10001.select(arg_38_0.planList, function(arg_39_0)
		return arg_39_0:IsShow()
	end)

	local var_38_0 = arg_38_0.planUIList

	var_1.align(var_38_0, #arg_38_0.showList)

	return
end

function var_0_1.FlushTarot(arg_40_0)
	local var_40_0 = arg_40_0.contextData.char

	arg_40_0.tarotId = var_1.GetTarotId(var_40_0)
	setActive = var_1

	var_1(arg_40_0.tarotIconTF, arg_40_0.tarotId)

	if arg_40_0.tarotId then
		LoadImageSpriteAsync = var_1

		local var_40_1 = "neweducateicon/"

		pg = var_3

		var_1(var_40_1 .. var_3.child2_benefit_list[arg_40_0.tarotId].item_icon_little, arg_40_0.tarotIconTF)
	end

	setText = var_1

	local var_40_2 = arg_40_0.tarotNameTF

	if arg_40_0.tarotId then
		pg = var_3

		local var_40_3

		if not var_3.child2_benefit_list[arg_40_0.tarotId].name then
			var_40_3 = "EMPTY"
		end

		var_1(var_40_2, var_40_3)

		local var_40_4 = arg_40_0.contextData.char
		local var_40_5 = var_1.GetBenefitData(var_40_4)
		local var_40_6 = var_1.GetListByType

		NewEducateBuff = var_40_3
		arg_40_0.entries = var_40_6(var_40_5, var_40_3.TYPE.ENTRY)
		setText = var_1

		local var_40_7 = arg_40_0.tarotEntryTF

		i18n = var_3

		var_1(var_40_7, var_3("child2_entry_summary") .. #arg_40_0.entries)

		return
	end
end

function var_0_1.UpdateEffect(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.contextData.char
	local var_41_1 = var_2.GetMoodStage(var_41_0, arg_41_1)

	setText = var_41_0

	local var_41_2 = arg_41_0.effectTF

	string = var_1_10005

	local var_41_3 = var_1_10005.gsub
	local var_41_4 = "$1"
	local var_41_5 = "$1"

	i18n = var_1_10008

	var_41_0(var_41_2, var_41_3(var_41_4, var_41_5, var_1_10008("child2_mood_desc" .. var_41_1)))

	return
end

function var_0_1.UpdateTalent(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0.talents[arg_42_1 + 1]

	setActive = var_4

	var_4(arg_42_2:Find("unlock"), var_42_0)

	setActive = var_4

	var_4(arg_42_2:Find("lock"), not var_42_0)

	setImageAlpha = var_4

	var_4(arg_42_2, var_42_0 and 1 or 0.4)

	if var_42_0 then
		LoadImageSpriteAsync = var_4

		var_4("neweducateicon/" .. var_42_0:getConfig("item_icon_little"), arg_42_2:Find("unlock/icon"))

		setText = var_4

		local var_42_1 = arg_42_2
		local var_42_2 = arg_42_2.Find(var_42_1, "unlock/name")

		shortenString = var_42_1

		var_4(var_42_2, var_42_1(var_42_0:getConfig("name"), 5))

		setText = var_4

		var_4(arg_42_2:Find("unlock/info/content/name"), var_42_0:getConfig("name"))

		setText = var_4

		var_4(arg_42_2:Find("unlock/info/content/desc"), var_42_0:getConfig("desc"))
	end

	return
end

function var_0_1.UpdateStatus(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.status[arg_43_1 + 1]

	LoadImageSpriteAsync = var_4

	var_4("neweducateicon/" .. var_43_0:getConfig("item_icon"), arg_43_2:Find("icon"))

	local var_43_1 = var_43_0:getConfig("during_time")
	local var_43_2 = var_43_0:GetEndRound()
	local var_43_3 = arg_43_0.contextData.char
	local var_43_4 = var_43_2 - var_6.GetRoundData(var_43_3).round

	if var_43_1 == -1 then
		i18n = var_43_5

		local var_43_5

		if not var_43_5("child2_status_time2") then
			i18n = var_43_5
			var_43_5 = var_43_5("child2_status_time1", var_43_4)
		end

		setText = var_43_3

		var_43_3(arg_43_2:Find("time/Text"), var_43_5)

		setText = var_43_3

		var_43_3(arg_43_2:Find("info/content/name"), var_43_0:getConfig("name"))

		setText = var_43_3

		var_43_3(arg_43_2:Find("info/content/desc"), var_43_0:getConfig("desc"))

		return
	end
end

function var_0_1.CalcPlanResult(arg_44_0, arg_44_1)
	local var_44_0 = 0
	local var_44_1 = 0

	underscore = var_1_10004

	var_1_10004.each(arg_44_1:GetCostWithBenefit(arg_44_0.discountInfos), function(arg_45_0)
		switch = var_2_10001

		local var_45_0 = arg_45_0.type
		local var_45_1 = {}

		NewEducateConst = var_2_10004
		var_45_1[var_2_10004.DROP_TYPE.RES] = function()
			if arg_45_0.id == arg_44_0.moneyResId then
				var_44_0 = var_44_0 + arg_45_0.number
			elseif arg_45_0.id == arg_44_0.moodResId then
				var_44_1 = var_44_1 + arg_45_0.number
			end

			return
		end

		var_2_10001(var_45_0, var_45_1)

		return
	end)

	local var_44_2 = 0
	local var_44_3 = 0
	local var_44_4 = {}

	underscore = var_7

	var_7.each(arg_44_1:GetAwardShowInfos(), function(arg_47_0)
		switch = var_2_10001

		local var_47_0 = arg_47_0.type
		local var_47_1 = {}

		NewEducateConst = var_2_10004
		var_47_1[var_2_10004.DROP_TYPE.RES] = function()
			if arg_47_0.id == arg_44_0.moneyResId then
				var_44_2 = var_44_2 + arg_47_0.number
			elseif arg_47_0.id == arg_44_0.moodResId then
				var_44_3 = var_44_3 + arg_47_0.number
			end

			return
		end
		NewEducateConst = var_4
		var_47_1[var_4.DROP_TYPE.ATTR] = function()
			if not var_44_4[arg_47_0.id] then
				var_44_4[arg_47_0.id] = 0
			end

			var_44_4[arg_47_0.id] = var_44_4[arg_47_0.id] + arg_47_0.number

			return
		end

		var_2_10001(var_47_0, var_47_1)

		return
	end)

	return var_44_2 - var_44_0, var_44_3 - var_44_1, var_44_4
end

function var_0_1.CalcCurResult(arg_50_0)
	arg_50_0.attrResult = {}
	arg_50_0.moneyResult = 0
	arg_50_0.moodResult = 0
	underscore = var_1

	var_1.each(arg_50_0.cells, function(arg_51_0)
		if arg_51_0.plan then
			local var_51_0 = arg_50_0
			local var_51_1, var_51_2, var_51_3 = var_1.CalcPlanResult(var_51_0, arg_51_0.plan)

			arg_50_0.moneyResult = arg_50_0.moneyResult + var_51_1

			local var_51_4 = arg_50_0

			var_51_4.moodResult = arg_50_0.moodResult + var_51_2
			pairs = var_51_4

			for iter_51_0, iter_51_1 in var_51_4(var_51_3) do
				if not arg_50_0.attrResult[iter_51_0] then
					arg_50_0.attrResult[iter_51_0] = 0
				end

				arg_50_0.attrResult[iter_51_0] = arg_50_0.attrResult[iter_51_0] + iter_51_1
			end
		end

		return
	end)

	return
end

function var_0_1.GetColor(arg_52_0, arg_52_1)
	if arg_52_1 == 0 then
		return "ffffff"
	else
		return arg_52_1 > 0 and "2df7bc" or "ff6767"
	end

	return
end

function var_0_1.UpdateAttr(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_0.attrIds[arg_53_1 + 1]
	local var_53_1 = arg_53_0.contextData.char
	local var_53_2 = var_4.GetAttr(var_53_1, var_53_0)

	NewEducateInfoPanel = var_53_1

	local var_53_3 = var_53_1.GetArrtInfo

	pg = var_6

	local var_53_4, var_53_5 = var_53_3(var_6.child2_attr[var_53_0].rank, var_53_2)

	setText = var_7

	var_7(arg_53_2:Find("rank/Text"), var_53_4)

	setImageColor = var_7

	local var_53_6 = arg_53_2
	local var_53_7 = arg_53_2.Find(var_53_6, "rank")

	Color = var_53_6

	local var_53_8 = var_53_6.NewHex

	EducateConst = var_10

	var_7(var_53_7, var_53_8(var_10.GRADE_2_COLOR[var_53_4][2]))

	setText = var_7

	var_7(arg_53_2:Find("before_value"), var_53_2)

	local var_53_9

	if not arg_53_0.attrResult[var_53_0] then
		var_53_9 = 0
	end

	setText = var_8

	var_8(arg_53_2:Find("after_value"), var_53_2 + var_53_9)

	local var_53_10 = arg_53_0
	local var_53_11 = arg_53_0.GetColor(var_53_10, var_53_9)

	setImageColor = var_53_10

	local var_53_12 = arg_53_2
	local var_53_13 = arg_53_2.Find(var_53_12, "arrow")

	Color = var_53_12

	var_53_10(var_53_13, var_53_12.NewHex(var_53_11))

	setTextColor = var_53_10

	local var_53_14 = arg_53_2
	local var_53_15 = arg_53_2.Find(var_53_14, "after_value")

	Color = var_53_14

	var_53_10(var_53_15, var_53_14.NewHex(var_53_11))

	return
end

function var_0_1.UpdateReuslt(arg_54_0)
	underscore = var_1_10001
	arg_54_0.selectedCnt = var_1_10001.reduce(arg_54_0.cells, 0, function(arg_55_0, arg_55_1)
		return arg_55_0 + (arg_55_1.plan and 1 or 0)
	end)
	setText = var_1

	var_1(arg_54_0.planCountTF, arg_54_0.selectedCnt .. "/" .. arg_54_0.unlockPlanNum)
	arg_54_0:CalcCurResult()

	local var_54_0 = arg_54_0.contextData.char
	local var_54_1 = var_1.GetRes(var_54_0, arg_54_0.moneyResId)

	setText = var_54_0

	local var_54_2 = arg_54_0.moneyTF

	var_54_0(var_3.Find(var_54_2, "before_value"), var_54_1)

	setText = var_54_0

	local var_54_3 = arg_54_0.moneyTF

	var_54_0(var_3.Find(var_54_3, "after_value"), var_54_1 + arg_54_0.moneyResult)

	local var_54_4 = arg_54_0
	local var_54_5 = arg_54_0.GetColor(var_54_4, arg_54_0.moneyResult)

	setImageColor = var_54_4

	local var_54_6 = arg_54_0.moneyTF
	local var_54_7 = var_4.Find(var_54_6, "arrow")

	Color = var_54_6

	var_54_4(var_54_7, var_54_6.NewHex(var_54_5))

	setTextColor = var_54_4

	local var_54_8 = arg_54_0.moneyTF
	local var_54_9 = var_4.Find(var_54_8, "after_value")

	Color = var_54_8

	var_54_4(var_54_9, var_54_8.NewHex(var_54_5))

	local var_54_10 = arg_54_0.contextData.char
	local var_54_11 = var_3.GetRes(var_54_10, arg_54_0.moodResId)

	setText = var_54_10

	local var_54_12 = arg_54_0.moodTF

	var_54_10(var_5.Find(var_54_12, "before_value"), var_54_11)

	local var_54_13 = var_54_11 + arg_54_0.moodResult

	math = var_5

	local var_54_14 = var_5.max

	pg = var_6

	local var_54_15 = var_54_14(var_6.child2_resource[arg_54_0.moodResId].min_value, var_54_13)

	math = var_5

	local var_54_16 = var_5.min

	pg = var_6

	local var_54_17 = var_54_16(var_6.child2_resource[arg_54_0.moodResId].max_value, var_54_15)

	setText = var_5

	local var_54_18 = arg_54_0.moodTF

	var_5(var_6.Find(var_54_18, "after_value"), var_54_17)

	local var_54_19 = arg_54_0
	local var_54_20 = arg_54_0.GetColor(var_54_19, arg_54_0.moodResult)

	setImageColor = var_54_19

	local var_54_21 = arg_54_0.moodTF
	local var_54_22 = var_7.Find(var_54_21, "arrow")

	Color = var_54_21

	var_54_19(var_54_22, var_54_21.NewHex(var_54_20))

	setTextColor = var_54_19

	local var_54_23 = arg_54_0.moodTF
	local var_54_24 = var_7.Find(var_54_23, "after_value")

	Color = var_54_23

	var_54_19(var_54_24, var_54_23.NewHex(var_54_20))
	arg_54_0:UpdateEffect(var_54_17)

	local var_54_25 = arg_54_0.attrUIList

	var_6.align(var_54_25, #arg_54_0.attrIds)

	return
end

function var_0_1.SetScheduleData(arg_56_0, arg_56_1)
	arg_56_0.contextData.scheduleDataTable.OnScheduleDone = arg_56_1

	return
end

function var_0_1.OnClickNextBtn(arg_57_0)
	local var_57_0 = {}
	local var_57_1 = ""
	local var_57_2 = false

	if arg_57_0.selectedCnt < arg_57_0.unlockPlanNum then
		i18n = var_4
		var_57_1 = var_4("child2_schedule_sure_tip")
		var_57_2 = true
	end

	local var_57_3 = arg_57_0.contextData.char

	if var_4.GetPoint(var_57_3) > 0 then
		if var_57_2 then
			i18n = var_4

			if not var_4("child2_schedule_sure_tip3") then
				::label_57_0::

				i18n = var_4
				var_57_1 = var_4("child2_schedule_sure_tip2")
			end

			table = var_4

			var_4.insert(var_57_0, function(arg_58_0)
				if var_57_1 ~= "" then
					local var_58_0 = arg_57_0

					var_1.emit(var_58_0, var_0_1.ON_BOX, {
						content = var_57_1,
						onYes = arg_58_0
					})
				else
					arg_58_0()
				end

				return
			end)

			seriesAsync = var_4

			var_4(var_57_0, function()
				local var_59_0 = arg_57_0
				local var_59_1 = var_0.emit

				NewEducateScheduleMediator = var_2_10002

				var_59_1(var_59_0, var_2_10002.ON_SELECTED_PLANS, arg_57_0.skipToggleCom.isOn, arg_57_0.cells)

				return
			end)

			return
		end
	end
end

function var_0_1.willExit(arg_60_0)
	arg_60_0:UnOverlayPanel(arg_60_0.mainTF, arg_60_0.rootTF)

	return
end

return var_0_1
