local var_0_0 = class("BackYardFurniturePage", import(".BackYardShopBasePage"))

table.insert(Furniture.INDEX_TO_SHOP_TYPE, 1, {})

local function var_0_1(arg_1_0)
	return var_0[arg_1_0]
end

function var_0_0.getUIName(arg_2_0)
	return "BackYardFurniturePage"
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.scrollRect = arg_3_0._tf:Find("adpter/frame/bg"):GetComponent("LScrollRect")
	arg_3_0.searchInput = arg_3_0._tf:Find("adpter/search")
	arg_3_0.searchClear = arg_3_0._tf:Find("adpter/search/clear")
	arg_3_0.filterBtn = arg_3_0._tf:Find("adpter/filter")
	arg_3_0.filterBtnTxt = arg_3_0.filterBtn:Find("Text"):GetComponent(typeof(Text))
	arg_3_0.filterBtnTxt.text = i18n("word_default")
	arg_3_0.orderBtn = arg_3_0._tf:Find("adpter/order")
	arg_3_0.orderBtnIcon = arg_3_0.orderBtn:Find("icon")
	arg_3_0.orderBtnTxt = arg_3_0.orderBtn:Find("Text"):GetComponent(typeof(Text))

	setText(arg_3_0.searchInput:Find("Placeholder"), i18n("courtyard_label_search_holder"))

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.cards = {}

	function arg_4_0.scrollRect.onInitItem(arg_5_0)
		arg_4_0:OnInitItem(arg_5_0)

		return
	end

	function arg_4_0.scrollRect.onUpdateItem(arg_6_0, arg_6_1)
		arg_4_0:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	onInputChanged(arg_4_0, arg_4_0.searchInput, function()
		setActive(arg_4_0.searchClear, getInputText(arg_4_0.searchInput) ~= "")
		arg_4_0:OnSearchKeyChange()

		return
	end)
	onButton(arg_4_0, arg_4_0.searchClear, function()
		setInputText(arg_4_0.searchInput, "")

		return
	end, SFX_PANEL)

	arg_4_0.orderMode = BackYardDecorationFilterPanel.ORDER_MODE_DASC
	arg_4_0.orderBtnIcon.localScale = Vector3(1, -1, 1)

	local function var_4_0(arg_9_0)
		local var_9_0 = ""

		if arg_9_0 == BackYardDecorationFilterPanel.ORDER_MODE_ASC then
			var_9_0 = i18n("word_asc")
		elseif arg_9_0 == BackYardDecorationFilterPanel.ORDER_MODE_DASC then
			var_9_0 = i18n("word_desc")
		end

		arg_4_0.orderBtnTxt.text = var_9_0

		return
	end

	onToggle(arg_4_0, arg_4_0.orderBtn, function(arg_10_0)
		if arg_10_0 then
			arg_4_0.orderMode = BackYardDecorationFilterPanel.ORDER_MODE_ASC or BackYardDecorationFilterPanel.ORDER_MODE_DASC

			var_4_0(arg_4_0.orderMode)
			arg_4_0:UpdateFliterData()
			arg_4_0.contextData.filterPanel:Sort()
			arg_4_0:OnFilterDone()

			arg_4_0.orderBtnIcon.localScale = Vector3(1, arg_10_0 and 1 or -1, 1)

			return
		end
	end, SFX_PANEL)
	;(function(arg_9_0)
		local var_9_0 = ""

		if arg_9_0 == BackYardDecorationFilterPanel.ORDER_MODE_ASC then
			var_9_0 = i18n("word_asc")
		elseif arg_9_0 == BackYardDecorationFilterPanel.ORDER_MODE_DASC then
			var_9_0 = i18n("word_desc")
		end

		arg_4_0.orderBtnTxt.text = var_9_0

		return
	end)(arg_4_0.orderMode)

	function arg_4_0.contextData.filterPanel.confirmFunc()
		arg_4_0.filterBtnTxt.text = arg_4_0.contextData.filterPanel.sortTxt

		arg_4_0:OnFilterDone()

		return
	end

	onButton(arg_4_0, arg_4_0.filterBtn, function()
		arg_4_0.contextData.filterPanel:setFilterData(arg_4_0:GetData())
		arg_4_0.contextData.filterPanel:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	arg_4_0:UpdateFliterData()

	return
end

function var_0_0.UpdateFliterData(arg_13_0)
	arg_13_0.contextData.filterPanel:updateOrderMode(arg_13_0.orderMode)

	return
end

function var_0_0.OnFilterDone(arg_14_0)
	arg_14_0.displays = arg_14_0.contextData.filterPanel:GetFilterData()

	arg_14_0.scrollRect:SetTotalCount(#arg_14_0.displays)

	return
end

function var_0_0.OnDisplayUpdated(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.displays) do
		if iter_15_1.id == arg_15_1.id then
			arg_15_0.displays[iter_15_0] = arg_15_1

			break
		end
	end

	return
end

function var_0_0.OnCardUpdated(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.cards) do
		if iter_16_1.furniture.id == arg_16_1.id then
			iter_16_1:Update(arg_16_1)

			break
		end
	end

	return
end

function var_0_0.OnDormUpdated(arg_17_0)
	arg_17_0:UpdateFliterData()

	return
end

function var_0_0.OnSetUp(arg_18_0)
	arg_18_0:InitFurnitureList()

	return
end

function var_0_0.OnSearchKeyChange(arg_19_0)
	arg_19_0:InitFurnitureList()

	return
end

function var_0_0.InitFurnitureList(arg_20_0)
	arg_20_0.contextData.filterPanel:setFilterData((arg_20_0:GetData()))
	arg_20_0.contextData.filterPanel:filter()
	arg_20_0:OnFilterDone()

	return
end

function var_0_0.GetData(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = arg_21_0.dorm:GetPurchasedFurnitures()

	local function var_21_2(arg_22_0)
		local var_22_0 = var_21_1[arg_22_0.id]

		return pg.furniture_shop_template[arg_22_0.id] and not arg_22_0:isNotForSale() and (not arg_22_0:isForActivity() or not not var_22_0) and not not arg_22_0:inTime()
	end

	local function var_21_3(arg_23_0)
		local var_23_0 = getInputText(arg_21_0.searchInput)

		if not var_23_0 or var_23_0 == "" then
			return true
		else
			return arg_23_0:isMatchSearchKey(var_23_0)
		end

		return
	end

	if arg_21_0.pageType == 5 then
		for iter_21_0, iter_21_1 in ipairs(pg.furniture_data_template.get_id_list_by_tag[7]) do
			(function(arg_24_0)
				local var_24_0 = var_21_1[arg_24_0] or Furniture.New({
					id = arg_24_0
				})

				if var_21_2(var_24_0) and var_21_3(var_24_0) then
					table.insert(var_21_0, var_24_0)
				end

				return
			end)(iter_21_1)
		end
	else
		for iter_21_2, iter_21_3 in ipairs((var_0_1(arg_21_0.pageType))) do
			local var_21_4 = pg.furniture_data_template.get_id_list_by_type[iter_21_3] or {}

			for iter_21_4, iter_21_5 in ipairs(var_21_4) do
				(function(arg_24_0)
					local var_24_0 = var_21_1[arg_24_0] or Furniture.New({
						id = arg_24_0
					})

					if var_21_2(var_24_0) and var_21_3(var_24_0) then
						table.insert(var_21_0, var_24_0)
					end

					return
				end)(iter_21_5)
			end
		end
	end

	return {}
end

function var_0_0.OnInitItem(arg_25_0, arg_25_1)
	local var_25_0 = BackYardFurnitureCard.New(arg_25_1)

	onButton(arg_25_0, var_25_0._go, function()
		if var_25_0.furniture:canPurchase() then
			arg_25_0.contextData.furnitureMsgBox:ExecuteAction("SetUp", var_25_0.furniture, arg_25_0.dorm, arg_25_0.player)
		end

		return
	end, SFX_PANEL)

	arg_25_0.cards[arg_25_1] = var_25_0

	return
end

function var_0_0.OnUpdateItem(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0.cards[arg_27_2] then
		arg_27_0:OnInitItem(arg_27_2)
	end

	arg_27_0.cards[arg_27_2]:Update(arg_27_0.displays[arg_27_1 + 1])

	return
end

function var_0_0.OnDestroy(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.cards) do
		iter_28_1:Clear()
	end

	return
end

return var_0_0
