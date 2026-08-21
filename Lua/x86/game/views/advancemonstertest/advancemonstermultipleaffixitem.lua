local var_0_0 = import("game.views.osiris.raceTrial.CustomBox")
local var_0_1 = class("AdvanceMonsterMultipleAffixItem", var_0_0)

function var_0_1.IndexItem(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0.customList_[arg_1_1]
	local var_1_1 = table.indexof(arg_1_0.customSelectList_, var_1_0)

	arg_1_2:RefreshUI(arg_1_0.customList_[arg_1_1], var_1_1)
	arg_1_2:RegisterClickListener(arg_1_0.clickFunc_)
end

function var_0_1.RefreshUI(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.uilistTrs_:GetComponent("ScrollRectEx")

	arg_2_0.customList_ = arg_2_1
	arg_2_0.customSelectList_ = arg_2_2
	var_2_0.enabled = true

	arg_2_0.scrollHelper_:SetAppearType(0)

	local var_2_1 = #arg_2_0.customList_

	arg_2_0.scrollHelper_:StartScroll(var_2_1)

	var_2_0.enabled = false

	local var_2_2 = math.floor(arg_2_0.uilistTrs_.rect.width / 123)
	local var_2_3 = math.ceil(var_2_1 / var_2_2)
	local var_2_4 = 166

	arg_2_0.uilistTrs_.sizeDelta = Vector2(arg_2_0.uilistTrs_.sizeDelta.x, var_2_3 * var_2_4)
	arg_2_0.transform_.sizeDelta = Vector2(arg_2_0.transform_.sizeDelta.x, var_2_3 * var_2_4 + 20)
	arg_2_0.bg01Trs_.sizeDelta = Vector2(arg_2_0.bg01Trs_.sizeDelta.x, var_2_3 * var_2_4 + 10)
end

return var_0_1
