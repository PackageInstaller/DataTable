local WSAtlasWorld = class("WSAtlasWorld", import(".WSAtlas"))

WSAtlasWorld.Fields = {
	isDragging = "boolean",
	tfAreaScene = "userdata",
	wsTimer = "table",
	tfMapModel = "userdata",
	nowArea = "number",
	dragTrigger = "userdata",
	tfModel = "userdata",
	twRotateId = "number",
	isTransAnim = "boolean",
	areaLockPressingAward = "table",
	entranceTplDic = "table",
	twFocusIds = "table"
}
WSAtlasWorld.Listeners = {
	onUpdatePressingAward = "OnUpdatePressingAward",
	onUpdatePortMark = "OnUpdatePortMark",
	onUpdateActiveEntrance = "OnUpdateActiveEntrance",
	onUpdateProgress = "OnUpdateProgress"
}
WSAtlasWorld.EventUpdateselectEntrance = "WSAtlasWorld.EventUpdateselectEntrance"
WSAtlasWorld.baseDistance = -217.4
WSAtlasWorld.frontDistance = -101.6237
WSAtlasWorld.basePoint = Vector2(1024, 550)
WSAtlasWorld.baseMoveDistance = 100
WSAtlasWorld.baseDuration = 0.8
WSAtlasWorld.selectOffsetPos = Vector2(107, 61)

function WSAtlasWorld:Dispose()
	self:DisposeEntranceTplDic()
	WSAtlasWorld.super.Dispose(self)

	return
end

function WSAtlasWorld:Init()
	WSAtlasWorld.super.Init(self)

	self.entranceTplDic = {}
	self.twFocusIds = {}
	self.areaLockPressingAward = {}

	return
end

function WSAtlasWorld:UpdateAtlas(arg_3_1)
	if self.atlas ~= arg_3_1 then
		self:RemoveAtlasListener()
		self:DisposeEntranceTplDic()

		self.atlas = arg_3_1

		self:AddAtlasListener()
		self:NewEntranceTplDic()
		self:UpdateModelMask()
		self:OnUpdateActiveEntrance(nil, nil, self.atlas:GetActiveEntrance())
		self:OnUpdatePressingAward()
	end

	return
end

function WSAtlasWorld:AddAtlasListener()
	if self.atlas then
		self.atlas:AddListener(WorldAtlas.EventUpdatePortMark, self.onUpdatePortMark)
	end

	WSAtlasWorld.super.AddAtlasListener(self)

	return
end

function WSAtlasWorld:RemoveAtlasListener()
	if self.atlas then
		self.atlas:RemoveListener(WorldAtlas.EventUpdatePortMark, self.onUpdatePortMark)
	end

	WSAtlasWorld.super.RemoveAtlasListener(self)

	return
end

function WSAtlasWorld:LoadModel(arg_6_1)
	local var_6_0 = {}

	if not self.tfModel then
		table.insert(var_6_0, function(arg_7_0)
			local var_7_0 = PoolMgr.GetInstance()

			var_7_0:GetPrefab("model/worldmapmodel", "WorldMapModel", true, function(arg_8_0)
				if self.transform then
					self.tfModel = tf(arg_8_0)

					setParent(self.tfModel, self.tfMapModel, false)
				else
					var_7_0:ReturnPrefab("model/worldmapmodel", "WorldMapModel", arg_8_0, true)
				end

				return arg_7_0()
			end)

			return
		end)
	end

	seriesAsync(var_6_0, function()
		return existCall(arg_6_1)
	end)

	return
end

function WSAtlasWorld:ReturnModel()
	if self.tfModel then
		PoolMgr.GetInstance():ReturnPrefab("model/worldmapmodel", "WorldMapModel", go(self.tfModel), true)
	end

	return
end

function WSAtlasWorld:LoadScene(arg_11_1)
	gcAll(true)
	SceneOpMgr.Inst:LoadSceneAsync("scenes/worldmap3d", "WorldMap3D", LoadSceneMode.Additive, function(arg_12_0, arg_12_1)
		self.transform = tf(arg_12_0:GetRootGameObjects()[0])

		setActive(self.transform, false)

		self.tfEntity = self.transform:Find("entity")
		self.tfAreaScene = self.tfEntity:Find("area_scene")
		self.tfMapScene = self.tfEntity:Find("map_scene")
		self.tfMapModel = self.tfEntity:Find("model")
		self.tfMapSelect = self.tfMapScene:Find("selected_layer")
		self.tfSpriteScene = self.tfEntity:Find("sprite_scene")
		self.tfCamera = self.transform:Find("Main Camera")
		self.tfCamera:GetComponent("Camera").depthTextureMode = UnityEngine.DepthTextureMode.Depth
		self.defaultSprite = self.tfEntity:Find("decolation_layer/edge"):GetComponent("SpriteRenderer").material
		self.addSprite = self.tfEntity:Find("map_scene/mask_layer"):GetComponent("SpriteRenderer").material

		local var_12_0 = math.deg2Rad * 30
		local var_12_1 = self.frontDistance / UnityEngine.Screen.height

		self.dragTrigger = self.tfEntity:Find("Plane"):GetComponent("EventTriggerListener")

		self.dragTrigger:AddDragFunc(function(arg_13_0, arg_13_1)
			self.isDragging = true

			if not self.nowArea or self:CheckIsTweening() then
				return
			end

			if self.selectEntrance then
				self:UpdateSelect()
			end

			self.tfCamera.localPosition = self.tfCamera.localPosition + Vector3(arg_13_1.delta.x, 0, arg_13_1.delta.y / math.cos(var_12_0)) * var_12_1

			return
		end)
		self.dragTrigger:AddDragEndFunc(function(arg_14_0, arg_14_1)
			self.isDragging = false

			return
		end)
		self:UpdateCenterEffectDisplay()
		self:BuildActiveMark()

		local var_12_2 = nowWorld()

		self.cmPointer = self.tfEntity:Find("Plane"):GetComponent(typeof(PointerInfo))

		self.cmPointer:AddColorMaskClickListener(function(arg_15_0, arg_15_1)
			if self.isDragging then
				return
			end

			local var_15_0 = var_12_2:ColorToEntrance(arg_15_0)

			if var_15_0 then
				self.onClickColor(var_15_0, arg_15_1.position)
			end

			return
		end)

		return existCall(arg_11_1)
	end)

	return
end

function WSAtlasWorld:ReturnScene()
	self:ReturnModel()

	if self.transform then
		local var_16_0 = self.tfMapScene:GetComponent("FMultiSpriteRenderCtrl")

		var_16_0.alpha = 1

		var_16_0:UpdateAlpha()

		local var_16_1 = self.tfAreaScene:GetComponent("FMultiSpriteRenderCtrl")

		var_16_1.alpha = 1

		var_16_1:UpdateAlpha()
		SceneOpMgr.Inst:UnloadSceneAsync("scene/worldmap3d", "WorldMap3D")

		self.cmPointer = nil
	end

	return
end

function WSAtlasWorld:ShowOrHide(arg_17_1)
	WSAtlasWorld.super.ShowOrHide(self, arg_17_1)

	if arg_17_1 then
		SceneManager.SetActiveScene(SceneManager.GetSceneByName("WorldMap3D"))
	else
		SceneManager.SetActiveScene(SceneManager.GetSceneByName("main"))
	end

	return
end

function WSAtlasWorld:GetOffsetMapPos()
	local var_18_0 = math.rad(-self.tfEntity.localEulerAngles.y)

	return Vector2(WSAtlasWorld.selectOffsetPos.x * math.cos(var_18_0) - WSAtlasWorld.selectOffsetPos.y * math.sin(var_18_0), WSAtlasWorld.selectOffsetPos.y * math.cos(var_18_0) + WSAtlasWorld.selectOffsetPos.x * math.sin(var_18_0))
end

function WSAtlasWorld:UpdateSelect(arg_19_1, arg_19_2, arg_19_3)
	if arg_19_1 then
		self.nowArea = arg_19_1:GetAreaId()

		self:FocusPos(Vector2(arg_19_1.config.area_pos[1], arg_19_1.config.area_pos[2]) + self:GetOffsetMapPos(), nil, 1, true, function()
			WSAtlasWorld.super.UpdateSelect(self, arg_19_1)
			self:DispatchEvent(WSAtlasWorld.EventUpdateselectEntrance, arg_19_1, arg_19_2, arg_19_3)

			return
		end)
	else
		WSAtlasWorld.super.UpdateSelect(self, arg_19_1)
		self:DispatchEvent(WSAtlasWorld.EventUpdateselectEntrance, arg_19_1, arg_19_2, arg_19_3)
	end

	return
end

function WSAtlasWorld:UpdateModelMask()
	WSAtlasWorld.super.UpdateModelMask(self)
	self:UpdateAreaLock()

	return
end

function WSAtlasWorld:UpdateEntranceMask(arg_22_1)
	if arg_22_1:HasPort() then
		self.entranceTplDic[arg_22_1.id]:UpdatePort(self.atlas:GetEntrancePortInfo(arg_22_1.id))
	end

	WSAtlasWorld.super.UpdateEntranceMask(self, arg_22_1)

	return
end

function WSAtlasWorld:OnUpdateProgress(arg_23_1, arg_23_2, arg_23_3)
	WSAtlasWorld.super.OnUpdateProgress(self, arg_23_1, arg_23_2, arg_23_3)
	self:UpdateAreaLock()

	return
end

function WSAtlasWorld:UpdateAreaLock()
	for iter_24_0 = 1, 5 do
		local var_24_0 = nowWorld():CheckAreaUnlock(iter_24_0)

		setActive(self.tfAreaScene:Find("lock_layer/" .. iter_24_0), not var_24_0)
		setActive(self.tfMapScene:Find("mask_layer/" .. iter_24_0), var_24_0)

		if var_24_0 and self.areaLockPressingAward[iter_24_0] then
			for iter_24_1, iter_24_2 in ipairs(self.areaLockPressingAward[iter_24_0]) do
				self.entranceTplDic[iter_24_2]:UpdatePressingAward()
			end

			self.areaLockPressingAward[iter_24_0] = nil
		end
	end

	return
end

function WSAtlasWorld:OnUpdateActiveEntrance(arg_25_1, arg_25_2, arg_25_3)
	WSAtlasWorld.super.OnUpdateActiveEntrance(self, arg_25_1, arg_25_2, arg_25_3)

	if arg_25_3 then
		local var_25_0 = arg_25_3:HasPort()

		self:DoUpdatExtraMark(self.tfActiveMark, "mark_active_1", not var_25_0)
		self:DoUpdatExtraMark(self.tfActiveMark, "mark_active_port", var_25_0)
	end

	local var_25_1 = arg_25_3 and arg_25_3:GetAreaId()

	for iter_25_0 = 1, 5 do
		setActive(self.tfAreaScene:Find("selected_layer/B" .. iter_25_0 .. "_2"), iter_25_0 == var_25_1)
		setActive(self.tfAreaScene:Find("base_layer/B" .. iter_25_0), iter_25_0 ~= var_25_1)
	end

	return
end

function WSAtlasWorld:OnUpdatePressingAward(arg_26_1, arg_26_2, arg_26_3)
	arg_26_3 = arg_26_3 or self.atlas.transportDic

	for iter_26_0, iter_26_1 in pairs(arg_26_3) do
		if iter_26_1 then
			local var_26_0 = self.atlas:GetEntrance(iter_26_0):GetAreaId()

			if nowWorld():CheckAreaUnlock(var_26_0) then
				self.entranceTplDic[iter_26_0]:UpdatePressingAward()
			else
				self.areaLockPressingAward[var_26_0] = self.areaLockPressingAward[var_26_0] or {}

				table.insert(self.areaLockPressingAward[var_26_0], iter_26_0)
			end
		end
	end

	WSAtlasWorld.super.OnUpdatePressingAward(self, arg_26_1, arg_26_2, arg_26_3)

	return
end

function WSAtlasWorld:OnUpdatePortMark(arg_27_1, arg_27_2, arg_27_3)
	for iter_27_0, iter_27_1 in pairs(arg_27_3) do
		if iter_27_1 then
			self.entranceTplDic[iter_27_0]:UpdatePort(self.atlas:GetEntrancePortInfo(iter_27_0))
		end
	end

	return
end

function WSAtlasWorld:NewEntranceTplDic()
	for iter_28_0, iter_28_1 in pairs(self.atlas.entranceDic) do
		self.entranceTplDic[iter_28_1.id] = self:NewEntranceTpl(iter_28_1)
	end

	return
end

function WSAtlasWorld:DisposeEntranceTplDic()
	WPool:ReturnArray(_.values(self.entranceTplDic))

	self.entranceTplDic = {}

	return
end

function WSAtlasWorld:NewEntranceTpl(arg_30_1)
	local var_30_0 = WPool:Get(WSEntranceTpl)

	var_30_0.transform:SetParent(self.tfSpriteScene, false)

	var_30_0.transform.localPosition = WorldConst.CalcModelPosition(arg_30_1, self.spriteBaseSize)
	var_30_0.tfArea = self.tfAreaScene:Find("display_layer")
	var_30_0.tfMap = self.tfMapScene:Find("display_layer")

	var_30_0:Setup()
	var_30_0:UpdateEntrance(arg_30_1)

	return var_30_0
end

function WSAtlasWorld:FindEntranceTpl(arg_31_1)
	return self.entranceTplDic[arg_31_1.id]
end

function WSAtlasWorld:UpdateScale(arg_32_1)
	local var_32_0

	if not arg_32_1 then
		arg_32_1 = 0
		var_32_0 = WSAtlasWorld.baseDistance * (1 - arg_32_1) + self.frontDistance * arg_32_1 - self.tfCamera.localPosition.y / -math.sin(self.tfCamera.localEulerAngles.x / 180 * math.pi)
	end

	self.tfCamera.localPosition = self.tfCamera.localPosition + Vector3(0, -math.sin(self.tfCamera.localEulerAngles.x / 180 * math.pi) * var_32_0, math.cos(self.tfCamera.localEulerAngles.x / 180 * math.pi) * var_32_0)

	return
end

function WSAtlasWorld:FocusPos(arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	local var_33_9000

	if self.twRotateId then
		LeanTween.cancel(self.twRotateId)

		self.twRotateId = nil
	end

	arg_33_3 = arg_33_3 or 0
	arg_33_2 = 0

	if not arg_33_1 then
		local var_33_0 = math.rad(-arg_33_2)

		arg_33_1 = WSAtlasWorld.basePoint - WSAtlasWorld.spriteBaseSize / 2
		arg_33_1 = Vector2((WSAtlasWorld.basePoint - WSAtlasWorld.spriteBaseSize / 2).x * math.cos(var_33_0) - (WSAtlasWorld.basePoint - WSAtlasWorld.spriteBaseSize / 2).y * math.sin(var_33_0), (WSAtlasWorld.basePoint - WSAtlasWorld.spriteBaseSize / 2).y * math.cos(var_33_0) + (WSAtlasWorld.basePoint - WSAtlasWorld.spriteBaseSize / 2).x * math.sin(var_33_0))
		arg_33_1 = WSAtlasWorld.basePoint - WSAtlasWorld.spriteBaseSize / 2 + WSAtlasWorld.spriteBaseSize / 2
	end

	local var_33_1 = math.rad(self.tfEntity.localEulerAngles.y - arg_33_2)

	arg_33_1 = arg_33_1 - WSAtlasWorld.spriteBaseSize / 2
	arg_33_1 = Vector2(arg_33_1.x * math.cos(var_33_1) - arg_33_1.y * math.sin(var_33_1), arg_33_1.y * math.cos(var_33_1) + arg_33_1.x * math.sin(var_33_1))

	local var_33_2 = self.transform:InverseTransformPoint(self.tfSpriteScene:TransformPoint(Vector3(arg_33_1.x, 0, arg_33_1.y) / PIXEL_PER_UNIT))
	local var_33_3 = math.rad(self.tfCamera.localEulerAngles.x)
	local var_33_4 = WSAtlasWorld.baseDistance * (1 - arg_33_3) + WSAtlasWorld.frontDistance * arg_33_3 - Vector3(0, var_33_2.y, var_33_2.y / -math.tan(var_33_3)).y / -math.sin(var_33_3)
	local var_33_5 = var_33_2 - var_33_9000 + Vector3(0, self.tfCamera.localPosition.y, self.tfCamera.localPosition.y / -math.tan(var_33_3)) + Vector3(0, -math.sin(var_33_3) * var_33_4, math.cos(var_33_3) * var_33_4)

	if arg_33_4 then
		local var_33_6 = math.min(Vector3.Distance(self.tfCamera.localPosition, var_33_5) / WSAtlasWorld.baseMoveDistance, 1) * WSAtlasWorld.baseDuration
		local var_33_7 = math.min(math.abs(arg_33_2 - self.tfEntity.localEulerAngles.y) / 180, 1) * WSAtlasWorld.baseDuration
		local var_33_8 = {}

		table.insert(var_33_8, function(arg_34_0)
			local var_34_0 = LeanTween.moveLocal(go(self.tfCamera), var_33_5, var_33_6):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_34_0)).uniqueId

			table.insert(self.twFocusIds, var_34_0)
			self.wsTimer:AddTween(var_34_0)

			return
		end)
		table.insert(var_33_8, function(arg_35_0)
			local var_35_0 = LeanTween.rotateY(go(self.tfEntity), arg_33_2, var_33_7):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_35_0)).uniqueId

			table.insert(self.twFocusIds, var_35_0)
			self.wsTimer:AddTween(var_35_0)

			return
		end)
		parallelAsync(var_33_8, function()
			existCall(arg_33_5)

			return
		end)
	else
		self.tfCamera.localPosition = var_33_5
		self.tfEntity.localEulerAngles = Vector3(0, arg_33_2, 0)

		return existCall(arg_33_5)
	end

	return
end

function WSAtlasWorld:FocusPosInArea(arg_37_1, arg_37_2, arg_37_3)
	if arg_37_1 then
		self:FocusPos(Vector2(pg.world_regions_data[arg_37_1].regions_pos[1], pg.world_regions_data[arg_37_1].regions_pos[2]), pg.world_regions_data[arg_37_1].regions_rotation[1], 1, arg_37_2, arg_37_3)
	else
		self:FocusPos(WSAtlasWorld.basePoint, 0, 0, arg_37_2, arg_37_3)
	end

	return
end

function WSAtlasWorld:SwitchArea(arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = {}

	if arg_38_2 and tobool(arg_38_1) ~= tobool(self.nowArea) then
		table.insert(var_38_0, function(arg_39_0)
			self:SwitchMode(arg_38_1, arg_38_2, arg_39_0)

			return
		end)
	end

	table.insert(var_38_0, function(arg_40_0)
		setActive(self.tfAreaScene, not arg_38_1)
		setActive(self.tfMapScene, arg_38_1)
		setActive(self.tfMapModel, not arg_38_1)
		arg_40_0()

		return
	end)

	self.nowArea = arg_38_1

	parallelAsync({
		function(arg_41_0)
			seriesAsync(var_38_0, arg_41_0)

			return
		end,
		function(arg_42_0)
			self:FocusPosInArea(arg_38_1, arg_38_2, arg_42_0)

			return
		end
	}, function()
		return existCall(arg_38_3)
	end)

	return
end

function WSAtlasWorld:SwitchMode(arg_44_1, arg_44_2, arg_44_3)
	local function var_44_0()
		self:BreathRotate(not arg_44_1)

		return existCall(arg_44_3)
	end

	if arg_44_2 then
		parallelAsync({
			function(arg_45_0)
				setActive(self.tfAreaScene, true)

				local var_45_0 = self.tfAreaScene:GetComponent("FMultiSpriteRenderCtrl")

				var_45_0:Init()

				var_45_0.alpha = arg_44_1 and 1 or 0

				var_45_0:UpdateAlpha()

				local var_45_1 = LeanTween.value(go(self.tfAreaScene), arg_44_1 and 1 or 0, arg_44_1 and 0 or 1, WSAtlasWorld.baseDuration):setOnUpdate(System.Action_float(function(arg_46_0)
					var_45_0.alpha = arg_46_0

					return
				end)):setOnComplete(System.Action(function()
					var_45_0.alpha = 1

					var_45_0:UpdateAlpha()
					setActive(self.tfAreaScene, not arg_44_1)

					return arg_45_0()
				end)).uniqueId

				table.insert(self.twFocusIds, var_45_1)
				self.wsTimer:AddTween(var_45_1)

				return
			end,
			function(arg_48_0)
				setActive(self.tfMapScene, true)

				local var_48_0 = self.tfMapScene:GetComponent("FMultiSpriteRenderCtrl")

				var_48_0:Init()

				var_48_0.alpha = arg_44_1 and 0 or 1

				var_48_0:UpdateAlpha()

				local var_48_1 = LeanTween.value(go(self.tfMapScene), arg_44_1 and 0 or 1, arg_44_1 and 1 or 0, WSAtlasWorld.baseDuration):setOnUpdate(System.Action_float(function(arg_49_0)
					var_48_0.alpha = arg_49_0

					return
				end)):setOnComplete(System.Action(function()
					var_48_0.alpha = 1

					var_48_0:UpdateAlpha()
					setActive(self.tfMapScene, arg_44_1)

					return arg_48_0()
				end)).uniqueId

				table.insert(self.twFocusIds, var_48_1)
				self.wsTimer:AddTween(var_48_1)

				return
			end,
			function(arg_51_0)
				setActive(self.tfMapModel, true)

				local var_51_0 = {}
				local var_51_1 = WSAtlasWorld.baseDuration

				table.insert(var_51_0, function(arg_52_0)
					local var_52_0 = self.tfModel:Find("Terrain_LOD9_perfect")
					local var_52_1 = var_52_0:GetComponent("MeshRenderer").material

					var_52_1:SetFloat("_Invisible", arg_44_1 and 1 or 0)

					local var_52_2 = LeanTween.value(go(var_52_0), arg_44_1 and 1 or 0, arg_44_1 and 0 or 1, var_51_1):setOnUpdate(System.Action_float(function(arg_53_0)
						var_52_1:SetFloat("_Invisible", arg_53_0)

						return
					end)):setOnComplete(System.Action(function()
						var_52_1:SetFloat("_Invisible", arg_44_1 and 0 or 1)
						arg_52_0()

						return
					end)).uniqueId

					table.insert(self.twFocusIds, var_52_2)
					self.wsTimer:AddTween(var_52_2)

					return
				end)
				table.insert(var_51_0, function(arg_55_0)
					local var_55_0 = self.tfModel:Find("decolation_model")
					local var_55_1 = var_55_0:GetComponent("FMultiSpriteRenderCtrl")

					var_55_1:Init()

					var_55_1.alpha = arg_44_1 and 1 or 0

					var_55_1:UpdateAlpha()

					local var_55_2 = LeanTween.value(go(var_55_0), arg_44_1 and 1 or 0, arg_44_1 and 0 or 1, var_51_1):setOnUpdate(System.Action_float(function(arg_56_0)
						var_55_1.alpha = arg_56_0

						return
					end)):setOnComplete(System.Action(function()
						var_55_1.alpha = 1

						var_55_1:UpdateAlpha()
						arg_55_0()

						return
					end)).uniqueId

					table.insert(self.twFocusIds, var_55_2)
					self.wsTimer:AddTween(var_55_2)

					return
				end)
				parallelAsync(var_51_0, function()
					setActive(self.tfMapModel, not arg_44_1)

					return arg_51_0()
				end)

				return
			end
		}, function()
			return var_44_0()
		end)
	else
		return var_44_0()
	end

	return
end

WSAtlasWorld.LowRotation = -5
WSAtlasWorld.HeightRotation = 5
WSAtlasWorld.BreathTime = 18

function WSAtlasWorld:BreathRotate(arg_61_1)
	if self.twRotateId then
		LeanTween.cancel(self.twRotateId)

		self.twRotateId = nil
	end

	if not arg_61_1 then
		return
	end

	local var_61_0 = -1

	local function var_61_1()
		var_61_0 = -1 * var_61_0
		self.twRotateId = LeanTween.rotateY(go(self.tfEntity), (var_61_0 == 1 or nil) and (WSAtlasWorld.HeightRotation or WSAtlasWorld.LowRotation), WSAtlasWorld.BreathTime):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(function()
			var_61_1()

			return
		end)).uniqueId

		return
	end

	self.twRotateId = LeanTween.rotateY(go(self.tfEntity), WSAtlasWorld.LowRotation, WSAtlasWorld.BreathTime / 2):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(function()
		var_61_1()

		return
	end)):setDelay(1).uniqueId

	return
end

function WSAtlasWorld:CheckIsTweening()
	while #self.twFocusIds > 0 and not LeanTween.isTweening(self.twFocusIds[1]) do
		table.remove(self.twFocusIds, 1)
	end

	return self.isTransAnim or #self.twFocusIds > 0
end

function WSAtlasWorld:ActiveTrans(arg_66_1)
	if self.entranceTplDic[arg_66_1.id].portCamp then
		-- block empty
	else
		local var_66_0 = self.tfMapSelect:Find("A" .. arg_66_1:GetColormaskUniqueID() .. "_2")

		setActive(var_66_0, true)

		local var_66_1 = var_66_0:GetComponent("SpriteRenderer").color

		var_66_1.a = 0
		var_66_0:GetComponent("SpriteRenderer").color = var_66_1

		LeanTween.alpha(go(var_66_0), 1, 0.3):setOnComplete(System.Action(function()
			LeanTween.alpha(go(var_66_0), 0, 0.2):setDelay(0.1):setOnComplete(System.Action(function()
				setActive(var_66_0, self.selectEntrance == arg_66_1)

				var_66_1.a = 1
				var_66_0:GetComponent("SpriteRenderer").color = var_66_1

				return
			end))

			return
		end))
	end

	return
end

function WSAtlasWorld:DisplayTransport(arg_69_1, arg_69_2)
	local var_69_0 = {}

	for iter_69_0, iter_69_1 in pairs(self.atlas.transportDic) do
		if iter_69_1 and not arg_69_1[iter_69_0] then
			var_69_0[iter_69_0] = true
		end
	end

	self:UpdateTransMark(var_69_0, arg_69_2)

	return
end

function WSAtlasWorld:UpdateTransMark(arg_70_1, arg_70_2)
	for iter_70_0, iter_70_1 in pairs(arg_70_1) do
		if iter_70_1 then
			self.isTransAnim = true

			self:ActiveTrans(self.atlas:GetEntrance(iter_70_0))
		end
	end

	if self.isTransAnim then
		self.wsTimer:AddTimer(function()
			self.isTransAnim = false

			arg_70_2()

			return
		end, 0.6):Start()
	else
		arg_70_2()
	end

	return
end

function WSAtlasWorld:UpdateActiveMark()
	local var_72_0 = nowWorld():GetActiveMap():CkeckTransport()

	eachChild(self.tfActiveMark, function(arg_73_0)
		setActive(arg_73_0:Find("base"), var_72_0)
		setActive(arg_73_0:Find("limit"), not var_72_0)

		return
	end)

	return
end

return WSAtlasWorld
