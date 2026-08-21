local var_0_0 = class("CaptureRoleEntity", CaptureEntityBase)

function var_0_0.GetType(arg_1_0)
	return CaptureGameConst.EntityType.Role
end

function var_0_0.InitGameObject(arg_2_0)
	local var_2_0 = Asset.Instantiate(string.format("CaptureGame/Char/%d_capture_tpose", arg_2_0.params_.roleId))

	var_2_0.transform.parent = CaptureGameMgr:GetGameContext().characterRoot
	var_2_0.transform.localScale = Vector3.one

	return var_2_0
end

function var_0_0.Init(arg_3_0)
	local var_3_0 = arg_3_0.entity.obj:GetComponent(typeof(Capture.Runtime.CaptureEntityMono))
	local var_3_1 = GameObject.New("RealLookAt")

	var_3_1.transform.parent = arg_3_0.entity.obj.transform
	arg_3_0.context = {
		isHide = false,
		entity = arg_3_0.entity,
		transform = arg_3_0.entity.obj.transform,
		gameObject = arg_3_0.entity.obj,
		mono = var_3_0,
		rotateModel = var_3_0.rotateModel,
		preDragPos = {
			x = 0,
			y = 0
		},
		characterEffect = arg_3_0.entity.obj:GetComponentInChildren(typeof(CharacterEffect)),
		lookAtRoot = var_3_1
	}
	arg_3_0.animContext = {
		currentAnim = "Nil",
		crossFadeTime = 0,
		defaultAnimName = "Idle",
		animMap = {},
		currentAnimId = CaptureGameConst.IdleAnim.ID,
		adaptorColliderRoot = arg_3_0.context.transform:Find("ActionCollider")
	}
	arg_3_0.animContext.defaultCollider = arg_3_0.animContext.adaptorColliderRoot:Find("TouchCollider"):GetComponent(typeof(UnityEngine.CapsuleCollider))

	if isNil(arg_3_0.animContext.defaultCollider) then
		Debug.LogError("错误，请检查是否提供了默认的碰撞盒" .. arg_3_0.context.gameObject.name)
	else
		local var_3_2 = arg_3_0.context.entity.obbCalculator

		var_3_2.ccl = arg_3_0.animContext.defaultCollider
		arg_3_0.context.entity.obbCalculator = var_3_2

		arg_3_0.animContext.defaultCollider.gameObject:SetActive(true)
	end

	arg_3_0:InitAnimation()
	arg_3_0:AddListener()
end

function var_0_0.InitAnimation(arg_4_0)
	local var_4_0 = arg_4_0.context.gameObject:GetComponentInChildren(typeof(Animator))

	arg_4_0.animContext.animator = var_4_0

	if not isNil(var_4_0) then
		local var_4_1 = {
			[CaptureGameConst.IdleAnim.ID] = CaptureGameConst.IdleAnim.name
		}

		for iter_4_0, iter_4_1 in ipairs(ActivitySwimSkinAnimationCfg.all) do
			local var_4_2 = ActivitySwimSkinAnimationCfg[iter_4_1]

			if var_4_2.character == arg_4_0.params_.roleId then
				var_4_1[var_4_2.Id] = var_4_2.animName
			end
		end

		arg_4_0.animContext.animMap = var_4_1
	end
end

function var_0_0.InitComponents(arg_5_0)
	arg_5_0.context.entity:AddComponent(CaptureGameConst.ComponentType.TransformComponent)
	arg_5_0.context.entity:AddComponent(CaptureGameConst.ComponentType.OBBComponent)

	if CaptureGameMgr:IsSingleMode() then
		arg_5_0.context.entity:AddComponent(CaptureGameConst.ComponentType.OcculuderComponent)
	end

	arg_5_0:AdaptorAnimation(arg_5_0.animContext.defaultAnimName)
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0.context.trigger = arg_6_0.animContext.defaultCollider.gameObject:AddComponent(typeof(CaptureEntityTrigger))

	function arg_6_0.context.trigger.onPointerClick(arg_7_0, arg_7_1)
		if CaptureGameMgr:IsSingleMode() then
			CaptureGameMgr:OpenSettingPanel(true)
		end
	end

	function arg_6_0.context.trigger.onBeginDrag(arg_8_0, arg_8_1)
		local var_8_0 = CaptureGameMgr:GetCameraMgr():GetControllerRectTransform()
		local var_8_1 = LuaHelper.ScreenToLocal(var_8_0, arg_8_1.position, arg_8_1.enterEventCamera)

		arg_6_0.context.preDragPos = {
			x = var_8_1.x,
			y = var_8_1.y
		}
	end

	function arg_6_0.context.trigger.onDrag(arg_9_0, arg_9_1)
		if not CaptureGameSettingData:CheckCanRotateModel() then
			return
		end

		if not CaptureGameMgr:IsSingleMode() and not CaptureGameMgr:GetPlaceHolderMgr():CheckSkinCanRotate(arg_6_0.params_.roleId) then
			return
		end

		local var_9_0 = CaptureGameMgr:GetCameraMgr():GetControllerRectTransform()
		local var_9_1 = LuaHelper.ScreenToLocal(var_9_0, arg_9_1.position, arg_9_1.enterEventCamera)
		local var_9_2 = arg_6_0.context.preDragPos.x - var_9_1.x

		arg_6_0.context.preDragPos = {
			x = var_9_1.x,
			y = var_9_1.y
		}

		local var_9_3 = arg_6_0.context.rotateModel.localEulerAngles
		local var_9_4 = var_9_3.y
		local var_9_5 = var_9_4 + var_9_2 * HeroConst.ROTATE_RATIO - var_9_4
		local var_9_6 = var_9_5

		if var_9_5 < -HeroConst.MAX_RORATE_ANGLE then
			var_9_6 = -HeroConst.MAX_RORATE_ANGLE
		elseif var_9_5 > HeroConst.MAX_RORATE_ANGLE then
			var_9_6 = HeroConst.MAX_RORATE_ANGLE
		end

		arg_6_0.context.rotateModel.localRotation = Quaternion.RotateTowards(arg_6_0.context.rotateModel.localRotation, Quaternion.Euler(var_9_3.x, var_9_4 + var_9_6, var_9_3.z), HeroConst.MAX_RORATE_ANGLE)
	end
end

function var_0_0.ResetToTransformPos(arg_10_0, arg_10_1)
	arg_10_0.context.transform.position = arg_10_1.position

	local var_10_0 = arg_10_1.rotation.eulerAngles

	arg_10_0.context.transform.rotation = Quaternion.Euler(var_10_0.x, var_10_0.y, var_10_0.z)

	arg_10_0:UpdateShadowHeight(arg_10_1.position.y)
end

function var_0_0.ResetLookAtTarget(arg_11_0)
	if arg_11_0.animContext.lookAtTimer then
		arg_11_0.animContext.lookAtTimer:Stop()

		arg_11_0.animContext.lookAtTimer = nil
	end

	arg_11_0.animContext.lookAtTimer = FrameTimer.New(function()
		if not isNil(arg_11_0.context.lookAtRoot) and not isNil(arg_11_0.context.mono.lookTarget) then
			arg_11_0.context.lookAtRoot.transform.position = arg_11_0.context.mono.lookTarget.position
		end

		if arg_11_0.animContext.lookAtTimer then
			arg_11_0.animContext.lookAtTimer:Stop()

			arg_11_0.animContext.lookAtTimer = nil
		end
	end, 1, 1):Start()
end

function var_0_0.OnScreen(arg_13_0)
	return not arg_13_0.context.isHide and arg_13_0.context.entity.isOnScreen
end

function var_0_0.GetRoleId(arg_14_0)
	return arg_14_0.params_.roleId
end

function var_0_0.Hide(arg_15_0, arg_15_1)
	arg_15_0.context.isHide = arg_15_1

	local var_15_0 = arg_15_0.context.entity.obbCalculator

	var_15_0.hasOBB = not arg_15_1
	arg_15_0.context.entity.obbCalculator = var_15_0

	if not isNil(arg_15_0.context.gameObject) then
		arg_15_0.context.gameObject:SetActive(not arg_15_1)
	end
end

function var_0_0.PlayAnimation(arg_16_0, arg_16_1)
	if not isNil(arg_16_0.animContext.animator) then
		local var_16_0 = arg_16_0.animContext.animMap[arg_16_1]

		if var_16_0 then
			arg_16_0.animContext.animator:Play(var_16_0)

			arg_16_0.animContext.currentAnimId = arg_16_1

			arg_16_0:AdaptorAnimation(var_16_0)
		end
	end
end

function var_0_0.AdaptorAnimation(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.animContext.currentAnim
	local var_17_1 = arg_17_0.animContext.adaptorColliderRoot:Find(arg_17_1)
	local var_17_2 = arg_17_0.animContext.adaptorColliderRoot:Find(var_17_0)
	local var_17_3
	local var_17_4 = arg_17_0.animContext.defaultCollider
	local var_17_5 = var_17_4.transform
	local var_17_6 = arg_17_0.context.entity.obbCalculator

	if not isNil(var_17_1) then
		var_17_6.hasOBB = true

		local var_17_7 = var_17_1.gameObject:GetComponent(typeof(UnityEngine.CapsuleCollider))

		arg_17_0.animContext.currentAnim = arg_17_1
		var_17_5.position = var_17_7.transform.position
		var_17_5.rotation = var_17_7.transform.rotation
		var_17_4.center = var_17_7.center
		var_17_4.radius = var_17_7.radius
		var_17_4.height = var_17_7.height
	elseif arg_17_1 == arg_17_0.animContext.defaultAnimName then
		var_17_6.hasOBB = false
	elseif arg_17_0.animContext.currentAnim ~= arg_17_0.animContext.defaultAnimName then
		local var_17_8 = arg_17_0.animContext.adaptorColliderRoot:Find(arg_17_0.animContext.defaultAnimName)

		if not isNil(var_17_8) then
			var_17_6.hasOBB = true

			local var_17_9 = var_17_8.gameObject:GetComponent(typeof(UnityEngine.CapsuleCollider))

			arg_17_0.animContext.currentAnim = arg_17_0.animContext.defaultAnimName
			var_17_5.position = var_17_9.transform.position
			var_17_5.rotation = var_17_9.transform.rotation
			var_17_4.center = var_17_9.center
			var_17_4.radius = var_17_9.radius
			var_17_4.height = var_17_9.height
		else
			var_17_6.hasOBB = false
		end
	end

	arg_17_0.context.entity.obbCalculator = var_17_6

	arg_17_0:ResetLookAtTarget()
end

function var_0_0.GetAnimMap(arg_18_0)
	return arg_18_0.animContext.animMap
end

function var_0_0.IsInAnim(arg_19_0, arg_19_1)
	return arg_19_1 == arg_19_0.animContext.currentAnimId
end

function var_0_0.GetCurrentAnimation(arg_20_0)
	return arg_20_0.animContext.currentAnimId
end

function var_0_0.UpdateShadowHeight(arg_21_0, arg_21_1)
	arg_21_0.context.characterEffect.shadowHeight = arg_21_1
end

function var_0_0.Dispose(arg_22_0)
	if arg_22_0.animContext.lookAtTimer then
		arg_22_0.animContext.lookAtTimer:Stop()

		arg_22_0.animContext.lookAtTimer = nil
	end

	arg_22_0.animContext.animator = nil
	arg_22_0.animContext.animMap = {}

	arg_22_0.context.trigger:RemoveAllListeners()

	arg_22_0.context.trigger = nil
	arg_22_0.context.transform = nil
	arg_22_0.context.gameObject = nil

	arg_22_0.context.entity:Dispose()

	arg_22_0.context.entity = nil

	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
