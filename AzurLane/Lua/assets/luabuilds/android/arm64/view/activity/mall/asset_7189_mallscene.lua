class = var_0_10000

local var_0_0 = "MallScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "MallUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10004
	DftAniEvent = var_1_10006
	arg_2_0.animDft = var_2_1(var_2_0, var_1_10004(var_1_10006))

	local var_2_2 = arg_2_0.animDft

	var_1.SetEndEvent(var_2_2, function(arg_3_0)
		var_0_1.super.onBackPressed(arg_2_0)

		return
	end)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiBackBtn

	local function var_2_5()
		local var_4_0 = arg_2_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiHomeBtn

	local function var_2_8()
		local var_5_0 = arg_2_0

		var_0.quickExitFunc(var_5_0)

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_2_6, var_2_7, var_2_8, var_1_10006)

	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.uiHelpBtn

	local function var_2_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.mall_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_9, var_2_10, var_2_11, var_1_10006)

	onButton = var_1

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.uiMapBtn

	local function var_2_14()
		local var_7_0 = arg_2_0
		local var_7_1 = var_0.emit

		MallMediator = var_2_10003

		local var_7_2 = var_2_10003.CHANGE_SCENE

		SCENE = var_2_10004

		var_7_1(var_7_0, var_7_2, var_2_10004.MALL_MAP)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_12, var_2_13, var_2_14, var_1_10006)

	onButton = var_1

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0.uiBookBtn

	local function var_2_17()
		local var_8_0 = arg_2_0
		local var_8_1 = var_0.emit

		MallMediator = var_2_10003

		local var_8_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_8_3 = var_2_10004.New
		local var_8_4 = {}

		MallStoryLineMediator = var_2_10007
		var_8_4.mediator = var_2_10007
		MallStoryLineLayer = var_2_10007
		var_8_4.viewComponent = var_2_10007

		var_8_1(var_8_0, var_8_2, var_8_3(var_8_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_15, var_2_16, var_2_17, var_1_10006)

	onButton = var_1

	local var_2_18 = arg_2_0
	local var_2_19 = arg_2_0.uiOrderBtn

	local function var_2_20()
		local var_9_0 = arg_2_0
		local var_9_1 = var_0.emit

		MallMediator = var_2_10003

		local var_9_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_9_3 = var_2_10004.New
		local var_9_4 = {}

		MallOrderMediator = var_2_10007
		var_9_4.mediator = var_2_10007
		MallOrderLayer = var_2_10007
		var_9_4.viewComponent = var_2_10007
		var_9_4.data = {
			onExit = function()
				local var_10_0 = arg_2_0

				var_0.UpdateData(var_10_0)

				local var_10_1 = arg_2_0

				var_0.UpdateView(var_10_1)

				return
			end
		}

		var_9_1(var_9_0, var_9_2, var_9_3(var_9_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_18, var_2_19, var_2_20, var_1_10006)

	onButton = var_1

	local var_2_21 = arg_2_0
	local var_2_22 = arg_2_0.uiSummaryBtn

	local function var_2_23()
		local var_11_0 = arg_2_0

		var_0.ShowSummaryBox(var_11_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_21, var_2_22, var_2_23, var_1_10006)

	onButton = var_1

	local var_2_24 = arg_2_0
	local var_2_25 = arg_2_0.uiAwardBtn

	local function var_2_26()
		local var_12_0 = arg_2_0
		local var_12_1 = var_0.emit

		MallMediator = var_2_10003

		local var_12_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_12_3 = var_2_10004.New
		local var_12_4 = {}

		MallAwardMediator = var_2_10007
		var_12_4.mediator = var_2_10007
		MallAwardLayer = var_2_10007
		var_12_4.viewComponent = var_2_10007
		var_12_4.data = {
			onExit = function()
				local var_13_0 = arg_2_0

				var_0.UpdateData(var_13_0)

				local var_13_1 = arg_2_0

				var_0.UpdateView(var_13_1)

				return
			end
		}

		var_12_1(var_12_0, var_12_2, var_12_3(var_12_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_24, var_2_25, var_2_26, var_1_10006)

	onButton = var_1

	local var_2_27 = arg_2_0
	local var_2_28 = arg_2_0.uiRightUpgradeBtn

	local function var_2_29()
		setActive = var_2_10000

		var_2_10000(arg_2_0.uiRightUpgradeTF, true)

		setActive = var_2_10000

		var_2_10000(arg_2_0.uiRightSummaryTF, false)

		setText = var_2_10000

		local var_14_0 = arg_2_0.uiRightTitleText

		i18n = var_3

		var_2_10000(var_14_0, var_3("mall_right_title_summary"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_27, var_2_28, var_2_29, var_1_10006)

	onButton = var_1

	local var_2_30 = arg_2_0
	local var_2_31 = arg_2_0.uiRightSummaryBtn

	local function var_2_32()
		setActive = var_2_10000

		var_2_10000(arg_2_0.uiRightSummaryTF, true)

		setActive = var_2_10000

		var_2_10000(arg_2_0.uiRightUpgradeTF, false)

		setText = var_2_10000

		local var_15_0 = arg_2_0.uiRightTitleText

		i18n = var_3

		var_2_10000(var_15_0, var_3("mall_right_title_upgrade"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_30, var_2_31, var_2_32, var_1_10006)

	UIItemList = var_1

	local var_2_33 = var_1.New
	local var_2_34 = arg_2_0.uiUpgradeConditionTF
	local var_2_35 = arg_2_0.uiUpgradeConditionTF

	arg_2_0.upgradeUIList = var_2_33(var_2_34, var_4.Find(var_2_35, "tpl"))

	local var_2_36 = arg_2_0.upgradeUIList

	var_1.make(var_2_36, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = arg_2_0

			var_3.UpdateConditionTpl(var_16_0, arg_16_1, arg_16_2)
		end

		return
	end)

	MallUpgradeBox = var_1
	arg_2_0.upgradeBox = var_1.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	MallSettleBox = var_1
	arg_2_0.settleBox = var_1.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	MallSummaryBox = var_1
	arg_2_0.summaryBox = var_1.New(arg_2_0._tf, arg_2_0.event, arg_2_0.contextData)
	setText = var_1

	local var_2_37 = arg_2_0.uiTitleText

	i18n = var_4

	var_1(var_2_37, var_4("mall_title"))

	setText = var_1

	local var_2_38 = arg_2_0.uiTitleEnText

	i18n = var_4

	var_1(var_2_38, var_4("mall_title_en"))

	setText = var_1

	local var_2_39 = arg_2_0.uiRoundHeaderText

	i18n = var_4

	var_1(var_2_39, var_4("mall_round_header"))

	setText = var_1

	local var_2_40 = arg_2_0.uiLevelHeaderText

	i18n = var_4

	var_1(var_2_40, var_4("mall_level_header"))

	setText = var_1

	local var_2_41 = arg_2_0.uiRightUpgradeTF
	local var_2_42 = var_3.Find(var_2_41, "max/Text")

	i18n = var_4

	var_1(var_2_42, var_4("mall_level_max"))

	return
end

function var_0_1.didEnter(arg_17_0)
	arg_17_0:UpdateData()
	arg_17_0:UpdateView()

	triggerButton = var_1

	var_1(arg_17_0.uiRightSummaryBtn)

	return
end

function var_0_1.UpdateData(arg_18_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)
	local var_18_1 = var_1.getActivityByType

	ActivityConst = var_1_10004
	arg_18_0.activity = var_18_1(var_18_0, var_1_10004.ACTIVITY_TYPE_MALL)
	assert = var_1

	local var_18_2

	if arg_18_0.activity then
		var_1_10005 = arg_18_0.activity
		var_18_2 = not var_3.isEnd(var_1_10005)
	end

	local var_18_3 = "not exist mall act, type: "

	ActivityConst = var_1_10005

	var_1(var_18_2, var_18_3 .. var_1_10005.ACTIVITY_TYPE_MALL)

	local var_18_4 = arg_18_0.activity

	arg_18_0.levelDate = var_1.GetLevelData(var_18_4)

	local var_18_5 = arg_18_0.levelDate

	arg_18_0.conditionList = var_1.getConfig(var_18_5, "upgrade_task")

	local var_18_6 = arg_18_0.levelDate

	arg_18_0.conditionDescList = var_1.getConfig(var_18_6, "upgrade_task_desc")
	getProxy = var_1
	ActivityProxy = var_18_6

	local var_18_7 = var_1(var_18_6)
	local var_18_8 = var_1.getActivityById
	local var_18_9 = arg_18_0.activity
	local var_18_10 = var_18_8(var_18_7, var_4.getConfig(var_18_9, "config_id"))

	ActivityPtData = var_1_10002
	arg_18_0.curPt = var_1_10002.New(var_18_10).count
	arg_18_0.ptTargets = var_2.targets
	arg_18_0.ptUnlockStamps = var_2:GetDayUnlockStamps()

	return
end

function var_0_1.UpdateView(arg_19_0)
	setText = var_1_10001

	local var_19_0 = arg_19_0.uiGoldText
	local var_19_1 = arg_19_0.activity

	var_1_10001(var_19_0, var_4.GetGold(var_19_1))

	setText = var_1_10001

	local var_19_2 = arg_19_0.uiRoundText
	local var_19_3 = arg_19_0.activity

	var_1_10001(var_19_2, var_4.GetRound(var_19_3))

	setText = var_1_10001

	var_1_10001(arg_19_0.uiLevelText, arg_19_0.levelDate.level)

	local var_19_4 = arg_19_0.levelDate
	local var_19_5 = var_1.IsMaxLevel(var_19_4)

	setActive = var_1_10002

	local var_19_6 = arg_19_0.uiRightUpgradeTF

	var_1_10002(var_4.Find(var_19_6, "conditions"), not var_19_5)

	setActive = var_1_10002

	local var_19_7 = arg_19_0.uiRightUpgradeTF

	var_1_10002(var_4.Find(var_19_7, "max"), var_19_5)

	local var_19_8 = arg_19_0.upgradeUIList

	var_2.align(var_19_8, var_19_5 and 0 or #arg_19_0.conditionList)
	arg_19_0:UpdateFloors()
	arg_19_0:UpdateOrderBtn()
	arg_19_0:UpdateTips()
	arg_19_0:UpdateStartBtn()

	return
end

function var_0_1.UpdateOrderBtn(arg_20_0)
	setActive = var_1_10001

	var_1_10001(arg_20_0.uiOrderTimeTF, false)

	local var_20_0 = arg_20_0.activity

	arg_20_0.orderData = var_1.GetOrderData(var_20_0)

	if arg_20_0.orderData.id ~= 0 then
		pg = var_1

		local var_20_1 = var_1.TimeMgr.GetInstance()
		local var_20_2 = var_1.GetServerTime(var_20_1)
		local var_20_3 = arg_20_0.orderData

		if var_20_2 < var_2.GetEndTime(var_20_3) then
			setActive = var_20_2

			var_20_2(arg_20_0.uiOrderTimeTF, true)
			arg_20_0:StartTimer()
		end
	else
		arg_20_0:StopTimer()
	end

	return
end

function var_0_1.UpdateTips(arg_21_0)
	setActive = var_1_10001

	var_1_10001(arg_21_0.uiAwardTip, var_0_1.IsAwardTip())

	setActive = var_1_10001

	var_1_10001(arg_21_0.uiOrderTip, var_0_1.IsOrderTip())

	setActive = var_1_10001

	var_1_10001(arg_21_0.uiMapTip, var_0_1.IsMapTip())

	return
end

function var_0_1.UpdateStartBtn(arg_22_0)
	local var_22_0 = false

	ipairs = var_1_10002

	local var_22_1 = arg_22_0.activity

	for iter_22_0, iter_22_1 in var_1_10002(var_4.GetFloorList(var_22_1)) do
		if iter_22_1:IsUnlock() and iter_22_1:GetStaffList()[1] ~= 0 then
			var_22_0 = false

			break
		end

		var_22_0 = true
	end

	if var_22_0 then
		setActive = var_2

		var_2(arg_22_0.uiStartBtn, false)

		setActive = var_2

		var_2(arg_22_0.uiStartGreyBtn, true)

		onButton = var_2

		local var_22_2 = arg_22_0
		local var_22_3 = arg_22_0.uiStartGreyBtn

		local function var_22_4()
			pg = var_2_10000

			local var_23_0 = var_2_10000.TipsMgr.GetInstance()
			local var_23_1 = var_0.ShowTips

			i18n = var_2_10003

			var_23_1(var_23_0, var_2_10003("mall_floor_all_empty_tip"))

			return
		end

		SFX_PANEL = var_1_10007

		var_2(var_22_2, var_22_3, var_22_4, var_1_10007)

		return
	end

	local var_22_5, var_22_6, var_22_7 = (function()
		pg = var_2_10000

		local var_24_0 = var_2_10000.TimeMgr.GetInstance()

		ipairs = var_2_10001

		for iter_24_0, iter_24_1 in var_2_10001(arg_22_0.ptTargets) do
			if arg_22_0.ptUnlockStamps[iter_24_0] and var_6 > var_24_0:GetServerTime() then
				local var_24_1 = var_24_0:STimeDescS(var_6, "%m")
				local var_24_2 = var_24_0:STimeDescS(var_6, "%d")

				return iter_24_0, var_24_1, var_24_2
			end
		end

		return nil
	end)()
	local var_22_8

	if not var_22_5 or not (var_22_5 - 1) then
		var_22_8 = #arg_22_0.ptTargets
	end

	local var_22_9 = arg_22_0.ptTargets[var_22_8]
	local var_22_10 = arg_22_0.curPt
	local var_22_11 = arg_22_0.activity
	local var_22_12 = var_22_9 <= var_22_10 + var_9.GetGold(var_22_11)

	setActive = var_9

	var_9(arg_22_0.uiStartBtn, not var_22_12 or not var_22_5)

	onButton = var_9

	local var_22_13 = arg_22_0
	local var_22_14 = arg_22_0.uiStartBtn

	local function var_22_15()
		if var_22_12 and var_22_5 then
			return
		end

		local var_25_0 = arg_22_0
		local var_25_1 = var_0.emit

		MallMediator = var_2_10003

		var_25_1(var_25_0, var_2_10003.SETTLE_ROUND, arg_22_0.activity.id)

		return
	end

	SFX_PANEL = var_1_10014

	var_9(var_22_13, var_22_14, var_22_15, var_1_10014)

	setActive = var_9

	var_9(arg_22_0.uiStartGreyBtn, var_22_12 and var_22_5)

	onButton = var_9

	local var_22_16 = arg_22_0
	local var_22_17 = arg_22_0.uiStartGreyBtn

	local function var_22_18()
		if not var_22_12 then
			return
		end

		local var_26_1

		if var_22_5 then
			pg = var_26_1

			local var_26_0 = var_26_1.TipsMgr.GetInstance()

			var_26_1 = var_26_1.ShowTips
			i18n = var_2_10003

			var_26_1(var_26_0, var_2_10003("mall_unlock_date_tip", var_22_6, var_22_7))
		else
			pg = var_26_1

			local var_26_2 = var_26_1.TipsMgr.GetInstance()
			local var_26_3 = var_0.ShowTips

			i18n = var_2_10003

			var_26_3(var_26_2, var_2_10003("mall_finished_all_tip"))
		end

		return
	end

	SFX_PANEL = var_1_10014

	var_9(var_22_16, var_22_17, var_22_18, var_1_10014)

	return
end

function var_0_1.UpdateConditionTpl(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.conditionList[arg_27_1 + 1][1]
	local var_27_1 = arg_27_0.conditionList[arg_27_1 + 1][2]
	local var_27_2 = 0
	local var_27_3 = 0
	local var_27_4 = arg_27_0.conditionDescList[arg_27_1 + 1]

	switch = var_8

	local var_27_5 = var_27_0
	local var_27_6 = {}

	MallLevel = var_1_10012
	var_27_6[var_1_10012.CONDITION_TYPE.ROUND] = function()
		local var_28_0 = arg_27_0.activity

		var_27_2 = var_0.GetRound(var_28_0)
		var_27_3 = var_27_1[1]

		return
	end
	MallLevel = var_12
	var_27_6[var_12.CONDITION_TYPE.ORDER] = function()
		local var_29_0 = arg_27_0.activity
		local var_29_1 = var_0.GetOrderData(var_29_0)

		var_27_2 = #var_0.GetFinishedList(var_29_1)
		var_27_3 = var_27_1[1]

		return
	end
	MallLevel = var_12
	var_27_6[var_12.CONDITION_TYPE.ROUND_INCOME] = function()
		local var_30_0 = arg_27_0.activity

		var_27_2 = var_0.GetLastIncome(var_30_0)
		var_27_3 = var_27_1[1]

		return
	end
	MallLevel = var_12
	var_27_6[var_12.CONDITION_TYPE.FLOOR_INCOME] = function()
		local var_31_0 = arg_27_0.activity
		local var_31_1 = var_0.GetFloorData(var_31_0)[var_27_1[1]]

		var_27_2 = var_0.GetLastIncome(var_31_1)
		var_27_3 = var_27_1[2]

		return
	end

	var_8(var_27_5, var_27_6)

	local var_27_7 = var_27_3 <= var_27_2

	setActive = var_1_10009

	var_1_10009(arg_27_2:Find("unfinished"), not var_27_7)

	setActive = var_1_10009

	var_1_10009(arg_27_2:Find("finished"), var_27_7)

	if not var_27_7 or not var_27_2 then
		::label_27_0::

		setColorStr = var_1_10009
		var_1_10009 = var_1_10009(var_27_2, "#bd5d4a")
	end

	string = var_27_5

	local var_27_8 = var_27_5.gsub(var_27_4, "$1", var_1_10009)

	string = var_10

	local var_27_9 = var_10.gsub(var_27_8, "$2", var_27_3)

	setText = var_10

	var_10(arg_27_2:Find("Text"), var_27_9)

	return
end

function var_0_1.UpdateFloors(arg_32_0)
	eachChild = var_1_10001

	var_1_10001(arg_32_0.uiFloorsTF, function(arg_33_0)
		tonumber = var_2_10001

		local var_33_0 = var_2_10001(arg_33_0.name)
		local var_33_1 = arg_32_0

		var_2.UpdateFloorTpl(var_33_1, var_33_0, arg_33_0)

		return
	end)

	return
end

function var_0_1.UpdateFloorTpl(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.activity
	local var_34_1 = var_3.GetFloor(var_34_0, arg_34_1)
	local var_34_2 = var_3.IsUnlock(var_34_1)

	setActive = var_34_0

	var_34_0(arg_34_2:Find("lock"), not var_34_2)

	if arg_34_2:Find("sign") then
		setActive = var_5

		var_5(arg_34_2:Find("sign"), var_34_2)
	end

	local var_34_3 = var_3
	local var_34_4 = var_3.GetStaffList(var_34_3)

	underscore = var_34_1

	local var_34_5 = var_34_1.reduce(var_34_4, 0, function(arg_35_0, arg_35_1)
		return arg_35_0 + (arg_35_1 ~= 0 and 1 or 0)
	end)

	setActive = var_34_3

	var_34_3(arg_34_2:Find("bg"), var_34_5 ~= 0)

	setActive = var_34_3

	var_34_3(arg_34_2:Find("empty"), var_34_5 == 0)

	setText = var_34_3

	var_34_3(arg_34_2:Find("rank/Text"), var_34_5 .. "/" .. #var_34_4)

	local var_34_6 = {}

	ipairs = var_8

	for iter_34_0, iter_34_1 in var_8(var_3:GetTargetInfos(arg_34_0.levelDate.level)) do
		table = var_13

		var_13.insert(var_34_6, {
			cur = 0,
			id = iter_34_0,
			base = iter_34_1[1],
			max = iter_34_1[2]
		})
	end

	ipairs = var_8

	for iter_34_2, iter_34_3 in var_8(var_34_4) do
		if iter_34_3 ~= 0 then
			local var_34_7 = arg_34_0.activity
			local var_34_8 = var_13.GetStaff(var_34_7, iter_34_3)

			ipairs = var_1_10014

			for iter_34_4, iter_34_5 in var_1_10014(var_34_8:GetAttrList()) do
				var_34_6[iter_34_4].cur = var_34_6[iter_34_4].cur + iter_34_5
			end
		end
	end

	underscore = var_8

	local var_34_9 = var_8.select(var_34_6, function(arg_36_0)
		return arg_36_0.base ~= 0 and arg_36_0.max ~= 0
	end)

	underscore = var_9

	local var_34_10 = var_9.reduce(var_34_9, 0, function(arg_37_0, arg_37_1)
		return arg_37_0 + arg_37_1.cur
	end)

	underscore = var_10

	local var_34_11 = var_10.reduce(var_34_9, 0, function(arg_38_0, arg_38_1)
		return arg_38_0 + arg_38_1.base
	end)

	MallUtil = var_11

	local var_34_12 = var_11.GetFloorRank(var_34_10, var_34_11)

	GetImageSpriteFromAtlasAsync = var_12

	var_12("ui/mallui_atlas", "rank_" .. var_34_12, arg_34_2:Find("rank"), true)

	onButton = var_12

	local var_34_13 = arg_34_0
	local var_34_14 = arg_34_2

	local function var_34_15()
		if not var_34_2 then
			return
		end

		local var_39_0 = arg_34_0
		local var_39_1 = var_0.emit

		MallMediator = var_2_10003

		local var_39_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_39_3 = var_2_10004.New
		local var_39_4 = {}

		MallStaffMediator = var_2_10007
		var_39_4.mediator = var_2_10007
		MallStaffLayer = var_2_10007
		var_39_4.viewComponent = var_2_10007
		var_39_4.data = {
			floorId = var_0.id
		}

		var_39_1(var_39_0, var_39_2, var_39_3(var_39_4))

		return
	end

	SFX_PANEL = var_17

	var_12(var_34_13, var_34_14, var_34_15, var_17)

	return
end

function var_0_1.StartTimer(arg_40_0)
	arg_40_0:StopTimer()

	local var_40_0 = arg_40_0.orderData

	arg_40_0.orderEndTime = var_1.GetEndTime(var_40_0)
	Timer = var_1
	arg_40_0.timer = var_1.New(function()
		local var_41_0 = arg_40_0.orderEndTime

		pg = var_2_10001

		local var_41_1 = var_2_10001.TimeMgr.GetInstance()
		local var_41_2 = var_41_0 - var_1.GetServerTime(var_41_1)

		setText = var_1

		local var_41_3 = arg_40_0.uiOrderTimeTF
		local var_41_4 = var_3.Find(var_41_3, "Text")

		pg = var_2_10004

		local var_41_5 = var_2_10004.TimeMgr.GetInstance()

		var_1(var_41_4, var_4.DescCDTime(var_41_5, var_41_2))

		if var_41_2 <= 0 then
			local var_41_6 = arg_40_0

			var_1.UpdateOrderBtn(var_41_6)

			setActive = var_1

			var_1(arg_40_0.uiOrderTip, true)
		end

		return
	end, 1, -1)

	local var_40_1 = arg_40_0.timer

	var_1.Start(var_40_1)
	arg_40_0.timer.func()

	return
end

function var_0_1.StopTimer(arg_42_0)
	if arg_42_0.timer then
		local var_42_0 = arg_42_0.timer

		var_1.Stop(var_42_0)

		arg_42_0.timer = nil
	end

	return
end

function var_0_1.ShowUpgradeBox(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = arg_43_0.upgradeBox

	var_4.ExecuteAction(var_43_0, "Show", arg_43_1, arg_43_2, arg_43_3)

	return
end

function var_0_1.ShowSettleBox(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0.settleBox

	var_3.ExecuteAction(var_44_0, "Show", arg_44_1, arg_44_2)

	return
end

function var_0_1.ShowSummaryBox(arg_45_0)
	local var_45_0 = arg_45_0.summaryBox

	var_1.ExecuteAction(var_45_0, "Show")

	return
end

function var_0_1.onBackPressed(arg_46_0)
	if arg_46_0.upgradeBox then
		local var_46_0 = arg_46_0.upgradeBox

		if var_1.isShowing(var_46_0) then
			local var_46_1 = arg_46_0.upgradeBox

			var_1.ExecuteAction(var_46_1, "Hide")

			return
		end
	end

	if arg_46_0.summaryBox then
		local var_46_2 = arg_46_0.summaryBox

		if var_1.isShowing(var_46_2) then
			local var_46_3 = arg_46_0.summaryBox

			var_1.ExecuteAction(var_46_3, "Hide")

			return
		end
	end

	if arg_46_0.settleBox then
		local var_46_4 = arg_46_0.settleBox

		if var_1.isShowing(var_46_4) then
			local var_46_5 = arg_46_0.settleBox

			var_1.ExecuteAction(var_46_5, "Hide")

			return
		end
	end

	quickPlayAnimation = var_1

	var_1(arg_46_0._tf, "anim_MallUI_out")

	return
end

function var_0_1.willExit(arg_47_0)
	local var_47_0 = arg_47_0.animDft

	var_1.SetEndEvent(var_47_0, nil)

	if arg_47_0.upgradeBox then
		local var_47_1 = arg_47_0.upgradeBox

		var_1.Destroy(var_47_1)

		arg_47_0.upgradeBox = nil
	end

	if arg_47_0.settleBox then
		local var_47_2 = arg_47_0.settleBox

		var_1.Destroy(var_47_2)

		arg_47_0.settleBox = nil
	end

	if arg_47_0.summaryBox then
		local var_47_3 = arg_47_0.summaryBox

		var_1.Destroy(var_47_3)

		arg_47_0.summaryBox = nil
	end

	arg_47_0:StopTimer()

	return
end

function var_0_1.IsAwardTip()
	MallAwardLayer = var_1_10000

	local var_48_0

	if not var_1_10000.IsAwardTip() then
		MallAwardLayer = var_48_0

		if not var_48_0.IsInputTip() then
			MallAwardLayer = var_48_0
			var_48_0 = var_48_0.IsTaskTip()
		end
	end

	return var_48_0
end

function var_0_1.IsOrderTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_49_0 = var_1_10000(var_1_10002)
	local var_49_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_49_2 = var_49_1(var_49_0, var_1_10003.ACTIVITY_TYPE_MALL)
	local var_49_3 = var_0.GetOrderData(var_49_2)

	if var_1.IsFinishedAll(var_49_3) then
		return false
	end

	local var_49_4 = var_1
	local var_49_5 = var_1.GetFinishedList(var_49_4)

	underscore = var_49_2

	local var_49_6 = var_49_2.detect

	pg = var_1_10005

	local var_49_7 = var_49_6(var_1_10005.activity_mall_custom_order.all, function(arg_50_0)
		table = var_2_10001

		return not var_2_10001.contains(var_49_5, arg_50_0)
	end)

	pg = var_49_4

	local var_49_8 = var_49_4.activity_mall_custom_order[var_49_7]

	if not (var_0:GetLevelData().level >= var_49_8.unlock_lv and var_0:getDayIndex() >= var_49_8.unlock_time) then
		var_49_7 = 0
	end

	if var_49_7 ~= 0 then
		local var_49_10

		if var_1.startTime ~= 0 then
			pg = var_7

			local var_49_9 = var_7.TimeMgr.GetInstance()

			if not (var_7.GetServerTime(var_49_9) >= var_1:GetEndTime()) then
				var_49_10 = false

				goto label_49_0
			end
		end

		var_49_10 = true

		::label_49_0::

		return var_49_10
	end
end

function var_0_1.IsMapTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_51_0 = var_1_10000(var_1_10002)
	local var_51_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_51_2 = var_51_1(var_51_0, var_1_10003.ACTIVITY_TYPE_MALL)
	local var_51_3 = var_0.GetTriggeredPointIds(var_51_2)
	local var_51_4 = var_0:GetLevelData()
	local var_51_5 = var_2.GetUnlockStoryIds(var_51_4)

	underscore = var_51_2

	return #var_51_2.select(var_51_5, function(arg_52_0)
		pg = var_2_10001

		local var_52_0 = var_2_10001.activity_mall_story[arg_52_0].type

		MallActivity = var_2_10003

		local var_52_1 = var_52_0 ~= var_2_10003.POINT_TYPE.SITE

		table = var_3

		if var_3.contains(var_51_3, arg_52_0) then
			local var_52_3

			if var_52_1 then
				::label_52_0::

				if var_1.lua ~= "" then
					pg = var_52_3

					local var_52_2 = var_52_3.NewStoryMgr.GetInstance()

					var_52_3 = not var_52_3.IsPlayed(var_52_2, var_1.lua)
				else
					var_52_3 = false
				end

				if false then
					var_52_3 = true
				end
			end

			return var_52_3
		end
	end) > 0
end

return var_0_1
