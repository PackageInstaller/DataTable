local var_0_0 = class("CaptureResultTaskModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = arg_3_0.completeController_:GetController("default0")
	arg_3_0.isHide = false
end

function var_0_0.RenderItem(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 then
		arg_4_0:Hide(true)

		return
	end

	arg_4_0:Hide(false)

	local var_4_0 = CaptureGameHelper:GetConditionByTask(arg_4_1)

	arg_4_0.taskText_.text = var_4_0.description

	arg_4_0.controller_:SetSelectedState(arg_4_2 and "yes" or "no")
end

function var_0_0.HideLine(arg_5_0)
	SetActive(arg_5_0.lineObj_, false)
end

function var_0_0.Hide(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0.isHide then
		SetActive(arg_6_0.gameObject_, not arg_6_1)
	end
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.controller_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
