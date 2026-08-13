class = var_0_10000

local var_0_0 = "IslandRestaurantPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

var_0_1.MAX_ASSISTANT_CNT = 2
var_0_1.MAX_SHELF_CNT = 5
Vector3 = var_1

local var_0_2 = var_1(-210, 50)

pg = var_0_0

local var_0_3 = var_0_0.island_item_data_template

pg = var_3

local var_0_4 = var_3.island_set

pg = var_4

local var_0_5 = var_4.island_buff_template

function var_0_1.getUIName(arg_1_0)
	return "IslandRestaurantUI"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "top/title/Text")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("island_manage_title"))

	local var_2_2 = arg_2_0._tf

	arg_2_0.rankTF = var_1.Find(var_2_2, "rank")

	local var_2_3 = arg_2_0.rankTF

	arg_2_0.rankIcon = var_1.Find(var_2_3, "icon")

	local var_2_4 = arg_2_0.rankTF

	arg_2_0.rankSlider = var_1.Find(var_2_4, "exp")

	local var_2_5 = arg_2_0.rankTF

	arg_2_0.rankText = var_1.Find(var_2_5, "exp/progress")

	local var_2_6 = arg_2_0._tf

	arg_2_0.eventContainer = var_1.Find(var_2_6, "content/event_container")

	local var_2_7 = arg_2_0.eventContainer

	arg_2_0.eventTitleTF = var_1.Find(var_2_7, "event/title")

	local var_2_8 = arg_2_0.eventContainer

	arg_2_0.eventDescTF = var_1.Find(var_2_8, "event/desc/Text")
	setText = var_1

	local var_2_9 = arg_2_0.eventContainer

	var_1(var_3.Find(var_2_9, "event/desc/effect"), "")

	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_3.Find(var_2_11, "content/event_container/event/items")
	local var_2_13 = arg_2_0._tf

	arg_2_0.itemsList = var_2_10(var_2_12, var_4.Find(var_2_13, "content/event_container/event/items/tpl"))
	UIItemList = var_1

	local var_2_14 = var_1.New
	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_3.Find(var_2_15, "content/event_container/event/addition")
	local var_2_17 = arg_2_0._tf

	arg_2_0.additionList = var_2_14(var_2_16, var_4.Find(var_2_17, "content/event_container/event/addition/tpl"))

	local var_2_18 = arg_2_0._tf

	arg_2_0.windowContainer = var_1.Find(var_2_18, "content/window_container")

	local var_2_19 = arg_2_0.windowContainer
	local var_2_20 = var_1.Find(var_2_19, "window")

	arg_2_0.nameTF = var_1.Find(var_2_20, "name/Text")
	arg_2_0.nameEnTF = var_1:Find("name_en/Text")

	local var_2_21 = var_1
	local var_2_22 = var_1.Find(var_2_21, "left/content")

	UIItemList = var_2_19
	arg_2_0.shipUIList = var_2_19.New(var_2_22, var_2_22:Find("tpl"))
	setText = var_3

	local var_2_23 = var_2_22:Find("tpl/empty/Image/Text")

	i18n = var_6

	var_3(var_2_23, var_6("island_manage_sel_worker"))

	setText = var_3

	local var_2_24 = var_2_22:Find("tpl/lock/Image/Text")

	i18n = var_6

	var_3(var_2_24, var_6("island_manage_upgrade_worker_level"))

	setText = var_3

	local var_2_25 = var_2_22:Find("tpl/ship/skill/invalid/Text")

	i18n = var_6

	var_3(var_2_25, var_6("island_manage_skill_cant_use"))

	arg_2_0.commoditiesTF = var_1:Find("right/commodities")
	arg_2_0.commoditiesEmptyTF = var_1:Find("right/commodities_empty")
	setText = var_3

	local var_2_26 = arg_2_0.commoditiesEmptyTF

	i18n = var_6

	var_3(var_2_26, var_6("island_manage_stock_out"))

	local var_2_27 = arg_2_0.commoditiesTF

	arg_2_0.scrollRect = var_3.GetComponent(var_2_27, "LScrollRect")
	arg_2_0.detailPanel = var_1:Find("right/detail")

	local var_2_28 = arg_2_0.detailPanel

	arg_2_0.detailNameTF = var_3.Find(var_2_28, "dot/name")

	local var_2_29 = arg_2_0.detailPanel

	arg_2_0.detailPriceTF = var_3.Find(var_2_29, "price/value")

	local var_2_30 = arg_2_0.detailPanel

	arg_2_0.detailDescTF = var_3.Find(var_2_30, "desc")

	local var_2_31 = arg_2_0.detailPanel

	arg_2_0.detailEffectTF = var_3.Find(var_2_31, "effect/Text")
	arg_2_0.shelfsTF = var_1:Find("right/shelfs")
	setText = var_3

	local var_2_32 = arg_2_0.shelfsTF
	local var_2_33 = var_5.Find(var_2_32, "infos/tip")

	i18n = var_6

	var_3(var_2_33, var_6("island_manage_item_select"))

	local var_2_34 = arg_2_0.shelfsTF

	arg_2_0.extraCapacityTF = var_3.Find(var_2_34, "infos/capacity")
	setText = var_3

	local var_2_35 = arg_2_0.extraCapacityTF
	local var_2_36 = var_5.Find(var_2_35, "name")

	i18n = var_6

	var_3(var_2_36, var_6("island_manage_capacity"))

	local var_2_37 = arg_2_0.extraCapacityTF

	arg_2_0.extraCapacityEffectTF = var_3.Find(var_2_37, "effect")
	UIItemList = var_3

	local var_2_38 = var_3.New
	local var_2_39 = arg_2_0.shelfsTF
	local var_2_40 = var_5.Find(var_2_39, "content")
	local var_2_41 = arg_2_0.shelfsTF

	arg_2_0.shelfUIList = var_2_38(var_2_40, var_6.Find(var_2_41, "content/tpl"))

	local var_2_42 = var_1
	local var_2_43 = var_1.Find(var_2_42, "estimate")

	setText = var_2_21

	local var_2_44 = var_2_43:Find("Text")

	i18n = var_2_39

	var_2_21(var_2_44, var_2_39("island_manage_predict_saleroom"))

	setText = var_2_21

	local var_2_45 = var_2_43:Find("count/Text")

	i18n = var_7

	var_2_21(var_2_45, var_7("island_manage_cnt"))

	setText = var_2_21

	local var_2_46 = var_2_43:Find("sales/Text")

	i18n = var_7

	var_2_21(var_2_46, var_7("island_manage_saleroom") .. ":")

	arg_2_0.estimateCntTF = var_2_43:Find("count/value")
	arg_2_0.estimateSalesTF = var_2_43:Find("sales/value")
	arg_2_0.buffInfoBtn = var_2_43:Find("info")
	arg_2_0.buffInfoPanel = var_2_43:Find("info_panel")
	setText = var_4

	local var_2_47 = arg_2_0.buffInfoPanel
	local var_2_48 = var_6.Find(var_2_47, "Text")

	i18n = var_7

	var_4(var_2_48, var_7("island_manage_addition"))

	UIItemList = var_4

	local var_2_49 = var_4.New
	local var_2_50 = arg_2_0.buffInfoPanel
	local var_2_51 = var_6.Find(var_2_50, "effects")
	local var_2_52 = arg_2_0.buffInfoPanel

	arg_2_0.buffInfoUIList = var_2_49(var_2_51, var_7.Find(var_2_52, "effects/tpl"))

	local var_2_53 = arg_2_0.buffInfoPanel

	arg_2_0.buffInfoEmptyTF = var_4.Find(var_2_53, "empty")
	setText = var_4

	local var_2_54 = arg_2_0.buffInfoEmptyTF
	local var_2_55 = var_6.Find(var_2_54, "Text")

	i18n = var_7

	var_4(var_2_55, var_7("island_manage_no_addition"))

	setText = var_4

	local var_2_56 = arg_2_0.buffInfoPanel
	local var_2_57 = var_6.Find(var_2_56, "tips")

	i18n = var_7

	var_4(var_2_57, var_7("island_manage_buff_tip"))

	arg_2_0.btnsTF = var_1:Find("btns")

	local var_2_58 = arg_2_0.btnsTF
	local var_2_59 = var_4.Find(var_2_58, "prepare/open")

	setText = var_2_42

	local var_2_60 = arg_2_0.btnsTF
	local var_2_61 = var_7.Find(var_2_60, "prepare/auto/Text")

	i18n = var_2_56

	var_2_42(var_2_61, var_2_56("island_manage_auto_work"))

	arg_2_0.openBtn = var_2_59
	setText = var_2_59

	local var_2_62 = arg_2_0.btnsTF
	local var_2_63 = var_6.Find(var_2_62, "prepare/open/Text")

	i18n = var_2_61

	var_2_59(var_2_63, var_2_61("island_manage_start_work"))

	setText = var_2_59

	local var_2_64 = arg_2_0.btnsTF
	local var_2_65 = var_6.Find(var_2_64, "opening/Text")

	i18n = var_7

	var_2_59(var_2_65, var_7("island_manage_working"))

	setText = var_2_59

	local var_2_66 = arg_2_0.btnsTF
	local var_2_67 = var_6.Find(var_2_66, "close/Text")

	i18n = var_7

	var_2_59(var_2_67, var_7("island_manage_result"))

	setText = var_2_59

	local var_2_68 = arg_2_0.btnsTF
	local var_2_69 = var_6.Find(var_2_68, "end/Text")

	i18n = var_7

	var_2_59(var_2_69, var_7("island_manage_end_daily_work"))

	setText = var_2_59

	local var_2_70 = arg_2_0._tf
	local var_2_71 = var_6.Find(var_2_70, "content/event_container/event/title/Text")

	i18n = var_7

	var_2_59(var_2_71, var_7("island_post_event_addition_label"))

	local var_2_72 = arg_2_0.btnsTF

	arg_2_0.ticketBtn = var_4.Find(var_2_72, "opening/ticket")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/title/help")

	local function var_3_3()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_4_2.type = var_2_10004
		pg = var_2_10004
		var_4_2.helps = var_2_10004.gametip.island_help_manage.tip

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_4.Find(var_3_5, "top/back")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_3_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.rankTF

	local function var_3_10()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.OpenPage

		IslandRestaurantRankPage = var_2_10003

		var_6_1(var_6_0, var_2_10003, arg_3_0.restId)

		return
	end

	SFX_PANEL = var_3_5

	var_1_10001(var_3_8, var_3_9, var_3_10, var_3_5)

	onButton = var_1_10001

	local var_3_11 = arg_3_0
	local var_3_12 = arg_3_0.btnsTF
	local var_3_13 = var_4.Find(var_3_12, "prepare/auto")

	local function var_3_14()
		if not arg_3_0.isOperable then
			return
		end

		local var_7_0 = arg_3_0

		var_0.OnAutoSelect(var_7_0)

		return
	end

	SFX_PANEL = var_3_12

	var_1_10001(var_3_11, var_3_13, var_3_14, var_3_12)

	onButton = var_1_10001

	local var_3_15 = arg_3_0
	local var_3_16 = arg_3_0.openBtn

	local function var_3_17()
		local var_8_0 = {}

		ipairs = var_2_10001

		for iter_8_0, iter_8_1 in var_2_10001(arg_3_0.assistantsData) do
			var_8_0[iter_8_1.id] = arg_3_0.selectedShipIds[iter_8_0]
		end

		local var_8_1 = arg_3_0
		local var_8_2 = var_1.emit

		IslandMediator = iter_8_0

		var_8_2(var_8_1, iter_8_0.OPEN_RESTAURANT, {
			restId = arg_3_0.restId,
			ships = var_8_0,
			commodities = arg_3_0.selectedDic,
			estimateData = {
				trade_id = arg_3_0.restId,
				sell_num_min = arg_3_0.totalMinCnt,
				sell_num_max = arg_3_0.totalMaxCnt,
				sell_money_min = arg_3_0.totalMinSales,
				sell_money_max = arg_3_0.totalMaxSales
			}
		})

		return
	end

	SFX_PANEL = var_3_12

	var_1_10001(var_3_15, var_3_16, var_3_17, var_3_12)

	onButton = var_1_10001

	local var_3_18 = arg_3_0
	local var_3_19 = arg_3_0.btnsTF
	local var_3_20 = var_4.Find(var_3_19, "close")

	local function var_3_21()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		IslandMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.CLOSE_RESTAURANT, arg_3_0.restId, arg_3_0.isPost)

		return
	end

	SFX_PANEL = var_3_19

	var_1_10001(var_3_18, var_3_20, var_3_21, var_3_19)

	onButton = var_1_10001

	local var_3_22 = arg_3_0
	local var_3_23 = arg_3_0.buffInfoBtn

	local function var_3_24()
		isActive = var_2_10000

		if var_2_10000(arg_3_0.buffInfoPanel) then
			setActive = var_0

			var_0(arg_3_0.buffInfoPanel, false)
		else
			setActive = var_0

			var_0(arg_3_0.buffInfoPanel, true)

			local var_10_0 = arg_3_0.buffInfoUIList

			var_0.align(var_10_0, #arg_3_0.buffInfos)

			setActive = var_0

			var_0(arg_3_0.buffInfoEmptyTF, #arg_3_0.buffInfos == 0)
		end

		return
	end

	SFX_PANEL = var_3_19

	var_1_10001(var_3_22, var_3_23, var_3_24, var_3_19)

	onButton = var_1_10001

	local var_3_25 = arg_3_0
	local var_3_26 = arg_3_0.ticketBtn

	local function var_3_27()
		local var_11_0 = arg_3_0
		local var_11_1 = var_0.OpenPage

		IslandTicketUsePage = var_2_10003
		IslandUseTicketCommand = var_2_10004

		var_11_1(var_11_0, var_2_10003, var_2_10004.TYPES.MANAGE, arg_3_0.restId)

		return
	end

	SFX_PANEL = var_3_19

	var_1_10001(var_3_25, var_3_26, var_3_27, var_3_19)

	local var_3_28 = arg_3_0.shipUIList

	var_1.make(var_3_28, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_3_0

			var_3.UpdateShipItem(var_12_0, arg_12_1, arg_12_2)
		end

		return
	end)

	function arg_3_0.scrollRect.onInitItem(arg_13_0)
		local var_13_0 = arg_3_0

		var_1.OnInitItem(var_13_0, arg_13_0)

		return
	end

	function arg_3_0.scrollRect.onUpdateItem(arg_14_0, arg_14_1)
		local var_14_0 = arg_3_0

		var_2.OnUpdateItem(var_14_0, arg_14_0, arg_14_1)

		return
	end

	local var_3_29 = arg_3_0.shelfUIList

	var_1.make(var_3_29, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_3_0

			var_3.UpdateShelfItem(var_15_0, arg_15_1, arg_15_2)
		end

		return
	end)

	local var_3_30 = arg_3_0.buffInfoUIList

	var_1.make(var_3_30, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = arg_3_0.buffInfos[arg_16_1 + 1]

			setText = var_4

			var_4(arg_16_2:Find("bg/name"), var_16_0.name)

			setText = var_4

			var_4(arg_16_2:Find("bg/effect"), var_16_0.effect)
		end

		return
	end)

	arg_3_0.priceFactor = var_0_4.island_manage_price_coefficient.key_value_int / 100
	arg_3_0.argA = var_0_4.island_manage_sale_coefficient_a.key_value_int / 100
	arg_3_0.argB = var_0_4.island_manage_sale_coefficient_b.key_value_int / 100
	arg_3_0.argC = var_0_4.island_manage_sale_coefficient_c.key_value_int / 100
	arg_3_0.saleConst = var_0_4.island_manage_sale_constant.key_value_int / 100
	pg = var_1
	arg_3_0.maxAttrEffect = var_1.island_chara_att[1].manage_effect / 16
	arg_3_0.minSaleCnt = var_0_4.island_manage_sale_limit.key_value_int

	return
end

function var_0_1.AddListeners(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.AddListener

	GAME = var_1_10004

	var_17_1(var_17_0, var_1_10004.ISLAND_OPEN_RESTAURANT_DONE, arg_17_0.Flush)

	local var_17_2 = arg_17_0
	local var_17_3 = arg_17_0.AddListener

	GAME = var_4

	var_17_3(var_17_2, var_4.ISLAND_CLOSE_RESTAURANT_DONE, arg_17_0.Flush)

	local var_17_4 = arg_17_0
	local var_17_5 = arg_17_0.AddListener

	IslandManageAgecny = var_4

	var_17_5(var_17_4, var_4.ON_DAILY_REFRESH, arg_17_0.Flush)

	return
end

function var_0_1.RemoveListeners(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.RemoveListener

	GAME = var_1_10004

	var_18_1(var_18_0, var_1_10004.ISLAND_OPEN_RESTAURANT_DONE, arg_18_0.Flush)

	local var_18_2 = arg_18_0
	local var_18_3 = arg_18_0.RemoveListener

	GAME = var_4

	var_18_3(var_18_2, var_4.ISLAND_CLOSE_RESTAURANT_DONE, arg_18_0.Flush)

	local var_18_4 = arg_18_0
	local var_18_5 = arg_18_0.RemoveListener

	IslandManageAgecny = var_4

	var_18_5(var_18_4, var_4.ON_DAILY_REFRESH, arg_18_0.Flush)

	return
end

function var_0_1.OnInitItem(arg_19_0, arg_19_1)
	IslandFoodCard = var_1_10002

	local var_19_0 = var_1_10002.New(arg_19_1)

	onButton = var_1_10003

	local var_19_1 = arg_19_0
	local var_19_2 = var_19_0._go

	local function var_19_3()
		isActive = var_2_10000

		if var_2_10000(arg_19_0.detailPanel) then
			setActive = var_0

			var_0(arg_19_0.detailPanel, false)
		end

		if not arg_19_0.isOperable then
			return
		end

		local var_20_0 = arg_19_0

		var_0.AddOnShelf(var_20_0, var_19_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_19_1, var_19_2, var_19_3, var_1_10008)

	arg_19_0.cards[arg_19_1] = var_19_0

	return
end

function var_0_1.AddOnShelf(arg_21_0, arg_21_1)
	if #arg_21_0.shelfInfos >= arg_21_0.shelfCnt then
		return
	end

	math = var_2

	local var_21_0 = var_2.min
	local var_21_1 = arg_21_1.item
	local var_21_2 = var_21_0(var_4.GetCount(var_21_1), arg_21_0.baseCapacity + arg_21_0.extraCapacity)

	arg_21_0.selectedDic[arg_21_1.item.id] = var_21_2

	arg_21_1:UpdateSelectedCnt(var_21_2)
	arg_21_0:FlushShelfs()
	arg_21_0:FlushEstimate()

	return
end

function var_0_1.ShowDetailPanel(arg_22_0, arg_22_1, arg_22_2)
	setAnchoredPosition = var_1_10003

	var_1_10003(arg_22_0.detailPanel, arg_22_2 + var_0_2)

	setActive = var_1_10003

	var_1_10003(arg_22_0.detailPanel, true)

	setText = var_1_10003

	var_1_10003(arg_22_0.detailNameTF, arg_22_1:GetName())

	math = var_1_10003

	local var_22_0 = var_1_10003.floor(arg_22_1:getConfig("order_price") * arg_22_0.priceFactor)

	setText = var_1_10004

	var_1_10004(arg_22_0.detailPriceTF, var_22_0)

	setText = var_1_10004

	var_1_10004(arg_22_0.detailDescTF, arg_22_1:GetDesc())

	IslandShipAttr = var_1_10004

	local var_22_1 = var_1_10004.GetAtrrName
	local var_22_2 = arg_22_1
	local var_22_3 = var_22_1(arg_22_1.getConfig(var_22_2, "sub_attribute")[1])

	i18n = var_5

	local var_22_4 = var_5("island_manage_attr_effect")

	IslandShipAttr = var_6

	local var_22_5 = var_6.ATTRS_CH[1]
	local var_22_6 = "、"

	IslandShipAttr = var_22_2

	local var_22_7 = var_22_4 .. var_22_5 .. var_22_6 .. var_22_2.ToChinese(var_22_3)

	setText = var_22_5

	var_22_5(arg_22_0.detailEffectTF, var_22_7)

	return
end

function var_0_1.OnUpdateItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0

	if not arg_23_0.cards[arg_23_2] then
		var_1_10006 = arg_23_0

		arg_23_0.OnInitItem(var_1_10006, arg_23_2)

		var_23_0 = arg_23_0.cards[arg_23_2]
	end

	if arg_23_0.displays[arg_23_1 + 1] then
		local var_23_1 = arg_23_0:GetAttrsFactorsRatio(var_4.id)

		if not arg_23_0.selectedDic or not arg_23_0.selectedDic[var_4.id] or not arg_23_0.selectedDic[var_4.id] then
			var_1_10006 = 0
		end

		var_1_10009 = var_23_0

		local var_23_2 = var_23_0.Update
		local var_23_3 = var_4

		var_1_10011 = arg_23_0.isOperable and var_1_10006 or 0

		var_23_2(var_1_10009, var_23_3, var_1_10011, arg_23_0.eventEffects[var_4.id], var_23_1)
	end

	local var_23_4 = arg_23_0.detailPanel.parent
	local var_23_5 = var_5.InverseTransformPoint(var_23_4, var_23_0._tf.position)

	GetOrAddComponent = var_1_10006

	local var_23_6 = var_23_0._go

	typeof = var_1_10009
	UILongPressTrigger = var_1_10011

	local var_23_7 = var_1_10006(var_23_6, var_1_10009(var_1_10011)).onLongPressed

	var_7.AddListener(var_23_7, function()
		local var_24_0 = arg_23_0

		var_0.ShowDetailPanel(var_24_0, var_23_0.item, var_23_5)

		return
	end)

	return
end

function var_0_1.UpdateCardWithItemId(arg_25_0, arg_25_1)
	pairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.cards) do
		if iter_25_1.item.id == arg_25_1 then
			local var_25_0 = iter_25_1
			local var_25_1 = iter_25_1.UpdateSelectedCnt
			local var_25_2

			if not arg_25_0.selectedDic[arg_25_1] then
				var_25_2 = 0
			end

			var_25_1(var_25_0, var_25_2)
		end
	end

	return
end

function var_0_1.OnShow(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:BlurPanel()

	setActive = var_3

	var_3(arg_26_0.buffInfoPanel, false)

	arg_26_0.restId = arg_26_1
	arg_26_0.isPost = arg_26_2
	arg_26_0.cards = {}

	arg_26_0:Flush()

	return
end

function var_0_1.OnEnable(arg_27_0)
	arg_27_0:Flush()

	return
end

function var_0_1.Flush(arg_28_0)
	arg_28_0:FlushData()
	arg_28_0:FlushName()
	arg_28_0:FlushRank()
	arg_28_0:FlushEvent()

	arg_28_0.selectedShipIds = nil

	arg_28_0:FlushAssistants()

	arg_28_0.selectedDic = nil

	arg_28_0:FlushCards()
	arg_28_0:FlushShelfs()
	arg_28_0:FlushEstimate()
	arg_28_0:FlushBtns()

	return
end

function var_0_1.FlushData(arg_29_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_29_0 = var_1_10001(var_1_10003)
	local var_29_1 = var_1.GetIsland(var_29_0)
	local var_29_2 = var_1.GetManageAgency(var_29_1)

	arg_29_0.rest = var_1.GetRestaurant(var_29_2, arg_29_0.restId)

	local var_29_3 = arg_29_0.rest

	arg_29_0.shelfCnt = var_1.GetShelfCnt(var_29_3)

	local var_29_4 = arg_29_0.rest

	arg_29_0.assistantsData = var_1.GetAssistants(var_29_4)

	local var_29_5 = arg_29_0.rest

	arg_29_0.baseCapacity = var_1.GetBaseShelfCapacity(var_29_5)
	arg_29_0.extraCapacity = 0

	local var_29_6 = arg_29_0.rest
	local var_29_7 = var_1.GetStatus(var_29_6)

	IslandRestaurant = var_1_10002
	arg_29_0.isOperable = var_29_7 == var_1_10002.STATUS.PREPARE

	return
end

function var_0_1.FlushName(arg_30_0)
	setText = var_1_10001

	local var_30_0 = arg_30_0.nameTF
	local var_30_1 = arg_30_0.rest

	var_1_10001(var_30_0, var_4.getConfig(var_30_1, "name"))

	setText = var_1_10001

	local var_30_2 = arg_30_0.nameEnTF
	local var_30_3 = arg_30_0.rest

	var_1_10001(var_30_2, var_4.getConfig(var_30_3, "name_en"))

	return
end

function var_0_1.FlushRank(arg_31_0)
	LoadImageSpriteAsync = var_1_10001

	local var_31_0 = "island/islandrestaurant/"
	local var_31_1 = arg_31_0.rest

	var_1_10001(var_31_0 .. var_4.GetRankIcon(var_31_1), arg_31_0.rankIcon)

	local var_31_2 = arg_31_0.rest
	local var_31_3 = var_1.GetSales(var_31_2)
	local var_31_4 = arg_31_0.rest
	local var_31_5 = var_2.GetCanUpgradeExp(var_31_4)

	setText = var_31_2

	var_31_2(arg_31_0.rankText, var_31_3 .. "/" .. var_31_5)

	setSlider = var_31_2

	var_31_2(arg_31_0.rankSlider, 0, 1, var_31_5 == 0 and 0 or var_31_3 / var_31_5)

	return
end

function var_0_1.FlushEvent(arg_32_0)
	local var_32_0 = arg_32_0.rest
	local var_32_1, var_32_2, var_32_3 = var_1.GetEventInfo(var_32_0)

	arg_32_0.eventInfluence = var_32_3
	arg_32_0.eventEffects = var_32_2
	arg_32_0.eventId = var_32_1
	setActive = var_32_1

	var_32_1(arg_32_0.eventContainer, arg_32_0.eventId ~= 0)

	if arg_32_0.eventId ~= 0 then
		pg = var_1

		local var_32_4 = var_1.island_manage_event[arg_32_0.eventId]

		setText = var_2

		var_2(arg_32_0.eventTitleTF, var_32_4.name)

		setText = var_2

		local var_32_5 = arg_32_0.eventDescTF

		string = var_5

		local var_32_6 = var_5.gsub
		local var_32_7 = var_32_4.desc
		local var_32_8 = "$1"
		local var_32_9 = arg_32_0.rest

		var_2(var_32_5, var_32_6(var_32_7, var_32_8, var_9.getConfig(var_32_9, "name")))
		arg_32_0:UpdateAddition(arg_32_0.rest)
	end

	return
end

function var_0_1.UpdateAddition(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0
	local var_33_1 = arg_33_0.WarpItemInfo(var_33_0, arg_33_1)
	local var_33_2 = arg_33_0.itemsList

	var_3.make(var_33_2, function(arg_34_0, arg_34_1, arg_34_2)
		UIItemList = var_2_10003

		if arg_34_0 == var_2_10003.EventUpdate then
			local var_34_0 = var_33_1[arg_34_1 + 1]

			Drop = var_4

			local var_34_1 = var_4.New
			local var_34_2 = {
				count = 0
			}

			DROP_TYPE_ISLAND_ITEM = var_2_10007
			var_34_2.type = var_2_10007
			var_34_2.id = var_34_0.id

			local var_34_3 = var_34_1(var_34_2)

			updateCustomDrop = var_2_10005

			var_2_10005(arg_34_2, var_34_3)
		end

		return
	end)

	local var_33_3 = arg_33_0.itemsList

	var_3.align(var_33_3, #var_33_1)

	local var_33_4 = arg_33_1:GetEventInfo()

	pg = var_33_0

	local var_33_5 = var_33_0.island_manage_event[var_33_4]
	local var_33_6 = arg_33_0:WarpAdditionInfo(var_33_5)
	local var_33_7 = arg_33_0.additionList

	var_6.make(var_33_7, function(arg_35_0, arg_35_1, arg_35_2)
		UIItemList = var_2_10003

		if arg_35_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_35_2:Find("Text"), var_33_6[arg_35_1 + 1][1])

			setText = var_3

			var_3(arg_35_2:Find("value"), "+" .. var_33_6[arg_35_1 + 1][2] .. "%")
		end

		return
	end)

	local var_33_8 = arg_33_0.additionList

	var_6.align(var_33_8, #var_33_6)

	return
end

function var_0_1.WarpItemInfo(arg_36_0, arg_36_1)
	local var_36_0 = {}
	local var_36_1 = arg_36_1
	local var_36_2, var_36_3 = arg_36_1.GetEventInfo(var_36_1)

	getProxy = var_36_1
	IslandProxy = var_1_10007

	local var_36_4 = var_36_1(var_1_10007)
	local var_36_5 = var_5.GetIsland(var_36_4)
	local var_36_6 = var_5.GetInventoryAgency(var_36_5)

	ipairs = var_1_10006

	for iter_36_0, iter_36_1 in var_1_10006(arg_36_1:getConfig("item_id")) do
		local var_36_7

		if not var_36_6:GetItemById(iter_36_1[1]) then
			IslandItem = var_36_7
			var_36_7 = var_36_7.New({
				id = iter_36_1[1]
			})
		end

		if var_36_7 and var_36_3[var_36_7.id] then
			table = var_12

			var_12.insert(var_36_0, var_36_7)
		end
	end

	return var_36_0
end

function var_0_1.WarpAdditionInfo(arg_37_0, arg_37_1)
	local var_37_0 = {}

	table = var_1_10003

	local var_37_1 = var_1_10003.insert
	local var_37_2 = var_37_0
	local var_37_3 = {}

	i18n = var_1_10007
	var_37_3[1] = var_1_10007("island_addition_influence")
	var_37_3[2] = arg_37_1.influence_bonus

	var_37_1(var_37_2, var_37_3)

	table = var_37_1

	local var_37_4 = var_37_1.insert
	local var_37_5 = var_37_0
	local var_37_6 = {}

	i18n = var_7
	var_37_6[1] = var_7("island_addition_sale")
	var_37_6[2] = arg_37_1.event_effect[1][1]

	var_37_4(var_37_5, var_37_6)

	return var_37_0
end

function var_0_1.FlushAssistants(arg_38_0)
	if not arg_38_0.selectedShipIds then
		getProxy = var_1
		IslandProxy = var_1_10003
		var_1_10003 = var_1(var_1_10003)
		var_1_10003 = var_1.GetIsland(var_1_10003)

		local var_38_0 = var_1.GetCharacterAgency(var_1_10003)

		arg_38_0.selectedShipIds = {}
		ipairs = var_1_10002

		for iter_38_0, iter_38_1 in var_1_10002(arg_38_0.assistantsData) do
			if iter_38_1.shipId ~= 0 then
				table = var_1_10008

				var_1_10008.insert(arg_38_0.selectedShipIds, var_1_10007)
			end
		end
	end

	arg_38_0.selectedShips = {}
	getProxy = var_1
	IslandProxy = var_1_10003

	local var_38_1 = var_1(var_1_10003)
	local var_38_2 = var_1.GetIsland(var_38_1)
	local var_38_3 = var_1.GetCharacterAgency(var_38_2)

	ipairs = var_1_10002

	for iter_38_2, iter_38_3 in var_1_10002(arg_38_0.selectedShipIds) do
		table = var_1_10007

		var_1_10007.insert(arg_38_0.selectedShips, var_38_3:GetShipById(iter_38_3))
	end

	local var_38_4 = arg_38_0.shipUIList

	var_2.align(var_38_4, var_0_1.MAX_ASSISTANT_CNT)

	arg_38_0.extraPricePer = 0
	arg_38_0.extraCapacity = 0
	arg_38_0.buffInfos = {}
	IslandBuffHelper = var_2

	local var_38_5 = var_2.GetManageSellPriceBuffs(arg_38_0.selectedShips, arg_38_0.restId)

	ipairs = var_3

	for iter_38_4, iter_38_5 in var_3(var_38_5) do
		var_1_10010 = iter_38_5

		local var_38_6 = iter_38_5.GetBuffEffect(var_1_10010)[2]

		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_38_7 = arg_38_0.buffInfos
		local var_38_8 = {}

		i18n = var_1_10013
		var_38_8.name = var_1_10013("island_manage_saleroom")
		var_38_8.effect = "+" .. var_38_6 .. "%"

		var_1_10009(var_38_7, var_38_8)

		arg_38_0.extraPricePer = arg_38_0.extraPricePer + var_38_6 / 100
	end

	IslandBuffHelper = var_3

	local var_38_9 = var_3.GetManageSellNumBuffs(arg_38_0.selectedShips, arg_38_0.restId)

	ipairs = var_4

	for iter_38_6, iter_38_7 in var_4(var_38_9) do
		local var_38_10 = iter_38_7:GetBuffEffect()[2]

		table = var_1_10010
		var_1_10010 = var_1_10010.insert

		local var_38_11 = arg_38_0.buffInfos
		local var_38_12 = {}

		i18n = var_1_10014
		var_38_12.name = var_1_10014("island_manage_capacity")
		var_38_12.effect = "+" .. var_38_10

		var_1_10010(var_38_11, var_38_12)

		arg_38_0.extraCapacity = arg_38_0.extraCapacity + var_38_10
	end

	if arg_38_0.statusCheckTimer then
		local var_38_13 = arg_38_0.statusCheckTimer

		var_4.Stop(var_38_13)
	end

	local var_38_14

	if arg_38_0.isOperable then
		IslandBuffHelper = var_38_14
		arg_38_0.shipStatus = var_38_14.GetManageStatus(arg_38_0.selectedShips, arg_38_0.restId)
		var_38_14 = #arg_38_0.shipStatus

		if 0 < var_38_14 then
			Timer = var_38_14
			arg_38_0.statusCheckTimer = var_38_14.New(function()
				underscore = var_2_10000

				if var_2_10000.reduce(arg_38_0.shipStatus, 0, function(arg_40_0, arg_40_1)
					return arg_40_0 + (arg_40_1:IsExpiration() and 1 or 0)
				end) > 0 then
					local var_39_0 = arg_38_0

					var_1.OnStatusExpired(var_39_0)
				end

				return
			end, 1, -1)

			local var_38_15 = arg_38_0.statusCheckTimer

			var_38_14.Start(var_38_15)
		end
	end

	setActive = var_38_14

	local var_38_16 = arg_38_0.extraCapacityTF
	local var_38_17

	if arg_38_0.isOperable then
		var_38_17 = arg_38_0.extraCapacity > 0
	end

	var_38_14(var_38_16, var_38_17)

	setText = var_38_14

	var_38_14(arg_38_0.extraCapacityEffectTF, "+" .. arg_38_0.extraCapacity)

	local var_38_18 = arg_38_0.buffInfoUIList

	var_4.align(var_38_18, #arg_38_0.buffInfos)

	setActive = var_4

	var_4(arg_38_0.buffInfoEmptyTF, #arg_38_0.buffInfos == 0)

	if arg_38_0.shelfInfos then
		local var_38_19 = #arg_38_0.shelfInfos

		if 0 < var_38_19 then
			local var_38_21

			if arg_38_0.selectedShipIds then
				local var_38_20 = #arg_38_0.selectedShipIds

				if not (0 < var_38_20) then
					var_38_21 = false
				else
					var_38_21 = true
				end
			end

			setGray = var_5

			var_5(arg_38_0.openBtn, not var_38_21, true)

			setButtonEnabled = var_5

			var_5(arg_38_0.openBtn, var_38_21)

			return
		end
	end
end

function var_0_1.GetEffectiveManangeSkill(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1:GetSkill()

	return var_2.IsEffectiveInRest(var_41_0, arg_41_0.restId) and var_2 or nil
end

function var_0_1.GetEffectiveManangeUnlockSkill(arg_42_0, arg_42_1)
	return arg_42_0:GetEffectiveManangeSkill(arg_42_1) and var_2:IsUnlock() and var_2 or nil
end

function var_0_1.UpdateShipItem(arg_43_0, arg_43_1, arg_43_2)
	arg_43_2.name = arg_43_1 + 1

	local var_43_0 = var_3 <= #arg_43_0.assistantsData

	setActive = var_1_10005

	var_1_10005(arg_43_2:Find("lock"), not var_43_0)

	local var_43_1 = arg_43_0.selectedShips[var_3]

	setActive = var_1_10006

	var_1_10006(arg_43_2:Find("empty"), var_43_0 and not var_43_1)

	setActive = var_1_10006

	var_1_10006(arg_43_2:Find("ship"), var_43_0 and var_43_1)

	onButton = var_1_10006

	local var_43_2 = arg_43_0
	local var_43_3 = arg_43_2

	local function var_43_4()
		if not var_43_0 or not arg_43_0.isOperable then
			return
		end

		local var_44_0 = arg_43_0
		local var_44_1 = var_0.OpenPage

		IslandShipSelectPage = var_2_10003

		local var_44_2 = {
			showBenefits = true
		}

		IslandSelectShipCard = var_2_10005
		var_44_2.showType = var_2_10005.SHOW_TYPE.RESTAURANT
		var_44_2.restId = arg_43_0.restId
		var_44_2.selectNum = #arg_43_0.assistantsData
		Clone = var_5
		var_44_2.selectedIds = var_5(arg_43_0.selectedShipIds)
		IslandShipAttr = var_5
		var_44_2.attrType = var_5.MANAGE_KEY

		function var_44_2.confirmFunc(arg_45_0)
			local var_45_0 = arg_43_0

			var_1.OnSelectedShipsDone(var_45_0, arg_45_0)

			return
		end

		local var_44_3 = arg_43_0.rest

		var_44_2.emptyInfoTitle = var_5.getConfig(var_44_3, "name")

		var_44_1(var_44_0, var_2_10003, var_44_2)

		return
	end

	SFX_PANEL = var_11

	var_1_10006(var_43_2, var_43_3, var_43_4, var_11)

	if var_43_1 then
		local var_43_5 = arg_43_2
		local var_43_6 = arg_43_2.Find(var_43_5, "ship")

		setText = var_7

		var_7(var_43_6:Find("name"), var_43_1:GetName())

		local var_43_7 = arg_43_0
		local var_43_8 = arg_43_0.GetEffectiveManangeSkill(var_43_7, var_43_1)

		setActive = var_43_5

		var_43_5(var_43_6:Find("skill"), var_43_8 and var_43_8:IsUnlock())

		setActive = var_43_5

		var_43_5(var_43_6:Find("skill_lock"), var_43_8 and not var_43_8:IsUnlock())

		IslandShip = var_43_5

		local var_43_9 = var_43_5.StaticGetPrefab(var_43_1.id)

		GetImageSpriteFromAtlasAsync = var_43_7

		var_43_7("ShipYardIcon/" .. var_43_9, "", var_43_6:Find("icon"))

		local var_43_10 = var_43_6
		local var_43_11 = var_43_6.Find(var_43_10, "skill")

		if var_43_8 then
			local var_43_12

			if var_43_8:IsUnlock() then
				setActive = var_43_12

				var_43_12(var_43_11:Find("effects"), true)

				setActive = var_43_12

				var_43_12(var_43_11:Find("invalid"), false)

				LoadImageSpriteAsync = var_43_12

				var_43_12("island/islandskillicon/" .. var_43_8:GetIcon(), var_43_11:Find("skill_icon"))

				setText = var_43_12

				var_43_12(var_43_11:Find("skill_name"), var_43_8:GetName())

				IslandBuffHelper = var_43_12
				var_43_12 = var_43_12.GetAllShipManageBuffs(var_43_1, arg_43_0.restId)
				UIItemList = var_43_10

				var_43_10.StaticAlign(var_43_11:Find("effects"), var_43_11:Find("effects/tpl"), #var_43_12, function(arg_46_0, arg_46_1, arg_46_2)
					UIItemList = var_2_10003

					if arg_46_0 == var_2_10003.EventUpdate then
						local var_46_0 = var_43_12[arg_46_1 + 1]
						local var_46_1 = var_3.GetBuffType(var_46_0)
						local var_46_2 = ""
						local var_46_3 = ""

						IslandBuffType = var_2_10007

						if var_46_1 == var_2_10007.SHIP_MANAGE_SELL_PRICE then
							i18n = var_7
							var_46_2 = var_7("island_manage_saleroom")
							var_46_3 = "+" .. var_3:GetBuffEffect()[2] .. "%"
						else
							IslandBuffType = var_7

							if var_46_1 == var_7.SHIP_MANAGE_SELL_NUM then
								i18n = var_7
								var_46_2 = var_7("island_manage_capacity")
								var_46_3 = "+" .. var_3:GetBuffEffect()[2]
							end
						end

						setText = var_7

						var_7(arg_46_2:Find("name"), var_46_2)

						setText = var_7

						var_7(arg_46_2:Find("effect"), var_46_3)
					end

					return
				end)
			else
				setText = var_43_12

				local var_43_13 = var_43_6:Find("skill_lock/Image/Text")

				i18n = var_13

				var_43_12(var_43_13, var_13("island_need_star_1", var_43_1:GetSkillUnlockLevel()))
			end
		else
			local var_43_14 = var_43_1:GetSkill()

			setActive = var_43_10

			var_43_10(var_43_6:Find("skill"), true)

			LoadImageSpriteAsync = var_43_10

			var_43_10("island/islandskillicon/" .. var_43_14:GetIcon(), var_43_11:Find("skill_icon"))

			setText = var_43_10

			var_43_10(var_43_11:Find("skill_name"), var_43_14:GetName())

			setActive = var_43_10

			var_43_10(var_43_11:Find("effects"), false)

			setActive = var_43_10

			var_43_10(var_43_11:Find("invalid"), true)
		end
	end

	return
end

function var_0_1.FlushCards(arg_47_0)
	arg_47_0.displays = {}
	getProxy = var_1
	IslandProxy = var_1_10003

	local var_47_0 = var_1(var_1_10003)
	local var_47_1 = var_1.GetIsland(var_47_0)
	local var_47_2 = var_1.GetInventoryAgency(var_47_1)

	ipairs = var_1_10002

	local var_47_3 = arg_47_0.rest

	for iter_47_0, iter_47_1 in var_1_10002(var_4.getConfig(var_47_3, "item_id")) do
		if var_47_2:GetItemById(iter_47_1[1]) then
			table = var_1_10008

			var_1_10008.insert(arg_47_0.displays, var_7)
		end
	end

	setActive = var_2

	var_2(arg_47_0.commoditiesEmptyTF, #arg_47_0.displays <= 0)

	setActive = var_2

	var_2(arg_47_0.commoditiesTF, #arg_47_0.displays > 0)
	arg_47_0:CaclAttrsFactors()

	if #arg_47_0.displays > 0 then
		arg_47_0:SortDisplays()
	end

	return
end

function var_0_1.SortDisplays(arg_48_0)
	table = var_1_10001

	local var_48_0 = var_1_10001.sort
	local var_48_1 = arg_48_0.displays

	CompareFuncs = var_1_10004

	var_48_0(var_48_1, var_1_10004({
		function(arg_49_0)
			return -arg_48_0.subAttrFactorsDic[arg_49_0.id]
		end,
		function(arg_50_0)
			return -arg_50_0:getConfig("order_price") * arg_48_0.priceFactor
		end,
		function(arg_51_0)
			return arg_51_0.id
		end
	}))

	if arg_48_0:isShowing() then
		local var_48_2 = arg_48_0.scrollRect

		var_1.SetTotalCount(var_48_2, #arg_48_0.displays, -1)
	end

	return
end

function var_0_1.CaclAttrsFactors(arg_52_0)
	arg_52_0.subAttrFactorsDic = {}
	arg_52_0.mainAttrFactorsDic = {}
	ipairs = var_1

	for iter_52_0, iter_52_1 in var_1(arg_52_0.displays) do
		local var_52_0 = iter_52_1:getConfig("sub_attribute")[1]
		local var_52_1 = arg_52_0.subAttrFactorsDic
		local var_52_2 = iter_52_1.id
		local var_52_3

		if not var_52_0 or not var_0_1.CaclShipAttrFactors(arg_52_0.selectedShips, var_52_0) then
			var_52_3 = 0
		end

		var_52_1[var_52_2] = var_52_3

		local var_52_4 = arg_52_0.mainAttrFactorsDic
		local var_52_5 = iter_52_1.id
		local var_52_6 = var_0_1.CaclShipAttrFactors
		local var_52_7 = arg_52_0.selectedShips

		IslandShipAttr = var_1_10012
		var_52_4[var_52_5] = var_52_6(var_52_7, var_1_10012.MANAGE_KEY)
	end

	return
end

function var_0_1.GetSubAttrFactors(arg_53_0, arg_53_1)
	if arg_53_0.subAttrFactorsDic[arg_53_1] then
		return arg_53_0.subAttrFactorsDic[arg_53_1]
	end

	local var_53_0 = var_0_3[arg_53_1].sub_attribute[1]
	local var_53_1 = arg_53_0.subAttrFactorsDic
	local var_53_2

	if not var_53_0 or not var_0_1.CaclShipAttrFactors(arg_53_0.selectedShips, var_53_0) then
		var_53_2 = 0
	end

	var_53_1[arg_53_1] = var_53_2

	return arg_53_0.subAttrFactorsDic[arg_53_1]
end

function var_0_1.GetMainAttrFactors(arg_54_0, arg_54_1)
	if arg_54_0.mainAttrFactorsDic[arg_54_1] then
		return arg_54_0.mainAttrFactorsDic[arg_54_1]
	end

	local var_54_0 = arg_54_0.mainAttrFactorsDic
	local var_54_1 = var_0_1.CaclShipAttrFactors
	local var_54_2 = arg_54_0.selectedShips

	IslandShipAttr = var_1_10006
	var_54_0[arg_54_1] = var_54_1(var_54_2, var_1_10006.MANAGE_KEY)

	return arg_54_0.mainAttrFactorsDic[arg_54_1]
end

function var_0_1.GetAttrsFactorsRatio(arg_55_0, arg_55_1)
	local var_55_0 = var_0_3[arg_55_1].sub_attribute[2] / 100
	local var_55_1 = arg_55_0:GetMainAttrFactors(arg_55_1) + arg_55_0:GetSubAttrFactors(arg_55_1) * var_55_0

	return #arg_55_0.assistantsData * (arg_55_0.maxAttrEffect + arg_55_0.maxAttrEffect * var_55_0) == 0 and 0 or var_55_1 / var_4
end

function var_0_1.FlushShelfs(arg_56_0)
	if not arg_56_0.selectedDic then
		arg_56_0.selectedDic = {}
		ipairs = var_1

		local var_56_0 = arg_56_0.rest

		for iter_56_0, iter_56_1 in var_1(var_3.GetCommondities(var_56_0)) do
			var_1_10006 = arg_56_0.selectedDic
			var_1_10006[iter_56_1.id] = iter_56_1.num
		end
	end

	arg_56_0.shelfInfos = {}
	pairs = var_1

	for iter_56_2, iter_56_3 in var_1(arg_56_0.selectedDic) do
		table = var_1_10006

		var_1_10006.insert(arg_56_0.shelfInfos, {
			id = iter_56_2,
			num = iter_56_3
		})
	end

	local var_56_1 = arg_56_0.shelfUIList

	var_1.align(var_56_1, var_0_1.MAX_SHELF_CNT)

	if arg_56_0.shelfInfos then
		local var_56_2 = #arg_56_0.shelfInfos

		if 0 < var_56_2 then
			local var_56_4

			if arg_56_0.selectedShipIds then
				local var_56_3 = #arg_56_0.selectedShipIds

				if not (0 < var_56_3) then
					var_56_4 = false
				else
					var_56_4 = true
				end
			end

			setGray = var_2

			var_2(arg_56_0.openBtn, not var_56_4, true)

			setButtonEnabled = var_2

			var_2(arg_56_0.openBtn, var_56_4)

			return
		end
	end
end

function var_0_1.UpdateShelfItem(arg_57_0, arg_57_1, arg_57_2)
	arg_57_2.name = arg_57_1 + 1

	local var_57_0 = var_3 <= arg_57_0.shelfCnt

	setActive = var_1_10005

	var_1_10005(arg_57_2:Find("lock"), not var_57_0)

	local var_57_1 = arg_57_0.shelfInfos[var_3]

	setActive = var_1_10006

	var_1_10006(arg_57_2:Find("empty"), var_57_0 and not var_57_1)

	setActive = var_1_10006

	var_1_10006(arg_57_2:Find("commodity"), var_57_0 and var_57_1)

	if var_57_1 then
		local var_57_2 = arg_57_2:Find("commodity")

		LoadImageSpriteAsync = var_7

		var_7("island/" .. var_0_3[var_57_1.id].icon, var_57_2:Find("bg/icon"))

		local var_57_3 = arg_57_0.baseCapacity + arg_57_0.extraCapacity

		if arg_57_0.isOperable then
			setText = var_8

			local var_57_4 = var_57_2:Find("count/Text")
			local var_57_5 = var_57_1.num
			local var_57_6 = "/"

			if arg_57_0.extraCapacity > 0 then
				setColorStr = var_13

				local var_57_7

				if not var_13(var_57_3, "#7BF59DFF") then
					var_57_7 = var_57_3
				end

				var_8(var_57_4, var_57_5 .. var_57_6 .. var_57_7)

				if false then
					setText = var_8

					var_8(var_57_2:Find("count/Text"), var_57_1.num)
				end

				setActive = var_8

				var_8(var_57_2:Find("event"), arg_57_0.eventEffects[var_57_1.id])

				local var_57_8 = arg_57_0:GetAttrsFactorsRatio(var_57_1.id)

				setFillAmount = var_9

				var_9(var_57_2:Find("bg/silder/bar"), var_57_8)

				setActive = var_9

				var_9(var_57_2:Find("reduce"), arg_57_0.isOperable)

				onButton = var_9

				local var_57_9 = arg_57_0
				local var_57_10 = var_57_2
				local var_57_11 = var_57_2.Find(var_57_10, "reduce")

				local function var_57_12()
					if not arg_57_0.isOperable then
						return
					end

					local var_58_0 = arg_57_0

					var_0.ReduceShelfCnt(var_58_0, var_57_1.id, 1)

					local var_58_1 = arg_57_0

					var_0.FlushEstimate(var_58_1)

					return
				end

				SFX_PANEL = var_57_10

				var_9(var_57_9, var_57_11, var_57_12, var_57_10)

				if var_57_3 < var_57_1.num then
					arg_57_0:ReduceShelfCnt(var_57_1.id, var_57_1.num - var_57_3)
					arg_57_0:FlushEstimate()
				end

				return
			end
		end
	end
end

function var_0_1.ReduceShelfCnt(arg_59_0, arg_59_1, arg_59_2)
	arg_59_0.selectedDic[arg_59_1] = arg_59_0.selectedDic[arg_59_1] - arg_59_2

	if arg_59_0.selectedDic[arg_59_1] <= 0 then
		arg_59_0.selectedDic[arg_59_1] = nil
	end

	arg_59_0:UpdateCardWithItemId(arg_59_1)
	arg_59_0:FlushShelfs()

	return
end

function var_0_1.FlushEstimate(arg_60_0)
	local var_60_0 = arg_60_0.rest
	local var_60_1 = var_1.GetStatus(var_60_0)

	IslandRestaurant = var_1_10002

	if var_60_1 ~= var_1_10002.STATUS.OPENING then
		IslandRestaurant = var_2

		if var_60_1 == var_2.STATUS.CLOSE then
			local var_60_2 = arg_60_0.rest
			local var_60_3 = var_2.GetEstimateData(var_60_2)

			setText = var_60_0

			var_60_0(arg_60_0.estimateCntTF, var_60_3.cntMin .. "-" .. var_60_3.cntMax)

			setText = var_60_0

			var_60_0(arg_60_0.estimateSalesTF, var_60_3.salesMin .. "-" .. var_60_3.salesMax)
		else
			local var_60_4 = arg_60_0.rest
			local var_60_5, var_60_6 = var_2.GetRandomSaleCntBound(var_60_4)
			local var_60_7 = 0

			arg_60_0.totalMaxCnt, arg_60_0.totalMinSales, arg_60_0.totalMaxSales = 0, 0, 0
			arg_60_0.totalMinCnt = var_60_7
			pairs = var_60_7

			for iter_60_0, iter_60_1 in var_60_7(arg_60_0.selectedDic) do
				local var_60_8 = arg_60_0
				local var_60_9 = arg_60_0.CaclBaseSaleCnt(var_60_8, iter_60_0)

				math = var_1_10010
				var_1_10010 = var_1_10010.min

				local var_60_10 = iter_60_1

				math = var_1_10013
				var_1_10010 = var_1_10010(var_60_10, var_1_10013.max(arg_60_0.minSaleCnt, var_60_9 + var_60_5))
				math = var_60_8

				local var_60_11 = var_60_8.min

				var_1_10013 = iter_60_1
				math = var_1_10014

				local var_60_12 = var_60_11(var_1_10013, var_1_10014.max(arg_60_0.minSaleCnt, var_60_9 + var_60_6))

				arg_60_0.totalMinSales = arg_60_0.totalMinSales + arg_60_0:CaclGroupPrice(iter_60_0, var_1_10010)
				arg_60_0.totalMaxSales = arg_60_0.totalMaxSales + arg_60_0:CaclGroupPrice(iter_60_0, var_60_12)
				arg_60_0.totalMinCnt = arg_60_0.totalMinCnt + var_1_10010
				arg_60_0.totalMaxCnt = arg_60_0.totalMaxCnt + var_60_12
			end

			setText = var_4

			var_4(arg_60_0.estimateCntTF, arg_60_0.totalMinCnt .. "-" .. arg_60_0.totalMaxCnt)

			setText = var_4

			var_4(arg_60_0.estimateSalesTF, arg_60_0.totalMinSales .. "-" .. arg_60_0.totalMaxSales)
		end

		return
	end
end

function var_0_1.CaclBaseSaleCnt(arg_61_0, arg_61_1)
	local var_61_0 = var_0_3[arg_61_1].manage_influence / 100
	local var_61_1

	if not arg_61_0.eventEffects[arg_61_1] or not arg_61_0.eventInfluence then
		var_61_1 = 0
	end

	local var_61_2 = var_61_0 + var_61_1
	local var_61_3 = arg_61_0.argA + arg_61_0:GetMainAttrFactors(arg_61_1)
	local var_61_4 = var_0_3[arg_61_1].sub_attribute[2] / 100
	local var_61_5 = arg_61_0.argB + arg_61_0:GetSubAttrFactors(arg_61_1) * var_61_4
	local var_61_6 = arg_61_0.argC
	local var_61_7 = arg_61_0.rest
	local var_61_8 = var_61_6 + var_9.GetRankFactor(var_61_7)

	math = var_9

	return var_9.floor(var_61_2 * var_61_3 * var_61_5 * var_61_8 / arg_61_0.saleConst)
end

function var_0_1.CaclGroupPrice(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = var_0_3[arg_62_1].order_price * arg_62_0.priceFactor
	local var_62_1

	if not arg_62_0.eventEffects[arg_62_1] then
		var_62_1 = 0
	end

	math = var_1_10005

	return var_1_10005.floor(var_62_0 * arg_62_2 * (1 + var_62_1 + arg_62_0.extraPricePer))
end

function var_0_1.OnStatusExpired(arg_63_0)
	arg_63_0:FlushAssistants()
	arg_63_0:FlushCards()
	arg_63_0:FlushShelfs()
	arg_63_0:FlushEstimate()

	return
end

function var_0_1.OnSelectedShipsDone(arg_64_0, arg_64_1)
	arg_64_0.selectedShipIds = arg_64_1

	arg_64_0:FlushAssistants()
	arg_64_0:FlushCards()
	arg_64_0:FlushShelfs()
	arg_64_0:FlushEstimate()

	return
end

function var_0_1.OnAutoSelect(arg_65_0)
	arg_65_0.selectedShipIds = arg_65_0:GetAutoShipIds()

	arg_65_0:FlushAssistants()
	arg_65_0:FlushCards()

	arg_65_0.selectedDic = {}

	for iter_65_0 = 1, arg_65_0.shelfCnt do
		if arg_65_0.displays[iter_65_0] then
			local var_65_0 = arg_65_0.selectedDic
			local var_65_1 = var_5.id

			math = var_1_10008
			var_65_0[var_65_1] = var_1_10008.min(var_5:GetCount(), arg_65_0.baseCapacity + arg_65_0.extraCapacity)
		end
	end

	local var_65_2 = arg_65_0.scrollRect

	var_1.SetTotalCount(var_65_2, #arg_65_0.displays, -1)
	arg_65_0:FlushShelfs()
	arg_65_0:FlushEstimate()

	return
end

function var_0_1.GetAutoShipIds(arg_66_0)
	underscore = var_1_10001

	local var_66_0 = var_1_10001.select

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_66_1 = var_1_10003(var_1_10005)
	local var_66_2 = var_3.GetIsland(var_66_1)
	local var_66_3 = var_3.GetCharacterAgency(var_66_2)
	local var_66_4 = var_66_0(var_3.GetShips(var_66_3), function(arg_67_0)
		return arg_67_0:IsDelegable()
	end)

	table = var_1_10002

	local var_66_5 = var_1_10002.sort
	local var_66_6 = var_66_4

	CompareFuncs = var_66_3

	var_66_5(var_66_6, var_66_3({
		function(arg_68_0)
			local var_68_0 = arg_66_0

			return var_1.GetEffectiveManangeUnlockSkill(var_68_0, arg_68_0) and 0 or 1
		end,
		function(arg_69_0)
			IslandBuffHelper = var_2_10001

			local var_69_0 = var_2_10001.GetShipBuffsByType
			local var_69_1 = {
				arg_69_0
			}

			IslandBuffType = var_2_10004

			local var_69_2 = var_69_0(var_69_1, var_2_10004.SHIP_MANAGE_SELL_PRICE)

			underscore = var_2_10002

			return -var_2_10002.reduce(var_69_2, 0, function(arg_70_0, arg_70_1)
				return arg_70_0 + arg_70_1:GetBuffEffect()[2]
			end)
		end,
		function(arg_71_0)
			IslandBuffHelper = var_2_10001

			local var_71_0 = var_2_10001.GetShipBuffsByType
			local var_71_1 = {
				arg_71_0
			}

			IslandBuffType = var_2_10004

			local var_71_2 = var_71_0(var_71_1, var_2_10004.SHIP_MANAGE_SELL_NUM)

			underscore = var_2_10002

			return -var_2_10002.reduce(var_71_2, 0, function(arg_72_0, arg_72_1)
				return arg_72_0 + arg_72_1:GetBuffEffect()[2]
			end)
		end,
		function(arg_73_0)
			return arg_73_0.id
		end
	}))

	local var_66_7 = {}

	for iter_66_0 = 1, #arg_66_0.assistantsData do
		if var_66_4[iter_66_0] then
			table = var_7

			var_7.insert(var_66_7, var_66_4[iter_66_0].id)
		end
	end

	if #var_66_7 == 0 and #arg_66_0.assistantsData > 0 then
		table = var_3

		local var_66_8 = var_3.insert
		local var_66_9 = var_66_7

		IslandCharacterAgency = iter_66_0

		var_66_8(var_66_9, iter_66_0.NPC_CONFIG_ID)
	end

	return var_66_7
end

function var_0_1.FlushBtns(arg_74_0)
	local var_74_0 = arg_74_0.rest
	local var_74_1 = var_1.GetStatus(var_74_0)

	eachChild = var_1_10002

	var_1_10002(arg_74_0.btnsTF, function(arg_75_0)
		setActive = var_2_10001

		var_2_10001(arg_75_0, arg_75_0.name == var_74_1)

		return
	end)

	IslandRestaurant = var_1_10002

	if var_74_1 == var_1_10002.STATUS.OPENING then
		if not arg_74_0.timer then
			arg_74_0:StartTimer()
			arg_74_0:UpdateTime()
		end
	else
		arg_74_0:StopTimer()
	end

	setActive = var_2

	var_2(arg_74_0.buffInfoBtn, arg_74_0.isOperable)

	return
end

function var_0_1.UpdateTime(arg_76_0)
	pg = var_1_10001

	local var_76_0 = var_1_10001.TimeMgr.GetInstance()
	local var_76_1 = arg_76_0.rest
	local var_76_2 = var_2.GetEndTime(var_76_1) - var_76_0:GetServerTime()

	setText = var_3

	local var_76_3 = arg_76_0.btnsTF

	var_3(var_5.Find(var_76_3, "opening/time"), var_76_0:DescCDTime(var_76_2))

	if var_76_2 <= 0 then
		arg_76_0:FlushBtns()
	end

	return
end

function var_0_1.StartTimer(arg_77_0)
	Timer = var_1_10001
	arg_77_0.timer = var_1_10001.New(function()
		local var_78_0 = arg_77_0

		var_0.UpdateTime(var_78_0)

		return
	end, 1, -1)

	local var_77_0 = arg_77_0.timer

	var_1.Start(var_77_0)

	return
end

function var_0_1.StopTimer(arg_79_0)
	if arg_79_0.timer ~= nil then
		local var_79_0 = arg_79_0.timer

		var_1.Stop(var_79_0)

		arg_79_0.timer = nil
	end

	return
end

function var_0_1.OnHide(arg_80_0)
	arg_80_0:StopTimer()

	if arg_80_0.statusCheckTimer then
		local var_80_0 = arg_80_0.statusCheckTimer

		var_1.Stop(var_80_0)

		arg_80_0.statusCheckTimer = nil
	end

	arg_80_0:UnBlurPanel()

	return
end

function var_0_1.OnDisable(arg_81_0)
	arg_81_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_82_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_82_0.scrollRect)
	arg_82_0:OnHide()

	return
end

function var_0_1.CaclShipAttrFactors(arg_83_0, arg_83_1)
	local var_83_0 = 0

	ipairs = var_1_10003

	for iter_83_0, iter_83_1 in var_1_10003(arg_83_0) do
		local var_83_1 = iter_83_1
		local var_83_2 = iter_83_1.GetAttrGrade

		IslandShipAttr = var_1_10011

		local var_83_3 = var_83_2(var_83_1, var_1_10011.GetAtrrName(arg_83_1))

		pg = var_1_10009
		var_83_0 = var_83_0 + var_1_10009.island_chara_att[var_83_3].manage_effect / 16
	end

	return var_83_0
end

return var_0_1
