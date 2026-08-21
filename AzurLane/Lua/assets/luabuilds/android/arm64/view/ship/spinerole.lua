local var_0_0 = class("SpineRole")

var_0_0.STATE_EMPTY = 0
var_0_0.STATE_LOADING = 1
var_0_0.STATE_INITED = 2
var_0_0.STATE_DISPOSE = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.state = var_0_0.STATE_EMPTY

	if arg_1_1 then
		arg_1_0.ship = arg_1_1
		arg_1_0.prefabName = arg_1_0.ship:getPrefab(arg_1_2)
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

	PoolMgr.GetInstance():GetSpineChar(arg_3_0.prefabName, arg_3_2, function(arg_4_0)
		assert(arg_4_0, "没有这个角色的模型  " .. arg_3_0.prefabName)

		if arg_3_0.state == var_0_0.STATE_DISPOSE then
			PoolMgr.GetInstance():ReturnSpineChar(arg_3_0.prefabName, arg_4_0)
		else
			arg_3_0._modelRoot = GameObject.New(arg_3_0.prefabName .. "_root")

			arg_3_0._modelRoot:AddComponent(typeof(RectTransform))

			arg_3_0._model = arg_4_0

			arg_3_0:Init()
			arg_3_0:SetLocalScale(Vector3.one)
			arg_3_0:SetModelScale(Vector3.one)
			arg_3_0._model.transform:SetParent(arg_3_0._modelRoot.transform, false)

			arg_3_0._model.transform.localPosition = Vector3.zero

			setActive(arg_3_0._model.transform, true)

			if arg_3_1 then
				arg_3_1()
			end

			arg_3_0:AttachOrbit(arg_3_3)
			arg_3_0:sortAttachmentGO()
		end

		return
	end)

	return
end

function var_0_0.LoadLite(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == nil then
		arg_5_2 = true
	end

	PoolMgr.GetInstance():GetSpineChar(arg_5_0.prefabName, arg_5_2, function(arg_6_0)
		assert(arg_6_0, "没有这个角色的模型  " .. arg_5_0.prefabName)

		if arg_5_0.state == var_0_0.STATE_DISPOSE then
			PoolMgr.GetInstance():ReturnSpineChar(arg_5_0.prefabName, arg_6_0)
		else
			arg_5_0._modelRoot = arg_6_0
			arg_5_0._model = arg_6_0

			arg_5_0:Init()
			arg_5_0:SetLocalScale(Vector3.one)
			arg_5_0:SetModelScale(Vector3.one)

			arg_5_0._model.transform.localPosition = Vector3.zero

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
	arg_7_0._modleGraphic = arg_7_0._model:GetComponent("SkeletonGraphic")
	arg_7_0._modleAnim = arg_7_0._model:GetComponent("SpineAnimUI")
	arg_7_0._attachmentList = {}
	arg_7_0._visible = true
	arg_7_0._orbitVisible = true

	return
end

function var_0_0.AttachOrbit(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or var_0_0.ORBIT_KEY_UI

	for iter_8_0, iter_8_1 in pairs((arg_8_0:GetAttachmentList())) do
		local var_8_1 = iter_8_1.config
		local var_8_2 = iter_8_1.index
		local var_8_3 = iter_8_1.config[var_8_0]

		if var_8_0 ~= var_0_0.ORBIT_KEY_UI and var_8_3 == "" then
			var_8_3 = var_8_1.orbit_ui
			var_8_0 = var_0_0.ORBIT_KEY_UI
		end

		if var_8_3 ~= "" then
			local var_8_4 = var_8_1.orbit_ui_bound[1]
			local var_8_5 = arg_8_0._modleGraphic.Skeleton:FindBoneIndex("char1_" .. var_8_1.orbit_ui_bound[1])
			local var_8_6 = arg_8_0._modleGraphic.Skeleton:FindBoneIndex("char2_" .. var_8_1.orbit_ui_bound[1])
			local var_8_7 = var_8_1.double_char_bone
			local var_8_8 = ys.Battle.BattleResourceManager.GetOrbitPath(var_8_3)

			if not not (arg_8_0.ship and arg_8_0.ship:IsDoubleSkin()) and (var_8_5 >= 0 or var_8_6 > 0) or var_8_5 >= 0 and var_8_6 > 0 then
				if var_8_6 >= 0 and var_8_7 and #var_8_7 > 0 and var_8_7[1] == 1 then
					arg_8_0:loadOrbitUI(var_8_8, var_8_0, var_8_3, "char2" .. "_" .. var_8_4, var_8_2, var_8_1)
				end

				if var_8_7 and #var_8_7 > 0 and var_8_7[2] == 1 then
					arg_8_0:loadOrbitUI(var_8_8, var_8_0, var_8_3, var_8_4, var_8_2, var_8_1)
				end

				if var_8_5 >= 0 and var_8_7 and #var_8_7 > 0 and var_8_7[3] == 1 then
					arg_8_0:loadOrbitUI(var_8_8, var_8_0, var_8_3, "char1" .. "_" .. var_8_4, var_8_2, var_8_1)
				end
			else
				arg_8_0:loadOrbitUI(var_8_8, var_8_0, var_8_3, var_8_4, var_8_2, var_8_1)
			end
		end
	end

	return
end

function var_0_0.loadOrbitUI(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	ResourceMgr.Inst:getAssetAsync(arg_9_1, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
		local var_10_0 = tf(arg_10_0).childCount

		if var_10_0 > 1 then
			for iter_10_0 = 1, var_10_0 do
				arg_9_0:CreateOrbitUI(iter_10_0, arg_10_0, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
			end
		else
			arg_9_0:CreateOrbitUI(0, arg_10_0, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
		end

		return
	end), true, true)

	return
end

function var_0_0.CreateOrbitUI(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7)
	local var_11_0

	if arg_11_0.state == var_0_0.STATE_DISPOSE then
		do return end

		var_11_0 = arg_11_7[arg_11_3 .. "_bound"][1]
	end

	local var_11_1 = arg_11_7[arg_11_3 .. "_bound"][2]
	local var_11_2 = Object.Instantiate(arg_11_2)
	local var_11_3 = 0

	if arg_11_1 ~= 0 then
		for iter_11_0 = var_11_2.transform.childCount, 1, -1 do
			local var_11_4 = var_11_2.transform:GetChild(iter_11_0 - 1)

			if iter_11_0 ~= arg_11_1 then
				Destroy(var_11_4.gameObject)
			else
				local var_11_5 = var_11_4:GetComponent(typeof(Canvas))

				if var_11_5 then
					var_11_3 = var_11_5.sortingOrder

					RemoveComponent(var_11_4.transform, "Canvas")
				end
			end
		end
	else
		local var_11_6 = var_11_2.transform:GetChild(0)

		if var_11_6:GetComponent(typeof(Canvas)) then
			RemoveComponent(var_11_6.transform, "Canvas")
		end
	end

	local var_11_7 = var_11_2:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic))

	for iter_11_1, iter_11_2 in ipairs((var_11_7:ToTable())) do
		iter_11_2.raycastTarget = false
	end

	var_11_2.transform.localPosition = Vector2(var_11_1[1], var_11_1[2])
	var_11_2.transform.localScale = Vector3.one

	local var_11_8 = SpineAnimUI.AddFollower(arg_11_5, arg_11_0._model.transform, var_11_2.transform)

	arg_11_0._attachmentList[var_11_8] = {
		tf = var_11_2.transform,
		p = arg_11_4,
		hiddenActionList = arg_11_7.orbit_hidden_action,
		index = arg_11_6,
		back = arg_11_7.orbit_ui_back,
		sortOrder = var_11_3
	}

	local var_11_9 = var_11_8:GetComponent("Spine.Unity.BoneFollowerGraphic")

	var_11_9.followSkeletonFlip = false

	if arg_11_7.orbit_rotate_ui ~= "" and arg_11_7.orbit_rotate_ui == true then
		var_11_9.followBoneRotation = true
		var_11_2.transform.localEulerAngles = Vector3(var_11_2.transform.localEulerAngles.x, var_11_2.transform.localEulerAngles.y, var_11_2.transform.localEulerAngles.z - 90)
	else
		var_11_9.followBoneRotation = false
	end

	if var_11_3 and var_11_3 < 0 then
		var_11_8:SetParent(arg_11_0._modelRoot.transform, false)
		var_11_8:SetAsFirstSibling()
	elseif var_11_3 and var_11_3 > 0 then
		var_11_8:SetParent(arg_11_0._modelRoot.transform, false)
		var_11_8:SetAsLastSibling()
	elseif arg_11_7.orbit_ui_back == 1 then
		var_11_8:SetParent(arg_11_0._modelRoot.transform, false)
		var_11_8:SetAsFirstSibling()
	else
		var_11_8:SetParent(arg_11_0._modelRoot.transform, false)
		var_11_8:SetAsLastSibling()
	end

	SetActive(var_11_8, false)
	onNextTick(function()
		SetActive(var_11_8, arg_11_0._visible)

		return
	end)
	arg_11_0:sortAttachmentGO()

	return
end

function var_0_0.sortAttachmentGO(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._attachmentList) do
		table.insert({}, {
			tf = iter_13_0,
			index = iter_13_1.index,
			back = iter_13_1.back,
			p = iter_13_1.p,
			sortOrder = iter_13_1.sortOrder
		})
	end

	table.sort({}, function(arg_14_0, arg_14_1)
		return arg_14_0.index < arg_14_1.index
	end)

	for iter_13_2, iter_13_3 in ipairs({}) do
		if iter_13_3.back ~= 1 and iter_13_3.sortOrder == 0 then
			iter_13_3.tf:SetAsLastSibling()

			break
		elseif iter_13_3.back == 1 and iter_13_3.sortOrder == 0 then
			iter_13_3.tf:SetAsFirstSibling()
		end
	end

	return
end

function var_0_0.GetAttachmentList(arg_15_0)
	if arg_15_0.ship then
		return arg_15_0.ship:getAttachmentPrefab()
	else
		return arg_15_0.attachmentData or {}
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
		arg_22_0._modelRoot.transform:SetSiblingIndex(arg_22_1)
	end

	return
end

function var_0_0.SetParent(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0:CheckInited() then
		SetParent(tf(arg_23_0._modelRoot), tf(arg_23_1), arg_23_2 and true or false)
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

		for iter_27_0, iter_27_1 in pairs(arg_27_0._attachmentList) do
			SetActive(iter_27_0, arg_27_1)
		end
	end

	return
end

function var_0_0.SetVisible(arg_28_0, arg_28_1)
	if arg_28_0:CheckInited() then
		arg_28_0._visible = arg_28_1
		arg_28_0._orbitVisible = arg_28_1
		arg_28_0._modleGraphic.color = Color.New(1, 1, 1, arg_28_1 and 1 or 0)

		for iter_28_0, iter_28_1 in pairs(arg_28_0._attachmentList) do
			SetActive(iter_28_0, arg_28_1)
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

	local var_30_0 = math.sign(arg_30_0._rootScale.x)
	local var_30_1, var_30_2 = SpineAnimUtil.GetCharAnimationDirect(arg_30_0._modleGraphic, var_30_0, arg_30_1)

	arg_30_0._model.transform.localScale = var_30_2 and Vector3(var_30_0 * math.abs(arg_30_0._modelScale.x), arg_30_0._modelScale.y, arg_30_0._modelScale.z) or arg_30_0._modelScale

	arg_30_0._modleAnim:SetAction(var_30_1, 0)

	arg_30_0._action = arg_30_1

	arg_30_0:HiddenAttachmentByAction(arg_30_1)

	return
end

function var_0_0.SetActionOnce(arg_31_0, arg_31_1)
	if not arg_31_0:CheckInited() then
		return
	end

	arg_31_0._modleGraphic.AnimationState:SetAnimation(0, arg_31_1, false)
	arg_31_0:HiddenAttachmentByAction(arg_31_1)

	return
end

function var_0_0.SetActionCallBack(arg_32_0, arg_32_1)
	if not arg_32_0:CheckInited() then
		return
	end

	arg_32_0._modleAnim:SetActionCallBack(function(arg_33_0)
		arg_32_0:changeAttachLListVisible(arg_33_0)

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

	for iter_34_0, iter_34_1 in pairs(arg_34_0._attachmentList) do
		SetActive(iter_34_0, var_34_0)
	end

	return
end

function var_0_0.HiddenAttachmentByAction(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in pairs(arg_35_0._attachmentList) do
		SetActive(iter_35_0, not table.contains(iter_35_1.hiddenActionList, arg_35_1) and arg_35_0._orbitVisible)
	end

	return
end

function var_0_0.SetSizeDelta(arg_36_0, arg_36_1)
	if arg_36_0:CheckInited() then
		rtf(arg_36_0._modelRoot).sizeDelta = arg_36_1
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
		arg_41_0._modelRoot.transform:SetAsFirstSibling()
	end

	return
end

function var_0_0.SetLayer(arg_42_0, arg_42_1)
	if arg_42_0:CheckInited() then
		pg.ViewUtils.SetLayer(arg_42_0._modelRoot.transform, arg_42_1)
	end

	return
end

function var_0_0.TweenShining(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5, arg_43_6, arg_43_7, arg_43_8, arg_43_9, arg_43_10)
	if arg_43_0:CheckInited() then
		arg_43_0:StopTweenShining()

		local var_43_0 = arg_43_0._modleGraphic.material
		local var_43_1 = LeanTween.value(arg_43_0._modelRoot, arg_43_3, arg_43_4, arg_43_1):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_44_0)
			if arg_43_7 then
				var_43_0:SetColor("_Color", Color.Lerp(arg_43_5, arg_43_6, arg_44_0))
			else
				arg_43_0._modleGraphic.color = Color.Lerp(arg_43_5, arg_43_6, arg_44_0)
			end

			existCall(arg_43_9, arg_44_0)

			return
		end)):setOnComplete(System.Action(function()
			arg_43_0._tweenShiningId = nil

			if arg_43_8 then
				if arg_43_7 then
					var_43_0:SetColor("_Color", arg_43_5)
				else
					arg_43_0._modleGraphic.color = arg_43_5
				end
			end

			existCall(arg_43_10)

			return
		end))

		if arg_43_2 then
			var_43_1:setLoopPingPong(arg_43_2)
		end

		arg_43_0._tweenShiningId = var_43_1.uniqueId
	end

	return
end

function var_0_0.StopTweenShining(arg_46_0)
	if arg_46_0:CheckInited() and arg_46_0._tweenShiningId then
		LeanTween.cancel(arg_46_0._tweenShiningId, true)

		arg_46_0._tweenShiningId = nil
	end

	return
end

function var_0_0.ChangeMaterial(arg_47_0, arg_47_1)
	if not arg_47_0:CheckInited() then
		return
	end

	arg_47_0._stageMaterial = arg_47_0._stageMaterial or arg_47_0._modleGraphic.material
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
	arg_49_0._mouseChild = GameObject("mouseChild")

	arg_49_0._mouseChild.transform:SetParent(arg_49_0._modelRoot.transform, false)

	arg_49_0._mouseChild.transform.localPosition = Vector3.zero
	arg_49_0._modelClick = GetOrAddComponent(arg_49_0._mouseChild, "ModelDrag")
	arg_49_0._modelPress = GetOrAddComponent(arg_49_0._mouseChild, "UILongPressTrigger")
	arg_49_0._dragDelegate = GetOrAddComponent(arg_49_0._mouseChild, "EventTriggerListener")

	arg_49_0._modelClick:Init()

	local var_49_0 = GetOrAddComponent(arg_49_0._mouseChild, typeof(RectTransform))

	var_49_0.pivot = Vector2(0.5, 0)
	var_49_0.anchoredPosition = Vector2(0, 0)
	var_49_0.localScale = Vector2(100, 100)
	var_49_0.sizeDelta = Vector2(3, 3)

	return arg_49_0._modelClick, arg_49_0._modelPress, arg_49_0._dragDelegate
end

function var_0_0.resumeRole(arg_50_0)
	if arg_50_0._modleAnim and arg_50_0._modleAnim:GetAnimationState() then
		arg_50_0._modleAnim:Resume()
	end

	return
end

function var_0_0.GetInterface(arg_51_0)
	return arg_51_0._modelClick, arg_51_0._modelPress, arg_51_0._dragDelegate
end

function var_0_0.EnableInterface(arg_52_0)
	arg_52_0._mouseChild:GetComponent(typeof(Image)).enabled = true

	return
end

function var_0_0.DisableInterface(arg_53_0)
	arg_53_0._mouseChild:GetComponent(typeof(Image)).enabled = false

	return
end

function var_0_0.Dispose(arg_54_0)
	if arg_54_0.state == var_0_0.STATE_INITED then
		arg_54_0._modleAnim:SetActionCallBack(nil)
		arg_54_0:StopTweenShining()
		arg_54_0:RevertMaterial()
		PoolMgr.GetInstance():ReturnSpineChar(arg_54_0.prefabName, arg_54_0._model)
		arg_54_0:SetVisible(true)
		arg_54_0._modleGraphic.material:SetColor("_Color", Color.New(0, 0, 0, 0))

		arg_54_0._modleGraphic.color = Color.New(1, 1, 1, 1)

		for iter_54_0, iter_54_1 in pairs(arg_54_0._attachmentList) do
			Object.Destroy(iter_54_0.gameObject)
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
