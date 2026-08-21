local var_0_0 = import("game.views.recharge.pages.RechargePageBase")
local var_0_1 = class("RechargeVoucherPageView", var_0_0)

function var_0_1.InitUI(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.shopID = arg_1_2

	arg_1_0:BindCfgUI()

	arg_1_0.list_ = LuaList.New(handler(arg_1_0, arg_1_0.indexItem), arg_1_0.listGo_, RechargeVoucherItem)
end

function var_0_1.indexItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2:SetData(arg_2_0.shopDataList_[arg_2_1])
end

function var_0_1.AddUIListener(arg_3_0)
	return
end

function var_0_1.OnTop(arg_4_0)
	return
end

function var_0_1.OnEnter(arg_5_0)
	arg_5_0.shopDataList_ = arg_5_0:InitDataList()

	arg_5_0.list_:StartScroll(#arg_5_0.shopDataList_)
end

function var_0_1.OnExit(arg_6_0)
	return
end

function var_0_1.Hide(arg_7_0)
	var_0_1.super.Hide(arg_7_0)
end

function var_0_1.InitDataList(arg_8_0)
	local var_8_0 = ShopTools.FilterShopDataList(arg_8_0.shopID)

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		local var_9_0 = getShopCfg(arg_9_0.id)
		local var_9_1 = getShopCfg(arg_9_1.id)

		return var_9_0.goods_id < var_9_1.goods_id
	end)

	return var_8_0
end

function var_0_1.Dispose(arg_10_0)
	if arg_10_0.list_ then
		arg_10_0.list_:Dispose()

		arg_10_0.list_ = nil
	end

	var_0_1.super.Dispose(arg_10_0)
end

return var_0_1
