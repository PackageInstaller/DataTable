class = var_0_10000

local var_0_0 = "LadyEnv"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Core.BaseLadyEnv"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.super.Ctor(arg_1_0, arg_1_1.event, arg_1_1)

	return
end

function var_0_1.InitCharacter(arg_2_0, arg_2_1)
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

function var_0_1.InitCharacterRoot(arg_3_0)
	arg_3_0.lady = arg_3_0.ladyGameObject.transform

	local var_3_0 = arg_3_0.lady

	var_1.SetParent(var_3_0, arg_3_0:Get("mainCameraTF"))

	local var_3_1 = arg_3_0.lady

	var_1.SetParent(var_3_1, nil)

	return
end

function var_0_1.InitCharacterAimIK(arg_4_0)
	local var_4_0 = arg_4_0.lady
	local var_4_1 = var_1.GetComponent

	typeof = var_1_10004
	HeadAimIK = var_1_10006
	arg_4_0.ladyHeadIKComp = var_4_1(var_4_0, var_1_10004(var_1_10006))

	local var_4_2 = arg_4_0.ladyHeadIKComp
	local var_4_3 = arg_4_0:Get("mainCameraTF")

	var_4_2.AimTarget = var_2.Find(var_4_3, "AimTarget")
	arg_4_0.ladyHeadIKData = {
		DampTime = arg_4_0.ladyHeadIKComp.DampTime,
		blinkSpeed = arg_4_0.ladyHeadIKComp.blinkSpeed,
		BodyWeight = arg_4_0.ladyHeadIKComp.BodyWeight,
		HeadWeight = arg_4_0.ladyHeadIKComp.HeadWeight
	}

	return
end

function var_0_1.InitCharacterAnimator(arg_5_0)
	local var_5_0 = arg_5_0.lady
	local var_5_1 = var_1.GetComponent

	typeof = var_1_10004
	Animator = var_1_10006
	arg_5_0.ladyAnimator = var_5_1(var_5_0, var_1_10004(var_1_10006))

	local var_5_2 = arg_5_0.ladyAnimator

	arg_5_0.ladyAnimBaseLayerIndex = var_1.GetLayerIndex(var_5_2, "Base Layer")

	local var_5_3 = arg_5_0.ladyAnimator

	arg_5_0.ladyAnimFaceLayerIndex = var_1.GetLayerIndex(var_5_3, "Face")

	return
end

function var_0_1.InitCharacterHierarchy(arg_6_0)
	local var_6_0 = {}

	table = var_1_10002

	local var_6_1 = var_1_10002.Foreach

	DormConst = var_1_10004

	var_6_1(var_1_10004.boneMap, function(arg_7_0, arg_7_1)
		var_6_0[arg_7_1] = arg_7_0

		return
	end)

	arg_6_0.ladyBoneMaps = {}

	local var_6_2 = arg_6_0.lady
	local var_6_3 = var_2.GetComponentsInChildren

	typeof = var_5
	Transform = var_1_10007

	local var_6_4 = var_6_3(var_6_2, var_5(var_1_10007), true)

	table = var_1_10003

	var_1_10003.IpairsCArray(var_6_4, function(arg_8_0, arg_8_1)
		if arg_8_1.name == "BodyCollider" then
			local var_8_0 = arg_6_0

			var_8_0.ladyCollider = arg_8_1
			setActive = var_8_0

			var_8_0(arg_8_1, true)
		elseif arg_8_1.name == "SafeCollider" then
			local var_8_1 = arg_6_0

			var_8_1.ladySafeCollider = arg_8_1
			setActive = var_8_1

			var_8_1(arg_8_1, false)
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

function var_0_1.InitCharacterCollider(arg_9_0)
	arg_9_0.ladyColliders = {}
	arg_9_0.ladyTouchColliders = {}
	table = var_1

	local var_9_0 = var_1.IpairsCArray
	local var_9_1 = arg_9_0.lady
	local var_9_2 = var_3.GetComponentsInChildren

	typeof = var_1_10006
	UnityEngine = var_1_10008

	var_9_0(var_9_2(var_9_1, var_1_10006(var_1_10008.Collider), true), function(arg_10_0, arg_10_1)
		local var_10_0 = arg_10_1:GetType()
		local var_10_1 = var_2.Equals

		typeof = var_2_10005
		UnityEngine = var_2_10007

		if var_10_1(var_10_0, var_2_10005(var_2_10007.MeshCollider)) then
			return
		end

		tf = var_2

		if var_2(arg_10_1).name then
			string = var_4

			local var_10_2

			if not var_4.find(var_3, "Collider") then
				var_10_2 = -1
			end

			string = var_5

			local var_10_3 = var_5.sub(var_3, 1, var_10_2 - 1)

			DormConst = var_2_10006

			if var_2_10006.BONE_TO_TOUCH[var_10_3] == nil then
				return
			end

			local var_10_4 = arg_9_0.ladyColliders

			var_10_4[var_10_3] = var_2
			table = var_10_4

			var_10_4.insert(arg_9_0.ladyTouchColliders, var_2)

			setActive = var_6

			var_6(var_2, false)

			return
		end
	end)

	return
end

function var_0_1.InitCharacterCloth(arg_11_0)
	arg_11_0.clothComps = {}
	arg_11_0.ladyClothCompSettings = {}
	table = var_1

	local var_11_0 = var_1.IpairsCArray
	local var_11_1 = arg_11_0.lady
	local var_11_2 = var_3.GetComponentsInChildren

	typeof = var_1_10006

	var_11_0(var_11_2(var_11_1, var_1_10006("MagicaCloth2.MagicaCloth"), true), function(arg_12_0, arg_12_1)
		table = var_2_10002

		var_2_10002.insert(arg_11_0.clothComps, arg_12_1)

		arg_11_0.ladyClothCompSettings[arg_12_1] = {
			enabled = arg_12_1.enabled
		}

		return
	end)

	arg_11_0.clothColliderDict = {}
	arg_11_0.ladyClothColliderSettings = {}
	typeof = var_1

	local var_11_3 = var_1("MagicaCloth2.MagicaCapsuleCollider")

	table = var_1_10002

	local var_11_4 = var_1_10002.IpairsCArray
	local var_11_5 = arg_11_0.lady

	var_11_4(var_4.GetComponentsInChildren(var_11_5, var_11_3, true), function(arg_13_0, arg_13_1)
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

function var_0_1.InitCharacterIKRoot(arg_14_0)
	local var_14_0 = arg_14_0.lady

	arg_14_0.ladyIKRoot = var_1.Find(var_14_0, "IKLayers")
	eachChild = var_1

	var_1(arg_14_0.ladyIKRoot, function(arg_15_0)
		setActive = var_2_10001

		var_2_10001(arg_15_0, false)

		return
	end)

	return
end

function var_0_1.InitCharacterTouchEvent(arg_16_0, arg_16_1)
	GetComponent = var_1_10002

	local var_16_0 = arg_16_0.lady

	typeof = var_1_10005
	EventTriggerListener = var_1_10007

	local var_16_1 = var_1_10002(var_16_0, var_1_10005(var_1_10007))

	var_2.AddPointClickFunc(var_16_1, function(arg_17_0, arg_17_1)
		if arg_17_1.rawPointerPress.transform == arg_16_0.ladyCollider then
			local var_17_0 = arg_16_0
			local var_17_1 = var_2.Emit

			Dorm3dRoomTemplateScene = var_2_10005

			var_17_1(var_17_0, var_2_10005.CLICK_CHARACTER, arg_16_1)
		end

		return
	end)

	return
end

function var_0_1.InitCharacterAnimationEvent(arg_18_0)
	local var_18_0 = arg_18_0.ladyAnimator
	local var_18_1 = var_1.GetComponent(var_18_0, "DftAniEvent")

	var_1.SetCommonEvent(var_18_1, function(arg_19_0)
		if arg_18_0.nowState then
			local var_19_0 = arg_19_0.animatorStateInfo

			if var_1.IsName(var_19_0, arg_18_0.nowState) then
				existCall = var_1

				var_1(arg_18_0.stateCallback)

				return
			end
		end

		local var_19_1 = arg_19_0.animatorStateInfo

		pairs = var_2_10002

		for iter_19_0, iter_19_1 in var_2_10002(arg_18_0.animCallbacks) do
			if var_19_1:IsName(iter_19_0) then
				warning = var_7

				var_7("Active", iter_19_0)

				table = var_7

				local var_19_2 = var_7.removebykey(arg_18_0.animCallbacks, iter_19_0)

				existCall = var_2_10008

				var_2_10008(var_19_2)

				return
			end
		end

		if arg_19_0.stringParameter ~= "" then
			local var_19_3 = arg_18_0

			var_2.Func(var_19_3, "OnAnimationEvent", arg_19_0)
		end

		return
	end)

	arg_18_0.animEventCallbacks = {}
	arg_18_0.animCallbacks = {}

	return
end

function var_0_1.InitCharacterEffects(arg_20_0)
	local function var_20_0(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_20_0
		local var_21_1 = var_3.Get(var_21_0, "loader")

		var_3.GetPrefab(var_21_1, arg_21_0, arg_21_1, function(arg_22_0)
			arg_22_0.name = arg_21_2

			local var_22_0 = arg_20_0
			local var_22_1 = arg_21_2

			tf = var_3_10003
			var_22_0[var_22_1] = var_3_10003(arg_22_0)
			setActive = var_22_0

			var_22_0(arg_22_0, false)

			onNextTick = var_22_0

			var_22_0(function()
				setParent = var_4_10000

				var_4_10000(arg_20_0[arg_21_2], arg_20_0.ladyHeadCenter)

				return
			end)

			return
		end)

		return
	end

	local var_20_1 = arg_20_0.ladyHeadCenter

	arg_20_0.effectHeart = var_2.Find(var_20_1, "effectHeart")

	if not arg_20_0.effectHeart then
		var_20_0("dorm3d/effect/prefab/function/vfx_function_aixin02", "vfx_function_aixin02", "effectHeart")
	end

	local var_20_2 = arg_20_0.ladyHeadCenter

	arg_20_0.ladyWatchFloat = var_2.Find(var_20_2, "ladyWatchFloat")

	if not arg_20_0.ladyWatchFloat then
		var_20_0("dorm3d/effect/prefab/function/vfx_talk_mark", "vfx_talk_mark", "ladyWatchFloat")
	end

	if arg_20_0.tfPendintItem then
		onNextTick = var_2

		var_2(function()
			setParent = var_2_10000

			var_2_10000(arg_20_0.tfPendintItem, arg_20_0.lady)

			return
		end)
	end

	return
end

function var_0_1.InitCharacterBlackboard(arg_25_0, arg_25_1)
	GetComponent = var_1_10002
	arg_25_0.ladyOwner = var_1_10002(arg_25_0.lady, "GraphOwner")
	GetComponent = var_2
	arg_25_0.ladyBlackboard = var_2(arg_25_0.lady, "Blackboard")

	arg_25_0:SetBlackboardValue("groupId", arg_25_1)

	onNextTick = var_2

	var_2(function()
		arg_25_0.ladyOwner.enabled = true

		return
	end)

	return
end

function var_0_1.InitCharacterLayer(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.ViewUtils.SetLayer
	local var_27_1 = arg_27_0.lady

	Layer = var_1_10004

	var_27_0(var_27_1, var_1_10004.Character3D)

	return
end

function var_0_1.InitCharacterController(arg_28_0)
	GetOrAddComponent = var_1_10001

	local var_28_0 = arg_28_0.ladyGameObject

	typeof = var_1_10004
	CharacterController = var_1_10006
	arg_28_0.characterController = var_1_10001(var_28_0, var_1_10004(var_1_10006))
	arg_28_0.characterController.enabled = false

	local var_28_1 = arg_28_0.characterController

	DormConst = var_2
	var_28_1.center = var_2.CHARACTER_CONTROLLER.center

	local var_28_2 = arg_28_0.characterController

	DormConst = var_2
	var_28_2.radius = var_2.CHARACTER_CONTROLLER.radius

	local var_28_3 = arg_28_0.characterController

	DormConst = var_2
	var_28_3.height = var_2.CHARACTER_CONTROLLER.height

	local var_28_4 = arg_28_0.characterController

	DormConst = var_2
	var_28_4.stepOffset = var_2.CHARACTER_CONTROLLER.stepOffset

	return
end

function var_0_1.InitCharacterTransparency(arg_29_0)
	GetOrAddComponent = var_1_10001

	local var_29_0 = arg_29_0.lady

	typeof = var_1_10004
	CharacterTransparency = var_1_10006
	arg_29_0.transparencyComp = var_1_10001(var_29_0, var_1_10004(var_1_10006))
	arg_29_0.transparencyComp.player = arg_29_0:Get("player")

	local var_29_1 = arg_29_0.transparencyComp

	DormConst = var_2
	var_29_1.minDistance = var_2.TRANSPARENCY_MIN_DISTANCE

	local var_29_2 = arg_29_0.transparencyComp

	DormConst = var_2
	var_29_2.maxDistance = var_2.TRANSPARENCY_MAX_DISTANCE

	return
end

function var_0_1.InitCharacterAnimationDispatcher(arg_30_0)
	GetOrAddComponent = var_1_10001

	local var_30_0 = arg_30_0.lady

	typeof = var_1_10004
	DormAnimationEventDispatcher = var_1_10006
	arg_30_0.animationEventDispatcher = var_1_10001(var_30_0, var_1_10004(var_1_10006))
	arg_30_0.animationEventDispatcher.listenLayer = arg_30_0.ladyAnimBaseLayerIndex

	return
end

function var_0_1.SetZone(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.ladyBaseZone = arg_31_1
	arg_31_0.ladyActiveZone = arg_31_2 or arg_31_1

	return
end

function var_0_1.SwitchCharacterSkin(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = arg_32_0.skinIdList

	assert = var_1_10005
	table = var_1_10007

	var_1_10005(var_1_10007.contains(var_32_0, arg_32_2))

	local var_32_1 = arg_32_0:GetCurrentAnim()
	local var_32_2 = arg_32_0.skinId
	local var_32_3 = arg_32_0:Get("skinDict")[var_32_2].ladyGameObject.transform.position
	local var_32_4 = var_7.transform.rotation
	local var_32_5 = arg_32_0.ladyBlackboard

	setActive = var_1_10011

	var_1_10011(var_7, false)

	arg_32_0.skinId = arg_32_2
	setActive = var_1_10011

	var_1_10011(arg_32_0:Get("skinDict")[arg_32_2].ladyGameObject, true)

	arg_32_0.ladyGameObject = arg_32_0:Get("skinDict")[arg_32_2].ladyGameObject
	arg_32_0.ladyCollider = nil

	arg_32_0:InitCharacter(arg_32_1)

	pg = var_11

	local var_32_6 = var_11.NodeCanvasMgr.GetInstance()

	var_11.CopyAllBlackBoardValue(var_32_6, var_32_5, arg_32_0.ladyBlackboard)

	local var_32_7 = arg_32_0.ladyAnimator

	var_11.Play(var_32_7, var_32_1, arg_32_0.ladyAnimBaseLayerIndex)

	local var_32_8 = arg_32_0.ladyAnimator

	var_11.Update(var_32_8, 0)

	local var_32_9 = arg_32_0.lady

	var_11.SetPositionAndRotation(var_32_9, var_32_3, var_32_4)
	arg_32_0:Func("InitHolyLight")

	existCall = var_11

	var_11(arg_32_3)

	return
end

function var_0_1.SetBlackboardValue(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0

	if not arg_33_0.blackboard then
		var_33_0 = {}
	end

	arg_33_0.blackboard = var_33_0

	local var_33_1 = arg_33_0.blackboard

	var_33_1[arg_33_1] = arg_33_2
	pg = var_33_1

	local var_33_2 = var_33_1.NodeCanvasMgr.GetInstance()

	var_3.SetBlackboradValue(var_33_2, arg_33_1, arg_33_2, arg_33_0.ladyBlackboard)

	return
end

function var_0_1.GetBlackboardValue(arg_34_0, arg_34_1)
	local var_34_0

	if not arg_34_0.blackboard then
		var_34_0 = {}
	end

	arg_34_0.blackboard = var_34_0

	return arg_34_0.blackboard[arg_34_1]
end

function var_0_1.GetCurrentAnim(arg_35_0)
	local var_35_0 = arg_35_0.ladyAnimator

	return var_1.GetCurrentAnimatorStateInfo(var_35_0, arg_35_0.ladyAnimBaseLayerIndex).shortNameHash
end

function var_0_1.EnableCloth(arg_36_0, arg_36_1, arg_36_2)
	arg_36_1 = arg_36_1 or {}
	table = var_1_10003

	var_1_10003.Foreach(arg_36_0.clothComps, function(arg_37_0, arg_37_1)
		if arg_37_1 == nil then
			return
		end

		setActive = var_2_10002

		var_2_10002(arg_37_1, arg_36_1[arg_37_0] == 1)

		return
	end)

	table = var_3

	var_3.Foreach(arg_36_0.clothColliderDict, function(arg_38_0, arg_38_1)
		if arg_38_1 == nil then
			return
		end

		setActive = var_2_10002

		var_2_10002(arg_38_1, false)

		return
	end)

	if arg_36_2 then
		table = var_3

		var_3.Foreach(arg_36_2, function(arg_39_0, arg_39_1)
			if arg_36_0.clothColliderDict[arg_39_1[1]] == nil then
				return
			end

			setActive = var_3

			var_3(var_2, arg_39_1[2] == 1)

			if arg_39_1[2] ~= 1 then
				return
			end

			var_0_1.SetMagicaCollider(var_2, arg_39_1[3], arg_39_1[4])

			return
		end)
	end

	return
end

function var_0_1.PlaySingleAction(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	warning = var_1_10004

	var_1_10004("Play", arg_40_1)

	string = var_1_10004

	local var_40_0 = var_1_10004.find(arg_40_1, "^Face_")

	tobool = var_1_10005

	local var_40_2

	if not var_1_10005(var_40_0) then
		string = var_6

		local var_40_1 = var_6.find(arg_40_1, "^face_")

		tobool = var_6
		var_40_2 = var_6(var_40_1)
	end

	if var_40_2 then
		arg_40_0:PlayFaceAnim(arg_40_1, arg_40_2)

		return
	end

	local var_40_3 = arg_40_0.ladyAnimator
	local var_40_4 = var_6.GetCurrentAnimatorStateInfo(var_40_3, arg_40_0.ladyAnimBaseLayerIndex)

	if var_6.IsName(var_40_4, arg_40_1) then
		return
	end

	existCall = var_6

	var_6(arg_40_0.animExtraItemCallback)

	arg_40_0.animExtraItemCallback = nil

	local var_40_5 = arg_40_0
	local var_40_6 = arg_40_0.GetBlackboardValue(var_40_5, "groupId")

	_ = var_7

	local var_40_7 = var_7.detect

	pg = var_9

	local var_40_8

	if not var_9.dorm3d_anim_extraitem.get_id_list_by_ship_id[var_40_6] then
		var_40_8 = {}
	end

	if var_40_7(var_40_8, function(arg_41_0)
		pg = var_2_10001

		return var_2_10001.dorm3d_anim_extraitem[arg_41_0].anim == arg_40_1
	end) then
		::label_40_0::

		pg = var_40_5
		var_40_5 = var_40_5.dorm3d_anim_extraitem[var_7]
	end

	local var_40_9

	if not arg_40_3 then
		DormConst = var_10
		arg_40_3 = var_10.DEFAULT_ANIM_FADE_IN_TIME
	end

	seriesAsync = var_10

	var_10({
		function(arg_42_0)
			if not var_40_5 or var_40_5.item_prefab == "" then
				arg_42_0()

				return
			end

			string = var_1

			local var_42_0 = var_1.lower("dorm3d/furniture/item/" .. var_40_5.item_prefab)
			local var_42_1 = arg_40_0
			local var_42_2 = var_2.Get(var_42_1, "loader")

			var_2.GetPrefab(var_42_2, var_42_0, "", function(arg_43_0)
				setParent = var_3_10001

				var_3_10001(arg_43_0, arg_40_0.lady)

				if var_40_5.item_shield ~= "" then
					var_40_9 = {}
					ipairs = var_1

					for iter_43_0, iter_43_1 in var_1(var_40_5.item_shield) do
						local var_43_0 = arg_40_0
						local var_43_1 = var_6.Get(var_43_0, "modelRoot")

						if not var_6.Find(var_43_1, iter_43_1) then
							warning = var_3_10007
							string = var_9

							var_3_10007(var_9.format("dorm3d_anim_extraitem:%d without hide item:%s", var_40_5.id, iter_43_1))
						else
							var_3_10007 = var_40_9
							isActive = var_43_1
							var_3_10007[iter_43_1] = var_43_1(var_6)
							setActive = var_3_10007

							var_3_10007(var_6, false)
						end
					end
				end

				function arg_40_0.animExtraItemCallback()
					local var_44_0 = arg_40_0
					local var_44_1 = var_0.Get(var_44_0, "loader")

					var_0.ClearRequest(var_44_1, "AnimExtraItem")

					if var_40_9 then
						pairs = var_0

						for iter_44_0, iter_44_1 in var_0(var_40_9) do
							setActive = var_4_10005

							local var_44_2 = arg_40_0
							local var_44_3 = var_7.Get(var_44_2, "modelRoot")

							var_4_10005(var_7.Find(var_44_3, iter_44_0), iter_44_1)
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

			local var_45_0 = arg_40_0

			var_45_0.stateCallback = arg_45_0
			IsUnityEditor = var_45_0

			if var_45_0 then
				local var_45_1 = arg_40_0.ladyAnimator
				local var_45_2 = var_1.HasState
				local var_45_3 = arg_40_0.ladyAnimBaseLayerIndex

				Animator = var_2_10005

				if not var_45_2(var_45_1, var_45_3, var_2_10005.StringToHash(arg_40_1)) then
					errorMsg = var_1

					var_1("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_40_1)
				end
			end

			local var_45_4 = arg_40_0.ladyAnimator

			var_1.CrossFadeInFixedTime(var_45_4, arg_40_1, arg_40_3, arg_40_0.ladyAnimBaseLayerIndex)

			return
		end,
		function(arg_46_0)
			arg_40_0.nowState = nil

			local var_46_0 = arg_40_0

			var_46_0.stateCallback = nil
			existCall = var_46_0

			var_46_0(arg_40_0.animExtraItemCallback)

			arg_40_0.animExtraItemCallback = nil

			arg_46_0()

			return
		end,
		arg_40_2
	})

	return
end

function var_0_1.PlayFaceAnim(arg_47_0, arg_47_1, arg_47_2)
	IsUnityEditor = var_1_10003

	if var_1_10003 then
		local var_47_0 = arg_47_0.ladyAnimator
		local var_47_1 = var_3.HasState
		local var_47_2 = arg_47_0.ladyAnimFaceLayerIndex

		Animator = var_1_10007

		if not var_47_1(var_47_0, var_47_2, var_1_10007.StringToHash(arg_47_1)) then
			errorMsg = var_3

			var_3("！！！！！！！！动画不存在>>>>>>>>>>>>>", arg_47_1)
		end
	end

	local var_47_3 = arg_47_0.ladyAnimator

	var_3.CrossFadeInFixedTime(var_47_3, arg_47_1, 0, arg_47_0.ladyAnimFaceLayerIndex)

	existCall = var_3

	var_3(arg_47_2)

	return
end

function var_0_1.SwitchAnim(arg_48_0, arg_48_1, arg_48_2)
	string = var_1_10003

	local var_48_0 = var_1_10003.find(arg_48_1, "^Face_")

	tobool = var_1_10004

	if var_1_10004(var_48_0) then
		arg_48_0:PlayFaceAnim(arg_48_1, arg_48_2)

		return
	end

	existCall = var_5

	var_5(arg_48_0.animExtraItemCallback)

	arg_48_0.animExtraItemCallback = nil

	local var_48_1 = {}

	table = var_6

	var_6.insert(var_48_1, function(arg_49_0)
		arg_48_0.nowState = arg_48_1
		arg_48_0.stateCallback = arg_49_0

		local var_49_0 = arg_48_0.ladyAnimator

		var_1.PlayInFixedTime(var_49_0, arg_48_1, arg_48_0.ladyAnimBaseLayerIndex)

		return
	end)

	table = var_6

	var_6.insert(var_48_1, function(arg_50_0)
		arg_48_0.nowState = nil
		arg_48_0.stateCallback = nil

		arg_50_0()

		return
	end)

	seriesAsync = var_6

	var_6(var_48_1, arg_48_2)

	return
end

function var_0_1.RevertClothComps(arg_51_0)
	table = var_1_10001

	var_1_10001.Foreach(arg_51_0.ladyClothCompSettings, function(arg_52_0, arg_52_1)
		arg_52_0.enabled = arg_52_1.enabled

		return
	end)

	table = var_1

	var_1.Foreach(arg_51_0.ladyClothColliderSettings, function(arg_53_0, arg_53_1)
		arg_53_0.enabled = arg_53_1.enabled

		var_0_1.SetMagicaCollider(arg_53_0, arg_53_1.StartRadius, arg_53_1.EndRadius)

		return
	end)

	return
end

function var_0_1.SetMagicaCollider(arg_54_0, arg_54_1, arg_54_2)
	typeof = var_1_10003

	local var_54_0 = var_1_10003("MagicaCloth2.MagicaCapsuleCollider")
	local var_54_1 = arg_54_0:GetSize()

	var_54_1.x = arg_54_1
	var_54_1.y = arg_54_2

	arg_54_0:SetSize(var_54_1)

	return
end

function var_0_1.MoveToTarget(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	if not arg_55_2 then
		DormConst = var_1_10004
		arg_55_2 = var_1_10004.LADY_MOVE_SPEED
	end

	if not arg_55_3 then
		DormConst = var_1_10004
		arg_55_3 = var_1_10004.LADY_ROTATE_SPEED
	end

	local var_55_0 = arg_55_1 - arg_55_0.lady.position

	var_55_0.y = 0
	Vector3 = var_5

	if var_55_0 ~= var_5.zero then
		Quaternion = var_5

		local var_55_1 = var_5.LookRotation(var_55_0)
		local var_55_2 = arg_55_0.lady

		Quaternion = var_7

		local var_55_3 = var_7.Slerp

		var_1_10009 = arg_55_0.lady.rotation

		local var_55_4 = var_55_1

		Time = var_1_10011
		var_55_2.rotation = var_55_3(var_1_10009, var_55_4, var_1_10011.deltaTime * arg_55_3)
	end

	local var_55_5 = var_55_0.normalized * arg_55_2
	local var_55_6 = arg_55_0.characterController
	local var_55_7 = var_6.Move

	Time = var_1_10009

	var_55_7(var_55_6, var_55_5 * var_1_10009.deltaTime)

	return
end

function var_0_1.SetCurrentIkTimelineStatus(arg_56_0, arg_56_1)
	arg_56_0.currentIkTimelineStatus = arg_56_1

	return
end

function var_0_1.CheckIkTimelineStatus(arg_57_0, arg_57_1)
	if not arg_57_0.currentIkTimelineStatus then
		return true
	end

	return arg_57_0.currentIkTimelineStatus ~= arg_57_1
end

function var_0_1.SetCollisible(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0.ladyCollider
	local var_58_1 = var_2.GetComponent

	typeof = var_1_10005
	UnityEngine = var_1_10007

	local var_58_2 = var_58_1(var_58_0, var_1_10005(var_1_10007.CapsuleCollider))

	if arg_58_1 then
		LayerMask = var_1_10003
		var_58_2.excludeLayers = var_1_10003.GetMask("Nothing")
		var_1_10003 = arg_58_0.characterController
		LayerMask = var_58_0
		var_1_10003.excludeLayers = var_58_0.GetMask("Nothing")
	else
		LayerMask = var_1_10003
		var_58_2.excludeLayers = var_1_10003.GetMask("Player")

		local var_58_3 = arg_58_0.characterController

		LayerMask = var_58_0
		var_58_3.excludeLayers = var_58_0.GetMask("Player")
	end

	return
end

function var_0_1.EnableCharacterTransparency(arg_59_0, arg_59_1)
	arg_59_0.transparencyComp.Enable = arg_59_1

	return
end

function var_0_1.BlockCanWatch(arg_60_0, arg_60_1)
	arg_60_0.blockCanWatch = arg_60_1

	return
end

function var_0_1.SetPosition(arg_61_0, arg_61_1)
	arg_61_0.lady.position = arg_61_1

	return
end

function var_0_1.SetRotation(arg_62_0, arg_62_1)
	arg_62_0.lady.rotation = arg_62_1

	return
end

return var_0_1
