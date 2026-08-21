local var_0_0 = class("ValentineGameSPRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.commonGo_)
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.data_ = formatReward(arg_5_1)

	local var_5_0 = rewardToItemTemplate(arg_5_1)

	arg_5_0.commonItem_:RefreshData(var_5_0)
	arg_5_0.commonItem_:RegistCallBack(function(arg_6_0)
		ShowPopItem(POP_ITEM, arg_6_0)
	end)
	arg_5_0:RefreshText()
	SetActive(arg_5_0.gameObject_, true)
end

function var_0_0.RefreshText(arg_7_0)
	arg_7_0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	arg_7_0.commonItem_:HideNum()

	arg_7_0.cntText_.text = GetI18NText(arg_7_0.data_.num)
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0.commonItem_:OnExit()
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0.commonItem_:Dispose()
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
