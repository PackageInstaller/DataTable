local ReserveCameraTemplate = class("ReserveCameraTemplate")

function ReserveCameraTemplate:Ctor(arg_1_1, arg_1_2)
	self.gameObject = arg_1_1
	self.transform = arg_1_1.transform
	self.cameraType = arg_1_2

	self:InitCameraGroup()
end

function ReserveCameraTemplate:InitCameraGroup()
	self.cameraGroupList = {}

	for iter_2_0 = 0, self.transform.childCount - 1 do
		local var_2_0 = self.transform:GetChild(iter_2_0).gameObject

		SetActive(var_2_0, false)
		table.insert(self.cameraGroupList, (ReserveCameraGroup.New(var_2_0, self.cameraType)))
	end
end

function ReserveCameraTemplate:SwitchCamera(arg_3_1, arg_3_2)
	self:CloseCameraGroup(self.curGroupID)

	self.curGroupID = self:GetTargetCameraGroupID(arg_3_1, arg_3_2)

	self.cameraGroupList[self.curGroupID]:SetActive(true)

	return self.cameraGroupList[self.curGroupID]:SwitchCamera(arg_3_1, arg_3_2)
end

function ReserveCameraTemplate:GetTargetCameraGroupID(arg_4_1, arg_4_2)
	return 1
end

function ReserveCameraTemplate:SetCameraFOV()
	if self.curGroupID and self.cameraGroupList[self.curGroupID] then
		self.cameraGroupList[self.curGroupID]:SetCameraFOV()
	end
end

function ReserveCameraTemplate:SetActive(arg_6_1)
	if not arg_6_1 and self.curGroupID then
		self:CloseCameraGroup(self.curGroupID)

		self.curGroupID = nil
	end

	SetActive(self.gameObject, arg_6_1)
end

function ReserveCameraTemplate:CloseCameraGroup(arg_7_1)
	if arg_7_1 and self.cameraGroupList[arg_7_1] then
		self.cameraGroupList[arg_7_1]:SetActive(false)
	end
end

function ReserveCameraTemplate:Dispose()
	self.cameraGroupList = nil

	Object.Destroy(self.gameObject)

	self.gameObject = nil
	self.transform = nil
end

return ReserveCameraTemplate
