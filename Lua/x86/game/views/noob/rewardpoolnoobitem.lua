local var_0_0 = import("game.views.common.RewardPoolItem")
local var_0_1 = class("RewardPoolNoobItem", var_0_0)

function var_0_1.GetParentItemPath(arg_1_0)
	return "UI/Activity/NewbieCommonItem"
end

function var_0_1.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	local var_2_0

	if arg_2_1 == nil then
		var_2_0 = Asset.Load(arg_2_0:GetParentItemPath())
	else
		var_2_0 = arg_2_1
	end

	arg_2_0.parentGo_ = Object.Instantiate(var_2_0, arg_2_2.transform)

	arg_2_0:BindCfgUI(arg_2_0.parentGo_)
	var_0_1.super.OnCtor(arg_2_0, arg_2_0.parentGo_, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
end

function var_0_1.SetParent(arg_3_0)
	arg_3_0.commonItemGo_.transform:SetParent(arg_3_0.parentGo_.transform)
end

function var_0_1.SetData(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super.SetData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:RefreshText(arg_4_1.num)
end

function var_0_1.RefreshText(arg_5_0, arg_5_1)
	arg_5_0:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	arg_5_0.commonItem_:HideNum()

	arg_5_0.cntText_.text = arg_5_1
end

function var_0_1.Dispose(arg_6_0)
	arg_6_0.commonItem_:ResetTransform()
	var_0_1.super.Dispose(arg_6_0)
	Object.Destroy(arg_6_0.parentGo_)

	arg_6_0.parentGo_ = nil
end

function var_0_1.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.parentGo_, arg_7_1)
	var_0_1.super.Show(arg_7_0, arg_7_1)
end

function var_0_1.SetTextColor(arg_8_0, arg_8_1)
	arg_8_0.cntText_.color = arg_8_1
end

return var_0_1
