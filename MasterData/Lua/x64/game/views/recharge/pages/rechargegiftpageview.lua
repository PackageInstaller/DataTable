local RechargeGiftPageView = class("RechargeGiftPageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeGiftPageView:InitUI()
	self:BindCfgUI()

	self.giftList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, RechargeGiftItem)
end

function RechargeGiftPageView:indexItem(arg_2_1, arg_2_2)
	arg_2_2:SetData(self.shopDataList_[arg_2_1])
	arg_2_2:SetOutOfDateHandler(handler(self, self.OnItemOutOfDate))
end

function RechargeGiftPageView:OnItemOutOfDate(arg_3_1)
	self:RefreshList()

	if #self.shopDataList_ == 0 and self.treeRefreshHandler_ ~= nil then
		self.treeRefreshHandler_()
	end
end

function RechargeGiftPageView:OnBuySuccess(arg_4_1, arg_4_2)
	if self.curShopId_ == arg_4_2 then
		self:RefreshList(true)
	end
end

function RechargeGiftPageView:AddUIListener()
	if SDKTools.GetIsInputServer("kr") then
		self:AddBtnListener(self.refundbtn_, nil, function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = {
					"Widget/System/Recharge/RefundPolicyKR_01"
				}
			})
		end)
	end
end

function RechargeGiftPageView:SwitchPage(arg_7_1)
	self.curShopId_ = arg_7_1
	self.shopDataList_ = self:InitShopList(arg_7_1)

	self.giftList_:StartScroll(#self.shopDataList_)
	SetActive(self.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(self.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(self.refundbtn_.gameObject, self.curPageIndex_ ~= 4 and self.curPageIndex_ ~= 6)
	end
end

function RechargeGiftPageView:RefreshList(arg_8_1)
	arg_8_1 = arg_8_1 or false
	self.shopDataList_ = self:InitShopList(self.curShopId_)

	if arg_8_1 then
		self.giftList_:StartScrollByPosition(#self.shopDataList_, (self.giftList_:GetScrolledPosition()))
	else
		self.giftList_:StartScroll(#self.shopDataList_)
	end
end

function RechargeGiftPageView:InitShopList(arg_9_1)
	local var_9_0 = ShopTools.FilterShopDataList(arg_9_1)

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		local var_10_0 = getShopCfg(arg_10_0.id, arg_9_1)
		local var_10_1 = getShopCfg(arg_10_1.id, arg_9_1)
		local var_10_2 = self:GetGoodStatus(arg_10_0.id, arg_9_1)
		local var_10_3 = self:GetGoodStatus(arg_10_1.id, arg_9_1)

		if var_10_2 ~= var_10_3 then
			return var_10_2 < var_10_3
		end

		if var_10_0.shop_sort ~= var_10_1.shop_sort then
			return var_10_0.shop_sort > var_10_1.shop_sort
		end

		return var_10_0.goods_id > var_10_1.goods_id
	end)

	return var_9_0
end

function RechargeGiftPageView:GetGoodStatus(arg_11_1, arg_11_2)
	local var_11_1 = getShopCfg(arg_11_1, arg_11_2)
	local var_11_2 = ShopData.GetShop(var_11_1.shop_id)[arg_11_1]

	if ShopData.IsGoodOutOfDate(arg_11_1, arg_11_2) then
		return 3
	end

	if (var_11_2 ~= nil and var_11_1.limit_num ~= nil and var_11_1.limit_num ~= -1 and var_11_1.limit_num - var_11_2.buy_times <= 0 or nil) and true then
		return 3
	end

	if RechargeShopDescriptionCfg[var_11_1.description] and RechargeShopDescriptionCfg[var_11_1.description].sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
		for iter_11_0, iter_11_1 in ipairs(RechargeShopDescriptionCfg[var_11_1.description].param) do
			if iter_11_1[1] then
				if ItemTools.getItemNum(iter_11_1[1]) == 1 and ItemCfg[iter_11_1[1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
					return 2
				end
			end
		end
	end

	if ShopData.IsGoodUnlock(arg_11_1, arg_11_2) == 0 then
		return 1
	end

	return 0
end

function RechargeGiftPageView:AddEventListeners()
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_13_0)
		if arg_13_0 > 0 and arg_13_0 == self.curShopId_ then
			self:RefreshList()
		end
	end)
	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_14_0, arg_14_1)
		self:RefreshShopGoodInfo(arg_14_0, arg_14_1)
	end)
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_15_0)
		self:RefreshList(true)
	end)
end

function RechargeGiftPageView:UpdateShopList(arg_16_1)
	if arg_16_1 == self.curShopId_ then
		self.giftList_:Refresh()
	end
end

function RechargeGiftPageView:RefreshShopGoodInfo(arg_17_1, arg_17_2)
	if self.curShopId_ ~= arg_17_1 then
		return
	end

	for iter_17_0, iter_17_1 in pairs(self.giftList_:GetItemList()) do
		if arg_17_2 == iter_17_1.goodId_ then
			iter_17_1:SetData(iter_17_1.index_, iter_17_1.shopId_, iter_17_1.goodId_)
		end
	end
end

function RechargeGiftPageView:OnShopBuyResult(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_1 == 0 then
		self:RefreshList(true)
	end
end

function RechargeGiftPageView:OnTop()
	return
end

function RechargeGiftPageView:OnEnter()
	self:AddEventListeners()

	if self.timer_ == nil then
		self.timer_ = FrameTimer.New(function()
			if self.giftList_ ~= nil then
				for iter_21_0, iter_21_1 in ipairs(self.giftList_:GetItemList()) do
					iter_21_1:UpdateTimerView()
				end
			end
		end, 1, -1)

		self.timer_:Start()
	end

	SetActive(self.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(self.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(self.refundbtn_.gameObject, self.curPageIndex_ ~= 4 and self.curPageIndex_ ~= 6)
	end
end

function RechargeGiftPageView:OnExit()
	self:RemoveAllEventListener()

	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function RechargeGiftPageView:Hide()
	RechargeGiftPageView.super.Hide(self)
end

function RechargeGiftPageView:SetTreeRefreshHandler(arg_24_1)
	self.treeRefreshHandler_ = arg_24_1
end

function RechargeGiftPageView:Dispose()
	if self.giftList_ then
		self.giftList_:Dispose()

		self.giftList_ = nil
	end

	self.treeRefreshHandler_ = nil

	RechargeGiftPageView.super.Dispose(self)
end

return RechargeGiftPageView
