local IslandBaseShipDisplayPage = class("IslandBaseShipDisplayPage", import("...base.IslandBasePage"))

function IslandBaseShipDisplayPage:Ctor(...)
	IslandBaseShipDisplayPage.super.Ctor(self, ...)

	self.displayUnit = IslandDisplayShipUnit.New()
	self.gcCounter = 0

	return
end

function IslandBaseShipDisplayPage:Preload(arg_2_1)
	self:PrepareCharacterScene(arg_2_1)

	return
end

function IslandBaseShipDisplayPage:PrepareCharacterScene(arg_3_1)
	self.isLoadCharacterScene = true

	seriesAsync({
		function(arg_4_0)
			self:CreateCharacterContainer()
			self:CreateToolContainer()
			self:LoadCharacterScene(arg_4_0)

			return
		end,
		function(arg_5_0)
			self:ModifyCameraMask()
			self:ActivityCharacterCamera()
			self:InitSceneTimeline()
			arg_5_0()

			return
		end
	}, arg_3_1)

	return
end

function IslandBaseShipDisplayPage:CreateCharacterContainer()
	self.roleContainer = GameObject.New("roleContainer").transform

	pg.ViewUtils.SetLayer(self.roleContainer, Layer.Character3D)

	return
end

function IslandBaseShipDisplayPage:LoadCharacterScene(arg_7_1)
	SceneOpMgr.Inst:LoadSceneAsyncWithProgress("island/scenesres/scenes/character/map_shipmainui_scene", "map_shipmainui", LoadSceneMode.Additive, function(arg_8_0)
		if arg_8_0 == 1 then
			arg_7_1()
		end

		return
	end)

	return
end

function IslandBaseShipDisplayPage:ModifyCameraMask()
	local var_9_1 = ((IsNil(IslandCameraMgr.instance) or nil) and CheatTavernCameraMgr.instance)._mainCamera

	self.defaultCullingMask = ((IsNil(IslandCameraMgr.instance) or nil) and CheatTavernCameraMgr.instance)._mainCamera.cullingMask

	LuaHelper.SetCamCullingMask(var_9_1, "Character3D")

	return
end

function IslandBaseShipDisplayPage:ActivityCharacterCamera()
	local var_10_0 = self:GetActiveCamName()
	local var_10_1 = IslandCameraMgr.instance

	if IsNil(IslandCameraMgr.instance) then
		var_10_1 = CheatTavernCameraMgr.instance
	end

	local var_10_2 = var_10_1:GetVirtualCamera(var_10_0)

	var_10_2.Follow = self.roleContainer
	var_10_2.LookAt = self.roleContainer

	var_10_1:ActiveVirtualCamera(var_10_0)

	return
end

function IslandBaseShipDisplayPage:InitSceneTimeline()
	local var_11_0 = GameObject.Find("[sequence]")

	if var_11_0 then
		local var_11_1 = var_11_0:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

		TimelineSupport.DynamicBinding(var_11_1)
		var_11_1:Play()
	end

	return
end

function IslandBaseShipDisplayPage:ClearCharacterScene(arg_12_1)
	if self.isLoadCharacterScene then
		self:UnLoadCharacterScene(arg_12_1)
		self:ClearCharacterContainer()
		self:ClearToolContainer()
		self:ResetCameraMask()
		self:ActivityPlayerCamera()
		self:emitCore(ISLAND_EVT.REFRESH_WEATHER_SYSTEM)
	end

	self.isLoadCharacterScene = false

	return
end

function IslandBaseShipDisplayPage:OnHome()
	self:ClearCharacterScene(function()
		self:emit(BaseUI.ON_HOME)

		return
	end)

	return
end

function IslandBaseShipDisplayPage:LoadCharacter(arg_15_1, arg_15_2)
	self:UnloadCharacter(self.loadData)

	local var_15_0 = {
		isCommander = arg_15_2,
		modelData = arg_15_1
	}

	self.loadData = var_15_0

	self:_LoadModel(var_15_0, function(arg_16_0, arg_16_1)
		if var_15_0.modelData.model ~= self.loadData.modelData.model then
			self:UnloadCharacter(var_15_0)

			return
		end

		self.role = arg_16_0

		pg.ViewUtils.SetLayer(self.role.transform, Layer.Character3D)
		setParent(self.role, self.roleContainer)

		self.role.transform.eulerAngles = Vector3(0, 180, 0)
		self.role.transform.localPosition = Vector3((self._tf.rect.width / self._tf.rect.height < 1.7777777777777777 or nil) and 0.5 * (1.7777777777777777 - self._tf.rect.width / self._tf.rect.height) / 0.4444444444444444, 0, 0)

		local var_16_1 = GetOrAddComponent(self:GetSmoothRotateObject(), typeof(SmoothRotateObject))

		var_16_1:SetUp(self.role.transform)

		var_16_1.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		self.displayUnit:OnAttach(arg_16_0, self.toolContainer)

		if arg_16_1 and arg_16_1 ~= "" then
			local var_16_2 = GetOrAddComponent(self.role.transform:GetChild(0), typeof(Animator))

			for iter_16_0 = 1, var_16_2.layerCount do
				var_16_2:CrossFadeInFixedTime(arg_16_1, 0, iter_16_0 - 1)
			end
		end

		GetOrAddComponent(self.role, typeof(CharacterFootprintMgr)):SetSpawnMode(1)
		self:OnCharLoaded(var_15_0.modelData)

		return
	end)

	return
end

function IslandBaseShipDisplayPage:_LoadModel(arg_17_1, arg_17_2)
	pg.UIMgr.GetInstance():LoadingOn()

	local var_17_0 = arg_17_1.modelData

	if arg_17_1.isCommander then
		self:GetPoolMgr():GetCommanderModel(arg_17_1.modelData, function(arg_18_0)
			arg_17_2(arg_18_0, var_17_0.personal_ani)
			pg.UIMgr.GetInstance():LoadingOff()

			return
		end)
	elseif self:IsPreviewScene() then
		self:GetPoolMgr():GetPreviewModel(arg_17_1.modelData, function(arg_19_0)
			arg_17_2(arg_19_0, var_17_0.personal_ani)
			pg.UIMgr.GetInstance():LoadingOff()

			return
		end, self:GetDressByType(), self:GetColorByDressId())
	else
		self:GetPoolMgr():GetCharacter(arg_17_1.modelData.model, arg_17_1.modelData.animator, function(arg_20_0)
			arg_17_2(arg_20_0, var_17_0.personal_ani)
			pg.UIMgr.GetInstance():LoadingOff()

			return
		end)
	end

	return
end

function IslandBaseShipDisplayPage:UnloadCharacter(arg_21_1)
	if not arg_21_1 then
		return
	end

	local var_21_0 = arg_21_1.modelData
	local var_21_2 = self:GetSmoothRotateObject():GetComponent(typeof(SmoothRotateObject))

	if var_21_2 then
		Object.Destroy(var_21_2)
	end

	if self.role then
		self.displayUnit:OnDetach()
		pg.ViewUtils.SetLayer(self.role.transform, Layer.Default)

		if self.isCommander then
			self:GetPoolMgr():ReturnCommanderModel(self.role)
		elseif self:IsPreviewScene() then
			Object.Destroy(self.role)
		else
			self:GetPoolMgr():ReturnCharacter(var_21_0.model, var_21_0.animator, self.role)
		end

		self.role = nil
	end

	if self.gcCounter >= 3 then
		self.gcCounter = 0

		IslandHelper.RunGC(true)
	else
		self.gcCounter = self.gcCounter + 1
	end

	return
end

function IslandBaseShipDisplayPage:ClearCharacterContainer()
	self:UnloadCharacter(self.loadData)

	self.loadData = nil

	if not IsNil(self.roleContainer) then
		Object.Destroy(self.roleContainer.gameObject)

		self.roleContainer = nil
	end

	return
end

function IslandBaseShipDisplayPage:UnLoadCharacterScene(arg_23_1)
	SceneOpMgr.Inst:UnloadSceneAsync("island/scenesres/scenes/character/map_shipmainui_scene", "map_shipmainui", function()
		if arg_23_1 then
			arg_23_1()
		end

		return
	end)

	return
end

function IslandBaseShipDisplayPage:ResetCameraMask()
	local var_25_0 = IslandCameraMgr.instance

	if IsNil(IslandCameraMgr.instance) then
		var_25_0 = CheatTavernCameraMgr.instance
	end

	if self.defaultCullingMask and var_25_0 then
		LuaHelper.ResetCamCullingMask(var_25_0._mainCamera, self.defaultCullingMask)
	end

	return
end

function IslandBaseShipDisplayPage:ActivityPlayerCamera()
	if not IslandCameraMgr.instance then
		return
	end

	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)

	return
end

function IslandBaseShipDisplayPage:CreateToolContainer()
	self.toolContainer = GameObject.New("toolContainer").transform

	pg.ViewUtils.SetLayer(self.roleContainer, Layer.Default)

	return
end

function IslandBaseShipDisplayPage:ClearToolContainer()
	if not IsNil(self.toolContainer) then
		Object.Destroy(self.toolContainer.gameObject)

		self.toolContainer = nil
	end

	return
end

function IslandBaseShipDisplayPage:OnClearItemAnimator()
	self.displayUnit:OnClearItemAnimator()

	return
end

function IslandBaseShipDisplayPage:Hide()
	IslandBaseShipDisplayPage.super.Hide(self)
	self:ClearCharacterScene()

	return
end

function IslandBaseShipDisplayPage:OnDisable()
	self:ClearCharacterScene()

	return
end

function IslandBaseShipDisplayPage:OnDestroy()
	self:ClearCharacterScene()

	for iter_32_0, iter_32_1 in pairs(self.cards or {}) do
		iter_32_1:Dispose()
	end

	self.cards = nil

	return
end

function IslandBaseShipDisplayPage:GetActiveCamName()
	return IslandConst.CHARA_CAMERA_NAME
end

function IslandBaseShipDisplayPage:GetSmoothRotateObject()
	assert(false, "Write me")

	return
end

function IslandBaseShipDisplayPage:OnCharLoaded()
	return
end

function IslandBaseShipDisplayPage:IsPreviewScene()
	return false
end

function IslandBaseShipDisplayPage:GetDressByType()
	return {}
end

function IslandBaseShipDisplayPage:GetColorByDressId()
	return {}
end

return IslandBaseShipDisplayPage
