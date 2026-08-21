local var_0_0 = class("ShopExchangeContentView", ShopContentViewBase)

function var_0_0.InitUI(arg_1_0)
	local var_1_0 = Asset.Load("Widget/System/Shop/contentViews/defaultView")

	var_1_0.name = "exchangeContentUI"
	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_0.containerGo_.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.list_ = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.listGo_, ExchangeItemView)
end

function var_0_0.RefreshList(arg_2_0, arg_2_1)
	var_0_0.super.RefreshList(arg_2_0, arg_2_1)

	arg_2_0.shopDataList_ = arg_2_0:GetExchangeGoodList(arg_2_0.shopId_)

	if arg_2_1 and arg_2_0.list_:GetNum() == #arg_2_0.shopDataList_ then
		arg_2_0.list_:Refresh()
	else
		arg_2_0.list_:StartScroll(#arg_2_0.shopDataList_)
	end
end

function var_0_0.IndexItem(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2:SetData(arg_3_0.shopDataList_[arg_3_1])
end

function var_0_0.GetLuaList(arg_4_0)
	return arg_4_0.list_
end

function var_0_0.GetItemList(arg_5_0)
	return arg_5_0.list_:GetItemList()
end

function var_0_0.ScrollByPosition(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0

	if arg_6_2 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.shopDataList_) do
			if iter_6_1.id == arg_6_2 then
				var_6_0 = iter_6_0

				break
			end
		end
	end

	if var_6_0 ~= nil then
		arg_6_0.list_:ScrollToIndex(var_6_0)
	elseif arg_6_1 then
		arg_6_0.list_:SetScrolledPosition(arg_6_1)
	end
end

function var_0_0.GetExchangeGoodList(arg_7_0)
	local var_7_0 = ShopListCfg[arg_7_0.shopId_].chain_last_visible == 1

	return ShopTools.FilterShopDataList(arg_7_0.shopId_, var_7_0)
end

function var_0_0.Dispose(arg_8_0)
	if arg_8_0.list_ then
		arg_8_0.list_:Dispose()

		arg_8_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
