local CaptureRoleEntity = class("CaptureRoleEntity", CaptureEntityBase)

function CaptureRoleEntity:GetType()
	return CaptureGameConst.EntityType.Role
end

function CaptureRoleEntity:InitGameObject()
	local var_2_0 = Asset.Instantiate(string.format("CaptureGame/Char/%d_capture_tpose", self.params_.roleId))

	var_2_0.transform.parent = CaptureGameMgr:GetGameContext().characterRoot
	var_2_0.transform.localScale = Vector3.one

	return var_2_0
end

function CaptureRoleEntity:Init()
	local var_3_0 = self.entity.obj:GetComponent(typeof(Capture.Runtime.CaptureEntityMono))
	local var_3_1 = GameObject.New("RealLookAt")

	var_3_1.transform.parent = self.entity.obj.transform
	self.context = {
		isHide = false,
		entity = self.entity,
		transform = self.entity.obj.transform,
		gameObject = self.entity.obj,
		mono = var_3_0,
		rotateModel = var_3_0.rotateModel,
		preDragPos = {
			x = 0,
			y = 0
		},
		characterEffect = self.entity.obj:GetComponentInChildren(typeof(CharacterEffect)),
		lookAtRoot = var_3_1
	}
	self.animContext = {
		currentAnim = "Nil",
		crossFadeTime = 0,
		defaultAnimName = "Idle",
		animMap = {},
		currentAnimId = CaptureGameConst.IdleAnim.ID,
		adaptorColliderRoot = self.context.transform:Find("ActionCollider")
	}
	self.animContext.defaultCollider = self.animContext.adaptorColliderRoot:Find("TouchCollider"):GetComponent(typeof(UnityEngine.CapsuleCollider))

	if isNil(self.animContext.defaultCollider) then
		Debug.LogError("错误，请检查是否提供了默认的碰撞盒" .. self.context.gameObject.name)
	else
		local var_3_2 = self.context.entity.obbCalculator

		var_3_2.ccl = self.animContext.defaultCollider
		self.context.entity.obbCalculator = var_3_2

		self.animContext.defaultCollider.gameObject:SetActive(true)
	end

	self:InitAnimation()
	self:AddListener()
end

function CaptureRoleEntity:InitAnimation()
	local var_4_0 = self.context.gameObject:GetComponentInChildren(typeof(Animator))

	self.animContext.animator = var_4_0

	if not isNil(var_4_0) then
		local var_4_1 = {
			[CaptureGameConst.IdleAnim.ID] = CaptureGameConst.IdleAnim.name
		}

		for iter_4_0, iter_4_1 in ipairs(ActivitySwimSkinAnimationCfg.all) do
			if ActivitySwimSkinAnimationCfg[iter_4_1].character == self.params_.roleId then
				var_4_1[ActivitySwimSkinAnimationCfg[iter_4_1].Id] = ActivitySwimSkinAnimationCfg[iter_4_1].animName
			end
		end

		self.animContext.animMap = var_4_1
	end
end

function CaptureRoleEntity:InitComponents()
	self.context.entity:AddComponent(CaptureGameConst.ComponentType.TransformComponent)
	self.context.entity:AddComponent(CaptureGameConst.ComponentType.OBBComponent)

	if CaptureGameMgr:IsSingleMode() then
		self.context.entity:AddComponent(CaptureGameConst.ComponentType.OcculuderComponent)
	end

	self:AdaptorAnimation(self.animContext.defaultAnimName)
end

function CaptureRoleEntity:AddListener()
	self.context.trigger = self.animContext.defaultCollider.gameObject:AddComponent(typeof(CaptureEntityTrigger))

	function self.context.trigger.onPointerClick(arg_7_0, arg_7_1)
		if CaptureGameMgr:IsSingleMode() then
			CaptureGameMgr:OpenSettingPanel(true)
		end
	end

	function self.context.trigger.onBeginDrag(arg_8_0, arg_8_1)
		local var_8_0 = CaptureGameMgr:GetCameraMgr()

		self.context.preDragPos = {
			x = var_8_0.x,
			y = LuaHelper.ScreenToLocal(var_8_0:GetControllerRectTransform(), arg_8_1.position, arg_8_1.enterEventCamera).y
		}
	end

	function self.context.trigger.onDrag(arg_9_0, arg_9_1)
		if not CaptureGameSettingData:CheckCanRotateModel() then
			return
		end

		if not CaptureGameMgr:IsSingleMode() then
			if not CaptureGameMgr:GetPlaceHolderMgr():CheckSkinCanRotate(self.params_.roleId) then
				return
			end
		end

		local var_9_0 = CaptureGameMgr:GetCameraMgr()
		local var_9_1 = LuaHelper.ScreenToLocal(var_9_0:GetControllerRectTransform(), arg_9_1.position, arg_9_1.enterEventCamera)

		self.context.preDragPos = {
			x = var_9_1.x,
			y = var_9_1.y
		}

		local var_9_2 = self.context.rotateModel.localEulerAngles
		local var_9_3 = self.context.rotateModel.localEulerAngles.y + (self.context.preDragPos.x - var_9_0.x) * HeroConst.ROTATE_RATIO - self.context.rotateModel.localEulerAngles.y
		local var_9_4 = var_9_3

		if var_9_3 < -HeroConst.MAX_RORATE_ANGLE then
			var_9_4 = -HeroConst.MAX_RORATE_ANGLE
		elseif var_9_3 > HeroConst.MAX_RORATE_ANGLE then
			var_9_4 = HeroConst.MAX_RORATE_ANGLE
		end

		self.context.rotateModel.localRotation = Quaternion.RotateTowards(self.context.rotateModel.localRotation, Quaternion.Euler(var_9_2.x, self.context.rotateModel.localEulerAngles.y + var_9_4, var_9_2.z), HeroConst.MAX_RORATE_ANGLE)
	end
end

function CaptureRoleEntity:ResetToTransformPos(arg_10_1)
	self.context.transform.position = arg_10_1.position
	self.context.transform.rotation = Quaternion.Euler(arg_10_1.rotation.eulerAngles.x, arg_10_1.rotation.eulerAngles.y, arg_10_1.rotation.eulerAngles.z)

	self:UpdateShadowHeight(arg_10_1.position.y)
end

function CaptureRoleEntity:ResetLookAtTarget()
	if self.animContext.lookAtTimer then
		self.animContext.lookAtTimer:Stop()

		self.animContext.lookAtTimer = nil
	end

	self.animContext.lookAtTimer = FrameTimer.New(function()
		if not isNil(self.context.lookAtRoot) and not isNil(self.context.mono.lookTarget) then
			self.context.lookAtRoot.transform.position = self.context.mono.lookTarget.position
		end

		if self.animContext.lookAtTimer then
			self.animContext.lookAtTimer:Stop()

			self.animContext.lookAtTimer = nil
		end
	end, 1, 1):Start()
end

function CaptureRoleEntity:OnScreen()
	return not self.context.isHide and self.context.entity.isOnScreen
end

function CaptureRoleEntity:GetRoleId()
	return self.params_.roleId
end

function CaptureRoleEntity:Hide(arg_15_1)
	self.context.isHide = arg_15_1
	self.context.entity.obbCalculator.hasOBB = not arg_15_1
	self.context.entity.obbCalculator = self.context.entity.obbCalculator

	if not isNil(self.context.gameObject) then
		self.context.gameObject:SetActive(not arg_15_1)
	end
end

function CaptureRoleEntity:PlayAnimation(arg_16_1)
	if not isNil(self.animContext.animator) then
		if self.animContext.animMap[arg_16_1] then
			self.animContext.animator:Play(self.animContext.animMap[arg_16_1])

			self.animContext.currentAnimId = arg_16_1

			self:AdaptorAnimation(self.animContext.animMap[arg_16_1])
		end
	end
end

function CaptureRoleEntity:AdaptorAnimation(arg_17_1)
	local var_17_0 = self.animContext.adaptorColliderRoot:Find(arg_17_1)
	local var_17_1 = self.animContext.adaptorColliderRoot:Find(self.animContext.currentAnim)
	local var_17_3 = self.context.entity.obbCalculator

	if not isNil(var_17_0) then
		var_17_3.hasOBB = true

		local var_17_4 = var_17_0.gameObject:GetComponent(typeof(UnityEngine.CapsuleCollider))

		self.animContext.currentAnim = arg_17_1
		self.animContext.defaultCollider.transform.position = var_17_4.transform.position
		self.animContext.defaultCollider.transform.rotation = var_17_4.transform.rotation
		self.animContext.defaultCollider.center = var_17_4.center
		self.animContext.defaultCollider.radius = var_17_4.radius
		self.animContext.defaultCollider.height = var_17_4.height
	elseif arg_17_1 == self.animContext.defaultAnimName then
		var_17_3.hasOBB = false
	elseif self.animContext.currentAnim ~= self.animContext.defaultAnimName then
		local var_17_5 = self.animContext.adaptorColliderRoot:Find(self.animContext.defaultAnimName)

		if not isNil(var_17_5) then
			var_17_3.hasOBB = true

			local var_17_6 = var_17_5.gameObject:GetComponent(typeof(UnityEngine.CapsuleCollider))

			self.animContext.currentAnim = self.animContext.defaultAnimName
			self.animContext.defaultCollider.transform.position = var_17_6.transform.position
			self.animContext.defaultCollider.transform.rotation = var_17_6.transform.rotation
			self.animContext.defaultCollider.center = var_17_6.center
			self.animContext.defaultCollider.radius = var_17_6.radius
			self.animContext.defaultCollider.height = var_17_6.height
		else
			var_17_3.hasOBB = false
		end
	end

	self.context.entity.obbCalculator = var_17_3

	self:ResetLookAtTarget()
end

function CaptureRoleEntity:GetAnimMap()
	return self.animContext.animMap
end

function CaptureRoleEntity:IsInAnim(arg_19_1)
	return arg_19_1 == self.animContext.currentAnimId
end

function CaptureRoleEntity:GetCurrentAnimation()
	return self.animContext.currentAnimId
end

function CaptureRoleEntity:UpdateShadowHeight(arg_21_1)
	self.context.characterEffect.shadowHeight = arg_21_1
end

function CaptureRoleEntity:Dispose()
	if self.animContext.lookAtTimer then
		self.animContext.lookAtTimer:Stop()

		self.animContext.lookAtTimer = nil
	end

	self.animContext.animator = nil
	self.animContext.animMap = {}

	self.context.trigger:RemoveAllListeners()

	self.context.trigger = nil
	self.context.transform = nil
	self.context.gameObject = nil

	self.context.entity:Dispose()

	self.context.entity = nil

	CaptureRoleEntity.super.Dispose(self)
end

return CaptureRoleEntity
