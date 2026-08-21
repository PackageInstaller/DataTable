local var_0_0 = class("RechargeMainView", ReduxView)
local var_0_1 = 2
local var_0_2 = {
	[ShopConst.SHOP_ID.MIGRATION_OBSERVATIONS] = true,
	[ShopConst.SHOP_ID.SKIN_TARGET] = true
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeSystemUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.prefabList_ = ShopConst.prefabList
	arg_3_0.ClassList_ = {
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
	arg_3_0.SpecialClassList_ = {
		[ShopConst.SPECIAL_ID.SKIN_LIST] = RechargeSkinListPageView
	}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.pages_ = {}
	arg_4_0.specialPages_ = {}
	arg_4_0.tree_ = LuaTree.New(arg_4_0.treeGo_)
	arg_4_0.titleList = {}
	arg_4_0.redBindingGroupIndex_ = 0
	arg_4_0.enterTimerDic = {}
	arg_4_0.skinTabController_ = arg_4_0.mainControllerEx_:GetController("skinTab")
	arg_4_0.hideTopController_ = arg_4_0.mainControllerEx_:GetController("hideTop")
	arg_4_0.btnTwoController_ = arg_4_0.mainControllerEx_:GetController("btn_two")
	arg_4_0.tabChooseController_ = arg_4_0.tabControllerEx_:GetController("tab")
	arg_4_0.filterBtnController_ = arg_4_0.skinListFiltetControllerEx_:GetController("color")
	arg_4_0.skinDiscountController_ = arg_4_0.mainControllerEx_:GetController("skinEvent")

	arg_4_0.filterBtnController_:SetSelectedState("normal")

	arg_4_0.skinPageState_ = 0
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cumulativeBtn_, nil, function()
		manager.redPoint:setTip(RedPointConst.TOTAL_CHARGE_BONUS, 0, RedPointStyle.SHOW_NEW_TAG)
		JumpTools.OpenPageByJump("/rechargeTotalRecharge")
	end)
	arg_5_0:AddBtnListener(arg_5_0.tabBtn_, nil, function()
		arg_5_0:ChangeSkinPage()
	end)
	arg_5_0:AddBtnListener(arg_5_0.skinListFiltetBtn_, nil, function()
		if arg_5_0.skinPageState_ == 1 then
			local var_8_0 = ShopConst.SPECIAL_ID.SKIN_LIST
			local var_8_1 = arg_5_0.specialPages_[var_8_0]

			if var_8_1.OpenFilterView then
				var_8_1:OpenFilterView()
			end
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.skinDiscountBtn_, nil, function()
		local var_9_0 = arg_5_0:CheckSkinDiscountGift()

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
	local var_11_0 = arg_11_0[arg_11_1]
	local var_11_1 = var_11_0[arg_11_2].id
	local var_11_2 = ShopListCfg[var_11_1]

	if not var_0_3(var_11_2) then
		return arg_11_2
	end

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if not var_0_3(iter_11_1) then
			return arg_11_2
		end
	end

	return nil, GetTips("ERROR_FUNCTION_STOP")
end

function var_0_0.PreGroupSelectCheck(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.itemToSelect_

	if arg_12_0.currentGroupIndex_ == arg_12_1 then
		var_12_0 = var_12_0 or arg_12_0.currentItemIndex_
	else
		var_12_0 = var_12_0 or 1
	end

	return var_0_4(arg_12_0.groups_, arg_12_1, var_12_0)
end

local function var_0_5(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0 = arg_13_2.childCount + 1, arg_13_0 do
		local var_13_0 = Object.Instantiate(arg_13_1, arg_13_2)
	end

	local var_13_1 = arg_13_2.childCount

	for iter_13_1 = 1, var_13_1 do
		local var_13_2 = arg_13_2:GetChild(iter_13_1 - 1).gameObject

		SetActive(var_13_2, iter_13_1 <= arg_13_0)
	end
end

local function var_0_6(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.titleTagPrefab_.transform.parent

	var_0_5(arg_14_1, arg_14_0.titleTagPrefab_, var_14_0)

	for iter_14_0 = 1, arg_14_1 do
		local var_14_1 = var_14_0:GetChild(iter_14_0 - 1).gameObject

		var_14_1.name = string.format("tabItem%02d", iter_14_0)
		arg_14_0.titleList[iter_14_0] = arg_14_0.titleList[iter_14_0] or RechargeTitleItem.New(var_14_1)
	end

	local var_14_2 = arg_14_0.titleTagSeprateor_.transform.parent

	var_0_5(arg_14_1 - 1, arg_14_0.titleTagSeprateor_, var_14_2)

	for iter_14_1 = 1, arg_14_1 - 1 do
		var_14_2:GetChild(iter_14_1 - 1).gameObject.name = string.format("line%02d", iter_14_1)
	end
end

function var_0_0.RefreshTitleTabItem(arg_15_0)
	var_0_6(arg_15_0, #arg_15_0.groupInfo.itemIndexes_)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.groupInfo.itemIndexes_) do
		local var_15_0 = arg_15_0.groupInfo[iter_15_1]
		local var_15_1 = var_15_0.id

		arg_15_0.titleList[iter_15_0]:SetData(var_15_0, iter_15_0, handler(arg_15_0, arg_15_0.ClickTitle), var_15_1)
	end

	arg_15_0:UpdateShopTabRedPoint()
end

function var_0_0.OnGroupSelect(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0, var_16_1 = arg_16_0:PreGroupSelectCheck(arg_16_1)

	if not var_16_0 then
		arg_16_0.groupInfo = {
			itemIndexes_ = {}
		}

		arg_16_0:RefreshTitleTabItem()
		arg_16_0:HideLastShopPage()
		ShowTips(var_16_1)

		return
	end

	arg_16_0.groupInfo = arg_16_0.groups_[arg_16_1]

	arg_16_0:RefreshTitleTabItem()

	arg_16_0.params_.page = arg_16_1

	arg_16_0:ClickTitle(var_16_0)

	arg_16_0.itemToSelect_ = nil
	arg_16_0.currentGroupIndex_ = arg_16_1

	arg_16_0:EnterSendMgr(arg_16_1)
end

function var_0_0.ClickTitle(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.titleList[arg_17_1]
	local var_17_1 = var_17_0.shopId

	OperationRecorder.RecordButtonTouch("shop_recharge_gifts" .. arg_17_0.params_.page .. "_type" .. arg_17_1)

	if ShopConst.PC_LOCK_SHOP[var_17_1] and ShopTools.IsLimitRecharge() then
		ShowTips("PC_SHOP_TIPS1")

		return
	end

	if arg_17_0.currentGroupIndex_ == 4 and arg_17_0.currentItemIndex_ == 3 and arg_17_1 ~= 3 then
		saveData("FirstGear", "hasView", true)
		manager.redPoint:setTip(RedPointConst.FIRST_GEAR, 0)
	end

	arg_17_0.currentItemIndex_ = arg_17_1

	arg_17_0:EnterSendMgr(nil, arg_17_1)

	arg_17_0.params_.childShopIndex = arg_17_1

	arg_17_0:SwitchToShop(var_17_1)

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.titleList) do
		iter_17_1.controller:SetSelectedState(iter_17_0 == arg_17_1 and "false" or "true")
	end

	if ShopData.GetRedPointData()[var_17_1] then
		ShopAction.RemoveShopRedPoint(var_17_1)
		manager.redPoint:SetRedPointIndependent(var_17_0.transform_, false)
	end

	manager.redPoint:SetRedPointIndependent(var_17_0.transform_, arg_17_0:SpecialShop(var_17_1), nil, RedPointStyle.NORMAL)

	if var_17_1 == ShopConst.SHOP_ID.MIGRATION_OBSERVATIONS then
		RedPointAction.HandleRedPoint(RED_POINT_ID.RECHARGE)
		manager.redPoint:setTip(RED_POINT_ID.RECHARGE, 0)
		SetActive(arg_17_0.redGo2_, false)
	end

	if var_17_1 == ShopConst.SHOP_ID.OBSERVATION_SHOP and ActivityNoobData:GetFirstMonthlyCardStatus().newTagSignFlag then
		ActivityNoobAction.UpdateFirstSign()
	end

	if var_17_1 == ShopConst.SHOP_ID.CONSTANT_OBSERVATIONS and ActivityNoobData:GetFirstMonthlyCardStatus().newTagRoleFlag then
		ActivityNoobAction.UpdateFirstRecharge()
	end

	if var_17_1 == ShopConst.SHOP_ID.SIX_SHOP and ActivityNoobData:GetFirstRechargeStatus().firstGearNewTag then
		ActivityNoobAction.UpdateFirstGearNewTag()
	end

	if var_17_1 == ShopConst.SHOP_ID.EIGHT_SHOP and ActivityNoobData:GetFirstRechargeStatus().secondGearNewTag then
		ActivityNoobAction.UpdateSecondGearNewTag()
	end

	if var_17_1 == ShopConst.SHOP_ID.CONTRACT_BENEFITS and ActivityNoobData:GetBattlePassStatus().battlePassNewTag then
		ActivityNoobAction.UpdateBattlePassNewTag()
	end
end

function var_0_0.ChangeSkinPage(arg_18_0)
	if arg_18_0.skinPageState_ == 0 then
		arg_18_0:SwitchToSkinList()
	else
		arg_18_0:SwitchToShop(arg_18_0.shopListId_, true)
	end
end

function var_0_0.SwitchToSkinList(arg_19_0)
	arg_19_0.skinPageState_ = 1

	arg_19_0.hideTopController_:SetSelectedState("state1")
	arg_19_0.btnTwoController_:SetSelectedState("state1")
	arg_19_0.tabChooseController_:SetSelectedState("select2")

	if arg_19_0.shopListId_ then
		local var_19_0 = arg_19_0.pages_[arg_19_0.shopListId_]

		if var_19_0 then
			var_19_0:Hide()
		end
	end

	local var_19_1 = ShopConst.SPECIAL_ID.SKIN_LIST

	arg_19_0:UpdateBar()

	if not arg_19_0.specialPages_[var_19_1] then
		local var_19_2 = Object.Instantiate(Asset.Load(ShopConst.SPRCIAL_PREFAB[var_19_1]), arg_19_0.container_)

		arg_19_0.specialPages_[var_19_1] = arg_19_0.SpecialClassList_[var_19_1].New(var_19_2)

		arg_19_0.specialPages_[var_19_1]:Show()
	else
		arg_19_0.specialPages_[var_19_1]:Show()
	end
end

function var_0_0.UpdateBar(arg_20_0)
	if arg_20_0.skinPageState_ == 1 then
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

	if arg_20_0.shopListId_ == ShopConst.SHOP_ID.SKIN_SHOP or arg_20_0.shopListId_ == ShopConst.SHOP_ID.SKIN_TARGET then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_SKIN
		}, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, var_0_2[arg_20_0.shopListId_] ~= true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, var_0_2[arg_20_0.shopListId_] ~= true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), nullable(var_0_2, arg_20_0.shopListId_) ~= true)
	end
end

function var_0_0.RefreshTree(arg_21_0)
	local var_21_0 = arg_21_0.tree_

	var_21_0:SetSelectedHandler(nil, nil)

	local var_21_1 = arg_21_0:GetTreeDataByParams()

	var_21_0:SetData(var_21_1)
	var_21_0:SetSelectedHandler(handler(arg_21_0, arg_21_0.OnGroupSelect))

	arg_21_0.treeData_ = var_21_1

	arg_21_0:BindRedPoint()
	arg_21_0:UpdateShopTabRedPoint()
	arg_21_0:UpdateShopCategoryTreeRedPoint()
end

function var_0_0.HideLastShopPage(arg_22_0)
	if arg_22_0.shopListId_ then
		local var_22_0 = arg_22_0.pages_[arg_22_0.shopListId_]

		if var_22_0 then
			var_22_0:Hide()
		end
	end
end

function var_0_0.SwitchToShop(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.skinDiscountController_:SetSelectedState(arg_23_1 == ShopConst.SHOP_ID.SKIN_SHOP and arg_23_0:CheckSkinDiscountGift() and "state1" or "state0")

	if arg_23_1 == arg_23_0.shopListId_ and not arg_23_2 then
		return
	end

	if arg_23_0.skinPageState_ == 1 then
		arg_23_0.skinPageState_ = 0

		arg_23_0.hideTopController_:SetSelectedState("state0")
		arg_23_0.btnTwoController_:SetSelectedState("state0")
		arg_23_0.tabChooseController_:SetSelectedState("select1")

		local var_23_0 = ShopConst.SPECIAL_ID.SKIN_LIST
		local var_23_1 = arg_23_0.specialPages_[var_23_0]

		if var_23_1 then
			var_23_1:Hide()
		end
	end

	arg_23_0:HideLastShopPage()

	arg_23_0.shopListId_ = arg_23_1
	arg_23_0.params_.shopListId = arg_23_1

	if not arg_23_0.pages_[arg_23_1] then
		local var_23_2 = Object.Instantiate(Asset.Load(arg_23_0.prefabList_[arg_23_1]), arg_23_0.container_)

		arg_23_0.pages_[arg_23_1] = arg_23_0.ClassList_[arg_23_1].New(var_23_2, {
			ShopConst.SIX_EIGHT[arg_23_1]
		}, arg_23_1)

		arg_23_0:CheckPageEnter(arg_23_1)
	else
		arg_23_0.pages_[arg_23_1]:Show()
	end

	if arg_23_0.pages_[arg_23_1].SwitchPage then
		arg_23_0.pages_[arg_23_1]:SwitchPage(arg_23_1)
	end

	if ShopConst.SKIN_SHOP_LIST[arg_23_1] then
		arg_23_0.skinTabController_:SetSelectedIndex(1)
	else
		arg_23_0.skinTabController_:SetSelectedIndex(0)
	end

	arg_23_0:UpdateBar()
end

function var_0_0.SwitchPageByParams(arg_24_0)
	arg_24_0.currentGroupIndex_, arg_24_0.currentItemIndex_ = 1, 1

	local var_24_0 = 1

	if arg_24_0.params_.page then
		local var_24_1 = arg_24_0.params_.page

		arg_24_0.currentGroupIndex_ = var_24_1

		local var_24_2 = arg_24_0.groups_[var_24_1]
		local var_24_3 = arg_24_0.params_.shopId_ or arg_24_0.params_.shopListId

		for iter_24_0, iter_24_1 in ipairs(var_24_2.itemIndexes_) do
			local var_24_4 = var_24_2[iter_24_1]

			if var_24_3 and var_24_3 == var_24_4.id then
				arg_24_0.itemToSelect_ = iter_24_0

				break
			end
		end

		if arg_24_0.itemToSelect_ == nil and arg_24_0.params_.childShopIndex then
			arg_24_0.itemToSelect_ = arg_24_0.params_.childShopIndex
		end

		arg_24_0.tree_:SelectGroup(arg_24_0.currentGroupIndex_)

		if var_24_3 and arg_24_0.params_.goodId_ then
			local var_24_5 = arg_24_0.params_.goodId_

			if ShopTools.IsGoodCanBuyInShop(var_24_3, var_24_5) and ShopTools.CheckSoldOut(var_24_5) == false then
				if ShopTools.CheckGiftSkinOwn(var_24_5) then
					ShowTips("ALREADY_GET")
				elseif ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
					ShowTips("PC_SHOP_TIPS2")
				else
					JumpTools.OpenPageByJump("rechargeGiftPopLink", {
						goodId = var_24_5,
						shopId = var_24_3
					})
				end
			else
				ShowTips("SELL_OUT")
			end

			arg_24_0.params_.goodId_ = nil
		end

		arg_24_0.params_.shopId_ = nil
	end
end

function var_0_0.CheckPageEnter(arg_25_0, arg_25_1)
	if not arg_25_0.enteredPage_[arg_25_1] then
		arg_25_0.enterTimerDic[arg_25_1] = TimeTools.StartAfterSeconds(0.05, function()
			if arg_25_0.enterTimerDic[arg_25_1] == nil then
				return
			end

			arg_25_0.pages_[arg_25_1]:OnEnter()

			arg_25_0.enteredPage_[arg_25_1] = true
			arg_25_0.enterTimerDic[arg_25_1] = nil
		end, {})
	end
end

function var_0_0.OnTop(arg_27_0)
	arg_27_0:UpdateBar()

	if arg_27_0.currentGroupIndex_ ~= arg_27_0.params_.page or arg_27_0.currentItemIndex_ ~= arg_27_0.params_.childShopIndex then
		arg_27_0:SwitchPageByParams()
	end

	if arg_27_0.groupInfo[arg_27_0.currentItemIndex_] then
		local var_27_0 = arg_27_0.groupInfo[arg_27_0.currentItemIndex_].id

		if var_27_0 == ShopConst.SHOP_ID.CONTRACT_BENEFITS and arg_27_0.pages_[var_27_0] then
			arg_27_0.pages_[var_27_0]:Show()
		end
	end
end

function var_0_0.OnEnter(arg_28_0)
	arg_28_0.enteredPage_ = {}

	for iter_28_0, iter_28_1 in pairs(arg_28_0.pages_) do
		arg_28_0:CheckPageEnter(iter_28_0)
	end

	arg_28_0:RefreshTree()
	arg_28_0:SwitchPageByParams()
	arg_28_0:RegistEventListener(SHOP_BUY_SUCCESS, function(arg_29_0, arg_29_1)
		for iter_29_0, iter_29_1 in pairs(arg_28_0.pages_) do
			if iter_29_1 ~= nil and iter_29_1.OnBuySuccess then
				iter_29_1:OnBuySuccess(arg_29_0, arg_29_1)
			end
		end
	end)
	arg_28_0:RegistEventListener(RECHARGE_SKIN_LIST_FILTER_APPLY, function(arg_30_0)
		arg_28_0:OnSkinListFilterApply(arg_30_0)
	end)

	if arg_28_0.pages_[arg_28_0.shopListId_] and arg_28_0.pages_[arg_28_0.shopListId_].RefreshList then
		arg_28_0.pages_[arg_28_0.shopListId_]:RefreshList()
	end

	if arg_28_0.skinPageState_ == 1 then
		local var_28_0 = ShopConst.SPECIAL_ID.SKIN_LIST

		if arg_28_0.specialPages_[var_28_0] and arg_28_0.specialPages_[var_28_0].RefreshList then
			arg_28_0.specialPages_[var_28_0]:RefreshList()
		end
	end
end

function var_0_0.OnExit(arg_31_0)
	arg_31_0:RemoveAllEventListener()

	for iter_31_0, iter_31_1 in pairs(arg_31_0.pages_) do
		if iter_31_1 ~= nil then
			iter_31_1:OnExit()
		end
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0.specialPages_) do
		if iter_31_3 ~= nil then
			iter_31_3:OnExit()
		end
	end

	arg_31_0.enterTimer = nil

	for iter_31_4, iter_31_5 in pairs(arg_31_0.enterTimerDic) do
		iter_31_5:Stop()
	end

	arg_31_0.enterTimerDic = {}

	arg_31_0:UnbindRedPoint()
	manager.windowBar:HideBar()
	arg_31_0:ExitUITime()
end

function var_0_0.UpdateShopCategoryTreeRedPoint(arg_32_0)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.groups_) do
		local var_32_0 = arg_32_0.tree_:GetGroupRedPointContainerById(iter_32_0)

		if var_32_0 then
			SetActive(var_32_0, true)

			local var_32_1 = false
			local var_32_2 = false
			local var_32_3 = var_32_0.transform:Find("notice_img/Default")
			local var_32_4 = var_32_0.transform:Find("notice_img/NewRed")

			for iter_32_2, iter_32_3 in ipairs(iter_32_1) do
				if arg_32_0:CheckShopRedPoint(iter_32_3.id) then
					var_32_1 = true
				end

				if arg_32_0:SpecialShop(iter_32_3.id) then
					var_32_2 = true
				end
			end

			SetActive(var_32_4, var_32_1)
			SetActive(var_32_3, var_32_2)
		end
	end
end

function var_0_0.UpdateShopTabRedPoint(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0.titleList) do
		if iter_33_0 <= #arg_33_0.groupInfo.itemIndexes_ then
			local var_33_0 = iter_33_1.shopId
			local var_33_1 = false
			local var_33_2 = RedPointStyle.None

			if arg_33_0:CheckShopRedPoint(var_33_0) then
				var_33_1, var_33_2 = true, RedPointStyle.SHOW_NEW_TAG
			elseif arg_33_0:SpecialShop(var_33_0) then
				var_33_1, var_33_2 = true, RedPointStyle.NORMAL
			end

			manager.redPoint:SetRedPointIndependent(iter_33_1.transform_, var_33_1, nil, var_33_2)
		end
	end
end

function var_0_0.BindRedPoint(arg_34_0)
	manager.redPoint:bindUIandKey(arg_34_0.totalRechargeNoticeContainer_, RedPointConst.TOTAL_CHARGE_BONUS)
	manager.redPoint:bindUIandKey(arg_34_0.skinDiscountBtn_.transform, RedPointConst.SKIN_DISCOUNT_GIFT)

	if arg_34_0.updateTimer_ then
		arg_34_0.updateTimer_:Stop()

		arg_34_0.updateTimer_ = nil
	end

	arg_34_0.updateTimer_ = Timer.New(function()
		arg_34_0:UpdateShopTabRedPoint()
		arg_34_0:UpdateShopCategoryTreeRedPoint()
	end, 1, -1, 1)

	arg_34_0.updateTimer_:Start()
end

function var_0_0.UnbindRedPoint(arg_36_0)
	manager.redPoint:unbindUIandKey(arg_36_0.totalRechargeNoticeContainer_, RedPointConst.TOTAL_CHARGE_BONUS, {
		x = 0,
		y = 0
	})
	manager.redPoint:unbindUIandKey(arg_36_0.skinDiscountBtn_.transform, RedPointConst.SKIN_DISCOUNT_GIFT)

	if arg_36_0.updateTimer_ then
		arg_36_0.updateTimer_:Stop()

		arg_36_0.updateTimer_ = nil
	end
end

function var_0_0.OnShopBuyResult(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	if arg_37_0.pages_[var_0_1] then
		arg_37_0.pages_[var_0_1]:OnShopBuyResult(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	end

	if arg_37_0.pages_[ShopConst.SHOP_ID.OATH_RING_SHIP] then
		arg_37_0.pages_[ShopConst.SHOP_ID.OATH_RING_SHIP]:OnShopBuyResult(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	end
end

function var_0_0.SpecialShop(arg_38_0, arg_38_1)
	if ShopConst.PC_LOCK_SHOP[arg_38_1] == true and ShopTools.IsLimitRecharge() then
		return false
	end

	if ShopConst.SHOP_ID_TO_RED_CONST[arg_38_1] then
		return manager.redPoint:getTipBoolean(ShopConst.SHOP_ID_TO_RED_CONST[arg_38_1])
	end

	return false
end

function var_0_0.CheckShopRedPoint(arg_39_0, arg_39_1)
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

function var_0_0.OnTryToUseItem(arg_40_0, arg_40_1, arg_40_2)
	if isSuccess(arg_40_1.result) then
		local var_40_0 = arg_40_2.use_item_list[1].item_id
		local var_40_1 = ItemCfg[var_40_0].param[1]

		getReward({
			{
				num = 1,
				id = var_40_1
			}
		})

		local var_40_2 = SkinCfg[var_40_1].hero

		HeroAction.UpdateSkinCouponRedPoint(var_40_2)
		HeroAction.SkinAdd(var_40_1)
	else
		ShowTips(arg_40_1.result)
	end
end

function var_0_0.HaveActivityGift(arg_41_0)
	local var_41_0 = getShopIDListByShopID(ShopConst.SHOP_ID.LIMIT_SUPPLY)

	for iter_41_0, iter_41_1 in ipairs(var_41_0) do
		if not ShopData.IsGoodOutOfDate(iter_41_1, ShopConst.SHOP_ID.LIMIT_SUPPLY) then
			return true
		end
	end

	return false
end

function var_0_0.HaveNewbieGift(arg_42_0)
	local var_42_0 = ShopConst.SHOP_ID.NEWBIE_SHOP
	local var_42_1 = ShopData.GetShop(var_42_0)

	for iter_42_0, iter_42_1 in pairs(var_42_1.shopItemIDs) do
		if ShopTools.IsGoodCanDisplay(var_42_0, iter_42_1) and not ShopData.IsSoldout(var_42_0, iter_42_1) then
			return true
		end
	end

	return false
end

function var_0_0.OnMainHomeViewTop(arg_43_0)
	arg_43_0.params_.childShopIndex = 1
	arg_43_0.params_.page = 1
end

function var_0_0.OnSkinListFilterApply(arg_44_0, arg_44_1)
	if arg_44_0.skinPageState_ == 1 then
		local var_44_0 = ShopConst.SPECIAL_ID.SKIN_LIST
		local var_44_1 = arg_44_0.specialPages_[var_44_0]

		if var_44_1.OnSkinListFilterApply then
			var_44_1:OnSkinListFilterApply(arg_44_1)
		end
	end

	if #arg_44_1.heroIDList > 0 or arg_44_1.goodType ~= ShopConst.FILTER_HERO_TYPE.ALL or arg_44_1.stateType ~= ShopConst.FILTER_STATE_TYPE.ALL then
		arg_44_0.filterBtnController_:SetSelectedState("orange")
	else
		arg_44_0.filterBtnController_:SetSelectedState("normal")
	end
end

function var_0_0.Dispose(arg_45_0)
	arg_45_0.firstRechargeGroupGoList_ = nil

	if arg_45_0.tree_ then
		arg_45_0.tree_:Dispose()

		arg_45_0.tree_ = nil
	end

	for iter_45_0, iter_45_1 in ipairs(arg_45_0.titleList) do
		iter_45_1:Dispose()
	end

	if arg_45_0.pages_ then
		for iter_45_2, iter_45_3 in pairs(arg_45_0.pages_) do
			iter_45_3:Dispose()
		end

		arg_45_0.pages_ = nil
	end

	if arg_45_0.specialPages_ then
		for iter_45_4, iter_45_5 in pairs(arg_45_0.specialPages_) do
			iter_45_5:Dispose()
		end

		arg_45_0.specialPages_ = nil
	end

	var_0_0.super.Dispose(arg_45_0)
end

function var_0_0.RefreshFirstRechargeGroup(arg_46_0)
	arg_46_0.firstRechargeGroupGoList_ = {}
	arg_46_0.firstRechargeGroupGoList_[1] = arg_46_0.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.SIX_SHOP)
	arg_46_0.firstRechargeGroupGoList_[2] = arg_46_0.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.EIGHT_SHOP)
	arg_46_0.firstRechargeGroupGoList_[3] = arg_46_0.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.OBSERVATION_SHOP)

	for iter_46_0, iter_46_1 in ipairs(arg_46_0.firstRechargeGroupGoList_) do
		SetActive(iter_46_1, ActivityNewbieTools.GetRechargeIsOpen(iter_46_0))
	end

	local var_46_0 = ActivityNewbieTools.GetFirstRechargeStatus()

	if var_46_0 and var_46_0.firstGearStatus == 2 then
		arg_46_0.tree_:GetData().groupDatas[5].defaultIndex = 1
	end
end

function var_0_0.GetTreeDataByParams(arg_47_0)
	local var_47_0 = {}

	if arg_47_0.params_.showShops then
		var_47_0 = arg_47_0.params_.showShops
	else
		local var_47_1 = ShopListCfg.get_id_list_by_system[2]

		for iter_47_0, iter_47_1 in ipairs(var_47_1) do
			if ShopListCfg[iter_47_1].show_in_shop == 1 then
				table.insert(var_47_0, iter_47_1)
			end
		end
	end

	local var_47_2 = {}

	for iter_47_2, iter_47_3 in ipairs(var_47_0) do
		table.insert(var_47_2, iter_47_3)
	end

	arg_47_0.groups_ = {}
	arg_47_0.groupIndexes_ = {}

	local var_47_3 = UITreeData.New()

	for iter_47_4, iter_47_5 in ipairs(var_47_2) do
		local var_47_4 = ShopListCfg[iter_47_5]

		if not arg_47_0.groups_[var_47_4.display_group] then
			arg_47_0.groups_[var_47_4.display_group] = {
				itemIndexes_ = {}
			}

			table.insert(arg_47_0.groupIndexes_, var_47_4.display_group)
		end

		arg_47_0.groups_[var_47_4.display_group][var_47_4.display_index] = var_47_4

		if not var_0_3(var_47_4) then
			table.insert(arg_47_0.groups_[var_47_4.display_group].itemIndexes_, var_47_4.display_index)
		end
	end

	for iter_47_6, iter_47_7 in pairs(arg_47_0.groups_) do
		table.sort(iter_47_7.itemIndexes_, function(arg_48_0, arg_48_1)
			return arg_48_0 < arg_48_1
		end)
	end

	table.sort(arg_47_0.groupIndexes_, function(arg_49_0, arg_49_1)
		return arg_49_0 < arg_49_1
	end)

	for iter_47_8, iter_47_9 in pairs(arg_47_0.groupIndexes_) do
		local var_47_5 = UITreeGroupData.New()

		var_47_5.text = GetI18NText(ShopListCfg.get_id_list_by_system_and_group[2][iter_47_9][1].group_name)
		var_47_5.controllerStateValue = tostring(iter_47_9)
		var_47_5.id = iter_47_9

		var_47_3.groupDatas:Add(var_47_5)
	end

	return var_47_3
end

function var_0_0.EnterSendMgr(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0.groupIndex_ = arg_50_1 or arg_50_0.groupIndex_
	arg_50_0.titleIndex_ = arg_50_2 or arg_50_0.titleIndex_

	local var_50_0 = string.format("%s_%s_%s", UITimeConst.shopRechargeGifts, arg_50_0.groupIndex_, arg_50_0.titleIndex_)

	if arg_50_0.groupIndex_ and arg_50_0.titleIndex_ and var_50_0 ~= arg_50_0.lastShopId_ then
		arg_50_0:ExitSendMgr()
		manager.uiTime:OnEnterRoute(var_50_0, true)

		arg_50_0.lastShopId_ = var_50_0
	end
end

function var_0_0.ExitSendMgr(arg_51_0)
	if arg_51_0.lastShopId_ then
		manager.uiTime:OnExitRoute(arg_51_0.lastShopId_, true)
	end
end

function var_0_0.ExitUITime(arg_52_0)
	arg_52_0:ExitSendMgr()

	arg_52_0.lastShopId_ = nil
	arg_52_0.groupIndex_ = nil
	arg_52_0.titleIndex_ = nil
end

function var_0_0.CheckSkinDiscountGift(arg_53_0)
	local var_53_0 = SkinDiscountGiftTools.GetActivityList()

	for iter_53_0, iter_53_1 in ipairs(var_53_0) do
		local var_53_1 = SkinDiscountGiftTools.GetSignActivityID(iter_53_1)

		if var_53_1 and SignTools.GetSevenDaySignIndex(var_53_1) ~= 0 then
			return iter_53_1
		end
	end

	return (SkinDiscountGiftTools.HasGiftActivityID())
end

return var_0_0
