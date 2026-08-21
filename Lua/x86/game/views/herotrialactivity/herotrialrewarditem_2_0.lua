RewardPoolItem = import("game.views.common.RewardPoolItem")

local var_0_0 = class("HeroTrialRewardItem_2_0", RewardPoolItem)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.parentGo_ = Object.Instantiate(arg_1_2, arg_1_1.transform, arg_1_4)

	arg_1_0:BindCfgUI(arg_1_0.parentGo_)
	var_0_0.super.OnCtor(arg_1_0, arg_1_1, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.receivedMarkGo_.transform:SetAsLastSibling()
end

function var_0_0.SetParent(arg_2_0)
	arg_2_0.commonItemGo_.transform:SetParent(arg_2_0.parentGo_.transform)
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:RefreshText(arg_3_1.num)
end

function var_0_0.RefreshText(arg_4_0, arg_4_1)
	arg_4_0:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	arg_4_0.commonItem_:HideNum()

	arg_4_0.cntText_.text = arg_4_1
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.commonItem_:ResetTransform()
	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.parentGo_)

	arg_5_0.parentGo_ = nil
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.parentGo_, arg_6_1)
	var_0_0.super.Show(arg_6_0, arg_6_1)
end

function var_0_0.RefreshReceive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.receivedMarkGo_, arg_7_1)
end

return var_0_0
