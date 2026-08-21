local var_0_0 = class("EquipGoodsItem", ShopItemBase)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.commonItem_ = CommonItemView.New(arg_1_0.commonGo_)
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.buyBtn_, nil, function()
		arg_2_0:ClickFunction()
	end)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index = arg_4_2
	arg_4_0.data = arg_4_1
	arg_4_0.shopCfg = getShopCfg(arg_4_1.id)
	arg_4_0.goodID = arg_4_1.id
	arg_4_0.dlcID = arg_4_0.shopCfg.dlc or nil
	arg_4_0.haveDlc = arg_4_0.dlcID ~= nil and arg_4_0.dlcID ~= 0
	arg_4_0.isExchange = arg_4_0.shopCfg.shop_refresh == 2
	arg_4_0.shopID = arg_4_1.shopId

	local var_4_0

	if arg_4_0.shopCfg.description then
		arg_4_0.itemCfg = RechargeShopDescriptionCfg[arg_4_0.shopCfg.description]
		var_4_0 = arg_4_0.itemCfg.param[1]
	else
		arg_4_0.itemCfg = ItemCfg[arg_4_0.shopCfg.give_id]
	end

	if var_4_0 and SkinCfg[var_4_0] then
		arg_4_0.skinCfg = SkinCfg[var_4_0]
		arg_4_0.skinID = var_4_0
		arg_4_0.heroCfg = HeroCfg[arg_4_0.skinCfg.hero]
	end

	if arg_4_0.haveDlc then
		arg_4_0.shopDlcCfg = getShopCfg(arg_4_0.dlcID)
		arg_4_0.itemDlcCfg = RechargeShopDescriptionCfg[arg_4_0.shopDlcCfg.description]

		if arg_4_0.itemDlcCfg == nil then
			arg_4_0.itemDlcCfg = ItemCfg[getShopCfg(arg_4_0.dlcID).give_id]
		end

		arg_4_0.canBuyDlc = ShopConst.SHOP_ID.DLC_SHOP == arg_4_0.shopDlcCfg.shop_id
	end

	arg_4_0.buyTime = ShopData.GetShop(arg_4_0.shopID)[arg_4_0.goodID] ~= nil and ShopData.GetShop(arg_4_0.shopID)[arg_4_0.goodID].buy_times or 0
	arg_4_0.restNum = arg_4_0.shopCfg.limit_num - arg_4_0.data.buyTime

	arg_4_0:UpdateView()
	arg_4_0:UpdateTimerView()
end

function var_0_0.UpdateView(arg_5_0)
	arg_5_0:SetCommonItem()
	arg_5_0:SetCostIcon()
	arg_5_0:SetPriceText(arg_5_0.goodID)

	arg_5_0.titleImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Common/com_equip_icon_0" .. arg_5_0.index)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0:UpdateView()
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
	Object.Destroy(arg_8_0.gameObject_)
end

return var_0_0
