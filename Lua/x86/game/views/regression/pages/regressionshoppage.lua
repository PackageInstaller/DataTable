local var_0_0 = import("game.views.shop.base.ShopContentViewBase")
local var_0_1 = class("RegressionShopPage", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("UI/ReturnUI/RegressionShopUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.list_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, ExchangeItemView)
end

function var_0_1.AddUIListener(arg_4_0)
	return
end

function var_0_1.SetData(arg_5_0)
	arg_5_0:SetShopId(25)
	arg_5_0:RefreshList()
end

function var_0_1.RefreshList(arg_6_0, arg_6_1)
	arg_6_0:UpdateBarByShopId()

	arg_6_0.shopDataList_ = arg_6_0:GetShopGoodList(arg_6_0.shopId_)

	if arg_6_1 and arg_6_0.list_:GetNum() == #arg_6_0.shopDataList_ then
		arg_6_0.list_:Refresh()
	else
		arg_6_0.list_:StartScroll(#arg_6_0.shopDataList_)
	end
end

function var_0_1.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:RegistCallBack(handler(arg_7_0, arg_7_0.OnShopClick))
	arg_7_2:SetData(arg_7_0.shopDataList_[arg_7_1])
end

function var_0_1.GetLuaList(arg_8_0)
	return arg_8_0.list_
end

function var_0_1.GetItemList(arg_9_0)
	return arg_9_0.list_:GetItemList()
end

function var_0_1.ScrollByPosition(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if arg_10_2 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.shopDataList_) do
			if iter_10_1.id == arg_10_2 then
				var_10_0 = iter_10_0

				break
			end
		end
	end

	if var_10_0 ~= nil then
		arg_10_0.list_:ScrollToIndex(var_10_0)
	elseif arg_10_1 then
		arg_10_0.list_:SetScrolledPosition(arg_10_1)
	end
end

function var_0_1.SetActive(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_1.Dispose(arg_12_0)
	if arg_12_0.list_ then
		arg_12_0.list_:Dispose()

		arg_12_0.list_ = nil
	end

	var_0_1.super.Dispose(arg_12_0)
end

return var_0_1
