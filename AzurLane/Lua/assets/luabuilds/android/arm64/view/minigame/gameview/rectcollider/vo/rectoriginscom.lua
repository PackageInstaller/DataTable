local var_0_0 = class("RectOriginsCom")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.skinWidth = 0.01
	arg_1_0.dstBetweenRays = 0.3
	arg_1_0.horizontalRayCount = 0
	arg_1_0.verticalRayCount = 0
	arg_1_0.horizontalRaySpacing = 0
	arg_1_0.verticalRaySpacing = 0
	arg_1_0.topLeft = Vector3.zero
	arg_1_0.topRight = Vector3.zero
	arg_1_0.bottomLeft = Vector3.zero
	arg_1_0.bottomRight = Vector3.zero
	arg_1_0.center = Vector3.zero
	arg_1_0._collider = arg_1_1
	arg_1_0.initFlag = false

	return
end

function var_0_0.calculateRaySpacing(arg_2_0)
	arg_2_0._collider.bounds:Expand(arg_2_0.skinWidth * -2)

	arg_2_0.verticalRayCount = Mathf.Round(arg_2_0._collider.bounds.size.x / arg_2_0.dstBetweenRays)
	arg_2_0.horizontalRayCount = Mathf.Round(arg_2_0._collider.bounds.size.y / arg_2_0.dstBetweenRays)

	if arg_2_0.verticalRayCount <= 1 then
		arg_2_0.verticalRayCount = 2
	end

	arg_2_0.horizontalRaySpacing = arg_2_0._collider.bounds.size.y / (arg_2_0.horizontalRayCount - 1)
	arg_2_0.verticalRaySpacing = arg_2_0._collider.bounds.size.x / (arg_2_0.verticalRayCount - 1)

	return
end

function var_0_0.updateRaycastOrigins(arg_3_0)
	if not arg_3_0.initFlag then
		arg_3_0.initFlag = true

		arg_3_0:calculateRaySpacing()
	end

	local var_3_0 = arg_3_0._collider.bounds

	arg_3_0._collider.bounds:Expand(arg_3_0.skinWidth * -2)

	arg_3_0.bottomLeft.x = var_3_0.min.x
	arg_3_0.bottomLeft.y = var_3_0.min.y
	arg_3_0.bottomLeft.z = var_3_0.min.z
	arg_3_0.bottomRight.x = var_3_0.max.x
	arg_3_0.bottomRight.y = var_3_0.min.y
	arg_3_0.bottomRight.z = var_3_0.min.z
	arg_3_0.topLeft.x = var_3_0.min.x
	arg_3_0.topLeft.y = var_3_0.max.y
	arg_3_0.topLeft.z = var_3_0.max.z
	arg_3_0.topRight.x = var_3_0.max.x
	arg_3_0.topRight.y = var_3_0.max.y
	arg_3_0.topRight.z = var_3_0.max.z
	arg_3_0.center.x = var_3_0.center.x
	arg_3_0.center.y = var_3_0.center.y
	arg_3_0.center.z = var_3_0.center.z

	return
end

function var_0_0.createDebugImg(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._collider.bounds:Expand(arg_4_0.skinWidth * -2)

	arg_4_0.bl = cloneTplTo(arg_4_1, arg_4_2, "bl")
	arg_4_0.br = cloneTplTo(arg_4_1, arg_4_2, "br")
	arg_4_0.tl = cloneTplTo(arg_4_1, arg_4_2, "tl")
	arg_4_0.tr = cloneTplTo(arg_4_1, arg_4_2, "tr")
	arg_4_0.bl.position = Vector3(arg_4_0._collider.bounds.min.x, arg_4_0._collider.bounds.min.y, arg_4_0._collider.bounds.min.z)
	arg_4_0.br.position = Vector3(arg_4_0._collider.bounds.max.x, arg_4_0._collider.bounds.min.y, arg_4_0._collider.bounds.min.z)
	arg_4_0.tl.position = Vector3(arg_4_0._collider.bounds.min.x, arg_4_0._collider.bounds.max.y, arg_4_0._collider.bounds.max.z)
	arg_4_0.tr.position = Vector3(arg_4_0._collider.bounds.max.x, arg_4_0._collider.bounds.max.y, arg_4_0._collider.bounds.max.z)

	return
end

return var_0_0
