local var_0_0 = class("RechargeSkinNormalItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.skinItem = RechargeSkinNewItem.New(arg_3_0.gameObject_)
end

function var_0_0.SetItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_0.data[arg_4_1])
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.data = arg_5_1
	arg_5_0.shopCfg = getShopCfg(arg_5_1.id)
	arg_5_0.goodID = arg_5_1.id
	arg_5_0.isExchange = arg_5_0.shopCfg.shop_refresh == 2
	arg_5_0.shopID = arg_5_0.shopCfg.shop_id

	local var_5_0

	if arg_5_0.shopCfg.description then
		arg_5_0.itemCfg = RechargeShopDescriptionCfg[arg_5_0.shopCfg.description]
		var_5_0 = arg_5_0.itemCfg.param[1]
	else
		arg_5_0.itemCfg = ItemCfg[arg_5_0.shopCfg.give_id]
	end

	if var_5_0 and SkinCfg[var_5_0] then
		arg_5_0.skinCfg = SkinCfg[var_5_0]
		arg_5_0.skinID = var_5_0
		arg_5_0.heroCfg = HeroCfg[arg_5_0.skinCfg.hero]
	end

	arg_5_0.buyTime = ShopData.GetShop(arg_5_0.shopID)[arg_5_0.goodID] ~= nil and ShopData.GetShop(arg_5_0.shopID)[arg_5_0.goodID].buy_times or 0
	arg_5_0.restNum = arg_5_0.shopCfg.limit_num - arg_5_0.buyTime
	arg_5_0.index = arg_5_2

	arg_5_0:Show(true)
	arg_5_0:UpdateView()
end

function var_0_0.SetCallBack(arg_6_0, arg_6_1)
	arg_6_0.callBack_ = arg_6_1
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.skinItem:SetData(arg_7_0.data)
	arg_7_0.skinItem:SetCallBack(arg_7_0.callBack_, arg_7_0.index)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.transform_)
	arg_7_0:UpdateTimerView()
end

function var_0_0.UpdateTimerView(arg_8_0)
	arg_8_0.skinItem:UpdateTimerView()
	arg_8_0.skinItem.giftController_:SetSelectedState("false")
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:UpdateView()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0.skinItem:OnExit()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.transform_)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.skinItem:Dispose()
	var_0_0.super.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)
end

function var_0_0.GetItemHeight(arg_12_0)
	return arg_12_0.rectGo_.sizeDelta.x
end

function var_0_0.SetAsLastSibling(arg_13_0)
	arg_13_0.transform_:SetAsLastSibling()
end

function var_0_0.SetAsFirstSibling(arg_14_0)
	arg_14_0.transform_:SetAsFirstSibling()
end

function var_0_0.GetIndex(arg_15_0)
	return arg_15_0.index
end

function var_0_0.IsActive(arg_16_0)
	return true
end

function var_0_0.IsTimeBar(arg_17_0)
	return false
end

function var_0_0.Show(arg_18_0, arg_18_1)
	SetActive(arg_18_0.gameObject_, arg_18_1)
end

return var_0_0
