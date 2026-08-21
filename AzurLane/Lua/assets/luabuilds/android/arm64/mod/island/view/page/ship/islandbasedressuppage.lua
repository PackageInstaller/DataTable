local var_0_0 = class("IslandBaseDressupPage", import("...base.IslandBasePage"))

function var_0_0.Preload(arg_1_0, arg_1_1)
	arg_1_0:PrepareCharacterScene(arg_1_1)

	return
end

function var_0_0.PrepareCharacterScene(arg_2_0, arg_2_1)
	arg_2_0.isLoadCharacterScene = true

	seriesAsync({
		function(arg_3_0)
			arg_2_0:LoadCharacterScene(arg_3_0)

			return
		end,
		function(arg_4_0)
			arg_2_0:CreateCharacterContainer()
			arg_2_0:ModifyCameraMask()
			onNextTick(function()
				arg_2_0:ActivityCharacterCamera()

				return
			end)
			arg_4_0()

			return
		end
	}, arg_2_1)

	return
end

function var_0_0.LoadCharacterScene(arg_6_0, arg_6_1)
	SceneOpMgr.Inst:LoadSceneAsyncWithProgress("island/scenesres/scenes/character/map_ship_dressup_scene", "map_ship_dressup", LoadSceneMode.Additive, function(arg_7_0)
		if arg_7_0 == 1 then
			SceneOpMgr.Inst:SetActiveSceneByIndex(1)
			arg_6_1()
		end

		return
	end)

	return
end

function var_0_0.CreateCharacterContainer(arg_8_0)
	arg_8_0.roleContainer = GameObject.New("roleContainer").transform

	pg.ViewUtils.SetLayer(arg_8_0.roleContainer, Layer.Character3D)

	return
end

function var_0_0.ModifyCameraMask(arg_9_0)
	arg_9_0.defaultCullingMask = IslandCameraMgr.instance._mainCamera.cullingMask

	LuaHelper.SetCamCullingMask(IslandCameraMgr.instance._mainCamera, "Character3D")

	return
end

function var_0_0.ActivityCharacterCamera(arg_10_0)
	local var_10_0 = arg_10_0:GetActiveCamName()
	local var_10_1 = IslandCameraMgr.instance:GetVirtualCamera(var_10_0)

	var_10_1.Follow = arg_10_0.roleContainer
	var_10_1.LookAt = arg_10_0.roleContainer

	IslandCameraMgr.instance:ActiveVirtualCamera(var_10_0)

	return
end

function var_0_0.GetActiveCamName(arg_11_0)
	return IslandConst.DRESSUP_CAMERA_NAME
end

function var_0_0.UnLoadCharacterScene(arg_12_0, arg_12_1)
	SceneOpMgr.Inst:UnloadSceneAsync("island/scenesres/scenes/character/map_ship_dressup_scene", "map_ship_dressup", function()
		if arg_12_1 then
			arg_12_1()
		end

		return
	end)

	return
end

function var_0_0.ClearCharacterScene(arg_14_0, arg_14_1)
	if arg_14_0.isLoadCharacterScene then
		arg_14_0:UnLoadCharacterScene(arg_14_1)
		arg_14_0:ClearCharacterContainer()
	end

	arg_14_0.isLoadCharacterScene = false

	return
end

function var_0_0.ClearCharacterContainer(arg_15_0)
	arg_15_0:UnloadCharacter()

	if arg_15_0.roleContainer then
		Object.Destroy(arg_15_0.roleContainer.gameObject)

		arg_15_0.roleContainer = nil
	end

	return
end

function var_0_0.LoadCharacter(arg_16_0, arg_16_1)
	arg_16_0:UnloadCharacter()
	arg_16_0:GetPoolMgr():GetCommanderModel(arg_16_1, function(arg_17_0)
		arg_16_0.role = arg_17_0

		pg.ViewUtils.SetLayer(arg_16_0.role.transform, Layer.Character3D)
		setParent(arg_16_0.role, arg_16_0.roleContainer)

		arg_16_0.role.transform.eulerAngles = Vector3(0, 180, 0)

		IslandCameraMgr.instance:CinemachineComposerTrackObjOffset(arg_16_0:GetActiveCamName(), Vector3(0.9 - (1.7777777777777777 - Screen.width / Screen.height) * 0.5, 1, 0))

		arg_16_0.role.transform.localPosition = Vector3(0, 0, 0)

		local var_17_0 = GetOrAddComponent(arg_16_0:GetSmoothRotateObject(), typeof(SmoothRotateObject))

		var_17_0:SetUp(arg_16_0.role.transform)

		var_17_0.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		arg_16_0:OnCharLoaded()
		GetOrAddComponent(arg_16_0.role, typeof(CharacterFootprintMgr)):SetSpawnMode(1)

		return
	end)

	return
end

function var_0_0.UnloadCharacter(arg_18_0)
	local var_18_0 = arg_18_0:GetSmoothRotateObject():GetComponent(typeof(SmoothRotateObject))

	if var_18_0 then
		Object.Destroy(var_18_0)
	end

	if arg_18_0.role then
		arg_18_0:GetPoolMgr():ReturnCommanderModel(arg_18_0.role)

		arg_18_0.role = nil
	end

	return
end

function var_0_0.Hide(arg_19_0)
	var_0_0.super.Hide(arg_19_0)

	return
end

function var_0_0.OnDestroy(arg_20_0)
	arg_20_0:ClearCharacterScene()

	local var_20_0 = arg_20_0.cards or {}

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		iter_20_1:Dispose()
	end

	arg_20_0.cards = nil

	return
end

return var_0_0
