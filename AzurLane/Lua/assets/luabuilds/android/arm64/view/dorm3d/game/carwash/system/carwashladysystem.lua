class = var_0_10000

local var_0_0 = "CarWashLadySystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_1.UPDATE_PHASE2_TIPS = "CarWashLadySystem.UPDATE_PHASE2_TIPS"
var_0_1.UPDATE_EXPRESSION_HUD_POSITION = "CarWashLadySystem.UPDATE_EXPRESSION_HUD_POSITION"
var_0_1.PLAY_PHASE2_REACTION = "CarWashLadySystem.PLAY_PHASE2_REACTION"

function var_0_1.OnInit(arg_1_0)
	arg_1_0:InitSceneRefs()
	arg_1_0:InitLady()

	arg_1_0.hitForce = 0
	arg_1_0.gunType = nil
	arg_1_0.hiddenReactionHitTime = 0
	arg_1_0.hiddenReactionConfigId = nil
	arg_1_0.hiddenReactionTriggered = false
	arg_1_0.reactionAnim = nil
	arg_1_0.reactionCallback = nil
	arg_1_0.waitingReactionReturnIdle = false
	arg_1_0.reactionLeftIdle = false
	arg_1_0.gameState = nil

	return
end

function var_0_1.RegisterEvents(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.Bind

	CarWashGameFlowSystem = var_1_10004

	var_2_1(var_2_0, var_1_10004.UPDATE_LADY_POS, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.OnLadyPosChanged(var_3_0, arg_3_1.newValue)

		return
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.Bind

	CarWashGameFlowSystem = var_4

	var_2_3(var_2_2, var_4.UPDATE_CURRENT_GUN_TYPE, function(arg_4_0, arg_4_1)
		arg_2_0.gunType = arg_4_1.newValue

		local var_4_0 = arg_2_0

		CarWashConst = var_3
		var_4_0.hitForce = var_3.GetGunConfig(arg_4_1.newValue).force

		local var_4_1 = arg_2_0

		var_2.ResetHiddenReactionState(var_4_1)

		return
	end)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.Bind

	CarWashGameFlowSystem = var_4

	var_2_5(var_2_4, var_4.UPDATE_IS_SHOOTING, function(arg_5_0, arg_5_1)
		if not arg_5_1.newValue then
			local var_5_0 = arg_2_0

			var_2.ResetHiddenReactionState(var_5_0)
		end

		return
	end)

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.Bind

	CarWashRaycastSystem = var_4

	var_2_7(var_2_6, var_4.UPDATE_COMMON_RAYCAST, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.OnCommonRaycast(var_6_0, arg_6_1)

		return
	end)

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.Bind

	CarWashGameFlowSystem = var_4

	var_2_9(var_2_8, var_4.UPDATE_GAME_STATE, function(arg_7_0, arg_7_1)
		arg_2_0.gameState = arg_7_1.newValue

		return
	end)
	arg_2_0:Bind(var_0_1.PLAY_PHASE2_REACTION, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_2_0

		var_2.OnPlayPhase2Reaction(var_8_0, arg_8_1)

		return
	end)

	local var_2_10 = arg_2_0
	local var_2_11 = arg_2_0.Bind

	CarWashTimelineSystem = var_4

	var_2_11(var_2_10, var_4.TIMELINE_SEQUENCE_BEGIN, function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.ViewUtils.SetLayer
		local var_9_1 = arg_2_0.ladyTransform

		Layer = var_2_10003

		var_9_0(var_9_1, var_2_10003.UIHidden)

		return
	end)

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0.Bind

	CarWashTimelineSystem = var_4

	var_2_13(var_2_12, var_4.TIMELINE_SEQUENCE_END, function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.ViewUtils.SetLayer
		local var_10_1 = arg_2_0.ladyTransform

		Layer = var_2_10003

		var_10_0(var_10_1, var_2_10003.Character3D)

		pg = var_10_0

		local var_10_2 = var_10_0.ViewUtils.SetLayer
		local var_10_3 = arg_2_0.physicsCollider

		Layer = var_3

		var_10_2(var_10_3, var_3.CameraRT)

		return
	end)

	return
end

function var_0_1.OnDispose(arg_11_0)
	arg_11_0.hiddenReactionHitTime = nil
	arg_11_0.hiddenReactionConfigId = nil
	arg_11_0.hiddenReactionTriggered = nil
	arg_11_0.reactionAnim = nil
	arg_11_0.reactionCallback = nil
	arg_11_0.waitingReactionReturnIdle = nil
	arg_11_0.reactionLeftIdle = nil
	arg_11_0.gameState = nil
	arg_11_0.colliderMap = nil

	return
end

function var_0_1.OnUpdate(arg_12_0, arg_12_1)
	arg_12_0:UpdateReactionState()
	arg_12_0:UpdateExpressionHUDPosition()
	arg_12_0:UpdatePhase2Tips()

	return
end

function var_0_1.InitSceneRefs(arg_13_0)
	GameObject = var_1_10001
	arg_13_0.ladyPositionRoot = var_1_10001.Find("[LADYPOSITION]").transform
	arg_13_0.ladyGO = arg_13_0:GetLadyGO()
	arg_13_0.mainCamera = arg_13_0:GetMainCamera()
	arg_13_0.mainCameraTF = arg_13_0:GetMainCameraTF()

	return
end

function var_0_1.InitLady(arg_14_0)
	arg_14_0.ladyTransform = arg_14_0.ladyGO.transform

	local var_14_0 = arg_14_0.ladyGO
	local var_14_1 = var_1.GetComponent

	typeof = var_1_10004
	Animator = var_1_10006
	arg_14_0.ladyAnimator = var_14_1(var_14_0, var_1_10004(var_1_10006))

	local var_14_2 = arg_14_0.ladyAnimator

	arg_14_0.ladyAnimBaseLayerIndex = var_1.GetLayerIndex(var_14_2, "Base Layer")

	local var_14_3 = arg_14_0.ladyAnimator

	arg_14_0.ladyAnimFaceLayerIndex = var_1.GetLayerIndex(var_14_3, "Face")

	local var_14_4 = arg_14_0.ladyTransform

	arg_14_0.physicsCollider = var_1.Find(var_14_4, "physicsCollider")
	pg = var_1

	local var_14_5 = var_1.ViewUtils.SetLayer
	local var_14_6 = arg_14_0.ladyTransform

	Layer = var_4

	var_14_5(var_14_6, var_4.Character3D)

	pg = var_14_5

	local var_14_7 = var_14_5.ViewUtils.SetLayer
	local var_14_8 = arg_14_0.physicsCollider

	Layer = var_4

	var_14_7(var_14_8, var_4.CameraRT)

	GetComponent = var_14_7
	arg_14_0.ladyOwner = var_14_7(arg_14_0.ladyTransform, "GraphOwner")
	arg_14_0.ladyOwner.enabled = false

	local var_14_9 = arg_14_0.ladyTransform

	arg_14_0.hitReactionLayers = var_1.Find(var_14_9, "CarWashHitReactionLayers")

	local var_14_10 = arg_14_0.hitReactionLayers

	arg_14_0.commonIK = var_1.Find(var_14_10, "CommonIK")
	setActive = var_1

	var_1(arg_14_0.commonIK, true)

	eachChild = var_1

	var_1(arg_14_0.commonIK, function(arg_15_0)
		setActive = var_2_10001

		var_2_10001(arg_15_0, false)

		return
	end)

	local var_14_11 = arg_14_0.ladyTransform

	arg_14_0.boneBip001 = var_1.Find(var_14_11, "all/Bip001")

	local var_14_12 = arg_14_0.ladyTransform

	arg_14_0.boneHUD = var_1.Find(var_14_12, "all/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2/Bip001 Spine3/Bip001 Neck/Bip001 Head/ExpressionHUD")
	assert = var_1

	var_1(arg_14_0.boneHUD, "CarWash ExpressionHUD bone not found")
	arg_14_0:InitColliderMap()

	return
end

function var_0_1.InitColliderMap(arg_16_0)
	arg_16_0.colliderMap = {}

	local var_16_0 = arg_16_0.ladyGO
	local var_16_1 = var_1.GetComponentsInChildren

	typeof = var_1_10004
	UnityEngine = var_1_10006

	local var_16_2 = var_16_1(var_16_0, var_1_10004(var_1_10006.Collider), true)
	local var_16_3 = var_1.ToTable(var_16_2)

	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(var_16_3) do
		arg_16_0.colliderMap[iter_16_1.gameObject.name] = iter_16_1
	end

	return
end

function var_0_1.UpdateExpressionHUDPosition(arg_17_0)
	local var_17_0 = arg_17_0.mainCamera
	local var_17_1 = var_1.WorldToScreenPoint(var_17_0, arg_17_0.boneHUD.position)

	arg_17_0:Emit(var_0_1.UPDATE_EXPRESSION_HUD_POSITION, {
		screenPosition = var_17_1,
		visible = var_17_1.z > 0
	})

	return
end

function var_0_1.OnLadyPosChanged(arg_18_0, arg_18_1)
	arg_18_0:ResetHiddenReactionState()
	arg_18_0:ResetReactionState()

	arg_18_0.posConfig = arg_18_1

	local var_18_0 = arg_18_0.ladyPositionRoot
	local var_18_1 = var_2.Find(var_18_0, arg_18_0.posConfig.pos)

	assert = var_1_10003

	var_1_10003(var_18_1, "CarWash lady position node not found: " .. arg_18_0.posConfig.pos)

	setParent = var_1_10003

	var_1_10003(arg_18_0.ladyTransform, var_18_1)
	arg_18_0:PlayAnim(arg_18_0.posConfig.idle_anim, 0)

	if arg_18_0.hitReactionTF and arg_18_0.hitReactionComp then
		setActive = var_3

		var_3(arg_18_0.hitReactionTF, false)

		arg_18_0.hitReactionComp = nil
	end

	local var_18_4

	if arg_18_0.posConfig.hit_reaction_layer and arg_18_0.posConfig.hit_reaction_layer ~= "" then
		local var_18_2 = arg_18_0.commonIK

		arg_18_0.hitReactionTF = var_18_4.Find(var_18_2, arg_18_0.posConfig.hit_reaction_layer)

		local var_18_3 = arg_18_0.hitReactionTF

		var_18_4 = var_18_4.GetComponent
		typeof = var_6
		BLHXHitReaction = var_1_10008
		arg_18_0.hitReactionComp = var_18_4(var_18_3, var_6(var_1_10008))
		setActive = var_18_4

		var_18_4(arg_18_0.hitReactionTF, true)
	end

	_ = var_18_4
	arg_18_0.animConfig = var_18_4.map(arg_18_0.posConfig.fury_anim, function(arg_19_0)
		pg = var_2_10001

		return var_2_10001.dorm3d_carwash_animation[arg_19_0]
	end)

	return
end

function var_0_1.OnCommonRaycast(arg_20_0, arg_20_1)
	if not arg_20_1.hit then
		var_1_10004 = arg_20_0

		arg_20_0.ResetHiddenReactionState(var_1_10004)

		return
	end

	local var_20_0 = arg_20_1.hitInfo.collider.gameObject.layer

	CarWashConst = var_1_10004

	if var_20_0 ~= var_1_10004.LADY_LAYER then
		arg_20_0:ResetHiddenReactionState()

		return
	end

	local var_20_1 = arg_20_0:GetCharacterHitConfig(var_2.collider.gameObject.name)
	local var_20_2 = arg_20_0
	local var_20_3 = arg_20_0.TryHandleHiddenReaction
	local var_20_4 = var_20_1
	local var_20_5

	if not arg_20_1.deltaTime then
		Time = var_20_5
		var_20_5 = var_20_5.deltaTime
	end

	if var_20_3(var_20_2, var_20_4, var_20_5) then
		return
	end

	local var_20_6 = arg_20_0
	local var_20_7 = arg_20_0.OnCharacterHit
	local var_20_8 = var_2
	local var_20_9

	if not arg_20_1.muzzleRay then
		var_20_9 = arg_20_1.ray
	end

	var_20_7(var_20_6, var_20_8, var_20_9, var_20_1)

	return
end

function var_0_1.GetCharacterHitConfig(arg_21_0, arg_21_1)
	if not arg_21_0.animConfig then
		return nil
	end

	_ = var_2

	return var_2.detect(arg_21_0.animConfig, function(arg_22_0)
		_ = var_2_10001

		local var_22_0

		if var_2_10001.any(arg_22_0.collider, function(arg_23_0)
			return arg_23_0 == arg_21_1
		end) then
			_ = var_22_0
			var_22_0 = var_22_0.any(arg_22_0.gun_type, function(arg_24_0)
				return arg_24_0 == arg_21_0.gunType
			end)
		end

		return var_22_0
	end)
end

function var_0_1.OnCharacterHit(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_1.collider.gameObject.name

	arg_25_3 = arg_25_3 or arg_25_0:GetCharacterHitConfig(var_25_0)

	if arg_25_3 and arg_25_0:CanTriggerReactionAnim() and arg_25_0:GetTriggerAnim(arg_25_3) ~= "" then
		arg_25_0:PlayReactionAnim(var_5, function()
			local var_26_0 = arg_25_0
			local var_26_1 = var_0.Emit

			CarWashGameFlowSystem = var_2_10003

			var_26_1(var_26_0, var_2_10003.MODIFY_HEART_BEAT_VALUE, arg_25_3.mood_value_plus)

			local var_26_2 = arg_25_0
			local var_26_3 = var_0.Emit

			CarWashMainPage = var_3

			local var_26_4 = var_3.SHOW_EXPRESSION_HUD

			CarWashMainPage = var_4

			var_26_3(var_26_2, var_26_4, var_4.EXPRESSION_TYPE.LIKE)

			return
		end)

		return
	end

	if arg_25_0.hitReactionComp then
		local var_25_1 = arg_25_0.hitReactionComp

		var_5.Hit(var_25_1, arg_25_1.collider, arg_25_2.direction * arg_25_0.hitForce, arg_25_1.point)
	end

	return
end

function var_0_1.IsMainCameraOnLeftSide(arg_27_0)
	local var_27_0 = arg_27_0.boneBip001.up
	local var_27_1 = arg_27_0.mainCameraTF.position - arg_27_0.boneBip001.position

	warning = var_3
	Vector3 = var_1_10005

	var_3(var_1_10005.Dot(var_27_1, var_27_0) > 0 and "Camera is on the left side" or "Camera is on the right side")

	Vector3 = var_3

	return var_3.Dot(var_27_1, var_27_0) > 0
end

function var_0_1.UpdatePhase2Tips(arg_28_0)
	local var_28_0 = arg_28_0.gameState

	CarWashConst = var_1_10002

	if var_28_0 ~= var_1_10002.GAME_STATE.PHASE_2 then
		return
	end

	if not arg_28_0.posConfig then
		return
	end

	arg_28_0:Emit(var_0_1.UPDATE_PHASE2_TIPS, arg_28_0:GetPhase2TipInfos())

	return
end

function var_0_1.GetPhase2TipInfos(arg_29_0)
	assert = var_1_10001

	local var_29_0

	if arg_29_0.posConfig.fury_anim then
		var_29_0 = #arg_29_0.posConfig.fury_anim > 0
	end

	local var_29_1 = "CarWash phase2 fury_anim config is empty: "

	tostring = var_1_10005

	var_1_10001(var_29_0, var_29_1 .. var_1_10005(arg_29_0.posConfig.id))

	local var_29_2 = {}

	ipairs = var_1_10002

	for iter_29_0, iter_29_1 in var_1_10002(arg_29_0.posConfig.fury_anim) do
		pg = var_29_3

		local var_29_3 = var_29_3.dorm3d_carwash_animation[iter_29_1]

		assert = var_1_10008

		local var_29_4 = var_29_3
		local var_29_5 = "CarWash phase2 animation config not found: "

		tostring = var_1_10012

		var_1_10008(var_29_4, var_29_5 .. var_1_10012(iter_29_1))

		assert = var_1_10008

		local var_29_6

		if var_29_3.collider then
			var_29_6 = var_29_3.collider[1]
		end

		local var_29_7 = "CarWash phase2 animation collider config is empty: "

		tostring = var_1_10012

		var_1_10008(var_29_6, var_29_7 .. var_1_10012(iter_29_1))

		var_1_10008 = var_29_3.collider[1]

		local var_29_8 = arg_29_0.colliderMap[var_1_10008]

		assert = var_29_6
		var_1_10012 = var_29_8

		local var_29_9 = "CarWash phase2 collider not found: "

		tostring = var_14

		var_29_6(var_1_10012, var_29_9 .. var_14(var_1_10008))

		var_1_10012 = arg_29_0.mainCamera

		local var_29_10 = var_10.WorldToScreenPoint(var_1_10012, var_29_8.bounds.center)

		table = var_11

		var_11.insert(var_29_2, {
			index = iter_29_0,
			animId = iter_29_1,
			colliderName = var_1_10008,
			screenPosition = var_29_10,
			visible = var_29_10.z > 0 and arg_29_0:CanTriggerReactionAnim()
		})
	end

	return var_29_2
end

function var_0_1.OnPlayPhase2Reaction(arg_30_0, arg_30_1)
	assert = var_1_10002

	var_1_10002(arg_30_1, "CarWash phase2 reaction data is nil")

	local var_30_0 = arg_30_1.animId

	pg = var_1_10003

	local var_30_1 = var_1_10003.dorm3d_carwash_animation[var_30_0]

	assert = var_4

	local var_30_2 = var_30_1
	local var_30_3 = "CarWash phase2 animation config not found: "

	tostring = var_1_10008

	var_4(var_30_2, var_30_3 .. var_1_10008(var_30_0))

	local var_30_4 = arg_30_0:GetTriggerAnim(var_30_1)

	assert = var_5

	local var_30_5 = var_30_4 ~= ""
	local var_30_6 = "CarWash phase2 reaction animation not found: "

	tostring = var_1_10009

	var_5(var_30_5, var_30_6 .. var_1_10009(var_30_0))

	warning = var_5

	var_5("Play phase2 reaction anim: " .. var_30_4)
	arg_30_0:PlayReactionAnim(var_30_4, function()
		existCall = var_2_10000

		var_2_10000(arg_30_1.callback, true)

		return
	end)

	return
end

function var_0_1.TryHandleHiddenReaction(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0

	if not arg_32_0.IsHiddenReactionConditionMet(var_32_0, arg_32_1) then
		var_32_0 = arg_32_0

		arg_32_0.ResetHiddenReactionState(var_32_0)

		return false
	end

	local var_32_1

	if not arg_32_1.id then
		var_32_1 = arg_32_1
	end

	if arg_32_0.hiddenReactionConfigId ~= var_32_1 then
		arg_32_0.hiddenReactionConfigId = var_32_1
		arg_32_0.hiddenReactionHitTime = 0
		arg_32_0.hiddenReactionTriggered = false

		local var_32_2 = arg_32_0
		local var_32_3 = arg_32_0.Emit

		CarWashMainPage = var_1_10007

		local var_32_4 = var_1_10007.SHOW_EXPRESSION_HUD

		CarWashMainPage = var_1_10008

		var_32_3(var_32_2, var_32_4, var_1_10008.EXPRESSION_TYPE.HATE)
	end

	if arg_32_0.hiddenReactionTriggered then
		return true
	end

	arg_32_0.hiddenReactionHitTime = arg_32_0.hiddenReactionHitTime + arg_32_2

	local var_32_5 = arg_32_0.hiddenReactionHitTime

	CarWashConst = var_32_0

	if var_32_5 >= var_32_0.HIDDEN_REACTION_TRIGGER_TIME then
		arg_32_0.hiddenReactionTriggered = true

		arg_32_0:TriggerHiddenReaction(arg_32_1)
	end

	return true
end

function var_0_1.IsHiddenReactionConditionMet(arg_33_0, arg_33_1)
	return arg_33_1 and arg_33_1.hidden_reaction ~= "" and arg_33_0:IsInState(arg_33_0.posConfig.idle_anim)
end

function var_0_1.TriggerHiddenReaction(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.Emit

	CarWashGameFlowSystem = var_1_10005

	var_34_1(var_34_0, var_1_10005.TRIGGER_HIDDEN_REACTION, arg_34_1)

	return
end

function var_0_1.ResetHiddenReactionState(arg_35_0)
	arg_35_0.hiddenReactionHitTime = 0
	arg_35_0.hiddenReactionConfigId = nil
	arg_35_0.hiddenReactionTriggered = false

	return
end

function var_0_1.CanTriggerReactionAnim(arg_36_0)
	return not arg_36_0.waitingReactionReturnIdle and arg_36_0:IsAnimatorStableInIdle()
end

function var_0_1.GetTriggerAnim(arg_37_0, arg_37_1)
	if arg_37_1.anim ~= "" then
		return arg_37_1.anim
	end

	if arg_37_1.anim_l ~= "" and arg_37_1.anim_r ~= "" then
		if arg_37_0:IsMainCameraOnLeftSide() then
			return arg_37_1.anim_l
		else
			return arg_37_1.anim_r
		end
	end

	return ""
end

function var_0_1.PlayReactionAnim(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0.reactionAnim = arg_38_1
	arg_38_0.reactionCallback = arg_38_2
	arg_38_0.waitingReactionReturnIdle = true
	arg_38_0.reactionLeftIdle = false

	arg_38_0:PlayAnim(arg_38_1)

	return
end

function var_0_1.UpdateReactionState(arg_39_0)
	if not arg_39_0.waitingReactionReturnIdle then
		return
	end

	if not arg_39_0.reactionLeftIdle then
		arg_39_0.reactionLeftIdle = not arg_39_0:IsAnimatorStableInIdle()

		return
	end

	if not arg_39_0:IsAnimatorStableInIdle() then
		return
	end

	local var_39_0 = arg_39_0.reactionCallback

	arg_39_0:ResetReactionState()

	existCall = var_2

	var_2(var_39_0)

	return
end

function var_0_1.IsAnimatorStableInIdle(arg_40_0)
	if not arg_40_0.posConfig then
		return false
	end

	local var_40_0 = arg_40_0.ladyAnimator

	if var_1.IsInTransition(var_40_0, arg_40_0.ladyAnimBaseLayerIndex) then
		return false
	end

	return arg_40_0:IsInState(arg_40_0.posConfig.idle_anim)
end

function var_0_1.ResetReactionState(arg_41_0)
	arg_41_0.reactionAnim = nil
	arg_41_0.reactionCallback = nil
	arg_41_0.waitingReactionReturnIdle = false
	arg_41_0.reactionLeftIdle = false

	return
end

function var_0_1.IsInState(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.ladyAnimator
	local var_42_1 = var_2.GetCurrentAnimatorStateInfo(var_42_0, arg_42_0.ladyAnimBaseLayerIndex)

	return var_2.IsName(var_42_1, arg_42_1)
end

function var_0_1.PlayAnim(arg_43_0, arg_43_1, arg_43_2)
	arg_43_2 = arg_43_2 or 0.5
	string = var_1_10003

	local var_43_0 = var_1_10003.find(arg_43_1, "^Face_")

	tobool = var_1_10004

	local var_43_2

	if not var_1_10004(var_43_0) then
		string = var_5

		local var_43_1 = var_5.find(arg_43_1, "^face_")

		tobool = var_5
		var_43_2 = var_5(var_43_1)
	end

	if var_43_2 then
		arg_43_0:PlayFaceAnim(arg_43_1)

		return
	end

	if arg_43_0:IsInState(arg_43_1) then
		return
	end

	IsUnityEditor = var_5

	if var_5 then
		local var_43_3 = arg_43_0.ladyAnimator
		local var_43_4 = var_5.HasState
		local var_43_5 = arg_43_0.ladyAnimBaseLayerIndex

		Animator = var_1_10009

		if not var_43_4(var_43_3, var_43_5, var_1_10009.StringToHash(arg_43_1)) then
			errorMsg = var_5

			var_5("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_43_1)
		end
	end

	local var_43_6 = arg_43_0.ladyAnimator

	var_5.CrossFadeInFixedTime(var_43_6, arg_43_1, arg_43_2, arg_43_0.ladyAnimBaseLayerIndex)

	return
end

function var_0_1.PlayFaceAnim(arg_44_0, arg_44_1)
	IsUnityEditor = var_1_10002

	if var_1_10002 then
		local var_44_0 = arg_44_0.ladyAnimator
		local var_44_1 = var_2.HasState
		local var_44_2 = arg_44_0.ladyAnimFaceLayerIndex

		Animator = var_1_10006

		if not var_44_1(var_44_0, var_44_2, var_1_10006.StringToHash(arg_44_1)) then
			errorMsg = var_2

			var_2("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_44_1)
		end
	end

	local var_44_3 = arg_44_0.ladyAnimator

	var_2.CrossFadeInFixedTime(var_44_3, arg_44_1, 0, arg_44_0.ladyAnimFaceLayerIndex)

	return
end

return var_0_1
