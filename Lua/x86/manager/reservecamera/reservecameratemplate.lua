local var_0_0 = class("ReserveCameraTemplate")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.cameraType = arg_1_2

	arg_1_0:InitCameraGroup()
end

function var_0_0.InitCameraGroup(arg_2_0)
	arg_2_0.cameraGroupList = {}

	local var_2_0 = arg_2_0.transform.childCount

	for iter_2_0 = 0, var_2_0 - 1 do
		local var_2_1 = arg_2_0.transform:GetChild(iter_2_0).gameObject

		SetActive(var_2_1, false)

		local var_2_2 = ReserveCameraGroup.New(var_2_1, arg_2_0.cameraType)

		table.insert(arg_2_0.cameraGroupList, var_2_2)
	end
end

function var_0_0.SwitchCamera(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:CloseCameraGroup(arg_3_0.curGroupID)

	arg_3_0.curGroupID = arg_3_0:GetTargetCameraGroupID(arg_3_1, arg_3_2)

	arg_3_0.cameraGroupList[arg_3_0.curGroupID]:SetActive(true)

	return arg_3_0.cameraGroupList[arg_3_0.curGroupID]:SwitchCamera(arg_3_1, arg_3_2)
end

function var_0_0.GetTargetCameraGroupID(arg_4_0, arg_4_1, arg_4_2)
	return 1
end

function var_0_0.SetCameraFOV(arg_5_0)
	if arg_5_0.curGroupID and arg_5_0.cameraGroupList[arg_5_0.curGroupID] then
		arg_5_0.cameraGroupList[arg_5_0.curGroupID]:SetCameraFOV()
	end
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	if not arg_6_1 and arg_6_0.curGroupID then
		arg_6_0:CloseCameraGroup(arg_6_0.curGroupID)

		arg_6_0.curGroupID = nil
	end

	SetActive(arg_6_0.gameObject, arg_6_1)
end

function var_0_0.CloseCameraGroup(arg_7_0, arg_7_1)
	if arg_7_1 and arg_7_0.cameraGroupList[arg_7_1] then
		arg_7_0.cameraGroupList[arg_7_1]:SetActive(false)
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.cameraGroupList = nil

	Object.Destroy(arg_8_0.gameObject)

	arg_8_0.gameObject = nil
	arg_8_0.transform = nil
end

return var_0_0
