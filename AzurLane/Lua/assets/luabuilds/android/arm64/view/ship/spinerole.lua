class = var_0_10000

local var_0_0 = var_0_10000("SpineRole")

var_0_0.STATE_EMPTY = 0
var_0_0.STATE_LOADING = 1
var_0_0.STATE_INITED = 2
var_0_0.STATE_DISPOSE = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.state = var_0_0.STATE_EMPTY

	if arg_1_1 then
		arg_1_0.ship = arg_1_1

		local var_1_0 = arg_1_0.ship

		arg_1_0.prefabName = var_3.getPrefab(var_1_0, arg_1_2)
	end

	return
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.prefabName = arg_2_1
	arg_2_0.attachmentData = arg_2_2

	return
end

var_0_0.ORBIT_KEY_UI = "orbit_ui"
var_0_0.ORBIT_KEY_SLG = "orbit_slg"

function var_0_0.Load(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 == nil then
		arg_3_2 = true
	end

	PoolMgr = var_1_10004

	local var_3_0 = var_1_10004.GetInstance()

	var_4.GetSpineChar(var_3_0, arg_3_0.prefabName, arg_3_2, function(arg_4_0)
		assert = var_2_10001

		var_2_10001(arg_4_0, "没有这个角色的模型  " .. arg_3_0.prefabName)

		if arg_3_0.state == var_0_0.STATE_DISPOSE then
			PoolMgr = var_1

			local var_4_0 = var_1.GetInstance()

			var_1.ReturnSpineChar(var_4_0, arg_3_0.prefabName, arg_4_0)
		else
			local var_4_1 = arg_3_0

			GameObject = var_2
			var_4_1._modelRoot = var_2.New(arg_3_0.prefabName .. "_root")

			local var_4_2 = arg_3_0._modelRoot
			local var_4_3 = var_1.AddComponent

			typeof = var_4
			RectTransform = var_2_10006

			var_4_3(var_4_2, var_4(var_2_10006))

			arg_3_0._model = arg_4_0

			local var_4_4 = arg_3_0

			var_1.Init(var_4_4)

			local var_4_5 = arg_3_0
			local var_4_6 = var_1.SetLocalScale

			Vector3 = var_4

			var_4_6(var_4_5, var_4.one)

			local var_4_7 = arg_3_0
			local var_4_8 = var_1.SetModelScale

			Vector3 = var_4

			var_4_8(var_4_7, var_4.one)

			local var_4_9 = arg_3_0._model.transform

			var_1.SetParent(var_4_9, arg_3_0._modelRoot.transform, false)

			local var_4_10 = arg_3_0._model.transform

			Vector3 = var_2
			var_4_10.localPosition = var_2.zero
			setActive = var_4_10

			var_4_10(arg_3_0._model.transform, true)

			if arg_3_1 then
				arg_3_1()
			end

			local var_4_11 = arg_3_0

			var_1.AttachOrbit(var_4_11, arg_3_3)

			local var_4_12 = arg_3_0

			var_1.sortAttachmentGO(var_4_12)
		end

		return
	end)

	return
end

function var_0_0.LoadLite(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == nil then
		arg_5_2 = true
	end

	PoolMgr = var_1_10003

	local var_5_0 = var_1_10003.GetInstance()

	var_3.GetSpineChar(var_5_0, arg_5_0.prefabName, arg_5_2, function(arg_6_0)
		assert = var_2_10001

		var_2_10001(arg_6_0, "没有这个角色的模型  " .. arg_5_0.prefabName)

		if arg_5_0.state == var_0_0.STATE_DISPOSE then
			PoolMgr = var_1

			local var_6_0 = var_1.GetInstance()

			var_1.ReturnSpineChar(var_6_0, arg_5_0.prefabName, arg_6_0)
		else
			arg_5_0._modelRoot = arg_6_0
			arg_5_0._model = arg_6_0

			local var_6_1 = arg_5_0

			var_1.Init(var_6_1)

			local var_6_2 = arg_5_0
			local var_6_3 = var_1.SetLocalScale

			Vector3 = var_4

			var_6_3(var_6_2, var_4.one)

			local var_6_4 = arg_5_0
			local var_6_5 = var_1.SetModelScale

			Vector3 = var_4

			var_6_5(var_6_4, var_4.one)

			local var_6_6 = arg_5_0._model.transform

			Vector3 = var_2
			var_6_6.localPosition = var_2.zero

			if arg_5_1 then
				arg_5_1()
			end
		end

		return
	end)

	return
end

function var_0_0.Init(arg_7_0)
	arg_7_0.state = var_0_0.STATE_INITED
	arg_7_0._sortLayerCount = 0

	local var_7_0 = arg_7_0._model

	arg_7_0._modleGraphic = var_1.GetComponent(var_7_0, "SkeletonGraphic")

	local var_7_1 = arg_7_0._model

	arg_7_0._modleAnim = var_1.GetComponent(var_7_1, "SpineAnimUI")
	arg_7_0._attachmentList = {}
	arg_7_0._visible = true
	arg_7_0._orbitVisible = true

	return
end

function var_0_0.AttachOrbit(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or var_0_0.ORBIT_KEY_UI
	local var_8_1 = arg_8_0:GetAttachmentList()

	pairs = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10004(var_8_1) do
		local var_8_2 = iter_8_1.config
		local var_8_3 = iter_8_1.index
		local var_8_4 = var_8_2[var_8_0]

		if var_8_0 ~= var_0_0.ORBIT_KEY_UI and var_8_4 == "" then
			var_8_4 = var_8_2.orbit_ui
			var_8_0 = var_0_0.ORBIT_KEY_UI
		end

		if var_8_4 ~= "" then
			local var_8_5 = var_8_2.orbit_ui_bound[1]
			local var_8_7

			if arg_8_0.ship then
				local var_8_6 = arg_8_0.ship

				if var_13.IsDoubleSkin(var_8_6) then
					var_8_7 = true

					goto label_8_0
				end
			end

			var_8_7 = false

			::label_8_0::

			local var_8_8 = arg_8_0._modleGraphic.Skeleton
			local var_8_9 = var_14.FindBoneIndex(var_8_8, "char1_" .. var_8_5)
			local var_8_10 = arg_8_0._modleGraphic.Skeleton
			local var_8_11 = var_15.FindBoneIndex(var_8_10, "char2_" .. var_8_5)
			local var_8_12 = var_8_2.double_char_bone

			ys = var_8_10

			local var_8_13 = var_8_10.Battle.BattleResourceManager.GetOrbitPath(var_8_4)

			if var_8_7 and (var_8_9 >= 0 or var_8_11 > 0) or var_8_9 >= 0 and var_8_11 > 0 then
				if var_8_11 >= 0 and var_8_12 and #var_8_12 > 0 and var_8_12[1] == 1 then
					arg_8_0:loadOrbitUI(var_8_13, var_8_0, var_8_4, "char2" .. "_" .. var_8_5, var_8_3, var_8_2)
				end

				if var_8_12 and #var_8_12 > 0 and var_8_12[2] == 1 then
					arg_8_0:loadOrbitUI(var_8_13, var_8_0, var_8_4, var_8_5, var_8_3, var_8_2)
				end

				if var_8_9 >= 0 and var_8_12 and #var_8_12 > 0 and var_8_12[3] == 1 then
					arg_8_0:loadOrbitUI(var_8_13, var_8_0, var_8_4, "char1" .. "_" .. var_8_5, var_8_3, var_8_2)
				end
			else
				arg_8_0:loadOrbitUI(var_8_13, var_8_0, var_8_4, var_8_5, var_8_3, var_8_2)
			end
		end
	end

	return
end

function var_0_0.loadOrbitUI(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	ResourceMgr = var_1_10007

	local var_9_0 = var_1_10007.Inst
	local var_9_1 = var_7.getAssetAsync
	local var_9_2 = arg_9_1
	local var_9_3 = ""

	UnityEngine = var_1_10012

	var_9_1(var_9_0, var_9_2, var_9_3, var_1_10012.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
		tf = var_2_10001

		if var_2_10001(arg_10_0).childCount > 1 then
			for iter_10_0 = 1, var_1 do
				local var_10_0 = arg_9_0

				var_6.CreateOrbitUI(var_10_0, iter_10_0, arg_10_0, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
			end
		else
			local var_10_1 = arg_9_0

			var_2.CreateOrbitUI(var_10_1, 0, arg_10_0, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
		end

		return
	end), true, true)

	return
end

function var_0_0.CreateOrbitUI(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	if arg_11_0.state == var_0_0.STATE_DISPOSE then
		return
	end

	local var_11_0 = arg_11_7[arg_11_3 .. "_bound"][1]
	local var_11_1 = arg_11_7[var_8][2]

	Object = var_1_10011

	local var_11_2 = var_1_10011.Instantiate(arg_11_2)
	local var_11_3 = 0

	if arg_11_1 ~= 0 then
		for iter_11_0 = var_11_2.transform.childCount, 1, -1 do
			local var_11_4 = var_11_2.transform

			var_1_10018 = var_1_10018.GetChild(var_11_4, iter_11_0 - 1)

			if iter_11_0 ~= arg_11_1 then
				Destroy = var_1_10019

				var_1_10019(var_1_10018.gameObject)
			else
				local var_11_5 = var_1_10018

				var_1_10019 = var_1_10018.GetComponent
				typeof = var_1_10022
				Canvas = var_1_10024

				if var_1_10019(var_11_5, var_1_10022(var_1_10024)) then
					var_11_3 = var_1_10019.sortingOrder
					RemoveComponent = var_11_4

					var_11_4(var_1_10018.transform, "Canvas")
				end
			end
		end
	else
		local var_11_6 = var_11_2.transform

		var_1_10016 = var_13.GetChild(var_11_6, 0)
		var_1_10014 = var_13.GetComponent
		typeof = iter_11_0
		Canvas = var_1_10019

		if var_1_10014(var_1_10016, iter_11_0(var_1_10019)) then
			RemoveComponent = var_11_6

			var_11_6(var_13.transform, "Canvas")
		end
	end

	local var_11_7 = var_11_2
	local var_11_8 = var_11_2.GetComponentsInChildren

	typeof = var_1_10016
	Spine = var_1_10018

	local var_11_9 = var_11_8(var_11_7, var_1_10016(var_1_10018.Unity.SkeletonGraphic))
	local var_11_10 = var_13.ToTable(var_11_9)

	ipairs = var_1_10014

	for iter_11_1, iter_11_2 in var_1_10014(var_11_10) do
		iter_11_2.raycastTarget = false
	end

	local var_11_11 = var_11_2.transform

	Vector2 = var_15
	var_11_11.localPosition = var_15(var_11_1[1], var_11_1[2])

	local var_11_12 = var_11_2.transform

	Vector3 = var_15
	var_11_12.localScale = var_15.one
	SpineAnimUI = var_11_12

	local var_11_13 = var_11_12.AddFollower(arg_11_5, arg_11_0._model.transform, var_11_2.transform)

	arg_11_0._attachmentList[var_11_13] = {
		tf = var_11_2.transform,
		p = arg_11_4,
		hiddenActionList = arg_11_7.orbit_hidden_action,
		index = arg_11_6,
		back = arg_11_7.orbit_ui_back,
		sortOrder = var_11_3
	}

	local var_11_14 = var_11_13:GetComponent("Spine.Unity.BoneFollowerGraphic")

	var_11_14.followSkeletonFlip = false

	local var_11_15

	if arg_11_7.orbit_rotate_ui ~= "" and arg_11_7.orbit_rotate_ui == true then
		var_11_14.followBoneRotation = true
		var_11_15 = var_11_2.transform.localEulerAngles

		local var_11_16 = var_11_2.transform

		Vector3 = var_18
		var_11_16.localEulerAngles = var_18(var_11_15.x, var_11_15.y, var_11_15.z - 90)
	else
		var_11_14.followBoneRotation = false
	end

	if var_11_3 and var_11_3 < 0 then
		var_11_13:SetParent(arg_11_0._modelRoot.transform, false)
		var_11_13:SetAsFirstSibling()
	elseif var_11_3 and 0 < var_11_3 then
		var_11_13:SetParent(arg_11_0._modelRoot.transform, false)
		var_11_13:SetAsLastSibling()
	elseif arg_11_7.orbit_ui_back == 1 then
		var_11_13:SetParent(arg_11_0._modelRoot.transform, false)
		var_11_13:SetAsFirstSibling()
	else
		var_11_13:SetParent(arg_11_0._modelRoot.transform, false)
		var_11_13:SetAsLastSibling()
	end

	SetActive = var_11_15

	var_11_15(var_11_13, false)

	onNextTick = var_11_15

	var_11_15(function()
		SetActive = var_2_10000

		var_2_10000(var_11_13, arg_11_0._visible)

		return
	end)
	arg_11_0:sortAttachmentGO()

	return
end

function var_0_0.sortAttachmentGO(arg_13_0)
	local var_13_0 = {}

	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0._attachmentList) do
		table = var_1_10007

		var_1_10007.insert(var_13_0, {
			tf = iter_13_0,
			index = iter_13_1.index,
			back = iter_13_1.back,
			p = iter_13_1.p,
			sortOrder = iter_13_1.sortOrder
		})
	end

	table = var_2

	var_2.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.index < arg_14_1.index
	end)

	ipairs = var_2

	for iter_13_2, iter_13_3 in var_2(var_13_0) do
		if iter_13_3.back ~= 1 and iter_13_3.sortOrder == 0 then
			local var_13_1 = iter_13_3.tf

			var_7.SetAsLastSibling(var_13_1)

			break
		elseif iter_13_3.back == 1 and iter_13_3.sortOrder == 0 then
			local var_13_2 = iter_13_3.tf

			var_7.SetAsFirstSibling(var_13_2)
		end
	end

	return
end

function var_0_0.GetAttachmentList(arg_15_0)
	if arg_15_0.ship then
		local var_15_0 = arg_15_0.ship

		return var_1.getAttachmentPrefab(var_15_0)
	else
		local var_15_1

		if not arg_15_0.attachmentData then
			var_15_1 = {}
		end

		return var_15_1
	end

	return
end

function var_0_0.CheckInited(arg_16_0)
	return arg_16_0.state == var_0_0.STATE_INITED
end

function var_0_0.GetName(arg_17_0)
	if arg_17_0:CheckInited() then
		return arg_17_0._modelRoot.name
	end

	return
end

function var_0_0.SetName(arg_18_0, arg_18_1)
	if arg_18_0:CheckInited() then
		arg_18_0._modelRoot.name = arg_18_1
	end

	return
end

function var_0_0.GetRoleModel(arg_19_0)
	if arg_19_0:CheckInited() then
		return arg_19_0._model
	end

	return nil
end

function var_0_0.GetRootModel(arg_20_0)
	if arg_20_0:CheckInited() then
		return arg_20_0._modelRoot
	end

	return nil
end

function var_0_0.GetSpineAnimUI(arg_21_0)
	if arg_21_0:CheckInited() then
		return arg_21_0._modleAnim
	end

	return nil
end

function var_0_0.SetSiblingIndex(arg_22_0, arg_22_1)
	if arg_22_0:CheckInited() then
		local var_22_0 = arg_22_0._modelRoot.transform

		var_2.SetSiblingIndex(var_22_0, arg_22_1)
	end

	return
end

function var_0_0.SetParent(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0

	if arg_23_0.CheckInited(var_23_0) then
		SetParent = var_3
		tf = var_23_0

		local var_23_1 = var_23_0(arg_23_0._modelRoot)

		tf = var_1_10006

		var_3(var_23_1, var_1_10006(arg_23_1), arg_23_2 and true or false)
	end

	return
end

function var_0_0.SetRaycastTarget(arg_24_0, arg_24_1)
	if arg_24_0:CheckInited() then
		arg_24_0._modleGraphic.raycastTarget = arg_24_1
	end

	return
end

function var_0_0.GetSkeletonGraphic(arg_25_0)
	if arg_25_0:CheckInited() then
		return arg_25_0._modleGraphic
	end

	return
end

function var_0_0.ModifyName(arg_26_0, arg_26_1)
	if arg_26_0:CheckInited() then
		arg_26_0._modelRoot.name = arg_26_1
	end

	return
end

function var_0_0.SetOrbitVisible(arg_27_0, arg_27_1)
	if arg_27_0:CheckInited() then
		arg_27_0._orbitVisible = arg_27_1
		pairs = var_2

		for iter_27_0, iter_27_1 in var_2(arg_27_0._attachmentList) do
			SetActive = var_1_10007

			var_1_10007(iter_27_0, arg_27_1)
		end
	end

	return
end

function var_0_0.SetVisible(arg_28_0, arg_28_1)
	if arg_28_0:CheckInited() then
		arg_28_0._visible = arg_28_1
		arg_28_0._orbitVisible = arg_28_1

		local var_28_0 = arg_28_0._modleGraphic

		Color = var_1_10003
		var_28_0.color = var_1_10003.New(1, 1, 1, arg_28_1 and 1 or 0)
		pairs = var_28_0

		for iter_28_0, iter_28_1 in var_28_0(arg_28_0._attachmentList) do
			SetActive = var_7

			var_7(iter_28_0, arg_28_1)
		end
	end

	return
end

function var_0_0.SetAnchoredPosition3D(arg_29_0, arg_29_1)
	if arg_29_0:CheckInited() then
		arg_29_0._modelRoot.transform.anchoredPosition3D = arg_29_1
	end

	return
end

function var_0_0.SetAction(arg_30_0, arg_30_1)
	if not arg_30_0:CheckInited() then
		return
	end

	math = var_2

	local var_30_0 = var_2.sign(arg_30_0._rootScale.x)

	SpineAnimUtil = var_1_10003

	local var_30_1, var_30_2 = var_1_10003.GetCharAnimationDirect(arg_30_0._modleGraphic, var_30_0, arg_30_1)

	if var_30_2 then
		local var_30_3 = arg_30_0._model.transform

		Vector3 = var_6
		math = var_1_10008
		var_30_3.localScale = var_6(var_30_0 * var_1_10008.abs(arg_30_0._modelScale.x), arg_30_0._modelScale.y, arg_30_0._modelScale.z)
	else
		arg_30_0._model.transform.localScale = arg_30_0._modelScale
	end

	local var_30_4 = arg_30_0._modleAnim

	var_5.SetAction(var_30_4, var_30_1, 0)

	arg_30_0._action = arg_30_1

	arg_30_0:HiddenAttachmentByAction(arg_30_1)

	return
end

function var_0_0.SetActionOnce(arg_31_0, arg_31_1)
	if not arg_31_0:CheckInited() then
		return
	end

	local var_31_0 = arg_31_0._modleGraphic.AnimationState

	var_2.SetAnimation(var_31_0, 0, arg_31_1, false)
	arg_31_0:HiddenAttachmentByAction(arg_31_1)

	return
end

function var_0_0.SetActionCallBack(arg_32_0, arg_32_1)
	if not arg_32_0:CheckInited() then
		return
	end

	local var_32_0 = arg_32_0._modleAnim

	var_2.SetActionCallBack(var_32_0, function(arg_33_0)
		local var_33_0 = arg_32_0

		var_1.changeAttachLListVisible(var_33_0, arg_33_0)

		if arg_32_1 then
			arg_32_1(arg_33_0)
		end

		return
	end)

	return
end

function var_0_0.changeAttachLListVisible(arg_34_0, arg_34_1)
	local var_34_0

	if arg_34_1 == "skin_on" then
		var_34_0 = true
	elseif arg_34_1 == "skin_off" then
		var_34_0 = false
	else
		return
	end

	pairs = var_1_10003

	for iter_34_0, iter_34_1 in var_1_10003(arg_34_0._attachmentList) do
		SetActive = var_1_10008

		var_1_10008(iter_34_0, var_34_0)
	end

	return
end

function var_0_0.HiddenAttachmentByAction(arg_35_0, arg_35_1)
	pairs = var_1_10002

	for iter_35_0, iter_35_1 in var_1_10002(arg_35_0._attachmentList) do
		SetActive = var_1_10007

		local var_35_0 = iter_35_0

		table = var_1_10010
		var_1_10010 = not var_1_10010.contains(iter_35_1.hiddenActionList, arg_35_1) and arg_35_0._orbitVisible

		var_1_10007(var_35_0, var_1_10010)
	end

	return
end

function var_0_0.SetSizeDelta(arg_36_0, arg_36_1)
	if arg_36_0:CheckInited() then
		rtf = var_2
		var_2(arg_36_0._modelRoot).sizeDelta = arg_36_1
	end

	return
end

function var_0_0.SetModelScale(arg_37_0, arg_37_1)
	if arg_37_0:CheckInited() then
		arg_37_0._model.transform.localScale = arg_37_1
		arg_37_0._modelScale = arg_37_1
	end

	return
end

function var_0_0.SetLocalScale(arg_38_0, arg_38_1)
	if arg_38_0:CheckInited() then
		arg_38_0._rootScale = arg_38_1
		arg_38_0._modelRoot.transform.localScale = arg_38_1

		if arg_38_0._action then
			arg_38_0:SetAction(arg_38_0._action)
		end
	end

	return
end

function var_0_0.GetLocalScale(arg_39_0)
	if arg_39_0:CheckInited() then
		return arg_39_0._modelRoot.transform.localScale
	end

	return
end

function var_0_0.SetLocalPosition(arg_40_0, arg_40_1)
	if arg_40_0:CheckInited() then
		arg_40_0._modelRoot.transform.localPosition = arg_40_1
	end

	return
end

function var_0_0.SetAsFirstSibling(arg_41_0)
	if arg_41_0:CheckInited() then
		local var_41_0 = arg_41_0._modelRoot.transform

		var_1.SetAsFirstSibling(var_41_0)
	end

	return
end

function var_0_0.SetLayer(arg_42_0, arg_42_1)
	if arg_42_0:CheckInited() then
		pg = var_2

		var_2.ViewUtils.SetLayer(arg_42_0._modelRoot.transform, arg_42_1)
	end

	return
end

function var_0_0.TweenShining(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5, arg_43_6, arg_43_7, arg_43_8, arg_43_9, arg_43_10)
	if arg_43_0:CheckInited() then
		arg_43_0:StopTweenShining()

		local var_43_0 = arg_43_0._modleGraphic.material

		LeanTween = var_1_10012

		local var_43_1 = var_1_10012.value(arg_43_0._modelRoot, arg_43_3, arg_43_4, arg_43_1)
		local var_43_2 = var_12.setEase

		LeanTweenType = var_15

		local var_43_3 = var_43_2(var_43_1, var_15.easeInOutSine)
		local var_43_4 = var_12.setOnUpdate

		System = var_15

		local var_43_5 = var_43_4(var_43_3, var_15.Action_float(function(arg_44_0)
			local var_44_1

			if arg_43_7 then
				local var_44_0 = var_43_0

				var_44_1 = var_44_1.SetColor

				local var_44_2 = "_Color"

				Color = var_2_10005

				var_44_1(var_44_0, var_44_2, var_2_10005.Lerp(arg_43_5, arg_43_6, arg_44_0))
			else
				var_44_1 = arg_43_0._modleGraphic
				Color = var_2_10002
				var_44_1.color = var_2_10002.Lerp(arg_43_5, arg_43_6, arg_44_0)
			end

			existCall = var_44_1

			var_44_1(arg_43_9, arg_44_0)

			return
		end))
		local var_43_6 = var_12.setOnComplete

		System = var_15

		local var_43_7 = var_43_6(var_43_5, var_15.Action(function()
			arg_43_0._tweenShiningId = nil

			local var_45_1

			if arg_43_8 then
				if arg_43_7 then
					local var_45_0 = var_43_0

					var_45_1.SetColor(var_45_0, "_Color", arg_43_5)
				else
					var_45_1 = arg_43_0._modleGraphic
					var_45_1.color = arg_43_5
				end
			end

			existCall = var_45_1

			var_45_1(arg_43_10)

			return
		end))

		if arg_43_2 then
			var_43_7:setLoopPingPong(arg_43_2)
		end

		arg_43_0._tweenShiningId = var_43_7.uniqueId
	end

	return
end

function var_0_0.StopTweenShining(arg_46_0)
	if arg_46_0:CheckInited() and arg_46_0._tweenShiningId then
		LeanTween = var_1

		var_1.cancel(arg_46_0._tweenShiningId, true)

		arg_46_0._tweenShiningId = nil
	end

	return
end

function var_0_0.ChangeMaterial(arg_47_0, arg_47_1)
	if not arg_47_0:CheckInited() then
		return
	end

	if not arg_47_0._stageMaterial then
		arg_47_0._stageMaterial = arg_47_0._modleGraphic.material
	end

	arg_47_0._modleGraphic.material = arg_47_1

	return
end

function var_0_0.RevertMaterial(arg_48_0)
	if not arg_48_0:CheckInited() then
		return
	end

	if not arg_48_0._stageMaterial then
		return
	end

	arg_48_0._modleGraphic.material = arg_48_0._stageMaterial

	return
end

function var_0_0.CreateInterface(arg_49_0)
	GameObject = var_1_10001
	arg_49_0._mouseChild = var_1_10001("mouseChild")

	local var_49_0 = arg_49_0._mouseChild.transform

	var_1.SetParent(var_49_0, arg_49_0._modelRoot.transform, false)

	local var_49_1 = arg_49_0._mouseChild.transform

	Vector3 = var_1_10002
	var_49_1.localPosition = var_1_10002.zero
	GetOrAddComponent = var_49_1
	arg_49_0._modelClick = var_49_1(arg_49_0._mouseChild, "ModelDrag")
	GetOrAddComponent = var_1
	arg_49_0._modelPress = var_1(arg_49_0._mouseChild, "UILongPressTrigger")
	GetOrAddComponent = var_1
	arg_49_0._dragDelegate = var_1(arg_49_0._mouseChild, "EventTriggerListener")

	local var_49_2 = arg_49_0._modelClick

	var_1.Init(var_49_2)

	GetOrAddComponent = var_1

	local var_49_3 = arg_49_0._mouseChild

	typeof = var_4
	RectTransform = var_1_10006

	local var_49_4 = var_1(var_49_3, var_4(var_1_10006))

	Vector2 = var_2
	var_49_4.pivot = var_2(0.5, 0)
	Vector2 = var_2
	var_49_4.anchoredPosition = var_2(0, 0)
	Vector2 = var_2
	var_49_4.localScale = var_2(100, 100)
	Vector2 = var_2
	var_49_4.sizeDelta = var_2(3, 3)

	return arg_49_0._modelClick, arg_49_0._modelPress, arg_49_0._dragDelegate
end

function var_0_0.resumeRole(arg_50_0)
	if arg_50_0._modleAnim then
		local var_50_0 = arg_50_0._modleAnim

		if var_1.GetAnimationState(var_50_0) then
			local var_50_1 = arg_50_0._modleAnim

			var_1.Resume(var_50_1)
		end
	end

	return
end

function var_0_0.GetInterface(arg_51_0)
	return arg_51_0._modelClick, arg_51_0._modelPress, arg_51_0._dragDelegate
end

function var_0_0.EnableInterface(arg_52_0)
	local var_52_0 = arg_52_0._mouseChild
	local var_52_1 = var_1.GetComponent

	typeof = var_1_10004
	Image = var_1_10006
	var_52_1(var_52_0, var_1_10004(var_1_10006)).enabled = true

	return
end

function var_0_0.DisableInterface(arg_53_0)
	local var_53_0 = arg_53_0._mouseChild
	local var_53_1 = var_1.GetComponent

	typeof = var_1_10004
	Image = var_1_10006
	var_53_1(var_53_0, var_1_10004(var_1_10006)).enabled = false

	return
end

function var_0_0.Dispose(arg_54_0)
	if arg_54_0.state == var_0_0.STATE_INITED then
		local var_54_0 = arg_54_0._modleAnim

		var_1.SetActionCallBack(var_54_0, nil)
		arg_54_0:StopTweenShining()
		arg_54_0:RevertMaterial()

		PoolMgr = var_1

		local var_54_1 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_54_1, arg_54_0.prefabName, arg_54_0._model)
		arg_54_0:SetVisible(true)

		local var_54_2 = arg_54_0._modleGraphic.material
		local var_54_3 = var_1.SetColor
		local var_54_4 = "_Color"

		Color = var_5

		var_54_3(var_54_2, var_54_4, var_5.New(0, 0, 0, 0))

		local var_54_5 = arg_54_0._modleGraphic

		Color = var_2
		var_54_5.color = var_2.New(1, 1, 1, 1)
		pairs = var_54_5

		for iter_54_0, iter_54_1 in var_54_5(arg_54_0._attachmentList) do
			Object = var_6

			var_6.Destroy(iter_54_0.gameObject)
		end

		arg_54_0._model = nil
		arg_54_0.prefabName = nil
		arg_54_0.ship = nil
		arg_54_0.attachmentData = nil
		arg_54_0._modleGraphic = nil
		arg_54_0._modleAnim = nil
		arg_54_0._attachmentList = nil
		arg_54_0._sortLayerCount = 0
	end

	arg_54_0.state = var_0_0.STATE_DISPOSE

	return
end

return var_0_0
