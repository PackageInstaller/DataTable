local var_0_0 = class("ExchangeSplitItem", ReduxView)

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

	arg_3_0.list = LuaList.New(handler(arg_3_0, arg_3_0.SetItem), arg_3_0.listGo_, ExchangeItemView)
end

function var_0_0.SetItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_0.data[arg_4_1])
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.data = arg_5_1
	arg_5_0.titleIndex = arg_5_2
	arg_5_0.indexList = arg_5_3
	arg_5_0.index = arg_5_4

	arg_5_0:Show(true)
	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	arg_6_0.list:StartScrollWithoutAnimator(#arg_6_0.data)
	SetActive(arg_6_0.titleGo_.gameObject, false)

	arg_6_0.titleTxt_.text = ""

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.indexList) do
		if arg_6_0.index == iter_6_1 then
			SetActive(arg_6_0.titleGo_.gameObject, true)

			local var_6_0 = getShopCfg(arg_6_0.data[1].id)
			local var_6_1 = ItemCfg[var_6_0.give_id]

			if var_6_1.type == ItemConst.ITEM_TYPE.HERO_PIECE and var_6_0.shop_refresh == 4 then
				arg_6_0.titleTxt_.text = GetTips("SHOP_LABLE_5")
			elseif ShopConst.ITEM_TYPE_TO_LABEL[var_6_1.type] then
				arg_6_0.titleTxt_.text = GetTips(ShopConst.ITEM_TYPE_TO_LABEL[var_6_1.type])
			else
				arg_6_0.titleTxt_.text = GetTips("SHOP_LABLE_1")
			end
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.transform_)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:UpdateView()
end

function var_0_0.UpdateTimerView(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.list:GetItemList()) do
		iter_8_1:UpdateTimerView()
	end
end

function var_0_0.OnExit(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.list:GetItemList()) do
		iter_9_1:OnExit()
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.list:Dispose()
	var_0_0.super.Dispose(arg_10_0)
	Object.Destroy(arg_10_0.gameObject_)
end

function var_0_0.GetItemHeight(arg_11_0)
	return arg_11_0.rectGo_.sizeDelta.y
end

function var_0_0.SetAsLastSibling(arg_12_0)
	arg_12_0.transform_:SetAsLastSibling()
end

function var_0_0.SetAsFirstSibling(arg_13_0)
	arg_13_0.transform_:SetAsFirstSibling()
end

function var_0_0.GetIndex(arg_14_0)
	return arg_14_0.index
end

function var_0_0.IsActive(arg_15_0)
	return true
end

function var_0_0.IsTimeBar(arg_16_0)
	return false
end

function var_0_0.Show(arg_17_0, arg_17_1)
	SetActive(arg_17_0.gameObject_, arg_17_1)
end

return var_0_0
