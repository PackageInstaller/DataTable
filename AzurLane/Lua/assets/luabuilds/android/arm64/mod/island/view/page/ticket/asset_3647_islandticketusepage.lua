class = var_0_10000

local var_0_0 = "IslandTicketUsePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandTicketUseUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "window/time_panel")

	setText = var_1_10002

	local var_2_2 = var_2_1:Find("left/Text")

	i18n = var_1_10005

	var_1_10002(var_2_2, var_1_10005("island_ticket_remain_time"))

	arg_2_0.remainTimeTF = var_2_1:Find("left/time")
	arg_2_0.progressSliderTF = var_2_1:Find("right/progress")
	arg_2_0.progressUpSliderTF = var_2_1:Find("right/progress_up")
	arg_2_0.reduceTimeTF = var_2_1:Find("right/Text")

	local var_2_3 = arg_2_0._tf

	arg_2_0.formulaNumTF = var_2.Find(var_2_3, "window/Text")

	local var_2_4 = arg_2_0._tf

	arg_2_0.viewBtn = var_2.Find(var_2_4, "window/view")
	setText = var_2

	local var_2_5 = arg_2_0.viewBtn
	local var_2_6 = var_4.Find(var_2_5, "Text")

	i18n = var_5

	var_2(var_2_6, var_5("island_ticket_view"))

	local var_2_7 = arg_2_0._tf

	arg_2_0.autoBtn = var_2.Find(var_2_7, "window/auto")
	setText = var_2

	local var_2_8 = arg_2_0.autoBtn
	local var_2_9 = var_4.Find(var_2_8, "Text")

	i18n = var_5

	var_2(var_2_9, var_5("island_ticket_auto_select"))

	local var_2_10 = arg_2_0._tf

	arg_2_0.useBtn = var_2.Find(var_2_10, "window/use")
	setText = var_2

	local var_2_11 = arg_2_0.useBtn
	local var_2_12 = var_4.Find(var_2_11, "Text")

	i18n = var_5

	var_2(var_2_12, var_5("island_ticket_use"))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_2.Find(var_2_13, "window/scrollrect")

	arg_2_0.scrollRect = var_2.GetComponent(var_2_14, "LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_4.Find(var_5_1, "window/help")

	local function var_5_3()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		IslandMsgBox = var_2_10004
		var_6_2.type = var_2_10004.TYPE_WHITOUT_BTN
		i18n = var_4
		var_6_2.content = var_4("island_helpbtn_speedup")

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_4.Find(var_5_5, "window/close")

	local function var_5_7()
		local var_7_0 = arg_5_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_5_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_4.Find(var_5_9, "mask")

	local function var_5_11()
		local var_8_0 = arg_5_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_5_9

	var_1_10001(var_5_8, var_5_10, var_5_11, var_5_9)

	onButton = var_1_10001

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.viewBtn

	local function var_5_14()
		local var_9_0 = arg_5_0
		local var_9_1 = var_0.OpenPage

		IslandTicketStoragePage = var_2_10003

		var_9_1(var_9_0, var_2_10003)

		return
	end

	SFX_PANEL = var_5_9

	var_1_10001(var_5_12, var_5_13, var_5_14, var_5_9)

	onButton = var_1_10001

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0.viewBtn

	local function var_5_17()
		local var_10_0 = arg_5_0
		local var_10_1 = var_0.OpenPage

		IslandTicketStoragePage = var_2_10003

		var_10_1(var_10_0, var_2_10003)

		return
	end

	SFX_PANEL = var_5_9

	var_1_10001(var_5_15, var_5_16, var_5_17, var_5_9)

	onButton = var_1_10001

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.autoBtn

	local function var_5_20()
		local var_11_0 = arg_5_0

		var_0.AutoSelect(var_11_0)

		return
	end

	SFX_PANEL = var_5_9

	var_1_10001(var_5_18, var_5_19, var_5_20, var_5_9)

	onButton = var_1_10001

	local var_5_21 = arg_5_0
	local var_5_22 = arg_5_0.useBtn

	local function var_5_23()
		local var_12_0 = arg_5_0

		var_0.UseTickets(var_12_0)

		return
	end

	SFX_PANEL = var_5_9

	var_1_10001(var_5_21, var_5_22, var_5_23, var_5_9)

	arg_5_0.cards = {}
	underscore = var_1

	local var_5_24 = var_1.keys

	pg = var_5_21
	arg_5_0.displayGroups = var_5_24(var_5_21.island_speedup_ticket.get_id_list_by_speedup_time)
	table = var_1

	var_1.sort(arg_5_0.displayGroups)

	return
end

function var_0_1.OnInitItem(arg_13_0, arg_13_1)
	IslandTicketGroupCard = var_1_10002

	local var_13_0 = var_1_10002.New(arg_13_1)
	local var_13_1 = arg_13_0.cards

	var_13_1[arg_13_1] = var_13_0
	onButton = var_13_1

	local var_13_2 = arg_13_0
	local var_13_3 = var_13_0.shopBtn

	local function var_13_4()
		IslandMainBtnTipHelper = var_2_10000

		if not var_2_10000.IsUnlock("shop") then
			pg = var_2_10001

			local var_14_0 = var_2_10001.TipsMgr.GetInstance()

			var_2_10001 = var_2_10001.ShowTips
			i18n = var_2_10004

			var_2_10001(var_14_0, var_2_10004("island_shop_lock_tip"))

			return
		end

		pg = var_2_10001

		local var_14_1 = var_2_10001.island_set.island_ticket_shopid.key_value_varchar
		local var_14_2 = arg_13_0
		local var_14_3 = var_2.OpenPage

		IslandShopPage = var_2_10005
		unpack = var_2_10006

		var_14_3(var_14_2, var_2_10005, var_2_10006(var_14_1))

		return
	end

	SFX_PANEL = var_1_10008

	var_13_1(var_13_2, var_13_3, var_13_4, var_1_10008)

	return
end

function var_0_1.OnUpdateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	if not arg_15_0.cards[arg_15_2] then
		var_1_10006 = arg_15_0

		arg_15_0.OnInitItem(var_1_10006, arg_15_2)

		var_15_0 = arg_15_0.cards[arg_15_2]
	end

	local function var_15_1(arg_16_0, arg_16_1)
		arg_15_0.selCounts[arg_16_0] = arg_16_1

		local var_16_0 = var_15_0

		var_2.UpdateSelCnt(var_16_0, arg_15_0.selCounts[arg_16_0])

		local var_16_1 = arg_15_0

		var_2.UpdataSelected(var_16_1)

		local var_16_2 = arg_15_0

		var_2.SetOverflowFlag(var_16_2)

		return
	end

	local var_15_2 = arg_15_1 + 1

	onButton = var_1_10006

	local var_15_3 = arg_15_0
	local var_15_4 = var_15_0._go

	local function var_15_5()
		if arg_15_0.overflowFlag then
			return
		end

		if arg_15_0.selCounts[var_15_2] + 1 > arg_15_0.allCounts[var_15_2] then
			return
		end

		var_15_1(var_15_2, var_0)

		return
	end

	SFX_PANEL = var_1_10011

	var_1_10006(var_15_3, var_15_4, var_15_5, var_1_10011)

	onButton = var_1_10006

	local var_15_6 = arg_15_0
	local var_15_7 = var_15_0.reduceBtn

	local function var_15_8()
		if arg_15_0.selCounts[var_15_2] - 1 < 0 then
			return
		end

		var_15_1(var_15_2, var_0)

		return
	end

	SFX_PANEL = var_1_10011

	var_1_10006(var_15_6, var_15_7, var_15_8, var_1_10011)

	onInputEndEdit = var_1_10006

	var_1_10006(arg_15_0, var_15_0.countInput, function(arg_19_0)
		local var_19_0 = 0

		if arg_19_0 and arg_19_0 ~= "" then
			tonumber = var_2_10002

			if not var_2_10002(arg_19_0) then
				local var_19_1 = 0
			end

			tonumber = var_2_10002

			local var_19_2 = var_2_10002(arg_19_0)

			math = var_2

			local var_19_3 = var_2.max(0, var_19_2)

			math = var_2

			if var_2.min(var_19_3, arg_15_0.allCounts[var_15_2]) > arg_15_0.selCounts[var_15_2] and arg_15_0.overflowFlag then
				return
			end

			var_15_1(var_15_2, var_1)

			return
		end
	end)

	local var_15_9 = arg_15_0.displayGroups[var_15_2]

	if arg_15_0.displayDic[var_15_9] then
		var_15_0:Update(var_15_9, var_7, arg_15_0.allCounts[var_15_2], arg_15_0.selCounts[var_15_2])
	end

	return
end

function var_0_1.SetOverflowFlag(arg_20_0)
	local var_20_0 = arg_20_0.endTime
	local var_20_1 = arg_20_0.timeMgr

	arg_20_0.overflowFlag = var_20_0 - var_2.GetServerTime(var_20_1) - arg_20_0.reduceTime <= 0

	return
end

function var_0_1.AddListeners(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.AddListener

	GAME = var_1_10004

	var_21_1(var_21_0, var_1_10004.ISLAND_REMOVE_EXPIRED_TICKET_DONE, arg_21_0.Flush)

	local var_21_2 = arg_21_0
	local var_21_3 = arg_21_0.AddListener

	GAME = var_4

	var_21_3(var_21_2, var_4.ISLAND_USE_TICKET_DONE, arg_21_0.Flush)

	local var_21_4 = arg_21_0
	local var_21_5 = arg_21_0.AddListener

	GAME = var_4

	var_21_5(var_21_4, var_4.ISLAND_SHOP_OP_DONE, arg_21_0.Flush)

	return
end

function var_0_1.RemoveListeners(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.RemoveListener

	GAME = var_1_10004

	var_22_1(var_22_0, var_1_10004.ISLAND_REMOVE_EXPIRED_TICKET_DONE, arg_22_0.Flush)

	local var_22_2 = arg_22_0
	local var_22_3 = arg_22_0.RemoveListener

	GAME = var_4

	var_22_3(var_22_2, var_4.ISLAND_USE_TICKET_DONE, arg_22_0.Flush)

	local var_22_4 = arg_22_0
	local var_22_5 = arg_22_0.RemoveListener

	GAME = var_4

	var_22_5(var_22_4, var_4.ISLAND_SHOP_OP_DONE, arg_22_0.Flush)

	return
end

function var_0_1.OnShow(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:BlurPanel()

	arg_23_0.type = arg_23_1
	arg_23_0.id = arg_23_2
	pg = var_3
	arg_23_0.timeMgr = var_3.TimeMgr.GetInstance()

	arg_23_0:Flush()

	return
end

function var_0_1.Flush(arg_24_0)
	arg_24_0:SetSystemData()
	arg_24_0:SetTicketsData()

	local var_24_0 = arg_24_0.scrollRect

	var_1.SetTotalCount(var_24_0, #arg_24_0.displayGroups, -1)
	arg_24_0:UpdataSelected()
	arg_24_0:StopTimer()
	arg_24_0:StartTimer()

	arg_24_0.overflowFlag = false

	return
end

function var_0_1.SetSystemData(arg_25_0)
	arg_25_0.allTime = 0
	arg_25_0.endTime = 0
	switch = var_1

	local var_25_0 = arg_25_0.type
	local var_25_1 = {}

	IslandUseTicketCommand = var_1_10005
	var_25_1[var_1_10005.TYPES.ORDER_CD] = function()
		getProxy = var_2_10000
		IslandProxy = var_2_10002

		local var_26_0 = var_2_10000(var_2_10002)
		local var_26_1 = var_0.GetIsland(var_26_0)
		local var_26_2 = var_0.GetOrderAgency(var_26_1)

		if not var_0.GetSlot(var_26_2, arg_25_0.id) then
			return
		end

		arg_25_0.endTime = var_0:GetCanSubmitTime()
		arg_25_0.allTime = var_0:GetTotalTime()

		return
	end
	IslandUseTicketCommand = var_5
	var_25_1[var_5.TYPES.SHIP_ORDER] = function()
		getProxy = var_2_10000
		IslandProxy = var_2_10002

		local var_27_0 = var_2_10000(var_2_10002)
		local var_27_1 = var_0.GetIsland(var_27_0)
		local var_27_2 = var_0.GetOrderAgency(var_27_1)

		if not var_0.GetShipOrderSlot(var_27_2, arg_25_0.id) then
			return
		end

		arg_25_0.endTime = var_0:GetEndTime()
		arg_25_0.allTime = var_0:GetNeedTime()

		return
	end
	IslandUseTicketCommand = var_5
	var_25_1[var_5.TYPES.MANAGE] = function()
		getProxy = var_2_10000
		IslandProxy = var_2_10002

		local var_28_0 = var_2_10000(var_2_10002)
		local var_28_1 = var_0.GetIsland(var_28_0)
		local var_28_2 = var_0.GetManageAgency(var_28_1)

		if not var_0.GetRestaurant(var_28_2, arg_25_0.id) then
			return
		end

		arg_25_0.endTime = var_0:GetEndTime()
		arg_25_0.allTime = var_0:getConfig("opening_time")

		return
	end
	IslandUseTicketCommand = var_5
	var_25_1[var_5.TYPES.APPOINT] = function()
		pg = var_2_10000

		local var_29_0 = var_2_10000.island_production_slot[arg_25_0.id].place

		getProxy = var_1
		IslandProxy = var_2_10003

		local var_29_1 = var_1(var_2_10003)
		local var_29_2 = var_1.GetIsland(var_29_1)
		local var_29_3 = var_1.GetBuildingAgency(var_29_2)
		local var_29_4 = var_1.GetBuilding(var_29_3, var_29_0)
		local var_29_5 = var_1.GetDelegationSlotData(var_29_4, arg_25_0.id)

		arg_25_0.appointRoleData = var_29_5:GetSlotRoleData()

		if not arg_25_0.appointRoleData then
			return
		end

		local var_29_6 = arg_25_0
		local var_29_7 = arg_25_0.appointRoleData

		var_29_6.endTime = var_4.GetFinishTime(var_29_7)

		local var_29_8 = arg_25_0
		local var_29_9 = arg_25_0.appointRoleData

		var_29_8.allTime = var_4.GetAllTime(var_29_9)

		return
	end
	IslandUseTicketCommand = var_5
	var_25_1[var_5.TYPES.SHIP_ORDER_RELOAD] = function()
		local var_30_0 = arg_25_0

		getProxy = var_2_10001
		IslandProxy = var_2_10003

		local var_30_1 = var_2_10001(var_2_10003)
		local var_30_2 = var_1.GetIsland(var_30_1)
		local var_30_3 = var_1.GetOrderAgency(var_30_2)

		var_30_0.endTime = var_1.GetNextManualReloadDelegateTime(var_30_3)

		local var_30_4 = arg_25_0

		pg = var_1
		var_30_4.allTime = var_1.island_set.island_shiporder_refresh_cd.key_value_int

		return
	end

	var_1(var_25_0, var_25_1, function()
		assert = var_2_10000

		var_2_10000(false, "no ticket use type: " .. arg_25_0.type)

		return
	end)

	return
end

function var_0_1.SetTicketsData(arg_32_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_32_0 = var_1_10001(var_1_10003)
	local var_32_1 = var_1.GetIsland(var_32_0)

	arg_32_0.ticketAgency = var_1.GetTicketAgency(var_32_1)
	arg_32_0.displayDic = {}

	local var_32_2 = arg_32_0.ticketAgency
	local var_32_3 = var_1.GetTicketData(var_32_2)

	pairs = var_1_10002

	for iter_32_0, iter_32_1 in var_1_10002(var_32_3) do
		underscore = var_1_10007

		if #var_1_10007.values(iter_32_1) > 0 then
			var_1_10010 = var_1_10007[1]
			var_1_10008 = var_1_10008.GetTime(var_1_10010)

			if not arg_32_0.displayDic[var_1_10008] then
				arg_32_0.displayDic[var_1_10008] = {}
			end

			local var_32_4 = arg_32_0.displayDic

			table = var_1_10010
			var_32_4[var_1_10008] = var_1_10010.mergeArray(arg_32_0.displayDic[var_1_10008], var_1_10007)
		end
	end

	pairs = var_2

	for iter_32_2, iter_32_3 in var_2(arg_32_0.displayDic) do
		table = var_1_10007
		var_1_10007 = var_1_10007.sort

		local var_32_5 = iter_32_3

		CompareFuncs = var_1_10010

		var_1_10007(var_32_5, var_1_10010({
			function(arg_33_0)
				return arg_33_0:IsForever() and 1 or 0
			end,
			function(arg_34_0)
				return arg_34_0:GetEndTime()
			end,
			function(arg_35_0)
				return arg_35_0.id
			end
		}))
	end

	arg_32_0.allCounts = {}
	arg_32_0.selCounts = {}
	ipairs = var_2

	for iter_32_4, iter_32_5 in var_2(arg_32_0.displayGroups) do
		local var_32_6

		if not arg_32_0.displayDic[iter_32_5] then
			var_32_6 = arg_32_0.displayDic
			var_32_6[iter_32_5] = {}
		end

		underscore = var_32_6

		local var_32_7 = var_32_6.reduce(arg_32_0.displayDic[iter_32_5], 0, function(arg_36_0, arg_36_1)
			return arg_36_0 + arg_36_1:GetCount()
		end)

		table = var_1_10008

		var_1_10008.insert(arg_32_0.allCounts, var_32_7)

		table = var_1_10008

		var_1_10008.insert(arg_32_0.selCounts, 0)
	end

	arg_32_0.reduceTime = 0

	return
end

function var_0_1.UpdateSliderUI(arg_37_0)
	local var_37_0 = arg_37_0.timeMgr
	local var_37_1 = var_1.GetServerTime(var_37_0)
	local var_37_2 = arg_37_0.endTime - var_37_1 - arg_37_0.reduceTime

	if 0 < var_37_2 then
		setText = var_4

		local var_37_3 = arg_37_0.remainTimeTF
		local var_37_4 = arg_37_0.timeMgr

		var_4(var_37_3, var_1_10007.DescCDTime(var_37_4, var_37_2))
	else
		setText = var_4

		local var_37_5 = arg_37_0.remainTimeTF

		i18n = var_1_10007

		var_4(var_37_5, var_1_10007("island_ticket_finished"))
	end

	setText = var_4

	local var_37_6 = arg_37_0.reduceTimeTF
	local var_37_7 = "-"
	local var_37_8 = arg_37_0.timeMgr

	var_4(var_37_6, var_37_7 .. var_8.DescCDTime(var_37_8, arg_37_0.reduceTime))

	setSlider = var_4

	var_4(arg_37_0.progressSliderTF, 0, 1, 1 - var_2 / arg_37_0.allTime)

	setSlider = var_4

	var_4(arg_37_0.progressUpSliderTF, 0, 1, 1 - (var_2 - arg_37_0.reduceTime) / arg_37_0.allTime)

	local var_37_9 = arg_37_0.type

	IslandUseTicketCommand = var_1_10005

	local var_37_10 = var_37_9 == var_1_10005.TYPES.APPOINT

	setActive = var_5

	var_5(arg_37_0.formulaNumTF, var_37_10)

	if var_37_10 and arg_37_0.appointRoleData then
		local var_37_11 = arg_37_0.appointRoleData
		local var_37_12 = var_5.GetCountByTimestamp(var_37_11, var_37_1 + arg_37_0.reduceTime)

		setText = var_6

		local var_37_13 = arg_37_0.formulaNumTF

		i18n = var_9

		var_6(var_37_13, var_9("island_ticket_completed_quantity", var_37_12))
	end

	return
end

function var_0_1.UpdateReduceTime(arg_38_0)
	arg_38_0.reduceTime = 0
	ipairs = var_1

	for iter_38_0, iter_38_1 in var_1(arg_38_0.selCounts) do
		arg_38_0.reduceTime = arg_38_0.reduceTime + arg_38_0.displayGroups[iter_38_0] * iter_38_1
	end

	return
end

function var_0_1.UpdataSelected(arg_39_0)
	arg_39_0:UpdateReduceTime()
	arg_39_0:UpdateSliderUI()

	underscore = var_1

	local var_39_0 = var_1.any(arg_39_0.selCounts, function(arg_40_0)
		return arg_40_0 > 0
	end)

	setGray = var_1_10002

	var_1_10002(arg_39_0.useBtn, not var_39_0, true)

	setButtonEnabled = var_1_10002

	var_1_10002(arg_39_0.useBtn, var_39_0)

	return
end

function var_0_1._SelectTickets(arg_41_0)
	local var_41_0 = arg_41_0.endTime
	local var_41_1 = arg_41_0.timeMgr
	local var_41_2 = var_41_0 - var_2.GetServerTime(var_41_1)
	local var_41_3 = 0

	arg_41_0.selCounts = {}
	ipairs = var_3

	for iter_41_0, iter_41_1 in var_3(arg_41_0.displayGroups) do
		table = var_1_10008

		var_1_10008.insert(arg_41_0.selCounts, 0)
	end

	ipairs = var_3

	for iter_41_2, iter_41_3 in var_3(arg_41_0.displayGroups) do
		local var_41_4 = arg_41_0.displayDic[iter_41_3]

		ipairs = var_1_10009

		for iter_41_4, iter_41_5 in var_1_10009(var_41_4) do
			for iter_41_6 = 1, iter_41_5:GetCount() do
				if var_41_2 <= var_41_3 + iter_41_5:GetTime() then
					return
				end

				arg_41_0.selCounts[iter_41_2] = arg_41_0.selCounts[iter_41_2] + 1
			end
		end
	end

	return
end

function var_0_1.AutoSelect(arg_42_0)
	arg_42_0:_SelectTickets()
	arg_42_0:UpdataSelected()

	local var_42_0 = arg_42_0.scrollRect

	var_1.SetTotalCount(var_42_0, #arg_42_0.displayGroups, -1)

	return
end

function var_0_1.GetSelectedTickets(arg_43_0)
	local var_43_0 = {}

	ipairs = var_1_10002

	for iter_43_0, iter_43_1 in var_1_10002(arg_43_0.selCounts) do
		local var_43_1 = arg_43_0.displayGroups[iter_43_0]
		local var_43_2 = arg_43_0.displayDic[var_43_1]
		local var_43_3 = 0

		ipairs = var_1_10010

		for iter_43_2, iter_43_3 in var_1_10010(var_43_2) do
			local var_43_4

			if iter_43_1 - var_43_3 <= iter_43_3:GetCount() then
				table = var_43_4
				var_43_4 = var_43_4.insert

				local var_43_5 = var_43_0

				IslandTicket = var_1_10019

				var_43_4(var_43_5, var_1_10019.New(iter_43_3.id, iter_43_3.endTime, var_15))

				break
			else
				table = var_43_4

				local var_43_6 = var_43_4.insert
				local var_43_7 = var_43_0

				IslandTicket = var_1_10019

				var_43_6(var_43_7, var_1_10019.New(iter_43_3.id, iter_43_3.endTime, iter_43_3:GetCount()))

				var_43_3 = var_43_3 + iter_43_3:GetCount()
			end
		end
	end

	underscore = var_2

	return (var_2.select(var_43_0, function(arg_44_0)
		return arg_44_0:GetCount() > 0
	end))
end

function var_0_1.UseTickets(arg_45_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_46_0)
			local var_46_0 = arg_45_0.endTime
			local var_46_1 = arg_45_0.timeMgr

			if var_46_0 - var_2.GetServerTime(var_46_1) <= 0 then
				pg = var_2

				local var_46_2 = var_2.TipsMgr.GetInstance()
				local var_46_3 = var_2.ShowTips

				i18n = var_2_10005

				var_46_3(var_46_2, var_2_10005("island_ticket_finished"))
			else
				arg_46_0()
			end

			return
		end,
		function(arg_47_0)
			local var_47_0 = arg_45_0.endTime
			local var_47_1 = arg_45_0.timeMgr

			if var_47_0 - var_2.GetServerTime(var_47_1) < arg_45_0.reduceTime then
				local var_47_2 = arg_45_0
				local var_47_3 = var_2.ShowMsgBox
				local var_47_4 = {}

				IslandMsgBox = var_2_10006
				var_47_4.type = var_2_10006.TYPE_COMMON
				i18n = var_6
				var_47_4.content = var_6("island_sure_ticket_overflow")
				var_47_4.onYes = arg_47_0

				var_47_3(var_47_2, var_47_4)
			else
				arg_47_0()
			end

			return
		end
	}, function()
		local var_48_0 = arg_45_0
		local var_48_1 = var_0.GetSelectedTickets(var_48_0)
		local var_48_2 = arg_45_0
		local var_48_3 = var_1.emit

		IslandMediator = var_2_10004

		var_48_3(var_48_2, var_2_10004.USE_TICKETS, arg_45_0.type, arg_45_0.id, var_48_1)

		return
	end)

	return
end

function var_0_1.StartTimer(arg_49_0)
	Timer = var_1_10001
	arg_49_0.timer = var_1_10001.New(function()
		local var_50_0 = arg_49_0

		var_0.UpdateTimer(var_50_0)

		return
	end, 1, -1)

	local var_49_0 = arg_49_0.timer

	var_1.Start(var_49_0)
	arg_49_0:UpdateTimer()

	return
end

function var_0_1.UpdateTimer(arg_51_0)
	arg_51_0:UpdateSliderUI()

	return
end

function var_0_1.StopTimer(arg_52_0)
	if arg_52_0.timer then
		local var_52_0 = arg_52_0.timer

		var_1.Stop(var_52_0)

		arg_52_0.timer = nil
	end

	return
end

function var_0_1.OnHide(arg_53_0)
	arg_53_0:UnBlurPanel()
	arg_53_0:StopTimer()

	return
end

function var_0_1.OnDisable(arg_54_0)
	arg_54_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_55_0)
	arg_55_0:OnHide()

	ClearLScrollrect = var_1

	var_1(arg_55_0.scrollRect)

	pairs = var_1

	for iter_55_0, iter_55_1 in var_1(arg_55_0.cards) do
		iter_55_1:Dispose()
	end

	arg_55_0.cards = {}

	return
end

return var_0_1
