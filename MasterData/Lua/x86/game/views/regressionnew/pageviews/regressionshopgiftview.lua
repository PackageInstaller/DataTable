local RegressionShopGiftView = class("RegressionShopGiftView", ReduxView)

function RegressionShopGiftView:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnThree/RT3rd_ShopGiftUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionShopGiftView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionShopGiftView:InitUI()
	self:BindCfgUI()

	self.itemData = clone(ItemTemplateData)
	self.shopList = LuaList.New(handler(self, self.IndexItem), self.listGo_, RegressionShopItem)
	self.dailyReward = CommonItemView.New(self.rewardGo_)
	self.dailyStateController_ = self.dailyController_:GetController("state")
	self.descTxt_.text = GetTips("NEW_REGRESSION_SHOP_DESC")
	self.discountValueTxt_.text = GetTips("NEW_REGRESSION_SHOP_VALUE_DESC")
end

function RegressionShopGiftView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.shopDataPosList[arg_4_1], arg_4_1, arg_4_1 == #self.shopDataPosList)
	arg_4_2:SetBuyCallBack(handler(self, self.OnClickBuyBtn))
end

function RegressionShopGiftView:OnClickBuyBtn(arg_5_1, arg_5_2)
	local var_5_0 = table.indexof(self.shopPosIDList, arg_5_1)

	self:GetBuyList(arg_5_1)
end

function RegressionShopGiftView:GetBuyList(arg_6_1)
	local var_6_0 = self:GetBuyPreID(arg_6_1, {})

	table.insert(var_6_0, arg_6_1)
	self:BuyGoodList(var_6_0)
end

function RegressionShopGiftView:ConfirmBuyItemList(arg_7_1)
	local var_7_0 = 0
	local var_7_1 = 0
	local var_7_2 = GetTips("CONFIRM_BUY")
	local var_7_3 = 0
	local var_7_4
	local var_7_5 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_6 = getShopCfg(iter_7_1.goodID)

		if ShopTools.GetPrice then
			var_7_0 = var_7_0 + ShopTools.GetPrice(iter_7_1.goodID)
			var_7_1 = ShopTools.GetCostLevel(iter_7_1.goodID)
			var_7_3 = ShopTools.GetCostCount(iter_7_1.goodID)
			var_7_4 = ShopTools.GetCostCfg(iter_7_1.goodID)
		end

		var_7_5 = var_7_5 + 1
	end

	var_7_2 = var_7_5 == 1 and string.format(GetTips("NEW_REGRESSION_BUY_GIFT"), GetI18NText(var_7_4.name), var_7_0) or string.format(GetTips("NEW_REGRESSION_BUY_GIFT_WITH_PRE"), GetI18NText(var_7_4.name), var_7_0)

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

function RegressionShopGiftView:BuyGoodList(arg_10_1)
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
		self:ConfirmBuyItemList(var_10_1)
	end
end

function RegressionShopGiftView:GetBuyPreID(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in pairs(getShopCfg(arg_11_1).pre_goods_id) do
		if not ShopTools.CheckSoldOut(iter_11_1) then
			arg_11_2 = self:GetBuyPreID(iter_11_1, arg_11_2)

			table.insert(arg_11_2, iter_11_1)
		end
	end

	return arg_11_2
end

function RegressionShopGiftView:AddUIListener()
	self:AddBtnListener(self.freeBtn_, nil, function()
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

function RegressionShopGiftView:SetData()
	local var_14_0 = RegressionDataNew:GetShopGoodsList()

	self.shopPosIDList = {}

	local var_14_1 = {}
	local var_14_2 = 0

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if var_14_2 == 4 then
			table.insert(var_14_1, iter_14_0 - 1, iter_14_1)
		elseif var_14_2 == 5 then
			table.insert(var_14_1, iter_14_0 - 2, iter_14_1)
		else
			table.insert(var_14_1, iter_14_1)
		end

		table.insert(self.shopPosIDList, iter_14_1.id)

		var_14_2 = (var_14_2 + 1) % 6
	end

	self.shopDataPosList = var_14_1
	self.shopDataList = var_14_0

	self.shopList:StartScroll(#var_14_1, self:FindCanBuyShopID())
	self:UpdateDailyRewardUI()
	manager.redPoint:bindUIandKey(self.freeBtn_.transform, RedPointConst.NEW_REGRESSION_FREE_DAILY_REWARD)
end

function RegressionShopGiftView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
end

function RegressionShopGiftView:OnExit()
	manager.redPoint:unbindUIandKey(self.freeBtn_.transform, RedPointConst.NEW_REGRESSION_FREE_DAILY_REWARD)
end

function RegressionShopGiftView:UpdateDailyRewardUI()
	local var_17_0 = RegressionDataNew:GetShopDailyFreeGoodID()

	if ShopTools.CheckSoldOut(var_17_0) then
		self.dailyStateController_:SetSelectedState("received")
	else
		self.dailyStateController_:SetSelectedState("hightight")
	end

	local var_17_2 = getShopCfg(var_17_0)
	local var_17_4 = self.itemData

	self.itemData.id = var_17_2.give_id
	self.itemData.number = var_17_2.give

	function self.itemData.clickFun()
		ShowPopItem(POP_ITEM, {
			var_17_4.id
		})
	end

	self.dailyReward:SetData(self.itemData)
	self.dailyReward:Show(true)
end

function RegressionShopGiftView:FindCanBuyShopID()
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(self.shopDataList) do
		if not ShopTools.CheckSoldOut(iter_19_1.id) then
			var_19_0 = iter_19_0

			break
		end
	end

	return var_19_0
end

function RegressionShopGiftView:OnRegressionShopUpdate()
	self.shopList:StartScroll(#self.shopDataPosList, self:FindCanBuyShopID())
	self:UpdateDailyRewardUI()
end

function RegressionShopGiftView:SetActive(arg_21_1)
	SetActive(self.gameObject_, arg_21_1)
end

function RegressionShopGiftView:Dispose()
	if self.shopList then
		self.shopList:Dispose()

		self.shopList = nil
	end

	if self.dailyReward then
		self.dailyReward:Dispose()

		self.dailyReward = nil
	end

	RegressionShopGiftView.super.Dispose(self)
end

return RegressionShopGiftView
