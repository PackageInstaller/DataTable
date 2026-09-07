local IslandBaseDressupPage = class("IslandBaseDressupPage", import("...base.IslandBasePage"))

function IslandBaseDressupPage:Preload(arg_1_1)
	self:PrepareCharacterScene(arg_1_1)

	return
end

function IslandBaseDressupPage:PrepareCharacterScene(arg_2_1)
	self.isLoadCharacterScene = true

	seriesAsync({
		function(arg_3_0)
			self:LoadCharacterScene(arg_3_0)

			return
		end,
		function(arg_4_0)
			self:CreateCharacterContainer()
			self:ModifyCameraMask()
			onNextTick(function()
				self:ActivityCharacterCamera()

				return
			end)
			arg_4_0()

			return
		end
	}, arg_2_1)

	return
end

function IslandBaseDressupPage:LoadCharacterScene(arg_6_1)
	SceneOpMgr.Inst:LoadSceneAsyncWithProgress("island/scenesres/scenes/character/map_ship_dressup_scene", "map_ship_dressup", LoadSceneMode.Additive, function(arg_7_0)
		if arg_7_0 == 1 then
			SceneOpMgr.Inst:SetActiveSceneByIndex(1)
			arg_6_1()
		end

		return
	end)

	return
end

function IslandBaseDressupPage:CreateCharacterContainer()
	self.roleContainer = GameObject.New("roleContainer").transform

	pg.ViewUtils.SetLayer(self.roleContainer, Layer.Character3D)

	return
end

function IslandBaseDressupPage:ModifyCameraMask()
	self.defaultCullingMask = IslandCameraMgr.instance._mainCamera.cullingMask

	LuaHelper.SetCamCullingMask(IslandCameraMgr.instance._mainCamera, "Character3D")

	return
end

function IslandBaseDressupPage:ActivityCharacterCamera()
	local var_10_0 = self:GetActiveCamName()
	local var_10_1 = IslandCameraMgr.instance:GetVirtualCamera(var_10_0)

	var_10_1.Follow = self.roleContainer
	var_10_1.LookAt = self.roleContainer

	IslandCameraMgr.instance:ActiveVirtualCamera(var_10_0)

	return
end

function IslandBaseDressupPage:GetActiveCamName()
	return IslandConst.DRESSUP_CAMERA_NAME
end

function IslandBaseDressupPage:UnLoadCharacterScene(arg_12_1)
	SceneOpMgr.Inst:UnloadSceneAsync("island/scenesres/scenes/character/map_ship_dressup_scene", "map_ship_dressup", function()
		if arg_12_1 then
			arg_12_1()
		end

		return
	end)

	return
end

function IslandBaseDressupPage:ClearCharacterScene(arg_14_1)
	if self.isLoadCharacterScene then
		self:UnLoadCharacterScene(arg_14_1)
		self:ClearCharacterContainer()
	end

	self.isLoadCharacterScene = false

	return
end

function IslandBaseDressupPage:ClearCharacterContainer()
	self:UnloadCharacter()

	if self.roleContainer then
		Object.Destroy(self.roleContainer.gameObject)

		self.roleContainer = nil
	end

	return
end

function IslandBaseDressupPage:LoadCharacter(arg_16_1)
	self:UnloadCharacter()
	self:GetPoolMgr():GetCommanderModel(arg_16_1, function(arg_17_0)
		self.role = arg_17_0

		pg.ViewUtils.SetLayer(self.role.transform, Layer.Character3D)
		setParent(self.role, self.roleContainer)

		self.role.transform.eulerAngles = Vector3(0, 180, 0)

		IslandCameraMgr.instance:CinemachineComposerTrackObjOffset(self:GetActiveCamName(), Vector3(0.9 - (1.7777777777777777 - Screen.width / Screen.height) * 0.5, 1, 0))

		self.role.transform.localPosition = Vector3(0, 0, 0)

		local var_17_0 = GetOrAddComponent(self:GetSmoothRotateObject(), typeof(SmoothRotateObject))

		var_17_0:SetUp(self.role.transform)

		var_17_0.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		self:OnCharLoaded()
		GetOrAddComponent(self.role, typeof(CharacterFootprintMgr)):SetSpawnMode(1)

		return
	end)

	return
end

function IslandBaseDressupPage:UnloadCharacter()
	local var_18_0 = self:GetSmoothRotateObject():GetComponent(typeof(SmoothRotateObject))

	if var_18_0 then
		Object.Destroy(var_18_0)
	end

	if self.role then
		self:GetPoolMgr():ReturnCommanderModel(self.role)

		self.role = nil
	end

	return
end

function IslandBaseDressupPage:Hide()
	IslandBaseDressupPage.super.Hide(self)

	return
end

function IslandBaseDressupPage:OnDestroy()
	self:ClearCharacterScene()

	for iter_20_0, iter_20_1 in pairs(self.cards or {}) do
		iter_20_1:Dispose()
	end

	self.cards = nil

	return
end

return IslandBaseDressupPage
