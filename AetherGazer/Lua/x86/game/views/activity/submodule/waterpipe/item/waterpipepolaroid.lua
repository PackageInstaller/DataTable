local var_0_0 = class("WaterPipePolaroid", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController = arg_2_0.controllerexcollection_:GetController("state")
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	arg_3_0.normalImg_.sprite = WaterPipeData:GetPipePolaroidImg(arg_3_1, false)
	arg_3_0.finishImg_.sprite = WaterPipeData:GetPipePolaroidImg(arg_3_1, true)

	if WaterPipeData:GetStageInfoByStageID(arg_3_1) then
		arg_3_0.stateController:SetSelectedState("finish")
	else
		arg_3_0.stateController:SetSelectedState("normal")
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
