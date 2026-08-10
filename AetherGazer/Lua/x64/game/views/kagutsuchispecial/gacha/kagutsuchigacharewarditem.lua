local var_0_0 = class("KagutsuchiGachaRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardController_ = ControllerUtil.GetController(arg_3_0.transform_, "reward")
	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.commonItemGo_)
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0.commonItem_:RegistCallBack(function(arg_5_0)
		ShowPopItem(POP_ITEM, {
			arg_4_0.itemID_
		})
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.id_ = arg_7_3
	arg_7_0.poolId_ = arg_7_2
	arg_7_0.activityId_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0, var_8_1 = KagutsuchiGachaData:GetDrawItemReward(arg_8_0.poolId_, arg_8_0.id_)
	local var_8_2 = KagutsuchiGachaData:GetDrawItemRemainCount(arg_8_0.poolId_, arg_8_0.id_)
	local var_8_3 = var_8_2 .. "/" .. KagutsuchiGachaData:GetDrawItemTotalCount(arg_8_0.poolId_, arg_8_0.id_)

	arg_8_0.itemID_ = var_8_0

	arg_8_0.rewardController_:SetSelectedState(var_8_2 > 0 and "have" or "no")

	arg_8_0.itemText_.text = var_8_3

	arg_8_0.commonItem_:RefreshData({
		id = var_8_0,
		number = var_8_1
	})
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.commonItem_:Dispose()

	arg_10_0.commonItem_ = nil

	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
