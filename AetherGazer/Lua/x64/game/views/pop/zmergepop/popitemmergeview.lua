local var_0_0 = class("PopItemMergeView", PopItemSourceView)

function var_0_0.AddListeners(arg_1_0)
	var_0_0.super.AddListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.mergeBtn_, nil, function()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[arg_1_0:GetItemID()].compose_id
		})
	end)
	arg_1_0:AddBtnListener(arg_1_0.decomposeBtn_, nil, function()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[arg_1_0:GetItemID()].decompose_id
		})
	end)
end

function var_0_0.OnEnter(arg_4_0)
	var_0_0.super.OnEnter(arg_4_0)

	arg_4_0.equipInfo_ = arg_4_0.params_.equip_info or {}
end

function var_0_0.CustomInitUI(arg_5_0)
	var_0_0.super.CustomInitUI(arg_5_0)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.super.OnEnter(arg_6_0)
	arg_6_0:RefreshBtn()
end

function var_0_0.RefreshBtn(arg_7_0)
	local var_7_0 = ItemCfg[arg_7_0:GetItemID()]

	SetActive(arg_7_0.decomposeBtn_.gameObject, var_7_0.decompose_id ~= 0 and ItemExchangeCfg[var_7_0.decompose_id] ~= nil)
	SetActive(arg_7_0.mergeBtn_.gameObject, var_7_0.compose_id ~= 0 and ItemExchangeCfg[var_7_0.compose_id] ~= nil)
end

function var_0_0.RefreshItem(arg_8_0)
	var_0_0.super.RefreshItem(arg_8_0)

	local var_8_0 = ItemTools.getItemNum(arg_8_0:GetItemID())

	arg_8_0.cntText_.text = string.format("x%d", NumberTools.RetractNumberForWindBar(var_8_0))
end

return var_0_0
