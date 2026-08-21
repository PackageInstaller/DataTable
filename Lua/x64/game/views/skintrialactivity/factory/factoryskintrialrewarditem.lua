local var_0_0 = class("FactorySkinTrialRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonItem_ = CommonItem.New(arg_2_0.commonItemGo_)
end

function var_0_0.GetCommonItem(arg_3_0)
	return arg_3_0.commonItem_
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.data_ = arg_4_1
	arg_4_0.popType_ = arg_4_2

	arg_4_0.commonItem_:RefreshData(formatReward(arg_4_1))
	arg_4_0.commonItem_:RegistCallBack(function()
		if arg_4_0.clickCallback_ then
			if arg_4_0.clickCallback_() then
				ShowPopItem(arg_4_0.popType_, arg_4_1)
			end
		else
			ShowPopItem(arg_4_0.popType_, arg_4_1)
		end
	end)

	if arg_4_0.receivedControllerList_ == nil then
		arg_4_0.receivedControllerList_ = ControllerUtil.GetController(arg_4_0.commonItem_.transform_, "received")
	end

	if SkinTrialData:IsCompleted(arg_4_3) then
		arg_4_0.receivedControllerList_:SetSelectedState("true")
	else
		arg_4_0.receivedControllerList_:SetSelectedState("false")
	end

	arg_4_0.commonItem_:Show(true)
	arg_4_0:RefreshText()
end

function var_0_0.RefreshText(arg_6_0)
	arg_6_0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	arg_6_0.commonItem_:HideNum()

	arg_6_0.num_.text = arg_6_0.data_[2]
end

return var_0_0
