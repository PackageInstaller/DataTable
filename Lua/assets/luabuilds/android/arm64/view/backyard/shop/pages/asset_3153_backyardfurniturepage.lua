local BackYardFurniturePage = class("BackYardFurniturePage", import(".BackYardShopBasePage"))
local var_0_1 = Furniture.INDEX_TO_SHOP_TYPE

table.insert(Furniture.INDEX_TO_SHOP_TYPE, 1, {})

local function var_0_2(arg_1_0)
	return var_0_1[arg_1_0]
end

function BackYardFurniturePage:getUIName()
	return "BackYardFurniturePage"
end

function BackYardFurniturePage:OnLoaded()
	self.scrollRect = self._tf:Find("adpter/frame/bg"):GetComponent("LScrollRect")
	self.searchInput = self._tf:Find("adpter/search")
	self.searchClear = self._tf:Find("adpter/search/clear")
	self.filterBtn = self._tf:Find("adpter/filter")
	self.filterBtnTxt = self.filterBtn:Find("Text"):GetComponent(typeof(Text))
	self.filterBtnTxt.text = i18n("word_default")
	self.orderBtn = self._tf:Find("adpter/order")
	self.orderBtnIcon = self.orderBtn:Find("icon")
	self.orderBtnTxt = self.orderBtn:Find("Text"):GetComponent(typeof(Text))

	setText(self.searchInput:Find("Placeholder"), i18n("courtyard_label_search_holder"))

	return
end

function BackYardFurniturePage:OnInit()
	self.cards = {}

	function self.scrollRect.onInitItem(arg_5_0)
		self:OnInitItem(arg_5_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_6_0, arg_6_1)
		self:OnUpdateItem(arg_6_0, arg_6_1)

		return
	end

	onInputChanged(self, self.searchInput, function()
		setActive(self.searchClear, getInputText(self.searchInput) ~= "")
		self:OnSearchKeyChange()

		return
	end)
	onButton(self, self.searchClear, function()
		setInputText(self.searchInput, "")

		return
	end, SFX_PANEL)

	self.orderMode = BackYardDecorationFilterPanel.ORDER_MODE_DASC
	self.orderBtnIcon.localScale = Vector3(1, -1, 1)

	local function var_4_0(arg_9_0)
		local var_9_0 = ""

		if arg_9_0 == BackYardDecorationFilterPanel.ORDER_MODE_ASC then
			var_9_0 = i18n("word_asc")
		elseif arg_9_0 == BackYardDecorationFilterPanel.ORDER_MODE_DASC then
			var_9_0 = i18n("word_desc")
		end

		self.orderBtnTxt.text = var_9_0

		return
	end

	onToggle(self, self.orderBtn, function(arg_10_0)
		if arg_10_0 then
			self.orderMode = BackYardDecorationFilterPanel.ORDER_MODE_ASC or BackYardDecorationFilterPanel.ORDER_MODE_DASC
		end

		var_4_0(self.orderMode)
		self:UpdateFliterData()
		self.contextData.filterPanel:Sort()
		self:OnFilterDone()

		self.orderBtnIcon.localScale = Vector3(1, arg_10_0 and 1 or -1, 1)

		return
	end, SFX_PANEL)
	var_4_0(self.orderMode)

	function self.contextData.filterPanel.confirmFunc()
		self.filterBtnTxt.text = self.contextData.filterPanel.sortTxt

		self:OnFilterDone()

		return
	end

	onButton(self, self.filterBtn, function()
		self.contextData.filterPanel:setFilterData(self:GetData())
		self.contextData.filterPanel:ExecuteAction("Show")

		return
	end, SFX_PANEL)
	self:UpdateFliterData()

	return
end

function BackYardFurniturePage:UpdateFliterData()
	self.contextData.filterPanel:updateOrderMode(self.orderMode)

	return
end

function BackYardFurniturePage:OnFilterDone()
	self.displays = self.contextData.filterPanel:GetFilterData()

	self.scrollRect:SetTotalCount(#self.displays)

	return
end

function BackYardFurniturePage:OnDisplayUpdated(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(self.displays) do
		if iter_15_1.id == arg_15_1.id then
			self.displays[iter_15_0] = arg_15_1

			break
		end
	end

	return
end

function BackYardFurniturePage:OnCardUpdated(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(self.cards) do
		if iter_16_1.furniture.id == arg_16_1.id then
			iter_16_1:Update(arg_16_1)

			break
		end
	end

	return
end

function BackYardFurniturePage:OnDormUpdated()
	self:UpdateFliterData()

	return
end

function BackYardFurniturePage:OnSetUp()
	self:InitFurnitureList()

	return
end

function BackYardFurniturePage:OnSearchKeyChange()
	self:InitFurnitureList()

	return
end

function BackYardFurniturePage:InitFurnitureList()
	self.contextData.filterPanel:setFilterData((self:GetData()))
	self.contextData.filterPanel:filter()
	self:OnFilterDone()

	return
end

function BackYardFurniturePage:GetData()
	local var_21_0 = {}
	local var_21_1 = self.dorm:GetPurchasedFurnitures()

	local function var_21_2(arg_22_0)
		return (pg.furniture_shop_template[arg_22_0.id] or nil) and not arg_22_0:isNotForSale() and (not arg_22_0:isForActivity() or not not var_21_1[arg_22_0.id]) and not not arg_22_0:inTime()
	end

	local function var_21_3(arg_23_0)
		local var_23_0 = getInputText(self.searchInput)

		if not var_23_0 or var_23_0 == "" then
			return true
		else
			return arg_23_0:isMatchSearchKey(var_23_0)
		end

		return
	end

	local function var_21_4(arg_24_0)
		local var_24_0 = var_21_1[arg_24_0] or Furniture.New({
			id = arg_24_0
		})

		if var_21_2(var_24_0) and var_21_3(var_24_0) then
			table.insert(var_21_0, var_24_0)
		end

		return
	end

	if self.pageType == 5 then
		for iter_21_0, iter_21_1 in ipairs(pg.furniture_data_template.get_id_list_by_tag[7]) do
			var_21_4(iter_21_1)
		end
	else
		for iter_21_2, iter_21_3 in ipairs((var_0_2(self.pageType))) do
			for iter_21_4, iter_21_5 in ipairs(pg.furniture_data_template.get_id_list_by_type[iter_21_3] or {}) do
				var_21_4(iter_21_5)
			end
		end
	end

	return var_21_0
end

function BackYardFurniturePage:OnInitItem(arg_25_1)
	local var_25_0 = BackYardFurnitureCard.New(arg_25_1)

	onButton(self, var_25_0._go, function()
		if var_25_0.furniture:canPurchase() then
			self.contextData.furnitureMsgBox:ExecuteAction("SetUp", var_25_0.furniture, self.dorm, self.player)
		end

		return
	end, SFX_PANEL)

	self.cards[arg_25_1] = var_25_0

	return
end

function BackYardFurniturePage:OnUpdateItem(arg_27_1, arg_27_2)
	if not self.cards[arg_27_2] then
		self:OnInitItem(arg_27_2)
	end

	self.cards[arg_27_2]:Update(self.displays[arg_27_1 + 1])

	return
end

function BackYardFurniturePage:OnDestroy()
	for iter_28_0, iter_28_1 in pairs(self.cards) do
		iter_28_1:Clear()
	end

	return
end

return BackYardFurniturePage
