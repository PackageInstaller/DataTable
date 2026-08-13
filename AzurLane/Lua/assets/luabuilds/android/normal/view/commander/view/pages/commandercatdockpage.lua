class = var_0_10000

local var_0_0 = "CommanderCatDockPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.ON_SORT = "CommanderCatDockPage:ON_SORT"

function var_0_1.getUIName(arg_1_0)
	return "CommanderCatDockui"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_1, "LScrollRect")

	local var_2_2 = arg_2_0._tf

	arg_2_0.reserveBtn = var_1.Find(var_2_2, "box/reserve_btn")

	local var_2_3 = arg_2_0.reserveBtn
	local var_2_4 = var_1.Find(var_2_3, "Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.reserveTxt = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0.reserveBtn

	arg_2_0.reserveTip = var_1.Find(var_2_6, "free")

	local var_2_7 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_7, "box/home")

	local var_2_8 = arg_2_0.homeBtn
	local var_2_9 = var_1.Find(var_2_8, "Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.homeTxt = var_2_10(var_2_9, var_3(var_1_10004))

	local var_2_11 = arg_2_0.homeBtn

	arg_2_0.homeTip = var_1.Find(var_2_11, "tip")

	local var_2_12 = arg_2_0._tf

	arg_2_0.boxesBtn = var_1.Find(var_2_12, "box/boxes_btn")

	local var_2_13 = arg_2_0.boxesBtn
	local var_2_14 = var_1.Find(var_2_13, "Text")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.boxesTxt = var_2_15(var_2_14, var_3(var_1_10004))

	local var_2_16 = arg_2_0.boxesBtn

	arg_2_0.boxesTip = var_1.Find(var_2_16, "tip")

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "box/capcity/Text")
	local var_2_19 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.capacityTxt = var_2_19(var_2_18, var_3(var_1_10004))

	local var_2_20 = arg_2_0._tf

	arg_2_0.sortBtn = var_1.Find(var_2_20, "top/sort_btn")

	local var_2_21 = arg_2_0.sortBtn

	arg_2_0.sortIdTxt = var_1.Find(var_2_21, "id")

	local var_2_22 = arg_2_0.sortBtn

	arg_2_0.sortLvTxt = var_1.Find(var_2_22, "Level")

	local var_2_23 = arg_2_0.sortBtn

	arg_2_0.sortRarityTxt = var_1.Find(var_2_23, "Rarity")

	local var_2_24 = arg_2_0._tf

	arg_2_0.ascBtn = var_1.Find(var_2_24, "top/asc_btn")

	local var_2_25 = arg_2_0.ascBtn

	arg_2_0.ascTr = var_1.Find(var_2_25, "asc")

	local var_2_26 = arg_2_0.ascBtn

	arg_2_0.descTr = var_1.Find(var_2_26, "desc")

	local var_2_27 = arg_2_0._tf

	arg_2_0.selectedTr = var_1.Find(var_2_27, "bottom")

	local var_2_28 = arg_2_0._tf

	arg_2_0.btnsTr = var_1.Find(var_2_28, "box")

	local var_2_29 = arg_2_0._tf
	local var_2_30 = var_1.Find(var_2_29, "bottom/value/Text")
	local var_2_31 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.selectedNumTxt = var_2_31(var_2_30, var_3(var_1_10004))

	local var_2_32 = arg_2_0._tf

	arg_2_0.selectedBtn = var_1.Find(var_2_32, "bottom/select_btn")

	local var_2_33 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_33, "bottom/cancel_btn")
	CommanderReservePage = var_1
	arg_2_0.reservePanel = var_1.New(arg_2_0._tf.parent, arg_2_0.event, arg_2_0.contextData)
	CommanderBoxesPage = var_1
	arg_2_0.boxesPanel = var_1.New(arg_2_0._tf.parent, arg_2_0.event, arg_2_0.contextData)
	CommanderIndexPage = var_1
	arg_2_0.indexPanel = var_1.New(arg_2_0._tf, arg_2_0.event)
	CatterySettlementPage = var_1
	arg_2_0.catterySettlementPage = var_1.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_1.RegisterEvent(arg_3_0)
	arg_3_0:bind(var_0_1.ON_SORT, function(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.OnSort(var_4_0)

		return
	end)

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bind

	CommanderCatScene = var_3

	var_3_1(var_3_0, var_3.EVENT_NEXT_ONE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0

		var_2.OnNextOn(var_5_0, arg_5_1, 1)

		return
	end)

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.bind

	CommanderCatScene = var_3

	var_3_3(var_3_2, var_3.EVENT_PREV_ONE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_3_0

		var_2.OnNextOn(var_6_0, arg_6_1, -1)

		return
	end)

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.bind

	CommanderCatScene = var_3

	var_3_5(var_3_4, var_3.MSG_UPDATE, function(arg_7_0)
		local var_7_0 = arg_3_0

		var_1.UpdateCommanders(var_7_0, true)

		local var_7_1 = arg_3_0

		var_1.UpdateCapacity(var_7_1)

		return
	end)

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.bind

	CommanderCatScene = var_3

	var_3_7(var_3_6, var_3.MSG_HOME_TIP, function(arg_8_0)
		local var_8_0 = arg_3_0

		var_1.UpdateHome(var_8_0)

		return
	end)

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.bind

	CommanderCatScene = var_3

	var_3_9(var_3_8, var_3.MSG_BUILD, function()
		local var_9_0 = arg_3_0

		var_0.UpdateBoxes(var_9_0)

		return
	end)

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.bind

	CommanderCatScene = var_3

	var_3_11(var_3_10, var_3.MSG_RESERVE_BOX, function()
		local var_10_0 = arg_3_0

		var_0.UpdateReserve(var_10_0)

		return
	end)

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.bind

	CommanderCatScene = var_3

	var_3_13(var_3_12, var_3.EVENT_FOLD, function(arg_11_0, arg_11_1)
		if arg_11_1 then
			LeanTween = var_2_10002
			var_2_10002 = var_2_10002.moveX
			rtf = var_2_10003

			var_2_10002(var_2_10003(arg_3_0._tf), 1000, 0.5)
		else
			LeanTween = var_2_10002

			local var_11_0 = var_2_10002.moveX

			rtf = var_2_10003

			var_11_0(var_2_10003(arg_3_0._tf), -423, 0.5)
		end

		return
	end)

	return
end

function var_0_1.OnNextOn(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = 0

	ipairs = var_1_10004

	for iter_12_0, iter_12_1 in var_1_10004(arg_12_0.displays) do
		if iter_12_1.id == arg_12_1 then
			var_12_0 = iter_12_0

			break
		end
	end

	if var_12_0 + arg_12_2 <= 0 or var_4 > #arg_12_0.displays then
		return
	end

	local var_12_1 = false
	local var_12_2 = arg_12_0.displays[var_4]

	pairs = iter_12_0

	for iter_12_2, iter_12_3 in iter_12_0(arg_12_0.cards) do
		if iter_12_3.commanderVO and iter_12_3.commanderVO.id == var_12_2.id then
			var_12_1 = true
			triggerButton = var_12

			var_12(iter_12_3.infoTF)

			break
		end
	end

	if not var_12_1 then
		local var_12_3 = arg_12_0
		local var_12_4 = arg_12_0.emit

		CommanderCatScene = var_9

		var_12_4(var_12_3, var_9.EVENT_SELECTED, var_12_2)
	end

	return
end

function var_0_1.OnSort(arg_13_0)
	local var_13_0 = arg_13_0.sortData.asc

	arg_13_0.sortData = arg_13_0.indexPanel.data
	arg_13_0.sortData.asc = var_13_0

	arg_13_0:UpdateSortTxt()
	arg_13_0:UpdateCommanders(false)

	setActive = var_2

	var_2(arg_13_0.ascTr, arg_13_0.sortData.asc)

	setActive = var_2

	var_2(arg_13_0.descTr, not arg_13_0.sortData.asc)

	return
end

function var_0_1.UpdateSortTxt(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.sortIdTxt, arg_14_0.sortData.sortData == "id")

	setActive = var_1_10001

	var_1_10001(arg_14_0.sortLvTxt, arg_14_0.sortData.sortData == "Level")

	setActive = var_1_10001

	var_1_10001(arg_14_0.sortRarityTxt, arg_14_0.sortData.sortData == "Rarity")

	return
end

function var_0_1.OnInit(arg_15_0)
	local var_15_0

	if not arg_15_0.contextData.onCommander then
		function var_15_0(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
			return true
		end
	end

	arg_15_0.onCommander = var_15_0

	local var_15_1

	if not arg_15_0.contextData.onSelected then
		function var_15_1(arg_17_0, arg_17_1)
			arg_17_1()

			return
		end
	end

	arg_15_0.onSelected = var_15_1

	local var_15_2

	if not arg_15_0.contextData.onQuit then
		function var_15_2(arg_18_0)
			return
		end
	end

	arg_15_0.onQuit = var_15_2

	arg_15_0:RegisterEvent()

	local var_15_3

	if not arg_15_0.contextData.sortData then
		var_15_3 = {
			asc = false,
			sortData = "Level",
			nationData = {},
			rarityData = {}
		}
	end

	arg_15_0.sortData = var_15_3

	function arg_15_0.scrollRect.onInitItem(arg_19_0)
		local var_19_0 = arg_15_0

		var_1.OnInitItem(var_19_0, arg_19_0)

		return
	end

	local var_15_4 = arg_15_0.scrollRect

	function var_15_4.onUpdateItem(arg_20_0, arg_20_1)
		local var_20_0 = arg_15_0

		var_2.OnUpdateItem(var_20_0, arg_20_0, arg_20_1)

		return
	end

	onButton = var_15_4

	local var_15_5 = arg_15_0
	local var_15_6 = arg_15_0.reserveBtn

	local function var_15_7()
		local var_21_0 = arg_15_0.reservePanel

		var_0.ExecuteAction(var_21_0, "Update")

		return
	end

	SFX_PANEL = var_1_10005

	var_15_4(var_15_5, var_15_6, var_15_7, var_1_10005)

	onButton = var_15_4

	local var_15_8 = arg_15_0
	local var_15_9 = arg_15_0.boxesBtn

	local function var_15_10()
		local var_22_0 = arg_15_0.boxesPanel

		var_0.ExecuteAction(var_22_0, "Update")

		return
	end

	SFX_PANEL = var_1_10005

	var_15_4(var_15_8, var_15_9, var_15_10, var_1_10005)

	onButton = var_15_4

	local var_15_11 = arg_15_0
	local var_15_12 = arg_15_0.ascBtn

	local function var_15_13()
		local var_23_0 = arg_15_0.sortData

		var_23_0.asc = not arg_15_0.sortData.asc
		setActive = var_23_0

		var_23_0(arg_15_0.ascTr, arg_15_0.sortData.asc)

		setActive = var_23_0

		var_23_0(arg_15_0.descTr, not arg_15_0.sortData.asc)

		local var_23_1 = arg_15_0

		var_0.UpdateCommanders(var_23_1, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_15_4(var_15_11, var_15_12, var_15_13, var_1_10005)

	setActive = var_15_4

	var_15_4(arg_15_0.ascTr, arg_15_0.sortData.asc)

	setActive = var_15_4

	var_15_4(arg_15_0.descTr, not arg_15_0.sortData.asc)

	onButton = var_15_4

	local var_15_14 = arg_15_0
	local var_15_15 = arg_15_0.sortBtn

	local function var_15_16()
		local var_24_0 = arg_15_0.indexPanel

		var_0.ExecuteAction(var_24_0, "Show", arg_15_0.sortData)

		return
	end

	SFX_PANEL = var_1_10005

	var_15_4(var_15_14, var_15_15, var_15_16, var_1_10005)

	onButton = var_15_4

	local var_15_17 = arg_15_0
	local var_15_18 = arg_15_0.selectedBtn

	local function var_15_19()
		local var_25_0

		if not arg_15_0.contextData.minCount then
			var_25_0 = 1
		end

		if #arg_15_0.selectedList < var_25_0 then
			pg = var_1

			local var_25_1 = var_1.TipsMgr.GetInstance()
			local var_25_2 = var_1.ShowTips

			i18n = var_2_10003

			var_25_2(var_25_1, var_2_10003("commander_select_min_cnt", var_25_0))

			return
		end

		arg_15_0.onSelected(arg_15_0.selectedList, function()
			local var_26_0 = arg_15_0
			local var_26_1 = var_0.emit

			CommanderCatScene = var_3_10002

			var_26_1(var_26_0, var_3_10002.EVENT_BACK)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10005

	var_15_4(var_15_17, var_15_18, var_15_19, var_1_10005)

	onButton = var_15_4

	local var_15_20 = arg_15_0
	local var_15_21 = arg_15_0.cancelBtn

	local function var_15_22()
		local var_27_0 = arg_15_0
		local var_27_1 = var_0.emit

		CommanderCatScene = var_2_10002

		var_27_1(var_27_0, var_2_10002.EVENT_BACK)

		return
	end

	SFX_PANEL = var_1_10005

	var_15_4(var_15_20, var_15_21, var_15_22, var_1_10005)

	LOCK_CATTERY = var_15_4

	if not var_15_4 then
		onButton = var_15_4

		local var_15_23 = arg_15_0
		local var_15_24 = arg_15_0.homeBtn

		local function var_15_25()
			local var_28_0 = arg_15_0
			local var_28_1 = var_0.emit

			CommanderCatMediator = var_2_10002

			var_28_1(var_28_0, var_2_10002.OPEN_HOME)

			return
		end

		SFX_PANEL = var_1_10005

		var_15_4(var_15_23, var_15_24, var_15_25, var_1_10005)
	else
		setActive = var_15_4

		var_15_4(arg_15_0.homeBtn, false)
	end

	arg_15_0:Flush()

	return
end

function var_0_1.Flush(arg_29_0)
	arg_29_0.cards = {}

	local var_29_0

	if not arg_29_0.contextData.selectedIds then
		var_29_0 = {}
	end

	arg_29_0.selectedList = var_29_0
	arg_29_0.previewCommander = arg_29_0.contextData.activeCommander

	local var_29_1

	if arg_29_0.previewCommander then
		var_29_1 = arg_29_0.previewCommander.id
	end

	arg_29_0.previewCommanderId = var_29_1

	local var_29_2

	if not arg_29_0.previewCommanderId then
		var_29_2 = arg_29_0.contextData.selectedId
	end

	arg_29_0.selectedId = var_29_2

	arg_29_0:UpdateCommanders(true)
	arg_29_0:UpdateBoxes()
	arg_29_0:UpdateReserve()
	arg_29_0:UpdateCapacity()
	arg_29_0:UpdateHome()
	arg_29_0:TryPlayStory()
	arg_29_0:DisplayCatterySettlement()
	arg_29_0:UpdateStyle()
	arg_29_0:UpdateSortTxt()

	return
end

function var_0_1.Show(arg_30_0)
	setActive = var_1_10001

	var_1_10001(arg_30_0._tf, true)

	CommanderCatUtil = var_1_10001

	var_1_10001.SetActive(arg_30_0._tf, true)

	return
end

function var_0_1.Hide(arg_31_0)
	CommanderCatUtil = var_1_10001

	var_1_10001.SetActive(arg_31_0._tf, false)

	return
end

function var_0_1.UpdateStyle(arg_32_0)
	setActive = var_1_10001

	local var_32_0 = arg_32_0.selectedTr
	local var_32_1 = arg_32_0.contextData.mode

	CommanderCatScene = var_1_10004

	var_1_10001(var_32_0, var_32_1 == var_1_10004.MODE_SELECT)

	setActive = var_1_10001

	local var_32_2 = arg_32_0.btnsTr
	local var_32_3 = arg_32_0.contextData.mode

	CommanderCatScene = var_4

	var_1_10001(var_32_2, var_32_3 == var_4.MODE_VIEW)

	local var_32_4 = arg_32_0.contextData.mode

	CommanderCatScene = var_32_2

	if var_32_4 == var_32_2.MODE_SELECT then
		arg_32_0:UpdateSelectedTxt()
	end

	return
end

function var_0_1.TryPlayStory(arg_33_0)
	if arg_33_0.contextData.fromMain then
		pg = var_1

		local var_33_0 = var_1.SystemGuideMgr.GetInstance()

		var_1.PlayCommander(var_33_0)
	end

	return
end

function var_0_1.DisplayCatterySettlement(arg_34_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10002

	local var_34_0 = var_1_10001(var_1_10002)
	local var_34_1 = var_1.GetCommanderHome(var_34_0)
	local var_34_2 = arg_34_0.contextData.fromMediatorName

	NewMainMediator = var_1_10003

	local var_34_3 = var_34_2 == var_1_10003.__cname

	pg = var_3

	local var_34_4 = var_3.NewStoryMgr.GetInstance()
	local var_34_5

	if not var_3.IsRunning(var_34_4) then
		pg = var_34_5
		var_34_4 = var_34_5.NewGuideMgr.GetInstance()
		var_34_5 = var_34_5.IsBusy(var_34_4)
	end

	if var_34_1 and var_34_1:ShouldSettleCattery() and var_34_3 and not var_34_5 then
		Clone = var_34_4
		var_34_4 = var_34_4(var_34_1)
		var_1_10006 = arg_34_0.catterySettlementPage

		var_5.ExecuteAction(var_1_10006, "Show", var_34_4)
	end

	pg = var_34_4

	local var_34_6 = var_34_4.m02
	local var_34_7 = var_4.sendNotification

	GAME = var_1_10006

	var_34_7(var_34_6, var_1_10006.OPEN_OR_CLOSE_CATTERY, {
		open = true
	})

	return
end

function var_0_1.UpdateHome(arg_35_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10002

	local var_35_0 = var_1_10001(var_1_10002)

	setActive = var_1_10002

	local var_35_1 = arg_35_0.homeTip
	local var_35_2

	if not var_35_0:AnyCatteryExistOP() then
		var_35_2 = var_35_0:AnyCatteryCanUse()
	end

	var_1_10002(var_35_1, var_35_2)

	local var_35_3 = var_35_0:GetCommanderHome()
	local var_35_4 = ""

	if var_35_3 then
		var_35_4 = var_35_3:GetExistCommanderCattertCnt() .. "/" .. var_35_3:GetMaxCatteryCnt()
	end

	arg_35_0.homeTxt.text = var_35_4

	return
end

function var_0_1.UpdateCapacity(arg_36_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_36_0 = var_1_10001(var_1_10002)
	local var_36_1 = var_1.getRawData(var_36_0)

	table = var_36_0

	local var_36_2 = var_36_0.getCount

	getProxy = var_1_10003
	CommanderProxy = var_1_10004

	local var_36_3 = var_1_10003(var_1_10004)
	local var_36_4 = var_36_2(var_3.getRawData(var_36_3))

	arg_36_0.capacityTxt.text = var_36_4 .. "/" .. var_36_1.commanderBagMax

	return
end

function var_0_1.UpdateReserve(arg_37_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10002

	local var_37_0 = var_1_10001(var_1_10002)
	local var_37_1 = var_1.getBoxUseCnt(var_37_0)
	local var_37_2 = arg_37_0.reserveTxt

	CommanderConst = var_1_10004

	local var_37_3 = var_1_10004.MAX_GETBOX_CNT - var_37_1
	local var_37_4 = "/"

	CommanderConst = var_1_10006
	var_37_2.text = var_37_3 .. var_37_4 .. var_1_10006.MAX_GETBOX_CNT
	setActive = var_37_2

	var_37_2(arg_37_0.reserveTip, var_37_1 == 0)

	return
end

function var_0_1.UpdateBoxes(arg_38_0)
	getProxy = var_1_10001
	CommanderProxy = var_1_10002

	local var_38_0 = var_1_10001(var_1_10002)
	local var_38_1 = var_1.getBoxes(var_38_0)

	_ = var_38_0

	local var_38_2 = var_38_0.select(var_38_1, function(arg_39_0)
		local var_39_0 = arg_39_0
		local var_39_1 = arg_39_0.getState(var_39_0)

		CommanderBox = var_39_0

		return var_39_1 == var_39_0.STATE_FINISHED
	end)
	local var_38_3 = arg_38_0.boxesTxt

	var_38_3.text = #var_38_2 .. "/" .. #var_38_1
	setActive = var_38_3

	local var_38_4 = arg_38_0.boxesTip

	getProxy = var_5
	CommanderProxy = var_6

	local var_38_5 = var_5(var_6)

	var_38_3(var_38_4, var_5.ShouldTipBox(var_38_5))

	return
end

function var_0_1.OnInitItem(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0
	local var_40_1 = arg_40_0.NewCard(var_40_0, arg_40_1)

	onButton = var_40_0

	local var_40_2 = arg_40_0
	local var_40_3 = var_40_1.infoTF

	local function var_40_4()
		if not var_40_1.commanderVO then
			return
		end

		local var_41_0 = arg_40_0.contextData.mode

		CommanderCatScene = var_2_10001

		if var_41_0 == var_2_10001.MODE_SELECT then
			local var_41_1 = #arg_40_0.selectedList
			local var_41_2 = arg_40_0

			var_1.OnCheckBefore(var_41_2, var_40_1.commanderVO)

			local var_41_3 = arg_40_0

			var_1.Check(var_41_3, var_40_1.commanderVO)

			local var_41_4 = arg_40_0

			var_1.OnCheckAfter(var_41_4, var_40_1.commanderVO, var_41_1 > #arg_40_0.selectedList)
		else
			local var_41_5 = arg_40_0

			var_41_5.selectedList = {}
			pairs = var_41_5

			for iter_41_0, iter_41_1 in var_41_5(arg_40_0.cards) do
				iter_41_1:UpdateSelected(arg_40_0.selectedList)
			end

			table = var_0

			var_0.insert(arg_40_0.selectedList, var_40_1.commanderVO.id)

			local var_41_6 = var_40_1
			local var_41_7 = var_0.UpdateSelected
			local var_41_8 = arg_40_0.selectedList

			defaultValue = iter_41_0

			var_41_7(var_41_6, var_41_8, not iter_41_0(arg_40_0.sortData.displayCustomName, true))

			arg_40_0.selectedId = var_40_1.commanderVO.id

			local var_41_9 = arg_40_0
			local var_41_10 = var_0.emit

			CommanderCatScene = var_41_8

			var_41_10(var_41_9, var_41_8.EVENT_SELECTED, var_40_1.commanderVO, true)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_40_0(var_40_2, var_40_3, var_40_4, var_1_10007)

	onButton = var_40_0

	local var_40_5 = arg_40_0
	local var_40_6 = var_40_1.quitTF

	local function var_40_7()
		if not var_40_1.commanderVO then
			return
		end

		if var_40_1.commanderVO.id == 0 then
			arg_40_0.onQuit(function()
				local var_43_0 = arg_40_0
				local var_43_1 = var_0.emit

				CommanderCatScene = var_3_10002

				var_43_1(var_43_0, var_3_10002.EVENT_BACK)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_40_0(var_40_5, var_40_6, var_40_7, var_1_10007)

	arg_40_0.cards[arg_40_1] = var_40_1

	return
end

function var_0_1.OnCheckBefore(arg_44_0, arg_44_1)
	if arg_44_0.previewCommander and arg_44_0.contextData.maxCount > 1 then
		local var_44_0 = arg_44_0
		local var_44_1 = arg_44_0.emit

		CommanderCatScene = var_1_10004

		var_44_1(var_44_0, var_1_10004.EVENT_SELECTED, arg_44_0.previewCommander, true)
	else
		local var_44_2 = arg_44_0
		local var_44_3 = arg_44_0.emit

		CommanderCatScene = var_1_10004

		var_44_3(var_44_2, var_1_10004.EVENT_SELECTED, arg_44_1, true)

		if arg_44_0.previewCommander then
			local var_44_4 = arg_44_0
			local var_44_5 = arg_44_0.emit

			CommanderCatScene = var_4

			var_44_5(var_44_4, var_4.EVENT_PREVIEW_ADDITION, arg_44_0.previewCommander, true)
		else
			local var_44_6 = arg_44_0
			local var_44_7 = arg_44_0.emit

			CommanderCatScene = var_4

			var_44_7(var_44_6, var_4.EVENT_PREVIEW_ADDITION, arg_44_1, true)
		end
	end

	return
end

function var_0_1.OnCheckAfter(arg_45_0, arg_45_1, arg_45_2)
	if arg_45_0.previewCommander and arg_45_0.contextData.maxCount > 1 then
		local var_45_0 = arg_45_0
		local var_45_1 = arg_45_0.emit

		CommanderCatScene = var_1_10005

		var_45_1(var_45_0, var_1_10005.EVENT_PREVIEW_PLAY, arg_45_0.selectedList, arg_45_2)
	end

	return
end

function var_0_1.Check(arg_46_0, arg_46_1)
	local var_46_0

	if not arg_46_0.contextData.maxCount then
		table = var_46_0
		var_46_0 = var_46_0.getCount(arg_46_0.commanderList)
	end

	table = var_1_10003

	if var_1_10003.contains(arg_46_0.selectedList, arg_46_1.id) and var_46_0 == 1 then
		arg_46_0:UpdateSelected()

		return
	else
		table = var_3

		if var_3.contains(arg_46_0.selectedList, arg_46_1.id) then
			table = var_3

			local var_46_1 = var_3.indexof(arg_46_0.selectedList, arg_46_1.id)

			table = var_4

			var_4.remove(arg_46_0.selectedList, var_46_1)
			arg_46_0:UpdateSelected()

			return
		end
	end

	local function var_46_2()
		ipairs = var_2_10000

		for iter_47_0, iter_47_1 in var_2_10000(arg_46_0.selectedList) do
			if iter_47_1 == arg_46_1.id then
				table = var_5

				var_5.remove(arg_46_0.selectedList, iter_47_0)

				break
			end
		end

		return
	end

	local var_46_3, var_46_4 = arg_46_0.onCommander(arg_46_1, function()
		var_46_2()

		local var_48_0 = arg_46_0

		var_0.UpdateSelected(var_48_0)

		return
	end, function()
		var_46_2()

		local var_49_0 = arg_46_0

		var_0.UpdateCommanders(var_49_0, true)

		ipairs = var_0

		local var_49_1

		if not arg_46_0.commanderList then
			var_49_1 = {}
		end

		for iter_49_0, iter_49_1 in var_0(var_49_1) do
			if iter_49_1.id == arg_46_1.id then
				local var_49_2 = arg_46_0

				var_5.Check(var_49_2, iter_49_1)
			end
		end

		local var_49_3 = arg_46_0

		var_0.UpdateSelected(var_49_3)

		return
	end, arg_46_0)

	if not var_46_3 then
		if var_46_4 then
			pg = var_46_7

			local var_46_5 = var_46_7.TipsMgr.GetInstance()

			var_46_7.ShowTips(var_46_5, var_46_4)
		end

		return
	end

	local var_46_7

	if var_46_0 == 1 then
		table = var_46_7

		var_46_7.remove(arg_46_0.selectedList, #arg_46_0.selectedList)
	elseif var_46_0 <= #arg_46_0.selectedList then
		pg = var_46_7

		local var_46_6 = var_46_7.TipsMgr.GetInstance()

		var_46_7 = var_46_7.ShowTips
		i18n = var_8

		var_46_7(var_46_6, var_8("commander_select_max"))
		arg_46_0:UpdateSelected()

		return
	end

	table = var_46_7

	var_46_7.insert(arg_46_0.selectedList, arg_46_1.id)
	arg_46_0:UpdateSelected()

	return
end

function var_0_1.UpdateSelected(arg_50_0)
	pairs = var_1_10001

	for iter_50_0, iter_50_1 in var_1_10001(arg_50_0.cards) do
		iter_50_1:UpdateSelected(arg_50_0.selectedList)
	end

	arg_50_0:UpdateSelectedTxt()

	return
end

function var_0_1.UpdateSelectedTxt(arg_51_0)
	local var_51_0

	if not arg_51_0.contextData.maxCount then
		table = var_51_0
		var_51_0 = var_51_0.getCount(arg_51_0.commanderList)
	end

	arg_51_0.selectedNumTxt.text = #arg_51_0.selectedList .. "/" .. var_51_0

	return
end

function var_0_1.NewCard(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_0.contextData.mode

	CommanderCatScene = var_1_10003

	if var_52_0 == var_1_10003.MODE_VIEW or arg_52_0.contextData.maxCount == 1 then
		CommanderCatCard = var_52_0
		var_52_0 = var_52_0.New

		local var_52_1 = arg_52_1

		CommanderCatCard = var_1_10004

		return var_52_0(var_52_1, var_1_10004.MARK_TYPE_CIRCLE)
	else
		CommanderCatCard = var_52_0

		local var_52_2 = var_52_0.New
		local var_52_3 = arg_52_1

		CommanderCatCard = var_1_10004

		return var_52_2(var_52_3, var_1_10004.MARK_TYPE_TICK)
	end

	return
end

function var_0_1.OnUpdateItem(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0

	if not arg_53_0.cards[arg_53_2] then
		var_53_0 = arg_53_0:NewCard(arg_53_2)
		arg_53_0.cards[arg_53_2] = var_53_0
	end

	local var_53_1 = arg_53_0.displays[arg_53_1 + 1]
	local var_53_2 = var_53_0
	local var_53_3 = var_53_0.Update
	local var_53_4 = var_53_1
	local var_53_5 = arg_53_0.selectedList

	defaultValue = var_1_10009

	var_53_3(var_53_2, var_53_4, var_53_5, not var_1_10009(arg_53_0.sortData.displayCustomName, true))

	if var_53_1 and arg_53_0.selectedId and arg_53_0.selectedId == var_53_1.id and arg_53_0.shouldTrigger then
		arg_53_0.shouldTrigger = false
		triggerButton = var_5

		var_5(var_53_0.infoTF)
	end

	return
end

local function var_0_2(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = false
	local var_54_1 = false
	local var_54_2 = arg_54_0
	local var_54_3 = arg_54_0.getConfig(var_54_2, "nationality")

	table = var_54_2

	if var_54_2.getCount(arg_54_1) ~= 0 and not arg_54_1[var_54_3] then
		CommanderIndexPage = var_6

		if arg_54_1[var_6.NATION_OTHER] then
			CommanderIndexPage = var_6

			if var_6.IsOtherNation(var_54_3) then
				var_54_0 = true
			end
		end

		table = var_6

		if var_6.getCount(arg_54_2) == 0 or arg_54_2[arg_54_0:getRarity()] then
			var_54_1 = true
		end

		return var_54_0 and var_54_1
	end
end

local function var_0_3(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4)
	local function var_55_0()
		if arg_55_3 == "id" then
			local var_56_0

			if not arg_55_2 or not {
				arg_55_0.id < arg_55_1.id
			} then
				var_56_0 = {
					arg_55_0.id > arg_55_1.id
				}
			end

			return var_56_0[1]
		elseif arg_55_0["get" .. arg_55_3](arg_55_0) == arg_55_1["get" .. arg_55_3](arg_55_1) then
			local var_56_1

			if not arg_55_2 or not {
				arg_55_0.configId < arg_55_1.configId
			} then
				var_56_1 = {
					arg_55_0.configId > arg_55_1.configId
				}
			end

			return var_56_1[1]
		else
			local var_56_2

			if not arg_55_2 or not {
				var_0 < var_1
			} then
				var_56_2 = {
					var_1 < var_0
				}
			end

			return var_56_2[1]
		end

		return
	end

	local function var_55_1()
		if (arg_55_4 == arg_55_0.id and 1 or 0) == (arg_55_4 == arg_55_1.id and 1 or 0) then
			return var_55_0()
		else
			return var_1 < var_0
		end

		return
	end

	if (arg_55_0.inFleet and 1 or 0) == (arg_55_1.inFleet and 1 or 0) then
		return var_55_1()
	else
		return var_8 < var_7
	end

	return
end

function var_0_1.UpdateCommanders(arg_58_0, arg_58_1)
	if arg_58_1 or not arg_58_0.commanderList then
		CommanderCatUtil = var_1_10003

		local var_58_0

		if not var_1_10003.GetCommanderList(arg_58_0.contextData) then
			var_58_0 = arg_58_0.commanderList
		end

		arg_58_0.shouldTrigger = true
		arg_58_0.displays = {}

		local var_58_1 = {}
		local var_58_2 = {}

		pairs = var_1_10006

		local var_58_3

		if not arg_58_0.sortData.nationData then
			var_58_3 = {}
		end

		for iter_58_0, iter_58_1 in var_1_10006(var_58_3) do
			var_58_1[iter_58_1] = true
		end

		ipairs = var_6

		local var_58_4

		if not arg_58_0.sortData.rarityData then
			var_58_4 = {}
		end

		for iter_58_2, iter_58_3 in var_6(var_58_4) do
			var_58_2[iter_58_3] = true
		end

		pairs = var_6

		for iter_58_4, iter_58_5 in var_6(var_58_0) do
			if var_0_2(iter_58_5, var_58_1, var_58_2) then
				table = var_11

				var_11.insert(arg_58_0.displays, iter_58_5)
			end
		end

		table = var_6

		var_6.sort(arg_58_0.displays, function(arg_59_0, arg_59_1)
			return var_0_3(arg_59_0, arg_59_1, arg_58_0.sortData.asc, arg_58_0.sortData.sortData, arg_58_0.previewCommanderId)
		end)

		if not arg_58_0.selectedId and #arg_58_0.displays > 0 then
			arg_58_0.selectedId = arg_58_0.displays[1].id
		elseif #arg_58_0.displays > 0 then
			_ = var_6

			if var_6.all(arg_58_0.displays, function(arg_60_0)
				return arg_60_0.id ~= arg_58_0.selectedId
			end) and arg_58_0.previewCommander then
				arg_58_0:OnCheckBefore(arg_58_0.previewCommander)
				arg_58_0:OnCheckAfter(arg_58_0.previewCommander)
			end
		end

		if arg_58_0.previewCommanderId and arg_58_0.contextData.maxCount == 1 then
			table = var_6

			var_6.insert(arg_58_0.displays, 1, {
				id = 0
			})
		end

		local var_58_5, var_58_6 = arg_58_0:FillList()
		local var_58_7 = arg_58_0.scrollRect

		var_8.SetTotalCount(var_58_7, var_58_5, var_58_6)

		arg_58_0.commanderList = var_58_0

		return
	end
end

function var_0_1.FillList(arg_61_0)
	local var_61_0 = arg_61_0.contextData.mode

	CommanderCatScene = var_1_10002

	local var_61_3

	if var_61_0 == var_1_10002.MODE_VIEW then
		local var_61_1 = #arg_61_0.displays % 4
		local var_61_2

		if not (0 < var_61_1) or not (4 - #arg_61_0.displays % 4) then
			var_61_2 = 0
		end

		var_61_3 = #arg_61_0.displays + var_61_2

		local var_61_4
		local var_61_5

		if arg_61_0.selectedId then
			var_61_5 = 0
			ipairs = var_1_10005

			for iter_61_0, iter_61_1 in var_1_10005(arg_61_0.displays) do
				if iter_61_1.id == arg_61_0.selectedId then
					var_61_5 = iter_61_0

					break
				end
			end

			math = var_5
			var_61_4 = var_5.floor(var_61_5 / 4) / (#arg_61_0.displays / 4)
		end

		math = var_61_5

		local var_61_6 = var_61_5.max(12, var_61_3)
		local var_61_7

		if not var_61_4 and not arg_61_0.contextData.scrollValue then
			var_61_7 = 0
		end

		return var_61_6, var_61_7
	else
		local var_61_8 = arg_61_0.contextData.mode

		CommanderCatScene = var_61_3

		if var_61_8 == var_61_3.MODE_SELECT then
			local var_61_9 = #arg_61_0.displays
			local var_61_10

			if not arg_61_0.contextData.scrollValue then
				var_61_10 = 0
			end

			return var_61_9, var_61_10
		end
	end

	return
end

function var_0_1.CanBack(arg_62_0)
	if arg_62_0.boxesPanel then
		local var_62_0 = arg_62_0.boxesPanel

		if var_1.GetLoaded(var_62_0) and arg_62_0.boxesPanel.CanBack then
			local var_62_1 = arg_62_0.boxesPanel

			if not var_1.CanBack(var_62_1) then
				return false
			end
		end
	end

	if arg_62_0.reservePanel then
		local var_62_2 = arg_62_0.reservePanel

		if var_1.GetLoaded(var_62_2) then
			local var_62_3 = arg_62_0.reservePanel

			if var_1.isShowing(var_62_3) then
				local var_62_4 = arg_62_0.reservePanel

				var_1.Hide(var_62_4)

				return false
			end
		end
	end

	if arg_62_0.boxesPanel then
		local var_62_5 = arg_62_0.boxesPanel

		if var_1.GetLoaded(var_62_5) then
			local var_62_6 = arg_62_0.boxesPanel

			if var_1.isShowing(var_62_6) then
				local var_62_7 = arg_62_0.boxesPanel

				var_1.Hide(var_62_7)

				return false
			end
		end
	end

	if arg_62_0.indexPanel then
		local var_62_8 = arg_62_0.indexPanel

		if var_1.GetLoaded(var_62_8) then
			local var_62_9 = arg_62_0.indexPanel

			if var_1.isShowing(var_62_9) then
				local var_62_10 = arg_62_0.indexPanel

				var_1.Hide(var_62_10)

				return false
			end
		end
	end

	return true
end

function var_0_1.OnDestroy(arg_63_0)
	pairs = var_1_10001

	for iter_63_0, iter_63_1 in var_1_10001(arg_63_0.cards) do
		iter_63_1:Dispose()
	end

	local var_63_0

	if arg_63_0.reservePanel then
		var_63_0 = arg_63_0.reservePanel

		var_1.Destroy(var_63_0)

		arg_63_0.reservePanel = nil
	end

	if arg_63_0.boxesPanel then
		var_63_0 = arg_63_0.boxesPanel

		var_1.Destroy(var_63_0)

		arg_63_0.boxesPanel = nil
	end

	if arg_63_0.indexPanel then
		var_63_0 = arg_63_0.indexPanel

		var_1.Destroy(var_63_0)

		arg_63_0.indexPanel = nil
	end

	if arg_63_0.catterySettlementPage then
		var_63_0 = arg_63_0.catterySettlementPage

		var_1.Destroy(var_63_0)

		arg_63_0.catterySettlementPage = nil
	end

	local var_63_1 = arg_63_0.contextData

	math = var_63_0
	var_63_1.scrollValue = var_63_0.min(arg_63_0.scrollRect.value, 1)

	return
end

return var_0_1
