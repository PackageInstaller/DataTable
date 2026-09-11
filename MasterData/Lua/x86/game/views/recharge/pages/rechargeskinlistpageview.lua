local RechargeSkinListPageView = class("RechargeSkinListPageView", (import("game.views.recharge.pages.RechargePageBase")))
local var_0_1 = {
	SKIN = 1,
	DLC = 2
}
local var_0_2 = {
	SKIN_BUY = 1,
	DLC_CANT = 4,
	FREE = 0,
	SKIN_CANT = 3,
	DLC_BUY = 2
}

function RechargeSkinListPageView:ResetPool()
	if self.itemPool_ then
		self:CleanPool()
	end

	self.itemPool_ = {
		[var_0_1.SKIN] = {},
		[var_0_1.DLC] = {}
	}
end

function RechargeSkinListPageView:CleanPool()
	if not self.itemPool_ then
		return
	end

	for iter_2_0, iter_2_1 in pairs(self.itemPool_[var_0_1.SKIN]) do
		iter_2_1.itemView:Dispose()
	end

	for iter_2_2, iter_2_3 in pairs(self.itemPool_[var_0_1.DLC]) do
		iter_2_3.itemView:Dispose()
	end
end

function RechargeSkinListPageView:GetItem(arg_3_1, arg_3_2)
	if self.itemPool_[arg_3_1][arg_3_2.id] then
		self.itemPool_[arg_3_1][arg_3_2.id].itemView:Show(true)

		return self.itemPool_[arg_3_1][arg_3_2.id]
	else
		return self:CreateItem(arg_3_1, arg_3_2, var_0_2.FREE)
	end
end

function RechargeSkinListPageView:SetItem(arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = self:GetItem(arg_4_1, arg_4_2)

	var_4_0.itemIndex = arg_4_3

	var_4_0.itemGo.transform:SetParent(self.contentTrs_[arg_4_3], true)
end

function RechargeSkinListPageView:FreeItem(arg_5_1, arg_5_2)
	return
end

function RechargeSkinListPageView:CreateItem(arg_6_1, arg_6_2, arg_6_3)
	if self.itemPool_[arg_6_1][arg_6_2.id] then
		return self.itemPool_[arg_6_1][arg_6_2.id]
	end

	local var_6_0
	local var_6_1

	if arg_6_1 == var_0_1.SKIN then
		var_6_0 = RechargeSkinNormalItem.New(self.itemSkinGo_, self.contentTrs_[arg_6_3])
		var_6_1 = var_6_0.gameObject_

		var_6_0:SetData(arg_6_2)
	elseif arg_6_1 == var_0_1.DLC then
		var_6_1 = Object.Instantiate(self.itemSkinGo_, self.contentTrs_[arg_6_3])
		var_6_0 = RechargeSkinListDlcItem.New(var_6_1)

		local var_6_2 = getShopCfg(arg_6_2.id)

		var_6_0:SetData(var_6_2.dlc, (var_6_2.description or nil) and RechargeShopDescriptionCfg[var_6_2.description].param[1], arg_6_2.id)
	end

	if var_6_0 then
		self.itemPool_[arg_6_1][arg_6_2.id] = {
			itemView = var_6_0,
			itemGo = var_6_1,
			itemIndex = arg_6_3
		}
	end

	return self.itemPool_[arg_6_1][arg_6_2.id] or nil
end

function RechargeSkinListPageView:InitUI()
	self:BindCfgUI()

	self.goodTypeController_ = ControllerUtil.GetController(self.transform_, "text")
	self.contentTrs_ = {}

	for iter_7_0 = 0, 4 do
		self.contentTrs_[iter_7_0] = self["contentTrs_" .. iter_7_0]
	end

	self:InitFilterParams()
	self:ResetPool()
end

function RechargeSkinListPageView:AddEventListeners()
	return
end

function RechargeSkinListPageView:AddUIListener()
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

function RechargeSkinListPageView:InitDataList()
	self.dataList_ = {
		skin = {},
		dlc = {},
		heroID = {}
	}

	local var_13_0 = {
		ShopConst.SHOP_ID.SKIN_SHOP,
		ShopConst.SHOP_ID.DIRECT_SHOP,
		ShopConst.SHOP_ID.REPURCHASE_SHOP
	}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		for iter_13_2, iter_13_3 in ipairs((ShopTools.FilterShopDataList(iter_13_1))) do
			local var_13_1 = getShopCfg(iter_13_3.id)

			if RechargeShopDescriptionCfg[var_13_1.description] and SkinCfg[RechargeShopDescriptionCfg[var_13_1.description].param[1]] then
				if RechargeShopDescriptionCfg[var_13_1.description].type ~= 21 then
					table.insert(self.dataList_.skin, iter_13_3)
				end

				if not table.keyof(self.dataList_.heroID, SkinCfg[RechargeShopDescriptionCfg[var_13_1.description].param[1]].hero) then
					table.insert(self.dataList_.heroID, SkinCfg[RechargeShopDescriptionCfg[var_13_1.description].param[1]].hero)
				end

				if iter_13_1 == var_13_0[1] then
					if var_13_1.dlc ~= nil and var_13_1.dlc ~= 0 and (var_13_1.dlc ~= nil and var_13_1.dlc ~= 0 or nil) and getShopCfg(var_13_1.dlc) then
						table.insert(self.dataList_.dlc, iter_13_3)
					end
				end
			end
		end
	end
end

function RechargeSkinListPageView:RefreshList()
	if self.dataList_ == nil then
		self:InitDataList()
	end

	local var_14_0 = {
		[var_0_2.SKIN_BUY] = 0,
		[var_0_2.DLC_BUY] = 0,
		[var_0_2.SKIN_CANT] = 0,
		[var_0_2.DLC_CANT] = 0
	}

	for iter_14_0 = 1, 4 do
		SetActive(self.contentTrs_[iter_14_0].gameObject, true)
	end

	for iter_14_1, iter_14_2 in ipairs(self.dataList_.skin) do
		local var_14_1 = self:GetItem(var_0_1.SKIN, iter_14_2)

		var_14_1.itemView:Show(true)
		var_14_1.itemView:OnEnter()

		local var_14_2 = var_0_2.FREE

		if self:GetGoodStatus(iter_14_2.id) == 0 then
			var_14_2 = var_0_2.SKIN_BUY

			self:SetItem(var_0_1.SKIN, iter_14_2, var_0_2.SKIN_BUY)
		else
			var_14_2 = var_0_2.SKIN_CANT

			self:SetItem(var_0_1.SKIN, iter_14_2, var_0_2.SKIN_CANT)
		end

		var_14_0[var_14_2] = var_14_0[var_14_2] + 1

		local var_14_3 = SkinCfg[RechargeShopDescriptionCfg[getShopCfg(iter_14_2.id).description].param[1]].hero

		if self.skinListFilterParams_.stateType == ShopConst.FILTER_STATE_TYPE.CAN_BUY and self:GetGoodStatus(iter_14_2.id) ~= 0 or self.skinListFilterParams_.stateType == ShopConst.FILTER_STATE_TYPE.CANT_BUY and self:GetGoodStatus(iter_14_2.id) == 0 or self.skinListFilterParams_.goodType == ShopConst.FILTER_HERO_TYPE.DLC or self.skinListFilterParams_.heroIDList and #self.skinListFilterParams_.heroIDList > 0 and not table.keyof(self.skinListFilterParams_.heroIDList, var_14_3) then
			var_14_1.itemView:Show(false)

			var_14_0[var_14_2] = var_14_0[var_14_2] - 1
		end
	end

	for iter_14_3, iter_14_4 in ipairs(self.dataList_.dlc) do
		local var_14_7 = self:GetItem(var_0_1.DLC, iter_14_4)

		var_14_7.itemView:Show(true)
		var_14_7.itemView:UpdateView()

		local var_14_8 = var_0_2.FREE
		local var_14_9 = getShopCfg(iter_14_4.id)

		if ShopTools.CheckDlcPurchased(var_14_9.dlc) == true then
			var_14_8 = var_0_2.DLC_CANT

			self:SetItem(var_0_1.DLC, iter_14_4, var_0_2.DLC_CANT)
		else
			var_14_8 = var_0_2.DLC_BUY

			self:SetItem(var_0_1.DLC, iter_14_4, var_0_2.DLC_BUY)
		end

		var_14_0[var_14_8] = var_14_0[var_14_8] + 1

		local var_14_10 = SkinCfg[RechargeShopDescriptionCfg[var_14_9.description].param[1]].hero

		if self.skinListFilterParams_.stateType == ShopConst.FILTER_STATE_TYPE.CAN_BUY and ShopTools.CheckDlcPurchased(var_14_9.dlc) or self.skinListFilterParams_.stateType == ShopConst.FILTER_STATE_TYPE.CANT_BUY and not ShopTools.CheckDlcPurchased(var_14_9.dlc) or self.skinListFilterParams_.goodType == ShopConst.FILTER_HERO_TYPE.SKIN or self.skinListFilterParams_.heroIDList and #self.skinListFilterParams_.heroIDList > 0 and not table.keyof(self.skinListFilterParams_.heroIDList, var_14_10) then
			var_14_7.itemView:Show(false)

			var_14_0[var_14_8] = var_14_0[var_14_8] - 1
		end
	end

	for iter_14_5, iter_14_6 in pairs(var_14_0) do
		if iter_14_6 == 0 then
			SetActive(self["titleGo_" .. iter_14_5], false)
		else
			SetActive(self["titleGo_" .. iter_14_5], true)
		end
	end
end

function RechargeSkinListPageView:InitFilterParams()
	self.skinListFilterParams_ = {
		heroIDList = {},
		goodType = ShopConst.FILTER_HERO_TYPE.ALL,
		stateType = ShopConst.FILTER_STATE_TYPE.ALL
	}
end

function RechargeSkinListPageView:OnSkinListFilterApply(arg_16_1)
	self.skinListFilterParams_.heroIDList = arg_16_1.heroIDList
	self.skinListFilterParams_.goodType = arg_16_1.goodType
	self.skinListFilterParams_.stateType = arg_16_1.stateType

	self:RefreshList()
end

function RechargeSkinListPageView:OpenFilterView()
	gameContext:Go("rechargeSkinListFilterView", {
		filterParams = self.skinListFilterParams_,
		heroIDList = self.dataList_.heroID
	})
end

function RechargeSkinListPageView:GetGoodStatus(arg_18_1)
	local var_18_0 = RechargeShopDescriptionCfg[getShopCfg(arg_18_1).description].param[1]

	if ShopTools.HaveSkin(var_18_0) or HeroTools.CanChangeSkin(var_18_0) then
		return 2
	end

	if ShopData.IsGoodUnlock(arg_18_1) == 0 then
		return 1
	end

	return 0
end

function RechargeSkinListPageView:OnEnter()
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

function RechargeSkinListPageView:Show()
	RechargeSkinListPageView.super.Show(self)
	self:RefreshList()
end

function RechargeSkinListPageView:OnExit()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end

	for iter_21_0, iter_21_1 in pairs(self.itemPool_[var_0_1.SKIN]) do
		iter_21_1.itemView:OnExit()
	end

	for iter_21_2, iter_21_3 in pairs(self.itemPool_[var_0_1.DLC]) do
		iter_21_3.itemView:OnExit()
	end
end

function RechargeSkinListPageView:Hide()
	RechargeSkinListPageView.super.Hide(self)
end

function RechargeSkinListPageView:Dispose()
	self:RemoveAllEventListener()
	self:CleanPool()
	RechargeSkinListPageView.super.Dispose(self)
end

function RechargeSkinListPageView:OnBuySuccess(arg_24_1, arg_24_2)
	if self.curShopId_ == arg_24_2 or arg_24_2 == 54 then
		self:RefreshList(true)
	end
end

return RechargeSkinListPageView
