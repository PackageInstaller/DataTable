local BackYardThemePage = class("BackYardThemePage", import(".BackYardShopBasePage"))

function BackYardThemePage:getUIName()
	return "BackYardThemePage"
end

function BackYardThemePage:OnLoaded()
	self:LoadList()
	self:LoadDetail()

	self.largeSpLoader = BackYardLargeSpriteLoader.New(6)

	return
end

function BackYardThemePage:LoadList()
	self._parentTF = self._tf.parent
	self.adpter = self._tf:Find("adpter")
	self.themeContainer = self._tf:Find("list/frame")
	self.scrollRect = self._tf:Find("list/frame/mask/content"):GetComponent("LScrollRect")
	self.scrollRectWidth = self._tf:Find("list/frame/mask").rect.width
	self.searchInput = self._tf:Find("adpter/search")
	self.searchClear = self.searchInput:Find("clear")

	setText(self.searchInput:Find("Placeholder"), i18n("courtyard_label_search_holder"))

	return
end

function BackYardThemePage:LoadDetail()
	self.purchaseBtn = self._tf:Find("adpter/descript/btn_goumai")
	self.title = self._tf:Find("adpter/descript/title"):GetComponent(typeof(Text))
	self.desc = self._tf:Find("adpter/descript/desc"):GetComponent(typeof(Text))
	self.actualPrice = self._tf:Find("adpter/descript/price/actual_price")
	self.actualPriceTxt = self._tf:Find("adpter/descript/price/actual_price/Text"):GetComponent(typeof(Text))
	self.goldTxt = self._tf:Find("adpter/descript/price/price/Text"):GetComponent(typeof(Text))
	self.preview = self._tf:Find("preview"):GetComponent(typeof(Image))
	self.descript = self._tf:Find("adpter/descript")
	self.infoPage = BackYardThemeInfoPage.New(self._tf.parent, self.event, self.contextData)

	function self.infoPage.OnEnter()
		self:UnBlurView()

		return
	end

	function self.infoPage.OnExit()
		self:BlurView()

		return
	end

	function self.infoPage.OnPrevTheme()
		self:OnInfoPagePrevTheme()

		return
	end

	function self.infoPage.OnNextTheme()
		self:OnInfoPageNextTheme()

		return
	end

	onButton(self, self.purchaseBtn, function()
		self.infoPage:ExecuteAction("SetUp", self:GetSelectedIndex(), self.selected, self.dorm, self.player)

		return
	end, SFX_PANEL)
	setText(self.purchaseBtn:Find("Text"), i18n("word_buy"))

	return
end

function BackYardThemePage:OnInit()
	self.cards = {}

	function self.scrollRect.onInitItem(arg_11_0)
		self:OnInitCard(arg_11_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_12_0, arg_12_1)
		self:OnUpdateCard(arg_12_0, arg_12_1)

		return
	end

	self:InitInput()
	onButton(self, self.searchClear, function()
		setInputText(self.searchInput, "")

		return
	end, SFX_PANEL)

	return
end

function BackYardThemePage:InitInput()
	onInputChanged(self, self.searchInput, function()
		setActive(self.searchClear, getInputText(self.searchInput) ~= "")
		self:OnSearchKeyChange()

		return
	end)

	return
end

function BackYardThemePage:GetData()
	local var_16_0 = {}
	local var_16_1 = getInputText(self.searchInput)
	local var_16_2 = self.dorm:GetPurchasedFurnitures()
	local var_16_3 = {}

	for iter_16_0, iter_16_1 in ipairs((getProxy(DormProxy):GetSystemThemes())) do
		if not iter_16_1:IsOverTime() and iter_16_1:MatchSearchKey(var_16_1) then
			table.insert(var_16_0, iter_16_1)

			var_16_3[iter_16_1.id] = iter_16_1:IsPurchased(var_16_2) and 1 or 0
		end
	end

	local var_16_4 = pg.backyard_theme_template

	local function var_16_5(arg_17_0, arg_17_1)
		if var_16_4[arg_17_0.id].hot == var_16_4[arg_17_1.id].hot then
			return var_16_4[arg_17_0.id].order > var_16_4[arg_17_1.id].order
		else
			return var_16_4[arg_17_0.id].hot > var_16_4[arg_17_1.id].hot
		end

		return
	end

	table.sort(var_16_0, function(arg_18_0, arg_18_1)
		local var_18_0 = var_16_3[arg_18_0.id]
		local var_18_1 = var_16_3[arg_18_1.id]

		if var_16_3[arg_18_0.id] == var_16_3[arg_18_1.id] then
			if var_16_4[arg_18_0.id].new == var_16_4[arg_18_1.id].new then
				return var_16_5(arg_18_0, arg_18_1)
			else
				return var_16_4[arg_18_0.id].new > var_16_4[arg_18_1.id].new
			end
		else
			return var_18_0 < var_18_1
		end

		return
	end)

	return var_16_0
end

function BackYardThemePage:FurnituresUpdated(arg_19_1)
	if self.infoPage:GetLoaded() then
		self.infoPage:ExecuteAction("FurnituresUpdated", arg_19_1)
	end

	if self.card then
		self:UpdatePrice(self.card)
	end

	self:InitThemeList()

	return
end

function BackYardThemePage:OnDormUpdated()
	if self.infoPage:GetLoaded() then
		self.infoPage:ExecuteAction("DormUpdated", self.dorm)
	end

	return
end

function BackYardThemePage:OnPlayerUpdated()
	if self.infoPage:GetLoaded() then
		self.infoPage:ExecuteAction("OnPlayerUpdated", self.player)
	end

	return
end

function BackYardThemePage:OnSetUp()
	self:InitThemeList()
	self:BlurView()

	return
end

function BackYardThemePage:InitThemeList()
	self.disPlays = self:GetData()

	onNextTick(function()
		self.scrollRect.enabled = true

		self.scrollRect:SetTotalCount(#self.disPlays)

		return
	end)

	return
end

function BackYardThemePage:OnSearchKeyChange()
	self:InitThemeList()

	return
end

function BackYardThemePage:CreateCard(arg_26_1)
	return (BackYardThemeCard.New(arg_26_1))
end

function BackYardThemePage:OnInitCard(arg_27_1)
	local var_27_0 = self:CreateCard(arg_27_1)

	onButton(self, var_27_0._go, function()
		self:OnCardClick(var_27_0)

		self.selected = var_27_0.themeVO

		if self.selected then
			for iter_28_0, iter_28_1 in pairs(self.cards) do
				if iter_28_1.themeVO.id == self.selected.id and iter_28_1._go.name ~= "-1" then
					preCard = iter_28_1

					break
				end
			end

			if preCard then
				preCard:UpdateSelected(self.selected)
			end
		end

		var_27_0:UpdateSelected(self.selected)

		return
	end, SFX_PANEL)

	self.cards[arg_27_1] = var_27_0

	return
end

function BackYardThemePage:OnUpdateCard(arg_29_1, arg_29_2)
	if not self.cards[arg_29_2] then
		self:OnInitCard(arg_29_2)
	end

	local var_29_0 = self.cards[arg_29_2]

	self.cards[arg_29_2]:Update(self.disPlays[arg_29_1 + 1], self.disPlays[arg_29_1 + 1]:IsPurchased((self.dorm:GetPurchasedFurnitures())))
	var_29_0:UpdateSelected(self.selected)

	if self:NoSelected() and arg_29_1 == 0 then
		triggerButton(var_29_0._go)
	end

	return
end

function BackYardThemePage:NoSelected()
	return not self.selected or not _.any(self.disPlays, function(arg_31_0)
		return arg_31_0.id == self.selected.id
	end)
end

function BackYardThemePage:OnCardClick(arg_32_1)
	self:UpdateMainPage(arg_32_1.themeVO)

	return
end

function BackYardThemePage:UpdateMainPage(arg_33_1)
	if arg_33_1 == self.card then
		return
	end

	self.title.text = string.gsub(string.gsub(arg_33_1:getConfig("name"), "<size=%d+>", ""), "</size>", "")
	self.desc.text = arg_33_1:getConfig("desc")

	local var_33_0 = arg_33_1:getConfig("discount")

	setActive(self.actualPrice, (arg_33_1:HasDiscount()))
	self:UpdatePrice(arg_33_1)
	self.largeSpLoader:LoadSpriteAsync("BackYardTheme/theme_" .. arg_33_1.id, function(arg_34_0)
		if IsNil(self.preview) then
			return
		end

		self.preview.sprite = arg_34_0
		self.preview.enabled = true

		return
	end)

	self.card = arg_33_1

	return
end

function BackYardThemePage:UpdatePrice(arg_35_1)
	local var_35_0, var_35_1 = self:CalcThemePrice(arg_35_1)

	self.actualPriceTxt.text = var_35_1
	self.goldTxt.text = var_35_0

	return
end

function BackYardThemePage:GetAddList(arg_36_1)
	local var_36_0 = {}
	local var_36_1 = self.dorm:GetPurchasedFurnitures()

	for iter_36_0, iter_36_1 in ipairs((arg_36_1:GetFurnitures())) do
		if not var_36_1[iter_36_1] then
			table.insert(var_36_0, Furniture.New({
				id = iter_36_1
			}))
		end
	end

	return var_36_0
end

function BackYardThemePage:CalcThemePrice(arg_37_1)
	local var_37_0 = 0
	local var_37_1 = 0

	for iter_37_0, iter_37_1 in ipairs((self:GetAddList(arg_37_1))) do
		var_37_1 = var_37_1 + iter_37_1:getConfig("dorm_icon_price")
		var_37_0 = var_37_0 + iter_37_1:getPrice(PlayerConst.ResDormMoney)
	end

	return var_37_0, var_37_1
end

local function var_0_1(arg_38_0, arg_38_1)
	local var_38_0

	for iter_38_0, iter_38_1 in pairs(arg_38_0) do
		if iter_38_1.themeVO.id == arg_38_1.id then
			var_38_0 = iter_38_1

			break
		end
	end

	return var_38_0
end

local function var_0_2(arg_39_0, arg_39_1, arg_39_2)
	return math.abs(arg_39_0:HeadIndexToValue(arg_39_2) - arg_39_0:HeadIndexToValue(arg_39_1))
end

function BackYardThemePage:GetSelectedIndex()
	local var_40_0 = 0

	for iter_40_0, iter_40_1 in ipairs(self.disPlays) do
		if iter_40_1.id == self.selected.id then
			var_40_0 = iter_40_0

			break
		end
	end

	return var_40_0
end

function BackYardThemePage:OnSwitchToNextTheme()
	local var_41_0 = self:GetSelectedIndex()

	if var_41_0 >= #self.disPlays then
		return false
	end

	local var_41_1 = self.disPlays[var_41_0 + 1]
	local var_41_2 = var_0_1(self.cards, self.disPlays[var_41_0 + 1])

	if not var_41_2 or var_41_2 and (function(arg_42_0)
		return go(self.scrollRect).transform.localPosition.x + self.scrollRectWidth / 2 < go(self.scrollRect).transform.parent:InverseTransformPoint(arg_42_0._tf.position).x
	end)(var_41_2) then
		self.scrollRect:ScrollTo(self.scrollRect.value + var_0_2(self.scrollRect, 1, 2), true)

		var_41_2 = var_0_1(self.cards, var_41_1)
	end

	if var_41_2 then
		triggerButton(var_41_2._go)
	end

	return true
end

function BackYardThemePage:OnSwitchToPrevTheme()
	local var_43_0 = self:GetSelectedIndex()

	if var_43_0 <= 1 then
		return false
	end

	local var_43_1 = self.disPlays[var_43_0 - 1]
	local var_43_2 = var_0_1(self.cards, self.disPlays[var_43_0 - 1])

	if not var_43_2 or var_43_2 and (function(arg_44_0)
		return go(self.scrollRect).transform.localPosition.x - self.scrollRectWidth / 2 > go(self.scrollRect).transform.parent:InverseTransformPoint(arg_44_0._tf.position).x
	end)(var_43_2) then
		self.scrollRect:ScrollTo(self.scrollRect.value - var_0_2(self.scrollRect, 1, 2), true)

		var_43_2 = var_0_1(self.cards, var_43_1)
	end

	if var_43_2 then
		triggerButton(var_43_2._go)
	end

	return true
end

function BackYardThemePage:OnInfoPagePrevTheme()
	if self:OnSwitchToPrevTheme() then
		triggerButton(self.purchaseBtn)
	end

	return
end

function BackYardThemePage:OnInfoPageNextTheme()
	if self:OnSwitchToNextTheme() then
		triggerButton(self.purchaseBtn)
	end

	return
end

function BackYardThemePage:Hide()
	BackYardThemePage.super.Hide(self)
	self:UnBlurView()

	return
end

function BackYardThemePage:BlurView()
	pg.UIMgr.GetInstance():OverlayPanel(self.adpter, {
		pbList = {
			self._tf:Find("adpter/descript")
		}
	})

	return
end

function BackYardThemePage:UnBlurView()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.adpter, self._tf)

	return
end

function BackYardThemePage:OnDestroy()
	if self.largeSpLoader then
		self.largeSpLoader:Dispose()

		self.largeSpLoader = nil
	end

	if self.infoPage then
		self.infoPage.OnExit = nil
		self.infoPage.OnEnter = nil
		self.infoPage.OnPrevTheme = nil
		self.infoPage.OnNextTheme = nil

		self.infoPage:Destroy()
	end

	for iter_50_0, iter_50_1 in pairs(self.cards or {}) do
		iter_50_1:Dispose()
	end

	self.cards = nil

	self:Hide()

	return
end

return BackYardThemePage
