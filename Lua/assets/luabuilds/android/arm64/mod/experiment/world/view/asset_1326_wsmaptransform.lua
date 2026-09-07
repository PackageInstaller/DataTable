local WSMapTransform = class("WSMapTransform", import(".WSMapObject"))

WSMapTransform.Fields = {
	modelOrder = "number",
	isMoving = "boolean",
	transform = "userdata"
}

function WSMapTransform:Dispose()
	self:ClearModelOrder()
	self:Clear()

	return
end

function WSMapTransform:SetModelOrder(arg_2_1, arg_2_2)
	assert(self.transform)

	if not GetComponent(self.transform, typeof(Canvas)) then
		SetCanvasOverrideSorting(self.transform, true)
	end

	local var_2_0 = 0

	if self.modelOrder then
		var_2_0 = var_2_0 - self.modelOrder
	end

	self.modelOrder = arg_2_1 + defaultValue(arg_2_2, 0) * 10

	if var_2_0 + self.modelOrder ~= 0 then
		WorldConst.ArrayEffectOrder(self.transform, var_2_0 + self.modelOrder)
	end

	return
end

function WSMapTransform:ClearModelOrder()
	assert(self.transform)
	self:UnloadModel()

	if self.modelOrder then
		WorldConst.ArrayEffectOrder(self.transform, -self.modelOrder)

		self.modelOrder = nil
	end

	return
end

function WSMapTransform:LoadModel(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	WSMapTransform.super.LoadModel(self, arg_4_1, arg_4_2, arg_4_3, arg_4_4, function()
		if self.modelOrder then
			WorldConst.ArrayEffectOrder(self.model, self.modelOrder)
		end

		return existCall(arg_4_5)
	end)

	return
end

function WSMapTransform:UnloadModel()
	if self.modelOrder and self.model then
		WorldConst.ArrayEffectOrder(self.model, -self.modelOrder)
	end

	WSMapTransform.super.UnloadModel(self)

	return
end

return WSMapTransform
