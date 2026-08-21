local var_0_0 = class("ShopContentViewWithPoster", ShopContentViewBase)

function var_0_0.GetAssetPath()
	return
end

function var_0_0.InitUI(arg_2_0)
	local var_2_0 = Asset.Load(arg_2_0.GetAssetPath())

	arg_2_0.gameObject_ = Object.Instantiate(var_2_0, arg_2_0.containerGo_.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	arg_2_0:BindCfgUI()

	arg_2_0.list_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.listGo_, ExchangeItemView)
end

function var_0_0.OnEnter(arg_3_0)
	return
end

function var_0_0.OnExit(arg_4_0)
	return
end

function var_0_0.UpdateListByFilter(arg_5_0)
	arg_5_0:RefreshList()
end

function var_0_0.GetPoster(arg_6_0)
	return getSpriteViaConfig("ShopPoster", arg_6_0.shopId_)
end

function var_0_0.RefreshList(arg_7_0, arg_7_1)
	arg_7_0.imageImg_.sprite = arg_7_0:GetPoster()
	arg_7_0.shopName.text = ShopListCfg[arg_7_0.shopId_].remark

	var_0_0.super.RefreshList(arg_7_0, arg_7_1)

	arg_7_0.shopDataList_ = ShopTools.FilterShopDataList(arg_7_0.shopId_)

	local var_7_0 = {}

	if not arg_7_0.selectedPos then
		arg_7_0.selectedPos = DormConst.DORM_FURTYPE_OFFSET
	end

	if arg_7_0.selectedPos ~= DormConst.DORM_FURTYPE_OFFSET then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.shopDataList_) do
			local var_7_1 = getShopCfg(iter_7_1.id).give_id

			if arg_7_0.selectedPos == DormConst.DORM_SUIT_TYPE and BackHomeSuitCfg[var_7_1] or BackHomeFurniture[var_7_1] and arg_7_0.selectedPos == BackHomeFurniture[var_7_1].type then
				table.insert(var_7_0, iter_7_1)
			end
		end

		arg_7_0.shopDataList_ = var_7_0
	end

	if arg_7_1 and arg_7_0.list_:GetNum() == #arg_7_0.shopDataList_ then
		arg_7_0.list_:Refresh()
	else
		arg_7_0.list_:StartScroll(#arg_7_0.shopDataList_)

		if #arg_7_0.shopDataList_ == 0 then
			-- block empty
		end
	end
end

function var_0_0.OnItemClick(arg_8_0, arg_8_1)
	return
end

function var_0_0.IndexItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:RegistCallBack(handler(arg_9_0, arg_9_0.OnItemClick))
	arg_9_2:SetData(arg_9_0.shopDataList_[arg_9_1])

	arg_9_0.contentHeight = arg_9_0.contentTrs_.rect.height
end

function var_0_0.ScrollByPosition(arg_10_0, arg_10_1, arg_10_2)
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

function var_0_0.GetLuaList(arg_11_0)
	return arg_11_0.list_
end

function var_0_0.GetItemList(arg_12_0)
	return arg_12_0.list_:GetItemList()
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.list_ then
		arg_13_0.list_:Dispose()

		arg_13_0.list_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
