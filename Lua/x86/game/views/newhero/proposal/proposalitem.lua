local var_0_0 = class("EquipProposalItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = arg_2_0.proposalCon_:GetController("select")
	arg_2_0.nameController_ = arg_2_0.proposalCon_:GetController("name")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener("", nil, function()
		arg_3_0.func()
	end)
	arg_3_0:AddBtnListener(arg_3_0.btnChangeName_, nil, function()
		arg_3_0.changeNameFunc()
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.label1Text_.text = GetI18NText(arg_6_1.proposal_name)
	arg_6_0.label2Text_.text = GetI18NText(arg_6_1.proposal_name)
end

function var_0_0.ShowSelect(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "select" or "unselect")
	arg_7_0.nameController_:SetSelectedState(arg_7_1 and "change" or "name")
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.func = arg_8_1
	arg_8_0.changeNameFunc = arg_8_2
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
