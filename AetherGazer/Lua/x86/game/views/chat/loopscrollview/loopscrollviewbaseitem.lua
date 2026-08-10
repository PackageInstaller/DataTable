local var_0_0 = class("LoopScrollViewBaseItem", ReduxView)

function var_0_0.GetIndex(arg_1_0)
	return arg_1_0.index_
end

function var_0_0.IsActive(arg_2_0)
	return true
end

function var_0_0.IsTimeBar(arg_3_0)
	return false
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_0.GetItemHeight(arg_5_0)
	return arg_5_0.rectGo_.sizeDelta.y
end

function var_0_0.SetAsLastSibling(arg_6_0)
	arg_6_0.transform_:SetAsLastSibling()
end

function var_0_0.SetAsFirstSibling(arg_7_0)
	arg_7_0.transform_:SetAsFirstSibling()
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

return var_0_0
