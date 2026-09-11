local RechargeGiftPopView = class("RechargeGiftPopView", ReduxView)

function RechargeGiftPopView:UIName()
	return "Widget/System/Recharge/RechargeGiftPopUI"
end

function RechargeGiftPopView:UIParent()
	return manager.ui.uiPop.transform
end

function RechargeGiftPopView:Init()
	self.immeRewardItemList_ = {}
	self.immeRewardItemList2_ = {}
	self.dailyRewardItemList_ = {}

	self:InitUI()
	self:AddUIListener()
end

function RechargeGiftPopView:InitUI()
	self:BindCfgUI()

	self.rewardTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "rewardType")
	self.costTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "costType")
	self.list_ = LuaList.New(handler(self, self.indexItem), self.listGo_, RechargeGiftPopItem)
end

function RechargeGiftPopView:indexItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.itemDesCfg.param[arg_5_1][1], self.itemDesCfg.param[arg_5_1][2], self.selectNum)
end

function RechargeGiftPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.maxBtn_, nil, function()
		self.useNumSlider_.value = self.canUseMaxNum_
	end)
	self:AddBtnListener(self.buyBtn_, nil, function()
		SendMessageManagerToSDK("purchase_click_gp_once")
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox_buy = self.goodID
		})

		local var_10_0, var_10_1 = ShopTools.IsShopSuspended(self.shopID)

		if var_10_0 then
			ShowTips(var_10_1)

			return
		end

		local function var_10_2()
			if ShopTools.IsRMB(self.goodID) then
				PayAction.RequestGSPay((self:IsOnDiscountArea() and PaymentCfg[self.shopCfg.cheap_cost_id] or PaymentCfg[self.shopCfg.cost_id]).id, self.selectNum, self.shopCfg.shop_id, self.shopCfg.goods_id, self.params_.buy_source or 0)
			else
				local var_11_1 = self.params_.buy_source or 0

				if ShopTools.GetPrice(self.goodID) == 0 then
					self:Back()
					ShopAction.BuyItem({
						{
							goodID = self.goodID,
							buyNum = self.selectNum
						}
					}, nil, var_11_1)

					return
				end

				ShopTools.ConfirmBuyItem(self.goodID, self.selectNum, function()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_giftbox_check = 0
					})
					self:Back()
				end, function()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_giftbox_check = 1
					})
					self:UpdateRealtimePrice()
					self:UpdatePreview()
				end, var_11_1)
			end
		end

		local var_10_3, var_10_4 = ShopTools.rewertReward(self.goodID, self.selectNum)

		if #var_10_4 ~= 0 then
			JumpTools.OpenPageByJump("rechargeRevertPop", {
				goodID = self.goodID,
				callBack = var_10_2,
				buyNumber = self.selectNum
			})
		else
			var_10_2()
		end
	end)
	self.useNumSlider_.onValueChanged:AddListener(function()
		self.selectNum = self.useNumSlider_.value

		if self.selectNum < 1 then
			self.selectNum = 1

			self:UpdateSliderPositionBySelectNum()
		end

		self:UpdateDelAddBtn()
		self:UpdatePreview()
	end)
	self:AddPressingByTimeListener(self.delBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.selectNum > 1 then
			self.selectNum = self.selectNum - 1

			self:UpdateSliderPositionBySelectNum()
			self:UpdateDelAddBtn()
			self:UpdatePreview()

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if self.selectNum < self.canUseMaxNum_ then
			self.selectNum = self.selectNum + 1

			self:UpdateSliderPositionBySelectNum()
			self:UpdateDelAddBtn()
			self:UpdatePreview()

			return true
		end

		return false
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("SHOP_GIFT_DESCRIBE"),
			content = self.itemDesCfg.desc2
		})
	end)
end

function RechargeGiftPopView:UpdateDelAddBtn()
	self.delBtn_.interactable = self.selectNum > 1
	self.addBtn_.interactable = self.selectNum < self.canUseMaxNum_
end

function RechargeGiftPopView:UpdateSliderPositionBySelectNum()
	self.useNumSlider_.value = self.selectNum
end

function RechargeGiftPopView:UpdateRealtimePrice()
	self.price_, self.oldPrice_, self.pricePercent_ = ShopTools.GetPrice(self.goodID)
end

function RechargeGiftPopView:UpdatePreview()
	self.buyNumLabel_.text = tostring(self.selectNum)

	if self.price_ * self.selectNum <= 0 then
		self.costTypeController_:SetSelectedState("free")
	elseif ShopTools.IsRMB(self.goodID) then
		self.costTypeController_:SetSelectedState("money")

		self.totleLabel_.text = self.price_ * self.selectNum
		self.rmbLabel_.text = GetTips("MONEY_SYMBOL")
	else
		self.costTypeController_:SetSelectedState("currency")

		self.costIcon_.sprite = ItemTools.getItemLittleSprite(self.shopCfg.cost_id)
		self.totleLabel_.text = self.price_ * self.selectNum

		if self.price_ * self.selectNum > ItemTools.getItemNum(self.shopCfg.cost_id) then
			self.totleLabel_.text = "<color=#FF000B>" .. self.price_ * self.selectNum .. "</color>"
		end
	end

	if self.itemDesCfg.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
		self.list_:StartScrollWithoutAnimator(#self.itemDesCfg.param)
	end
end

function RechargeGiftPopView:UpdateBar()
	if self.shopID == 1050 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_SKIN
		}, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	else
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	end
end

function RechargeGiftPopView:OnTop()
	self:UpdateBar()
	manager.windowBar:SetAsLastSibling()
	self:UpdateView()
	self:UpdatePreview()
end

function RechargeGiftPopView:OnEnter()
	self.itemCfg = self.params_.itemCfg
	self.goodID = self.params_.goodId
	self.buyTime = self.params_.buyTime
	self.shopID = self.params_.shopId
	self.shopCfg = self.params_.shopCfg
	self.itemDesCfg = self.params_.itemDesCfg_
	self.selectNum = 1
	self.multipleScrollRect_.verticalNormalizedPosition = 1

	self:UpdateRealtimePrice()

	self.canUseMaxNum_ = self:GetMaxNum()

	self:UpdateView()
	self:UpdateTimer()

	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.useNumSlider_.value = 1

	self.timer_:Start()
	self:UpdateDelAddBtn()
	self:UpdatePreview()
	self:AddEventListeners()
end

function RechargeGiftPopView:UpdateTimer()
	if #self.shopCfg.close_time > 0 then
		SetActive(self.remainTimeGo_, true)

		local var_26_0 = TimeMgr.GetInstance():parseTimeFromConfig(self.shopCfg.close_time)

		self.remainTimeTxt_.text = var_26_0 <= TimeMgr.GetInstance():GetServerTime() and GetTips("TIP_EXPIRED") or manager.time:GetLostTimeStr(var_26_0)
	else
		SetActive(self.remainTimeGo_, false)
	end

	if self:IsOnDiscountArea() then
		SetActive(self.discountGo_, true)

		self.tipLabel_.text = ShopTools.GetDiscountLabel(self.shopCfg.goods_id)

		if #self.shopCfg.cheap_close_time > 0 then
			self.lastLabel_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(self.shopCfg.cheap_close_time))

			SetActive(self.limitTimeGo_, self.shopCfg.is_limit_time_discount == 1)
			SetActive(self.discountLimitTimeGo_, self.shopCfg.is_limit_time_discount == 1)
		else
			SetActive(self.limitTimeGo_, false)
			SetActive(self.discountLimitTimeGo_, false)
		end
	else
		SetActive(self.limitTimeGo_, false)
		SetActive(self.discountGo_, false)
		SetActive(self.limitTimeGo_, false)
		SetActive(self.discountLimitTimeGo_, false)
	end
end

function RechargeGiftPopView:UpdateView()
	self.useNumSlider_.maxValue = self.canUseMaxNum_
	self.nameLabel_.text = GetI18NText(self.itemDesCfg.name)

	SetActive(self.ownGo_, ShopTools.CheckGoodsOwen(self.goodID))

	self.image_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/PrizeItem/" .. self.itemDesCfg.icon)

	self.image_:SetNativeSize()

	if self.shopCfg.limit_num ~= nil and self.shopCfg.limit_num ~= -1 then
		self.limitLabel_.text = string.format("%d/%d", self.shopCfg.limit_num - self.buyTime, self.shopCfg.limit_num)
		self.limitTitle_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[self.shopCfg.refresh_cycle])
	else
		self.limitLabel_.text = " "
		self.limitTitle_.text = " "
	end

	SetActive(self.limitGo_, self.shopCfg.limit_num ~= nil and self.shopCfg.limit_num ~= -1)
	SetActive(self.surperValue, self.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE)

	if self.itemDesCfg.desc2 ~= "" then
		self.rewardTypeController_:SetSelectedState("value_2")

		self.descText_.text = self.itemDesCfg.desc

		local var_27_0 = self.itemDesCfg.param[1] or {}

		for iter_27_0, iter_27_1 in ipairs(var_27_0) do
			if iter_27_0 <= #self.immeRewardItemList2_ then
				self.immeRewardItemList2_[iter_27_0]:SetData(iter_27_1[1], iter_27_1[2])
			else
				local var_27_1 = RechargeGiftPopItem.New((Object.Instantiate(self.GiftPopItemPrefab_, self.itemParent2_)))

				var_27_1:SetData(iter_27_1[1], iter_27_1[2])
				table.insert(self.immeRewardItemList2_, var_27_1)
			end
		end

		while #var_27_0 < #self.immeRewardItemList2_ do
			self.immeRewardItemList2_[#self.immeRewardItemList2_]:Dispose()
			table.remove(self.immeRewardItemList2_, #self.immeRewardItemList2_)
		end
	elseif self.itemDesCfg.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
		self.rewardTypeController_:SetSelectedState("normal")
		self.list_:StartScroll(#self.itemDesCfg.param)
	elseif self.itemDesCfg.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_SEVEN_PACKS then
		self.rewardTypeController_:SetSelectedState("multiple")

		local var_27_2 = self.itemDesCfg.param[1] or {}

		if #var_27_2 > 0 then
			for iter_27_2, iter_27_3 in ipairs(var_27_2) do
				if iter_27_2 <= #self.immeRewardItemList_ then
					self.immeRewardItemList_[iter_27_2]:SetData(iter_27_3[1], iter_27_3[2])
				else
					local var_27_3 = RechargeGiftPopItem.New((Object.Instantiate(self.GiftPopItemPrefab_, self.immeList_)))

					var_27_3:SetData(iter_27_3[1], iter_27_3[2] * self.shopCfg.give)
					table.insert(self.immeRewardItemList_, var_27_3)
				end
			end

			SetActive(self.immeLabelGo_, true)
		else
			SetActive(self.immeLabelGo_, false)
		end

		while #var_27_2 < #self.immeRewardItemList_ do
			self.immeRewardItemList_[#self.immeRewardItemList_]:Dispose()
			table.remove(self.immeRewardItemList_, #self.immeRewardItemList_)
		end

		self.dailyLabel_.text = string.format(GetTips("CONSECUTIVE_DAYS"), tostring(self.itemDesCfg.param[3]))

		for iter_27_4, iter_27_5 in ipairs(self.itemDesCfg.param[2]) do
			if iter_27_4 <= #self.dailyRewardItemList_ then
				self.dailyRewardItemList_[iter_27_4]:SetData(iter_27_5[1], iter_27_5[2])
				self.dailyRewardItemList_[iter_27_4]:SetActive(true)
			else
				local var_27_4 = RechargeGiftPopItem.New((Object.Instantiate(self.GiftPopItemPrefab_, self.dailyList_)))

				var_27_4:SetData(iter_27_5[1], iter_27_5[2])
				var_27_4:SetActive(true)
				table.insert(self.dailyRewardItemList_, var_27_4)
			end
		end

		while #self.itemDesCfg.param[2] < #self.dailyRewardItemList_ do
			self.dailyRewardItemList_[#self.dailyRewardItemList_]:SetActive(false)
			self.dailyRewardItemList_[#self.dailyRewardItemList_]:Dispose()
			table.remove(self.dailyRewardItemList_, #self.dailyRewardItemList_)
		end

		if self.layoutTimer_ == nil then
			self.layoutTimer_ = Timer.New(function()
				LayoutRebuilder.ForceRebuildLayoutImmediate(self.multipleContainer_)
				self.layoutTimer_:Stop()

				self.layoutTimer_ = nil
			end, 0.05)
		end

		self.layoutTimer_:Start()
	end

	self.useNumSlider_.minValue = 0

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.dailyList_)
end

function RechargeGiftPopView:GetMaxNum()
	local var_29_0 = 1

	if self.shopCfg.limit_num ~= nil and self.shopCfg.limit_num ~= -1 then
		var_29_0 = self.shopCfg.limit_num - self.buyTime
		var_29_0 = math.min(self.shopCfg.limit_num - self.buyTime, (math.max(math.floor(ItemTools.getItemNum(self.shopCfg.cost_id) / ShopTools.GetPrice(self.goodID)), 1)))
	end

	if var_29_0 < 1 then
		var_29_0 = 1
	end

	return var_29_0
end

function RechargeGiftPopView:OnShopBuyResult(arg_30_1, arg_30_2)
	if arg_30_1 == 0 then
		local var_30_0 = getShopCfg(arg_30_2)

		self:Back()

		if RechargeShopDescriptionCfg[var_30_0.description].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward({
				{
					id = var_30_0.goods_id,
					num = var_30_0.give
				}
			})
		elseif RechargeShopDescriptionCfg[var_30_0.description].type == ItemConst.ITEM_TYPE.EQUIP then
			if EquipData:GetEquipBagFull() then
				showEquipSendMail(nil)
				EquipAction.EquipBagFull(false)
			else
				ShowTips("TRANSACTION_SUCCESS")
			end
		else
			ShowTips("TRANSACTION_SUCCESS")
		end
	elseif arg_30_1 == 899 then
		ShowMessageBox({
			content = GetTips("EQUIP_NUM_MAX"),
			OkCallback = function()
				JumpTools.GoToSystem("/bag", {
					type = "equip"
				}, ViewConst.SYSTEM_ID.BAG)
			end
		})
	elseif arg_30_1 == 406 then
		ShowTips("ITEM_INVALID")
	elseif arg_30_1 then
		ShowTips(arg_30_1)
	end
end

function RechargeGiftPopView:AddEventListeners()
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_33_0)
		local var_33_1 = self:IsOnDiscountArea() and PaymentCfg[self.shopCfg.cheap_cost_id] or PaymentCfg[self.shopCfg.cost_id]

		if arg_33_0 == self.shopCfg.cheap_cost_id or arg_33_0 == self.shopCfg.cost_id then
			self:Back()
		end
	end)
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_34_0)
		self:UpdateView()
	end)
end

function RechargeGiftPopView:IsOnDiscountArea()
	local var_35_0, var_35_1, var_35_2 = ShopTools.IsOnDiscountArea(self.shopCfg.goods_id)

	if var_35_0 and var_35_2 then
		return true
	else
		return false
	end
end

function RechargeGiftPopView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function RechargeGiftPopView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	if self.immeRewardItemList_ then
		for iter_37_0, iter_37_1 in ipairs(self.immeRewardItemList_) do
			iter_37_1:Dispose()
		end

		self.immeRewardItemList_ = nil
	end

	if self.immeRewardItemList2_ then
		for iter_37_2, iter_37_3 in ipairs(self.immeRewardItemList2_) do
			iter_37_3:Dispose()
		end

		self.immeRewardItemList2_ = nil
	end

	if self.dailyRewardItemList_ then
		for iter_37_4, iter_37_5 in ipairs(self.dailyRewardItemList_) do
			iter_37_5:Dispose()
		end

		self.dailyRewardItemList_ = nil
	end

	self.useNumSlider_.onValueChanged:RemoveAllListeners()
	RechargeGiftPopView.super.Dispose(self)
end

return RechargeGiftPopView
