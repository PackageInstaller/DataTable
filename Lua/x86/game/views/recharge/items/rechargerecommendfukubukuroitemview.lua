local var_0_0 = class("RechargeRecommendFukubukuroItemView", RechargeRecommendBgItemView)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.list = LuaList.New(handler(arg_1_0, arg_1_0.IndexItem), arg_1_0.m_list, CommonItemView)
end

function var_0_0.AddUIListener(arg_2_0)
	var_0_0.super.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(nil, arg_2_0.m_rareBtn, function()
		JumpTools.OpenPageByJump("popFukubukuroProbability", {
			itemId = arg_2_0.itemId
		})
	end)
end

function var_0_0.UpdateView(arg_4_0)
	var_0_0.super.UpdateView(arg_4_0)

	if arg_4_0.cfg_ and arg_4_0.cfg_.params ~= "" then
		arg_4_0.itemId = arg_4_0.cfg_.params[1] or 0
	else
		arg_4_0.itemId = 0
	end

	arg_4_0.items = ItemCfg[arg_4_0.itemId].param

	arg_4_0.list:StartScroll(#arg_4_0.items)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.items[arg_5_1]
	local var_5_1 = clone(ItemTemplateData)

	var_5_1.id = var_5_0[1]
	var_5_1.number = var_5_0[2]

	function var_5_1.clickFun()
		ShowPopItem(POP_ITEM, {
			var_5_1.id
		})
	end

	arg_5_2:SetData(var_5_1)
	arg_5_2:Show(true)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.list:Dispose()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
