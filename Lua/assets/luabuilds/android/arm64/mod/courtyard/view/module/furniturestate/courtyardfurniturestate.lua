local var_0_0 = class("CourtyardFurnitureState")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.rectTF = arg_1_2
	arg_1_0.rootTF = arg_1_0._tf.parent
	arg_1_0.furnitureStateImg = arg_1_0._tf:GetComponent(typeof(Image))
	arg_1_0.furnitureStateAnim = arg_1_0._tf:GetComponent(typeof(Animation))
	arg_1_0.selectedMat = arg_1_3
	arg_1_0.canPlaceMat = arg_1_4
	arg_1_0.cantPlaceMat = arg_1_5

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	pg.UIMgr.GetInstance():LoadingOn(false)
	setActive(arg_2_0._tf, false)
	ResourceMgr.Inst:getAssetAsync("furnitrues/" .. arg_2_2:GetPicture(), "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_3_0)
		pg.UIMgr.GetInstance():LoadingOff()

		if arg_2_0.exited then
			return
		end

		setActive(arg_2_0._tf, true)

		arg_2_0.furnitureStateImg.sprite = arg_3_0:GetComponent(typeof(Image)).sprite
		arg_2_0._tf.sizeDelta = arg_3_0.transform.sizeDelta
		arg_2_0._tf.localPosition = arg_2_1:GetCenterPoint()

		arg_2_0:OnUpdateScale(arg_2_1)
		arg_2_0:OnReset()

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
	arg_6_0._tf.localPosition = arg_6_1:GetCenterPoint()

	return
end

function var_0_0.OnCantPlace(arg_7_0)
	if arg_7_0.furnitureStateImg.material ~= arg_7_0.cantPlaceMat then
		arg_7_0.furnitureStateImg.material = arg_7_0.cantPlaceMat

		arg_7_0.furnitureStateAnim:Play("anim_courtyard_iconred")
	end

	return
end

function var_0_0.OnCanPlace(arg_8_0)
	if arg_8_0.furnitureStateImg.material ~= arg_8_0.canPlaceMat then
		arg_8_0.furnitureStateImg.material = arg_8_0.canPlaceMat

		arg_8_0.furnitureStateAnim:Play("anim_courtyard_icongreen")
	end

	return
end

function var_0_0.OnReset(arg_9_0)
	if arg_9_0.furnitureStateImg.material ~= arg_9_0.selectedMat then
		arg_9_0.furnitureStateImg.material = arg_9_0.selectedMat

		arg_9_0.furnitureStateAnim:Play("anim_courtyard_iconwhite")
	end

	return
end

function var_0_0.OnClear(arg_10_0)
	arg_10_0.furnitureStateAnim:Stop()

	arg_10_0.furnitureStateImg.sprite = nil
	arg_10_0.furnitureStateImg.material = nil

	setParent(arg_10_0._tf, arg_10_0.rootTF)

	return
end

return var_0_0
