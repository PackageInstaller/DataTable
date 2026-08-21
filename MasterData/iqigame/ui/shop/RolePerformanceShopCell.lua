-- chunkname: @IQIGame\\UI\\Shop\\RolePerformanceShopCell.lua

local RolePerformanceShopCell = {}

function RolePerformanceShopCell.New(go, mainView)
	local o = Clone(RolePerformanceShopCell)

	o:Initialize(go, mainView)

	return o
end

function RolePerformanceShopCell:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()

	if self.Timer == nil then
		self.Timer = Timer.New(function()
			self:CheckTime()
		end, 1, -1)

		self.Timer:Start()
	end
end

function RolePerformanceShopCell:InitComponent()
	self.buttonBuy = self.buttonBuy:GetComponent("Button")
	self.imageRoleSkin = self.imageRoleSkin:GetComponent("Image")
	self.skinPreviewButton = self.skinPreviewButtonObj:GetComponent("Button")
end

function RolePerformanceShopCell:InitDelegate()
	function self.ButtonBuyDelegate()
		self:OnButtonBuyClick()
	end

	function self.DelegateOnSkinPreviewButtonClick()
		self:OnSkinPreviewButtonClick()
	end
end

function RolePerformanceShopCell:AddListener()
	self.buttonBuy.onClick:AddListener(self.ButtonBuyDelegate)
	self.skinPreviewButton.onClick:AddListener(self.DelegateOnSkinPreviewButtonClick)
end

function RolePerformanceShopCell:RemoveListener()
	self.buttonBuy.onClick:RemoveListener(self.ButtonBuyDelegate)
	self.skinPreviewButton.onClick:RemoveListener(self.DelegateOnSkinPreviewButtonClick)
end

function RolePerformanceShopCell:Dispose()
	self:RemoveListener()

	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end

	self.skinPreviewButton = nil
end

function RolePerformanceShopCell:OnButtonBuyClick()
	UIModule.Open(Constant.UIControllerName.BuyResItemUI, Constant.UILayer.UI, {
		data = self.Data
	})
end

function RolePerformanceShopCell:OnSkinPreviewButtonClick()
	UIModule.Open(Constant.UIControllerName.HeroSkinUI, Constant.UILayer.UI, {
		type = Constant.SkinUIOpenType.ShopDetailsUI,
		args = {
			showSkinCid = self.skinCid,
			commodityDataList = self.allCommodityDatas
		}
	})
end

function RolePerformanceShopCell:Refresh(data, allCommodityDatas)
	self.Data = data
	self.allCommodityDatas = allCommodityDatas

	local itemCfg = CfgItemTable[self.Data.config.ItemId]

	self.skinCid = itemCfg.LikeId

	local skinCfg = CfgHeroSkinTable[self.skinCid]
	local heroCfg = CfgHeroTable[skinCfg.HeroId]

	self.heroCid = skinCfg.HeroId

	LuaUtility.SetText(self.textItemName, itemCfg.Name)
	LuaUtility.SetText(self.NameText, heroCfg.Name)
	AssetUtil.LoadImage(self, SkinModule.GetHeroSkinImgPathByType(skinCfg, Constant.SkinImageType.ShopShowImg), self.imageRoleSkin, function()
		LuaUtility.SetImageNativeSizeWithGameObject(self.imageRoleSkin.gameObject)
	end)
	LuaUtility.SetGameObjectShow(self.battleTag, false)
	LuaUtility.SetGameObjectShow(self.skillTag, false)

	for i = 1, #skinCfg.Tips do
		if skinCfg.Tips[i] == Constant.SkinTag.battleTag then
			LuaUtility.SetGameObjectShow(self.battleTag, true)

			break
		elseif skinCfg.Tips[i] == Constant.SkinTag.skillTag then
			LuaUtility.SetGameObjectShow(self.skillTag, true)

			break
		end
	end

	self:Reset()
	self:CheckTime()
	self:CheckBuyLimit()
	self:CheckDiscount()
	self:CheckCommodityTagType()
	self:CheckBuyCondition()
	self:SetRedDotState()
end

function RolePerformanceShopCell:Reset()
	LuaUtility.SetGameObjectShow(self.timeRoot, false)
	LuaUtility.SetGameObjectShow(self.SellOutRoot, false)
	LuaUtility.SetGameObjectShow(self.priceItem, true)
end

function RolePerformanceShopCell:CheckTime()
	if self.Data.refreshType ~= Constant.ShopRefreshType.None then
		LuaUtility.SetGameObjectShow(self.timeRoot, true)
		LuaUtility.SetText(self.textTime, self.Data:GetRefreshTimeText())
	end
end

function RolePerformanceShopCell:CheckDiscount()
	LuaUtility.SetGameObjectShow(self.textDiscountNum, not self.Data.config.Free)
	LuaUtility.SetGameObjectShow(self.freeText, self.Data.config.Free)
	LuaUtility.SetGameObjectShow(self.imageCurrencyIcon, false)

	if self.Data.config.Free then
		LuaUtility.SetGameObjectShow(self.imageCurrencyIcon, false)
		LuaUtility.SetText(self.textDiscountNum, ShopUIApi:GetFreeText())
	else
		AssetUtil.LoadImage(self, ShopUIApi:GetShopBuyIconPath(self.Data:GetPriceIconId()), self.imageCurrencyIcon:GetComponent("Image"))
		LuaUtility.SetGameObjectShow(self.imageCurrencyIcon, true)

		if self.Data.isDiscount and not self.Data.isDiscountWithoutPrice then
			LuaUtility.SetText(self.textDiscountNum, self.Data:GetDiscount())
		else
			LuaUtility.SetText(self.textDiscountNum, self.Data:GetPrice())
		end

		if self.Data.isDiscount then
			LuaUtility.SetText(self.textDiscount, self.Data:GetDiscountPercentText())
		end
	end
end

function RolePerformanceShopCell:CheckBuyLimit()
	if self.Data.buyLimitType == Constant.ShopBuyLimitType.Limit then
		if self.Data.buyNum < self.Data.buyLimit then
			LuaUtility.SetText(self.textLimitTag, ShopUIApi:PurchaseLimitation(self.Data.buyNum, self.Data.buyLimit))
		else
			LuaUtility.SetGameObjectShow(self.SellOutRoot, true)
			LuaUtility.SetGameObjectShow(self.priceItem, false)
			LuaUtility.SetText(self.textLimitTag, ShopUIApi:GetZeroLimitation(self.Data.buyNum, self.Data.buyLimit))
		end
	end
end

function RolePerformanceShopCell:CheckCommodityTagType()
	LuaUtility.SetGameObjectShow(self.longTremTag, self.Data:IsLongTremCommodity())
	LuaUtility.SetGameObjectShow(self.discountTag, self.Data:IsDiscountCommodity())
	LuaUtility.SetGameObjectShow(self.limitTimeTag, self.Data:IsLimitTimeCommodity())
end

function RolePerformanceShopCell:CheckBuyCondition()
	if not self.Data.isBuy and self.Data.buyConditionId ~= nil then
		UGUIUtil.SetText(self.conditionText, CfgConditionTable[self.Data.buyConditionId].Name)
		LuaUtility.SetGameObjectShow(self.conditionRoot, true)
	else
		LuaUtility.SetGameObjectShow(self.conditionRoot, false)
	end
end

function RolePerformanceShopCell:SetRedDotState()
	LuaUtility.SetGameObjectShow(self.RedDot, self.Data.config.Free and self.Data.buyNum < self.Data.buyLimit and self.Data.isBuy)
end

return RolePerformanceShopCell
