local var_0_0 = class("BilliardGameQuestModule", ReduxView)
local var_0_1 = {
	[1] = "消灭怪物",
	[2] = "坚持回合"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.lookController = arg_2_0.mainControllerEx_:GetController("look")
	arg_2_0.completeController = arg_2_0.mainControllerEx_:GetController("complete")

	arg_2_0.lookController:SetSelectedIndex(1)
	arg_2_0.completeController:SetSelectedIndex(0)
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.lookBtn_, nil, function()
		if arg_3_0.lookController:GetSelectedIndex() == 1 then
			return
		end

		arg_3_0.lookController:SetSelectedIndex(1)
	end)
	arg_3_0:AddBtnListener(arg_3_0.closeBtn_, nil, function()
		if arg_3_0.lookController:GetSelectedIndex() == 0 then
			return
		end

		arg_3_0.lookController:SetSelectedIndex(0)
	end)
end

function var_0_0.Refresh(arg_6_0, arg_6_1)
	return
end

function var_0_0.OnDataChange(arg_7_0)
	return
end

function var_0_0.Finish(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.lookController:SetSelectedIndex(1)
		arg_8_0.completeController:SetSelectedIndex(1)
	else
		arg_8_0.lookController:SetSelectedIndex(0)
		arg_8_0.completeController:SetSelectedIndex(0)
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
