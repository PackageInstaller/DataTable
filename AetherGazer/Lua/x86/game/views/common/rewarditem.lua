local var_0_0 = class("RewardItem", ReduxView)
local var_0_1 = import("game.tools.ItemTools")

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_3 then
		arg_1_0.commonItem_ = manager.commonItemPool:Get(arg_1_2)
		arg_1_0.gameObject_ = arg_1_0.commonItem_.gameObject_
		arg_1_0.transform_ = arg_1_0.gameObject_.transform
	else
		arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
		arg_1_0.transform_ = arg_1_0.gameObject_.transform
		arg_1_0.commonItem_ = CommonItem.New(arg_1_0.gameObject_)
	end

	arg_1_0.fromPool_ = arg_1_3

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:RemoveListeners()

	if arg_3_0.fromPool_ then
		arg_3_0.commonItem_.mainAni_.speed = 1

		manager.commonItemPool:Release(arg_3_0.commonItem_)
	else
		arg_3_0.commonItem_:Dispose()
		Object.Destroy(arg_3_0.gameObject_)

		arg_3_0.gameObject_ = nil
	end

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.InitUI(arg_4_0)
	return
end

function var_0_0.AddListeners(arg_5_0)
	return
end

function var_0_0.RemoveListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	local var_7_0 = rewardToItemTemplate(formatReward(arg_7_1))

	arg_7_0.commonItem_:RefreshData(var_7_0)
	arg_7_0.commonItem_:RegistCallBack(function(arg_8_0)
		ShowPopItem(POP_ITEM, arg_8_0)
		OperationRecorder.Record(arg_7_0.class.__cname, "open_pop_item")
	end)
	arg_7_0.commonItem_:SetSelectType("equip")
	SetActive(arg_7_0.gameObject_, true)
end

function var_0_0.UpdateCommonItemAni(arg_9_0)
	arg_9_0.commonItem_:UpdateAnimator()
end

function var_0_0.Show(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.ShowSelect(arg_11_0, arg_11_1)
	arg_11_0.commonItem_:ShowSelect(arg_11_1 and 1 or 0)
end

return var_0_0
