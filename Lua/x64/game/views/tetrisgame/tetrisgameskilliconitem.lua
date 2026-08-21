local var_0_0 = class("TetrisGameSkillIconItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	if arg_3_0.controller_ then
		arg_3_0.stateController = arg_3_0.controller_:GetController("state")
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.skillID)
		end
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.skillID = arg_6_1
	arg_6_0.icon.sprite = TetrisGameTools:GetSkillIcon(arg_6_1)

	arg_6_0:RefreshCountShow()
end

function var_0_0.RefreshCountShow(arg_7_0)
	if arg_7_0.controller_ then
		local var_7_0 = TetrisGameRunTimeManager:GetSkillCD(arg_7_0.skillID)

		if var_7_0 then
			arg_7_0.numTxt_.text = var_7_0

			arg_7_0.stateController:SetSelectedState("show")
		else
			arg_7_0.stateController:SetSelectedState("hide")
		end
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.RegisterClickFunc(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.clickFunc = arg_9_1
	end
end

return var_0_0
