local var_0_0 = class("NewServerSupplyPage", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/NewServer/NewServerShopUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.giftList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.listGo_, RechargeGiftItem)
end

function var_0_0.AddEventListeners(arg_3_0)
	arg_3_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_4_0)
		if arg_4_0 > 0 and arg_4_0 == arg_3_0.curShopId_ then
			arg_3_0:RefreshList()
		end
	end)
	arg_3_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_5_0, arg_5_1)
		arg_3_0:RefreshShopGoodInfo(arg_5_0, arg_5_1)
	end)
	arg_3_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_6_0)
		arg_3_0:RefreshList()
	end)
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)

	if arg_8_1 == true then
		arg_8_0:AddEventListeners()
	else
		arg_8_0:RemoveAllEventListener()
	end
end

function var_0_0.UpdateBar(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	if arg_10_0.giftList_ then
		arg_10_0.giftList_:Dispose()

		arg_10_0.giftList_ = nil
	end
end

function var_0_0.SetData(arg_11_0)
	arg_11_0.curShopId_ = ShopConst.SHOP_ID.NEW_SERVER_SHOP
	arg_11_0.shopDataList_ = arg_11_0:InitShopList(arg_11_0.curShopId_)

	arg_11_0.giftList_:StartScroll(#arg_11_0.shopDataList_)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.shopDataList_[arg_12_1])
	arg_12_2:SetOutOfDateHandler(handler(arg_12_0, arg_12_0.OnItemOutOfDate))
end

function var_0_0.OnItemOutOfDate(arg_13_0, arg_13_1)
	arg_13_0:RefreshList()

	if #arg_13_0.shopDataList_ == 0 and arg_13_0.treeRefreshHandler_ ~= nil then
		arg_13_0.treeRefreshHandler_()
	end
end

function var_0_0.RefreshList(arg_14_0)
	arg_14_0.shopDataList_ = arg_14_0:InitShopList(arg_14_0.curShopId_)

	arg_14_0.giftList_:StartScroll(#arg_14_0.shopDataList_)
end

function var_0_0.InitShopList(arg_15_0, arg_15_1)
	local var_15_0 = ShopTools.FilterShopDataList(arg_15_1)
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_2 = getShopCfg(iter_15_1.id)

		if RechargeShopDescriptionCfg[var_15_2.description] ~= nil then
			table.insert(var_15_1, iter_15_1)
		end
	end

	local var_15_3 = var_15_1

	table.sort(var_15_3, function(arg_16_0, arg_16_1)
		local var_16_0 = getShopCfg(arg_16_0.id)
		local var_16_1 = getShopCfg(arg_16_1.id)
		local var_16_2 = arg_15_0:GetGoodStatus(arg_16_0.id, arg_15_1)
		local var_16_3 = arg_15_0:GetGoodStatus(arg_16_1.id, arg_15_1)

		if var_16_2 ~= var_16_3 then
			return var_16_2 < var_16_3
		end

		local var_16_4 = var_16_0.cost
		local var_16_5 = var_16_1.cost

		if var_16_4 == 0 and var_16_5 ~= 0 or var_16_5 == 0 and var_16_4 ~= 0 then
			return var_16_4 < var_16_5
		end

		local var_16_6 = var_16_0.tag
		local var_16_7 = var_16_1.tag

		if var_16_6 == 1 and var_16_7 == 0 or var_16_6 == 0 and var_16_7 == 1 then
			return var_16_7 < var_16_6
		end

		if var_16_0.shop_sort ~= var_16_1.shop_sort then
			return var_16_0.shop_sort > var_16_1.shop_sort
		end

		return var_16_0.goods_id > var_16_1.goods_id
	end)

	return var_15_3
end

function var_0_0.GetGoodStatus(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = false
	local var_17_1 = getShopCfg(arg_17_1, arg_17_2)
	local var_17_2 = ShopData.GetShop(var_17_1.shop_id)[arg_17_1]

	if ShopData.IsGoodOutOfDate(arg_17_1, arg_17_2) then
		return 2
	end

	if var_17_2 ~= nil and var_17_1.limit_num ~= nil and var_17_1.limit_num ~= -1 and var_17_1.limit_num - var_17_2.buy_times <= 0 then
		var_17_0 = true
	end

	if var_17_0 then
		return 2
	end

	if ShopData.IsGoodUnlock(arg_17_1, arg_17_2) == 0 then
		return 1
	end

	return 0
end

function var_0_0.RefreshShopGoodInfo(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.curShopId_ ~= arg_18_1 then
		return
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.giftList_:GetItemList()) do
		if arg_18_2 == iter_18_1.goodId_ then
			iter_18_1:SetData(iter_18_1.index_, iter_18_1.shopId_, iter_18_1.goodId_)
		end
	end
end

function var_0_0.OnShopBuyResult(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if arg_19_1 == 0 then
		arg_19_0:RefreshList()
	end
end

return var_0_0
