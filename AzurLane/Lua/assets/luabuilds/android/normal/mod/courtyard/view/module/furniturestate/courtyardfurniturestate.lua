class = var_0_10000

local var_0_0 = var_0_10000("CourtyardFurnitureState")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.rectTF = arg_1_2
	arg_1_0.rootTF = arg_1_0._tf.parent

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_6.GetComponent

	typeof = var_1_10008
	Image = var_1_10009
	arg_1_0.furnitureStateImg = var_1_1(var_1_0, var_1_10008(var_1_10009))

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_6.GetComponent

	typeof = var_8
	Animation = var_1_10009
	arg_1_0.furnitureStateAnim = var_1_3(var_1_2, var_8(var_1_10009))
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
	local var_2_3 = "furnitrues/"
	local var_2_4 = arg_2_2
	local var_2_5 = var_2_3 .. arg_2_2.GetPicture(var_2_4)
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

		setActive = var_1

		var_1(arg_2_0._tf, true)

		local var_3_1 = arg_2_0.furnitureStateImg
		local var_3_2 = arg_3_0
		local var_3_3 = arg_3_0.GetComponent

		typeof = var_2_10004
		Image = var_2_10005
		var_3_1.sprite = var_3_3(var_3_2, var_2_10004(var_2_10005)).sprite
		arg_2_0._tf.sizeDelta = arg_3_0.transform.sizeDelta

		local var_3_4 = arg_2_0._tf
		local var_3_5 = arg_2_1

		var_3_4.localPosition = var_2.GetCenterPoint(var_3_5)

		local var_3_6 = arg_2_0

		var_1.OnUpdateScale(var_3_6, arg_2_1)

		local var_3_7 = arg_2_0

		var_1.OnReset(var_3_7)

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
	arg_6_0._tf.localPosition = arg_6_1:GetCenterPoint()

	return
end

function var_0_0.OnCantPlace(arg_7_0)
	if arg_7_0.furnitureStateImg.material ~= arg_7_0.cantPlaceMat then
		arg_7_0.furnitureStateImg.material = arg_7_0.cantPlaceMat

		local var_7_0 = arg_7_0.furnitureStateAnim

		var_1.Play(var_7_0, "anim_courtyard_iconred")
	end

	return
end

function var_0_0.OnCanPlace(arg_8_0)
	if arg_8_0.furnitureStateImg.material ~= arg_8_0.canPlaceMat then
		arg_8_0.furnitureStateImg.material = arg_8_0.canPlaceMat

		local var_8_0 = arg_8_0.furnitureStateAnim

		var_1.Play(var_8_0, "anim_courtyard_icongreen")
	end

	return
end

function var_0_0.OnReset(arg_9_0)
	if arg_9_0.furnitureStateImg.material ~= arg_9_0.selectedMat then
		arg_9_0.furnitureStateImg.material = arg_9_0.selectedMat

		local var_9_0 = arg_9_0.furnitureStateAnim

		var_1.Play(var_9_0, "anim_courtyard_iconwhite")
	end

	return
end

function var_0_0.OnClear(arg_10_0)
	local var_10_0 = arg_10_0.furnitureStateAnim

	var_1.Stop(var_10_0)

	arg_10_0.furnitureStateImg.sprite = nil

	local var_10_1 = arg_10_0.furnitureStateImg

	var_10_1.material = nil
	setParent = var_10_1

	var_10_1(arg_10_0._tf, arg_10_0.rootTF)

	return
end

return var_0_0
