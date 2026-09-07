local BackYardThemeInfoPage = class("BackYardThemeInfoPage", import("....base.BaseSubView"))

function BackYardThemeInfoPage:getUIName()
	return "BackYardThemeInfoPage"
end

function BackYardThemeInfoPage:OnLoaded()
	self.scrollRect = self._tf:Find("frame/list"):GetComponent("LScrollRect")
	self.nameTxt = self._tf:Find("frame/name"):GetComponent(typeof(Text))
	self.icon = self._tf:Find("frame/icon/Image"):GetComponent(typeof(Image))
	self.desc = self._tf:Find("frame/desc"):GetComponent(typeof(Text))
	self.backBtn = self._tf:Find("frame/back")
	self.leftArrBtn = self._tf:Find("arr_left")
	self.rightArrBtn = self._tf:Find("arr_right")
	self.gemTxt = self._tf:Find("res_gem/Text"):GetComponent(typeof(Text))
	self.goldTxt = self._tf:Find("res_gold/Text"):GetComponent(typeof(Text))
	self.gemAddBtn = self._tf:Find("res_gem/jiahao")
	self.goldAddBtn = self._tf:Find("res_gold/jiahao")
	self.purchaseBtn = self._tf:Find("frame/purchase_btn")
	self.purchaseAllBtn = self._tf:Find("frame/purchase_all_btn")

	setText(self.purchaseBtn:Find("Text"), i18n("fur_onekey_buy"))
	setText(self.purchaseAllBtn:Find("Text"), i18n("fur_all_buy"))

	return
end

function BackYardThemeInfoPage:OnInit()
	self.cards = {}

	function self.scrollRect.onInitItem(arg_4_0)
		self:OnInitCard(arg_4_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_5_0, arg_5_1)
		self:OnUpdateCard(arg_5_0, arg_5_1)

		return
	end

	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.purchaseBtn, function()
		self.contextData.themeMsgBox:ExecuteAction("SetUp", self.themeVO, self.dorm, self.player)

		return
	end, SFX_PANEL)
	onButton(self, self.purchaseAllBtn, function()
		self.contextData.themeAllMsgBox:ExecuteAction("SetUp", self.themeVO, self.dorm, self.player)

		return
	end, SFX_PANEL)
	onButton(self, self.leftArrBtn, function()
		if self.OnPrevTheme then
			self.OnPrevTheme()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.rightArrBtn, function()
		if self.OnNextTheme then
			self.OnNextTheme()
		end

		return
	end, SFX_PANEL)
	onButton(self, self.goldAddBtn, function()
		self:emit(NewBackYardShopMediator.ON_CHARGE, PlayerConst.ResDormMoney)

		return
	end, SFX_PANEL)
	onButton(self, self.gemAddBtn, function()
		self:emit(NewBackYardShopMediator.ON_CHARGE, PlayerConst.ResDiamond)

		return
	end, SFX_PANEL)

	return
end

function BackYardThemeInfoPage:OnPlayerUpdated(arg_14_1)
	self.player = arg_14_1

	self:UpdateRes()

	return
end

function BackYardThemeInfoPage:DormUpdated(arg_15_1)
	self.dorm = arg_15_1

	return
end

function BackYardThemeInfoPage:FurnituresUpdated(arg_16_1)
	local var_16_0 = self.dorm:GetPurchasedFurnitures()

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		self:OnDisplayUpdated(var_16_0[iter_16_1])
		self:OnCardUpdated(var_16_0[iter_16_1])
	end

	self:UpdatePurchaseBtn()

	return
end

function BackYardThemeInfoPage:OnDisplayUpdated(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(self.displays) do
		if iter_17_1.id == arg_17_1.id then
			self.displays[iter_17_0] = arg_17_1
		end
	end

	return
end

function BackYardThemeInfoPage:OnCardUpdated(arg_18_1)
	for iter_18_0, iter_18_1 in pairs(self.cards) do
		if iter_18_1.furniture.id == arg_18_1.id then
			iter_18_1:Update(arg_18_1)
		end
	end

	return
end

function BackYardThemeInfoPage:SetUp(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self:Show()

	self.index = arg_19_1
	self.dorm = arg_19_3
	self.themeVO = arg_19_2
	self.player = arg_19_4

	self:InitFurnitureList()
	self:UpdateThemeInfo()
	self:UpdateRes()

	return
end

function BackYardThemeInfoPage:UpdateRes()
	self.gemTxt.text = self.player:getTotalGem()
	self.goldTxt.text = self.player:getResource(PlayerConst.ResDormMoney)

	return
end

function BackYardThemeInfoPage:InitFurnitureList()
	local var_21_0 = self.dorm:GetPurchasedFurnitures()

	self.displays = {}

	for iter_21_0, iter_21_1 in ipairs((self.themeVO:GetFurnitures())) do
		table.insert(self.displays, var_21_0[iter_21_1] or Furniture.New({
			id = iter_21_1
		}))
	end

	table.sort(self.displays, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:canPurchase() and 1 or 0
		local var_22_1 = arg_22_1:canPurchase() and 1 or 0

		if var_22_0 == var_22_1 then
			return arg_22_0.id < arg_22_1.id
		else
			return var_22_1 < var_22_0
		end

		return
	end)
	self.scrollRect:SetTotalCount(#self.displays)

	return
end

function BackYardThemeInfoPage:OnInitCard(arg_23_1)
	local var_23_0 = BackYardFurnitureCard.New(arg_23_1)

	onButton(self, var_23_0._go, function()
		if var_23_0.furniture:canPurchase() then
			self.contextData.furnitureMsgBox:ExecuteAction("SetUp", var_23_0.furniture, self.dorm, self.player)
		end

		return
	end, SFX_PANEL)

	self.cards[arg_23_1] = var_23_0

	return
end

function BackYardThemeInfoPage:OnUpdateCard(arg_25_1, arg_25_2)
	if not self.cards[arg_25_2] then
		self:OnInitCard(arg_25_2)
	end

	self.cards[arg_25_2]:Update(self.displays[arg_25_1 + 1])

	return
end

function BackYardThemeInfoPage:UpdateThemeInfo()
	self.nameTxt.text = HXSet.hxLan(self.themeVO:getConfig("name"))

	GetSpriteFromAtlasAsync("BackYardTheme/theme_" .. self.themeVO.id, "", function(arg_27_0)
		if IsNil(self.icon) then
			return
		end

		self.icon.sprite = arg_27_0

		return
	end)
	self.icon:SetNativeSize()

	self.desc.text = HXSet.hxLan(self.themeVO:getConfig("desc"))

	self:UpdatePurchaseBtn()

	return
end

function BackYardThemeInfoPage:UpdatePurchaseBtn()
	local var_28_0 = self.themeVO:GetFurnitures()
	local var_28_1 = self.dorm:GetPurchasedFurnitures()

	setActive(self.purchaseBtn, (_.any(var_28_0, function(arg_29_0)
		return not var_28_1[arg_29_0]
	end)))
	setActive(self.purchaseAllBtn, (_.any(var_28_0, function(arg_30_0)
		return self.dorm:GetOwnFurnitureCount(arg_30_0) < pg.furniture_data_template[arg_30_0].count
	end)))

	return
end

function BackYardThemeInfoPage:Show()
	BackYardThemeInfoPage.super.Show(self)
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	if self.OnEnter then
		self.OnEnter()
	end

	return
end

function BackYardThemeInfoPage:Hide()
	BackYardThemeInfoPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance().UIMain)

	if self.OnExit then
		self.OnExit()
	end

	return
end

function BackYardThemeInfoPage:OnDestroy()
	self:Hide()

	for iter_33_0, iter_33_1 in pairs(self.cards) do
		iter_33_1:Clear()
	end

	return
end

return BackYardThemeInfoPage
