class = var_0_10000

local var_0_0 = "IslandBaseDressupPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.Preload(arg_1_0, arg_1_1)
	arg_1_0:PrepareCharacterScene(arg_1_1)

	return
end

function var_0_1.PrepareCharacterScene(arg_2_0, arg_2_1)
	arg_2_0.isLoadCharacterScene = true
	seriesAsync = var_2

	var_2({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.LoadCharacterScene(var_3_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.CreateCharacterContainer(var_4_0)

			local var_4_1 = arg_2_0

			var_1.ModifyCameraMask(var_4_1)

			onNextTick = var_1

			var_1(function()
				local var_5_0 = arg_2_0

				var_0.ActivityCharacterCamera(var_5_0)

				return
			end)
			arg_4_0()

			return
		end
	}, arg_2_1)

	return
end

function var_0_1.LoadCharacterScene(arg_6_0, arg_6_1)
	local var_6_0 = "island/scenesres/scenes/character/map_ship_dressup_scene"

	SceneOpMgr = var_1_10003

	local var_6_1 = var_1_10003.Inst
	local var_6_2 = var_3.LoadSceneAsyncWithProgress
	local var_6_3 = var_6_0
	local var_6_4 = "map_ship_dressup"

	LoadSceneMode = var_1_10008

	var_6_2(var_6_1, var_6_3, var_6_4, var_1_10008.Additive, function(arg_7_0)
		if arg_7_0 == 1 then
			SceneOpMgr = var_2_10001

			local var_7_0 = var_2_10001.Inst

			var_1.SetActiveSceneByIndex(var_7_0, 1)
			arg_6_1()
		end

		return
	end)

	return
end

function var_0_1.CreateCharacterContainer(arg_8_0)
	GameObject = var_1_10001
	arg_8_0.roleContainer = var_1_10001.New("roleContainer").transform
	pg = var_1

	local var_8_0 = var_1.ViewUtils.SetLayer
	local var_8_1 = arg_8_0.roleContainer

	Layer = var_1_10004

	var_8_0(var_8_1, var_1_10004.Character3D)

	return
end

function var_0_1.ModifyCameraMask(arg_9_0)
	IslandCameraMgr = var_1_10001
	arg_9_0.defaultCullingMask = var_1_10001.instance._mainCamera.cullingMask
	LuaHelper = var_2

	var_2.SetCamCullingMask(var_1, "Character3D")

	return
end

function var_0_1.ActivityCharacterCamera(arg_10_0)
	local var_10_0 = arg_10_0:GetActiveCamName()

	IslandCameraMgr = var_1_10002

	local var_10_1 = var_1_10002.instance
	local var_10_2 = var_2.GetVirtualCamera(var_10_1, var_10_0)

	var_10_2.Follow = arg_10_0.roleContainer
	var_10_2.LookAt = arg_10_0.roleContainer
	IslandCameraMgr = var_3

	local var_10_3 = var_3.instance

	var_3.ActiveVirtualCamera(var_10_3, var_10_0)

	return
end

function var_0_1.GetActiveCamName(arg_11_0)
	IslandConst = var_1_10001

	return var_1_10001.DRESSUP_CAMERA_NAME
end

function var_0_1.UnLoadCharacterScene(arg_12_0, arg_12_1)
	local var_12_0 = "island/scenesres/scenes/character/map_ship_dressup_scene"

	SceneOpMgr = var_1_10003

	local var_12_1 = var_1_10003.Inst

	var_3.UnloadSceneAsync(var_12_1, var_12_0, "map_ship_dressup", function()
		if arg_12_1 then
			arg_12_1()
		end

		return
	end)

	return
end

function var_0_1.ClearCharacterScene(arg_14_0, arg_14_1)
	if arg_14_0.isLoadCharacterScene then
		arg_14_0:UnLoadCharacterScene(arg_14_1)
		arg_14_0:ClearCharacterContainer()
	end

	arg_14_0.isLoadCharacterScene = false

	return
end

function var_0_1.ClearCharacterContainer(arg_15_0)
	arg_15_0:UnloadCharacter()

	if arg_15_0.roleContainer then
		Object = var_1

		var_1.Destroy(arg_15_0.roleContainer.gameObject)

		arg_15_0.roleContainer = nil
	end

	return
end

function var_0_1.LoadCharacter(arg_16_0, arg_16_1)
	arg_16_0:UnloadCharacter()

	local var_16_0 = arg_16_0:GetPoolMgr()

	var_2.GetCommanderModel(var_16_0, arg_16_1, function(arg_17_0)
		local var_17_0 = arg_16_0

		var_17_0.role = arg_17_0
		pg = var_17_0

		local var_17_1 = var_17_0.ViewUtils.SetLayer
		local var_17_2 = arg_16_0.role.transform

		Layer = var_2_10004

		var_17_1(var_17_2, var_2_10004.Character3D)

		setParent = var_17_1

		var_17_1(arg_16_0.role, arg_16_0.roleContainer)

		local var_17_3 = arg_16_0.role.transform

		Vector3 = var_2_10002
		var_17_3.eulerAngles = var_2_10002(0, 180, 0)

		local var_17_4 = 1.7777777777777777

		Screen = var_2

		local var_17_5 = var_2.width

		Screen = var_3

		local var_17_6 = (var_17_4 - var_17_5 / var_3.height) * 0.5
		local var_17_7 = 0.9

		IslandCameraMgr = var_5

		local var_17_8 = var_5.instance
		local var_17_9 = var_5.CinemachineComposerTrackObjOffset
		local var_17_10 = arg_16_0
		local var_17_11 = var_8.GetActiveCamName(var_17_10)

		Vector3 = var_2_10009

		var_17_9(var_17_8, var_17_11, var_2_10009(var_17_7 - var_17_6, 1, 0))

		local var_17_12 = arg_16_0.role.transform

		Vector3 = var_6
		var_17_12.localPosition = var_6(0, 0, 0)

		local var_17_13 = arg_16_0
		local var_17_14

		var_17_14, GetOrAddComponent = var_5.GetSmoothRotateObject(var_17_13), var_6
		typeof = var_9
		SmoothRotateObject = var_11

		local var_17_15 = var_6(var_17_14, var_9(var_11))

		var_6.SetUp(var_17_15, arg_16_0.role.transform)

		pg = var_7
		var_6.rotationSpeed = var_7.island_set.character_detail_camera_speed.key_value_int

		local var_17_16 = arg_16_0

		var_8.OnCharLoaded(var_17_16)

		GetOrAddComponent = var_8

		local var_17_17 = arg_16_0.role

		typeof = var_11
		CharacterFootprintMgr = var_13

		local var_17_18 = var_8(var_17_17, var_11(var_13))

		var_8.SetSpawnMode(var_17_18, 1)

		return
	end)

	return
end

function var_0_1.UnloadCharacter(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetSmoothRotateObject(var_18_0)
	local var_18_2 = var_1.GetComponent

	typeof = var_1_10005
	SmoothRotateObject = var_1_10007

	if var_18_2(var_18_1, var_1_10005(var_1_10007)) then
		Object = var_18_0

		var_18_0.Destroy(var_2)
	end

	if arg_18_0.role then
		local var_18_3 = arg_18_0:GetPoolMgr()

		var_3.ReturnCommanderModel(var_18_3, arg_18_0.role)

		arg_18_0.role = nil
	end

	return
end

function var_0_1.Hide(arg_19_0)
	var_0_1.super.Hide(arg_19_0)

	return
end

function var_0_1.OnDestroy(arg_20_0)
	arg_20_0:ClearCharacterScene()

	pairs = var_1

	local var_20_0

	if not arg_20_0.cards then
		var_20_0 = {}
	end

	for iter_20_0, iter_20_1 in var_1(var_20_0) do
		iter_20_1:Dispose()
	end

	arg_20_0.cards = nil

	return
end

return var_0_1
