local var_0_0 = class("WaterPipeGameEventItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.controllerexcollection_:GetController("state")
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	arg_3_0.eventID = arg_3_1
	arg_3_0.descText_.text = ActivityWaterPipeEventCfg[arg_3_1].event_desc

	arg_3_0:ChangeState(false)
end

function var_0_0.GetEventID(arg_4_0)
	return arg_4_0.eventID
end

function var_0_0.SetOrder(arg_5_0, arg_5_1)
	arg_5_0.order = arg_5_1

	local var_5_0 = WaterPipeData:GetOrderImg(arg_5_1)

	if var_5_0 then
		arg_5_0.indexImg_.sprite = var_5_0
	end
end

function var_0_0.SetSiblingIndex(arg_6_0)
	arg_6_0.gameObject_.transform:SetSiblingIndex(arg_6_0.order - 1)
end

function var_0_0.ChangeState(arg_7_0, arg_7_1)
	arg_7_0.isFinish = arg_7_1

	arg_7_0.stateController_:SetSelectedState(arg_7_1 and "finish" or "normal")
end

function var_0_0.GetSDKStr(arg_8_0)
	if arg_8_0.isFinish then
		return arg_8_0.eventID
	else
		return nil
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
