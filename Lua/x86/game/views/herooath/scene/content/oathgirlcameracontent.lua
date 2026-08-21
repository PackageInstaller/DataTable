local var_0_0 = class("OathGirlCameraContent", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddTouchHelper()
end

function var_0_0.AddTouchHelper(arg_3_0)
	arg_3_0.mutiTouchHelper_ = arg_3_0.gameObject_:GetComponent("MutiTouchHelper")

	function arg_3_0.mutiTouchHelper_.OnIdle()
		arg_3_0:TouchHelpIdle()
	end

	function arg_3_0.mutiTouchHelper_.OnSingleDrag(arg_5_0, arg_5_1)
		arg_3_0:TouchHelpSingleDrag(arg_5_0, arg_5_1)
	end

	function arg_3_0.mutiTouchHelper_.OnMutiDrag(arg_6_0)
		arg_3_0:TouchHelpMutiDrag(arg_6_0)
	end
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.LoadModel(arg_8_0, arg_8_1)
	arg_8_0.model = arg_8_1

	arg_8_0:LoadCamera()
end

function var_0_0.LoadCamera(arg_9_0)
	arg_9_0.cameraManager_ = arg_9_0.model.transform:GetComponentInChildren(typeof(CharacterCameraManager))

	arg_9_0:InitCamera()
	arg_9_0:UpdateCameraParams()
end

function var_0_0.InitCamera(arg_10_0)
	arg_10_0.cameraManager_.touchHelper = arg_10_0.mutiTouchHelper_
end

function var_0_0.UpdateCameraParams(arg_11_0)
	if not arg_11_0.cameraManager_ then
		return
	end

	arg_11_0.cameraManager_:SetCameraParams(arg_11_0:GetViewDirect())
	arg_11_0:SetSelfCamera(0)
end

function var_0_0.GetViewDirect(arg_12_0)
	return PosterGirlConst.ViewDirect.center
end

function var_0_0.SetSelfCamera(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == -1 then
		arg_13_0.cameraManager_:RemoveActiveCamera()
	else
		arg_13_0.cameraManager_:SetActiveCamera(arg_13_1, arg_13_2 or false)
	end

	arg_13_0:ResetCameraPos()
end

function var_0_0.ResetCameraPos(arg_14_0)
	arg_14_0.cameraManager_:ResetCameraDefaultCfg()
end

function var_0_0.TouchHelpIdle(arg_15_0)
	arg_15_0.cameraManager_:TweenToDefaultCameraPos()
end

function var_0_0.TouchHelpSingleDrag(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.cameraManager_:RotateCamera(arg_16_1, arg_16_2)
end

function var_0_0.TouchHelpMutiDrag(arg_17_0, arg_17_1)
	arg_17_0:DefaultZoomToCameraImpl(arg_17_1, 1, 0)
end

function var_0_0.DefaultZoomToCameraImpl(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = nullable(GameSetting.delta_to_zoom, "value", 1) or 10

	if var_18_0 < arg_18_1 then
		arg_18_0.cameraManager_:SetActiveCamera(arg_18_2)
	elseif arg_18_1 < -1 * var_18_0 then
		arg_18_0.cameraManager_:SetActiveCamera(arg_18_3)
	end
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0.model = nil
	arg_19_0.mutiTouchHelper_ = nil
	arg_19_0.cameraManager_ = nil

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
