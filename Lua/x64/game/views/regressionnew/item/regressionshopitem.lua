local var_0_0 = class("RegressionShopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.itemData = {
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	arg_3_0.rewardItemList = {}

	for iter_3_0 = 1, 2 do
		local var_3_0 = string.format("reward%sGo_", iter_3_0)

		arg_3_0.rewardItemList[iter_3_0] = CommonItemView.New(arg_3_0[var_3_0])
	end

	arg_3_0.dirController_ = arg_3_0.controller_:GetController("dir")
	arg_3_0.payController_ = arg_3_0.controller_:GetController("pay")
	arg_3_0.rewardCountController_ = arg_3_0.controller_:GetController("rewardCount")
	arg_3_0.stateController_ = arg_3_0.controller_:GetController("state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.freeBtn_, nil, function()
		if arg_4_0.buyCallback then
			arg_4_0.buyCallback(arg_4_0.shopID, false)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.payBtn_, nil, function()
		if arg_4_0.buyCallback then
			arg_4_0.buyCallback(arg_4_0.shopID, true)
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1.id == -1 then
		SetActive(arg_7_0.gameObject_, false)

		return
	end

	SetActive(arg_7_0.gameObject_, true)

	arg_7_0.shopID = arg_7_1.id
	arg_7_0.shopCfg = getShopCfg(arg_7_0.shopID)

	if not arg_7_3 then
		local var_7_0 = arg_7_2 % 6

		if var_7_0 == 1 or var_7_0 == 2 then
			arg_7_0.dirController_:SetSelectedState("right")
		elseif var_7_0 == 3 or var_7_0 == 4 then
			arg_7_0.dirController_:SetSelectedState("down")
		elseif var_7_0 == 0 or var_7_0 == 5 then
			arg_7_0.dirController_:SetSelectedState("left")

			if var_7_0 == 5 then
				arg_7_0.transform_:SetSiblingIndex(arg_7_2 - 2)
			else
				arg_7_0.transform_:SetSiblingIndex(arg_7_2 - 3)
			end
		end
	else
		arg_7_0.dirController_:SetSelectedState("none")
	end

	if arg_7_0.shopCfg.description then
		arg_7_0.itemCfg = RechargeShopDescriptionCfg[arg_7_0.shopCfg.description]
	else
		arg_7_0.itemCfg = ItemCfg[arg_7_0.shopCfg.give_id]
	end

	local var_7_1 = arg_7_0.shopCfg.cost_id

	if var_7_1 == 0 then
		var_7_1 = arg_7_0.shopCfg.cheap_cost_id
	end

	arg_7_0.priceImg_.sprite = ItemTools.getItemLittleSprite(var_7_1)

	for iter_7_0 = 1, 2 do
		arg_7_0.rewardItemList[iter_7_0]:Show(false)
	end

	local var_7_2 = arg_7_0.itemCfg.param

	if #var_7_2 == 1 then
		arg_7_0.rewardCountController_:SetSelectedState("One")
	else
		arg_7_0.rewardCountController_:SetSelectedState("Two")
	end

	for iter_7_1 = 1, 2 do
		if var_7_2[iter_7_1] then
			local var_7_3 = arg_7_0.itemData[iter_7_1]

			var_7_3.id = var_7_2[iter_7_1][1]
			var_7_3.number = var_7_2[iter_7_1][2]

			function var_7_3.clickFun()
				ShowPopItem(POP_ITEM, {
					var_7_3.id
				})
			end

			arg_7_0.rewardItemList[iter_7_1]:SetData(var_7_3)
			arg_7_0.rewardItemList[iter_7_1]:Show(true)
		end
	end

	arg_7_0:UpdatePrice()

	local var_7_4 = true
	local var_7_5 = arg_7_0.shopCfg.pre_goods_id

	for iter_7_2, iter_7_3 in pairs(var_7_5) do
		if not ShopTools.CheckSoldOut(iter_7_3) then
			var_7_4 = false
		end
	end

	local var_7_6 = false

	if var_7_4 then
		var_7_6 = ShopTools.GetPrice(arg_7_0.shopID) == 0
	end

	arg_7_0:UpdateSoldOutState(var_7_4)
	manager.redPoint:setRedPoint({
		display = arg_7_0.freeBtn_.transform
	}, var_7_6)
end

function var_0_0.UpdatePrice(arg_9_0)
	local var_9_0 = arg_9_0.shopCfg.goods_id
	local var_9_1, var_9_2, var_9_3 = ShopTools.GetPrice(var_9_0)

	arg_9_0.priceTxt_.text = var_9_1

	if var_9_1 <= 0 then
		arg_9_0.payController_:SetSelectedState("free")
	else
		arg_9_0.payController_:SetSelectedState("pay")
	end
end

function var_0_0.UpdateSoldOutState(arg_10_0, arg_10_1)
	if ShopTools.CheckSoldOut(arg_10_0.shopID) then
		arg_10_0.stateController_:SetSelectedState("received")
	elseif arg_10_1 then
		arg_10_0.stateController_:SetSelectedState("hightight")
	else
		arg_10_0.stateController_:SetSelectedState("normal")
	end
end

function var_0_0.SetBuyCallBack(arg_11_0, arg_11_1)
	arg_11_0.buyCallback = arg_11_1
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.rewardItemList) do
		if iter_12_1 then
			iter_12_1:Dispose()

			iter_12_1 = nil
		end
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
