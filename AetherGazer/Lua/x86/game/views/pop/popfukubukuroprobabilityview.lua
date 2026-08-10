local var_0_0 = class("PopFukubukuroProbabilityView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/FukubukuroProbabilityPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.m_list, PopFukubukuroProbabilityItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.m_mask, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	return
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.itemId = arg_8_0.params_.itemId

	local var_8_0 = ItemCfg[arg_8_0.itemId]

	if var_8_0 and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == var_8_0.sub_type then
		arg_8_0.probabilitys = var_8_0.param
		arg_8_0.weight = 0

		for iter_8_0, iter_8_1 in ipairs(arg_8_0.probabilitys) do
			arg_8_0.weight = arg_8_0.weight + iter_8_1[3]
		end

		arg_8_0.list:StartScroll(#arg_8_0.probabilitys)
	else
		arg_8_0.list:StartScroll(0)
	end
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.list:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.probabilitys[arg_11_1]

	arg_11_2:SetData(var_11_0, arg_11_0.probabilitys, arg_11_0.weight)
end

return var_0_0
