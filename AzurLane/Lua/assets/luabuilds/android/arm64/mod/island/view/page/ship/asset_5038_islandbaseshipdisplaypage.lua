class = var_0_10000

local var_0_0 = "IslandBaseShipDisplayPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	IslandDisplayShipUnit = var_1
	arg_1_0.displayUnit = var_1.New()
	arg_1_0.gcCounter = 0

	return
end

function var_0_1.Preload(arg_2_0, arg_2_1)
	arg_2_0:PrepareCharacterScene(arg_2_1)

	return
end

function var_0_1.PrepareCharacterScene(arg_3_0, arg_3_1)
	arg_3_0.isLoadCharacterScene = true
	seriesAsync = var_2

	var_2({
		function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.CreateCharacterContainer(var_4_0)

			local var_4_1 = arg_3_0

			var_1.CreateToolContainer(var_4_1)

			local var_4_2 = arg_3_0

			var_1.LoadCharacterScene(var_4_2, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.ModifyCameraMask(var_5_0)

			local var_5_1 = arg_3_0

			var_1.ActivityCharacterCamera(var_5_1)

			local var_5_2 = arg_3_0

			var_1.InitSceneTimeline(var_5_2)
			arg_5_0()

			return
		end
	}, arg_3_1)

	return
end

function var_0_1.CreateCharacterContainer(arg_6_0)
	GameObject = var_1_10001
	arg_6_0.roleContainer = var_1_10001.New("roleContainer").transform
	pg = var_1

	local var_6_0 = var_1.ViewUtils.SetLayer
	local var_6_1 = arg_6_0.roleContainer

	Layer = var_1_10004

	var_6_0(var_6_1, var_1_10004.Character3D)

	return
end

function var_0_1.LoadCharacterScene(arg_7_0, arg_7_1)
	local var_7_0 = "island/scenesres/scenes/character/map_shipmainui_scene"

	SceneOpMgr = var_1_10003

	local var_7_1 = var_1_10003.Inst
	local var_7_2 = var_3.LoadSceneAsyncWithProgress
	local var_7_3 = var_7_0
	local var_7_4 = "map_shipmainui"

	LoadSceneMode = var_1_10008

	var_7_2(var_7_1, var_7_3, var_7_4, var_1_10008.Additive, function(arg_8_0)
		if arg_8_0 == 1 then
			arg_7_1()
		end

		return
	end)

	return
end

function var_0_1.ModifyCameraMask(arg_9_0)
	IslandCameraMgr = var_1_10001

	local var_9_0 = var_1_10001.instance

	IsNil = var_1_10002

	if var_1_10002(var_9_0) then
		CheatTavernCameraMgr = var_2
		var_9_0 = var_2.instance
	end

	arg_9_0.defaultCullingMask = var_9_0._mainCamera.cullingMask
	LuaHelper = var_3

	var_3.SetCamCullingMask(var_2, "Character3D")

	return
end

function var_0_1.ActivityCharacterCamera(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.GetActiveCamName(var_10_0)

	IslandCameraMgr = var_1_10002

	local var_10_2 = var_1_10002.instance

	IsNil = var_10_0

	if var_10_0(var_10_2) then
		CheatTavernCameraMgr = var_3
		var_10_2 = var_3.instance
	end

	local var_10_3 = var_10_2:GetVirtualCamera(var_10_1)

	var_10_3.Follow = arg_10_0.roleContainer
	var_10_3.LookAt = arg_10_0.roleContainer

	var_10_2:ActiveVirtualCamera(var_10_1)

	return
end

function var_0_1.InitSceneTimeline(arg_11_0)
	GameObject = var_1_10001

	if var_1_10001.Find("[sequence]") then
		local var_11_0 = var_1
		local var_11_1 = var_1.GetComponent

		typeof = var_1_10005
		UnityEngine = var_1_10007

		local var_11_2 = var_11_1(var_11_0, var_1_10005(var_1_10007.Playables.PlayableDirector))

		TimelineSupport = var_3

		var_3.DynamicBinding(var_11_2)
		var_11_2:Play()
	end

	return
end

function var_0_1.ClearCharacterScene(arg_12_0, arg_12_1)
	if arg_12_0.isLoadCharacterScene then
		arg_12_0:UnLoadCharacterScene(arg_12_1)
		arg_12_0:ClearCharacterContainer()
		arg_12_0:ClearToolContainer()
		arg_12_0:ResetCameraMask()
		arg_12_0:ActivityPlayerCamera()

		local var_12_0 = arg_12_0
		local var_12_1 = arg_12_0.emitCore

		ISLAND_EVT = var_5

		var_12_1(var_12_0, var_5.REFRESH_WEATHER_SYSTEM)
	end

	arg_12_0.isLoadCharacterScene = false

	return
end

function var_0_1.OnHome(arg_13_0)
	arg_13_0:ClearCharacterScene(function()
		local var_14_0 = arg_13_0
		local var_14_1 = var_0.emit

		BaseUI = var_2_10003

		var_14_1(var_14_0, var_2_10003.ON_HOME)

		return
	end)

	return
end

function var_0_1.LoadCharacter(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:UnloadCharacter(arg_15_0.loadData)

	arg_15_0.loadData = {
		isCommander = arg_15_2,
		modelData = arg_15_1
	}

	local function var_15_0(arg_16_0, arg_16_1)
		if var_0.modelData.model ~= arg_15_0.loadData.modelData.model then
			local var_16_0 = arg_15_0

			var_2.UnloadCharacter(var_16_0, var_0)

			return
		end

		local var_16_1 = arg_15_0

		var_16_1.role = arg_16_0
		pg = var_16_1

		local var_16_2 = var_16_1.ViewUtils.SetLayer
		local var_16_3 = arg_15_0.role.transform

		Layer = var_2_10005

		var_16_2(var_16_3, var_2_10005.Character3D)

		setParent = var_16_2

		var_16_2(arg_15_0.role, arg_15_0.roleContainer)

		local var_16_4 = arg_15_0.role.transform

		Vector3 = var_3
		var_16_4.eulerAngles = var_3(0, 180, 0)

		local var_16_5 = 0

		if arg_15_0._tf.rect.width / arg_15_0._tf.rect.height < 1.7777777777777777 then
			var_16_5 = 0.5 * (1.7777777777777777 - var_3) / 0.4444444444444444
		end

		local var_16_6 = arg_15_0.role.transform

		Vector3 = var_5
		var_16_6.localPosition = var_5(var_16_5, 0, 0)

		local var_16_7 = arg_15_0
		local var_16_8

		var_16_8, GetOrAddComponent = var_4.GetSmoothRotateObject(var_16_7), var_5
		typeof = var_8
		SmoothRotateObject = var_2_10010

		local var_16_9 = var_5(var_16_8, var_8(var_2_10010))

		var_5.SetUp(var_16_9, arg_15_0.role.transform)

		pg = var_6
		var_5.rotationSpeed = var_6.island_set.character_detail_camera_speed.key_value_int

		local var_16_10 = arg_15_0.displayUnit

		var_7.OnAttach(var_16_10, arg_16_0, arg_15_0.toolContainer)

		local var_16_13

		if arg_16_1 and arg_16_1 ~= "" then
			GetOrAddComponent = var_16_13

			local var_16_11 = arg_15_0.role.transform
			local var_16_12 = var_9.GetChild(var_16_11, 0)

			typeof = var_10
			Animator = var_2_10012
			var_16_13 = var_16_13(var_16_12, var_10(var_2_10012))

			for iter_16_0 = 1, var_16_13.layerCount do
				var_16_13:CrossFadeInFixedTime(arg_16_1, 0, iter_16_0 - 1)
			end
		end

		GetOrAddComponent = var_16_13

		local var_16_14 = arg_15_0.role

		typeof = var_10
		CharacterFootprintMgr = var_2_10012

		local var_16_15 = var_16_13(var_16_14, var_10(var_2_10012))

		var_7.SetSpawnMode(var_16_15, 1)

		local var_16_16 = arg_15_0

		var_8.OnCharLoaded(var_16_16, var_0.modelData)

		return
	end

	arg_15_0:_LoadModel(var_3, var_15_0)

	return
end

function var_0_1._LoadModel(arg_17_0, arg_17_1, arg_17_2)
	pg = var_1_10003

	local var_17_0 = var_1_10003.UIMgr.GetInstance()

	var_3.LoadingOn(var_17_0)

	local var_17_1 = arg_17_1.modelData

	if arg_17_1.isCommander then
		local var_17_2 = arg_17_0:GetPoolMgr()

		var_5.GetCommanderModel(var_17_2, var_17_1, function(arg_18_0)
			arg_17_2(arg_18_0, var_17_1.personal_ani)

			pg = var_1

			local var_18_0 = var_1.UIMgr.GetInstance()

			var_1.LoadingOff(var_18_0)

			return
		end)
	elseif arg_17_0:IsPreviewScene() then
		local var_17_3 = arg_17_0:GetPoolMgr()

		var_5.GetPreviewModel(var_17_3, var_17_1, function(arg_19_0)
			arg_17_2(arg_19_0, var_17_1.personal_ani)

			pg = var_1

			local var_19_0 = var_1.UIMgr.GetInstance()

			var_1.LoadingOff(var_19_0)

			return
		end, arg_17_0:GetDressByType(), arg_17_0:GetColorByDressId())
	else
		local var_17_4 = arg_17_0:GetPoolMgr()

		var_5.GetCharacter(var_17_4, var_17_1.model, var_17_1.animator, function(arg_20_0)
			arg_17_2(arg_20_0, var_17_1.personal_ani)

			pg = var_1

			local var_20_0 = var_1.UIMgr.GetInstance()

			var_1.LoadingOff(var_20_0)

			return
		end)
	end

	return
end

function var_0_1.UnloadCharacter(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	local var_21_0 = arg_21_1.modelData
	local var_21_1 = arg_21_1.isCommander
	local var_21_2 = arg_21_0
	local var_21_3 = arg_21_0.GetSmoothRotateObject(var_21_2)
	local var_21_4 = var_4.GetComponent

	typeof = var_1_10008
	SmoothRotateObject = var_1_10010

	if var_21_4(var_21_3, var_1_10008(var_1_10010)) then
		Object = var_21_2

		var_21_2.Destroy(var_5)

		local var_21_5
	end

	if arg_21_0.role then
		local var_21_6 = arg_21_0.displayUnit

		var_6.OnDetach(var_21_6)

		pg = var_6

		local var_21_7 = var_6.ViewUtils.SetLayer
		local var_21_8 = arg_21_0.role.transform

		Layer = var_1_10009

		var_21_7(var_21_8, var_1_10009.Default)

		if arg_21_0.isCommander then
			local var_21_9 = arg_21_0:GetPoolMgr()

			var_6.ReturnCommanderModel(var_21_9, arg_21_0.role)
		elseif arg_21_0:IsPreviewScene() then
			Object = var_6

			var_6.Destroy(arg_21_0.role)
		else
			local var_21_10 = arg_21_0:GetPoolMgr()

			var_6.ReturnCharacter(var_21_10, var_21_0.model, var_21_0.animator, arg_21_0.role)
		end

		arg_21_0.role = nil
	end

	if arg_21_0.gcCounter >= 3 then
		arg_21_0.gcCounter = 0
		IslandHelper = var_6

		var_6.RunGC(true)
	else
		arg_21_0.gcCounter = arg_21_0.gcCounter + 1
	end

	return
end

function var_0_1.ClearCharacterContainer(arg_22_0)
	arg_22_0:UnloadCharacter(arg_22_0.loadData)

	arg_22_0.loadData = nil
	IsNil = var_1

	if not var_1(arg_22_0.roleContainer) then
		Object = var_1

		var_1.Destroy(arg_22_0.roleContainer.gameObject)

		arg_22_0.roleContainer = nil
	end

	return
end

function var_0_1.UnLoadCharacterScene(arg_23_0, arg_23_1)
	local var_23_0 = "island/scenesres/scenes/character/map_shipmainui_scene"

	SceneOpMgr = var_1_10003

	local var_23_1 = var_1_10003.Inst

	var_3.UnloadSceneAsync(var_23_1, var_23_0, "map_shipmainui", function()
		if arg_23_1 then
			arg_23_1()
		end

		return
	end)

	return
end

function var_0_1.ResetCameraMask(arg_25_0)
	IslandCameraMgr = var_1_10001

	local var_25_0 = var_1_10001.instance

	IsNil = var_1_10002

	if var_1_10002(var_25_0) then
		CheatTavernCameraMgr = var_2
		var_25_0 = var_2.instance
	end

	if arg_25_0.defaultCullingMask and var_25_0 then
		local var_25_1 = var_25_0._mainCamera

		LuaHelper = var_1_10003

		var_1_10003.ResetCamCullingMask(var_25_1, arg_25_0.defaultCullingMask)
	end

	return
end

function var_0_1.ActivityPlayerCamera(arg_26_0)
	IslandCameraMgr = var_1_10001

	if not var_1_10001.instance then
		return
	end

	IslandCameraMgr = var_1

	local var_26_0 = var_1.instance
	local var_26_1 = var_1.ActiveVirtualCamera

	IslandConst = var_1_10004

	var_26_1(var_26_0, var_1_10004.FOLLOW_CAMERA_NAME)

	return
end

function var_0_1.CreateToolContainer(arg_27_0)
	GameObject = var_1_10001
	arg_27_0.toolContainer = var_1_10001.New("toolContainer").transform
	pg = var_1

	local var_27_0 = var_1.ViewUtils.SetLayer
	local var_27_1 = arg_27_0.roleContainer

	Layer = var_1_10004

	var_27_0(var_27_1, var_1_10004.Default)

	return
end

function var_0_1.ClearToolContainer(arg_28_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_28_0.toolContainer) then
		Object = var_1

		var_1.Destroy(arg_28_0.toolContainer.gameObject)

		arg_28_0.toolContainer = nil
	end

	return
end

function var_0_1.OnClearItemAnimator(arg_29_0)
	local var_29_0 = arg_29_0.displayUnit

	var_1.OnClearItemAnimator(var_29_0)

	return
end

function var_0_1.Hide(arg_30_0)
	var_0_1.super.Hide(arg_30_0)
	arg_30_0:ClearCharacterScene()

	return
end

function var_0_1.OnDisable(arg_31_0)
	arg_31_0:ClearCharacterScene()

	return
end

function var_0_1.OnDestroy(arg_32_0)
	arg_32_0:ClearCharacterScene()

	pairs = var_1

	local var_32_0

	if not arg_32_0.cards then
		var_32_0 = {}
	end

	for iter_32_0, iter_32_1 in var_1(var_32_0) do
		iter_32_1:Dispose()
	end

	arg_32_0.cards = nil

	return
end

function var_0_1.GetActiveCamName(arg_33_0)
	IslandConst = var_1_10001

	return var_1_10001.CHARA_CAMERA_NAME
end

function var_0_1.GetSmoothRotateObject(arg_34_0)
	assert = var_1_10001

	var_1_10001(false, "Write me")

	return
end

function var_0_1.OnCharLoaded(arg_35_0)
	return
end

function var_0_1.IsPreviewScene(arg_36_0)
	return false
end

function var_0_1.GetDressByType(arg_37_0)
	return {}
end

function var_0_1.GetColorByDressId(arg_38_0)
	return {}
end

return var_0_1
