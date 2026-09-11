local ReserveCameraGroup = class("ReserveCameraGroup")

function ReserveCameraGroup:Ctor(arg_1_1, arg_1_2)
	self.gameObject = arg_1_1
	self.transform = arg_1_1.transform
	self.cameraType = arg_1_2

	self:InitCameraList()
end

function ReserveCameraGroup:InitCameraList()
	self.virtualCameraDic = {}
	self.virtualCameraDefaultFovDic = {}

	for iter_2_0, iter_2_1 in ipairs((self.transform:GetComponentsInChildren(typeof(Cinemachine.CinemachineVirtualCamera), true):ToTable())) do
		self.virtualCameraDic[ReserveCameraConst.VIRTUAL_CAMERA[iter_2_1.name]] = iter_2_1
		self.virtualCameraDefaultFovDic[ReserveCameraConst.VIRTUAL_CAMERA[iter_2_1.name]] = LuaForUtil.GetCinemachineVirtualCameraFOV(iter_2_1)
	end
end

function ReserveCameraGroup:SwitchCamera(arg_3_1, arg_3_2)
	self:CloseCamera(self.curCameraID)

	self.curCameraID = arg_3_1

	self:SetCameraFOV()
	SetActive(self.virtualCameraDic[self.curCameraID].gameObject, true)

	return self.virtualCameraDic[self.curCameraID].name
end

function ReserveCameraGroup:SetCameraFOV()
	LuaForUtil.SetCinemachineVirtualCameraFOV(self.virtualCameraDic[self.curCameraID], (manager.reserveCamera:CulculateRuntimeCameraFov(self.virtualCameraDefaultFovDic[self.curCameraID])))
end

function ReserveCameraGroup:SetActive(arg_5_1)
	if not arg_5_1 and self.curCameraID then
		self:CloseCamera(self.curCameraID)

		self.curCameraID = nil
	end

	SetActive(self.gameObject, arg_5_1)
end

function ReserveCameraGroup:CloseCamera(arg_6_1)
	if arg_6_1 and not isNil(self.virtualCameraDic[arg_6_1]) then
		SetActive(self.virtualCameraDic[arg_6_1].gameObject, false)
	end
end

return ReserveCameraGroup
