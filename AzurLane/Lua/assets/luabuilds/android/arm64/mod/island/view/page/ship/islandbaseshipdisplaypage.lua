local var_0_0 = class("IslandBaseShipDisplayPage", import("...base.IslandBasePage"))

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.displayUnit = IslandDisplayShipUnit.New()
	arg_1_0.gcCounter = 0

	return
end

function var_0_0.Preload(arg_2_0, arg_2_1)
	arg_2_0:PrepareCharacterScene(arg_2_1)

	return
end

function var_0_0.PrepareCharacterScene(arg_3_0, arg_3_1)
	arg_3_0.isLoadCharacterScene = true

	seriesAsync({
		function(arg_4_0)
			arg_3_0:CreateCharacterContainer()
			arg_3_0:CreateToolContainer()
			arg_3_0:LoadCharacterScene(arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_3_0:ModifyCameraMask()
			arg_3_0:ActivityCharacterCamera()
			arg_3_0:InitSceneTimeline()
			arg_5_0()

			return
		end
	}, arg_3_1)

	return
end

function var_0_0.CreateCharacterContainer(arg_6_0)
	arg_6_0.roleContainer = GameObject.New("roleContainer").transform

	pg.ViewUtils.SetLayer(arg_6_0.roleContainer, Layer.Character3D)

	return
end

function var_0_0.LoadCharacterScene(arg_7_0, arg_7_1)
	SceneOpMgr.Inst:LoadSceneAsyncWithProgress("island/scenesres/scenes/character/map_shipmainui_scene", "map_shipmainui", LoadSceneMode.Additive, function(arg_8_0)
		if arg_8_0 == 1 then
			arg_7_1()
		end

		return
	end)

	return
end

function var_0_0.ModifyCameraMask(arg_9_0)
	local var_9_0 = IslandCameraMgr.instance

	if IsNil(IslandCameraMgr.instance) then
		var_9_0 = CheatTavernCameraMgr.instance
	end

	local var_9_1 = var_9_0._mainCamera

	arg_9_0.defaultCullingMask = var_9_0._mainCamera.cullingMask

	LuaHelper.SetCamCullingMask(var_9_1, "Character3D")

	return
end

function var_0_0.ActivityCharacterCamera(arg_10_0)
	local var_10_0 = arg_10_0:GetActiveCamName()
	local var_10_1 = IslandCameraMgr.instance

	if IsNil(IslandCameraMgr.instance) then
		var_10_1 = CheatTavernCameraMgr.instance
	end

	local var_10_2 = var_10_1:GetVirtualCamera(var_10_0)

	var_10_2.Follow = arg_10_0.roleContainer
	var_10_2.LookAt = arg_10_0.roleContainer

	var_10_1:ActiveVirtualCamera(var_10_0)

	return
end

function var_0_0.InitSceneTimeline(arg_11_0)
	local var_11_0 = GameObject.Find("[sequence]")

	if var_11_0 then
		local var_11_1 = var_11_0:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

		TimelineSupport.DynamicBinding(var_11_1)
		var_11_1:Play()
	end

	return
end

function var_0_0.ClearCharacterScene(arg_12_0, arg_12_1)
	if arg_12_0.isLoadCharacterScene then
		arg_12_0:UnLoadCharacterScene(arg_12_1)
		arg_12_0:ClearCharacterContainer()
		arg_12_0:ClearToolContainer()
		arg_12_0:ResetCameraMask()
		arg_12_0:ActivityPlayerCamera()
		arg_12_0:emitCore(ISLAND_EVT.REFRESH_WEATHER_SYSTEM)
	end

	arg_12_0.isLoadCharacterScene = false

	return
end

function var_0_0.OnHome(arg_13_0)
	arg_13_0:ClearCharacterScene(function()
		arg_13_0:emit(BaseUI.ON_HOME)

		return
	end)

	return
end

function var_0_0.LoadCharacter(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:UnloadCharacter(arg_15_0.loadData)

	local var_15_0 = {
		isCommander = arg_15_2,
		modelData = arg_15_1
	}

	arg_15_0.loadData = {
		isCommander = arg_15_2,
		modelData = arg_15_1
	}

	arg_15_0:_LoadModel({
		isCommander = arg_15_2,
		modelData = arg_15_1
	}, function(arg_16_0, arg_16_1)
		if var_15_0.modelData.model ~= arg_15_0.loadData.modelData.model then
			arg_15_0:UnloadCharacter(var_15_0)

			return
		end

		arg_15_0.role = arg_16_0

		pg.ViewUtils.SetLayer(arg_15_0.role.transform, Layer.Character3D)
		setParent(arg_15_0.role, arg_15_0.roleContainer)

		arg_15_0.role.transform.eulerAngles = Vector3(0, 180, 0)

		local var_16_0 = 0

		if arg_15_0._tf.rect.width / arg_15_0._tf.rect.height < 1.7777777777777777 then
			var_16_0 = 0.5 * (1.7777777777777777 - arg_15_0._tf.rect.width / arg_15_0._tf.rect.height) / 0.4444444444444444
		end

		arg_15_0.role.transform.localPosition = Vector3(var_16_0, 0, 0)

		local var_16_1 = GetOrAddComponent(arg_15_0:GetSmoothRotateObject(), typeof(SmoothRotateObject))

		var_16_1:SetUp(arg_15_0.role.transform)

		var_16_1.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		arg_15_0.displayUnit:OnAttach(arg_16_0, arg_15_0.toolContainer)

		if arg_16_1 and arg_16_1 ~= "" then
			local var_16_2 = GetOrAddComponent(arg_15_0.role.transform:GetChild(0), typeof(Animator))

			for iter_16_0 = 1, var_16_2.layerCount do
				var_16_2:CrossFadeInFixedTime(arg_16_1, 0, iter_16_0 - 1)
			end
		end

		GetOrAddComponent(arg_15_0.role, typeof(CharacterFootprintMgr)):SetSpawnMode(1)
		arg_15_0:OnCharLoaded(var_15_0.modelData)

		return
	end)

	return
end

function var_0_0._LoadModel(arg_17_0, arg_17_1, arg_17_2)
	pg.UIMgr.GetInstance():LoadingOn()

	local var_17_0 = arg_17_1.modelData

	if arg_17_1.isCommander then
		arg_17_0:GetPoolMgr():GetCommanderModel(arg_17_1.modelData, function(arg_18_0)
			arg_17_2(arg_18_0, var_17_0.personal_ani)
			pg.UIMgr.GetInstance():LoadingOff()

			return
		end)
	elseif arg_17_0:IsPreviewScene() then
		arg_17_0:GetPoolMgr():GetPreviewModel(arg_17_1.modelData, function(arg_19_0)
			arg_17_2(arg_19_0, var_17_0.personal_ani)
			pg.UIMgr.GetInstance():LoadingOff()

			return
		end, arg_17_0:GetDressByType(), arg_17_0:GetColorByDressId())
	else
		arg_17_0:GetPoolMgr():GetCharacter(arg_17_1.modelData.model, arg_17_1.modelData.animator, function(arg_20_0)
			arg_17_2(arg_20_0, var_17_0.personal_ani)
			pg.UIMgr.GetInstance():LoadingOff()

			return
		end)
	end

	return
end

function var_0_0.UnloadCharacter(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	local var_21_0 = arg_21_1.modelData
	local var_21_2 = arg_21_0:GetSmoothRotateObject():GetComponent(typeof(SmoothRotateObject))

	if var_21_2 then
		Object.Destroy(var_21_2)
	end

	if arg_21_0.role then
		arg_21_0.displayUnit:OnDetach()
		pg.ViewUtils.SetLayer(arg_21_0.role.transform, Layer.Default)

		if arg_21_0.isCommander then
			arg_21_0:GetPoolMgr():ReturnCommanderModel(arg_21_0.role)
		elseif arg_21_0:IsPreviewScene() then
			Object.Destroy(arg_21_0.role)
		else
			arg_21_0:GetPoolMgr():ReturnCharacter(var_21_0.model, var_21_0.animator, arg_21_0.role)
		end

		arg_21_0.role = nil
	end

	if arg_21_0.gcCounter >= 3 then
		arg_21_0.gcCounter = 0

		IslandHelper.RunGC(true)
	else
		arg_21_0.gcCounter = arg_21_0.gcCounter + 1
	end

	return
end

function var_0_0.ClearCharacterContainer(arg_22_0)
	arg_22_0:UnloadCharacter(arg_22_0.loadData)

	arg_22_0.loadData = nil

	if not IsNil(arg_22_0.roleContainer) then
		Object.Destroy(arg_22_0.roleContainer.gameObject)

		arg_22_0.roleContainer = nil
	end

	return
end

function var_0_0.UnLoadCharacterScene(arg_23_0, arg_23_1)
	SceneOpMgr.Inst:UnloadSceneAsync("island/scenesres/scenes/character/map_shipmainui_scene", "map_shipmainui", function()
		if arg_23_1 then
			arg_23_1()
		end

		return
	end)

	return
end

function var_0_0.ResetCameraMask(arg_25_0)
	local var_25_0 = IslandCameraMgr.instance

	if IsNil(IslandCameraMgr.instance) then
		var_25_0 = CheatTavernCameraMgr.instance
	end

	if arg_25_0.defaultCullingMask and var_25_0 then
		LuaHelper.ResetCamCullingMask(var_25_0._mainCamera, arg_25_0.defaultCullingMask)
	end

	return
end

function var_0_0.ActivityPlayerCamera(arg_26_0)
	if not IslandCameraMgr.instance then
		return
	end

	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)

	return
end

function var_0_0.CreateToolContainer(arg_27_0)
	arg_27_0.toolContainer = GameObject.New("toolContainer").transform

	pg.ViewUtils.SetLayer(arg_27_0.roleContainer, Layer.Default)

	return
end

function var_0_0.ClearToolContainer(arg_28_0)
	if not IsNil(arg_28_0.toolContainer) then
		Object.Destroy(arg_28_0.toolContainer.gameObject)

		arg_28_0.toolContainer = nil
	end

	return
end

function var_0_0.OnClearItemAnimator(arg_29_0)
	arg_29_0.displayUnit:OnClearItemAnimator()

	return
end

function var_0_0.Hide(arg_30_0)
	var_0_0.super.Hide(arg_30_0)
	arg_30_0:ClearCharacterScene()

	return
end

function var_0_0.OnDisable(arg_31_0)
	arg_31_0:ClearCharacterScene()

	return
end

function var_0_0.OnDestroy(arg_32_0)
	arg_32_0:ClearCharacterScene()

	local var_32_0 = arg_32_0.cards or {}

	for iter_32_0, iter_32_1 in pairs(var_32_0) do
		iter_32_1:Dispose()
	end

	arg_32_0.cards = nil

	return
end

function var_0_0.GetActiveCamName(arg_33_0)
	return IslandConst.CHARA_CAMERA_NAME
end

function var_0_0.GetSmoothRotateObject(arg_34_0)
	assert(false, "Write me")

	return
end

function var_0_0.OnCharLoaded(arg_35_0)
	return
end

function var_0_0.IsPreviewScene(arg_36_0)
	return false
end

function var_0_0.GetDressByType(arg_37_0)
	return {}
end

function var_0_0.GetColorByDressId(arg_38_0)
	return {}
end

return var_0_0
