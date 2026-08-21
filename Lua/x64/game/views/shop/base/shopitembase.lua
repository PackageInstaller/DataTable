local var_0_0 = class("ShopItemBase", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(nil, nil, "OnClick")
	arg_3_0:AddBtnListener(arg_3_0.tipsBtn_, nil, function()
		if ItemCfg[arg_3_0.itemCfg.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			JumpTools.OpenPageByJump("/showServantView", {
				state = "onlydetail",
				id = arg_3_0.itemCfg.id
			})
		else
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_3_0.itemCfg.id
			})
		end
	end)
end

function var_0_0.SetPriceText(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		arg_5_1 = arg_5_0.goodID
	end

	local var_5_0, var_5_1, var_5_2 = ShopTools.GetPrice(arg_5_0.goodID)

	arg_5_0.priceText_.text = var_5_0
end

function var_0_0.UpdatePrice(arg_6_0, arg_6_1)
	local var_6_0 = getShopCfg(arg_6_1)
	local var_6_1 = ShopListCfg[arg_6_0.shopID]
	local var_6_2, var_6_3, var_6_4 = ShopTools.GetPrice(arg_6_1)

	if var_6_1.system == "1" and arg_6_0.oldPriceLabel_ then
		SetActive(arg_6_0.oldPriceLabel_.gameObject, true)

		arg_6_0.oldPriceLabel_.text = var_6_3
	elseif arg_6_0.oldPriceLabel_ then
		SetActive(arg_6_0.oldPriceLabel_.gameObject, false)
	end

	arg_6_0.moneyTxt_.text = ShopTools.GetMoneySymbol(arg_6_1)

	if var_6_2 <= 0 then
		arg_6_0.costTypeController_:SetSelectedState("free")
	else
		if ShopTools.IsRMB(arg_6_1) then
			arg_6_0.priceText_.text = var_6_2
		else
			arg_6_0:SetCostIcon()
			arg_6_0:SetPriceText(arg_6_1)
		end

		if arg_6_0.isDiscountController_ then
			arg_6_0.isDiscountController_:SetSelectedState(arg_6_0:IsOnDiscountArea(arg_6_1) and "true" or "false")
		end

		arg_6_0.costTypeController_:SetSelectedState(ShopTools.IsRMB(arg_6_1) and "money" or "currency")
	end

	if var_6_0.tag == ShopConst.TAGS.NEW then
		arg_6_0.tipController_:SetSelectedState(arg_6_0:IsOnDiscountArea(arg_6_1) and "discount" or "none")
	end

	if ShopTools.IsRMB(arg_6_1) and ShopTools.IsPC() and not SDKTools.GetIsOverSea() then
		arg_6_0.priceText_.text = GetTips("PC_SHOP_TIPS3")
		arg_6_0.moneyTxt_.text = ""
	end
end

function var_0_0.IsOnDiscountArea(arg_7_0, arg_7_1)
	return ShopTools.IsOnDiscountArea(arg_7_1)
end

function var_0_0.SetCostIcon(arg_8_0)
	local var_8_0 = arg_8_0.shopCfg.cost_id

	if var_8_0 == 0 then
		var_8_0 = arg_8_0.shopCfg.cheap_cost_id
	end

	arg_8_0.costIcon_.sprite = ItemTools.getItemLittleSprite(var_8_0)
end

function var_0_0.SetCommonItem(arg_9_0)
	CommonTools.SetCommonData(arg_9_0.commonItem_, {
		id = arg_9_0.itemCfg.id
	}, arg_9_0.commonData)
end

function var_0_0.SetData(arg_10_0, arg_10_1)
	if arg_10_1 == nil then
		return
	end

	arg_10_0.data = arg_10_1
	arg_10_0.shopCfg = getShopCfg(arg_10_1.id)
	arg_10_0.goodID = arg_10_0.shopCfg.goods_id
	arg_10_0.dlcID = arg_10_0.shopCfg.dlc or nil
	arg_10_0.haveDlc = arg_10_0.dlcID ~= nil and arg_10_0.dlcID ~= 0
	arg_10_0.isExchange = arg_10_0.shopCfg.shop_refresh == 2
	arg_10_0.shopID = arg_10_0.shopCfg.shop_id

	local var_10_0

	if arg_10_0.shopCfg.description then
		arg_10_0.itemCfg = RechargeShopDescriptionCfg[arg_10_0.shopCfg.description]

		if arg_10_0.itemCfg.type ~= 21 then
			var_10_0 = arg_10_0.itemCfg.param[1]
		end
	else
		arg_10_0.itemCfg = ItemCfg[arg_10_0.shopCfg.give_id]
	end

	if var_10_0 and SkinCfg[var_10_0] then
		arg_10_0.skinCfg = SkinCfg[var_10_0]
		arg_10_0.skinID = var_10_0
		arg_10_0.heroCfg = HeroCfg[arg_10_0.skinCfg.hero]
	end

	if arg_10_0.haveDlc then
		arg_10_0.shopDlcCfg = getShopCfg(arg_10_0.dlcID)
		arg_10_0.itemDlcCfg = RechargeShopDescriptionCfg[arg_10_0.shopDlcCfg.description]

		if arg_10_0.itemDlcCfg == nil then
			arg_10_0.itemDlcCfg = ItemCfg[getShopCfg(arg_10_0.dlcID).give_id]
		end

		arg_10_0.canBuyDlc = ShopConst.SHOP_ID.DLC_SHOP == arg_10_0.shopDlcCfg.shop_id
	end

	if ShopData.GetShop(arg_10_0.shopID) == nil then
		arg_10_0.buyTime = 0
	else
		arg_10_0.buyTime = ShopData.GetShop(arg_10_0.shopID)[arg_10_0.goodID] ~= nil and ShopData.GetShop(arg_10_0.shopID)[arg_10_0.goodID].buy_times or 0
	end

	arg_10_0.restNum = arg_10_0.shopCfg.limit_num - arg_10_0.buyTime

	arg_10_0:UpdateView()
	arg_10_0:UpdateTimerView()
end

function var_0_0.UpdateView(arg_11_0)
	return
end

function var_0_0.UpdateTimerView(arg_12_0)
	return
end

function var_0_0.GetItemInfo(arg_13_0)
	return arg_13_0.data
end

function var_0_0.RegistCallBack(arg_14_0, arg_14_1)
	arg_14_0.callBack = arg_14_1
end

function var_0_0.ClickFunction(arg_15_0)
	if ItemCfg[arg_15_0.shopCfg.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		if ShopTools.HaveSkin(arg_15_0.shopCfg.give_id) then
			return
		end
	elseif arg_15_0.shopCfg.limit_num then
		if arg_15_0.shopCfg.limit_num ~= -1 and arg_15_0.shopCfg.limit_num <= arg_15_0.data.buyTime then
			return
		end

		local var_15_0, var_15_1 = ShopTools.JudgeIsLvLimit(arg_15_0.shopCfg.level_limit)

		if var_15_0 then
			return
		end
	end

	JumpTools.OpenPopUp("shopBuy", {
		goodInfo = arg_15_0.data
	})
end

function var_0_0.OnEnter(arg_16_0)
	return
end

function var_0_0.OnExit(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
