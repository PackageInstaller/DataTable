class = var_0_10000

local var_0_0 = "WSAtlasWorld"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".WSAtlas"))

var_0_1.Fields = {
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
var_0_1.Listeners = {
	onUpdatePressingAward = "OnUpdatePressingAward",
	onUpdatePortMark = "OnUpdatePortMark",
	onUpdateActiveEntrance = "OnUpdateActiveEntrance",
	onUpdateProgress = "OnUpdateProgress"
}
var_0_1.EventUpdateselectEntrance = "WSAtlasWorld.EventUpdateselectEntrance"
var_0_1.baseDistance = -217.4
var_0_1.frontDistance = -101.6237
Vector2 = var_1
var_0_1.basePoint = var_1(1024, 550)
var_0_1.baseMoveDistance = 100
var_0_1.baseDuration = 0.8
Vector2 = var_1
var_0_1.selectOffsetPos = var_1(107, 61)

function var_0_1.Dispose(arg_1_0)
	arg_1_0:DisposeEntranceTplDic()
	var_0_1.super.Dispose(arg_1_0)

	return
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)

	arg_2_0.entranceTplDic = {}
	arg_2_0.twFocusIds = {}
	arg_2_0.areaLockPressingAward = {}

	return
end

function var_0_1.UpdateAtlas(arg_3_0, arg_3_1)
	if arg_3_0.atlas ~= arg_3_1 then
		arg_3_0:RemoveAtlasListener()
		arg_3_0:DisposeEntranceTplDic()

		arg_3_0.atlas = arg_3_1

		arg_3_0:AddAtlasListener()
		arg_3_0:NewEntranceTplDic()
		arg_3_0:UpdateModelMask()

		local var_3_0 = arg_3_0
		local var_3_1 = arg_3_0.OnUpdateActiveEntrance
		local var_3_2
		local var_3_3
		local var_3_4 = arg_3_0.atlas

		var_3_1(var_3_0, var_3_2, var_3_3, var_7.GetActiveEntrance(var_3_4))
		arg_3_0:OnUpdatePressingAward()
	end

	return
end

function var_0_1.AddAtlasListener(arg_4_0)
	if arg_4_0.atlas then
		local var_4_0 = arg_4_0.atlas
		local var_4_1 = var_1.AddListener

		WorldAtlas = var_1_10004

		var_4_1(var_4_0, var_1_10004.EventUpdatePortMark, arg_4_0.onUpdatePortMark)
	end

	var_0_1.super.AddAtlasListener(arg_4_0)

	return
end

function var_0_1.RemoveAtlasListener(arg_5_0)
	if arg_5_0.atlas then
		local var_5_0 = arg_5_0.atlas
		local var_5_1 = var_1.RemoveListener

		WorldAtlas = var_1_10004

		var_5_1(var_5_0, var_1_10004.EventUpdatePortMark, arg_5_0.onUpdatePortMark)
	end

	var_0_1.super.RemoveAtlasListener(arg_5_0)

	return
end

function var_0_1.LoadModel(arg_6_0, arg_6_1)
	local var_6_0 = {}

	if not arg_6_0.tfModel then
		table = var_3

		var_3.insert(var_6_0, function(arg_7_0)
			PoolMgr = var_2_10001

			local var_7_0 = var_2_10001.GetInstance()

			var_1.GetPrefab(var_7_0, "model/worldmapmodel", "WorldMapModel", true, function(arg_8_0)
				if arg_6_0.transform then
					local var_8_0 = arg_6_0

					tf = var_3_10002
					var_8_0.tfModel = var_3_10002(arg_8_0)
					setParent = var_8_0

					var_8_0(arg_6_0.tfModel, arg_6_0.tfMapModel, false)
				else
					local var_8_1 = var_0

					var_1.ReturnPrefab(var_8_1, "model/worldmapmodel", "WorldMapModel", arg_8_0, true)
				end

				return arg_7_0()
			end)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_6_0, function()
		existCall = var_2_10000

		return var_2_10000(arg_6_1)
	end)

	return
end

function var_0_1.ReturnModel(arg_10_0)
	if arg_10_0.tfModel then
		PoolMgr = var_1

		local var_10_0 = var_1.GetInstance()
		local var_10_1 = var_1.ReturnPrefab
		local var_10_2 = "model/worldmapmodel"
		local var_10_3 = "WorldMapModel"

		go = var_1_10006

		var_10_1(var_10_0, var_10_2, var_10_3, var_1_10006(arg_10_0.tfModel), true)
	end

	return
end

function var_0_1.LoadScene(arg_11_0, arg_11_1)
	gcAll = var_1_10002

	var_1_10002(true)

	SceneOpMgr = var_1_10002

	local var_11_0 = var_1_10002.Inst
	local var_11_1 = var_2.LoadSceneAsync
	local var_11_2 = "scenes/worldmap3d"
	local var_11_3 = "WorldMap3D"

	LoadSceneMode = var_1_10007

	var_11_1(var_11_0, var_11_2, var_11_3, var_1_10007.Additive, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_11_0

		tf = var_2_10003
		var_12_0.transform = var_2_10003(arg_12_0:GetRootGameObjects()[0])
		setActive = var_12_0

		var_12_0(arg_11_0.transform, false)

		local var_12_1 = arg_11_0
		local var_12_2 = arg_11_0.transform

		var_12_1.tfEntity = var_3.Find(var_12_2, "entity")

		local var_12_3 = arg_11_0
		local var_12_4 = arg_11_0.tfEntity

		var_12_3.tfAreaScene = var_3.Find(var_12_4, "area_scene")

		local var_12_5 = arg_11_0
		local var_12_6 = arg_11_0.tfEntity

		var_12_5.tfMapScene = var_3.Find(var_12_6, "map_scene")

		local var_12_7 = arg_11_0
		local var_12_8 = arg_11_0.tfEntity

		var_12_7.tfMapModel = var_3.Find(var_12_8, "model")

		local var_12_9 = arg_11_0
		local var_12_10 = arg_11_0.tfMapScene

		var_12_9.tfMapSelect = var_3.Find(var_12_10, "selected_layer")

		local var_12_11 = arg_11_0
		local var_12_12 = arg_11_0.tfEntity

		var_12_11.tfSpriteScene = var_3.Find(var_12_12, "sprite_scene")

		local var_12_13 = arg_11_0
		local var_12_14 = arg_11_0.transform

		var_12_13.tfCamera = var_3.Find(var_12_14, "Main Camera")

		local var_12_15 = arg_11_0.tfCamera
		local var_12_16 = var_2.GetComponent(var_12_15, "Camera")

		UnityEngine = var_3
		var_12_16.depthTextureMode = var_3.DepthTextureMode.Depth

		local var_12_17 = arg_11_0
		local var_12_18 = arg_11_0.tfEntity
		local var_12_19 = var_3.Find(var_12_18, "decolation_layer/edge")

		var_12_17.defaultSprite = var_3.GetComponent(var_12_19, "SpriteRenderer").material

		local var_12_20 = arg_11_0
		local var_12_21 = arg_11_0.tfEntity
		local var_12_22 = var_3.Find(var_12_21, "map_scene/mask_layer")

		var_12_20.addSprite = var_3.GetComponent(var_12_22, "SpriteRenderer").material
		math = var_12_20

		local var_12_23 = var_12_20.deg2Rad * 30
		local var_12_24 = arg_11_0.frontDistance

		UnityEngine = var_12_15

		local var_12_25 = var_12_24 / var_12_15.Screen.height
		local var_12_26 = arg_11_0
		local var_12_27 = arg_11_0.tfEntity
		local var_12_28 = var_5.Find(var_12_27, "Plane")

		var_12_26.dragTrigger = var_5.GetComponent(var_12_28, "EventTriggerListener")

		local var_12_29 = arg_11_0.dragTrigger

		var_4.AddDragFunc(var_12_29, function(arg_13_0, arg_13_1)
			arg_11_0.isDragging = true

			if arg_11_0.nowArea then
				local var_13_0 = arg_11_0

				if var_2.CheckIsTweening(var_13_0) then
					return
				end

				if arg_11_0.selectEntrance then
					local var_13_1 = arg_11_0

					var_2.UpdateSelect(var_13_1)
				end

				Vector3 = var_2

				local var_13_2 = arg_13_1.delta.x
				local var_13_3 = 0
				local var_13_4 = arg_13_1.delta.y

				math = var_3_10007

				local var_13_5 = var_2(var_13_2, var_13_3, var_13_4 / var_3_10007.cos(var_12_23)) * var_12_25

				arg_11_0.tfCamera.localPosition = arg_11_0.tfCamera.localPosition + var_13_5

				return
			end
		end)

		local var_12_30 = arg_11_0.dragTrigger

		var_4.AddDragEndFunc(var_12_30, function(arg_14_0, arg_14_1)
			arg_11_0.isDragging = false

			return
		end)

		local var_12_31 = arg_11_0

		var_4.UpdateCenterEffectDisplay(var_12_31)

		local var_12_32 = arg_11_0

		var_4.BuildActiveMark(var_12_32)

		nowWorld = var_4

		local var_12_33 = var_4()
		local var_12_34 = arg_11_0
		local var_12_35 = arg_11_0.tfEntity
		local var_12_36 = var_6.Find(var_12_35, "Plane")
		local var_12_37 = var_6.GetComponent

		typeof = var_9
		PointerInfo = var_2_10011
		var_12_34.cmPointer = var_12_37(var_12_36, var_9(var_2_10011))

		local var_12_38 = arg_11_0.cmPointer

		var_5.AddColorMaskClickListener(var_12_38, function(arg_15_0, arg_15_1)
			if arg_11_0.isDragging then
				return
			end

			local var_15_0 = var_12_33

			if var_2.ColorToEntrance(var_15_0, arg_15_0) then
				arg_11_0.onClickColor(var_2, arg_15_1.position)
			end

			return
		end)

		existCall = var_5

		return var_5(arg_11_1)
	end)

	return
end

function var_0_1.ReturnScene(arg_16_0)
	arg_16_0:ReturnModel()

	if arg_16_0.transform then
		local var_16_0 = arg_16_0.tfMapScene
		local var_16_1 = var_1.GetComponent(var_16_0, "FMultiSpriteRenderCtrl")

		var_16_1.alpha = 1

		var_16_1:UpdateAlpha()

		local var_16_2 = arg_16_0.tfAreaScene
		local var_16_3 = var_2.GetComponent(var_16_2, "FMultiSpriteRenderCtrl")

		var_16_3.alpha = 1

		var_16_3:UpdateAlpha()

		SceneOpMgr = var_3

		local var_16_4 = var_3.Inst

		var_3.UnloadSceneAsync(var_16_4, "scene/worldmap3d", "WorldMap3D")

		arg_16_0.cmPointer = nil
	end

	return
end

function var_0_1.ShowOrHide(arg_17_0, arg_17_1)
	var_0_1.super.ShowOrHide(arg_17_0, arg_17_1)

	local var_17_0

	if arg_17_1 then
		SceneManager = var_17_0
		var_17_0 = var_17_0.SetActiveScene
		SceneManager = var_4

		var_17_0(var_4.GetSceneByName("WorldMap3D"))
	else
		SceneManager = var_17_0

		local var_17_1 = var_17_0.SetActiveScene

		SceneManager = var_4

		var_17_1(var_4.GetSceneByName("main"))
	end

	return
end

function var_0_1.GetOffsetMapPos(arg_18_0)
	local var_18_0 = var_0_1.selectOffsetPos
	local var_18_1 = arg_18_0.tfEntity.localEulerAngles.y

	math = var_1_10003

	local var_18_2 = var_1_10003.rad(-var_18_1)

	Vector2 = var_1_10004

	local var_18_3 = var_18_0.x

	math = var_1_10007

	local var_18_4 = var_18_3 * var_1_10007.cos(var_18_2)
	local var_18_5 = var_18_0.y

	math = var_1_10008

	local var_18_6 = var_18_4 - var_18_5 * var_1_10008.sin(var_18_2)
	local var_18_7 = var_18_0.y

	math = var_8

	local var_18_8 = var_18_7 * var_8.cos(var_18_2)
	local var_18_9 = var_18_0.x

	math = var_9

	return var_1_10004(var_18_6, var_18_8 + var_18_9 * var_9.sin(var_18_2))
end

function var_0_1.UpdateSelect(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_1 then
		arg_19_0.nowArea = arg_19_1:GetAreaId()

		local var_19_0 = arg_19_0
		local var_19_1 = arg_19_0.FocusPos

		Vector2 = var_1_10007

		var_19_1(var_19_0, var_1_10007(arg_19_1.config.area_pos[1], arg_19_1.config.area_pos[2]) + arg_19_0:GetOffsetMapPos(), nil, 1, true, function()
			var_0_1.super.UpdateSelect(arg_19_0, arg_19_1)

			local var_20_0 = arg_19_0

			var_0.DispatchEvent(var_20_0, var_0_1.EventUpdateselectEntrance, arg_19_1, arg_19_2, arg_19_3)

			return
		end)
	else
		var_0_1.super.UpdateSelect(arg_19_0, arg_19_1)
		arg_19_0:DispatchEvent(var_0_1.EventUpdateselectEntrance, arg_19_1, arg_19_2, arg_19_3)
	end

	return
end

function var_0_1.UpdateModelMask(arg_21_0)
	var_0_1.super.UpdateModelMask(arg_21_0)
	arg_21_0:UpdateAreaLock()

	return
end

function var_0_1.UpdateEntranceMask(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.entranceTplDic[arg_22_1.id]

	if arg_22_1:HasPort() then
		local var_22_1 = var_22_0
		local var_22_2 = var_22_0.UpdatePort
		local var_22_3 = arg_22_0.atlas

		var_22_2(var_22_1, var_6.GetEntrancePortInfo(var_22_3, arg_22_1.id))
	end

	var_0_1.super.UpdateEntranceMask(arg_22_0, arg_22_1)

	return
end

function var_0_1.OnUpdateProgress(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	var_0_1.super.OnUpdateProgress(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0:UpdateAreaLock()

	return
end

function var_0_1.UpdateAreaLock(arg_24_0)
	for iter_24_0 = 1, 5 do
		nowWorld = var_1_10005

		local var_24_0 = var_1_10005()

		var_1_10005 = var_1_10005.CheckAreaUnlock(var_24_0, iter_24_0)
		setActive = var_1_10006

		local var_24_1 = arg_24_0.tfAreaScene

		var_1_10006(var_8.Find(var_24_1, "lock_layer/" .. iter_24_0), not var_1_10005)

		setActive = var_1_10006

		local var_24_2 = arg_24_0.tfMapScene

		var_1_10006(var_8.Find(var_24_2, "mask_layer/" .. iter_24_0), var_1_10005)

		if var_1_10005 and arg_24_0.areaLockPressingAward[iter_24_0] then
			ipairs = var_1_10006

			for iter_24_1, iter_24_2 in var_1_10006(arg_24_0.areaLockPressingAward[iter_24_0]) do
				local var_24_3 = arg_24_0.entranceTplDic[iter_24_2]

				var_11.UpdatePressingAward(var_24_3)
			end

			var_1_10006 = arg_24_0.areaLockPressingAward
			var_1_10006[iter_24_0] = nil
		end
	end

	return
end

function var_0_1.OnUpdateActiveEntrance(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	var_0_1.super.OnUpdateActiveEntrance(arg_25_0, arg_25_1, arg_25_2, arg_25_3)

	if arg_25_3 then
		local var_25_0 = arg_25_3:HasPort()

		arg_25_0:DoUpdatExtraMark(arg_25_0.tfActiveMark, "mark_active_1", not var_25_0)
		arg_25_0:DoUpdatExtraMark(arg_25_0.tfActiveMark, "mark_active_port", var_25_0)
	end

	local var_25_1 = arg_25_3 and arg_25_3:GetAreaId()

	for iter_25_0 = 1, 5 do
		setActive = var_9

		local var_25_2 = arg_25_0.tfAreaScene

		var_9(var_11.Find(var_25_2, "selected_layer/B" .. iter_25_0 .. "_2"), iter_25_0 == var_25_1)

		setActive = var_9

		local var_25_3 = arg_25_0.tfAreaScene

		var_9(var_11.Find(var_25_3, "base_layer/B" .. iter_25_0), iter_25_0 ~= var_25_1)
	end

	return
end

function var_0_1.OnUpdatePressingAward(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_3 = arg_26_3 or arg_26_0.atlas.transportDic
	pairs = var_1_10004

	for iter_26_0, iter_26_1 in var_1_10004(arg_26_3) do
		if iter_26_1 then
			local var_26_0 = arg_26_0.atlas
			local var_26_1 = var_9.GetEntrance(var_26_0, iter_26_0)
			local var_26_2 = var_9.GetAreaId(var_26_1)

			nowWorld = var_1_10010

			local var_26_3 = var_1_10010()

			if var_1_10010.CheckAreaUnlock(var_26_3, var_26_2) then
				local var_26_4 = arg_26_0.entranceTplDic[iter_26_0]

				var_1_10010.UpdatePressingAward(var_26_4)
			else
				var_1_10010 = arg_26_0.areaLockPressingAward

				local var_26_5

				if not arg_26_0.areaLockPressingAward[var_26_2] then
					var_26_5 = {}
				end

				var_1_10010[var_26_2] = var_26_5
				table = var_1_10010

				var_1_10010.insert(arg_26_0.areaLockPressingAward[var_26_2], iter_26_0)
			end
		end
	end

	var_0_1.super.OnUpdatePressingAward(arg_26_0, arg_26_1, arg_26_2, arg_26_3)

	return
end

function var_0_1.OnUpdatePortMark(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	pairs = var_1_10004

	for iter_27_0, iter_27_1 in var_1_10004(arg_27_3) do
		if iter_27_1 then
			local var_27_0 = arg_27_0.entranceTplDic[iter_27_0]
			local var_27_1 = var_9.UpdatePort
			local var_27_2 = arg_27_0.atlas

			var_27_1(var_27_0, var_12.GetEntrancePortInfo(var_27_2, iter_27_0))
		end
	end

	return
end

function var_0_1.NewEntranceTplDic(arg_28_0)
	pairs = var_1_10001

	for iter_28_0, iter_28_1 in var_1_10001(arg_28_0.atlas.entranceDic) do
		arg_28_0.entranceTplDic[iter_28_1.id] = arg_28_0:NewEntranceTpl(iter_28_1)
	end

	return
end

function var_0_1.DisposeEntranceTplDic(arg_29_0)
	WPool = var_1_10001

	local var_29_0 = var_1_10001
	local var_29_1 = var_1_10001.ReturnArray

	_ = var_1_10004

	var_29_1(var_29_0, var_1_10004.values(arg_29_0.entranceTplDic))

	arg_29_0.entranceTplDic = {}

	return
end

function var_0_1.NewEntranceTpl(arg_30_0, arg_30_1)
	WPool = var_1_10002

	local var_30_0 = var_1_10002
	local var_30_1 = var_1_10002.Get

	WSEntranceTpl = var_1_10005

	local var_30_2 = var_30_1(var_30_0, var_1_10005).transform

	var_3.SetParent(var_30_2, arg_30_0.tfSpriteScene, false)

	local var_30_3 = var_2.transform

	WorldConst = var_30_0
	var_30_3.localPosition = var_30_0.CalcModelPosition(arg_30_1, arg_30_0.spriteBaseSize)

	local var_30_4 = arg_30_0.tfAreaScene

	var_2.tfArea = var_3.Find(var_30_4, "display_layer")

	local var_30_5 = arg_30_0.tfMapScene

	var_2.tfMap = var_3.Find(var_30_5, "display_layer")

	var_2:Setup()
	var_2:UpdateEntrance(arg_30_1)

	return var_2
end

function var_0_1.FindEntranceTpl(arg_31_0, arg_31_1)
	return arg_31_0.entranceTplDic[arg_31_1.id]
end

function var_0_1.UpdateScale(arg_32_0, arg_32_1)
	arg_32_1 = arg_32_1 or 0

	local var_32_0 = arg_32_0.tfCamera.localEulerAngles.x / 180

	math = var_1_10003

	local var_32_1 = var_32_0 * var_1_10003.pi
	local var_32_2 = arg_32_0.tfCamera.localPosition.y

	math = var_1_10004

	local var_32_3 = var_32_2 / -var_1_10004.sin(var_32_1)
	local var_32_4 = var_0_1.baseDistance * (1 - arg_32_1) + arg_32_0.frontDistance * arg_32_1 - var_32_3

	Vector3 = var_5

	local var_32_5 = 0

	math = var_1_10008

	local var_32_6 = -var_1_10008.sin(var_32_1) * var_32_4

	math = var_1_10009

	local var_32_7 = var_5(var_32_5, var_32_6, var_1_10009.cos(var_32_1) * var_32_4)

	arg_32_0.tfCamera.localPosition = arg_32_0.tfCamera.localPosition + var_32_7

	return
end

function var_0_1.FocusPos(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	if arg_33_0.twRotateId then
		LeanTween = var_33_0

		var_33_0.cancel(arg_33_0.twRotateId)

		arg_33_0.twRotateId = nil
	end

	arg_33_3 = arg_33_3 or 0
	arg_33_2 = 0

	local var_33_0

	if not arg_33_1 then
		math = var_33_0
		var_33_0 = var_33_0.rad(-arg_33_2)
		arg_33_1 = var_0_1.basePoint - var_0_1.spriteBaseSize / 2
		Vector2 = var_7

		local var_33_1 = arg_33_1.x

		math = var_1_10010

		local var_33_2 = var_33_1 * var_1_10010.cos(var_33_0)

		var_1_10010 = arg_33_1.y
		math = var_1_10011

		local var_33_3 = var_33_2 - var_1_10010 * var_1_10011.sin(var_33_0)

		var_1_10010 = arg_33_1.y
		math = var_1_10011
		var_1_10010 = var_1_10010 * var_1_10011.cos(var_33_0)
		var_1_10011 = arg_33_1.x
		math = var_12
		arg_33_1 = var_7(var_33_3, var_1_10010 + var_1_10011 * var_12.sin(var_33_0)) + var_0_1.spriteBaseSize / 2
	end

	math = var_33_0

	local var_33_4 = var_33_0.rad(arg_33_0.tfEntity.localEulerAngles.y - arg_33_2)

	arg_33_1 = arg_33_1 - var_0_1.spriteBaseSize / 2
	Vector2 = var_7

	local var_33_5 = arg_33_1.x

	math = var_1_10010

	local var_33_6 = var_33_5 * var_1_10010.cos(var_33_4)
	local var_33_7 = arg_33_1.y

	math = var_1_10011

	local var_33_8 = var_33_6 - var_33_7 * var_1_10011.sin(var_33_4)
	local var_33_9 = arg_33_1.y

	math = var_11

	local var_33_10 = var_33_9 * var_11.cos(var_33_4)
	local var_33_11 = arg_33_1.x

	math = var_12
	arg_33_1 = var_7(var_33_8, var_33_10 + var_33_11 * var_12.sin(var_33_4))
	Vector3 = var_7

	local var_33_12 = var_7(arg_33_1.x, 0, arg_33_1.y)

	PIXEL_PER_UNIT = var_8

	local var_33_13 = var_33_12 / var_8
	local var_33_14 = arg_33_0.transform
	local var_33_15 = var_8.InverseTransformPoint
	local var_33_16 = arg_33_0.tfSpriteScene
	local var_33_17 = var_33_15(var_33_14, var_11.TransformPoint(var_33_16, var_33_13))

	math = var_9

	local var_33_18 = var_9.rad(arg_33_0.tfCamera.localEulerAngles.x)

	Vector3 = var_33_14

	local var_33_19 = 0
	local var_33_20 = var_33_17.y
	local var_33_21 = var_33_17.y

	math = var_1_10015

	local var_33_22 = var_33_17 - var_33_14(var_33_19, var_33_20, var_33_21 / -var_1_10015.tan(var_33_18))

	Vector3 = var_10

	local var_33_23 = 0
	local var_33_24 = arg_33_0.tfCamera.localPosition.y
	local var_33_25 = arg_33_0.tfCamera.localPosition.y

	math = var_15

	local var_33_26 = (var_33_22 + var_10(var_33_23, var_33_24, var_33_25 / -var_15.tan(var_33_18))).y

	math = var_33_23

	local var_33_27 = var_33_26 / -var_33_23.sin(var_33_18)
	local var_33_28 = var_0_1.baseDistance * (1 - arg_33_3) + var_0_1.frontDistance * arg_33_3 - var_33_27

	Vector3 = var_13

	local var_33_29 = 0

	math = var_1_10016

	local var_33_30 = -var_1_10016.sin(var_33_18) * var_33_28

	math = var_17

	local var_33_31 = var_10 + var_13(var_33_29, var_33_30, var_17.cos(var_33_18) * var_33_28)
	local var_33_34

	if arg_33_4 then
		math = var_13

		local var_33_32 = var_13.min

		Vector3 = var_33_29

		local var_33_33 = var_33_32(var_33_29.Distance(arg_33_0.tfCamera.localPosition, var_33_31) / var_0_1.baseMoveDistance, 1) * var_0_1.baseDuration

		math = var_33_34
		var_33_34 = var_33_34.min
		math = var_16
		var_33_34 = var_33_34(var_16.abs(arg_33_2 - arg_33_0.tfEntity.localEulerAngles.y) / 180, 1) * var_0_1.baseDuration

		local var_33_35 = {}

		table = var_16

		var_16.insert(var_33_35, function(arg_34_0)
			LeanTween = var_2_10001

			local var_34_0 = var_2_10001.moveLocal

			go = var_2_10003

			local var_34_1 = var_34_0(var_2_10003(arg_33_0.tfCamera), var_33_31, var_33_33)
			local var_34_2 = var_1.setEase

			LeanTweenType = var_4

			local var_34_3 = var_34_2(var_34_1, var_4.easeInOutSine)
			local var_34_4 = var_1.setOnComplete

			System = var_4

			local var_34_5 = var_34_4(var_34_3, var_4.Action(arg_34_0)).uniqueId

			table = var_2_10002

			var_2_10002.insert(arg_33_0.twFocusIds, var_34_5)

			local var_34_6 = arg_33_0.wsTimer

			var_2.AddTween(var_34_6, var_34_5)

			return
		end)

		table = var_16

		var_16.insert(var_33_35, function(arg_35_0)
			LeanTween = var_2_10001

			local var_35_0 = var_2_10001.rotateY

			go = var_2_10003

			local var_35_1 = var_35_0(var_2_10003(arg_33_0.tfEntity), arg_33_2, var_33_34)
			local var_35_2 = var_1.setEase

			LeanTweenType = var_4

			local var_35_3 = var_35_2(var_35_1, var_4.easeInOutSine)
			local var_35_4 = var_1.setOnComplete

			System = var_4

			local var_35_5 = var_35_4(var_35_3, var_4.Action(arg_35_0)).uniqueId

			table = var_2_10002

			var_2_10002.insert(arg_33_0.twFocusIds, var_35_5)

			local var_35_6 = arg_33_0.wsTimer

			var_2.AddTween(var_35_6, var_35_5)

			return
		end)

		parallelAsync = var_16

		var_16(var_33_35, function()
			existCall = var_2_10000

			var_2_10000(arg_33_5)

			return
		end)
	else
		arg_33_0.tfCamera.localPosition = var_33_31

		local var_33_36 = arg_33_0.tfEntity

		Vector3 = var_33_34
		var_33_36.localEulerAngles = var_33_34(0, arg_33_2, 0)
		existCall = var_33_36

		return var_33_36(arg_33_5)
	end

	return
end

function var_0_1.FocusPosInArea(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_1 then
		pg = var_1_10004

		local var_37_0 = var_1_10004.world_regions_data[arg_37_1]
		local var_37_1 = arg_37_0
		local var_37_2 = arg_37_0.FocusPos

		Vector2 = var_1_10008

		var_37_2(var_37_1, var_1_10008(var_37_0.regions_pos[1], var_37_0.regions_pos[2]), var_37_0.regions_rotation[1], 1, arg_37_2, arg_37_3)
	else
		arg_37_0:FocusPos(var_0_1.basePoint, 0, 0, arg_37_2, arg_37_3)
	end

	return
end

function var_0_1.SwitchArea(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = {}

	if arg_38_2 then
		tobool = var_1_10005
		var_1_10005 = var_1_10005(arg_38_1)
		tobool = var_1_10006

		if var_1_10005 ~= var_1_10006(arg_38_0.nowArea) then
			table = var_1_10005

			var_1_10005.insert(var_38_0, function(arg_39_0)
				local var_39_0 = arg_38_0

				var_1.SwitchMode(var_39_0, arg_38_1, arg_38_2, arg_39_0)

				return
			end)
		end
	end

	table = var_1_10005

	var_1_10005.insert(var_38_0, function(arg_40_0)
		setActive = var_2_10001

		var_2_10001(arg_38_0.tfAreaScene, not arg_38_1)

		setActive = var_2_10001

		var_2_10001(arg_38_0.tfMapScene, arg_38_1)

		setActive = var_2_10001

		var_2_10001(arg_38_0.tfMapModel, not arg_38_1)
		arg_40_0()

		return
	end)

	arg_38_0.nowArea = arg_38_1
	parallelAsync = var_5

	var_5({
		function(arg_41_0)
			seriesAsync = var_2_10001

			var_2_10001(var_38_0, arg_41_0)

			return
		end,
		function(arg_42_0)
			local var_42_0 = arg_38_0

			var_1.FocusPosInArea(var_42_0, arg_38_1, arg_38_2, arg_42_0)

			return
		end
	}, function()
		existCall = var_2_10000

		return var_2_10000(arg_38_3)
	end)

	return
end

function var_0_1.SwitchMode(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local function var_44_0(arg_45_0)
		setActive = var_2_10001

		var_2_10001(arg_44_0.tfAreaScene, true)

		local var_45_0 = arg_44_0.tfAreaScene
		local var_45_1 = var_1.GetComponent(var_45_0, "FMultiSpriteRenderCtrl")

		var_1.Init(var_45_1)

		var_1.alpha = arg_44_1 and 1 or 0

		local var_45_2 = var_1

		var_1.UpdateAlpha(var_45_2)

		LeanTween = var_2

		local var_45_3 = var_2.value

		go = var_45_2

		local var_45_4 = var_45_3(var_45_2(arg_44_0.tfAreaScene), arg_44_1 and 1 or 0, arg_44_1 and 0 or 1, var_0_1.baseDuration)
		local var_45_5 = var_2.setOnUpdate

		System = var_5

		local var_45_6 = var_45_5(var_45_4, var_5.Action_float(function(arg_46_0)
			var_0.alpha = arg_46_0

			return
		end))
		local var_45_7 = var_2.setOnComplete

		System = var_5

		local var_45_8 = var_45_7(var_45_6, var_5.Action(function()
			var_0.alpha = 1

			local var_47_0 = var_0

			var_0.UpdateAlpha(var_47_0)

			setActive = var_0

			var_0(arg_44_0.tfAreaScene, not arg_44_1)

			return arg_45_0()
		end)).uniqueId

		table = var_45_0

		var_45_0.insert(arg_44_0.twFocusIds, var_45_8)

		local var_45_9 = arg_44_0.wsTimer

		var_3.AddTween(var_45_9, var_45_8)

		return
	end

	local function var_44_1(arg_48_0)
		setActive = var_2_10001

		var_2_10001(arg_44_0.tfMapScene, true)

		local var_48_0 = arg_44_0.tfMapScene
		local var_48_1 = var_1.GetComponent(var_48_0, "FMultiSpriteRenderCtrl")

		var_1.Init(var_48_1)

		var_1.alpha = arg_44_1 and 0 or 1

		local var_48_2 = var_1

		var_1.UpdateAlpha(var_48_2)

		LeanTween = var_2

		local var_48_3 = var_2.value

		go = var_48_2

		local var_48_4 = var_48_3(var_48_2(arg_44_0.tfMapScene), arg_44_1 and 0 or 1, arg_44_1 and 1 or 0, var_0_1.baseDuration)
		local var_48_5 = var_2.setOnUpdate

		System = var_5

		local var_48_6 = var_48_5(var_48_4, var_5.Action_float(function(arg_49_0)
			var_0.alpha = arg_49_0

			return
		end))
		local var_48_7 = var_2.setOnComplete

		System = var_5

		local var_48_8 = var_48_7(var_48_6, var_5.Action(function()
			var_0.alpha = 1

			local var_50_0 = var_0

			var_0.UpdateAlpha(var_50_0)

			setActive = var_0

			var_0(arg_44_0.tfMapScene, arg_44_1)

			return arg_48_0()
		end)).uniqueId

		table = var_48_0

		var_48_0.insert(arg_44_0.twFocusIds, var_48_8)

		local var_48_9 = arg_44_0.wsTimer

		var_3.AddTween(var_48_9, var_48_8)

		return
	end

	local function var_44_2(arg_51_0)
		setActive = var_2_10001

		var_2_10001(arg_44_0.tfMapModel, true)

		local var_51_0 = {}
		local var_51_1 = var_0_1.baseDuration

		table = var_3

		var_3.insert(var_51_0, function(arg_52_0)
			local var_52_0 = arg_44_0.tfModel
			local var_52_1 = var_1.Find(var_52_0, "Terrain_LOD9_perfect")
			local var_52_2 = var_1.GetComponent(var_52_1, "MeshRenderer").material

			var_2.SetFloat(var_52_2, "_Invisible", arg_44_1 and 1 or 0)

			LeanTween = var_3

			local var_52_3 = var_3.value

			go = var_52_2

			local var_52_4 = var_52_3(var_52_2(var_1), arg_44_1 and 1 or 0, arg_44_1 and 0 or 1, var_51_1)
			local var_52_5 = var_3.setOnUpdate

			System = var_6

			local var_52_6 = var_52_5(var_52_4, var_6.Action_float(function(arg_53_0)
				local var_53_0 = var_0

				var_1.SetFloat(var_53_0, "_Invisible", arg_53_0)

				return
			end))
			local var_52_7 = var_3.setOnComplete

			System = var_6

			local var_52_8 = var_52_7(var_52_6, var_6.Action(function()
				local var_54_0 = var_0

				var_0.SetFloat(var_54_0, "_Invisible", arg_44_1 and 0 or 1)
				arg_52_0()

				return
			end)).uniqueId

			table = var_52_1

			var_52_1.insert(arg_44_0.twFocusIds, var_52_8)

			local var_52_9 = arg_44_0.wsTimer

			var_4.AddTween(var_52_9, var_52_8)

			return
		end)

		table = var_3

		var_3.insert(var_51_0, function(arg_55_0)
			local var_55_0 = arg_44_0.tfModel
			local var_55_1 = var_1.Find(var_55_0, "decolation_model")
			local var_55_2 = var_1.GetComponent(var_55_1, "FMultiSpriteRenderCtrl")

			var_2.Init(var_55_2)

			var_2.alpha = arg_44_1 and 1 or 0

			local var_55_3 = var_2

			var_2.UpdateAlpha(var_55_3)

			LeanTween = var_3

			local var_55_4 = var_3.value

			go = var_55_3

			local var_55_5 = var_55_4(var_55_3(var_1), arg_44_1 and 1 or 0, arg_44_1 and 0 or 1, var_51_1)
			local var_55_6 = var_3.setOnUpdate

			System = var_6

			local var_55_7 = var_55_6(var_55_5, var_6.Action_float(function(arg_56_0)
				var_0.alpha = arg_56_0

				return
			end))
			local var_55_8 = var_3.setOnComplete

			System = var_6

			local var_55_9 = var_55_8(var_55_7, var_6.Action(function()
				var_0.alpha = 1

				local var_57_0 = var_0

				var_0.UpdateAlpha(var_57_0)
				arg_55_0()

				return
			end)).uniqueId

			table = var_55_1

			var_55_1.insert(arg_44_0.twFocusIds, var_55_9)

			local var_55_10 = arg_44_0.wsTimer

			var_4.AddTween(var_55_10, var_55_9)

			return
		end)

		parallelAsync = var_3

		var_3(var_51_0, function()
			setActive = var_3_10000

			var_3_10000(arg_44_0.tfMapModel, not arg_44_1)

			return arg_51_0()
		end)

		return
	end

	local function var_44_3()
		local var_59_0 = arg_44_0

		var_0.BreathRotate(var_59_0, not arg_44_1)

		existCall = var_0

		return var_0(arg_44_3)
	end

	if arg_44_2 then
		parallelAsync = var_1_10008

		var_1_10008({
			var_44_0,
			var_44_1,
			var_44_2
		}, function()
			return var_44_3()
		end)
	else
		return var_44_3()
	end

	return
end

var_0_1.LowRotation = -5
var_0_1.HeightRotation = 5
var_0_1.BreathTime = 18

function var_0_1.BreathRotate(arg_61_0, arg_61_1)
	if arg_61_0.twRotateId then
		LeanTween = var_2

		var_2.cancel(arg_61_0.twRotateId)

		arg_61_0.twRotateId = nil
	end

	if not arg_61_1 then
		return
	end

	local var_61_0 = -1

	local function var_61_1()
		var_61_0 = -1 * var_61_0

		local var_62_0 = arg_61_0

		LeanTween = var_2_10001

		local var_62_1 = var_2_10001.rotateY

		go = var_2_10003

		local var_62_2 = var_2_10003(arg_61_0.tfEntity)
		local var_62_3

		if var_61_0 ~= 1 or not var_0_1.HeightRotation then
			var_62_3 = var_0_1.LowRotation
		end

		local var_62_4 = var_62_1(var_62_2, var_62_3, var_0_1.BreathTime)
		local var_62_5 = var_1.setEase

		LeanTweenType = var_62_3

		local var_62_6 = var_62_5(var_62_4, var_62_3.easeOutSine)
		local var_62_7 = var_1.setOnComplete

		System = var_4
		var_62_0.twRotateId = var_62_7(var_62_6, var_4.Action(function()
			var_61_1()

			return
		end)).uniqueId

		return
	end

	LeanTween = var_1_10004

	local var_61_2 = var_1_10004.rotateY

	go = var_1_10006

	local var_61_3 = var_61_2(var_1_10006(arg_61_0.tfEntity), var_0_1.LowRotation, var_0_1.BreathTime / 2)
	local var_61_4 = var_4.setEase

	LeanTweenType = var_7

	local var_61_5 = var_61_4(var_61_3, var_7.easeOutSine)
	local var_61_6 = var_4.setOnComplete

	System = var_7

	local var_61_7 = var_61_6(var_61_5, var_7.Action(function()
		var_61_1()

		return
	end))

	arg_61_0.twRotateId = var_4.setDelay(var_61_7, 1).uniqueId

	return
end

function var_0_1.CheckIsTweening(arg_65_0)
	::label_65_0::

	if #arg_65_0.twFocusIds > 0 then
		LeanTween = var_1

		if not var_1.isTweening(arg_65_0.twFocusIds[1]) then
			repeat
				table = var_1

				var_1.remove(arg_65_0.twFocusIds, 1)

				goto label_65_0
			until true
		end
	end

	local var_65_0

	if not arg_65_0.isTransAnim then
		var_65_0 = #arg_65_0.twFocusIds > 0
	end

	return var_65_0
end

function var_0_1.ActiveTrans(arg_66_0, arg_66_1)
	if arg_66_0.entranceTplDic[arg_66_1.id].portCamp then
		-- block empty
	else
		local var_66_0 = arg_66_0.tfMapSelect
		local var_66_1 = var_3.Find(var_66_0, "A" .. arg_66_1:GetColormaskUniqueID() .. "_2")

		setActive = var_1_10004

		var_1_10004(var_66_1, true)

		local var_66_2 = var_66_1:GetComponent("SpriteRenderer").color

		var_66_2.a = 0

		local var_66_3 = var_66_1
		local var_66_4 = var_66_1.GetComponent(var_66_3, "SpriteRenderer")

		var_66_4.color = var_66_2
		LeanTween = var_66_4

		local var_66_5 = var_66_4.alpha

		go = var_66_3

		local var_66_6 = var_66_5(var_66_3(var_66_1), 1, 0.3)
		local var_66_7 = var_5.setOnComplete

		System = var_8

		var_66_7(var_66_6, var_8.Action(function()
			LeanTween = var_2_10000

			local var_67_0 = var_2_10000.alpha

			go = var_2_10002

			local var_67_1 = var_67_0(var_2_10002(var_66_1), 0, 0.2)
			local var_67_2 = var_0.setDelay(var_67_1, 0.1)
			local var_67_3 = var_0.setOnComplete

			System = var_3

			var_67_3(var_67_2, var_3.Action(function()
				setActive = var_3_10000

				var_3_10000(var_66_1, arg_66_0.selectEntrance == arg_66_1)

				var_66_2.a = 1

				local var_68_0 = var_66_1

				var_0.GetComponent(var_68_0, "SpriteRenderer").color = var_66_2

				return
			end))

			return
		end))
	end

	return
end

function var_0_1.DisplayTransport(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = {}

	pairs = var_1_10004

	for iter_69_0, iter_69_1 in var_1_10004(arg_69_0.atlas.transportDic) do
		if iter_69_1 and not arg_69_1[iter_69_0] then
			var_69_0[iter_69_0] = true
		end
	end

	arg_69_0:UpdateTransMark(var_69_0, arg_69_2)

	return
end

function var_0_1.UpdateTransMark(arg_70_0, arg_70_1, arg_70_2)
	pairs = var_1_10003

	for iter_70_0, iter_70_1 in var_1_10003(arg_70_1) do
		if iter_70_1 then
			arg_70_0.isTransAnim = true

			local var_70_0 = arg_70_0
			local var_70_1 = arg_70_0.ActiveTrans
			local var_70_2 = arg_70_0.atlas

			var_70_1(var_70_0, var_11.GetEntrance(var_70_2, iter_70_0))
		end
	end

	if arg_70_0.isTransAnim then
		local var_70_3 = arg_70_0.wsTimer
		local var_70_4 = var_3.AddTimer(var_70_3, function()
			arg_70_0.isTransAnim = false

			arg_70_2()

			return
		end, 0.6)

		var_3.Start(var_70_4)
	else
		arg_70_2()
	end

	return
end

function var_0_1.UpdateActiveMark(arg_72_0)
	nowWorld = var_1_10001

	local var_72_0 = var_1_10001()
	local var_72_1 = var_1.GetActiveMap(var_72_0)
	local var_72_2 = var_1.CkeckTransport(var_72_1)

	eachChild = var_1_10002

	var_1_10002(arg_72_0.tfActiveMark, function(arg_73_0)
		setActive = var_2_10001

		var_2_10001(arg_73_0:Find("base"), var_72_2)

		setActive = var_2_10001

		var_2_10001(arg_73_0:Find("limit"), not var_72_2)

		return
	end)

	return
end

return var_0_1
