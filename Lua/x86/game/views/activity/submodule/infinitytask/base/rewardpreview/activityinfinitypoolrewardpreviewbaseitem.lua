local var_0_0 = class("ActivityInfinityPoolRewardPreviewBaseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
	arg_1_0.rewardItem_ = arg_1_0:GetRewardItem(arg_1_3)

	arg_1_0:SetData(arg_1_3, arg_1_4, arg_1_5)
end

function var_0_0.GetRewardItem(arg_2_0, arg_2_1)
	return RewardPoolItem.New(arg_2_0.gameObject_, arg_2_1)
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.rewardItem_:SetData(arg_3_1)

	if arg_3_0.gameObject_.activeSelf == false then
		arg_3_0:Show(true)
	end

	arg_3_0.textCnt_.text = string.format("%s/%s", arg_3_2, arg_3_3)

	if arg_3_3 <= arg_3_2 then
		arg_3_0.controller_:SetSelectedState("get")
	else
		arg_3_0.controller_:SetSelectedState("normal")
	end
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	arg_5_0.rewardItem_:Dispose()

	arg_5_0.rewardItem_ = nil

	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

return var_0_0
