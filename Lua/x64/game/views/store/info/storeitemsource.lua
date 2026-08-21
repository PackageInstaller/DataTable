local var_0_0 = class("StoreItemSource", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = arg_1_0.accessbtnControllerexcollection_:GetController("btnState")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		JumpTools.JumpToPage2(arg_3_0.sourceData_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.sourceData_ = arg_5_1

	if JumpTools.GetLinkIsLocked(arg_5_1) then
		arg_5_0.stateController_:SetSelectedState("locked")
	else
		arg_5_0.stateController_:SetSelectedState("unlocked")
	end

	arg_5_0.nameText_.text, arg_5_0.frontText_.text = JumpTools.GetName(arg_5_1)
end

return var_0_0
