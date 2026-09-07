local WSMapEffect = class("WSMapEffect", import(".WSMapTransform"))

WSMapEffect.Fields = {
	resPath = "string",
	resName = "string"
}

function WSMapEffect:Dispose()
	self:Unload()
	WSMapEffect.super.Dispose(self)

	return
end

function WSMapEffect:Setup(arg_2_1, arg_2_2)
	self.resPath = arg_2_1
	self.resName = arg_2_2

	return
end

function WSMapEffect:Load(arg_3_1)
	self:LoadModel(WorldConst.ModelPrefab, self.resPath, self.resName, true, function()
		setParent(self.model, self.transform, false)

		return existCall(arg_3_1)
	end)

	return
end

function WSMapEffect:Unload()
	self:UnloadModel()

	return
end

return WSMapEffect
