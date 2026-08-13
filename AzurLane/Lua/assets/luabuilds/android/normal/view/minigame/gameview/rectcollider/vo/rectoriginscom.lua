class = var_0_10000

local var_0_0 = var_0_10000("RectOriginsCom")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.skinWidth = 0.01
	arg_1_0.dstBetweenRays = 0.3
	arg_1_0.horizontalRayCount = 0
	arg_1_0.verticalRayCount = 0
	arg_1_0.horizontalRaySpacing = 0
	arg_1_0.verticalRaySpacing = 0
	Vector3 = var_2
	arg_1_0.topLeft = var_2.zero
	Vector3 = var_2
	arg_1_0.topRight = var_2.zero
	Vector3 = var_2
	arg_1_0.bottomLeft = var_2.zero
	Vector3 = var_2
	arg_1_0.bottomRight = var_2.zero
	Vector3 = var_2
	arg_1_0.center = var_2.zero
	arg_1_0._collider = arg_1_1
	arg_1_0.initFlag = false

	return
end

function var_0_0.calculateRaySpacing(arg_2_0)
	local var_2_0 = arg_2_0._collider.bounds

	var_1.Expand(var_2_0, arg_2_0.skinWidth * -2)

	local var_2_1 = var_1.size.x
	local var_2_2 = var_1.size.y

	Mathf = var_4
	arg_2_0.verticalRayCount = var_4.Round(var_2_1 / arg_2_0.dstBetweenRays)
	Mathf = var_4
	arg_2_0.horizontalRayCount = var_4.Round(var_2_2 / arg_2_0.dstBetweenRays)

	if arg_2_0.verticalRayCount <= 1 then
		arg_2_0.verticalRayCount = 2
	end

	arg_2_0.horizontalRaySpacing = var_1.size.y / (arg_2_0.horizontalRayCount - 1)
	arg_2_0.verticalRaySpacing = var_1.size.x / (arg_2_0.verticalRayCount - 1)

	return
end

function var_0_0.updateRaycastOrigins(arg_3_0)
	if not arg_3_0.initFlag then
		arg_3_0.initFlag = true

		arg_3_0:calculateRaySpacing()
	end

	local var_3_0 = arg_3_0._collider.bounds

	var_1.Expand(var_3_0, arg_3_0.skinWidth * -2)

	arg_3_0.bottomLeft.x = var_1.min.x
	arg_3_0.bottomLeft.y = var_1.min.y
	arg_3_0.bottomLeft.z = var_1.min.z
	arg_3_0.bottomRight.x = var_1.max.x
	arg_3_0.bottomRight.y = var_1.min.y
	arg_3_0.bottomRight.z = var_1.min.z
	arg_3_0.topLeft.x = var_1.min.x
	arg_3_0.topLeft.y = var_1.max.y
	arg_3_0.topLeft.z = var_1.max.z
	arg_3_0.topRight.x = var_1.max.x
	arg_3_0.topRight.y = var_1.max.y
	arg_3_0.topRight.z = var_1.max.z
	arg_3_0.center.x = var_1.center.x
	arg_3_0.center.y = var_1.center.y
	arg_3_0.center.z = var_1.center.z

	return
end

function var_0_0.createDebugImg(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._collider.bounds

	var_3.Expand(var_4_0, arg_4_0.skinWidth * -2)

	cloneTplTo = var_4
	arg_4_0.bl = var_4(arg_4_1, arg_4_2, "bl")
	cloneTplTo = var_4
	arg_4_0.br = var_4(arg_4_1, arg_4_2, "br")
	cloneTplTo = var_4
	arg_4_0.tl = var_4(arg_4_1, arg_4_2, "tl")
	cloneTplTo = var_4
	arg_4_0.tr = var_4(arg_4_1, arg_4_2, "tr")

	local var_4_1 = arg_4_0.bl

	Vector3 = var_5
	var_4_1.position = var_5(var_3.min.x, var_3.min.y, var_3.min.z)

	local var_4_2 = arg_4_0.br

	Vector3 = var_5
	var_4_2.position = var_5(var_3.max.x, var_3.min.y, var_3.min.z)

	local var_4_3 = arg_4_0.tl

	Vector3 = var_5
	var_4_3.position = var_5(var_3.min.x, var_3.max.y, var_3.max.z)

	local var_4_4 = arg_4_0.tr

	Vector3 = var_5
	var_4_4.position = var_5(var_3.max.x, var_3.max.y, var_3.max.z)

	return
end

return var_0_0
