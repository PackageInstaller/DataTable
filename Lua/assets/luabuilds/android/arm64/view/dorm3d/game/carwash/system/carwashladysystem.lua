local var_0_0 = class("CarWashLadySystem", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_0.UPDATE_PHASE2_TIPS = "CarWashLadySystem.UPDATE_PHASE2_TIPS"
var_0_0.UPDATE_EXPRESSION_HUD_POSITION = "CarWashLadySystem.UPDATE_EXPRESSION_HUD_POSITION"
var_0_0.PLAY_PHASE2_REACTION = "CarWashLadySystem.PLAY_PHASE2_REACTION"

function var_0_0.OnInit(arg_1_0)
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

function var_0_0.RegisterEvents(arg_2_0)
	arg_2_0:Bind(CarWashGameFlowSystem.UPDATE_LADY_POS, function(arg_3_0, arg_3_1)
		arg_2_0:OnLadyPosChanged(arg_3_1.newValue)

		return
	end)
	arg_2_0:Bind(CarWashGameFlowSystem.UPDATE_CURRENT_GUN_TYPE, function(arg_4_0, arg_4_1)
		arg_2_0.gunType = arg_4_1.newValue
		arg_2_0.hitForce = CarWashConst.GetGunConfig(arg_4_1.newValue).force

		arg_2_0:ResetHiddenReactionState()

		return
	end)
	arg_2_0:Bind(CarWashGameFlowSystem.UPDATE_IS_SHOOTING, function(arg_5_0, arg_5_1)
		if not arg_5_1.newValue then
			arg_2_0:ResetHiddenReactionState()
		end

		return
	end)
	arg_2_0:Bind(CarWashRaycastSystem.UPDATE_COMMON_RAYCAST, function(arg_6_0, arg_6_1)
		arg_2_0:OnCommonRaycast(arg_6_1)

		return
	end)
	arg_2_0:Bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_7_0, arg_7_1)
		arg_2_0.gameState = arg_7_1.newValue

		return
	end)
	arg_2_0:Bind(var_0_0.PLAY_PHASE2_REACTION, function(arg_8_0, arg_8_1)
		arg_2_0:OnPlayPhase2Reaction(arg_8_1)

		return
	end)
	arg_2_0:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, function()
		pg.ViewUtils.SetLayer(arg_2_0.ladyTransform, Layer.UIHidden)

		return
	end)
	arg_2_0:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, function()
		pg.ViewUtils.SetLayer(arg_2_0.ladyTransform, Layer.Character3D)
		pg.ViewUtils.SetLayer(arg_2_0.physicsCollider, Layer.CameraRT)

		return
	end)

	return
end

function var_0_0.OnDispose(arg_11_0)
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

function var_0_0.OnUpdate(arg_12_0, arg_12_1)
	arg_12_0:UpdateReactionState()
	arg_12_0:UpdateExpressionHUDPosition()
	arg_12_0:UpdatePhase2Tips()

	return
end

function var_0_0.InitSceneRefs(arg_13_0)
	arg_13_0.ladyPositionRoot = GameObject.Find("[LADYPOSITION]").transform
	arg_13_0.ladyGO = arg_13_0:GetLadyGO()
	arg_13_0.mainCamera = arg_13_0:GetMainCamera()
	arg_13_0.mainCameraTF = arg_13_0:GetMainCameraTF()

	return
end

function var_0_0.InitLady(arg_14_0)
	arg_14_0.ladyTransform = arg_14_0.ladyGO.transform
	arg_14_0.ladyAnimator = arg_14_0.ladyGO:GetComponent(typeof(Animator))
	arg_14_0.ladyAnimBaseLayerIndex = arg_14_0.ladyAnimator:GetLayerIndex("Base Layer")
	arg_14_0.ladyAnimFaceLayerIndex = arg_14_0.ladyAnimator:GetLayerIndex("Face")
	arg_14_0.physicsCollider = arg_14_0.ladyTransform:Find("physicsCollider")

	pg.ViewUtils.SetLayer(arg_14_0.ladyTransform, Layer.Character3D)
	pg.ViewUtils.SetLayer(arg_14_0.physicsCollider, Layer.CameraRT)

	arg_14_0.ladyOwner = GetComponent(arg_14_0.ladyTransform, "GraphOwner")
	arg_14_0.ladyOwner.enabled = false
	arg_14_0.hitReactionLayers = arg_14_0.ladyTransform:Find("CarWashHitReactionLayers")
	arg_14_0.commonIK = arg_14_0.hitReactionLayers:Find("CommonIK")

	setActive(arg_14_0.commonIK, true)
	eachChild(arg_14_0.commonIK, function(arg_15_0)
		setActive(arg_15_0, false)

		return
	end)

	arg_14_0.boneBip001 = arg_14_0.ladyTransform:Find("all/Bip001")
	arg_14_0.boneHUD = arg_14_0.ladyTransform:Find("all/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2/Bip001 Spine3/Bip001 Neck/Bip001 Head/ExpressionHUD")

	assert(arg_14_0.boneHUD, "CarWash ExpressionHUD bone not found")
	arg_14_0:InitColliderMap()

	return
end

function var_0_0.InitColliderMap(arg_16_0)
	arg_16_0.colliderMap = {}

	for iter_16_0, iter_16_1 in ipairs((arg_16_0.ladyGO:GetComponentsInChildren(typeof(UnityEngine.Collider), true):ToTable())) do
		arg_16_0.colliderMap[iter_16_1.gameObject.name] = iter_16_1
	end

	return
end

function var_0_0.UpdateExpressionHUDPosition(arg_17_0)
	local var_17_0 = arg_17_0.mainCamera:WorldToScreenPoint(arg_17_0.boneHUD.position)

	arg_17_0:Emit(var_0_0.UPDATE_EXPRESSION_HUD_POSITION, {
		screenPosition = var_17_0,
		visible = var_17_0.z > 0
	})

	return
end

function var_0_0.OnLadyPosChanged(arg_18_0, arg_18_1)
	arg_18_0:ResetHiddenReactionState()
	arg_18_0:ResetReactionState()

	arg_18_0.posConfig = arg_18_1

	local var_18_0 = arg_18_0.ladyPositionRoot:Find(arg_18_0.posConfig.pos)

	assert(var_18_0, "CarWash lady position node not found: " .. arg_18_0.posConfig.pos)
	setParent(arg_18_0.ladyTransform, var_18_0)
	arg_18_0:PlayAnim(arg_18_0.posConfig.idle_anim, 0)

	if arg_18_0.hitReactionTF and arg_18_0.hitReactionComp then
		setActive(arg_18_0.hitReactionTF, false)

		arg_18_0.hitReactionComp = nil
	end

	if arg_18_0.posConfig.hit_reaction_layer and arg_18_0.posConfig.hit_reaction_layer ~= "" then
		arg_18_0.hitReactionTF = arg_18_0.commonIK:Find(arg_18_0.posConfig.hit_reaction_layer)
		arg_18_0.hitReactionComp = arg_18_0.hitReactionTF:GetComponent(typeof(BLHXHitReaction))

		setActive(arg_18_0.hitReactionTF, true)
	end

	arg_18_0.animConfig = _.map(arg_18_0.posConfig.fury_anim, function(arg_19_0)
		return pg.dorm3d_carwash_animation[arg_19_0]
	end)

	return
end

function var_0_0.OnCommonRaycast(arg_20_0, arg_20_1)
	if not arg_20_1.hit then
		arg_20_0:ResetHiddenReactionState()

		return
	end

	local var_20_0 = arg_20_1.hitInfo

	if arg_20_1.hitInfo.collider.gameObject.layer ~= CarWashConst.LADY_LAYER then
		arg_20_0:ResetHiddenReactionState()

		return
	end

	local var_20_1 = arg_20_0:GetCharacterHitConfig(var_20_0.collider.gameObject.name)
	local var_20_2 = arg_20_1.deltaTime or Time.deltaTime

	if arg_20_0:TryHandleHiddenReaction(var_20_1, var_20_2) then
		do return end

		local var_20_3 = arg_20_1.muzzleRay or arg_20_1.ray

		arg_20_0:OnCharacterHit(var_20_0, var_20_3, var_20_1)

		return
	end
end

function var_0_0.GetCharacterHitConfig(arg_21_0, arg_21_1)
	if not arg_21_0.animConfig then
		return nil
	end

	return _.detect(arg_21_0.animConfig, function(arg_22_0)
		return _.any(arg_22_0.collider, function(arg_23_0)
			return arg_23_0 == arg_21_1
		end) and _.any(arg_22_0.gun_type, function(arg_24_0)
			return arg_24_0 == arg_21_0.gunType
		end)
	end)
end

function var_0_0.OnCharacterHit(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_3 = arg_25_3 or arg_25_0:GetCharacterHitConfig(arg_25_1.collider.gameObject.name)

	if arg_25_3 and arg_25_0:CanTriggerReactionAnim() then
		local var_25_0 = arg_25_0:GetTriggerAnim(arg_25_3)

		if var_25_0 ~= "" then
			arg_25_0:PlayReactionAnim(var_25_0, function()
				arg_25_0:Emit(CarWashGameFlowSystem.MODIFY_HEART_BEAT_VALUE, arg_25_3.mood_value_plus)
				arg_25_0:Emit(CarWashMainPage.SHOW_EXPRESSION_HUD, CarWashMainPage.EXPRESSION_TYPE.LIKE)

				return
			end)

			return
		end
	end

	if arg_25_0.hitReactionComp then
		arg_25_0.hitReactionComp:Hit(arg_25_1.collider, arg_25_2.direction * arg_25_0.hitForce, arg_25_1.point)
	end

	return
end

function var_0_0.IsMainCameraOnLeftSide(arg_27_0)
	local var_27_0 = arg_27_0.boneBip001.up
	local var_27_1 = arg_27_0.mainCameraTF.position - arg_27_0.boneBip001.position

	warning(Vector3.Dot(arg_27_0.mainCameraTF.position - arg_27_0.boneBip001.position, arg_27_0.boneBip001.up) > 0 and "Camera is on the left side" or "Camera is on the right side")

	return Vector3.Dot(var_27_1, var_27_0) > 0
end

function var_0_0.UpdatePhase2Tips(arg_28_0)
	if arg_28_0.gameState ~= CarWashConst.GAME_STATE.PHASE_2 then
		return
	end

	if not arg_28_0.posConfig then
		return
	end

	arg_28_0:Emit(var_0_0.UPDATE_PHASE2_TIPS, arg_28_0:GetPhase2TipInfos())

	return
end

function var_0_0.GetPhase2TipInfos(arg_29_0)
	local var_29_0 = arg_29_0.posConfig.fury_anim and #arg_29_0.posConfig.fury_anim > 0

	assert(var_29_0, "CarWash phase2 fury_anim config is empty: " .. tostring(arg_29_0.posConfig.id))

	local var_29_1 = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.posConfig.fury_anim) do
		assert(pg.dorm3d_carwash_animation[iter_29_1], "CarWash phase2 animation config not found: " .. tostring(iter_29_1))

		local var_29_2 = pg.dorm3d_carwash_animation[iter_29_1].collider and pg.dorm3d_carwash_animation[iter_29_1].collider[1]

		assert(var_29_2, "CarWash phase2 animation collider config is empty: " .. tostring(iter_29_1))

		local var_29_3 = pg.dorm3d_carwash_animation[iter_29_1].collider[1]

		assert(arg_29_0.colliderMap[pg.dorm3d_carwash_animation[iter_29_1].collider[1]], "CarWash phase2 collider not found: " .. tostring(pg.dorm3d_carwash_animation[iter_29_1].collider[1]))

		local var_29_4 = arg_29_0.mainCamera:WorldToScreenPoint(arg_29_0.colliderMap[pg.dorm3d_carwash_animation[iter_29_1].collider[1]].bounds.center)

		table.insert(var_29_1, {
			index = iter_29_0,
			animId = iter_29_1,
			colliderName = var_29_3,
			screenPosition = var_29_4,
			visible = var_29_4.z > 0 and arg_29_0:CanTriggerReactionAnim()
		})
	end

	return var_29_1
end

function var_0_0.OnPlayPhase2Reaction(arg_30_0, arg_30_1)
	assert(arg_30_1, "CarWash phase2 reaction data is nil")

	local var_30_0 = arg_30_1.animId

	assert(pg.dorm3d_carwash_animation[arg_30_1.animId], "CarWash phase2 animation config not found: " .. tostring(arg_30_1.animId))

	local var_30_1 = arg_30_0:GetTriggerAnim(pg.dorm3d_carwash_animation[arg_30_1.animId])

	assert(var_30_1 ~= "", "CarWash phase2 reaction animation not found: " .. tostring(var_30_0))
	warning("Play phase2 reaction anim: " .. var_30_1)
	arg_30_0:PlayReactionAnim(var_30_1, function()
		existCall(arg_30_1.callback, true)

		return
	end)

	return
end

function var_0_0.TryHandleHiddenReaction(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_0:IsHiddenReactionConditionMet(arg_32_1) then
		arg_32_0:ResetHiddenReactionState()

		return false
	end

	local var_32_0 = arg_32_1.id or arg_32_1

	if arg_32_0.hiddenReactionConfigId ~= var_32_0 then
		arg_32_0.hiddenReactionConfigId = var_32_0
		arg_32_0.hiddenReactionHitTime = 0
		arg_32_0.hiddenReactionTriggered = false

		arg_32_0:Emit(CarWashMainPage.SHOW_EXPRESSION_HUD, CarWashMainPage.EXPRESSION_TYPE.HATE)
	end

	if arg_32_0.hiddenReactionTriggered then
		return true
	end

	arg_32_0.hiddenReactionHitTime = arg_32_0.hiddenReactionHitTime + arg_32_2

	if arg_32_0.hiddenReactionHitTime >= CarWashConst.HIDDEN_REACTION_TRIGGER_TIME then
		arg_32_0.hiddenReactionTriggered = true

		arg_32_0:TriggerHiddenReaction(arg_32_1)
	end

	return true
end

function var_0_0.IsHiddenReactionConditionMet(arg_33_0, arg_33_1)
	return arg_33_1 and arg_33_1.hidden_reaction ~= "" and arg_33_0:IsInState(arg_33_0.posConfig.idle_anim)
end

function var_0_0.TriggerHiddenReaction(arg_34_0, arg_34_1)
	arg_34_0:Emit(CarWashGameFlowSystem.TRIGGER_HIDDEN_REACTION, arg_34_1)

	return
end

function var_0_0.ResetHiddenReactionState(arg_35_0)
	arg_35_0.hiddenReactionHitTime = 0
	arg_35_0.hiddenReactionConfigId = nil
	arg_35_0.hiddenReactionTriggered = false

	return
end

function var_0_0.CanTriggerReactionAnim(arg_36_0)
	return not arg_36_0.waitingReactionReturnIdle and arg_36_0:IsAnimatorStableInIdle()
end

function var_0_0.GetTriggerAnim(arg_37_0, arg_37_1)
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

function var_0_0.PlayReactionAnim(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0.reactionAnim = arg_38_1
	arg_38_0.reactionCallback = arg_38_2
	arg_38_0.waitingReactionReturnIdle = true
	arg_38_0.reactionLeftIdle = false

	arg_38_0:PlayAnim(arg_38_1)

	return
end

function var_0_0.UpdateReactionState(arg_39_0)
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
	existCall(var_39_0)

	return
end

function var_0_0.IsAnimatorStableInIdle(arg_40_0)
	if not arg_40_0.posConfig then
		return false
	end

	if arg_40_0.ladyAnimator:IsInTransition(arg_40_0.ladyAnimBaseLayerIndex) then
		return false
	end

	return arg_40_0:IsInState(arg_40_0.posConfig.idle_anim)
end

function var_0_0.ResetReactionState(arg_41_0)
	arg_41_0.reactionAnim = nil
	arg_41_0.reactionCallback = nil
	arg_41_0.waitingReactionReturnIdle = false
	arg_41_0.reactionLeftIdle = false

	return
end

function var_0_0.IsInState(arg_42_0, arg_42_1)
	return arg_42_0.ladyAnimator:GetCurrentAnimatorStateInfo(arg_42_0.ladyAnimBaseLayerIndex):IsName(arg_42_1)
end

function var_0_0.PlayAnim(arg_43_0, arg_43_1, arg_43_2)
	arg_43_2 = arg_43_2 or 0.5

	local var_43_0 = tobool((string.find(arg_43_1, "^Face_")))

	var_43_0 = var_43_0 or tobool((string.find(arg_43_1, "^face_")))

	if var_43_0 then
		arg_43_0:PlayFaceAnim(arg_43_1)

		return
	end

	if arg_43_0:IsInState(arg_43_1) then
		return
	end

	if IsUnityEditor and not arg_43_0.ladyAnimator:HasState(arg_43_0.ladyAnimBaseLayerIndex, Animator.StringToHash(arg_43_1)) then
		errorMsg("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_43_1)
	end

	arg_43_0.ladyAnimator:CrossFadeInFixedTime(arg_43_1, arg_43_2, arg_43_0.ladyAnimBaseLayerIndex)

	return
end

function var_0_0.PlayFaceAnim(arg_44_0, arg_44_1)
	if IsUnityEditor and not arg_44_0.ladyAnimator:HasState(arg_44_0.ladyAnimFaceLayerIndex, Animator.StringToHash(arg_44_1)) then
		errorMsg("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_44_1)
	end

	arg_44_0.ladyAnimator:CrossFadeInFixedTime(arg_44_1, 0, arg_44_0.ladyAnimFaceLayerIndex)

	return
end

return var_0_0
