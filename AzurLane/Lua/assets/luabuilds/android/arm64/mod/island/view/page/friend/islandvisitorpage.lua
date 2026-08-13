class = var_0_10000

local var_0_0 = "IslandVisitorPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))
local var_0_2 = 1
local var_0_3 = 2

function var_0_1.getUIName(arg_1_0)
	return "IslandVisitorUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.kickAllBtn = var_1.Find(var_2_0, "frame/public")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeAccessBtn = var_1.Find(var_2_1, "frame/onkey")

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "frame/close")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/cnt/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.peopleCntTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = {}
	local var_2_7 = arg_2_0._tf

	var_2_6[1] = var_2.Find(var_2_7, "frame/toggles/1")

	local var_2_8 = arg_2_0._tf

	var_2_6[2] = var_2.Find(var_2_8, "frame/toggles/2")
	arg_2_0.toggles = var_2_6

	local var_2_9 = {}
	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "frame/toggles/1/Text")
	local var_2_12 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_2_9[1] = var_2_12(var_2_11, var_5(var_1_10007))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_2.Find(var_2_13, "frame/toggles/2/Text")
	local var_2_15 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_2_9[2] = var_2_15(var_2_14, var_5(var_1_10007))
	arg_2_0.texts = var_2_9

	local var_2_16 = {}

	i18n = var_2
	var_2_16[1] = var_2("island_curr_visitor")
	i18n = var_2
	var_2_16[2] = var_2("island_visitor_log")
	arg_2_0.names = var_2_16

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1.Find(var_2_17, "frame/scrollrect")

	arg_2_0._scrollrect = var_1.GetComponent(var_2_18, "LScrollRect")

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.Find(var_2_19, "frame/scrollrect4Log")

	arg_2_0._scrollrectLog = var_1.GetComponent(var_2_20, "LScrollRect")
	arg_2_0.scrollrects = {
		arg_2_0._scrollrect,
		arg_2_0._scrollrectLog
	}
	arg_2_0.cards = {}
	arg_2_0.logCards = {}
	arg_2_0.cardList = {
		arg_2_0.cards,
		arg_2_0.logCards
	}

	function arg_2_0._scrollrect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0._scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	function arg_2_0._scrollrectLog.onInitItem(arg_5_0)
		local var_5_0 = arg_2_0

		var_1.OnInitItem4Log(var_5_0, arg_5_0)

		return
	end

	local var_2_21 = arg_2_0._scrollrectLog

	function var_2_21.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.OnUpdateItem4Log(var_6_0, arg_6_0, arg_6_1)

		return
	end

	setText = var_2_21

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_3.Find(var_2_22, "frame/public/Text")

	i18n = var_4

	var_2_21(var_2_23, var_4("island_kick_all"))

	setText = var_2_21

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_3.Find(var_2_24, "frame/onkey/Text")

	i18n = var_4

	var_2_21(var_2_25, var_4("island_close_visit"))

	setText = var_2_21

	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_3.Find(var_2_26, "frame/cnt/label")

	i18n = var_4

	var_2_21(var_2_27, var_4("island_curr_people_cnt"))

	return
end

function var_0_1.OnInit(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0._tf

	local function var_7_2()
		local var_8_0 = arg_7_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.closeBtn

	local function var_7_5()
		local var_9_0 = arg_7_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10006)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.kickAllBtn

	local function var_7_8()
		_ = var_2_10000

		if #var_2_10000.map(arg_7_0.displays, function(arg_11_0)
			return arg_11_0.id
		end) <= 0 then
			return
		end

		local var_10_0 = arg_7_0
		local var_10_1 = var_1.emit

		IslandMediator = var_2_10004

		var_10_1(var_10_0, var_2_10004.KICK_ALL_VISITOR, var_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10006)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.closeAccessBtn

	local function var_7_11()
		local var_12_0 = arg_7_0
		local var_12_1 = var_0.GetIsland(var_12_0)
		local var_12_2 = var_0.GetAccessAgency(var_12_1)
		local var_12_3 = var_0.HasOpenFlag

		IslandConst = var_2_10004

		if not var_12_3(var_12_2, var_2_10004.OPEN_ALL) then
			pg = var_1
			var_12_2 = var_1.TipsMgr.GetInstance()

			local var_12_4 = var_1.ShowTips

			i18n = var_4

			var_12_4(var_12_2, var_4("island_close_access_state"))

			return
		end

		local var_12_5 = {}
		local var_12_6 = {}

		IslandConst = var_12_2
		var_12_6[1] = var_12_2.OPEN_ALL

		local var_12_7 = arg_7_0
		local var_12_8 = var_3.emit

		IslandMediator = var_2_10006

		var_12_8(var_12_7, var_2_10006.SET_ACCESS_FLAG, var_12_5, var_12_6)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10006)

	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.toggles) do
		local var_7_12 = arg_7_0.texts[iter_7_0]
		local var_7_13 = arg_7_0.names[iter_7_0]

		onToggle = var_1_10008

		local var_7_14 = arg_7_0
		local var_7_15 = iter_7_1

		local function var_7_16(arg_13_0)
			if arg_13_0 then
				local var_13_0 = arg_7_0

				var_1.SwitchPage(var_13_0, iter_7_0)
			end

			local var_13_1 = var_7_12

			if arg_13_0 then
				setColorStr = var_2_10002

				if not var_2_10002(var_7_13, "#FEFEFE") then
					setColorStr = var_2_10002
					var_2_10002 = var_2_10002(var_7_13, "#6B6E75")
				end

				var_13_1.text = var_2_10002

				return
			end
		end

		SFX_PANEL = var_1_10013

		var_1_10008(var_7_14, var_7_15, var_7_16, var_1_10013)

		setColorStr = var_1_10008
		var_7_12.text = var_1_10008(var_7_13, "#6B6E75")
	end

	return
end

function var_0_1.AddListeners(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.AddListener

	IslandVisitorAgency = var_1_10004

	var_14_1(var_14_0, var_1_10004.PLAYER_ADD, arg_14_0.OnFlush)

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.AddListener

	IslandVisitorAgency = var_4

	var_14_3(var_14_2, var_4.PLAYER_EXIT, arg_14_0.OnFlush)

	return
end

function var_0_1.RemoveListeners(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.RemoveListener

	IslandVisitorAgency = var_1_10004

	var_15_1(var_15_0, var_1_10004.PLAYER_ADD, arg_15_0.OnFlush)

	local var_15_2 = arg_15_0
	local var_15_3 = arg_15_0.RemoveListener

	IslandVisitorAgency = var_4

	var_15_3(var_15_2, var_4.PLAYER_EXIT, arg_15_0.OnFlush)

	return
end

function var_0_1.OnFlush(arg_16_0)
	arg_16_0:FlushList()

	return
end

function var_0_1.GetDisplayData(arg_17_0, arg_17_1)
	local var_17_0 = {}

	if arg_17_1 == var_0_2 then
		var_1_10005 = arg_17_0
		var_1_10005 = arg_17_0.GetIsland(var_1_10005)
		var_1_10005 = var_3.GetVisitorAgency(var_1_10005)

		local var_17_1 = var_3.GetPlayerList(var_1_10005)

		pairs = var_1_10004

		for iter_17_0, iter_17_1 in var_1_10004(var_17_1) do
			var_1_10011 = iter_17_1

			if not iter_17_1.IsSelf(var_1_10011) then
				table = var_9

				var_9.insert(var_17_0, iter_17_1)
			end
		end
	elseif arg_17_1 == var_0_3 then
		getProxy = var_3
		IslandProxy = var_1_10005

		local var_17_2 = var_3(var_1_10005)
		local var_17_3 = var_3.GetIsland(var_17_2)
		local var_17_4 = var_3.GetAccessAgency(var_17_3)
		local var_17_5 = var_3.GetVisitorLogList(var_17_4)
		local var_17_6 = {}

		ipairs = var_17_4

		for iter_17_2, iter_17_3 in var_17_4(var_17_5) do
			if not iter_17_3:IsSelf() then
				table = var_10

				var_10.insert(var_17_6, iter_17_3)
			end
		end

		table = var_5

		var_5.sort(var_17_6, function(arg_18_0, arg_18_1)
			return arg_18_0.time > arg_18_1.time
		end)

		if #var_17_6 <= 1 then
			return {}
		end

		table = var_5

		var_5.insert(var_17_0, var_17_6[1])

		local var_17_7 = var_17_6[1].time

		for iter_17_4 = 2, #var_17_6 do
			local var_17_8 = var_17_6[iter_17_4].time

			pg = var_1_10011

			local var_17_9 = var_1_10011.TimeMgr.GetInstance()

			if not var_1_10011.IsSameDay(var_17_9, var_17_7, var_17_8) then
				table = var_1_10011
				var_1_10011 = var_1_10011.insert

				local var_17_10 = var_17_0

				IslandVisitorLog = var_14

				var_1_10011(var_17_10, var_14.New({
					id = -1,
					time = var_17_8
				}))
			end

			table = var_1_10011

			var_1_10011.insert(var_17_0, var_17_6[iter_17_4])

			var_17_7 = var_17_8
		end
	end

	return var_17_0
end

function var_0_1.SwitchPage(arg_19_0, arg_19_1)
	arg_19_0.pageIndex = arg_19_1

	arg_19_0:FlushList()

	return
end

function var_0_1.OnInitItem(arg_20_0, arg_20_1)
	IslandVisitorCard = var_1_10002

	local var_20_0 = var_1_10002.New(arg_20_1)

	onButton = var_1_10003

	local var_20_1 = arg_20_0
	local var_20_2 = var_20_0.btn

	local function var_20_3()
		local var_21_0 = arg_20_0
		local var_21_1 = var_0.emit

		IslandMediator = var_2_10003

		local var_21_2 = var_2_10003.ON_KICK_PLAYER

		IslandConst = var_2_10004

		var_21_1(var_21_0, var_21_2, var_2_10004.ACCESS_OP_KICK, var_20_0.player.id)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_20_1, var_20_2, var_20_3, var_1_10008)

	onButton = var_1_10003

	local var_20_4 = arg_20_0
	local var_20_5 = var_20_0.cardBtn

	local function var_20_6()
		local var_22_0 = arg_20_0
		local var_22_1 = var_0.emit

		IslandMediator = var_2_10003

		var_22_1(var_22_0, var_2_10003.OPEN_PAGE, "IslandOtherCardPage", {
			var_20_0.player.id
		})

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_20_4, var_20_5, var_20_6, var_1_10008)

	arg_20_0.cardList[arg_20_0.pageIndex][arg_20_1] = var_20_0

	return
end

function var_0_1.OnUpdateItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0

	if not arg_23_0.cardList[arg_23_0.pageIndex][arg_23_2] then
		arg_23_0:OnInitItem(arg_23_2)

		var_23_0 = arg_23_0.cardList[arg_23_0.pageIndex][arg_23_2]
	end

	local var_23_1 = arg_23_0.displays[arg_23_1 + 1]

	var_23_0:Update(var_23_1)

	return
end

function var_0_1.OnInitItem4Log(arg_24_0, arg_24_1)
	IslandVisitorLogCard = var_1_10002

	local var_24_0 = var_1_10002.New(arg_24_1)

	arg_24_0.cardList[arg_24_0.pageIndex][arg_24_1] = var_24_0

	return
end

function var_0_1.OnUpdateItem4Log(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0

	if not arg_25_0.cardList[arg_25_0.pageIndex][arg_25_2] then
		arg_25_0:OnInitItem(arg_25_2)

		var_25_0 = arg_25_0.cardList[arg_25_0.pageIndex][arg_25_2]
	end

	local var_25_1 = arg_25_0.displays[arg_25_1 + 1]

	var_25_0:Update(var_25_1)

	return
end

function var_0_1.Show(arg_26_0)
	var_0_1.super.Show(arg_26_0)

	triggerToggle = var_1

	var_1(arg_26_0.toggles[var_0_2], true)

	return
end

function var_0_1.FlushList(arg_27_0)
	arg_27_0.displays = arg_27_0:GetDisplayData(arg_27_0.pageIndex)

	local var_27_0 = arg_27_0.scrollrects[arg_27_0.pageIndex]

	var_1.SetTotalCount(var_27_0, #arg_27_0.displays)
	arg_27_0:FlushPeopleCnt()

	return
end

function var_0_1.FlushPeopleCnt(arg_28_0)
	arg_28_0.peopleCntTxt.text = #arg_28_0.displays .. "/10"

	return
end

function var_0_1.OnDestroy(arg_29_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_29_0._scrollrect)

	ClearLScrollrect = var_1_10001

	var_1_10001(arg_29_0._scrollrectLog)

	pairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0.cardList) do
		pairs = var_1_10006

		for iter_29_2, iter_29_3 in var_1_10006(iter_29_1) do
			iter_29_3:Dispose()
		end
	end

	arg_29_0.cardList = nil

	return
end

return var_0_1
