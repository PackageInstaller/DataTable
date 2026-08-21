local var_0_0 = class("WSAtlasWorld", import(".WSAtlas"))

var_0_0.Fields = {
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
var_0_0.Listeners = {
	onUpdatePressingAward = "OnUpdatePressingAward",
	onUpdatePortMark = "OnUpdatePortMark",
	onUpdateActiveEntrance = "OnUpdateActiveEntrance",
	onUpdateProgress = "OnUpdateProgress"
}
var_0_0.EventUpdateselectEntrance = "WSAtlasWorld.EventUpdateselectEntrance"
var_0_0.baseDistance = -217.4
var_0_0.frontDistance = -101.6237
var_0_0.basePoint = Vector2(1024, 550)
var_0_0.baseMoveDistance = 100
var_0_0.baseDuration = 0.8
var_0_0.selectOffsetPos = Vector2(107, 61)

function var_0_0.Dispose(arg_1_0)
	arg_1_0:DisposeEntranceTplDic()
	var_0_0.super.Dispose(arg_1_0)

	return
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.entranceTplDic = {}
	arg_2_0.twFocusIds = {}
	arg_2_0.areaLockPressingAward = {}

	return
end

function var_0_0.UpdateAtlas(arg_3_0, arg_3_1)
	if arg_3_0.atlas ~= arg_3_1 then
		arg_3_0:RemoveAtlasListener()
		arg_3_0:DisposeEntranceTplDic()

		arg_3_0.atlas = arg_3_1

		arg_3_0:AddAtlasListener()
		arg_3_0:NewEntranceTplDic()
		arg_3_0:UpdateModelMask()
		arg_3_0:OnUpdateActiveEntrance(nil, nil, arg_3_0.atlas:GetActiveEntrance())
		arg_3_0:OnUpdatePressingAward()
	end

	return
end

function var_0_0.AddAtlasListener(arg_4_0)
	if arg_4_0.atlas then
		arg_4_0.atlas:AddListener(WorldAtlas.EventUpdatePortMark, arg_4_0.onUpdatePortMark)
	end

	var_0_0.super.AddAtlasListener(arg_4_0)

	return
end

function var_0_0.RemoveAtlasListener(arg_5_0)
	if arg_5_0.atlas then
		arg_5_0.atlas:RemoveListener(WorldAtlas.EventUpdatePortMark, arg_5_0.onUpdatePortMark)
	end

	var_0_0.super.RemoveAtlasListener(arg_5_0)

	return
end

function var_0_0.LoadModel(arg_6_0, arg_6_1)
	if not arg_6_0.tfModel then
		table.insert({}, function(arg_7_0)
			local var_7_0 = PoolMgr.GetInstance()

			PoolMgr.GetInstance():GetPrefab("model/worldmapmodel", "WorldMapModel", true, function(arg_8_0)
				if arg_6_0.transform then
					arg_6_0.tfModel = tf(arg_8_0)

					setParent(arg_6_0.tfModel, arg_6_0.tfMapModel, false)
				else
					var_7_0:ReturnPrefab("model/worldmapmodel", "WorldMapModel", arg_8_0, true)
				end

				return arg_7_0()
			end)

			return
		end)
	end

	seriesAsync({}, function()
		return existCall(arg_6_1)
	end)

	return
end

function var_0_0.ReturnModel(arg_10_0)
	if arg_10_0.tfModel then
		PoolMgr.GetInstance():ReturnPrefab("model/worldmapmodel", "WorldMapModel", go(arg_10_0.tfModel), true)
	end

	return
end

function var_0_0.LoadScene(arg_11_0, arg_11_1)
	gcAll(true)
	SceneOpMgr.Inst:LoadSceneAsync("scenes/worldmap3d", "WorldMap3D", LoadSceneMode.Additive, function(arg_12_0, arg_12_1)
		arg_11_0.transform = tf(arg_12_0:GetRootGameObjects()[0])

		setActive(arg_11_0.transform, false)

		arg_11_0.tfEntity = arg_11_0.transform:Find("entity")
		arg_11_0.tfAreaScene = arg_11_0.tfEntity:Find("area_scene")
		arg_11_0.tfMapScene = arg_11_0.tfEntity:Find("map_scene")
		arg_11_0.tfMapModel = arg_11_0.tfEntity:Find("model")
		arg_11_0.tfMapSelect = arg_11_0.tfMapScene:Find("selected_layer")
		arg_11_0.tfSpriteScene = arg_11_0.tfEntity:Find("sprite_scene")
		arg_11_0.tfCamera = arg_11_0.transform:Find("Main Camera")
		arg_11_0.tfCamera:GetComponent("Camera").depthTextureMode = UnityEngine.DepthTextureMode.Depth
		arg_11_0.defaultSprite = arg_11_0.tfEntity:Find("decolation_layer/edge"):GetComponent("SpriteRenderer").material
		arg_11_0.addSprite = arg_11_0.tfEntity:Find("map_scene/mask_layer"):GetComponent("SpriteRenderer").material

		local var_12_0 = math.deg2Rad * 30
		local var_12_1 = arg_11_0.frontDistance / UnityEngine.Screen.height

		arg_11_0.dragTrigger = arg_11_0.tfEntity:Find("Plane"):GetComponent("EventTriggerListener")

		arg_11_0.dragTrigger:AddDragFunc(function(arg_13_0, arg_13_1)
			arg_11_0.isDragging = true

			if not arg_11_0.nowArea or arg_11_0:CheckIsTweening() then
				return
			end

			if arg_11_0.selectEntrance then
				arg_11_0:UpdateSelect()
			end

			arg_11_0.tfCamera.localPosition = arg_11_0.tfCamera.localPosition + Vector3(arg_13_1.delta.x, 0, arg_13_1.delta.y / math.cos(var_12_0)) * var_12_1

			return
		end)
		arg_11_0.dragTrigger:AddDragEndFunc(function(arg_14_0, arg_14_1)
			arg_11_0.isDragging = false

			return
		end)
		arg_11_0:UpdateCenterEffectDisplay()
		arg_11_0:BuildActiveMark()

		local var_12_2 = nowWorld()

		arg_11_0.cmPointer = arg_11_0.tfEntity:Find("Plane"):GetComponent(typeof(PointerInfo))

		arg_11_0.cmPointer:AddColorMaskClickListener(function(arg_15_0, arg_15_1)
			if arg_11_0.isDragging then
				return
			end

			local var_15_0 = var_12_2:ColorToEntrance(arg_15_0)

			if var_15_0 then
				arg_11_0.onClickColor(var_15_0, arg_15_1.position)
			end

			return
		end)

		return existCall(arg_11_1)
	end)

	return
end

function var_0_0.ReturnScene(arg_16_0)
	arg_16_0:ReturnModel()

	if arg_16_0.transform then
		local var_16_0 = arg_16_0.tfMapScene:GetComponent("FMultiSpriteRenderCtrl")

		var_16_0.alpha = 1

		var_16_0:UpdateAlpha()

		local var_16_1 = arg_16_0.tfAreaScene:GetComponent("FMultiSpriteRenderCtrl")

		var_16_1.alpha = 1

		var_16_1:UpdateAlpha()
		SceneOpMgr.Inst:UnloadSceneAsync("scene/worldmap3d", "WorldMap3D")

		arg_16_0.cmPointer = nil
	end

	return
end

function var_0_0.ShowOrHide(arg_17_0, arg_17_1)
	var_0_0.super.ShowOrHide(arg_17_0, arg_17_1)

	if arg_17_1 then
		SceneManager.SetActiveScene(SceneManager.GetSceneByName("WorldMap3D"))
	else
		SceneManager.SetActiveScene(SceneManager.GetSceneByName("main"))
	end

	return
end

function var_0_0.GetOffsetMapPos(arg_18_0)
	local var_18_0 = math.rad(-arg_18_0.tfEntity.localEulerAngles.y)

	return Vector2(var_0_0.selectOffsetPos.x * math.cos(var_18_0) - var_0_0.selectOffsetPos.y * math.sin(var_18_0), var_0_0.selectOffsetPos.y * math.cos(var_18_0) + var_0_0.selectOffsetPos.x * math.sin(var_18_0))
end

function var_0_0.UpdateSelect(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_1 then
		arg_19_0.nowArea = arg_19_1:GetAreaId()

		arg_19_0:FocusPos(Vector2(arg_19_1.config.area_pos[1], arg_19_1.config.area_pos[2]) + arg_19_0:GetOffsetMapPos(), nil, 1, true, function()
			var_0_0.super.UpdateSelect(arg_19_0, arg_19_1)
			arg_19_0:DispatchEvent(var_0_0.EventUpdateselectEntrance, arg_19_1, arg_19_2, arg_19_3)

			return
		end)
	else
		var_0_0.super.UpdateSelect(arg_19_0, arg_19_1)
		arg_19_0:DispatchEvent(var_0_0.EventUpdateselectEntrance, arg_19_1, arg_19_2, arg_19_3)
	end

	return
end

function var_0_0.UpdateModelMask(arg_21_0)
	var_0_0.super.UpdateModelMask(arg_21_0)
	arg_21_0:UpdateAreaLock()

	return
end

function var_0_0.UpdateEntranceMask(arg_22_0, arg_22_1)
	if arg_22_1:HasPort() then
		arg_22_0.entranceTplDic[arg_22_1.id]:UpdatePort(arg_22_0.atlas:GetEntrancePortInfo(arg_22_1.id))
	end

	var_0_0.super.UpdateEntranceMask(arg_22_0, arg_22_1)

	return
end

function var_0_0.OnUpdateProgress(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	var_0_0.super.OnUpdateProgress(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0:UpdateAreaLock()

	return
end

function var_0_0.UpdateAreaLock(arg_24_0)
	for iter_24_0 = 1, 5 do
		local var_24_0 = nowWorld():CheckAreaUnlock(iter_24_0)

		setActive(arg_24_0.tfAreaScene:Find("lock_layer/" .. iter_24_0), not var_24_0)
		setActive(arg_24_0.tfMapScene:Find("mask_layer/" .. iter_24_0), var_24_0)

		if var_24_0 and arg_24_0.areaLockPressingAward[iter_24_0] then
			for iter_24_1, iter_24_2 in ipairs(arg_24_0.areaLockPressingAward[iter_24_0]) do
				arg_24_0.entranceTplDic[iter_24_2]:UpdatePressingAward()
			end

			arg_24_0.areaLockPressingAward[iter_24_0] = nil
		end
	end

	return
end

function var_0_0.OnUpdateActiveEntrance(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	var_0_0.super.OnUpdateActiveEntrance(arg_25_0, arg_25_1, arg_25_2, arg_25_3)

	if arg_25_3 then
		local var_25_0 = arg_25_3:HasPort()

		arg_25_0:DoUpdatExtraMark(arg_25_0.tfActiveMark, "mark_active_1", not var_25_0)
		arg_25_0:DoUpdatExtraMark(arg_25_0.tfActiveMark, "mark_active_port", var_25_0)
	end

	local var_25_1 = arg_25_3 and arg_25_3:GetAreaId()

	for iter_25_0 = 1, 5 do
		setActive(arg_25_0.tfAreaScene:Find("selected_layer/B" .. iter_25_0 .. "_2"), iter_25_0 == var_25_1)
		setActive(arg_25_0.tfAreaScene:Find("base_layer/B" .. iter_25_0), iter_25_0 ~= var_25_1)
	end

	return
end

function var_0_0.OnUpdatePressingAward(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_3 = arg_26_3 or arg_26_0.atlas.transportDic

	for iter_26_0, iter_26_1 in pairs(arg_26_3) do
		if iter_26_1 then
			local var_26_0 = arg_26_0.atlas:GetEntrance(iter_26_0):GetAreaId()
			local var_26_1 = nowWorld()

			if var_26_1:CheckAreaUnlock(var_26_0) then
				arg_26_0.entranceTplDic[iter_26_0]:UpdatePressingAward()
			else
				local var_26_2 = arg_26_0.areaLockPressingAward

				var_26_2[var_26_0] = arg_26_0.areaLockPressingAward[var_26_0] or {}

				table.insert(arg_26_0.areaLockPressingAward[var_26_0], iter_26_0)
			end
		end
	end

	var_0_0.super.OnUpdatePressingAward(arg_26_0, arg_26_1, arg_26_2, arg_26_3)

	return
end

function var_0_0.OnUpdatePortMark(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	for iter_27_0, iter_27_1 in pairs(arg_27_3) do
		if iter_27_1 then
			arg_27_0.entranceTplDic[iter_27_0]:UpdatePort(arg_27_0.atlas:GetEntrancePortInfo(iter_27_0))
		end
	end

	return
end

function var_0_0.NewEntranceTplDic(arg_28_0)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.atlas.entranceDic) do
		arg_28_0.entranceTplDic[iter_28_1.id] = arg_28_0:NewEntranceTpl(iter_28_1)
	end

	return
end

function var_0_0.DisposeEntranceTplDic(arg_29_0)
	WPool:ReturnArray(_.values(arg_29_0.entranceTplDic))

	arg_29_0.entranceTplDic = {}

	return
end

function var_0_0.NewEntranceTpl(arg_30_0, arg_30_1)
	local var_30_0 = WPool:Get(WSEntranceTpl)

	var_30_0.transform:SetParent(arg_30_0.tfSpriteScene, false)

	var_30_0.transform.localPosition = WorldConst.CalcModelPosition(arg_30_1, arg_30_0.spriteBaseSize)
	var_30_0.tfArea = arg_30_0.tfAreaScene:Find("display_layer")
	var_30_0.tfMap = arg_30_0.tfMapScene:Find("display_layer")

	var_30_0:Setup()
	var_30_0:UpdateEntrance(arg_30_1)

	return var_30_0
end

function var_0_0.FindEntranceTpl(arg_31_0, arg_31_1)
	return arg_31_0.entranceTplDic[arg_31_1.id]
end

function var_0_0.UpdateScale(arg_32_0, arg_32_1)
	local var_32_0

	if not arg_32_1 then
		arg_32_1 = 0
		var_32_0 = var_0_0.baseDistance * (1 - arg_32_1) + arg_32_0.frontDistance * arg_32_1 - arg_32_0.tfCamera.localPosition.y / -math.sin(arg_32_0.tfCamera.localEulerAngles.x / 180 * math.pi)
	end

	local var_32_1 = Vector3(0, -math.sin(arg_32_0.tfCamera.localEulerAngles.x / 180 * math.pi) * var_32_0, math.cos(arg_32_0.tfCamera.localEulerAngles.x / 180 * math.pi) * var_32_0)

	arg_32_0.tfCamera.localPosition = arg_32_0.tfCamera.localPosition + var_32_1

	return
end

function var_0_0.FocusPos(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	local var_33_9000

	if arg_33_0.twRotateId then
		LeanTween.cancel(arg_33_0.twRotateId)

		arg_33_0.twRotateId = nil
	end

	arg_33_3 = arg_33_3 or 0
	arg_33_2 = 0

	if not arg_33_1 then
		local var_33_0 = math.rad(-arg_33_2)

		arg_33_1 = var_0_0.basePoint - var_0_0.spriteBaseSize / 2
		arg_33_1 = Vector2((var_0_0.basePoint - var_0_0.spriteBaseSize / 2).x * math.cos(var_33_0) - (var_0_0.basePoint - var_0_0.spriteBaseSize / 2).y * math.sin(var_33_0), (var_0_0.basePoint - var_0_0.spriteBaseSize / 2).y * math.cos(var_33_0) + (var_0_0.basePoint - var_0_0.spriteBaseSize / 2).x * math.sin(var_33_0))
		arg_33_1 = var_0_0.basePoint - var_0_0.spriteBaseSize / 2 + var_0_0.spriteBaseSize / 2
	end

	local var_33_1 = math.rad(arg_33_0.tfEntity.localEulerAngles.y - arg_33_2)

	arg_33_1 = arg_33_1 - var_0_0.spriteBaseSize / 2
	arg_33_1 = Vector2(arg_33_1.x * math.cos(var_33_1) - arg_33_1.y * math.sin(var_33_1), arg_33_1.y * math.cos(var_33_1) + arg_33_1.x * math.sin(var_33_1))

	local var_33_2 = arg_33_0.transform:InverseTransformPoint(arg_33_0.tfSpriteScene:TransformPoint(Vector3(arg_33_1.x, 0, arg_33_1.y) / PIXEL_PER_UNIT))
	local var_33_3 = math.rad(arg_33_0.tfCamera.localEulerAngles.x)
	local var_33_4 = var_0_0.baseDistance * (1 - arg_33_3) + var_0_0.frontDistance * arg_33_3 - Vector3(0, var_33_2.y, var_33_2.y / -math.tan(var_33_3)).y / -math.sin(var_33_3)
	local var_33_5 = var_33_2 - var_33_9000 + Vector3(0, arg_33_0.tfCamera.localPosition.y, arg_33_0.tfCamera.localPosition.y / -math.tan(var_33_3)) + Vector3(0, -math.sin(var_33_3) * var_33_4, math.cos(var_33_3) * var_33_4)

	if arg_33_4 then
		local var_33_6 = math.min(Vector3.Distance(arg_33_0.tfCamera.localPosition, var_33_5) / var_0_0.baseMoveDistance, 1) * var_0_0.baseDuration
		local var_33_7 = math.min(math.abs(arg_33_2 - arg_33_0.tfEntity.localEulerAngles.y) / 180, 1) * var_0_0.baseDuration

		table.insert({}, function(arg_34_0)
			local var_34_0 = LeanTween.moveLocal(go(arg_33_0.tfCamera), var_33_5, var_33_6):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_34_0)).uniqueId

			table.insert(arg_33_0.twFocusIds, var_34_0)
			arg_33_0.wsTimer:AddTween(var_34_0)

			return
		end)
		table.insert({}, function(arg_35_0)
			local var_35_0 = LeanTween.rotateY(go(arg_33_0.tfEntity), arg_33_2, var_33_7):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_35_0)).uniqueId

			table.insert(arg_33_0.twFocusIds, var_35_0)
			arg_33_0.wsTimer:AddTween(var_35_0)

			return
		end)
		parallelAsync({}, function()
			existCall(arg_33_5)

			return
		end)
	else
		arg_33_0.tfCamera.localPosition = var_33_5
		arg_33_0.tfEntity.localEulerAngles = Vector3(0, arg_33_2, 0)

		return existCall(arg_33_5)
	end

	return
end

function var_0_0.FocusPosInArea(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_1 then
		arg_37_0:FocusPos(Vector2(pg.world_regions_data[arg_37_1].regions_pos[1], pg.world_regions_data[arg_37_1].regions_pos[2]), pg.world_regions_data[arg_37_1].regions_rotation[1], 1, arg_37_2, arg_37_3)
	else
		arg_37_0:FocusPos(var_0_0.basePoint, 0, 0, arg_37_2, arg_37_3)
	end

	return
end

function var_0_0.SwitchArea(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = {}

	if arg_38_2 and tobool(arg_38_1) ~= tobool(arg_38_0.nowArea) then
		table.insert({}, function(arg_39_0)
			arg_38_0:SwitchMode(arg_38_1, arg_38_2, arg_39_0)

			return
		end)
	end

	table.insert({}, function(arg_40_0)
		setActive(arg_38_0.tfAreaScene, not arg_38_1)
		setActive(arg_38_0.tfMapScene, arg_38_1)
		setActive(arg_38_0.tfMapModel, not arg_38_1)
		arg_40_0()

		return
	end)

	arg_38_0.nowArea = arg_38_1

	parallelAsync({
		function(arg_41_0)
			seriesAsync(var_38_0, arg_41_0)

			return
		end,
		function(arg_42_0)
			arg_38_0:FocusPosInArea(arg_38_1, arg_38_2, arg_42_0)

			return
		end
	}, function()
		return existCall(arg_38_3)
	end)

	return
end

function var_0_0.SwitchMode(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local function var_44_0()
		arg_44_0:BreathRotate(not arg_44_1)

		return existCall(arg_44_3)
	end

	if arg_44_2 then
		parallelAsync({
			function(arg_45_0)
				setActive(arg_44_0.tfAreaScene, true)

				local var_45_0 = arg_44_0.tfAreaScene:GetComponent("FMultiSpriteRenderCtrl")

				var_45_0:Init()

				var_45_0.alpha = arg_44_1 and 1 or 0

				var_45_0:UpdateAlpha()

				local var_45_1 = LeanTween.value(go(arg_44_0.tfAreaScene), arg_44_1 and 1 or 0, arg_44_1 and 0 or 1, var_0_0.baseDuration):setOnUpdate(System.Action_float(function(arg_46_0)
					var_45_0.alpha = arg_46_0

					return
				end)):setOnComplete(System.Action(function()
					var_45_0.alpha = 1

					var_45_0:UpdateAlpha()
					setActive(arg_44_0.tfAreaScene, not arg_44_1)

					return arg_45_0()
				end)).uniqueId

				table.insert(arg_44_0.twFocusIds, var_45_1)
				arg_44_0.wsTimer:AddTween(var_45_1)

				return
			end,
			function(arg_48_0)
				setActive(arg_44_0.tfMapScene, true)

				local var_48_0 = arg_44_0.tfMapScene:GetComponent("FMultiSpriteRenderCtrl")

				var_48_0:Init()

				var_48_0.alpha = arg_44_1 and 0 or 1

				var_48_0:UpdateAlpha()

				local var_48_1 = LeanTween.value(go(arg_44_0.tfMapScene), arg_44_1 and 0 or 1, arg_44_1 and 1 or 0, var_0_0.baseDuration):setOnUpdate(System.Action_float(function(arg_49_0)
					var_48_0.alpha = arg_49_0

					return
				end)):setOnComplete(System.Action(function()
					var_48_0.alpha = 1

					var_48_0:UpdateAlpha()
					setActive(arg_44_0.tfMapScene, arg_44_1)

					return arg_48_0()
				end)).uniqueId

				table.insert(arg_44_0.twFocusIds, var_48_1)
				arg_44_0.wsTimer:AddTween(var_48_1)

				return
			end,
			function(arg_51_0)
				setActive(arg_44_0.tfMapModel, true)

				local var_51_0 = var_0_0.baseDuration

				table.insert({}, function(arg_52_0)
					local var_52_0 = arg_44_0.tfModel:Find("Terrain_LOD9_perfect")
					local var_52_1 = var_52_0:GetComponent("MeshRenderer").material

					var_52_1:SetFloat("_Invisible", arg_44_1 and 1 or 0)

					local var_52_2 = LeanTween.value(go(var_52_0), arg_44_1 and 1 or 0, arg_44_1 and 0 or 1, var_51_0):setOnUpdate(System.Action_float(function(arg_53_0)
						var_52_1:SetFloat("_Invisible", arg_53_0)

						return
					end)):setOnComplete(System.Action(function()
						var_52_1:SetFloat("_Invisible", arg_44_1 and 0 or 1)
						arg_52_0()

						return
					end)).uniqueId

					table.insert(arg_44_0.twFocusIds, var_52_2)
					arg_44_0.wsTimer:AddTween(var_52_2)

					return
				end)
				table.insert({}, function(arg_55_0)
					local var_55_0 = arg_44_0.tfModel:Find("decolation_model")
					local var_55_1 = var_55_0:GetComponent("FMultiSpriteRenderCtrl")

					var_55_1:Init()

					var_55_1.alpha = arg_44_1 and 1 or 0

					var_55_1:UpdateAlpha()

					local var_55_2 = LeanTween.value(go(var_55_0), arg_44_1 and 1 or 0, arg_44_1 and 0 or 1, var_51_0):setOnUpdate(System.Action_float(function(arg_56_0)
						var_55_1.alpha = arg_56_0

						return
					end)):setOnComplete(System.Action(function()
						var_55_1.alpha = 1

						var_55_1:UpdateAlpha()
						arg_55_0()

						return
					end)).uniqueId

					table.insert(arg_44_0.twFocusIds, var_55_2)
					arg_44_0.wsTimer:AddTween(var_55_2)

					return
				end)
				parallelAsync({}, function()
					setActive(arg_44_0.tfMapModel, not arg_44_1)

					return arg_51_0()
				end)

				return
			end
		}, function()
			return var_44_0()
		end)
	else
		return (function()
			arg_44_0:BreathRotate(not arg_44_1)

			return existCall(arg_44_3)
		end)()
	end

	return
end

var_0_0.LowRotation = -5
var_0_0.HeightRotation = 5
var_0_0.BreathTime = 18

function var_0_0.BreathRotate(arg_61_0, arg_61_1)
	if arg_61_0.twRotateId then
		LeanTween.cancel(arg_61_0.twRotateId)

		arg_61_0.twRotateId = nil
	end

	if not arg_61_1 then
		return
	end

	local var_61_0 = -1

	local function var_61_1()
		var_61_0 = -1 * var_61_0

		local var_62_0 = arg_61_0
		local var_62_2 = go(arg_61_0.tfEntity)

		if var_61_0 == 1 then
			local var_62_4 = var_62_1(var_62_2, var_62_3, var_0_0.BreathTime):setEase(LeanTweenType.easeOutSine)

			var_62_0.twRotateId = var_62_4:setOnComplete(System.Action(function()
				var_61_1()

				return
			end)).uniqueId

			return
		end
	end

	arg_61_0.twRotateId = LeanTween.rotateY(go(arg_61_0.tfEntity), var_0_0.LowRotation, var_0_0.BreathTime / 2):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(function()
		var_61_1()

		return
	end)):setDelay(1).uniqueId

	return
end

function var_0_0.CheckIsTweening(arg_65_0)
	while #arg_65_0.twFocusIds > 0 and not LeanTween.isTweening(arg_65_0.twFocusIds[1]) do
		table.remove(arg_65_0.twFocusIds, 1)
	end

	return arg_65_0.isTransAnim or #arg_65_0.twFocusIds > 0
end

function var_0_0.ActiveTrans(arg_66_0, arg_66_1)
	if arg_66_0.entranceTplDic[arg_66_1.id].portCamp then
		-- block empty
	else
		local var_66_0 = arg_66_0.tfMapSelect:Find("A" .. arg_66_1:GetColormaskUniqueID() .. "_2")

		setActive(var_66_0, true)

		local var_66_1 = var_66_0:GetComponent("SpriteRenderer").color

		var_66_1.a = 0
		var_66_0:GetComponent("SpriteRenderer").color = var_66_1

		LeanTween.alpha(go(var_66_0), 1, 0.3):setOnComplete(System.Action(function()
			LeanTween.alpha(go(var_66_0), 0, 0.2):setDelay(0.1):setOnComplete(System.Action(function()
				setActive(var_66_0, arg_66_0.selectEntrance == arg_66_1)

				var_66_1.a = 1
				var_66_0:GetComponent("SpriteRenderer").color = var_66_1

				return
			end))

			return
		end))
	end

	return
end

function var_0_0.DisplayTransport(arg_69_0, arg_69_1, arg_69_2)
	for iter_69_0, iter_69_1 in pairs(arg_69_0.atlas.transportDic) do
		if iter_69_1 and not arg_69_1[iter_69_0] then
			({})[iter_69_0] = true
		end
	end

	arg_69_0:UpdateTransMark({}, arg_69_2)

	return
end

function var_0_0.UpdateTransMark(arg_70_0, arg_70_1, arg_70_2)
	for iter_70_0, iter_70_1 in pairs(arg_70_1) do
		if iter_70_1 then
			arg_70_0.isTransAnim = true

			arg_70_0:ActiveTrans(arg_70_0.atlas:GetEntrance(iter_70_0))
		end
	end

	if arg_70_0.isTransAnim then
		arg_70_0.wsTimer:AddTimer(function()
			arg_70_0.isTransAnim = false

			arg_70_2()

			return
		end, 0.6):Start()
	else
		arg_70_2()
	end

	return
end

function var_0_0.UpdateActiveMark(arg_72_0)
	local var_72_0 = nowWorld():GetActiveMap():CkeckTransport()

	eachChild(arg_72_0.tfActiveMark, function(arg_73_0)
		setActive(arg_73_0:Find("base"), var_72_0)
		setActive(arg_73_0:Find("limit"), not var_72_0)

		return
	end)

	return
end

return var_0_0
