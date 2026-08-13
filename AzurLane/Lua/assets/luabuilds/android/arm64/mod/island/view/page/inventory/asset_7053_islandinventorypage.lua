class = var_0_10000

local var_0_0 = "IslandInventoryPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))
local var_0_2 = 101
local var_0_3 = 102
local var_0_4 = 103
local var_0_5 = false

var_0_1.INVENTORY_TYPE_OVERFLOW = 100
var_0_1.INVENTORY_TYPE_COMMON = 101
var_0_1.MODE_VIEW = 0
var_0_1.MODE_EDIT = 1

function var_0_1.getUIName(arg_1_0)
	return "IslandInventoryUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "window/close_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.filterBtn = var_1.Find(var_2_1, "window/sort_panel/index")

	local var_2_2 = arg_2_0._tf

	arg_2_0.orderBtn = var_1.Find(var_2_2, "window/sort_panel/sort")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "window/sort_panel/sort/Text")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.orderTxt = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = arg_2_0._tf

	arg_2_0.orderArr = var_1.Find(var_2_6, "window/sort_panel/sort/arr")

	local var_2_7 = {}
	local var_2_8 = var_0_1.INVENTORY_TYPE_OVERFLOW
	local var_2_9 = arg_2_0._tf

	var_2_7[var_2_8] = var_3.Find(var_2_9, "window/toggles/0")
	IslandItem = var_2_8

	local var_2_10 = var_2_8.TYPE_MATERIAL
	local var_2_11 = arg_2_0._tf

	var_2_7[var_2_10] = var_3.Find(var_2_11, "window/toggles/1")
	IslandItem = var_2_10

	local var_2_12 = var_2_10.TYPE_PROP
	local var_2_13 = arg_2_0._tf

	var_2_7[var_2_12] = var_3.Find(var_2_13, "window/toggles/2")
	IslandItem = var_2_12

	local var_2_14 = var_2_12.TYPE_SPECIAL_PROP
	local var_2_15 = arg_2_0._tf

	var_2_7[var_2_14] = var_3.Find(var_2_15, "window/toggles/3")
	arg_2_0.toggles = var_2_7

	local var_2_16 = {}
	local var_2_17 = var_0_1.INVENTORY_TYPE_OVERFLOW

	IslandInventoryIndexData = var_3
	var_2_16[var_2_17] = var_3.New(var_0_2)
	IslandItem = var_2_17

	local var_2_18 = var_2_17.TYPE_MATERIAL

	IslandInventoryIndexData = var_3
	var_2_16[var_2_18] = var_3.New(var_0_2)
	IslandItem = var_2_18

	local var_2_19 = var_2_18.TYPE_PROP

	IslandInventoryIndexData = var_3
	var_2_16[var_2_19] = var_3.New(var_0_3)
	IslandItem = var_2_19

	local var_2_20 = var_2_19.TYPE_SPECIAL_PROP

	IslandInventoryIndexData = var_3
	var_2_16[var_2_20] = var_3.New(var_0_4)
	arg_2_0.indexDatas = var_2_16

	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_1.Find(var_2_21, "window/upgrade/Text")
	local var_2_23 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.capacityTxt = var_2_23(var_2_22, var_4(var_6))

	local var_2_24 = arg_2_0._tf

	arg_2_0.upgradeBtn = var_1.Find(var_2_24, "window/upgrade")

	local var_2_25 = arg_2_0._tf

	arg_2_0.upgradeProg = var_1.Find(var_2_25, "window/upgrade/bar")

	local var_2_26 = arg_2_0._tf

	arg_2_0.batchSellBtn = var_1.Find(var_2_26, "window/batch_sell")

	local var_2_27 = arg_2_0._tf

	arg_2_0.sellPanel = var_1.Find(var_2_27, "window/sell_panel")
	setText = var_1

	local var_2_28 = arg_2_0.sellPanel
	local var_2_29 = var_3.Find(var_2_28, "tip")

	i18n = var_4

	var_1(var_2_29, var_4("island_quickselect_tip"))

	local var_2_30 = arg_2_0._tf

	arg_2_0.sortPaenl = var_1.Find(var_2_30, "window/sort_panel")

	local var_2_31 = arg_2_0._tf

	arg_2_0.sellBtn = var_1.Find(var_2_31, "window/sell_panel/batch_sell_1")

	local var_2_32 = arg_2_0._tf

	arg_2_0.sellCancelBtn = var_1.Find(var_2_32, "window/sell_panel/cancel")

	local var_2_33 = arg_2_0._tf

	arg_2_0.sellAllBtn = var_1.Find(var_2_33, "window/sell_panel/all")
	setActive = var_1

	var_1(arg_2_0.sellAllBtn, var_0_5)

	local var_2_34 = arg_2_0.sellAllBtn

	arg_2_0.sellAllFlagTF = var_1.Find(var_2_34, "flag")

	local var_2_35 = arg_2_0._tf
	local var_2_36 = var_1.Find(var_2_35, "window/sell_panel/price/Text")
	local var_2_37 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_2_0.sellPriceTxt = var_2_37(var_2_36, var_4(var_6))
	LoadImageSpriteAsync = var_1

	local var_2_38 = "island/"

	getIslandSeasonPtInfo = var_4

	local var_2_39 = var_2_38 .. var_4().icon
	local var_2_40 = arg_2_0._tf

	var_1(var_2_39, var_4.Find(var_2_40, "window/sell_panel/price/Text/icon"))

	local var_2_41 = arg_2_0._tf

	arg_2_0.oneKeyPanel = var_1.Find(var_2_41, "window/one_key_panel")

	local var_2_42 = arg_2_0._tf

	arg_2_0.onekeyBtn = var_1.Find(var_2_42, "window/one_key_panel/fetch_btn")

	local var_2_43 = arg_2_0._tf
	local var_2_44 = var_1.Find(var_2_43, "window/item_scrollview")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_44, "LScrollRect")
	setText = var_1

	local var_2_45 = arg_2_0._tf
	local var_2_46 = var_3.Find(var_2_45, "window/title/Text")

	i18n = var_4

	var_1(var_2_46, var_4("island_bag_title"))

	setText = var_1

	local var_2_47 = arg_2_0._tf
	local var_2_48 = var_3.Find(var_2_47, "window/batch_sell/Text")

	i18n = var_4

	var_1(var_2_48, var_4("island_batch_covert"))

	setText = var_1

	local var_2_49 = arg_2_0._tf
	local var_2_50 = var_3.Find(var_2_49, "window/sell_panel/price/label")

	i18n = var_4

	var_1(var_2_50, var_4("island_total_price"))

	setText = var_1

	local var_2_51 = arg_2_0._tf
	local var_2_52 = var_3.Find(var_2_51, "window/sell_panel/cancel/Text")

	i18n = var_4

	var_1(var_2_52, var_4("word_cancel"))

	setText = var_1

	local var_2_53 = arg_2_0._tf
	local var_2_54 = var_3.Find(var_2_53, "window/sell_panel/all/Text")

	i18n = var_4

	var_1(var_2_54, var_4("island_selectall"))

	setText = var_1

	local var_2_55 = arg_2_0._tf
	local var_2_56 = var_3.Find(var_2_55, "window/sell_panel/batch_sell_1/Text")

	i18n = var_4

	var_1(var_2_56, var_4("island_batch_covert"))

	setText = var_1

	local var_2_57 = arg_2_0._tf
	local var_2_58 = var_3.Find(var_2_57, "window/one_key_panel/fetch_btn/Text")

	i18n = var_4

	var_1(var_2_58, var_4("mail_get_oneclick"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.upgradeBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.OpenPage

		IslandInventoryUpgradePage = var_2_10003

		var_6_1(var_6_0, var_2_10003)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.batchSellBtn

	local function var_3_11()
		arg_3_0.mode = var_0_1.MODE_EDIT

		local var_7_0 = arg_3_0

		var_0.SetTotalCount(var_7_0)

		local var_7_1 = arg_3_0

		var_0.UpdateStyle(var_7_1)

		arg_3_0.sellPriceTxt.text = "x 0"

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.sellCancelBtn

	local function var_3_14()
		arg_3_0.mode = var_0_1.MODE_VIEW

		local var_8_0 = arg_3_0

		var_0.SetTotalCount(var_8_0)

		local var_8_1 = arg_3_0

		var_0.UpdateStyle(var_8_1)

		ipairs = var_0

		for iter_8_0, iter_8_1 in var_0(arg_3_0.values) do
			arg_3_0.values[iter_8_0] = 0
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_12, var_3_13, var_3_14, var_1_10006)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.sellAllBtn

	local function var_3_17(arg_9_0)
		if not var_0_5 then
			return
		end

		if arg_3_0.selAllFlag then
			local var_9_0 = arg_3_0

			var_1.UpdataUnselAll(var_9_0)
		else
			local var_9_1 = arg_3_0

			var_1.UpdataSelAll(var_9_1)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_15, var_3_16, var_3_17, var_1_10006)

	onButton = var_1_10001

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.sellBtn

	local function var_3_20()
		local var_10_0 = arg_3_0

		if #var_0.GetSellItems(var_10_0) <= 0 then
			return
		end

		local var_10_1 = arg_3_0
		local var_10_2 = var_1.ShowMsgBox
		local var_10_3 = {}

		i18n = var_2_10005
		var_10_3.content = var_2_10005("island_season_window_transformtip")

		function var_10_3.onYes()
			if arg_3_0.tagType == var_0_1.INVENTORY_TYPE_OVERFLOW then
				local var_11_0 = arg_3_0
				local var_11_1 = var_0.emit

				IslandMediator = var_3_10003

				var_11_1(var_11_0, var_3_10003.ON_CONVERT_SEASON_PT_4_OVERFLOW, var_0)
			else
				local var_11_2 = arg_3_0
				local var_11_3 = var_0.emit

				IslandMediator = var_3_10003

				var_11_3(var_11_2, var_3_10003.ON_CONVERT_SEASON_PT, var_0)
			end

			return
		end

		var_10_2(var_10_1, var_10_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_18, var_3_19, var_3_20, var_1_10006)

	onButton = var_1_10001

	local var_3_21 = arg_3_0
	local var_3_22 = arg_3_0.onekeyBtn

	local function var_3_23()
		if arg_3_0.tagType ~= var_0_1.INVENTORY_TYPE_OVERFLOW then
			return
		end

		local var_12_0 = arg_3_0
		local var_12_1 = var_0.emit

		IslandMediator = var_2_10003

		var_12_1(var_12_0, var_2_10003.ONE_KEY)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_21, var_3_22, var_3_23, var_1_10006)

	return
end

function var_0_1.OnShow(arg_13_0)
	arg_13_0:SetUp()

	return
end

function var_0_1.GetSellItems(arg_14_0)
	local var_14_0 = {}

	ipairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0.values) do
		local var_14_1 = arg_14_0.displays[iter_14_0].id
		local var_14_2

		if not var_14_0[var_7.id] then
			var_14_2 = 0
		end

		var_14_0[var_14_1] = var_14_2 + iter_14_1
	end

	local var_14_3 = {}

	pairs = var_3

	for iter_14_2, iter_14_3 in var_3(var_14_0) do
		if 0 < iter_14_3 then
			table = var_8

			var_8.insert(var_14_3, {
				id = iter_14_2,
				num = iter_14_3
			})
		end
	end

	return var_14_3
end

function var_0_1.UpdateStyle(arg_15_0)
	setActive = var_1_10001

	var_1_10001(arg_15_0.sellPanel, arg_15_0.mode == var_0_1.MODE_EDIT)

	setActive = var_1_10001

	var_1_10001(arg_15_0.sortPaenl, arg_15_0.mode == var_0_1.MODE_VIEW and arg_15_0.tagType ~= var_0_1.INVENTORY_TYPE_OVERFLOW)

	setActive = var_1_10001

	var_1_10001(arg_15_0.oneKeyPanel, arg_15_0.tagType == var_0_1.INVENTORY_TYPE_OVERFLOW and arg_15_0.mode ~= var_0_1.MODE_EDIT)

	setActive = var_1_10001

	var_1_10001(arg_15_0.batchSellBtn, arg_15_0.mode == var_0_1.MODE_VIEW)

	if arg_15_0.mode == var_0_1.MODE_EDIT then
		arg_15_0:CheckSelAllFlag()
	end

	return
end

function var_0_1.AddListeners(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.AddListener

	IslandScene = var_1_10004

	var_16_1(var_16_0, var_1_10004.ON_INVENTORY_FILTER, arg_16_0.OnInventoryFilter)

	local var_16_2 = arg_16_0
	local var_16_3 = arg_16_0.AddListener

	GAME = var_4

	var_16_3(var_16_2, var_4.ISLAND_UPGRADE_INVENTORY_DONE, arg_16_0.OnUpgrade)

	local var_16_4 = arg_16_0
	local var_16_5 = arg_16_0.AddListener

	GAME = var_4

	var_16_5(var_16_4, var_4.ISLAND_CONVERT_SEASON_PT_DONE, arg_16_0.OnSell)

	local var_16_6 = arg_16_0
	local var_16_7 = arg_16_0.AddListener

	GAME = var_4

	var_16_7(var_16_6, var_4.ISLAND_GET_OVERFLOW_ITEM_DOME, arg_16_0.OnSell)

	local var_16_8 = arg_16_0
	local var_16_9 = arg_16_0.AddListener

	GAME = var_4

	var_16_9(var_16_8, var_4.ISLAND_INVITE_SHIP_DONE, arg_16_0.OnUseInvitation)

	return
end

function var_0_1.RemoveListeners(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.RemoveListener

	IslandScene = var_1_10004

	var_17_1(var_17_0, var_1_10004.ON_INVENTORY_FILTER, arg_17_0.OnInventoryFilter)

	local var_17_2 = arg_17_0
	local var_17_3 = arg_17_0.RemoveListener

	GAME = var_4

	var_17_3(var_17_2, var_4.ISLAND_UPGRADE_INVENTORY_DONE, arg_17_0.OnUpgrade)

	local var_17_4 = arg_17_0
	local var_17_5 = arg_17_0.RemoveListener

	GAME = var_4

	var_17_5(var_17_4, var_4.ISLAND_CONVERT_SEASON_PT_DONE, arg_17_0.OnSell)

	local var_17_6 = arg_17_0
	local var_17_7 = arg_17_0.RemoveListener

	GAME = var_4

	var_17_7(var_17_6, var_4.ISLAND_GET_OVERFLOW_ITEM_DOME, arg_17_0.OnSell)

	local var_17_8 = arg_17_0
	local var_17_9 = arg_17_0.RemoveListener

	GAME = var_4

	var_17_9(var_17_8, var_4.ISLAND_INVITE_SHIP_DONE, arg_17_0.OnUseInvitation)

	return
end

function var_0_1.OnUseInvitation(arg_18_0)
	arg_18_0:SetTotalCount()

	return
end

function var_0_1.GetIndexData(arg_19_0, arg_19_1)
	assert = var_1_10002

	var_1_10002(arg_19_0.indexDatas[arg_19_1])

	return arg_19_0.indexDatas[arg_19_1]
end

function var_0_1.UpdateIndexData(arg_20_0, arg_20_1, arg_20_2)
	assert = var_1_10003

	var_1_10003(arg_20_0.indexDatas[arg_20_1])

	local var_20_0 = arg_20_0.indexDatas[arg_20_1]

	var_3.SetData(var_20_0, arg_20_2)

	return
end

function var_0_1.OnInventoryFilter(arg_21_0, arg_21_1)
	arg_21_0:UpdateIndexData(arg_21_0.tagType, arg_21_1)
	arg_21_0:FlushSortBtn()
	arg_21_0:SetTotalCount()

	return
end

function var_0_1.OnUpgrade(arg_22_0)
	arg_22_0:SetTotalCount()
	arg_22_0:FlushCapacity()

	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.ClosePage

	IslandInventoryUpgradePage = var_1_10004

	var_22_1(var_22_0, var_1_10004)

	return
end

function var_0_1.OnSell(arg_23_0)
	arg_23_0.mode = var_0_1.MODE_VIEW

	arg_23_0:SetTotalCount()
	arg_23_0:UpdateStyle()
	arg_23_0:FlushCapacity()

	arg_23_0.sellPriceTxt.text = "x 0"

	return
end

function var_0_1.SetUp(arg_24_0)
	IslandItem = var_1_10001
	arg_24_0.tagType = var_1_10001.TYPE_MATERIAL
	arg_24_0.mode = var_0_1.MODE_VIEW
	arg_24_0.asc = true
	arg_24_0.cards = {}

	arg_24_0:FlushTags()
	arg_24_0:FlushFilterBtn()
	arg_24_0:FlushSortBtn()
	arg_24_0:FlushList()
	arg_24_0:FlushCapacity()
	arg_24_0:UpdateStyle()

	return
end

function var_0_1.FlushCapacity(arg_25_0)
	local var_25_0 = arg_25_0.tagType

	IslandItem = var_1_10002

	if var_25_0 == var_1_10002.TYPE_MATERIAL then
		setActive = var_25_0

		var_25_0(arg_25_0.upgradeBtn, true)

		setActive = var_25_0

		var_25_0(arg_25_0.batchSellBtn, true)

		getProxy = var_25_0
		IslandProxy = var_3

		local var_25_1 = var_25_0(var_3)
		local var_25_2 = var_1.GetIsland(var_25_1)
		local var_25_3 = var_1.GetInventoryAgency(var_25_2)
		local var_25_4 = var_1.GetLength(var_25_3)
		local var_25_5 = var_1
		local var_25_6 = var_1.GetCapacity(var_25_5)

		setButtonEnabled = var_25_3

		local var_25_7 = arg_25_0.upgradeBtn
		local var_25_8 = var_1

		var_25_3(var_25_7, not var_1.IsMaxLevel(var_25_8))

		local var_25_9 = var_25_4 / var_25_6

		math = var_25_5

		local var_25_10 = var_25_5.min(var_25_9, 1)
		local var_25_11 = arg_25_0
		local var_25_12 = arg_25_0.managedTween

		LeanTween = var_25_8

		local var_25_13 = var_25_8.value
		local var_25_14

		go = var_1_10011

		local var_25_15 = var_25_12(var_25_11, var_25_13, var_25_14, var_1_10011(arg_25_0.upgradeBtn), 0, var_25_9, var_25_10)
		local var_25_16 = var_6.setOnUpdate

		System = var_25_13

		local var_25_17 = var_25_16(var_25_15, var_25_13.Action_float(function(arg_26_0)
			local var_26_0 = arg_25_0.capacityTxt

			calcFloor = var_2_10002
			var_26_0.text = var_2_10002(var_25_6 * arg_26_0) .. "/" .. var_25_6
			setFillAmount = var_26_0

			var_26_0(arg_25_0.upgradeProg, arg_26_0)

			return
		end))
		local var_25_18 = var_6.setOnComplete

		System = var_9

		var_25_18(var_25_17, var_9.Action(function()
			local var_27_0 = arg_25_0.capacityTxt

			var_27_0.text = var_25_4 .. "/" .. var_25_6
			setFillAmount = var_27_0

			var_27_0(arg_25_0.upgradeProg, var_25_9)

			return
		end))

		if 0.85 < var_25_9 then
			Color = var_25_19

			local var_25_19

			if not var_25_19.New(0.9529411764705882, 0.4235294117647059, 0.43137254901960786, 1) then
				Color = var_25_19
				var_25_19 = var_25_19.New(0.2235294117647059, 0.7450980392156863, 1, 1)
			end

			local var_25_20 = arg_25_0.upgradeProg
			local var_25_21 = var_7.GetComponent

			typeof = var_25_14
			Image = var_12
			var_25_21(var_25_20, var_25_14(var_12)).color = var_25_19

			if false then
				if arg_25_0.tagType == var_0_1.INVENTORY_TYPE_OVERFLOW then
					setActive = var_1

					var_1(arg_25_0.upgradeBtn, false)

					setActive = var_1

					var_1(arg_25_0.batchSellBtn, true)
				else
					setActive = var_1

					var_1(arg_25_0.upgradeBtn, false)

					setActive = var_1

					var_1(arg_25_0.batchSellBtn, false)
				end
			end

			return
		end
	end
end

function var_0_1.FlushTags(arg_28_0)
	pairs = var_1_10001

	for iter_28_0, iter_28_1 in var_1_10001(arg_28_0.toggles) do
		onToggle = var_1_10006

		local var_28_0 = arg_28_0
		local var_28_1 = iter_28_1

		local function var_28_2(arg_29_0)
			if arg_29_0 then
				local var_29_0 = arg_28_0

				var_1.CheckEditMode(var_29_0, iter_28_0)

				arg_28_0.tagType = iter_28_0

				local var_29_1 = arg_28_0

				var_1.FlushCapacity(var_29_1)

				local var_29_2 = arg_28_0

				var_1.FlushSortBtn(var_29_2)

				local var_29_3 = arg_28_0

				var_1.SetTotalCount(var_29_3)

				local var_29_4 = arg_28_0

				var_1.UpdateStyle(var_29_4)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_28_0, var_28_1, var_28_2, var_1_10011)

		if iter_28_0 == var_0_1.INVENTORY_TYPE_OVERFLOW then
			setText = var_1_10006

			local var_28_3 = iter_28_1:Find("Text")

			i18n = var_28_1

			var_1_10006(var_28_3, var_28_1("island_word_temp"))
		else
			setText = var_1_10006

			local var_28_4 = iter_28_1:Find("Text")

			IslandItemKind = var_28_1

			var_1_10006(var_28_4, var_28_1.Type2TagName(iter_28_0))
		end
	end

	arg_28_0:ActiveDefaultTag()

	return
end

function var_0_1.ActiveDefaultTag(arg_30_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_30_0 = var_1_10001(var_1_10003)
	local var_30_1 = var_1.GetIsland(var_30_0)
	local var_30_2 = var_1.GetInventoryAgency(var_30_1)
	local var_30_3 = var_1.ExistAnyOverFlowItem(var_30_2)

	setActive = var_30_1

	var_30_1(arg_30_0.toggles[var_0_1.INVENTORY_TYPE_OVERFLOW], var_30_3)

	if var_30_3 then
		triggerToggle = var_30_1

		var_30_1(arg_30_0.toggles[var_0_1.INVENTORY_TYPE_OVERFLOW], true)
	else
		triggerToggle = var_30_1

		local var_30_4 = arg_30_0.toggles

		IslandItem = var_6

		var_30_1(var_30_4[var_6.TYPE_MATERIAL], true)
	end

	return
end

function var_0_1.CheckEditMode(arg_31_0, arg_31_1)
	if arg_31_0.tagType ~= arg_31_1 and arg_31_0.mode == var_0_1.MODE_EDIT then
		triggerButton = var_2

		var_2(arg_31_0.sellCancelBtn)
	end

	return
end

function var_0_1.FlushFilterBtn(arg_32_0)
	onButton = var_1_10001

	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.filterBtn

	local function var_32_2()
		local var_33_0 = arg_32_0
		local var_33_1 = var_0.GetIndexData(var_33_0, arg_32_0.tagType)
		local var_33_2 = arg_32_0
		local var_33_3 = var_1.OpenPage

		IslandInventoryIndexPage = var_2_10004

		var_33_3(var_33_2, var_2_10004, var_33_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_32_0, var_32_1, var_32_2, var_1_10006)

	return
end

function var_0_1.FlushSortBtn(arg_34_0)
	local function var_34_0()
		local var_35_0 = arg_34_0
		local var_35_1 = var_0.GetIndexData(var_35_0, arg_34_0.tagType)

		arg_34_0.orderTxt.text = var_35_1:GetSortText()

		local var_35_2 = arg_34_0.orderArr

		if arg_34_0.asc then
			Vector2 = var_35_3

			local var_35_3

			if not var_35_3(1, -1, 1) then
				Vector2 = var_35_3
				var_35_3 = var_35_3(1, 1, 1)
			end

			var_35_2.localScale = var_35_3

			return
		end
	end

	onButton = var_1_10002

	local var_34_1 = arg_34_0
	local var_34_2 = arg_34_0.orderBtn

	local function var_34_3()
		arg_34_0.asc = not arg_34_0.asc

		var_34_0()

		local var_36_0 = arg_34_0

		var_0.SetTotalCount(var_36_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_34_1, var_34_2, var_34_3, var_1_10007)
	var_34_0()

	return
end

function var_0_1.FlushList(arg_37_0)
	function arg_37_0.scrollRect.onInitItem(arg_38_0)
		local var_38_0 = arg_37_0

		var_1.OnInitItem(var_38_0, arg_38_0)

		return
	end

	function arg_37_0.scrollRect.onUpdateItem(arg_39_0, arg_39_1)
		local var_39_0 = arg_37_0

		var_2.OnUpdateItem(var_39_0, arg_39_0, arg_39_1)

		return
	end

	arg_37_0:SetTotalCount()

	return
end

function var_0_1.SetTotalCount(arg_40_0)
	arg_40_0.displays = arg_40_0:Filter()
	arg_40_0.values = {}
	arg_40_0.selAllFlag = false
	ipairs = var_1

	for iter_40_0, iter_40_1 in var_1(arg_40_0.displays) do
		table = var_1_10006

		var_1_10006.insert(arg_40_0.values, 0)
	end

	local var_40_0 = arg_40_0:GetIndexData(arg_40_0.tagType)

	table = var_2

	var_2.sort(arg_40_0.displays, function(arg_41_0, arg_41_1)
		local var_41_0 = var_40_0

		return var_2.Sort(var_41_0, arg_41_0, arg_41_1, arg_40_0.asc)
	end)

	local var_40_1 = arg_40_0.scrollRect

	var_2.SetTotalCount(var_40_1, #arg_40_0.displays, -1)

	return
end

function var_0_1.OnInitItem(arg_42_0, arg_42_1)
	IslandItemCard = var_1_10002

	local var_42_0 = var_1_10002.New(arg_42_1)

	onButton = var_1_10003

	local var_42_1 = arg_42_0
	local var_42_2 = var_42_0._go

	local function var_42_3()
		if arg_42_0.mode == var_0_1.MODE_VIEW then
			if arg_42_0.tagType ~= var_0_1.INVENTORY_TYPE_OVERFLOW then
				local var_43_0 = arg_42_0

				var_0.OnClickItem(var_43_0, var_42_0)
			end
		elseif arg_42_0.mode == var_0_1.MODE_EDIT then
			local var_43_1 = arg_42_0

			var_0.OnClickItemForSell(var_43_1, var_42_0)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_42_1, var_42_2, var_42_3, var_1_10008)

	onButton = var_1_10003

	local var_42_4 = arg_42_0
	local var_42_5 = var_42_0.reduceBtn

	local function var_42_6()
		if arg_42_0.mode == var_0_1.MODE_EDIT then
			local var_44_0 = arg_42_0

			var_0.UpdateSellPrice(var_44_0, var_42_0, -1)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_42_4, var_42_5, var_42_6, var_1_10008)

	onInputEndEdit = var_1_10003

	var_1_10003(arg_42_0, var_42_0.valueInput, function(arg_45_0)
		table = var_2_10001

		if not var_2_10001.indexof(arg_42_0.displays, var_42_0.item) then
			return
		end

		local var_45_0 = 0

		if arg_45_0 and arg_45_0 ~= "" then
			tonumber = var_3

			if not var_3(arg_45_0) then
				local var_45_1 = 1
			end

			tonumber = var_3

			local var_45_2 = var_3(arg_45_0) - arg_42_0.values[var_1]
			local var_45_3 = arg_42_0

			var_5.UpdateSellPrice(var_45_3, var_42_0, var_45_2)

			return
		end
	end)

	pressPersistTrigger = var_1_10003

	local var_42_7 = var_42_0.calcPanel
	local var_42_8 = 0.5

	local function var_42_9()
		if arg_42_0.mode == var_0_1.MODE_EDIT then
			local var_46_0 = arg_42_0

			var_0.UpdateSellPrice(var_46_0, var_42_0, 1)
		end

		return
	end

	local var_42_10
	local var_42_11 = true
	local var_42_12 = true
	local var_42_13 = 0.1

	SFX_PANEL = var_1_10012

	var_1_10003(var_42_7, var_42_8, var_42_9, var_42_10, var_42_11, var_42_12, var_42_13, var_1_10012)

	arg_42_0.cards[arg_42_1] = var_42_0

	return
end

function var_0_1.OnClickItem(arg_47_0, arg_47_1)
	isa = var_1_10002

	local var_47_0 = arg_47_1.item

	IslandInvitation = var_1_10005

	if var_1_10002(var_47_0, var_1_10005) then
		local var_47_1 = arg_47_1.item
		local var_47_2 = var_2.GetShipName(var_47_1)
		local var_47_3 = arg_47_0
		local var_47_4 = arg_47_0.ShowMsgBox

		var_1_10006 = {}
		i18n = var_1_10007
		var_1_10006.content = var_1_10007("island_open_ship_tip")

		function var_1_10006.onYes()
			local var_48_0 = arg_47_0

			var_0.Hide(var_48_0)

			local var_48_1 = arg_47_0
			local var_48_2 = var_0.emit

			IslandBaseMediator = var_2_10003

			local var_48_3 = var_2_10003.SWITCH_MAP

			IslandConst = var_2_10004

			local var_48_4 = var_2_10004.LABORATORY_MAP_ID

			IslandConst = var_2_10005

			var_48_2(var_48_1, var_48_3, var_48_4, var_2_10005.LETTEROFINVITATION_SP)

			return
		end

		var_47_4(var_47_3, var_1_10006)
	else
		local var_47_5 = arg_47_0
		local var_47_6 = arg_47_0.ShowMsgBox
		local var_47_7 = {}

		i18n = var_1_10006
		var_47_7.title = var_1_10006("island_word_desc")
		IslandMsgBox = var_6
		var_47_7.type = var_6.TYPE_COMMON_ITEM
		var_47_7.itemId = arg_47_1.item.id

		var_47_6(var_47_5, var_47_7)
	end

	return
end

function var_0_1.OnClickItemForSell(arg_49_0, arg_49_1)
	arg_49_0:UpdateSellPrice(arg_49_1, 1)

	return
end

function var_0_1._IsSelAll(arg_50_0)
	ipairs = var_1_10001

	for iter_50_0, iter_50_1 in var_1_10001(arg_50_0.values) do
		local var_50_0 = arg_50_0.displays[iter_50_0]

		if iter_50_1 ~= var_6.GetCount(var_50_0) then
			return false
		end
	end

	return true
end

function var_0_1.CheckSelAllFlag(arg_51_0)
	arg_51_0.selAllFlag = arg_51_0:_IsSelAll()
	setActive = var_1

	var_1(arg_51_0.sellAllFlagTF, arg_51_0.selAllFlag)

	return
end

function var_0_1.UpdataSelAll(arg_52_0)
	arg_52_0.values = {}
	ipairs = var_1

	for iter_52_0, iter_52_1 in var_1(arg_52_0.displays) do
		arg_52_0.values[iter_52_0] = iter_52_1:GetCount()
	end

	local var_52_0 = arg_52_0.scrollRect

	var_1.SetTotalCount(var_52_0, #arg_52_0.displays, -1)

	local var_52_1 = 0

	ipairs = var_2

	for iter_52_2, iter_52_3 in var_2(arg_52_0.values) do
		local var_52_2 = arg_52_0.displays[iter_52_2]

		var_52_1 = var_7.GetConvertPt(var_52_2) * iter_52_3 + var_52_1
	end

	arg_52_0.sellPriceTxt.text = "x " .. var_52_1
	arg_52_0.selAllFlag = true
	setActive = var_2

	var_2(arg_52_0.sellAllFlagTF, arg_52_0.selAllFlag)

	return
end

function var_0_1.UpdataUnselAll(arg_53_0)
	arg_53_0:SetTotalCount()

	arg_53_0.sellPriceTxt.text = "x 0"
	arg_53_0.selAllFlag = false
	setActive = var_1

	var_1(arg_53_0.sellAllFlagTF, arg_53_0.selAllFlag)

	return
end

function var_0_1.UpdateSellPrice(arg_54_0, arg_54_1, arg_54_2)
	table = var_1_10003

	if not var_1_10003.indexof(arg_54_0.displays, arg_54_1.item) then
		return
	end

	local var_54_0 = arg_54_0.values[var_3] + arg_54_2
	local var_54_1 = arg_54_0.values

	math = var_6

	local var_54_2 = var_6.max
	local var_54_3 = 0

	math = var_1_10009

	local var_54_4 = var_1_10009.min
	local var_54_5 = var_54_0
	local var_54_6 = arg_54_1.item

	var_54_1[var_3] = var_54_2(var_54_3, var_54_4(var_54_5, var_12.GetCount(var_54_6)))

	arg_54_1:UpdateValue(arg_54_0.values[var_3])

	local var_54_7 = 0

	ipairs = var_6

	for iter_54_0, iter_54_1 in var_6(arg_54_0.values) do
		local var_54_8 = arg_54_0.displays[iter_54_0]

		var_54_7 = var_11.GetConvertPt(var_54_8) * iter_54_1 + var_54_7
	end

	arg_54_0.sellPriceTxt.text = "x " .. var_54_7

	arg_54_0:CheckSelAllFlag()

	return
end

function var_0_1.OnUpdateItem(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0

	if not arg_55_0.cards[arg_55_2] then
		arg_55_0:OnInitItem(arg_55_2)

		var_55_0 = arg_55_0.cards[arg_55_2]
	end

	if arg_55_0.displays[arg_55_1 + 1] then
		var_55_0:Update(arg_55_0.displays[arg_55_1 + 1], arg_55_0.mode, arg_55_0.values[arg_55_1 + 1], arg_55_0.tagType)
	end

	return
end

function var_0_1.Filter(arg_56_0)
	local var_56_0 = {}

	if arg_56_0.tagType == var_0_1.INVENTORY_TYPE_OVERFLOW then
		arg_56_0:CollectOverFlowInventoryItems(var_56_0)
	else
		arg_56_0:CollectCommonInventoryItems(var_56_0)
	end

	if arg_56_0.mode == var_0_1.MODE_EDIT then
		underscore = var_2
		var_56_0 = var_2.select(var_56_0, function(arg_57_0)
			return arg_57_0:CanConvert()
		end)
	end

	return var_56_0
end

function var_0_1.CollectOverFlowInventoryItems(arg_58_0, arg_58_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_58_0 = var_1_10002(var_1_10004)
	local var_58_1 = var_2.GetIsland(var_58_0)
	local var_58_2 = var_2.GetInventoryAgency(var_58_1)
	local var_58_3 = var_2.GetOverflowItemList(var_58_2)

	pairs = var_58_1

	for iter_58_0, iter_58_1 in var_58_1(var_58_3) do
		table = var_1_10009

		var_1_10009.insert(arg_58_1, iter_58_1)
	end

	return
end

function var_0_1.CollectCommonInventoryItems(arg_59_0, arg_59_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_59_0 = var_1_10002(var_1_10004)
	local var_59_1 = var_2.GetIsland(var_59_0)
	local var_59_2 = var_2.GetInventoryAgency(var_59_1)
	local var_59_3 = var_2.GetGroupedItemList(var_59_2)

	ipairs = var_59_1

	for iter_59_0, iter_59_1 in var_59_1(var_59_3) do
		local var_59_4 = arg_59_0.tagType

		IslandItem = var_1_10010

		if var_59_4 == var_1_10010.TYPE_MATERIAL then
			var_1_10011 = iter_59_1

			if iter_59_1.IsMaterial(var_1_10011) then
				local var_59_5 = arg_59_0.indexDatas

				IslandItem = var_1_10010
				var_1_10011 = var_59_5[var_1_10010.TYPE_MATERIAL]

				if var_9.Match(var_1_10011, iter_59_1) then
					table = var_9

					var_9.insert(arg_59_1, iter_59_1)

					goto label_59_0
				end
			end
		end

		do
			local var_59_6 = arg_59_0.tagType

			IslandItem = var_1_10010

			if var_59_6 == var_1_10010.TYPE_PROP then
				var_1_10011 = iter_59_1

				if iter_59_1.IsProp(var_1_10011) then
					local var_59_7 = arg_59_0.indexDatas

					IslandItem = var_1_10010
					var_1_10011 = var_59_7[var_1_10010.TYPE_PROP]

					if var_9.Match(var_1_10011, iter_59_1) then
						table = var_9

						var_9.insert(arg_59_1, iter_59_1)

						goto label_59_0
					end
				end
			end

			local var_59_8 = arg_59_0.tagType

			IslandItem = var_1_10010

			if var_59_8 == var_1_10010.TYPE_SPECIAL_PROP then
				var_1_10011 = iter_59_1

				if iter_59_1.IsSpecialProp(var_1_10011) then
					local var_59_9 = arg_59_0.indexDatas

					IslandItem = var_1_10010
					var_1_10011 = var_59_9[var_1_10010.TYPE_SPECIAL_PROP]

					if var_9.Match(var_1_10011, iter_59_1) then
						table = var_9

						var_9.insert(arg_59_1, iter_59_1)
					end
				end
			end
		end

		::label_59_0::
	end

	local var_59_10 = arg_59_0.tagType

	IslandItem = var_5

	if var_59_10 == var_5.TYPE_SPECIAL_PROP then
		getProxy = var_59_10
		IslandProxy = var_6

		local var_59_11 = var_59_10(var_6)
		local var_59_12 = var_4.GetIsland(var_59_11)
		local var_59_13 = var_4.GetCharacterAgency(var_59_12)
		local var_59_14 = var_4.GetInviteList(var_59_13)

		ipairs = var_59_12

		for iter_59_2, iter_59_3 in var_59_12(var_59_14) do
			IslandInvitation = var_1_10011
			var_1_10011 = var_1_10011.New(iter_59_3)

			local var_59_15 = arg_59_0.indexDatas

			IslandItem = var_13

			local var_59_16 = var_59_15[var_13.TYPE_SPECIAL_PROP]

			if var_12.Match(var_59_16, var_1_10011) then
				table = var_12

				var_12.insert(arg_59_1, var_1_10011)
			end
		end
	end

	return
end

function var_0_1.OnDestroy(arg_60_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_60_0.scrollRect)

	pairs = var_1_10001

	for iter_60_0, iter_60_1 in var_1_10001(arg_60_0.cards) do
		iter_60_1:Dispose()
	end

	arg_60_0.cards = {}

	return
end

return var_0_1
