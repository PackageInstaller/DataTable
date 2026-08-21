local var_0_0 = class("LadyEnv", import("view.dorm3d.Core.BaseLadyEnv"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.super.Ctor(arg_1_0, arg_1_1.event, arg_1_1)

	return
end

function var_0_0.InitCharacter(arg_2_0, arg_2_1)
	arg_2_0:InitCharacterRoot()
	arg_2_0:InitCharacterAimIK()
	arg_2_0:InitCharacterAnimator()
	arg_2_0:InitCharacterHierarchy()
	arg_2_0:InitCharacterCollider()
	arg_2_0:InitCharacterCloth()
	arg_2_0:InitCharacterIKRoot()
	arg_2_0:InitCharacterTouchEvent(arg_2_1)
	arg_2_0:InitCharacterAnimationEvent()
	arg_2_0:InitCharacterEffects()
	arg_2_0:InitCharacterBlackboard(arg_2_1)
	arg_2_0:InitCharacterLayer()
	arg_2_0:InitCharacterController()
	arg_2_0:InitCharacterTransparency()
	arg_2_0:InitCharacterAnimationDispatcher()

	return
end

function var_0_0.InitCharacterRoot(arg_3_0)
	arg_3_0.lady = arg_3_0.ladyGameObject.transform

	arg_3_0.lady:SetParent(arg_3_0:Get("mainCameraTF"))
	arg_3_0.lady:SetParent(nil)

	return
end

function var_0_0.InitCharacterAimIK(arg_4_0)
	arg_4_0.ladyHeadIKComp = arg_4_0.lady:GetComponent(typeof(HeadAimIK))
	arg_4_0.ladyHeadIKComp.AimTarget = arg_4_0:Get("mainCameraTF"):Find("AimTarget")
	arg_4_0.ladyHeadIKData = {
		DampTime = arg_4_0.ladyHeadIKComp.DampTime,
		blinkSpeed = arg_4_0.ladyHeadIKComp.blinkSpeed,
		BodyWeight = arg_4_0.ladyHeadIKComp.BodyWeight,
		HeadWeight = arg_4_0.ladyHeadIKComp.HeadWeight
	}

	return
end

function var_0_0.InitCharacterAnimator(arg_5_0)
	arg_5_0.ladyAnimator = arg_5_0.lady:GetComponent(typeof(Animator))
	arg_5_0.ladyAnimBaseLayerIndex = arg_5_0.ladyAnimator:GetLayerIndex("Base Layer")
	arg_5_0.ladyAnimFaceLayerIndex = arg_5_0.ladyAnimator:GetLayerIndex("Face")

	return
end

function var_0_0.InitCharacterHierarchy(arg_6_0)
	local var_6_0 = {}

	table.Foreach(DormConst.boneMap, function(arg_7_0, arg_7_1)
		var_6_0[arg_7_1] = arg_7_0

		return
	end)

	arg_6_0.ladyBoneMaps = {}

	table.IpairsCArray(arg_6_0.lady:GetComponentsInChildren(typeof(Transform), true), function(arg_8_0, arg_8_1)
		if arg_8_1.name == "BodyCollider" then
			arg_6_0.ladyCollider = arg_8_1

			setActive(arg_8_1, true)
		elseif arg_8_1.name == "SafeCollider" then
			arg_6_0.ladySafeCollider = arg_8_1

			setActive(arg_8_1, false)
		elseif arg_8_1.name == "Interest" then
			arg_6_0.ladyInterestRoot = arg_8_1
		elseif arg_8_1.name == "Head Center" then
			arg_6_0.ladyHeadCenter = arg_8_1
		end

		if var_6_0[arg_8_1.name] then
			arg_6_0.ladyBoneMaps[var_6_0[arg_8_1.name]] = arg_8_1
		end

		return
	end)

	return
end

function var_0_0.InitCharacterCollider(arg_9_0)
	arg_9_0.ladyColliders = {}
	arg_9_0.ladyTouchColliders = {}

	table.IpairsCArray(arg_9_0.lady:GetComponentsInChildren(typeof(UnityEngine.Collider), true), function(arg_10_0, arg_10_1)
		if arg_10_1:GetType():Equals(typeof(UnityEngine.MeshCollider)) then
			return
		end

		local var_10_0 = tf(arg_10_1)
		local var_10_1 = var_10_0.name and string.find(var_10_0.name, "Collider") or -1
		local var_10_2 = string.sub(var_10_0.name, 1, var_10_1 - 1)

		if DormConst.BONE_TO_TOUCH[var_10_2] == nil then
			return
		end

		arg_9_0.ladyColliders[var_10_2] = var_10_0

		table.insert(arg_9_0.ladyTouchColliders, var_10_0)
		setActive(var_10_0, false)

		return
	end)

	return
end

function var_0_0.InitCharacterCloth(arg_11_0)
	arg_11_0.clothComps = {}
	arg_11_0.ladyClothCompSettings = {}

	table.IpairsCArray(arg_11_0.lady:GetComponentsInChildren(typeof("MagicaCloth2.MagicaCloth"), true), function(arg_12_0, arg_12_1)
		table.insert(arg_11_0.clothComps, arg_12_1)

		arg_11_0.ladyClothCompSettings[arg_12_1] = {
			enabled = arg_12_1.enabled
		}

		return
	end)

	arg_11_0.clothColliderDict = {}
	arg_11_0.ladyClothColliderSettings = {}

	table.IpairsCArray(arg_11_0.lady:GetComponentsInChildren(typeof("MagicaCloth2.MagicaCapsuleCollider"), true), function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_1:GetSize()

		arg_11_0.clothColliderDict[arg_13_1.name] = arg_13_1
		arg_11_0.ladyClothColliderSettings[arg_13_1] = {
			enabled = arg_13_1.enabled,
			StartRadius = var_13_0.x,
			EndRadius = var_13_0.y
		}

		return
	end)
	arg_11_0:EnableCloth(false)

	return
end

function var_0_0.InitCharacterIKRoot(arg_14_0)
	arg_14_0.ladyIKRoot = arg_14_0.lady:Find("IKLayers")

	eachChild(arg_14_0.ladyIKRoot, function(arg_15_0)
		setActive(arg_15_0, false)

		return
	end)

	return
end

function var_0_0.InitCharacterTouchEvent(arg_16_0, arg_16_1)
	GetComponent(arg_16_0.lady, typeof(EventTriggerListener)):AddPointClickFunc(function(arg_17_0, arg_17_1)
		if arg_17_1.rawPointerPress.transform == arg_16_0.ladyCollider then
			arg_16_0:Emit(Dorm3dRoomTemplateScene.CLICK_CHARACTER, arg_16_1)
		end

		return
	end)

	return
end

function var_0_0.InitCharacterAnimationEvent(arg_18_0)
	arg_18_0.ladyAnimator:GetComponent("DftAniEvent"):SetCommonEvent(function(arg_19_0)
		if arg_18_0.nowState and arg_19_0.animatorStateInfo:IsName(arg_18_0.nowState) then
			existCall(arg_18_0.stateCallback)

			return
		end

		for iter_19_0, iter_19_1 in pairs(arg_18_0.animCallbacks) do
			if var_19_0:IsName(iter_19_0) then
				warning("Active", iter_19_0)
				existCall((table.removebykey(arg_18_0.animCallbacks, iter_19_0)))

				return
			end
		end

		if arg_19_0.stringParameter ~= "" then
			arg_18_0:Func("OnAnimationEvent", arg_19_0)
		end

		return
	end)

	arg_18_0.animEventCallbacks = {}
	arg_18_0.animCallbacks = {}

	return
end

function var_0_0.InitCharacterEffects(arg_20_0)
	arg_20_0.effectHeart = arg_20_0.ladyHeadCenter:Find("effectHeart")

	if not arg_20_0.effectHeart then
		(function(arg_21_0, arg_21_1, arg_21_2)
			arg_20_0:Get("loader"):GetPrefab(arg_21_0, arg_21_1, function(arg_22_0)
				arg_22_0.name = arg_21_2
				arg_20_0[arg_21_2] = tf(arg_22_0)

				setActive(arg_22_0, false)
				onNextTick(function()
					setParent(arg_20_0[arg_21_2], arg_20_0.ladyHeadCenter)

					return
				end)

				return
			end)

			return
		end)("dorm3d/effect/prefab/function/vfx_function_aixin02", "vfx_function_aixin02", "effectHeart")
	end

	arg_20_0.ladyWatchFloat = arg_20_0.ladyHeadCenter:Find("ladyWatchFloat")

	if not arg_20_0.ladyWatchFloat then
		(function(arg_21_0, arg_21_1, arg_21_2)
			arg_20_0:Get("loader"):GetPrefab(arg_21_0, arg_21_1, function(arg_22_0)
				arg_22_0.name = arg_21_2
				arg_20_0[arg_21_2] = tf(arg_22_0)

				setActive(arg_22_0, false)
				onNextTick(function()
					setParent(arg_20_0[arg_21_2], arg_20_0.ladyHeadCenter)

					return
				end)

				return
			end)

			return
		end)("dorm3d/effect/prefab/function/vfx_talk_mark", "vfx_talk_mark", "ladyWatchFloat")
	end

	if arg_20_0.tfPendintItem then
		onNextTick(function()
			setParent(arg_20_0.tfPendintItem, arg_20_0.lady)

			return
		end)
	end

	return
end

function var_0_0.InitCharacterBlackboard(arg_25_0, arg_25_1)
	arg_25_0.ladyOwner = GetComponent(arg_25_0.lady, "GraphOwner")
	arg_25_0.ladyBlackboard = GetComponent(arg_25_0.lady, "Blackboard")

	arg_25_0:SetBlackboardValue("groupId", arg_25_1)
	onNextTick(function()
		arg_25_0.ladyOwner.enabled = true

		return
	end)

	return
end

function var_0_0.InitCharacterLayer(arg_27_0)
	pg.ViewUtils.SetLayer(arg_27_0.lady, Layer.Character3D)

	return
end

function var_0_0.InitCharacterController(arg_28_0)
	arg_28_0.characterController = GetOrAddComponent(arg_28_0.ladyGameObject, typeof(CharacterController))
	arg_28_0.characterController.enabled = false
	arg_28_0.characterController.center = DormConst.CHARACTER_CONTROLLER.center
	arg_28_0.characterController.radius = DormConst.CHARACTER_CONTROLLER.radius
	arg_28_0.characterController.height = DormConst.CHARACTER_CONTROLLER.height
	arg_28_0.characterController.stepOffset = DormConst.CHARACTER_CONTROLLER.stepOffset

	return
end

function var_0_0.InitCharacterTransparency(arg_29_0)
	arg_29_0.transparencyComp = GetOrAddComponent(arg_29_0.lady, typeof(CharacterTransparency))
	arg_29_0.transparencyComp.player = arg_29_0:Get("player")
	arg_29_0.transparencyComp.minDistance = DormConst.TRANSPARENCY_MIN_DISTANCE
	arg_29_0.transparencyComp.maxDistance = DormConst.TRANSPARENCY_MAX_DISTANCE

	return
end

function var_0_0.InitCharacterAnimationDispatcher(arg_30_0)
	arg_30_0.animationEventDispatcher = GetOrAddComponent(arg_30_0.lady, typeof(DormAnimationEventDispatcher))
	arg_30_0.animationEventDispatcher.listenLayer = arg_30_0.ladyAnimBaseLayerIndex

	return
end

function var_0_0.SetZone(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.ladyBaseZone = arg_31_1
	arg_31_0.ladyActiveZone = arg_31_2 or arg_31_1

	return
end

function var_0_0.SwitchCharacterSkin(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	assert(table.contains(arg_32_0.skinIdList, arg_32_2))

	local var_32_0 = arg_32_0:Get("skinDict")[arg_32_0.skinId].ladyGameObject

	setActive(var_32_0, false)

	arg_32_0.skinId = arg_32_2

	setActive(arg_32_0:Get("skinDict")[arg_32_2].ladyGameObject, true)

	arg_32_0.ladyGameObject = arg_32_0:Get("skinDict")[arg_32_2].ladyGameObject
	arg_32_0.ladyCollider = nil

	arg_32_0:InitCharacter(arg_32_1)
	pg.NodeCanvasMgr.GetInstance():CopyAllBlackBoardValue(arg_32_0.ladyBlackboard, arg_32_0.ladyBlackboard)
	arg_32_0.ladyAnimator:Play(arg_32_0:GetCurrentAnim(), arg_32_0.ladyAnimBaseLayerIndex)
	arg_32_0.ladyAnimator:Update(0)
	arg_32_0.lady:SetPositionAndRotation(var_32_0.transform.position, var_32_0.transform.rotation)
	arg_32_0:Func("InitHolyLight")
	existCall(arg_32_3)

	return
end

function var_0_0.SetBlackboardValue(arg_33_0, arg_33_1, arg_33_2)
	arg_33_0.blackboard = arg_33_0.blackboard or {}
	arg_33_0.blackboard[arg_33_1] = arg_33_2

	pg.NodeCanvasMgr.GetInstance():SetBlackboradValue(arg_33_1, arg_33_2, arg_33_0.ladyBlackboard)

	return
end

function var_0_0.GetBlackboardValue(arg_34_0, arg_34_1)
	arg_34_0.blackboard = arg_34_0.blackboard or {}

	return arg_34_0.blackboard[arg_34_1]
end

function var_0_0.GetCurrentAnim(arg_35_0)
	return arg_35_0.ladyAnimator:GetCurrentAnimatorStateInfo(arg_35_0.ladyAnimBaseLayerIndex).shortNameHash
end

function var_0_0.EnableCloth(arg_36_0, arg_36_1, arg_36_2)
	arg_36_1 = arg_36_1 or {}

	table.Foreach(arg_36_0.clothComps, function(arg_37_0, arg_37_1)
		if arg_37_1 == nil then
			return
		end

		setActive(arg_37_1, arg_36_1[arg_37_0] == 1)

		return
	end)
	table.Foreach(arg_36_0.clothColliderDict, function(arg_38_0, arg_38_1)
		if arg_38_1 == nil then
			return
		end

		setActive(arg_38_1, false)

		return
	end)

	if arg_36_2 then
		table.Foreach(arg_36_2, function(arg_39_0, arg_39_1)
			local var_39_0 = arg_36_0.clothColliderDict[arg_39_1[1]]

			if arg_36_0.clothColliderDict[arg_39_1[1]] == nil then
				return
			end

			setActive(var_39_0, arg_39_1[2] == 1)

			if arg_39_1[2] ~= 1 then
				return
			end

			var_0_0.SetMagicaCollider(var_39_0, arg_39_1[3], arg_39_1[4])

			return
		end)
	end

	return
end

function var_0_0.PlaySingleAction(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	warning("Play", arg_40_1)

	local var_40_0 = tobool((string.find(arg_40_1, "^Face_"))) or tobool((string.find(arg_40_1, "^face_")))

	if var_40_0 then
		arg_40_0:PlayFaceAnim(arg_40_1, arg_40_2)

		return
	end

	local var_40_1 = arg_40_0.ladyAnimator:GetCurrentAnimatorStateInfo(arg_40_0.ladyAnimBaseLayerIndex)

	if var_40_1:IsName(arg_40_1) then
		return
	end

	existCall(arg_40_0.animExtraItemCallback)

	arg_40_0.animExtraItemCallback = nil

	local var_40_2 = pg.dorm3d_anim_extraitem.get_id_list_by_ship_id[arg_40_0:GetBlackboardValue("groupId")] or {}
	local var_40_3 = _.detect(var_40_2, function(arg_41_0)
		return pg.dorm3d_anim_extraitem[arg_41_0].anim == arg_40_1
	end)
	local var_40_4 = var_40_3 and pg.dorm3d_anim_extraitem[var_40_3]
	local var_40_5

	arg_40_3 = arg_40_3 or DormConst.DEFAULT_ANIM_FADE_IN_TIME

	seriesAsync({
		function(arg_42_0)
			if not var_40_4 or var_40_4.item_prefab == "" then
				arg_42_0()

				return
			end

			arg_40_0:Get("loader"):GetPrefab(string.lower("dorm3d/furniture/item/" .. var_40_4.item_prefab), "", function(arg_43_0)
				setParent(arg_43_0, arg_40_0.lady)

				if var_40_4.item_shield ~= "" then
					var_40_5 = {}

					for iter_43_0, iter_43_1 in ipairs(var_40_4.item_shield) do
						local var_43_0 = arg_40_0:Get("modelRoot"):Find(iter_43_1)

						if not var_43_0 then
							warning(string.format("dorm3d_anim_extraitem:%d without hide item:%s", var_40_4.id, iter_43_1))
						else
							var_40_5[iter_43_1] = isActive(var_43_0)

							setActive(var_43_0, false)
						end
					end
				end

				function arg_40_0.animExtraItemCallback()
					arg_40_0:Get("loader"):ClearRequest("AnimExtraItem")

					if var_40_5 then
						for iter_44_0, iter_44_1 in pairs(var_40_5) do
							local var_44_0 = arg_40_0:Get("modelRoot")

							setActive(var_44_0:Find(iter_44_0), iter_44_1)
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
			arg_40_0.nowState = arg_40_1
			arg_40_0.stateCallback = arg_45_0

			if IsUnityEditor and not arg_40_0.ladyAnimator:HasState(arg_40_0.ladyAnimBaseLayerIndex, Animator.StringToHash(arg_40_1)) then
				errorMsg("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_40_1)
			end

			arg_40_0.ladyAnimator:CrossFadeInFixedTime(arg_40_1, arg_40_3, arg_40_0.ladyAnimBaseLayerIndex)

			return
		end,
		function(arg_46_0)
			arg_40_0.nowState = nil
			arg_40_0.stateCallback = nil

			existCall(arg_40_0.animExtraItemCallback)

			arg_40_0.animExtraItemCallback = nil

			arg_46_0()

			return
		end,
		arg_40_2
	})

	return
end

function var_0_0.PlayFaceAnim(arg_47_0, arg_47_1, arg_47_2)
	if IsUnityEditor and not arg_47_0.ladyAnimator:HasState(arg_47_0.ladyAnimFaceLayerIndex, Animator.StringToHash(arg_47_1)) then
		errorMsg("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_47_1)
	end

	arg_47_0.ladyAnimator:CrossFadeInFixedTime(arg_47_1, 0, arg_47_0.ladyAnimFaceLayerIndex)
	existCall(arg_47_2)

	return
end

function var_0_0.SwitchAnim(arg_48_0, arg_48_1, arg_48_2)
	if tobool((string.find(arg_48_1, "^Face_"))) then
		arg_48_0:PlayFaceAnim(arg_48_1, arg_48_2)

		return
	end

	existCall(arg_48_0.animExtraItemCallback)

	arg_48_0.animExtraItemCallback = nil

	table.insert({}, function(arg_49_0)
		arg_48_0.nowState = arg_48_1
		arg_48_0.stateCallback = arg_49_0

		arg_48_0.ladyAnimator:PlayInFixedTime(arg_48_1, arg_48_0.ladyAnimBaseLayerIndex)

		return
	end)
	table.insert({}, function(arg_50_0)
		arg_48_0.nowState = nil
		arg_48_0.stateCallback = nil

		arg_50_0()

		return
	end)
	seriesAsync({}, arg_48_2)

	return
end

function var_0_0.RevertClothComps(arg_51_0)
	table.Foreach(arg_51_0.ladyClothCompSettings, function(arg_52_0, arg_52_1)
		arg_52_0.enabled = arg_52_1.enabled

		return
	end)
	table.Foreach(arg_51_0.ladyClothColliderSettings, function(arg_53_0, arg_53_1)
		arg_53_0.enabled = arg_53_1.enabled

		var_0_0.SetMagicaCollider(arg_53_0, arg_53_1.StartRadius, arg_53_1.EndRadius)

		return
	end)

	return
end

function var_0_0.SetMagicaCollider(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = typeof("MagicaCloth2.MagicaCapsuleCollider")
	local var_54_1 = arg_54_0:GetSize()

	var_54_1.x = arg_54_1
	var_54_1.y = arg_54_2

	arg_54_0:SetSize(var_54_1)

	return
end

function var_0_0.MoveToTarget(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	arg_55_2 = arg_55_2 or DormConst.LADY_MOVE_SPEED
	arg_55_3 = arg_55_3 or DormConst.LADY_ROTATE_SPEED

	local var_55_0 = arg_55_1 - arg_55_0.lady.position

	var_55_0.y = 0

	if var_55_0 ~= Vector3.zero then
		arg_55_0.lady.rotation = Quaternion.Slerp(arg_55_0.lady.rotation, Quaternion.LookRotation(var_55_0), Time.deltaTime * arg_55_3)
	end

	arg_55_0.characterController:Move(var_55_0.normalized * arg_55_2 * Time.deltaTime)

	return
end

function var_0_0.SetCurrentIkTimelineStatus(arg_56_0, arg_56_1)
	arg_56_0.currentIkTimelineStatus = arg_56_1

	return
end

function var_0_0.CheckIkTimelineStatus(arg_57_0, arg_57_1)
	if not arg_57_0.currentIkTimelineStatus then
		return true
	end

	return arg_57_0.currentIkTimelineStatus ~= arg_57_1
end

function var_0_0.SetCollisible(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0.ladyCollider:GetComponent(typeof(UnityEngine.CapsuleCollider))

	if arg_58_1 then
		var_58_0.excludeLayers = LayerMask.GetMask("Nothing")
		arg_58_0.characterController.excludeLayers = LayerMask.GetMask("Nothing")
	else
		var_58_0.excludeLayers = LayerMask.GetMask("Player")
		arg_58_0.characterController.excludeLayers = LayerMask.GetMask("Player")
	end

	return
end

function var_0_0.EnableCharacterTransparency(arg_59_0, arg_59_1)
	arg_59_0.transparencyComp.Enable = arg_59_1

	return
end

function var_0_0.BlockCanWatch(arg_60_0, arg_60_1)
	arg_60_0.blockCanWatch = arg_60_1

	return
end

function var_0_0.SetPosition(arg_61_0, arg_61_1)
	arg_61_0.lady.position = arg_61_1

	return
end

function var_0_0.SetRotation(arg_62_0, arg_62_1)
	arg_62_0.lady.rotation = arg_62_1

	return
end

return var_0_0
