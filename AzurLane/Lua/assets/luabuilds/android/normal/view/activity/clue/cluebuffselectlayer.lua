class = var_0_10000

local var_0_0 = "ClueBuffSelectLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.SP_STRA_MIN_RANGE = 201308
var_0_1.SP_STRA_MAX_RANGE = 201320
var_0_1.SP_STRATEGY_ID = 201321
var_0_1.BOOST_ITEM_ID = 26
var_0_1.PLYAER_PREF_KEY = "ClueBuffSelectedBySingleEnemyID_"

function var_0_1.getUIName(arg_1_0)
	return "ClueBuffSelectUI"
end

function var_0_1.preloadUIList(arg_2_0)
	return {
		arg_2_0:getUIName(),
		"BossSingleFleetSelectView"
	}
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.closeBtn = var_1.Find(var_3_0, "Top/BackBtn")
	onButton = var_1

	var_1(arg_3_0, arg_3_0.closeBtn, function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK_PRESSED)

		return
	end)

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0._tf

	var_1(var_3_1, var_3.Find(var_3_2, "mask"), function()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_BACK_PRESSED)

		return
	end)

	local var_3_3 = arg_3_0._tf

	arg_3_0.buffContainer = var_1.Find(var_3_3, "Buff/buff_list")

	local var_3_4 = arg_3_0.buffContainer

	arg_3_0.buffTmp = var_1.Find(var_3_4, "buff")
	arg_3_0.buffTFs = {}
	arg_3_0.strategyList = {}
	arg_3_0.buffDescList = {}

	for iter_3_0 = 1, 4 do
		local var_3_5 = arg_3_0._tf
		local var_3_6 = var_5.Find(var_3_5, "Buff/buff_desc_list/buff_desc_" .. iter_3_0)

		table = var_3_5

		var_3_5.insert(arg_3_0.buffDescList, var_3_6)

		setText = var_6

		local var_3_7 = var_3_6
		local var_3_8 = var_3_6.Find(var_3_7, "unselect")

		i18n = var_3_7

		var_6(var_3_8, var_3_7("clue_buff_unselect"))
	end

	local var_3_9 = arg_3_0._tf

	arg_3_0.stageName = var_1.Find(var_3_9, "Stage/stage_name_text")

	local var_3_10 = arg_3_0._tf

	arg_3_0.stageLV = var_1.Find(var_3_10, "Stage/stage_level_text")
	setText = var_1

	local var_3_11 = arg_3_0._tf
	local var_3_12 = var_2.Find(var_3_11, "Stage/text_stage_reserach")

	i18n = var_3_11

	var_1(var_3_12, var_3_11("clue_buff_research"))

	setText = var_1

	local var_3_13 = arg_3_0._tf
	local var_3_14 = var_2.Find(var_3_13, "Stage/text_stage_loot")

	i18n = var_3_13

	var_1(var_3_14, var_3_13("clue_buff_stage_loot"))

	local var_3_15 = arg_3_0._tf

	arg_3_0.awards = var_1.Find(var_3_15, "Loot/awards")

	local var_3_16 = arg_3_0._tf

	arg_3_0.awardTpl = var_1.Find(var_3_16, "Loot/awards/award")

	local var_3_17 = arg_3_0._tf

	arg_3_0.goBtn = var_1.Find(var_3_17, "Combat/go_btn")
	onButton = var_1

	var_1(arg_3_0, arg_3_0.goBtn, function()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		ClueBuffSelectMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_FLEET_SELECT, arg_3_0.singleID)

		return
	end)

	local var_3_18 = arg_3_0._tf

	arg_3_0.detailView = var_1.Find(var_3_18, "Detail")

	local var_3_19 = arg_3_0._tf

	arg_3_0.detailBtn = var_1.Find(var_3_19, "BuffDetail")
	setActive = var_1

	var_1(arg_3_0.detailBtn, false)

	UIItemList = var_1

	local var_3_20 = var_1.New
	local var_3_21 = arg_3_0.detailView
	local var_3_22 = var_2.Find(var_3_21, "panel/list")
	local var_3_23 = arg_3_0.detailView

	arg_3_0.detailList = var_3_20(var_3_22, var_3.Find(var_3_23, "panel/list/item"))
	onButton = var_1

	var_1(arg_3_0, arg_3_0.detailBtn, function()
		local var_7_0 = arg_3_0

		var_0.openDetailView(var_7_0)

		return
	end)

	local var_3_24 = arg_3_0.detailView

	arg_3_0.detailClose = var_1.Find(var_3_24, "btnBack")
	onButton = var_1

	var_1(arg_3_0, arg_3_0.detailClose, function()
		local var_8_0 = arg_3_0

		var_0.closeDetailView(var_8_0)

		return
	end)

	onButton = var_1

	local var_3_25 = arg_3_0
	local var_3_26 = arg_3_0.detailView

	var_1(var_3_25, var_3.Find(var_3_26, "mask"), function()
		local var_9_0 = arg_3_0

		var_0.closeDetailView(var_9_0)

		return
	end)

	local var_3_27 = arg_3_0._tf

	arg_3_0.ticket = var_1.Find(var_3_27, "Ticket")

	local var_3_28 = arg_3_0._tf

	arg_3_0.ticketTips = var_1.Find(var_3_28, "ticketTips")

	local var_3_29 = arg_3_0.ticket

	arg_3_0.ticketCheckBox = var_1.Find(var_3_29, "checkbox")
	arg_3_0.useTicket = false
	onButton = var_1

	local var_3_30 = arg_3_0
	local var_3_31 = arg_3_0.ticket

	var_1(var_3_30, var_3.Find(var_3_31, "bg"), function()
		local var_10_0 = arg_3_0

		var_0.UpdateTicket(var_10_0)

		return
	end)

	setText = var_1

	local var_3_32 = arg_3_0.ticketTips

	i18n = var_3

	var_1(var_3_32, var_3("clue_buff_ticket_tips"))

	local var_3_33 = arg_3_0._tf

	arg_3_0.explore = var_1.Find(var_3_33, "exploreTarget")
	setActive = var_1

	var_1(arg_3_0.explore, true)

	BossSingleBattleFleetSelectViewComponent = var_1

	local var_3_34 = var_1.AttachFleetSelect
	local var_3_35 = arg_3_0

	ClueBuffSelectMediator = var_3

	var_3_34(var_3_35, var_3)

	pg = var_3_34

	local var_3_36 = var_3_34.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_36, arg_3_0._tf)

	return
end

function var_0_1.didEnter(arg_11_0)
	arg_11_0:updateBuffView()
	arg_11_0:UpdateCluePanel()

	local var_11_0 = arg_11_0.contextData

	var_11_0.selectedBuffList = {}
	ipairs = var_11_0

	for iter_11_0, iter_11_1 in var_11_0(arg_11_0.preSelectedBuffList) do
		arg_11_0:selectBuff(iter_11_1)
	end

	if arg_11_0.contextData.editFleet then
		arg_11_0:ShowNormalFleet(arg_11_0.singleID)
	end

	return
end

function var_0_1.show(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0._tf, true)

	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_12_0, arg_12_0._tf)

	return
end

function var_0_1.hide(arg_13_0)
	setActive = var_1_10001

	var_1_10001(arg_13_0._tf, false)

	pg = var_1_10001

	local var_13_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf, arg_13_0._parentTf)

	return
end

function var_0_1.openDetailView(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.detailView, true)
	arg_14_0:updateDetailView()

	return
end

function var_0_1.closeDetailView(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.detailView, false)

	return
end

function var_0_1.updateBuffView(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.activity_single_enemy[arg_16_0.singleID].strategy_id

	ipairs = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10003(var_16_0) do
		table = var_1_10008

		if not var_1_10008.contains(arg_16_0.strategyList, iter_16_1) then
			setActive = var_1_10008

			local var_16_1 = arg_16_0.buffTFs[iter_16_1]

			var_1_10008(var_1_10009.Find(var_16_1, "selected"), false)
		end
	end

	pg = var_3

	local var_16_2 = var_3.strategy_data_template

	ipairs = var_4

	for iter_16_2, iter_16_3 in var_4(arg_16_0.buffDescList) do
		local var_16_3 = iter_16_3:Find("mask/desc")
		local var_16_4 = var_1_10009.GetComponent(var_16_3, "RectTransform")
		local var_16_6

		if var_1.strategy_num < iter_16_2 then
			local var_16_5 = iter_16_3:Find("bg")

			var_16_6 = var_16_6.GetComponent
			typeof = var_13
			CanvasGroup = var_1_10014
			var_16_6 = var_16_6(var_16_5, var_13(var_1_10014))
			var_16_6.alpha = 0.05
			setActive = var_16_6

			var_16_6(iter_16_3:Find("lock"), true)

			setActive = var_16_6

			var_16_6(var_1_10009, false)

			setActive = var_16_6

			var_16_6(iter_16_3:Find("over_deco"), false)

			setActive = var_16_6

			var_16_6(iter_16_3:Find("unselect"), false)
		else
			setActive = var_16_6

			var_16_6(iter_16_3:Find("lock"), false)

			local var_16_7

			if arg_16_0.strategyList[iter_16_2] then
				setActive = var_16_7

				var_16_7(var_1_10009, true)

				var_16_7 = var_16_2[arg_16_0.strategyList[iter_16_2]]

				local var_16_8 = iter_16_3:Find("bg")
				local var_16_9 = var_12.GetComponent

				typeof = var_1_10014
				CanvasGroup = var_1_10015

				local var_16_10 = var_16_9(var_16_8, var_1_10014(var_1_10015))

				var_16_10.alpha = 1
				setText = var_16_10
				var_1_10014 = var_1_10009

				var_16_10(var_1_10009.Find(var_1_10014, "index"), iter_16_2)

				setText = var_16_10
				var_1_10014 = var_1_10009

				var_16_10(var_1_10009.Find(var_1_10014, "name"), var_16_7.name)

				setText = var_16_10
				var_1_10014 = var_1_10009

				var_16_10(var_1_10009.Find(var_1_10014, "desc"), var_16_7.desc)

				setActive = var_16_10
				var_1_10014 = iter_16_3

				var_16_10(iter_16_3.Find(var_1_10014, "lock"), false)

				setActive = var_16_10
				var_1_10014 = iter_16_3

				var_16_10(iter_16_3.Find(var_1_10014, "unselect"), false)

				Canvas = var_16_10

				var_16_10.ForceUpdateCanvases()

				setActive = var_12
				var_1_10014 = iter_16_3

				local var_16_11 = iter_16_3.Find(var_1_10014, "over_deco")

				var_1_10014 = var_16_4.rect.width
				var_1_10014 = 560 < var_1_10014

				var_12(var_16_11, var_1_10014)
			else
				setActive = var_16_7

				var_16_7(var_1_10009, false)

				local var_16_12 = iter_16_3:Find("bg")
				local var_16_13 = var_11.GetComponent

				typeof = var_13
				CanvasGroup = var_1_10014

				local var_16_14 = var_16_13(var_16_12, var_13(var_1_10014))

				var_16_14.alpha = 0.2
				setActive = var_16_14

				var_16_14(iter_16_3:Find("unselect"), true)

				setActive = var_16_14

				var_16_14(iter_16_3:Find("lock"), false)

				setActive = var_16_14

				var_16_14(iter_16_3:Find("over_deco"), false)
			end
		end
	end

	pairs = var_4

	for iter_16_4, iter_16_5 in var_4(arg_16_0.buffTFs) do
		table = var_1_10009

		if var_1_10009.contains(arg_16_0.strategyList, iter_16_4) then
			setActive = var_1_10009

			var_1_10009(iter_16_5:Find("selected"), true)

			table = var_1_10009
			var_1_10009 = var_1_10009.indexof(arg_16_0.strategyList, iter_16_4)
			setImageSprite = var_10

			local var_16_15 = iter_16_5
			local var_16_16 = iter_16_5.Find(var_16_15, "selected/counter")

			LoadSprite = var_16_15

			var_10(var_16_16, var_16_15("ui/cluebuffselectui_atlas", "buff_n_" .. var_1_10009), true)
		else
			setActive = var_1_10009

			var_1_10009(iter_16_5:Find("selected"), false)
		end
	end

	setActive = var_4

	var_4(arg_16_0.detailBtn, #arg_16_0.strategyList > 0)

	local var_16_17

	if arg_16_0.ptAwardTF then
		setActive = var_4
		var_16_17 = arg_16_0.ptAwardTF

		local var_16_18 = var_5.Find(var_16_17, "boost")

		var_16_17 = #arg_16_0.strategyList > 0

		var_4(var_16_18, var_16_17)

		setText = var_4
		var_16_17 = arg_16_0.ptAwardTF

		var_4(var_5.Find(var_16_17, "boost/boost"), "+" .. 5 * #arg_16_0.strategyList .. "%")
	end

	table = var_4

	local var_16_19 = var_4.concat
	local var_16_20 = {}

	unpack = var_16_17
	var_16_20[1] = var_16_17(arg_16_0.strategyList)

	local var_16_21 = var_16_19(var_16_20, "|")

	PlayerPrefs = var_16_20

	var_16_20.SetString(var_0_1.PLYAER_PREF_KEY .. arg_16_0.singleID, var_16_21)

	setText = var_5

	local var_16_22 = arg_16_0._tf

	var_5(var_6.Find(var_16_22, "Stage/text_stage_buff_count"), "(" .. #arg_16_0.strategyList .. "/" .. var_1.strategy_num .. ")")

	return
end

function var_0_1.UpdateCluePanel(arg_17_0)
	ActivityConst = var_1_10001

	local var_17_0 = var_1_10001.Valleyhospital_ACT_ID

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_17_1 = var_1_10002(var_1_10003)
	local var_17_2 = var_2.getRawData(var_17_1).id

	PlayerPrefs = var_17_1

	local var_17_3 = var_17_1.GetInt("investigatingGroupId_" .. var_17_0 .. "_" .. var_17_2, 0)
	local var_17_4 = true
	local var_17_5
	local var_17_6 = 0

	pg = var_7

	local var_17_7 = var_7.activity_clue

	if var_17_3 ~= 0 then
		var_1_10008 = var_17_7.get_id_list_by_group[var_17_3]
		var_17_5 = {
			var_17_7[var_1_10008[1]],
			var_17_7[var_1_10008[2]],
			var_17_7[var_1_10008[3]]
		}
		getProxy = var_9
		TaskProxy = var_10

		local var_17_8 = var_9(var_10)
		local var_17_9 = var_9.getTaskVO

		tonumber = var_1_10011

		local var_17_10 = var_17_9(var_17_8, var_1_10011(var_17_5[3].task_id))

		var_17_6 = var_9.getProgress(var_17_10)

		for iter_17_0 = 1, 3 do
			getProxy = var_1_10013
			TaskProxy = var_1_10014
			var_1_10014 = var_1_10013(var_1_10014)
			var_1_10013 = var_1_10013.getFinishTaskById
			tonumber = var_1_10015

			if not var_1_10013(var_1_10014, var_1_10015(var_17_5[iter_17_0].task_id)) then
				var_17_4 = false

				break
			end
		end
	end

	if var_17_4 then
		setText = var_1_10008

		local var_17_11 = arg_17_0.explore
		local var_17_12 = var_9.Find(var_17_11, "target/Text")

		i18n = var_17_11

		var_1_10008(var_17_12, var_17_11("clue_unselect_tip"))
	else
		setText = var_1_10008

		local var_17_13 = arg_17_0.explore
		local var_17_14 = var_9.Find(var_17_13, "target/Text")
		local var_17_15 = var_17_5[1].unlock_desc
		local var_17_16 = var_17_5[1].unlock_num
		local var_17_17 = "/"
		local var_17_18 = var_17_5[2].unlock_num
		local var_17_19 = "/"
		local var_17_20 = var_17_5[3].unlock_num

		i18n = var_1_10016

		var_1_10008(var_17_14, var_17_15 .. var_17_16 .. var_17_17 .. var_17_18 .. var_17_19 .. var_17_20 .. var_1_10016("clue_task_tip", var_17_6))
	end

	return
end

function var_0_1.updateDetailView(arg_18_0)
	pg = var_1_10001

	local var_18_0 = var_1_10001.activity_single_enemy[arg_18_0.singleID]
	local var_18_1 = {}

	ipairs = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10003(arg_18_0.strategyList) do
		table = var_1_10008

		var_1_10008.insert(var_18_1, iter_18_1)
	end

	ipairs = var_3

	for iter_18_2, iter_18_3 in var_3(arg_18_0.strategyList) do
		if iter_18_3 >= var_0_1.SP_STRA_MIN_RANGE and iter_18_3 <= var_0_1.SP_STRA_MAX_RANGE then
			table = var_8

			var_8.insert(var_18_1, var_0_1.SP_STRATEGY_ID)

			break
		end
	end

	pg = var_3

	local var_18_2 = var_3.strategy_data_template
	local var_18_3 = arg_18_0.detailList

	var_4.make(var_18_3, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = var_18_1[arg_19_1 + 1]
			local var_19_1 = var_18_2[var_19_0]

			GetImageSpriteFromAtlasAsync = var_2_10005

			var_2_10005("strategyicon/" .. var_19_1.icon, "", arg_19_2:Find("icon"))

			setText = var_2_10005

			var_2_10005(arg_19_2:Find("textBG/name"), var_19_1.name)

			setText = var_2_10005

			var_2_10005(arg_19_2:Find("textBG/desc"), var_19_1.desc)
		end

		return
	end)

	local var_18_4 = arg_18_0.detailList

	var_4.align(var_18_4, #var_18_1)

	return
end

function var_0_1.SetStageID(arg_20_0, arg_20_1)
	arg_20_0.singleID = arg_20_1
	pg = var_1_10002

	local var_20_0 = var_1_10002.activity_single_enemy[arg_20_0.singleID]

	pg = var_3

	local var_20_1 = var_3.strategy_data_template

	setText = var_1_10004

	var_1_10004(arg_20_0.stageName, var_20_0.name)

	setText = var_1_10004

	var_1_10004(arg_20_0.stageLV, var_20_0.level)

	setText = var_1_10004

	local var_20_2 = arg_20_0._tf
	local var_20_3 = var_5.Find(var_20_2, "Stage/text_stage_PTBoost")

	i18n = var_20_2

	var_1_10004(var_20_3, var_20_2("clue_buff_pt_boost", var_20_0.strategy_num))

	local var_20_4 = var_20_0.strategy_id

	ipairs = var_20_3

	for iter_20_0, iter_20_1 in var_20_3(var_20_4) do
		cloneTplTo = var_1_10010
		var_1_10010 = var_1_10010(arg_20_0.buffTmp, arg_20_0.buffContainer)
		setActive = var_11

		var_11(var_1_10010, true)

		local var_20_5 = var_20_1[iter_20_1]

		GetImageSpriteFromAtlasAsync = var_12

		var_12("strategyicon/" .. var_20_5.icon, "", var_1_10010:Find("icon"))

		setActive = var_12

		var_12(var_1_10010:Find("selected"), false)

		onButton = var_12

		var_12(arg_20_0, var_1_10010, function()
			local var_21_0 = arg_20_0

			var_0.onStrategyClick(var_21_0, iter_20_1)

			return
		end)

		arg_20_0.buffTFs[iter_20_1] = var_1_10010
	end

	setImageSprite = var_5

	local var_20_6 = arg_20_0._tf
	local var_20_7 = var_6.Find(var_20_6, "Stage/stage_icon")

	LoadSprite = var_20_6

	var_5(var_20_7, var_20_6("ui/cluebuffselectui_atlas", var_20_0.icon), true)

	local var_20_8 = var_20_0.type

	BossSingleVariableEnemyData = var_20_7

	if var_20_8 >= var_20_7.TYPE.SP then
		setActive = var_20_8

		local var_20_9 = arg_20_0._tf

		var_20_8(var_6.Find(var_20_9, "Stage/stage_type_icon"), false)

		setActive = var_20_8

		var_20_8(arg_20_0.ticket, true)

		setActive = var_20_8

		var_20_8(arg_20_0.ticketTips, true)

		GetImageSpriteFromAtlasAsync = var_20_8
		pg = var_6

		local var_20_10 = var_6.item_virtual_data_statistics[var_20_0.enter_cost].icon
		local var_20_11 = ""
		local var_20_12 = arg_20_0.ticket

		var_20_8(var_20_10, var_20_11, var_8.Find(var_20_12, "icon"), true)

		getProxy = var_20_8
		ActivityProxy = var_20_10

		local var_20_13 = var_20_8(var_20_10)

		var_20_8 = var_20_8.getActivityById
		ActivityConst = var_20_11
		var_20_8 = var_20_8(var_20_13, var_20_11.Valleyhospital_ACT_ID)
		setText = var_20_13

		local var_20_14 = arg_20_0.ticket

		var_20_13(var_7.Find(var_20_14, "count"), var_20_8.data1)
	else
		setActive = var_20_8

		local var_20_15 = arg_20_0._tf

		var_20_8(var_6.Find(var_20_15, "Stage/stage_type_icon"), true)

		setActive = var_20_8

		var_20_8(arg_20_0.ticket, false)

		setActive = var_20_8

		var_20_8(arg_20_0.ticketTips, false)

		setImageSprite = var_20_8

		local var_20_16 = arg_20_0._tf
		local var_20_17 = var_6.Find(var_20_16, "Stage/stage_type_icon")

		LoadSprite = var_20_16

		var_20_8(var_20_17, var_20_16("ui/cluebuffselectui_atlas", "tier_" .. var_20_0.type), true)

		arg_20_0.useTicket = false
		setActive = var_20_8

		var_20_8(arg_20_0.ticketCheckBox, arg_20_0.useTicket)

		var_20_8 = arg_20_0.contextData
		var_20_8.useTicket = arg_20_0.useTicket
	end

	pg = var_20_8

	local var_20_18 = var_20_8.expedition_data_template[var_20_0.expedition_id].award_display

	arg_20_0:updateAwards(var_20_18, arg_20_0.awards, arg_20_0.awardTpl)

	return
end

function var_0_1.UpdateTicket(arg_22_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_22_0 = var_1_10001(var_1_10002)
	local var_22_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	if var_22_1(var_22_0, var_1_10003.Valleyhospital_ACT_ID).data1 <= 0 then
		pg = var_2

		local var_22_2 = var_2.TipsMgr.GetInstance()
		local var_22_3 = var_2.ShowTips

		i18n = var_1_10004

		var_22_3(var_22_2, var_1_10004("clue_buff_empty_ticket"))
	else
		arg_22_0.useTicket = not arg_22_0.useTicket
		setActive = var_2

		var_2(arg_22_0.ticketCheckBox, arg_22_0.useTicket)

		arg_22_0.contextData.useTicket = arg_22_0.useTicket
	end

	return
end

function var_0_1.SetPreSelectedBuff(arg_23_0, arg_23_1)
	arg_23_0.preSelectedBuffList = {}
	ipairs = var_2

	for iter_23_0, iter_23_1 in var_2(arg_23_1) do
		table = var_1_10007

		var_1_10007.insert(arg_23_0.preSelectedBuffList, iter_23_1)
	end

	return
end

function var_0_1.onStrategyClick(arg_24_0, arg_24_1)
	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.strategyList) do
		if iter_24_1 == arg_24_1 then
			table = var_1_10007

			var_1_10007.remove(arg_24_0.strategyList, iter_24_0)

			table = var_1_10007

			var_1_10007.remove(arg_24_0.contextData.selectedBuffList, iter_24_0)
			arg_24_0:updateBuffView()

			return
		end
	end

	arg_24_0:selectBuff(arg_24_1)

	return
end

function var_0_1.selectBuff(arg_25_0, arg_25_1)
	pg = var_1_10002

	local var_25_0 = var_1_10002.activity_single_enemy[arg_25_0.singleID]
	local var_25_2

	if #arg_25_0.strategyList >= var_25_0.strategy_num then
		pg = var_25_2

		local var_25_1 = var_25_2.TipsMgr.GetInstance()

		var_25_2 = var_25_2.ShowTips
		i18n = var_1_10005

		var_25_2(var_25_1, var_1_10005("clue_buff_reach_max"))

		return
	end

	table = var_25_2

	var_25_2.insert(arg_25_0.strategyList, arg_25_1)

	table = var_3

	var_3.insert(arg_25_0.contextData.selectedBuffList, arg_25_1)
	arg_25_0:updateBuffView()

	return
end

function var_0_1.updateAwards(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	for iter_26_0 = 1, #arg_26_1 do
		cloneTplTo = var_1_10008
		var_1_10008 = var_1_10008(arg_26_3, arg_26_2)

		local var_26_0 = arg_26_1[iter_26_0]
		local var_26_1 = {
			type = var_26_0[1],
			id = var_26_0[2],
			count = var_26_0[3]
		}

		if var_26_0[2] == var_0_1.BOOST_ITEM_ID then
			arg_26_0.ptAwardTF = var_1_10008
		end

		updateDrop = var_11
		findTF = var_12

		var_11(var_12(var_1_10008, "mask"), var_26_1)

		onButton = var_11

		local var_26_2 = arg_26_0
		local var_26_3 = var_1_10008

		local function var_26_4()
			Item = var_2_10000

			local var_27_0 = var_2_10000.getConfigData(var_26_0[2])
			local var_27_1 = {
				[99] = true
			}

			if var_27_0 and var_27_1[var_27_0.type] then
				local var_27_2 = var_27_0.display_icon
				local var_27_3 = {}

				ipairs = var_2_10004

				for iter_27_0, iter_27_1 in var_2_10004(var_27_2) do
					local var_27_4 = iter_27_1[1]
					local var_27_5 = iter_27_1[2]

					var_27_3[#var_27_3 + 1] = {
						hideName = true,
						type = var_27_4,
						id = var_27_5
					}
				end

				local var_27_6 = arg_26_0

				var_2_10004.emit(var_27_6, var_0_1.ON_DROP_LIST, {
					item2Row = true,
					itemList = var_27_3,
					content = var_27_0.display
				})
			else
				local var_27_7 = arg_26_0
				local var_27_8 = var_2.emit

				BaseUI = var_2_10004

				var_27_8(var_27_7, var_2_10004.ON_DROP, var_26_1)
			end

			return
		end

		SFX_PANEL = var_1_10015

		var_11(var_26_2, var_26_3, var_26_4, var_1_10015)
	end

	return
end

function var_0_1.willExit(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_28_0, arg_28_0._tf, arg_28_0._parentTf)

	return
end

function var_0_1.onBackPressed(arg_29_0)
	isActive = var_1_10001

	if var_1_10001(arg_29_0.detailView) then
		arg_29_0:closeDetailView()
	else
		arg_29_0:closeView()
	end

	return
end

return var_0_1
