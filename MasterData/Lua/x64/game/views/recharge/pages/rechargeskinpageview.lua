local RechargeSkinPageView = class("RechargeSkinPageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeSkinPageView:InitUI()
	self:BindCfgUI()

	self.goodTypeController_ = ControllerUtil.GetController(self.transform_, "text")
	self.skinList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, RechargeSkinNewItem)
end

function RechargeSkinPageView:indexItem(arg_2_1, arg_2_2)
	arg_2_2:SetData(self.skinDataList_[arg_2_1])
	arg_2_2:SetOutOfDateHandler(handler(self, self.OnItemOutOfDate))
end

function RechargeSkinPageView:OnItemOutOfDate(arg_3_1)
	self:RefreshList()

	if #self.skinDataList_ == 0 and self.treeRefreshHandler_ ~= nil then
		self.treeRefreshHandler_()
	end
end

function RechargeSkinPageView:AddEventListeners()
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_5_0)
		if arg_5_0 > 0 and arg_5_0 == self.curShopId_ then
			self:RefreshList()
		end
	end)
	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_6_0, arg_6_1)
		self:RefreshShopGoodInfo(arg_6_0, arg_6_1)
	end)
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_7_0)
		self:RefreshList()
	end)
end

function RechargeSkinPageView:AddUIListener()
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

	if self.fundsettlementmethodBtn_ and self.commercialBtn_ then
		self:AddBtnListener(self.fundsettlementmethodBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", fund_settlement_algorithm))
		end)
		self:AddBtnListener(self.commercialBtn_, nil, function()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", specific_commercial_transaction_act))
		end)
	end
end

function RechargeSkinPageView:SwitchPage(arg_12_1)
	self.curShopId_ = arg_12_1
	self.skinDataList_ = self:InitDataList(arg_12_1)

	self.skinList_:StartScroll(#self.skinDataList_)
end

function RechargeSkinPageView:RefreshList(arg_13_1)
	arg_13_1 = arg_13_1 or false
	self.skinDataList_ = self:InitDataList(self.curShopId_)

	if arg_13_1 then
		self.skinList_:StartScrollByPosition(#self.skinDataList_, (self.skinList_:GetScrolledPosition()))
	elseif self.skinList_ then
		self.skinList_:StartScroll(#self.skinDataList_)
	end
end

function RechargeSkinPageView:InitDataList(arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs((ShopTools.FilterShopDataList(arg_14_1))) do
		if SkinCfg[RechargeShopDescriptionCfg[getShopCfg(iter_14_1.id).description].param[1]] then
			table.insert(var_14_0, iter_14_1)
		end
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		local var_15_0 = RechargeSkinPageView.CheckSkinOwn(arg_15_0.id) and 1 or 0
		local var_15_1 = RechargeSkinPageView.CheckSkinOwn(arg_15_1.id) and 1 or 0

		if var_15_0 ~= var_15_1 then
			return var_15_0 < var_15_1
		end

		local var_15_2 = getShopCfg(arg_15_0.id)
		local var_15_3 = getShopCfg(arg_15_1.id)
		local var_15_4 = ShopTools.GetGoodStatus(arg_15_0.id)
		local var_15_5 = ShopTools.GetGoodStatus(arg_15_1.id)

		if var_15_4 ~= var_15_5 then
			return var_15_4 < var_15_5
		end

		if var_15_2.shop_sort ~= var_15_3.shop_sort then
			return var_15_2.shop_sort > var_15_3.shop_sort
		end

		return var_15_2.goods_id > var_15_3.goods_id
	end)

	return var_14_0
end

function RechargeSkinPageView:CheckSkinOwn()
	local var_16_0 = SkinCfg[RechargeShopDescriptionCfg[getShopCfg(self).description].param[1]]

	if ShopTools.HaveSkin(var_16_0.id) or HeroTools.CanChangeSkin(var_16_0.id) then
		return true
	else
		return false
	end

	return false
end

function RechargeSkinPageView:GetGoodStatus(arg_17_1)
	local var_17_0 = RechargeShopDescriptionCfg[getShopCfg(arg_17_1).description].param[1]

	if ShopTools.HaveSkin(var_17_0) or HeroTools.CanChangeSkin(var_17_0) then
		return 2
	end

	if ShopData.IsGoodUnlock(arg_17_1) == 0 then
		return 1
	end

	return 0
end

function RechargeSkinPageView:RefreshShopGoodInfo(arg_18_1, arg_18_2)
	if self.curShopId_ ~= arg_18_1 then
		return
	end

	for iter_18_0, iter_18_1 in pairs(self.skinList_:GetItemList()) do
		if arg_18_2 == iter_18_1.goodId_ then
			iter_18_1:SetData(iter_18_1.index_, iter_18_1.shopId_, iter_18_1.goodId_)
		end
	end
end

function RechargeSkinPageView:OnEnter()
	self:AddEventListeners()
	SetActive(self.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(self.refundbtn_.gameObject, false)

	if self.timer_ == nil then
		self.timer_ = FrameTimer.New(function()
			if self.skinList_ ~= nil then
				for iter_20_0, iter_20_1 in pairs(self.skinList_:GetItemList()) do
					iter_20_1:UpdateTimerView()
				end
			end

			self:UpdateTimer()
		end, 1, -1)

		self.timer_:Start()
	end

	SetActive(self.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
	SetActive(self.refundGo_, not SDKTools.GetIsKorea())
	SetActive(self.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(self.refundbtn_.gameObject, self.curPageIndex_ ~= 4 and self.curPageIndex_ ~= 6)
	end
end

function RechargeSkinPageView:UpdateTimer()
	return
end

function RechargeSkinPageView:Show()
	RechargeSkinPageView.super.Show(self)
	self:RefreshList()
end

function RechargeSkinPageView:OnExit()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function RechargeSkinPageView:Hide()
	RechargeSkinPageView.super.Hide(self)
end

function RechargeSkinPageView:SetTreeRefreshHandler(arg_25_1)
	self.treeRefreshHandler_ = arg_25_1
end

function RechargeSkinPageView:Dispose()
	self:RemoveAllEventListener()

	if self.skinList_ then
		self.skinList_:Dispose()

		self.skinList_ = nil
	end

	self.treeRefreshHandler_ = nil

	RechargeSkinPageView.super.Dispose(self)
end

function RechargeSkinPageView:OnBuySuccess(arg_27_1, arg_27_2)
	if self.curShopId_ == arg_27_2 or arg_27_2 == 54 then
		self:RefreshList(true)
	end
end

return RechargeSkinPageView
