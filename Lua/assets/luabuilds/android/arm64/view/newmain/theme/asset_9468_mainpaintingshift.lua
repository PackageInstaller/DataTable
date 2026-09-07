local MainPaintingShift = class("MainPaintingShift")

function MainPaintingShift:Ctor(arg_1_1, arg_1_2)
	self.meshImageShift = Vector3(arg_1_1[1], arg_1_1[2], 0) + (arg_1_2 or Vector3.zero)
	self.l2dShift = Vector3(arg_1_1[3], arg_1_1[4], 0)
	self.spineShift = Vector3(arg_1_1[5], arg_1_1[6], 0)
	self.scale = Vector3(arg_1_1[7], arg_1_1[7], 1)
	self.l2dScale = Vector3(arg_1_1[8], arg_1_1[8], 1)
	self.spineScale = Vector3(arg_1_1[9], arg_1_1[9], 1)

	return
end

function MainPaintingShift:GetMeshImageShift()
	return self.meshImageShift, self.scale
end

function MainPaintingShift:GetL2dShift()
	return self.l2dShift, self.l2dScale
end

function MainPaintingShift:GetSpineShift()
	return self.spineShift, self.spineScale
end

function MainPaintingShift:IsLimitYPos()
	return self == "biaoqiang" or self == "z23" or self == "lafei" or self == "lingbo" or self == "mingshi" or self == "xuefeng"
end

function MainPaintingShift:GetHalfBodyOffsetY(arg_6_1)
	return self.rect.height * -0.5 + 325 * arg_6_1.localScale.y
end

return MainPaintingShift
