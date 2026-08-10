local var_0_0 = class("ReserveCameraGroup")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.cameraType = arg_1_2

	arg_1_0:InitCameraList()
end

function var_0_0.InitCameraList(arg_2_0)
	arg_2_0.virtualCameraDic = {}
	arg_2_0.virtualCameraDefaultFovDic = {}

	local var_2_0 = arg_2_0.transform:GetComponentsInChildren(typeof(Cinemachine.CinemachineVirtualCamera), true):ToTable()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = iter_2_1.name
		local var_2_2 = ReserveCameraConst.VIRTUAL_CAMERA[var_2_1]

		arg_2_0.virtualCameraDic[var_2_2] = iter_2_1
		arg_2_0.virtualCameraDefaultFovDic[var_2_2] = LuaForUtil.GetCinemachineVirtualCameraFOV(iter_2_1)
	end
end

function var_0_0.SwitchCamera(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:CloseCamera(arg_3_0.curCameraID)

	arg_3_0.curCameraID = arg_3_1

	arg_3_0:SetCameraFOV()
	SetActive(arg_3_0.virtualCameraDic[arg_3_0.curCameraID].gameObject, true)

	return arg_3_0.virtualCameraDic[arg_3_0.curCameraID].name
end

function var_0_0.SetCameraFOV(arg_4_0)
	local var_4_0 = manager.reserveCamera:CulculateRuntimeCameraFov(arg_4_0.virtualCameraDefaultFovDic[arg_4_0.curCameraID])

	LuaForUtil.SetCinemachineVirtualCameraFOV(arg_4_0.virtualCameraDic[arg_4_0.curCameraID], var_4_0)
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	if not arg_5_1 and arg_5_0.curCameraID then
		arg_5_0:CloseCamera(arg_5_0.curCameraID)

		arg_5_0.curCameraID = nil
	end

	SetActive(arg_5_0.gameObject, arg_5_1)
end

function var_0_0.CloseCamera(arg_6_0, arg_6_1)
	if arg_6_1 and not isNil(arg_6_0.virtualCameraDic[arg_6_1]) then
		SetActive(arg_6_0.virtualCameraDic[arg_6_1].gameObject, false)
	end
end

return var_0_0
