local var_0_0 = class("NewActivityShopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Shop/ActiveStoreUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetItem), arg_4_0.listGo_, ExchangeItemView)
	arg_4_0.stateController = arg_4_0.controller_:GetController("state")
	arg_4_0.titleTogList = {
		RechargeTitleItem.New(arg_4_0.tag01_),
		RechargeTitleItem.New(arg_4_0.tag02_),
		(RechargeTitleItem.New(arg_4_0.tag03_))
	}
end

function var_0_0.SetItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.shopDataList[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_8_0)
		if arg_8_0 == 0 or arg_7_0.curShopId_ == arg_8_0 then
			arg_7_0:UpdateShopList(arg_7_0.curShopId_)
		end
	end)
	arg_7_0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_9_0)
		arg_7_0.needKeepPos1 = true

		arg_7_0:UpdateShopList(arg_7_0.curShopId_)
	end)
	arg_7_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_10_0, arg_10_1)
		if arg_7_0.curShopId_ ~= arg_10_0 then
			return
		end

		arg_7_0.needKeepPos1 = true

		arg_7_0:UpdateShopList(arg_7_0.curShopId_)
	end)
	arg_7_0:RegistEventListener(CURRENCY_UPDATE, function(arg_11_0)
		local var_11_0 = getShopIDListByCurrency(arg_11_0)

		if var_11_0 ~= nil and #var_11_0 > 0 then
			arg_7_0.needKeepPos1 = true

			arg_7_0:UpdateShopList(arg_7_0.curShopId_, true)
		end
	end)
	arg_7_0:RegistEventListener(MATERIAL_MODIFY, function(arg_12_0)
		local var_12_0 = getShopIDListByCurrency(arg_12_0)

		if var_12_0 ~= nil and #var_12_0 > 0 then
			arg_7_0.needKeepPos1 = true

			arg_7_0:UpdateShopList(arg_7_0.curShopId_)
		end
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:InitShopByParams()
	arg_13_0:UpdateViewByParams()
	arg_13_0:UpdateTitle()
	arg_13_0:AddEventListeners()
	arg_13_0:SetTimer()
end

function var_0_0.OnTop(arg_14_0)
	if arg_14_0.params_.shopId == arg_14_0.curShopId_ then
		arg_14_0:UpdateBarByShopId(arg_14_0.curShopId_)

		return
	end

	arg_14_0.curShopId_ = arg_14_0.params_.shopId

	if arg_14_0.curShopId_ ~= nil then
		arg_14_0.needKeepPos1 = true

		arg_14_0:UpdateViewByParams()
	end
end

function var_0_0.UpdateTitle(arg_15_0)
	local var_15_0 = arg_15_0.groupIndexes[1]

	arg_15_0.groupInfo = arg_15_0.groups[var_15_0]

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.titleTogList) do
		if iter_15_0 <= #arg_15_0.groupInfo.itemIndexes_ then
			SetActive(iter_15_1.gameObject_, true)

			local var_15_1 = arg_15_0.groupInfo[arg_15_0.groupInfo.itemIndexes_[iter_15_0]].id

			iter_15_1:SetData(arg_15_0.groupInfo[arg_15_0.groupInfo.itemIndexes_[iter_15_0]], iter_15_0, handler(arg_15_0, arg_15_0.ClickTitle), var_15_1)
		else
			SetActive(iter_15_1.gameObject_, false)
		end
	end

	if #ShopListCfg[arg_15_0.groupInfo[arg_15_0.groupInfo.itemIndexes_[1]].id].shop_label >= 1 then
		arg_15_0.stateController:SetSelectedState("true")
	else
		arg_15_0.stateController:SetSelectedState("false")
	end

	for iter_15_2 = 1, 2 do
		SetActive(arg_15_0["line" .. iter_15_2 .. "Go_"], iter_15_2 < #arg_15_0.groupInfo.itemIndexes_)
	end

	if arg_15_0.currentGroupIndex_ == 1 then
		arg_15_0:ClickTitle(arg_15_0.itemToSelect_ or arg_15_0.currentItemIndex_)
	else
		arg_15_0:ClickTitle(arg_15_0.itemToSelect_ or 1)
	end
end

function var_0_0.ClickTitle(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.groupInfo[arg_16_0.groupInfo.itemIndexes_[arg_16_1]].id

	SetActive(arg_16_0.lockGo_, not ShopTools.CheckShopIsUnLock(var_16_0))

	local var_16_1 = ShopListCfg[var_16_0]

	arg_16_0.lockDescTxt_.text = ShopTools.GetShopIsUnLockDesc(var_16_0)
	arg_16_0.currentItemIndex_ = arg_16_1
	arg_16_0.titleTxt_.text = GetI18NText(var_16_1.remark)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.titleTogList) do
		iter_16_1.controller:SetSelectedState(iter_16_0 == arg_16_1 and "false" or "true")
	end

	arg_16_0.roleBg_.sprite = pureGetSpriteWithoutAtlas(var_16_1.shop_background)

	arg_16_0:UpdateBarByShopId(var_16_0)

	arg_16_0.params_.shopId = var_16_0
	arg_16_0.enterTimer = TimeTools.StartAfterSeconds(0.05, function()
		if arg_16_0.enterTimer == nil then
			return
		end

		arg_16_0:UpdateShopList(var_16_0)

		arg_16_0.enterTimer = nil
	end, {})
end

function var_0_0.UpdateViewByParams(arg_18_0)
	arg_18_0:GetTreeDataByParams()

	if next(arg_18_0.groupIndexes) == nil then
		return
	end

	local var_18_0 = arg_18_0.params_.goodId

	if var_18_0 and ShopTools.IsGoodCanBuy(arg_18_0.curShopId_, var_18_0) then
		arg_18_0.timer_ = FrameTimer.New(function()
			arg_18_0.params_.goodId = nil

			local var_19_0 = getShopCfg(var_18_0)
			local var_19_1 = {
				id = var_18_0,
				shopId = var_19_0.shop_id,
				buyTime = ShopData.GetShop(var_19_0.shop_id)[var_18_0] ~= nil and ShopData.GetShop(var_19_0.shop_id)[var_18_0].buy_times or 0
			}

			JumpTools.OpenPopUp("shopBuy", {
				mainShopID = arg_18_0.curShopId_,
				goodInfo = var_19_1
			})

			arg_18_0.timer_ = nil
		end, 1, 1)

		arg_18_0.timer_:Start()
	end
end

function var_0_0.GetTreeDataByParams(arg_20_0)
	local var_20_0 = {}

	if arg_20_0.params_.showShops then
		var_20_0 = arg_20_0.params_.showShops
	else
		local var_20_1 = ShopListCfg.get_id_list_by_system[1]

		for iter_20_0, iter_20_1 in ipairs(var_20_1) do
			if ShopListCfg[iter_20_1].show_in_shop == 1 then
				table.insert(var_20_0, iter_20_1)
			end
		end
	end

	local var_20_2 = {}

	for iter_20_2, iter_20_3 in ipairs(var_20_0) do
		if ShopTools.IsShopOpen(iter_20_3) then
			table.insert(var_20_2, iter_20_3)
		end
	end

	arg_20_0.groups = {}
	arg_20_0.groupIndexes = {}

	for iter_20_4, iter_20_5 in ipairs(var_20_2) do
		local var_20_3 = ShopListCfg[iter_20_5]

		if not arg_20_0.groups[var_20_3.display_group] then
			arg_20_0.groups[var_20_3.display_group] = {
				itemIndexes_ = {}
			}

			table.insert(arg_20_0.groupIndexes, var_20_3.display_group)
		end

		arg_20_0.groups[var_20_3.display_group][var_20_3.display_index] = var_20_3

		table.insert(arg_20_0.groups[var_20_3.display_group].itemIndexes_, var_20_3.display_index)
	end

	for iter_20_6, iter_20_7 in pairs(arg_20_0.groups) do
		table.sort(iter_20_7.itemIndexes_, function(arg_21_0, arg_21_1)
			return arg_21_0 < arg_21_1
		end)
	end

	table.sort(arg_20_0.groupIndexes, function(arg_22_0, arg_22_1)
		return arg_22_0 < arg_22_1
	end)
end

function var_0_0.InitShopByParams(arg_23_0)
	local var_23_0 = arg_23_0.params_.goodId
	local var_23_1 = arg_23_0.params_.shopId

	if var_23_0 then
		local var_23_2 = getShopCfg(var_23_0)

		arg_23_0.curShopId_ = ShopListCfg[var_23_2.shop_id].id
	else
		arg_23_0.curShopId_ = tonumber(var_23_1 or 2)
	end

	arg_23_0.currentGroupIndex_ = ShopListCfg[arg_23_0.curShopId_].display_group
end

function var_0_0.UpdateBarByShopId(arg_24_0, arg_24_1)
	local var_24_0 = {}

	table.insert(var_24_0, BACK_BAR)

	if arg_24_0.params_.hideHomeBtn ~= 1 then
		table.insert(var_24_0, HOME_BAR)
		manager.windowBar:RegistHomeCallBack(function()
			arg_24_0:GoHome()
		end)
	end

	if arg_24_0.params_.infoKey and arg_24_0.params_.infoKey ~= "" then
		table.insert(var_24_0, INFO_BAR)
		manager.windowBar:SetGameHelpKey(arg_24_0.params_.infoKey)
	end

	table.insert(var_24_0, NAVI_BAR)

	local var_24_1 = {}
	local var_24_2 = ShopListCfg[arg_24_1]

	for iter_24_0 = 1, #var_24_2.cost_id do
		local var_24_3

		if CurrencyIdMapCfg[var_24_2.cost_id[iter_24_0]] then
			var_24_3 = CurrencyIdMapCfg[var_24_2.cost_id[iter_24_0]].item_id
		else
			var_24_3 = var_24_2.cost_id[iter_24_0]
		end

		if var_24_3 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			var_24_3 = CurrencyConst.GetPlatformDiamondId()
		end

		table.insert(var_24_0, var_24_3)
		table.insert(var_24_1, var_24_3)
	end

	manager.windowBar:SwitchBar(var_24_0)

	for iter_24_1 = 1, #var_24_1 do
		manager.windowBar:SetBarCanAdd(var_24_1[iter_24_1], ShopConst.ADD_CURRENCY[var_24_1[iter_24_1]] == true)
		manager.windowBar:SetBarCanClick(var_24_1[iter_24_1], true)
	end

	manager.windowBar:RegistHomeCallBack(function()
		arg_24_0:GoHome()
	end)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

function var_0_0.GoHome(arg_28_0)
	gameContext:Go("/home", nil, nil, true)
end

function var_0_0.UpdateShopList(arg_29_0, arg_29_1)
	arg_29_0.curShopId_ = arg_29_1

	local var_29_0 = ShopListCfg[arg_29_1]

	arg_29_0.shopDataList = ShopTools.FilterShopDataList(arg_29_0.curShopId_, var_29_0.chain_last_visible == 1)
	arg_29_0.shopDataList = ShopTools.CommonSort(arg_29_0.shopDataList)

	if arg_29_0.needKeepPos1 then
		arg_29_0.pos = arg_29_0.list:GetScrolledPosition()
	else
		arg_29_0.pos = nil
	end

	arg_29_0.list:StartScrollWithoutAnimator(#arg_29_0.shopDataList, arg_29_0.pos)

	arg_29_0.needKeepPos1 = nil

	arg_29_0:UpdateBarByShopId(arg_29_0.curShopId_)
	arg_29_0:UpdateTimer()
end

function var_0_0.UpdateTimer(arg_30_0)
	local var_30_0 = ShopListCfg[arg_30_0.curShopId_]

	arg_30_0.remainTimeTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(var_30_0.activity_id).stopTime))

	for iter_30_0, iter_30_1 in pairs(arg_30_0.list:GetItemList()) do
		iter_30_1:UpdateTimerView()
	end
end

function var_0_0.SetTimer(arg_31_0)
	SetActive(arg_31_0.timebgGo_, not ShopConst.NEED_HIDE_TIME[arg_31_0.curShopId_])
	arg_31_0:StopTimer()
	arg_31_0:UpdateTimer()

	arg_31_0.refreshTimer_ = Timer.New(function()
		arg_31_0:UpdateTimer()
	end, 1, -1, 1)

	arg_31_0.refreshTimer_:Start()
end

function var_0_0.OnExit(arg_33_0)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.list:GetItemList()) do
		iter_33_1:OnExit()
	end

	arg_33_0.enterTimer = nil

	manager.windowBar:HideBar()

	arg_33_0.params_.hideHomeBtn = nil

	arg_33_0:StopTimer()
	arg_33_0:RemoveAllEventListener()
end

function var_0_0.StopTimer(arg_34_0)
	if arg_34_0.refreshTimer_ then
		arg_34_0.refreshTimer_:Stop()

		arg_34_0.refreshTimer_ = nil
	end
end

function var_0_0.Dispose(arg_35_0)
	if arg_35_0.list then
		arg_35_0.list:Dispose()

		arg_35_0.list = nil
	end

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.titleTogList) do
		iter_35_1:Dispose()
	end

	arg_35_0:RemoveAllListeners()

	arg_35_0.curShopId_ = nil

	var_0_0.super.Dispose(arg_35_0)
end

return var_0_0
