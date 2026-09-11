local FreeSkinBuyCheckView = class("FreeSkinBuyCheckView", ReduxView)
local var_0_1 = {
	ViewDlc = 1,
	notViewDlc = 2
}

function FreeSkinBuyCheckView:UIName()
	return "Widget/System/Recharge/RechargeSkinPopUI"
end

function FreeSkinBuyCheckView:UIParent()
	return manager.ui.uiPop.transform
end

function FreeSkinBuyCheckView:Init()
	self:InitUI()
	self:AddUIListener()
end

function FreeSkinBuyCheckView:InitUI()
	self:BindCfgUI()

	self.dlcselController = self.controller_:GetController("dlcsel")
	self.dlcbtnController = self.controller_:GetController("dlcbtn")
	self.dlcbgController = self.controller_:GetController("dlcbg")
	self.dlcIconController = self.controller_:GetController("dlcIcon")
	self.discountController = self.controller_:GetController("discount")
	self.giveBackItem2 = CommonItemView.New(self.giveBackGo2_, true)
end

function FreeSkinBuyCheckView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.calcelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.checkBtn_, nil, function()
		local var_8_0, var_8_1, var_8_2 = ShopTools.GetPrice(self.goodID)
		local var_8_3 = var_8_0
		local var_8_4 = {
			self.goodID,
			self.dlcID
		}

		local function var_8_5()
			if ShopTools.IsRMB(self.goodID) == false and ShopTools.GetCostCount(self.goodID) < var_8_3 then
				ShopTools.ConfirmBuySkin(var_8_4, {
					1,
					1
				})
			else
				ShopTools.ConfirmBuySkin(var_8_4, {
					1,
					1
				})
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_skin_buy_unlock = 0
				})
			end
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin_buy_check = self.skinID
		})

		if ShopData.IsGoodOutOfDate(self.goodID) then
			ShowTips("SKIN_SALE_FINISH")
			self:Back()

			return
		end

		if HeroData:GetHeroData(self.heroID).unlock == 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("NOT_HAVE_HERO_SKIN_CONFIRM"), GetI18NText(self.heroCfg.name)),
				OkCallback = var_8_5,
				CancelCallback = function()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_skin_buy_unlock = 1
					})
				end
			})
		else
			var_8_5()
		end
	end)
	self:AddBtnListener(self.freeViewBtn_, nil, function()
		self.showModel = var_0_1.ViewDlc

		self:UpdateView()
	end)
	self:AddBtnListener(self.freeViewBackBtn_, nil, function()
		self.showModel = var_0_1.notViewDlc

		self:UpdateView()
	end)
	self:AddBtnListener(self.btnView_, nil, function()
		JumpTools.OpenPageByJump("/skinDlcShow", {
			goodId = self.goodID
		})
	end)
end

function FreeSkinBuyCheckView:OnShopBuyResult(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_1 == 0 then
		self:Back()
	else
		self:Back()
	end
end

function FreeSkinBuyCheckView:UpdateBar()
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId(),
		CurrencyConst.CURRENCY_TYPE_SKIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
end

function FreeSkinBuyCheckView:OnTop()
	self:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function FreeSkinBuyCheckView:UpdateData()
	self.shopCfg = getShopCfg(self.goodID)
	self.shopID = self.shopCfg.shop_id
	self.skinCfg = SkinCfg[self.skinID]
	self.heroCfg = HeroCfg[self.skinCfg.hero]
	self.desCfg = RechargeShopDescriptionCfg[self.shopCfg.description]
	self.descID = self.desCfg.id
	self.dlcID = self.shopCfg.dlc or nil
	self.shopDlcCfg = getShopCfg(self.dlcID)
	self.itemDlcCfg = RechargeShopDescriptionCfg[self.shopDlcCfg.description]
	self.showModel = var_0_1.ViewDlc
end

function FreeSkinBuyCheckView:UpdatePrice()
	local var_18_0, var_18_1, var_18_2 = ShopTools.GetPrice(self.goodID)
	local var_18_3 = 0
	local var_18_4 = 0

	if self.dlcID and self.dlcID ~= 0 then
		local var_18_6

		var_18_3, var_18_4, var_18_6 = ShopTools.GetPrice(self.dlcID)
	end

	local var_18_7 = ItemCfg[self.skinCfg.hero]

	SetActive(self.oriOriceTxt_.gameObject, false)
	SetActive(self.skinOriginTxt_.gameObject, false)
	SetActive(self.dlcPrice_.gameObject, false)
	self.dlcbgController:SetSelectedState("false")

	local var_18_8, var_18_9, var_18_10 = ShopTools.IsOnDiscountArea(self.goodID)

	self.buyDesc_.text = string.format(GetTips("BUY_SKIN_FREE_DLC_TIPS"), ItemTools.getItemName(self.shopCfg.cost_id), var_18_0, ItemTools.getItemName(var_18_7.id), ItemTools.getItemName(self.shopCfg.description), ItemTools.getItemName(self.itemDlcCfg.id))

	SetActive(self.costiconImg_.gameObject, true)

	if var_18_8 and var_18_10 then
		SetActive(self.skinOriginTxt_.gameObject, var_18_0 ~= var_18_1)

		if var_18_0 ~= var_18_1 then
			self.skinOriginTxt_.text = var_18_1
		end
	end

	self.costiconImg_.sprite = ItemTools.getItemLittleSprite(self.shopCfg.cost_id)
	self.priceText_.text = var_18_0 + var_18_3

	if var_18_0 > ItemTools.getItemNum(self.shopCfg.cost_id) then
		self.priceText_.text = "<color=#FF000B>" .. var_18_0 .. "</color>"
	end

	if #self.shopCfg.give_back_list ~= 0 then
		self.rebackSkinTicketText_.text = self.shopCfg.give_back_list[1].num
		self.allrebackTxt_.text = ""
	end

	if self.showModel == var_0_1.notViewDlc then
		self.allPriceTxt_.text = ""

		SetActive(self.kuoGo_, false)
	else
		SetActive(self.oriOriceTxt_.gameObject, true)

		self.oriOriceTxt_.text = var_18_4

		SetActive(self.dlcPrice_.gameObject, true)

		self.allPriceTxt_.text = string.format("( %d", var_18_0)
		self.dlcPrice_.text = "+0"

		SetActive(self.kuoGo_, true)
	end
end

function FreeSkinBuyCheckView:UpdateTitle()
	if self.showModel == var_0_1.ViewDlc then
		self.textnameText_.text = ItemTools.getItemName(self.itemDlcCfg.id)
		self.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(self.itemDlcCfg.id)) .. ItemTools.getItemDesc(self.itemDlcCfg.id)
	else
		self.textnameText_.text = ItemTools.getItemName(self.shopCfg.description)
		self.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(self.shopCfg.description)) .. ItemTools.getItemDesc(self.descID)
	end
end

function FreeSkinBuyCheckView:UpdateView()
	self:UpdatePrice()
	self:UpdateTitle()
	SetActive(self.dlcItemLimit_, false)
	SetActive(self.freeGiveGo_, true)
	SetActive(self.freeForeverGo_, false)
	self.dlcselController:SetSelectedState(self.showModel == var_0_1.ViewDlc and "true" or "false")
	SetActive(self.giveBackGo_, #self.shopCfg.give_back_list ~= 0)

	if nullable(self.shopCfg.give_back_list, 2) then
		self.giveBackItem2:SetData((rewardToItemTemplate(formatReward(self.shopCfg.give_back_list[2]), nil, true)))
		SetActive(self.giveBackItem2.gameObject_, true)
	else
		SetActive(self.giveBackItem2.gameObject_, false)
	end

	SetActive(self.skinRemainGo_, false)

	self.skinImg_.sprite = getSpriteViaConfig("HeroIcon", self.skinCfg.picture_id)

	self.skinImg_:SetNativeSize()
	self.dlcIconController:SetSelectedState(self.shopDlcCfg and "true" or "false")

	if self.dlcID and ShopTools.CheckDlcCanBuy(self.dlcID) and ShopTools.CheckDlcPurchased(self.dlcID) == false and self.shopDlcCfg.shop_id == self.shopID then
		if self.showModel == var_0_1.ViewDlc then
			self.dlcbtnController:SetSelectedState("gift2")
		else
			self.dlcbtnController:SetSelectedState("gift1")
		end

		self.dlcIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. self.skinCfg.id .. "_character")
		self.dlcLittleIcon_.sprite = ItemTools.getItemSprite(self.itemDlcCfg.id)
		self.dlcBgImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/BackgroundQuad/" .. HomeSceneSettingCfg[self.itemDlcCfg.id].prefix)
		self.dlcbuyTxt_.text = string.format(GetTips("BUY_SKIN_DLC_TIPS"), ItemTools.getItemName(self.itemDlcCfg.id))
		self.dlcItemNameTxt_.text = string.format(ItemTools.getItemName(self.itemDlcCfg.id))
	end

	self:UpdateTimeView()
end

function FreeSkinBuyCheckView:UpdateTimer()
	self:UpdateTimeView()

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimeView()
		end, 1, -1, -1)

		self.timer_:Start()
	end
end

function FreeSkinBuyCheckView:UpdateTimeView()
	if self.shopDlcCfg then
		local var_23_0, var_23_1, var_23_2 = ShopTools.IsOnDiscountArea(self.dlcID)

		if var_23_0 and var_23_2 then
			SetActive(self.dlcItemLimit_, self.shopDlcCfg.is_limit_time_discount == 1)

			self.dlcItemLimitTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(self.shopDlcCfg.cheap_close_time))
		else
			SetActive(self.dlcItemLimit_, false)
		end
	end

	self.freeRemainTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(self.shopDlcCfg.cheap_close_time))

	local var_23_3 = self.shopCfg.close_time
	local var_23_4 = self.shopCfg

	SetActive(self.timeGo_, #self.shopCfg.close_time > 0)

	if #var_23_3 <= 0 then
		self.discountController:SetSelectedState("none")
	end

	if #var_23_3 > 0 then
		local var_23_5 = TimeMgr.GetInstance():parseTimeFromConfig(var_23_3)

		self.remainTxt_.text = var_23_5 <= TimeMgr.GetInstance():GetServerTime() and GetTips("TIP_EXPIRED") or string.format("%s", manager.time:GetLostTimeStr(var_23_5))
	end

	if #var_23_4.cheap_close_time > 0 then
		local var_23_6, var_23_7, var_23_8 = ShopTools.IsOnDiscountArea(var_23_4.goods_id)

		if var_23_6 and var_23_8 then
			self.discountController:SetSelectedState("none")
			SetActive(self.skinRemainGo_, var_23_4.is_limit_time_discount == 1)

			self.skinRemianTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(var_23_4.cheap_close_time))
		else
			self.discountController:SetSelectedState("none")
			SetActive(self.skinRemainGo_, false)
		end
	end

	self:UpdatePrice()
end

function FreeSkinBuyCheckView:OnEnter()
	self.goodID = self.params_.goodID
	self.heroID = self.params_.heroID
	self.skinID = self.params_.skinID

	self:UpdateData()
	self:UpdateView()
	self:UpdateTimer()
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_25_0)
		local var_25_0 = HeroTools.GetSkinChangeItem(self.skinID)

		self:Back()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(var_25_0)),
			OkCallback = function()
				CommonAction.TryToUseItem({
					{
						item_info = {
							num = 1,
							id = var_25_0
						},
						use_list = {}
					}
				})
			end
		})
	end)
end

function FreeSkinBuyCheckView:OnExit()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end

	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function FreeSkinBuyCheckView:Dispose()
	self.giveBackItem2:Dispose()
	FreeSkinBuyCheckView.super.Dispose(self)
end

return FreeSkinBuyCheckView
