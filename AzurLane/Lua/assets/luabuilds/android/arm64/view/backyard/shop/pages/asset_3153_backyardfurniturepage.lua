class = var_0_10000

local var_0_0 = "BackYardFurniturePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BackYardShopBasePage"))

Furniture = var_0_10001

local var_0_2 = var_0_10001.INDEX_TO_SHOP_TYPE

table = var_0_0

var_0_0.insert(var_0_2, 1, {})

local function var_0_3(arg_1_0)
	return var_0_2[arg_1_0]
end

function var_0_1.getUIName(arg_2_0)
	return "BackYardFurniturePage"
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "adpter/frame/bg")

	arg_3_0.scrollRect = var_1.GetComponent(var_3_1, "LScrollRect")

	local var_3_2 = arg_3_0._tf

	arg_3_0.searchInput = var_1.Find(var_3_2, "adpter/search")

	local var_3_3 = arg_3_0._tf

	arg_3_0.searchClear = var_1.Find(var_3_3, "adpter/search/clear")

	local var_3_4 = arg_3_0._tf

	arg_3_0.filterBtn = var_1.Find(var_3_4, "adpter/filter")

	local var_3_5 = arg_3_0.filterBtn
	local var_3_6 = var_1.Find(var_3_5, "Text")
	local var_3_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.filterBtnTxt = var_3_7(var_3_6, var_4(var_1_10006))

	local var_3_8 = arg_3_0.filterBtnTxt

	i18n = var_1_10002
	var_3_8.text = var_1_10002("word_default")

	local var_3_9 = arg_3_0._tf

	arg_3_0.orderBtn = var_1.Find(var_3_9, "adpter/order")

	local var_3_10 = arg_3_0.orderBtn

	arg_3_0.orderBtnIcon = var_1.Find(var_3_10, "icon")

	local var_3_11 = arg_3_0.orderBtn
	local var_3_12 = var_1.Find(var_3_11, "Text")
	local var_3_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.orderBtnTxt = var_3_13(var_3_12, var_4(var_1_10006))
	setText = var_1

	local var_3_14 = arg_3_0.searchInput
	local var_3_15 = var_3.Find(var_3_14, "Placeholder")

	i18n = var_4

	var_1(var_3_15, var_4("courtyard_label_search_holder"))

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.cards = {}

	function arg_4_0.scrollRect.onInitItem(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.OnInitItem(var_5_0, arg_5_0)

		return
	end

	local var_4_0 = arg_4_0.scrollRect

	function var_4_0.onUpdateItem(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0

		var_2.OnUpdateItem(var_6_0, arg_6_0, arg_6_1)

		return
	end

	onInputChanged = var_4_0

	var_4_0(arg_4_0, arg_4_0.searchInput, function()
		getInputText = var_2_10000

		local var_7_0 = var_2_10000(arg_4_0.searchInput)

		setActive = var_2_10001

		var_2_10001(arg_4_0.searchClear, var_7_0 ~= "")

		local var_7_1 = arg_4_0

		var_1.OnSearchKeyChange(var_7_1)

		return
	end)

	onButton = var_4_0

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.searchClear

	local function var_4_3()
		setInputText = var_2_10000

		var_2_10000(arg_4_0.searchInput, "")

		return
	end

	SFX_PANEL = var_1_10006

	var_4_0(var_4_1, var_4_2, var_4_3, var_1_10006)

	BackYardDecorationFilterPanel = var_4_0
	arg_4_0.orderMode = var_4_0.ORDER_MODE_DASC

	local var_4_4 = arg_4_0.orderBtnIcon

	Vector3 = var_2
	var_4_4.localScale = var_2(1, -1, 1)

	local function var_4_5(arg_9_0)
		local var_9_0 = ""

		BackYardDecorationFilterPanel = var_2_10002

		if arg_9_0 == var_2_10002.ORDER_MODE_ASC then
			i18n = var_2
			var_9_0 = var_2("word_asc")
		else
			BackYardDecorationFilterPanel = var_2

			if arg_9_0 == var_2.ORDER_MODE_DASC then
				i18n = var_2
				var_9_0 = var_2("word_desc")
			end
		end

		arg_4_0.orderBtnTxt.text = var_9_0

		return
	end

	onToggle = var_2

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.orderBtn

	local function var_4_8(arg_10_0)
		local var_10_0 = arg_4_0

		if arg_10_0 then
			BackYardDecorationFilterPanel = var_2_10002

			if not var_2_10002.ORDER_MODE_ASC then
				BackYardDecorationFilterPanel = var_2_10002
				var_2_10002 = var_2_10002.ORDER_MODE_DASC
			end

			var_10_0.orderMode = var_2_10002

			var_4_5(arg_4_0.orderMode)

			local var_10_1 = arg_4_0

			var_1.UpdateFliterData(var_10_1)

			local var_10_2 = arg_4_0.contextData.filterPanel

			var_1.Sort(var_10_2)

			local var_10_3 = arg_4_0

			var_1.OnFilterDone(var_10_3)

			local var_10_4 = arg_4_0.orderBtnIcon

			Vector3 = var_2_10002
			var_10_4.localScale = var_2_10002(1, arg_10_0 and 1 or -1, 1)

			return
		end
	end

	SFX_PANEL = var_1_10007

	var_2(var_4_6, var_4_7, var_4_8, var_1_10007)
	var_4_5(arg_4_0.orderMode)

	local var_4_9 = arg_4_0.contextData.filterPanel

	function var_4_9.confirmFunc()
		local var_11_0 = arg_4_0.contextData.filterPanel.sortTxt

		arg_4_0.filterBtnTxt.text = var_11_0

		local var_11_1 = arg_4_0

		var_1.OnFilterDone(var_11_1)

		return
	end

	onButton = var_4_9

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.filterBtn

	local function var_4_12()
		local var_12_0 = arg_4_0.contextData.filterPanel
		local var_12_1 = var_0.setFilterData
		local var_12_2 = arg_4_0

		var_12_1(var_12_0, var_3.GetData(var_12_2))

		local var_12_3 = arg_4_0.contextData.filterPanel

		var_0.ExecuteAction(var_12_3, "Show")

		return
	end

	SFX_PANEL = var_1_10007

	var_4_9(var_4_10, var_4_11, var_4_12, var_1_10007)
	arg_4_0:UpdateFliterData()

	return
end

function var_0_1.UpdateFliterData(arg_13_0)
	local var_13_0 = arg_13_0.contextData.filterPanel

	var_1.updateOrderMode(var_13_0, arg_13_0.orderMode)

	return
end

function var_0_1.OnFilterDone(arg_14_0)
	local var_14_0 = arg_14_0.contextData.filterPanel

	arg_14_0.displays = var_1.GetFilterData(var_14_0)

	local var_14_1 = arg_14_0.scrollRect

	var_2.SetTotalCount(var_14_1, #arg_14_0.displays)

	return
end

function var_0_1.OnDisplayUpdated(arg_15_0, arg_15_1)
	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.displays) do
		if iter_15_1.id == arg_15_1.id then
			arg_15_0.displays[iter_15_0] = arg_15_1

			break
		end
	end

	return
end

function var_0_1.OnCardUpdated(arg_16_0, arg_16_1)
	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.cards) do
		if iter_16_1.furniture.id == arg_16_1.id then
			iter_16_1:Update(arg_16_1)

			break
		end
	end

	return
end

function var_0_1.OnDormUpdated(arg_17_0)
	arg_17_0:UpdateFliterData()

	return
end

function var_0_1.OnSetUp(arg_18_0)
	arg_18_0:InitFurnitureList()

	return
end

function var_0_1.OnSearchKeyChange(arg_19_0)
	arg_19_0:InitFurnitureList()

	return
end

function var_0_1.InitFurnitureList(arg_20_0)
	local var_20_0 = arg_20_0:GetData()
	local var_20_1 = arg_20_0.contextData.filterPanel

	var_2.setFilterData(var_20_1, var_20_0)

	local var_20_2 = arg_20_0.contextData.filterPanel

	var_2.filter(var_20_2)
	arg_20_0:OnFilterDone()

	return
end

function var_0_1.GetData(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = arg_21_0.dorm
	local var_21_2 = var_2.GetPurchasedFurnitures(var_21_1)

	local function var_21_3(arg_22_0)
		local var_22_0 = var_21_2[arg_22_0.id]

		pg = var_2

		local var_22_1

		if var_2.furniture_shop_template[arg_22_0.id] then
			var_22_1 = not arg_22_0:isNotForSale() and (not arg_22_0:isForActivity() or not not var_22_0) and not not arg_22_0:inTime()
		end

		return var_22_1
	end

	local function var_21_4(arg_23_0)
		getInputText = var_2_10001

		if not var_2_10001(arg_21_0.searchInput) or var_1 == "" then
			return true
		else
			return arg_23_0:isMatchSearchKey(var_1)
		end

		return
	end

	local function var_21_5(arg_24_0)
		local var_24_0

		if not var_21_2[arg_24_0] then
			Furniture = var_2_10002
			var_24_0 = var_2_10002.New({
				id = arg_24_0
			})
		end

		if var_21_3(var_24_0) and var_21_4(var_24_0) then
			table = var_2

			var_2.insert(var_21_0, var_24_0)
		end

		return
	end

	if arg_21_0.pageType == 5 then
		ipairs = var_6
		pg = var_1_10008

		for iter_21_0, iter_21_1 in var_6(var_1_10008.furniture_data_template.get_id_list_by_tag[7]) do
			var_21_5(iter_21_1)
		end
	else
		local var_21_6 = var_0_3(arg_21_0.pageType)

		pg = var_1_10007

		local var_21_7 = var_1_10007.furniture_data_template.get_id_list_by_type

		ipairs = var_8

		for iter_21_2, iter_21_3 in var_8(var_21_6) do
			ipairs = var_1_10013

			local var_21_8

			if not var_21_7[iter_21_3] then
				var_21_8 = {}
			end

			for iter_21_4, iter_21_5 in var_1_10013(var_21_8) do
				var_21_5(iter_21_5)
			end
		end
	end

	return var_21_0
end

function var_0_1.OnInitItem(arg_25_0, arg_25_1)
	BackYardFurnitureCard = var_1_10002

	local var_25_0 = var_1_10002.New(arg_25_1)

	onButton = var_1_10003

	local var_25_1 = arg_25_0
	local var_25_2 = var_25_0._go

	local function var_25_3()
		local var_26_0 = var_25_0.furniture

		if var_0.canPurchase(var_26_0) then
			local var_26_1 = arg_25_0.contextData.furnitureMsgBox

			var_0.ExecuteAction(var_26_1, "SetUp", var_25_0.furniture, arg_25_0.dorm, arg_25_0.player)
		end

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_25_1, var_25_2, var_25_3, var_1_10008)

	arg_25_0.cards[arg_25_1] = var_25_0

	return
end

function var_0_1.OnUpdateItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0

	if not arg_27_0.cards[arg_27_2] then
		arg_27_0:OnInitItem(arg_27_2)

		var_27_0 = arg_27_0.cards[arg_27_2]
	end

	local var_27_1 = arg_27_0.displays[arg_27_1 + 1]

	var_27_0:Update(var_27_1)

	return
end

function var_0_1.OnDestroy(arg_28_0)
	pairs = var_1_10001

	for iter_28_0, iter_28_1 in var_1_10001(arg_28_0.cards) do
		iter_28_1:Clear()
	end

	return
end

return var_0_1
