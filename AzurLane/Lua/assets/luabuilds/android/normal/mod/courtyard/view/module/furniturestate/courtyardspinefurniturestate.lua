class = var_0_10000

local var_0_0 = var_0_10000("CourtyardSpineFurnitureState")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.rectTF = arg_1_2
	arg_1_0.rootTF = arg_1_0._tf.parent

	local var_1_0 = arg_1_0._tf

	arg_1_0.furnitureSpineStateSkeletonGraphic = var_6.GetComponent(var_1_0, "Spine.Unity.SkeletonGraphic")

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_6.GetComponent

	typeof = var_8
	Animation = var_1_10009
	arg_1_0.furnitureSpineStateAnim = var_1_2(var_1_1, var_8(var_1_10009))
	arg_1_0.selectedMat = arg_1_3
	arg_1_0.canPlaceMat = arg_1_4
	arg_1_0.cantPlaceMat = arg_1_5

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	pg = var_1_10003

	local var_2_0 = var_1_10003.UIMgr.GetInstance()

	var_3.LoadingOn(var_2_0, false)

	setActive = var_3

	var_3(arg_2_0._tf, false)

	ResourceMgr = var_3

	local var_2_1 = var_3.Inst
	local var_2_2 = var_3.getAssetAsync
	local var_2_3 = "sfurniture/"
	local var_2_4 = arg_2_2:GetFirstSlot()
	local var_2_5 = var_2_3 .. var_6.GetName(var_2_4)
	local var_2_6 = ""

	typeof = var_2_4
	GameObject = var_1_10008

	local var_2_7 = var_2_4(var_1_10008)

	UnityEngine = var_1_10008

	var_2_2(var_2_1, var_2_5, var_2_6, var_2_7, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_3_0)

		if arg_2_0.exited then
			return
		end

		arg_2_0._tf.pivot = arg_3_0.transform.pivot
		arg_2_0._tf.sizeDelta = arg_3_0.transform.sizeDelta

		local var_3_1 = arg_2_0._tf
		local var_3_2 = arg_2_1

		var_3_1.localPosition = var_2.GetSpinePoint(var_3_2)

		local var_3_3 = arg_2_0.furnitureSpineStateSkeletonGraphic
		local var_3_4 = arg_3_0.transform
		local var_3_5 = var_2.Find(var_3_4, "spine")

		var_3_3.skeletonDataAsset = var_2.GetComponent(var_3_5, "Spine.Unity.SkeletonGraphic").skeletonDataAsset

		local var_3_6 = arg_2_0.furnitureSpineStateSkeletonGraphic

		var_1.Initialize(var_3_6, true)

		setActive = var_1

		var_1(arg_2_0._tf, true)

		local var_3_7 = arg_2_0

		GetOrAddComponent = var_2

		local var_3_8 = arg_2_0._tf

		typeof = var_4
		SpineAnimUI = var_2_10005
		var_3_7.furnitureSpineStateAnimUI = var_2(var_3_8, var_4(var_2_10005))

		local var_3_9 = arg_2_0

		var_1.OnUpdateScale(var_3_9, arg_2_1)

		local var_3_10 = arg_2_0

		var_1.OnReset(var_3_10, arg_2_1)

		return
	end), true, true)

	return
end

function var_0_0.OnInit(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:Init(arg_4_1, arg_4_2)

	setParent = var_3

	var_3(arg_4_0._tf, arg_4_0.rectTF)

	return
end

function var_0_0.OnUpdateScale(arg_5_0, arg_5_1)
	CourtYardCalcUtil = var_1_10002

	local var_5_0 = var_1_10002.GetSign(arg_5_1._tf.localScale.x)
	local var_5_1 = arg_5_0._tf

	Vector3 = var_1_10004
	var_5_1.localScale = var_1_10004(var_5_0, 1, 1)

	return
end

function var_0_0.OnUpdate(arg_6_0, arg_6_1)
	arg_6_0._tf.localPosition = arg_6_1:GetSpinePoint()

	return
end

function var_0_0.OnCantPlace(arg_7_0)
	if arg_7_0.furnitureSpineStateSkeletonGraphic.material ~= arg_7_0.cantPlaceMat then
		arg_7_0.furnitureSpineStateSkeletonGraphic.material = arg_7_0.cantPlaceMat

		local var_7_0 = arg_7_0.furnitureSpineStateAnim

		var_1.Play(var_7_0, "anim_courtyard_spinered")
	end

	return
end

function var_0_0.OnCanPlace(arg_8_0)
	if arg_8_0.furnitureSpineStateSkeletonGraphic.material ~= arg_8_0.canPlaceMat then
		arg_8_0.furnitureSpineStateSkeletonGraphic.material = arg_8_0.canPlaceMat

		local var_8_0 = arg_8_0.furnitureSpineStateAnim

		var_1.Play(var_8_0, "anim_courtyard_spinegreen")
	end

	return
end

function var_0_0.OnReset(arg_9_0, arg_9_1)
	if not arg_9_0.furnitureSpineStateAnimUI then
		return
	end

	if arg_9_0.furnitureSpineStateSkeletonGraphic.material ~= arg_9_0.selectedMat then
		arg_9_0.furnitureSpineStateSkeletonGraphic.material = arg_9_0.selectedMat

		local var_9_0 = arg_9_0.furnitureSpineStateAnim

		var_2.Play(var_9_0, "anim_courtyard_spinewhite")
	end

	local var_9_1 = arg_9_1.animator

	if var_2.GetNormalAnimationName(var_9_1) then
		local var_9_2 = arg_9_1.animator

		var_3.RestartAnimation(var_9_2, var_2)

		local var_9_3 = arg_9_0.furnitureSpineStateAnimUI

		var_3.SetAction(var_9_3, var_2, 0)
	end

	return
end

function var_0_0.OnClear(arg_10_0)
	if arg_10_0.furnitureSpineStateAnimUI then
		Object = var_1

		var_1.Destroy(arg_10_0.furnitureSpineStateAnimUI)

		arg_10_0.furnitureSpineStateAnimUI = nil
	end

	setParent = var_1

	var_1(arg_10_0._tf, arg_10_0.rootTF)

	return
end

return var_0_0
