local ReserveCameraMgr = class("ReserveCameraMgr")

function ReserveCameraMgr:Ctor()
	self:Init()
end

function ReserveCameraMgr:Init()
	self.cameraTemplateDic = {}
	self.cameraSwitchEndHandler = handler(self, self.OnCameraSwitchEnd)
	self.switchingCameraName = nil
	self.setCmaeraFovHandler = handler(self, self.SetCameraFOV)

	manager.notify:RegistListener("FoldStatusCallback", self.setCmaeraFovHandler)
end

function ReserveCameraMgr:Dispose()
	manager.reserveCamera:SwitchCamera(ReserveCameraConst.CAMERA_TYPE.null)

	self.curCameraType = nil

	for iter_3_0, iter_3_1 in pairs(self.cameraTemplateDic) do
		iter_3_1:Dispose()
		Asset.Unload(ReserveCameraConst.CAMERA_TEMPLATE_PREFAB[iter_3_0])
	end

	self.cameraTemplateDic = {}
	self.cinemachineBrain = nil

	manager.notify:RemoveListener("FoldStatusCallback", self.setCmaeraFovHandler)

	self.setCmaeraFovHandler = nil
end

function ReserveCameraMgr:SwitchCamera(arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_1 then
		return
	end

	self:InitCinemachineBrain()

	if arg_4_1 == ReserveCameraConst.CAMERA_TYPE.null then
		self:CloseCameraBrain()
		self:ResetCinemachineBlend()
		self:ResetCamera()
	else
		self:OpenCameraBrain()
		self:InitCinemachineBlend()
		self:SwitchTargetCamera(arg_4_1, arg_4_2, arg_4_3)
		self:SwitchCameraEnd()
	end
end

function ReserveCameraMgr:InitCinemachineBrain()
	if isNil(self.cinemachineBrain) then
		self.cinemachineBrain = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	end
end

function ReserveCameraMgr:OpenCameraBrain()
	self.brainOpended = true

	if isNil(self.transitionCheker) then
		self.transitionCheker = GameObjectTools.GetOrAddComponent(self.cinemachineBrain.gameObject, typeof(CinemachineTransitionCheker))

		self.transitionCheker:SetTransitionEndCallback(self.cameraSwitchEndHandler)
	end

	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function ReserveCameraMgr:CloseCameraBrain()
	if self.brainOpended then
		self.brainOpended = false

		manager.ui:SetMainCameraCom("CinemachineBrain", false)
		Object.DestroyImmediate(self.transitionCheker, true)

		self.transitionCheker = nil
	end
end

function ReserveCameraMgr:ResetCamera()
	self:CloseCameraTemplate(self.curCameraType)

	self.curCameraType = nil
end

function ReserveCameraMgr:InitCinemachineBlend()
	if not isNil(self.cinemachineBrain) and not self.blendInited then
		self.blendInited = true
		self.cinemachineBrain.m_CustomBlends = Asset.Load(ReserveCameraConst.CUSTOM_BLEND_ASSET_PATH)
	end
end

function ReserveCameraMgr:ResetCinemachineBlend()
	if not isNil(self.cinemachineBrain) and self.blendInited then
		self.blendInited = false

		Asset.Unload(ReserveCameraConst.CUSTOM_BLEND_ASSET_PATH)

		self.cinemachineBrain.m_CustomBlends = nil
	end
end

function ReserveCameraMgr:SwitchTargetCamera(arg_11_1, arg_11_2, arg_11_3)
	self:CloseCameraTemplate(self.curCameraType)
	self:CheckLoadCameraTemplate(arg_11_1)

	self.isSwitchingCamera = true
	self.curCameraType = arg_11_1

	self.cameraTemplateDic[self.curCameraType]:SetActive(true)

	self.switchingCameraName = self.cameraTemplateDic[arg_11_1]:SwitchCamera(arg_11_2, arg_11_3)
end

function ReserveCameraMgr:CheckLoadCameraTemplate(arg_12_1)
	if not self.cameraTemplateDic[arg_12_1] then
		self:LoadCameraTemplate(arg_12_1)
	end
end

function ReserveCameraMgr:LoadCameraTemplate(arg_13_1)
	self.cameraTemplateDic[arg_13_1] = _G[ReserveCameraConst.CAMERA_TEMPLATE_CLASS_NAME[arg_13_1]].New(Object.Instantiate(Asset.Load(ReserveCameraConst.CAMERA_TEMPLATE_PREFAB[arg_13_1])), arg_13_1)
end

function ReserveCameraMgr:CloseCameraTemplate(arg_14_1)
	if arg_14_1 and self.cameraTemplateDic[arg_14_1] then
		self.cameraTemplateDic[arg_14_1]:SetActive(false)
	end
end

function ReserveCameraMgr:SwitchCameraEnd()
	FrameTimer.New(function()
		if self.cinemachineBrain.IsBlending then
			return
		end

		if self.isSwitchingCamera then
			self:OnCameraSwitchEnd(self.switchingCameraName)
		end
	end, 2, 1):Start()
end

function ReserveCameraMgr:OnCameraSwitchEnd(arg_17_1)
	if self.isSwitchingCamera and self.switchingCameraName == arg_17_1 then
		self.isSwitchingCamera = false

		manager.notify:Invoke(RESERVE_CAMERA_SWITCH_END)
	end
end

function ReserveCameraMgr:CulculateRuntimeCameraFov(arg_18_1)
	self.runtimeCameraFov = SectionSelectHeroConst.STANDARD_SCREEN_WIDTH / SectionSelectHeroConst.STANDARD_SCREEN_HEIGHT / (_G.SCREEN_WIDTH / _G.SCREEN_HEIGHT) > 1 and arg_18_1 * (SectionSelectHeroConst.STANDARD_SCREEN_WIDTH / SectionSelectHeroConst.STANDARD_SCREEN_HEIGHT / (_G.SCREEN_WIDTH / _G.SCREEN_HEIGHT)) or arg_18_1

	return self.runtimeCameraFov
end

function ReserveCameraMgr:SetCameraFOV()
	if self.curCameraType and self.curCameraType ~= ReserveCameraConst.CAMERA_TYPE.null and self.cameraTemplateDic[self.curCameraType] then
		self.cameraTemplateDic[self.curCameraType]:SetCameraFOV()
	end
end

return ReserveCameraMgr
