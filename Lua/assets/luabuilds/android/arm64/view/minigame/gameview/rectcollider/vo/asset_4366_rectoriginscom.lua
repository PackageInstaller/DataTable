local RectOriginsCom = class("RectOriginsCom")

function RectOriginsCom:Ctor(arg_1_1)
	self.skinWidth = 0.01
	self.dstBetweenRays = 0.3
	self.horizontalRayCount = 0
	self.verticalRayCount = 0
	self.horizontalRaySpacing = 0
	self.verticalRaySpacing = 0
	self.topLeft = Vector3.zero
	self.topRight = Vector3.zero
	self.bottomLeft = Vector3.zero
	self.bottomRight = Vector3.zero
	self.center = Vector3.zero
	self._collider = arg_1_1
	self.initFlag = false

	return
end

function RectOriginsCom:calculateRaySpacing()
	self._collider.bounds:Expand(self.skinWidth * -2)

	self.verticalRayCount = Mathf.Round(self._collider.bounds.size.x / self.dstBetweenRays)
	self.horizontalRayCount = Mathf.Round(self._collider.bounds.size.y / self.dstBetweenRays)

	if self.verticalRayCount <= 1 then
		self.verticalRayCount = 2
	end

	self.horizontalRaySpacing = self._collider.bounds.size.y / (self.horizontalRayCount - 1)
	self.verticalRaySpacing = self._collider.bounds.size.x / (self.verticalRayCount - 1)

	return
end

function RectOriginsCom:updateRaycastOrigins()
	if not self.initFlag then
		self.initFlag = true

		self:calculateRaySpacing()
	end

	local var_3_0 = self._collider.bounds

	self._collider.bounds:Expand(self.skinWidth * -2)

	self.bottomLeft.x = var_3_0.min.x
	self.bottomLeft.y = var_3_0.min.y
	self.bottomLeft.z = var_3_0.min.z
	self.bottomRight.x = var_3_0.max.x
	self.bottomRight.y = var_3_0.min.y
	self.bottomRight.z = var_3_0.min.z
	self.topLeft.x = var_3_0.min.x
	self.topLeft.y = var_3_0.max.y
	self.topLeft.z = var_3_0.max.z
	self.topRight.x = var_3_0.max.x
	self.topRight.y = var_3_0.max.y
	self.topRight.z = var_3_0.max.z
	self.center.x = var_3_0.center.x
	self.center.y = var_3_0.center.y
	self.center.z = var_3_0.center.z

	return
end

function RectOriginsCom:createDebugImg(arg_4_1, arg_4_2)
	self._collider.bounds:Expand(self.skinWidth * -2)

	self.bl = cloneTplTo(arg_4_1, arg_4_2, "bl")
	self.br = cloneTplTo(arg_4_1, arg_4_2, "br")
	self.tl = cloneTplTo(arg_4_1, arg_4_2, "tl")
	self.tr = cloneTplTo(arg_4_1, arg_4_2, "tr")
	self.bl.position = Vector3(self._collider.bounds.min.x, self._collider.bounds.min.y, self._collider.bounds.min.z)
	self.br.position = Vector3(self._collider.bounds.max.x, self._collider.bounds.min.y, self._collider.bounds.min.z)
	self.tl.position = Vector3(self._collider.bounds.min.x, self._collider.bounds.max.y, self._collider.bounds.max.z)
	self.tr.position = Vector3(self._collider.bounds.max.x, self._collider.bounds.max.y, self._collider.bounds.max.z)

	return
end

return RectOriginsCom
