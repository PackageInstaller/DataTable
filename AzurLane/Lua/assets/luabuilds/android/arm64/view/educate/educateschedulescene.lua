class = var_0_10000

local var_0_0 = "EducateScheduleScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateScheduleUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	arg_3_0.playerID = var_1.getRawData(var_3_0).id
	getProxy = var_1
	EducateProxy = var_3_0
	arg_3_0.educateProxy = var_1(var_3_0)

	local var_3_1 = arg_3_0.educateProxy

	arg_3_0.char = var_1.GetCharData(var_3_1)

	local var_3_2 = arg_3_0.educateProxy

	arg_3_0.curTime = var_1.GetCurTime(var_3_2)

	local var_3_3 = arg_3_0.educateProxy

	arg_3_0.planProxy = var_1.GetPlanProxy(var_3_3)

	local var_3_4 = arg_3_0.educateProxy

	arg_3_0.buffList = var_1.GetBuffList(var_3_4)

	local var_3_5 = arg_3_0.char
	local var_3_6 = var_1.GetAttrIdsByType

	EducateChar = var_1_10004
	arg_3_0.natureIds = var_3_6(var_3_5, var_1_10004.ATTR_TYPE_PERSONALITY)

	local var_3_7 = arg_3_0.char
	local var_3_8 = var_1.GetAttrIdsByType

	EducateChar = var_4
	arg_3_0.majorIds = var_3_8(var_3_7, var_4.ATTR_TYPE_MAJOR)

	local var_3_9 = arg_3_0.char
	local var_3_10 = var_1.GetAttrIdsByType

	EducateChar = var_4
	arg_3_0.minorIds = var_3_10(var_3_9, var_4.ATTR_TYPE_MINOR)

	arg_3_0:getLocalGridData()

	local var_3_11 = arg_3_0.contextData
	local var_3_12

	if not arg_3_0.contextData.indexDatas then
		var_3_12 = {}
	end

	var_3_11.indexDatas = var_3_12

	return
end

function var_0_1.clearLocalPlans(arg_4_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.GetPlanProxy(var_4_0)

	var_1.ClearLocalPlansData(var_4_1)
	arg_4_0:getLocalGridData()
	arg_4_0:updateResultPanel()
	arg_4_0:closeSelectPanel()

	return
end

function var_0_1.getLocalGridData(arg_5_0)
	local var_5_0 = arg_5_0.char
	local var_5_1 = var_1.GetNextWeekPlanCnt(var_5_0)

	arg_5_0.gridData = {}

	for iter_5_0 = 1, 6 do
		arg_5_0.gridData[iter_5_0] = {}

		for iter_5_1 = 1, 3 do
			if iter_5_1 <= var_5_1 then
				EducateGrid = var_1_10010

				if not var_1_10010.TYPE_EMPTY then
					EducateGrid = var_1_10010
					var_1_10010 = var_1_10010.TYPE_LOCK
				end

				var_1_10011 = arg_5_0.gridData[iter_5_0]
				EducateGrid = var_1_10012
				var_1_10011[iter_5_1] = var_1_10012.New({
					type = var_1_10010
				})
			end
		end
	end

	for iter_5_2 = 1, 6 do
		arg_5_0.selectDay = iter_5_2

		for iter_5_3 = 1, var_5_1 do
			arg_5_0.selectIndex = iter_5_3
			PlayerPrefs = var_1_10010
			var_1_10010 = var_1_10010.GetString
			EducateConst = var_1_10012

			if var_1_10010(var_1_10012.PLANS_DATA_KEY .. arg_5_0.playerID .. "_" .. iter_5_2 .. "_" .. iter_5_3) ~= "" then
				string = var_1_10011
				var_1_10011 = var_1_10011.split(var_1_10010, "_")
				tonumber = var_1_10012
				var_1_10012 = var_1_10012(var_1_10011[1])
				tonumber = var_13

				local var_5_2 = var_13(var_1_10011[2])

				if arg_5_0:checkLocalPlan(var_1_10012, var_5_2) then
					local var_5_3 = arg_5_0.gridData[iter_5_2]

					EducateGrid = var_15
					var_5_3[iter_5_3] = var_15.New({
						id = var_1_10012,
						type = var_5_2
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

function var_0_1.checkLocalPlan(arg_6_0, arg_6_1, arg_6_2)
	EducateGrid = var_1_10003

	if arg_6_2 ~= var_1_10003.TYPE_PLAN then
		EducateGrid = var_3

		if arg_6_2 == var_3.TYPE_PLAN_OCCUPY then
			EducatePlan = var_3

			local var_6_0 = var_3.New(arg_6_1)
			local var_6_1 = var_3.getConfig(var_6_0, "pre_next")
			local var_6_2

			if arg_6_0:CheckCondition(var_3) then
				var_6_2 = not var_3:ExistNextPlanCanFill(arg_6_0.char)
			end

			return var_6_2
		end

		return false
	end
end

function var_0_1.recoverSpecEventForPlans(arg_7_0)
	local var_7_0 = arg_7_0.educateProxy
	local var_7_1 = var_1.GetEventProxy(var_7_0)
	local var_7_2 = var_1.GetPlanSpecEvents(var_7_1)

	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(var_7_2) do
		local var_7_3 = iter_7_1:GetGridIndexs()

		ipairs = var_1_10008

		for iter_7_2, iter_7_3 in var_1_10008(var_7_3) do
			if iter_7_2 == 1 then
				EducateGrid = var_1_10013

				if not var_1_10013.TYPE_EVENT then
					EducateGrid = var_1_10013
					var_1_10013 = var_1_10013.TYPE_EVENT_OCCUPY
				end

				EducateGrid = var_1_10014
				var_1_10014 = var_1_10014.New({
					type = var_1_10013,
					id = iter_7_1.id
				})

				arg_7_0:setGridDataForPlan(iter_7_3[1], iter_7_3[2], var_1_10014)
			end
		end
	end

	return
end

function var_0_1.saveGridLocalData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_3.id .. "_" .. arg_8_3.type

	PlayerPrefs = var_5

	local var_8_1 = var_5.SetString

	EducateConst = var_1_10007

	var_8_1(var_1_10007.PLANS_DATA_KEY .. arg_8_0.playerID .. "_" .. arg_8_1 .. "_" .. arg_8_2, var_8_0)

	return
end

function var_0_1.setGridDataForPlan(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0.gridData[arg_9_1][arg_9_2]

	if not var_4.IsEmpty(var_9_0) then
		arg_9_0:clearGridData(arg_9_1, arg_9_2)
	end

	if arg_9_3:GetOccupyGridCnt() > 1 then
		for iter_9_0 = 1, var_5 - 1 do
			local var_9_1 = arg_9_0.gridData[arg_9_1]
			local var_9_2 = arg_9_2 + iter_9_0

			EducateGrid = var_1_10012
			var_1_10012 = var_1_10012.New

			local var_9_3 = {}

			EducateGrid = var_1_10015
			var_9_3.type = var_1_10015.TYPE_PLAN_OCCUPY
			var_9_3.id = arg_9_3.id
			var_9_1[var_9_2] = var_1_10012(var_9_3)
			var_1_10012 = arg_9_0

			arg_9_0.saveGridLocalData(var_1_10012, arg_9_1, arg_9_2 + iter_9_0, arg_9_0.gridData[arg_9_1][arg_9_2 + iter_9_0])
		end
	end

	arg_9_0.gridData[arg_9_1][arg_9_2] = arg_9_3

	arg_9_0:saveGridLocalData(arg_9_1, arg_9_2, arg_9_3)

	return
end

function var_0_1.clearGridData(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.gridData[arg_10_1][arg_10_2]
	local var_10_1 = var_3.GetOccupyGridCnt(var_10_0)

	if 1 < var_10_1 then
		pairs = var_5

		for iter_10_0, iter_10_1 in var_5(arg_10_0.gridData[arg_10_1]) do
			if (iter_10_1:IsPlanOccupy() or iter_10_1:IsPlan()) and iter_10_1.id == var_3.id then
				local var_10_2 = arg_10_0.gridData[arg_10_1]

				EducateGrid = var_11

				local var_10_3 = var_11.New
				local var_10_4 = {}

				EducateGrid = var_1_10014
				var_10_4.type = var_1_10014.TYPE_EMPTY
				var_10_2[iter_10_0] = var_10_3(var_10_4)

				arg_10_0:saveGridLocalData(arg_10_1, iter_10_0, arg_10_0.gridData[arg_10_1][iter_10_0])
			end
		end
	end

	local var_10_5 = arg_10_0.gridData[arg_10_1]

	EducateGrid = var_10_0

	local var_10_6 = var_10_0.New
	local var_10_7 = {}

	EducateGrid = iter_10_1
	var_10_7.type = iter_10_1.TYPE_EMPTY
	var_10_5[arg_10_2] = var_10_6(var_10_7)

	arg_10_0:saveGridLocalData(arg_10_1, arg_10_2, arg_10_0.gridData[arg_10_1][arg_10_2])

	return
end

function var_0_1.findUI(arg_11_0)
	local var_11_0 = arg_11_0._tf

	arg_11_0.bgTF = var_1.Find(var_11_0, "anim_root/bg")

	local var_11_1 = arg_11_0._tf

	arg_11_0.topTF = var_1.Find(var_11_1, "anim_root/top")

	local var_11_2 = arg_11_0.topTF

	arg_11_0.returnBtn = var_1.Find(var_11_2, "return_btn/return_btn")

	local var_11_3 = arg_11_0._tf

	arg_11_0.mainTF = var_1.Find(var_11_3, "anim_root/main")

	local var_11_4 = arg_11_0.mainTF

	arg_11_0.leftPanelTF = var_1.Find(var_11_4, "schedule_left")

	local var_11_5 = arg_11_0.leftPanelTF

	arg_11_0.targetTF = var_1.Find(var_11_5, "target")
	setText = var_1

	local var_11_6 = arg_11_0.targetTF
	local var_11_7 = var_3.Find(var_11_6, "title")

	i18n = var_4

	var_1(var_11_7, var_4("child_btn_target") .. ":")

	local var_11_8 = arg_11_0.leftPanelTF

	arg_11_0.scheduleTF = var_1.Find(var_11_8, "schedule")
	UIItemList = var_1

	local var_11_9 = var_1.New
	local var_11_10 = arg_11_0.scheduleTF
	local var_11_11 = arg_11_0.leftPanelTF

	arg_11_0.dayList = var_11_9(var_11_10, var_4.Find(var_11_11, "schedule/day_tpl"))

	local var_11_12 = arg_11_0.leftPanelTF

	arg_11_0.monthText = var_1.Find(var_11_12, "title/month")
	setText = var_1

	local var_11_13 = arg_11_0.leftPanelTF
	local var_11_14 = var_3.Find(var_11_13, "title/right/content/month")

	i18n = var_4

	var_1(var_11_14, var_4("word_month"))

	local var_11_15 = arg_11_0.leftPanelTF

	arg_11_0.weekText = var_1.Find(var_11_15, "title/right/content/week")

	local var_11_16 = arg_11_0.leftPanelTF

	arg_11_0.skipToggle = var_1.Find(var_11_16, "skip_toggle")

	local var_11_17 = arg_11_0.skipToggle
	local var_11_18 = var_1.GetComponent

	typeof = var_4
	Toggle = var_6
	arg_11_0.skipToggleCom = var_11_18(var_11_17, var_4(var_6))
	PlayerPrefs = var_1

	local var_11_19 = var_1.GetInt

	EducateConst = var_11_17

	local var_11_20 = var_11_19(var_11_17.SKIP_PLANS_ANIM_KEY .. "_" .. arg_11_0.playerID)

	triggerToggle = var_1_10002

	var_1_10002(arg_11_0.skipToggle, var_11_20 == 1)

	setActive = var_1_10002

	var_1_10002(arg_11_0.skipToggle, true)

	setText = var_1_10002

	local var_11_21 = arg_11_0.skipToggle
	local var_11_22 = var_4.Find(var_11_21, "Text")

	i18n = var_5

	var_1_10002(var_11_22, var_5("child_plan_skip"))

	local var_11_23 = arg_11_0.leftPanelTF

	arg_11_0.skipEventToggle = var_2.Find(var_11_23, "skip_toggle_event")

	local var_11_24 = arg_11_0.skipEventToggle
	local var_11_25 = var_2.GetComponent

	typeof = var_5
	Toggle = var_7
	arg_11_0.skipEventToggleCom = var_11_25(var_11_24, var_5(var_7))
	PlayerPrefs = var_2

	local var_11_26 = var_2.GetInt

	EducateConst = var_11_24

	local var_11_27 = var_11_26(var_11_24.SKIP_PLANS_EVENT_ANIM_KEY .. "_" .. arg_11_0.playerID)

	triggerToggle = var_3

	var_3(arg_11_0.skipEventToggle, var_11_27 == 1)

	setActive = var_3

	var_3(arg_11_0.skipEventToggle, true)

	setText = var_3

	local var_11_28 = arg_11_0.skipEventToggle
	local var_11_29 = var_5.Find(var_11_28, "Text")

	i18n = var_6

	var_3(var_11_29, var_6("child_plan_skip_event"))

	local var_11_30 = arg_11_0.leftPanelTF

	arg_11_0.selectPanelTF = var_3.Find(var_11_30, "select_panel")
	setActive = var_3

	var_3(arg_11_0.selectPanelTF, false)

	local var_11_31 = arg_11_0.selectPanelTF

	arg_11_0.selectCloseBtn = var_3.Find(var_11_31, "fold_btn")

	local var_11_32 = arg_11_0.selectPanelTF

	arg_11_0.plansView = var_3.Find(var_11_32, "scrollview")

	local var_11_33 = arg_11_0.mainTF

	arg_11_0.rightPanelTF = var_3.Find(var_11_33, "result_right")

	local var_11_34 = arg_11_0.rightPanelTF

	arg_11_0.rightEmptyTF = var_3.Find(var_11_34, "empty")
	setText = var_3

	local var_11_35 = arg_11_0.rightEmptyTF
	local var_11_36 = var_5.Find(var_11_35, "Text")

	i18n = var_6

	var_3(var_11_36, var_6("child_schedule_empty_tip"))

	local var_11_37 = arg_11_0.rightPanelTF

	arg_11_0.rightContentTF = var_3.Find(var_11_37, "content")
	UIItemList = var_3

	local var_11_38 = var_3.New
	local var_11_39 = arg_11_0.rightContentTF
	local var_11_40 = var_5.Find(var_11_39, "buff_list")
	local var_11_41 = arg_11_0.rightContentTF

	arg_11_0.buffUIList = var_11_38(var_11_40, var_6.Find(var_11_41, "buff_list/tpl"))

	local var_11_42 = arg_11_0.rightContentTF

	arg_11_0.avatarTF = var_3.Find(var_11_42, "avatar")

	local var_11_43 = arg_11_0.avatarTF

	arg_11_0.avatarImage = var_3.Find(var_11_43, "mask/Image")

	local var_11_44 = arg_11_0.rightContentTF

	arg_11_0.natureTF = var_3.Find(var_11_44, "nature/unlock")

	local var_11_45 = arg_11_0.rightContentTF

	arg_11_0.natureLockTF = var_3.Find(var_11_45, "nature/lock")
	setText = var_3

	local var_11_46 = arg_11_0.rightContentTF
	local var_11_47 = var_5.Find(var_11_46, "major_title/Text")

	i18n = var_6

	var_3(var_11_47, var_6("child_attr_name1"))

	setText = var_3

	local var_11_48 = arg_11_0.rightContentTF
	local var_11_49 = var_5.Find(var_11_48, "minor_title/Text")

	i18n = var_6

	var_3(var_11_49, var_6("child_attr_name2"))

	UIItemList = var_3

	local var_11_50 = var_3.New
	local var_11_51 = arg_11_0.rightContentTF
	local var_11_52 = var_5.Find(var_11_51, "major")
	local var_11_53 = arg_11_0.rightContentTF

	arg_11_0.majorUIList = var_11_50(var_11_52, var_6.Find(var_11_53, "major/tpl"))
	UIItemList = var_3

	local var_11_54 = var_3.New
	local var_11_55 = arg_11_0.rightContentTF
	local var_11_56 = var_5.Find(var_11_55, "minor")
	local var_11_57 = arg_11_0.rightContentTF

	arg_11_0.minorUIList = var_11_54(var_11_56, var_6.Find(var_11_57, "minor/tpl"))

	local var_11_58 = arg_11_0.rightPanelTF

	arg_11_0.nextBtn = var_3.Find(var_11_58, "next_btn")
	EducateTopPanel = var_3

	local var_11_59 = var_3.New
	local var_11_60 = arg_11_0.topTF

	arg_11_0.topPanel = var_11_59(var_5.Find(var_11_60, "top_right"), arg_11_0.event)

	local var_11_61 = arg_11_0.topPanel

	var_3.Load(var_11_61)

	EducateResPanel = var_3

	local var_11_62 = var_3.New
	local var_11_63 = arg_11_0.topTF

	arg_11_0.resPanel = var_11_62(var_5.Find(var_11_63, "res"), arg_11_0.event)

	local var_11_64 = arg_11_0.resPanel

	var_3.Load(var_11_64)

	return
end

function var_0_1.addListener(arg_12_0)
	setActive = var_1_10001

	local var_12_0 = arg_12_0.topTF

	var_1_10001(var_3.Find(var_12_0, "clear_btn"), false)

	onButton = var_1_10001

	local var_12_1 = arg_12_0
	local var_12_2 = arg_12_0.topTF
	local var_12_3 = var_4.Find(var_12_2, "clear_btn")

	local function var_12_4()
		local var_13_0 = arg_12_0

		var_0.clearLocalPlans(var_13_0)

		local var_13_1 = arg_12_0.resPanel

		var_0.ActionInvoke(var_13_1, "Flush")

		return
	end

	SFX_PANEL = var_12_2

	var_1_10001(var_12_1, var_12_3, var_12_4, var_12_2)

	onButton = var_1_10001

	local var_12_5 = arg_12_0
	local var_12_6 = arg_12_0.selectPanelTF
	local var_12_7 = var_4.Find(var_12_6, "index_btn")

	local function var_12_8()
		local var_14_0 = {}

		Clone = var_2_10001

		local var_14_1

		if not var_2_10001(arg_12_0.contextData.indexDatas) then
			var_14_1 = {}
		end

		var_14_0.indexDatas = var_14_1

		function var_14_0.callback(arg_15_0)
			arg_12_0.typeIndex = arg_15_0.typeIndex
			arg_12_0.costIndex = arg_15_0.costIndex
			arg_12_0.awardResIndex = arg_15_0.awardResIndex
			arg_12_0.awardNatureIndex = arg_15_0.awardNatureIndex
			arg_12_0.awardAttr1Index = arg_15_0.awardAttr1Index
			arg_12_0.awardAttr2Index = arg_15_0.awardAttr2Index

			local var_15_0 = arg_12_0

			var_1.updateIndexDatas(var_15_0)

			local var_15_1 = arg_12_0

			var_1.updatePlanList(var_15_1)

			return
		end

		local var_14_2 = arg_12_0
		local var_14_3 = var_1.emit

		EducateScheduleMediator = var_2_10004

		var_14_3(var_14_2, var_2_10004.OPEN_FILTER_LAYER, var_14_0)

		return
	end

	SFX_PANEL = var_12_6

	var_1_10001(var_12_5, var_12_7, var_12_8, var_12_6)

	onButton = var_1_10001

	local var_12_9 = arg_12_0
	local var_12_10 = arg_12_0.returnBtn

	local function var_12_11()
		local var_16_0 = arg_12_0

		var_0.onBackPressed(var_16_0)

		return
	end

	SFX_PANEL = var_12_6

	var_1_10001(var_12_9, var_12_10, var_12_11, var_12_6)

	onButton = var_1_10001

	local var_12_12 = arg_12_0
	local var_12_13 = arg_12_0.selectCloseBtn

	local function var_12_14()
		local var_17_0 = arg_12_0

		var_0.closeSelectPanel(var_17_0)

		return
	end

	SFX_PANEL = var_12_6

	var_1_10001(var_12_12, var_12_13, var_12_14, var_12_6)

	onButton = var_1_10001

	local var_12_15 = arg_12_0
	local var_12_16 = arg_12_0.nextBtn

	local function var_12_17()
		local var_18_0 = {}
		local var_18_1

		table = var_2_10002

		var_2_10002.insert(var_18_0, function(arg_19_0)
			local var_19_0 = arg_12_0

			if var_1.haveEmpty(var_19_0) then
				local var_19_1 = arg_12_0
				local var_19_2 = var_1.emit
				local var_19_3 = var_0_1.EDUCATE_ON_MSG_TIP
				local var_19_4 = {}

				i18n = var_3_10006
				var_19_4.content = var_3_10006("child_schedule_sure_tip")

				function var_19_4.onYes()
					var_18_1 = true

					return
				end

				function var_19_4.onExit()
					if var_18_1 then
						arg_19_0()
					end

					return
				end

				var_19_2(var_19_1, var_19_3, var_19_4)
			else
				arg_19_0()
			end

			return
		end)

		table = var_2

		var_2.insert(var_18_0, function(arg_22_0)
			getProxy = var_3_10001
			EducateProxy = var_3_10003

			local var_22_0 = var_3_10001(var_3_10003)

			if var_1.GetCharData(var_22_0).site > 0 then
				local var_22_1 = arg_12_0
				local var_22_2 = var_1.emit
				local var_22_3 = var_0_1.EDUCATE_ON_MSG_TIP
				local var_22_4 = {}

				i18n = var_3_10006
				var_22_4.content = var_3_10006("child_schedule_sure_tip2")

				function var_22_4.onYes()
					arg_22_0()

					return
				end

				var_22_2(var_22_1, var_22_3, var_22_4)
			else
				arg_22_0()
			end

			return
		end)

		seriesAsync = var_2

		var_2(var_18_0, function()
			local var_24_0 = arg_12_0

			var_0.executePlans(var_24_0, arg_12_0.skipToggleCom.isOn, arg_12_0.skipEventToggleCom.isOn)

			return
		end)

		return
	end

	SFX_PANEL = var_12_6

	var_1_10001(var_12_15, var_12_16, var_12_17, var_12_6)

	onToggle = var_1_10001

	local var_12_18 = arg_12_0
	local var_12_19 = arg_12_0.skipToggle

	local function var_12_20(arg_25_0)
		PlayerPrefs = var_2_10001

		local var_25_0 = var_2_10001.SetInt

		EducateConst = var_2_10003

		var_25_0(var_2_10003.SKIP_PLANS_ANIM_KEY .. "_" .. arg_12_0.playerID, arg_25_0 and 1 or 0)

		return
	end

	SFX_PANEL = var_12_6

	var_1_10001(var_12_18, var_12_19, var_12_20, var_12_6)

	onToggle = var_1_10001

	local var_12_21 = arg_12_0
	local var_12_22 = arg_12_0.skipEventToggle

	local function var_12_23(arg_26_0)
		PlayerPrefs = var_2_10001

		local var_26_0 = var_2_10001.SetInt

		EducateConst = var_2_10003

		var_26_0(var_2_10003.SKIP_PLANS_EVENT_ANIM_KEY .. "_" .. arg_12_0.playerID, arg_26_0 and 1 or 0)

		return
	end

	SFX_PANEL = var_12_6

	var_1_10001(var_12_21, var_12_22, var_12_23, var_12_6)

	return
end

function var_0_1.haveEmpty(arg_27_0)
	for iter_27_0 = 1, 6 do
		for iter_27_1 = 1, 3 do
			local var_27_0 = arg_27_0.gridData[iter_27_0][iter_27_1]

			if var_9.IsEmpty(var_27_0) then
				return true
			end
		end
	end

	return false
end

function var_0_1.allEmpty(arg_28_0)
	for iter_28_0 = 1, 6 do
		for iter_28_1 = 1, 3 do
			local var_28_0 = arg_28_0.gridData[iter_28_0][iter_28_1]

			if not var_9.IsEmpty(var_28_0) and not var_9:IsLock() then
				return false
			end
		end
	end

	return true
end

function var_0_1.executePlans(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0
	local var_29_1 = arg_29_0.emit

	EducateScheduleMediator = var_1_10006

	var_29_1(var_29_0, var_1_10006.GET_PLANS, {
		gridData = arg_29_0.gridData,
		isSkip = arg_29_1,
		isSkipEvent = arg_29_2
	})

	return
end

function var_0_1.didEnter(arg_30_0)
	arg_30_0:updateBg()
	arg_30_0:initTimeTitle()
	arg_30_0:initTargetText()
	arg_30_0:updateIndexDatas()
	arg_30_0:initSchedulePanel()
	arg_30_0:initSelectPlans()
	arg_30_0:initResultPanel()
	arg_30_0:checkTips()

	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.OverlayPanel
	local var_30_2 = arg_30_0.mainTF
	local var_30_3 = {}
	local var_30_4 = {}
	local var_30_5 = arg_30_0.mainTF

	var_30_4[1] = var_7.Find(var_30_5, "bg")
	var_30_3.pbList = var_30_4

	var_30_1(var_30_0, var_30_2, var_30_3)
	arg_30_0:OverlayPanel(arg_30_0.topTF, {
		groupDelta = 1
	})

	return
end

function var_0_1.checkTips(arg_31_0)
	EducateTipHelper = var_1_10001
	arg_31_0.newUnlcokPlanIds = var_1_10001.GetPlanUnlockTipIds()

	if #arg_31_0.newUnlcokPlanIds > 0 then
		local var_31_0 = arg_31_0
		local var_31_1 = arg_31_0.emit
		local var_31_2 = var_0_1.EDUCATE_ON_UNLOCK_TIP
		local var_31_3 = {}

		EducateUnlockTipLayer = var_1_10006
		var_31_3.type = var_1_10006.UNLOCK_TYPE_PLAN
		var_31_3.list = arg_31_0.newUnlcokPlanIds

		var_31_1(var_31_0, var_31_2, var_31_3)
	end

	return
end

function var_0_1.updateBg(arg_32_0)
	LoadSprite = var_1_10001

	local var_32_0 = "bg/"
	local var_32_1 = arg_32_0.char
	local var_32_2 = var_1_10001(var_32_0 .. var_4.GetBGName(var_32_1))

	setImageSprite = var_1_10002

	var_1_10002(arg_32_0.bgTF, var_32_2, false)

	return
end

function var_0_1.initTimeTitle(arg_33_0)
	EducateHelper = var_1_10001

	local var_33_0 = var_1_10001.GetTimeAfterWeeks(arg_33_0.curTime, 1)

	EducateHelper = var_1_10002

	local var_33_1 = var_1_10002.GetShowMonthNumber(var_33_0.month)

	setText = var_3

	var_3(arg_33_0.monthText, var_33_1)

	i18n = var_3

	local var_33_2 = var_3("number_" .. var_33_0.week)

	setText = var_4

	local var_33_3 = arg_33_0.weekText

	i18n = var_1_10007

	var_4(var_33_3, var_1_10007("word_which_week", var_33_2))

	return
end

function var_0_1.initTargetText(arg_34_0)
	arg_34_0.showAttrSubtype = 0

	local var_34_0 = arg_34_0.educateProxy
	local var_34_1 = var_1.GetTaskProxy(var_34_0)

	if not var_1.CanGetTargetAward(var_34_1) then
		setText = var_2

		local var_34_2 = arg_34_0.targetTF
		local var_34_3 = var_4.Find(var_34_2, "Text")

		i18n = var_1_10005

		var_2(var_34_3, var_1_10005("child_task_finish_all"))

		setActive = var_2

		local var_34_4 = arg_34_0.targetTF

		var_2(var_4.Find(var_34_4, "icon"), false)
	else
		local var_34_5 = var_1

		if not var_1.FilterByGroup(var_34_5, var_1:GetTargetTasksForShow())[1] then
			setActive = var_34_0

			var_34_0(arg_34_0.targetTF, false)
		end

		setText = var_34_0

		local var_34_6 = arg_34_0.targetTF

		var_34_0(var_5.Find(var_34_6, "Text"), var_2:getConfig("name"))

		local var_34_7 = var_2:GetType()

		EducateTask = var_34_5

		if var_34_7 == var_34_5.TYPE_ATTR then
			setActive = var_34_7

			local var_34_8 = arg_34_0.targetTF

			var_34_7(var_5.Find(var_34_8, "icon"), true)

			arg_34_0.showAttrSubtype = var_2:getConfig("sub_type")
			type = var_34_7

			if var_34_7(arg_34_0.showAttrSubtype) ~= "string" or not arg_34_0.showAttrSubtype then
				var_34_7 = arg_34_0.showAttrSubtype[1]
			end

			GetImageSpriteFromAtlasAsync = var_4

			local var_34_9 = "ui/educatecommonui_atlas"
			local var_34_10 = "attr_" .. var_34_7
			local var_34_11 = arg_34_0.targetTF

			var_4(var_34_9, var_34_10, var_8.Find(var_34_11, "icon"))
		else
			setActive = var_34_7

			local var_34_12 = arg_34_0.targetTF

			var_34_7(var_5.Find(var_34_12, "icon"), false)
		end
	end

	return
end

function var_0_1.updateIndexDatas(arg_35_0)
	local var_35_0 = arg_35_0.contextData
	local var_35_1

	if not arg_35_0.contextData.indexDatas then
		var_35_1 = {}
	end

	var_35_0.indexDatas = var_35_1
	arg_35_0.contextData.indexDatas.typeIndex = arg_35_0.typeIndex
	arg_35_0.contextData.indexDatas.costIndex = arg_35_0.costIndex
	arg_35_0.contextData.indexDatas.awardResIndex = arg_35_0.awardResIndex
	arg_35_0.contextData.indexDatas.awardNatureIndex = arg_35_0.awardNatureIndex
	arg_35_0.contextData.indexDatas.awardAttr1Index = arg_35_0.awardAttr1Index
	arg_35_0.contextData.indexDatas.awardAttr2Index = arg_35_0.awardAttr2Index

	return
end

function var_0_1.initSchedulePanel(arg_36_0)
	local var_36_0 = arg_36_0.dayList

	var_1.make(var_36_0, function(arg_37_0, arg_37_1, arg_37_2)
		UIItemList = var_2_10003

		local var_37_0

		if arg_37_0 == var_2_10003.EventInit then
			var_37_0 = arg_37_1 + 1
			tostring = var_2_10004
			arg_37_2.name = var_2_10004(var_37_0)
			GetImageSpriteFromAtlasAsync = var_4

			var_4("ui/educatescheduleui_atlas", var_37_0, arg_37_2:Find("title"), true)

			for iter_37_0 = 1, 3 do
				local var_37_1 = arg_37_2:Find("cells")
				local var_37_2 = var_8.GetChild(var_37_1, iter_37_0 - 1)
				local var_37_3 = arg_36_0.planProxy
				local var_37_4 = var_9.GetGridBgName(var_37_3, var_37_0, iter_37_0)

				GetImageSpriteFromAtlasAsync = var_37_1

				var_37_1("ui/educatescheduleui_atlas", var_37_4[1], var_37_2:Find("empty"), true)

				GetImageSpriteFromAtlasAsync = var_37_1

				var_37_1("ui/educatescheduleui_atlas", var_37_4[2], var_37_2:Find("plan/name_bg"), true)

				onButton = var_37_1

				local var_37_5 = arg_36_0
				local var_37_6 = var_37_2

				local function var_37_7()
					local var_38_0 = arg_36_0.gridData[var_37_0][iter_37_0]

					if var_0.IsEvent(var_38_0) or var_0:IsEventOccupy() then
						pg = var_1

						local var_38_1 = var_1.TipsMgr.GetInstance()
						local var_38_2 = var_1.ShowTips

						i18n = var_3_10004

						var_38_2(var_38_1, var_3_10004("child_schedule_event_tip"))
					else
						local var_38_3 = arg_36_0

						var_1.openSelectPanel(var_38_3, var_37_0, iter_37_0)
					end

					return
				end

				SFX_PANEL = var_15

				var_37_1(var_37_5, var_37_6, var_37_7, var_15)
			end
		end

		UIItemList = var_37_0

		if arg_37_0 == var_37_0.EventUpdate then
			local var_37_8 = arg_36_0

			var_3.updateDayGrids(var_37_8, arg_37_1, arg_37_2)
		end

		return
	end)

	local var_36_1 = arg_36_0.dayList

	var_1.align(var_36_1, 6)

	return
end

function var_0_1._updateGrid(arg_39_0, arg_39_1, arg_39_2)
	setActive = var_1_10003

	var_1_10003(arg_39_1, not arg_39_2:IsLock())

	if not arg_39_2:IsLock() then
		setActive = var_3

		local var_39_0 = arg_39_1:Find("empty")
		local var_39_1 = arg_39_2

		var_3(var_39_0, arg_39_2.IsEmpty(var_39_1))

		local var_39_2 = arg_39_1
		local var_39_3 = arg_39_1.GetComponent

		typeof = var_6
		Image = var_39_1

		local var_39_4 = var_39_3(var_39_2, var_6(var_39_1))

		var_39_4.enabled = not arg_39_2:IsEmpty()
		setActive = var_39_4

		var_39_4(arg_39_1:Find("plan"), not arg_39_2:IsEmpty())

		if arg_39_2:IsPlan() or arg_39_2:IsPlanOccupy() then
			LoadImageSpriteAsync = var_3

			local var_39_5 = "educateprops/"
			local var_39_6 = arg_39_2.data

			var_3(var_39_5 .. var_6.getConfig(var_39_6, "icon"), arg_39_1:Find("plan/icon"), true)

			setScrollText = var_3

			local var_39_7 = arg_39_1:Find("plan/name_bg/Text")
			local var_39_8 = arg_39_2.data

			var_3(var_39_7, var_6.getConfig(var_39_8, "name"))
		end

		if arg_39_2:IsEvent() or arg_39_2:IsEventOccupy() then
			local var_39_9 = arg_39_2.data
			local var_39_10

			if not var_3.getConfig(var_39_9, "type_param")[1] then
				var_39_10 = ""
			end

			LoadImageSpriteAsync = var_4

			var_4("educateprops/" .. var_39_10, arg_39_1:Find("plan/icon"), true)

			setScrollText = var_4

			local var_39_11 = arg_39_1:Find("plan/name_bg/Text")

			i18n = var_7

			var_4(var_39_11, var_7("child_plan_event"))
		end
	end

	return
end

function var_0_1.updateDayGrids(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_1 + 1

	for iter_40_0 = 1, 3 do
		local var_40_1 = arg_40_2:Find("cells")
		local var_40_2 = var_8.GetChild(var_40_1, iter_40_0 - 1)

		tostring = var_1_10009
		var_40_2.name = var_1_10009(iter_40_0)
		var_1_10009 = arg_40_0.gridData[var_40_0][iter_40_0]

		arg_40_0:_updateGrid(var_40_2, var_1_10009)
	end

	return
end

function var_0_1.initSelectPlans(arg_41_0)
	local var_41_0 = arg_41_0.plansView

	arg_41_0.plansRect = var_1.GetComponent(var_41_0, "LScrollRect")
	arg_41_0.planCards = {}

	function arg_41_0.plansRect.onInitItem(arg_42_0)
		EducateSchedulePlanCard = var_2_10001

		local var_42_0 = var_2_10001.New(arg_42_0, arg_41_0)

		arg_41_0.planCards[arg_42_0] = var_42_0

		return
	end

	function arg_41_0.plansRect.onUpdateItem(arg_43_0, arg_43_1)
		if not arg_41_0.planCards[arg_43_1] then
			EducateSchedulePlanCard = var_2_10003

			local var_43_0 = var_2_10003.New(arg_43_1, arg_41_0)

			arg_41_0.planCards[arg_43_1] = var_43_0
		end

		local var_43_1 = arg_41_0.showPlans[arg_43_0 + 1]
		local var_43_2 = 0

		if arg_41_0.gridData[arg_41_0.selectDay][arg_41_0.selectIndex] and var_5:IsPlanOccupy() or var_5:IsPlan() then
			var_43_2 = var_5.id
		end

		var_2:update(var_43_1, var_43_2)

		return
	end

	function arg_41_0.plansRect.onReturnItem(arg_44_0, arg_44_1)
		return
	end

	for iter_41_0 = 1, 3 do
		local var_41_1 = arg_41_0.selectPanelTF
		local var_41_2 = var_5.Find(var_41_1, "day/cells")
		local var_41_3 = var_5.GetChild(var_41_2, iter_41_0 - 1)

		onButton = var_1_10006

		local var_41_4 = arg_41_0
		local var_41_5 = var_41_3

		local function var_41_6()
			local var_45_0 = arg_41_0.gridData[arg_41_0.selectDay][iter_41_0]

			if var_0.IsEvent(var_45_0) or var_0:IsEventOccupy() then
				pg = var_1

				local var_45_1 = var_1.TipsMgr.GetInstance()
				local var_45_2 = var_1.ShowTips

				i18n = var_2_10004

				var_45_2(var_45_1, var_2_10004("child_schedule_event_tip"))
			else
				arg_41_0.selectIndex = iter_41_0

				local var_45_3 = arg_41_0

				var_1.updateSelectdDay(var_45_3)

				local var_45_4 = arg_41_0

				var_1.updatePlanList(var_45_4)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_41_4, var_41_5, var_41_6, var_1_10011)
	end

	return
end

function var_0_1.openSelectPanel(arg_46_0, arg_46_1, arg_46_2)
	LoadImageSpriteAtlasAsync = var_1_10003

	local var_46_0 = "ui/educatescheduleui_atlas"
	local var_46_1 = arg_46_1
	local var_46_2 = arg_46_0.selectPanelTF

	var_1_10003(var_46_0, var_46_1, var_7.Find(var_46_2, "day/title"), true)

	setActive = var_1_10003

	var_1_10003(arg_46_0.selectPanelTF, true)

	setActive = var_1_10003

	var_1_10003(arg_46_0.scheduleTF, false)

	arg_46_0.selectDay = arg_46_1
	arg_46_0.selectIndex = arg_46_2

	arg_46_0:updateSelectdDay()
	arg_46_0:updatePlanList()

	return
end

function var_0_1.updateSelectdDay(arg_47_0)
	for iter_47_0 = 1, 3 do
		local var_47_0 = arg_47_0.selectPanelTF
		local var_47_1 = var_5.Find(var_47_0, "day/cells")
		local var_47_2 = var_5.GetChild(var_47_1, iter_47_0 - 1)
		local var_47_3 = arg_47_0.gridData[arg_47_0.selectDay][iter_47_0]
		local var_47_4 = arg_47_0.planProxy
		local var_47_5 = var_7.GetGridBgName(var_47_4, arg_47_0.selectDay, iter_47_0)

		GetImageSpriteFromAtlasAsync = var_8

		var_8("ui/educatescheduleui_atlas", var_47_5[1], var_47_2:Find("empty"), true)

		GetImageSpriteFromAtlasAsync = var_8

		var_8("ui/educatescheduleui_atlas", var_47_5[2], var_47_2:Find("plan/name_bg"), true)

		setActive = var_8

		var_8(var_47_2:Find("selected"), arg_47_0.selectIndex == iter_47_0)
		arg_47_0:_updateGrid(var_47_2, var_47_3)
	end

	return
end

function var_0_1.updatePlanList(arg_48_0)
	if arg_48_0.selectIndex ~= 0 then
		local var_48_0 = arg_48_0
		local var_48_1 = arg_48_0.filter
		local var_48_2 = arg_48_0.planProxy
		local var_48_3 = var_4.GetShowPlans
		local var_48_4 = arg_48_0.char

		arg_48_0.showPlans = var_48_1(var_48_0, var_48_3(var_48_2, var_7.GetNextWeekStage(var_48_4), arg_48_0.selectDay, arg_48_0.selectIndex))

		arg_48_0:sortPlans()

		local var_48_5 = arg_48_0.plansRect

		var_1.SetTotalCount(var_48_5, #arg_48_0.showPlans, -1)
	end

	return
end

function var_0_1.sortPlans(arg_49_0)
	table = var_1_10001

	local var_49_0 = var_1_10001.sort
	local var_49_1 = arg_49_0.showPlans

	CompareFuncs = var_1_10004

	var_49_0(var_49_1, var_1_10004({
		function(arg_50_0)
			table = var_2_10001

			return var_2_10001.contains(arg_49_0.newUnlcokPlanIds, arg_50_0.id) and 0 or 1
		end,
		function(arg_51_0)
			return arg_51_0:IsMatchAttr(arg_49_0.char) and 0 or 1
		end,
		function(arg_52_0)
			local var_52_0 = arg_52_0
			local var_52_1 = arg_52_0.CheckResultBySubType

			EducateConst = var_2_10004

			return var_52_1(var_52_0, var_2_10004.DROP_TYPE_ATTR, arg_49_0.showAttrSubtype) and 0 or 1
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

function var_0_1.OnPlanCardClick(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0
	local var_55_1, var_55_2 = arg_55_0.CheckCondition(var_55_0, arg_55_1)

	if var_55_1 then
		EducateGrid = var_55_0
		var_55_0 = var_55_0.New

		local var_55_3 = {}

		EducateGrid = var_1_10007
		var_55_3.type = var_1_10007.TYPE_PLAN
		var_55_3.id = arg_55_1.id
		var_55_0 = var_55_0(var_55_3)

		arg_55_0:setGridDataForPlan(arg_55_0.selectDay, arg_55_0.selectIndex, var_55_0)
		arg_55_0:updateSelectdDay()
		arg_55_0:updateResultPanel()
		arg_55_0:closeSelectPanel()
	else
		pg = var_55_0

		local var_55_4 = var_55_0.TipsMgr.GetInstance()

		var_4.ShowTips(var_55_4, var_55_2)
	end

	return
end

function var_0_1.filter(arg_56_0, arg_56_1)
	underscore = var_1_10002

	return var_1_10002.select(arg_56_1, function(arg_57_0)
		EducatePlanIndexConst = var_2_10001

		local var_57_0

		if var_2_10001.filterByType(arg_57_0, arg_56_0.typeIndex) then
			EducatePlanIndexConst = var_57_0

			if var_57_0.filterByCost(arg_57_0, arg_56_0.costIndex) then
				EducatePlanIndexConst = var_57_0

				if var_57_0.filterByAwardRes(arg_57_0, arg_56_0.awardResIndex) then
					EducatePlanIndexConst = var_57_0

					if var_57_0.filterByAwardNature(arg_57_0, arg_56_0.awardNatureIndex) then
						EducatePlanIndexConst = var_57_0

						if var_57_0.filterByAwardAttr1(arg_57_0, arg_56_0.awardAttr1Index) then
							EducatePlanIndexConst = var_57_0
							var_57_0 = var_57_0.filterByAwardAttr2(arg_57_0, arg_56_0.awardAttr2Index)
						end
					end
				end
			end
		end

		return var_57_0
	end)
end

function var_0_1.closeSelectPanel(arg_58_0)
	setActive = var_1_10001

	var_1_10001(arg_58_0.selectPanelTF, false)

	setActive = var_1_10001

	var_1_10001(arg_58_0.scheduleTF, true)

	local var_58_0 = arg_58_0.dayList

	var_1.align(var_58_0, 6)

	return
end

function var_0_1.CheckCondition(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0.gridData[arg_59_0.selectDay][arg_59_0.selectIndex]

	if var_2.IsEvent(var_59_0) or var_2:IsEventOccupy() then
		local var_59_1 = false

		i18n = var_1_10004

		local var_59_2 = var_1_10004("child_schedule_event_tip")

		return
	end

	local var_59_3 = var_2.data
	local var_59_4, var_59_5, var_59_6 = arg_59_1:GetCost()

	if var_59_6 > 1 and not arg_59_0:CheckRemainGrid(var_59_6, var_2.id) then
		local var_59_7 = false

		i18n = var_1_10008
		var_1_10008 = var_1_10008("child_plan_check_tip1")

		return
	end

	if not arg_59_1:IsMatchAttr(arg_59_0.char) then
		local var_59_8 = false

		i18n = var_1_10008
		var_1_10008 = var_1_10008("child_plan_check_tip2")

		return
	end

	local var_59_9 = arg_59_1
	local var_59_10 = arg_59_1.IsInStage
	local var_59_11 = arg_59_0.char

	if not var_59_10(var_59_9, var_10.GetNextWeekStage(var_59_11)) then
		local var_59_12 = false

		i18n = var_1_10008

		local var_59_13 = var_1_10008("child_plan_check_tip6")

		return
	end

	local var_59_14 = arg_59_1
	local var_59_15 = arg_59_1.getConfig(var_59_14, "pre")[1]
	local var_59_16 = arg_59_1
	local var_59_17 = arg_59_1.IsMatchPre
	local var_59_18 = arg_59_0.planProxy

	if not var_59_17(var_59_16, var_11.GetHistoryCntById(var_59_18, var_59_15)) then
		local var_59_19 = false

		i18n = var_59_14

		local var_59_20 = var_59_14("child_plan_check_tip3")

		return
	end

	local var_59_21, var_59_22 = arg_59_0:getPlansCost()
	local var_59_23 = 0
	local var_59_24 = 0

	if var_2:IsPlan() or var_2:IsPlanOccupy() then
		local var_59_25

		var_59_23, var_59_25 = var_59_3:GetCost()
	end

	if arg_59_0.char.money < var_59_21 + var_59_4 - var_59_23 then
		local var_59_26 = false

		i18n = var_13

		local var_59_27 = var_13("child_plan_check_tip4")

		return
	end

	return true
end

function var_0_1.CheckRemainGrid(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_0.selectIndex + arg_60_1 - 1 > 3 then
		return false
	end

	for iter_60_0 = arg_60_0.selectIndex + 1, var_3 do
		local var_60_0 = arg_60_0.gridData[arg_60_0.selectDay][iter_60_0]

		if not var_8.IsEmpty(var_60_0) and (not var_8:IsPlanOccupy() or var_8.id ~= arg_60_2) then
			return false
		end
	end

	return true
end

function var_0_1.showBuffBox(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0
	local var_61_1 = arg_61_0.emit
	local var_61_2 = var_0_1.EDUCATE_ON_ITEM
	local var_61_3 = {}
	local var_61_4 = {
		number = 1
	}

	EducateConst = var_1_10008
	var_61_4.type = var_1_10008.DROP_TYPE_BUFF
	var_61_4.id = arg_61_1
	var_61_3.drop = var_61_4

	var_61_1(var_61_0, var_61_2, var_61_3)

	return
end

function var_0_1.initResultPanel(arg_62_0)
	local var_62_0 = arg_62_0.resPanel

	var_1.ActionInvoke(var_62_0, "FlushAddValue", "", "")

	local var_62_1 = arg_62_0.buffUIList

	var_1.make(var_62_1, function(arg_63_0, arg_63_1, arg_63_2)
		UIItemList = var_2_10003

		if arg_63_0 == var_2_10003.EventUpdate then
			onButton = var_3

			local var_63_0 = arg_62_0
			local var_63_1 = arg_63_2

			local function var_63_2()
				local var_64_0 = arg_62_0

				var_0.showBuffBox(var_64_0, arg_62_0.buffList[arg_63_1 + 1].id)

				return
			end

			SFX_PANEL = var_2_10008

			var_3(var_63_0, var_63_1, var_63_2, var_2_10008)
		end

		return
	end)

	local var_62_2 = arg_62_0.buffUIList

	var_1.align(var_62_2, #arg_62_0.buffList)

	local var_62_3 = arg_62_0.natureTF
	local var_62_4 = var_1.Find(var_62_3, "content")
	local var_62_5 = arg_62_0.avatarTF
	local var_62_6 = var_2.Find(var_62_5, "progress")
	local var_62_7 = arg_62_0.char
	local var_62_8 = var_3.GetPaintingName(var_62_7)

	setImageSprite = var_62_5

	local var_62_9 = arg_62_0.avatarTF
	local var_62_10 = var_6.Find(var_62_9, "mask/Image")

	LoadSprite = var_1_10007

	var_62_5(var_62_10, var_1_10007("squareicon/" .. var_62_8), true)

	ipairs = var_62_5

	for iter_62_0, iter_62_1 in var_62_5(arg_62_0.natureIds) do
		local var_62_11 = var_62_4:GetChild(iter_62_0 - 1)

		setActive = var_10

		var_10(var_62_11:Find("tip"), false)

		var_62_11.name = iter_62_1
		setScrollText = var_10

		local var_62_12 = var_62_11:Find("mask/Text")

		pg = var_13

		local var_62_13 = var_13.child_attr[iter_62_1].name
		local var_62_14 = " "
		local var_62_15 = arg_62_0.char

		var_10(var_62_12, var_62_13 .. var_62_14 .. var_15.GetAttrById(var_62_15, iter_62_1))
	end

	local var_62_16 = arg_62_0.majorUIList

	var_4.make(var_62_16, function(arg_65_0, arg_65_1, arg_65_2)
		UIItemList = var_2_10003

		if arg_65_0 == var_2_10003.EventInit then
			arg_65_2.name = arg_62_0.majorIds[arg_65_1 + 1]
			GetImageSpriteFromAtlasAsync = var_4

			var_4("ui/educatecommonui_atlas", "attr_" .. var_3, arg_65_2:Find("icon"), true)

			setScrollText = var_4

			local var_65_0 = arg_65_2:Find("name_mask/name")

			pg = var_7

			var_4(var_65_0, var_7.child_attr[var_3].name)

			local var_65_1 = arg_62_0.char
			local var_65_2 = var_4.GetAttrInfo(var_65_1, var_3)

			setText = var_2_10005

			var_2_10005(arg_65_2:Find("grade/Text"), var_65_2)

			setText = var_2_10005

			local var_65_3 = arg_65_2:Find("before_value")
			local var_65_4 = arg_62_0.char

			var_2_10005(var_65_3, var_8.GetAttrById(var_65_4, var_3))

			EducateConst = var_2_10005

			local var_65_5 = var_2_10005.GRADE_2_COLOR[var_65_2][2]

			setActive = var_65_1

			var_65_1(arg_65_2:Find("gradient"), false)

			setImageColor = var_65_1

			local var_65_6 = arg_65_2:Find("grade")

			Color = var_9

			var_65_1(var_65_6, var_9.NewHex(var_65_5))
		else
			UIItemList = var_3

			if arg_65_0 == var_3.EventUpdate then
				tonumber = var_3

				local var_65_7 = var_3(arg_65_2.name)
				local var_65_8 = arg_62_0.char
				local var_65_9 = var_4.GetAttrById(var_65_8, var_65_7)

				if arg_62_0.attrResults and arg_62_0.attrResults[var_65_7] then
					var_65_9 = var_65_9 + arg_62_0.attrResults[var_65_7]
					setActive = var_5

					var_5(arg_65_2:Find("gradient"), true)

					setImageColor = var_5

					local var_65_10 = arg_65_2:Find("arrow")

					Color = var_8

					var_5(var_65_10, var_8.NewHex("9efffe"))

					setText = var_5

					local var_65_11 = arg_65_2:Find("after_value")

					setColorStr = var_8

					var_5(var_65_11, var_8(var_65_9, "#9efffe"))
				else
					setActive = var_5

					var_5(arg_65_2:Find("gradient"), false)

					setImageColor = var_5

					local var_65_12 = arg_65_2:Find("arrow")

					Color = var_8

					var_5(var_65_12, var_8.NewHex("dddedf"))

					setText = var_5

					local var_65_13 = arg_65_2:Find("after_value")

					setColorStr = var_8

					var_5(var_65_13, var_8(var_65_9, "#ffffff"))
				end
			end
		end

		return
	end)

	local var_62_17 = arg_62_0.minorUIList

	var_4.make(var_62_17, function(arg_66_0, arg_66_1, arg_66_2)
		UIItemList = var_2_10003

		if arg_66_0 == var_2_10003.EventInit then
			arg_66_2.name = arg_62_0.minorIds[arg_66_1 + 1]
			GetImageSpriteFromAtlasAsync = var_4

			var_4("ui/educatecommonui_atlas", "attr_" .. var_3, arg_66_2:Find("icon"), true)

			setText = var_4
			var_2_10008 = arg_66_2

			local var_66_0 = arg_66_2.Find(var_2_10008, "value")
			local var_66_1 = arg_62_0.char

			var_4(var_66_0, var_7.GetAttrById(var_66_1, var_3))
		else
			UIItemList = var_3

			if arg_66_0 == var_3.EventUpdate then
				tonumber = var_3

				local var_66_2 = var_3(arg_66_2.name)
				local var_66_3 = arg_62_0.char
				local var_66_4 = var_4.GetAttrById(var_66_3, var_66_2)

				setText = var_5

				local var_66_5 = arg_66_2:Find("name")

				pg = var_2_10008

				var_5(var_66_5, var_2_10008.child_attr[var_66_2].name)

				local var_66_6

				if arg_62_0.attrResults and arg_62_0.attrResults[var_66_2] then
					var_66_6 = var_66_4
					setColorStr = var_66_3
					var_66_4 = var_66_6 .. var_66_3("+" .. arg_62_0.attrResults[var_66_2], "#9efffe")
				end

				setText = var_66_6

				var_66_6(arg_66_2:Find("value"), var_66_4)
			end
		end

		return
	end)

	arg_62_0.attrResults, arg_62_0.resResult = {}, {}

	arg_62_0:updateResultPanel()

	return
end

function var_0_1.updateResultPanel(arg_67_0)
	local var_67_0 = arg_67_0:allEmpty()

	setActive = var_1_10002

	var_1_10002(arg_67_0.rightEmptyTF, var_67_0)

	setActive = var_1_10002

	var_1_10002(arg_67_0.rightContentTF, not var_67_0)

	if not var_67_0 then
		arg_67_0.attrResults, arg_67_0.resResult = arg_67_0:getPlansResult()

		local var_67_1 = arg_67_0.majorUIList

		var_2.align(var_67_1, #arg_67_0.majorIds)

		local var_67_2 = arg_67_0.minorUIList

		var_2.align(var_67_2, #arg_67_0.minorIds)

		local var_67_3, var_67_4 = arg_67_0:getPlansCost()
		local var_67_5 = arg_67_0.resResult

		EducateChar = var_5

		local var_67_6

		if not var_67_5[var_5.RES_MONEY_ID] then
			var_67_6 = 0
		end

		local var_67_7 = arg_67_0.resResult

		EducateChar = var_1_10006

		local var_67_8

		if not var_67_7[var_1_10006.RES_MOOD_ID] then
			var_67_8 = 0
		end

		local var_67_9

		if not (var_67_6 - var_67_3 >= 0) or not ("+" .. var_67_6 - var_67_3) then
			var_67_9 = var_67_6 - var_67_3
		end

		local var_67_10

		if not (var_67_8 - var_67_4 >= 0) or not ("+" .. var_67_8 - var_67_4) then
			var_67_10 = var_67_8 - var_67_4
		end

		local var_67_11 = arg_67_0.resPanel

		var_8.ActionInvoke(var_67_11, "FlushAddValue", var_67_10, var_67_9)

		EducateHelper = var_8

		local var_67_12 = var_8.IsShowNature()

		setActive = var_1_10009

		var_1_10009(arg_67_0.natureTF, var_67_12)

		setActive = var_1_10009

		var_1_10009(arg_67_0.natureLockTF, not var_67_12)

		if var_67_12 then
			local var_67_13 = arg_67_0.natureTF
			local var_67_14 = var_9.Find(var_67_13, "content")

			eachChild = var_67_11

			var_67_11(var_67_14, function(arg_68_0)
				tonumber = var_2_10001

				local var_68_0 = var_2_10001(arg_68_0.name)

				if arg_67_0.attrResults and arg_67_0.attrResults[var_68_0] and arg_67_0.attrResults[var_68_0] ~= 0 then
					local var_68_1 = arg_67_0.attrResults[var_68_0] > 0 and "+" or ""
					local var_68_2 = var_2 > 0 and "39bfff" or "a9a9a9"

					setActive = var_2_10005

					var_2_10005(arg_68_0:Find("tip"), true)

					setImageColor = var_2_10005

					local var_68_3 = arg_68_0:Find("tip")

					Color = var_8

					var_2_10005(var_68_3, var_8.NewHex(var_68_2))

					setText = var_2_10005

					var_2_10005(arg_68_0:Find("tip/Text"), var_68_1 .. var_2)
				else
					setActive = var_2

					var_2(arg_68_0:Find("tip"), false)
				end

				return
			end)
		end
	end

	return
end

function var_0_1.getPlansResult(arg_69_0)
	local var_69_0 = {}
	local var_69_1 = {}

	ipairs = var_1_10003

	for iter_69_0, iter_69_1 in var_1_10003(arg_69_0.gridData) do
		ipairs = var_1_10008

		for iter_69_2, iter_69_3 in var_1_10008(iter_69_1) do
			if iter_69_3:IsPlan() then
				ipairs = var_13

				local var_69_2 = iter_69_3.data

				for iter_69_4, iter_69_5 in var_13(var_15.GetResult(var_69_2)) do
					local var_69_3 = iter_69_5[1]

					EducateConst = var_1_10019

					if var_69_3 == var_1_10019.DROP_TYPE_ATTR then
						local var_69_4

						if not var_69_0[iter_69_5[2]] then
							var_69_4 = 0
						end

						var_69_0[iter_69_5[2]] = var_69_4 + iter_69_5[3]
					else
						local var_69_5 = iter_69_5[1]

						EducateConst = var_1_10019

						if var_69_5 == var_1_10019.DROP_TYPE_RES then
							local var_69_6

							if not var_69_1[iter_69_5[2]] then
								var_69_6 = 0
							end

							var_69_1[iter_69_5[2]] = var_69_6 + iter_69_5[3]
						end
					end
				end
			end
		end
	end

	return var_69_0, var_69_1
end

function var_0_1.getPlansCost(arg_70_0)
	local var_70_0 = 0
	local var_70_1 = 0
	local var_70_2 = {}

	pairs = var_1_10004

	for iter_70_0, iter_70_1 in var_1_10004(arg_70_0.gridData) do
		pairs = var_1_10009

		for iter_70_2, iter_70_3 in var_1_10009(iter_70_1) do
			if iter_70_3:IsPlan() then
				local var_70_3 = iter_70_3.data
				local var_70_4, var_70_5 = var_14.GetCost(var_70_3)

				var_70_0 = var_70_0 + var_70_4
				var_70_1 = var_70_1 + var_70_5
			end
		end
	end

	return var_70_0, var_70_1
end

function var_0_1.getRemainGridCnt(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = arg_71_0.gridData[arg_71_1]
	local var_71_1 = 1

	pairs = var_1_10005

	for iter_71_0, iter_71_1 in var_1_10005(var_71_0) do
		if arg_71_2 < iter_71_0 and iter_71_1:IsEmpty() then
			var_71_1 = var_71_1 + 1
		end
	end

	return var_71_1
end

function var_0_1.DoRecommend(arg_72_0)
	local var_72_0 = arg_72_0.char
	local var_72_1 = var_1.GetAttrSortIds(var_72_0)

	pairs = var_1_10002

	for iter_72_0, iter_72_1 in var_1_10002(arg_72_0.gridData) do
		pairs = var_1_10007

		for iter_72_2, iter_72_3 in var_1_10007(iter_72_1) do
			if iter_72_3:IsEmpty() then
				local var_72_2, var_72_3 = arg_72_0:getPlansCost()
				local var_72_4 = arg_72_0
				local var_72_5 = arg_72_0.getRemainGridCnt(var_72_4, iter_72_0, iter_72_2)
				local var_72_6 = arg_72_0.planProxy

				if var_15.GetRecommendPlan(var_72_6, iter_72_0, iter_72_2, arg_72_0.char, var_72_2, var_72_3, var_72_5, var_72_1) then
					EducateGrid = var_72_4

					local var_72_7 = var_72_4.New
					local var_72_8 = {}

					EducateGrid = var_19
					var_72_8.type = var_19.TYPE_PLAN
					var_72_8.id = var_15.id

					local var_72_9 = var_72_7(var_72_8)

					arg_72_0:setGridDataForPlan(iter_72_0, iter_72_2, var_72_9)
				end
			end
		end
	end

	arg_72_0:updateResultPanel()
	arg_72_0:closeSelectPanel()

	return
end

function var_0_1.onBackPressed(arg_73_0)
	isActive = var_1_10001

	if var_1_10001(arg_73_0.selectPanelTF) then
		arg_73_0:closeSelectPanel()
	else
		var_0_1.super.onBackPressed(arg_73_0)
	end

	return
end

function var_0_1.willExit(arg_74_0)
	local var_74_0 = arg_74_0.topPanel

	var_1.Destroy(var_74_0)

	arg_74_0.topPanel = nil

	local var_74_1 = arg_74_0.resPanel

	var_1.Destroy(var_74_1)

	arg_74_0.resPanel = nil

	local var_74_2 = arg_74_0
	local var_74_3 = arg_74_0.UnOverlayPanel
	local var_74_4 = arg_74_0.mainTF
	local var_74_5 = arg_74_0._tf

	var_74_3(var_74_2, var_74_4, var_5.Find(var_74_5, "anim_root"))

	local var_74_6 = arg_74_0
	local var_74_7 = arg_74_0.UnOverlayPanel
	local var_74_8 = arg_74_0.topTF
	local var_74_9 = arg_74_0._tf

	var_74_7(var_74_6, var_74_8, var_5.Find(var_74_9, "anim_root"))

	pairs = var_74_7

	for iter_74_0, iter_74_1 in var_74_7(arg_74_0.planCards) do
		iter_74_1:dispose()
	end

	return
end

return var_0_1
