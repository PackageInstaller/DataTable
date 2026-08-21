local var_0_0 = class("RegressionShopGiftView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/ReturnThree/RT3rd_ShopGiftUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.itemData = clone(ItemTemplateData)
	arg_3_0.shopList = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, RegressionShopItem)
	arg_3_0.dailyReward = CommonItemView.New(arg_3_0.rewardGo_)
	arg_3_0.dailyStateController_ = arg_3_0.dailyController_:GetController("state")
	arg_3_0.descTxt_.text = GetTips("NEW_REGRESSION_SHOP_DESC")
	arg_3_0.discountValueTxt_.text = GetTips("NEW_REGRESSION_SHOP_VALUE_DESC")
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.shopDataPosList[arg_4_1]

	arg_4_2:SetData(var_4_0, arg_4_1, arg_4_1 == #arg_4_0.shopDataPosList)
	arg_4_2:SetBuyCallBack(handler(arg_4_0, arg_4_0.OnClickBuyBtn))
end

function var_0_0.OnClickBuyBtn(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = table.indexof(arg_5_0.shopPosIDList, arg_5_1)

	arg_5_0:GetBuyList(arg_5_1)
end

function var_0_0.GetBuyList(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = arg_6_0:GetBuyPreID(arg_6_1, var_6_0)

	table.insert(var_6_1, arg_6_1)
	arg_6_0:BuyGoodList(var_6_1)
end

function var_0_0.ConfirmBuyItemList(arg_7_0, arg_7_1)
	local var_7_0 = 0
	local var_7_1 = 0
	local var_7_2 = GetTips("CONFIRM_BUY")
	local var_7_3 = 0
	local var_7_4
	local var_7_5 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_6 = iter_7_1.goodID
		local var_7_7 = getShopCfg(var_7_6)

		if ShopTools.GetPrice then
			var_7_0 = var_7_0 + ShopTools.GetPrice(var_7_6)
			var_7_1 = ShopTools.GetCostLevel(var_7_6)
			var_7_3 = ShopTools.GetCostCount(var_7_6)
			var_7_4 = ShopTools.GetCostCfg(var_7_6)
		end

		var_7_5 = var_7_5 + 1
	end

	if var_7_5 == 1 then
		var_7_2 = string.format(GetTips("NEW_REGRESSION_BUY_GIFT"), GetI18NText(var_7_4.name), var_7_0)
	else
		var_7_2 = string.format(GetTips("NEW_REGRESSION_BUY_GIFT_WITH_PRE"), GetI18NText(var_7_4.name), var_7_0)
	end

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = var_7_2,
		OkCallback = function()
			if var_7_3 < var_7_0 then
				ShopTools.CostEnoughJump(var_7_1)
			else
				if not RegressionDataNew:IsRegressionOpen() then
					ShowTips("GOODS_HAS_BEEN_REMOVED")

					return
				end

				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 0
				})
				ShopAction.BuyItem(arg_7_1, cost, buy_source)
			end
		end,
		CancelCallback = function()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_giftbox_check = 1
			})
		end
	})
end

function var_0_0.BuyGoodList(arg_10_0, arg_10_1)
	local var_10_0 = true

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if ShopTools.GetPrice(iter_10_1) > 0 then
			var_10_0 = false

			break
		end
	end

	local var_10_1 = {}

	for iter_10_2, iter_10_3 in pairs(arg_10_1) do
		table.insert(var_10_1, {
			buyNum = 1,
			goodID = iter_10_3
		})
	end

	if var_10_0 then
		ShopAction.BuyItem(var_10_1, nil, buy_source)
	else
		arg_10_0:ConfirmBuyItemList(var_10_1)
	end
end

function var_0_0.GetBuyPreID(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = getShopCfg(arg_11_1).pre_goods_id

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if not ShopTools.CheckSoldOut(iter_11_1) then
			arg_11_2 = arg_11_0:GetBuyPreID(iter_11_1, arg_11_2)

			table.insert(arg_11_2, iter_11_1)
		end
	end

	return arg_11_2
end

function var_0_0.AddUIListener(arg_12_0)
	arg_12_0:AddBtnListener(arg_12_0.freeBtn_, nil, function()
		local var_13_0 = RegressionDataNew:GetShopDailyFreeGoodID()

		if not ShopTools.CheckSoldOut(var_13_0) then
			ShopAction.BuyItem({
				{
					buyNum = 1,
					goodID = var_13_0
				}
			}, nil, 0)
		end
	end)
end

function var_0_0.SetData(arg_14_0)
	local var_14_0 = RegressionDataNew:GetShopGoodsList()

	arg_14_0.shopPosIDList = {}

	local var_14_1 = {}
	local var_14_2 = 0
	local var_14_3 = #var_14_0 % 6

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if var_14_2 == 4 then
			table.insert(var_14_1, iter_14_0 - 1, iter_14_1)
		elseif var_14_2 == 5 then
			table.insert(var_14_1, iter_14_0 - 2, iter_14_1)
		else
			table.insert(var_14_1, iter_14_1)
		end

		table.insert(arg_14_0.shopPosIDList, iter_14_1.id)

		var_14_2 = (var_14_2 + 1) % 6
	end

	arg_14_0.shopDataPosList = var_14_1
	arg_14_0.shopDataList = var_14_0

	arg_14_0.shopList:StartScroll(#var_14_1, arg_14_0:FindCanBuyShopID())
	arg_14_0:UpdateDailyRewardUI()
	manager.redPoint:bindUIandKey(arg_14_0.freeBtn_.transform, RedPointConst.NEW_REGRESSION_FREE_DAILY_REWARD)
end

function var_0_0.UpdateBar(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function var_0_0.OnExit(arg_16_0)
	manager.redPoint:unbindUIandKey(arg_16_0.freeBtn_.transform, RedPointConst.NEW_REGRESSION_FREE_DAILY_REWARD)
end

function var_0_0.UpdateDailyRewardUI(arg_17_0)
	local var_17_0 = RegressionDataNew:GetShopDailyFreeGoodID()

	if ShopTools.CheckSoldOut(var_17_0) then
		arg_17_0.dailyStateController_:SetSelectedState("received")
	else
		arg_17_0.dailyStateController_:SetSelectedState("hightight")
	end

	local var_17_1
	local var_17_2 = getShopCfg(var_17_0)
	local var_17_3 = ItemCfg[var_17_2.give_id]
	local var_17_4 = arg_17_0.itemData

	var_17_4.id = var_17_2.give_id
	var_17_4.number = var_17_2.give

	function var_17_4.clickFun()
		ShowPopItem(POP_ITEM, {
			var_17_4.id
		})
	end

	arg_17_0.dailyReward:SetData(var_17_4)
	arg_17_0.dailyReward:Show(true)
end

function var_0_0.FindCanBuyShopID(arg_19_0)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.shopDataList) do
		if not ShopTools.CheckSoldOut(iter_19_1.id) then
			var_19_0 = iter_19_0

			break
		end
	end

	return var_19_0
end

function var_0_0.OnRegressionShopUpdate(arg_20_0)
	arg_20_0.shopList:StartScroll(#arg_20_0.shopDataPosList, arg_20_0:FindCanBuyShopID())
	arg_20_0:UpdateDailyRewardUI()
end

function var_0_0.SetActive(arg_21_0, arg_21_1)
	SetActive(arg_21_0.gameObject_, arg_21_1)
end

function var_0_0.Dispose(arg_22_0)
	if arg_22_0.shopList then
		arg_22_0.shopList:Dispose()

		arg_22_0.shopList = nil
	end

	if arg_22_0.dailyReward then
		arg_22_0.dailyReward:Dispose()

		arg_22_0.dailyReward = nil
	end

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
