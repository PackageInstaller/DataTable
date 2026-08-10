local var_0_0 = class("ActivityNewServerSwitchItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.index_)
		end
	end)
end

function var_0_0.SetClickCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickHandler_ = arg_6_1
end

function var_0_0.RefreshSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(tostring(arg_7_0.index_ == arg_7_1))
end

return var_0_0
