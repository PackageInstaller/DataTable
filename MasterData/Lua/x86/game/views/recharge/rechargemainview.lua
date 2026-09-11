local RechargeMainView = class("RechargeMainView", ReduxView)
local var_0_1 = 2
local var_0_2 = {
	[ShopConst.SHOP_ID.MIGRATION_OBSERVATIONS] = true,
	[ShopConst.SHOP_ID.SKIN_TARGET] = true
}

function RechargeMainView:UIName()
	return "Widget/System/Recharge/RechargeSystemUI"
end

function RechargeMainView:UIParent()
	return manager.ui.uiMain.transform
end

function RechargeMainView:Init()
	self.prefabList_ = ShopConst.prefabList
	self.ClassList_ = {
		[ShopConst.SHOP_ID.LIMIT_SUPPLY] = RechargeGiftPageView,
		[ShopConst.SHOP_ID.DAILY_SUPPLY] = RechargeGiftPageView,
		[ShopConst.SHOP_ID.NEWBIE_SHOP] = RechargeGiftPageView,
		[ShopConst.SHOP_ID.DRAW_SHOP] = RechargeVoucherPageView,
		[ShopConst.SHOP_ID.SKIN_SHOP] = RechargeSkinDlcPageView,
		[ShopConst.SHOP_ID.DIRECT_SHOP] = RechargeSkinPageView,
		[ShopConst.SHOP_ID.REPURCHASE_SHOP] = RechargeSkinDlcPageView,
		[ShopConst.SHOP_ID.SKIN_TARGET] = RechargeGiftPageView,
		[ShopConst.SHOP_ID.CONSTANT_OBSERVATIONS] = RechargeMonthCardPageView,
		[ShopConst.SHOP_ID.MIGRATION_OBSERVATIONS] = RechargeRechargePageView,
		[ShopConst.SHOP_ID.SIX_SHOP] = RechargeFirstRechargePageView,
		[ShopConst.SHOP_ID.EIGHT_SHOP] = RechargeFirstRechargePageView,
		[ShopConst.SHOP_ID.OBSERVATION_SHOP] = RechargeFirstMonthlyCardPageView,
		[ShopConst.SHOP_ID.CONTRACT_BENEFITS] = RechargeFirstBpPageView,
		[ShopConst.SHOP_ID.OATH_RING_SHIP] = RechargeOathRingShopPageView
	}
	self.SpecialClassList_ = {
		[ShopConst.SPECIAL_ID.SKIN_LIST] = RechargeSkinListPageView
	}

	self:InitUI()
	self:AddUIListener()
end

function RechargeMainView:InitUI()
	self:BindCfgUI()

	self.pages_ = {}
	self.specialPages_ = {}
	self.tree_ = LuaTree.New(self.treeGo_)
	self.titleList = {}
	self.redBindingGroupIndex_ = 0
	self.enterTimerDic = {}
	self.skinTabController_ = self.mainControllerEx_:GetController("skinTab")
	self.hideTopController_ = self.mainControllerEx_:GetController("hideTop")
	self.btnTwoController_ = self.mainControllerEx_:GetController("btn_two")
	self.tabChooseController_ = self.tabControllerEx_:GetController("tab")
	self.filterBtnController_ = self.skinListFiltetControllerEx_:GetController("color")
	self.skinDiscountController_ = self.mainControllerEx_:GetController("skinEvent")

	self.filterBtnController_:SetSelectedState("normal")

	self.skinPageState_ = 0
end

function RechargeMainView:AddUIListener()
	self:AddBtnListener(self.cumulativeBtn_, nil, function()
		manager.redPoint:setTip(RedPointConst.TOTAL_CHARGE_BONUS, 0, RedPointStyle.SHOW_NEW_TAG)
		JumpTools.OpenPageByJump("/rechargeTotalRecharge")
	end)
	self:AddBtnListener(self.tabBtn_, nil, function()
		self:ChangeSkinPage()
	end)
	self:AddBtnListener(self.skinListFiltetBtn_, nil, function()
		if self.skinPageState_ == 1 then
			if self.specialPages_[ShopConst.SPECIAL_ID.SKIN_LIST].OpenFilterView then
				self.specialPages_[ShopConst.SPECIAL_ID.SKIN_LIST]:OpenFilterView()
			end
		end
	end)
	self:AddBtnListener(self.skinDiscountBtn_, nil, function()
		local var_9_0 = self:CheckSkinDiscountGift()

		if var_9_0 then
			OperationRecorder.RecordButtonTouch({
				button_name = "shop_recharge_activity_" .. var_9_0
			})
			JumpTools.GoToSystem("/skinDiscountGiftMain", {
				activityID = var_9_0
			}, ViewConst.SYSTEM_ID.SKIN_DISCOUNT_GIFT)
		end
	end)
end

local function var_0_3(arg_10_0)
	return OperationData:IsFunctionStoped(arg_10_0.operation_stop_id)
end

local function var_0_4(arg_11_0, arg_11_1, arg_11_2)
	if not var_0_3(ShopListCfg[arg_11_0[arg_11_1][arg_11_2].id]) then
		return arg_11_2
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0[arg_11_1]) do
		if not var_0_3(iter_11_1) then
			return arg_11_2
		end
	end

	return nil, GetTips("ERROR_FUNCTION_STOP")
end

function RechargeMainView:PreGroupSelectCheck(arg_12_1)
	local var_12_0 = self.itemToSelect_

	var_12_0 = self.currentGroupIndex_ == arg_12_1 and (var_12_0 or self.currentItemIndex_) or var_12_0 or 1

	return var_0_4(self.groups_, arg_12_1, var_12_0)
end

local function var_0_5(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0 = arg_13_2.childCount + 1, arg_13_0 do
		local var_13_0 = Object.Instantiate(arg_13_1, arg_13_2)
	end

	for iter_13_1 = 1, arg_13_2.childCount do
		SetActive(arg_13_2:GetChild(iter_13_1 - 1).gameObject, iter_13_1 <= arg_13_0)
	end
end

local function var_0_6(arg_14_0, arg_14_1)
	var_0_5(arg_14_1, arg_14_0.titleTagPrefab_, arg_14_0.titleTagPrefab_.transform.parent)

	for iter_14_0 = 1, arg_14_1 do
		local var_14_0 = arg_14_0.titleTagPrefab_.transform.parent:GetChild(iter_14_0 - 1).gameObject

		var_14_0.name = string.format("tabItem%02d", iter_14_0)
		arg_14_0.titleList[iter_14_0] = arg_14_0.titleList[iter_14_0] or RechargeTitleItem.New(var_14_0)
	end

	var_0_5(arg_14_1 - 1, arg_14_0.titleTagSeprateor_, arg_14_0.titleTagSeprateor_.transform.parent)

	for iter_14_1 = 1, arg_14_1 - 1 do
		arg_14_0.titleTagSeprateor_.transform.parent:GetChild(iter_14_1 - 1).gameObject.name = string.format("line%02d", iter_14_1)
	end
end

function RechargeMainView:RefreshTitleTabItem()
	var_0_6(self, #self.groupInfo.itemIndexes_)

	for iter_15_0, iter_15_1 in ipairs(self.groupInfo.itemIndexes_) do
		self.titleList[iter_15_0]:SetData(self.groupInfo[iter_15_1], iter_15_0, handler(self, self.ClickTitle), self.groupInfo[iter_15_1].id)
	end

	self:UpdateShopTabRedPoint()
end

function RechargeMainView:OnGroupSelect(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0, var_16_1 = self:PreGroupSelectCheck(arg_16_1)

	if not var_16_0 then
		self.groupInfo = {
			itemIndexes_ = {}
		}

		self:RefreshTitleTabItem()
		self:HideLastShopPage()
		ShowTips(var_16_1)

		return
	end

	self.groupInfo = self.groups_[arg_16_1]

	self:RefreshTitleTabItem()

	self.params_.page = arg_16_1

	self:ClickTitle(var_16_0)

	self.itemToSelect_ = nil
	self.currentGroupIndex_ = arg_16_1

	self:EnterSendMgr(arg_16_1)
end

function RechargeMainView:ClickTitle(arg_17_1)
	OperationRecorder.RecordButtonTouch("shop_recharge_gifts" .. self.params_.page .. "_type" .. arg_17_1)

	if ShopConst.PC_LOCK_SHOP[self.titleList[arg_17_1].shopId] and ShopTools.IsLimitRecharge() then
		ShowTips("PC_SHOP_TIPS1")

		return
	end

	if self.currentGroupIndex_ == 4 and self.currentItemIndex_ == 3 and arg_17_1 ~= 3 then
		saveData("FirstGear", "hasView", true)
		manager.redPoint:setTip(RedPointConst.FIRST_GEAR, 0)
	end

	self.currentItemIndex_ = arg_17_1

	self:EnterSendMgr(nil, arg_17_1)

	self.params_.childShopIndex = arg_17_1

	self:SwitchToShop(self.titleList[arg_17_1].shopId)

	for iter_17_0, iter_17_1 in ipairs(self.titleList) do
		iter_17_1.controller:SetSelectedState(iter_17_0 == arg_17_1 and "false" or "true")
	end

	if ShopData.GetRedPointData()[self.titleList[arg_17_1].shopId] then
		ShopAction.RemoveShopRedPoint(self.titleList[arg_17_1].shopId)
		manager.redPoint:SetRedPointIndependent(self.titleList[arg_17_1].transform_, false)
	end

	manager.redPoint:SetRedPointIndependent(self.titleList[arg_17_1].transform_, self:SpecialShop(self.titleList[arg_17_1].shopId), nil, RedPointStyle.NORMAL)

	if self.titleList[arg_17_1].shopId == ShopConst.SHOP_ID.MIGRATION_OBSERVATIONS then
		RedPointAction.HandleRedPoint(RED_POINT_ID.RECHARGE)
		manager.redPoint:setTip(RED_POINT_ID.RECHARGE, 0)
		SetActive(self.redGo2_, false)
	end

	if self.titleList[arg_17_1].shopId == ShopConst.SHOP_ID.OBSERVATION_SHOP and ActivityNoobData:GetFirstMonthlyCardStatus().newTagSignFlag then
		ActivityNoobAction.UpdateFirstSign()
	end

	if self.titleList[arg_17_1].shopId == ShopConst.SHOP_ID.CONSTANT_OBSERVATIONS and ActivityNoobData:GetFirstMonthlyCardStatus().newTagRoleFlag then
		ActivityNoobAction.UpdateFirstRecharge()
	end

	if self.titleList[arg_17_1].shopId == ShopConst.SHOP_ID.SIX_SHOP and ActivityNoobData:GetFirstRechargeStatus().firstGearNewTag then
		ActivityNoobAction.UpdateFirstGearNewTag()
	end

	if self.titleList[arg_17_1].shopId == ShopConst.SHOP_ID.EIGHT_SHOP and ActivityNoobData:GetFirstRechargeStatus().secondGearNewTag then
		ActivityNoobAction.UpdateSecondGearNewTag()
	end

	if self.titleList[arg_17_1].shopId == ShopConst.SHOP_ID.CONTRACT_BENEFITS and ActivityNoobData:GetBattlePassStatus().battlePassNewTag then
		ActivityNoobAction.UpdateBattlePassNewTag()
	end
end

function RechargeMainView:ChangeSkinPage()
	if self.skinPageState_ == 0 then
		self:SwitchToSkinList()
	else
		self:SwitchToShop(self.shopListId_, true)
	end
end

function RechargeMainView:SwitchToSkinList()
	self.skinPageState_ = 1

	self.hideTopController_:SetSelectedState("state1")
	self.btnTwoController_:SetSelectedState("state1")
	self.tabChooseController_:SetSelectedState("select2")

	if self.shopListId_ then
		if self.pages_[self.shopListId_] then
			self.pages_[self.shopListId_]:Hide()
		end
	end

	local var_19_0 = ShopConst.SPECIAL_ID.SKIN_LIST

	self:UpdateBar()

	if not self.specialPages_[var_19_0] then
		self.specialPages_[var_19_0] = self.SpecialClassList_[var_19_0].New((Object.Instantiate(Asset.Load(ShopConst.SPRCIAL_PREFAB[var_19_0]), self.container_)))

		self.specialPages_[var_19_0]:Show()
	else
		self.specialPages_[var_19_0]:Show()
	end
end

function RechargeMainView:UpdateBar()
	if self.skinPageState_ == 1 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_SKIN,
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId(),
			53014
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
		manager.windowBar:SetBarCanClick(53014, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)

		return
	end

	if self.shopListId_ == ShopConst.SHOP_ID.SKIN_SHOP or self.shopListId_ == ShopConst.SHOP_ID.SKIN_TARGET then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_SKIN
		}, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, var_0_2[self.shopListId_] ~= true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, var_0_2[self.shopListId_] ~= true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), nullable(var_0_2, self.shopListId_) ~= true)
	end
end

function RechargeMainView:RefreshTree()
	self.tree_:SetSelectedHandler(nil, nil)

	local var_21_0 = self:GetTreeDataByParams()

	self.tree_:SetData(var_21_0)
	self.tree_:SetSelectedHandler(handler(self, self.OnGroupSelect))

	self.treeData_ = var_21_0

	self:BindRedPoint()
	self:UpdateShopTabRedPoint()
	self:UpdateShopCategoryTreeRedPoint()
end

function RechargeMainView:HideLastShopPage()
	if self.shopListId_ then
		if self.pages_[self.shopListId_] then
			self.pages_[self.shopListId_]:Hide()
		end
	end
end

function RechargeMainView:SwitchToShop(arg_23_1, arg_23_2)
	self.skinDiscountController_:SetSelectedState(arg_23_1 == ShopConst.SHOP_ID.SKIN_SHOP and self:CheckSkinDiscountGift() and "state1" or "state0")

	if arg_23_1 == self.shopListId_ and not arg_23_2 then
		return
	end

	if self.skinPageState_ == 1 then
		self.skinPageState_ = 0

		self.hideTopController_:SetSelectedState("state0")
		self.btnTwoController_:SetSelectedState("state0")
		self.tabChooseController_:SetSelectedState("select1")

		if self.specialPages_[ShopConst.SPECIAL_ID.SKIN_LIST] then
			self.specialPages_[ShopConst.SPECIAL_ID.SKIN_LIST]:Hide()
		end
	end

	self:HideLastShopPage()

	self.shopListId_ = arg_23_1
	self.params_.shopListId = arg_23_1

	if not self.pages_[arg_23_1] then
		self.pages_[arg_23_1] = self.ClassList_[arg_23_1].New(Object.Instantiate(Asset.Load(self.prefabList_[arg_23_1]), self.container_), {
			ShopConst.SIX_EIGHT[arg_23_1]
		}, arg_23_1)

		self:CheckPageEnter(arg_23_1)
	else
		self.pages_[arg_23_1]:Show()
	end

	if self.pages_[arg_23_1].SwitchPage then
		self.pages_[arg_23_1]:SwitchPage(arg_23_1)
	end

	if ShopConst.SKIN_SHOP_LIST[arg_23_1] then
		self.skinTabController_:SetSelectedIndex(1)
	else
		self.skinTabController_:SetSelectedIndex(0)
	end

	self:UpdateBar()
end

function RechargeMainView:SwitchPageByParams()
	self.currentGroupIndex_, self.currentItemIndex_ = 1, 1

	if self.params_.page then
		self.currentGroupIndex_ = self.params_.page

		local var_24_1 = self.params_.shopId_ or self.params_.shopListId

		for iter_24_0, iter_24_1 in ipairs(self.groups_[self.params_.page].itemIndexes_) do
			if var_24_1 and var_24_1 == self.groups_[self.params_.page][iter_24_1].id then
				self.itemToSelect_ = iter_24_0

				break
			end
		end

		if self.itemToSelect_ == nil and self.params_.childShopIndex then
			self.itemToSelect_ = self.params_.childShopIndex
		end

		self.tree_:SelectGroup(self.currentGroupIndex_)

		if var_24_1 and self.params_.goodId_ then
			if ShopTools.IsGoodCanBuyInShop(var_24_1, self.params_.goodId_) and ShopTools.CheckSoldOut(self.params_.goodId_) == false then
				if ShopTools.CheckGiftSkinOwn(self.params_.goodId_) then
					ShowTips("ALREADY_GET")
				elseif ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
					ShowTips("PC_SHOP_TIPS2")
				else
					JumpTools.OpenPageByJump("rechargeGiftPopLink", {
						goodId = self.params_.goodId_,
						shopId = var_24_1
					})
				end
			else
				ShowTips("SELL_OUT")
			end

			self.params_.goodId_ = nil
		end

		self.params_.shopId_ = nil
	end
end

function RechargeMainView:CheckPageEnter(arg_25_1)
	if not self.enteredPage_[arg_25_1] then
		self.enterTimerDic[arg_25_1] = TimeTools.StartAfterSeconds(0.05, function()
			if self.enterTimerDic[arg_25_1] == nil then
				return
			end

			self.pages_[arg_25_1]:OnEnter()

			self.enteredPage_[arg_25_1] = true
			self.enterTimerDic[arg_25_1] = nil
		end, {})
	end
end

function RechargeMainView:OnTop()
	self:UpdateBar()

	if self.currentGroupIndex_ ~= self.params_.page or self.currentItemIndex_ ~= self.params_.childShopIndex then
		self:SwitchPageByParams()
	end

	if self.groupInfo[self.currentItemIndex_] then
		if self.groupInfo[self.currentItemIndex_].id == ShopConst.SHOP_ID.CONTRACT_BENEFITS and self.pages_[self.groupInfo[self.currentItemIndex_].id] then
			self.pages_[self.groupInfo[self.currentItemIndex_].id]:Show()
		end
	end
end

function RechargeMainView:OnEnter()
	self.enteredPage_ = {}

	for iter_28_0, iter_28_1 in pairs(self.pages_) do
		self:CheckPageEnter(iter_28_0)
	end

	self:RefreshTree()
	self:SwitchPageByParams()
	self:RegistEventListener(SHOP_BUY_SUCCESS, function(arg_29_0, arg_29_1)
		for iter_29_0, iter_29_1 in pairs(self.pages_) do
			if iter_29_1 ~= nil and iter_29_1.OnBuySuccess then
				iter_29_1:OnBuySuccess(arg_29_0, arg_29_1)
			end
		end
	end)
	self:RegistEventListener(RECHARGE_SKIN_LIST_FILTER_APPLY, function(arg_30_0)
		self:OnSkinListFilterApply(arg_30_0)
	end)

	if self.pages_[self.shopListId_] and self.pages_[self.shopListId_].RefreshList then
		self.pages_[self.shopListId_]:RefreshList()
	end

	if self.skinPageState_ == 1 then
		if self.specialPages_[ShopConst.SPECIAL_ID.SKIN_LIST] and self.specialPages_[ShopConst.SPECIAL_ID.SKIN_LIST].RefreshList then
			self.specialPages_[ShopConst.SPECIAL_ID.SKIN_LIST]:RefreshList()
		end
	end
end

function RechargeMainView:OnExit()
	self:RemoveAllEventListener()

	for iter_31_0, iter_31_1 in pairs(self.pages_) do
		if iter_31_1 ~= nil then
			iter_31_1:OnExit()
		end
	end

	for iter_31_2, iter_31_3 in pairs(self.specialPages_) do
		if iter_31_3 ~= nil then
			iter_31_3:OnExit()
		end
	end

	self.enterTimer = nil

	for iter_31_4, iter_31_5 in pairs(self.enterTimerDic) do
		iter_31_5:Stop()
	end

	self.enterTimerDic = {}

	self:UnbindRedPoint()
	manager.windowBar:HideBar()
	self:ExitUITime()
end

function RechargeMainView:UpdateShopCategoryTreeRedPoint()
	for iter_32_0, iter_32_1 in pairs(self.groups_) do
		local var_32_0 = self.tree_:GetGroupRedPointContainerById(iter_32_0)

		if var_32_0 then
			SetActive(var_32_0, true)

			local var_32_1 = false
			local var_32_2 = false
			local var_32_3 = var_32_0.transform:Find("notice_img/Default")
			local var_32_4 = var_32_0.transform:Find("notice_img/NewRed")

			for iter_32_2, iter_32_3 in ipairs(iter_32_1) do
				if self:CheckShopRedPoint(iter_32_3.id) then
					var_32_1 = true
				end

				if self:SpecialShop(iter_32_3.id) then
					var_32_2 = true
				end
			end

			SetActive(var_32_4, var_32_1)
			SetActive(var_32_3, var_32_2)
		end
	end
end

function RechargeMainView:UpdateShopTabRedPoint()
	for iter_33_0, iter_33_1 in ipairs(self.titleList) do
		if iter_33_0 <= #self.groupInfo.itemIndexes_ then
			local var_33_0 = false
			local var_33_1 = RedPointStyle.None

			if self:CheckShopRedPoint(iter_33_1.shopId) then
				var_33_1 = RedPointStyle.SHOW_NEW_TAG
				var_33_0 = true
			elseif self:SpecialShop(iter_33_1.shopId) then
				var_33_1 = RedPointStyle.NORMAL
				var_33_0 = true
			end

			manager.redPoint:SetRedPointIndependent(iter_33_1.transform_, var_33_0, nil, var_33_1)
		end
	end
end

function RechargeMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.totalRechargeNoticeContainer_, RedPointConst.TOTAL_CHARGE_BONUS)
	manager.redPoint:bindUIandKey(self.skinDiscountBtn_.transform, RedPointConst.SKIN_DISCOUNT_GIFT)

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	self.updateTimer_ = Timer.New(function()
		self:UpdateShopTabRedPoint()
		self:UpdateShopCategoryTreeRedPoint()
	end, 1, -1, 1)

	self.updateTimer_:Start()
end

function RechargeMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.totalRechargeNoticeContainer_, RedPointConst.TOTAL_CHARGE_BONUS, {
		x = 0,
		y = 0
	})
	manager.redPoint:unbindUIandKey(self.skinDiscountBtn_.transform, RedPointConst.SKIN_DISCOUNT_GIFT)

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function RechargeMainView:OnShopBuyResult(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	if self.pages_[var_0_1] then
		self.pages_[var_0_1]:OnShopBuyResult(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	end

	if self.pages_[ShopConst.SHOP_ID.OATH_RING_SHIP] then
		self.pages_[ShopConst.SHOP_ID.OATH_RING_SHIP]:OnShopBuyResult(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	end
end

function RechargeMainView:SpecialShop(arg_38_1)
	if ShopConst.PC_LOCK_SHOP[arg_38_1] == true and ShopTools.IsLimitRecharge() then
		return false
	end

	if ShopConst.SHOP_ID_TO_RED_CONST[arg_38_1] then
		return manager.redPoint:getTipBoolean(ShopConst.SHOP_ID_TO_RED_CONST[arg_38_1])
	end

	return false
end

function RechargeMainView:CheckShopRedPoint(arg_39_1)
	local var_39_0 = ShopData.GetRedPointData()

	if arg_39_1 == ShopConst.SHOP_ID.CONSTANT_OBSERVATIONS then
		return var_39_0[arg_39_1] == true or ActivityNoobData:GetFirstMonthlyCardStatus().newTagRoleFlag
	elseif arg_39_1 == ShopConst.SHOP_ID.OBSERVATION_SHOP then
		return var_39_0[arg_39_1] == true or ActivityNoobData:GetFirstMonthlyCardStatus().newTagSignFlag
	elseif arg_39_1 == ShopConst.SHOP_ID.SIX_SHOP then
		return var_39_0[arg_39_1] == true or ActivityNoobData:GetFirstRechargeStatus().firstGearNewTag
	elseif arg_39_1 == ShopConst.SHOP_ID.EIGHT_SHOP then
		return var_39_0[arg_39_1] == true or ActivityNoobData:GetFirstRechargeStatus().secondGearNewTag
	elseif arg_39_1 == ShopConst.SHOP_ID.CONTRACT_BENEFITS then
		return var_39_0[arg_39_1] == true or ActivityNoobData:GetBattlePassStatus().battlePassNewTag
	else
		return var_39_0[arg_39_1] == true
	end
end

function RechargeMainView:OnTryToUseItem(arg_40_1, arg_40_2)
	if isSuccess(arg_40_1.result) then
		getReward({
			{
				num = 1,
				id = ItemCfg[arg_40_2.use_item_list[1].item_id].param[1]
			}
		})
		HeroAction.UpdateSkinCouponRedPoint(SkinCfg[ItemCfg[arg_40_2.use_item_list[1].item_id].param[1]].hero)
		HeroAction.SkinAdd(ItemCfg[arg_40_2.use_item_list[1].item_id].param[1])
	else
		ShowTips(arg_40_1.result)
	end
end

function RechargeMainView:HaveActivityGift()
	for iter_41_0, iter_41_1 in ipairs((getShopIDListByShopID(ShopConst.SHOP_ID.LIMIT_SUPPLY))) do
		if not ShopData.IsGoodOutOfDate(iter_41_1, ShopConst.SHOP_ID.LIMIT_SUPPLY) then
			return true
		end
	end

	return false
end

function RechargeMainView:HaveNewbieGift()
	for iter_42_0, iter_42_1 in pairs(ShopData.GetShop(ShopConst.SHOP_ID.NEWBIE_SHOP).shopItemIDs) do
		if ShopTools.IsGoodCanDisplay(ShopConst.SHOP_ID.NEWBIE_SHOP, iter_42_1) and not ShopData.IsSoldout(ShopConst.SHOP_ID.NEWBIE_SHOP, iter_42_1) then
			return true
		end
	end

	return false
end

function RechargeMainView:OnMainHomeViewTop()
	self.params_.childShopIndex = 1
	self.params_.page = 1
end

function RechargeMainView:OnSkinListFilterApply(arg_44_1)
	if self.skinPageState_ == 1 then
		if self.specialPages_[ShopConst.SPECIAL_ID.SKIN_LIST].OnSkinListFilterApply then
			self.specialPages_[ShopConst.SPECIAL_ID.SKIN_LIST]:OnSkinListFilterApply(arg_44_1)
		end
	end

	if #arg_44_1.heroIDList > 0 or arg_44_1.goodType ~= ShopConst.FILTER_HERO_TYPE.ALL or arg_44_1.stateType ~= ShopConst.FILTER_STATE_TYPE.ALL then
		self.filterBtnController_:SetSelectedState("orange")
	else
		self.filterBtnController_:SetSelectedState("normal")
	end
end

function RechargeMainView:Dispose()
	self.firstRechargeGroupGoList_ = nil

	if self.tree_ then
		self.tree_:Dispose()

		self.tree_ = nil
	end

	for iter_45_0, iter_45_1 in ipairs(self.titleList) do
		iter_45_1:Dispose()
	end

	if self.pages_ then
		for iter_45_2, iter_45_3 in pairs(self.pages_) do
			iter_45_3:Dispose()
		end

		self.pages_ = nil
	end

	if self.specialPages_ then
		for iter_45_4, iter_45_5 in pairs(self.specialPages_) do
			iter_45_5:Dispose()
		end

		self.specialPages_ = nil
	end

	RechargeMainView.super.Dispose(self)
end

function RechargeMainView:RefreshFirstRechargeGroup()
	self.firstRechargeGroupGoList_ = {}
	self.firstRechargeGroupGoList_[1] = self.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.SIX_SHOP)
	self.firstRechargeGroupGoList_[2] = self.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.EIGHT_SHOP)
	self.firstRechargeGroupGoList_[3] = self.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.OBSERVATION_SHOP)

	for iter_46_0, iter_46_1 in ipairs(self.firstRechargeGroupGoList_) do
		SetActive(iter_46_1, ActivityNewbieTools.GetRechargeIsOpen(iter_46_0))
	end

	local var_46_0 = ActivityNewbieTools.GetFirstRechargeStatus()

	if var_46_0 and var_46_0.firstGearStatus == 2 then
		self.tree_:GetData().groupDatas[5].defaultIndex = 1
	end
end

function RechargeMainView:GetTreeDataByParams()
	local var_47_0 = {}

	if self.params_.showShops then
		var_47_0 = self.params_.showShops
	else
		for iter_47_0, iter_47_1 in ipairs(ShopListCfg.get_id_list_by_system[2]) do
			if ShopListCfg[iter_47_1].show_in_shop == 1 then
				table.insert(var_47_0, iter_47_1)
			end
		end
	end

	local var_47_1 = {}

	for iter_47_2, iter_47_3 in ipairs(var_47_0) do
		table.insert(var_47_1, iter_47_3)
	end

	self.groups_ = {}
	self.groupIndexes_ = {}

	local var_47_2 = UITreeData.New()

	for iter_47_4, iter_47_5 in ipairs(var_47_1) do
		if not self.groups_[ShopListCfg[iter_47_5].display_group] then
			self.groups_[ShopListCfg[iter_47_5].display_group] = {
				itemIndexes_ = {}
			}

			table.insert(self.groupIndexes_, ShopListCfg[iter_47_5].display_group)
		end

		self.groups_[ShopListCfg[iter_47_5].display_group][ShopListCfg[iter_47_5].display_index] = ShopListCfg[iter_47_5]

		if not var_0_3(ShopListCfg[iter_47_5]) then
			table.insert(self.groups_[ShopListCfg[iter_47_5].display_group].itemIndexes_, ShopListCfg[iter_47_5].display_index)
		end
	end

	for iter_47_6, iter_47_7 in pairs(self.groups_) do
		table.sort(iter_47_7.itemIndexes_, function(arg_48_0, arg_48_1)
			return arg_48_0 < arg_48_1
		end)
	end

	table.sort(self.groupIndexes_, function(arg_49_0, arg_49_1)
		return arg_49_0 < arg_49_1
	end)

	for iter_47_8, iter_47_9 in pairs(self.groupIndexes_) do
		local var_47_3 = UITreeGroupData.New()

		var_47_3.text = GetI18NText(ShopListCfg.get_id_list_by_system_and_group[2][iter_47_9][1].group_name)
		var_47_3.controllerStateValue = tostring(iter_47_9)
		var_47_3.id = iter_47_9

		var_47_2.groupDatas:Add(var_47_3)
	end

	return var_47_2
end

function RechargeMainView:EnterSendMgr(arg_50_1, arg_50_2)
	self.groupIndex_ = arg_50_1 or self.groupIndex_
	self.titleIndex_ = arg_50_2 or self.titleIndex_

	local var_50_0 = string.format("%s_%s_%s", UITimeConst.shopRechargeGifts, self.groupIndex_, self.titleIndex_)

	if self.groupIndex_ and self.titleIndex_ and var_50_0 ~= self.lastShopId_ then
		self:ExitSendMgr()
		manager.uiTime:OnEnterRoute(var_50_0, true)

		self.lastShopId_ = var_50_0
	end
end

function RechargeMainView:ExitSendMgr()
	if self.lastShopId_ then
		manager.uiTime:OnExitRoute(self.lastShopId_, true)
	end
end

function RechargeMainView:ExitUITime()
	self:ExitSendMgr()

	self.lastShopId_ = nil
	self.groupIndex_ = nil
	self.titleIndex_ = nil
end

function RechargeMainView:CheckSkinDiscountGift()
	for iter_53_0, iter_53_1 in ipairs((SkinDiscountGiftTools.GetActivityList())) do
		local var_53_0 = SkinDiscountGiftTools.GetSignActivityID(iter_53_1)

		if var_53_0 and SignTools.GetSevenDaySignIndex(var_53_0) ~= 0 then
			return iter_53_1
		end
	end

	return (SkinDiscountGiftTools.HasGiftActivityID())
end

return RechargeMainView
