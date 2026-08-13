class = var_0_10000

local var_0_0 = "BuildShipDetailLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))
local var_0_2 = 10
local var_0_3 = 2
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = {
	"resources/1",
	"resources/2",
	"resources/3",
	"resources/1"
}

function var_0_1.getUIName(arg_1_0)
	return "BuildShipDetailUI1"
end

function var_0_1.setItems(arg_2_0, arg_2_1)
	ITEM_ID_EQUIP_QUICK_FINISH = var_1_10002

	local var_2_0

	if not arg_2_1[var_1_10002] then
		var_2_0 = {
			count = 0
		}
		ITEM_ID_EQUIP_QUICK_FINISH = var_1_10003
		var_2_0.id = var_1_10003
	end

	arg_2_0.itemVO = var_2_0

	return
end

function var_0_1.setWorkCount(arg_3_0, arg_3_1)
	arg_3_0.workCount = arg_3_1

	return
end

function var_0_1.setBuildSpeedUpRemind(arg_4_0, arg_4_1)
	arg_4_0.isStopSpeedUpRemind = arg_4_1

	return
end

var_0_1.MODEL_INDEX = 2

function var_0_1.setProjectList(arg_5_0, arg_5_1)
	arg_5_0.projectList = arg_5_1

	local var_5_0

	if not (#arg_5_0.projectList > var_0_1.MODEL_INDEX) or not var_0_3 then
		var_5_0 = var_0_4
	end

	arg_5_0.MODEL = var_5_0

	return
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.multLineTF = var_1.Find(var_6_0, "list_mult_line")

	local var_6_1 = arg_6_0._tf

	arg_6_0.multLineContain = var_1.Find(var_6_1, "list_mult_line/content")

	local var_6_2 = arg_6_0.multLineContain

	arg_6_0.multLineTpl = var_1.Find(var_6_2, "project_tpl")
	UIItemList = var_1
	arg_6_0.multList = var_1.New(arg_6_0.multLineContain, arg_6_0.multLineTpl)

	local var_6_3 = arg_6_0._tf

	arg_6_0.singleLineTF = var_1.Find(var_6_3, "list_single_line")

	local var_6_4 = arg_6_0._tf

	arg_6_0.singleLineContain = var_1.Find(var_6_4, "list_single_line/content")

	local var_6_5 = arg_6_0.singleLineContain

	arg_6_0.singleLineTpl = var_1.Find(var_6_5, "project_tpl")
	UIItemList = var_1
	arg_6_0.singleList = var_1.New(arg_6_0.singleLineContain, arg_6_0.singleLineTpl)

	local var_6_6 = arg_6_0._tf

	arg_6_0.listCountTF = var_1.Find(var_6_6, "title/value")

	local var_6_7 = arg_6_0._tf

	arg_6_0.quickCount = var_1.Find(var_6_7, "quick_count")

	local var_6_8 = arg_6_0._tf

	arg_6_0.quickCountTF = var_1.Find(var_6_8, "quick_count/value")

	local var_6_9 = arg_6_0._tf

	arg_6_0.noneBg = var_1.Find(var_6_9, "none_bg")

	local var_6_10 = arg_6_0._tf

	arg_6_0.allLaunch = var_1.Find(var_6_10, "all_launch")

	local var_6_11 = arg_6_0._tf

	arg_6_0.aniBgTF = var_1.Find(var_6_11, "aniBg")

	local var_6_12 = arg_6_0._tf
	local var_6_13 = var_1.Find(var_6_12, "autolockship/Toggle")
	local var_6_14 = var_1.GetComponent

	typeof = var_4
	Toggle = var_1_10006
	arg_6_0.autoLockShipToggle = var_6_14(var_6_13, var_4(var_1_10006))
	GetOrAddComponent = var_1

	local var_6_15 = arg_6_0._tf

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_6_0.canvasgroup = var_1(var_6_15, var_4(var_1_10006))
	setText = var_1

	local var_6_16 = arg_6_0._tf
	local var_6_17 = var_3.Find(var_6_16, "title/text")

	i18n = var_4

	var_1(var_6_17, var_4("build_detail_intro"))

	setText = var_1

	local var_6_18 = arg_6_0._tf
	local var_6_19 = var_3.Find(var_6_18, "autolockship/Text")

	i18n = var_4

	var_1(var_6_19, var_4("lock_new_ship"))

	return
end

function var_0_1.updatePlayer(arg_7_0, arg_7_1)
	arg_7_0._player = arg_7_1

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0.projectTFs = {}

	local var_8_0 = arg_8_0.multList

	var_1.make(var_8_0, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			arg_9_2.gameObject.name = "project_" .. arg_9_1 + 1
			arg_8_0.projectTFs[arg_9_1 + 1] = arg_9_2

			local var_9_0 = arg_8_0

			var_3.updateProject(var_9_0, arg_9_1 + 1, arg_8_0.projectList[arg_9_1 + 1])
		end

		return
	end)

	local var_8_1 = arg_8_0.singleList

	var_1.make(var_8_1, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			arg_10_2.gameObject.name = "project_" .. arg_10_1 + 1
			arg_8_0.projectTFs[arg_10_1 + 1] = arg_10_2

			local var_10_0 = arg_8_0

			var_3.updateProject(var_10_0, arg_10_1 + 1, arg_8_0.projectList[arg_10_1 + 1])
		end

		return
	end)
	arg_8_0:initProjectList()
	arg_8_0:updateItem()
	arg_8_0:updateListCount()

	GameObject = var_1

	local var_8_2 = var_1.Find("Overlay/UIOverlay")
	local var_8_3 = arg_8_0.aniBgTF.transform

	var_2.SetParent(var_8_3, var_8_2.transform, false)

	onButton = var_2

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0.allLaunch

	local function var_8_6()
		local var_11_0 = arg_8_0

		if var_0.getNeedCount(var_11_0) > 0 and not arg_8_0.isStopSpeedUpRemind then
			pg = var_1
			var_2_10004 = var_1.MsgboxMgr.GetInstance()

			local var_11_1 = var_1.ShowMsgBox
			local var_11_2 = {
				showStopRemind = true
			}

			i18n = var_2_10006

			local var_11_3 = "ship_buildShipScene_quest_quickFinish"
			local var_11_4 = var_0

			if arg_8_0.itemVO.count == 0 then
				COLOR_RED = var_10

				if not var_10 then
					COLOR_GREEN = var_10
				end

				var_11_2.content = var_2_10006(var_11_3, var_11_4, var_10, arg_8_0.itemVO.count)
				i18n = var_6
				var_11_2.stopRamindContent = var_6("common_dont_remind_dur_login")

				function var_11_2.onYes()
					local var_12_0 = arg_8_0
					local var_12_1 = var_0.emit

					BuildShipDetailMediator = var_3_10003

					var_12_1(var_12_0, var_3_10003.LAUNCH_ALL, var_0.stopRemindToggle.isOn)

					return
				end

				var_11_1(var_2_10004, var_11_2)

				if false then
					local var_11_6

					if #arg_8_0.projectList > 0 then
						local var_11_5 = arg_8_0

						var_11_6 = var_11_6.emit
						BuildShipDetailMediator = var_2_10004

						var_11_6(var_11_5, var_2_10004.LAUNCH_ALL)
					else
						pg = var_11_6

						local var_11_7 = var_11_6.TipsMgr.GetInstance()
						local var_11_8 = var_1.ShowTips

						i18n = var_2_10004

						var_11_8(var_11_7, var_2_10004("ship_getShip_error_noShip"))
					end
				end

				return
			end
		end
	end

	SFX_UI_BUILDING_FASTBUILDING = var_1_10007

	var_2(var_8_4, var_8_5, var_8_6, var_1_10007)

	onButton = var_2

	var_2(arg_8_0, arg_8_0.quickCount, function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.shop_template[61009]

		shoppingBatch = var_1

		var_1(61009, {
			id = var_13_0.effect_args[1]
		}, 9, "build_ship_quickly_buy_tool")

		return
	end)

	pg = var_2

	local var_8_7 = var_2.settings_other_template[22]

	getProxy = var_3
	PlayerProxy = var_5

	local var_8_8 = var_3(var_5)
	local var_8_9 = var_3.getRawData(var_8_8)
	local var_8_10 = var_3.GetCommonFlag

	_G = var_6

	local var_8_11 = var_8_10(var_8_9, var_6[var_8_7.name])

	if var_8_7.default == 1 then
		var_8_11 = not var_8_11
	end

	local var_8_12 = arg_8_0.autoLockShipToggle

	var_8_12.isOn = var_8_11 or false
	onToggle = var_8_12

	local var_8_13 = arg_8_0

	go = var_7

	local var_8_14 = var_7(arg_8_0.autoLockShipToggle)

	local function var_8_15(arg_14_0)
		local var_14_0 = arg_8_0

		var_1.ChangeAutoLockShip(var_14_0, var_8_7, arg_14_0)

		return
	end

	SFX_PANEL = var_9

	var_8_12(var_8_13, var_8_14, var_8_15, var_9)

	return
end

function var_0_1.onBackPressed(arg_15_0)
	if arg_15_0.isPlayAnim then
		return
	end

	arg_15_0:emit(var_0_1.ON_BACK_PRESSED, true)

	return
end

function var_0_1.getNeedCount(arg_16_0)
	local var_16_0 = 0

	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.projectList) do
		local var_16_1 = iter_16_1.state

		BuildShip = var_1_10008

		if var_16_1 ~= var_1_10008.FINISH then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function var_0_1.updateListCount(arg_17_0)
	setText = var_1_10001

	var_1_10001(arg_17_0.listCountTF, arg_17_0.workCount)

	return
end

function var_0_1.updateItem(arg_18_0)
	setText = var_1_10001

	var_1_10001(arg_18_0.quickCountTF, arg_18_0.itemVO.count)

	return
end

function var_0_1.initProjectList(arg_19_0)
	pairs = var_1_10001

	local var_19_0

	if not arg_19_0.buildTimers then
		var_19_0 = {}
	end

	for iter_19_0, iter_19_1 in var_1_10001(var_19_0) do
		pg = var_1_10006

		local var_19_1 = var_1_10006.TimeMgr.GetInstance()

		var_1_10006.RemoveTimer(var_19_1, iter_19_1)
	end

	arg_19_0.buildTimers = {}

	local var_19_2

	if arg_19_0.MODEL ~= var_0_3 or not #arg_19_0.projectList then
		var_19_2 = 0
	end

	local var_19_3

	if arg_19_0.MODEL ~= var_0_4 or not #arg_19_0.projectList then
		var_19_3 = 0
	end

	setActive = var_3

	var_3(arg_19_0.multLineTF, var_19_2 > 0)

	setActive = var_3

	var_3(arg_19_0.singleLineTF, var_19_3 > 0)

	local var_19_4 = arg_19_0.multList

	var_3.align(var_19_4, var_19_2)

	local var_19_5 = arg_19_0.singleList

	var_3.align(var_19_5, var_19_3)

	setActive = var_3

	var_3(arg_19_0.noneBg, #arg_19_0.projectList <= 0)

	return
end

function var_0_1.initMultLine(arg_20_0)
	local var_20_0 = arg_20_0.multList

	var_1.align(var_20_0, #arg_20_0.projectList)

	return
end

function var_0_1.initSingleLine(arg_21_0)
	local var_21_0 = arg_21_0.singleList

	var_1.align(var_21_0, #arg_21_0.projectList)

	return
end

function var_0_1.updateProject(arg_22_0, arg_22_1, arg_22_2)
	assert = var_1_10003
	isa = var_1_10005

	local var_22_0 = arg_22_2

	BuildShip = var_1_10008

	var_1_10003(var_1_10005(var_22_0, var_1_10008), "必须是实例BuildShip")

	local var_22_1 = arg_22_0.projectTFs[arg_22_1]

	IsNil = var_1_10004

	if var_1_10004(var_22_1) then
		return
	end

	local var_22_2 = var_22_1:Find("frame/buiding")
	local var_22_3 = var_22_1
	local var_22_4 = var_22_1.Find(var_22_3, "frame/finished")
	local var_22_5 = var_22_1:Find("frame/waiting")

	setActive = var_22_3

	var_22_3(var_22_5, false)

	setActive = var_22_3

	local var_22_6 = var_22_2
	local var_22_7 = arg_22_2.state

	BuildShip = var_1_10011

	var_22_3(var_22_6, var_22_7 == var_1_10011.ACTIVE)

	setActive = var_22_3

	local var_22_8 = var_22_4
	local var_22_9 = arg_22_2.state

	BuildShip = var_11

	var_22_3(var_22_8, var_22_9 == var_11.FINISH)

	local var_22_10 = var_22_1
	local var_22_11 = var_22_1.GetComponent(var_22_10, "CanvasGroup")
	local var_22_12 = arg_22_2.state

	BuildShip = var_22_10
	var_22_11.alpha = var_22_12 == var_22_10.INACTIVE and 0.6 or 1
	pg = var_8

	local var_22_13 = var_8.ship_data_create_material[arg_22_2.type]

	tonumber = var_9

	local var_22_14 = var_9(var_22_13.ship_icon)
	local var_22_15 = var_22_2:Find("ship_modal")

	for iter_22_0 = 0, var_22_15.childCount - 1 do
		var_1_10017 = var_22_15

		local var_22_16 = var_22_15.GetChild(var_1_10017, iter_22_0)

		setActive = var_1_10016

		var_1_10016(var_22_16, false)
	end

	local var_22_17 = arg_22_2.state

	BuildShip = var_12

	if var_22_17 == var_12.ACTIVE then
		GetComponent = var_22_17

		local var_22_18 = var_22_2

		typeof = iter_22_0
		CanvasGroup = var_1_10016

		if var_22_17(var_22_18, iter_22_0(var_1_10016)) then
			var_11.alpha = 1
		end

		iter_22_0 = var_22_15

		if not var_22_15.Find(iter_22_0, "shipModelBuliding" .. var_22_14) then
			PoolMgr = var_22_18

			local var_22_19 = var_22_18.GetInstance()

			var_22_18.GetUI(var_22_19, "shipModelBuliding" .. var_22_14, true, function(arg_23_0)
				local var_23_0 = arg_23_0.transform

				var_1.SetParent(var_23_0, var_22_15, false)

				local var_23_1 = arg_23_0.transform

				Vector3 = var_2_10002
				var_23_1.localPosition = var_2_10002(1, 1, 1)

				local var_23_2 = arg_23_0.transform

				Vector3 = var_2
				var_23_2.localScale = var_2(1, 1, 1)

				local var_23_3 = arg_23_0.transform

				var_1.SetAsFirstSibling(var_23_3)

				setActive = var_1

				var_1(arg_23_0, true)

				return
			end)
		else
			setActive = var_22_18

			var_22_18(var_12, true)
		end

		local var_22_20 = var_22_2:Find("timer/Text")

		onButton = iter_22_0
		var_1_10016 = arg_22_0

		local var_22_21 = var_22_2

		var_1_10017 = var_22_2.Find(var_22_21, "quick_btn")

		local function var_22_22()
			BuildShip = var_2_10000

			local var_24_0, var_24_1, var_24_2 = var_2_10000.canQuickBuildShip(arg_22_1)

			if not var_24_0 then
				if var_24_2 then
					GoShoppingMsgBox = var_2_10003
					i18n = var_2_10005

					local var_24_3 = var_2_10005("switch_to_shop_tip_1")

					ChargeScene = var_2_10006

					var_2_10003(var_24_3, var_2_10006.TYPE_ITEM, var_24_2)
				else
					pg = var_2_10003

					local var_24_4 = var_2_10003.TipsMgr.GetInstance()

					var_3.ShowTips(var_24_4, var_24_1)
				end

				return
			end

			local var_24_6

			if arg_22_0.isStopSpeedUpRemind then
				local var_24_5 = arg_22_0

				var_24_6 = var_24_6.emit
				BuildShipDetailMediator = var_2_10006

				var_24_6(var_24_5, var_2_10006.ON_QUICK, arg_22_1)

				goto label_24_0
			end

			pg = var_24_6

			local var_24_7 = var_24_6.MsgboxMgr.GetInstance()
			local var_24_8 = var_3.ShowMsgBox
			local var_24_9 = {
				showStopRemind = true
			}

			i18n = var_2_10008

			local var_24_10 = "ship_buildShipScene_quest_quickFinish"
			local var_24_11 = 1

			if arg_22_0.itemVO.count == 0 then
				COLOR_RED = var_12

				if not var_12 then
					COLOR_GREEN = var_12
				end

				var_24_9.content = var_2_10008(var_24_10, var_24_11, var_12, arg_22_0.itemVO.count)
				i18n = var_8
				var_24_9.stopRamindContent = var_8("dont_remind_session")

				function var_24_9.onYes()
					local var_25_0 = arg_22_0
					local var_25_1 = var_0.emit

					BuildShipDetailMediator = var_3_10003

					var_25_1(var_25_0, var_3_10003.ON_QUICK, arg_22_1, var_0.stopRemindToggle.isOn)

					return
				end

				var_24_8(var_24_7, var_24_9)

				::label_24_0::

				return
			end
		end

		SFX_UI_BUILDING_FASTBUILDING = var_22_21

		iter_22_0(var_1_10016, var_1_10017, var_22_22, var_22_21)

		function iter_22_0()
			pg = var_2_10000

			local var_26_0 = var_2_10000.TimeMgr.GetInstance()

			var_0.RemoveTimer(var_26_0, arg_22_0.buildTimers[arg_22_1])

			local var_26_1 = arg_22_0.buildTimers

			var_26_1[arg_22_1] = nil
			setActive = var_26_1

			var_26_1(var_22_2, false)

			setActive = var_26_1

			var_26_1(var_22_4, true)

			return
		end

		local function var_22_23(arg_27_0)
			pg = var_2_10001

			local var_27_0 = var_2_10001.TimeMgr.GetInstance()
			local var_27_1 = var_1.DescCDTime(var_27_0, arg_27_0)

			setText = var_2_10002

			var_2_10002(var_22_20, var_27_1)

			return
		end

		if arg_22_0.buildTimers[arg_22_1] then
			pg = var_1_10016

			local var_22_24 = var_1_10016.TimeMgr.GetInstance()

			var_1_10016.RemoveTimer(var_22_24, arg_22_0.buildTimers[arg_22_1])

			var_1_10016 = arg_22_0.buildTimers
			var_1_10016[arg_22_1] = nil
		end

		var_1_10016 = arg_22_0.buildTimers
		pg = var_1_10017

		local var_22_25 = var_1_10017.TimeMgr.GetInstance()

		var_1_10016[arg_22_1] = var_1_10017.AddTimer(var_22_25, "timer" .. arg_22_1, 0, 1, function()
			local var_28_0 = arg_22_2

			if var_0.getLeftTime(var_28_0) <= 0 then
				iter_22_0()
			else
				var_22_23(var_0)
			end

			return
		end)
	else
		local var_22_26 = arg_22_2.state

		BuildShip = var_12

		if var_22_26 == var_12.FINISH then
			GetOrAddComponent = var_22_26

			local var_22_27 = var_22_2

			typeof = iter_22_0
			CanvasGroup = var_1_10016
			var_22_26(var_22_27, iter_22_0(var_1_10016)).alpha = 0
			setActive = var_12

			var_12(var_22_2, true)

			local var_22_28 = var_22_15

			if var_22_15.Find(var_22_28, "shipModelBuliding" .. var_22_14) then
				setActive = var_22_27

				var_22_27(var_12, true)
			end

			local var_22_29 = arg_22_0
			local var_22_30 = arg_22_0.setSpriteTo
			local var_22_31 = var_0_6

			tonumber = var_1_10017

			local var_22_32 = var_22_31[var_1_10017(var_22_13.ship_icon)]
			local var_22_33 = var_22_4

			var_22_30(var_22_29, var_22_32, var_22_4.Find(var_22_33, "ship_modal"), false)

			findTF = var_22_30

			local var_22_34 = var_22_30(var_22_4, "launched_btn")

			onButton = var_22_28

			local var_22_35 = arg_22_0
			local var_22_36 = var_22_34

			local function var_22_37()
				local var_29_0 = arg_22_0
				local var_29_1 = var_0.emit

				BuildShipDetailMediator = var_2_10003

				var_29_1(var_29_0, var_2_10003.ON_LAUNCHED, arg_22_1)

				return
			end

			SFX_PANEL = var_22_33

			var_22_28(var_22_35, var_22_36, var_22_37, var_22_33)

			onButton = var_22_28

			local var_22_38 = arg_22_0
			local var_22_39 = var_22_1

			local function var_22_40()
				triggerButton = var_2_10000

				var_2_10000(var_22_34)

				return
			end

			SFX_PANEL = var_22_33

			var_22_28(var_22_38, var_22_39, var_22_40, var_22_33)
		else
			local var_22_41 = arg_22_2.state

			BuildShip = var_12

			if var_22_41 == var_12.INACTIVE then
				setActive = var_22_41

				var_22_41(var_22_5, true)

				setActive = var_22_41

				var_22_41(var_22_2, false)

				setActive = var_22_41

				var_22_41(var_22_4, false)
			end
		end
	end

	return
end

function var_0_1.playGetShipAnimate(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0.canvasgroup

	var_31_0.blocksRaycasts = false
	pg = var_31_0

	local var_31_1 = var_31_0.ship_data_create_material[arg_31_2]

	arg_31_0.isPlayAnim = true
	arg_31_0.onLoading = true
	pg = var_4

	local var_31_2 = var_4.CpkPlayMgr.GetInstance()
	local var_31_3 = var_4.PlayCpkMovie

	local function var_31_4()
		arg_31_0.onLoading = false

		if var_31_1 and var_31_1.build_voice ~= "" then
			local var_32_0 = arg_31_0

			var_0.playCV(var_32_0, var_31_1.build_voice)
		end

		warning = var_0

		local var_32_1 = "BuildingCPK PlayCallBack"

		pg = var_2_10003

		var_0(var_32_1, var_2_10003.CpkPlayMgr.GetInstance()._ratioFitter.enabled)

		return
	end

	local function var_31_5()
		arg_31_0.isPlayAnim = false
		arg_31_0.canvasgroup.blocksRaycasts = true

		arg_31_1()

		return
	end

	local var_31_6 = "ui"
	local var_31_7

	if not var_31_1.build_anim then
		var_31_7 = "Building"
	end

	var_31_3(var_31_2, var_31_4, var_31_5, var_31_6, var_31_7, true, false, 4.5, true)

	return
end

function var_0_1.willExit(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.CpkPlayMgr.GetInstance()

	var_1.DisposeCpkMovie(var_34_0)

	pairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0.buildTimers) do
		pg = var_1_10006

		local var_34_1 = var_1_10006.TimeMgr.GetInstance()

		var_1_10006.RemoveTimer(var_34_1, iter_34_1)
	end

	if arg_34_0.aniBgTF then
		SetParent = var_1

		var_1(arg_34_0.aniBgTF, arg_34_0._tf)
	end

	arg_34_0.buildTimers = nil

	arg_34_0:stopCV()

	arg_34_0.onLoading = false

	local var_34_2 = arg_34_0.multList

	var_1.each(var_34_2, function(arg_35_0, arg_35_1)
		local var_35_0 = arg_35_1:Find("frame/buiding/ship_modal")

		eachChild = var_2_10003

		var_2_10003(var_35_0, function(arg_36_0)
			PoolMgr = var_3_10001

			local var_36_0 = var_3_10001.GetInstance()

			var_1.ReturnUI(var_36_0, arg_36_0.name, arg_36_0)

			return
		end)

		return
	end)

	local var_34_3 = arg_34_0.singleList

	var_1.each(var_34_3, function(arg_37_0, arg_37_1)
		local var_37_0 = arg_37_1:Find("frame/buiding/ship_modal")

		eachChild = var_2_10003

		var_2_10003(var_37_0, function(arg_38_0)
			PoolMgr = var_3_10001

			local var_38_0 = var_3_10001.GetInstance()

			var_1.ReturnUI(var_38_0, arg_38_0.name, arg_38_0)

			return
		end)

		return
	end)

	return
end

function var_0_1.playCV(arg_39_0, arg_39_1)
	arg_39_0:stopCV()

	local var_39_0 = "event:/cv/build/" .. arg_39_1

	pg = var_3

	local var_39_1 = var_3.CriMgr.GetInstance()

	var_3.PlaySoundEffect_V3(var_39_1, var_39_0)

	arg_39_0.voiceContent = var_39_0

	return
end

function var_0_1.stopCV(arg_40_0)
	if arg_40_0.voiceContent then
		pg = var_1

		local var_40_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_40_0, arg_40_0.voiceContent)
	end

	arg_40_0.voiceContent = nil

	return
end

function var_0_1.ChangeAutoLockShip(arg_41_0, arg_41_1, arg_41_2)
	_G = var_1_10003

	local var_41_0 = var_1_10003[arg_41_1.name]

	getProxy = var_4
	PlayerProxy = var_1_10006

	local var_41_1 = var_4(var_1_10006)
	local var_41_2 = var_4.getRawData(var_41_1)
	local var_41_3 = var_4.GetCommonFlag(var_41_2, var_41_0)
	local var_41_4 = not arg_41_2

	if arg_41_1.default == 1 then
		var_41_4 = arg_41_2
	end

	local var_41_6

	if var_41_4 then
		pg = var_41_6

		local var_41_5 = var_41_6.m02

		var_41_6 = var_41_6.sendNotification
		GAME = var_1_10009

		var_41_6(var_41_5, var_1_10009.CANCEL_COMMON_FLAG, {
			flagID = var_41_0
		})
	else
		pg = var_41_6

		local var_41_7 = var_41_6.m02
		local var_41_8 = var_6.sendNotification

		GAME = var_1_10009

		var_41_8(var_41_7, var_1_10009.COMMON_FLAG, {
			flagID = var_41_0
		})
	end

	return
end

return var_0_1
