local LadyEnv = class("LadyEnv", import("view.dorm3d.Core.BaseLadyEnv"))

function LadyEnv:Ctor(arg_1_1)
	self.super.Ctor(self, arg_1_1.event, arg_1_1)

	return
end

function LadyEnv:InitCharacter(arg_2_1)
	self:InitCharacterRoot()
	self:InitCharacterAimIK()
	self:InitCharacterAnimator()
	self:InitCharacterHierarchy()
	self:InitCharacterCollider()
	self:InitCharacterCloth()
	self:InitCharacterIKRoot()
	self:InitCharacterTouchEvent(arg_2_1)
	self:InitCharacterAnimationEvent()
	self:InitCharacterEffects()
	self:InitCharacterBlackboard(arg_2_1)
	self:InitCharacterLayer()
	self:InitCharacterController()
	self:InitCharacterTransparency()
	self:InitCharacterAnimationDispatcher()

	return
end

function LadyEnv:InitCharacterRoot()
	self.lady = self.ladyGameObject.transform

	self.lady:SetParent(self:Get("mainCameraTF"))
	self.lady:SetParent(nil)

	return
end

function LadyEnv:InitCharacterAimIK()
	self.ladyHeadIKComp = self.lady:GetComponent(typeof(HeadAimIK))
	self.ladyHeadIKComp.AimTarget = self:Get("mainCameraTF"):Find("AimTarget")
	self.ladyHeadIKData = {
		DampTime = self.ladyHeadIKComp.DampTime,
		blinkSpeed = self.ladyHeadIKComp.blinkSpeed,
		BodyWeight = self.ladyHeadIKComp.BodyWeight,
		HeadWeight = self.ladyHeadIKComp.HeadWeight
	}

	return
end

function LadyEnv:InitCharacterAnimator()
	self.ladyAnimator = self.lady:GetComponent(typeof(Animator))
	self.ladyAnimBaseLayerIndex = self.ladyAnimator:GetLayerIndex("Base Layer")
	self.ladyAnimFaceLayerIndex = self.ladyAnimator:GetLayerIndex("Face")

	return
end

function LadyEnv:InitCharacterHierarchy()
	local var_6_0 = {}

	table.Foreach(DormConst.boneMap, function(arg_7_0, arg_7_1)
		var_6_0[arg_7_1] = arg_7_0

		return
	end)

	self.ladyBoneMaps = {}

	table.IpairsCArray(self.lady:GetComponentsInChildren(typeof(Transform), true), function(arg_8_0, arg_8_1)
		if arg_8_1.name == "BodyCollider" then
			self.ladyCollider = arg_8_1

			setActive(arg_8_1, true)
		elseif arg_8_1.name == "SafeCollider" then
			self.ladySafeCollider = arg_8_1

			setActive(arg_8_1, false)
		elseif arg_8_1.name == "Interest" then
			self.ladyInterestRoot = arg_8_1
		elseif arg_8_1.name == "Head Center" then
			self.ladyHeadCenter = arg_8_1
		end

		if var_6_0[arg_8_1.name] then
			self.ladyBoneMaps[var_6_0[arg_8_1.name]] = arg_8_1
		end

		return
	end)

	return
end

function LadyEnv:InitCharacterCollider()
	self.ladyColliders = {}
	self.ladyTouchColliders = {}

	table.IpairsCArray(self.lady:GetComponentsInChildren(typeof(UnityEngine.Collider), true), function(arg_10_0, arg_10_1)
		if arg_10_1:GetType():Equals(typeof(UnityEngine.MeshCollider)) then
			return
		end

		local var_10_0 = tf(arg_10_1)
		local var_10_1 = string.sub(var_10_0.name, 1, (var_10_0.name and string.find(var_10_0.name, "Collider") or -1) - 1)

		if DormConst.BONE_TO_TOUCH[var_10_1] == nil then
			return
		end

		self.ladyColliders[var_10_1] = var_10_0

		table.insert(self.ladyTouchColliders, var_10_0)
		setActive(var_10_0, false)

		return
	end)

	return
end

function LadyEnv:InitCharacterCloth()
	self.clothComps = {}
	self.ladyClothCompSettings = {}

	table.IpairsCArray(self.lady:GetComponentsInChildren(typeof("MagicaCloth2.MagicaCloth"), true), function(arg_12_0, arg_12_1)
		table.insert(self.clothComps, arg_12_1)

		self.ladyClothCompSettings[arg_12_1] = {
			enabled = arg_12_1.enabled
		}

		return
	end)

	self.clothColliderDict = {}
	self.ladyClothColliderSettings = {}

	table.IpairsCArray(self.lady:GetComponentsInChildren(typeof("MagicaCloth2.MagicaCapsuleCollider"), true), function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_1:GetSize()

		self.clothColliderDict[arg_13_1.name] = arg_13_1
		self.ladyClothColliderSettings[arg_13_1] = {
			enabled = arg_13_1.enabled,
			StartRadius = var_13_0.x,
			EndRadius = var_13_0.y
		}

		return
	end)
	self:EnableCloth(false)

	return
end

function LadyEnv:InitCharacterIKRoot()
	self.ladyIKRoot = self.lady:Find("IKLayers")

	eachChild(self.ladyIKRoot, function(arg_15_0)
		setActive(arg_15_0, false)

		return
	end)

	return
end

function LadyEnv:InitCharacterTouchEvent(arg_16_1)
	GetComponent(self.lady, typeof(EventTriggerListener)):AddPointClickFunc(function(arg_17_0, arg_17_1)
		if arg_17_1.rawPointerPress.transform == self.ladyCollider then
			self:Emit(Dorm3dRoomTemplateScene.CLICK_CHARACTER, arg_16_1)
		end

		return
	end)

	return
end

function LadyEnv:InitCharacterAnimationEvent()
	self.ladyAnimator:GetComponent("DftAniEvent"):SetCommonEvent(function(arg_19_0)
		if self.nowState and arg_19_0.animatorStateInfo:IsName(self.nowState) then
			existCall(self.stateCallback)

			return
		end

		local var_19_0 = arg_19_0.animatorStateInfo

		for iter_19_0, iter_19_1 in pairs(self.animCallbacks) do
			if var_19_0:IsName(iter_19_0) then
				warning("Active", iter_19_0)
				existCall((table.removebykey(self.animCallbacks, iter_19_0)))

				return
			end
		end

		if arg_19_0.stringParameter ~= "" then
			self:Func("OnAnimationEvent", arg_19_0)
		end

		return
	end)

	self.animEventCallbacks = {}
	self.animCallbacks = {}

	return
end

function LadyEnv:InitCharacterEffects()
	local function var_20_0(arg_21_0, arg_21_1, arg_21_2)
		self:Get("loader"):GetPrefab(arg_21_0, arg_21_1, function(arg_22_0)
			arg_22_0.name = arg_21_2
			self[arg_21_2] = tf(arg_22_0)

			setActive(arg_22_0, false)
			onNextTick(function()
				setParent(self[arg_21_2], self.ladyHeadCenter)

				return
			end)

			return
		end)

		return
	end

	self.effectHeart = self.ladyHeadCenter:Find("effectHeart")

	if not self.effectHeart then
		var_20_0("dorm3d/effect/prefab/function/vfx_function_aixin02", "vfx_function_aixin02", "effectHeart")
	end

	self.ladyWatchFloat = self.ladyHeadCenter:Find("ladyWatchFloat")

	if not self.ladyWatchFloat then
		var_20_0("dorm3d/effect/prefab/function/vfx_talk_mark", "vfx_talk_mark", "ladyWatchFloat")
	end

	if self.tfPendintItem then
		onNextTick(function()
			setParent(self.tfPendintItem, self.lady)

			return
		end)
	end

	return
end

function LadyEnv:InitCharacterBlackboard(arg_25_1)
	self.ladyOwner = GetComponent(self.lady, "GraphOwner")
	self.ladyBlackboard = GetComponent(self.lady, "Blackboard")

	self:SetBlackboardValue("groupId", arg_25_1)
	onNextTick(function()
		self.ladyOwner.enabled = true

		return
	end)

	return
end

function LadyEnv:InitCharacterLayer()
	pg.ViewUtils.SetLayer(self.lady, Layer.Character3D)

	return
end

function LadyEnv:InitCharacterController()
	self.characterController = GetOrAddComponent(self.ladyGameObject, typeof(CharacterController))
	self.characterController.enabled = false
	self.characterController.center = DormConst.CHARACTER_CONTROLLER.center
	self.characterController.radius = DormConst.CHARACTER_CONTROLLER.radius
	self.characterController.height = DormConst.CHARACTER_CONTROLLER.height
	self.characterController.stepOffset = DormConst.CHARACTER_CONTROLLER.stepOffset

	return
end

function LadyEnv:InitCharacterTransparency()
	self.transparencyComp = GetOrAddComponent(self.lady, typeof(CharacterTransparency))
	self.transparencyComp.player = self:Get("player")
	self.transparencyComp.minDistance = DormConst.TRANSPARENCY_MIN_DISTANCE
	self.transparencyComp.maxDistance = DormConst.TRANSPARENCY_MAX_DISTANCE

	return
end

function LadyEnv:InitCharacterAnimationDispatcher()
	self.animationEventDispatcher = GetOrAddComponent(self.lady, typeof(DormAnimationEventDispatcher))
	self.animationEventDispatcher.listenLayer = self.ladyAnimBaseLayerIndex

	return
end

function LadyEnv:SetZone(arg_31_1, arg_31_2)
	self.ladyBaseZone = arg_31_1
	self.ladyActiveZone = arg_31_2 or arg_31_1

	return
end

function LadyEnv:SwitchCharacterSkin(arg_32_1, arg_32_2, arg_32_3)
	assert(table.contains(self.skinIdList, arg_32_2))

	local var_32_0 = self:Get("skinDict")[self.skinId].ladyGameObject

	setActive(var_32_0, false)

	self.skinId = arg_32_2

	setActive(self:Get("skinDict")[arg_32_2].ladyGameObject, true)

	self.ladyGameObject = self:Get("skinDict")[arg_32_2].ladyGameObject
	self.ladyCollider = nil

	self:InitCharacter(arg_32_1)
	pg.NodeCanvasMgr.GetInstance():CopyAllBlackBoardValue(self.ladyBlackboard, self.ladyBlackboard)
	self.ladyAnimator:Play(self:GetCurrentAnim(), self.ladyAnimBaseLayerIndex)
	self.ladyAnimator:Update(0)
	self.lady:SetPositionAndRotation(var_32_0.transform.position, var_32_0.transform.rotation)
	self:Func("InitHolyLight")
	existCall(arg_32_3)

	return
end

function LadyEnv:SetBlackboardValue(arg_33_1, arg_33_2)
	self.blackboard = self.blackboard or {}
	self.blackboard[arg_33_1] = arg_33_2

	pg.NodeCanvasMgr.GetInstance():SetBlackboradValue(arg_33_1, arg_33_2, self.ladyBlackboard)

	return
end

function LadyEnv:GetBlackboardValue(arg_34_1)
	self.blackboard = self.blackboard or {}

	return self.blackboard[arg_34_1]
end

function LadyEnv:GetCurrentAnim()
	return self.ladyAnimator:GetCurrentAnimatorStateInfo(self.ladyAnimBaseLayerIndex).shortNameHash
end

function LadyEnv:EnableCloth(arg_36_1, arg_36_2)
	arg_36_1 = arg_36_1 or {}

	table.Foreach(self.clothComps, function(arg_37_0, arg_37_1)
		if arg_37_1 == nil then
			return
		end

		setActive(arg_37_1, arg_36_1[arg_37_0] == 1)

		return
	end)
	table.Foreach(self.clothColliderDict, function(arg_38_0, arg_38_1)
		if arg_38_1 == nil then
			return
		end

		setActive(arg_38_1, false)

		return
	end)

	if arg_36_2 then
		table.Foreach(arg_36_2, function(arg_39_0, arg_39_1)
			local var_39_0 = self.clothColliderDict[arg_39_1[1]]

			if self.clothColliderDict[arg_39_1[1]] == nil then
				return
			end

			setActive(var_39_0, arg_39_1[2] == 1)

			if arg_39_1[2] ~= 1 then
				return
			end

			LadyEnv.SetMagicaCollider(var_39_0, arg_39_1[3], arg_39_1[4])

			return
		end)
	end

	return
end

function LadyEnv:PlaySingleAction(arg_40_1, arg_40_2, arg_40_3)
	warning("Play", arg_40_1)

	if tobool((string.find(arg_40_1, "^Face_"))) or tobool((string.find(arg_40_1, "^face_"))) then
		self:PlayFaceAnim(arg_40_1, arg_40_2)

		return
	end

	if self.ladyAnimator:GetCurrentAnimatorStateInfo(self.ladyAnimBaseLayerIndex):IsName(arg_40_1) then
		return
	end

	existCall(self.animExtraItemCallback)

	self.animExtraItemCallback = nil

	local var_40_0 = _.detect(pg.dorm3d_anim_extraitem.get_id_list_by_ship_id[self:GetBlackboardValue("groupId")] or {}, function(arg_41_0)
		return pg.dorm3d_anim_extraitem[arg_41_0].anim == arg_40_1
	end)
	local var_40_1 = var_40_0 and pg.dorm3d_anim_extraitem[var_40_0]
	local var_40_2

	arg_40_3 = arg_40_3 or DormConst.DEFAULT_ANIM_FADE_IN_TIME

	seriesAsync({
		function(arg_42_0)
			if not var_40_1 or var_40_1.item_prefab == "" then
				arg_42_0()

				return
			end

			self:Get("loader"):GetPrefab(string.lower("dorm3d/furniture/item/" .. var_40_1.item_prefab), "", function(arg_43_0)
				setParent(arg_43_0, self.lady)

				if var_40_1.item_shield ~= "" then
					var_40_2 = {}

					for iter_43_0, iter_43_1 in ipairs(var_40_1.item_shield) do
						local var_43_0 = self:Get("modelRoot"):Find(iter_43_1)

						if not var_43_0 then
							warning(string.format("dorm3d_anim_extraitem:%d without hide item:%s", var_40_1.id, iter_43_1))
						else
							var_40_2[iter_43_1] = isActive(var_43_0)

							setActive(var_43_0, false)
						end
					end
				end

				function self.animExtraItemCallback()
					self:Get("loader"):ClearRequest("AnimExtraItem")

					if var_40_2 then
						for iter_44_0, iter_44_1 in pairs(var_40_2) do
							setActive(self:Get("modelRoot"):Find(iter_44_0), iter_44_1)
						end
					end

					return
				end

				arg_42_0()

				return
			end, "AnimExtraItem")

			return
		end,
		function(arg_45_0)
			self.nowState = arg_40_1
			self.stateCallback = arg_45_0

			if IsUnityEditor and not self.ladyAnimator:HasState(self.ladyAnimBaseLayerIndex, Animator.StringToHash(arg_40_1)) then
				errorMsg("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_40_1)
			end

			self.ladyAnimator:CrossFadeInFixedTime(arg_40_1, arg_40_3, self.ladyAnimBaseLayerIndex)

			return
		end,
		function(arg_46_0)
			self.nowState = nil
			self.stateCallback = nil

			existCall(self.animExtraItemCallback)

			self.animExtraItemCallback = nil

			arg_46_0()

			return
		end,
		arg_40_2
	})

	return
end

function LadyEnv:PlayFaceAnim(arg_47_1, arg_47_2)
	if IsUnityEditor and not self.ladyAnimator:HasState(self.ladyAnimFaceLayerIndex, Animator.StringToHash(arg_47_1)) then
		errorMsg("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_47_1)
	end

	self.ladyAnimator:CrossFadeInFixedTime(arg_47_1, 0, self.ladyAnimFaceLayerIndex)
	existCall(arg_47_2)

	return
end

function LadyEnv:SwitchAnim(arg_48_1, arg_48_2)
	if tobool((string.find(arg_48_1, "^Face_"))) then
		self:PlayFaceAnim(arg_48_1, arg_48_2)

		return
	end

	existCall(self.animExtraItemCallback)

	self.animExtraItemCallback = nil

	local var_48_0 = {}

	table.insert(var_48_0, function(arg_49_0)
		self.nowState = arg_48_1
		self.stateCallback = arg_49_0

		self.ladyAnimator:PlayInFixedTime(arg_48_1, self.ladyAnimBaseLayerIndex)

		return
	end)
	table.insert(var_48_0, function(arg_50_0)
		self.nowState = nil
		self.stateCallback = nil

		arg_50_0()

		return
	end)
	seriesAsync(var_48_0, arg_48_2)

	return
end

function LadyEnv:RevertClothComps()
	table.Foreach(self.ladyClothCompSettings, function(arg_52_0, arg_52_1)
		arg_52_0.enabled = arg_52_1.enabled

		return
	end)
	table.Foreach(self.ladyClothColliderSettings, function(arg_53_0, arg_53_1)
		arg_53_0.enabled = arg_53_1.enabled

		LadyEnv.SetMagicaCollider(arg_53_0, arg_53_1.StartRadius, arg_53_1.EndRadius)

		return
	end)

	return
end

function LadyEnv:SetMagicaCollider(arg_54_1, arg_54_2)
	local var_54_0 = typeof("MagicaCloth2.MagicaCapsuleCollider")
	local var_54_1 = self:GetSize()

	var_54_1.x = arg_54_1
	var_54_1.y = arg_54_2

	self:SetSize(var_54_1)

	return
end

function LadyEnv:MoveToTarget(arg_55_1, arg_55_2, arg_55_3)
	arg_55_2 = arg_55_2 or DormConst.LADY_MOVE_SPEED
	arg_55_3 = arg_55_3 or DormConst.LADY_ROTATE_SPEED

	local var_55_0 = arg_55_1 - self.lady.position

	var_55_0.y = 0

	if var_55_0 ~= Vector3.zero then
		self.lady.rotation = Quaternion.Slerp(self.lady.rotation, Quaternion.LookRotation(var_55_0), Time.deltaTime * arg_55_3)
	end

	self.characterController:Move(var_55_0.normalized * arg_55_2 * Time.deltaTime)

	return
end

function LadyEnv:SetCurrentIkTimelineStatus(arg_56_1)
	self.currentIkTimelineStatus = arg_56_1

	return
end

function LadyEnv:CheckIkTimelineStatus(arg_57_1)
	if not self.currentIkTimelineStatus then
		return true
	end

	return self.currentIkTimelineStatus ~= arg_57_1
end

function LadyEnv:SetCollisible(arg_58_1)
	local var_58_0 = self.ladyCollider:GetComponent(typeof(UnityEngine.CapsuleCollider))

	if arg_58_1 then
		var_58_0.excludeLayers = LayerMask.GetMask("Nothing")
		self.characterController.excludeLayers = LayerMask.GetMask("Nothing")
	else
		var_58_0.excludeLayers = LayerMask.GetMask("Player")
		self.characterController.excludeLayers = LayerMask.GetMask("Player")
	end

	return
end

function LadyEnv:EnableCharacterTransparency(arg_59_1)
	self.transparencyComp.Enable = arg_59_1

	return
end

function LadyEnv:BlockCanWatch(arg_60_1)
	self.blockCanWatch = arg_60_1

	return
end

function LadyEnv:SetPosition(arg_61_1)
	self.lady.position = arg_61_1

	return
end

function LadyEnv:SetRotation(arg_62_1)
	self.lady.rotation = arg_62_1

	return
end

return LadyEnv
