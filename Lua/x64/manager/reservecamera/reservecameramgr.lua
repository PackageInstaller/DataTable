local var_0_0 = class("ReserveCameraMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.cameraTemplateDic = {}
	arg_2_0.cameraSwitchEndHandler = handler(arg_2_0, arg_2_0.OnCameraSwitchEnd)
	arg_2_0.switchingCameraName = nil
	arg_2_0.setCmaeraFovHandler = handler(arg_2_0, arg_2_0.SetCameraFOV)

	manager.notify:RegistListener("FoldStatusCallback", arg_2_0.setCmaeraFovHandler)
end

function var_0_0.Dispose(arg_3_0)
	manager.reserveCamera:SwitchCamera(ReserveCameraConst.CAMERA_TYPE.null)

	arg_3_0.curCameraType = nil

	for iter_3_0, iter_3_1 in pairs(arg_3_0.cameraTemplateDic) do
		iter_3_1:Dispose()

		local var_3_0 = ReserveCameraConst.CAMERA_TEMPLATE_PREFAB[iter_3_0]

		Asset.Unload(var_3_0)
	end

	arg_3_0.cameraTemplateDic = {}
	arg_3_0.cinemachineBrain = nil

	manager.notify:RemoveListener("FoldStatusCallback", arg_3_0.setCmaeraFovHandler)

	arg_3_0.setCmaeraFovHandler = nil
end

function var_0_0.SwitchCamera(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_1 then
		return
	end

	arg_4_0:InitCinemachineBrain()

	if arg_4_1 == ReserveCameraConst.CAMERA_TYPE.null then
		arg_4_0:CloseCameraBrain()
		arg_4_0:ResetCinemachineBlend()
		arg_4_0:ResetCamera()
	else
		arg_4_0:OpenCameraBrain()
		arg_4_0:InitCinemachineBlend()
		arg_4_0:SwitchTargetCamera(arg_4_1, arg_4_2, arg_4_3)
		arg_4_0:SwitchCameraEnd()
	end
end

function var_0_0.InitCinemachineBrain(arg_5_0)
	if isNil(arg_5_0.cinemachineBrain) then
		arg_5_0.cinemachineBrain = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	end
end

function var_0_0.OpenCameraBrain(arg_6_0)
	arg_6_0.brainOpended = true

	if isNil(arg_6_0.transitionCheker) then
		arg_6_0.transitionCheker = GameObjectTools.GetOrAddComponent(arg_6_0.cinemachineBrain.gameObject, typeof(CinemachineTransitionCheker))

		arg_6_0.transitionCheker:SetTransitionEndCallback(arg_6_0.cameraSwitchEndHandler)
	end

	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function var_0_0.CloseCameraBrain(arg_7_0)
	if arg_7_0.brainOpended then
		arg_7_0.brainOpended = false

		manager.ui:SetMainCameraCom("CinemachineBrain", false)
		Object.DestroyImmediate(arg_7_0.transitionCheker, true)

		arg_7_0.transitionCheker = nil
	end
end

function var_0_0.ResetCamera(arg_8_0)
	arg_8_0:CloseCameraTemplate(arg_8_0.curCameraType)

	arg_8_0.curCameraType = nil
end

function var_0_0.InitCinemachineBlend(arg_9_0)
	if not isNil(arg_9_0.cinemachineBrain) and not arg_9_0.blendInited then
		arg_9_0.blendInited = true
		arg_9_0.cinemachineBrain.m_CustomBlends = Asset.Load(ReserveCameraConst.CUSTOM_BLEND_ASSET_PATH)
	end
end

function var_0_0.ResetCinemachineBlend(arg_10_0)
	if not isNil(arg_10_0.cinemachineBrain) and arg_10_0.blendInited then
		arg_10_0.blendInited = false

		Asset.Unload(ReserveCameraConst.CUSTOM_BLEND_ASSET_PATH)

		arg_10_0.cinemachineBrain.m_CustomBlends = nil
	end
end

function var_0_0.SwitchTargetCamera(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0:CloseCameraTemplate(arg_11_0.curCameraType)
	arg_11_0:CheckLoadCameraTemplate(arg_11_1)

	arg_11_0.isSwitchingCamera = true
	arg_11_0.curCameraType = arg_11_1

	arg_11_0.cameraTemplateDic[arg_11_0.curCameraType]:SetActive(true)

	arg_11_0.switchingCameraName = arg_11_0.cameraTemplateDic[arg_11_1]:SwitchCamera(arg_11_2, arg_11_3)
end

function var_0_0.CheckLoadCameraTemplate(arg_12_0, arg_12_1)
	if not arg_12_0.cameraTemplateDic[arg_12_1] then
		arg_12_0:LoadCameraTemplate(arg_12_1)
	end
end

function var_0_0.LoadCameraTemplate(arg_13_0, arg_13_1)
	local var_13_0 = ReserveCameraConst.CAMERA_TEMPLATE_PREFAB[arg_13_1]
	local var_13_1 = Object.Instantiate(Asset.Load(var_13_0))
	local var_13_2 = ReserveCameraConst.CAMERA_TEMPLATE_CLASS_NAME[arg_13_1]
	local var_13_3 = _G[var_13_2].New(var_13_1, arg_13_1)

	arg_13_0.cameraTemplateDic[arg_13_1] = var_13_3
end

function var_0_0.CloseCameraTemplate(arg_14_0, arg_14_1)
	if arg_14_1 and arg_14_0.cameraTemplateDic[arg_14_1] then
		arg_14_0.cameraTemplateDic[arg_14_1]:SetActive(false)
	end
end

function var_0_0.SwitchCameraEnd(arg_15_0)
	FrameTimer.New(function()
		if arg_15_0.cinemachineBrain.IsBlending then
			return
		end

		if arg_15_0.isSwitchingCamera then
			arg_15_0:OnCameraSwitchEnd(arg_15_0.switchingCameraName)
		end
	end, 2, 1):Start()
end

function var_0_0.OnCameraSwitchEnd(arg_17_0, arg_17_1)
	if arg_17_0.isSwitchingCamera and arg_17_0.switchingCameraName == arg_17_1 then
		arg_17_0.isSwitchingCamera = false

		manager.notify:Invoke(RESERVE_CAMERA_SWITCH_END)
	end
end

function var_0_0.CulculateRuntimeCameraFov(arg_18_0, arg_18_1)
	local var_18_0 = SectionSelectHeroConst.STANDARD_SCREEN_WIDTH / SectionSelectHeroConst.STANDARD_SCREEN_HEIGHT / (_G.SCREEN_WIDTH / _G.SCREEN_HEIGHT)

	if var_18_0 > 1 then
		arg_18_0.runtimeCameraFov = arg_18_1 * var_18_0
	else
		arg_18_0.runtimeCameraFov = arg_18_1
	end

	return arg_18_0.runtimeCameraFov
end

function var_0_0.SetCameraFOV(arg_19_0)
	if arg_19_0.curCameraType and arg_19_0.curCameraType ~= ReserveCameraConst.CAMERA_TYPE.null and arg_19_0.cameraTemplateDic[arg_19_0.curCameraType] then
		arg_19_0.cameraTemplateDic[arg_19_0.curCameraType]:SetCameraFOV()
	end
end

return var_0_0
