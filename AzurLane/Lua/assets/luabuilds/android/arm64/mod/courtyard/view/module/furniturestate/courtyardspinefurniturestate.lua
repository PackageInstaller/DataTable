local var_0_0 = class("CourtyardSpineFurnitureState")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.rectTF = arg_1_2
	arg_1_0.rootTF = arg_1_0._tf.parent
	arg_1_0.furnitureSpineStateSkeletonGraphic = arg_1_0._tf:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_1_0.furnitureSpineStateAnim = arg_1_0._tf:GetComponent(typeof(Animation))
	arg_1_0.selectedMat = arg_1_3
	arg_1_0.canPlaceMat = arg_1_4
	arg_1_0.cantPlaceMat = arg_1_5

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	pg.UIMgr.GetInstance():LoadingOn(false)
	setActive(arg_2_0._tf, false)
	ResourceMgr.Inst:getAssetAsync("sfurniture/" .. arg_2_2:GetFirstSlot():GetName(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if arg_2_0.exited then
			return
		end

		arg_2_0._tf.pivot = arg_3_0.transform.pivot
		arg_2_0._tf.sizeDelta = arg_3_0.transform.sizeDelta
		arg_2_0._tf.localPosition = arg_2_1:GetSpinePoint()
		arg_2_0.furnitureSpineStateSkeletonGraphic.skeletonDataAsset = arg_3_0.transform:Find("spine"):GetComponent("Spine.Unity.SkeletonGraphic").skeletonDataAsset

		arg_2_0.furnitureSpineStateSkeletonGraphic:Initialize(true)
		setActive(arg_2_0._tf, true)

		arg_2_0.furnitureSpineStateAnimUI = GetOrAddComponent(arg_2_0._tf, typeof(SpineAnimUI))

		arg_2_0:OnUpdateScale(arg_2_1)
		arg_2_0:OnReset(arg_2_1)

		return
	end), true, true)

	return
end

function var_0_0.OnInit(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:Init(arg_4_1, arg_4_2)
	setParent(arg_4_0._tf, arg_4_0.rectTF)

	return
end

function var_0_0.OnUpdateScale(arg_5_0, arg_5_1)
	arg_5_0._tf.localScale = Vector3(CourtYardCalcUtil.GetSign(arg_5_1._tf.localScale.x), 1, 1)

	return
end

function var_0_0.OnUpdate(arg_6_0, arg_6_1)
	arg_6_0._tf.localPosition = arg_6_1:GetSpinePoint()

	return
end

function var_0_0.OnCantPlace(arg_7_0)
	if arg_7_0.furnitureSpineStateSkeletonGraphic.material ~= arg_7_0.cantPlaceMat then
		arg_7_0.furnitureSpineStateSkeletonGraphic.material = arg_7_0.cantPlaceMat

		arg_7_0.furnitureSpineStateAnim:Play("anim_courtyard_spinered")
	end

	return
end

function var_0_0.OnCanPlace(arg_8_0)
	if arg_8_0.furnitureSpineStateSkeletonGraphic.material ~= arg_8_0.canPlaceMat then
		arg_8_0.furnitureSpineStateSkeletonGraphic.material = arg_8_0.canPlaceMat

		arg_8_0.furnitureSpineStateAnim:Play("anim_courtyard_spinegreen")
	end

	return
end

function var_0_0.OnReset(arg_9_0, arg_9_1)
	if not arg_9_0.furnitureSpineStateAnimUI then
		return
	end

	if arg_9_0.furnitureSpineStateSkeletonGraphic.material ~= arg_9_0.selectedMat then
		arg_9_0.furnitureSpineStateSkeletonGraphic.material = arg_9_0.selectedMat

		arg_9_0.furnitureSpineStateAnim:Play("anim_courtyard_spinewhite")
	end

	local var_9_0 = arg_9_1.animator:GetNormalAnimationName()

	if var_9_0 then
		arg_9_1.animator:RestartAnimation(var_9_0)
		arg_9_0.furnitureSpineStateAnimUI:SetAction(var_9_0, 0)
	end

	return
end

function var_0_0.OnClear(arg_10_0)
	if arg_10_0.furnitureSpineStateAnimUI then
		Object.Destroy(arg_10_0.furnitureSpineStateAnimUI)

		arg_10_0.furnitureSpineStateAnimUI = nil
	end

	setParent(arg_10_0._tf, arg_10_0.rootTF)

	return
end

return var_0_0
