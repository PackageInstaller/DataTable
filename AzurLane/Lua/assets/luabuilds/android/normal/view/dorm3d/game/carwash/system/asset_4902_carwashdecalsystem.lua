class = var_0_10000

local var_0_0 = "CarWashDecalSystem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_1.GENERATE_DECALS = "CarWashDecalSystem.GENERATE_DECALS"
var_0_1.GENERATOR_NAME = "[DECALROOT]/[DECAL GENERATOR]"
var_0_1.ON_SHOOT_INTERVAL = 0.1

function var_0_1.OnInit(arg_1_0)
	arg_1_0:InitSceneRefs()

	arg_1_0.selectedCarDecalType = nil
	arg_1_0.selectedLadyDecalType = nil
	arg_1_0.isShooting = false

	return
end

function var_0_1.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_1.GENERATE_DECALS, function(arg_3_0)
		local var_3_0 = arg_2_0
		local var_3_1 = var_1.RegenerateAll

		System = var_2_10003

		var_3_1(var_3_0, var_2_10003.Action_int(function(arg_4_0)
			local var_4_0 = arg_2_0
			local var_4_1 = var_1.Emit

			CarWashGameFlowSystem = var_3_10003

			var_4_1(var_4_0, var_3_10003.SET_STAINS_COUNT_MAX, arg_4_0)

			local var_4_2 = arg_2_0
			local var_4_3 = var_1.Emit

			CarWashGameFlowSystem = var_3

			var_4_3(var_4_2, var_3.SET_STAINS_COUNT, arg_4_0)

			return
		end))

		return
	end)

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.Bind

	CarWashGameFlowSystem = var_3

	var_2_1(var_2_0, var_3.UPDATE_IS_SHOOTING, function(arg_5_0, arg_5_1)
		arg_2_0.isShooting = arg_5_1.newValue

		return
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.Bind

	CarWashGameFlowSystem = var_3

	var_2_3(var_2_2, var_3.UPDATE_CURRENT_GUN_TYPE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.OnSwitchGun(var_6_0, arg_6_1.newValue)

		return
	end)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.Bind

	CarWashRaycastSystem = var_3

	var_2_5(var_2_4, var_3.UPDATE_DECAL_RAYCAST, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_2_0

		var_2.OnShootLogic(var_7_0, arg_7_1)

		return
	end)

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.Bind

	CarWashTimelineSystem = var_3

	var_2_7(var_2_6, var_3.TIMELINE_SEQUENCE_BEGIN, function(arg_8_0)
		local var_8_0 = arg_2_0

		var_1.EnableDecalRoot(var_8_0, false)

		return
	end)

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.Bind

	CarWashTimelineSystem = var_3

	var_2_9(var_2_8, var_3.TIMELINE_SEQUENCE_END, function(arg_9_0)
		local var_9_0 = arg_2_0

		var_1.EnableDecalRoot(var_9_0, true)

		return
	end)

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.Bind

	CarWashGameFlowSystem = var_3

	var_2_11(var_2_10, var_3.UPDATE_GAME_STATE, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_1.newValue

		CarWashConst = var_2_10003

		local var_10_1

		if var_10_0 == var_2_10003.GAME_STATE.PHASE_2 then
			var_10_1 = arg_2_0

			var_2.EnableDecalRoot(var_10_1, false)
		else
			local var_10_2 = arg_10_1.newValue

			CarWashConst = var_10_1

			if var_10_2 == var_10_1.GAME_STATE.PHASE_1 then
				local var_10_3 = arg_2_0

				var_2.EnableDecalRoot(var_10_3, true)
			end
		end

		return
	end)

	return
end

function var_0_1.OnDispose(arg_11_0)
	arg_11_0.randomDecalGenerator = nil
	arg_11_0.generatorTF = nil
	arg_11_0.decalParent = nil

	return
end

function var_0_1.InitSceneRefs(arg_12_0)
	GameObject = var_1_10001

	local var_12_0 = var_1_10001.Find(var_0_1.GENERATOR_NAME)

	assert = var_2

	var_2(var_12_0, "CarWash RandomDecalGenerator object not found: " .. var_0_1.GENERATOR_NAME)

	arg_12_0.generatorTF = var_12_0.transform
	arg_12_0.decalParent = arg_12_0.generatorTF

	local var_12_1 = var_12_0
	local var_12_2 = var_12_0.GetComponent

	typeof = var_4
	RandomDecalGenerator = var_5
	arg_12_0.randomDecalGenerator = var_12_2(var_12_1, var_4(var_5))
	assert = var_2

	var_2(arg_12_0.randomDecalGenerator, "RandomDecalGenerator component not found on " .. var_0_1.GENERATOR_NAME)

	return
end

function var_0_1.EnableDecalRoot(arg_13_0, arg_13_1)
	if arg_13_0.decalParent then
		setActive = var_2

		var_2(arg_13_0.decalParent, arg_13_1)
	end

	return
end

function var_0_1.GenerateDecals(arg_14_0)
	return arg_14_0:GenerateAll()
end

function var_0_1.OnSwitchGun(arg_15_0, arg_15_1)
	CarWashConst = var_1_10002

	local var_15_0 = var_1_10002.GetGunConfig(arg_15_1)

	assert = var_3

	local var_15_1 = var_15_0
	local var_15_2 = "CarWash gun config not found: "

	tostring = var_1_10006

	var_3(var_15_1, var_15_2 .. var_1_10006(arg_15_1))

	local var_15_3 = var_15_0.decalType

	assert = var_15_1

	local var_15_4 = var_15_3
	local var_15_5 = "CarWash decal types not found for gun type: "

	tostring = var_7

	var_15_1(var_15_4, var_15_5 .. var_7(arg_15_1))

	assert = var_15_1

	local var_15_6 = var_15_3.onCar
	local var_15_7 = "CarWash car decal type not found for gun type: "

	tostring = var_7

	var_15_1(var_15_6, var_15_7 .. var_7(arg_15_1))

	assert = var_15_1

	local var_15_8 = var_15_3.onLady
	local var_15_9 = "CarWash lady decal type not found for gun type: "

	tostring = var_7

	var_15_1(var_15_8, var_15_9 .. var_7(arg_15_1))

	arg_15_0.currentGunType = arg_15_1
	arg_15_0.selectedCarDecalType = var_15_3.onCar
	arg_15_0.selectedLadyDecalType = var_15_3.onLady

	return
end

function var_0_1.OnShootLogic(arg_16_0, arg_16_1)
	if not arg_16_0.isShooting then
		return
	end

	local var_16_0 = arg_16_1.targets
	local var_16_1 = arg_16_1.hit
	local var_16_2 = arg_16_1.hitInfo
	local var_16_3 = false
	local var_16_4
	local var_16_5 = false
	local var_16_6 = {}
	local var_16_7 = 16191
	local var_16_8 = 16191

	ipairs = var_1_10011

	for iter_16_0, iter_16_1 in var_1_10011(var_16_0) do
		local var_16_9 = iter_16_1.gameObject.transform
		local var_16_10 = var_1_10016.layer

		CarWashConst = var_1_10019

		if var_16_10 == var_1_10019.CAR_LAYER then
			var_16_5 = true
			math = var_16_10
			var_16_7 = var_16_10.min(var_16_7, iter_16_0)
		end

		local var_16_11 = var_1_10016.layer

		CarWashConst = var_1_10019

		if var_16_11 == var_1_10019.LADY_LAYER then
			var_16_3 = true
			var_16_4 = var_16_9
			math = var_16_11
			var_16_8 = var_16_11.min(var_16_8, iter_16_0)
		end

		var_1_10019 = var_1_10016

		local var_16_12 = var_1_10016.GetComponent

		typeof = var_1_10020
		DecalController = var_1_10021

		if var_16_12(var_1_10019, var_1_10020(var_1_10021)) then
			table = var_1_10019

			var_1_10019.insert(var_16_6, var_18)
		end
	end

	local var_16_14

	if var_16_1 and var_16_3 and var_16_8 < var_16_7 then
		table = var_16_14

		if not var_16_14.contains(arg_16_0:GetGameConfig().non_decal_colliders, var_16_2.collider.name) then
			assert = var_16_14

			var_16_14(var_16_2, "CarWash decal hitInfo is nil")

			_ = var_16_14

			if not var_16_14.any(var_16_6, function(arg_17_0)
				return arg_17_0.decalType == arg_16_0.selectedLadyDecalType
			end) then
				local var_16_13 = arg_16_0

				var_16_14 = arg_16_0.GenerateDecalAtScreenCenter

				local var_16_15 = arg_16_0.selectedLadyDecalType
				local var_16_16 = var_16_2

				var_1_10016 = arg_16_0

				var_16_14(var_16_13, var_16_15, var_16_16, arg_16_0.GetColliderBone(var_1_10016, var_16_4), arg_16_0:GetCapsuleColliderRadius(var_16_4))
			end
		end
	end

	if var_16_1 and var_16_5 and var_16_7 < var_16_8 then
		assert = var_16_14

		var_16_14(var_16_2, "CarWash decal hitInfo is nil")

		_ = var_16_14

		if not var_16_14.any(var_16_6, function(arg_18_0)
			return arg_18_0.decalType == arg_16_0.selectedCarDecalType
		end) then
			arg_16_0:GenerateDecalAtScreenCenter(arg_16_0.selectedCarDecalType, var_16_2)
		end

		ipairs = var_11

		for iter_16_2, iter_16_3 in var_11(var_16_6) do
			CarWashConst = var_1_10016

			if var_1_10016.GetStainsConfig(iter_16_3.decalType) then
				local var_16_17 = 0
				local var_16_18 = arg_16_0.currentGunType == var_1_10016.targetGunType
				local var_16_19

				if var_1_10016.coverDecal then
					_ = var_16_19
					var_16_19 = var_16_19.any(var_16_6, function(arg_19_0)
						return arg_19_0.decalType == var_1_10016.coverDecal
					end)
				end

				local var_16_20

				if not var_16_18 or not var_1_10016.fadePerSec then
					var_16_20 = 0
				end

				local var_16_21 = var_16_17 + var_16_20
				local var_16_22

				if not var_16_18 or not var_16_19 or not var_1_10016.coverBuff then
					var_16_22 = 0
				end

				if var_16_21 + var_16_22 > 0 then
					iter_16_3:SetAlpha(iter_16_3.Alpha - var_17 * var_0_1.ON_SHOOT_INTERVAL)
				end

				if iter_16_3.Alpha <= 0 then
					StaticDecalSpawner = var_20

					var_20.Despawn(iter_16_3)

					local var_16_23 = arg_16_0
					local var_16_24 = arg_16_0.Emit

					CarWashGameFlowSystem = var_1_10022

					var_16_24(var_16_23, var_1_10022.DECREASE_STAINS_COUNT, 1)
				end
			end
		end
	end

	return
end

function var_0_1.GetColliderBone(arg_20_0, arg_20_1)
	return arg_20_1.parent
end

function var_0_1.GetCapsuleColliderRadius(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.GetComponent

	typeof = var_1_10004

	local var_21_2 = var_21_1(var_21_0, var_1_10004("UnityEngine.CapsuleCollider"))
	local var_21_3 = 16191

	if var_21_2 then
		var_21_3 = var_21_2.radius * 2 - 0.01
	end

	math = var_4

	local var_21_4 = var_4.min
	local var_21_5 = var_21_3

	CarWashConst = var_1_10006

	return var_21_4(var_21_5, var_1_10006.DEFAULT_LADY_DECAL_SIZE)
end

function var_0_1.GenerateDecalAtScreenCenter(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	assert = var_1_10005

	var_1_10005(arg_22_1, "CarWash decal type is nil")

	CarWashConst = var_1_10005

	local var_22_0 = var_1_10005.GetDecalConfig(arg_22_1)

	assert = var_22_3

	local var_22_1 = var_22_0
	local var_22_2 = "CarWash decal config not found: "

	tostring = var_1_10009

	var_22_3(var_22_1, var_22_2 .. var_1_10009(arg_22_1))

	local var_22_3

	if not arg_22_4 then
		::label_22_0::

		math = var_22_3
		var_22_3 = var_22_3.random()
		CarWashConst = var_22_1
		var_22_1 = var_22_1.ORTHOGRAPHIC_SIZE_RANGE[2]
		CarWashConst = var_8
		var_22_3 = var_22_3 * (var_22_1 - var_8.ORTHOGRAPHIC_SIZE_RANGE[1])
		CarWashConst = var_22_1
		var_22_3 = var_22_3 + var_22_1.ORTHOGRAPHIC_SIZE_RANGE[1]
	end

	math = var_22_1

	local var_22_4 = var_22_1.floor(var_22_3 * 100) / 100

	math = var_7

	local var_22_5 = var_7.random()

	CarWashConst = var_8

	local var_22_6 = var_8.ROTATE_RANGE[2]

	CarWashConst = var_9

	local var_22_7 = var_22_5 * (var_22_6 - var_9.ROTATE_RANGE[1])

	CarWashConst = var_8

	local var_22_8 = var_22_7 + var_8.ROTATE_RANGE[1]

	DecalRaycastUtil = var_8

	local var_22_9 = var_8.TryComputeDecalPlacement
	local var_22_10 = arg_22_2.point
	local var_22_11 = arg_22_2.normal
	local var_22_12 = var_22_4
	local var_22_13 = var_22_0.aspectRatio

	CarWashConst = var_1_10013

	local var_22_14, var_22_15 = var_22_9(var_22_10, var_22_11, var_22_12, var_22_13, var_1_10013.LAYER_MASK, var_22_8, nil)

	if not var_22_14 then
		return nil
	end

	local var_22_16 = arg_22_0

	if not arg_22_0.GetSourceMaterial(var_22_16, var_22_0.sourceMaterial) then
		return nil
	end

	DecalControllerPoolMgr = var_22_16

	local var_22_17 = var_22_16.Inst
	local var_22_18 = var_11.Acquire
	local var_22_19 = var_22_15.position
	local var_22_20 = var_22_15.rotation
	local var_22_21 = arg_22_3 or arg_22_0.decalParent
	local var_22_22 = var_10
	local var_22_23 = var_22_4
	local var_22_24 = var_22_0.aspectRatio
	local var_22_25 = var_22_15.nearClip
	local var_22_26 = var_22_15.farClip
	local var_22_27 = var_22_0.renderQueue
	local var_22_28

	if not var_22_0.decalType then
		var_22_28 = arg_22_1
	end

	return var_22_18(var_22_17, var_22_19, var_22_20, var_22_21, var_22_22, var_22_23, var_22_24, var_22_25, var_22_26, var_22_27, var_22_28, var_22_0.useAutoFade, var_22_0.autoFadeStartTime, var_22_0.autoFadeTime)
end

function var_0_1.GetSourceMaterial(arg_23_0, arg_23_1)
	assert = var_1_10002
	type = var_1_10003

	var_1_10002(var_1_10003(arg_23_1) == "table", "CarWash decal sourceMaterial config should be table")

	assert = var_1_10002

	var_1_10002(#arg_23_1 > 0, "CarWash decal sourceMaterial config is empty")

	math = var_1_10002

	local var_23_0 = arg_23_1[var_1_10002.random(1, #arg_23_1)]

	DecalMaterialPoolMgr = var_3

	local var_23_1 = var_3.Inst

	assert = var_4

	var_4(var_23_1, "DecalMaterialPoolMgr.Inst not found")

	local var_23_2 = var_23_1.sourceMaterials

	assert = var_5

	var_5(var_23_2, "DecalMaterialPoolMgr.sourceMaterials not found")

	assert = var_5

	local var_23_3 = var_23_0 >= 0 and var_23_0 < var_23_2.Count
	local var_23_4 = "Invalid decal sourceMaterial index: "

	tostring = var_1_10008

	var_5(var_23_3, var_23_4 .. var_1_10008(var_23_0))

	return var_23_2:get_Item(var_23_0)
end

function var_0_1.GenerateAll(arg_24_0)
	if not arg_24_0.randomDecalGenerator then
		return 0
	end

	local var_24_0 = arg_24_0.randomDecalGenerator

	return var_1.GenerateAll(var_24_0)
end

function var_0_1.GenerateRegion(arg_25_0, arg_25_1)
	if not arg_25_0.randomDecalGenerator then
		return 0
	end

	local var_25_0 = arg_25_0.randomDecalGenerator

	return var_2.GenerateRegion(var_25_0, arg_25_1)
end

function var_0_1.RegenerateAll(arg_26_0, arg_26_1)
	if not arg_26_0.randomDecalGenerator then
		return 0
	end

	local var_26_0 = arg_26_0.randomDecalGenerator

	return var_2.RegenerateAll(var_26_0, arg_26_1)
end

function var_0_1.RegenerateRegion(arg_27_0, arg_27_1)
	if not arg_27_0.randomDecalGenerator then
		return 0
	end

	local var_27_0 = arg_27_0.randomDecalGenerator

	return var_2.RegenerateRegion(var_27_0, arg_27_1)
end

function var_0_1.ClearGenerated(arg_28_0)
	if not arg_28_0.randomDecalGenerator then
		return
	end

	local var_28_0 = arg_28_0.randomDecalGenerator

	var_1.ClearGenerated(var_28_0)

	return
end

return var_0_1
