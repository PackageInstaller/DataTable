local BackYardThemeMsgBoxPage = class("BackYardThemeMsgBoxPage", import(".BackYardFurnitureMsgBoxPage"))

function BackYardThemeMsgBoxPage:getUIName()
	return "ThemeMsgboxPage"
end

function BackYardThemeMsgBoxPage:OnLoaded()
	BackYardThemeMsgBoxPage.super.OnLoaded(self)

	self.purchaseTr = self._tf:Find("frame/tip")
	self.purchase = self._tf:Find("frame/tip/Text"):GetComponent(typeof(Text))

	return
end

function BackYardThemeMsgBoxPage:OnInit()
	BackYardThemeMsgBoxPage.super.OnInit(self)
	onButton(self, self.gemPurchaseBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.goldPurchaseBtn, function()
		local var_5_0 = self:GetAddList()

		if #var_5_0 <= 0 then
			return
		end

		self:emit(NewBackYardShopMediator.ON_SHOPPING, _.map(var_5_0, function(arg_6_0)
			return arg_6_0.id
		end), PlayerConst.ResDormMoney)
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function BackYardThemeMsgBoxPage:SetUp(arg_7_1, arg_7_2, arg_7_3)
	self.dorm = arg_7_2
	self.themeVO = arg_7_1
	self.player = arg_7_3
	self.count = 1
	self.maxCount = 1

	self:UpdateMainInfo()
	self:UpdateBtns()
	self:UpdatePrice()
	self:Show()

	self.purchase.text = i18n("purchase_backyard_theme_desc_for_onekey")

	setActive(self.purchaseTr, true)
	setText(self.gemPurchaseBtn:Find("content/Text"), i18n("word_buy"))
	setText(self.goldPurchaseBtn:Find("content/Text"), i18n("word_buy"))

	return
end

function BackYardThemeMsgBoxPage:UpdateMainInfo()
	self.nameTxt.text = self.themeVO:getConfig("name")
	self.themeTxt.text = ""
	self.descTxt.text = self.themeVO:getConfig("desc")
	self.maxCnt.text = ""
	self.icon.sprite = GetSpriteFromAtlas("BackYardTheme/" .. self.themeVO.id, "")
	tf(self.icon.gameObject).sizeDelta = Vector2(336, 336)
	self.maxBtnTxt.text = "+" .. self.maxCount

	return
end

function BackYardThemeMsgBoxPage:UpdateBtns()
	setActive(self.goldPurchaseBtn, true)
	setActive(self.gemPurchaseBtn, false)
	setActive(self.gemIcon, false)
	setActive(self.gemCount, false)
	setActive(self.goldIcon, true)
	setActive(self.goldCount, true)
	setActive(self.line, true and false)

	return
end

function BackYardThemeMsgBoxPage:GetAddList()
	local var_10_0 = {}
	local var_10_1 = self.dorm:GetPurchasedFurnitures()

	for iter_10_0, iter_10_1 in ipairs((self.themeVO:GetFurnitures())) do
		if not var_10_1[iter_10_1] then
			table.insert(var_10_0, Furniture.New({
				id = iter_10_1
			}))
		end
	end

	return var_10_0
end

function BackYardThemeMsgBoxPage:UpdatePrice()
	local var_11_0 = self:GetAddList()

	self.gemCount.text = 0 * self.count
	self.goldCount.text = _.reduce(var_11_0, 0, function(arg_12_0, arg_12_1)
		return arg_12_0 + arg_12_1:getPrice(PlayerConst.ResDormMoney)
	end) * self.count

	self:UpdateEnergy(var_11_0)

	return
end

function BackYardThemeMsgBoxPage:OnDestroy()
	return
end

return BackYardThemeMsgBoxPage
