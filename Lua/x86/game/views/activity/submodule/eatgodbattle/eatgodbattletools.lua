local var_0_0 = {}
local var_0_1 = {
	Color.New(0.8666666666666667, 0.9647058823529412, 1, 1),
	Color.New(0.792156862745098, 0.7764705882352941, 0.8509803921568627, 1),
	(Color.New(0.6235294117647059, 0.615686274509804, 0.6705882352941176, 1))
}
local var_0_2 = {
	0,
	0.4841,
	0.44
}
local var_0_3 = {
	Color.New(0.8666666666666667, 0.9647058823529412, 1, 1) * math.pow(2, var_0_2[1]),
	Color.New(0.6980392156862745, 0.6862745098039216, 0.7490196078431373, 1) * math.pow(2, var_0_2[2]),
	Color.New(0.6549019607843137, 0.6313725490196078, 0.7490196078431373, 1) * math.pow(2, var_0_2[3])
}

function var_0_0.SetBackGroundStatus(arg_1_0, arg_1_1)
	if var_0_0.backGround == nil then
		var_0_0.backGround = GameObject.Instantiate(Asset.Load("ModelUI/EatGod_UI/I19"))

		local var_1_0 = var_0_0.backGround.transform

		var_1_0.localPosition = WeekBossConst.BackGroundTransform.position
		var_1_0.localEulerAngles = WeekBossConst.BackGroundTransform.rotation
		var_1_0.localScale = WeekBossConst.BackGroundTransform.scale
		var_0_0.backMaterials = var_0_0.backMaterials or var_1_0:Find("I19_bg01"):GetComponent(typeof(MeshRenderer)).materials
		var_0_0.pillarMaterials = var_0_0.pillarMaterials or var_1_0:Find("I19_bg02"):GetComponent(typeof(MeshRenderer)).materials
		var_0_0.backController = var_0_0.backController or var_1_0:GetComponent("ControllerExCollection"):GetController("pillar")
	end

	var_0_0.backMaterials[0].color = var_0_1[arg_1_1]
	var_0_0.pillarMaterials[0].color = var_0_3[arg_1_1]

	var_0_0.backController:SetSelectedState(arg_1_0)
end

function var_0_0.UnloadBackScene()
	if var_0_0.backGround then
		GameObject.Destroy(var_0_0.backGround)

		var_0_0.backGround = nil
	end

	var_0_0.backMaterials = nil
	var_0_0.pillarMaterials = nil
	var_0_0.backController = nil
end

function var_0_0.GetVirtualCameras()
	if var_0_0.trackGo == nil or var_0_0.virtualCameraList == nil then
		var_0_0.trackGo = Object.Instantiate(Asset.Load("UI/HeroCamera/I19_Virtual_Camera.prefab"))

		local var_3_0 = var_0_0.trackGo.transform:GetComponentsInChildren(typeof(Cinemachine.CinemachineVirtualCamera), true):ToTable()

		var_0_0.virtualCameraList = {}

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			table.insert(var_0_0.virtualCameraList, iter_3_1)
		end
	end

	return var_0_0.trackGo, var_0_0.virtualCameraList
end

function var_0_0.ResetCamera()
	if var_0_0.virtualCameraList then
		var_0_0.virtualCameraList[1].Priority = -100
		var_0_0.virtualCameraList[2].Priority = -100
	end

	local var_4_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")

	if var_4_0 then
		var_4_0.m_CustomBlends = nil
		var_4_0.enabled = false
	end

	manager.ui:ResetMainCamera()

	if var_0_0.trackGo then
		GameObject.Destroy(var_0_0.trackGo)

		var_0_0.trackGo = nil
	end

	var_0_0.virtualCameraList = nil
end

return var_0_0
