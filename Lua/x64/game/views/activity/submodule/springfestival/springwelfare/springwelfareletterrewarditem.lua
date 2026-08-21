local var_0_0 = class("SpringWelfareLetterRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()

	arg_2_0.id_ = 0
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.commonItemGo_)
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.onClickHandler_ then
			arg_4_0.onClickHandler_(arg_4_0)
		end
	end)
	arg_4_0.commonItem_:RegistCallBack(function(arg_6_0)
		if arg_4_0.onClickHandler_ then
			arg_4_0.onClickHandler_(arg_4_0)
		end
	end)
end

function var_0_0.SetClickHandler(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.onClickHandler_ = arg_7_1
	end
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.commonItem_ then
		arg_10_0.commonItem_:Dispose()

		arg_10_0.commonItem_ = nil
	end

	arg_10_0.super.Dispose(arg_10_0)
end

function var_0_0.SetData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.itemID_ = arg_11_1
	arg_11_0.num_ = arg_11_2
	arg_11_0.acquired_ = arg_11_3

	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.stateController_:SetSelectedState(arg_12_0.acquired_ and "acquired" or "normal")
	arg_12_0:RefreshItemUI()
end

function var_0_0.RefreshItemUI(arg_13_0)
	if arg_13_0.itemID_ == 0 then
		SetActive(arg_13_0.commonItemGo_, false)

		return
	end

	arg_13_0.commonItem_:RefreshData({
		id = arg_13_0.itemID_,
		number = arg_13_0.num_
	})
	SetActive(arg_13_0.commonItemGo_, true)
end

return var_0_0
