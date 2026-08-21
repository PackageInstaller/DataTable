local var_0_0 = class("ExchangeEquipItem", ReduxView)

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

	arg_3_0.list1 = LuaList.New(handler(arg_3_0, arg_3_0.SetItem1), arg_3_0.listGo_, EquipExchangeItem)
end

function var_0_0.SetItem1(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:SetData(arg_4_0.data[arg_4_1], arg_4_1, handler(arg_4_0, arg_4_0.ClickCallBack), arg_4_0.equipData)
end

function var_0_0.ClickCallBack(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0.equipData ~= arg_5_1 then
		arg_5_0.clickData = arg_5_1

		arg_5_3.selectController:SetSelectedState("true")
	else
		arg_5_0.clickData = nil

		arg_5_3.selectController:SetSelectedState("false")
	end

	arg_5_0.callback(arg_5_0.index, arg_5_0.clickData, arg_5_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_5_0.transform_)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	arg_6_0.data = arg_6_1
	arg_6_0.indexList = arg_6_3
	arg_6_0.index = arg_6_4
	arg_6_0.callback = arg_6_5
	arg_6_0.equipData = arg_6_6

	arg_6_0:Show(true)
	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	if arg_7_0.data == nil then
		SetActive(arg_7_0.gameObject_, false)

		return
	end

	arg_7_0.list1:StartScrollWithoutAnimator(#arg_7_0.data)

	arg_7_0.titleTxt_.text = ""

	SetActive(arg_7_0.titleGo_.gameObject, false)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.indexList) do
		if arg_7_0.index == iter_7_1 then
			SetActive(arg_7_0.titleGo_.gameObject, true)

			arg_7_0.titleTxt_.text = GetTips("SHOP_LABLE_3")
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.transform_)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:UpdateView()
end

function var_0_0.OnExit(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.list1:GetItemList()) do
		iter_9_1:OnExit()
	end
end

function var_0_0.UpdateTimerView(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.list1:GetItemList()) do
		iter_10_1:UpdateTimerView()
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.list1:Dispose()
	var_0_0.super.Dispose(arg_11_0)
	Object.Destroy(arg_11_0.gameObject_)
end

function var_0_0.GetItemHeight(arg_12_0)
	return arg_12_0.rectGo_.sizeDelta.y
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
