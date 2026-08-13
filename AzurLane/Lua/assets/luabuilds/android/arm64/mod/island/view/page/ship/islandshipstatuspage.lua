class = var_0_10000

local var_0_0 = "IslandShipStatusPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShipStatusUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "adapt/attr_panel/srcollrect")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_1, "LScrollRect")

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

	local var_2_2 = arg_2_0._tf

	arg_2_0.giveBtn = var_1.Find(var_2_2, "adapt/attr_panel/send_panel/give_btn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.emptyTr = var_1.Find(var_2_3, "adapt/attr_panel/send_panel/empty")
	UIItemList = var_1

	local var_2_4 = var_1.New
	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_3.Find(var_2_5, "adapt/attr_panel/send_panel/scrollrect/list")
	local var_2_7 = arg_2_0._tf

	arg_2_0.giftEffectList = var_2_4(var_2_6, var_4.Find(var_2_7, "adapt/attr_panel/send_panel/scrollrect/list/tpl"))
	IslandShipStatusPanel = var_1

	local var_2_8 = var_1.New
	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "adapt/attr_panel/status")
	local var_2_11 = arg_2_0._tf

	arg_2_0.statusPanel = var_2_8(var_2_10, var_4.Find(var_2_11, "adapt/attr_panel/status_empty"))
	setText = var_1

	local var_2_12 = arg_2_0.emptyTr
	local var_2_13 = var_3.Find(var_2_12, "Text")

	i18n = var_4

	var_1(var_2_13, var_4("island_select_ship_gift"))

	local var_2_14 = arg_2_0._tf

	arg_2_0.powerTr = var_1.Find(var_2_14, "adapt/attr_panel/power")
	setText = var_1

	local var_2_15 = arg_2_0.powerTr
	local var_2_16 = var_3.Find(var_2_15, "Text")

	i18n = var_4

	var_1(var_2_16, var_4("island_gift_tip_title"))

	return
end

function var_0_1.OnInit(arg_5_0)
	arg_5_0.cards = {}
	onButton = var_1

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.giveBtn

	local function var_5_2()
		if not arg_5_0.selectedId then
			return
		end

		local var_6_0 = {}
		local var_6_1 = arg_5_0.addPower + arg_5_0.curPower

		if arg_5_0.maxPower < var_6_1 then
			table = var_6_1

			var_6_1.insert(var_6_0, function(arg_7_0)
				local var_7_0 = arg_5_0
				local var_7_1 = var_1.ShowMsgBox
				local var_7_2 = {}

				IslandMsgBox = var_3_10005
				var_7_2.type = var_3_10005.TYPE_COMMON
				i18n = var_5
				var_7_2.content = var_5("island_gift_tip")
				var_7_2.onYes = arg_7_0

				var_7_1(var_7_0, var_7_2)

				return
			end)
		end

		local var_6_2 = arg_5_0
		local var_6_3 = var_1.CollectGiftBuffs(var_6_2, arg_5_0.selectedId)

		ipairs = var_2

		for iter_6_0, iter_6_1 in var_2(var_6_3) do
			table = var_2_10007

			var_2_10007.insert(var_6_0, function(arg_8_0)
				IslandAddShipStatusHelper = var_3_10001

				var_3_10001.CheckAddStatus(arg_5_0, arg_5_0.ship, iter_6_1, arg_8_0)

				return
			end)
		end

		seriesAsync = var_2

		var_2(var_6_0, function()
			local var_9_0 = arg_5_0
			local var_9_1 = var_0.emit

			IslandMediator = var_3_10003

			var_9_1(var_9_0, var_3_10003.ON_GIVE_GIFT, arg_5_0.selectedId, 1, arg_5_0.shipId)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_0, var_5_1, var_5_2, var_1_10006)

	return
end

function var_0_1.AddListeners(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.AddListener

	GAME = var_1_10004

	var_10_1(var_10_0, var_1_10004.ISLAND_GIVE_GIFT_DONE, arg_10_0.OnUseItem)

	return
end

function var_0_1.RemoveListeners(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.RemoveListener

	GAME = var_1_10004

	var_11_1(var_11_0, var_1_10004.ISLAND_GIVE_GIFT_DONE, arg_11_0.OnUseItem)

	return
end

function var_0_1.OnUseItem(arg_12_0)
	arg_12_0.selectedId = nil

	arg_12_0:FlushStatus(arg_12_0.ship)
	arg_12_0:FlushGifts()
	arg_12_0:FlushPower()

	return
end

function var_0_1.OnShow(arg_13_0, arg_13_1)
	arg_13_0.selectedId = nil
	getProxy = var_2
	IslandProxy = var_1_10004

	local var_13_0 = var_2(var_1_10004)
	local var_13_1 = var_2.GetIsland(var_13_0)
	local var_13_2 = var_2.GetCharacterAgency(var_13_1)

	if var_2.GetShipById(var_13_2, arg_13_1) == nil then
		return
	end

	arg_13_0.ship = var_2
	arg_13_0.shipId = arg_13_0.ship.id

	arg_13_0:FlushStatus(var_2)
	arg_13_0:FlushGifts()
	arg_13_0:FlushPower()
	arg_13_0:UpdateSelected(arg_13_0.selectedId)

	return
end

function var_0_1.FlushStatus(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.statusPanel

	var_2.Flush(var_14_0, arg_14_1)

	local var_14_1 = arg_14_1:GetDisplayStatus()

	onButton = var_1_10003

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.statusPanel.viewBtn

	local function var_14_4()
		local var_15_0 = arg_14_0
		local var_15_1 = var_0.ShowMsgBox
		local var_15_2 = {
			hideNo = true
		}

		IslandMsgBox = var_2_10004
		var_15_2.type = var_2_10004.TYPE_SHIP_OWN_STATUS
		i18n = var_4
		var_15_2.title = var_4("island_word_ship_buff_desc")
		var_15_2.statusList = var_14_1

		var_15_1(var_15_0, var_15_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_14_2, var_14_3, var_14_4, var_1_10008)

	return
end

function var_0_1.OnInitItem(arg_16_0, arg_16_1)
	IslandGiftCard = var_1_10002

	local var_16_0 = var_1_10002.New(arg_16_1)

	onButton = var_1_10003

	local var_16_1 = arg_16_0
	local var_16_2 = var_16_0.go

	local function var_16_3()
		local var_17_0 = var_16_0.item

		if var_0.GetCount(var_17_0) <= 0 then
			local var_17_1 = arg_16_0
			local var_17_2 = var_0.ShowMsgBox
			local var_17_3 = {}

			i18n = var_2_10004
			var_17_3.title = var_2_10004("island_word_ship_buff_desc")
			IslandMsgBox = var_4
			var_17_3.type = var_4.TYPE_COMMON_ITEM
			var_17_3.itemId = var_16_0.item.id

			var_17_2(var_17_1, var_17_3)

			return
		end

		local var_17_4 = arg_16_0

		var_17_4.selectedId = nil
		pairs = var_17_4

		for iter_17_0, iter_17_1 in var_17_4(arg_16_0.cards) do
			iter_17_1:UpdateSelected(arg_16_0.selectedId)
		end

		local var_17_5 = arg_16_0

		var_0.UpdateSelected(var_17_5, var_16_0.itemId)

		local var_17_6 = var_16_0

		var_0.UpdateSelected(var_17_6, arg_16_0.selectedId)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_16_1, var_16_2, var_16_3, var_1_10008)

	arg_16_0.cards[arg_16_1] = var_16_0

	return
end

function var_0_1.OnUpdateItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0

	if not arg_18_0.cards[arg_18_2] then
		arg_18_0:OnInitItem(arg_18_2)

		var_18_0 = arg_18_0.cards[arg_18_2]
	end

	var_18_0:Update(arg_18_0.shipId, arg_18_0.displays[arg_18_1 + 1], arg_18_0.selectedId)

	return
end

function var_0_1.FlushGifts(arg_19_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_19_0 = var_1_10001(var_1_10003)
	local var_19_1 = var_1.GetIsland(var_19_0)
	local var_19_2 = var_1.GetInventoryAgency(var_19_1)
	local var_19_3 = var_1.GetGifts(var_19_2)

	arg_19_0.displays = {}
	pairs = var_2

	for iter_19_0, iter_19_1 in var_2(var_19_3) do
		table = var_1_10007

		var_1_10007.insert(arg_19_0.displays, iter_19_1)
	end

	table = var_2

	var_2.sort(arg_19_0.displays, function(arg_20_0, arg_20_1)
		return arg_20_0.id < arg_20_1.id
	end)

	local var_19_4 = arg_19_0.scrollRect

	var_2.SetTotalCount(var_19_4, #arg_19_0.displays)

	return
end

function var_0_1.UpdateSelected(arg_21_0, arg_21_1)
	arg_21_0.selectedId = arg_21_1
	setActive = var_1_10002

	var_1_10002(arg_21_0.emptyTr, arg_21_0.selectedId == nil)

	setActive = var_1_10002

	var_1_10002(arg_21_0.giftEffectList.container, arg_21_0.selectedId)

	if arg_21_0.selectedId then
		local var_21_0 = arg_21_0:CollectGiftEffect(arg_21_1)
		local var_21_1 = arg_21_0.giftEffectList

		var_3.make(var_21_1, function(arg_22_0, arg_22_1, arg_22_2)
			UIItemList = var_2_10003

			if arg_22_0 == var_2_10003.EventUpdate then
				setText = var_3

				var_3(arg_22_2, var_21_0[arg_22_1 + 1])
			end

			return
		end)

		local var_21_2 = arg_21_0.giftEffectList

		var_3.align(var_21_2, #var_21_0)
	end

	arg_21_0:FlushPower()

	return
end

function var_0_1.CollectGiftBuffs(arg_23_0, arg_23_1)
	local var_23_0 = {}

	IslandItem = var_1_10003

	local var_23_1 = var_1_10003.StaticGetUsageArg(arg_23_1)
	local var_23_2 = arg_23_0.ship

	if var_4.IsFavoriteGift(var_23_2, arg_23_1) then
		IslandConst = var_23_3

		local var_23_3

		if not var_23_3.GIFT_INDEX_FAVORITE then
			IslandConst = var_23_3
			var_23_3 = var_23_3.GIFT_INDEX_COMMON
		end

		ipairs = var_5

		for iter_23_0, iter_23_1 in var_5(var_23_1) do
			if var_23_3 == iter_23_0 then
				local var_23_4 = iter_23_1[2]

				ipairs = var_1_10011

				for iter_23_2, iter_23_3 in var_1_10011(var_23_4) do
					table = var_1_10016

					var_1_10016.insert(var_23_0, iter_23_3)
				end
			end
		end

		return var_23_0
	end
end

function var_0_1.CollectGiftEffect(arg_24_0, arg_24_1)
	local var_24_0 = {}

	IslandItem = var_1_10003

	local var_24_1 = var_1_10003.StaticGetUsageArg(arg_24_1)

	IslandConst = var_1_10004

	local var_24_2 = var_1_10004.GIFT_INDEX_COMMON

	IslandConst = var_5

	local var_24_3 = var_5.GIFT_INDEX_FAVORITE
	local var_24_4 = arg_24_0.ship
	local var_24_5

	if not var_6.IsFavoriteGift(var_24_4, arg_24_1) or not var_24_1[var_24_3] then
		var_24_5 = var_24_1[var_24_2]
	end

	local var_24_6

	if var_24_5[var_24_2] > 0 then
		table = var_24_6
		var_24_6 = var_24_6.insert

		local var_24_7 = var_24_0

		i18n = var_1_10010

		var_24_6(var_24_7, var_1_10010("island_word_ship_enengy_recover") .. var_24_5[var_24_2])
	end

	ipairs = var_24_6

	for iter_24_0, iter_24_1 in var_24_6(var_24_5[2]) do
		pg = var_1_10012
		var_1_10012 = var_1_10012.island_buff_template[iter_24_1]
		table = var_1_10013

		var_1_10013.insert(var_24_0, var_1_10012.buff_desc)
	end

	return var_24_0
end

function var_0_1.GetGiftAddPower(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return 0
	end

	IslandItem = var_1_10002

	local var_25_0 = var_1_10002.StaticGetUsageArg(arg_25_1)

	IslandConst = var_1_10003

	local var_25_1 = var_1_10003.GIFT_INDEX_COMMON

	IslandConst = var_4

	local var_25_2 = var_4.GIFT_INDEX_FAVORITE
	local var_25_3 = arg_25_0.ship
	local var_25_4

	if not var_5.IsFavoriteGift(var_25_3, arg_25_1) or not var_25_0[var_25_2] then
		var_25_4 = var_25_0[var_25_1]
	end

	if var_25_4[var_25_1] > 0 then
		return var_25_4[var_25_1]
	end

	return 0
end

function var_0_1.FlushPower(arg_26_0)
	local var_26_0 = arg_26_0.ship

	arg_26_0.maxPower = var_1.GetMaxEnergy(var_26_0)

	local var_26_1 = arg_26_0.ship

	arg_26_0.curPower = var_1.GetCurrentEnergy(var_26_1)
	arg_26_0.addPower = arg_26_0:GetGiftAddPower(arg_26_0.selectedId)
	math = var_1

	local var_26_2

	if not (var_1.min(arg_26_0.addPower, arg_26_0.maxPower - arg_26_0.curPower) > 0) or not ("+" .. var_1) then
		var_26_2 = ""
	end

	setText = var_3

	local var_26_3 = arg_26_0.powerTr
	local var_26_4 = var_5.Find(var_26_3, "value")
	local var_26_5 = arg_26_0.curPower

	setColorStr = var_26_3

	var_3(var_26_4, var_26_5 .. var_26_3(var_26_2, "#4FD775") .. "/" .. arg_26_0.maxPower)

	setSlider = var_3

	local var_26_6 = arg_26_0.powerTr

	var_3(var_5.Find(var_26_6, "progress"), 0, 1, arg_26_0.curPower / arg_26_0.maxPower)

	setSlider = var_3

	local var_26_7 = arg_26_0.powerTr
	local var_26_8 = var_5.Find(var_26_7, "progress/add")
	local var_26_9 = 0
	local var_26_10 = 1
	local var_26_11

	if not (arg_26_0.addPower > 0) or not ((arg_26_0.curPower + arg_26_0.addPower) / arg_26_0.maxPower) then
		var_26_11 = 0
	end

	var_3(var_26_8, var_26_9, var_26_10, var_26_11)

	return
end

function var_0_1.OnDestroy(arg_27_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_27_0.scrollRect)

	local var_27_0 = arg_27_0.statusPanel

	var_1.Dispose(var_27_0)

	arg_27_0.statusPanel = nil
	ipairs = var_1

	local var_27_1

	if not arg_27_0.cards then
		var_27_1 = {}
	end

	for iter_27_0, iter_27_1 in var_1(var_27_1) do
		iter_27_1:Dispose()
	end

	arg_27_0.cards = nil

	return
end

return var_0_1
