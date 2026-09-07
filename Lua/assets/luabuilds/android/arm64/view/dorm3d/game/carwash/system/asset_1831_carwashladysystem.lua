local CarWashLadySystem = class("CarWashLadySystem", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

CarWashLadySystem.UPDATE_PHASE2_TIPS = "CarWashLadySystem.UPDATE_PHASE2_TIPS"
CarWashLadySystem.UPDATE_EXPRESSION_HUD_POSITION = "CarWashLadySystem.UPDATE_EXPRESSION_HUD_POSITION"
CarWashLadySystem.PLAY_PHASE2_REACTION = "CarWashLadySystem.PLAY_PHASE2_REACTION"

function CarWashLadySystem:OnInit()
	self:InitSceneRefs()
	self:InitLady()

	self.hitForce = 0
	self.gunType = nil
	self.hiddenReactionHitTime = 0
	self.hiddenReactionConfigId = nil
	self.hiddenReactionTriggered = false
	self.reactionAnim = nil
	self.reactionCallback = nil
	self.waitingReactionReturnIdle = false
	self.reactionLeftIdle = false
	self.gameState = nil

	return
end

function CarWashLadySystem:RegisterEvents()
	self:Bind(CarWashGameFlowSystem.UPDATE_LADY_POS, function(arg_3_0, arg_3_1)
		self:OnLadyPosChanged(arg_3_1.newValue)

		return
	end)
	self:Bind(CarWashGameFlowSystem.UPDATE_CURRENT_GUN_TYPE, function(arg_4_0, arg_4_1)
		self.gunType = arg_4_1.newValue
		self.hitForce = CarWashConst.GetGunConfig(arg_4_1.newValue).force

		self:ResetHiddenReactionState()

		return
	end)
	self:Bind(CarWashGameFlowSystem.UPDATE_IS_SHOOTING, function(arg_5_0, arg_5_1)
		if not arg_5_1.newValue then
			self:ResetHiddenReactionState()
		end

		return
	end)
	self:Bind(CarWashRaycastSystem.UPDATE_COMMON_RAYCAST, function(arg_6_0, arg_6_1)
		self:OnCommonRaycast(arg_6_1)

		return
	end)
	self:Bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_7_0, arg_7_1)
		self.gameState = arg_7_1.newValue

		return
	end)
	self:Bind(CarWashLadySystem.PLAY_PHASE2_REACTION, function(arg_8_0, arg_8_1)
		self:OnPlayPhase2Reaction(arg_8_1)

		return
	end)
	self:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, function()
		pg.ViewUtils.SetLayer(self.ladyTransform, Layer.UIHidden)

		return
	end)
	self:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, function()
		pg.ViewUtils.SetLayer(self.ladyTransform, Layer.Character3D)
		pg.ViewUtils.SetLayer(self.physicsCollider, Layer.CameraRT)

		return
	end)

	return
end

function CarWashLadySystem:OnDispose()
	self.hiddenReactionHitTime = nil
	self.hiddenReactionConfigId = nil
	self.hiddenReactionTriggered = nil
	self.reactionAnim = nil
	self.reactionCallback = nil
	self.waitingReactionReturnIdle = nil
	self.reactionLeftIdle = nil
	self.gameState = nil
	self.colliderMap = nil

	return
end

function CarWashLadySystem:OnUpdate(arg_12_1)
	self:UpdateReactionState()
	self:UpdateExpressionHUDPosition()
	self:UpdatePhase2Tips()

	return
end

function CarWashLadySystem:InitSceneRefs()
	self.ladyPositionRoot = GameObject.Find("[LADYPOSITION]").transform
	self.ladyGO = self:GetLadyGO()
	self.mainCamera = self:GetMainCamera()
	self.mainCameraTF = self:GetMainCameraTF()

	return
end

function CarWashLadySystem:InitLady()
	self.ladyTransform = self.ladyGO.transform
	self.ladyAnimator = self.ladyGO:GetComponent(typeof(Animator))
	self.ladyAnimBaseLayerIndex = self.ladyAnimator:GetLayerIndex("Base Layer")
	self.ladyAnimFaceLayerIndex = self.ladyAnimator:GetLayerIndex("Face")
	self.physicsCollider = self.ladyTransform:Find("physicsCollider")

	pg.ViewUtils.SetLayer(self.ladyTransform, Layer.Character3D)
	pg.ViewUtils.SetLayer(self.physicsCollider, Layer.CameraRT)

	self.ladyOwner = GetComponent(self.ladyTransform, "GraphOwner")
	self.ladyOwner.enabled = false
	self.hitReactionLayers = self.ladyTransform:Find("CarWashHitReactionLayers")
	self.commonIK = self.hitReactionLayers:Find("CommonIK")

	setActive(self.commonIK, true)
	eachChild(self.commonIK, function(arg_15_0)
		setActive(arg_15_0, false)

		return
	end)

	self.boneBip001 = self.ladyTransform:Find("all/Bip001")
	self.boneHUD = self.ladyTransform:Find("all/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2/Bip001 Spine3/Bip001 Neck/Bip001 Head/ExpressionHUD")

	assert(self.boneHUD, "CarWash ExpressionHUD bone not found")
	self:InitColliderMap()

	return
end

function CarWashLadySystem:InitColliderMap()
	self.colliderMap = {}

	for iter_16_0, iter_16_1 in ipairs((self.ladyGO:GetComponentsInChildren(typeof(UnityEngine.Collider), true):ToTable())) do
		self.colliderMap[iter_16_1.gameObject.name] = iter_16_1
	end

	return
end

function CarWashLadySystem:UpdateExpressionHUDPosition()
	local var_17_0 = self.mainCamera:WorldToScreenPoint(self.boneHUD.position)

	self:Emit(CarWashLadySystem.UPDATE_EXPRESSION_HUD_POSITION, {
		screenPosition = var_17_0,
		visible = var_17_0.z > 0
	})

	return
end

function CarWashLadySystem:OnLadyPosChanged(arg_18_1)
	self:ResetHiddenReactionState()
	self:ResetReactionState()

	self.posConfig = arg_18_1

	local var_18_0 = self.ladyPositionRoot:Find(self.posConfig.pos)

	assert(var_18_0, "CarWash lady position node not found: " .. self.posConfig.pos)
	setParent(self.ladyTransform, var_18_0)
	self:PlayAnim(self.posConfig.idle_anim, 0)

	if self.hitReactionTF and self.hitReactionComp then
		setActive(self.hitReactionTF, false)

		self.hitReactionComp = nil
	end

	if self.posConfig.hit_reaction_layer and self.posConfig.hit_reaction_layer ~= "" then
		self.hitReactionTF = self.commonIK:Find(self.posConfig.hit_reaction_layer)
		self.hitReactionComp = self.hitReactionTF:GetComponent(typeof(BLHXHitReaction))

		setActive(self.hitReactionTF, true)
	end

	self.animConfig = _.map(self.posConfig.fury_anim, function(arg_19_0)
		return pg.dorm3d_carwash_animation[arg_19_0]
	end)

	return
end

function CarWashLadySystem:OnCommonRaycast(arg_20_1)
	if not arg_20_1.hit then
		self:ResetHiddenReactionState()

		return
	end

	local var_20_0 = arg_20_1.hitInfo

	if arg_20_1.hitInfo.collider.gameObject.layer ~= CarWashConst.LADY_LAYER then
		self:ResetHiddenReactionState()

		return
	end

	local var_20_1 = self:GetCharacterHitConfig(var_20_0.collider.gameObject.name)

	if self:TryHandleHiddenReaction(var_20_1, arg_20_1.deltaTime or Time.deltaTime) then
		return
	end

	self:OnCharacterHit(var_20_0, arg_20_1.muzzleRay or arg_20_1.ray, var_20_1)

	return
end

function CarWashLadySystem:GetCharacterHitConfig(arg_21_1)
	if not self.animConfig then
		return nil
	end

	return _.detect(self.animConfig, function(arg_22_0)
		return _.any(arg_22_0.collider, function(arg_23_0)
			return arg_23_0 == arg_21_1
		end) and _.any(arg_22_0.gun_type, function(arg_24_0)
			return arg_24_0 == self.gunType
		end)
	end)
end

function CarWashLadySystem:OnCharacterHit(arg_25_1, arg_25_2, arg_25_3)
	arg_25_3 = arg_25_3 or self:GetCharacterHitConfig(arg_25_1.collider.gameObject.name)

	if arg_25_3 and self:CanTriggerReactionAnim() then
		local var_25_0 = self:GetTriggerAnim(arg_25_3)

		if var_25_0 ~= "" then
			self:PlayReactionAnim(var_25_0, function()
				self:Emit(CarWashGameFlowSystem.MODIFY_HEART_BEAT_VALUE, arg_25_3.mood_value_plus)
				self:Emit(CarWashMainPage.SHOW_EXPRESSION_HUD, CarWashMainPage.EXPRESSION_TYPE.LIKE)

				return
			end)

			return
		end
	end

	if self.hitReactionComp then
		self.hitReactionComp:Hit(arg_25_1.collider, arg_25_2.direction * self.hitForce, arg_25_1.point)
	end

	return
end

function CarWashLadySystem:IsMainCameraOnLeftSide()
	local var_27_0 = self.boneBip001.up
	local var_27_1 = self.mainCameraTF.position - self.boneBip001.position

	warning(Vector3.Dot(self.mainCameraTF.position - self.boneBip001.position, self.boneBip001.up) > 0 and "Camera is on the left side" or "Camera is on the right side")

	return Vector3.Dot(var_27_1, var_27_0) > 0
end

function CarWashLadySystem:UpdatePhase2Tips()
	if self.gameState ~= CarWashConst.GAME_STATE.PHASE_2 then
		return
	end

	if not self.posConfig then
		return
	end

	self:Emit(CarWashLadySystem.UPDATE_PHASE2_TIPS, self:GetPhase2TipInfos())

	return
end

function CarWashLadySystem:GetPhase2TipInfos()
	assert(self.posConfig.fury_anim and #self.posConfig.fury_anim > 0, "CarWash phase2 fury_anim config is empty: " .. tostring(self.posConfig.id))

	local var_29_1 = {}

	for iter_29_0, iter_29_1 in ipairs(self.posConfig.fury_anim) do
		assert(pg.dorm3d_carwash_animation[iter_29_1], "CarWash phase2 animation config not found: " .. tostring(iter_29_1))
		assert(pg.dorm3d_carwash_animation[iter_29_1].collider and pg.dorm3d_carwash_animation[iter_29_1].collider[1], "CarWash phase2 animation collider config is empty: " .. tostring(iter_29_1))

		local var_29_2 = pg.dorm3d_carwash_animation[iter_29_1].collider[1]

		assert(self.colliderMap[pg.dorm3d_carwash_animation[iter_29_1].collider[1]], "CarWash phase2 collider not found: " .. tostring(pg.dorm3d_carwash_animation[iter_29_1].collider[1]))

		local var_29_3 = self.mainCamera:WorldToScreenPoint(self.colliderMap[pg.dorm3d_carwash_animation[iter_29_1].collider[1]].bounds.center)

		table.insert(var_29_1, {
			index = iter_29_0,
			animId = iter_29_1,
			colliderName = var_29_2,
			screenPosition = var_29_3,
			visible = var_29_3.z > 0 and self:CanTriggerReactionAnim()
		})
	end

	return var_29_1
end

function CarWashLadySystem:OnPlayPhase2Reaction(arg_30_1)
	assert(arg_30_1, "CarWash phase2 reaction data is nil")

	local var_30_0 = arg_30_1.animId

	assert(pg.dorm3d_carwash_animation[arg_30_1.animId], "CarWash phase2 animation config not found: " .. tostring(arg_30_1.animId))

	local var_30_1 = self:GetTriggerAnim(pg.dorm3d_carwash_animation[arg_30_1.animId])

	assert(var_30_1 ~= "", "CarWash phase2 reaction animation not found: " .. tostring(var_30_0))
	warning("Play phase2 reaction anim: " .. var_30_1)
	self:PlayReactionAnim(var_30_1, function()
		existCall(arg_30_1.callback, true)

		return
	end)

	return
end

function CarWashLadySystem:TryHandleHiddenReaction(arg_32_1, arg_32_2)
	if not self:IsHiddenReactionConditionMet(arg_32_1) then
		self:ResetHiddenReactionState()

		return false
	end

	local var_32_0 = arg_32_1.id or arg_32_1

	if self.hiddenReactionConfigId ~= var_32_0 then
		self.hiddenReactionConfigId = var_32_0
		self.hiddenReactionHitTime = 0
		self.hiddenReactionTriggered = false

		self:Emit(CarWashMainPage.SHOW_EXPRESSION_HUD, CarWashMainPage.EXPRESSION_TYPE.HATE)
	end

	if self.hiddenReactionTriggered then
		return true
	end

	self.hiddenReactionHitTime = self.hiddenReactionHitTime + arg_32_2

	if self.hiddenReactionHitTime >= CarWashConst.HIDDEN_REACTION_TRIGGER_TIME then
		self.hiddenReactionTriggered = true

		self:TriggerHiddenReaction(arg_32_1)
	end

	return true
end

function CarWashLadySystem:IsHiddenReactionConditionMet(arg_33_1)
	return arg_33_1 and arg_33_1.hidden_reaction ~= "" and self:IsInState(self.posConfig.idle_anim)
end

function CarWashLadySystem:TriggerHiddenReaction(arg_34_1)
	self:Emit(CarWashGameFlowSystem.TRIGGER_HIDDEN_REACTION, arg_34_1)

	return
end

function CarWashLadySystem:ResetHiddenReactionState()
	self.hiddenReactionHitTime = 0
	self.hiddenReactionConfigId = nil
	self.hiddenReactionTriggered = false

	return
end

function CarWashLadySystem:CanTriggerReactionAnim()
	return not self.waitingReactionReturnIdle and self:IsAnimatorStableInIdle()
end

function CarWashLadySystem:GetTriggerAnim(arg_37_1)
	if arg_37_1.anim ~= "" then
		return arg_37_1.anim
	end

	if arg_37_1.anim_l ~= "" and arg_37_1.anim_r ~= "" then
		if self:IsMainCameraOnLeftSide() then
			return arg_37_1.anim_l
		else
			return arg_37_1.anim_r
		end
	end

	return ""
end

function CarWashLadySystem:PlayReactionAnim(arg_38_1, arg_38_2)
	self.reactionAnim = arg_38_1
	self.reactionCallback = arg_38_2
	self.waitingReactionReturnIdle = true
	self.reactionLeftIdle = false

	self:PlayAnim(arg_38_1)

	return
end

function CarWashLadySystem:UpdateReactionState()
	if not self.waitingReactionReturnIdle then
		return
	end

	if not self.reactionLeftIdle then
		self.reactionLeftIdle = not self:IsAnimatorStableInIdle()

		return
	end

	if not self:IsAnimatorStableInIdle() then
		return
	end

	local var_39_0 = self.reactionCallback

	self:ResetReactionState()
	existCall(var_39_0)

	return
end

function CarWashLadySystem:IsAnimatorStableInIdle()
	if not self.posConfig then
		return false
	end

	if self.ladyAnimator:IsInTransition(self.ladyAnimBaseLayerIndex) then
		return false
	end

	return self:IsInState(self.posConfig.idle_anim)
end

function CarWashLadySystem:ResetReactionState()
	self.reactionAnim = nil
	self.reactionCallback = nil
	self.waitingReactionReturnIdle = false
	self.reactionLeftIdle = false

	return
end

function CarWashLadySystem:IsInState(arg_42_1)
	return self.ladyAnimator:GetCurrentAnimatorStateInfo(self.ladyAnimBaseLayerIndex):IsName(arg_42_1)
end

function CarWashLadySystem:PlayAnim(arg_43_1, arg_43_2)
	arg_43_2 = arg_43_2 or 0.5

	local var_43_0 = tobool((string.find(arg_43_1, "^Face_")))

	var_43_0 = var_43_0 or tobool((string.find(arg_43_1, "^face_")))

	if var_43_0 then
		self:PlayFaceAnim(arg_43_1)

		return
	end

	if self:IsInState(arg_43_1) then
		return
	end

	if IsUnityEditor and not self.ladyAnimator:HasState(self.ladyAnimBaseLayerIndex, Animator.StringToHash(arg_43_1)) then
		errorMsg("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_43_1)
	end

	self.ladyAnimator:CrossFadeInFixedTime(arg_43_1, arg_43_2, self.ladyAnimBaseLayerIndex)

	return
end

function CarWashLadySystem:PlayFaceAnim(arg_44_1)
	if IsUnityEditor and not self.ladyAnimator:HasState(self.ladyAnimFaceLayerIndex, Animator.StringToHash(arg_44_1)) then
		errorMsg("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_44_1)
	end

	self.ladyAnimator:CrossFadeInFixedTime(arg_44_1, 0, self.ladyAnimFaceLayerIndex)

	return
end

return CarWashLadySystem
