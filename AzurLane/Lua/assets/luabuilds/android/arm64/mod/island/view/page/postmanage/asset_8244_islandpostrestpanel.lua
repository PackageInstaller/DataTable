class = var_0_10000

local var_0_0 = "IslandPostRestPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.MAX_ASSISTANT_CNT = 2
var_0_1.MAX_SHELF_CNT = 5
var_0_1.ScrollValue = 0

function var_0_1.getUIName(arg_1_0)
	return "IslandPostRestPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.scrollTF = var_1.Find(var_2_0, "view")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "view/content")
	local var_2_3 = var_1.Find(var_2_2, "tpl")

	setText = var_2_1

	local var_2_4 = var_2_3:Find("btns/opening/Text")

	i18n = var_1_10006

	var_2_1(var_2_4, var_1_10006("island_manage_view"))

	setText = var_2_1

	local var_2_5 = var_2_3:Find("btns/close/Text")

	i18n = var_6

	var_2_1(var_2_5, var_6("island_manage_result"))

	setText = var_2_1

	local var_2_6 = var_2_3:Find("btns/lock/Text")

	i18n = var_6

	var_2_1(var_2_6, var_6("word_lock"))

	setText = var_2_1

	local var_2_7 = var_2_3:Find("name/event/Text")

	i18n = var_6

	var_2_1(var_2_7, var_6("island_post_event_label"))

	UIItemList = var_2_1
	arg_2_0.uiList = var_2_1.New(var_1, var_2_3)

	return
end

function var_0_1.OnInit(arg_3_0)
	pg = var_1_10001
	arg_3_0.restIds = var_1_10001.island_set.post_manage_operate.key_value_varchar

	local var_3_0 = arg_3_0.uiList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventInit then
			local var_4_0 = arg_3_0

			var_3.InitItem(var_4_0, arg_4_1, arg_4_2)
		else
			UIItemList = var_3

			if arg_4_0 == var_3.EventUpdate then
				local var_4_1 = arg_3_0

				var_3.UpdateItem(var_4_1, arg_4_1, arg_4_2)
			end
		end

		return
	end)

	onScroll = var_1

	var_1(arg_3_0, arg_3_0.scrollTF, function(arg_5_0)
		var_0_1.ScrollValue = arg_5_0.x

		return
	end)

	return
end

function var_0_1.TriggerEvent(arg_6_0, arg_6_1)
	local var_6_0 = -1

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(arg_6_0.restIds) do
		if iter_6_1 == arg_6_1 then
			var_6_0 = iter_6_0

			break
		end
	end

	if var_6_0 < 0 then
		return
	end

	local var_6_1 = arg_6_0.uiList

	var_3.eachActive(var_6_1, function(arg_7_0, arg_7_1)
		if arg_7_0 + 1 == var_6_0 then
			triggerButton = var_2

			var_2(arg_7_1:Find("btns/opening"))
		end

		return
	end)

	return
end

function var_0_1.InitItem(arg_8_0, arg_8_1, arg_8_2)
	onButton = var_1_10003

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_2
	local var_8_2 = arg_8_2.Find(var_8_1, "btns/prepare")

	local function var_8_3()
		local var_9_0 = arg_8_0

		var_0.OpenRestaurant(var_9_0, arg_8_0.restIds[arg_8_1 + 1])

		return
	end

	SFX_PANEL = var_8_1

	var_1_10003(var_8_0, var_8_2, var_8_3, var_8_1)

	onButton = var_1_10003

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_2
	local var_8_6 = arg_8_2.Find(var_8_5, "btns/opening")

	local function var_8_7()
		local var_10_0 = arg_8_0

		var_0.OpenRestaurant(var_10_0, arg_8_0.restIds[arg_8_1 + 1])

		return
	end

	SFX_PANEL = var_8_5

	var_1_10003(var_8_4, var_8_6, var_8_7, var_8_5)

	onButton = var_1_10003

	local var_8_8 = arg_8_0
	local var_8_9 = arg_8_2
	local var_8_10 = arg_8_2.Find(var_8_9, "btns/close")

	local function var_8_11()
		local var_11_0 = arg_8_0

		var_0.OpenRestaurant(var_11_0, arg_8_0.restIds[arg_8_1 + 1])

		return
	end

	SFX_PANEL = var_8_9

	var_1_10003(var_8_8, var_8_10, var_8_11, var_8_9)

	return
end

function var_0_1.OpenRestaurant(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.emit

	IslandMediator = var_1_10005

	var_12_1(var_12_0, var_1_10005.OPEN_PAGE, "IslandRestaurantPage", {
		arg_12_1,
		true
	})

	return
end

function var_0_1.UpdateItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2.name = arg_13_0.restIds[arg_13_1 + 1]
	pg = var_4

	local var_13_0 = var_4.island_manage_restaurant[var_3].name

	setText = var_1_10005

	var_1_10005(arg_13_2:Find("name"), var_13_0)

	local var_13_1 = arg_13_0.rests[var_3]

	setActive = var_1_10006

	var_1_10006(arg_13_2:Find("lock"), not var_13_1)

	setActive = var_1_10006

	var_1_10006(arg_13_2:Find("btns/lock"), not var_13_1)

	setActive = var_1_10006

	var_1_10006(arg_13_2:Find("rank"), var_13_1)

	setActive = var_1_10006

	local var_13_2 = arg_13_2
	local var_13_3 = arg_13_2.Find(var_13_2, "opening")
	local var_13_4

	if var_13_1 then
		::label_13_0::

		var_13_4 = var_13_1:GetStatus()
		IslandRestaurant = var_13_2
		var_13_4 = var_13_4 == var_13_2.STATUS.OPENING
	end

	var_1_10006(var_13_3, var_13_4)

	if var_13_1 then
		var_1_10006 = var_13_1:GetEventInfo()
		setActive = var_7

		var_7(arg_13_2:Find("name/event"), var_13_1:GetEventInfo() ~= 0)
	else
		setActive = var_1_10006

		var_1_10006(arg_13_2:Find("name/event"), false)
	end

	onButton = var_1_10006

	local var_13_5 = arg_13_0
	local var_13_6 = arg_13_2
	local var_13_7 = arg_13_2.Find(var_13_6, "name/event")

	local function var_13_8()
		local var_14_0 = arg_13_0
		local var_14_1 = var_0.emit

		IslandPostManagePage = var_2_10003

		var_14_1(var_14_0, var_2_10003.EVENT_SHOW_SP_EVENT_TIP, var_13_1, false)

		return
	end

	SFX_PANEL = var_13_6

	var_1_10006(var_13_5, var_13_7, var_13_8, var_13_6)

	local var_13_9

	if not var_13_1 or not var_13_1:GetAssistants() then
		var_13_9 = {}
	end

	UIItemList = var_7

	var_7.StaticAlign(arg_13_2:Find("ships"), arg_13_2:Find("ships/tpl"), var_0_1.MAX_ASSISTANT_CNT, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = var_13_9[arg_15_1 + 1]

			setActive = var_4

			var_4(arg_15_2:Find("lock"), not var_15_0)

			local var_15_1 = var_15_0 and var_15_0.shipId

			setActive = var_2_10005

			var_2_10005(arg_15_2:Find("icon"), var_15_1 and var_15_1 ~= 0)

			if var_15_1 and var_15_1 ~= 0 then
				IslandShip = var_2_10005

				local var_15_2 = var_2_10005.StaticGetPrefab(var_15_1)

				LoadImageSpriteAsync = var_6

				var_6("squareicon/" .. var_15_2, arg_15_2:Find("icon"))
			end
		end

		return
	end)

	if var_13_1 then
		local var_13_10 = var_13_1
		local var_13_11

		if not var_13_1.GetCommondities(var_13_10) then
			var_13_11 = {}
		end

		local var_13_12

		if not var_13_1 or not var_13_1:GetShelfCnt() then
			var_13_12 = 0
		end

		UIItemList = var_13_10

		var_13_10.StaticAlign(arg_13_2:Find("shelfs"), arg_13_2:Find("shelfs/tpl"), var_0_1.MAX_SHELF_CNT, function(arg_16_0, arg_16_1, arg_16_2)
			UIItemList = var_2_10003

			if arg_16_0 == var_2_10003.EventUpdate then
				local var_16_0 = var_13_11[arg_16_1 + 1]
				local var_16_1 = var_13_12 < arg_16_1 + 1

				setActive = var_5

				var_5(arg_16_2:Find("lock"), var_16_1)

				setActive = var_5

				var_5(arg_16_2:Find("drop"), var_16_0)

				if var_16_0 then
					Drop = var_5

					local var_16_2 = var_5.New
					local var_16_3 = {}

					DROP_TYPE_ISLAND_ITEM = var_8
					var_16_3.type = var_8
					var_16_3.id = var_16_0.id
					var_16_3.count = var_16_0.num

					local var_16_4 = var_16_2(var_16_3)

					updateCustomDrop = var_2_10006

					var_2_10006(arg_16_2:Find("drop"), var_16_4)
				end
			end

			return
		end)

		if var_13_1 then
			local var_13_13 = var_13_1
			local var_13_14 = var_13_1.getConfig(var_13_13, "opening_number")
			local var_13_15 = var_13_1:GetRemainCnt()

			setText = var_13_13

			local var_13_16 = arg_13_2:Find("btns/prepare/Text")

			string = var_14

			local var_13_17 = var_14.format
			local var_13_18 = "%s(%d/%d)"

			i18n = var_1_10017

			var_13_13(var_13_16, var_13_17(var_13_18, var_1_10017("island_manage_prepare"), var_13_15, var_13_14))

			setText = var_13_13

			local var_13_19 = arg_13_2:Find("btns/end/Text")

			string = var_14

			local var_13_20 = var_14.format
			local var_13_21 = "%s(%d/%d)"

			i18n = var_17

			var_13_13(var_13_19, var_13_20(var_13_21, var_17("island_manage_daily_cnt_tip"), var_13_15, var_13_14))

			LoadImageSpriteAsync = var_13_13

			var_13_13("island/islandrestaurant/" .. var_13_1:GetRankIcon(), arg_13_2:Find("rank"), true)
			arg_13_0:UpdataStatusInfo(arg_13_2, var_13_1)
		end

		return
	end
end

function var_0_1.UpdataStatusInfo(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2:GetStatus()

	IslandRestaurant = var_1_10004

	local var_17_1

	if var_17_0 == var_1_10004.STATUS.OPENING then
		pg = var_17_1
		var_17_1 = var_17_1.TimeMgr.GetInstance()

		local var_17_2 = arg_17_2:GetEndTime() - var_17_1:GetServerTime()

		setText = var_6

		var_6(arg_17_1:Find("opening/Text"), var_17_1:DescCDTime(var_17_2))
	end

	eachChild = var_17_1

	var_17_1(arg_17_1:Find("btns"), function(arg_18_0)
		setActive = var_2_10001

		var_2_10001(arg_18_0, arg_18_0.name == var_17_0)

		return
	end)

	return
end

function var_0_1.Show(arg_19_0)
	arg_19_0.super.Show(arg_19_0)
	arg_19_0:Flush()
	arg_19_0:CheckEventTip()

	scrollTo = var_1

	var_1(arg_19_0.scrollTF, var_0_1.ScrollValue)

	return
end

function var_0_1.CheckEventTip(arg_20_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)

	if not var_1.ShouldTipIslandRestEvet(var_20_0) then
		return
	end

	local var_20_1

	pairs = var_20_0

	for iter_20_0, iter_20_1 in var_20_0(arg_20_0.rests) do
		local var_20_2 = iter_20_1:GetEventInfo()

		if iter_20_1:GetEventInfo() ~= 0 then
			var_20_1 = iter_20_1

			break
		end
	end

	if var_20_1 then
		local var_20_3 = arg_20_0
		local var_20_4 = arg_20_0.emit

		IslandPostManagePage = iter_20_0

		var_20_4(var_20_3, iter_20_0.EVENT_SHOW_SP_EVENT_TIP, var_20_1, true)
	end

	return
end

function var_0_1.Flush(arg_21_0)
	local var_21_0 = arg_21_0

	arg_21_0.StopTimer(var_21_0)

	getProxy = var_1
	IslandProxy = var_21_0

	local var_21_1 = var_1(var_21_0)
	local var_21_2 = var_1.GetIsland(var_21_1)
	local var_21_3 = var_1.GetManageAgency(var_21_2)

	arg_21_0.rests = var_1.GetRestaurants(var_21_3)
	table = var_1

	local var_21_4 = var_1.sort
	local var_21_5 = arg_21_0.restIds

	CompareFuncs = var_1_10004

	var_21_4(var_21_5, var_1_10004({
		function(arg_22_0)
			return arg_21_0.rests[arg_22_0] and 0 or 1
		end,
		function(arg_23_0)
			if arg_21_0.rests[arg_23_0] then
				local var_23_0 = arg_21_0
				local var_23_1

				if not var_2.GetStatusSortWeight(var_23_0, var_1:GetStatus()) then
					var_23_1 = 999
				end

				return var_23_1
			end
		end,
		function(arg_24_0)
			return arg_24_0
		end
	}))

	local var_21_6 = arg_21_0.uiList

	var_1.align(var_21_6, #arg_21_0.restIds)
	arg_21_0:StartTimer()
	arg_21_0:UpdateTime()

	return
end

function var_0_1.GetStatusSortWeight(arg_25_0, arg_25_1)
	switch = var_1_10002

	local var_25_0 = arg_25_1
	local var_25_1 = {}

	IslandRestaurant = var_1_10006
	var_25_1[var_1_10006.STATUS.CLOSE] = function()
		return 1
	end
	IslandRestaurant = var_6
	var_25_1[var_6.STATUS.PREPARE] = function()
		return 2
	end
	IslandRestaurant = var_6
	var_25_1[var_6.STATUS.OPENING] = function()
		return 3
	end
	IslandRestaurant = var_6
	var_25_1[var_6.STATUS.END] = function()
		return 4
	end

	return var_1_10002(var_25_0, var_25_1, function()
		return 999
	end)
end

function var_0_1.UpdateTime(arg_31_0)
	local var_31_0 = arg_31_0.uiList

	var_1.eachActive(var_31_0, function(arg_32_0, arg_32_1)
		if arg_31_0.rests[arg_31_0.restIds[arg_32_0 + 1]] then
			local var_32_0 = arg_31_0

			var_3.UpdataStatusInfo(var_32_0, arg_32_1, var_2)
		end

		return
	end)

	return
end

function var_0_1.StartTimer(arg_33_0)
	Timer = var_1_10001
	arg_33_0.timer = var_1_10001.New(function()
		local var_34_0 = arg_33_0

		var_0.UpdateTime(var_34_0)

		return
	end, 1, -1)

	local var_33_0 = arg_33_0.timer

	var_1.Start(var_33_0)

	return
end

function var_0_1.StopTimer(arg_35_0)
	if arg_35_0.timer ~= nil then
		local var_35_0 = arg_35_0.timer

		var_1.Stop(var_35_0)

		arg_35_0.timer = nil
	end

	return
end

function var_0_1.OnHide(arg_36_0)
	arg_36_0:StopTimer()

	return
end

function var_0_1.OnDestroy(arg_37_0)
	arg_37_0:OnHide()

	return
end

return var_0_1
