local RegressionShopItem = class("RegressionShopItem", ReduxView)

function RegressionShopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RegressionShopItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionShopItem:InitUI()
	self:BindCfgUI()

	self.itemData = {
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	self.rewardItemList = {}

	for iter_3_0 = 1, 2 do
		self.rewardItemList[iter_3_0] = CommonItemView.New(self[string.format("reward%sGo_", iter_3_0)])
	end

	self.dirController_ = self.controller_:GetController("dir")
	self.payController_ = self.controller_:GetController("pay")
	self.rewardCountController_ = self.controller_:GetController("rewardCount")
	self.stateController_ = self.controller_:GetController("state")
end

function RegressionShopItem:AddUIListener()
	self:AddBtnListener(self.freeBtn_, nil, function()
		if self.buyCallback then
			self.buyCallback(self.shopID, false)
		end
	end)
	self:AddBtnListener(self.payBtn_, nil, function()
		if self.buyCallback then
			self.buyCallback(self.shopID, true)
		end
	end)
end

function RegressionShopItem:SetData(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1.id == -1 then
		SetActive(self.gameObject_, false)

		return
	end

	SetActive(self.gameObject_, true)

	self.shopID = arg_7_1.id
	self.shopCfg = getShopCfg(self.shopID)

	if not arg_7_3 then
		if arg_7_2 % 6 == 1 or arg_7_2 % 6 == 2 then
			self.dirController_:SetSelectedState("right")
		elseif arg_7_2 % 6 == 3 or arg_7_2 % 6 == 4 then
			self.dirController_:SetSelectedState("down")
		elseif arg_7_2 % 6 == 0 or arg_7_2 % 6 == 5 then
			self.dirController_:SetSelectedState("left")

			if arg_7_2 % 6 == 5 then
				self.transform_:SetSiblingIndex(arg_7_2 - 2)
			else
				self.transform_:SetSiblingIndex(arg_7_2 - 3)
			end
		end
	else
		self.dirController_:SetSelectedState("none")
	end

	self.itemCfg = self.shopCfg.description and RechargeShopDescriptionCfg[self.shopCfg.description] or ItemCfg[self.shopCfg.give_id]
	self.priceImg_.sprite = ItemTools.getItemLittleSprite((self.shopCfg.cost_id == 0 or nil) and self.shopCfg.cheap_cost_id)

	for iter_7_0 = 1, 2 do
		self.rewardItemList[iter_7_0]:Show(false)
	end

	local var_7_1 = self.itemCfg.param

	if #self.itemCfg.param == 1 then
		self.rewardCountController_:SetSelectedState("One")
	else
		self.rewardCountController_:SetSelectedState("Two")
	end

	for iter_7_1 = 1, 2 do
		if var_7_1[iter_7_1] then
			local var_7_2 = self.itemData[iter_7_1]

			self.itemData[iter_7_1].id = var_7_1[iter_7_1][1]
			self.itemData[iter_7_1].number = var_7_1[iter_7_1][2]
			self.itemData[iter_7_1].clickFun = function()
				ShowPopItem(POP_ITEM, {
					var_7_2.id
				})
			end

			self.rewardItemList[iter_7_1]:SetData(self.itemData[iter_7_1])
			self.rewardItemList[iter_7_1]:Show(true)
		end
	end

	self:UpdatePrice()

	local var_7_3 = true

	for iter_7_2, iter_7_3 in pairs(self.shopCfg.pre_goods_id) do
		if not ShopTools.CheckSoldOut(iter_7_3) then
			var_7_3 = false
		end
	end

	local var_7_4 = false

	if var_7_3 then
		var_7_4 = ShopTools.GetPrice(self.shopID) == 0
	end

	self:UpdateSoldOutState(var_7_3)
	manager.redPoint:setRedPoint({
		display = self.freeBtn_.transform
	}, var_7_4)
end

function RegressionShopItem:UpdatePrice()
	local var_9_0, var_9_1, var_9_2 = ShopTools.GetPrice(self.shopCfg.goods_id)

	self.priceTxt_.text = var_9_0

	if var_9_0 <= 0 then
		self.payController_:SetSelectedState("free")
	else
		self.payController_:SetSelectedState("pay")
	end
end

function RegressionShopItem:UpdateSoldOutState(arg_10_1)
	if ShopTools.CheckSoldOut(self.shopID) then
		self.stateController_:SetSelectedState("received")
	elseif arg_10_1 then
		self.stateController_:SetSelectedState("hightight")
	else
		self.stateController_:SetSelectedState("normal")
	end
end

function RegressionShopItem:SetBuyCallBack(arg_11_1)
	self.buyCallback = arg_11_1
end

function RegressionShopItem:Dispose()
	for iter_12_0, iter_12_1 in pairs(self.rewardItemList) do
		if iter_12_1 then
			iter_12_1:Dispose()

			iter_12_1 = nil
		end
	end

	RegressionShopItem.super.Dispose(self)
end

return RegressionShopItem
