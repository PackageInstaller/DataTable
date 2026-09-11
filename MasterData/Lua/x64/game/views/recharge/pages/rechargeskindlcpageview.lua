local RechargeSkinDlcPageView = class("RechargeSkinDlcPageView", (import("game.views.recharge.pages.RechargePageBase")))

function RechargeSkinDlcPageView:InitUI()
	self:BindCfgUI()

	self.goodTypeController_ = ControllerUtil.GetController(self.transform_, "text")
	self.loopScrollView_ = LoopScrollView.New(self, self.scrollEx_, self.contTrs_, self.viewTrs_, self.viewTrs_.rect.width, self.contTrs_:GetComponent("HorizontalLayoutGroup").spacing, nil, true)
	self.item1Pool = {}
	self.item2Pool = {}
end

function RechargeSkinDlcPageView:OnItemOutOfDate(arg_2_1)
	self:RefreshList()

	if #self.skinDataList_ == 0 and self.treeRefreshHandler_ ~= nil then
		self.treeRefreshHandler_()
	end
end

function RechargeSkinDlcPageView:AddEventListeners()
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_4_0)
		if arg_4_0 > 0 and arg_4_0 == self.curShopId_ then
			self:RefreshList()
		end
	end)
	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_5_0, arg_5_1)
		self:RefreshShopGoodInfo(arg_5_0, arg_5_1)
	end)
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_6_0)
		self:SwitchPage(self.curShopId_)
	end)
end

function RechargeSkinDlcPageView:AddUIListener()
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

function RechargeSkinDlcPageView:SwitchPage(arg_11_1)
	self.curShopId_ = arg_11_1
	self.skinDataList_ = self:InitDataList(arg_11_1)

	self.loopScrollView_:NavigateIndex(1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.loopScrollView_.rectGrid_)

	self.loopScrollView_.scrollView_.horizontalNormalizedPosition = 0
end

function RechargeSkinDlcPageView:RefreshList(arg_12_1)
	self.loopScrollView_:NavigateIndex(self.selectIndex_ or 1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.loopScrollView_.rectGrid_)

	self.loopScrollView_.scrollView_.horizontalNormalizedPosition = 0

	if self.timer_ == nil then
		self.timer_ = FrameTimer.New(function()
			for iter_13_0, iter_13_1 in pairs(self.item1Pool) do
				iter_13_1.itemView:UpdateTimerView()
			end

			for iter_13_2, iter_13_3 in pairs(self.item2Pool) do
				iter_13_3.itemView:UpdateTimerView()
			end

			self:UpdateTimer()
		end, 1, -1)

		self.timer_:Start()
	end
end

function RechargeSkinDlcPageView:InitDataList(arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs((ShopTools.FilterShopDataList(arg_14_1))) do
		local var_14_1 = RechargeShopDescriptionCfg[getShopCfg(iter_14_1.id).description]

		if var_14_1 and var_14_1.type ~= 21 and SkinCfg[var_14_1.param[1]] then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return ShopTools.CommonSort(var_14_0)
end

function RechargeSkinDlcPageView:GetGoodStatus(arg_15_1)
	local var_15_0 = RechargeShopDescriptionCfg[getShopCfg(arg_15_1).description].param[1]

	if ShopTools.HaveSkin(var_15_0) or HeroTools.CanChangeSkin(var_15_0) then
		return 2
	end

	if ShopData.IsGoodUnlock(arg_15_1) == 0 then
		return 1
	end

	return 0
end

function RechargeSkinDlcPageView:RefreshShopGoodInfo(arg_16_1, arg_16_2)
	if self.curShopId_ ~= arg_16_1 then
		return
	end
end

function RechargeSkinDlcPageView:OnEnter()
	self:AddEventListeners()
	SetActive(self.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(self.refundbtn_.gameObject, false)
	self:RefreshList()
	SetActive(self.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
	SetActive(self.refundGo_, not SDKTools.GetIsKorea())
	SetActive(self.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(self.refundbtn_.gameObject, self.curPageIndex_ ~= 4 and self.curPageIndex_ ~= 6)
	end
end

function RechargeSkinDlcPageView:UpdateTimer()
	return
end

function RechargeSkinDlcPageView:Show()
	RechargeSkinDlcPageView.super.Show(self)
	self:RefreshList()
end

function RechargeSkinDlcPageView:OnExit()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end

	for iter_20_0, iter_20_1 in pairs(self.item1Pool) do
		iter_20_1.itemView:OnExit()
	end

	for iter_20_2, iter_20_3 in pairs(self.item2Pool) do
		iter_20_3.itemView:OnExit()
	end
end

function RechargeSkinDlcPageView:Hide()
	RechargeSkinDlcPageView.super.Hide(self)
end

function RechargeSkinDlcPageView:SetTreeRefreshHandler(arg_22_1)
	self.treeRefreshHandler_ = arg_22_1
end

function RechargeSkinDlcPageView:Dispose()
	self:RemoveAllEventListener()

	if self.skinList_ then
		self.skinList_:Dispose()

		self.skinList_ = nil
	end

	self.treeRefreshHandler_ = nil

	for iter_23_0, iter_23_1 in pairs(self.item1Pool) do
		iter_23_1.itemView:Dispose()
	end

	for iter_23_2, iter_23_3 in pairs(self.item2Pool) do
		iter_23_3.itemView:Dispose()
	end

	self.item1Pool = nil
	self.item2Pool = nil
	self.itemEquipPool = nil

	RechargeSkinDlcPageView.super.Dispose(self)
end

function RechargeSkinDlcPageView:OnBuySuccess(arg_24_1, arg_24_2)
	if self.curShopId_ == arg_24_2 or arg_24_2 == 54 then
		self:RefreshList(true)
	end
end

function RechargeSkinDlcPageView:LsRemoveItem(arg_25_1)
	arg_25_1.itemView:Show(false)

	arg_25_1.isFree = true
end

function RechargeSkinDlcPageView:GetFreeItem(arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in pairs(arg_26_1) do
		if iter_26_1.isFree == true then
			iter_26_1.isFree = false

			return iter_26_1
		end
	end

	local var_26_0 = {
		isFree = false,
		itemView = arg_26_2()
	}

	table.insert(arg_26_1, var_26_0)

	return var_26_0
end

function RechargeSkinDlcPageView:LsAddItem(arg_27_1, arg_27_2)
	local var_27_0
	local var_27_1 = getShopCfg(arg_27_1.id)

	var_27_0 = var_27_1.dlc ~= nil and var_27_1.dlc ~= 0 and (var_27_1.dlc ~= nil and var_27_1.dlc ~= 0 or nil) and getShopCfg(var_27_1.dlc) and self:GetFreeItem(self.item1Pool, function()
		return RechargeSkinAllItem.New(self.item1Go_, self.contTrs_.gameObject)
	end) or self:GetFreeItem(self.item2Pool, function()
		return RechargeSkinNormalItem.New(self.item2Go_, self.contTrs_.gameObject)
	end)

	var_27_0.itemView:SetCallBack(function(arg_30_0)
		self.selectIndex_ = arg_30_0
	end)
	var_27_0.itemView:SetData(arg_27_1, arg_27_2)

	return var_27_0
end

function RechargeSkinDlcPageView:LsGetItemData()
	return self.skinDataList_
end

function RechargeSkinDlcPageView:LsUpdateItem(arg_32_1, arg_32_2, arg_32_3)
	arg_32_1.itemView:SetData(arg_32_2, arg_32_3)
end

return RechargeSkinDlcPageView
